import React, { useState, useEffect } from 'react';
import * as ReactDOM from 'react-dom';
import { HashRouter as Router, Link, Switch, Route, useParams } from 'react-router-dom';
// @ts-ignore
import party from '../../assets/images/party.jpg';

type Category = { id: number, name: string, color: string }
type Card = { id: number, title: string, category?: string }

const CardPresenter = ({ card, category }: { card: Card, category: Category }) => {
    return <div className="card">
        <div className="card-header" style={{
            backgroundColor: category.color
        }}>{category.name}</div>
        <div className="card-body">{card.title}</div>
    </div>
}

const CardListManager = () => {
    let { categoryId } = useParams();
    const [data, setData] = useState({
        category: null,
        cards: [],
        cardIndex: -1
    });
    let fetchData = async () => {
        const result = await fetch(`http://localhost:3000/api/v1/categories/${categoryId}`)
        let category = await result.json();
        let { cards } = category;
        let leaderCard: Card = { id: -1, title: category.description }
        cards = [leaderCard, ...cards]
        setData({ cards, cardIndex: 0, category });
    }
    useEffect(() => { fetchData(); }, []);
    let activeCard = data.cards[data.cardIndex]
    return activeCard
        ? <>
            <CardPresenter card={activeCard} category={data.category} />
            <button onClick={() => setData({ ...data, cardIndex: data.cardIndex + 1 })}>
                next
            </button>
        </>
        : <>
            <img src={party} />
            You did it!
        </>
}

const CategoryItem = ({ color, name }: { color: string, name: string }) => {
    return <li style={{ display: 'flex', flexDirection: 'row', padding: 30, alignContent: 'center' }}>
        <div
            className='category-color'
            style={{
                display: 'flex',
                backgroundColor: color,
                borderRadius: 20,
                width: 20, height: 20,
                marginRight: 12,
            }}
        >
        </div>
        <span className='category-name' style={{ fontFamily: 'Gothic A1', fontWeight: 800 }}>
            {name}
        </span>
    </li>

}

const CategoryList = () => {
    const [data, setData] = useState({ categories: [] })
    let getCategories = async () => {
        const result = await fetch('http://localhost:3000/api/v1/categories')
        let categories = await result.json();
        setData({ categories });
    }
    useEffect(() => { getCategories(); }, []);
    return <ul className="categories" style={{ listStyle: 'none', }}>
        {data.categories.map(category => (
            <Link key={category.name} to={`/categories/${category.id}`}>
                <CategoryItem name={category.name} color={category.color} />
            </Link>
        ))}
    </ul>
}

const AppRouter = () => {
    return (
        <Router>
            <Link to='/'><h1>r e f l e c t</h1></Link>
            <Switch>
                <Route path='/categories/:categoryId'>
                    <p>active card</p>
                    <CardListManager />
                </Route>
                <Route path='/'>
                    <p>category list</p>
                    <CategoryList />
                </Route>
            </Switch>
        </Router>
    );
}

document.addEventListener('DOMContentLoaded', () => {
    ReactDOM.render(
        <AppRouter />,
        document.body.appendChild(document.createElement('div')),
    )
});
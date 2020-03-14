// assets/js/Root.tsx

import * as React from 'react'
import { BrowserRouter, Route, Switch } from 'react-router-dom'

import Header from './components/Header'
import HomePage from './pages'
import Counter from './components/Counter'
import FetchDataPage from './pages/fetch-data'


export default class Root extends React.Component {
  public render(): JSX.Element {
    return (
      <>
        <Header />
        <BrowserRouter>
          <Switch>
            <Route exact path="/" component={HomePage} />
            <Route path="/counter" component={ Counter } />
            <Route path="/fetch-data" component={FetchDataPage} />'
          </Switch>
        </BrowserRouter>
      </>
    )
  }
}

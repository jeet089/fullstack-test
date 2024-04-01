import logo from './logo.svg';
import './App.css';
import InsiderTrade from './components/InsiderTrade';
function App() {
  return (
    <div className="App">
      <header className="Apps">
        <img src={logo} className="App-logo" alt="logo" />
         <InsiderTrade/>
      </header>
    </div>
  );
}

export default App;

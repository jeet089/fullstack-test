import React, { useState, useEffect } from 'react';
import axios from 'axios';
import 'react-dropdown/style.css';
import Combobox from "react-widgets/Combobox";
import "react-widgets/styles.css";

export const getCompaniesURL= "http://localhost:4000/api/companies";
export const getInsiderTradeURL = (selectedOption) => {
    return `http://localhost:4000/api/insider_trades?ticker=${selectedOption}`;
};

const InsiderTrade = () => {
    const [stocks, setStocks] = useState([]);
    const [selectedOption, setSelectedOption] = useState('');
    const [options, setOptions] = useState([]);

    useEffect(() => {
        fetchOptions();
    }, []);

    useEffect(() => {
        if (selectedOption) {
            fetchData();
        }
    }, [selectedOption]);

    const fetchOptions = async () => {
        try {
            const response = await axios.get(getCompaniesURL);
            const data = response.data.data.map(item => ({
                name: item.company_name,
                id: item.ticker
            }));

            setOptions(data);
            setSelectedOption("AMZN");
            
        } catch (error) {
            console.error('Error fetching data:', error);
        }
    };

    const fetchData = async () => {
        try {
            const response = await axios.get(getInsiderTradeURL(selectedOption));
            setStocks(response.data.data);
        } catch (error) {
            console.error('Error fetching data:', error);
        }
    };

    const handleOptionChange = (option) => {
        setSelectedOption(option.id);
    };
    return (
        <div className="container">
            <div className="dropdown-container">
        <Combobox
            dataKey='id'
            onSelect={handleOptionChange}
            textField='name'
            placeholder="Search a company"
            data={options}
            defaultValue={"AMZN"}
            />
            </div>
       
            <table className="table">
                <thead>
                    <tr>
                        <th style={{ width: '30%' }}>Insider</th>
                        <th>Relation</th>
                        <th>Transaction Date</th>
                        <th>Share Quantity</th>
                        <th>Market Cap</th>
                    </tr>
                </thead>
                <tbody>
                    {stocks.map((stock, index) => (
                        <tr key={index}>
                            <td>{stock.person_name}</td>
                            <td>{stock.job_title}</td>
                            <td>{stock.trade_date}</td>
                            <td>{stock.share_qty}</td>
                            <td>{stock.market_cap_percentage}</td>
                        </tr>
                    ))}
                </tbody>
            </table>
        </div>
    );
};

export default InsiderTrade;

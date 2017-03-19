import React from 'react';
import { Link } from 'react-router';
import { hashHistory } from 'react-router';
import GroupLeft from './group_left';
import GroupDetail from './group_detail';
import GroupBot from './group_bot';

class GroupShow extends React.Component {
  componentDidMount(){
    let {group} = this.props;
    if (!group) {
      this.props.fetchGroup();
    }
  }
  render() {
    // return (<p>TEST</p>);
    let content = (<section>Group was not found</section>);
    let {group} = this.props;
    if (group) {
      content = (
        <section className='groupshow'>
          <GroupLeft group={group} />
          <div className='fullwide'>
            <GroupDetail group={group} />
            <GroupBot group={group} />
          </div>
        </section>
      );
    }
    return content;
  }
}

export default GroupShow;

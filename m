Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D81691F1791
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jun 2020 13:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729656AbgFHLW6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Jun 2020 07:22:58 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:46400 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729640AbgFHLWu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Jun 2020 07:22:50 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 058BMRGD111939;
        Mon, 8 Jun 2020 11:22:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=g/SBqla2Qz8YmgXWV5dNE6NiesBkgSREBkriy+DQb8o=;
 b=T2VIpFyRZdRUANYlq3EtlHGqp8itK8+N7iO7owb3UkNmIQnmlkjUZjHNsC4JQ8Z5yCZD
 SGoJ1XLBMMT7lUSQyg5PNdF/yyMUhwIp6fzvzsVKWFnt8iihZ5XHGtYeGM69Vw9eW5t+
 Mgj0WcDHHJ0+k6k4aSg4gVNSpSwB9JphTvMU9Mn1Th4IfAK1DxC2w4DULZBiAH3Y/oBu
 izQAKPWW+xk6JzJtIepE5jnm6IkKsG+49UHcvd6EVyEz15hMyoewGo1ODtK4fne/Vq0e
 5o1aQ/XlxyDzNbdLzzIPhTR1TzAlHUxQxxNYAsLNv5VPbAM0cJ/FAJcezXRZJFYwyznQ pw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 31g3smp5y8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 08 Jun 2020 11:22:39 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 058BHmnK020506;
        Mon, 8 Jun 2020 11:22:38 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 31gmqm38yx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Jun 2020 11:22:38 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 058BMaa1010818;
        Mon, 8 Jun 2020 11:22:37 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 08 Jun 2020 04:22:36 -0700
Date:   Mon, 8 Jun 2020 14:22:28 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Joe Perches <joe@perches.com>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        rjw@rjwysocki.net, pavel@ucw.cz, len.brown@intel.com,
        Dan Carpenter <error27@gmail.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] kernel: power: swap: mark a function as __init to save
 some memory
Message-ID: <20200608112228.GW30374@kadam>
References: <20200531210059.647066-1-christophe.jaillet@wanadoo.fr>
 <effe3cde7b1f188427c42c476f5a96251d837416.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <effe3cde7b1f188427c42c476f5a96251d837416.camel@perches.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9645 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=936 adultscore=0 spamscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006080086
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9645 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 cotscore=-2147483648 suspectscore=0
 spamscore=0 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0
 mlxlogscore=963 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006080086
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, May 31, 2020 at 03:11:27PM -0700, Joe Perches wrote:
> (adding Dan Carpenter)
> 
> On Sun, 2020-05-31 at 23:00 +0200, Christophe JAILLET wrote:
> > 'swsusp_header_init()' is only called via 'core_initcall'.
> > It can be marked as __init to save a few bytes of memory.
> 
> Hey Dan
> 
> smatch has a full function calling tree right?
> 
> Can smatch find unmarked functions called only by __init
> functions so those unmarked functions can be appropriately
> marked with __init like the below?
> 

It turns out it's complicated to do this in Smatch because Sparse
ignores the section attribute.  :/

regards,
dan carpenter


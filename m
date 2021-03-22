Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 091D6344FBE
	for <lists+linux-pm@lfdr.de>; Mon, 22 Mar 2021 20:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbhCVTSt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Mar 2021 15:18:49 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:47372 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbhCVTSg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Mar 2021 15:18:36 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12MJEXWT113677;
        Mon, 22 Mar 2021 19:18:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=OdSzbbMJFi0/bQPEJHqVkQJu/ObFAXZ9MghiNNd7rRU=;
 b=B2o45gpMd9Lby74gvlyfB2SFSccswAI9BQymf7/6WbowURYKgCZeeWxEPfH6G7yioNuw
 22mYeWmVTbRShT2pBzKVcefGZlxztayR+COSYhgtcusxMYbIpoYzNazoOPGVL/88EMek
 BqSf+FMCPgt51UKUXu14j2g3eB9CDTlUow1t0C+gbbfC46go9OaJMr3wBbSzkuRd4Z4B
 5walAJa9lx2WPiaBbFd05Z/LUE9ymRbZ+mKoXQl24Fobwo3qqdx5MIHW4YLdPdU0ANPh
 iBL/NFVQkT1RbGHZWR+1IeEark2AmT31V9t0FpzY/k5gYBD5uaww6jxQDV/LmKlOsKVd Vw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 37d6jbcqc6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Mar 2021 19:18:30 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12MJEd99104042;
        Mon, 22 Mar 2021 19:18:28 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 37dtywfxpe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Mar 2021 19:18:28 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 12MJIQe0022457;
        Mon, 22 Mar 2021 19:18:27 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 22 Mar 2021 12:18:26 -0700
Date:   Mon, 22 Mar 2021 22:18:17 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Muhammad Usama Anjum <musamaanjum@gmail.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        colin.king@canonical.com
Subject: Re: [PATCH] thermal/core: avoid memory leak
Message-ID: <20210322191817.GG1717@kadam>
References: <20210322191204.GA2122573@LEGION>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210322191204.GA2122573@LEGION>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9931 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103220140
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9931 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1011 priorityscore=1501
 spamscore=0 adultscore=0 impostorscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103220140
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Mar 23, 2021 at 12:12:04AM +0500, Muhammad Usama Anjum wrote:
> When memory allocation for cdev is successful but ida_simple_get fails,
> branch to out_kfree_cdev label happens and cdev isn't freed. There are
> other some other branches in which the memory can leaked. Fix it by
> freeing cdev.
> 

The patch is correct, but Daniel already sent a fix for it.

regards,
dan carpenter


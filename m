Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 815A7285136
	for <lists+linux-pm@lfdr.de>; Tue,  6 Oct 2020 19:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgJFRww (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Oct 2020 13:52:52 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:48564 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbgJFRww (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Oct 2020 13:52:52 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 096HnOpC146506;
        Tue, 6 Oct 2020 17:52:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=LC/82944zGqf53+25kAz8BWVggLMv8anZyyopbS2QKE=;
 b=dVe4uPFLErvgS+R0I/nG7ewrZo/paaUDZWlJTF57UfGgEvqymRVGZUROR8ez1rqF+sRi
 +1cqwwfZ+HmCO4RFtqrCOGJCWezHgiRSyMSLIU/MdQb9LRdMms8SHuJQuSSJWBLMbFLt
 741z6mJLDpQyFt6VH0xt3lpV8HMYXEMBeTQxN8De/yrs7Rb9UW3seWI5NCa/IRJgBAAU
 Pv4REs9mp2wtICRtcHK+BIywS97pw/afyaqJFOrKcGZCP/cT38ykzAYOELX7pMBZyiKK
 xmcMzrZVRJNp6l3vqNypSyd2yggHDm7rqVbAarHp93tA8L4yt/QF0nnN9x21BWYmETtl uA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 33xhxmwduk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 06 Oct 2020 17:52:46 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 096HpGiB123117;
        Tue, 6 Oct 2020 17:52:46 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 33y2vnbucb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Oct 2020 17:52:45 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 096Hqj0Z020525;
        Tue, 6 Oct 2020 17:52:45 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 06 Oct 2020 10:52:44 -0700
Date:   Tue, 6 Oct 2020 20:52:38 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Sebastian Reichel <sre@kernel.org>, Dan Murphy <dmurphy@ti.com>,
        linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] power: supply: bq25980: remove redundant zero
 check on ret
Message-ID: <20201006175238.GG4282@kadam>
References: <20201006170600.545361-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201006170600.545361-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9765 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010060115
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9765 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 clxscore=1011 spamscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010060115
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 06, 2020 at 06:06:00PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently ret is assigned to zero and the following statement checks
> if it is non-zero. This check is redundant and can be removed
> 
> Addresses-Coverity: ("Logically dead code")
> Fixes: 5069185fc18e ("power: supply: bq25980: Add support for the BQ259xx family")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/power/supply/bq25980_charger.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/power/supply/bq25980_charger.c b/drivers/power/supply/bq25980_charger.c
> index 3995fb7cf060..f04f9acdb13b 100644
> --- a/drivers/power/supply/bq25980_charger.c
> +++ b/drivers/power/supply/bq25980_charger.c
> @@ -613,9 +613,6 @@ static int bq25980_set_battery_property(struct power_supply *psy,
>  	struct bq25980_device *bq = power_supply_get_drvdata(psy);
>  	int ret = 0;

I'm surprised this doesn't generate a set but not used warning.  And
then at the end of the function it could be changed from "return ret;"
to "return 0;"

regards,
dan carpenter


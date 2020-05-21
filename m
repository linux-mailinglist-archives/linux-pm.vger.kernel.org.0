Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11BB41DC9BC
	for <lists+linux-pm@lfdr.de>; Thu, 21 May 2020 11:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728999AbgEUJPg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 May 2020 05:15:36 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:58116 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728746AbgEUJPg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 May 2020 05:15:36 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04L9BnJU127976;
        Thu, 21 May 2020 09:15:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=bh+xl74w9Pkh3905HBogf0NGla+VU7nalNxpQKJpDgo=;
 b=a0EChYEYNnlwmOCKS9rkx0gOHg77FbolOr/EsqMpLpNqzEj6dp9cUgIAvocRavU8hKtM
 HE4kYMhm3vNYS98f217SdV1SDOoxIJVYpdszoh/yr6jJmwEvw9no7Zwy/TLjw9q58nea
 l3Ofrm3CeWWoHG8oKFLSyCF9rdfifmuKTAMoY3Izj6BCKs+c9DIBgmB4uZSz0jMAXbhs
 Vdj3K3b1SRl1FGwi1BJeN5iuMokY5B+MytX6jgG9AsF3bjOIyKm2x/yN7st9DhmT18Ez
 myajXBxweymmQP8+yoRVWWluBETYiA7zkLv30XZ/lL6T17Dhw4qq6fWUM/grRwFdUe5F Dg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 31284m7gfe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 21 May 2020 09:15:23 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04L9DERq169437;
        Thu, 21 May 2020 09:15:22 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 312t3aj105-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 May 2020 09:15:22 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04L9FE7h011073;
        Thu, 21 May 2020 09:15:15 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 21 May 2020 02:15:14 -0700
Date:   Thu, 21 May 2020 12:15:05 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     dinghao.liu@zju.edu.cn
Cc:     devel@driverdev.osuosl.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, kjlu@umn.edu,
        linux-kernel@vger.kernel.org,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, linux-tegra@vger.kernel.org,
        Dmitry Osipenko <digetx@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Subject: Re: Re: [PATCH] media: staging: tegra-vde: fix runtime pm imbalance
 on error
Message-ID: <20200521091505.GF30374@kadam>
References: <20200520095148.10995-1-dinghao.liu@zju.edu.cn>
 <2b5d64f5-825f-c081-5d03-02655c2d9491@gmail.com>
 <20200520150230.GC30374@kadam>
 <2a46539d.b977f.1723553aa81.Coremail.dinghao.liu@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a46539d.b977f.1723553aa81.Coremail.dinghao.liu@zju.edu.cn>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9627 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 malwarescore=0 suspectscore=29 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005210067
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9627 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=29 mlxscore=0
 cotscore=-2147483648 impostorscore=0 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 spamscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005210067
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, May 21, 2020 at 11:42:55AM +0800, dinghao.liu@zju.edu.cn wrote:
> Hi, Dan,
> 
> I agree the best solution is to fix __pm_runtime_resume(). But there are also 
> many cases that assume pm_runtime_get_sync() will change PM usage 
> counter on error. According to my static analysis results, the number of these 
> "right" cases are larger. Adjusting __pm_runtime_resume() directly will introduce 
> more new bugs. Therefore I think we should resolve the "bug" cases individually.
> 

That's why I was saying that we may need to introduce a new replacement
function for pm_runtime_get_sync() that works as expected.

There is no reason why we have to live with the old behavior.

regards,
dan carpenter


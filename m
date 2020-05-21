Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EFB01DCC96
	for <lists+linux-pm@lfdr.de>; Thu, 21 May 2020 14:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729114AbgEUMGL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 May 2020 08:06:11 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:48352 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727905AbgEUMGL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 May 2020 08:06:11 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04LC3kQ4031241;
        Thu, 21 May 2020 12:06:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=/dSwQBMQ9edVQjkiT3Bt0WIXXVOZp3v9OdMj2sZjdRM=;
 b=e4L267jwZlTFvTG9JpcIULqEeEQocx0mw6IjjEz8r1uelXohYCcNYQWm63MmNdFiJFMC
 YifX1o3XyvBF6x/rZGDZ1mNd9Y1laKRbFpuSPYp1EzuE/I9zJY1WGqS9TXAK4MfHwu+Y
 0gwJ13GqRKQEYr5LTnoW4lijkInJxlkDlN/zCILV0qkW95J8mSbAFLWIIohhAEiib35A
 Y/bMYNVm4Xa9beWQRWNjcqLR8ClhlV50qsVlmYjOXJePHIFHQEXRT5LiKmECMpc0vjBp
 5li9q5LQEEvdqCcWoouQxJbifnkjTbx7ZT7gt9sO7vG9RX0dbxqdA90NKV04CK6UYKiV FA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 31501ren20-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 21 May 2020 12:06:00 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04LC3D2E106767;
        Thu, 21 May 2020 12:03:59 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 312t3ay20b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 May 2020 12:03:59 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04LC3rgH020890;
        Thu, 21 May 2020 12:03:53 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 21 May 2020 05:03:53 -0700
Date:   Thu, 21 May 2020 15:03:45 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     dinghao.liu@zju.edu.cn
Cc:     devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kjlu@umn.edu,
        linux-kernel@vger.kernel.org,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-tegra@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: Re: Re: [PATCH] [v2] media: staging: tegra-vde: fix runtime pm
 imbalance on error
Message-ID: <20200521120344.GH30374@kadam>
References: <20200521062746.6656-1-dinghao.liu@zju.edu.cn>
 <20200521112131.GG30374@kadam>
 <4b400526.bbc83.172370b23a0.Coremail.dinghao.liu@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b400526.bbc83.172370b23a0.Coremail.dinghao.liu@zju.edu.cn>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9627 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 malwarescore=0 suspectscore=2 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005210091
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9627 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 spamscore=0
 mlxlogscore=999 clxscore=1015 priorityscore=1501 cotscore=-2147483648
 impostorscore=0 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0
 mlxscore=0 suspectscore=2 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005210091
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, May 21, 2020 at 07:42:56PM +0800, dinghao.liu@zju.edu.cn wrote:
> We need to make sure if pm_runtime_get_sync() is designed with
> such behavior before modifying it.  
> 
> I received a response from Rafael when I commited a similar patch:
> https://lkml.org/lkml/2020/5/20/1100
> It seems that this behavior is intentional and needs to be kept.

Yes.  This is why I have said twice or three times to not change
pm_runtime_get_sync() but instead to write a replacement.

A large percent of the callers are buggy.  The pm_runtime_get_sync() is
a -4 on Rusty's API scale.
http://sweng.the-davies.net/Home/rustys-api-design-manifesto
One could argue that anything above a -4 is really a 2 if you read
the implementation thouroughly enough...

regards,
dan carpenter



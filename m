Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C82C1122EF
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2019 07:33:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725958AbfLDGdH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Dec 2019 01:33:07 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:34514 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbfLDGdH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Dec 2019 01:33:07 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB46T2FY063294;
        Wed, 4 Dec 2019 06:32:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=dACA43soU8GDdHUjwYqjBqF/VhZ6M/HfzgDTJlJS8Ec=;
 b=p4jlz6cvyDmosH57R5bGv6rUx7bjuoaVmfO1bRDUceDvu3sPiCvQ1kpjurrIO07A5oQ5
 YJYTiAjEOCsom78MMk1/yKNn+TUhXoDXGTdmfFQNDCIgzxgTCKG4ryKx3fltnRnZbnIa
 RHlNjL5VJOaTDLcOTSt1waLtCNizZzPimPJEKRuHmdxWvxyjKB+Yx/bX6p/zUBZqVSU3
 409OPNRZqg7b70JZK28TtrpCJJ2YeRwKXRAvzJuY6lf4318TZLNiNimQyEszd8rDqNYU
 xAdd6ZzJoI27lRIRsDmateuI7L3VPGEvF/k2AX7cEeHAicUyQdsQnkNFvU8nv3YaOOz9 rQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2wkgcqcbdx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Dec 2019 06:32:54 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB46TCsI062755;
        Wed, 4 Dec 2019 06:32:53 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2wp17csr5d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Dec 2019 06:32:53 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xB46WqUg013991;
        Wed, 4 Dec 2019 06:32:52 GMT
Received: from kadam (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 03 Dec 2019 22:32:51 -0800
Date:   Wed, 4 Dec 2019 09:32:40 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Mao Wenan <maowenan@huawei.com>
Cc:     sre@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH -next] power: supply: ab8500: Drop pointless static
 qualifier in ab8500_btemp_batctrl_volt_to_res()
Message-ID: <20191204063240.GJ1787@kadam>
References: <20191204010506.159128-1-maowenan@huawei.com>
 <20191204063058.GE1765@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191204063058.GE1765@kadam>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9460 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912040046
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9460 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912040046
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Dec 04, 2019 at 09:30:58AM +0300, Dan Carpenter wrote:
> On Wed, Dec 04, 2019 at 09:05:06AM +0800, Mao Wenan wrote:
> > There is no need to have the 'T *v' variable static
> > since new value always be assigned before use it.
> > 
> > Reported-by: Hulk Robot <hulkci@huawei.com>
> > Signed-off-by: Mao Wenan <maowenan@huawei.com>
> > ---
> >  drivers/power/supply/ab8500_btemp.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/power/supply/ab8500_btemp.c b/drivers/power/supply/ab8500_btemp.c
> > index 909f0242bacb..d3d4f7327d1b 100644
> > --- a/drivers/power/supply/ab8500_btemp.c
> > +++ b/drivers/power/supply/ab8500_btemp.c
> > @@ -180,7 +180,7 @@ static int ab8500_btemp_batctrl_volt_to_res(struct ab8500_btemp *di,
> >  static int ab8500_btemp_read_batctrl_voltage(struct ab8500_btemp *di)
> >  {
> >  	int vbtemp, ret;
> > -	static int prev;
> > +	int prev;
> 
> No.  We use it first on linux-next (yesterday).  It needs to be static.
> 

It's surprising that your patch didn't cause an uninitialized variable
compile warning for you.

regards,
dan carpenter


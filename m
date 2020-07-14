Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CEDF21ED0C
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jul 2020 11:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbgGNJiT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jul 2020 05:38:19 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:40746 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgGNJiR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jul 2020 05:38:17 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06E9atMJ178432;
        Tue, 14 Jul 2020 09:38:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=8wmA0uYOG9OxOF3CVL1wtgfgJV7miu8gCUETPuUCOak=;
 b=IZUTBNLQqKhzm4shvwTB7u1+rTmOLyk/gmUqwbLTNAqavKFNcomDoGPdkubnvn0Yqic0
 XnexXXwiIZ1JRVCymW0ENjFUCDpDKaut9/034sdVyCYKyqGrdwEw7xEf7AZlNUHlUeyw
 GSRcLXRexL4mNOu1eNJLuWo+w6LBrsfqIvEx0Uwz58mD83OyzjLizgNmcVcOnl0YPkq0
 RUT8QCoVdmhTtO95WEFT8uvOtx2+0iIFAcaHNxZV4BQ+d8SQpwvht5v3IobzjW7AbYDi
 JPbHVPr0gXKAvRndl/q0KuEqF5xwoC2hDTkEWF/05TkZUdbNbm+z1otJoL+5Ix2pP7LK aw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 3275cm4bjk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 14 Jul 2020 09:38:08 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06E9XaXF169890;
        Tue, 14 Jul 2020 09:38:07 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 327q6rxbkv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jul 2020 09:38:07 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06E9c6rT009307;
        Tue, 14 Jul 2020 09:38:06 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 14 Jul 2020 02:38:05 -0700
Date:   Tue, 14 Jul 2020 12:37:58 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>, linux-pm@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH -next] PM / devfreq: Fix missing unlock on error in
 devfreq_add_device()
Message-ID: <20200714093758.GW2549@kadam>
References: <20200714063025.118829-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714063025.118829-1-weiyongjun1@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9681 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=2
 phishscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007140072
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9681 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 priorityscore=1501
 bulkscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=999 clxscore=1011 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007140072
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 14, 2020 at 06:30:25AM +0000, Wei Yongjun wrote:
> Add the missing unlock before return from function devfreq_add_device()
> in the error handling case.
> 
> Fixes: d7c46505a7ad ("PM / devfreq: Add support delayed timer for polling mode")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/devfreq/devfreq.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 5320c3b37f35..2b54a59bb281 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -788,6 +788,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  
>  	if (devfreq->profile->timer < 0
>  		|| devfreq->profile->timer >= DEVFREQ_TIMER_NUM) {
> +		mutex_unlock(&devfreq->lock);
>  		goto err_out;

This should be "goto err_dev;" and the unlock is not required because
we free "devfreq".

regards,
dan carpenter
>  	}
> 
> 

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC65F21EE86
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jul 2020 12:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726041AbgGNK7r (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jul 2020 06:59:47 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:47952 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727043AbgGNK7r (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jul 2020 06:59:47 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06EAw4hA041130;
        Tue, 14 Jul 2020 10:59:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=FVZzYXiUXmNYZ2rp7CjKtJQ3hhXEWdRzRUoSe6Wbctg=;
 b=EFM7kEbYM0sjw6aLLBovqJFmAwYcL7/G6ByJwO7JFdfQy5WZmg7kfsnrsijFmq7zqq2k
 q0sRDC4fekv7O8j9eBzhbSSJS6FvYJJd+j/HwawZADvVoVFY/8RONF+7QboHdmcJmqqR
 bi8Xto/rHfZDCjOHhDg8u/4uzsTVyWxrIu8G2xsPuW0K0doUHH33KmEu0dlu+zXz51GZ
 mFinJhbNHCbHWBgGltuZpGAuv2R0vxKkyUsVg/nA4/s1Sc1uMdPuUqqTr6UmeA5Ec7bU
 Q+LvLFNGmnAfgr+H3FkyrrlerJBGNPmBtXvNPIrazHoSlsPfwp5CLYM5E+WCedKcS9iT Dg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 3274ur4qg3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 14 Jul 2020 10:59:37 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06EAxbLM088296;
        Tue, 14 Jul 2020 10:59:37 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 327q6s29p1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jul 2020 10:59:37 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06EAxPic017937;
        Tue, 14 Jul 2020 10:59:25 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 14 Jul 2020 03:59:25 -0700
Date:   Tue, 14 Jul 2020 13:59:18 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>, linux-pm@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH -next] PM / devfreq: Fix missing unlock on error in
 devfreq_add_device()
Message-ID: <20200714105918.GB2571@kadam>
References: <20200714063025.118829-1-weiyongjun1@huawei.com>
 <20200714093758.GW2549@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714093758.GW2549@kadam>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9681 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=2
 phishscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007140084
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9681 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 impostorscore=0
 suspectscore=2 phishscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007140084
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 14, 2020 at 12:37:58PM +0300, Dan Carpenter wrote:
> On Tue, Jul 14, 2020 at 06:30:25AM +0000, Wei Yongjun wrote:
> > Add the missing unlock before return from function devfreq_add_device()
> > in the error handling case.
> > 
> > Fixes: d7c46505a7ad ("PM / devfreq: Add support delayed timer for polling mode")
> > Reported-by: Hulk Robot <hulkci@huawei.com>
> > Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> > ---
> >  drivers/devfreq/devfreq.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> > index 5320c3b37f35..2b54a59bb281 100644
> > --- a/drivers/devfreq/devfreq.c
> > +++ b/drivers/devfreq/devfreq.c
> > @@ -788,6 +788,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
> >  
> >  	if (devfreq->profile->timer < 0
> >  		|| devfreq->profile->timer >= DEVFREQ_TIMER_NUM) {
> > +		mutex_unlock(&devfreq->lock);
> >  		goto err_out;
> 
> This should be "goto err_dev;" and the unlock is not required because
> we free "devfreq".

Also the error code needs to be set on this error path.

regards,
dan carpenter


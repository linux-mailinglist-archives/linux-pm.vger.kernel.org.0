Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 714A51DD49A
	for <lists+linux-pm@lfdr.de>; Thu, 21 May 2020 19:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbgEURle (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 May 2020 13:41:34 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:42724 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbgEURle (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 May 2020 13:41:34 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04LHbUjp196368;
        Thu, 21 May 2020 17:41:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=gA43wCjQqcJxoz3k/kU6IZwsYpzQYq2m+PwRQ/B3VuI=;
 b=KXrFiR/REHrzSvFv/SIXpsQFfN3guFg4aqUUlyaEwJhRMZIaeY41DOT6xi2xWZn1VgLH
 DOUvuKNnw+mcyEfDfOLg8Bf+knoOCwah2Mh47Q/mAmskorEFJ6kS+2vysisdbD5TNWUW
 MA0+YBpTVhUSTet98TijOcTX9S7qH7oj5XKjgFl3KDmcZIowc+7RNabKIIzXbDZR3H6T
 JpVH3whqOTuGKzGCFLlrzwMfjuUq/q6oYMtVVPN9R1Iy8lEDIQ1K+iuBacIXG799P1ic
 gKds2Z/KQwLMd4ajPFxq1AvbrJ0WExNDzVKZ6DR6MxrqVsPUi3MvXt7b8+SrCGrxcain WA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 31501rgby4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 21 May 2020 17:41:19 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04LHdFtJ105995;
        Thu, 21 May 2020 17:39:18 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 315022uevc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 May 2020 17:39:18 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04LHdBli014341;
        Thu, 21 May 2020 17:39:11 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 21 May 2020 10:39:10 -0700
Date:   Thu, 21 May 2020 20:39:02 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     dinghao.liu@zju.edu.cn, devel@driverdev.osuosl.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>, Kangjie Lu <kjlu@umn.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Subject: Re: Re: [PATCH] media: staging: tegra-vde: fix runtime pm imbalance
 on error
Message-ID: <20200521173901.GA22310@kadam>
References: <20200520095148.10995-1-dinghao.liu@zju.edu.cn>
 <2b5d64f5-825f-c081-5d03-02655c2d9491@gmail.com>
 <20200520150230.GC30374@kadam>
 <2a46539d.b977f.1723553aa81.Coremail.dinghao.liu@zju.edu.cn>
 <20200521091505.GF30374@kadam>
 <CAJZ5v0irLayBUPRWNT1tcZivz9inS1YbUgGj5WXvucLKKwRQAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0irLayBUPRWNT1tcZivz9inS1YbUgGj5WXvucLKKwRQAw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9628 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 suspectscore=18 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005210127
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9628 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 spamscore=0
 mlxlogscore=999 clxscore=1011 priorityscore=1501 cotscore=-2147483648
 impostorscore=0 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0
 mlxscore=0 suspectscore=18 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005210127
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, May 21, 2020 at 05:22:05PM +0200, Rafael J. Wysocki wrote:
> On Thu, May 21, 2020 at 11:15 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> >
> > On Thu, May 21, 2020 at 11:42:55AM +0800, dinghao.liu@zju.edu.cn wrote:
> > > Hi, Dan,
> > >
> > > I agree the best solution is to fix __pm_runtime_resume(). But there are also
> > > many cases that assume pm_runtime_get_sync() will change PM usage
> > > counter on error. According to my static analysis results, the number of these
> > > "right" cases are larger. Adjusting __pm_runtime_resume() directly will introduce
> > > more new bugs. Therefore I think we should resolve the "bug" cases individually.
> > >
> >
> > That's why I was saying that we may need to introduce a new replacement
> > function for pm_runtime_get_sync() that works as expected.
> >
> > There is no reason why we have to live with the old behavior.
> 
> What exactly do you mean by "the old behavior"?

I'm suggesting we leave pm_runtime_get_sync() alone but we add a new
function which called pm_runtime_get_sync_resume() which does something
like this:

static inline int pm_runtime_get_sync_resume(struct device *dev)
{
	int ret;

	ret = __pm_runtime_resume(dev, RPM_GET_PUT);
	if (ret < 0) {
		pm_runtime_put(dev);
		return ret;
	}
	return 0;
}

I'm not sure if pm_runtime_put() is the correct thing to do?  The other
thing is that this always returns zero on success.  I don't know that
drivers ever care to differentiate between one and zero returns.

Then if any of the caller expect that behavior we update them to use the
new function.

regards,
dan carpenter


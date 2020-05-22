Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E04211DE7F3
	for <lists+linux-pm@lfdr.de>; Fri, 22 May 2020 15:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729406AbgEVNXv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 May 2020 09:23:51 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:48006 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729399AbgEVNXv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 May 2020 09:23:51 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04MDMLnF129997;
        Fri, 22 May 2020 13:23:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=gZnfBrzAvRzx8jUFLTXQ8QllxngxYzmzC5MjjDonJe8=;
 b=tX0SIp0bVzqD3O0hqKK1fsbNI5KXLBSbmIK3CQsCMzIj7t04LDO17Trpko/fAzkFZ11r
 kEWAvq/E8fQkiW7vuXl+RbTkRpMJXyauafF0xW6AUTp0kG8uV1rg40/BvUsHc9InYWpD
 BLkbCPMrXketqBlyfRMexfCSVdVkeBpBxuzVNiQ5Ero86RtvT4mOyx+jwW9+28JrrFfA
 IfyOd0YDmTeFlJBR7uZY5kancMr02DMQyx//VZatXlSLvrEPVlQEa8mC3laP/zGIdFMx
 Pz9rIQLJQRhgRyGC8XbqWTlhvcXUb3F6wbOya9sMZ1kWJm7fYr9fvEtwiJ5Pe9xYN+dw Zw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 31284mdq3s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 22 May 2020 13:23:38 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04MDIaNo006519;
        Fri, 22 May 2020 13:23:37 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 314gmb52d4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 May 2020 13:23:37 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04MDNS3x025160;
        Fri, 22 May 2020 13:23:28 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 22 May 2020 06:23:27 -0700
Date:   Fri, 22 May 2020 16:23:18 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     devel@driverdev.osuosl.org, Len Brown <len.brown@intel.com>,
        Pavel Machek <pavel@ucw.cz>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        dinghao.liu@zju.edu.cn, Kangjie Lu <kjlu@umn.edu>,
        Dmitry Osipenko <digetx@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Subject: Re: Re: [PATCH] media: staging: tegra-vde: fix runtime pm imbalance
 on error
Message-ID: <20200522132318.GM30374@kadam>
References: <20200520095148.10995-1-dinghao.liu@zju.edu.cn>
 <2b5d64f5-825f-c081-5d03-02655c2d9491@gmail.com>
 <20200520150230.GC30374@kadam>
 <2a46539d.b977f.1723553aa81.Coremail.dinghao.liu@zju.edu.cn>
 <20200521091505.GF30374@kadam>
 <CAJZ5v0irLayBUPRWNT1tcZivz9inS1YbUgGj5WXvucLKKwRQAw@mail.gmail.com>
 <20200521173901.GA22310@kadam>
 <20200522131031.GL2163848@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522131031.GL2163848@ulmo>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9628 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 phishscore=0 mlxscore=0 spamscore=0 suspectscore=21
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005220109
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9628 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=21 mlxscore=0
 cotscore=-2147483648 impostorscore=0 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 spamscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005220109
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, May 22, 2020 at 03:10:31PM +0200, Thierry Reding wrote:
> On Thu, May 21, 2020 at 08:39:02PM +0300, Dan Carpenter wrote:
> > On Thu, May 21, 2020 at 05:22:05PM +0200, Rafael J. Wysocki wrote:
> > > On Thu, May 21, 2020 at 11:15 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > > >
> > > > On Thu, May 21, 2020 at 11:42:55AM +0800, dinghao.liu@zju.edu.cn wrote:
> > > > > Hi, Dan,
> > > > >
> > > > > I agree the best solution is to fix __pm_runtime_resume(). But there are also
> > > > > many cases that assume pm_runtime_get_sync() will change PM usage
> > > > > counter on error. According to my static analysis results, the number of these
> > > > > "right" cases are larger. Adjusting __pm_runtime_resume() directly will introduce
> > > > > more new bugs. Therefore I think we should resolve the "bug" cases individually.
> > > > >
> > > >
> > > > That's why I was saying that we may need to introduce a new replacement
> > > > function for pm_runtime_get_sync() that works as expected.
> > > >
> > > > There is no reason why we have to live with the old behavior.
> > > 
> > > What exactly do you mean by "the old behavior"?
> > 
> > I'm suggesting we leave pm_runtime_get_sync() alone but we add a new
> > function which called pm_runtime_get_sync_resume() which does something
> > like this:
> > 
> > static inline int pm_runtime_get_sync_resume(struct device *dev)
> > {
> > 	int ret;
> > 
> > 	ret = __pm_runtime_resume(dev, RPM_GET_PUT);
> > 	if (ret < 0) {
> > 		pm_runtime_put(dev);
> > 		return ret;
> > 	}
> > 	return 0;
> > }
> > 
> > I'm not sure if pm_runtime_put() is the correct thing to do?  The other
> > thing is that this always returns zero on success.  I don't know that
> > drivers ever care to differentiate between one and zero returns.
> > 
> > Then if any of the caller expect that behavior we update them to use the
> > new function.
> 
> Does that really have many benefits, though? I understand that this
> would perhaps be easier to use because it is more in line with how other
> functions operate. On the other hand, in some cases you may want to call
> a different version of pm_runtime_put() on failure, as discussed in
> other threads.

I wasn't CC'd on the other threads so I don't know.  :/  I have always
assumed it was something like this but I don't know the details and
there is no documentation.

http://sweng.the-davies.net/Home/rustys-api-design-manifesto
You're essentially arguing that it's a #1 on Rusty's scale but ideally
we would want to be at #7.

> 
> Even ignoring that issue, any existing callsites that are leaking the
> reference would have to be updated to call the new function, which would
> be pretty much the same amount of work as updating the callsites to fix
> the leak, right?

With the current API we're constantly adding bugs.  I imagine that once
we add a straight forward default and some documentation then we will
solve this.

> 
> So if instead we just fix up the leaks, we might have a case of an API
> that doesn't work as some of us (myself included) expected it, but at
> least it would be consistent. If we add another variant things become
> fragmented and therefore even more complicated to use and review.

That's the approach that we've been trying and it's clearly not working.

regards,
dan carpenter


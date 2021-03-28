Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A15F934BD90
	for <lists+linux-pm@lfdr.de>; Sun, 28 Mar 2021 19:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbhC1R13 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 28 Mar 2021 13:27:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:59808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229593AbhC1R1C (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 28 Mar 2021 13:27:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 24F2061929;
        Sun, 28 Mar 2021 17:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616952421;
        bh=QEqM6tDytb7lgcGKZ/gDMwwXoV4ceL76Hk1LDKF5R10=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X09agavam2BFbqZUMespZZ9ze22dgaYgo0o6sWeiXWKRfqKT4bLc/jJBN9CRqcZPx
         i604BLoSul71colDwMG9cpwLCjVa0fNPRYFyuTGea/G7AwpRly7isjoYNNE8CVCFyC
         T+pXl2b/mKXEWEAFFfzDd5GOnFqULQaHNXsY6SfI=
Date:   Sun, 28 Mar 2021 19:26:58 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, lukasz.luba@arm.com
Subject: Re: [PATCH v4 2/5] powercap/drivers/dtpm: Create a registering system
Message-ID: <YGC8Yj9OTgc4aU0y@kroah.com>
References: <20210312130411.29833-1-daniel.lezcano@linaro.org>
 <20210312130411.29833-2-daniel.lezcano@linaro.org>
 <YF8qIw4UBLnj9TCA@kroah.com>
 <433ec4ac-a7a9-ecf9-f1c1-f658d279a2df@linaro.org>
 <YGAnRx8SiZHFPpY6@kroah.com>
 <7df276d1-abea-622c-2c7e-2c5e412aa4a9@linaro.org>
 <YGBng8D+nPS4/LJO@kroah.com>
 <7ba5094b-7fac-72ff-0e52-6f60eb86f253@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ba5094b-7fac-72ff-0e52-6f60eb86f253@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Mar 28, 2021 at 06:07:10PM +0200, Daniel Lezcano wrote:
> On 28/03/2021 13:24, Greg KH wrote:
> > On Sun, Mar 28, 2021 at 01:11:30PM +0200, Daniel Lezcano wrote:
> >>
> >> Hi Greg,
> >>
> >> On 28/03/2021 08:50, Greg KH wrote:
> >>
> >> [ ... ]
> >>
> >>>>> And any reason why you are not using "real" struct devices in this
> >>>>> subsystem?  You seem to be rolling your own infrastructure for no good
> >>>>> reason.  I imagine you want sysfs support next, right?
> >>>>
> >>>> Actually, the framework is on top of powercap, so it has de facto the
> >>>> sysfs support. On the other side, the dtpm backends are tied with the
> >>>> device they manage.
> >>>
> >>> So why are they not a "real" device in the driver model?  It looks like
> >>> you almost are wanting all of that functionality and are having to
> >>> implement it "by hand" instead.
> >>
> >> I'm sorry I misunderstanding your point. dtpm is the backend for the
> >> powercap subsystem which is the generic subsystem to do power limitation.
> >>
> >> We have:
> >>
> >> struct dtpm_cpu {
> >> 	struct dtpm dtmp;
> >> 	...
> >> }
> >>
> >> struct dtpm {
> >> 	struct powercap powecap;
> >> };
> >>
> >> struct powercap {
> >> 	struct device dev;
> >> };
> > 
> > Oh nice.  So you can not use a kref here at all as you already have a
> > reference counted device controling your structure.  You can not have 2
> > references trying to control the same structure, that way lies madness
> > and bugs :(
> > 
> > So why are you trying to add a kref here as the structure already has
> > support for proper lifetimes?
> 
> Right, I'll revisit that part. Thanks for the review.
> 
> I've a branch which is pulled by Rafael [1]. These parts are already
> merged in the dtpm/next branch but not yet in Rafael's tree.

I would recommend fixing that up if you can rebase it.  If not, you need
to revert it and start over.  I'll be glad to review it if you cc: me on
the patches.

> I think a rebase is possible but I would like to avoid that. Would be a
> patch on top of the dtpm/next acceptable given your flow with Android ?

This has nothing to do with the Android kernel workflow, sorry.  I am
concerned about proper kernel development and keeping bugs out of it.

thanks,

greg k-h

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72B7E34BC26
	for <lists+linux-pm@lfdr.de>; Sun, 28 Mar 2021 13:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbhC1LYy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 28 Mar 2021 07:24:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:40128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229503AbhC1LYy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 28 Mar 2021 07:24:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 967466193C;
        Sun, 28 Mar 2021 11:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616930694;
        bh=uae/A7CFNb/iy2jpCjvjBsmPJqVGmDYovI6k28i3Lv0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NLhsg3WsT565y6wgkqcCMOjevyGfZG2bAio+8IUy5pgLTCDoCKQgb0NUvy4JTsku2
         d972evjUf0YZh8dFIjHxY8czQ/VkN5hPTkxt3Q3eheVA62mQw3ljS6cPv2ruUb2UuX
         W0oJ3ok2UNoYcoetOYSyUU4xp/87xGatGYUh0w/k=
Date:   Sun, 28 Mar 2021 13:24:51 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, lukasz.luba@arm.com
Subject: Re: [PATCH v4 2/5] powercap/drivers/dtpm: Create a registering system
Message-ID: <YGBng8D+nPS4/LJO@kroah.com>
References: <20210312130411.29833-1-daniel.lezcano@linaro.org>
 <20210312130411.29833-2-daniel.lezcano@linaro.org>
 <YF8qIw4UBLnj9TCA@kroah.com>
 <433ec4ac-a7a9-ecf9-f1c1-f658d279a2df@linaro.org>
 <YGAnRx8SiZHFPpY6@kroah.com>
 <7df276d1-abea-622c-2c7e-2c5e412aa4a9@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7df276d1-abea-622c-2c7e-2c5e412aa4a9@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Mar 28, 2021 at 01:11:30PM +0200, Daniel Lezcano wrote:
> 
> Hi Greg,
> 
> On 28/03/2021 08:50, Greg KH wrote:
> 
> [ ... ]
> 
> >>> And any reason why you are not using "real" struct devices in this
> >>> subsystem?  You seem to be rolling your own infrastructure for no good
> >>> reason.  I imagine you want sysfs support next, right?
> >>
> >> Actually, the framework is on top of powercap, so it has de facto the
> >> sysfs support. On the other side, the dtpm backends are tied with the
> >> device they manage.
> > 
> > So why are they not a "real" device in the driver model?  It looks like
> > you almost are wanting all of that functionality and are having to
> > implement it "by hand" instead.
> 
> I'm sorry I misunderstanding your point. dtpm is the backend for the
> powercap subsystem which is the generic subsystem to do power limitation.
> 
> We have:
> 
> struct dtpm_cpu {
> 	struct dtpm dtmp;
> 	...
> }
> 
> struct dtpm {
> 	struct powercap powecap;
> };
> 
> struct powercap {
> 	struct device dev;
> };

Oh nice.  So you can not use a kref here at all as you already have a
reference counted device controling your structure.  You can not have 2
references trying to control the same structure, that way lies madness
and bugs :(

So why are you trying to add a kref here as the structure already has
support for proper lifetimes?

thanks,

greg k-h

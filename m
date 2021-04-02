Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 181A835272F
	for <lists+linux-pm@lfdr.de>; Fri,  2 Apr 2021 10:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234265AbhDBICV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 2 Apr 2021 04:02:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:35190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234139AbhDBICT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 2 Apr 2021 04:02:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 351826100A;
        Fri,  2 Apr 2021 08:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617350538;
        bh=y9zmwC39301s/j2wc1CnDJrrb22WDqRqa+zGLorL9uY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W5Bep2EaKXKBr8kXYw7cBBzTS8C1gbBx7f48rGyRyoVX+2zB8bQoWt5oTPz3lon6A
         hiegsEUbDHXzp8EmDUsn/po/eAavEAvTR5JsH+uKNGMTkzNOcbKie4dlThrRW29tR4
         47YRmiUXkurwhJz3/QhTB4Q1xYSngw8luGyks8iU=
Date:   Fri, 2 Apr 2021 10:02:15 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        lukasz.luba@arm.com, rafael@kernel.org,
        Ram Chandrasekar <rkumbako@codeaurora.org>
Subject: Re: [PATCH v6 2/7] powercap/drivers/dtpm: Create a registering system
Message-ID: <YGbPh/QrFsgyJC6B@kroah.com>
References: <20210401183654.27214-1-daniel.lezcano@linaro.org>
 <20210401183654.27214-2-daniel.lezcano@linaro.org>
 <YGYe9p3oyNpMnsBT@kroah.com>
 <d0f818c7-3262-268b-bcc2-8036ce559d7b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0f818c7-3262-268b-bcc2-8036ce559d7b@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Apr 02, 2021 at 12:08:49AM +0200, Daniel Lezcano wrote:
> 
> Hi Greg,
> 
> On 01/04/2021 21:28, Greg KH wrote:
> > On Thu, Apr 01, 2021 at 08:36:49PM +0200, Daniel Lezcano wrote:
> >> A SoC can be differently structured depending on the platform and the
> >> kernel can not be aware of all the combinations, as well as the
> >> specific tweaks for a particular board.
> >>
> >> The creation of the hierarchy must be delegated to userspace.
> > 
> > Why?  Isn't this what DT is for?
> 
> I've always been told the DT describes the hardware. Here we are more
> describing a configuration, that is the reason why I've let the
> userspace to handle that through configfs.

DT does describe how the hardware configuration is to be used.  You are
saying that the hardware description does not work and somehow you need
a magic userspace tool to reconfigure things instead?

> > What "userspace tool" is going to be created to manage all of this?
> > Pointers to that codebase?
> 
> You are certainly aware of most of it but let me give a bit more of context.

No, I am not aware of it at all, thanks :)

> The thermal framework has cooling devices which export their 'state', a
> representation of their performance level, in sysfs. Unfortunately that
> gives access from the user space to act on the performance as a power
> limiter in total conflict with the in-kernel thermal governor decisions.

Why not remove that conflict?

> That is done from thermal daemon the different SoC vendors tweak for
> their platform. Depending on the application running and identified as a
> scenario, the daemon acts proactively on the different cooling devices
> to ensure a skin temperature which is far below the thermal limit of the
> components.

So userspace is going to try to manage power settings in order to keep
thermal values under control?  Has no one learned from our past mistakes
when we used to have to do this 10 years ago and it turned out so bad
that it was just baked into the hardware instead?

{sigh}

> This usage of the cooling devices hijacked the real purpose of the
> thermal framework which is to protect the silicon. Nobody to blame,
> there is no alternative for userspace.

Userspace should not care.

> The use case falls under the power limitation framework prerogative and
> that is the reason why we provided a new framework to limit the power
> based on the powercap framework. The thermal daemon can then use it and
> stop abusing the thermal framework.
> 
> This DTPM framework allows to read the power consumption and set a power
> limit to a device.
> 
> While the powercap simple backend gives a single device entry, DTPM
> aggregates the different devices power by summing their power and their
> limits. The tree representation of the different DTPM nodes describe how
> their limits are set and how the power is computed along the different
> devices.

That's all great, doing this in-kernel is fine, it's now the "userspace
must set this up properly that I'm objecting to as no one will know how
to do this.

> For more info, we did a presentation at ELC [1] and Linux PM
> microconference [2] and there is an article talking about it [3].
> 
> 
> To answer your questions, there is a SoC vendor thermal daemon using
> DTPM and there is a tool created to watch the thermal framework and read
> the DTPM values, it is available at [4]. It is currently under
> development with the goal of doing power rebalancing / capping across
> the different nodes when there is a violation of the parent's power limit.

Crazy ideas aside, your implementation of this is my main objection
here.  You are creating a user/kernel api that you will have to support
for 20+ years, without a real userspace user just yet (from what I can
tell).  That's rough, and is going to mean that this gets messy over
time.

Also there's the whole "tying sysfs to configfs" mess and reference
counting that I object to as well...

> >> The next changes will provide an userspace interface to create
> >> hierarchically the different nodes. Those will be created by name and
> >> found via the list filled by the different subsystem.
> >>
> >> If a specified name is not found in the list, it is assumed to be a
> >> virtual node which will have children and the default is to allocate
> >> such node.
> > 
> > So userspace sets the name?
> > 
> > Why not use the name in the device itself?  I thought I asked that last
> > time...
> 
> I probably missed it, sorry for that.
> 
> When the userspace creates the directory in the configfs, there is a
> lookup with the name in the device list name. If it is found, then the
> device is used, otherwise a virtual node is created instead, its power
> consumption is equal to the sum of the children.
> 
> The different drivers register themselves with their name and the
> associated dtpm structure. The userspace pick in this list to create a
> hierarchy via configfs.
> 
> For example, a big.Little system.
> 
> - little CPUs power limiter will have the name cpu0-cpufreq
> - big CPUs will have the name cpu4-cpufreq
> - gpu will have the name ff9a0000.gpu-devfreq
> - charger will have the name power-supply-charge
> - DDR memory controller can have the name dmc-devfreq
> 
> Userspace may want to create this hierarchy:
> 
> soc
>  - package
>    - cluster0
>      - cpu0-cpufreq
>    - cluster1
>      - ff9a0000.gpu-devfreq
>    - dmc-devfreq
>  - battery
>    - power-supply-charge
> 
> It will do:
> 
> mkdir soc (virtual node)
> mkdir soc/cluster0 (virtual node)
> mkdir soc/cluster0/cpu0-cpufreq (real device)
> etc ...
> 
> The configfs does not represent the layout of the sensors or the floor
> plan of the devices but only the constraints we want to tie together.
> 
> That is the reason why I think using configfs instead of OF is more
> adequate and flexible as userspace deals with the power numbers.
> Moreover, we won't be facing issues with devices initialization priority
> when the daemon starts.
> 
> I thought we can add OF later, when the framework has more users and
> more devices. The configfs and OF can certainly co-exist or be mutually
> exclusive via the Kconfig option.

Kconfig options are not ok for this, you want to build a kernel that
works everywhere.

If you want to make virtual things, that's fine, but again, your tying
of sysfs to configfs in odd ways, along with the reference counting
bugs/nightmare the current implementation is creating, is a non-starter
for me at the moment, sorry.

thanks,

greg k-h

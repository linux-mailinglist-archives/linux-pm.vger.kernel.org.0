Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD2A2937F0
	for <lists+linux-pm@lfdr.de>; Tue, 20 Oct 2020 11:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391512AbgJTJYj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Oct 2020 05:24:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:49946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391474AbgJTJYi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 20 Oct 2020 05:24:38 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7F0D22283;
        Tue, 20 Oct 2020 09:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603185877;
        bh=8ZZSyaST46xHsc2O8mFnyXxHaTQ7UF7YOOmcmS7F5uk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Skkx4ZJ/LXQ3YYr/MG/bTqDu6egjPnooKqoFZLtAdmwKfBXzATRXwNJRfEMvrqd4y
         2AF0+nkgWH1Gpubu1KjGXiVNgTen3jv6iymogLL5FfWRELBi9bbYLQpaFfQv2Gi+DV
         4ErdZNHcW/zzZQk709hohHya4AIc5YyJIItFLhjY=
Date:   Tue, 20 Oct 2020 11:25:20 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     josephjang@google.com
Cc:     rafael@kernel.org, rjw@rjwysocki.net, pavel@ucw.cz,
        len.brown@intel.com, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        jonglin@google.com, woodylin@google.com, markcheng@google.com
Subject: Re: [PATCH] power: suspend: Add suspend timeout handler
Message-ID: <20201020092520.GB3880268@kroah.com>
References: <0000000000008d35ba05b216782a@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000008d35ba05b216782a@google.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Note, your response is not threading well, just hit 'reply' in your
email client...

On Tue, Oct 20, 2020 at 09:01:05AM +0000, josephjang@google.com wrote:
> > On Tue, Oct 20, 2020 at 08:15:38AM +0000, josephjang@google.com wrote:
> > > > On Tue, Oct 20, 2020 at 02:22:26PM +0800, Joseph Jang wrote:
> > > > > Add sleep timer and timeout handler to prevent device stuck during
> > > > suspend/
> > > > > resume process. The timeout handler will dump disk sleep task at
> > first
> > > > > round timeout and trigger kernel panic at second round timeout.
> > > > > The default timer for each round is defined in
> > > > > CONFIG_PM_SLEEP_TIMER_TIMEOUT.
> > > > >
> > > > > Signed-off-by: Joseph Jang <josephjang@google.com>
> > > > > ---
> > > > >  MAINTAINERS                   |  2 +
> > > > >  include/linux/console.h       |  1 +
> > > > >  include/linux/suspend_timer.h | 90
> > +++++++++++++++++++++++++++++++++++
> > >
> > > > Why is this file in include/linux/ if you only ever call it from one
> > .c
> > > > file?
> > >
> > > I just refer to include/linux/suspend.h and create a new header file
> > in the
> > > same folder.
> > > If you have a better location for the new header file, please feel
> > free to
> > > let me know.
> 
> > Only put .h files that are needed by different .c files in the
> > include/linux/ directory.  Otherwise it should be local to where the .c
> > file is.
> > Great, use that!
> 
> > > But we really hit the suspend hang issue that DPM_WATCHDOG cannot cover.
> 
> > What issue is that?
> 
> > > We propose a wide coverage debug feature like PM_SLEEP_MONITOR which
> > > not only covers PM but also core PM hang issues.
> > >
> > > And DPM_WATCHDOG is for device driver power management in
> > > drivers/base/power/main.c
> > > and PM_SLEEP_MONITOR locate is for core power management in
> > > kernel/power/suspend.c.
> > > I think it is fine for users to select whether they need device PM
> > only or
> > > not.
> 
> > How will a user know which they should use?
> 
> > Why not just fix whatever is wrong with the watchdog code instead of
> > creating a new one?
> 
> > > > And why isn't the watchdog sufficient for you?  Why are you "open
> > > > coding" a watchdog timer logic here at all???
> > >
> > > Yes, we refer to DPM_WATCHDOG to extend the watchdog debugging for
> > core PM.
> > > Because we really hit a real case that was not covered by DPM_WATCHDOG.
> 
> > Then fix that!
> 
> > > I think PM_SLEEP_MONITOR is an extension debug feature from
> > DPM_WATCHDOG.
> 
> > Please just fix the watchdog, as obviously it is not working properly.
> > Don't create something new because of that.
> 
> > thanks,
> 
> > greg k-h
> 
> Thank you Greq for promptly responding.
> I am okay to fix the DPM_WATCHDOG feature, but would like to have quick sync
> up before start.
> Could you help?
> 
> 
> 1. Can we change the kernel config name ?
> DPM_WATCHDOG stands for Device Power Management.
> We propose PM_SLEEP_MONITOR is to cover Core PM and Device PM.

That's fine.

> 2. Can we create a new data structure instead of using the following struct
> dpm_watchdog?
> struct dpm_watchdog {
> 	struct device		*dev;
> 	struct task_struct	*tsk;
> 	struct timer_list	timer;
> };

Why not use the existing one?

> 
> I list some reasons by following ...
> 
> static int device_resume(struct device *dev, pm_message_t state, bool async)
> {
> 	pm_callback_t callback = NULL;
> 	const char *info = NULL;
> 	int error = 0;
> 	DECLARE_DPM_WATCHDOG_ON_STACK(wd);  <== dpm_watchdog use stack memory for
> watchdog timer struct, but sleep timer use global memory.

Then move it off of the stack.

> 
> ...<SNIP>
> 
> 	if (!dpm_wait_for_superior(dev, async))
> 		goto Complete;
> 
> 	dpm_watchdog_set(&wd, dev);  <== dpm_watchdog need "struct device", but
> sleep timer doesn't need it.

That's fine, what are you trying to optimize for?


> 	device_lock(dev);
> 
> ...<SNIP>
> 
>  Unlock:
> 	device_unlock(dev);
> 	dpm_watchdog_clear(&wd);
> 
>  Complete:
> 	complete_all(&dev->power.completion);
> 
> 	TRACE_RESUME(error);
> 
> 	return error;
> }

Submit a patch that shows what you are doing and we will be glad to
review that.

thanks,

greg k-h

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 180D834BB78
	for <lists+linux-pm@lfdr.de>; Sun, 28 Mar 2021 08:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbhC1GvM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 28 Mar 2021 02:51:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:33362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229485AbhC1Guu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 28 Mar 2021 02:50:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 993A66197E;
        Sun, 28 Mar 2021 06:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616914250;
        bh=Qfc+jkQiwmRLdku+MjqiGwfs/bzz2AM23GbuUyLm58E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bvo//q4deEJljFDZWWf5Pfddhnhs+qcja05VScZGkygUebRSx4er7lhovAH/ARdXY
         0gaJynuMDIlEqrpjiwB0bSXjPo2JSxgb1kVTKqEUNironRQxYYpKF7a0RSQ3kNsWKz
         WfKpBQm8qvmUbtHxqyAkD55lDh37EIjuwahVt9h4=
Date:   Sun, 28 Mar 2021 08:50:47 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, lukasz.luba@arm.com
Subject: Re: [PATCH v4 2/5] powercap/drivers/dtpm: Create a registering system
Message-ID: <YGAnRx8SiZHFPpY6@kroah.com>
References: <20210312130411.29833-1-daniel.lezcano@linaro.org>
 <20210312130411.29833-2-daniel.lezcano@linaro.org>
 <YF8qIw4UBLnj9TCA@kroah.com>
 <433ec4ac-a7a9-ecf9-f1c1-f658d279a2df@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <433ec4ac-a7a9-ecf9-f1c1-f658d279a2df@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Mar 27, 2021 at 08:41:24PM +0100, Daniel Lezcano wrote:
> On 27/03/2021 13:50, Greg KH wrote:
> > On Fri, Mar 12, 2021 at 02:04:08PM +0100, Daniel Lezcano wrote:
> >> A SoC can be differently structured depending on the platform and the
> >> kernel can not be aware of all the combinations, as well as the
> >> specific tweaks for a particular board.
> >>
> >> The creation of the hierarchy must be delegated to userspace.
> >>
> >> These changes provide a registering mechanism where the different
> >> subsystems will initialize their dtpm backends and register with a
> >> name the dtpm node in a list.
> >>
> >> The next changes will provide an userspace interface to create
> >> hierarchically the different nodes. Those will be created by name and
> >> found via the list filled by the different subsystem.
> >>
> >> If a specified name is not found in the list, it is assumed to be a
> >> virtual node which will have children and the default is to allocate
> >> such node.
> >>
> >> When the node register in the list, the function will be dtpm_register
> >> where the previous semantic was to create the node. Thus, the
> >> functions are renamed to reflect their purpose.
> >>
> >> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> >> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
> >> ---
> 
> [ ... ]
> 
> >> +static void dtpm_release(struct kref *kref)
> >> +{
> >> +	struct dtpm *dtpm = container_of(kref, struct dtpm, kref);
> >> +
> >> +	kfree(dtpm);
> >> +}
> >> +
> >> +/**
> >> + * dtpm_put - Release a reference on a dtpm device
> >> + * @dtpm: a pointer to a dtpm structure
> >> + *
> >> + * Release the reference on the specified dtpm device. The last
> >> + * reference leads to a memory release.
> >> + */
> >> +void dtpm_put(struct dtpm *dtpm)
> >> +{
> >> +	kref_put(&dtpm->kref, dtpm_release);
> > 
> > You forgot to also grab the dtpm_lock before calling this, right?  What
> > is preventing a get and put from being called at the same time?
> > 
> > You protect things at get time, but not put from what I can see :(
> 
> Thanks for spotting this, I will send a fix for that.
> 
> [ ... ]
> 
> >> +	list_add(&node->node, &dtpm_list);
> >> +
> >> +	pr_info("Registered %s\n", name);
> > 
> > When kernel code works properly, it is quiet.  This is debugging code a
> > the most, never something that everyone should be seeing all the time,
> > please remove.
> 
> Initially, a comment asked for debug traces in the code. There are more
> traces in the code at the pr_debug level.
> 
> Is your suggestion to remove the pr_info as well as other debug traces
> or convert those pr_info to pr_debug ?

pr_info() should not be used for "debug traces".

Use real tracepoints for debug traces if you still need them, hopefully
the code is all now debugged properly, right?

Again, when code is working, it is quiet.  Do not leave debugging stuff
like this in a working system.

> 
> [ ... ]
> 
> > And any reason why you are not using "real" struct devices in this
> > subsystem?  You seem to be rolling your own infrastructure for no good
> > reason.  I imagine you want sysfs support next, right?
> 
> Actually, the framework is on top of powercap, so it has de facto the
> sysfs support. On the other side, the dtpm backends are tied with the
> device they manage.

So why are they not a "real" device in the driver model?  It looks like
you almost are wanting all of that functionality and are having to
implement it "by hand" instead.

thanks,

greg k-h

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 117A53E2D6A
	for <lists+linux-pm@lfdr.de>; Fri,  6 Aug 2021 17:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234937AbhHFPQk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Aug 2021 11:16:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:45106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232091AbhHFPQj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 6 Aug 2021 11:16:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 726586113C;
        Fri,  6 Aug 2021 15:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628262983;
        bh=5EQVQZE7KCLf8QCR8UMxWlsi5KRF1bSRTflymQ2CGzg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FFBOiFC1omFG4oeN/9vAb3em/q/pCUjst1ywNCt5zTl3jm4NUEhYj6VCJXw2udaGS
         wfjSRioecHGRD6ZC32wQ+k3w4wpaGu037rFQQMuRRy3xJbYbGGileo0qlRdImKF0LH
         VCLKdG4Mi/Hz47OdEfjR/9ZAh/rxekt3fF3zxmNM=
Date:   Fri, 6 Aug 2021 17:16:21 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     psodagud@codeaurora.org
Cc:     rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PM: sleep: core: Avoid setting power.must_resume to false
Message-ID: <YQ1SRbBrcKl2Vt9f@kroah.com>
References: <1627313074-436260-1-git-send-email-psodagud@codeaurora.org>
 <YQl6Bnjrnypbsz/s@kroah.com>
 <0fe9a873ca77293151a61f64d355895f@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0fe9a873ca77293151a61f64d355895f@codeaurora.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Aug 06, 2021 at 08:07:08AM -0700, psodagud@codeaurora.org wrote:
> On 2021-08-03 10:16, Greg KH wrote:
> > On Mon, Jul 26, 2021 at 08:24:34AM -0700, Prasad Sodagudi wrote:
> > > There are variables(power.may_skip_resume and dev->power.must_resume)
> > > and DPM_FLAG_MAY_SKIP_RESUME flags to control the resume of devices
> > > after
> > > a system wide suspend transition.
> > > 
> > > Setting the DPM_FLAG_MAY_SKIP_RESUME flag means that the driver allows
> > > its "noirq" and "early" resume callbacks to be skipped if the device
> > > can be left in suspend after a system-wide transition into the working
> > > state. PM core determines that the driver's "noirq" and "early" resume
> > > callbacks should be skipped or not with dev_pm_skip_resume()
> > > function by
> > > checking power.may_skip_resume variable.
> > > 
> > > power.must_resume variable is getting set to false in
> > > __device_suspend()
> > > function without checking device's DPM_FLAG_MAY_SKIP_RESUME and
> > > dev->power.usage_count variables. This is leading to failure to call
> > > resume handler for some of the devices suspended in early suspend
> > > phase.
> > > So check device's DPM_FLAG_MAY_SKIP_RESUME flag before
> > > setting power.must_resume variable.
> > > 
> > > Signed-off-by: Prasad Sodagudi <psodagud@codeaurora.org>
> > > ---
> > >  drivers/base/power/main.c | 6 +++++-
> > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> > > index d568772..8eebc4d 100644
> > > --- a/drivers/base/power/main.c
> > > +++ b/drivers/base/power/main.c
> > > @@ -1642,7 +1642,11 @@ static int __device_suspend(struct device
> > > *dev, pm_message_t state, bool async)
> > >  	}
> > > 
> > >  	dev->power.may_skip_resume = true;
> > > -	dev->power.must_resume = false;
> > > +	if ((atomic_read(&dev->power.usage_count) <= 1) &&
> > > +			(dev_pm_test_driver_flags(dev, DPM_FLAG_MAY_SKIP_RESUME)))
> > 
> > What is preventing that atomic value from changing _right_ after you
> > just read this?
> > 
> > and very odd indentation, checkpatch didn't complain about this?
> Sure. I will fix indentation problem once Rafael reviewed this patch.

Neither of us can take this as-is, so why wait?


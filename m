Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70AD2139017
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2020 12:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbgAML3h convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Mon, 13 Jan 2020 06:29:37 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:56307 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbgAML3h (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jan 2020 06:29:37 -0500
Received: from 79.184.255.90.ipv4.supernova.orange.pl (79.184.255.90) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.320)
 id 9ab51728271c6d21; Mon, 13 Jan 2020 12:29:34 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PM-runtime: add tracepoints for usage_count changes
Date:   Mon, 13 Jan 2020 12:29:33 +0100
Message-ID: <12840272.KYWuQ3LjJR@kreacher>
In-Reply-To: <20200106100004.GA10946@qmqm.qmqm.pl>
References: <cb199a03895f8a11d9039209e6ac1cd92b1d1fb9.1578155207.git.mirq-linux@rere.qmqm.pl> <20200104182123.GA1485543@kroah.com> <20200106100004.GA10946@qmqm.qmqm.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Monday, January 6, 2020 11:00:04 AM CET Michał Mirosław wrote:
> On Sat, Jan 04, 2020 at 07:21:23PM +0100, Greg Kroah-Hartman wrote:
> > On Sat, Jan 04, 2020 at 05:27:57PM +0100, Michał Mirosław wrote:
> > > Add tracepoints to remaining places where device's power.usage_count
> > > is changed. This helps debugging where and why autosuspend is prevented.
> > > 
> > > Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> > > ---
> > >  drivers/base/power/runtime.c | 13 +++++++++++--
> > >  include/trace/events/rpm.h   |  6 ++++++
> > >  2 files changed, 17 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> > > index 48616f358854..16134a69bf6f 100644
> > > --- a/drivers/base/power/runtime.c
> > > +++ b/drivers/base/power/runtime.c
> > > @@ -1006,8 +1006,10 @@ int __pm_runtime_idle(struct device *dev, int rpmflags)
> > >  	int retval;
> > >  
> > >  	if (rpmflags & RPM_GET_PUT) {
> > > -		if (!atomic_dec_and_test(&dev->power.usage_count))
> > > +		if (!atomic_dec_and_test(&dev->power.usage_count)) {
> > > +			trace_rpm_usage_rcuidle(dev, rpmflags);
> > 
> > Who and what is really going to use these tracepoints?
> > 
> > And putting them in these if statements seems odd, are you sure that's
> > the correct place?  What do these show to userspace?
> > 
> > >  			return 0;
> > > +		}
> > >  	}
> > >  
> > >  	might_sleep_if(!(rpmflags & RPM_ASYNC) && !dev->power.irq_safe);
> > > @@ -1038,8 +1040,10 @@ int __pm_runtime_suspend(struct device *dev, int rpmflags)
> > >  	int retval;
> > >  
> > >  	if (rpmflags & RPM_GET_PUT) {
> > > -		if (!atomic_dec_and_test(&dev->power.usage_count))
> > > +		if (!atomic_dec_and_test(&dev->power.usage_count)) {
> > > +			trace_rpm_usage_rcuidle(dev, rpmflags);
> > >  			return 0;
> > > +		}
> > >  	}
> > >  
> > >  	might_sleep_if(!(rpmflags & RPM_ASYNC) && !dev->power.irq_safe);
> > > @@ -1101,6 +1105,7 @@ int pm_runtime_get_if_in_use(struct device *dev)
> > >  	retval = dev->power.disable_depth > 0 ? -EINVAL :
> > >  		dev->power.runtime_status == RPM_ACTIVE
> > >  			&& atomic_inc_not_zero(&dev->power.usage_count);
> > > +	trace_rpm_usage_rcuidle(dev, 0);
> > 
> > Why this one?
> > 
> > 
> > >  	spin_unlock_irqrestore(&dev->power.lock, flags);
> > >  	return retval;
> > >  }
> > > @@ -1434,6 +1439,8 @@ void pm_runtime_allow(struct device *dev)
> > >  	dev->power.runtime_auto = true;
> > >  	if (atomic_dec_and_test(&dev->power.usage_count))
> > >  		rpm_idle(dev, RPM_AUTO | RPM_ASYNC);
> > > +	else
> > > +		trace_rpm_usage_rcuidle(dev, RPM_AUTO | RPM_ASYNC);
> > 
> > Are you sure this is correct?
> > 
> > These feel odd...
> 
> This covers all places where power.usage_count might have changed.
> If atomic_dec_and_test() decrements usage_count but not to zero,
> the new value will be traced in rpm_idle(). But if the value drops to
> zero, then we need to trace it explicitly to be able to have all changes
> accounted for in the trace.
> 
> I actually used this patch to track down why USB storage device was
> not autosuspending correctly.

Fair enough, and the patch makes sense to me, so I'm queuing it up as 5.6
material.

Thanks!




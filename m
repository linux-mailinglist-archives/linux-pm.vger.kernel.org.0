Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDF13130FD6
	for <lists+linux-pm@lfdr.de>; Mon,  6 Jan 2020 11:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725821AbgAFKAL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Jan 2020 05:00:11 -0500
Received: from rere.qmqm.pl ([91.227.64.183]:58440 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbgAFKAL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 6 Jan 2020 05:00:11 -0500
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 47rrbW64m1zV6;
        Mon,  6 Jan 2020 11:00:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1578304808; bh=cL4mF1jHUeGe0pKz/0D4gMOsnENC81lNvvo2kdmArbw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SQSRAtimoT4S5oqIEhtwVHIDIIABk1PQ+gDFywwA12mVBxFRczNTPkaAVOfE3ufl9
         L3RIGEGymoOXMqIelWI+HgGTlo1tSmjBaF6zL8sBarb/8EqOcqC3c4Ek45kH9eEo0V
         zvLNihcBDd0dE7h0G/k7j1iFKP9Vc2Hbt3GKqjUt0CeZypoxOnm+HVbPS0r5y2XSwm
         YdmfgMAK+ZclPu0b52QY6ekXCCopqoKk0jPQl6AsgRtxQELwtc31nTeXpQujcCOR6a
         ExD7P1+Ri/LBqJCZ9U5sGe1Nh8jdFaat+iG86csKydya9ziBgCzYXal0U9ndRyUjQS
         jmKoMoJwdhxtw==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.101.4 at mail
Date:   Mon, 6 Jan 2020 11:00:04 +0100
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PM-runtime: add tracepoints for usage_count changes
Message-ID: <20200106100004.GA10946@qmqm.qmqm.pl>
References: <cb199a03895f8a11d9039209e6ac1cd92b1d1fb9.1578155207.git.mirq-linux@rere.qmqm.pl>
 <20200104182123.GA1485543@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200104182123.GA1485543@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Jan 04, 2020 at 07:21:23PM +0100, Greg Kroah-Hartman wrote:
> On Sat, Jan 04, 2020 at 05:27:57PM +0100, Micha³ Miros³aw wrote:
> > Add tracepoints to remaining places where device's power.usage_count
> > is changed. This helps debugging where and why autosuspend is prevented.
> > 
> > Signed-off-by: Micha³ Miros³aw <mirq-linux@rere.qmqm.pl>
> > ---
> >  drivers/base/power/runtime.c | 13 +++++++++++--
> >  include/trace/events/rpm.h   |  6 ++++++
> >  2 files changed, 17 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> > index 48616f358854..16134a69bf6f 100644
> > --- a/drivers/base/power/runtime.c
> > +++ b/drivers/base/power/runtime.c
> > @@ -1006,8 +1006,10 @@ int __pm_runtime_idle(struct device *dev, int rpmflags)
> >  	int retval;
> >  
> >  	if (rpmflags & RPM_GET_PUT) {
> > -		if (!atomic_dec_and_test(&dev->power.usage_count))
> > +		if (!atomic_dec_and_test(&dev->power.usage_count)) {
> > +			trace_rpm_usage_rcuidle(dev, rpmflags);
> 
> Who and what is really going to use these tracepoints?
> 
> And putting them in these if statements seems odd, are you sure that's
> the correct place?  What do these show to userspace?
> 
> >  			return 0;
> > +		}
> >  	}
> >  
> >  	might_sleep_if(!(rpmflags & RPM_ASYNC) && !dev->power.irq_safe);
> > @@ -1038,8 +1040,10 @@ int __pm_runtime_suspend(struct device *dev, int rpmflags)
> >  	int retval;
> >  
> >  	if (rpmflags & RPM_GET_PUT) {
> > -		if (!atomic_dec_and_test(&dev->power.usage_count))
> > +		if (!atomic_dec_and_test(&dev->power.usage_count)) {
> > +			trace_rpm_usage_rcuidle(dev, rpmflags);
> >  			return 0;
> > +		}
> >  	}
> >  
> >  	might_sleep_if(!(rpmflags & RPM_ASYNC) && !dev->power.irq_safe);
> > @@ -1101,6 +1105,7 @@ int pm_runtime_get_if_in_use(struct device *dev)
> >  	retval = dev->power.disable_depth > 0 ? -EINVAL :
> >  		dev->power.runtime_status == RPM_ACTIVE
> >  			&& atomic_inc_not_zero(&dev->power.usage_count);
> > +	trace_rpm_usage_rcuidle(dev, 0);
> 
> Why this one?
> 
> 
> >  	spin_unlock_irqrestore(&dev->power.lock, flags);
> >  	return retval;
> >  }
> > @@ -1434,6 +1439,8 @@ void pm_runtime_allow(struct device *dev)
> >  	dev->power.runtime_auto = true;
> >  	if (atomic_dec_and_test(&dev->power.usage_count))
> >  		rpm_idle(dev, RPM_AUTO | RPM_ASYNC);
> > +	else
> > +		trace_rpm_usage_rcuidle(dev, RPM_AUTO | RPM_ASYNC);
> 
> Are you sure this is correct?
> 
> These feel odd...

This covers all places where power.usage_count might have changed.
If atomic_dec_and_test() decrements usage_count but not to zero,
the new value will be traced in rpm_idle(). But if the value drops to
zero, then we need to trace it explicitly to be able to have all changes
accounted for in the trace.

I actually used this patch to track down why USB storage device was
not autosuspending correctly.

Best Regards,
Micha³ Miros³aw

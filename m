Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5F9222199E
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jul 2020 03:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbgGPBsb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jul 2020 21:48:31 -0400
Received: from mga09.intel.com ([134.134.136.24]:45030 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726785AbgGPBsa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 15 Jul 2020 21:48:30 -0400
IronPort-SDR: VJdOjsTGR32VX5w2hBwRo66fs16dvv/8df5lYA0h5Yc2LrDuV+nEMz2noMjEjBbzuNTqngaHt/
 8Zyuc9r1lCoQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9683"; a="150689518"
X-IronPort-AV: E=Sophos;i="5.75,357,1589266800"; 
   d="scan'208";a="150689518"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2020 18:48:28 -0700
IronPort-SDR: gQWfjTPxlyJ4nqYRxf0GpqjZPNlcfbjb5b4r5XXdiX1MDpXKOytShrJQPjwaD4+EMH3ilS7RNE
 BYY0ilEOwHZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,357,1589266800"; 
   d="scan'208";a="486444956"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by fmsmga005.fm.intel.com with ESMTP; 15 Jul 2020 18:48:26 -0700
Date:   Thu, 16 Jul 2020 09:49:46 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Miroslaw <mirq-linux@rere.qmqm.pl>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2][RESEND v3] PM-runtime: change the tracepoints to
 cover all usage_count
Message-ID: <20200716014946.GB4588@chenyu-office.sh.intel.com>
References: <cover.1594790493.git.yu.c.chen@intel.com>
 <395187057e486df9a4328bc6d7d4ee912967fdb3.1594790493.git.yu.c.chen@intel.com>
 <CAJZ5v0j9Jb5c7AQT611Zjep+jx+iTqKB8-KbPCKb8SCXMqEiJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0j9Jb5c7AQT611Zjep+jx+iTqKB8-KbPCKb8SCXMqEiJQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jul 15, 2020 at 05:47:36PM +0200, Rafael J. Wysocki wrote:
> On Wed, Jul 15, 2020 at 8:26 AM Chen Yu <yu.c.chen@intel.com> wrote:
> >
> > Commit d229290689ae ("PM-runtime: add tracepoints for usage_count changes")
> > has added some tracepoints to monitor the change of runtime usage, and
> > there is something to improve:
> > 1. There are some places that adjust the usage count not
> >    been traced yet. For example, pm_runtime_get_noresume() and
> >    pm_runtime_put_noidle()
> > 2. The change of the usage count will not be tracked if decreased
> >    from 1 to 0.
> >
> > This patch intends to adjust the logic to be consistent with the
> > change of usage_counter, that is to say, only after the counter has
> > been possibly modified, we record it. Besides, all usage changes will
> > be shown using rpm_usage even if included by other trace points.
> > And these changes has helped track down the e1000e runtime issue.
> >
> > Reviewed-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > ---
> >  drivers/base/power/runtime.c | 38 +++++++++++++++++++++++-------------
> >  1 file changed, 24 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> > index 85a248e196ca..5789d2624513 100644
> > --- a/drivers/base/power/runtime.c
> > +++ b/drivers/base/power/runtime.c
> > @@ -1004,10 +1004,11 @@ int __pm_runtime_idle(struct device *dev, int rpmflags)
> >         int retval;
> >
> >         if (rpmflags & RPM_GET_PUT) {
> > -               if (!atomic_dec_and_test(&dev->power.usage_count)) {
> > -                       trace_rpm_usage_rcuidle(dev, rpmflags);
> > +               bool non_zero = !atomic_dec_and_test(&dev->power.usage_count);
> > +
> > +               trace_rpm_usage_rcuidle(dev, rpmflags);
> 
> It looks like you could move the trace event before the atomic variable check.
> 
> The ordering between the two doesn't matter, because usage_count may
> change between the check and the trace event anyway.
> 
> But then what is the trace event useful for in the first place?
>
Thanks for explanation, I've changed my mind, it seems that we should not
trace the counter because we don't know who the operator is due to race condition.
> > +               if (non_zero)
> >                         return 0;
> > -               }
> >         }
> >
> >         might_sleep_if(!(rpmflags & RPM_ASYNC) && !dev->power.irq_safe);
> > @@ -1038,10 +1039,12 @@ int __pm_runtime_suspend(struct device *dev, int rpmflags)
> >         int retval;
> >
> >         if (rpmflags & RPM_GET_PUT) {
> > -               if (!atomic_dec_and_test(&dev->power.usage_count)) {
> > -                       trace_rpm_usage_rcuidle(dev, rpmflags);
> > +               bool non_zero = !atomic_dec_and_test(&dev->power.usage_count);
> > +
> > +               trace_rpm_usage_rcuidle(dev, rpmflags);
> 
> And the same comments apply here.
> 
> > +               if (non_zero)
> >                         return 0;
> > -               }
> > +
> >         }
> >
> >         might_sleep_if(!(rpmflags & RPM_ASYNC) && !dev->power.irq_safe);
> > @@ -1073,8 +1076,10 @@ int __pm_runtime_resume(struct device *dev, int rpmflags)
> >         might_sleep_if(!(rpmflags & RPM_ASYNC) && !dev->power.irq_safe &&
> >                         dev->power.runtime_status != RPM_ACTIVE);
> >
> > -       if (rpmflags & RPM_GET_PUT)
> > +       if (rpmflags & RPM_GET_PUT) {
> >                 atomic_inc(&dev->power.usage_count);
> 
> So the reason why things like that don't work is because the atomic
> variable can change again between the inc and the trace event.
> 
Got it.
> > +               trace_rpm_usage_rcuidle(dev, rpmflags);
> > +       }
> >
> >         spin_lock_irqsave(&dev->power.lock, flags);
> >         retval = rpm_resume(dev, rpmflags);
> > @@ -1433,6 +1438,7 @@ void pm_runtime_forbid(struct device *dev)
> >
> >         dev->power.runtime_auto = false;
> >         atomic_inc(&dev->power.usage_count);
> 
> Analogously here.
> 
> > +       trace_rpm_usage_rcuidle(dev, 0);
> >         rpm_resume(dev, 0);
> >
> >   out:
> > @@ -1448,16 +1454,17 @@ EXPORT_SYMBOL_GPL(pm_runtime_forbid);
> >   */
> >  void pm_runtime_allow(struct device *dev)
> >  {
> > +       bool is_zero;
> > +
> >         spin_lock_irq(&dev->power.lock);
> >         if (dev->power.runtime_auto)
> >                 goto out;
> >
> >         dev->power.runtime_auto = true;
> > -       if (atomic_dec_and_test(&dev->power.usage_count))
> > +       is_zero = atomic_dec_and_test(&dev->power.usage_count);
> > +       trace_rpm_usage_rcuidle(dev, RPM_AUTO | RPM_ASYNC);
> > +       if (is_zero)
> >                 rpm_idle(dev, RPM_AUTO | RPM_ASYNC);
> > -       else
> > -               trace_rpm_usage_rcuidle(dev, RPM_AUTO | RPM_ASYNC);
> 
> The change of ordering is pointless for the reasons outlined above.
> 
> And so on.
> 
> > -
> >   out:
> >         spin_unlock_irq(&dev->power.lock);
> >  }
> > @@ -1523,9 +1530,8 @@ static void update_autosuspend(struct device *dev, int old_delay, int old_use)
> >                 /* If it used to be allowed then prevent it. */
> >                 if (!old_use || old_delay >= 0) {
> >                         atomic_inc(&dev->power.usage_count);
> > -                       rpm_resume(dev, 0);
> > -               } else {
> >                         trace_rpm_usage_rcuidle(dev, 0);
> > +                       rpm_resume(dev, 0);
> >                 }
> >         }
> >
> > @@ -1533,8 +1539,10 @@ static void update_autosuspend(struct device *dev, int old_delay, int old_use)
> >         else {
> >
> >                 /* If it used to be prevented then allow it. */
> > -               if (old_use && old_delay < 0)
> > +               if (old_use && old_delay < 0) {
> >                         atomic_dec(&dev->power.usage_count);
> > +                       trace_rpm_usage_rcuidle(dev, 0);
> > +               }
> >
> >                 /* Maybe we can autosuspend now. */
> >                 rpm_idle(dev, RPM_AUTO);
> > @@ -1741,12 +1749,14 @@ void pm_runtime_drop_link(struct device *dev)
> >  void pm_runtime_get_noresume(struct device *dev)
> >  {
> >         atomic_inc(&dev->power.usage_count);
> > +       trace_rpm_usage_rcuidle(dev, 0);
> >  }
> 
> This actually kind of makes sense, as a matter of tracing the
> pm_runtime_get_noresume() usage, but not as a matter of tracing the
> atomic variable value.
> 
Okay, I'll re-iterate the code and re-think about it on how to
track the runtime process more robustly.

Thanks,
Chenyu
> >  EXPORT_SYMBOL_GPL(pm_runtime_get_noresume);
> >
> >  void pm_runtime_put_noidle(struct device *dev)
> >  {
> >         atomic_add_unless(&dev->power.usage_count, -1, 0);
> > +       trace_rpm_usage_rcuidle(dev, 0);
> >  }
> >  EXPORT_SYMBOL_GPL(pm_runtime_put_noidle);
> >
> > --

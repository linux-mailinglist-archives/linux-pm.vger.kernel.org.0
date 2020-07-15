Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBA8122117D
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jul 2020 17:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725861AbgGOPrt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Wed, 15 Jul 2020 11:47:49 -0400
Received: from mail-oo1-f65.google.com ([209.85.161.65]:34926 "EHLO
        mail-oo1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbgGOPrs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jul 2020 11:47:48 -0400
Received: by mail-oo1-f65.google.com with SMTP id w1so555705ooj.2;
        Wed, 15 Jul 2020 08:47:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2dd8dU80M/kMQux1WWZ1GyO7vPwtuF7WLVF0BD54ZC8=;
        b=DKEyMRGjTbiEnQM3w6EOq9t7yCnc8T1BqTvWsRuITpwzBiUYXKiL8lG5B8jfovX0O4
         nNe8xhqCZyAgeX03X1kvSVQnHonMA/kxUZRZdXqlzBej4di1l7QD/OFwiDTRmypTo9uB
         DKgWxm2MMqgq2/UUrP0d65eyLrKQVpAwWI5SUPu+a5+fXBTBJosvSTET6Obq4DLCN2aK
         bWxTjehE1F4/soQLx1m15ZG+GUeAm4HJlEh3RWv80Rh9dCTgWWZFdK4KAJIV5aU0e9PN
         SKwjr3hr0wyOyOBsza5h9pq0qUiyzvwQ20bpozU3KYTGfLmCCb9NxU4cDTflMIkx3+dc
         s5pg==
X-Gm-Message-State: AOAM530wosair74sp32AhvvUgj/A/ClVO4rqmX0sCzS8I5SHdx9nZRYa
        IEv5KaN/dvPOzh4KkVTKypQdwSHrUKPDkaahtRU=
X-Google-Smtp-Source: ABdhPJybCX4o1BU6NYBb/UZcP+yGeSeAacIluPEC2msbr+yFDYZx+ayBE7divhGu1q6ipjauPHhqigsiSHgpdBdDtTQ=
X-Received: by 2002:a4a:2459:: with SMTP id v25mr10007959oov.75.1594828067535;
 Wed, 15 Jul 2020 08:47:47 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1594790493.git.yu.c.chen@intel.com> <395187057e486df9a4328bc6d7d4ee912967fdb3.1594790493.git.yu.c.chen@intel.com>
In-Reply-To: <395187057e486df9a4328bc6d7d4ee912967fdb3.1594790493.git.yu.c.chen@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 15 Jul 2020 17:47:36 +0200
Message-ID: <CAJZ5v0j9Jb5c7AQT611Zjep+jx+iTqKB8-KbPCKb8SCXMqEiJQ@mail.gmail.com>
Subject: Re: [PATCH 2/2][RESEND v3] PM-runtime: change the tracepoints to
 cover all usage_count
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Miroslaw <mirq-linux@rere.qmqm.pl>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jul 15, 2020 at 8:26 AM Chen Yu <yu.c.chen@intel.com> wrote:
>
> Commit d229290689ae ("PM-runtime: add tracepoints for usage_count changes")
> has added some tracepoints to monitor the change of runtime usage, and
> there is something to improve:
> 1. There are some places that adjust the usage count not
>    been traced yet. For example, pm_runtime_get_noresume() and
>    pm_runtime_put_noidle()
> 2. The change of the usage count will not be tracked if decreased
>    from 1 to 0.
>
> This patch intends to adjust the logic to be consistent with the
> change of usage_counter, that is to say, only after the counter has
> been possibly modified, we record it. Besides, all usage changes will
> be shown using rpm_usage even if included by other trace points.
> And these changes has helped track down the e1000e runtime issue.
>
> Reviewed-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
>  drivers/base/power/runtime.c | 38 +++++++++++++++++++++++-------------
>  1 file changed, 24 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index 85a248e196ca..5789d2624513 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -1004,10 +1004,11 @@ int __pm_runtime_idle(struct device *dev, int rpmflags)
>         int retval;
>
>         if (rpmflags & RPM_GET_PUT) {
> -               if (!atomic_dec_and_test(&dev->power.usage_count)) {
> -                       trace_rpm_usage_rcuidle(dev, rpmflags);
> +               bool non_zero = !atomic_dec_and_test(&dev->power.usage_count);
> +
> +               trace_rpm_usage_rcuidle(dev, rpmflags);

It looks like you could move the trace event before the atomic variable check.

The ordering between the two doesn't matter, because usage_count may
change between the check and the trace event anyway.

But then what is the trace event useful for in the first place?

> +               if (non_zero)
>                         return 0;
> -               }
>         }
>
>         might_sleep_if(!(rpmflags & RPM_ASYNC) && !dev->power.irq_safe);
> @@ -1038,10 +1039,12 @@ int __pm_runtime_suspend(struct device *dev, int rpmflags)
>         int retval;
>
>         if (rpmflags & RPM_GET_PUT) {
> -               if (!atomic_dec_and_test(&dev->power.usage_count)) {
> -                       trace_rpm_usage_rcuidle(dev, rpmflags);
> +               bool non_zero = !atomic_dec_and_test(&dev->power.usage_count);
> +
> +               trace_rpm_usage_rcuidle(dev, rpmflags);

And the same comments apply here.

> +               if (non_zero)
>                         return 0;
> -               }
> +
>         }
>
>         might_sleep_if(!(rpmflags & RPM_ASYNC) && !dev->power.irq_safe);
> @@ -1073,8 +1076,10 @@ int __pm_runtime_resume(struct device *dev, int rpmflags)
>         might_sleep_if(!(rpmflags & RPM_ASYNC) && !dev->power.irq_safe &&
>                         dev->power.runtime_status != RPM_ACTIVE);
>
> -       if (rpmflags & RPM_GET_PUT)
> +       if (rpmflags & RPM_GET_PUT) {
>                 atomic_inc(&dev->power.usage_count);

So the reason why things like that don't work is because the atomic
variable can change again between the inc and the trace event.

> +               trace_rpm_usage_rcuidle(dev, rpmflags);
> +       }
>
>         spin_lock_irqsave(&dev->power.lock, flags);
>         retval = rpm_resume(dev, rpmflags);
> @@ -1433,6 +1438,7 @@ void pm_runtime_forbid(struct device *dev)
>
>         dev->power.runtime_auto = false;
>         atomic_inc(&dev->power.usage_count);

Analogously here.

> +       trace_rpm_usage_rcuidle(dev, 0);
>         rpm_resume(dev, 0);
>
>   out:
> @@ -1448,16 +1454,17 @@ EXPORT_SYMBOL_GPL(pm_runtime_forbid);
>   */
>  void pm_runtime_allow(struct device *dev)
>  {
> +       bool is_zero;
> +
>         spin_lock_irq(&dev->power.lock);
>         if (dev->power.runtime_auto)
>                 goto out;
>
>         dev->power.runtime_auto = true;
> -       if (atomic_dec_and_test(&dev->power.usage_count))
> +       is_zero = atomic_dec_and_test(&dev->power.usage_count);
> +       trace_rpm_usage_rcuidle(dev, RPM_AUTO | RPM_ASYNC);
> +       if (is_zero)
>                 rpm_idle(dev, RPM_AUTO | RPM_ASYNC);
> -       else
> -               trace_rpm_usage_rcuidle(dev, RPM_AUTO | RPM_ASYNC);

The change of ordering is pointless for the reasons outlined above.

And so on.

> -
>   out:
>         spin_unlock_irq(&dev->power.lock);
>  }
> @@ -1523,9 +1530,8 @@ static void update_autosuspend(struct device *dev, int old_delay, int old_use)
>                 /* If it used to be allowed then prevent it. */
>                 if (!old_use || old_delay >= 0) {
>                         atomic_inc(&dev->power.usage_count);
> -                       rpm_resume(dev, 0);
> -               } else {
>                         trace_rpm_usage_rcuidle(dev, 0);
> +                       rpm_resume(dev, 0);
>                 }
>         }
>
> @@ -1533,8 +1539,10 @@ static void update_autosuspend(struct device *dev, int old_delay, int old_use)
>         else {
>
>                 /* If it used to be prevented then allow it. */
> -               if (old_use && old_delay < 0)
> +               if (old_use && old_delay < 0) {
>                         atomic_dec(&dev->power.usage_count);
> +                       trace_rpm_usage_rcuidle(dev, 0);
> +               }
>
>                 /* Maybe we can autosuspend now. */
>                 rpm_idle(dev, RPM_AUTO);
> @@ -1741,12 +1749,14 @@ void pm_runtime_drop_link(struct device *dev)
>  void pm_runtime_get_noresume(struct device *dev)
>  {
>         atomic_inc(&dev->power.usage_count);
> +       trace_rpm_usage_rcuidle(dev, 0);
>  }

This actually kind of makes sense, as a matter of tracing the
pm_runtime_get_noresume() usage, but not as a matter of tracing the
atomic variable value.

>  EXPORT_SYMBOL_GPL(pm_runtime_get_noresume);
>
>  void pm_runtime_put_noidle(struct device *dev)
>  {
>         atomic_add_unless(&dev->power.usage_count, -1, 0);
> +       trace_rpm_usage_rcuidle(dev, 0);
>  }
>  EXPORT_SYMBOL_GPL(pm_runtime_put_noidle);
>
> --

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3355139055
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2020 12:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728689AbgAMLpk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jan 2020 06:45:40 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40771 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbgAMLpk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jan 2020 06:45:40 -0500
Received: by mail-ot1-f67.google.com with SMTP id w21so8624270otj.7;
        Mon, 13 Jan 2020 03:45:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WunI6mk4pmK/ShQ0y2XYQNmAEGKYY8aPuYK3+E8KjOo=;
        b=MXjxWOr9BCfVqppiwyIwizs4bY2TlTjEJjeHPueOTaSjkz5Ib2M250ndvg8JpuRHtv
         iJ9QWpKnCaaHGUFNRNQDJmrZCIvcZeGuz+2OFaP8gxV9gxTtzGlSX/TDPkFwk6tIvsc8
         yKBkNY4OIn0yiZ6N03hbRXOt161KjjvHh7pQED1T7Aly3H643R6aV2VtsWcGpV00i3jR
         R1eybdRmWXd3hKnvxQTARE3E9qVpc4GLhabNIycw/Y5KSG6dsgHiHxSS9ddMrEBWG92l
         PrUaE/Cbc2fBV4/4q0Lc0qQ7hu6tf7h92HG5YK7Pn47g4xx/hvOsw/6/raHO4ys6un+k
         B8Qw==
X-Gm-Message-State: APjAAAU78iQUcrTw17cIwrS4k1pvyTbzLkg4/J5TGUK/0ohzz71JTdXu
        3EYVO8kehDKjH49LgAFC7aiQJPwC2J0vcsC6H/Y=
X-Google-Smtp-Source: APXvYqwE3K/KnAY4PHlsIHtQQsuExd3cxSB5V2Y7/wwG9BJLJQDNgzmur6hFT73EjaNHd5NpCR9LAZ8+HXafga+OIN0=
X-Received: by 2002:a05:6830:1e67:: with SMTP id m7mr12962729otr.262.1578915938616;
 Mon, 13 Jan 2020 03:45:38 -0800 (PST)
MIME-Version: 1.0
References: <d34ad8b1-8c0a-99d9-dc3e-319600c0bc39@freesources.org>
In-Reply-To: <d34ad8b1-8c0a-99d9-dc3e-319600c0bc39@freesources.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 13 Jan 2020 12:45:27 +0100
Message-ID: <CAJZ5v0gFJ09rLU4JRsf49wTRu-6dPMV67ZCTkGi1J7VJVMhrZQ@mail.gmail.com>
Subject: Re: [PATCH v2] PM: Add a switch for disabling/enabling sync() before suspend
To:     Jonas Meurer <jonas@freesources.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Tim Dittler <tim.dittler@systemli.org>,
        Yannik Sembritzki <yannik@sembritzki.me>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Dec 20, 2019 at 5:03 PM Jonas Meurer <jonas@freesources.org> wrote:
>
> The switch allows to enable or disable the final sync() from the suspend.c
> Linux Kernel system suspend implementation. This is useful to avoid race
> conditions if block devices have been suspended before. Be aware that you
> have to take care of sync() yourself before suspending the system if you
> disable it here.
>
> Congruously, the behaviour of build-time switch CONFIG_SUSPEND_SKIP_SYNC
> is slightly changed: It now configures the default for fun-time switch
> '/sys/power/sync_on_suspend'.
>
> Signed-off-by: Jonas Meurer <jonas@freesources.org>

First, I would use a slightly different subject.  What about "PM:
suspend: Add sysfs attribute to control the "sync on suspend"
behavior"?

Then, I would write in the changelog that whether or not filesystems
are synced before system suspend by the kernel depends on a Kconfig
option which is not flexible enough, because there are cases in which
user space may want to decide whether or not the sync in the kernel
should be carried out.

Actually, in the example case given by you, it is not clear enough why
you cannot build the kernel with CONFIG_SUSPEND_SKIP_SYNC set, so it
would be good to explain that.  Or give a different example.

Then I would say that the existing CONFIG_SUSPEND_SKIP_SYNC will be
used to set the default value of the new sysfs attribute after the
patch.

> ---
>  Documentation/ABI/testing/sysfs-power | 15 ++++++++++++
>  include/linux/suspend.h               |  2 ++
>  kernel/power/Kconfig                  |  5 +++-
>  kernel/power/main.c                   | 33 +++++++++++++++++++++++++++
>  kernel/power/suspend.c                |  2 +-
>  5 files changed, 55 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-power b/Documentation/ABI/testing/sysfs-power
> index 6f87b9dd384b..783b3ce8eb06 100644
> --- a/Documentation/ABI/testing/sysfs-power
> +++ b/Documentation/ABI/testing/sysfs-power
> @@ -407,3 +407,18 @@ Contact:   Kalesh Singh <kaleshsingh96@gmail.com>
>  Description:
>                 The /sys/power/suspend_stats/last_failed_step file contains
>                 the last failed step in the suspend/resume path.
> +
> +What:          /sys/power/sync_on_suspend
> +Date:          October 2019
> +Contact:       Jonas Meurer <jonas@freesources.org>
> +Description:
> +               This file controls the switch to enable or disable the final
> +               sync() before system suspend. This is useful to avoid race
> +               conditions if block devices have been suspended before. Be
> +               aware that you have to take care of sync() yourself before
> +               suspending the system if you disable it here.

I'm not entirely happy with the paragraph above.

It basically doesn't have to explain what the feature is useful for,
but if you waht to give an example, I would write something like this:

"This file controls whether or not the kernel will sync() filesystems
during system suspend (after freezing user space and before suspending
devices).  For example, user space may want to prevent the kernel from
syncing filesystems at that time in cases when system suspend works
reliably and is carried out relatively often, so doing a system-wide
filesystem sync every time it happens is not really useful."


> +
> +               Writing a "1" to this file enables the sync() and writing a
> +               "0" disables it. Reads from the file return the current value.
> +               The default is "1" but can be configured with the build-time
> +               config flag "SUSPEND_SKIP_SYNC".
> diff --git a/include/linux/suspend.h b/include/linux/suspend.h
> index 6fc8843f1c9e..4a230c2f1c31 100644
> --- a/include/linux/suspend.h
> +++ b/include/linux/suspend.h
> @@ -329,6 +329,7 @@ extern void arch_suspend_disable_irqs(void);
>  extern void arch_suspend_enable_irqs(void);
>
>  extern int pm_suspend(suspend_state_t state);
> +extern bool sync_on_suspend_enabled;
>  #else /* !CONFIG_SUSPEND */
>  #define suspend_valid_only_mem NULL
>
> @@ -342,6 +343,7 @@ static inline bool pm_suspend_default_s2idle(void) { return false; }
>
>  static inline void suspend_set_ops(const struct platform_suspend_ops *ops) {}
>  static inline int pm_suspend(suspend_state_t state) { return -ENOSYS; }
> +static inline bool sync_on_suspend_enabled(void) { return true; }
>  static inline bool idle_should_enter_s2idle(void) { return false; }
>  static inline void __init pm_states_init(void) {}
>  static inline void s2idle_set_ops(const struct platform_s2idle_ops *ops) {}
> diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
> index d3667b4075c1..7cbfbeacd68a 100644
> --- a/kernel/power/Kconfig
> +++ b/kernel/power/Kconfig
> @@ -27,7 +27,10 @@ config SUSPEND_SKIP_SYNC
>           Skip the kernel sys_sync() before freezing user processes.
>           Some systems prefer not to pay this cost on every invocation
>           of suspend, or they are content with invoking sync() from
> -         user-space before invoking suspend.  Say Y if that's your case.
> +         user-space before invoking suspend.  There's a run-time switch
> +         at '/sys/power/sync_on_suspend' to configure this behaviour.
> +         This setting changes the default for the run-tim switch. Say Y
> +         to change the default to disable the kernel sys_sync().
>
>  config HIBERNATE_CALLBACKS
>         bool
> diff --git a/kernel/power/main.c b/kernel/power/main.c
> index e26de7af520b..69b7a8aeca3b 100644
> --- a/kernel/power/main.c
> +++ b/kernel/power/main.c
> @@ -190,6 +190,38 @@ static ssize_t mem_sleep_store(struct kobject *kobj, struct kobj_attribute *attr
>  }
>
>  power_attr(mem_sleep);
> +
> +/*
> + * sync_on_suspend: invoke ksys_sync_helper() before suspend.
> + *
> + * show() returns whether ksys_sync_helper() is invoked before suspend.
> + * store() accepts 0 or 1.  0 disables ksys_sync_helper() and 1 enables it.
> + */
> +bool sync_on_suspend_enabled = !IS_ENABLED(CONFIG_SUSPEND_SKIP_SYNC);
> +
> +static ssize_t sync_on_suspend_show(struct kobject *kobj,
> +                                  struct kobj_attribute *attr, char *buf)
> +{
> +       return sprintf(buf, "%d\n", sync_on_suspend_enabled);
> +}
> +
> +static ssize_t sync_on_suspend_store(struct kobject *kobj,
> +                                   struct kobj_attribute *attr,
> +                                   const char *buf, size_t n)
> +{
> +       unsigned long val;
> +
> +       if (kstrtoul(buf, 10, &val))
> +               return -EINVAL;
> +
> +       if (val > 1)
> +               return -EINVAL;
> +
> +       sync_on_suspend_enabled = !!val;
> +       return n;
> +}
> +
> +power_attr(sync_on_suspend);
>  #endif /* CONFIG_SUSPEND */
>
>  #ifdef CONFIG_PM_SLEEP_DEBUG
> @@ -855,6 +887,7 @@ static struct attribute * g[] = {
>         &wakeup_count_attr.attr,
>  #ifdef CONFIG_SUSPEND
>         &mem_sleep_attr.attr,
> +       &sync_on_suspend_attr.attr,
>  #endif
>  #ifdef CONFIG_PM_AUTOSLEEP
>         &autosleep_attr.attr,
> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> index f3b7239f1892..2c47280fbfc7 100644
> --- a/kernel/power/suspend.c
> +++ b/kernel/power/suspend.c
> @@ -564,7 +564,7 @@ static int enter_state(suspend_state_t state)
>         if (state == PM_SUSPEND_TO_IDLE)
>                 s2idle_begin();
>
> -       if (!IS_ENABLED(CONFIG_SUSPEND_SKIP_SYNC)) {
> +       if (sync_on_suspend_enabled) {
>                 trace_suspend_resume(TPS("sync_filesystems"), 0, true);
>                 ksys_sync_helper();
>                 trace_suspend_resume(TPS("sync_filesystems"), 0, false);
> --

The patch itself looks fine to me.

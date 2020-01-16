Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 960C613FADA
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2020 21:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732532AbgAPUtR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Jan 2020 15:49:17 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39822 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbgAPUtR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Jan 2020 15:49:17 -0500
Received: by mail-ot1-f67.google.com with SMTP id 77so20669303oty.6;
        Thu, 16 Jan 2020 12:49:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vKWl+i3G1M08ggLIoH2gqIF2689K3Ew0LiOCmwmp/BI=;
        b=V9DyBpcccxtdBuEvMM+gi23TlnE/zd39fu6tgJhBHxAETFCwGAz/26cvswfCC/udCm
         PlA5tl5ZZ45FUzLuR1OdnQ5Fwh3OqHgsfF4evsa9JaUiUlEGO6HLPPj/G/WxA0OMM6f4
         vtJDEOB7cRNB1jTKFdHJPoliy1221zn5LuwOqsTUKzmfYh/OFA7YNeJc2oHuWRFnJOIG
         uOJA0BlJUeI+IExCQHsc9oSThntENzckiNuUB080n662LC/BsyWbDf9SpKaYnGzG5Gcc
         CpUlFcgpi8Cchjhk97ARSPExjfdXCwtKnXh0UPanM4zkVSg/dT43Cm+U4MjqV2UBIRtL
         XB7g==
X-Gm-Message-State: APjAAAUp1fkcnVTic37ZgZpSbeBcA+ixLmoORz/YbcGe57KGZQwV292T
        PFoCTxCqCVcZx3wMY/O/aGOfikiM8fIFfwIDzwgF+g==
X-Google-Smtp-Source: APXvYqzOLGos6s7Y71H1AklWTE2f09vz51ZGotacxjlP/Wsz27QuqtXTiEwUKaZ5USsXu+cAuD5Ns2IP/BanfxOXYCQ=
X-Received: by 2002:a05:6830:4b9:: with SMTP id l25mr3602980otd.266.1579207755629;
 Thu, 16 Jan 2020 12:49:15 -0800 (PST)
MIME-Version: 1.0
References: <d05a1c0c-1212-17f4-3772-042e2ff76a40@freesources.org>
In-Reply-To: <d05a1c0c-1212-17f4-3772-042e2ff76a40@freesources.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 16 Jan 2020 21:49:05 +0100
Message-ID: <CAJZ5v0gXMkL8Z_=jUvNGoVjDr4s5osO8RNekJ1yg-b+=zi7GSw@mail.gmail.com>
Subject: Re: [PATCH v3] PM: suspend: Add sysfs attribute to control the "sync
 on suspend" behavior
To:     Jonas Meurer <jonas@freesources.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Tim Dittler <tim.dittler@systemli.org>,
        Yannik Sembritzki <yannik@sembritzki.me>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jan 16, 2020 at 12:53 PM Jonas Meurer <jonas@freesources.org> wrote:
>
> The sysfs attribute `/sys/power/sync_on_suspend` controls, whether or not
> filesystems are synced by the kernel before system suspend.
>
> Congruously, the behaviour of build-time switch CONFIG_SUSPEND_SKIP_SYNC
> is slightly changed: It now defines the run-tim default for the new sysfs
> attribute `/sys/power/sync_on_suspend`.
>
> The run-time attribute is added because the existing corresponding
> build-time Kconfig flag for (`CONFIG_SUSPEND_SKIP_SYNC`) is not flexible
> enough. E.g. Linux distributions that provide pre-compiled kernels
> usually want to stick with the default (sync filesystems before suspend)
> but under special conditions this needs to be changed.
>
> One example for such a special condition is user-space handling of
> suspending block devices (e.g. using `cryptsetup luksSuspend` or `dmsetup
> suspend`) before system suspend. The Kernel trying to sync filesystems
> after the underlying block device already got suspended obviously leads
> to dead-locks. Be aware that you have to take care of the filesystem sync
> yourself before suspending the system in those scenarios.
>
> Signed-off-by: Jonas Meurer <jonas@freesources.org>

Applied as 5.6 material with minor changes in the ABI document, thanks!

> ---
>  Documentation/ABI/testing/sysfs-power | 13 +++++++++++
>  include/linux/suspend.h               |  2 ++
>  kernel/power/Kconfig                  |  5 +++-
>  kernel/power/main.c                   | 33 +++++++++++++++++++++++++++
>  kernel/power/suspend.c                |  2 +-
>  5 files changed, 53 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-power b/Documentation/ABI/testing/sysfs-power
> index 6f87b9dd384b..9392a83afce8 100644
> --- a/Documentation/ABI/testing/sysfs-power
> +++ b/Documentation/ABI/testing/sysfs-power
> @@ -407,3 +407,16 @@ Contact:   Kalesh Singh <kaleshsingh96@gmail.com>
>  Description:
>                 The /sys/power/suspend_stats/last_failed_step file contains
>                 the last failed step in the suspend/resume path.
> +
> +What:          /sys/power/sync_on_suspend
> +Date:          October 2019
> +Contact:       Jonas Meurer <jonas@freesources.org>
> +Description:
> +               This file controls whether or not the kernel will sync()
> +               filesystems during system suspend (after freezing user space
> +               and before suspending devices).
> +
> +               Writing a "1" to this file enables the sync() and writing a
> +               "0" disables it.  Reads from the file return the current value.
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
> 2.20.1
>

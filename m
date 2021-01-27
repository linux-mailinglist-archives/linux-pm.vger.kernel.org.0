Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCC7305F5E
	for <lists+linux-pm@lfdr.de>; Wed, 27 Jan 2021 16:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343550AbhA0PTd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Jan 2021 10:19:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:60046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343806AbhA0PSx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 27 Jan 2021 10:18:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2CFD0207DE;
        Wed, 27 Jan 2021 15:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611760692;
        bh=YbhKYTQ1WyrYd9bmtSUpMjiR8QZruUCpWktopF7wXZI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=18xyOmayPLDfv4OWEDhiEjGHfKL2fm3kjh6kX1VuKc/ndvHoGYkr7zaXHrwsO+ep5
         Lr/ZbVehnFzhsmxrDBabsGVK5OQEWoWvVDuHG+i6WEHn1t/g36MGDWdxMjIjmUb+Qt
         JYICRENUq9Qxa34cP7V6TErHKA3K2cFNCMyytmSU=
Date:   Wed, 27 Jan 2021 16:18:10 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Joseph Jang <josephjang@google.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        "David S . Miller " <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        jonglin@google.com, woodylin@google.com, markcheng@google.com
Subject: Re: [PATCH v5] power: suspend: Move dpm_watchdog to suspend.c and
 enhance it
Message-ID: <YBGEMnn2CAUwFZvd@kroah.com>
References: <20210108055111.931543-1-josephjang@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210108055111.931543-1-josephjang@google.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jan 08, 2021 at 01:51:11PM +0800, Joseph Jang wrote:
> Since dpm_watchdog just cover two functions __device_suspend() and
> device_resume(), we proposed to move it to core power suspend.c to extend
> its coverage and monitor more devices suspend hand issues.
> 
> We propose to use new name suspend watchdog and new timeout handler to
> cover more sleep hang issues. The new timeout handler will dump disk
> sleep task call trace at first round timeout and trigger kernel panic
> at second round timeout.
> The default timer for each round is defined in
> CONFIG_PM_SUSPEND_WATCHDOG_TIMEOUT.
> 
> Signed-off-by: Joseph Jang <josephjang@google.com>
> ---
> Changes since v4:
>  - Change #define PM_SUSPEND_WATCHDOG to CONFIG_PM_SUSPEND_WATCHDOG in suspend_watchdog.c
>    to make sure we compile all suspend watchdog functions.
>  - Add suspend watchdog functions declared in suspend_watchdog.h to prevent compile errors.
> 
> Changes since v3:
>  - Change the naming from sleep timer to suspend watchdog.
>  - Remove console_is_suspended() from console.h and printk.c
>  - Add static declaration for suspend_watchdog struct since we use it in suspend.c only.
>  - Move suspend watchdog real logic to suspend_watchdog.c.
>  - Put the function prototypes in suspend_watchdog.h
>  - Use inline functions for function prototypes definition.
> 
> Changes since v2:
>  - Add kernel/power/suspend_timer.h in MAINTAINERS
>  - Share some corner cases that dpm_watchdog cannot cover.
>   Case#A: dpm_watchdog cannot cover suspend hang in suspend_enter().
>   File: kernel/power/suspend.c
>   int suspend_devices_and_enter(suspend_state_t state)
>   {
>    ... <SNIP>
> 
>          suspend_test_start();
>          error = dpm_suspend_start(PMSG_SUSPEND);  <== dpm_watchdog will be enabled/disabled in this fucntion ...
>          if (error) {
>                  pr_err("Some devices failed to suspend, or early wake event detected\n");
>                  goto Recover_platform;
>          }
>          suspend_test_finish("suspend devices");
>          if (suspend_test(TEST_DEVICES))
>                  goto Recover_platform;
> 
>          do {
>                  error = suspend_enter(state, &wakeup);  <== but we encounter hang inside function suspend_enter() ...
>          } while (!error && !wakeup && platform_suspend_again(state));
> 
>   Case#B: dpm_watchdog cannot cover resume hang in dpm_resume_early() because it enable/disable in device_resume().
>   Call trace:
>    __switch_to+0x174/0x194
>    __schedule+0xa60/0x1464
>    __cancel_work_timer+0x120/0x234
>    chg_pm_resume+0x2c/0xd8
>    dpm_run_callback+0x27c/0x624
>    device_resume_early+0x1e4/0x1f8
>    dpm_resume_early+0x350/0x8f4
>    suspend_devices_and_enter+0xffc/0x168c
>    pm_suspend+0xb54/0xdac
> 
>   File: drivers/base/power/main.c.
>   static int device_resume(struct device *dev, pm_message_t state, bool async)
>       if (!dpm_wait_for_superior(dev, async))
>           goto Complete;
>   
>       dpm_watchdog_set(&wd, dev);
>       device_lock(dev);
>   
>       /*
>    ... <SNIP>
>  
>       Unlock:
>           device_unlock(dev);
>           dpm_watchdog_clear(&wd);
> 
>   Case#C: dpm_watchdog cannot cover suspend hang in ksys_sync().
>    Call trace:
>     __switch_to+0x1b0/0x1cc
>     __schedule+0xac8/0x1314
>     io_schedule+0x94/0xc8
>     wait_on_page_bit+0x1f8/0x3a4
>     __filemap_fdatawait_range+0x134/0x150
>     sync_inodes_sb+0x368/0x584
>     sync_inodes_one_sb+0x18/0x24
>     iterate_supers+0x12c/0x2b8
>     ksys_sync+0x48/0x12c
>     enter_state+0x294/0x7bc
>     pm_suspend+0x164/0x2a8
> 
>  - Explain some enhancement by following.
>   Q1: Why not use the existing one?
>   struct dpm_watchdog {
>       struct device           *dev;
>       struct task_struct      *tsk;
>       struct timer_list       timer;
>   };
>   
>   A1: In kernel/power/suspend.c, we don't have "struct device " because suspend.c is for core PM instead of device PM.
>   So we propose to use sleep_timer struct.
>   
>   struct sleep_timer {
>       struct task_struct	*tsk;
>       struct timer_list	timer;
>   };
>   
>   
>   Q2: Why not use stack memory for timer struct?
>   static void dpm_watchdog_set(struct dpm_watchdog *wd, struct device *dev)
>   {
>       ... <SNIP>  
>       timer_setup_on_stack(timer, dpm_watchdog_handler, 0);  <== dpm_watchdog use stack memory for timer struct.
>       /* use same timeout value for both suspend and resume */
>       timer->expires = jiffies + HZ * CONFIG_DPM_WATCHDOG_TIMEOUT;
>       add_timer(timer);
>   }
>   
>   A2: dpm_watchdog use stack memory has limitation.
>   It cannot support starting watchdog at end of function like s2idle_enter().
>   We cannot use stack memory for this case because the timer struct will be free when go back to caller.
>   
>   File: kernel/power/suspend.c
>   static void s2idle_enter(void)
>     {
>           trace_suspend_resume(TPS("machine_suspend"), PM_SUSPEND_TO_IDLE, true);
>   
>   +       stop_sleep_timer(&st);
>   +
>           raw_spin_lock_irq(&s2idle_lock);
>           if (pm_wakeup_pending())
>                   goto out;
>   ... <SNIP>
>           s2idle_state = S2IDLE_STATE_NONE;
>           raw_spin_unlock_irq(&s2idle_lock);
>   
>   +       start_sleep_timer(&st);
>   +
>           trace_suspend_resume(TPS("machine_suspend"), PM_SUSPEND_TO_IDLE, false);
>     }
>   
>   So we propose to declare a global sleep timer struct in suspend.c like following.
>   
>   File: kernel/power/suspend.c
>    static DEFINE_RAW_SPINLOCK(s2idle_lock);
>    
>   +DECLARE_SLEEP_TIMER(st);
>   +
>    /**
>     * pm_suspend_default_s2idle - Check if suspend-to-idle is the default suspend.
>   
>   Using global timer has another advantage is we could support double calling add_timer()
>   because add_timer() can easily to delete pending timer and add new timer by using the
>   same timer struct.
> 
>   Q3: Why do you need to change the timeout handler?
>   A3: dpm_watchdog_handler() need device struct to get device information, but suspend.c doesn't have it.
>   In most of cases, we could know which device driver hang by tracing the suspend thread call stack logs
>   without device struct information for debugging. So we propose to remove device struct and related
>   information like "dev_driver_string(wd->dev)" and "dev_name(wd->dev)" from timeout handler.
>   
>    static void dpm_watchdog_handler(struct timer_list *t)
>    {
>        struct dpm_watchdog *wd = from_timer(wd, t, timer);
>   
>        dev_emerg(wd->dev, "**** DPM device timeout ****\n");
>        show_stack(wd->tsk, NULL, KERN_EMERG);
>        panic("%s %s: unrecoverable failure\n",
>            dev_driver_string(wd->dev), dev_name(wd->dev));  <== we don't need it.
>    }
>   
>    We propose to dump all disk sleep tasks call stack log twice to double confirm suspend thread hang at
>    the same function and make sure other sleep tasks were stuck at the same function for a long time.
>    We also try to resume conole if the console is suspended.
>    At the end of watchdog timeout handler, we propose to trigger kernel panic to prevent system hang like
>    dpm_watchdog.
>   
>   
>   static void sleep_timeout_handler(struct timer_list *t)
>   {
>       struct sleep_timer *st = from_timer(st, t, timer);
>       static int timeout_count;
>   
>       pr_info("Sleep timeout (timer is %d seconds)\n",
>           (CONFIG_PM_SLEEP_TIMER_TIMEOUT));
>       show_stack(st->tsk, NULL, KERN_EMERG);
>       show_state_filter(TASK_UNINTERRUPTIBLE);
>   
>       if (timeout_count < 1) {
>           timeout_count++;
>           start_sleep_timer(st);
>           return;
>       }
>   
>       if (console_is_suspended())
>           resume_console();
>   
>       panic("Sleep timeout and panic\n");
>   }
> 
> Changes since v1:
>   - Add commit message to explain why move dpm_watchdog to kernel/power/suspend.c.
>   - Remove dpm_watchdog related functions in drivers/base/power/main.c.
>   - Move suspend_timer.h from include/linux/ to kernel/power/.
> ---
>  MAINTAINERS                     |  4 ++
>  drivers/base/power/main.c       | 69 ---------------------------
>  kernel/power/Kconfig            | 27 +++++------
>  kernel/power/Makefile           |  1 +
>  kernel/power/suspend.c          | 19 ++++++++
>  kernel/power/suspend_watchdog.c | 84 +++++++++++++++++++++++++++++++++
>  kernel/power/suspend_watchdog.h | 40 ++++++++++++++++
>  kernel/printk/printk.c          |  2 +-
>  8 files changed, 162 insertions(+), 84 deletions(-)
>  create mode 100644 kernel/power/suspend_watchdog.c
>  create mode 100644 kernel/power/suspend_watchdog.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 867157311dc8..ecd988b4a838 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7788,6 +7788,8 @@ F:	include/linux/freezer.h
>  F:	include/linux/pm.h
>  F:	include/linux/suspend.h
>  F:	kernel/power/
> +F:	kernel/power/suspend_watchdog.c
> +F:	kernel/power/suspend_watchdog.h
>  
>  HID CORE LAYER
>  M:	Jiri Kosina <jikos@kernel.org>
> @@ -16630,6 +16632,8 @@ F:	include/linux/freezer.h
>  F:	include/linux/pm.h
>  F:	include/linux/suspend.h
>  F:	kernel/power/
> +F:	kernel/power/suspend_watchdog.c
> +F:	kernel/power/suspend_watchdog.h

As you are now asking other people to maintain the code that you just
added, you will need to get their signed-off-by on this patch before I
can do anything with it.

thanks,

greg k-h

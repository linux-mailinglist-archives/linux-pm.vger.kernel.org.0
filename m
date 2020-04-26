Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89F061B9196
	for <lists+linux-pm@lfdr.de>; Sun, 26 Apr 2020 18:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbgDZQQb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 26 Apr 2020 12:16:31 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:65420 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbgDZQQb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 26 Apr 2020 12:16:31 -0400
Received: from 185.80.35.16 (185.80.35.16) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id 0961821f1edc6ea1; Sun, 26 Apr 2020 18:16:29 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Domenico Andreoli <domenico.andreoli@linux.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 2/2] uswsusp: build only when configured
Date:   Sun, 26 Apr 2020 18:16:29 +0200
Message-ID: <4068729.AMvo8hvaBI@kreacher>
In-Reply-To: <20200413193718.956985775@gmail.com>
References: <20200413190843.044112674@gmail.com> <20200413193718.956985775@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Monday, April 13, 2020 9:08:45 PM CEST Domenico Andreoli wrote:
> From: Domenico Andreoli <domenico.andreoli@linux.com>
> 
> uswsusp is no longer the preferred way to suspend/hibernate and the
> userspace tools have not received any update in years.
> 
> Make it possible to enable the uswsusp support only if needed, prepare
> for future phase out.
> 
> Signed-off-by: Domenico Andreoli <domenico.andreoli@linux.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Linux PM <linux-pm@vger.kernel.org>
> 
> ---
>  kernel/power/Kconfig  |    5 +++++
>  kernel/power/Makefile |    3 ++-
>  kernel/power/power.h  |    5 +++++
>  3 files changed, 12 insertions(+), 1 deletion(-)
> 
> Index: b/kernel/power/Kconfig
> ===================================================================
> --- a/kernel/power/Kconfig
> +++ b/kernel/power/Kconfig
> @@ -80,6 +80,11 @@ config HIBERNATION
>  
>  	  For more information take a look at <file:Documentation/power/swsusp.rst>.
>  
> +config HIBERNATION_USER
> +	bool "Userspace software suspend interface (DEPRECATED)"
> +	depends on HIBERNATION
> +	default n

This needs to be "default y" for the time being.

Also, I would call the option HIBERNATION_SNAPSHOT_DEV, because it effectively
controls whether or not the snapshot device is available.

> +
>  config PM_STD_PARTITION
>  	string "Default resume partition"
>  	depends on HIBERNATION
> Index: b/kernel/power/Makefile
> ===================================================================
> --- a/kernel/power/Makefile
> +++ b/kernel/power/Makefile
> @@ -10,7 +10,8 @@ obj-$(CONFIG_VT_CONSOLE_SLEEP)	+= consol
>  obj-$(CONFIG_FREEZER)		+= process.o
>  obj-$(CONFIG_SUSPEND)		+= suspend.o
>  obj-$(CONFIG_PM_TEST_SUSPEND)	+= suspend_test.o
> -obj-$(CONFIG_HIBERNATION)	+= hibernate.o snapshot.o swap.o user.o
> +obj-$(CONFIG_HIBERNATION)	+= hibernate.o snapshot.o swap.o
> +obj-$(CONFIG_HIBERNATION_USER)	+= user.o
>  obj-$(CONFIG_PM_AUTOSLEEP)	+= autosleep.o
>  obj-$(CONFIG_PM_WAKELOCKS)	+= wakelock.o
>  
> Index: b/kernel/power/power.h
> ===================================================================
> --- a/kernel/power/power.h
> +++ b/kernel/power/power.h
> @@ -158,8 +158,13 @@ extern sector_t alloc_swapdev_block(int
>  extern void free_all_swap_pages(int swap);
>  extern int swsusp_swap_in_use(void);
>  
> +#ifdef CONFIG_HIBERNATION_USER
>  bool swsusp_try_enter(void);
>  void swsusp_leave(void);
> +#else
> +static inline bool swsusp_try_enter(void) { return 1; }
> +static inline void swsusp_leave(void) {}
> +#endif

It is possible in theory that two processes write "disk" to /sys/power/state
concurrently.

Is there enough mutual exclusion in place to handle this gracefully after the
above change?

>  
>  /*
>   * Flags that can be passed from the hibernatig hernel to the "boot" kernel in
> 
> 





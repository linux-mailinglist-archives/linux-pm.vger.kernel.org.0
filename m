Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61B8D1B9127
	for <lists+linux-pm@lfdr.de>; Sun, 26 Apr 2020 17:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbgDZPZB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 26 Apr 2020 11:25:01 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:49150 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgDZPZB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 26 Apr 2020 11:25:01 -0400
Received: from 185.80.35.16 (185.80.35.16) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id 4bbe76b27600f444; Sun, 26 Apr 2020 17:24:59 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Todd E Brandt <todd.e.brandt@linux.intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] Revert "cpu/hotplug: Ignore pm_wakeup_pending() for disable_nonboot_cpus()"
Date:   Sun, 26 Apr 2020 17:24:58 +0200
Message-ID: <26038947.HFycnDbHsR@kreacher>
In-Reply-To: <20200409112742.3581-1-qais.yousef@arm.com>
References: <20200409112742.3581-1-qais.yousef@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thursday, April 9, 2020 1:27:40 PM CEST Qais Yousef wrote:
> This issue was fixed already by:
> 
> commit d66b16f5df4b ("arm64: Don't use disable_nonboot_cpus()")
> commit dddf3578e0d4 ("ARM: Don't use disable_nonboot_cpus()")
> 
> The only caller of disable_nonboot_cpus() is x86, which is in a proper
> suspend/resume path and due to the reverted patch lost its ability to
> early abort due to a pending wakeup.
> 
> The fix that is being reverted is arguably a better one to backport to
> stable trees. But it highlights the confusion about using
> disable_nonboot_cpus() API.
> 
> This is a preparation to remove disable_nonboot_cpus() in favor of
> freeze_secondary_cpus().
> 
> This reverts commit e98eac6ff1b45e4e73f2e6031b37c256ccb5d36b.
> 
> Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> CC: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> CC: Len Brown <len.brown@intel.com>
> CC: Pavel Machek <pavel@ucw.cz>
> CC: Ingo Molnar <mingo@redhat.com>
> CC: Borislav Petkov <bp@alien8.de>
> CC: "H. Peter Anvin" <hpa@zytor.com>
> CC: x86@kernel.org
> CC: Todd E Brandt <todd.e.brandt@linux.intel.com>
> CC: linux-pm@vger.kernel.org
> CC: linux-kernel@vger.kernel.org
> ---
>  include/linux/cpu.h | 12 +++---------
>  kernel/cpu.c        |  4 ++--
>  2 files changed, 5 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/cpu.h b/include/linux/cpu.h
> index beaed2dc269e..9ead281157d3 100644
> --- a/include/linux/cpu.h
> +++ b/include/linux/cpu.h
> @@ -144,18 +144,12 @@ static inline void get_online_cpus(void) { cpus_read_lock(); }
>  static inline void put_online_cpus(void) { cpus_read_unlock(); }
>  
>  #ifdef CONFIG_PM_SLEEP_SMP
> -int __freeze_secondary_cpus(int primary, bool suspend);
> -static inline int freeze_secondary_cpus(int primary)
> -{
> -	return __freeze_secondary_cpus(primary, true);
> -}
> -
> +extern int freeze_secondary_cpus(int primary);
>  static inline int disable_nonboot_cpus(void)
>  {
> -	return __freeze_secondary_cpus(0, false);
> +	return freeze_secondary_cpus(0);
>  }
> -
> -void enable_nonboot_cpus(void);
> +extern void enable_nonboot_cpus(void);
>  
>  static inline int suspend_disable_secondary_cpus(void)
>  {
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 12ae636e9cb6..30848496cbc7 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -1327,7 +1327,7 @@ void bringup_nonboot_cpus(unsigned int setup_max_cpus)
>  #ifdef CONFIG_PM_SLEEP_SMP
>  static cpumask_var_t frozen_cpus;
>  
> -int __freeze_secondary_cpus(int primary, bool suspend)
> +int freeze_secondary_cpus(int primary)
>  {
>  	int cpu, error = 0;
>  
> @@ -1352,7 +1352,7 @@ int __freeze_secondary_cpus(int primary, bool suspend)
>  		if (cpu == primary)
>  			continue;
>  
> -		if (suspend && pm_wakeup_pending()) {
> +		if (pm_wakeup_pending()) {
>  			pr_info("Wakeup pending. Abort CPU freeze\n");
>  			error = -EBUSY;
>  			break;
> 

I would do this the other way around:

1. Make x86 call freeze_secondary_cpus() directly, rename
   enable_nonboot_cpus() and drop disable_nonboot_cpus().
2. Get rid of __freeze_secondary_cpus().




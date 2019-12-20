Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83097127849
	for <lists+linux-pm@lfdr.de>; Fri, 20 Dec 2019 10:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbfLTJfU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 Dec 2019 04:35:20 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:45391 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727205AbfLTJfT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 Dec 2019 04:35:19 -0500
Received: from 79.184.253.1.ipv4.supernova.orange.pl (79.184.253.1) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.320)
 id 648bf26c0baafb8f; Fri, 20 Dec 2019 10:35:16 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Jonas Meurer <jonas@freesources.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Tim Dittler <tim.dittler@systemli.org>,
        Yannik Sembritzki <yannik@sembritzki.me>
Subject: Re: [PATCH 2/2] PM: CONFIG_SUSPEND_SKIP_SYNC sets default for, '/sys/power/sync_on_suspend'
Date:   Fri, 20 Dec 2019 10:35:16 +0100
Message-ID: <5078963.9SuZRVoKLz@kreacher>
In-Reply-To: <5c3996e1-eee7-1b8f-51bf-a6401d229bff@freesources.org>
References: <1ee5b9ef-f30e-3fde-2325-ba516a96ced5@freesources.org> <5c3996e1-eee7-1b8f-51bf-a6401d229bff@freesources.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Monday, December 2, 2019 6:07:43 PM CET Jonas Meurer wrote:
> Slightly change the behaviour of build-time switch CONFIG_SUSPEND_SKIP_SYNC:
> Make it configure the default for '/sys/power/sync_on_suspend', now that we
> have a run-time switch for it.
> 
> Signed-off-by: Jonas Meurer <jonas@freesources.org>
> ---
>  Documentation/ABI/testing/sysfs-power | 7 ++++---
>  kernel/power/Kconfig                  | 5 ++++-
>  kernel/power/main.c                   | 2 +-
>  kernel/power/suspend.c                | 2 +-
>  4 files changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-power b/Documentation/ABI/testing/sysfs-power
> index f164a364e89a..783b3ce8eb06 100644
> --- a/Documentation/ABI/testing/sysfs-power
> +++ b/Documentation/ABI/testing/sysfs-power
> @@ -418,6 +418,7 @@ Description:
>  		aware that you have to take care of sync() yourself before
>  		suspending the system if you disable it here.
>  
> -		Writing a "1" (default) to this file enables the sync() and
> -		writing a "0" disables it. Reads from the file return the
> -		current value.
> +		Writing a "1" to this file enables the sync() and writing a
> +		"0" disables it. Reads from the file return the current value.
> +		The default is "1" but can be configured with the build-time
> +		config flag "SUSPEND_SKIP_SYNC".
> diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
> index d3667b4075c1..7cbfbeacd68a 100644
> --- a/kernel/power/Kconfig
> +++ b/kernel/power/Kconfig
> @@ -27,7 +27,10 @@ config SUSPEND_SKIP_SYNC
>  	  Skip the kernel sys_sync() before freezing user processes.
>  	  Some systems prefer not to pay this cost on every invocation
>  	  of suspend, or they are content with invoking sync() from
> -	  user-space before invoking suspend.  Say Y if that's your case.
> +	  user-space before invoking suspend.  There's a run-time switch
> +	  at '/sys/power/sync_on_suspend' to configure this behaviour.
> +	  This setting changes the default for the run-tim switch. Say Y
> +	  to change the default to disable the kernel sys_sync().
>  
>  config HIBERNATE_CALLBACKS
>  	bool
> diff --git a/kernel/power/main.c b/kernel/power/main.c
> index 7d9d579a8e6f..69b7a8aeca3b 100644
> --- a/kernel/power/main.c
> +++ b/kernel/power/main.c
> @@ -197,7 +197,7 @@ power_attr(mem_sleep);
>   * show() returns whether ksys_sync_helper() is invoked before suspend.
>   * store() accepts 0 or 1.  0 disables ksys_sync_helper() and 1 enables it.
>   */
> -bool sync_on_suspend_enabled = true;
> +bool sync_on_suspend_enabled = !IS_ENABLED(CONFIG_SUSPEND_SKIP_SYNC);
>  
>  static ssize_t sync_on_suspend_show(struct kobject *kobj,
>  				   struct kobj_attribute *attr, char *buf)
> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> index 503d56419a69..2c47280fbfc7 100644
> --- a/kernel/power/suspend.c
> +++ b/kernel/power/suspend.c
> @@ -564,7 +564,7 @@ static int enter_state(suspend_state_t state)
>  	if (state == PM_SUSPEND_TO_IDLE)
>  		s2idle_begin();
>  
> -	if (!IS_ENABLED(CONFIG_SUSPEND_SKIP_SYNC) && sync_on_suspend_enabled) {
> +	if (sync_on_suspend_enabled) {
>  		trace_suspend_resume(TPS("sync_filesystems"), 0, true);
>  		ksys_sync_helper();
>  		trace_suspend_resume(TPS("sync_filesystems"), 0, false);
> 

I don't see much value in splitting the changes into two patches.
On the contrary, this patch is a logical part of the full change, so IMO
it should be folded into the [1/2].

Please do so and resubmit.

Thanks!




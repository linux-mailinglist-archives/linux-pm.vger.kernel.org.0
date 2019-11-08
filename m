Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93932F459D
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2019 12:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730221AbfKHLW2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 Nov 2019 06:22:28 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:47120 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbfKHLW2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 Nov 2019 06:22:28 -0500
Received: from 79.184.254.83.ipv4.supernova.orange.pl (79.184.254.83) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id 7b93b3f4ee9f5846; Fri, 8 Nov 2019 12:22:26 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Ikjoon Jang <ikjn@chromium.org>
Cc:     linux-pm@vger.kernel.org, "Pavel Machek )" <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH RESEND] cpuidle: undelaying cpuidle in dpm_{suspend|resume}()
Date:   Fri, 08 Nov 2019 12:22:25 +0100
Message-ID: <2576101.gjqMWB6DaV@kreacher>
In-Reply-To: <20191030022105.223213-1-ikjn@chromium.org>
References: <20191030022105.223213-1-ikjn@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wednesday, October 30, 2019 3:21:05 AM CET Ikjoon Jang wrote:
> cpuidle is paused only during dpm_suspend_noirq() ~ dpm_resume_noirq().
> But some device drivers need random sized IOs in dpm_{suspend|resume}()
> stage (e.g. re-downloading firmware in resume).
> And with such a device, cpuidle's latencies could be critical to
> response time of system suspend/resume.
> 
> To minimize those latencies, we could apply pm_qos to such device drivers,
> but simply undelaying cpuidle from dpm_suspend_noirq() to dpm suspend()
> seems no harm.

While the patch is generally acceptable, the changelog is not.

First, what does "undelying" mean?

Second, you seem to be talking about the cases in which exit latencies of
idle states are not small relative to the system suspend/resume time, so
without any specific examples this is not really convincing.

Also, potentially, there is another reason to make this change, which is
that on some systems i2c (or similar) controllers may be requisite for
idle state entry and exit, so it may make sense in general to prevent
cpuidle from being used over the entire suspend and resume of the
system.  However, without any example of a system in which that matters
it still is not convincing enough IMO.

> Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
> ---
>  drivers/base/power/main.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index 134a8af51511..5928dd2139e8 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -773,8 +773,6 @@ void dpm_resume_noirq(pm_message_t state)
>  
>  	resume_device_irqs();
>  	device_wakeup_disarm_wake_irqs();
> -
> -	cpuidle_resume();
>  }
>  
>  static pm_callback_t dpm_subsys_resume_early_cb(struct device *dev,
> @@ -1069,6 +1067,7 @@ void dpm_resume(pm_message_t state)
>  
>  	cpufreq_resume();
>  	devfreq_resume();
> +	cpuidle_resume();
>  	trace_suspend_resume(TPS("dpm_resume"), state.event, false);
>  }
>  
> @@ -1411,8 +1410,6 @@ int dpm_suspend_noirq(pm_message_t state)
>  {
>  	int ret;
>  
> -	cpuidle_pause();
> -
>  	device_wakeup_arm_wake_irqs();
>  	suspend_device_irqs();
>  
> @@ -1830,6 +1827,7 @@ int dpm_suspend(pm_message_t state)
>  	trace_suspend_resume(TPS("dpm_suspend"), state.event, true);
>  	might_sleep();
>  
> +	cpuidle_pause();
>  	devfreq_suspend();
>  	cpufreq_suspend();
>  
> 





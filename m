Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 919AA3B1D56
	for <lists+linux-pm@lfdr.de>; Wed, 23 Jun 2021 17:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbhFWPPV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Jun 2021 11:15:21 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:48620 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbhFWPPV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Jun 2021 11:15:21 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 2.1.0)
 id 79ccbd21b1696034; Wed, 23 Jun 2021 17:13:02 +0200
Received: from kreacher.localnet (89-64-80-57.dynamic.chello.pl [89.64.80.57])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 52FB9669A62;
        Wed, 23 Jun 2021 17:13:01 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 2/4] cpufreq: intel_pstate: Migrate to ->offline() instead of ->stop_cpu()
Date:   Wed, 23 Jun 2021 17:13:00 +0200
Message-ID: <5741915.lOV4Wx5bFT@kreacher>
In-Reply-To: <6144911f36d3d1f5faddf81d744bd39946843f6b.1624421816.git.viresh.kumar@linaro.org>
References: <cover.1624421816.git.viresh.kumar@linaro.org> <6144911f36d3d1f5faddf81d744bd39946843f6b.1624421816.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 89.64.80.57
X-CLIENT-HOSTNAME: 89-64-80-57.dynamic.chello.pl
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrfeegfedgkeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeetgefgleetgeduheeugeeikeevudelueelvdeufeejfeffgeefjedugfetfeehhfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeekledrieegrdektddrheejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepkeelrdeigedrkedtrdehjedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedprhgtphhtthhopehvihhrvghshhdrkhhumhgrrheslhhinhgrrhhordhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehlvghnsgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
 vhhinhgtvghnthdrghhuihhtthhotheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wednesday, June 23, 2021 6:24:40 AM CEST Viresh Kumar wrote:
> commit 367dc4aa932b ("cpufreq: Add stop CPU callback to cpufreq_driver
> interface") added the stop_cpu() callback to allow the drivers to do
> clean up before the CPU is completely down and its state can't be
> modified.
> 
> At that time the CPU hotplug framework used to call the cpufreq core's
> registered notifier for different events like CPU_DOWN_PREPARE and
> CPU_POST_DEAD. The stop_cpu() callback was called during the
> CPU_DOWN_PREPARE event.
> 
> This is no longer the case, cpuhp_cpufreq_offline() is called only once
> by the CPU hotplug core now and we don't really need to separately
> call stop_cpu() for cpufreq drivers.
> 
> Migrate to using the offline() callbacks instead of stop_cpu().
> 
> Cc: Dirk Brandewie <dirk.brandewie@gmail.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/intel_pstate.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 0e69dffd5a76..b4c0ff7f5b71 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -2335,6 +2335,8 @@ static int intel_pstate_cpu_offline(struct cpufreq_policy *policy)
>  
>  	pr_debug("CPU %d going offline\n", cpu->cpu);
>  
> +	intel_pstate_clear_update_util_hook(policy->cpu);

As mentioned already in

https://lore.kernel.org/linux-pm/CAJZ5v0g2tCZptcqh+c55YYiO7rDHmZivMLsmpq_7005zNPN1xg@mail.gmail.com/

this isn't particularly clean, because intel_pstate_cpu_offline() is
also used in the passive mode where the above call is not needed.

I would make a change like in the patch below instead.

> +
>  	if (cpu->suspended)
>  		return 0;

---
From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH] cpufreq: intel_pstate: Combine ->stop_cpu() and ->offline()

Combine the ->stop_cpu() and ->offline() callback routines for the
active mode of intel_pstate so as to avoid setting the ->stop_cpu
callback pointer which is going to be dropped from the framework.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -2577,11 +2577,13 @@ static int intel_pstate_cpu_online(struc
 	return 0;
 }
 
-static void intel_pstate_stop_cpu(struct cpufreq_policy *policy)
+static int intel_pstate_stop_cpu(struct cpufreq_policy *policy)
 {
 	pr_debug("CPU %d stopping\n", policy->cpu);
 
 	intel_pstate_clear_update_util_hook(policy->cpu);
+
+	return intel_pstate_cpu_offline(policy);
 }
 
 static int intel_pstate_cpu_exit(struct cpufreq_policy *policy)
@@ -2654,8 +2656,7 @@ static struct cpufreq_driver intel_pstat
 	.resume		= intel_pstate_resume,
 	.init		= intel_pstate_cpu_init,
 	.exit		= intel_pstate_cpu_exit,
-	.stop_cpu	= intel_pstate_stop_cpu,
-	.offline	= intel_pstate_cpu_offline,
+	.offline	= intel_pstate_stop_cpu,
 	.online		= intel_pstate_cpu_online,
 	.update_limits	= intel_pstate_update_limits,
 	.name		= "intel_pstate",




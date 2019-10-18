Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52A3ADC2B1
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2019 12:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405250AbfJRKWM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Oct 2019 06:22:12 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:61869 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728989AbfJRKWM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 18 Oct 2019 06:22:12 -0400
Received: from 79.184.255.51.ipv4.supernova.orange.pl (79.184.255.51) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id 6ce2739a0f04cd0d; Fri, 18 Oct 2019 12:22:10 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        sudeep.holla@arm.com, bjorn.andersson@linaro.org,
        edubezval@gmail.com, agross@kernel.org, tdas@codeaurora.org,
        swboyd@chromium.org, ilina@codeaurora.org,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Ben Segall <bsegall@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 3/6] cpufreq: Initialise the governors in core_initcall
Date:   Fri, 18 Oct 2019 12:22:09 +0200
Message-ID: <1627245.O3FKD7HvXP@kreacher>
In-Reply-To: <aa02366951fb174077a945761a7cda03d08acab5.1571387352.git.amit.kucheria@linaro.org>
References: <cover.1571387352.git.amit.kucheria@linaro.org> <aa02366951fb174077a945761a7cda03d08acab5.1571387352.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Friday, October 18, 2019 10:52:00 AM CEST Amit Kucheria wrote:
> Initialise the cpufreq governors earlier to allow for earlier
> performance control during the boot process.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

No more issues found, so

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/cpufreq/cpufreq_conservative.c | 2 +-
>  drivers/cpufreq/cpufreq_ondemand.c     | 2 +-
>  drivers/cpufreq/cpufreq_performance.c  | 2 +-
>  drivers/cpufreq/cpufreq_powersave.c    | 2 +-
>  drivers/cpufreq/cpufreq_userspace.c    | 2 +-
>  kernel/sched/cpufreq_schedutil.c       | 2 +-
>  6 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
> index b66e81c06a575..737ff3b9c2c09 100644
> --- a/drivers/cpufreq/cpufreq_conservative.c
> +++ b/drivers/cpufreq/cpufreq_conservative.c
> @@ -346,7 +346,7 @@ struct cpufreq_governor *cpufreq_default_governor(void)
>  	return CPU_FREQ_GOV_CONSERVATIVE;
>  }
>  
> -fs_initcall(cpufreq_gov_dbs_init);
> +core_initcall(cpufreq_gov_dbs_init);
>  #else
>  module_init(cpufreq_gov_dbs_init);
>  #endif
> diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
> index dced033875bf8..82a4d37ddecb3 100644
> --- a/drivers/cpufreq/cpufreq_ondemand.c
> +++ b/drivers/cpufreq/cpufreq_ondemand.c
> @@ -483,7 +483,7 @@ struct cpufreq_governor *cpufreq_default_governor(void)
>  	return CPU_FREQ_GOV_ONDEMAND;
>  }
>  
> -fs_initcall(cpufreq_gov_dbs_init);
> +core_initcall(cpufreq_gov_dbs_init);
>  #else
>  module_init(cpufreq_gov_dbs_init);
>  #endif
> diff --git a/drivers/cpufreq/cpufreq_performance.c b/drivers/cpufreq/cpufreq_performance.c
> index aaa04dfcacd9d..def9afe0f5b86 100644
> --- a/drivers/cpufreq/cpufreq_performance.c
> +++ b/drivers/cpufreq/cpufreq_performance.c
> @@ -50,5 +50,5 @@ MODULE_AUTHOR("Dominik Brodowski <linux@brodo.de>");
>  MODULE_DESCRIPTION("CPUfreq policy governor 'performance'");
>  MODULE_LICENSE("GPL");
>  
> -fs_initcall(cpufreq_gov_performance_init);
> +core_initcall(cpufreq_gov_performance_init);
>  module_exit(cpufreq_gov_performance_exit);
> diff --git a/drivers/cpufreq/cpufreq_powersave.c b/drivers/cpufreq/cpufreq_powersave.c
> index c143dc237d878..1ae66019eb835 100644
> --- a/drivers/cpufreq/cpufreq_powersave.c
> +++ b/drivers/cpufreq/cpufreq_powersave.c
> @@ -43,7 +43,7 @@ struct cpufreq_governor *cpufreq_default_governor(void)
>  	return &cpufreq_gov_powersave;
>  }
>  
> -fs_initcall(cpufreq_gov_powersave_init);
> +core_initcall(cpufreq_gov_powersave_init);
>  #else
>  module_init(cpufreq_gov_powersave_init);
>  #endif
> diff --git a/drivers/cpufreq/cpufreq_userspace.c b/drivers/cpufreq/cpufreq_userspace.c
> index cbd81c58cb8f0..b43e7cd502c58 100644
> --- a/drivers/cpufreq/cpufreq_userspace.c
> +++ b/drivers/cpufreq/cpufreq_userspace.c
> @@ -147,7 +147,7 @@ struct cpufreq_governor *cpufreq_default_governor(void)
>  	return &cpufreq_gov_userspace;
>  }
>  
> -fs_initcall(cpufreq_gov_userspace_init);
> +core_initcall(cpufreq_gov_userspace_init);
>  #else
>  module_init(cpufreq_gov_userspace_init);
>  #endif
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 86800b4d5453f..322ca8860f548 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -915,7 +915,7 @@ static int __init sugov_register(void)
>  {
>  	return cpufreq_register_governor(&schedutil_gov);
>  }
> -fs_initcall(sugov_register);
> +core_initcall(sugov_register);
>  
>  #ifdef CONFIG_ENERGY_MODEL
>  extern bool sched_energy_update;
> 





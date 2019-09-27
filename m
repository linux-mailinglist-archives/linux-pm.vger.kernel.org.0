Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AEEBC0160
	for <lists+linux-pm@lfdr.de>; Fri, 27 Sep 2019 10:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726029AbfI0Imt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 27 Sep 2019 04:42:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:47874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbfI0Imt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 27 Sep 2019 04:42:49 -0400
Received: from oasis.local.home (unknown [65.39.69.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4EDD2075D;
        Fri, 27 Sep 2019 08:42:44 +0000 (UTC)
Date:   Fri, 27 Sep 2019 04:42:39 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Douglas Anderson <dianders@chromium.org>,
        linux-pm@vger.kernel.org, Amit Kucheria <amit.kucheria@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] PM / Domains: Add tracepoints
Message-ID: <20190927044239.589e7c4c@oasis.local.home>
In-Reply-To: <20190926150406.v1.1.I07a769ad7b00376777c9815fb169322cde7b9171@changeid>
References: <20190926150406.v1.1.I07a769ad7b00376777c9815fb169322cde7b9171@changeid>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 26 Sep 2019 15:04:38 -0700
Matthias Kaehlcke <mka@chromium.org> wrote:

> Define genpd_power_on/off and genpd_set_performance_state
> tracepoints and use them.

I agree with Greg about adding a "why" you need this. But, in case
there's a good reason to have this, I have comments about the code
below.

> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> 
>  drivers/base/power/domain.c  | 27 +++++++++++++++++---
>  include/trace/events/power.h | 49 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 72 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index cc85e87eaf05..aee988c112e5 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -21,6 +21,7 @@
>  #include <linux/suspend.h>
>  #include <linux/export.h>
>  #include <linux/cpu.h>
> +#include <trace/events/power.h>
>  
>  #include "power.h"
>  
> @@ -329,6 +330,9 @@ static int _genpd_set_performance_state(struct generic_pm_domain *genpd,
>  		goto err;
>  
>  	genpd->performance_state = state;
> +
> +	trace_genpd_set_performance_state(genpd);
> +
>  	return 0;
>  
>  err:
> @@ -418,14 +422,21 @@ static int _genpd_power_on(struct generic_pm_domain *genpd, bool timed)
>  	if (!genpd->power_on)
>  		return 0;
>  
> -	if (!timed)
> -		return genpd->power_on(genpd);
> +	if (!timed) {
> +		ret = genpd->power_on(genpd);
> +		if (!ret)
> +			trace_genpd_power_on(genpd);
> +
> +		return ret;
> +	}
>  
>  	time_start = ktime_get();
>  	ret = genpd->power_on(genpd);
>  	if (ret)
>  		return ret;
>  
> +	trace_genpd_power_on(genpd);
> +
>  	elapsed_ns = ktime_to_ns(ktime_sub(ktime_get(), time_start));
>  	if (elapsed_ns <= genpd->states[state_idx].power_on_latency_ns)
>  		return ret;
> @@ -448,14 +459,22 @@ static int _genpd_power_off(struct generic_pm_domain *genpd, bool timed)
>  	if (!genpd->power_off)
>  		return 0;
>  
> -	if (!timed)
> -		return genpd->power_off(genpd);
> +	if (!timed) {
> +		ret = genpd->power_off(genpd);
> +		if (!ret)

Here

> +			trace_genpd_power_off(genpd);
> +
> +		return ret;
> +	}
>  
>  	time_start = ktime_get();
>  	ret = genpd->power_off(genpd);
>  	if (ret)
>  		return ret;
>  
> +	if (!ret)

And here add a conditional branch for only a tracepoint. To eliminate
the branch when tracepoints are not enabled, please do it this way
instead:

	if (trace_genpd_power_off_enabled() && !ret)

The above is a static branch (nop when disabled, and jmp when enabled),
and the above should move the conditional branch on !ret into the
section that is only called when the tracepoint is enabled.


> +		trace_genpd_power_off(genpd);
> +

-- Steve

>  	elapsed_ns = ktime_to_ns(ktime_sub(ktime_get(), time_start));
>  	if (elapsed_ns <= genpd->states[state_idx].power_off_latency_ns)
>  		return 0;
> diff --git a/include/trace/events/power.h b/include/trace/events/power.h
> index 7457e238e1b7..de56cd1e8d0d 100644
> --- a/include/trace/events/power.h
> +++ b/include/trace/events/power.h
> @@ -7,6 +7,7 @@
>  
>  #include <linux/cpufreq.h>
>  #include <linux/ktime.h>
> +#include <linux/pm_domain.h>
>  #include <linux/pm_qos.h>
>  #include <linux/tracepoint.h>
>  #include <linux/trace_events.h>
> @@ -525,6 +526,54 @@ DEFINE_EVENT(dev_pm_qos_request, dev_pm_qos_remove_request,
>  
>  	TP_ARGS(name, type, new_value)
>  );
> +
> +#ifdef CONFIG_PM_GENERIC_DOMAINS
> +DECLARE_EVENT_CLASS(genpd_power_on_off,
> +	TP_PROTO(struct generic_pm_domain *genpd),
> +
> +	TP_ARGS(genpd),
> +
> +	TP_STRUCT__entry(
> +		__string(name, genpd->name)
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(name, genpd->name);
> +	),
> +
> +	TP_printk("name=%s", __get_str(name))
> +);
> +
> +DEFINE_EVENT(genpd_power_on_off, genpd_power_on,
> +	TP_PROTO(struct generic_pm_domain *genpd),
> +
> +	TP_ARGS(genpd)
> +);
> +
> +DEFINE_EVENT(genpd_power_on_off, genpd_power_off,
> +	TP_PROTO(struct generic_pm_domain *genpd),
> +
> +	TP_ARGS(genpd)
> +);
> +
> +TRACE_EVENT(genpd_set_performance_state,
> +	TP_PROTO(struct generic_pm_domain *genpd),
> +
> +	TP_ARGS(genpd),
> +
> +	TP_STRUCT__entry(
> +		__string(name, genpd->name)
> +		__field(unsigned int, state)
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(name, genpd->name);
> +		__entry->state = genpd->performance_state;
> +	),
> +
> +	TP_printk("name=%s state=%u", __get_str(name), __entry->state)
> +);
> +#endif /* CONFIG_PM_GENERIC_DOMAINS */
>  #endif /* _TRACE_POWER_H */
>  
>  /* This part must be outside protection */


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B899D18B13D
	for <lists+linux-pm@lfdr.de>; Thu, 19 Mar 2020 11:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbgCSK0C (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Mar 2020 06:26:02 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:61677 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbgCSK0C (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Mar 2020 06:26:02 -0400
Received: from 185.80.35.16 (185.80.35.16) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id 510ce22fdf9eb956; Thu, 19 Mar 2020 11:25:56 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Francisco Jerez <currojerez@riseup.net>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-pm@vger.kernel.org,
        intel-gfx@lists.freedesktop.org,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>
Subject: Re: [PATCHv2 01/10] PM: QoS: Add CPU_RESPONSE_FREQUENCY global PM QoS limit.
Date:   Thu, 19 Mar 2020 11:25:56 +0100
Message-ID: <6173226.NlFJlbPEpo@kreacher>
In-Reply-To: <20200311192319.13406-1-currojerez@riseup.net>
References: <87d09iae6f.fsf@riseup.net> <20200311192319.13406-1-currojerez@riseup.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wednesday, March 11, 2020 8:23:19 PM CET Francisco Jerez wrote:
> The purpose of this PM QoS limit is to give device drivers additional
> control over the latency/energy efficiency trade-off made by the PM
> subsystem (particularly the CPUFREQ governor).  It allows device
> drivers to set a lower bound on the response latency of PM (defined as
> the time it takes from wake-up to the CPU reaching a certain
> steady-state level of performance [e.g. the nominal frequency] in
> response to a step-function load).  It reports to PM the minimum
> ramp-up latency considered of use to the application, and explicitly
> requests PM to filter out oscillations faster than the specified
> frequency.  It is somewhat complementary to the current
> CPU_DMA_LATENCY PM QoS class which can be understood as specifying an
> upper latency bound on the CPU wake-up time, instead of a lower bound
> on the CPU frequency ramp-up time.
> 
> Note that even though this provides a latency constraint it's
> represented as its reciprocal in Hz units for computational efficiency
> (since it would take a 64-bit division to compute the number of cycles
> elapsed from a time increment in nanoseconds and a time bound, while a
> frequency can simply be multiplied with the time increment).
> 
> This implements a MAX constraint so that the strictest (highest
> response frequency) request is honored.  This means that PM won't
> provide any guarantee that frequencies greater than the specified
> bound will be filtered, since that might be incompatible with the
> constraints specified by another more latency-sensitive application (A
> more fine-grained result could be achieved with a scheduling-based
> interface).  The default value needs to be equal to zero (best effort)
> for it to behave as identity of the MAX operation.
> 
> v2: Drop wake_up_all_idle_cpus() call from
>     cpu_response_frequency_qos_apply() (Peter).
> 
> Signed-off-by: Francisco Jerez <currojerez@riseup.net>
> ---
>  include/linux/pm_qos.h       |   9 +++
>  include/trace/events/power.h |  33 +++++----
>  kernel/power/qos.c           | 138 ++++++++++++++++++++++++++++++++++-

First, the documentation (Documentation/power/pm_qos_interface.rst) needs to be
updated too to cover the new QoS category.

>  3 files changed, 162 insertions(+), 18 deletions(-)
> 
> diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
> index 4a69d4af3ff8..b522e2194c05 100644
> --- a/include/linux/pm_qos.h
> +++ b/include/linux/pm_qos.h
> @@ -28,6 +28,7 @@ enum pm_qos_flags_status {
>  #define PM_QOS_LATENCY_ANY_NS	((s64)PM_QOS_LATENCY_ANY * NSEC_PER_USEC)
>  
>  #define PM_QOS_CPU_LATENCY_DEFAULT_VALUE	(2000 * USEC_PER_SEC)
> +#define PM_QOS_CPU_RESPONSE_FREQUENCY_DEFAULT_VALUE 0

I would call this PM_QOS_CPU_SCALING_RESPONSE_DEFAULT_VALUE and all of the
API pieces accordingly.

>  #define PM_QOS_RESUME_LATENCY_DEFAULT_VALUE	PM_QOS_LATENCY_ANY
>  #define PM_QOS_RESUME_LATENCY_NO_CONSTRAINT	PM_QOS_LATENCY_ANY
>  #define PM_QOS_RESUME_LATENCY_NO_CONSTRAINT_NS	PM_QOS_LATENCY_ANY_NS
> @@ -162,6 +163,14 @@ static inline void cpu_latency_qos_update_request(struct pm_qos_request *req,
>  static inline void cpu_latency_qos_remove_request(struct pm_qos_request *req) {}
>  #endif
>  
> +s32 cpu_response_frequency_qos_limit(void);

For example

cpu_scaling_response_qos_limit()

> +bool cpu_response_frequency_qos_request_active(struct pm_qos_request *req);

cpu_scaling_response_qos_request_active()

and so on.

> +void cpu_response_frequency_qos_add_request(struct pm_qos_request *req,
> +					    s32 value);
> +void cpu_response_frequency_qos_update_request(struct pm_qos_request *req,
> +					       s32 new_value);
> +void cpu_response_frequency_qos_remove_request(struct pm_qos_request *req);
> +
>  #ifdef CONFIG_PM
>  enum pm_qos_flags_status __dev_pm_qos_flags(struct device *dev, s32 mask);
>  enum pm_qos_flags_status dev_pm_qos_flags(struct device *dev, s32 mask);
> diff --git a/include/trace/events/power.h b/include/trace/events/power.h
> index af5018aa9517..7e4b52e8ca3a 100644
> --- a/include/trace/events/power.h
> +++ b/include/trace/events/power.h
> @@ -359,45 +359,48 @@ DEFINE_EVENT(power_domain, power_domain_target,
>  );
>  
>  /*
> - * CPU latency QoS events used for global CPU latency QoS list updates
> + * CPU latency/response frequency QoS events used for global CPU PM
> + * QoS list updates.
>   */
> -DECLARE_EVENT_CLASS(cpu_latency_qos_request,
> +DECLARE_EVENT_CLASS(pm_qos_request,
>  
> -	TP_PROTO(s32 value),
> +	TP_PROTO(const char *name, s32 value),
>  
> -	TP_ARGS(value),
> +	TP_ARGS(name, value),
>  
>  	TP_STRUCT__entry(
> +		__string(name,			 name		)
>  		__field( s32,                    value          )
>  	),
>  
>  	TP_fast_assign(
> +		__assign_str(name, name);
>  		__entry->value = value;
>  	),
>  
> -	TP_printk("CPU_DMA_LATENCY value=%d",
> -		  __entry->value)
> +	TP_printk("pm_qos_class=%s value=%d",
> +		  __get_str(name), __entry->value)
>  );
>  
> -DEFINE_EVENT(cpu_latency_qos_request, pm_qos_add_request,
> +DEFINE_EVENT(pm_qos_request, pm_qos_add_request,
>  
> -	TP_PROTO(s32 value),
> +	TP_PROTO(const char *name, s32 value),
>  
> -	TP_ARGS(value)
> +	TP_ARGS(name, value)
>  );
>  
> -DEFINE_EVENT(cpu_latency_qos_request, pm_qos_update_request,
> +DEFINE_EVENT(pm_qos_request, pm_qos_update_request,
>  
> -	TP_PROTO(s32 value),
> +	TP_PROTO(const char *name, s32 value),
>  
> -	TP_ARGS(value)
> +	TP_ARGS(name, value)
>  );
>  
> -DEFINE_EVENT(cpu_latency_qos_request, pm_qos_remove_request,
> +DEFINE_EVENT(pm_qos_request, pm_qos_remove_request,
>  
> -	TP_PROTO(s32 value),
> +	TP_PROTO(const char *name, s32 value),
>  
> -	TP_ARGS(value)
> +	TP_ARGS(name, value)
>  );
>  
>  /*
> diff --git a/kernel/power/qos.c b/kernel/power/qos.c
> index 32927682bcc4..49f140aa5aa1 100644
> --- a/kernel/power/qos.c
> +++ b/kernel/power/qos.c
> @@ -271,7 +271,7 @@ void cpu_latency_qos_add_request(struct pm_qos_request *req, s32 value)
>  		return;
>  	}
>  
> -	trace_pm_qos_add_request(value);
> +	trace_pm_qos_add_request("CPU_DMA_LATENCY", value);
>  
>  	req->qos = &cpu_latency_constraints;
>  	cpu_latency_qos_apply(req, PM_QOS_ADD_REQ, value);
> @@ -297,7 +297,7 @@ void cpu_latency_qos_update_request(struct pm_qos_request *req, s32 new_value)
>  		return;
>  	}
>  
> -	trace_pm_qos_update_request(new_value);
> +	trace_pm_qos_update_request("CPU_DMA_LATENCY", new_value);
>  
>  	if (new_value == req->node.prio)
>  		return;
> @@ -323,7 +323,7 @@ void cpu_latency_qos_remove_request(struct pm_qos_request *req)
>  		return;
>  	}
>  
> -	trace_pm_qos_remove_request(PM_QOS_DEFAULT_VALUE);
> +	trace_pm_qos_remove_request("CPU_DMA_LATENCY", PM_QOS_DEFAULT_VALUE);
>  
>  	cpu_latency_qos_apply(req, PM_QOS_REMOVE_REQ, PM_QOS_DEFAULT_VALUE);
>  	memset(req, 0, sizeof(*req));
> @@ -424,6 +424,138 @@ static int __init cpu_latency_qos_init(void)
>  late_initcall(cpu_latency_qos_init);
>  #endif /* CONFIG_CPU_IDLE */
>  
> +/* Definitions related to the CPU response frequency QoS. */
> +
> +static struct pm_qos_constraints cpu_response_frequency_constraints = {
> +	.list = PLIST_HEAD_INIT(cpu_response_frequency_constraints.list),
> +	.target_value = PM_QOS_CPU_RESPONSE_FREQUENCY_DEFAULT_VALUE,
> +	.default_value = PM_QOS_CPU_RESPONSE_FREQUENCY_DEFAULT_VALUE,
> +	.no_constraint_value = PM_QOS_CPU_RESPONSE_FREQUENCY_DEFAULT_VALUE,
> +	.type = PM_QOS_MAX,
> +};
> +
> +/**
> + * cpu_response_frequency_qos_limit - Return current system-wide CPU
> + *				      response frequency QoS limit.
> + */
> +s32 cpu_response_frequency_qos_limit(void)
> +{
> +	return pm_qos_read_value(&cpu_response_frequency_constraints);
> +}
> +EXPORT_SYMBOL_GPL(cpu_response_frequency_qos_limit);
> +
> +/**
> + * cpu_response_frequency_qos_request_active - Check the given PM QoS request.
> + * @req: PM QoS request to check.
> + *
> + * Return: 'true' if @req has been added to the CPU response frequency
> + * QoS list, 'false' otherwise.
> + */
> +bool cpu_response_frequency_qos_request_active(struct pm_qos_request *req)
> +{
> +	return req->qos == &cpu_response_frequency_constraints;
> +}
> +EXPORT_SYMBOL_GPL(cpu_response_frequency_qos_request_active);
> +
> +static void cpu_response_frequency_qos_apply(struct pm_qos_request *req,
> +					     enum pm_qos_req_action action,
> +					     s32 value)
> +{
> +	pm_qos_update_target(req->qos, &req->node, action, value);
> +}
> +
> +/**
> + * cpu_response_frequency_qos_add_request - Add new CPU response
> + *					    frequency QoS request.
> + * @req: Pointer to a preallocated handle.
> + * @value: Requested constraint value.
> + *
> + * Use @value to initialize the request handle pointed to by @req,
> + * insert it as a new entry to the CPU response frequency QoS list and
> + * recompute the effective QoS constraint for that list.
> + *
> + * Callers need to save the handle for later use in updates and removal of the
> + * QoS request represented by it.
> + */
> +void cpu_response_frequency_qos_add_request(struct pm_qos_request *req,
> +					    s32 value)
> +{
> +	if (!req)
> +		return;
> +
> +	if (cpu_response_frequency_qos_request_active(req)) {
> +		WARN(1, KERN_ERR "%s called for already added request\n",
> +		     __func__);
> +		return;
> +	}
> +
> +	trace_pm_qos_add_request("CPU_RESPONSE_FREQUENCY", value);
> +
> +	req->qos = &cpu_response_frequency_constraints;
> +	cpu_response_frequency_qos_apply(req, PM_QOS_ADD_REQ, value);
> +}
> +EXPORT_SYMBOL_GPL(cpu_response_frequency_qos_add_request);
> +
> +/**
> + * cpu_response_frequency_qos_update_request - Modify existing CPU
> + *					       response frequency QoS
> + *					       request.
> + * @req : QoS request to update.
> + * @new_value: New requested constraint value.
> + *
> + * Use @new_value to update the QoS request represented by @req in the
> + * CPU response frequency QoS list along with updating the effective
> + * constraint value for that list.
> + */
> +void cpu_response_frequency_qos_update_request(struct pm_qos_request *req,
> +					       s32 new_value)
> +{
> +	if (!req)
> +		return;
> +
> +	if (!cpu_response_frequency_qos_request_active(req)) {
> +		WARN(1, KERN_ERR "%s called for unknown object\n", __func__);
> +		return;
> +	}
> +
> +	trace_pm_qos_update_request("CPU_RESPONSE_FREQUENCY", new_value);
> +
> +	if (new_value == req->node.prio)
> +		return;
> +
> +	cpu_response_frequency_qos_apply(req, PM_QOS_UPDATE_REQ, new_value);
> +}
> +EXPORT_SYMBOL_GPL(cpu_response_frequency_qos_update_request);
> +
> +/**
> + * cpu_response_frequency_qos_remove_request - Remove existing CPU
> + *					       response frequency QoS
> + *					       request.
> + * @req: QoS request to remove.
> + *
> + * Remove the CPU response frequency QoS request represented by @req
> + * from the CPU response frequency QoS list along with updating the
> + * effective constraint value for that list.
> + */
> +void cpu_response_frequency_qos_remove_request(struct pm_qos_request *req)
> +{
> +	if (!req)
> +		return;
> +
> +	if (!cpu_response_frequency_qos_request_active(req)) {
> +		WARN(1, KERN_ERR "%s called for unknown object\n", __func__);
> +		return;
> +	}
> +
> +	trace_pm_qos_remove_request("CPU_RESPONSE_FREQUENCY",
> +				    PM_QOS_DEFAULT_VALUE);
> +
> +	cpu_response_frequency_qos_apply(req, PM_QOS_REMOVE_REQ,
> +					 PM_QOS_DEFAULT_VALUE);
> +	memset(req, 0, sizeof(*req));
> +}
> +EXPORT_SYMBOL_GPL(cpu_response_frequency_qos_remove_request);
> +
>  /* Definitions related to the frequency QoS below. */
>  
>  /**
> 





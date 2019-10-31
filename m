Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2789EAD61
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2019 11:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbfJaKYg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 31 Oct 2019 06:24:36 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:52678 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbfJaKYg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 31 Oct 2019 06:24:36 -0400
Received: from 91.217.168.176 (91.217.168.176) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id c2cbb5481e9d89f0; Thu, 31 Oct 2019 11:24:33 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Saravana Kannan <saravanak@google.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Matthias Kaehlcke <mka@chromium.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] cpufreq: Add user_min/max_freq
Date:   Thu, 31 Oct 2019 11:24:31 +0100
Message-ID: <3169109.BFaCN5124U@kreacher>
In-Reply-To: <c222deda79ad334ff4edcbd49ddda248685c4ee1.1572395990.git.leonard.crestez@nxp.com>
References: <c222deda79ad334ff4edcbd49ddda248685c4ee1.1572395990.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wednesday, October 30, 2019 1:41:49 AM CET Leonard Crestez wrote:
> Current values in scaling_min_freq and scaling_max freq can change on
> the fly due to event such as thermal monitoring.

Which is intentional.

> This behavior is confusing for userspace and because once an userspace
> limit is written to scaling_min/max_freq it is not possible to read it back.

That can be argued both ways.

It is also useful to know the effective constraints and arguably the ability
to read back the values that you have written is mostly needed for debugging
the code.

Also arguably, if there are multiple sources of frequency limits in user space,
there needs to be a user space arbiter deciding on which value to use and in
that case it needs to store the last value chosen by it anyway.

> Introduce two new user_min/max_freq files which only contain the limits
> imposed by userspace, without any aggregation.

I'm not sure how useful that is except for the debugging use case to be honest.

Do you have any specific use cases beyond debugging in mind?

> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
> This was motivated by these discussions:
> 
> * https://patchwork.kernel.org/patch/11078475/#22805379
> * https://patchwork.kernel.org/patch/11171817/#22917099
> 
> Those threads are about devfreq but same issue applies to cpufreq as
> well. Let me know if this solution seems reasonable?
> 
> An alternative would be to make scaling_min/max_freq always read back
> the configured value and introduce new effective_min/max_freq files for
> the aggregate values. That might break existing users (though I'm not
> familiar with any).
> 
>  Documentation/admin-guide/pm/cpufreq.rst | 27 ++++++++++++++++++------
>  drivers/cpufreq/cpufreq.c                | 19 +++++++++++++++++
>  include/linux/pm_qos.h                   |  4 ++++
>  3 files changed, 44 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/admin-guide/pm/cpufreq.rst b/Documentation/admin-guide/pm/cpufreq.rst
> index 0c74a7784964..734c01c1040e 100644
> --- a/Documentation/admin-guide/pm/cpufreq.rst
> +++ b/Documentation/admin-guide/pm/cpufreq.rst
> @@ -309,21 +309,36 @@ are the following:
>  
>  ``scaling_max_freq``
>  	Maximum frequency the CPUs belonging to this policy are allowed to be
>  	running at (in kHz).
>  
> -	This attribute is read-write and writing a string representing an
> -	integer to it will cause a new limit to be set (it must not be lower
> -	than the value of the ``scaling_min_freq`` attribute).
> +	This attribute is read-write: writing an integer will set a new limit
> +	(just like ``user_max_freq``) while reading will show the current
> +	limit (potentially affected by other system contraints such as thermal
> +	throttling).
>  
>  ``scaling_min_freq``
>  	Minimum frequency the CPUs belonging to this policy are allowed to be
>  	running at (in kHz).
>  
> -	This attribute is read-write and writing a string representing a
> -	non-negative integer to it will cause a new limit to be set (it must not
> -	be higher than the value of the ``scaling_max_freq`` attribute).
> +	This attribute is read-write: writing an integer will set a new limit
> +	(just like ``user_min_freq``) while reading will show the current
> +	limit (potentially affected by other system contraints).
> +
> +``user_max_freq``
> +	Userspace contraint for the maximum frequency the CPUs belonging to
> +	this policy are allowed to be running at (in kHz).
> +
> +	This attribute is read-write: writing an integer will set a new limit
> +	and reading will show the last limit set by userspace.

Making these read-write is not useful IMO.  Make them read-only.

> +
> +``user_min_freq``
> +	Userspace contraint for minimum frequency the CPUs belonging to this
> +	policy are allowed to be running at (in kHz).
> +
> +	This attribute is read-write: writing an integer will set a new limit
> +	and reading will show the last limit set by userspace.
>  
>  ``scaling_setspeed``
>  	This attribute is functional only if the `userspace`_ scaling governor
>  	is attached to the given policy.
>  
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 48a224a6b178..caefed0dac43 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -722,13 +722,28 @@ static ssize_t store_##file_name					\
>  									\
>  	ret = freq_qos_update_request(policy->object##_freq_req, val);\
>  	return ret >= 0 ? count : ret;					\
>  }
>  
> +store_one(user_min_freq, min);
> +store_one(user_max_freq, max);
>  store_one(scaling_min_freq, min);
>  store_one(scaling_max_freq, max);

I don't agree with duplicating functionality like this.

>  
> +#undef show_one
> +
> +#define show_one(file_name, object)					\
> +static ssize_t show_##file_name						\
> +(struct cpufreq_policy *policy, char *buf)				\
> +{									\
> +	s32 val = freq_qos_get_request_value(policy->object##_freq_req);\
> +	return sprintf(buf, "%d\n", val);				\
> +}
> +
> +show_one(user_min_freq, min);
> +show_one(user_max_freq, max);
> +
>  /**
>   * show_cpuinfo_cur_freq - current CPU frequency as detected by hardware
>   */
>  static ssize_t show_cpuinfo_cur_freq(struct cpufreq_policy *policy,
>  					char *buf)
> @@ -906,10 +921,12 @@ cpufreq_freq_attr_ro(related_cpus);
>  cpufreq_freq_attr_ro(affected_cpus);
>  cpufreq_freq_attr_rw(scaling_min_freq);
>  cpufreq_freq_attr_rw(scaling_max_freq);
>  cpufreq_freq_attr_rw(scaling_governor);
>  cpufreq_freq_attr_rw(scaling_setspeed);
> +cpufreq_freq_attr_rw(user_min_freq);
> +cpufreq_freq_attr_rw(user_max_freq);
>  
>  static struct attribute *default_attrs[] = {
>  	&cpuinfo_min_freq.attr,
>  	&cpuinfo_max_freq.attr,
>  	&cpuinfo_transition_latency.attr,
> @@ -919,10 +936,12 @@ static struct attribute *default_attrs[] = {
>  	&related_cpus.attr,
>  	&scaling_governor.attr,
>  	&scaling_driver.attr,
>  	&scaling_available_governors.attr,
>  	&scaling_setspeed.attr,
> +	&user_min_freq.attr,
> +	&user_max_freq.attr,
>  	NULL
>  };
>  
>  #define to_policy(k) container_of(k, struct cpufreq_policy, kobj)
>  #define to_attr(a) container_of(a, struct freq_attr, attr)
> diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
> index e97c2e376889..90b147b7d7a3 100644
> --- a/include/linux/pm_qos.h
> +++ b/include/linux/pm_qos.h
> @@ -310,7 +310,11 @@ int freq_qos_add_notifier(struct freq_constraints *qos,
>  			  enum freq_qos_req_type type,
>  			  struct notifier_block *notifier);
>  int freq_qos_remove_notifier(struct freq_constraints *qos,
>  			     enum freq_qos_req_type type,
>  			     struct notifier_block *notifier);
> +static inline s32 freq_qos_get_request_value(struct freq_qos_request *req)
> +{
> +	return req->pnode.prio;
> +}
>  
>  #endif
> 





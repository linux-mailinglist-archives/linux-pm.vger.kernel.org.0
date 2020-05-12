Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE5F21CF377
	for <lists+linux-pm@lfdr.de>; Tue, 12 May 2020 13:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729436AbgELLix (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 May 2020 07:38:53 -0400
Received: from foss.arm.com ([217.140.110.172]:53022 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728085AbgELLix (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 12 May 2020 07:38:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D48E30E;
        Tue, 12 May 2020 04:38:52 -0700 (PDT)
Received: from [10.37.12.83] (unknown [10.37.12.83])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D9103F71E;
        Tue, 12 May 2020 04:38:42 -0700 (PDT)
Subject: Re: [PATCH v7 04/15] PM / EM: add support for other devices than CPUs
 in Energy Model
To:     Quentin Perret <qperret@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-imx@nxp.com, Dietmar.Eggemann@arm.com, cw00.choi@samsung.com,
        b.zolnierkie@samsung.com, rjw@rjwysocki.net, sudeep.holla@arm.com,
        viresh.kumar@linaro.org, nm@ti.com, sboyd@kernel.org,
        rui.zhang@intel.com, amit.kucheria@verdurent.com,
        daniel.lezcano@linaro.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        kernel@pengutronix.de, khilman@kernel.org, agross@kernel.org,
        bjorn.andersson@linaro.org, robh@kernel.org,
        matthias.bgg@gmail.com, steven.price@arm.com,
        tomeu.vizoso@collabora.com, alyssa.rosenzweig@collabora.com,
        airlied@linux.ie, daniel@ffwll.ch, liviu.dudau@arm.com,
        lorenzo.pieralisi@arm.com, patrick.bellasi@matbug.net,
        orjan.eide@arm.com, rdunlap@infradead.org, mka@chromium.org
References: <20200511111912.3001-1-lukasz.luba@arm.com>
 <20200511111912.3001-5-lukasz.luba@arm.com>
 <20200511134319.GA29112@google.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <270f3e37-8de8-2841-dca3-8d70089f7317@arm.com>
Date:   Tue, 12 May 2020 12:38:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200511134319.GA29112@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 5/11/20 2:43 PM, Quentin Perret wrote:
> Hey Lukasz,
> 
> On Monday 11 May 2020 at 12:19:01 (+0100), Lukasz Luba wrote:
> <snip>
>> @@ -27,12 +29,15 @@ struct em_perf_state {
>>    * em_perf_domain - Performance domain
>>    * @table:		List of performance states, in ascending order
>>    * @nr_perf_states:	Number of performance states
>> - * @cpus:		Cpumask covering the CPUs of the domain
>> + * @cpus:		Cpumask covering the CPUs of the domain. It's here
>> + *			for performance reasons to avoid potential cache
>> + *			misses during energy calculations in the scheduler
> 
> And because that saves a pointer, and simplifies allocating/freeing that
> memory region :)

True, I will add this also:
'and simplifies allocating/freeing that memory region'

> 
> <snip>
>> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
>> index 5b8a1566526a..9cc7f2973600 100644
>> --- a/kernel/power/energy_model.c
>> +++ b/kernel/power/energy_model.c
>> @@ -2,8 +2,9 @@
>>   /*
>>    * Energy Model of CPUs
> 
> Should this comment change too?

Yes, indeed. I will adjust it.

> 
> <snip>
>> -static void em_debug_create_pd(struct em_perf_domain *pd, int cpu)
>> +static void em_debug_create_pd(struct device *dev)
>>   {
>>   	struct dentry *d;
>> -	char name[8];
>>   	int i;
>>   
>> -	snprintf(name, sizeof(name), "pd%d", cpu);
>> -
>>   	/* Create the directory of the performance domain */
>> -	d = debugfs_create_dir(name, rootdir);
>> +	d = debugfs_create_dir(dev_name(dev), rootdir);
> 
> So what will be the name for the perf domain of CPUs now? cpuX?

yeap, it will be 'cpu0', 'cpu4', etc...

> 
> <snip>
>> @@ -142,8 +149,8 @@ em_create_pd(struct device *dev, int nr_states, struct em_data_callback *cb,
>>   		 */
>>   		opp_eff = freq / power;
>>   		if (opp_eff >= prev_opp_eff)
>> -			pr_warn("pd%d: hertz/watts ratio non-monotonically decreasing: em_perf_state %d >= em_perf_state%d\n",
>> -					cpu, i, i - 1);
>> +			dev_dbg(dev, "EM: hertz/watts ratio non-monotonically decreasing: em_perf_state %d >= em_perf_state%d\n",
>> +					i, i - 1);
> 
> It feels like changing from warn to debug doesn't really belong to this
> patch no?

I thought that these prints are not worth to introduce another patch.
This warning is a bit tricky, because we (SW eng) basically are not able
to tweak OPPs, we can only remove them to calm down this warning.

There are platforms, with dozen of OPPs, seeing this. Warnings triggers 
the automated tests scripts, which are sensitive to dmesg log level and
cause developers to spent time and investigate the issue.

Then, what if these OPPs are needed because the thermal was tested OK
with some OPPs which unfortunately are triggering also this warning.
They cannot remove these OPPS, but the warning would stay. We might see
this also for GPUs.

I decided to change it into dbg, due to the reason above.

> 
> <snip>
>> @@ -216,47 +274,50 @@ int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
>>   	 */
>>   	mutex_lock(&em_pd_mutex);
>>   
>> -	for_each_cpu(cpu, span) {
>> -		/* Make sure we don't register again an existing domain. */
>> -		if (READ_ONCE(per_cpu(em_data, cpu))) {
>> -			ret = -EEXIST;
>> -			goto unlock;
>> -		}
>> +	if (dev->em_pd) {
>> +		ret = -EEXIST;
>> +		goto unlock;
>> +	}
>>   
>> -		/*
>> -		 * All CPUs of a domain must have the same micro-architecture
>> -		 * since they all share the same table.
>> -		 */
>> -		cap = arch_scale_cpu_capacity(cpu);
>> -		if (prev_cap && prev_cap != cap) {
>> -			pr_err("CPUs of %*pbl must have the same capacity\n",
>> -							cpumask_pr_args(span));
>> +	if (_is_cpu_device(dev)) {
> 
> Something like
> 
> 	if (!_is_cpu_device(dev))
> 		goto device;
> 
> would limit the diff a bit, but that may just be personal taste.

Possible

> 
> But appart from these nits, the patch LGTM.

Thank you for the review.

I will wait for Daniel's (because he suggested the em_pd inside
device struct) comments and if there is no other issues I will just
resend the patch with adjusted comment fields in response.

Regards,
Lukasz

> 
> Thanks,
> Quentin
> 

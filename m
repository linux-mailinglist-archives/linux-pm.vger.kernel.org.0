Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 145FD1CF31C
	for <lists+linux-pm@lfdr.de>; Tue, 12 May 2020 13:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729506AbgELLLU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 May 2020 07:11:20 -0400
Received: from foss.arm.com ([217.140.110.172]:52600 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726891AbgELLLT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 12 May 2020 07:11:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C9E0930E;
        Tue, 12 May 2020 04:11:18 -0700 (PDT)
Received: from [10.37.12.83] (unknown [10.37.12.83])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BB2703F71E;
        Tue, 12 May 2020 04:11:08 -0700 (PDT)
Subject: Re: [PATCH v7 03/15] PM / EM: update callback structure and add
 device pointer
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
 <20200511111912.3001-4-lukasz.luba@arm.com>
 <20200511115722.GA13741@google.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <a2c20b82-58e3-a2ef-2d8d-edbaf05277ec@arm.com>
Date:   Tue, 12 May 2020 12:11:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200511115722.GA13741@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Quentin,

On 5/11/20 12:57 PM, Quentin Perret wrote:
> On Monday 11 May 2020 at 12:19:00 (+0100), Lukasz Luba wrote:
>> diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
>> index 61623e2ff149..11ee24e06d12 100644
>> --- a/drivers/cpufreq/scmi-cpufreq.c
>> +++ b/drivers/cpufreq/scmi-cpufreq.c
>> @@ -103,17 +103,12 @@ scmi_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask)
>>   }
>>   
>>   static int __maybe_unused
>> -scmi_get_cpu_power(unsigned long *power, unsigned long *KHz, int cpu)
>> +scmi_get_cpu_power(unsigned long *power, unsigned long *KHz,
>> +		   struct device *cpu_dev)
>>   {
>> -	struct device *cpu_dev = get_cpu_device(cpu);
>>   	unsigned long Hz;
>>   	int ret, domain;
>>   
>> -	if (!cpu_dev) {
>> -		pr_err("failed to get cpu%d device\n", cpu);
>> -		return -ENODEV;
>> -	}
>> -
>>   	domain = handle->perf_ops->device_domain_id(cpu_dev);
>>   	if (domain < 0)
>>   		return domain;
>> @@ -200,7 +195,7 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
>>   
>>   	policy->fast_switch_possible = true;
>>   
>> -	em_register_perf_domain(policy->cpus, nr_opp, &em_cb);
> 
> So this one has no users after this patch right? I suppose you could
> squash patch 05 in this one. But no big deal.

Yes, it was tricky to me to decide the splits suggested by Daniel and
this is the example. I had to introduce the em_dev_register_perf_domain
and make clients of it before I remove the old em_register_perf_domain
completely. I agree it could also go with the patch 5, but it does not
harm to be here.

> 
> Acked-by: Quentin Perret <qperret@google.com>

Thank you for this ACKs and the earlier.

Regards,
Lukasz

> 
>> +	em_dev_register_perf_domain(cpu_dev, nr_opp, &em_cb, policy->cpus);
>>   
>>   	return 0;

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77DF42B95E7
	for <lists+linux-pm@lfdr.de>; Thu, 19 Nov 2020 16:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbgKSPOL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Nov 2020 10:14:11 -0500
Received: from foss.arm.com ([217.140.110.172]:60094 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726853AbgKSPOK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 19 Nov 2020 10:14:10 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A9E211D4;
        Thu, 19 Nov 2020 07:14:10 -0800 (PST)
Received: from [10.57.24.96] (unknown [10.57.24.96])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A6F203F719;
        Thu, 19 Nov 2020 07:14:05 -0800 (PST)
Subject: Re: [PATCH v8 1/3] cpufreq: mediatek-hw: Add support for CPUFREQ HW
To:     Hector Yuan <hector.yuan@mediatek.com>
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dave Gerlach <d-gerlach@ti.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        wsd_upstream@mediatek.com
References: <1603700349-5922-1-git-send-email-hector.yuan@mediatek.com>
 <1603700349-5922-2-git-send-email-hector.yuan@mediatek.com>
 <9382b917-f20d-c7b5-42e4-46d11465073f@arm.com>
 <1605793218.20463.5.camel@mtkswgap22>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <677bc381-6cab-85ec-8b9f-4c33dfb487fd@arm.com>
Date:   Thu, 19 Nov 2020 15:14:03 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1605793218.20463.5.camel@mtkswgap22>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 11/19/20 1:40 PM, Hector Yuan wrote:
> On Thu, 2020-11-19 at 12:41 +0000, Lukasz Luba wrote:
>> Hi Hector,
>>
>> On 10/26/20 8:19 AM, Hector Yuan wrote:
>>> From: "Hector.Yuan" <hector.yuan@mediatek.com>
>>>
>>> Add cpufreq HW support.
>>>
>>> Signed-off-by: Hector.Yuan <hector.yuan@mediatek.com>
>>
>> [snip]
>>
>>> +
>>> +static int mtk_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>>> +{
>>> +	struct cpufreq_mtk *c;
>>> +	struct device *cpu_dev;
>>> +	struct em_data_callback em_cb = EM_DATA_CB(mtk_cpufreq_get_cpu_power);
>>> +	struct pm_qos_request *qos_request;
>>> +	int sig, pwr_hw = CPUFREQ_HW_STATUS | SVS_HW_STATUS;
>>> +
>>> +	qos_request = kzalloc(sizeof(*qos_request), GFP_KERNEL);
>>> +	if (!qos_request)
>>> +		return -ENOMEM;
>>> +
>>> +	cpu_dev = get_cpu_device(policy->cpu);
>>> +	if (!cpu_dev) {
>>> +		pr_err("failed to get cpu%d device\n", policy->cpu);
>>> +		return -ENODEV;
>>> +	}
>>> +
>>> +	c = mtk_freq_domain_map[policy->cpu];
>>> +	if (!c) {
>>> +		pr_err("No scaling support for CPU%d\n", policy->cpu);
>>> +		return -ENODEV;
>>> +	}
>>> +
>>> +	cpumask_copy(policy->cpus, &c->related_cpus);
>>> +
>>> +	policy->freq_table = c->table;
>>> +	policy->driver_data = c;
>>
>> To control frequency transition rate in schedutil, you might
>> be interested in setting:
>>
>> policy->cpuinfo.transition_latency = <mtk_value_here>;
>>
>> Example, when this latency value comes from FW [1]
>>
> OK, I will add it in v9.
>>> +
>>> +	/* Let CPUs leave idle-off state for SVS CPU initializing */
>>> +	cpu_latency_qos_add_request(qos_request, 0);
>>> +
>>> +	/* HW should be in enabled state to proceed now */
>>> +	writel_relaxed(0x1, c->reg_bases[REG_FREQ_ENABLE]);
>>> +
>>> +	if (readl_poll_timeout(c->reg_bases[REG_FREQ_HW_STATE], sig,
>>> +			       (sig & pwr_hw) == pwr_hw, POLL_USEC,
>>> +			       TIMEOUT_USEC)) {
>>> +		if (!(sig & CPUFREQ_HW_STATUS)) {
>>> +			pr_info("cpufreq hardware of CPU%d is not enabled\n",
>>> +				policy->cpu);
>>> +			return -ENODEV;
>>> +		}
>>> +
>>> +		pr_info("SVS of CPU%d is not enabled\n", policy->cpu);
>>> +	}
>>> +
>>> +	em_dev_register_perf_domain(cpu_dev, c->nr_opp, &em_cb, policy->cpus);
>>
>> Please keep in mind that this is going to be changed soon with a new
>> argument: 'milliwatts'. It's queued in pm/linux-next [2].
>>
> OK, thanks for the remind.
>> Regards,
>> Lukasz
>>
>> [1]
>> https://elixir.bootlin.com/linux/latest/source/drivers/cpufreq/scmi-cpufreq.c#L194
>> [2]
>> https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?h=linux-next&id=c250d50fe2ce627ca9805d9c8ac11cbbf922a4a6
>>
> 

Also, based on function mtk_cpufreq_hw_target_index(), which looks
really simple, you might consider to have fast_switch enabled.

It will allow SchedUtil governor to change frequency directly
and not create a dedicated deadline thread for it. It pays off.

You have to experiment with something like:

policy->fast_switch_possible  = true;


static struct cpufreq_driver cpufreq_mtk_hw_driver = {
...
	.fast_switch = mtk_cpufreq_hw_fast_switch
...
}

Again, scmi-cpufreq.c would be a good pattern to follow.

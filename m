Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 171632B92AE
	for <lists+linux-pm@lfdr.de>; Thu, 19 Nov 2020 13:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgKSMlp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Nov 2020 07:41:45 -0500
Received: from foss.arm.com ([217.140.110.172]:56190 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727000AbgKSMlp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 19 Nov 2020 07:41:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C50911396;
        Thu, 19 Nov 2020 04:41:44 -0800 (PST)
Received: from [10.57.24.96] (unknown [10.57.24.96])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A3AAD3F718;
        Thu, 19 Nov 2020 04:41:40 -0800 (PST)
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
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <9382b917-f20d-c7b5-42e4-46d11465073f@arm.com>
Date:   Thu, 19 Nov 2020 12:41:38 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1603700349-5922-2-git-send-email-hector.yuan@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Hector,

On 10/26/20 8:19 AM, Hector Yuan wrote:
> From: "Hector.Yuan" <hector.yuan@mediatek.com>
> 
> Add cpufreq HW support.
> 
> Signed-off-by: Hector.Yuan <hector.yuan@mediatek.com>

[snip]

> +
> +static int mtk_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
> +{
> +	struct cpufreq_mtk *c;
> +	struct device *cpu_dev;
> +	struct em_data_callback em_cb = EM_DATA_CB(mtk_cpufreq_get_cpu_power);
> +	struct pm_qos_request *qos_request;
> +	int sig, pwr_hw = CPUFREQ_HW_STATUS | SVS_HW_STATUS;
> +
> +	qos_request = kzalloc(sizeof(*qos_request), GFP_KERNEL);
> +	if (!qos_request)
> +		return -ENOMEM;
> +
> +	cpu_dev = get_cpu_device(policy->cpu);
> +	if (!cpu_dev) {
> +		pr_err("failed to get cpu%d device\n", policy->cpu);
> +		return -ENODEV;
> +	}
> +
> +	c = mtk_freq_domain_map[policy->cpu];
> +	if (!c) {
> +		pr_err("No scaling support for CPU%d\n", policy->cpu);
> +		return -ENODEV;
> +	}
> +
> +	cpumask_copy(policy->cpus, &c->related_cpus);
> +
> +	policy->freq_table = c->table;
> +	policy->driver_data = c;

To control frequency transition rate in schedutil, you might
be interested in setting:

policy->cpuinfo.transition_latency = <mtk_value_here>;

Example, when this latency value comes from FW [1]

> +
> +	/* Let CPUs leave idle-off state for SVS CPU initializing */
> +	cpu_latency_qos_add_request(qos_request, 0);
> +
> +	/* HW should be in enabled state to proceed now */
> +	writel_relaxed(0x1, c->reg_bases[REG_FREQ_ENABLE]);
> +
> +	if (readl_poll_timeout(c->reg_bases[REG_FREQ_HW_STATE], sig,
> +			       (sig & pwr_hw) == pwr_hw, POLL_USEC,
> +			       TIMEOUT_USEC)) {
> +		if (!(sig & CPUFREQ_HW_STATUS)) {
> +			pr_info("cpufreq hardware of CPU%d is not enabled\n",
> +				policy->cpu);
> +			return -ENODEV;
> +		}
> +
> +		pr_info("SVS of CPU%d is not enabled\n", policy->cpu);
> +	}
> +
> +	em_dev_register_perf_domain(cpu_dev, c->nr_opp, &em_cb, policy->cpus);

Please keep in mind that this is going to be changed soon with a new
argument: 'milliwatts'. It's queued in pm/linux-next [2].

Regards,
Lukasz

[1] 
https://elixir.bootlin.com/linux/latest/source/drivers/cpufreq/scmi-cpufreq.c#L194
[2] 
https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?h=linux-next&id=c250d50fe2ce627ca9805d9c8ac11cbbf922a4a6


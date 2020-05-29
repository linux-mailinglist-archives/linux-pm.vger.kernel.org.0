Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0474D1E7BD9
	for <lists+linux-pm@lfdr.de>; Fri, 29 May 2020 13:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbgE2LbY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 May 2020 07:31:24 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:47211 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726052AbgE2LbY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 29 May 2020 07:31:24 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590751883; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=+b9xQUQFNN4Oe3TcPS9VmSMFWy3mqBpS5ldsN4JGRkk=;
 b=DMF4N0bFRSoYi54ZgYtukpoTgMX/HFPxwbZe+juo4ygTmkx/28HXI+B8Qj0a6Gitm0coNylu
 uB6/EqvkwiV3FW9Fw5nehthDkgbaSCEvRB8ZFS9/DRBMfuOxvBx4P26g/4PJp8YcejF6/qX2
 aPxGXX5NPjvn5xGU07qaS4ioSpg=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 5ed0f272809d904967f05863 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 29 May 2020 11:30:58
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 87934C43395; Fri, 29 May 2020 11:30:58 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 556F1C433C9;
        Fri, 29 May 2020 11:30:57 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 29 May 2020 17:00:57 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     sboyd@kernel.org, georgi.djakov@linaro.org, saravanak@google.com,
        mka@chromium.org, nm@ti.com, bjorn.andersson@linaro.org,
        agross@kernel.org, rjw@rjwysocki.net,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dianders@chromium.org,
        vincent.guittot@linaro.org, amit.kucheria@linaro.org,
        lukasz.luba@arm.com, sudeep.holla@arm.com, smasetty@codeaurora.org,
        linux-arm-msm-owner@vger.kernel.org
Subject: Re: [PATCH v5 4/5] cpufreq: qcom: Update the bandwidth levels on
 frequency change
In-Reply-To: <20200529100028.2wz2iqi5vqji2heb@vireshk-i7>
References: <20200527202153.11659-1-sibis@codeaurora.org>
 <20200527202153.11659-5-sibis@codeaurora.org>
 <20200529100028.2wz2iqi5vqji2heb@vireshk-i7>
Message-ID: <a90bce2d52f7cdb726e8b799e3512fad@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hey Viresh,
Thanks for taking time to review the
series :)

On 2020-05-29 15:30, Viresh Kumar wrote:
> On 28-05-20, 01:51, Sibi Sankar wrote:
>> Add support to parse optional OPP table attached to the cpu node when
>> the OPP bandwidth values are populated. This allows for scaling of
>> DDR/L3 bandwidth levels with frequency change.
>> 
>> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
>> ---
>> 
>> V5:
>>  * Use dev_pm_opp_adjust_voltage instead [Viresh]
>>  * Misc cleanup
>> 
>> v4:
>>  * Split fast switch disable into another patch [Lukasz]
>> 
>>  drivers/cpufreq/qcom-cpufreq-hw.c | 77 
>> ++++++++++++++++++++++++++++++-
>>  1 file changed, 75 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c 
>> b/drivers/cpufreq/qcom-cpufreq-hw.c
>> index fc92a8842e252..fbd73d106a3ae 100644
>> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
>> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
>> @@ -6,6 +6,7 @@
>>  #include <linux/bitfield.h>
>>  #include <linux/cpufreq.h>
>>  #include <linux/init.h>
>> +#include <linux/interconnect.h>
>>  #include <linux/kernel.h>
>>  #include <linux/module.h>
>>  #include <linux/of_address.h>
>> @@ -31,6 +32,52 @@
>>  static unsigned long cpu_hw_rate, xo_rate;
>>  static struct platform_device *global_pdev;
>> 
>> +static int qcom_cpufreq_set_bw(struct cpufreq_policy *policy,
>> +			       unsigned long freq_khz)
>> +{
>> +	unsigned long freq_hz = freq_khz * 1000;
>> +	struct dev_pm_opp *opp;
>> +	struct device *dev;
>> +	int ret;
>> +
>> +	dev = get_cpu_device(policy->cpu);
>> +	if (!dev)
>> +		return -ENODEV;
>> +
>> +	opp = dev_pm_opp_find_freq_exact(dev, freq_hz, true);
>> +	if (IS_ERR(opp))
>> +		return PTR_ERR(opp);
>> +
>> +	ret = dev_pm_opp_set_bw(dev, opp);
>> +	dev_pm_opp_put(opp);
>> +	return ret;
>> +}
>> +
>> +static int qcom_cpufreq_update_opp(struct device *cpu_dev,
>> +				   unsigned long freq_khz,
>> +				   unsigned long volt)
>> +{
>> +	unsigned long freq_hz = freq_khz * 1000;
>> +
>> +	if (dev_pm_opp_adjust_voltage(cpu_dev, freq_hz, volt, volt, volt))
>> +		return dev_pm_opp_add(cpu_dev, freq_hz, volt);
> 
> What's going on here ? Why add OPP here ?

We update the voltage if opp were
initially added as part of
dev_pm_opp_of_add_table. However
if the cpu node does not have an
opp table associated with it, we
do a opp_add_v1 instead.

> 
>> +
>> +	/* Enable the opp after voltage update */
>> +	return dev_pm_opp_enable(cpu_dev, freq_hz);
>> +}
>> +
>> +/* Check for optional interconnect paths on CPU0 */
>> +static int qcom_cpufreq_find_icc_paths(struct device *dev)
>> +{
>> +	struct device *cpu_dev;
>> +
>> +	cpu_dev = get_cpu_device(0);
>> +	if (!cpu_dev)
>> +		return -EPROBE_DEFER;
>> +
>> +	return dev_pm_opp_of_find_icc_paths(cpu_dev, NULL);
>> +}
>> +
> 
> open code this into the probe routine.

sure

> 
>>  static int qcom_cpufreq_hw_target_index(struct cpufreq_policy 
>> *policy,
>>  					unsigned int index)
>>  {
>> @@ -39,6 +86,8 @@ static int qcom_cpufreq_hw_target_index(struct 
>> cpufreq_policy *policy,
>> 
>>  	writel_relaxed(index, perf_state_reg);
>> 
>> +	qcom_cpufreq_set_bw(policy, freq);
>> +
>>  	arch_set_freq_scale(policy->related_cpus, freq,
>>  			    policy->cpuinfo.max_freq);
>>  	return 0;
>> @@ -88,12 +137,30 @@ static int qcom_cpufreq_hw_read_lut(struct device 
>> *cpu_dev,
>>  {
>>  	u32 data, src, lval, i, core_count, prev_freq = 0, freq;
>>  	u32 volt;
>> +	u64 rate;
>>  	struct cpufreq_frequency_table	*table;
>> +	struct device_node *opp_table_np, *np;
>> +	int ret;
>> 
>>  	table = kcalloc(LUT_MAX_ENTRIES + 1, sizeof(*table), GFP_KERNEL);
>>  	if (!table)
>>  		return -ENOMEM;
>> 
>> +	ret = dev_pm_opp_of_add_table(cpu_dev);
>> +	if (!ret) {
>> +		/* Disable all opps and cross-validate against LUT */
>> +		opp_table_np = dev_pm_opp_of_get_opp_desc_node(cpu_dev);
>> +		for_each_available_child_of_node(opp_table_np, np) {
>> +			ret = of_property_read_u64(np, "opp-hz", &rate);
> 
> No way, please use dev_pm_opp_find_freq_*() here instead to grab OPPs
> one by one.

sure I'll use a dev_pm_opp_find_freq_ceil
loop to do the same :P

> 
>> +			if (!ret)
>> +				dev_pm_opp_disable(cpu_dev, rate);
>> +		}
>> +		of_node_put(opp_table_np);
>> +	} else if (ret != -ENODEV) {
>> +		dev_err(cpu_dev, "Invalid OPP table in Device tree\n");
>> +		return ret;
>> +	}
> 
> Rather put this in the if (ret) block and so the else part doesn't
> need extra indentation.

https://patchwork.kernel.org/patch/11573905/

I'll need to enable fast_switch
when the device does not have a
opp-table associated with it or
throw a error when an improper
table is specified. If a table
with bw values is specified, we
disable fast switch and enable
scaling.

> 
>> +
>>  	for (i = 0; i < LUT_MAX_ENTRIES; i++) {
>>  		data = readl_relaxed(base + REG_FREQ_LUT +
>>  				      i * LUT_ROW_SIZE);
>> @@ -112,7 +179,7 @@ static int qcom_cpufreq_hw_read_lut(struct device 
>> *cpu_dev,
>> 
>>  		if (freq != prev_freq && core_count != LUT_TURBO_IND) {
>>  			table[i].frequency = freq;
>> -			dev_pm_opp_add(cpu_dev, freq * 1000, volt);
>> +			qcom_cpufreq_update_opp(cpu_dev, freq, volt);
>>  			dev_dbg(cpu_dev, "index=%d freq=%d, core_count %d\n", i,
>>  				freq, core_count);
>>  		} else if (core_count == LUT_TURBO_IND) {
>> @@ -133,7 +200,8 @@ static int qcom_cpufreq_hw_read_lut(struct device 
>> *cpu_dev,
>>  			if (prev->frequency == CPUFREQ_ENTRY_INVALID) {
>>  				prev->frequency = prev_freq;
>>  				prev->flags = CPUFREQ_BOOST_FREQ;
>> -				dev_pm_opp_add(cpu_dev,	prev_freq * 1000, volt);
>> +				qcom_cpufreq_update_opp(cpu_dev, prev_freq,
>> +							volt);
>>  			}
>> 
>>  			break;

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.

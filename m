Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36CCC1FC0A3
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jun 2020 23:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729272AbgFPVFZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Jun 2020 17:05:25 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:44392 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726804AbgFPVFZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 16 Jun 2020 17:05:25 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592341524; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=IMNNo1BqQ1o0gHuNsl/LI5YBXnEGtDooQJTtyr/egAU=;
 b=j6nnU6keN0MdfW5oOmmJEXhlzLYrv02d6aGOhg83a8PjlkVMAaIVPMLTNVGorYmEAJwZr/ng
 NrkwPCJMRU/y9CPE01FDOQF92tE1VLcKslHvCbgPr0Z7SM9IR49GNJyE3SR/rKCnyNGSQ+qs
 9jZ4dIFqENbNkSXqVccrZEzTluI=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 5ee933fd117610c7ff2678e7 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 16 Jun 2020 21:05:01
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 77EDEC43395; Tue, 16 Jun 2020 21:05:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3197CC433C9;
        Tue, 16 Jun 2020 21:05:00 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 17 Jun 2020 02:35:00 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     viresh.kumar@linaro.org, sboyd@kernel.org,
        georgi.djakov@linaro.org, saravanak@google.com, nm@ti.com,
        bjorn.andersson@linaro.org, agross@kernel.org, rjw@rjwysocki.net,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dianders@chromium.org,
        vincent.guittot@linaro.org, amit.kucheria@linaro.org,
        lukasz.luba@arm.com, sudeep.holla@arm.com, smasetty@codeaurora.org,
        linux-arm-msm-owner@vger.kernel.org
Subject: Re: [PATCH v6 4/5] cpufreq: qcom: Update the bandwidth levels on
 frequency change
In-Reply-To: <20200615172553.GU4525@google.com>
References: <20200605213332.609-1-sibis@codeaurora.org>
 <20200605213332.609-5-sibis@codeaurora.org>
 <20200615172553.GU4525@google.com>
Message-ID: <e21f85d64d72ec637c10dae93e8323bb@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hey Matthias,
Thanks for taking time to review
the series.

On 2020-06-15 22:55, Matthias Kaehlcke wrote:
> Hi Sibi,
> 
> On Sat, Jun 06, 2020 at 03:03:31AM +0530, Sibi Sankar wrote:
>> Add support to parse optional OPP table attached to the cpu node when
>> the OPP bandwidth values are populated. This allows for scaling of
>> DDR/L3 bandwidth levels with frequency change.
>> 
>> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
>> ---
>> 
>> v6:
>>  * Add global flag to distinguish between voltage update and opp add.
>>    Use the same flag before trying to scale ddr/l3 bw [Viresh]
>>  * Use dev_pm_opp_find_freq_ceil to grab all opps [Viresh]
>>  * Move dev_pm_opp_of_find_icc_paths into probe [Viresh]
>> 
>> v5:
>>  * Use dev_pm_opp_adjust_voltage instead [Viresh]
>>  * Misc cleanup
>> 
>> v4:
>>  * Split fast switch disable into another patch [Lukasz]
>> 
>>  drivers/cpufreq/qcom-cpufreq-hw.c | 82 
>> ++++++++++++++++++++++++++++++-
>>  1 file changed, 80 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c 
>> b/drivers/cpufreq/qcom-cpufreq-hw.c
>> index fc92a8842e252..8fa6ab6e0e4b6 100644
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
>> @@ -30,6 +31,48 @@
>> 
>>  static unsigned long cpu_hw_rate, xo_rate;
>>  static struct platform_device *global_pdev;
>> +static bool icc_scaling_enabled;
> 
> It seem you rely on 'icc_scaling_enabled' to be initialized to 'false'.
> This works during the first initialization, but not if the 'device' is
> unbound/rebound. In theory things shouldn't be different in a succesive

yes it shouldn't but sure I'll set
it to false along the way.

> initialization, however for robustness the variable should be 
> explicitly
> set to 'false' somewhere in the code path (_probe(), _read_lut(), ...).

> 
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
>> +	int ret;
>> +
>> +	/* Skip voltage update if the opp table is not available */
>> +	if (!icc_scaling_enabled)
>> +		return dev_pm_opp_add(cpu_dev, freq_hz, volt);
>> +
>> +	ret = dev_pm_opp_adjust_voltage(cpu_dev, freq_hz, volt, volt, volt);
>> +	if (ret) {
>> +		dev_err(cpu_dev, "Voltage update failed freq=%ld\n", freq_khz);
>> +		return ret;
>> +	}
>> +
>> +	return dev_pm_opp_enable(cpu_dev, freq_hz);
>> +}
>> 
>>  static int qcom_cpufreq_hw_target_index(struct cpufreq_policy 
>> *policy,
>>  					unsigned int index)
>> @@ -39,6 +82,9 @@ static int qcom_cpufreq_hw_target_index(struct 
>> cpufreq_policy *policy,
>> 
>>  	writel_relaxed(index, perf_state_reg);
>> 
>> +	if (icc_scaling_enabled)
>> +		qcom_cpufreq_set_bw(policy, freq);
>> +
>>  	arch_set_freq_scale(policy->related_cpus, freq,
>>  			    policy->cpuinfo.max_freq);
>>  	return 0;
>> @@ -89,11 +135,31 @@ static int qcom_cpufreq_hw_read_lut(struct device 
>> *cpu_dev,
>>  	u32 data, src, lval, i, core_count, prev_freq = 0, freq;
>>  	u32 volt;
>>  	struct cpufreq_frequency_table	*table;
>> +	struct dev_pm_opp *opp;
>> +	unsigned long rate;
>> +	int ret;
>> 
>>  	table = kcalloc(LUT_MAX_ENTRIES + 1, sizeof(*table), GFP_KERNEL);
>>  	if (!table)
>>  		return -ENOMEM;
>> 
>> +	ret = dev_pm_opp_of_add_table(cpu_dev);
>> +	if (!ret) {
>> +		/* Disable all opps and cross-validate against LUT */
> 
> nit: IIUC the cross-validation doesn't happen in this branch, so the
> comment is a bit misleading. Maybe change it to "Disable all opps to
> cross-validate against the LUT {below,later}".

sure will re-word it.

> 
>> +		icc_scaling_enabled = true;
>> +		for (rate = 0; ; rate++) {
>> +			opp = dev_pm_opp_find_freq_ceil(cpu_dev, &rate);
>> +			if (IS_ERR(opp))
>> +				break;
>> +
>> +			dev_pm_opp_put(opp);
>> +			dev_pm_opp_disable(cpu_dev, rate);
>> +		}
>> +	} else if (ret != -ENODEV) {
>> +		dev_err(cpu_dev, "Invalid opp table in device tree\n");
>> +		return ret;
>> +	}
>> +
>>  	for (i = 0; i < LUT_MAX_ENTRIES; i++) {
>>  		data = readl_relaxed(base + REG_FREQ_LUT +
>>  				      i * LUT_ROW_SIZE);
>> @@ -112,7 +178,7 @@ static int qcom_cpufreq_hw_read_lut(struct device 
>> *cpu_dev,
>> 
>>  		if (freq != prev_freq && core_count != LUT_TURBO_IND) {
>>  			table[i].frequency = freq;
>> -			dev_pm_opp_add(cpu_dev, freq * 1000, volt);
>> +			qcom_cpufreq_update_opp(cpu_dev, freq, volt);
> 
> This is the cross-validation mentioned above, right? Shouldn't it 
> include
> a check of the return value?

Yes, this is the cross-validation step,
we adjust the voltage if opp-tables are
present/added successfully and enable
them, else we would just do a add opp.
We don't want to exit early on a single
opp failure. We will error out a bit
later if the opp-count ends up to be
zero.

> 
>>  			dev_dbg(cpu_dev, "index=%d freq=%d, core_count %d\n", i,
>>  				freq, core_count);
>>  		} else if (core_count == LUT_TURBO_IND) {
>> @@ -133,7 +199,8 @@ static int qcom_cpufreq_hw_read_lut(struct device 
>> *cpu_dev,
>>  			if (prev->frequency == CPUFREQ_ENTRY_INVALID) {
>>  				prev->frequency = prev_freq;
>>  				prev->flags = CPUFREQ_BOOST_FREQ;
>> -				dev_pm_opp_add(cpu_dev,	prev_freq * 1000, volt);
>> +				qcom_cpufreq_update_opp(cpu_dev, prev_freq,
>> +							volt);
> 
> ditto
> 
> nit: with the updated max line length it isn't necessary anymore to 
> break
> this into multiple lines
> (https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/scripts/checkpatch.pl?h=v5.8-rc1#n54),
> though the coding style still has the old limit.

yeah I'll expand it.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.

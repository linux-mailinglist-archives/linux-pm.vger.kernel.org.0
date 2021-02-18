Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCD8A31EA54
	for <lists+linux-pm@lfdr.de>; Thu, 18 Feb 2021 14:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbhBRNQH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Feb 2021 08:16:07 -0500
Received: from foss.arm.com ([217.140.110.172]:50984 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233236AbhBRNAB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 18 Feb 2021 08:00:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C9CDED1;
        Thu, 18 Feb 2021 04:59:04 -0800 (PST)
Received: from [10.57.43.160] (unknown [10.57.43.160])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8A8A93F73B;
        Thu, 18 Feb 2021 04:59:02 -0800 (PST)
Subject: Re: [PATCH v7 2/3] scmi-cpufreq: Get opp_shared_cpus from opp-v2 for
 EM
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, sudeep.holla@arm.com, rjw@rjwysocki.net,
        vireshk@kernel.org, cristian.marussi@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com,
        ionela.voinescu@arm.com
References: <20210215075139.30772-1-nicola.mazzucato@arm.com>
 <20210215075139.30772-3-nicola.mazzucato@arm.com>
 <20210218110013.2b4ow7fzldra2srj@vireshk-i7>
From:   Nicola Mazzucato <nicola.mazzucato@arm.com>
Message-ID: <8efd2c71-847d-398a-5605-1daf9c2a3e75@arm.com>
Date:   Thu, 18 Feb 2021 13:02:11 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20210218110013.2b4ow7fzldra2srj@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Viresh,


On 2/18/21 11:00 AM, Viresh Kumar wrote:
> On 15-02-21, 07:51, Nicola Mazzucato wrote:
>> +	/*
>> +	 * Add OPPs only on those CPUs for which we haven't already done so.
>> +	 */
>>  	nr_opp = dev_pm_opp_get_opp_count(cpu_dev);
> 
> Please add a more detailed comment here explaining why you expect OPPs
> to be present here in advance. i.e. you _may_ have policy per CPU even
> though OPP core says OPPs are shared.. It is not straight forward to
> catch otherwise.

Sure, I'll put more details, thanks.

> 
>>  	if (nr_opp <= 0) {
>> -		dev_err(cpu_dev, "%s: No OPPs for this device: %d\n",
>> -			__func__, ret);
>> -
>> -		ret = -ENODEV;
>> -		goto out_free_priv;
>> +		ret = handle->perf_ops->device_opps_add(handle, cpu_dev);
>> +		if (ret) {
>> +			dev_warn(cpu_dev, "failed to add opps to the device\n");
>> +			goto out_free_cpumask;
>> +		}
>> +
>> +		nr_opp = dev_pm_opp_get_opp_count(cpu_dev);
>> +		if (nr_opp <= 0) {
>> +			dev_err(cpu_dev, "%s: No OPPs for this device: %d\n",
>> +				__func__, ret);
>> +
>> +			ret = -ENODEV;
>> +			goto out_free_opp;
>> +		}
>> +
>> +		ret = dev_pm_opp_set_sharing_cpus(cpu_dev, opp_shared_cpus);
>> +		if (ret) {
>> +			dev_err(cpu_dev, "%s: failed to mark OPPs as shared: %d\n",
>> +				__func__, ret);
>> +
>> +			goto out_free_opp;
>> +		}
>> +
>> +		power_scale_mw = handle->perf_ops->power_scale_mw_get(handle);
>> +		em_dev_register_perf_domain(cpu_dev, nr_opp, &em_cb,
>> +					    opp_shared_cpus, power_scale_mw);
>>  	}
> 

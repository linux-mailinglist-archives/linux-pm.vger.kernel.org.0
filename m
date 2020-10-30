Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EFE72A05FA
	for <lists+linux-pm@lfdr.de>; Fri, 30 Oct 2020 13:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbgJ3MyE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 30 Oct 2020 08:54:04 -0400
Received: from foss.arm.com ([217.140.110.172]:33986 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726178AbgJ3MyE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 30 Oct 2020 08:54:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D66F1063;
        Fri, 30 Oct 2020 05:54:03 -0700 (PDT)
Received: from [10.57.13.192] (unknown [10.57.13.192])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4DC633F68F;
        Fri, 30 Oct 2020 05:54:00 -0700 (PDT)
Subject: Re: [PATCH 2/4] OPP: Add support for parsing the 'opp-sustainable'
 property
To:     Quentin Perret <qperret@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        vireshk@kernel.org, robh+dt@kernel.org, nm@ti.com,
        rafael@kernel.org, sboyd@kernel.org, daniel.lezcano@linaro.org,
        sudeep.holla@arm.com, Dietmar.Eggemann@arm.com
References: <20201028140847.1018-1-lukasz.luba@arm.com>
 <20201028140847.1018-3-lukasz.luba@arm.com>
 <20201030114750.GA636720@google.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <7c8c2319-969e-d028-9a52-271d43611568@arm.com>
Date:   Fri, 30 Oct 2020 12:53:58 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20201030114750.GA636720@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Quentin,

On 10/30/20 11:47 AM, Quentin Perret wrote:
> Hi Lukasz,
> 
> On Wednesday 28 Oct 2020 at 14:08:45 (+0000), Lukasz Luba wrote:
>> +unsigned long dev_pm_opp_get_sustainable_opp_freq(struct device *dev)
>> +{
>> +	struct opp_table *opp_table;
>> +	unsigned long freq = 0;
>> +
>> +	opp_table = _find_opp_table(dev);
>> +	if (IS_ERR(opp_table))
>> +		return 0;
>> +
>> +	if (opp_table->sustainable_opp && opp_table->sustainable_opp->available)
>> +		freq = dev_pm_opp_get_freq(opp_table->sustainable_opp);
>> +
>> +	dev_pm_opp_put_opp_table(opp_table);
>> +
>> +	return freq;
>> +}
>> +EXPORT_SYMBOL_GPL(dev_pm_opp_get_sustainable_opp_freq);
> 
> I'm guessing this is what IPA will use to find out what the sustainable
> frequency is right?

Yes, you are right.

> 
> Is PM_OPP the right place for that? It feels odd IPA will get the EM
> from one place, which includes the performance state, and the sustained
> OPP from another. Should we move that to PM_EM instead?

True, it might looks strange, but the OPP framework is available when we
are adding the OPPs in scmi perf layer. The EM is available after we
register the device, so at the end of scmi-cpufreq init.
It would require a new scmi perf api function e.g. get_sustained_freq(),
and a set/get function for EM, which is doable.

I've discussed this approach to Viresh and he likes it better.
I am happy that you are also suggesting the EM approach.

I will send different patches for EM and SCMI to make that happen.
Should I re-based them on top of the patch adding this milliwatts filed
in EM [1]? Or do the opposite, changing the dependency order?

Regards,
Lukasz

[1] https://lkml.org/lkml/2020/10/19/392

> 
> Thanks,
> Quentin
> 

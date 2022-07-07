Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 915F256A07F
	for <lists+linux-pm@lfdr.de>; Thu,  7 Jul 2022 12:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbiGGKx7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 Jul 2022 06:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235020AbiGGKx5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 Jul 2022 06:53:57 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B691F32EC9;
        Thu,  7 Jul 2022 03:53:55 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C2E41063;
        Thu,  7 Jul 2022 03:53:55 -0700 (PDT)
Received: from [10.57.11.194] (unknown [10.57.11.194])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1918F3F66F;
        Thu,  7 Jul 2022 03:53:51 -0700 (PDT)
Message-ID: <85d48b3c-2c13-f0b9-900a-b67471948b38@arm.com>
Date:   Thu, 7 Jul 2022 11:53:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 1/4] PM: EM: convert power field to micro-Watts
 precision and align drivers
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        rafael@kernel.org, dietmar.eggemann@arm.com, nm@ti.com,
        sboyd@kernel.org, sudeep.holla@arm.com, cristian.marussi@arm.com,
        matthias.bgg@gmail.com, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20220707071555.10085-1-lukasz.luba@arm.com>
 <20220707071555.10085-2-lukasz.luba@arm.com>
 <20220707105307.wl2pnqbf3j4fo75z@vireshk-i7>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20220707105307.wl2pnqbf3j4fo75z@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 7/7/22 11:53, Viresh Kumar wrote:
> On 07-07-22, 08:15, Lukasz Luba wrote:
>> The milli-Watts precision causes rounding errors while calculating
>> efficiency cost for each OPP. This is especially visible in the 'simple'
>> Energy Model (EM), where the power for each OPP is provided from OPP
>> framework. This can cause some OPPs to be marked inefficient, while
>> using micro-Watts precision that might not happen.
>>
>> Update all EM users which access 'power' field and assume the value is
>> in milli-Watts.
>>
>> Solve also an issue with potential overflow in calculation of energy
>> estimation on 32bit machine. It's needed now since the power value
>> (thus the 'cost' as well) are higher.
>>
>> Example calculation which shows the rounding error and impact:
>>
>> power = 'dyn-power-coeff' * volt_mV * volt_mV * freq_MHz
>>
>> power_a_uW = (100 * 600mW * 600mW * 500MHz) / 10^6 = 18000
>> power_a_mW = (100 * 600mW * 600mW * 500MHz) / 10^9 = 18
>>
>> power_b_uW = (100 * 605mW * 605mW * 600MHz) / 10^6 = 21961
>> power_b_mW = (100 * 605mW * 605mW * 600MHz) / 10^9 = 21
>>
>> max_freq = 2000MHz
>>
>> cost_a_mW = 18 * 2000MHz/500MHz = 72
>> cost_a_uW = 18000 * 2000MHz/500MHz = 72000
>>
>> cost_b_mW = 21 * 2000MHz/600MHz = 70 // <- artificially better
>> cost_b_uW = 21961 * 2000MHz/600MHz = 73203
>>
>> The 'cost_b_mW' (which is based on old milli-Watts) is misleadingly
>> better that the 'cost_b_uW' (this patch uses micro-Watts) and such
>> would have impact on the 'inefficient OPPs' information in the Cpufreq
>> framework. This patch set removes the rounding issue.
>>
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>> ---
>>   drivers/cpufreq/mediatek-cpufreq-hw.c |  7 ++--
>>   drivers/cpufreq/scmi-cpufreq.c        |  6 +++
>>   drivers/opp/of.c                      | 15 ++++----
>>   drivers/powercap/dtpm_cpu.c           |  5 +--
>>   drivers/thermal/cpufreq_cooling.c     | 13 ++++++-
>>   drivers/thermal/devfreq_cooling.c     | 19 ++++++++--
>>   include/linux/energy_model.h          | 54 +++++++++++++++++++--------
>>   kernel/power/energy_model.c           | 24 ++++++++----
>>   8 files changed, 100 insertions(+), 43 deletions(-)
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 

Thank you Viresh for the ACKs!

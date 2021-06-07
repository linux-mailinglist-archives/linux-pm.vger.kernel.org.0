Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDED639E56C
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jun 2021 19:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbhFGRce (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Jun 2021 13:32:34 -0400
Received: from mga02.intel.com ([134.134.136.20]:61742 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230266AbhFGRce (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 7 Jun 2021 13:32:34 -0400
IronPort-SDR: ZAZM8Xqh3GcRawNmstUShO7qRyg6kY7yiQJd2/ZwCxt8CjnQg8UoBUPAuG63dcjZcBPP0F3fYD
 qE/cIheAjyiA==
X-IronPort-AV: E=McAfee;i="6200,9189,10008"; a="191778267"
X-IronPort-AV: E=Sophos;i="5.83,255,1616482800"; 
   d="scan'208";a="191778267"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2021 10:30:41 -0700
IronPort-SDR: deirWvcCsgtdXm90yHp0Uzo2d9GpC2TweX2Cmw0E55DhCmB2kxSVjbhDMQXjthAHCKFtCmE0hY
 MB6b1F0LqgUA==
X-IronPort-AV: E=Sophos;i="5.83,255,1616482800"; 
   d="scan'208";a="447563923"
Received: from rjwysock-mobl1.ger.corp.intel.com (HELO [10.249.139.144]) ([10.249.139.144])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2021 10:30:38 -0700
Subject: Re: [PATCH] cpuidle: ARM_QCOM_SPM_CPUIDLE should depend on
 HAVE_ARM_SMCCC
To:     Stephan Gerhold <stephan@gerhold.net>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, He Ying <heying24@huawei.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>
References: <20210606190048.689-1-rdunlap@infradead.org>
 <YL4Is1LNzBuViF3/@gerhold.net>
From:   "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Organization: Intel Technology Poland Sp. z o. o., KRS 101882, ul. Slowackiego
 173, 80-298 Gdansk
Message-ID: <7a207351-43e1-d439-9d86-bb28b6935fa2@intel.com>
Date:   Mon, 7 Jun 2021 19:30:36 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <YL4Is1LNzBuViF3/@gerhold.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 6/7/2021 1:53 PM, Stephan Gerhold wrote:
> Hi!
>
> On Sun, Jun 06, 2021 at 12:00:48PM -0700, Randy Dunlap wrote:
>> QCOM_SCM depends on HAVE_ARM_SMCCC, so ARM_QCOM_SPM_CPUIDLE should
>> also depend on HAVE_ARM_SMCCC since 'select' does not follow any
>> dependency chains.
>>
>> This fixes a kconfig warning and subsequent build errors:
>>
>> WARNING: unmet direct dependencies detected for QCOM_SCM
>>    Depends on [n]: (ARM [=y] || ARM64) && HAVE_ARM_SMCCC [=n]
>>    Selected by [y]:
>>    - ARM_QCOM_SPM_CPUIDLE [=y] && CPU_IDLE [=y] && (ARM [=y] || ARM64) && (ARCH_QCOM [=n] || COMPILE_TEST [=y]) && !ARM64 && MMU [=y]
>>
>> arm-linux-gnueabi-ld: drivers/firmware/qcom_scm-smc.o: in function `__scm_smc_do_quirk':
>> qcom_scm-smc.c:(.text+0x5c): undefined reference to `__arm_smccc_smc'
>> arm-linux-gnueabi-ld: drivers/firmware/qcom_scm-legacy.o: in function `scm_legacy_call':
>> qcom_scm-legacy.c:(.text+0x140): undefined reference to `__arm_smccc_smc'
>> arm-linux-gnueabi-ld: drivers/firmware/qcom_scm-legacy.o: in function `scm_legacy_call_atomic':
>> qcom_scm-legacy.c:(.text+0x364): undefined reference to `__arm_smccc_smc'
>>
>> Fixes: a871be6b8eee ("cpuidle: Convert Qualcomm SPM driver to a generic CPUidle driver")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Stephan Gerhold <stephan@gerhold.net>
>> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> Cc: Andy Gross <agross@kernel.org>
>> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
>> Cc: linux-arm-msm@vger.kernel.org
>> Cc: He Ying <heying24@huawei.com>
> There was a similar patch from Arnd a while ago (which fixes another
> warning for ARM_CPU_SUSPEND?):
>
> https://lore.kernel.org/linux-pm/20210421135723.3601743-1-arnd@kernel.org/
>
> I'm not sure who is supposed to pick it up. :)

ARM cpuidle drivers are maintained by Daniel Lezcano.

Also, please CC power management material to linux-pm@vger.kernel.org.


>
>> ---
>>   drivers/cpuidle/Kconfig.arm |    1 +
>>   1 file changed, 1 insertion(+)
>>
>> --- linux-next-20210604.orig/drivers/cpuidle/Kconfig.arm
>> +++ linux-next-20210604/drivers/cpuidle/Kconfig.arm
>> @@ -108,6 +108,7 @@ config ARM_TEGRA_CPUIDLE
>>   config ARM_QCOM_SPM_CPUIDLE
>>   	bool "CPU Idle Driver for Qualcomm Subsystem Power Manager (SPM)"
>>   	depends on (ARCH_QCOM || COMPILE_TEST) && !ARM64 && MMU
>> +	depends on HAVE_ARM_SMCCC
>>   	select ARM_CPU_SUSPEND
>>   	select CPU_IDLE_MULTIPLE_DRIVERS
>>   	select DT_IDLE_STATES



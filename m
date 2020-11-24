Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3A5B2C1E4B
	for <lists+linux-pm@lfdr.de>; Tue, 24 Nov 2020 07:35:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729760AbgKXGeF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Nov 2020 01:34:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbgKXGeF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Nov 2020 01:34:05 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0223AC0613CF;
        Mon, 23 Nov 2020 22:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=dw2WX6pmHeJN4qzN9ypDpXesWCc5HZ9sbIY2lS2fxUc=; b=XRTYE6aHSiL8uDrmV4c7P7/t4/
        klKAIIOk3+gRONFsT5Y8Y/srypoOSpOb6wBWarVjoC6/nL7bSLKUVn5m9Boaf/1kWnPCDssWa83zz
        KSqHNwc1Y66vh5E0jmXiViaqaARof6EW2py4BIlKMPmcT9hXoIfnQKU+hQNHLn3qqaetKIfR2R/lB
        jbcUaUWgQYAnBuRENSgXnvdOvqdaDfV/2OKNfJjcsjDGje1y7U1NqBI5UTTQHGSu/RTFDnekmZ6ZS
        R4k6zn7EwH3o/qw8pJYOKQdWE0A6KFYFyWLNzsW2NmQB5HF4XsYJTsMDAM0VwtTsNDJRtKu4pHgNZ
        dCtCcl/g==;
Received: from [2601:1c0:6280:3f0::cc1f]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khRtn-0001hS-Ds; Tue, 24 Nov 2020 06:33:59 +0000
Subject: Re: [PATCH] cpuidle: arm: qcom: fix Kconfig problems
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        linux-pm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Lina Iyer <ilina@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        John Stultz <john.stultz@linaro.org>
References: <20201124013053.11502-1-rdunlap@infradead.org>
 <20201124045110.GH95182@builder.lan>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <af448740-c7ba-f14e-2193-fea6acafa9fb@infradead.org>
Date:   Mon, 23 Nov 2020 22:33:52 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201124045110.GH95182@builder.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11/23/20 8:51 PM, Bjorn Andersson wrote:
> On Mon 23 Nov 19:30 CST 2020, Randy Dunlap wrote:
> 
>> The Kconfig symbol ARM_QCOM_SPM_CPUIDLE wildly selects other
>> Kconfig symbols when it should not.
>> This causes kconfig warnings and subsequent build errors,
>> as listed below, so modify this symbol's Kconfig entry to
>> constrain and tame it.
>>
>> WARNING: unmet direct dependencies detected for QCOM_SCM
>>   Depends on [n]: ARM [=y] && HAVE_ARM_SMCCC [=n] || ARM64
>>   Selected by [y]:
>>   - ARM_QCOM_SPM_CPUIDLE [=y] && CPU_IDLE [=y] && (ARM [=y] || ARM64) && (ARCH_QCOM [=n] || COMPILE_TEST [=y]) && !ARM64
>>
>> WARNING: unmet direct dependencies detected for ARM_CPU_SUSPEND
>>   Depends on [n]: ARCH_SUSPEND_POSSIBLE [=n]
>>   Selected by [y]:
>>   - ARM_QCOM_SPM_CPUIDLE [=y] && CPU_IDLE [=y] && (ARM [=y] || ARM64) && (ARCH_QCOM [=n] || COMPILE_TEST [=y]) && !ARM64
>>
>> and
>>
>> arm-linux-gnueabi-ld: arch/arm/kernel/sleep.o: in function `__cpu_suspend':
>> (.text+0x68): undefined reference to `cpu_sa110_suspend_size'
>> arm-linux-gnueabi-ld: arch/arm/kernel/suspend.o: in function `__cpu_suspend_save':
>> suspend.c:(.text+0x138): undefined reference to `cpu_sa110_do_suspend'
>> arm-linux-gnueabi-ld: suspend.c:(.text+0x170): undefined reference to `cpu_sa110_do_resume'
>> arm-linux-gnueabi-ld: drivers/firmware/qcom_scm-smc.o: in function `__scm_smc_do_quirk':
>> qcom_scm-smc.c:(.text+0x54): undefined reference to `__arm_smccc_smc'
>> arm-linux-gnueabi-ld: drivers/firmware/qcom_scm-legacy.o: in function `scm_legacy_call':
>> qcom_scm-legacy.c:(.text+0x168): undefined reference to `__arm_smccc_smc'
>> arm-linux-gnueabi-ld: drivers/firmware/qcom_scm-legacy.o: in function `scm_legacy_call_atomic':
>> qcom_scm-legacy.c:(.text+0x2e0): undefined reference to `__arm_smccc_smc'
>>
>> Fixes: a871be6b8eee ("cpuidle: Convert Qualcomm SPM driver to a generic CPUidle driver")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Cc: linux-pm@vger.kernel.org
>> Cc: Andy Gross <agross@kernel.org>
>> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
>> Cc: linux-arm-msm@vger.kernel.org
>> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Cc: Stephan Gerhold <stephan@gerhold.net>
>> Cc: Lina Iyer <ilina@codeaurora.org>
>> Cc: Ulf Hansson <ulf.hansson@linaro.org>
>> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
>> ---
>>  drivers/cpuidle/Kconfig.arm |    3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> --- linux-next-20201123.orig/drivers/cpuidle/Kconfig.arm
>> +++ linux-next-20201123/drivers/cpuidle/Kconfig.arm
>> @@ -108,10 +108,11 @@ config ARM_TEGRA_CPUIDLE
>>  config ARM_QCOM_SPM_CPUIDLE
>>  	bool "CPU Idle Driver for Qualcomm Subsystem Power Manager (SPM)"
>>  	depends on (ARCH_QCOM || COMPILE_TEST) && !ARM64
>> +	depends on PM
>>  	select ARM_CPU_SUSPEND
>>  	select CPU_IDLE_MULTIPLE_DRIVERS
>>  	select DT_IDLE_STATES
>> -	select QCOM_SCM
>> +	select QCOM_SCM if HAVE_ARM_SMCCC
> 
> I presume the trigger for this error is that 'd0511b5496c0 ("firmware:
> QCOM_SCM: Allow qcom_scm driver to be loadable as a permenent module")'
> made QCOM_SCM user selectable and described the dependency on
> HAVE_ARM_SMCCC..

I don't quite see that as contributing to the problem, but maybe
it's just too late at night for me to see it.

> So given that, and the fact that this driver doesn't do anything without
> QCOM_SCM, can we instead make it "depends on QCOM_SCM"? I believe it
> would inherit the dependency of HAVE_ARM_SMCCC in this case?

Sure, I'll respin it like that.

> Regards,
> Bjorn
> 
>>  	help
>>  	  Select this to enable cpuidle for Qualcomm processors.
>>  	  The Subsystem Power Manager (SPM) controls low power modes for the


thanks.
-- 
~Randy


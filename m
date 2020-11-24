Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82F852C1D1F
	for <lists+linux-pm@lfdr.de>; Tue, 24 Nov 2020 05:53:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbgKXEvO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Nov 2020 23:51:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbgKXEvN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Nov 2020 23:51:13 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82438C0613CF
        for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2020 20:51:13 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id 79so18171611otc.7
        for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2020 20:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IaPCaFCHuJQneePrqd68vBnsJF+MzsPrh4FvA+iHfzE=;
        b=UpR50yOkEvNdKtEe2bzhgb4x84Cye79O1Rm1mO8+oJTdzz2XfFE2isfCJ+YRTV8U8H
         L8PthdNJl+O1zDL68k06P0DmWk3xIt+5/YMjnL7pUlEIoiUeRLX1eiQK11qxqXbx28/a
         OdW+4Zuq2hs70u0dgtxBdY6j5CtbDQfms2eyYV1iIP9eMBF3f6iZaZMmnsookYiXAvBa
         SqJIiokjpkIc/l+gz2XVzK2NjH/iqpawKqHc7eGfv4JQ4MiLHA9m9DAISAgNwaxoOub7
         VYyB0nlSfdmwTUcN01brAtYe2HY/Wce3mutxjn3KmYxgOQnzAvFnm2Y+8zZRRUm6TdD0
         ZvTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IaPCaFCHuJQneePrqd68vBnsJF+MzsPrh4FvA+iHfzE=;
        b=uUfb+Rp3tuh36tGek9y5Z73K26IgUBazY+zn630rD1EvvFhoHcbDaoiwrNJHTfyL6F
         BZC7jYi4E70zZYArctEpyl0brqSTO4gad6vuoG7hozaxvoLxS2j4WoqvFWRxa9jYdpw6
         9vXXDrgb0y83G/XYSBbfUU80MpAmHpzCpYSbh4F31NuPCXOTENYShEqmwWeLmLKUkkFv
         r5xqfSQl5zno6PNLW5RsCVhbHQF4p/mv5AoIL4Ms5zjtoheJj6GykDbtwLFfHF5s7+bC
         qobbU7L0xdWpg+iGAXZrgLKeZs36kiXwqKLk3M3dyzLpX/S0I9Wjf9wHe/JLTgpL+MvO
         wCbQ==
X-Gm-Message-State: AOAM530QRu/Obnba/OAkx87MLPNliITes7vozwuNn5Ikmyyh03MsWePJ
        0criWibSRFnUX3zfyEOTDgHACQ==
X-Google-Smtp-Source: ABdhPJyMRIgFMVWRa72QLRCoypAvMPvF/ocxU/Mr/PZmNprFTp5JuOmTLGZWikWWLAMT7evse/AAcA==
X-Received: by 2002:a9d:261:: with SMTP id 88mr2045432otb.202.1606193472833;
        Mon, 23 Nov 2020 20:51:12 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id w6sm7845466otj.12.2020.11.23.20.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 20:51:12 -0800 (PST)
Date:   Mon, 23 Nov 2020 22:51:10 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        linux-pm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Lina Iyer <ilina@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] cpuidle: arm: qcom: fix Kconfig problems
Message-ID: <20201124045110.GH95182@builder.lan>
References: <20201124013053.11502-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124013053.11502-1-rdunlap@infradead.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon 23 Nov 19:30 CST 2020, Randy Dunlap wrote:

> The Kconfig symbol ARM_QCOM_SPM_CPUIDLE wildly selects other
> Kconfig symbols when it should not.
> This causes kconfig warnings and subsequent build errors,
> as listed below, so modify this symbol's Kconfig entry to
> constrain and tame it.
> 
> WARNING: unmet direct dependencies detected for QCOM_SCM
>   Depends on [n]: ARM [=y] && HAVE_ARM_SMCCC [=n] || ARM64
>   Selected by [y]:
>   - ARM_QCOM_SPM_CPUIDLE [=y] && CPU_IDLE [=y] && (ARM [=y] || ARM64) && (ARCH_QCOM [=n] || COMPILE_TEST [=y]) && !ARM64
> 
> WARNING: unmet direct dependencies detected for ARM_CPU_SUSPEND
>   Depends on [n]: ARCH_SUSPEND_POSSIBLE [=n]
>   Selected by [y]:
>   - ARM_QCOM_SPM_CPUIDLE [=y] && CPU_IDLE [=y] && (ARM [=y] || ARM64) && (ARCH_QCOM [=n] || COMPILE_TEST [=y]) && !ARM64
> 
> and
> 
> arm-linux-gnueabi-ld: arch/arm/kernel/sleep.o: in function `__cpu_suspend':
> (.text+0x68): undefined reference to `cpu_sa110_suspend_size'
> arm-linux-gnueabi-ld: arch/arm/kernel/suspend.o: in function `__cpu_suspend_save':
> suspend.c:(.text+0x138): undefined reference to `cpu_sa110_do_suspend'
> arm-linux-gnueabi-ld: suspend.c:(.text+0x170): undefined reference to `cpu_sa110_do_resume'
> arm-linux-gnueabi-ld: drivers/firmware/qcom_scm-smc.o: in function `__scm_smc_do_quirk':
> qcom_scm-smc.c:(.text+0x54): undefined reference to `__arm_smccc_smc'
> arm-linux-gnueabi-ld: drivers/firmware/qcom_scm-legacy.o: in function `scm_legacy_call':
> qcom_scm-legacy.c:(.text+0x168): undefined reference to `__arm_smccc_smc'
> arm-linux-gnueabi-ld: drivers/firmware/qcom_scm-legacy.o: in function `scm_legacy_call_atomic':
> qcom_scm-legacy.c:(.text+0x2e0): undefined reference to `__arm_smccc_smc'
> 
> Fixes: a871be6b8eee ("cpuidle: Convert Qualcomm SPM driver to a generic CPUidle driver")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: linux-pm@vger.kernel.org
> Cc: Andy Gross <agross@kernel.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: linux-arm-msm@vger.kernel.org
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Stephan Gerhold <stephan@gerhold.net>
> Cc: Lina Iyer <ilina@codeaurora.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  drivers/cpuidle/Kconfig.arm |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> --- linux-next-20201123.orig/drivers/cpuidle/Kconfig.arm
> +++ linux-next-20201123/drivers/cpuidle/Kconfig.arm
> @@ -108,10 +108,11 @@ config ARM_TEGRA_CPUIDLE
>  config ARM_QCOM_SPM_CPUIDLE
>  	bool "CPU Idle Driver for Qualcomm Subsystem Power Manager (SPM)"
>  	depends on (ARCH_QCOM || COMPILE_TEST) && !ARM64
> +	depends on PM
>  	select ARM_CPU_SUSPEND
>  	select CPU_IDLE_MULTIPLE_DRIVERS
>  	select DT_IDLE_STATES
> -	select QCOM_SCM
> +	select QCOM_SCM if HAVE_ARM_SMCCC

I presume the trigger for this error is that 'd0511b5496c0 ("firmware:
QCOM_SCM: Allow qcom_scm driver to be loadable as a permenent module")'
made QCOM_SCM user selectable and described the dependency on
HAVE_ARM_SMCCC..

So given that, and the fact that this driver doesn't do anything without
QCOM_SCM, can we instead make it "depends on QCOM_SCM"? I believe it
would inherit the dependency of HAVE_ARM_SMCCC in this case?

Regards,
Bjorn

>  	help
>  	  Select this to enable cpuidle for Qualcomm processors.
>  	  The Subsystem Power Manager (SPM) controls low power modes for the

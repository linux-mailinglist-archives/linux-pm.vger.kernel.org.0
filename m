Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9395B0F3D
	for <lists+linux-pm@lfdr.de>; Wed,  7 Sep 2022 23:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbiIGViS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Sep 2022 17:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiIGViR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Sep 2022 17:38:17 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B49B7EFB
        for <linux-pm@vger.kernel.org>; Wed,  7 Sep 2022 14:38:16 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id d68so12542552iof.11
        for <linux-pm@vger.kernel.org>; Wed, 07 Sep 2022 14:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=6rBN7kbnMQYf7kObJ9WtbMZk6eRV31FVrweeYnfKHJo=;
        b=GsBUnRMkGO5dIw7tKSqvNBSv8O6uCa4sXvZoRyGF82NiJatez4G6FekKpAO2g5lHhb
         ioBB06C8djv7sgDL5LJVAzCbNMAsD4opDc/GlUhhS/HCAc7i5bP5S29gHxqJXDeIORxA
         wji2yJFZQJdtAeGEO2Y3xGnoGpDil7p7ZMFt4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=6rBN7kbnMQYf7kObJ9WtbMZk6eRV31FVrweeYnfKHJo=;
        b=W8E5ctTl5HyA8ZBp4a/J+0khl+ii9QKgCfOWCN13z6/Rkkr2oNAeD5HJn9x85HLO6t
         QO9cpfZcnnMk5ebLtKdOKB6OizxsW14LjsSxqsz20FRZfjhMxTu9TsRnDebgN0h9UoEo
         NOoOYacnozW8KsUauLWEO2KOj1Ue/xDvCGnfnVKq9/0the0VT1xof2b34fCagkmOFGEj
         DP/GW/lkloyAXYCvgKIJQtUT0wd0fjtdq5+behkJQhmWgQMrWI2MV99RSZL8VuVO2Ghu
         kaLPKfGZ+lDleufJ2EfH2fmTyhxS8+rtb1XUPM9TGZ3OCz5v3L4X2O91TcBnAnDUbKJy
         gBdg==
X-Gm-Message-State: ACgBeo1xaostR+lh3fVfrenyEJB4g1sqi+kCKL/AZQyZS707W0cp8vVN
        /BTj0wNb74jtWv26GqV3Aua5FQ==
X-Google-Smtp-Source: AA6agR6B39GPaBcn12tQVkSuKNn+ADOzyYixhCwj8vYzrAK2PbdGI8JoV2lX1SICEk5Fv3cheNeRtQ==
X-Received: by 2002:a05:6602:160c:b0:68a:9ed3:e6ff with SMTP id x12-20020a056602160c00b0068a9ed3e6ffmr2641420iow.207.1662586696063;
        Wed, 07 Sep 2022 14:38:16 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id a191-20020a0216c8000000b003583635ab97sm569577jaa.28.2022.09.07.14.38.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Sep 2022 14:38:15 -0700 (PDT)
Message-ID: <23414197-aa0b-a5fb-a818-35873f7b0482@linuxfoundation.org>
Date:   Wed, 7 Sep 2022 15:38:14 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [Suggested-by:Shuah Khan Patch V2 1/1] cpufreq: amd-pstate: Add
 explanation for X86_AMD_PSTATE_UT
Content-Language: en-US
To:     Meng Li <li.meng@amd.com>, Huang Rui <ray.huang@amd.com>,
        linux-pm@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Perry Yuan <Perry.Yuan@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220905071418.1518338-1-li.meng@amd.com>
 <20220905071418.1518338-2-li.meng@amd.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20220905071418.1518338-2-li.meng@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 9/5/22 01:14, Meng Li wrote:
> This kernel module is used for testing. It's safe to say M here.
> It can also be built-in without X86_AMD_PSTATE enabled.
> Currently, only tests for amd-pstate are supported. If X86_AMD_PSTATE
> is set disabled, it can tell the users test can only run on amd-pstate
> driver, please set X86_AMD_PSTATE enabled.
> In the future, comparison tests will be added. It can set amd-pstate
> disabled and set acpi-cpufreq enabled to run test cases, then compare
> the test results.
> 
> Signed-off-by: Meng Li <li.meng@amd.com>
> ---
>   drivers/cpufreq/Kconfig.x86                         | 12 +++++++-----
>   tools/testing/selftests/amd-pstate/amd-pstate-ut.sh |  1 +
>   2 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
> index fd1582716c58..310779b07daf 100644
> --- a/drivers/cpufreq/Kconfig.x86
> +++ b/drivers/cpufreq/Kconfig.x86
> @@ -58,11 +58,13 @@ config X86_AMD_PSTATE_UT
>   	help
>   	  This kernel module is used for testing. It's safe to say M here.
>   
> -	  It can be modprobed even without amd-pstate module.
> -	  When the comparison test is performed, it can load other module
> -	  like acpi-cpufreq to test cases, then compare the test results.
> -	  When only the test for amd-pstate is performed, it can tell the
> -	  users they loaded a wrong module like acpi-cpufreq.
> +	  It can also be built-in without X86_AMD_PSTATE enabled.
> +	  Currently, only tests for amd-pstate are supported. If X86_AMD_PSTATE
> +	  is set disabled, it can tell the users test can only run on amd-pstate
> +	  driver, please set X86_AMD_PSTATE enabled.
> +	  In the future, comparison tests will be added. It can set amd-pstate
> +	  disabled and set acpi-cpufreq enabled to run test cases, then compare
> +	  the test results.
>   
>   config X86_ACPI_CPUFREQ
>   	tristate "ACPI Processor P-States driver"
> diff --git a/tools/testing/selftests/amd-pstate/amd-pstate-ut.sh b/tools/testing/selftests/amd-pstate/amd-pstate-ut.sh
> index 273364650285..f8e82d91ffcf 100755
> --- a/tools/testing/selftests/amd-pstate/amd-pstate-ut.sh
> +++ b/tools/testing/selftests/amd-pstate/amd-pstate-ut.sh
> @@ -32,6 +32,7 @@ fi
>   scaling_driver=$(cat /sys/devices/system/cpu/cpufreq/policy0/scaling_driver)
>   if [ "$scaling_driver" != "amd-pstate" ]; then
>   	echo "$0 # Skipped: Test can only run on amd-pstate driver."
> +	echo "$0 # Please set X86_AMD_PSTATE enabled."
>   	echo "$0 # Current cpufreq scaling drvier is $scaling_driver."
>   	exit $ksft_skip
>   fi

This patch doesn't apply on top of the previous patch series in
linux-kselftest next - please rebase and resend the patch.

thanks,
-- Shuah

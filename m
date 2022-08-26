Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9003C5A317C
	for <lists+linux-pm@lfdr.de>; Fri, 26 Aug 2022 23:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbiHZVtF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Aug 2022 17:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345131AbiHZVsD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Aug 2022 17:48:03 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F0A0E68F5
        for <linux-pm@vger.kernel.org>; Fri, 26 Aug 2022 14:47:30 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id j5so3563823oih.6
        for <linux-pm@vger.kernel.org>; Fri, 26 Aug 2022 14:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc;
        bh=CK+sMbdIAIuWYSo5Q4OVGY5Ul3jZA6hp/WZ7+Gsk4cQ=;
        b=ik5XLFmUCEL3+etpXE3CESeQSxuv7z4LNhd3MBNm4AFJnjhT76KtIcOP4M+YeH3f7i
         p+7fb+v0bmdH6qDd0a7ZsmguGENWHDe+O/OP1oI2sKKsuGAsxm4WINsjmiFyvl9b4zUR
         Rxf7OVPtrPqcK4mA+kK9o85IC/9b8Xwu9cvZc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc;
        bh=CK+sMbdIAIuWYSo5Q4OVGY5Ul3jZA6hp/WZ7+Gsk4cQ=;
        b=kXC0u1TPqZyX7dndSio0S3+qu1rvAjISWjr6/6TBOaf+tBP3tcERcWgLW5LFudqDlw
         Ft3wX03DsFE1A25yynMhgdH9q/OE3UIuRhtWlr5JjdvcAsaKguDEYzzEsUdNNOycJMxl
         IQRuIujK2lABcTM4oieNl0mG5dASF0iWGKYoyMN/ev25NgMbYwgl6k/SofdlPdjQSbd9
         XA/bZ8Gb6TgujBjRDOe2xfQ0Eb2P1+9XICcBsdghDd5VySrXzh9FzrMBRZpyf6FxQ8f5
         5W88Nk3CSkZtsmrV9LtWCrLga1Wppac9cVMB7lPe+mdtzIK0yeKMDSTKsbCMQONSgW/9
         EObg==
X-Gm-Message-State: ACgBeo2pdRtuMP0FWdHdpKqUDl69COxuSfeT6Y3Gv6RUAY/kqj5SEu9c
        hSFoUGE8Vz0oTseBUyfM93q/KA==
X-Google-Smtp-Source: AA6agR4xAqtIsz06Lx9OywleQrMSR01DmaFjYxlIxy9gZ+7x9P0vfYm+nLME0yrsLu2sV2xjrsGl+A==
X-Received: by 2002:aca:38c1:0:b0:345:8c44:f2bd with SMTP id f184-20020aca38c1000000b003458c44f2bdmr2560444oia.80.1661550448873;
        Fri, 26 Aug 2022 14:47:28 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id q16-20020a05683033d000b00638dd127f54sm1611375ott.1.2022.08.26.14.47.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Aug 2022 14:47:28 -0700 (PDT)
Subject: Re: [RESEND PATCH 2/4] cpufreq: amd-pstate: Add test module for
 amd-pstate driver
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
References: <20220817034630.1172065-1-li.meng@amd.com>
 <20220817034630.1172065-3-li.meng@amd.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <0f9706b7-6dd5-663d-70cf-7221b5a1bfc5@linuxfoundation.org>
Date:   Fri, 26 Aug 2022 15:47:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220817034630.1172065-3-li.meng@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 8/16/22 9:46 PM, Meng Li wrote:
> Add amd-pstate-ut test module, this module is used by kselftest
> to unit test amd-pstate functionality. This module will be
> expected by some of selftests to be present and loaded.
> 
> Signed-off-by: Meng Li <li.meng@amd.com>
> Acked-by: Huang Rui <ray.huang@amd.com>
> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
> ---
>   drivers/cpufreq/Kconfig.x86     |   7 +
>   drivers/cpufreq/Makefile        |   1 +
>   drivers/cpufreq/amd-pstate-ut.c | 293 ++++++++++++++++++++++++++++++++
>   3 files changed, 301 insertions(+)
>   create mode 100644 drivers/cpufreq/amd-pstate-ut.c
> 
> diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
> index 55516043b656..fdd819069d72 100644
> --- a/drivers/cpufreq/Kconfig.x86
> +++ b/drivers/cpufreq/Kconfig.x86
> @@ -51,6 +51,13 @@ config X86_AMD_PSTATE
>   
>   	  If in doubt, say N.
>   
> +config X86_AMD_PSTATE_UT
> +	tristate "selftest for AMD Processor P-State driver"
> +	depends on X86 && ACPI_PROCESSOR
> +	default n
> +	help
> +	  This kernel module is used for testing. It's safe to say M here.
> +

Shouldn't this X86_AMD_PSTATE_UT depend on X86_AMD_PSTATE?
I am running a few tests and when I have X86_AMD_PSTATE_UT
enabled as built-in and X86_AMD_PSTATE is disabled, test
fails saying incorrect cpufreq driver?

Skipped: Test can only run on amd-pstate driver.

So it sounds like X86_AMD_PSTATE_UT depends on X86_AMD_PSTATE.

thanks,
-- Shuah

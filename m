Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6AC405F53
	for <lists+linux-pm@lfdr.de>; Fri, 10 Sep 2021 00:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343920AbhIIWSE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Sep 2021 18:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344616AbhIIWSC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Sep 2021 18:18:02 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 049FBC061574
        for <linux-pm@vger.kernel.org>; Thu,  9 Sep 2021 15:16:53 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id a22so4365040iok.12
        for <linux-pm@vger.kernel.org>; Thu, 09 Sep 2021 15:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+P2JcKjAsSoxmGdXp+O/QkWzrXRZ4Yp1RixAXUcpagE=;
        b=enMlHTYGb3Q/1uuRR705TC2ffjiBKCBq+N+e7Sa6mGAawQAqXCA+xu60GW6GNC2INi
         7cjHFiTH1inXxSsIG3I7S+MMH4WJF1Lzc6tsR/n6v55FqaXMTaihKyDHsvOL0V/mewRi
         GyC4uArjSMRZgeEo/bO1Ahvz+XghvnQYFMNG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+P2JcKjAsSoxmGdXp+O/QkWzrXRZ4Yp1RixAXUcpagE=;
        b=vu/ZqvoFyb3EWNPaPeCOji4vKS32vMZZd6Axm/YtFh4z/8z9pxVdmjrRX2nVEW5sjR
         tuxz61J2DwrrJ7uZvDyVjswRYrrIFngLV5GBA40LdMYYKXuDyM2BBghypED1Y6QsQ0qh
         RB8x1boqN/ywFCRJn0S9SICY+X85LqrbqpP5EgEN1OQuh2udxzHJsC4HjWOtmMdp7qpb
         qfu3BAYz+x5P2TQfJO4gPyAjLFlxFdOHyk+UeLW2yHiv4ExijW5ntW54J148kI/KwEyv
         RRWMrW+XzXPRz8svEAo1LXjQuOBvP2UUqqkhnimmvv3j3U39VRZTskTNS97a1GczOnvD
         DCFw==
X-Gm-Message-State: AOAM532/Ji9SieuhHvuF7lDv3vG5C+D6//AsbonUUo4IbP+9ibAiV/p9
        oYZz8/qGy11iolFctIcAgrM9Zw==
X-Google-Smtp-Source: ABdhPJy1BgCvYD7Qnx3OJPvBP7ag/tSPh8rixeiagw5O2qCJiesCg7c9AwfXtneROd0QncFQMRTvtg==
X-Received: by 2002:a5d:9e09:: with SMTP id h9mr4506574ioh.164.1631225812461;
        Thu, 09 Sep 2021 15:16:52 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id c10sm1501659ilq.77.2021.09.09.15.16.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Sep 2021 15:16:51 -0700 (PDT)
Subject: Re: [PATCH 14/19] cpupower: initial AMD P-state capability
To:     Huang Rui <ray.huang@amd.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@kernel.org>,
        linux-pm@vger.kernel.org
Cc:     Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210908150001.3702552-1-ray.huang@amd.com>
 <20210908150001.3702552-15-ray.huang@amd.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <b030e734-e294-9bf5-ce88-a9e2970da0ef@linuxfoundation.org>
Date:   Thu, 9 Sep 2021 16:16:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210908150001.3702552-15-ray.huang@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 9/8/21 8:59 AM, Huang Rui wrote:
> If kernel enables AMD P-state, cpupower won't need to respond ACPI
> hardware P-states function anymore.
> 

This commit log doesn't seem to match the code change. I see it
calling cpupower_amd_pstate_enabled() and setting flags.

> Signed-off-by: Huang Rui <ray.huang@amd.com>
> ---
>   tools/power/cpupower/utils/helpers/cpuid.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/tools/power/cpupower/utils/helpers/cpuid.c b/tools/power/cpupower/utils/helpers/cpuid.c
> index 72eb43593180..78218c54acca 100644
> --- a/tools/power/cpupower/utils/helpers/cpuid.c
> +++ b/tools/power/cpupower/utils/helpers/cpuid.c
> @@ -149,6 +149,19 @@ int get_cpu_info(struct cpupower_cpu_info *cpu_info)
>   		if (ext_cpuid_level >= 0x80000008 &&
>   		    cpuid_ebx(0x80000008) & (1 << 4))
>   			cpu_info->caps |= CPUPOWER_CAP_AMD_RDPRU;
> +
> +		if (cpupower_amd_pstate_enabled(0)) {

What is the reason for calling this function with cpu id = 0?


> +			cpu_info->caps |= CPUPOWER_CAP_AMD_PSTATE;
> +
> +			/*
> +			 * If AMD P-state is enabled, the firmware will treat
> +			 * AMD P-state function as high priority.
> +			 */
> +			cpu_info->caps &= ~CPUPOWER_CAP_AMD_CPB;
> +			cpu_info->caps &= ~CPUPOWER_CAP_AMD_CPB_MSR;
> +			cpu_info->caps &= ~CPUPOWER_CAP_AMD_HW_PSTATE;
> +			cpu_info->caps &= ~CPUPOWER_CAP_AMD_PSTATEDEF;
> +		}
>   	}
>   
>   	if (cpu_info->vendor == X86_VENDOR_INTEL) {
> 

thanks,
-- Shuah

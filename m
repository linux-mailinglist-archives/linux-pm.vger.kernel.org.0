Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5E9300DB0
	for <lists+linux-pm@lfdr.de>; Fri, 22 Jan 2021 21:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729251AbhAVU2g (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Jan 2021 15:28:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729915AbhAVU0b (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Jan 2021 15:26:31 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53480C0613D6
        for <linux-pm@vger.kernel.org>; Fri, 22 Jan 2021 12:23:10 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id h11so13720258ioh.11
        for <linux-pm@vger.kernel.org>; Fri, 22 Jan 2021 12:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=9zlW2lUUFq94a13H+Bafe0Un7K52KcvjGZoo5gL5FNQ=;
        b=DEcMA/aHIITXo2glOdJIFeUrpOemjBS4r4FO8QOL2msXtLnoofFI4wVgt5UIDcL4m7
         d7olgXzRgwYuoYmlcH+/EFl39wMRVgFfH8k/CwWVcniw3/CTZvcCo3KU3/xcodqJo3vq
         Hd6aQc170oX51155kP7R5p03JpwS7m0Ke4fSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9zlW2lUUFq94a13H+Bafe0Un7K52KcvjGZoo5gL5FNQ=;
        b=MHKr1AcRvsdSwGEOfmz4Ceh++uefHPJ56YARvvtsENj47nYiJtI21H4dkRvWTqwl8s
         9P5cNBkdOz7K+2tKQl3mfToqiv1a4z1a9xpfTDe1o7nJfPfXYsUNwcXqnPBWi8VBhp13
         uBXRfCoTIqdl57ms01XVdF+PcB08fDLzILd7i9ZDNF+DfvUMwSD3dAUFvclhtJf0348d
         mwjwmw2EImCtWzBUq7t3dYqAH+jxS5ew4DGTCmxl1nHmceoc0WHQ5MAMg5c3nt/Fm6rw
         3fNGztr6hNINypekD6NT4p99z7oOtkRmtZ4JBHZtow5gMMwBh2vqRB7UuULQPRWk46lz
         jImA==
X-Gm-Message-State: AOAM531xLEzpeQdY6faBPn5QKlQGHN9hDXdPOEhjiynIsNFey00G2n0p
        zCN6NZ8Y35Ec2VI24u6E98DZONNMfowT8g==
X-Google-Smtp-Source: ABdhPJwcn8nRuo6Qb686uL+p/vPB+9tyIaVgT9p4fktoVA2x6YM1lKkssKnHF7j5oip7gz4/ni5oig==
X-Received: by 2002:a5d:8887:: with SMTP id d7mr4647810ioo.151.1611346989709;
        Fri, 22 Jan 2021 12:23:09 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id u3sm6684919ilg.48.2021.01.22.12.23.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jan 2021 12:23:09 -0800 (PST)
Subject: Re: [PATCH 3/8] cpupower: Add CPUPOWER_CAP_AMD_HW_PSTATE cpuid caps
 flag
To:     Nathan Fontenot <nathan.fontenot@amd.com>, rrichter@amd.com,
        shuah@kernel.org, linux-kernel@vger.kernel.org, trenn@suse.com,
        linux-pm@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <161133705833.59625.6935511700675018185.stgit@ethanol01c7-host.amd.com>
 <161133713035.59625.1577978944767511822.stgit@ethanol01c7-host.amd.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <512d7ad9-dac9-7e54-6afc-0bdf60eff8f2@linuxfoundation.org>
Date:   Fri, 22 Jan 2021 13:23:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <161133713035.59625.1577978944767511822.stgit@ethanol01c7-host.amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 1/22/21 10:38 AM, Nathan Fontenot wrote:
> Add a check in get_cpu_info() for the ability to read frequencies
> from hardware and set the CPUPOWER_CAP_AMD_HW_PSTATE cpuid flag.
> The cpuid flag is set when CPUID_80000007_EDX[7] is set,
> which is all families >= 10h. The check excludes family 14h
> because HW pstate reporting was not implemented on family 14h.
> 
> This is intended to reduce family checks in the main code paths.
> 
> Signed-off-by: Nathan Fontenot <nathan.fontenot@amd.com>
> ---
>   tools/power/cpupower/utils/helpers/amd.c     |    6 +-----
>   tools/power/cpupower/utils/helpers/cpuid.c   |   12 +++++++++---
>   tools/power/cpupower/utils/helpers/helpers.h |    1 +
>   3 files changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/power/cpupower/utils/helpers/amd.c b/tools/power/cpupower/utils/helpers/amd.c
> index 34368436bbd6..496844a20fe2 100644
> --- a/tools/power/cpupower/utils/helpers/amd.c
> +++ b/tools/power/cpupower/utils/helpers/amd.c
> @@ -94,11 +94,7 @@ int decode_pstates(unsigned int cpu, unsigned int cpu_family,
>   	union core_pstate pstate;
>   	unsigned long long val;
>   
> -	/* Only read out frequencies from HW when CPU might be boostable
> -	   to keep the code as short and clean as possible.
> -	   Otherwise frequencies are exported via ACPI tables.
> -	*/

Please update comment instead of deleting it.

> -	if (cpu_family < 0x10 || cpu_family == 0x14)
> +	if (!(cpupower_cpu_info.caps & CPUPOWER_CAP_AMD_HW_PSTATE))
>   		return -1;
>   
>   	if (read_msr(cpu, MSR_AMD_PSTATE_LIMIT, &val))
> diff --git a/tools/power/cpupower/utils/helpers/cpuid.c b/tools/power/cpupower/utils/helpers/cpuid.c
> index f9a66a430b72..d577220a193b 100644
> --- a/tools/power/cpupower/utils/helpers/cpuid.c
> +++ b/tools/power/cpupower/utils/helpers/cpuid.c
> @@ -128,9 +128,15 @@ int get_cpu_info(struct cpupower_cpu_info *cpu_info)
>   	/* AMD or Hygon Boost state enable/disable register */
>   	if (cpu_info->vendor == X86_VENDOR_AMD ||
>   	    cpu_info->vendor == X86_VENDOR_HYGON) {
> -		if (ext_cpuid_level >= 0x80000007 &&
> -		    (cpuid_edx(0x80000007) & (1 << 9)))
> -			cpu_info->caps |= CPUPOWER_CAP_AMD_CPB;
> +		if (ext_cpuid_level >= 0x80000007) {
> +			if (cpuid_edx(0x80000007) & (1 << 9))
> +				cpu_info->caps |= CPUPOWER_CAP_AMD_CPB;
> +
> +			if ((cpuid_edx(0x80000007) & (1 << 7)) &&
> +			    cpu_info->family != 0x14)
> +				/* HW pstate was not implemented in family 0x14 */
> +				cpu_info->caps |= CPUPOWER_CAP_AMD_HW_PSTATE;
> +		}
>   
>   		if (ext_cpuid_level >= 0x80000008 &&
>   		    cpuid_ebx(0x80000008) & (1 << 4))
> diff --git a/tools/power/cpupower/utils/helpers/helpers.h b/tools/power/cpupower/utils/helpers/helpers.h
> index a84f85a9dbd2..5f61eefff5b2 100644
> --- a/tools/power/cpupower/utils/helpers/helpers.h
> +++ b/tools/power/cpupower/utils/helpers/helpers.h
> @@ -70,6 +70,7 @@ enum cpupower_cpu_vendor {X86_VENDOR_UNKNOWN = 0, X86_VENDOR_INTEL,
>   #define CPUPOWER_CAP_IS_SNB		0x00000020
>   #define CPUPOWER_CAP_INTEL_IDA		0x00000040
>   #define CPUPOWER_CAP_AMD_RDPRU		0x00000080
> +#define CPUPOWER_CAP_AMD_HW_PSTATE	0x00000100
>   
>   #define CPUPOWER_AMD_CPBDIS		0x02000000
>   
> 
> 

thanks,
-- Shuah

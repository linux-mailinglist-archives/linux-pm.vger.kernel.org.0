Return-Path: <linux-pm+bounces-16518-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6919B1D76
	for <lists+linux-pm@lfdr.de>; Sun, 27 Oct 2024 12:41:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A29E2281A49
	for <lists+linux-pm@lfdr.de>; Sun, 27 Oct 2024 11:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F5E15098F;
	Sun, 27 Oct 2024 11:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EwJXAtrY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFF63F9D2;
	Sun, 27 Oct 2024 11:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730029298; cv=none; b=UvBIz9Vv+vJH/2QpN0Kkemqm/LYU42eIgoHYl+aCQfxP3fJS08YVQIOW52Ano04+1+hSe/sBjvvgC674VsuIzigpDJ7d8MzO0bNsLV5nQKfOH8ME3dpIMEO3jiUuJoxny5IDul+3353073TjQZBq/rkvR5Nl7Mu/Pl6EOVunJ/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730029298; c=relaxed/simple;
	bh=yOAbRloL18h0JY8kf64bci4q71DdsjBEhlEGTvjmWQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u8BGZ9/cGJCMcG7eZuW9xc/Bw2BjC54xha/CpAaj6CZchIbcHUw1sDrHXkAPGaa/5GxBQMgs+NKTMi+1NuzRFK8atL5Zt62DsfZYjqwTC8qPLq59Gnwk7iGzUo4zjO8o8/8qVw/ShbaDta2rOQHk0MiPkIPVqnb1VTk2Nf8m/pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EwJXAtrY; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-539fbe22ac0so3510229e87.2;
        Sun, 27 Oct 2024 04:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730029294; x=1730634094; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QDLuPMd1qfef1Km4eOF6L9ZsucNcLFZnzKLrPsyJGgQ=;
        b=EwJXAtrY9BgN/pOOtbnPBo1/E/5hNMazyisVob4jcMbUOkeOhfGLJih25dpDks5/+z
         5eDITI0wjsWejVySUniz8nEfku1cWiaqiIbj5Q1p713E2GGaVt/Z8VJYQdCf6rs/2v1p
         2AFONiHqTuHzM2zpQP2NqCLJN8h+CsqDemTIYn08MLPY3vDdvrhR5p7B/IlyjuqOyhvE
         Nkn+iSd4JBd6KhtCQ3vKoJv9NLXnx+bHGChK6fOrgTtr5nRLMIcgHsLz+3/T/oUwlG/G
         VgTxT4ZQzTjaNX3BL2pIaAD2rq1m3IQJ+YT6crnSAUKc/OfxdQuRhMdNT/MCMNp8Dmq/
         hFqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730029294; x=1730634094;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QDLuPMd1qfef1Km4eOF6L9ZsucNcLFZnzKLrPsyJGgQ=;
        b=lkmDVwXZ4bGjzH5lRcylS9cGwlJmgZjkMdOu+w8ZLzu4vxkbRq24I6vFuP5fuKjScl
         YRNCp0jda7109Qm97CdwW+QSCeMWmVOHCPfbaZAVS6Es/SDzCksaWYyNaoYmL8/FKkND
         df/9XyBwcvreltrMw1yjIINzLf/whZHCjiGz1s8evj9vDUMtsQ+Gu1oWyB6q5PYQZwPy
         JcXuwBofsf40AwH1I5LjnkwlC/MuDc+pvWlcoV/JzmP53UMVZ3OJpzNG+zh7IwaV3IXL
         vFIexJ7IVjYtixVIJVopi68CtvhutBO8yf0nRuCF86hF5MSLKinmbg53PYvvPHBeBaPE
         ZwRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNvVhSDHNTtBaov+MA+qqOsaImeUV7rDX3RkBJIxOqohzwaQQcf/Kr9/gqWx6pJkwwcR4r3sdWhZgD8L4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYEW8eBPU4ghXs9zYdb7kyjlVc3ohHRVU/3x/UmdAJL0/nlLVT
	JAVfslQ6Ht9+spNL2x3hKOmBpgNbEkOJDGoxvLuCuWVl5iDgxIkC
X-Google-Smtp-Source: AGHT+IGZ6Az5SLD1jmGJVaKuuoxSfcR7ttU/IZJyEDmDHo35PXvzoAdjyqP9bqMIIc1uAe0TJtnCvg==
X-Received: by 2002:a05:6512:1584:b0:539:f26f:d280 with SMTP id 2adb3069b0e04-53b348c38c7mr2109925e87.5.1730029293576;
        Sun, 27 Oct 2024 04:41:33 -0700 (PDT)
Received: from ?IPV6:2001:678:a5c:1202:4fb5:f16a:579c:6dcb? (soda.int.kasm.eu. [2001:678:a5c:1202:4fb5:f16a:579c:6dcb])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e1c877csm764517e87.190.2024.10.27.04.41.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Oct 2024 04:41:31 -0700 (PDT)
Message-ID: <f208714a-ed23-4f7e-a93d-6b6dad193f28@gmail.com>
Date: Sun, 27 Oct 2024 12:41:29 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] cpufreq/amd-pstate: Remove the redundant
 amd_pstate_set_driver() call
To: Mario Limonciello <superm1@gmail.com>,
 Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>, gautham.shenoy@amd.com,
 mario.limonciello@amd.com, perry.yuan@amd.com, rafael@kernel.org,
 viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, klara@kasm.eu
References: <20241017100528.300143-1-Dhananjay.Ugwekar@amd.com>
 <20241017100528.300143-5-Dhananjay.Ugwekar@amd.com>
 <cf9c146d-bacf-444e-92e2-15ebf513af96@gmail.com>
 <5cfc19d6-e171-4049-ad00-5f8474051c9b@gmail.com>
Content-Language: en-US, sv-SE
From: Klara Modin <klarasmodin@gmail.com>
In-Reply-To: <5cfc19d6-e171-4049-ad00-5f8474051c9b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-10-27 05:27, Mario Limonciello wrote:
> 
> 
> On 10/26/24 06:58, Klara Modin wrote:
>> Hi,
>>
>> On 2024-10-17 12:05, Dhananjay Ugwekar wrote:
>>> amd_pstate_set_driver() is called twice, once in amd_pstate_init() 
>>> and once
>>> as part of amd_pstate_register_driver(). Move around code and eliminate
>>> the redundancy.
>>>
>>> Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
>>> ---
>>>   drivers/cpufreq/amd-pstate.c | 12 ++++--------
>>>   1 file changed, 4 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
>>> index 13ee5cac901d..6f6d961879cc 100644
>>> --- a/drivers/cpufreq/amd-pstate.c
>>> +++ b/drivers/cpufreq/amd-pstate.c
>>> @@ -1848,9 +1848,11 @@ static int __init amd_pstate_init(void)
>>>           return -ENODEV;
>>>       }
>>> -    ret = amd_pstate_set_driver(cppc_state);
>>> -    if (ret)
>>> +    ret = amd_pstate_register_driver(cppc_state);
>>> +    if (ret) {
>>> +        pr_err("failed to register with return %d\n", ret);
>>>           return ret;
>>> +    }
>>>       /* capability check */
>>>       if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
>>> @@ -1870,12 +1872,6 @@ static int __init amd_pstate_init(void)
>>>               return ret;
>>>       }
>>> -    ret = amd_pstate_register_driver(cppc_state);
>>> -    if (ret) {
>>> -        pr_err("failed to register with return %d\n", ret);
>>> -        return ret;
>>> -    }
>>> -
>>>       dev_root = bus_get_dev_root(&cpu_subsys);
>>>       if (dev_root) {
>>>           ret = sysfs_create_group(&dev_root->kobj, 
>>> &amd_pstate_global_attr_group);
>>
>>
>> This seems to break boot on my Zen 2 desktop (my Zen 4 laptop is fine, 
>> however). I don't see any messages on the console and nothing shows up 
>> in the pstore either.
>>
>> I'll attach the kernel log from a normal boot (with the patch 
>> reverted) in case it helps.
>>
>> Please let me know if there's anything else you need.
>>
>> Regards,
>> Klara Modin
> 
> Hi,
> 
> Thanks for reporting.  I think this might be a regression on shared 
> memory designs specifically because static calls weren't updated yet.
> 
> Can you try this below diff?
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 206725219d8c9..2f0e29b05963d 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1857,12 +1857,6 @@ static int __init amd_pstate_init(void)
>                  return -ENODEV;
>          }
> 
> -       ret = amd_pstate_register_driver(cppc_state);
> -       if (ret) {
> -               pr_err("failed to register with return %d\n", ret);
> -               return ret;
> -       }
> -
>          /* capability check */
>          if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
>                  pr_debug("AMD CPPC MSR based functionality is 
> supported\n");
> @@ -1881,6 +1875,12 @@ static int __init amd_pstate_init(void)
>                          return ret;
>          }
> 
> +       ret = amd_pstate_register_driver(cppc_state);
> +       if (ret) {
> +               pr_err("failed to register with return %d\n", ret);
> +               return ret;
> +       }
> +
>          dev_root = bus_get_dev_root(&cpu_subsys);
>          if (dev_root) {
>                  ret = sysfs_create_group(&dev_root->kobj, 
> &amd_pstate_global_attr_group);
> 

Moving the it afterwards does fix the issue, thanks!

Tested-by: Klara Modin <klarasmodin@gmail.com>


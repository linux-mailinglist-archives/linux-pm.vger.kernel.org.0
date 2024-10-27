Return-Path: <linux-pm+bounces-16511-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD9C9B1C21
	for <lists+linux-pm@lfdr.de>; Sun, 27 Oct 2024 05:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82F801C20F1F
	for <lists+linux-pm@lfdr.de>; Sun, 27 Oct 2024 04:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31F224B29;
	Sun, 27 Oct 2024 04:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WfdX3s+3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E70748A;
	Sun, 27 Oct 2024 04:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730003239; cv=none; b=IgTbRbwzijJb61ab4BGikrfdfIZfEroLNdes9+uqHRs8yHlWw4DO9+bTETZFAobS8qeRG/3yRfQHrMcLG3L9eSPacSQf178GBzI8C+ZvcR9zgN4yC4B0IaFYs1gv/1GvDbOBWQgqxlibZ87VAKpX01hFv8U4rcEH3cXB7rriG3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730003239; c=relaxed/simple;
	bh=ErZvRMNFTC1JtfD7DlH7USWk//QvBMg14jI626yimY0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gThQHC1IshJVNMVg/Or1thMunSF/OdHyKpigIfECqTz5RMMVWITw7Nx5cX82FysW+ot+1WfY3zT6NZIV/eM2pHdo97n8w+U+bhcJe8cP8M/q4NPd8DYT71cTP0SHexomMkldiC4wW06Zez7YxRGSI7WG8PqGcko7X9SFJn4Wo/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WfdX3s+3; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-288d74b3a91so1859818fac.0;
        Sat, 26 Oct 2024 21:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730003236; x=1730608036; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C3ERsECHBxHLHOagymcD1zigsnGkXaBUgS4zAFSQOKA=;
        b=WfdX3s+3wbipy+0lXQVjpjgpKgWPMR4M5wuhcal8T1/WcCb+JxLcixc/Ec2eg46SOD
         NcnVCvL7xNZuzF4XJU5rZuaWJp/INw76D3/p6st/ScM6SEGGr6B0eOtqKGu1kPNJDLxm
         PGGgDjZHVjVMONELSWpcLKN+3ZmZDeiwaQ0zmh1aypa8VGG7tx8QsJfwTjywErXXitr6
         iiANh9Zzr8Qpyw1M2rLDI83jduNAbZeNy20SqHP7k2l8duHolg2lOmjUSRU9HiQoxlBv
         KgtQzJVOd7nFiOO1vncvTT4DcbZYiAczel977PMXXxIKBisG7+OsLm/iW+H37yQd0Fw4
         SjzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730003236; x=1730608036;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C3ERsECHBxHLHOagymcD1zigsnGkXaBUgS4zAFSQOKA=;
        b=Wi2yXftrBYPUarmkPhPt67kqq4K+UN0nWPVeFTKyFcVM+lVz4T82jUMzqPaF6fwg8y
         f3iuWEZlWyfYKcEJsD3wMRKfXC8f2zJKKNjW9stvLOKWcFOgIm1e5HlrODiHqoKii1DJ
         omyXWuv0wDcYpADzo0hOicxsPQABfdPoDpcUicJ/snKwHTpBpy6YyJByEI/DZzxfiGbo
         Ermh+k0CbzV6QqF6mik+99etSU8iqUW1FCFEyXiA/+RV30ER7vnBfkgZbgC1U0/ySHJb
         ZFVjP3y4HlALEWMYWZjxWyxNprbBqcOJaOYTjvDJRjePP9AYiMm+kEK6GFnhCaCsePaw
         VgnA==
X-Forwarded-Encrypted: i=1; AJvYcCWx+q3vtGkKlW8/3QuhBWPg+OJtF8Rh6A8l2lF9eEmngGPog/+is4HkhcUA4CyaNvDFtrfkdjL4MgbfT1U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWk8Zs33Inx34tjLPzUFRcurAiT462RQdeWy1nd07QoU0CO1lv
	zIYu6Ah7cKJ55dMm4RvEFfPimmDGHiYGDLRhw+NuWPH9P3z43BIh
X-Google-Smtp-Source: AGHT+IGXRBRB5XvgbPVCdvrKM/2Xm5Yc7Cnlexf8ner2J6xCeCzsnPKJydgFYdf7iYsje5aK7U7n4Q==
X-Received: by 2002:a05:6871:29a:b0:27c:4f04:a1f1 with SMTP id 586e51a60fabf-29051dc7c23mr3209798fac.32.1730003236452;
        Sat, 26 Oct 2024 21:27:16 -0700 (PDT)
Received: from ?IPV6:2607:fb91:1219:44f1:b4e8:dada:a078:b601? ([2607:fb91:1219:44f1:b4e8:dada:a078:b601])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7186189e28esm1005170a34.61.2024.10.26.21.27.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Oct 2024 21:27:15 -0700 (PDT)
Message-ID: <5cfc19d6-e171-4049-ad00-5f8474051c9b@gmail.com>
Date: Sat, 26 Oct 2024 23:27:13 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] cpufreq/amd-pstate: Remove the redundant
 amd_pstate_set_driver() call
To: Klara Modin <klarasmodin@gmail.com>,
 Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>, gautham.shenoy@amd.com,
 mario.limonciello@amd.com, perry.yuan@amd.com, rafael@kernel.org,
 viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, klara@kasm.eu
References: <20241017100528.300143-1-Dhananjay.Ugwekar@amd.com>
 <20241017100528.300143-5-Dhananjay.Ugwekar@amd.com>
 <cf9c146d-bacf-444e-92e2-15ebf513af96@gmail.com>
Content-Language: en-US
From: Mario Limonciello <superm1@gmail.com>
In-Reply-To: <cf9c146d-bacf-444e-92e2-15ebf513af96@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/26/24 06:58, Klara Modin wrote:
> Hi,
> 
> On 2024-10-17 12:05, Dhananjay Ugwekar wrote:
>> amd_pstate_set_driver() is called twice, once in amd_pstate_init() and 
>> once
>> as part of amd_pstate_register_driver(). Move around code and eliminate
>> the redundancy.
>>
>> Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
>> ---
>>   drivers/cpufreq/amd-pstate.c | 12 ++++--------
>>   1 file changed, 4 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
>> index 13ee5cac901d..6f6d961879cc 100644
>> --- a/drivers/cpufreq/amd-pstate.c
>> +++ b/drivers/cpufreq/amd-pstate.c
>> @@ -1848,9 +1848,11 @@ static int __init amd_pstate_init(void)
>>           return -ENODEV;
>>       }
>> -    ret = amd_pstate_set_driver(cppc_state);
>> -    if (ret)
>> +    ret = amd_pstate_register_driver(cppc_state);
>> +    if (ret) {
>> +        pr_err("failed to register with return %d\n", ret);
>>           return ret;
>> +    }
>>       /* capability check */
>>       if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
>> @@ -1870,12 +1872,6 @@ static int __init amd_pstate_init(void)
>>               return ret;
>>       }
>> -    ret = amd_pstate_register_driver(cppc_state);
>> -    if (ret) {
>> -        pr_err("failed to register with return %d\n", ret);
>> -        return ret;
>> -    }
>> -
>>       dev_root = bus_get_dev_root(&cpu_subsys);
>>       if (dev_root) {
>>           ret = sysfs_create_group(&dev_root->kobj, 
>> &amd_pstate_global_attr_group);
> 
> 
> This seems to break boot on my Zen 2 desktop (my Zen 4 laptop is fine, 
> however). I don't see any messages on the console and nothing shows up 
> in the pstore either.
> 
> I'll attach the kernel log from a normal boot (with the patch reverted) 
> in case it helps.
> 
> Please let me know if there's anything else you need.
> 
> Regards,
> Klara Modin

Hi,

Thanks for reporting.  I think this might be a regression on shared 
memory designs specifically because static calls weren't updated yet.

Can you try this below diff?

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 206725219d8c9..2f0e29b05963d 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1857,12 +1857,6 @@ static int __init amd_pstate_init(void)
                 return -ENODEV;
         }

-       ret = amd_pstate_register_driver(cppc_state);
-       if (ret) {
-               pr_err("failed to register with return %d\n", ret);
-               return ret;
-       }
-
         /* capability check */
         if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
                 pr_debug("AMD CPPC MSR based functionality is 
supported\n");
@@ -1881,6 +1875,12 @@ static int __init amd_pstate_init(void)
                         return ret;
         }

+       ret = amd_pstate_register_driver(cppc_state);
+       if (ret) {
+               pr_err("failed to register with return %d\n", ret);
+               return ret;
+       }
+
         dev_root = bus_get_dev_root(&cpu_subsys);
         if (dev_root) {
                 ret = sysfs_create_group(&dev_root->kobj, 
&amd_pstate_global_attr_group);



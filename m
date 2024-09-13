Return-Path: <linux-pm+bounces-14190-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD2BF978611
	for <lists+linux-pm@lfdr.de>; Fri, 13 Sep 2024 18:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70E2E285F74
	for <lists+linux-pm@lfdr.de>; Fri, 13 Sep 2024 16:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03BD57CB5;
	Fri, 13 Sep 2024 16:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CuIwLPMo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7C726AD0
	for <linux-pm@vger.kernel.org>; Fri, 13 Sep 2024 16:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726245942; cv=none; b=Vkf7LGVKgdiNwZtqD88OaQ4zUxBquFhurDDtkRimmTUQ1kysRP94ewMtDZqFX8cI7KstpGGnGtguXz1O+U7M87OS4Hw8wHiXtFUckJ8NdC1AUMbEjW+kqkU4RXTOz8mqaL6zecFWQVpP4CmzpkEZE7lL7gpKPT5LnFRxBOlAFrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726245942; c=relaxed/simple;
	bh=AgHQerAb57rcBCz6JKSogX+ZFauFDFx3EVdV6UTcrco=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QC+vuVhC0Lc/A4h4kMP+WJCEtrYs2qkZ/67oyoT6frHmlf8FgbvJF4omtxzT+t8wz0eHRbmUyJfv2q6r8fh/fdxb7pwagXuAaUWYCnr/gKKVikvnEKQ95EpYH7GCNkpjaRjoTJCeqCcryEoDqdQUvx5Wd7s/xvBmDaMlFsDR4FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CuIwLPMo; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3a056727fdfso8206585ab.3
        for <linux-pm@vger.kernel.org>; Fri, 13 Sep 2024 09:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1726245940; x=1726850740; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=npyFg3Dk46cOzCIDE4f6VgEoIuWUfYai1b3VyRjzFMM=;
        b=CuIwLPMoE4M2pS+fJ43HYeX29wYOxzrc6hsR3Ii7idV519a6QV12zG71KxOZuBgkd5
         HBMKOA+/0+gSqvKn039W6DsPIekQq8Ck5nZSA9f1LuOn2znPwWEahAapmwPFoiURHeA6
         j7IErDWlfBnDoEK3GPL/T+MSR5MUL8P+qfUL0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726245940; x=1726850740;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=npyFg3Dk46cOzCIDE4f6VgEoIuWUfYai1b3VyRjzFMM=;
        b=hZ/H2rMUI5OMUyopUwLg/7QI/UiTPgo5LDaQRLKimNDhgE1nHRnikBLIYoNN3+AiM7
         2eslcpYzz9E0/Rr4yDOykUkPT/ho8LEM4RHYobfBXxVeHq6NtsZ7NGxf9u7vg1glmYqv
         MycrI1WIibY9XJFA4FkKGbvyhvYR8PznEV0bjicoHuO+mZDrDpgcWu2aku7nkzfDncxm
         dfV7+yNKfjwEJ6VhTYGiO832nmikJ5RuWJai36x6je6Fw5WamvlviybW2obNcot479Qm
         7ZVr1K4wpktESKHOMRx/oBV4tvgHVBLMbGKlisFfsmTKxKMe0ZmY831Iw/Q2t4wqqzoI
         IgJw==
X-Forwarded-Encrypted: i=1; AJvYcCUxi7Wgv+v2Oc/9hsx+KQ/kR4E0DiMmnO5294OEJQMR84V1yLCj+wAuov0sVz0y/dT7Z/PHFJD5Kw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxKQnqMZhUEyjrwspLSB9matU8a3qrYyXLod7NnlSEkwPWXXf/V
	NhlD064mEx08q8uQCzqJyxenuJGIi22P5sOn+SoLEF7ZntlJQlS4kj2Zsea14YI=
X-Google-Smtp-Source: AGHT+IGg7bjlyIM44j2dnITZ9rXYWGjDovZ+9bdAAVQjM1fDgFlA2BGkSdZm98CGRRx1DvvrvKfD3w==
X-Received: by 2002:a05:6e02:1ca3:b0:3a0:90df:fed4 with SMTP id e9e14a558f8ab-3a090e00079mr4986975ab.24.1726245939751;
        Fri, 13 Sep 2024 09:45:39 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a087bf7ce2sm8665435ab.62.2024.09.13.09.45.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Sep 2024 09:45:39 -0700 (PDT)
Message-ID: <9f71c145-3d0d-42ad-a258-57ef89ec525c@linuxfoundation.org>
Date: Fri, 13 Sep 2024 10:45:38 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH for-next] pm: cpupower: rename raw_pylibcpupower.i
To: "John B. Wyatt IV" <jwyatt@redhat.com>,
 Min-Hua Chen <minhuadotchen@gmail.com>
Cc: jkacur@redhat.com, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, shuah@kernel.org, trenn@suse.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <b64402ad-4c0d-4f5f-939b-4be1a7855e4a@linuxfoundation.org>
 <20240912225519.119392-1-minhuadotchen@gmail.com> <ZuRpzN2OKHQ75GZW@rhfedora>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <ZuRpzN2OKHQ75GZW@rhfedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/13/24 10:35, John B. Wyatt IV wrote:
> On Fri, Sep 13, 2024 at 06:55:19AM +0800, Min-Hua Chen wrote:
>> AFAIK,
>> raw_pylibcpupower.i is not a generated file, it is a interface file
>> for swig.
> 
> That is correct. You can do more advanced things to help SWIG handle
> different languages, but so far with the script I wrote for libcpupower
> simply copying the definition files as worked for me for the .i file.
> 
> See:
> https://www.swig.org/Doc4.2/Preprocessor.html#Preprocessor
> 
>> The *.i file extension is also used for pre-processor output
>> (single target build) and all *.i files are removed by 'make mrproper',
>> including raw_pylibcpupower.i (should not be removed).
> 
> That would explain it. Not just 'make mrproper', but 'make clean'
> in the root removes the file as well. 'make clean' in the tools
> directory does not affect it.
> 
>  From 'man gcc':
> 
>         file.i
>             C source code that should not be preprocessed.
> 

.i extension is used for a C pre-processor out, hence the need to
mrprpoer and clean remove it. Because of that reason, using .i
will not work for swig interface files.

We build files to debug problems and to check the pre-processor
output. So changing mrproper and cleans to not remove .i would
leave the tree dirty.

>>>
>>>> I have reviewed and tested and this. I am good with it being a stopgap.
>>>
>>> I am okay with the stopgap, but I do want i explore other solutions.
> 
> Reviewing the documentation a better solution would be to rename it to .swg
> 
> '''
> 5.1.1 Input format
> 
> As input, SWIG expects a file containing ISO C/C++ declarations and special
> SWIG directives. More often than not, this is a special SWIG interface file
> which is usually denoted with a special .i or .swg suffix.
> '''
> 

This is the reason why I wanted to understand the problem to come up
with a solutions than renaming the file with .if extension.

I am glad to hear .swg can be used. Let's fix this properly then by
renaming the file as raw_pylibcpupower

> https://www.swig.org/Doc4.2/SWIG.html
> 

Please send me patch with the change to rename using .swg extension
and this can be used going forward for other swg interface files.

thanks,
-- Shuah


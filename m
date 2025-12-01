Return-Path: <linux-pm+bounces-38978-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA1CC97FC2
	for <lists+linux-pm@lfdr.de>; Mon, 01 Dec 2025 16:13:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AC9E3A3595
	for <lists+linux-pm@lfdr.de>; Mon,  1 Dec 2025 15:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E99331A547;
	Mon,  1 Dec 2025 15:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EERhaR8S";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gpfa9Iy2"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F9D1F03C5
	for <linux-pm@vger.kernel.org>; Mon,  1 Dec 2025 15:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764602005; cv=none; b=oIf0ce/KqW7NzxgQE73PHOavDjvFDdKiMVSdVCcAOH6xNWToJ2pvCplZi8Vz/aZRxDR8ubEl2KoWKR2YuFoGfDLHIfCQK8nelh9Se74VPrHaTvzubR/9UWIwlkd5aTgTX3HLyc6B9IMNi6aNpstpn3LHt+SJYIVLJJO8qaSnJAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764602005; c=relaxed/simple;
	bh=cJh61bIQVnWr73ImXoCzB2IPG7bPT9LbhOGEaaQhRbw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=dYE24i2JMe/k1BRCHbPux0iOjMyxpWjF+VTS7uNZojutOvuWxFsBNc54R8UkPVJZSMG12dqwW2/4cNlmjlprvsWVSwJZhqQm22nI4BYRldt0qrOp9qbG//7LRn35roII3iOGk+RmrFWt9hq8LJP9rVhwNbHZcNk+bormeUnZYgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EERhaR8S; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gpfa9Iy2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764602002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DyJz4TiV3W1A/RgLWbgSd9svl3wFJjMmLRwv8jmPQ9k=;
	b=EERhaR8SDBvDN6BQCNebjF0uIVVgoEg7eJjlL+k8jgn1DaB5RWneG5p43KIXLvaQvsNjC2
	l1Fm7oa6REOByLoWpCxDt01ZP4xCN1EW/8pFf6z+sjYKlhKQjNLMa5V8W6pQb8UtAAkGKD
	6GFfsEiDfm3PkTmVjt2fjZcMOPMZmvQ=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-buqbvJI3PSWcJJ-FZvjB8g-1; Mon, 01 Dec 2025 10:13:21 -0500
X-MC-Unique: buqbvJI3PSWcJJ-FZvjB8g-1
X-Mimecast-MFC-AGG-ID: buqbvJI3PSWcJJ-FZvjB8g_1764602001
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8b233e206ddso799713585a.3
        for <linux-pm@vger.kernel.org>; Mon, 01 Dec 2025 07:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764602001; x=1765206801; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DyJz4TiV3W1A/RgLWbgSd9svl3wFJjMmLRwv8jmPQ9k=;
        b=Gpfa9Iy2T7M6g4FXWMl1xJquk0RgKmCvbmuQi4sOcHowJVEPvi0zA0jD7B08RV2NWb
         VUiZikOFJTNhAuoX6RM/0beM/GHqEH0VEUfY4HJ5huuD7TV1ETeHmrFiJZeMYNFOAMcU
         qeilEl3SGkFGfS1P5cR8TeXQlZ8GG/rNyVKbm/Gqf7ToNGI/+dYUOovObFFYG+ssZxFk
         X7GdJaCvvLmwv7V1t7IzROp2+I+tqiccvk9c9E+d/dGbL6seJqGMtIYXDX7L/BTcX4dP
         GxWKc/zo6TX8SYNRNKlZH9QfKoDo12yHcPUx0DgZe0Df1GLSJgpngWPadKX4AaEOkMa0
         WWkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764602001; x=1765206801;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DyJz4TiV3W1A/RgLWbgSd9svl3wFJjMmLRwv8jmPQ9k=;
        b=erBKhGS/2uECYry3rQgSEfS9GgsFs6ruWu8q7qOy9fqgIDOnb5rQXGPGtKq+N9ig9m
         1Hv1BH0ce5SHSazCrLaYzgX8pkHUzi7TCF8+BbL9X3FhVzke4BKP6YMTteudRM5chnQE
         bzl6uexrj8Tv0UjESJ8F4h/a/1tYd0526hGnQqaFmE2WzfJVrt6LcX+XATMwY3UNeoG/
         Jeu+m/YjHYWidYS0SGN35MHdIIC0n/PAukgsiERquE3yK7m2OwTWQxcBtFm89vbAtR7D
         kr8wTNEjVPI/z0uKsJg2jr+0jXGzmvSxUu6KFVtvl6OqK5Ch2M7Rq3k+Ed48E1R0p8M5
         0wWg==
X-Gm-Message-State: AOJu0YyPx9tJIbrInLOx0LLHRJStEAl7rWhJSOKGAddMdsX5WSgKAjvt
	NHavENmDxTGURyaF155LwHl84A0oD4sgptCjpfPSHAGGCFGWaPM3UTYZYJ2MGsn5LIVuoJnxSO4
	z3VaPYfJ+HFCAsGBtp+nXd/+GdcwUHdwaLZmW2I0hwb2S9za0DU4jvjwoAwtS
X-Gm-Gg: ASbGncvQ7nBRAovHWG/OgqQYb+Vw5xVXfUMvnuYBkma6fgK990b2gcPes4tnuMXt/gu
	8KNCfTMCslcc48KWnXzczvsq0N0TCKw4naRN8jeg0Rmr0tQpQcRR9A4SJMdq+OGXHAw2pF0Qaku
	USjJmGiba4Jd5kGhId7V6dbQWRPbZlePtHzgWokukNhXtrrqJddavDzv/gyopwpJBF6DTSuoE9H
	EkHPg/nrAR70kCIuPsi5PT5zNiXqYvf4Zzy9MYy5VCL20XE/cDwCoS6bUglINe+jR/XCsT/Rohb
	7Z9Zcr83r4TgB87eZgGpPdWj/bRfBv4x6yvZ+Jn9GXKGGGFfLB0MtTdICSAQjGElzKfuIVp4CKh
	rqLKXJh1mAg==
X-Received: by 2002:a05:620a:17aa:b0:8b2:e8a0:f4e with SMTP id af79cd13be357-8b33d5fb804mr5507779485a.77.1764602000662;
        Mon, 01 Dec 2025 07:13:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHxg9QLwHbhqfQ4ocJlh4I+L2V71ydNVbq8MmzhlOZ+ffbnPuJwEbG35cEXG/8osYHofYV8hA==
X-Received: by 2002:a05:620a:17aa:b0:8b2:e8a0:f4e with SMTP id af79cd13be357-8b33d5fb804mr5507774585a.77.1764602000210;
        Mon, 01 Dec 2025 07:13:20 -0800 (PST)
Received: from [10.26.1.94] ([66.187.232.136])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b529a9c030sm872397185a.21.2025.12.01.07.13.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Dec 2025 07:13:19 -0800 (PST)
Message-ID: <25d6584f-7763-4b6e-92da-e8f1e31ea3df@redhat.com>
Date: Mon, 1 Dec 2025 10:13:18 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] tools/power turbostat: allow turbostat to work when
 aperf is not available
From: David Arcari <darcari@redhat.com>
To: Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251118155813.533424-1-darcari@redhat.com>
 <20251118155813.533424-4-darcari@redhat.com>
 <CAJvTdKmt+3i+TjbYSa--=uS22q1ZgEQuferNhCxKVK_G5Lx2jQ@mail.gmail.com>
 <b2ff2579-0d19-4648-9411-c02133c28c1d@redhat.com>
Content-Language: en-US
In-Reply-To: <b2ff2579-0d19-4648-9411-c02133c28c1d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/25/25 4:55 PM, David Arcari wrote:
> 
> 
> On 11/25/25 2:14 PM, Len Brown wrote:
>> It would be helpful if you could describe exactly what environment you
>> are running in.
> 
> It' a VMWARE instance.
> 
> CPUID(0): AuthenticAMD 0xd CPUID levels
> CPUID(1): family:model:stepping 0x17:0:0 (23:0:0) microcode 0x0
> CPUID(0x80000000): max_extended_levels: 0x8000001f
> CPUID(1): SSE3 - - - - TSC MSR - - -
> CPUID(6): No-APERF, No-TURBO, No-DTS, No-PTM, No-HWP, No-HWPnotify, No- 
> HWPwindow, No-HWPepp, No-HWPpkg, No-EPB
> CPUID(7): No-SGX No-Hybrid
> 
> 
>>
>> are there any MSRs?
> 
> I'm not certain, is there something in particular you are looking for?
> 

rdmsr returns zero for MSR_IA32_APERF and MSR_IA32_MPERF.

>> Is APERF available via perf, but not via MSR?
>> etc.

No.  add_msr_perf_counter() returns -1 as the call to open_perf_counter 
returns -1.

> 
> I don't believe that APERF was available via perf. I'll go back and 
> verify when I have a chance.
> 
> -DA
> 
Is there anything else you need?

Thanks,
-DA



Return-Path: <linux-pm+bounces-38964-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51747C97329
	for <lists+linux-pm@lfdr.de>; Mon, 01 Dec 2025 13:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACA0B3A33BE
	for <lists+linux-pm@lfdr.de>; Mon,  1 Dec 2025 12:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E8730BB86;
	Mon,  1 Dec 2025 12:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TxKPbHjr";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ViT3gJUf"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3712556E
	for <linux-pm@vger.kernel.org>; Mon,  1 Dec 2025 12:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764591524; cv=none; b=r/+8E3P7klyCib6m+7vn/wEAv09DxiEz9vTlYim1rv7WqoL1GNtKT9ihuGorlQx8kl27n7Bps6VhTu2/QXZcR/vJXRZvbBcWqhm0ZW6fqY4BWer6NcWAI9iu4dFB2MU6/uuj1I+6JL2grNr/uzjAOpdJKABSB+/gHuJgd07fjVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764591524; c=relaxed/simple;
	bh=oCHZXbXEVdz5K26qu7KvkuPVN4xxQZUgIPc1punUYiA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vBB63WHC/3NQWFGNG3sG9sQaWLMKEA9ByI3ITWWj15Jw97s3JaxvAvL80AKHkFbrWH5rgk6bDey78QOy7YdTDGv8FLF2q32A/S2+ndTZ8g63SxeiVmDWBjrTTldlcPLCRx02o6jHz+A7grCXpCyMtLB08FtHypYA1taxck+KSfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TxKPbHjr; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ViT3gJUf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764591520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0sUJlSyAUSGPuoTmGrlvdIcvz2TUMh3K5nx8FOyBU/s=;
	b=TxKPbHjrPtoHRu0BYnB9WRVlqd0n4Rl41Nn8vXq45+a/2Y6pOfJfLc2fcYzLI0+I+hqO2H
	0TJhO7BKrrKb2KrSFw9nS+mvJDbkGFZUoRnTUI2tdzS1oxb68RUSqAWFnKuMnGvbTSvsMn
	OewT15wCzqaKbE1c8BRkF6tnyLxdF90=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-DTAinEK7NTu8IZD39_vAFQ-1; Mon, 01 Dec 2025 07:18:39 -0500
X-MC-Unique: DTAinEK7NTu8IZD39_vAFQ-1
X-Mimecast-MFC-AGG-ID: DTAinEK7NTu8IZD39_vAFQ_1764591519
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ee09211413so77454401cf.2
        for <linux-pm@vger.kernel.org>; Mon, 01 Dec 2025 04:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764591519; x=1765196319; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0sUJlSyAUSGPuoTmGrlvdIcvz2TUMh3K5nx8FOyBU/s=;
        b=ViT3gJUfP5neRmRfC+Hsad7EAUasd9KRh56WrNh8Qh8S7dDFk8YGXHnYsE00ZX5RWX
         W9LHQ8ZFF2jNCtV4ha/EdpYTWY7qs2nKWIqutla3+I4/UxxaHBXXGWZsxx+GTQ0u3S6I
         GZzhtEIhrbZDAdzz4FNwduCXiAFa7ej3Kyuj4reDjjrw3tE5MPwAY8GAaSvfOs/PzfAo
         FDY442gpnXThljT1NqKzS0v5m3PrgxLLPuZoYM/cBQtyZ80gba7FNkJKZaoWuHk0SwYk
         RApjD6bZvhSc5L8XdE6RpxNFBJdzp8/iKBy73ugLivAMdOCID2UKe5vVsP92IABwONNh
         xTIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764591519; x=1765196319;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0sUJlSyAUSGPuoTmGrlvdIcvz2TUMh3K5nx8FOyBU/s=;
        b=srB+Iob5Q2pGC3l9QKLUPfW1GQ2JEsFPlZONYC8cCKE4nLsW9qd5JNvtivuVEVWhpx
         8u0Jbic5Vo61OiwEejtmCQHsWgcHMtzW6LXxS917kkeYIkJfnd8ICg+ilR0lpVpwQK2E
         MePrJOmQvB7RCxeFZ4yJWp4Wg5BlsClJZ22MA9Pa8pLaaN/gnynlYwP0fEWJPx4tho+K
         fLMo/JM1+wknChCZMVsHjjr0q9FpHGmYgQWKXPAfFDG5heTYPNkzQARtMLFHpYCG0Fhu
         b2u2HB/7hn93ISUgvMDVIWjlbRlmnqi1ocai0ozduCE2Fq9eWKH89sb3lMvdxMEniQOq
         I5cQ==
X-Gm-Message-State: AOJu0YynNVjHGEN56SNrLpLe32qUY9gmWUow4xCcbADBWeabmh2izy0d
	cZEM6OTnYeGjyJTVUfpy1tWeZxH85WbD3NdPw1NCXHy0MxTgFN/FdqCHtneHAOMkXTOIcTDnKnA
	5PypZEUK83DUOqBe5kNKda6ttxVqTjxkmamFTq7o7HwmdkgCfZJ+ZqkhWMLXK
X-Gm-Gg: ASbGncvGv1mnmf6Qet7vhc/Idaa9vGOqbLD93s60UtreFQmIb8VoxQLX8NO7vI3Q0HG
	v0l7jXFnIS3iLFjV6d5LKBR1Gwar/IaHS/blR4ND9HtE526dk9ofFxXvLNeRc/mPI0l2oRZ0PrH
	icaVwpRfrCO0259HduSWUf5nS9HzVIYqpcnA8dZ3KJDBHOL8NET3qT7f0UceN0nv7SQb6fv9X8G
	/Wa7njQg6r4BJZnkzzJqCxGpM2d7CysQSLQo3cvYbqk0MMdc1N4ADj18JHGET2fobKoBgSY5JC/
	wPhqe9nmGvY+zkHd0j93xx7J0R2t/3Mn/JH5aLOZDRjE90bI4qWiJyeIi3eCE6H4zbbl0J80rGT
	dCrsCwz57bQ==
X-Received: by 2002:ac8:5812:0:b0:4ed:685e:f3d3 with SMTP id d75a77b69052e-4ee58b3ece8mr533090311cf.81.1764591518983;
        Mon, 01 Dec 2025 04:18:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEN6yol5HTKr2uldB/3oVvsj1QC1opMKCsf6GxKBwGiJ4IH5kVwSXOATuZ79XukZteMYFMRTg==
X-Received: by 2002:ac8:5812:0:b0:4ed:685e:f3d3 with SMTP id d75a77b69052e-4ee58b3ece8mr533089771cf.81.1764591518549;
        Mon, 01 Dec 2025 04:18:38 -0800 (PST)
Received: from [10.26.1.94] ([66.187.232.136])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4efd344a188sm73518701cf.33.2025.12.01.04.18.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Dec 2025 04:18:37 -0800 (PST)
Message-ID: <10b3298c-99ab-4567-a793-9f12fa7f1dd0@redhat.com>
Date: Mon, 1 Dec 2025 07:18:36 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] tools/power turbostat: avoid an infinite loop of
 restarts
To: Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251118155813.533424-1-darcari@redhat.com>
 <20251118155813.533424-3-darcari@redhat.com>
 <CAJvTdK=tw76+79sCAa3TbVQwDdv9EGCWVrFvFbHihtH3jNcDWw@mail.gmail.com>
 <41373082-e421-496f-955d-bc9abbf44be4@redhat.com>
 <CAJvTdKm-GThyvWsv8meGDPxymF+2PV0EH=Ny6crO+8MfS5QeLg@mail.gmail.com>
Content-Language: en-US
From: David Arcari <darcari@redhat.com>
In-Reply-To: <CAJvTdKm-GThyvWsv8meGDPxymF+2PV0EH=Ny6crO+8MfS5QeLg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


I'll take a look with that in mind, but this is really a second order 
issue and could be deferred until a latter date.  It's patches 1 and 3 
that resolve the main issue and should be resolved more quickly.

-DA

On 11/27/25 12:45 PM, Len Brown wrote:
> I guess it is sort of an art form upon malfunction to decide whether
> it is fatal or not.
> 
> I suppose if we know that a counter used to work, and it stops working, then we
> are responding to a configuration change.  We don't want to count a
> certain number
> of configuration changes as a fatal error.
> 
> A more useful heuristic may be to recognize when there are failures
> without any intervening successes,
> and if those happen many times per second.  Likely that is the
> infinite loop case we're looking for...
> 
> On Tue, Nov 25, 2025 at 4:51 PM David Arcari <darcari@redhat.com> wrote:
>>
>>
>> I see.  Perhaps this isn't fixable then.  I'll take another look.
>>
>> -DA
>>
>> On 11/25/25 2:12 PM, Len Brown wrote:
>>> this patch introduces a limit of 10-restarts per turbostat lifetime,
>>> down from infinity.
>>>
>>> some turbostat invocations span multiple uses of cpu online/offline --
>>> so this limit will not fly.
>>>
>>> On Tue, Nov 18, 2025 at 10:58 AM David Arcari <darcari@redhat.com> wrote:
>>>>
>>>> There are some error cases where turbostat will attempt to reinitialize
>>>> by calling the re_initialize() function.  The code attempts to avoid
>>>> an infinite loop by checking the value of 'restarted' in one case, but
>>>> not others. It should be checked in all cases of restart.  Additonally,
>>>> the 'restarted' is reset to zero at the start of the loop which also
>>>> needs to be removed.
>>>>
>>>> Signed-off-by: David Arcari <darcari@redhat.com>
>>>> Cc: Len Brown <lenb@kernel.org>
>>>> Cc: linux-kernel@vger.kernel.org
>>>> ---
>>>>    tools/power/x86/turbostat/turbostat.c | 10 +++++-----
>>>>    1 file changed, 5 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
>>>> index 584b0f7f9067..5567b9ecd516 100644
>>>> --- a/tools/power/x86/turbostat/turbostat.c
>>>> +++ b/tools/power/x86/turbostat/turbostat.c
>>>> @@ -6722,7 +6722,11 @@ void turbostat_loop()
>>>>           set_my_sched_priority(-20);
>>>>
>>>>    restart:
>>>> -       restarted++;
>>>> +       if (restarted++ > 10) {
>>>> +               if (!retval)
>>>> +                       retval = -1;
>>>> +               exit(retval);
>>>> +       }
>>>>
>>>>           snapshot_proc_sysfs_files();
>>>>           retval = for_all_cpus(get_counters, EVEN_COUNTERS);
>>>> @@ -6730,13 +6734,9 @@ void turbostat_loop()
>>>>           if (retval < -1) {
>>>>                   exit(retval);
>>>>           } else if (retval == -1) {
>>>> -               if (restarted > 10) {
>>>> -                       exit(retval);
>>>> -               }
>>>>                   re_initialize();
>>>>                   goto restart;
>>>>           }
>>>> -       restarted = 0;
>>>>           done_iters = 0;
>>>>           gettimeofday(&tv_even, (struct timezone *)NULL);
>>>>
>>>> --
>>>> 2.51.0
>>>>
>>>>
>>>
>>>
>>
> 
> 



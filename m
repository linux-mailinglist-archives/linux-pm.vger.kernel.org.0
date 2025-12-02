Return-Path: <linux-pm+bounces-39069-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 46153C9B869
	for <lists+linux-pm@lfdr.de>; Tue, 02 Dec 2025 13:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5D1CA345363
	for <lists+linux-pm@lfdr.de>; Tue,  2 Dec 2025 12:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A227C313285;
	Tue,  2 Dec 2025 12:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="INQ2yBBs";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="nJxXahQs"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150FF27E7EC
	for <linux-pm@vger.kernel.org>; Tue,  2 Dec 2025 12:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764680110; cv=none; b=laXu1cO5x8eRk5PhfjCKE/QJCseaRZOAs23g9H/sR4lQT3qGDPFAo9+Rm753H6AhbgMYk9J783hiZqAfGwr913WnrUg1BWXlsaQKSzL08Tn1mDeRcM9It2ldrlBTwVE3fokSypj3eJMxLcNnMQlLaEmNuQgtr1qaDoKkvvycftM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764680110; c=relaxed/simple;
	bh=IEf6MAMLo9el3TCDM1LU0L8cCge4sIKs35xb2sHnaQs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UZuDIAds3lLPORHhYZw4TKFVT9O6HKbX6gmpBvwDjH9Re82n/0ZZe+Jo7Dj1BLHKV8g78dW1uxx9yeA4lR6LgjfX/TelZtVBleAon1GDy4oMm6LF+28wOWGQHeTcgrveV4akSevTjqM5eOAkJrqNo3A9RG87ZwwntT/Ud6VfjME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=INQ2yBBs; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=nJxXahQs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764680106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p8K/soAEl5Qpe2djewXayQipDTMRKNOonEUZGNR+gzM=;
	b=INQ2yBBsuracJMiUg9JrY4aMBfR0yVoPOaD7SNUn0PsCqIba9pXQ6YMg1R5MW/VMl67s+U
	DmhbJPhjBkKH98Fto1BvEEUJjOR2ALZcx3fgC5IZY3oB+SzQqryTPSmq0DqIG5hMV8VJXf
	FthmEWRjcGj3J4y3P7yeowcWhUDEvAU=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-Ei5k8xnwPaaR-X5MURvA6Q-1; Tue, 02 Dec 2025 07:55:04 -0500
X-MC-Unique: Ei5k8xnwPaaR-X5MURvA6Q-1
X-Mimecast-MFC-AGG-ID: Ei5k8xnwPaaR-X5MURvA6Q_1764680104
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ee04f4c632so75628521cf.3
        for <linux-pm@vger.kernel.org>; Tue, 02 Dec 2025 04:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764680104; x=1765284904; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p8K/soAEl5Qpe2djewXayQipDTMRKNOonEUZGNR+gzM=;
        b=nJxXahQs6lqKv6leOLQPu/w6VnactF7yrmunOrhvrGXAOPgUXk+DJZBp/3bVii/vfs
         J4brdMKNk2n4NEw2lRw+Cb1IZj+11IwPHrG7rBOj3NXnZYKN6VNTCo5SAY1OcmIauRnK
         jewPItrFqPu3fPE8QFJfid+B+DsISAn+zQcZB8hl+P3J4GsJiRrI1FdLXSt+nBC9AMlP
         ZEl/1VysAyVr/SoCw1h1T7mqZTCLkTaEP3AlgyhHXCwYTU25toWDeATWfHNZy6yF9eLn
         skk65FFivGPkO4BLGghAja56NRLzWDPtUGp8VAS2jGc8iwmKdLUNyIhOW4qVy5BWZtqR
         GBgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764680104; x=1765284904;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p8K/soAEl5Qpe2djewXayQipDTMRKNOonEUZGNR+gzM=;
        b=Q3KA32WwuJaVx3Ha7yppmTmTPJOZdcK12XejbhYONhEXdisikIEd+rVr8heVZgopT/
         yZgKR+NPCZ9D3nMiGW13z+ofFQih+jIqJR/2ykn930Yqd7+xPw6ikOFTCq/PVSTCnmbT
         xEZ/PVUc3ojM2s5gFM1VHcuGZZbsADb2sY6+XhRm72BBRpD4PNUTCG0lJIrT2eAdMZig
         XQExMhqMHnlF+duwzt89t5E0+lyeJA109BLbP0GmKN+q1h1atrJyXMIkorxj6IyXrQL7
         tliO/yu9VfOganecM5TgTHBnMi9P9ZvhZVBH5lYESQhiRU/q7bLQ0mmHC8aiF/KC6mg6
         v7zQ==
X-Gm-Message-State: AOJu0YxJT2H/OIA/HrQEzyz0ncK5eMzdhU6gAUvOpif+yliIMNkCO1tK
	9ARhyYVDpiazM3cNuktEepInhaxRbE2yiM4i4SacxqA922bOH6WPrZ8lu8eUlRorwSd/cjnPAlJ
	3C3fjoxPY4yo9oPeKmroOBRLr0HT4PBu/UeOvmhYwHiqRCspINV2FXiCDyRTCTVDtF0xm
X-Gm-Gg: ASbGncvR/EsteXf8glWuga0pCadK3l99D0cmmTjNr3TLqjiq6UsNo0MVMm/WNjLx773
	Jh6wwTYhJDkvdxZ2qN6wEcZ6O/0CjJs+Qf0/qVpo3k09w5eAC8HG5q3VVf89gIG3xrfk06jphB/
	G67yzTC7dm9/YDMSTzkROQd3VRbXncrp3qApR77ipHXDNBR5rKapxTZPKvuZwsGz2SfqKOaM2gG
	hosRxLxZLVEHAwzWo5eC+R5n0rds4YDK6ton3yVQlXLp47exkQ1xkevP/BjqFQQgruMbQOfILK0
	hxokHpMFzZ3nHCUuGfFq0J5trmyUyK22lIOmYoQRwV3BsMaKeI0AzlYDQAfbS3bEm+B/VeuaIKG
	i2KgKqfDzqg==
X-Received: by 2002:ac8:5812:0:b0:4ed:685e:f3d3 with SMTP id d75a77b69052e-4ee58b3ece8mr598584771cf.81.1764680103911;
        Tue, 02 Dec 2025 04:55:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHEEyTUTsKxzjm4jpwtLpYRoFXlpmTOyOsSOoys8fayyV+jq7IenUkgB2Rm759n0EVp2WsX4g==
X-Received: by 2002:ac8:5812:0:b0:4ed:685e:f3d3 with SMTP id d75a77b69052e-4ee58b3ece8mr598584501cf.81.1764680103551;
        Tue, 02 Dec 2025 04:55:03 -0800 (PST)
Received: from [10.26.1.94] ([66.187.232.136])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4efd341f2f8sm90525771cf.22.2025.12.02.04.55.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Dec 2025 04:55:03 -0800 (PST)
Message-ID: <e41340a2-4474-4c36-9ed6-bb73232774b1@redhat.com>
Date: Tue, 2 Dec 2025 07:55:02 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] tools/power turbostat: allow turbostat to work when
 aperf is not available
To: Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251118155813.533424-1-darcari@redhat.com>
 <20251118155813.533424-4-darcari@redhat.com>
 <CAJvTdKmt+3i+TjbYSa--=uS22q1ZgEQuferNhCxKVK_G5Lx2jQ@mail.gmail.com>
 <b2ff2579-0d19-4648-9411-c02133c28c1d@redhat.com>
 <25d6584f-7763-4b6e-92da-e8f1e31ea3df@redhat.com>
 <CAJvTdK=g191mjf3uhXTemZCfoc2iQWSE0n8QtFewvMmCbEojgg@mail.gmail.com>
 <CAJvTdKnBKcXJV5az-2q1MF8b6PU6mxVS2YETgn+OWUKBfOSuZA@mail.gmail.com>
Content-Language: en-US
From: David Arcari <darcari@redhat.com>
In-Reply-To: <CAJvTdKnBKcXJV5az-2q1MF8b6PU6mxVS2YETgn+OWUKBfOSuZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/1/25 3:11 PM, Len Brown wrote:
> Something like this?

Yes - this works.  It's actually nice and clean and actually mitigates 
the need for patch 0001.  Clearly an improvement over my patch 3.

How would you like to proceed?  I could resubmit a single v2 patch (with 
an appropriate explanation).

I'd rather not attempt to solve the retry issue.  It's really a second 
order issue and I don't think I'm the appropriate person to do that work.

-DA

> 
> diff --git a/tools/power/x86/turbostat/turbostat.c
> b/tools/power/x86/turbostat/turbostat.c
> index 5bc47ad5da09..4a847e7e9c65 100644
> --- a/tools/power/x86/turbostat/turbostat.c
> +++ b/tools/power/x86/turbostat/turbostat.c
> @@ -8530,7 +8530,7 @@ void rapl_perf_init(void)
>   /* Assumes msr_counter_info is populated */
>   static int has_amperf_access(void)
>   {
> -       return msr_counter_arch_infos[MSR_ARCH_INFO_APERF_INDEX].present &&
> +       return has_aperf &&
> msr_counter_arch_infos[MSR_ARCH_INFO_APERF_INDEX].present &&
>              msr_counter_arch_infos[MSR_ARCH_INFO_MPERF_INDEX].present;
>   }
> 
> 
> On Mon, Dec 1, 2025 at 2:53 PM Len Brown <lenb@kernel.org> wrote:
>>
>>> ...add_msr_perf_counter() returns -1
>>
>> good.  and then add_msr_counter() succeeds because...
>>
>>> rdmsr returns zero for MSR_IA32_APERF and MSR_IA32_MPERF.
>>
>> Your patch is a good suggestion -- though it checks for APERF only and
>> not for MPERF.
>>
>> We already ran CPUID and cleared has_aperf, so I'm thinking we should
>> be heading this off earlier.  Let me send you a test patch later today.
>>
>> thanks,
>> Len Brown, Intel Open Source Technology Center
> 
> 
> 




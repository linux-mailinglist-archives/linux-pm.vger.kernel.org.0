Return-Path: <linux-pm+bounces-9635-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C87A890F878
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 23:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52EAF2829D3
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 21:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A98D158DCA;
	Wed, 19 Jun 2024 21:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JaQ3MfwY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7252279B84;
	Wed, 19 Jun 2024 21:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718832361; cv=none; b=WZkDZjo0fgwKAlH6lW5Fue+lowPw1KVmtat96yw6T9TRx1PV474yT2q+ap1H+7NwnRquS4KDpYp3R6yPjtAxTi5aE8Cuzzhu17eDVAIfZ6oV5RGwbXBDpKLWxoRiEMLHCwyXOhDjO7IKmtoz8EETgn1W9uf2+TX3oTTcUbrWEeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718832361; c=relaxed/simple;
	bh=aBD2VFYnPNHvFT+5iq75qSOBUnyGOUYBkVR+iKGZZyM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VI4Fg9JNn7/sVE7SJTmAHmev9UIJBhFf3t9Mo+/7ZH4kpLAxZ3nnJCBd94Zan+c2kgm/ThABXIBVlfTQ2iND/HvmHQ3/3/rQLBxf+b2D0YlS74N/MeN7YZIhNtnLCZM7b17dgCoiSPf0n0CTkTC3rpycHOniLF/ZGpcahSD6GJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JaQ3MfwY; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42278f3aea4so2515715e9.1;
        Wed, 19 Jun 2024 14:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718832358; x=1719437158; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DCh72mRRzEKvcJCulnEudIxciFBuMT6TUtPKm0jpyl4=;
        b=JaQ3MfwYKgAxRO0nB2VsG//o5edGMED6Tc4vvPEVxfeUyO3PK5qqcjNS8bFhp9pGie
         svsCo+73rzsTMj/JL2VwrpqZMUXfe0f41TEW0uc7VQxHi20qjdPB/zGpVh4f7BlhKrE4
         DyDxQrdFVlDcF5IoF95ni83MdtG2cONC0saRBeZIS4ZxqO+FQujwtIZsA1wp7M2BRLKb
         AG/Jz2mZqhYTm4YE75Uhhc5iZfUO9cNTZaUSe6TPER1SDdJl0q5LG/gRC5+MJG8oNjMv
         JhTVSVIBiUh0MS0FFKM1kOxZpt63zyf19ZovRh9MVJWkt3EYkybGgC+WTKDmmZP0qL5y
         j0Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718832358; x=1719437158;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DCh72mRRzEKvcJCulnEudIxciFBuMT6TUtPKm0jpyl4=;
        b=heQF34HgvQY7F7WSBHm9kM9Jofs0mDjOLhmvUL4vlqMv6PvKc6LGRyqkSqyeaNP/ev
         a56o6qtzCA/760W5doefEwCw0KI4ITxdY9v2sGhkcO0zUxDtWSrFwhjHlF8nQ90iq86q
         UXxe7hcbsbSq3y8GtLxvpETiPiJgSTvBgNfeowvAMEYP//ta4D98nyISjGyFnCuiBcMI
         oECCnaX12879utElwtBk49weQcaeBbjrhUh+7uJpAMphrh8o1RZOdOdCs8Y/C3SQawwO
         Y5WshJ6L1rD72rQePNjFNbRw8sSBp3jOg8u/RUipQNENLNH3akJIuBF0unGGeX92sAnj
         nfeg==
X-Forwarded-Encrypted: i=1; AJvYcCVv+tkiG/mE8jfeFysanbIjH6RK00xvPzC7T/bOkJjhQox6g7SYmyOSdmxIySCt+7nNSeKqc2s2lgnMFV+HybuAsNcOZzhtNiVhc2HWuDE+gjo2BKhKq1SdThIvTXSrHYnSVzdotAH61hYdQnArTntqLN5v9sYXs4Lptd4ws2qd4bcjrioViXON
X-Gm-Message-State: AOJu0YxdaK//eAs3+o203g5B9OKUvcuRVUSuO6xL6G9kwPJXeXKLlhkB
	B5uD7Cub6BddyqUHSapkiI1GunHn3p10a+Ye9g2uiNA6LzdOQe26
X-Google-Smtp-Source: AGHT+IE78oByMdCj9PE7c6QOG7X5QVkj+xXT0JeLPOFBFYeCUhmWUt42d1UdVjPvkCiPWoQoEM1duQ==
X-Received: by 2002:a05:600c:892:b0:421:5966:ca40 with SMTP id 5b1f17b1804b1-42475175608mr25962225e9.10.1718832357373;
        Wed, 19 Jun 2024 14:25:57 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:1:6960:9f76:b012:ddc2:11de? ([2a01:e0a:1:6960:9f76:b012:ddc2:11de])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3632d8562a1sm3517542f8f.2.2024.06.19.14.25.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jun 2024 14:25:57 -0700 (PDT)
Message-ID: <0021f5f2-67c5-4b20-939d-48c9c1c60cdb@gmail.com>
Date: Wed, 19 Jun 2024 23:25:56 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] Add CPU-type to topology
Content-Language: en-US
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, daniel.sneddon@linux.intel.com, tony.luck@intel.com,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Andrew Cooper <andrew.cooper3@citrix.com>
References: <20240617-add-cpu-type-v1-0-b88998c01e76@linux.intel.com>
 <8d757ea3-87a3-4663-ac76-66b04e33e6b3@gmail.com>
 <20240619015315.3ei5f6rovzdnxovo@desk>
 <bc75ff55161671e4470849ed51baa547f619889d.camel@linux.intel.com>
From: Brice Goglin <brice.goglin@gmail.com>
In-Reply-To: <bc75ff55161671e4470849ed51baa547f619889d.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 19/06/2024 à 12:34, srinivas pandruvada a écrit :
> On Tue, 2024-06-18 at 18:53 -0700, Pawan Gupta wrote:
>> On Tue, Jun 18, 2024 at 02:49:10PM +0200, Brice Goglin wrote:
>>> Le 17/06/2024 à 11:11, Pawan Gupta a écrit :
>>>> Hi,
>>>>
>>>> This series adds support for CPU-type (CPUID.1A.EAX[31-24] on
>>>> Intel) to
>>>> differentiate between hybrid variants P+E, P-only, E-only that
>>>> share the
>>>> same Family/Model/Stepping. One of the use case for CPU-type is
>>>> the
>>>> affected CPU table for CPU vulnerabilities, which can now use the
>>>> CPU-type
>>>> to filter the unaffected variants.
>>>>
>>>> * Patch 1 adds cpu-type to CPU topology structure and introduces
>>>>     topology_cpu_type() to get the CPU-type.
>>>>
>>>> * Patch 2-4 replaces usages of get_this_hybrid_cpu_type() with
>>>>     topology_cpu_type().
>>>>
>>>> * Patch 5-7 Updates CPU-matching infrastructure to use CPU-type.
>>>>
>>>> * Patch 8 cleans up the affected CPU list.
>>>>
>>>> * Patch 9 uses the CPU-type to exclude P-only parts from the RFDS
>>>> affected
>>>>     list.
>>>
>>> Hello
>>>
>>> Is there still a plan to expose this info in sysfs?
>> Sure, if it helps userspace.
>>
>>> Userspace currently uses frequencies to guess which cores are E or
>>> P.
>>> Intel sent some patches several years ago [1], but they got
>>> abandoned
>>> nowhere as far as I know. There was also some discussion about
>>> using a
>>> "capacity" field like ARM does, but IIRC Intel didn't like the idea
>>> in
>>> the end.
>> There can be many ways to expose this information in sysfs. Like this
>> ...
>>
>>> [1] https://lkml.org/lkml/2020/10/2/1208
>> ... exposes /sys/devices/system/cpu/types which, in hybrid parts,
>> creates a
>> subdirectory for each type of CPU. Each subdirectory contains a CPU
>> list
>> and a CPU map that user space can query.
>>
>> The other way is to expose the CPU-type in a file:
>>
>>          /sys/devices/system/cpu/cpuN/type
>>
>> that could return the CPU-type of the CPU N. Is there a preference?
> But you still have to look at frequency or caches as there are Low
> power E-cores which will have same type but different capabilities.


Good point. From this patch series, I understand that the current kernel 
side doesn't care about these different E-cores. However it might be 
good to expose them as different cpu-types (or better name) to userspace ?

Something like type 0 = P-core, 1 = normal E-core, 2 = low power E-core ?

Brice




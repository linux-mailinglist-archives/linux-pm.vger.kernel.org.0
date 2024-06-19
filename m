Return-Path: <linux-pm+bounces-9634-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F6790F86E
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 23:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED7CC2824C6
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 21:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1017E58C;
	Wed, 19 Jun 2024 21:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J6qHzpj9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898A079B84;
	Wed, 19 Jun 2024 21:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718832141; cv=none; b=uBWVVK49r8TwwbP3agVcb5sApwkobhBUL7U4YClnpr3/H4kepIQDyPHpzaefaFEMozO4wK73szEob9RYq1LoJxo9ubm4b3MlldHUMHVK2fMT2h8iHf+3jTv4eOeXgJJjaTjeltycvHqlcpvf5wVvxWNKuNlj+i6wTsLkkQULIVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718832141; c=relaxed/simple;
	bh=2uEHebws1X9dqtvQws5gZF6eCQTI7EkV7dkk5jUUK6c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GczwoEubZjnhoqWLwai9RGMjPnWUEgZBOWkffnhkwSM0VH5IXVIRCtwSOgIv1eRMOs33eJdSHi8/n02Xq2QDe5WLcYiKAH80OMPK+V6sO7AbKlO3XKpU3ZbRH044GU5Y0HegbInoHjj4ImR9eHXGuq/XipCpBBUiF+Bsf91IHDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J6qHzpj9; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-364cdfdaf91so11483f8f.1;
        Wed, 19 Jun 2024 14:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718832138; x=1719436938; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5sx3d5aukNa1OWCQombJgZHBhuiOH8rHHOJskHdIODU=;
        b=J6qHzpj9DCAsvIXAVrChf+Ftq+0k5W9fmbtfk+QzeCHIQa2wjG4k7CVio2ZQyHRPUT
         woXsYldCy37VJbaDKazQLZisWTlcHKTeVnVMkDfTij36WI3KpQd84wSBeokLSGdS0wZE
         gXwlmuuv4LVpYO7TMt+/8FtPWTKxN/gXr0OimKI7vTaAWtWa2vrbI7NYYNnVdXp68tMp
         oJtxEYlya8/5OjDryRTigRU89fm/z+UOS7XUDyS0+nJtqwYTLFi8B8G7OTm+SxyN4yif
         ktDsXpZ07JnMngaLsYlFxPJ3WrqhxF+yBaKHCFmrLRUJ3c5zLl+rzbgWNvXEyP315suC
         33DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718832138; x=1719436938;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5sx3d5aukNa1OWCQombJgZHBhuiOH8rHHOJskHdIODU=;
        b=g+DuMfzayoiEnejfiyS6TQuxC9exGr4pr93RfxGjFW3Cow+8xTzh2Xk+tMkCY9g7Iz
         i7yem7uxkT+Wpdla8YsuK5qcvdxjtfMPtZwFncdxOZEXFQbD5gRjgqIaDBIiSIbwltnJ
         3HftI+BEn52Dbk2RKe8PJha411T7w+moqWyiETb0hOWWjyuH9CYo/fIiQnLE2WNtoKK0
         WRxCNlywD9ON6X/uYnYoGLNtUrCeFXdcBiMoXsEF6Va+6aaFSU2mCJWTaxxGqjI+agPs
         aap6PQbmRzGMoHjtwvbD2Q0d4PbCpmNWsj5OLiU1rBYY+PT3DlB653NzULRI/N3vBPzp
         kVFw==
X-Forwarded-Encrypted: i=1; AJvYcCVXAnY9z85OsnYtZt0imIARK/qCA46xluXwcVaLtJdjLT3G5TS3MVwf6+ajZMRdnnOYKP5lVxc9GWPeSv040dyRzil82+Tg2dX+MLX4wekBltBxEkOIFul7IlkT6W3TJKDOP01nWxKySyC0Gbz7Y8qa9P73PCNT2d8QAtVhOCqThZdSIlJhaAeb
X-Gm-Message-State: AOJu0YwpFJhY6DwXe8yE1cq0tAiDjTriyizxighkufrK1l+G1wQT8mk4
	qXBc8auGr/yDPc1vNevmTcRcyY0xkgQl1cAOQX2TKIB0Z4wYpwjy
X-Google-Smtp-Source: AGHT+IGc3vo6EKnmbemHDWA0UdbLA6WgSAtCwiUPHbsRyCJWFZ6KrymmxNAetUE1FTKl9Na6Td20Mw==
X-Received: by 2002:adf:a381:0:b0:362:a5b2:b62a with SMTP id ffacd0b85a97d-36317c7751amr2420976f8f.33.1718832137618;
        Wed, 19 Jun 2024 14:22:17 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:1:6960:9f76:b012:ddc2:11de? ([2a01:e0a:1:6960:9f76:b012:ddc2:11de])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d0ca0afsm2914015e9.25.2024.06.19.14.22.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jun 2024 14:22:17 -0700 (PDT)
Message-ID: <16994d97-0499-4e3b-8890-328e74adc91d@gmail.com>
Date: Wed, 19 Jun 2024 23:22:16 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] Add CPU-type to topology
Content-Language: en-US
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, daniel.sneddon@linux.intel.com, tony.luck@intel.com,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Andrew Cooper <andrew.cooper3@citrix.com>
References: <20240617-add-cpu-type-v1-0-b88998c01e76@linux.intel.com>
 <8d757ea3-87a3-4663-ac76-66b04e33e6b3@gmail.com>
 <20240619015315.3ei5f6rovzdnxovo@desk>
From: Brice Goglin <brice.goglin@gmail.com>
In-Reply-To: <20240619015315.3ei5f6rovzdnxovo@desk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 19/06/2024 à 03:53, Pawan Gupta a écrit :
> On Tue, Jun 18, 2024 at 02:49:10PM +0200, Brice Goglin wrote:
>> Le 17/06/2024 à 11:11, Pawan Gupta a écrit :
>>> Hi,
>>>
>>> This series adds support for CPU-type (CPUID.1A.EAX[31-24] on Intel) to
>>> differentiate between hybrid variants P+E, P-only, E-only that share the
>>> same Family/Model/Stepping. One of the use case for CPU-type is the
>>> affected CPU table for CPU vulnerabilities, which can now use the CPU-type
>>> to filter the unaffected variants.
>>>
>>> * Patch 1 adds cpu-type to CPU topology structure and introduces
>>>     topology_cpu_type() to get the CPU-type.
>>>
>>> * Patch 2-4 replaces usages of get_this_hybrid_cpu_type() with
>>>     topology_cpu_type().
>>>
>>> * Patch 5-7 Updates CPU-matching infrastructure to use CPU-type.
>>>
>>> * Patch 8 cleans up the affected CPU list.
>>>
>>> * Patch 9 uses the CPU-type to exclude P-only parts from the RFDS affected
>>>     list.
>>
>> Hello
>>
>> Is there still a plan to expose this info in sysfs?
> Sure, if it helps userspace.
>
>> Userspace currently uses frequencies to guess which cores are E or P.
>> Intel sent some patches several years ago [1], but they got abandoned
>> nowhere as far as I know. There was also some discussion about using a
>> "capacity" field like ARM does, but IIRC Intel didn't like the idea in
>> the end.
> There can be many ways to expose this information in sysfs. Like this ...
>
>> [1] https://lkml.org/lkml/2020/10/2/1208
> ... exposes /sys/devices/system/cpu/types which, in hybrid parts, creates a
> subdirectory for each type of CPU. Each subdirectory contains a CPU list
> and a CPU map that user space can query.
>
> The other way is to expose the CPU-type in a file:
>
> 	/sys/devices/system/cpu/cpuN/type
>
> that could return the CPU-type of the CPU N. Is there a preference?


I'd vote for the former.

Brice




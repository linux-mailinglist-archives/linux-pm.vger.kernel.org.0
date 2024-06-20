Return-Path: <linux-pm+bounces-9683-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 064BB9109B4
	for <lists+linux-pm@lfdr.de>; Thu, 20 Jun 2024 17:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 858B0285D9C
	for <lists+linux-pm@lfdr.de>; Thu, 20 Jun 2024 15:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3E51AF6B1;
	Thu, 20 Jun 2024 15:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XFfkYknu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092F91AD486;
	Thu, 20 Jun 2024 15:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718896984; cv=none; b=dSKd1ZW1TA5HtO6t1ycE1vSbsIcUOT6BYv0IzMxncV03o5OFqOyt4s2lVBBosXABs0LjPBOxWaomrBTrB2Cs4OCT0wePMPoBchQGrPipGUljTqzHBUkD8cCX1atxkI/FhAoSVArMu5FBYMxqHi0QM7YODBeakKAZtUUC4LCJqDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718896984; c=relaxed/simple;
	bh=icVkyLRQtfBnDXDL5T2LXmtHl0A/8wSSZwGGLKNXhas=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X2GL2goGAGCQc69zI/R58h9gsJLDyGjrewXcThiWLtVmM3v+B38qu6bGcrziDMLdKK2Hut4bOCVJYINIgwmofNGN5uYxgn68AyUwTr6RWaKlmJ56abOsAdL4cw4Htysn9x9gBHHwP7zn68oS/vjHRHDTbfGhcZw/nhCIAtggNA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XFfkYknu; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ec4a35baddso4478711fa.0;
        Thu, 20 Jun 2024 08:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718896981; x=1719501781; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6IFvd1gKY4Gen8SxIO8TYuBrF9aZdJ83hdWMC4Gaxh4=;
        b=XFfkYknuOi0oOOBjBxCAgbGn35ajAJV2RhUrIap/cOgQiagpTVUUlPTswqCncTIMO6
         4kI+x25iUW9MI/CVqDJl+YrjEwaAaatNYWBFbK3iQnFM2I7TRXx4/V/nBplxCHzyKSI5
         6bbX/5XxMmPxmT9fI6vvJXLcZY4+74cQVhnFiJVFhWM8cVyR9FX2HEye8prj6bJCXA+q
         M48xdNYa+XIc2BWqQLWKtnKPfTMBAH7WL2a3RAnHlnHLyKUVdsFq8pcZJsbIcBZCtK4l
         PWoDBbqOHxcvh30Mf6IyXbbyplVbBEaPrGMaRgZ0aXZTLOXIKjoyuIavDbA5yuV729vs
         /zEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718896981; x=1719501781;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6IFvd1gKY4Gen8SxIO8TYuBrF9aZdJ83hdWMC4Gaxh4=;
        b=BMlpt0z6Bgj+5zfxwY9cK5CTPAcz3cnnNH2TJVvPxfdsGMHLoP+VPkJPo1jnNreQOz
         kUpc4vGHNi6xZrvg67ZWxhQ2VArfWaiOqgGl/tkfNRRJS374LxA3v92xW/dZtl69f6CT
         jZ2hGer971+WgfWExeB+YgiOw45YW/opgpZqg+7yymHnASPUfgdb5WwSgzkLTf+DpGMX
         W+7V2+W0smDkTx++bAIhcJwlZyEqLAivoWoU6quZBk+FJHRFLv/LNKv9uWI+qYDNOd4S
         iiSnTigKjDAX6Cav+F2flacIaiN+r0W0/r1WDlTvheOw56HrRHVyoV3li4BhHB8IvyZ/
         XaWw==
X-Forwarded-Encrypted: i=1; AJvYcCWGEZG8vBLAm6wRvDP30DEThRX8/BqYBGWiVY0/jhs5hfSeZQBHm2aORD0ALwg6g1149aJxlptYyGdLV6b2B/YWtNxKq4yj48KPTmx4V1tWp42fB55pwWUOlZYE6XXpsAHg3++qCwgtgbvRKxqd3/rSnLDEsnz/Ok8qDgjihd+Wx9hvatB7DnyU
X-Gm-Message-State: AOJu0YzI20DgsucVi+DdF6Cx5ROHLVue6KIK1xIYj7mLfIrHBbTXy1Rg
	sHh25bK9LUAqjx93B9Shx0y7azHk9xiTYgovOvlle5ZVDBhjYUOn
X-Google-Smtp-Source: AGHT+IGikVgh8XgKRUtNVxnsSti1UHJwJALTtFYTQFJq7dc9FzLzcT/571ge3KDX9VdgIBKtjqeFjw==
X-Received: by 2002:a2e:9915:0:b0:2eb:e25a:34e5 with SMTP id 38308e7fff4ca-2ec3cfe69eamr35766021fa.34.1718896980462;
        Thu, 20 Jun 2024 08:23:00 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:1:6960:9f76:b012:ddc2:11de? ([2a01:e0a:1:6960:9f76:b012:ddc2:11de])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d0b63a9sm29408395e9.9.2024.06.20.08.22.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 08:23:00 -0700 (PDT)
Message-ID: <ec4eeab6-ce32-4a2f-a32c-dfd95cdd9ccd@gmail.com>
Date: Thu, 20 Jun 2024 17:22:59 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] Add CPU-type to topology
Content-Language: en-US
To: Dave Hansen <dave.hansen@intel.com>,
 srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
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
 <0021f5f2-67c5-4b20-939d-48c9c1c60cdb@gmail.com>
 <1b99017a-6964-46de-ba3a-09552e7cf072@intel.com>
From: Brice Goglin <brice.goglin@gmail.com>
In-Reply-To: <1b99017a-6964-46de-ba3a-09552e7cf072@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 20/06/2024 à 17:06, Dave Hansen a écrit :

> On 6/19/24 14:25, Brice Goglin wrote:
>> Good point. From this patch series, I understand that the current kernel
>> side doesn't care about these different E-cores. However it might be
>> good to expose them as different cpu-types (or better name) to userspace ?
>>
>> Something like type 0 = P-core, 1 = normal E-core, 2 = low power E-core ?
> The first priority here is getting the kernel to comprehend these types
> for architectural purposes: when there are functional differences
> between the cores.
>
> Let's get that in place, first.  Then we can discuss the possibility of
> new ABI in the area.

Agreed.

> Did the ARM folks ever do a sysfs ABI for big.LITTLE?  I don't see
> anything obvious in Documentation/ABI/testing/sysfs-devices-system-cpu.

As far as I know, they only have the "capacity" field in sysfs cpu files
that reports a higher number for the equivalent of P-core:

 From testing/sysfs-devices-system-cpu:

What:           /sys/devices/system/cpu/cpuX/cpu_capacity
Date:           December 2016
Contact:        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Description:    information about CPUs heterogeneity.

                 cpu_capacity: capacity of cpuX.

I don't know how it's calculated but I've never seen it report something wrong.
On Android/ARM phones, big cores usually have 1024 and small cores something
between 400 and 500.
Where there are 3 types of cores, they report 1024, 500-800 about ~250.

Brice



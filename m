Return-Path: <linux-pm+bounces-27507-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1B5AC0A6A
	for <lists+linux-pm@lfdr.de>; Thu, 22 May 2025 13:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7956B3ADE90
	for <lists+linux-pm@lfdr.de>; Thu, 22 May 2025 11:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A293D22D791;
	Thu, 22 May 2025 11:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XNsgnW/P"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33D4221F0A;
	Thu, 22 May 2025 11:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747912529; cv=none; b=QeYhF1fM0r9L+5st2VXb6qqbBBh3NQ5nizWqhsrWrxAlBW+73WTPeOqRXJ6YvFxGVPX3sg676t3REqN52XYHUKvgSm7OT4MCQ4i0eulW1R65ZxgJm5q+X4u8v9osGSWihg5i+SefMOa9kJYQL3RcKSycC9NwgZ6DSMeXP9szowI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747912529; c=relaxed/simple;
	bh=PYiCglQe17p+UCnGT1JX2kII7JObgxkxKAaLnythrUM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DFPssCqNolR2HWsJ1C2A7Vfx/b5xtSXlYEt9jDerqkJhDztSeY8+sKlNEAVojX6dvoPWAs5huDQhjg8xzH5pzHag5Lgtw6sa5LKIe5kSgvcn7cyGHxGRuZ9PwXBx7PT9iqHwv2j5jjhECF0DkXe4k97AKM7QCgHDOUaAkII90iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XNsgnW/P; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6f8b0fdd5ffso77807276d6.0;
        Thu, 22 May 2025 04:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747912527; x=1748517327; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xif0BFiKHRKFy77wQivk8+MEWBvoVtTEierfI/Fy18Y=;
        b=XNsgnW/PUG6c/rjJ83pvhAByBMv5GupUxd6fJcOVTjAmSvB6XHNOr3xKu/ZBEWUnAc
         x8gFoaDVla1WQFrwuqq7W8P01O/9FNpYlB4GeNvv8DxkH6R+DBz24W9wuJs9/FMelAMs
         S+c/2z1p0VxI1GTNVcdvSH0EPou++Vu9K12g3WrkOgOLdX6Pdqe+on+HFdoi1jt1ijKa
         uwBLjZs8HvrBaq3X0FKbXLmNk9yAf0dbM1vrJmxVW7MCilbLdUgxwKzd+r2QUmC2dR2g
         4hUYRso8xI8+u1xrraOTbuo0eZ1QsZwqNtChvjt8eD6zYOV3VgIgJeBpUgPEtD1lbsNp
         /dIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747912527; x=1748517327;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xif0BFiKHRKFy77wQivk8+MEWBvoVtTEierfI/Fy18Y=;
        b=SfrdupxguTM3JNTwH2FZW0NsDPmL8RvqEBSJnzknCQEvOW129ZPGaqG+ExmNi+pFpp
         /baO/pYohJtzQCti/CUWjDVU+Ogrp4YDflo0nqmFsHcoay4fQTQtjWzKI4D+qe9zq82T
         o+xiwpSFabviQ43U+U5LGtc1tqJYu2PgLti74qO0JuzJHP2Q2e9uQFIJElg9fb2J9EtA
         cOUuwFIPZNMfEWzS66KvL5PlhSU9JpEGDTrsNVB3bbHZwDsaQYYWGKnQkQTgaNZv6S8T
         DLwSqHB+JSKmutj6VPvanoaQIZdI0q9eD0aLO1Jq1WoNmZWAZdgfIy7y1O9fuhiQm6ZT
         28Fw==
X-Forwarded-Encrypted: i=1; AJvYcCU5hPz3AiDnCLOt1ix1GR1VxmJNoRBuyU6Yz5xGaRHXo2o4Fd6oxrgj7Crm2/n/zJ8uZol80NMZTLTHFePK@vger.kernel.org, AJvYcCW+XfTp6bYqHW4IC79N+5IQhzl5r/1iG5Al1RGj8GZY5rYTgyOSgk6LgTGjATD05PFjkT4JdDsoeSY=@vger.kernel.org, AJvYcCWTv4178lyzRNWJv3Lycvknt8bsALDrqZ/LM6G5GT8BFCbSn+jExhUjVujOjLuNcR6Zx/M+ackkA7g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaldxHpIaYjfvooEN0QNGN9Vhqqnxkpd8GcnIOnD3lI3jhsUFd
	zI9jnoxIXevg41CIoVTolMohenMw7DL/VDAvVVUieA9CaPPEhmaX4u8F
X-Gm-Gg: ASbGncu+gSKPIKoid5lOCFvF6CrAmtYrTN9HuVUADQ5znsyoHddZBkKi10mcVfd+yRk
	GdEAhojn+dN1VRBEJb0hzZxL/KTWL5BTYnV8AYFwoRfksw2RZ+fZqBjxg1Zzp8XAtraf6dzhtcM
	UgdAQmSqw2OedBMM/u5Tj8e81iR8MYedaOaBWvwHwNSjiRkdrXFULyApgQKXkdO3rdTl9oH9J3G
	zAgyJQLT7g9y4d2Xlh3CuQ89ijINUf1mj0trZNFFzjqXyxRF9667MvdTRbhu/OgWCk0gbex+T3l
	KZDXLkyE0hawk7cxzbwW1T58qFoh6aBTwyXPIpgN6XVuoWIund82WTa19wyxcV4ShWw7FJcHYsi
	cRw==
X-Google-Smtp-Source: AGHT+IF+w9MKktfhqzOrURUJ6c7DxwXWpC4hkXUEFIIUtW7CQjQt72TsTF4tBGZW48aVTTDOw3j/RQ==
X-Received: by 2002:ad4:5f08:0:b0:6e8:f166:b19c with SMTP id 6a1803df08f44-6f8b08ee744mr332249466d6.41.1747912526433;
        Thu, 22 May 2025 04:15:26 -0700 (PDT)
Received: from ?IPV6:2600:6c56:7d00:582f::64e? ([2600:6c56:7d00:582f::64e])
        by smtp.googlemail.com with ESMTPSA id 6a1803df08f44-6f8b0883f45sm98958816d6.23.2025.05.22.04.15.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 May 2025 04:15:26 -0700 (PDT)
Message-ID: <b62c0462-8185-4eb8-8ac6-7f2abc387768@gmail.com>
Date: Thu, 22 May 2025 06:15:24 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq, docs: (userspace governor) add that actual freq
 is >= scaling_setspeed
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Shashank Balaji <shashank.mahadasyam@sony.com>,
 Viresh Kumar <viresh.kumar@linaro.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-pm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shinya Takumi <shinya.takumi@sony.com>
References: <20250522-userspace-governor-doc-v1-1-c8a038e39084@sony.com>
 <15871c67-0d18-430f-935e-261b2cda855b@gmail.com>
 <CAJZ5v0gz3Y+RGqBf9E1hzq9rwfrryd98Xpk51DtLd-uck5y-rw@mail.gmail.com>
Content-Language: en-US
From: Russell Haley <yumpusamongus@gmail.com>
In-Reply-To: <CAJZ5v0gz3Y+RGqBf9E1hzq9rwfrryd98Xpk51DtLd-uck5y-rw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 5/22/25 4:47 AM, Rafael J. Wysocki wrote:
> On Thu, May 22, 2025 at 10:51 AM Russell Haley <yumpusamongus@gmail.com> wrote:
>>
>>
>> On 5/22/25 3:05 AM, Shashank Balaji wrote:
>>> The userspace governor does not have the CPUFREQ_GOV_STRICT_TARGET flag, which
>>> means the requested frequency may not strictly be followed. This is true in the
>>> case of the intel_pstate driver with HWP enabled. When programming the
>>> HWP_REQUEST MSR, the min_perf is set to `scaling_setspeed`, and the max_perf
>>> is set to the policy's max. So, the hardware is free to increase the frequency
>>> beyond the requested frequency.
>>>
>>> This behaviour can be slightly surprising, given the current wording "allows
>>> userspace to set the CPU frequency". Hence, document this.
>>>
>>
>> In my opinion, the documentation is correct, and it is the
>> implementation in intel_pstate that is wrong. If the user wanted two
>> separate knobs that control the minimum and maximum frequencies, they
>> could leave intel_pstate in "active" mode and change scaling_min_freq
>> and scaling_max_freq.
>>
>> If the user asks for the frequency to be set from userspace, the
>> frequency had damn well better be set from userspace.
> 
> The userspace governor requests a frequency between policy->min and
> policy->max on behalf of user space.  In intel_pstate this translates
> to setting DESIRED_PERF to the requested value which is also the case
> for the other governors.

Huh.  On this Skylake box with kernel 6.14.6, it seems to be setting
Minimum_Performance, and leaving desired at 0.

> echo userspace | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
userspace
> echo 1400000 | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_setspeed
1400000
> sudo x86_energy_perf_policy &| grep REQ
cpu0: HWP_REQ: min 14 max 40 des 0 epp 128 window 0x0 (0*10^0us) use_pkg 0
cpu1: HWP_REQ: min 14 max 40 des 0 epp 128 window 0x0 (0*10^0us) use_pkg 0
cpu2: HWP_REQ: min 14 max 40 des 0 epp 128 window 0x0 (0*10^0us) use_pkg 0
cpu3: HWP_REQ: min 14 max 40 des 0 epp 128 window 0x0 (0*10^0us) use_pkg 0
cpu4: HWP_REQ: min 14 max 40 des 0 epp 128 window 0x0 (0*10^0us) use_pkg 0
cpu5: HWP_REQ: min 14 max 40 des 0 epp 128 window 0x0 (0*10^0us) use_pkg 0
cpu6: HWP_REQ: min 14 max 40 des 0 epp 128 window 0x0 (0*10^0us) use_pkg 0
cpu7: HWP_REQ: min 14 max 40 des 0 epp 128 window 0x0 (0*10^0us) use_pkg 0

Cheers,
Russell


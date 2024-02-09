Return-Path: <linux-pm+bounces-3726-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F298F8500A5
	for <lists+linux-pm@lfdr.de>; Sat, 10 Feb 2024 00:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A85751F226B1
	for <lists+linux-pm@lfdr.de>; Fri,  9 Feb 2024 23:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A033613D;
	Fri,  9 Feb 2024 23:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b="fzaIXIZa"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245BD374DE
	for <linux-pm@vger.kernel.org>; Fri,  9 Feb 2024 23:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707520588; cv=none; b=J+l5drCc+I5DG9EkmubO+T9IOXO0aIeidMwXbDT1eZl8iosHj7UvZBdX5vNjWzNfdP49PLCYWI+F0L88p3EsXjh0e+pnISzD9tFFLCIJVPV5oOVd0ZEMLecxLzhvDt6eJEUnXDNy+a7sGT5osJaLfEJJmJgsumOt842PcI7VJ0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707520588; c=relaxed/simple;
	bh=1OM/XhD3ySAXgTEgnteyWwA1UhswVIHFAAumtB+wC3Q=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=NBmcoL2erHOYlXTYj9z1n30s4GP5DhGEN0GCYgh7fdTb3OolCJk055dhsiwtkI05Z3zeLXD3Q/MiLfaTPCvoshayO2+yz9PChsQf/LxrF2y+BTx823TyVRC72xpEev/hA/82wkCAC1Oual+1ovOPI5ZWAOlLfR9WofN+o4l/rPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net; spf=pass smtp.mailfrom=telus.net; dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b=fzaIXIZa; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telus.net
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-59883168a83so683027eaf.2
        for <linux-pm@vger.kernel.org>; Fri, 09 Feb 2024 15:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google; t=1707520586; x=1708125386; darn=vger.kernel.org;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=iV+rBQ9ePQ6B6/QahLurCX/rC4acs9WKhtG7mzgLabg=;
        b=fzaIXIZaRgac6/V4RTJHa5id0zxHkVG8g2Iq59C0/u5I4jnr8I0FchP+8Dnar84G7a
         Fiv8ZX3984Y0dCKCtMpLgg83PowIgSU1pg5TVgCIWsELGWTknzKfB0iaUQUJr2hdxrHE
         W0DvbpsMNHWBKPq8VuZoefDvQH8KJpArBoBkUXcAzYofUYG+PFQuU4iZTnJlUQWMW8iE
         GvMR1+Oa1cIt4Z2iIpsV+X0C3d/gfc6ju8iYUje30GOUlNuZ4aZ3LVo2ZFl9n4lJvaZz
         tIIEDU3k/Jo5uiuYWErt7VSLD2f5w1St6eRbc0NOA+ieXCqjBwaF+tvl3Cu2sZg1cA/o
         qLFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707520586; x=1708125386;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iV+rBQ9ePQ6B6/QahLurCX/rC4acs9WKhtG7mzgLabg=;
        b=Ok21lg9Qx48REjy1SCp7hlaZpCnQlhy/srro66p1Dqv+IFsGKWeS/rHcMVmcTOKodD
         GER3XiJIIf1VdvAj0+5Oh6ZwUZXPbe7hxzUNpbHXOyBnj1kJo4P+un56qYTqjHMnADbo
         +mnbeAugJNIb1jzPE6pi2oI4ekG8WTzcONHty1JK5SpuBd6+az4qDzp68vLl7d16zARe
         PBPAY01CmGouYZh2Dc3Bs/yzGS+Wi5Q+CGl+/picLfRmxzoiIKvW5/pXUgiB70pYrCRB
         qd+RCWOjwSeVVwEfjV3e6e/Ud7WdCmsllVgAzHE/Io+rcyXNWvabFD/eEMzCx6kKZZ8q
         vcFg==
X-Gm-Message-State: AOJu0YxVGU++9ZI0U4EpsqgR6EJZenmVprIZ/BkHy1AaCZ+jZmlD5Bdl
	9oiTXpAWGjYiINlvbiFsTYt/NLp5w51gjrZX0hWnLTnxwBFMWL9DVppy5EgZFag=
X-Google-Smtp-Source: AGHT+IFWkUOZ2G7QBQWLVquqtymqQWVSt4OgIL2Lze41FQp5ult1VdwmkL7UiadhfgDgeATiU/g+3A==
X-Received: by 2002:a05:6358:6f82:b0:178:fac8:da7c with SMTP id s2-20020a0563586f8200b00178fac8da7cmr589217rwn.21.1707520586098;
        Fri, 09 Feb 2024 15:16:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWZ9yd4Ee0ztusMWcG2fmmeT7o5RFQLMLtUQgBgFpMnMzuqXewMXCrZCB1tNd1JVmIOpNnd3j6VCyHP4CfHY0RpJ3pHhQqYf43kwttt7EDJ+RgcIZpQqR9xlI8/Qy7SI7VRMGk/Q0lPZqFGcxQzMbH/hkapgc0NMZbtUK3EsAVVuvoqPR9hekpgg5R9/g8b
Received: from DougS18 (s66-183-142-209.bc.hsia.telus.net. [66.183.142.209])
        by smtp.gmail.com with ESMTPSA id 23-20020a631357000000b005dc4829d0e1sm2354314pgt.85.2024.02.09.15.16.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Feb 2024 15:16:25 -0800 (PST)
From: "Doug Smythies" <dsmythies@telus.net>
To: "'Vincent Guittot'" <vincent.guittot@linaro.org>
Cc: "'Ingo Molnar'" <mingo@kernel.org>,
	"'Rafael J. Wysocki'" <rafael@kernel.org>,
	<linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	"Doug Smythies" <dsmythies@telus.net>
References: <002f01da5ba0$49cbf810$dd63e830$@telus.net> <CAKfTPtA-jizig0sh_shmkAMudAxDPYHP0SdanZe=Gc57jVKouQ@mail.gmail.com>
In-Reply-To: <CAKfTPtA-jizig0sh_shmkAMudAxDPYHP0SdanZe=Gc57jVKouQ@mail.gmail.com>
Subject: RE: sched/cpufreq: Rework schedutil governor performance estimation - Regression bisected
Date: Fri, 9 Feb 2024 15:16:28 -0800
Message-ID: <003801da5bae$02d6f550$0884dff0$@telus.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQHymzO4ho/iLx8gQfQ33x85MlP38AE230H5sMhpSQA=

Hi Vincent,
Thank you for your quick reply.

On 2024.02.09.14:11 Vincent wrote:
On Fri, 9 Feb 2024 at 22:38, Doug Smythies <dsmythies@telus.net> wrote:
>>
>> Hi,
>>
>> I noticed a regression in the 6.8rc series kernels. Bisecting the =
kernel pointed to:
>>
>> # first bad commit: [9c0b4bb7f6303c9c4e2e34984c46f5a86478f84d]
>> sched/cpufreq: Rework schedutil governor performance estimation
>>
>> There was previous bisection and suggestion of reversion,
>> but I guess it wasn't done in the end. [1]
>
> This has been fixed with
> =
https://lore.kernel.org/all/170539970061.398.16662091173685476681.tip-bot=
2@tip-bot2/

Okay, thanks. I didn't find that one.

>> The regression: reduced maximum CPU frequency is ignored.

> This seems to be something new.
> schedutil doesn't impact the max_freq and it's up to cpufreq driver
> select the final freq which should stay within the limits

Okay. All I know is this is the commit that caused the regression.
I do not know why, but I do wonder if there could any relationship with
the old, never fixed, problem of incorrect stale frequencies reported
under the same operating conditions. See the V2 note:
https://lore.kernel.org/all/001d01d9d3a7$71736f50$545a4df0$@telus.net/

where I haven't been able to figure out a solution.

>> Conditions:
>> CPU frequency scaling driver: intel_cpufreq (a.k.a intel_pstate in =
passive mode)
>> CPU frequency scaling governor: schedutil
>> HWP (HardWare Pstate) control (a.k.a. Intel_speedshift): Enabled
>> Processor: Intel(R) Core(TM) i5-10600K CPU @ 4.10GHz
>>
>> I did not check any other conditions, i.e. HWP disabled or the =
acpi-cpufreq driver.
>>
>> Example: A 100% load on CPU 5.
>>
>> sudo turbostat --quiet --Summary --show =
Busy%,Bzy_MHz,IRQ,PkgWatt,PkgTmp,RAMWatt,GFXWatt,CorWatt --interval 15
>> Busy%   Bzy_MHz IRQ     PkgTmp  PkgWatt CorWatt GFXWatt RAMWatt
>> 8.42    4636    21823   67      28.40   27.56   0.00    2.59
>> 8.40    4577    17724   66      27.57   26.73   0.00    2.59
>> 8.35    4637    19535   66      28.65   27.81   0.00    2.60
>> 8.41    4578    20723   66      27.73   26.89   0.00    2.59
>> 8.40    4558    19156   67      27.39   26.55   0.00    2.58
>> 8.34    4502    18127   67      26.79   25.96   0.00    2.57
>>
>> grep . /sys/devices/system/cpu/cpu*/cpufreq/scaling_max_freq
>> /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq:2400000
>> /sys/devices/system/cpu/cpu10/cpufreq/scaling_max_freq:2400000
>> /sys/devices/system/cpu/cpu11/cpufreq/scaling_max_freq:2400000
>> /sys/devices/system/cpu/cpu1/cpufreq/scaling_max_freq:2400000
>> /sys/devices/system/cpu/cpu2/cpufreq/scaling_max_freq:2400000
>> /sys/devices/system/cpu/cpu3/cpufreq/scaling_max_freq:2400000
>> /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq:2400000
>> /sys/devices/system/cpu/cpu5/cpufreq/scaling_max_freq:2400000
>> /sys/devices/system/cpu/cpu6/cpufreq/scaling_max_freq:2400000
>> /sys/devices/system/cpu/cpu7/cpufreq/scaling_max_freq:2400000
>> /sys/devices/system/cpu/cpu8/cpufreq/scaling_max_freq:2400000
>> /sys/devices/system/cpu/cpu9/cpufreq/scaling_max_freq:2400000
>>
>> grep . /sys/devices/system/cpu/cpu5/cpufreq/*
>> /sys/devices/system/cpu/cpu5/cpufreq/affected_cpus:5
>> /sys/devices/system/cpu/cpu5/cpufreq/base_frequency:4100000
>> /sys/devices/system/cpu/cpu5/cpufreq/cpuinfo_max_freq:4800000
>> /sys/devices/system/cpu/cpu5/cpufreq/cpuinfo_min_freq:800000
>> /sys/devices/system/cpu/cpu5/cpufreq/cpuinfo_transition_latency:20000
>> =
/sys/devices/system/cpu/cpu5/cpufreq/energy_performance_available_prefere=
nces:default performance balance_performance balance_power
>> power
>> =
/sys/devices/system/cpu/cpu5/cpufreq/energy_performance_preference:balanc=
e_performance
>> /sys/devices/system/cpu/cpu5/cpufreq/related_cpus:5
>> =
/sys/devices/system/cpu/cpu5/cpufreq/scaling_available_governors:conserva=
tive ondemand userspace powersave performance schedutil
>> /sys/devices/system/cpu/cpu5/cpufreq/scaling_cur_freq:4799998
>> /sys/devices/system/cpu/cpu5/cpufreq/scaling_driver:intel_cpufreq
>> /sys/devices/system/cpu/cpu5/cpufreq/scaling_governor:schedutil
>> /sys/devices/system/cpu/cpu5/cpufreq/scaling_max_freq:2400000
>> /sys/devices/system/cpu/cpu5/cpufreq/scaling_min_freq:800000
>> /sys/devices/system/cpu/cpu5/cpufreq/scaling_setspeed:<unsupported>
>>
>> [1] =
https://lore.kernel.org/all/CAKfTPtDCQuJjpi6=3DzjeWPcLeP+ZY5Dw7XDrZ-LpXqE=
AAUbXLhA@mail.gmail.com/




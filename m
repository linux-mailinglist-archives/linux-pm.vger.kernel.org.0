Return-Path: <linux-pm+bounces-26500-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2F4AA5963
	for <lists+linux-pm@lfdr.de>; Thu,  1 May 2025 03:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 212E41BC46B6
	for <lists+linux-pm@lfdr.de>; Thu,  1 May 2025 01:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465DF1EDA2B;
	Thu,  1 May 2025 01:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h2ljSetv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8E82F3E;
	Thu,  1 May 2025 01:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746062903; cv=none; b=BwMhjZDL9w3clTmHUZ4EtuozjbEXDqcY8uwtctXRzZcJY5aNghDMf5781fuWn5Bv7YnwsMzWffMclXpTQeV6FP7cqSjmcL7AbCwYyVzB8edRrV6tpO+t4A2HetHjJdTcqYiNdGQLzWq23KMNTAh55kydEaxBUlQv2Fbw91zyn6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746062903; c=relaxed/simple;
	bh=KM37b4s9Rfq9uTncM+K031EOHXQvnfMvyDPfM/D8BnI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bHhWGwbFsh6+q9JzH89W4HSp/768AAjKZR35pMnChSK0ihToztmcs7+GJZ+ncNZMVsVsHkspzWPm58f+26MOjgWVzr4WbfRZmM2rJfSbyMMJJQun2lHdZkAnDjnf7RZSPh5y3qXSxhq8k9AndbcfRr8a8nfsXBXTPoZiXuVncC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h2ljSetv; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-72b82c8230aso133071a34.2;
        Wed, 30 Apr 2025 18:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746062900; x=1746667700; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BHAiAriL0a3M+j0yvGSbbT4kExDsM2lRnxLYoNjxlDc=;
        b=h2ljSetvn2wc+AS28R401PPCTWGL+57rL5eDCMDtPsPlE5shmsnuyf9n/cuidIWF3d
         tNXoCDRJvwAB6jyoN7p8Yk9zBq6roEBHfFZpUZJuWoMigY7ToR0PGrWlKo6uAVUI5LfI
         1T8xZlewElXOEBDJe4+8lljXmch99ciHt8TBV2N0m9R3gWh+3+ALAqD7mW7crc5ryZCp
         XdvWQjIJcDH9lpERt03UBcaAlYgXc2PlUjZTpOV2CWyQzFjBPJ8lNLB+Tz8dKcwe7mVe
         zMEmte1ofCPsX3uNWHnd/uYdVOo7Er71IPBFv/EzbdzWk6lmf3cB5XiLOHE3TvOSh2qk
         dtrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746062900; x=1746667700;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BHAiAriL0a3M+j0yvGSbbT4kExDsM2lRnxLYoNjxlDc=;
        b=g9oeSZL8a4vCQWMdWSbdJYTm8EN6haCZ34YE/B00xgGJo21wAC1qVeqN2DzCTq0vaM
         nJp9jzIrlcGl9BgsAuFOFDbrAr+m3Qv3eTTMtYGljdXeDcp4a1L8XgwBIhKuiTu5pDQl
         EucFyt89tP5Q59iddKbNdfVgb1GNym1yu2wPxQShZnEejdc7T3fJDGWHtsqrmAgS3+8g
         rjCED0FotByeovKhQ3Oxjue4wP0zkpZ8xl+sIsG8137pvL7TVeLk+8SPDzFer0lrwsRF
         xiROr20Gmdjde98LZqwtauL3qhiolQD3w297a4km3mtIwCEpsApbLWhXSPa8UcTI1GzI
         Gegg==
X-Forwarded-Encrypted: i=1; AJvYcCXt+dKLt2bNQdz1Zj1OGMxxcFvWqMokVuaxFOHW0NrD+fSyLPjTcpJhqcXrPH8cgIYzrI1EFd40Xg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0bO8Ogy8M10NU9YxIu3lCRzVWLUjJqC/Wh1FAC9NAbPjqU6+f
	ZSivGeFur5GNT7RKvcDmKVUWRQOXC+myeTF8Q0+ugBZFmxpakFz8z/MSK0AE
X-Gm-Gg: ASbGnctihJz48JURjhz4AfzOonJYIncHT8nWb8dgTPT4a4DITKECfK7w1zMIswblUXP
	IjhH5ol0lMCB84IuRF72+yRhRVgrn/pdvCVedRr1InYxsu/kkpxH3uAFA87nXgLgATSdbt3+4fz
	LeOJL9oJjWHXLRLtDNCruwPiiGoff16pgqJ1GxnBXZIT0V0a123dv/OPnpHc592RpOu1sLO+g+V
	8/6gx6FMQ49lxuULgaqV2GqMiuNBNzE4DGssylX2yvhCyTdAimvn843a+EaBrXMIqEC6bOdDPFx
	qdB0uLFLW10v+20SzQsdl2a3xHOF0bKTlbQm2kcwylnjeeK+7U4HXC+G
X-Google-Smtp-Source: AGHT+IHxAh2FrqMqOg+Ig8XkRa1V1Q9oJXMfJkVlifPapgGOdJB/+slk7jZRlzWqP/CkL1v/dP9gbw==
X-Received: by 2002:a05:6830:6f85:b0:72b:9a2e:7828 with SMTP id 46e09a7af769-731c0aab0eemr3791355a34.28.1746062900643;
        Wed, 30 Apr 2025 18:28:20 -0700 (PDT)
Received: from ?IPV6:2600:6c56:7d00:582f::64e? ([2600:6c56:7d00:582f::64e])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-7308b31214bsm1119027a34.57.2025.04.30.18.28.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Apr 2025 18:28:20 -0700 (PDT)
Message-ID: <53027db5-f750-4b6f-8ac5-a849dff2524b@gmail.com>
Date: Wed, 30 Apr 2025 20:28:19 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] cpufreq: intel_pstate: Use CPPC to get scaling
 factors
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <1923452.tdWV9SEqCh@rjwysocki.net>
 <8476313.T7Z3S40VBb@rjwysocki.net>
Content-Language: en-US
From: Russell Haley <yumpusamongus@gmail.com>
In-Reply-To: <8476313.T7Z3S40VBb@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 12/5/24 5:39 AM, Rafael J. Wysocki wrote:

> +	 * Compute the perf-to-frequency scaling factor for the given CPU if
> +	 * possible, unless it would be 0.
> +	 */
> +	if (!cppc_get_perf_caps(cpu, &cppc_perf) &&
> +	    cppc_perf.nominal_perf && cppc_perf.nominal_freq)
> +		return div_u64(cppc_perf.nominal_freq * KHZ_PER_MHZ,
> +			       cppc_perf.nominal_perf);

I think this exposed a firmware bug on ARL. I have a Core Ultra 265K,
and two of the E-cores report 33 for nominal_perf, while the others
report 46. They all report 3300 for nominal_freq.

The result is that the kernel thinks these two E-cores are capable of
6.5 GHz.

> grep . /sys/devices/system/cpu/cpu*/cpufreq/cpuinfo_max_freq
/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq:5400000
/sys/devices/system/cpu/cpu1/cpufreq/cpuinfo_max_freq:5500000
/sys/devices/system/cpu/cpu2/cpufreq/cpuinfo_max_freq:5400000
/sys/devices/system/cpu/cpu3/cpufreq/cpuinfo_max_freq:5400000
/sys/devices/system/cpu/cpu4/cpufreq/cpuinfo_max_freq:5400000
/sys/devices/system/cpu/cpu5/cpufreq/cpuinfo_max_freq:5400000
/sys/devices/system/cpu/cpu6/cpufreq/cpuinfo_max_freq:5400000
/sys/devices/system/cpu/cpu7/cpufreq/cpuinfo_max_freq:5500000
/sys/devices/system/cpu/cpu8/cpufreq/cpuinfo_max_freq:4600000
/sys/devices/system/cpu/cpu9/cpufreq/cpuinfo_max_freq:4600000
/sys/devices/system/cpu/cpu10/cpufreq/cpuinfo_max_freq:4600000
/sys/devices/system/cpu/cpu11/cpufreq/cpuinfo_max_freq:4600000
/sys/devices/system/cpu/cpu12/cpufreq/cpuinfo_max_freq:6500000 # wow
/sys/devices/system/cpu/cpu13/cpufreq/cpuinfo_max_freq:6500000 # amazing
/sys/devices/system/cpu/cpu14/cpufreq/cpuinfo_max_freq:4600000
/sys/devices/system/cpu/cpu15/cpufreq/cpuinfo_max_freq:4600000
/sys/devices/system/cpu/cpu16/cpufreq/cpuinfo_max_freq:4600000
/sys/devices/system/cpu/cpu17/cpufreq/cpuinfo_max_freq:4600000
/sys/devices/system/cpu/cpu18/cpufreq/cpuinfo_max_freq:4600000
/sys/devices/system/cpu/cpu19/cpufreq/cpuinfo_max_freq:4600000

Hopefully you have the ear of someone on the firmware team so that a
ticket can be created for this.

In Phoronix discussion, users have reported seeing this on both ASRock
and MSI motherboards:

https://www.phoronix.com/forums/forum/hardware/processors-memory/1541981-intel-core-ultra-9-285k-arrow-lake-performance-on-linux-has-improved-a-lot-since-launch?p=1543676#post1543676

----------

Also, this may be related... I can't set scaling_max_freq to odd
multiples of 100 MHz, only even. Checking with:

    x86_energy_perf_policy &| grep -i req

reveals that some values of max are being skipped. Setting manually with

    x86_energy_perf_policy --cpu 0-7 --hwp-max 76

allows the odd multiples to be accessed. Integer division issue somewhere?


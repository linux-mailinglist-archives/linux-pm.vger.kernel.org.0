Return-Path: <linux-pm+bounces-26523-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8961AA65A2
	for <lists+linux-pm@lfdr.de>; Thu,  1 May 2025 23:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CC431895A1A
	for <lists+linux-pm@lfdr.de>; Thu,  1 May 2025 21:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01DE2213E6D;
	Thu,  1 May 2025 21:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BFoeGz6V"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C451E991D;
	Thu,  1 May 2025 21:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746135208; cv=none; b=Aj7IqoWP/FpDkJxQQNX9ZWkG7NU9uYIlXpF4r+oOxbWhEFt/6jbX8FQ3T9v3CwoA8H1OIKrO/7hxZJ3bCyIgfBlkgPAB1VDus/LslV5cPjIHjqZ4BwzzYh8TLxowWdO9vfLT6oejZ+v2VtsMbn1Y6qbFmQbtRY9xcLv08YKacw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746135208; c=relaxed/simple;
	bh=eDx405B4Ic1EnVGuT3bxKCdkxQUhKBjKbxLtKAAD3+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uarduqHxGEutEF6qGlBxTEXSUOZ+6cRX2jxjKH5NUnVSJMUSvkGzqwvdr6KeUD9dH1YcWgc/bLmp53iOl2FKiHzkwM/SHxwgxE6kjrW9gGpHYyGZq1ya13reg8WZtyO+eio6OcfLpzLMOjl7rf0YEHJh27jURpZOLdbiDBjEiZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BFoeGz6V; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2cca475546fso766056fac.1;
        Thu, 01 May 2025 14:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746135206; x=1746740006; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9YA+qomxqJgtRO9zeFhIcAGnsoMeaZH+uAlZOjHclfk=;
        b=BFoeGz6Vzi2N5UExi/eBgoPF9qWOdqaIPileD2dxeENhcxx+mXLlr9K1hxNS4TV69Y
         9z90zilmUD3ipMV02Gd8+Gj36tVbcLLaqIjDPalEdnjodt/XJ9lJzSXUGVtlHkf7G4Kx
         BcBHdeq2nha7onRFpPT2teptsOWovXFFi4ilFaz96+p7feaJkOzrP7uhW/NP2kA7qeoo
         tHoiglloEi0Bpi+hFohsT1In8IklMGL3D3kXmnVtGiRWP3yrv1uYccmepwr52ywUs2iK
         Rbl6FdUMVAEbViqw3M3B62ADx3OJe+M/2dx/JcZzF5sqFIhWfieAozsWxvv/AkpVDmQt
         lFTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746135206; x=1746740006;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9YA+qomxqJgtRO9zeFhIcAGnsoMeaZH+uAlZOjHclfk=;
        b=BgMtyZUpLChzYoT0s9fMhkBhylNP4PD78ObZgY7UyC0HhKaWIxrmUFTUPe53sr9mpx
         QOzYiW374lbZa4Mhuydz46FBdf/NjwBgz+e6CvZw3tiYwT0soePCNeGevIoD1QExsAdo
         ESwvTNgQGsYQRTdJM0uiO+j3rEPzD0Dp/pEjcD8F0UiJefACpWvbMQD5jHnRLuf9LRQq
         +uGJeOu0jO+ky/hFUM6b6FyfvrMUlsM2BZscHgNk3wL5o7Tu7uQQ7QI3enjGfqtD56zn
         l9evQ1bij0F30LFaw33c+HP3V7SkLkcZEc9edAHaDwM/sOdXN72cEoYmiHYtDbpr0UQd
         KS9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWgFJkRXaPmhipKa8G9BetCfoOEMo4c/LKyFOoIftLBghrv2MWXqyGvpDsI6ym4kLAl/JOw1fI3yg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwJSzeK7hTF0jAdAscWFxB1VdXH2XZB5H/sJEWpIicIcvRQXEiQ
	sfFdQPQLxBnBgEWixoH2+8W2butwoYeaEf4nkAlOMlUvSw/zBfTWxHxSPU0b
X-Gm-Gg: ASbGncudaZ8g1zWY4QFfTu2vQXgNVVBmWmvTtJVEB9igrC1lGxgCjAwpsSNXdHxOFfR
	QdixYuEx4CemKeAkBaBZhI8RRVu2qD2sDaZkgVtlZOGdwfMoaAwd7Hv9fteED2niZJfjfm00uQm
	4zOgIZKB3QLBne1kml7Q25gGJbs7F43kmBGJox5viFbUqwvXa2YqSblu1mCiQHcaKUF+Nvnw81r
	iONcb2qjP5cMHqgYKl1d7974GBZ55Utc9CteBgg/44W2nS1USol4sz/TW0KWHcstyNBlxEh+vy6
	HtxUJ/c0MhP9ioTBuEIzpg6d0UK0yGxxIfw1S0CLyIYRsytcTGIK+k9w
X-Google-Smtp-Source: AGHT+IGWbFkNkNzAeNv7tIYHv8Gx1fyT4D+BtizLMlgL37BqTu5VcJujaU5vfOoJaQRA+FbplTv+vA==
X-Received: by 2002:a05:6870:d685:b0:2bc:6675:2043 with SMTP id 586e51a60fabf-2dab2fe27d7mr257088fac.14.1746135206040;
        Thu, 01 May 2025 14:33:26 -0700 (PDT)
Received: from ?IPV6:2600:6c56:7d00:582f::64e? ([2600:6c56:7d00:582f::64e])
        by smtp.googlemail.com with ESMTPSA id 006d021491bc7-607e7cab6d8sm285152eaf.4.2025.05.01.14.33.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 May 2025 14:33:25 -0700 (PDT)
Message-ID: <ac0e5571-15b2-4b7a-adc9-84bbca96cbf3@gmail.com>
Date: Thu, 1 May 2025 16:33:24 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] cpufreq: intel_pstate: Use CPPC to get scaling
 factors
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <1923452.tdWV9SEqCh@rjwysocki.net>
 <8476313.T7Z3S40VBb@rjwysocki.net>
 <53027db5-f750-4b6f-8ac5-a849dff2524b@gmail.com>
 <b1bc2569b0da4c6749e896eee0fdf0af97c18fea.camel@linux.intel.com>
Content-Language: en-US
From: Russell Haley <yumpusamongus@gmail.com>
In-Reply-To: <b1bc2569b0da4c6749e896eee0fdf0af97c18fea.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 5/1/25 12:13 PM, srinivas pandruvada wrote:
> Hi Russell,
> 
> 
> On Wed, 2025-04-30 at 20:28 -0500, Russell Haley wrote:
>>
>> On 12/5/24 5:39 AM, Rafael J. Wysocki wrote:
>>
>>> +	 * Compute the perf-to-frequency scaling factor for the
>>> given CPU if
>>> +	 * possible, unless it would be 0.
>>> +	 */
>>> +	if (!cppc_get_perf_caps(cpu, &cppc_perf) &&
>>> +	    cppc_perf.nominal_perf && cppc_perf.nominal_freq)
>>> +		return div_u64(cppc_perf.nominal_freq *
>>> KHZ_PER_MHZ,
>>> +			       cppc_perf.nominal_perf);
>>
> Can you dump the output of
> 
>  grep -r . /sys/devices/system/cpu/cpu*/acpi_cppc/
> 
> Thanks,
> Srinivas

Running microcode 0x117, CSME firmware 19.0.5.1948, shipped in BIOS 3.04
on an ASRock Z890 Pro-A Wifi motherboard:

> /sys/devices/system/cpu/cpu0/acpi_cppc/feedback_ctrs:ref:127316207577 del:142876300546
> /sys/devices/system/cpu/cpu0/acpi_cppc/lowest_nonlinear_perf:36
> /sys/devices/system/cpu/cpu0/acpi_cppc/highest_perf:87
> /sys/devices/system/cpu/cpu0/acpi_cppc/nominal_freq:3900
> /sys/devices/system/cpu/cpu0/acpi_cppc/lowest_freq:0
> /sys/devices/system/cpu/cpu0/acpi_cppc/guaranteed_perf:63
> /sys/devices/system/cpu/cpu0/acpi_cppc/nominal_perf:62
> /sys/devices/system/cpu/cpu0/acpi_cppc/lowest_perf:1
> /sys/devices/system/cpu/cpu0/acpi_cppc/reference_perf:62
> /sys/devices/system/cpu/cpu0/acpi_cppc/wraparound_time:18446744073709551615
> /sys/devices/system/cpu/cpu1/acpi_cppc/feedback_ctrs:ref:30806048910 del:37298826546
> /sys/devices/system/cpu/cpu1/acpi_cppc/lowest_nonlinear_perf:36
> /sys/devices/system/cpu/cpu1/acpi_cppc/highest_perf:88
> /sys/devices/system/cpu/cpu1/acpi_cppc/nominal_freq:3900
> /sys/devices/system/cpu/cpu1/acpi_cppc/lowest_freq:0
> /sys/devices/system/cpu/cpu1/acpi_cppc/guaranteed_perf:63
> /sys/devices/system/cpu/cpu1/acpi_cppc/nominal_perf:62
> /sys/devices/system/cpu/cpu1/acpi_cppc/lowest_perf:1
> /sys/devices/system/cpu/cpu1/acpi_cppc/reference_perf:62
> /sys/devices/system/cpu/cpu1/acpi_cppc/wraparound_time:18446744073709551615
> /sys/devices/system/cpu/cpu2/acpi_cppc/feedback_ctrs:ref:30104856912 del:37149315858
> /sys/devices/system/cpu/cpu2/acpi_cppc/lowest_nonlinear_perf:36
> /sys/devices/system/cpu/cpu2/acpi_cppc/highest_perf:87
> /sys/devices/system/cpu/cpu2/acpi_cppc/nominal_freq:3900
> /sys/devices/system/cpu/cpu2/acpi_cppc/lowest_freq:0
> /sys/devices/system/cpu/cpu2/acpi_cppc/guaranteed_perf:63
> /sys/devices/system/cpu/cpu2/acpi_cppc/nominal_perf:62
> /sys/devices/system/cpu/cpu2/acpi_cppc/lowest_perf:1
> /sys/devices/system/cpu/cpu2/acpi_cppc/reference_perf:62
> /sys/devices/system/cpu/cpu2/acpi_cppc/wraparound_time:18446744073709551615
> /sys/devices/system/cpu/cpu3/acpi_cppc/feedback_ctrs:ref:28864792476 del:36395338959
> /sys/devices/system/cpu/cpu3/acpi_cppc/lowest_nonlinear_perf:36
> /sys/devices/system/cpu/cpu3/acpi_cppc/highest_perf:87
> /sys/devices/system/cpu/cpu3/acpi_cppc/nominal_freq:3900
> /sys/devices/system/cpu/cpu3/acpi_cppc/lowest_freq:0
> /sys/devices/system/cpu/cpu3/acpi_cppc/guaranteed_perf:63
> /sys/devices/system/cpu/cpu3/acpi_cppc/nominal_perf:62
> /sys/devices/system/cpu/cpu3/acpi_cppc/lowest_perf:1
> /sys/devices/system/cpu/cpu3/acpi_cppc/reference_perf:62
> /sys/devices/system/cpu/cpu3/acpi_cppc/wraparound_time:18446744073709551615
> /sys/devices/system/cpu/cpu4/acpi_cppc/feedback_ctrs:ref:29591299374 del:35708084379
> /sys/devices/system/cpu/cpu4/acpi_cppc/lowest_nonlinear_perf:36
> /sys/devices/system/cpu/cpu4/acpi_cppc/highest_perf:87
> /sys/devices/system/cpu/cpu4/acpi_cppc/nominal_freq:3900
> /sys/devices/system/cpu/cpu4/acpi_cppc/lowest_freq:0
> /sys/devices/system/cpu/cpu4/acpi_cppc/guaranteed_perf:63
> /sys/devices/system/cpu/cpu4/acpi_cppc/nominal_perf:62
> /sys/devices/system/cpu/cpu4/acpi_cppc/lowest_perf:1
> /sys/devices/system/cpu/cpu4/acpi_cppc/reference_perf:62
> /sys/devices/system/cpu/cpu4/acpi_cppc/wraparound_time:18446744073709551615
> /sys/devices/system/cpu/cpu5/acpi_cppc/feedback_ctrs:ref:27347351382 del:35000915045
> /sys/devices/system/cpu/cpu5/acpi_cppc/lowest_nonlinear_perf:36
> /sys/devices/system/cpu/cpu5/acpi_cppc/highest_perf:87
> /sys/devices/system/cpu/cpu5/acpi_cppc/nominal_freq:3900
> /sys/devices/system/cpu/cpu5/acpi_cppc/lowest_freq:0
> /sys/devices/system/cpu/cpu5/acpi_cppc/guaranteed_perf:63
> /sys/devices/system/cpu/cpu5/acpi_cppc/nominal_perf:62
> /sys/devices/system/cpu/cpu5/acpi_cppc/lowest_perf:1
> /sys/devices/system/cpu/cpu5/acpi_cppc/reference_perf:62
> /sys/devices/system/cpu/cpu5/acpi_cppc/wraparound_time:18446744073709551615
> /sys/devices/system/cpu/cpu6/acpi_cppc/feedback_ctrs:ref:28117737882 del:34854014824
> /sys/devices/system/cpu/cpu6/acpi_cppc/lowest_nonlinear_perf:36
> /sys/devices/system/cpu/cpu6/acpi_cppc/highest_perf:87
> /sys/devices/system/cpu/cpu6/acpi_cppc/nominal_freq:3900
> /sys/devices/system/cpu/cpu6/acpi_cppc/lowest_freq:0
> /sys/devices/system/cpu/cpu6/acpi_cppc/guaranteed_perf:63
> /sys/devices/system/cpu/cpu6/acpi_cppc/nominal_perf:62
> /sys/devices/system/cpu/cpu6/acpi_cppc/lowest_perf:1
> /sys/devices/system/cpu/cpu6/acpi_cppc/reference_perf:62
> /sys/devices/system/cpu/cpu6/acpi_cppc/wraparound_time:18446744073709551615
> /sys/devices/system/cpu/cpu7/acpi_cppc/feedback_ctrs:ref:29586359166 del:36871078184
> /sys/devices/system/cpu/cpu7/acpi_cppc/lowest_nonlinear_perf:36
> /sys/devices/system/cpu/cpu7/acpi_cppc/highest_perf:88
> /sys/devices/system/cpu/cpu7/acpi_cppc/nominal_freq:3900
> /sys/devices/system/cpu/cpu7/acpi_cppc/lowest_freq:0
> /sys/devices/system/cpu/cpu7/acpi_cppc/guaranteed_perf:63
> /sys/devices/system/cpu/cpu7/acpi_cppc/nominal_perf:62
> /sys/devices/system/cpu/cpu7/acpi_cppc/lowest_perf:1
> /sys/devices/system/cpu/cpu7/acpi_cppc/reference_perf:62
> /sys/devices/system/cpu/cpu7/acpi_cppc/wraparound_time:18446744073709551615
> /sys/devices/system/cpu/cpu8/acpi_cppc/feedback_ctrs:ref:28808115336 del:32798153181
> /sys/devices/system/cpu/cpu8/acpi_cppc/lowest_nonlinear_perf:21
> /sys/devices/system/cpu/cpu8/acpi_cppc/highest_perf:65
> /sys/devices/system/cpu/cpu8/acpi_cppc/nominal_freq:3300
> /sys/devices/system/cpu/cpu8/acpi_cppc/lowest_freq:0
> /sys/devices/system/cpu/cpu8/acpi_cppc/guaranteed_perf:47
> /sys/devices/system/cpu/cpu8/acpi_cppc/nominal_perf:46
> /sys/devices/system/cpu/cpu8/acpi_cppc/lowest_perf:1
> /sys/devices/system/cpu/cpu8/acpi_cppc/reference_perf:54
> /sys/devices/system/cpu/cpu8/acpi_cppc/wraparound_time:18446744073709551615
> /sys/devices/system/cpu/cpu9/acpi_cppc/feedback_ctrs:ref:28808446524 del:32557156736
> /sys/devices/system/cpu/cpu9/acpi_cppc/lowest_nonlinear_perf:21
> /sys/devices/system/cpu/cpu9/acpi_cppc/highest_perf:65
> /sys/devices/system/cpu/cpu9/acpi_cppc/nominal_freq:3300
> /sys/devices/system/cpu/cpu9/acpi_cppc/lowest_freq:0
> /sys/devices/system/cpu/cpu9/acpi_cppc/guaranteed_perf:47
> /sys/devices/system/cpu/cpu9/acpi_cppc/nominal_perf:46
> /sys/devices/system/cpu/cpu9/acpi_cppc/lowest_perf:1
> /sys/devices/system/cpu/cpu9/acpi_cppc/reference_perf:54
> /sys/devices/system/cpu/cpu9/acpi_cppc/wraparound_time:18446744073709551615
> /sys/devices/system/cpu/cpu10/acpi_cppc/feedback_ctrs:ref:28466858472 del:32126528930
> /sys/devices/system/cpu/cpu10/acpi_cppc/lowest_nonlinear_perf:21
> /sys/devices/system/cpu/cpu10/acpi_cppc/highest_perf:65
> /sys/devices/system/cpu/cpu10/acpi_cppc/nominal_freq:3300
> /sys/devices/system/cpu/cpu10/acpi_cppc/lowest_freq:0
> /sys/devices/system/cpu/cpu10/acpi_cppc/guaranteed_perf:47
> /sys/devices/system/cpu/cpu10/acpi_cppc/nominal_perf:46
> /sys/devices/system/cpu/cpu10/acpi_cppc/lowest_perf:1
> /sys/devices/system/cpu/cpu10/acpi_cppc/reference_perf:54
> /sys/devices/system/cpu/cpu10/acpi_cppc/wraparound_time:18446744073709551615
> /sys/devices/system/cpu/cpu11/acpi_cppc/feedback_ctrs:ref:30158667240 del:34095663687
> /sys/devices/system/cpu/cpu11/acpi_cppc/lowest_nonlinear_perf:21
> /sys/devices/system/cpu/cpu11/acpi_cppc/highest_perf:65
> /sys/devices/system/cpu/cpu11/acpi_cppc/nominal_freq:3300
> /sys/devices/system/cpu/cpu11/acpi_cppc/lowest_freq:0
> /sys/devices/system/cpu/cpu11/acpi_cppc/guaranteed_perf:47
> /sys/devices/system/cpu/cpu11/acpi_cppc/nominal_perf:46
> /sys/devices/system/cpu/cpu11/acpi_cppc/lowest_perf:1
> /sys/devices/system/cpu/cpu11/acpi_cppc/reference_perf:54
> /sys/devices/system/cpu/cpu11/acpi_cppc/wraparound_time:18446744073709551615
> /sys/devices/system/cpu/cpu12/acpi_cppc/feedback_ctrs:ref:29056752036 del:33047611525
> /sys/devices/system/cpu/cpu12/acpi_cppc/lowest_nonlinear_perf:21
> /sys/devices/system/cpu/cpu12/acpi_cppc/highest_perf:65
> /sys/devices/system/cpu/cpu12/acpi_cppc/nominal_freq:3300
> /sys/devices/system/cpu/cpu12/acpi_cppc/lowest_freq:0
> /sys/devices/system/cpu/cpu12/acpi_cppc/guaranteed_perf:47
> /sys/devices/system/cpu/cpu12/acpi_cppc/nominal_perf:33
> /sys/devices/system/cpu/cpu12/acpi_cppc/lowest_perf:1
> /sys/devices/system/cpu/cpu12/acpi_cppc/reference_perf:39
> /sys/devices/system/cpu/cpu12/acpi_cppc/wraparound_time:18446744073709551615
> /sys/devices/system/cpu/cpu13/acpi_cppc/feedback_ctrs:ref:28868999796 del:32974873909
> /sys/devices/system/cpu/cpu13/acpi_cppc/lowest_nonlinear_perf:21
> /sys/devices/system/cpu/cpu13/acpi_cppc/highest_perf:65
> /sys/devices/system/cpu/cpu13/acpi_cppc/nominal_freq:3300
> /sys/devices/system/cpu/cpu13/acpi_cppc/lowest_freq:0
> /sys/devices/system/cpu/cpu13/acpi_cppc/guaranteed_perf:47
> /sys/devices/system/cpu/cpu13/acpi_cppc/nominal_perf:33
> /sys/devices/system/cpu/cpu13/acpi_cppc/lowest_perf:1
> /sys/devices/system/cpu/cpu13/acpi_cppc/reference_perf:39
> /sys/devices/system/cpu/cpu13/acpi_cppc/wraparound_time:18446744073709551615
> /sys/devices/system/cpu/cpu14/acpi_cppc/feedback_ctrs:ref:32754342192 del:33580705618
> /sys/devices/system/cpu/cpu14/acpi_cppc/lowest_nonlinear_perf:21
> /sys/devices/system/cpu/cpu14/acpi_cppc/highest_perf:65
> /sys/devices/system/cpu/cpu14/acpi_cppc/nominal_freq:3300
> /sys/devices/system/cpu/cpu14/acpi_cppc/lowest_freq:0
> /sys/devices/system/cpu/cpu14/acpi_cppc/guaranteed_perf:47
> /sys/devices/system/cpu/cpu14/acpi_cppc/nominal_perf:46
> /sys/devices/system/cpu/cpu14/acpi_cppc/lowest_perf:1
> /sys/devices/system/cpu/cpu14/acpi_cppc/reference_perf:54
> /sys/devices/system/cpu/cpu14/acpi_cppc/wraparound_time:18446744073709551615
> /sys/devices/system/cpu/cpu15/acpi_cppc/feedback_ctrs:ref:30756411036 del:33232643243
> /sys/devices/system/cpu/cpu15/acpi_cppc/lowest_nonlinear_perf:21
> /sys/devices/system/cpu/cpu15/acpi_cppc/highest_perf:65
> /sys/devices/system/cpu/cpu15/acpi_cppc/nominal_freq:3300
> /sys/devices/system/cpu/cpu15/acpi_cppc/lowest_freq:0
> /sys/devices/system/cpu/cpu15/acpi_cppc/guaranteed_perf:47
> /sys/devices/system/cpu/cpu15/acpi_cppc/nominal_perf:46
> /sys/devices/system/cpu/cpu15/acpi_cppc/lowest_perf:1
> /sys/devices/system/cpu/cpu15/acpi_cppc/reference_perf:54
> /sys/devices/system/cpu/cpu15/acpi_cppc/wraparound_time:18446744073709551615
> /sys/devices/system/cpu/cpu16/acpi_cppc/feedback_ctrs:ref:29430330384 del:32848376143
> /sys/devices/system/cpu/cpu16/acpi_cppc/lowest_nonlinear_perf:21
> /sys/devices/system/cpu/cpu16/acpi_cppc/highest_perf:65
> /sys/devices/system/cpu/cpu16/acpi_cppc/nominal_freq:3300
> /sys/devices/system/cpu/cpu16/acpi_cppc/lowest_freq:0
> /sys/devices/system/cpu/cpu16/acpi_cppc/guaranteed_perf:47
> /sys/devices/system/cpu/cpu16/acpi_cppc/nominal_perf:46
> /sys/devices/system/cpu/cpu16/acpi_cppc/lowest_perf:1
> /sys/devices/system/cpu/cpu16/acpi_cppc/reference_perf:54
> /sys/devices/system/cpu/cpu16/acpi_cppc/wraparound_time:18446744073709551615
> /sys/devices/system/cpu/cpu17/acpi_cppc/feedback_ctrs:ref:29997814080 del:33374419073
> /sys/devices/system/cpu/cpu17/acpi_cppc/lowest_nonlinear_perf:21
> /sys/devices/system/cpu/cpu17/acpi_cppc/highest_perf:65
> /sys/devices/system/cpu/cpu17/acpi_cppc/nominal_freq:3300
> /sys/devices/system/cpu/cpu17/acpi_cppc/lowest_freq:0
> /sys/devices/system/cpu/cpu17/acpi_cppc/guaranteed_perf:47
> /sys/devices/system/cpu/cpu17/acpi_cppc/nominal_perf:46
> /sys/devices/system/cpu/cpu17/acpi_cppc/lowest_perf:1
> /sys/devices/system/cpu/cpu17/acpi_cppc/reference_perf:54
> /sys/devices/system/cpu/cpu17/acpi_cppc/wraparound_time:18446744073709551615
> /sys/devices/system/cpu/cpu18/acpi_cppc/feedback_ctrs:ref:28312400376 del:32285787922
> /sys/devices/system/cpu/cpu18/acpi_cppc/lowest_nonlinear_perf:21
> /sys/devices/system/cpu/cpu18/acpi_cppc/highest_perf:65
> /sys/devices/system/cpu/cpu18/acpi_cppc/nominal_freq:3300
> /sys/devices/system/cpu/cpu18/acpi_cppc/lowest_freq:0
> /sys/devices/system/cpu/cpu18/acpi_cppc/guaranteed_perf:47
> /sys/devices/system/cpu/cpu18/acpi_cppc/nominal_perf:46
> /sys/devices/system/cpu/cpu18/acpi_cppc/lowest_perf:1
> /sys/devices/system/cpu/cpu18/acpi_cppc/reference_perf:54
> /sys/devices/system/cpu/cpu18/acpi_cppc/wraparound_time:18446744073709551615
> /sys/devices/system/cpu/cpu19/acpi_cppc/feedback_ctrs:ref:28316604732 del:32229146887
> /sys/devices/system/cpu/cpu19/acpi_cppc/lowest_nonlinear_perf:21
> /sys/devices/system/cpu/cpu19/acpi_cppc/highest_perf:65
> /sys/devices/system/cpu/cpu19/acpi_cppc/nominal_freq:3300
> /sys/devices/system/cpu/cpu19/acpi_cppc/lowest_freq:0
> /sys/devices/system/cpu/cpu19/acpi_cppc/guaranteed_perf:47
> /sys/devices/system/cpu/cpu19/acpi_cppc/nominal_perf:46
> /sys/devices/system/cpu/cpu19/acpi_cppc/lowest_perf:1
> /sys/devices/system/cpu/cpu19/acpi_cppc/reference_perf:54
> /sys/devices/system/cpu/cpu19/acpi_cppc/wraparound_time:18446744073709551615

Thanks,

Russell



Return-Path: <linux-pm+bounces-34512-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3D4B53BB9
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 20:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE0BA173165
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 18:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C452DC76F;
	Thu, 11 Sep 2025 18:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b="FXL6IAJ+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD642DC76B
	for <linux-pm@vger.kernel.org>; Thu, 11 Sep 2025 18:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.84.1.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757616023; cv=none; b=C/5X/INvY3G08gRVB/teIHvQqXmMKA2xBBB/c4V5nJSypDU78L1tKoU6sinhKntD1J3XUGc3xQkP90dZuf+mTnoq3E4Jw6Ccwq+uvgklckk70tDGkkhdsJCUheo5dSsGJor3FivCo0MIc+oZ5Mhmwo5BVQ2TcsXKcmQXTlIIGa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757616023; c=relaxed/simple;
	bh=dPAE1u/RAxCTyMTmM8uSY19s7zZmCtbDoo9lH28bF+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s5Y/5gVJQM6ltc611KnB8Z5uVPiUZKv4Kqs3HwSfHVNUR/2V2VMQSWenDyQzZxkl2RGNoD4izdYgWSd7b4nhYIXFByYeLzNM+VFGOHk9foN58GlQaZl7p7ipLKHc24qs8AjJD2Z0yGAvAnr7K6A9JNVhMgyGT6Xo7TqqJnsBPoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com; spf=pass smtp.mailfrom=panix.com; dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b=FXL6IAJ+; arc=none smtp.client-ip=166.84.1.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=panix.com
Received: from [10.50.4.39] (45-31-46-51.lightspeed.sndgca.sbcglobal.net [45.31.46.51])
	by mailbackend.panix.com (Postfix) with ESMTPSA id 4cN5w26zc4zKl6;
	Thu, 11 Sep 2025 14:40:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
	t=1757616019; bh=dPAE1u/RAxCTyMTmM8uSY19s7zZmCtbDoo9lH28bF+k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=FXL6IAJ+nEwNQA6f1HeBPIhbiz9YfgUoiGyEQpl1ap71bSHfw7y3uQplGwjOfmwza
	 WlSGs9azg6Ylmc4ZWMgvAjU7BvuoqagATYwk1d1blMi6vYfhw88JBKl+JuoSLNSdRs
	 Hw4O4jfoXWTeuf9xRM/hhWb4Bvr2yMHUv/6vGG1w=
Message-ID: <474555e3-dc46-49aa-8e1e-0afbd1dee9ad@panix.com>
Date: Thu, 11 Sep 2025 11:40:17 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Sometimes I only see 3 RAPL (out of 4) Counters
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 Kenneth C <kenny@panix.com>
References: <8ce4578e-6913-4dbe-9573-433e69925bc1@panix.com>
 <CAJZ5v0i4gNcir8sDunPbpSP367tN=PvrsrP61puv954XEtMBKQ@mail.gmail.com>
 <b88dc0fc6604bd18d1658c0d16aa10a2f43eb054.camel@linux.intel.com>
Content-Language: en-US
From: Kenneth Crudup <kenny@panix.com>
In-Reply-To: <b88dc0fc6604bd18d1658c0d16aa10a2f43eb054.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/11/25 11:37, srinivas pandruvada wrote:
> On Thu, 2025-09-11 at 11:42 +0200, Rafael J. Wysocki wrote:
>> +Srinivas & Rui
>>
>> On Thu, Sep 11, 2025 at 2:20 AM Kenneth Crudup <kenny@panix.com>
>> wrote:
>>>
>>> I have a Dell XPS-9320, with a i7-1280P (family: 0x6, model: 0x9a,
>>> stepping: 0x3) CPU. Sometimes I'll only see 3 RAPL counters instead
>>> of
>>> the normal 4. (It used to happen a lot more often, BTW):
>>>
> 
> That is because sometimes the counter for PP1 (GFX ..) is 0 during boot
> and then the PMU code will ignore that. This happens when the counter
> is sampled before GPU is not even started. So this is a race condition.

Is there anything that should/could be done about it?

What's the effect of not having a GPU RAPL available?

> Thanks,
> Srinivas
> 
> 
>>> ----
>>> gunzip --force --stdout /var/log/syslog* | fgrep -i rapl | fgrep
>>> fixed
>>> 2025-09-08T12:09:05.915989-07:00 xps-9320 kernel: [    T1] RAPL
>>> PMU: API
>>> unit is 2^-32 Joules, 3 fixed counters, 655360 ms ovfl timer
>>> 2025-09-09T08:52:19.098522-07:00 xps-9320 kernel: [    T1] RAPL
>>> PMU: API
>>> unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
>>> 2025-09-09T17:25:24.377784-07:00 xps-9320 kernel: [    T1] RAPL
>>> PMU: API
>>> unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
>>> 2025-09-09T17:50:09.334140-07:00 xps-9320 kernel: [    T1] RAPL
>>> PMU: API
>>> unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
>>> 2025-09-10T16:42:13.259270-07:00 xps-9320 kernel: [    T1] RAPL
>>> PMU: API
>>> unit is 2^-32 Joules, 3 fixed counters, 655360 ms ovfl timer
>>> 2025-09-10T16:46:36.322016-07:00 xps-9320 kernel: [    T1] RAPL
>>> PMU: API
>>> unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
>>> 2025-09-02T13:05:02.632218-07:00 xps-9320 kernel: [    T1] RAPL
>>> PMU: API
>>> unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
>>> 2025-09-02T14:07:19.683466-07:00 xps-9320 kernel: [    T1] RAPL
>>> PMU: API
>>> unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
>>> 2025-09-02T14:20:43.602483-07:00 xps-9320 kernel: [    T1] RAPL
>>> PMU: API
>>> unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
>>> 2025-09-04T13:13:38.636326-07:00 xps-9320 kernel: [    T1] RAPL
>>> PMU: API
>>> unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
>>> 2025-09-05T09:21:50.147180-07:00 xps-9320 kernel: [    T1] RAPL
>>> PMU: API
>>> unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
>>> 2025-08-29T10:57:14.419740-07:00 xps-9320 kernel: [    T1] RAPL
>>> PMU: API
>>> unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
>>> 2025-08-17T11:52:55.733943-07:00 xps-9320 kernel: [    T1] RAPL
>>> PMU: API
>>> unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
>>> 2025-08-19T07:52:30.696326-07:00 xps-9320 kernel: [    T1] RAPL
>>> PMU: API
>>> unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
>>> 2025-08-19T07:55:49.083600-07:00 xps-9320 kernel: [    T1] RAPL
>>> PMU: API
>>> unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
>>> 2025-08-20T10:53:54.601680-07:00 xps-9320 kernel: [    T1] RAPL
>>> PMU: API
>>> unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
>>> 2025-08-20T11:00:09.560496-07:00 xps-9320 kernel: [    T1] RAPL
>>> PMU: API
>>> unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
>>> 2025-08-20T11:12:30.580414-07:00 xps-9320 kernel: [    T1] RAPL
>>> PMU: API
>>> unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
>>> ----
>>>
>>> ... and it's always(?) the GPU RAPL:
>>>
>>> ----
>>> gunzip --force --stdout /var/log/syslog* | fgrep -i rapl | cut -d\]
>>> -f2-
>>>> sort -f | uniq -c
>>> grep: (standard input): binary file matches
>>>        18  intel_rapl_common: Found RAPL domain core
>>>        36  intel_rapl_common: Found RAPL domain package
>>>        18  intel_rapl_common: Found RAPL domain psys
>>>        16  intel_rapl_common: Found RAPL domain uncore
>>>        18  intel_rapl_msr: PL4 support detected.
>>>         2  RAPL PMU: API unit is 2^-32 Joules, 3 fixed counters,
>>> 655360
>>> ms ovfl timer
>>>        16  RAPL PMU: API unit is 2^-32 Joules, 4 fixed counters,
>>> 655360
>>> ms ovfl timer
>>>        18  RAPL PMU: hw unit of domain package 2^-14 Joules
>>>        18  RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
>>>        16  RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
>>>        18  RAPL PMU: hw unit of domain psys 2^-14 Joules
>>> ----
>>>
>>> A reboot fixes it up again (and that's if I even notice), but what
>>> would
>>> cause this to happen? What's the effect of it missing the RAPL
>>> counter, BTW?
>>>
>>> LMK if you need more info,
>>>
>>> -Kenny
>>>
>>> --
>>> Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting,
>>> Orange
>>> County CA
>>>
>>>
> 

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange 
County CA



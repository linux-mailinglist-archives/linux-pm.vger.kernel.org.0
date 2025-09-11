Return-Path: <linux-pm+bounces-34425-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54CC3B524F2
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 02:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 120D4582AE9
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 00:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A832AF03;
	Thu, 11 Sep 2025 00:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b="wCmLJVn0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D91184
	for <linux-pm@vger.kernel.org>; Thu, 11 Sep 2025 00:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.84.1.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757550025; cv=none; b=Xiqr6HBghBTrwZSfH2V8IhI1+/Z4Cb+9+2/oIYVblImmFcuoPX1SKkvfqFsyI3TkxzFgWXddeIhjDNRCMmCL4XBA/Dj5VL2vn+3zP8/tESZVzIgD34nf8lbuzUEG6WGdRsVFKkBDIaep9lwByYP/aRqC9vywpufYQwGpS+KHVrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757550025; c=relaxed/simple;
	bh=7v4saj/4ISHFXnaBXmeO8rMTQZGg/5p01g4U1gABTOo=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=nyTw+9FcDmC53LbZb11QyDRwvo5hotJ+5/U4KbWpTGt3g36ERqriTlucq0Y/MBufoFN8DdGcCDjGyI7VdFX/HBmbCMuOlUYQu1S86oXKR6WqVTG0cEn0mQ9583Ewe/0+xtFVDbbhOaUHY/7Wm+nTIhg1tIgKNfzTqbaIBaj+RNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com; spf=pass smtp.mailfrom=panix.com; dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b=wCmLJVn0; arc=none smtp.client-ip=166.84.1.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=panix.com
Received: from [10.50.4.39] (45-31-46-51.lightspeed.sndgca.sbcglobal.net [45.31.46.51])
	by mailbackend.panix.com (Postfix) with ESMTPSA id 4cMdVj635dzNZD;
	Wed, 10 Sep 2025 20:20:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
	t=1757550014; bh=7v4saj/4ISHFXnaBXmeO8rMTQZGg/5p01g4U1gABTOo=;
	h=Date:To:Cc:From:Subject;
	b=wCmLJVn0AUmzy2W4Ff5SiNY/YKXjX+XkUZR4hPYOUB64n2obprByMUcjQ5oEiL77K
	 AYN0stoSVO8fdC235CjsSjWsqGbBuGe764eSeuSky70s2oEyQfOavxX9Cqf0mcf/ea
	 UbUzn5iS/D59BugNBWzLnjEXetFX3ltk5wzBxx8U=
Message-ID: <8ce4578e-6913-4dbe-9573-433e69925bc1@panix.com>
Date: Wed, 10 Sep 2025 17:20:12 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc: Kenneth C <kenny@panix.com>
From: Kenneth Crudup <kenny@panix.com>
Subject: Sometimes I only see 3 RAPL (out of 4) Counters
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I have a Dell XPS-9320, with a i7-1280P (family: 0x6, model: 0x9a, 
stepping: 0x3) CPU. Sometimes I'll only see 3 RAPL counters instead of 
the normal 4. (It used to happen a lot more often, BTW):

----
gunzip --force --stdout /var/log/syslog* | fgrep -i rapl | fgrep fixed
2025-09-08T12:09:05.915989-07:00 xps-9320 kernel: [    T1] RAPL PMU: API 
unit is 2^-32 Joules, 3 fixed counters, 655360 ms ovfl timer
2025-09-09T08:52:19.098522-07:00 xps-9320 kernel: [    T1] RAPL PMU: API 
unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
2025-09-09T17:25:24.377784-07:00 xps-9320 kernel: [    T1] RAPL PMU: API 
unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
2025-09-09T17:50:09.334140-07:00 xps-9320 kernel: [    T1] RAPL PMU: API 
unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
2025-09-10T16:42:13.259270-07:00 xps-9320 kernel: [    T1] RAPL PMU: API 
unit is 2^-32 Joules, 3 fixed counters, 655360 ms ovfl timer
2025-09-10T16:46:36.322016-07:00 xps-9320 kernel: [    T1] RAPL PMU: API 
unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
2025-09-02T13:05:02.632218-07:00 xps-9320 kernel: [    T1] RAPL PMU: API 
unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
2025-09-02T14:07:19.683466-07:00 xps-9320 kernel: [    T1] RAPL PMU: API 
unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
2025-09-02T14:20:43.602483-07:00 xps-9320 kernel: [    T1] RAPL PMU: API 
unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
2025-09-04T13:13:38.636326-07:00 xps-9320 kernel: [    T1] RAPL PMU: API 
unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
2025-09-05T09:21:50.147180-07:00 xps-9320 kernel: [    T1] RAPL PMU: API 
unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
2025-08-29T10:57:14.419740-07:00 xps-9320 kernel: [    T1] RAPL PMU: API 
unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
2025-08-17T11:52:55.733943-07:00 xps-9320 kernel: [    T1] RAPL PMU: API 
unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
2025-08-19T07:52:30.696326-07:00 xps-9320 kernel: [    T1] RAPL PMU: API 
unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
2025-08-19T07:55:49.083600-07:00 xps-9320 kernel: [    T1] RAPL PMU: API 
unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
2025-08-20T10:53:54.601680-07:00 xps-9320 kernel: [    T1] RAPL PMU: API 
unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
2025-08-20T11:00:09.560496-07:00 xps-9320 kernel: [    T1] RAPL PMU: API 
unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
2025-08-20T11:12:30.580414-07:00 xps-9320 kernel: [    T1] RAPL PMU: API 
unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
----

... and it's always(?) the GPU RAPL:

----
gunzip --force --stdout /var/log/syslog* | fgrep -i rapl | cut -d\] -f2- 
| sort -f | uniq -c
grep: (standard input): binary file matches
      18  intel_rapl_common: Found RAPL domain core
      36  intel_rapl_common: Found RAPL domain package
      18  intel_rapl_common: Found RAPL domain psys
      16  intel_rapl_common: Found RAPL domain uncore
      18  intel_rapl_msr: PL4 support detected.
       2  RAPL PMU: API unit is 2^-32 Joules, 3 fixed counters, 655360 
ms ovfl timer
      16  RAPL PMU: API unit is 2^-32 Joules, 4 fixed counters, 655360 
ms ovfl timer
      18  RAPL PMU: hw unit of domain package 2^-14 Joules
      18  RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
      16  RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
      18  RAPL PMU: hw unit of domain psys 2^-14 Joules
----

A reboot fixes it up again (and that's if I even notice), but what would 
cause this to happen? What's the effect of it missing the RAPL counter, BTW?

LMK if you need more info,

-Kenny

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange 
County CA



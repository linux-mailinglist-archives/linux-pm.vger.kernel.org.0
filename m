Return-Path: <linux-pm+bounces-15317-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1C09944E8
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2024 11:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7233AB23A6D
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2024 09:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9706118C916;
	Tue,  8 Oct 2024 09:56:09 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B352817E006;
	Tue,  8 Oct 2024 09:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728381369; cv=none; b=GwlQ++XAzKs5nHdQxbB28UI3qzFTKkECpnESH91JvVCqOjDuKJJyWCVULHkxp4yaou51pzdauLYQnqKDEk/1/YVQNlRVRnHncLngTUkolCRYafG4Ltuk1QJecaj19MMsCm4autsv513YJPtPND9Jh5bjpaXMzWhOxupFwDSZC2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728381369; c=relaxed/simple;
	bh=sflavb67v+3jMqz9cuuU/EBMb/bUrsBD/FaAW31LevQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sXx4kfU76Tfqffa+6xC/gzQte+bZr60ylc0aAKJIKFXRcH1s/D3DYvUXImvK0eVKVTvx2Oe1YZ89ALbUb7doFfdje5nTdikjA1XsngfxGZKKNdb+yOZ05HTzy+s1XOCCWit4a0HUX8kV8alHjEFevNzcJbuNdAO+6iBmOOOKmPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 94059DA7;
	Tue,  8 Oct 2024 02:56:36 -0700 (PDT)
Received: from [10.1.26.27] (unknown [10.1.26.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 13B3C3F640;
	Tue,  8 Oct 2024 02:56:03 -0700 (PDT)
Message-ID: <fa2f15b1-1602-4fd0-80ff-9d33303b7b5a@arm.com>
Date: Tue, 8 Oct 2024 10:56:02 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] sched: Consolidate cpufreq updates
To: Anjali K <anjalik@linux.ibm.com>, Qais Yousef <qyousef@layalina.io>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Juri Lelli <juri.lelli@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
 <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
 Valentin Schneider <vschneid@redhat.com>, Hongyan Xia
 <hongyan.xia2@arm.com>, John Stultz <jstultz@google.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240728184551.42133-1-qyousef@layalina.io>
 <ae65e4aa-3407-4fb0-b1f1-eb7c2626f768@linux.ibm.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <ae65e4aa-3407-4fb0-b1f1-eb7c2626f768@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/7/24 18:20, Anjali K wrote:
> Hi, I tested this patch to see if it causes any regressions on bare-metal power9 systems with microbenchmarks.
> The test system is a 2 NUMA node 128 cpu powernv power9 system. The conservative governor is enabled.
> I took the baseline as the 6.10.0-rc1 tip sched/core kernel.
> No regressions were found.
> 
> +------------------------------------------------------+--------------------+----------+
> |                     Benchmark                        |      Baseline      | Baseline |
> |                                                      |  (6.10.0-rc1 tip   | + patch  |
> |                                                      |  sched/core)       |          |
> +------------------------------------------------------+--------------------+----------+
> |Hackbench run duration (sec)                          |         1          |   1.01   |
> |Lmbench simple fstat (usec)                           |         1          |   0.99   |
> |Lmbench simple open/close (usec)                      |         1          |   1.02   |
> |Lmbench simple read (usec)                            |         1          |   1      |
> |Lmbench simple stat (usec)                            |         1          |   1.01   |
> |Lmbench simple syscall (usec)                         |         1          |   1.01   |
> |Lmbench simple write (usec)                           |         1          |   1      |
> |stressng (bogo ops)                                   |         1          |   0.94   |
> |Unixbench execl throughput (lps)                      |         1          |   0.97   |
> |Unixbench Pipebased Context Switching throughput (lps)|         1          |   0.94   |
> |Unixbench Process Creation (lps)                      |         1          |   1      |
> |Unixbench Shell Scripts (1 concurrent) (lpm)          |         1          |   1      |
> |Unixbench Shell Scripts (8 concurrent) (lpm)          |         1          |   1.01   |
> +------------------------------------------------------+--------------------+----------+
> 
> Thank you,
> Anjali K
> 

The default CPUFREQ_DBS_MIN_SAMPLING_INTERVAL is still to have 2 ticks between
cpufreq updates on conservative/ondemand.
What is your sampling_rate setting? What's your HZ?
Interestingly the context switch heavy benchmarks still show -6% don't they?
Do you mind trying schedutil with a reasonable rate_limit_us, too?

Regards,
Christian



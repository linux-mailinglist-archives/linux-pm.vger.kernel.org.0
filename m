Return-Path: <linux-pm+bounces-15624-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B19199D42E
	for <lists+linux-pm@lfdr.de>; Mon, 14 Oct 2024 18:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CE211F2220A
	for <lists+linux-pm@lfdr.de>; Mon, 14 Oct 2024 16:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FCAC1ABEB8;
	Mon, 14 Oct 2024 16:04:41 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39954156256;
	Mon, 14 Oct 2024 16:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728921881; cv=none; b=E49giC3m+fZaShoPznq2kqISG+O5gJta41oEHpPvbEB/bImDZEIU3e4f3QkPQsuO8bQ1fCdfRZppC6BNchNE1X3g8NI2XcSEKYDX3l9s0KlOztujHdFdzhOX++gYEJPfB+0PTNvTKeHPf+a5pSYPxgeV3Qrf2dlGxfCHvFAKnZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728921881; c=relaxed/simple;
	bh=141OZSwUZquYB5d7J1zr2IvqrEuo8P55ju64vN7jspU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VWhF6nDnqcDrNXlxjeXtH5kkVoDmNyij7ZxuvY2Tz7aYXG8goLe492qiDDLTsgcdt/oRGbFoWaAaCTc2p6aCDa8y1FSnGsOz31dD6cDbo75yHVNEh7WXDeVMfJRfkq/SuMxW7DuugF1nENDvMzN9Ud7idd1x+9YKj12N/CkmWKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 377621007;
	Mon, 14 Oct 2024 09:05:08 -0700 (PDT)
Received: from [10.1.33.17] (e127648.arm.com [10.1.33.17])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 57AFD3F71E;
	Mon, 14 Oct 2024 09:04:36 -0700 (PDT)
Message-ID: <d67d420f-8cd4-4b56-8a93-ebbd513268e8@arm.com>
Date: Mon, 14 Oct 2024 17:04:34 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 08/16] sched/fair: Extend util_est to improve rampup
 time
To: Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: Juri Lelli <juri.lelli@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, John Stultz
 <jstultz@google.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240820163512.1096301-1-qyousef@layalina.io>
 <20240820163512.1096301-9-qyousef@layalina.io>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20240820163512.1096301-9-qyousef@layalina.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/20/24 17:35, Qais Yousef wrote:
> Utilization invariance can cause big delays. When tasks are running,
> accumulate non-invairiant version of utilization to help tasks to settle
> down to their new util_avg values faster.
> 
> Keep track of delta_exec during runnable across activations to help
> update util_est for a long running task accurately. util_est shoudl
> still behave the same at enqueue/dequeue.

For periodic tasks that have longer slices (~tick) this overestimates
util_est by a lot.
AFAICS this also breaks util_est for co-scheduling tasks of different slice
lengths.

I'm testing with HZ=1000, but should work for any. On a RK3399, all pinned
to one big.

Having task A be 10ms period with 20% util (running for 2ms when scheduled)
and tasks B+ with 1ms period and 1% util.

I guess 9/16 tries to work around that somewhat but without any leeway that
doesn't work. Even rt-app tasks will vary slightly in their util_est values:


Task A only:
mainline:
A:
util_avg: 192 util_est: 204

9/16 sched/fair: util_est: Take into account periodic tasks
A:
util_avg: 185 util_est: 423

8 tasks:
mainline:
A:
util_avg: 229 util_est: 229
The rest
util_avg:  12 util_est:  24

9/16 sched/fair: util_est: Take into account periodic tasks
A:
util_avg: 242 util_est: 643
The rest:
util_avg:  12 util_est:  50


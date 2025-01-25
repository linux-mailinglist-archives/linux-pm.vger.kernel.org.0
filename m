Return-Path: <linux-pm+bounces-20949-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1468CA1C2E7
	for <lists+linux-pm@lfdr.de>; Sat, 25 Jan 2025 12:18:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61DF01678D5
	for <lists+linux-pm@lfdr.de>; Sat, 25 Jan 2025 11:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5D81D5149;
	Sat, 25 Jan 2025 11:18:44 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1453A38FAD;
	Sat, 25 Jan 2025 11:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737803924; cv=none; b=fiZCD1w89jb28z2dUiO3zkAueqLJ3JbmdDSY9abMhXN08vssQV5wJd2MsKEbAjoGBDIsrgkBXTKQC+/NGInv3ZiwDQ5d05EhsX0vXvlD1F+XuoVXpagJILAgAFeaJtGbQ4YFpfgE0sK7TKSRO9PoUh9XoSsfC/70kjaiJ/az+no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737803924; c=relaxed/simple;
	bh=eBRmM1it6xLmC4Wke+5kOZnpjwqyg8/6sdoMNGlZZU4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LmdLub2c7o8/5lKNb45488L6viREvBf7jB6m+DfcVR/gMF4XsnZc0hGxHWIz/eGjZeP5Qr7F8DdoKhqW0gBs+cdJjxz6J5L0E3IIp6mK3+SIwhLIaF9PnHrRiMny0dqooz0UcpAxgbBEnCuAPrNEN01N4pTBGuoV6UtZ0sBXYz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8EA63497;
	Sat, 25 Jan 2025 03:19:01 -0800 (PST)
Received: from [192.168.2.98] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5FAD63F5A1;
	Sat, 25 Jan 2025 03:18:32 -0800 (PST)
Message-ID: <be830a7a-410e-4864-adaf-0c68bb1135f1@arm.com>
Date: Sat, 25 Jan 2025 12:18:23 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH v021 0/9] cpufreq: intel_pstate: Enable EAS on hybrid
 platforms without SMT
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Morten Rasmussen <morten.rasmussen@arm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
 Pierre Gondois <pierre.gondois@arm.com>
References: <5861970.DvuYhMxLoT@rjwysocki.net>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <5861970.DvuYhMxLoT@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/11/2024 16:55, Rafael J. Wysocki wrote:

[...]

> For easier access, the series is available on the experimental/intel_ostate
> branch in linux-pm.git:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/log/?h=experimental/intel_pstate

I was wondering how we can test the EAS behaviour (power/perf) on Intel
hybrid machines.

I have system-wide RAPL 'power/energy-{cores,pkg}' events for power
(energy) on my i7-13700K (nosmt) so I can run an rt-app workload
(e.g. 30 5% tasks (0.8ms/16ms)) with:

perf stat -e power/energy-cores/,power/energy-pkg/ --repeat 10 ./rt-app.sh

Plus I can check for negative slack for those rt-app-test tasks (perf)
and do ftrace-based task placement evaluation.

base:

 Performance counter stats for 'system wide' (10 runs):

       52.67 Joules power/energy-cores/       ( +-  1.24% )
       85.09 Joules power/energy-pkg/         ( +-  0.83% )

   34.922801 +- 0.000736 seconds time elapsed ( +-  0.00% )


EAS:

 Performance counter stats for 'system wide' (10 runs):

       45.55 Joules power/energy-cores/       ( +-  1.07% )
       75.73 Joules power/energy-pkg/         ( +-  0.67% )

   34.93183 +- 0.00514 seconds time elapsed  ( +-  0.01% )

Do you have another (maybe more sophisticated) test methodology?



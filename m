Return-Path: <linux-pm+bounces-32032-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5BCAB1D5C1
	for <lists+linux-pm@lfdr.de>; Thu,  7 Aug 2025 12:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C05DA18A58F6
	for <lists+linux-pm@lfdr.de>; Thu,  7 Aug 2025 10:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EAC223D281;
	Thu,  7 Aug 2025 10:25:07 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3315B219311;
	Thu,  7 Aug 2025 10:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754562307; cv=none; b=HDSdSz+qh1ohwbvBdG+lUh2uCSplT1DNvtNd4Pe/kpiFweltS293XF83UNuVuO/eHS+BOl7bnFBp1qQfuj5fyjFy/iluiu7oCzwLho8eOQefGNTTrr61V3w7MKJAwp29Bb6GtIY36WEfXxCcBcOBx/f1Zj9B3zM47vKgCVObRWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754562307; c=relaxed/simple;
	bh=U1GAhsFmP/9ZpJ0WEA2ajL6DUWdnUB3fZA0kjlfVRVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tYDrdA2WFwjv//lm0SRCAkI7p8/V+rHExxZHbaLoZYs9pYJ24Me6cK3RGiOogTVQ9Ta5BXLMtGK6jFRyzCo61YoWprmJKpf1Ieh+4wGl4jP22EgHmoYvTLqEIXsE+Nnye/er4u5LD3LgFGWkoRdhL7liwcFp6SX7WAfMGRoCUkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1CF3F236D;
	Thu,  7 Aug 2025 03:24:55 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D77FF3F738;
	Thu,  7 Aug 2025 03:24:57 -0700 (PDT)
Date: Thu, 7 Aug 2025 12:24:32 +0200
From: Beata Michalska <beata.michalska@arm.com>
To: Prashant Malani <pmalani@google.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Jie Zhan <zhanjie9@hisilicon.com>,
	Ionela Voinescu <ionela.voinescu@arm.com>,
	Ben Segall <bsegall@google.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
	Mel Gorman <mgorman@suse.de>, Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	z00813676 <zhenglifeng1@huawei.com>, sudeep.holla@arm.com
Subject: Re: [PATCH v2 2/2] cpufreq: CPPC: Dont read counters for idle CPUs
Message-ID: <aJR-4J-sTpLaNIJB@arm.com>
References: <20250722032727.zmdwj6ztitkmr4pf@vireshk-i7>
 <CAFivqmLG0LriipbmM8qXZMKRRpH3_D02dNipnzj2aWRf9mSdCA@mail.gmail.com>
 <CAFivqmJ4nf_WnCZTNGke+9taaiJ9tZLvLL4Mx_B7uR-1DR_ajA@mail.gmail.com>
 <aIso4kLtChiQkBjH@arm.com>
 <CAFivqm+kbRbJsJ_Obb4bV6fgxbqAwOndLUCDwHvWWnpMYoNoNw@mail.gmail.com>
 <aIvSe9VtZ-zlYfbQ@arm.com>
 <CAFivqmKR1dqVqTsoznH2-n8cyAM1=5zEGcEvmESU8RNGac-0sA@mail.gmail.com>
 <CAFivqmKgiVEWMQ90Lh6T+Y44E6m4jmdF5sUFfVNTmgVHOMtZsw@mail.gmail.com>
 <aJMCgGt5zu5Dhrd5@arm.com>
 <CAFivqmLSp6RwfsPBK0d=zvRd6M_5GoeU4jHb-0OM9BpaDeSrzA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFivqmLSp6RwfsPBK0d=zvRd6M_5GoeU4jHb-0OM9BpaDeSrzA@mail.gmail.com>

On Wed, Aug 06, 2025 at 05:01:48PM -0700, Prashant Malani wrote:
> Hi Beata,
> 
> On Wed, 6 Aug 2025 at 00:22, Beata Michalska <beata.michalska@arm.com> wrote:
> > Would you mind giving it a go and see whether that improves things on your end ?
> > Note that this is a quick and semi-dirty hack though.
> >
> 
> Sure.
> The provided patch doesn't appear to work as expected.
> With all cores loaded (stress_ng --cpu N), it's returning the same
> counter values
> across samples. Here are readings from multiple CPUs:
> 
> t0: del:18446603338626579088, ref:192
> t1: del:18446603338626579088, ref:192
> ref_perf:10
> delivered_perf:0
> 
> 
> t0: del:18446603338627594896, ref:192
> t1: del:18446603338627594896, ref:192
> ref_perf:10
> delivered_perf:0
> 
> t0: del:18446603338627627664, ref:192
> t1: del:18446603338627627664, ref:192
> ref_perf:10
> delivered_perf:0
> 
> I verified separately that the "burst_read" path is being used by the platform
> I am testing on.
> 
> BR,
>
> -Prashant
Right .... that's what happens when you are (I am) making last minute clean up.
That should fix it. Would you mind giving it another go ? Would appreciate it.

---
BR
Beata

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 65adb78a9a87..2a51e93fcd6c 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -543,7 +543,7 @@ void counters_burst_read_on_cpu(void *arg)
 
 static inline bool cpc_reg_supported(struct cpc_reg *reg)
 {
-       return !((u64)reg->address != 0x0 || (u64)reg->address != 0x1);
+       return !((u64)reg->address != 0x0 && (u64)reg->address != 0x1);
 }
 
 int cpc_burst_read_ffh(int cpu, struct cpc_reg_sample *samples, size_t count)


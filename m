Return-Path: <linux-pm+bounces-31707-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C03CB17729
	for <lists+linux-pm@lfdr.de>; Thu, 31 Jul 2025 22:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DAE75A12F7
	for <lists+linux-pm@lfdr.de>; Thu, 31 Jul 2025 20:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EFF62222D8;
	Thu, 31 Jul 2025 20:31:16 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4834119ABAC;
	Thu, 31 Jul 2025 20:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753993876; cv=none; b=Z6J+YSjesCnR54H2LVgwza/3IwMhrNv7u9JgLqH0OrBqQik65mt3uJ6FnanUYjvOUnoevN4nZBT0x4thOl3Lne4+yaHjjOvW2UjzPMQWdDlzEgsfAZSjvMYXd561fE0xRii4/FjQ+1k89R3oVtQs2VZvUClw3ez2BWTOpOQ4xTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753993876; c=relaxed/simple;
	bh=Jq3XCtWkGoIl+7QfBw+jWIvM7XLZnkUB4MlR2CqrATE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pafgJmynGQAiF87c9T+gBKf3Mg44MjdWPqcaABKH16bizc5fWB7ZJULGc65JD+qoqwEJRWhuP63xDTPJTyoAImH8FL36FX6HkCzrBj+idcjCU3SIouJ1NQmp+IwyFAs5ZWMerVFpns95eKhwz2L/8briP6WcwcJNaLD5ROf8nuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4EF15176A;
	Thu, 31 Jul 2025 13:31:05 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 14DE93F5A1;
	Thu, 31 Jul 2025 13:31:06 -0700 (PDT)
Date: Thu, 31 Jul 2025 22:30:51 +0200
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
Message-ID: <aIvSe9VtZ-zlYfbQ@arm.com>
References: <CAFivqmKBgYVa6JUh82TS2pO915PUDYZMH+k-5=-0u1-K9-gMMw@mail.gmail.com>
 <aHTOSyhwIAaW_1m1@arm.com>
 <CAFivqmJ912sEdSih_DFkiWRm478XUJhNDe=s2M_UO2gVTu4e3w@mail.gmail.com>
 <CAJZ5v0irG16e2cM_tX_UeEJVmB_EdUvk-4Nv36dXoUS=Ud3U5A@mail.gmail.com>
 <CAFivqmLoDv_pWdmBG8ws-CMUBXcb9bS1TgMaxW9YZMqqHpRSyA@mail.gmail.com>
 <20250722032727.zmdwj6ztitkmr4pf@vireshk-i7>
 <CAFivqmLG0LriipbmM8qXZMKRRpH3_D02dNipnzj2aWRf9mSdCA@mail.gmail.com>
 <CAFivqmJ4nf_WnCZTNGke+9taaiJ9tZLvLL4Mx_B7uR-1DR_ajA@mail.gmail.com>
 <aIso4kLtChiQkBjH@arm.com>
 <CAFivqm+kbRbJsJ_Obb4bV6fgxbqAwOndLUCDwHvWWnpMYoNoNw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFivqm+kbRbJsJ_Obb4bV6fgxbqAwOndLUCDwHvWWnpMYoNoNw@mail.gmail.com>

On Thu, Jul 31, 2025 at 09:51:51AM -0700, Prashant Malani wrote:
> HI Beata,
> 
> On Thu, 31 Jul 2025 at 01:27, Beata Michalska <beata.michalska@arm.com> wrote:
> > In the meantime I'm still trying to figure out smht to mitigate the issues with
> > the numbers we get from counters after waking up the CPU.
> 
> My attempt at that is here: [1]
> It's been proposed before, but it's increasing the delay between samples.
> 
> [1] https://lore.kernel.org/linux-pm/20250730220812.53098-1-pmalani@google.com/
Thank you for the info, but I'm exploring ways that will not increase the time
window between the reads.
While we are at it, would you be able to drop me some numbers from your
platform, preferably good and `bad` ones:
both counter values, and the bits that are used for mapping performance to
actual frequency (nominal freq/perf, reference perf)

---
BR
Beata
> 
> BR,
> 
> -Prashant


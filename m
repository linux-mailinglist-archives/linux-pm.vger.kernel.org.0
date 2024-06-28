Return-Path: <linux-pm+bounces-10193-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C85D91BF08
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 14:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E76311F24856
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 12:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A438F1BE258;
	Fri, 28 Jun 2024 12:51:14 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3543C1BE24C;
	Fri, 28 Jun 2024 12:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719579074; cv=none; b=Cf6vqCTX7Hadj5W/owajm8gxFFaOA5UbbitZaX9cRWfZHGPUkXg1fZTDaZcVFCfHvsmqRFrw0z/fzFyl+iIjDzDTqh16UxynmNGviVpKq9C5r3zfY2nTJmwt7ktEI70iPQ/UllhsdJaRaX9wls4TItDrtaCgz812s5+g/XOnCpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719579074; c=relaxed/simple;
	bh=H5gIxHrgOR9xxPPd9H0f4XSK1Nm06i4f3r2x9UoDmuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qZQrXGiQ/6YJhuZr3Rhnie1RiXUoR3anZYoQ90XR1HijseXejTyQF0fomXWYsUz0CG1LuAIfOyCa4JCGt96mVQGfbQVVUJE3j1qvMsg7NjIixWCtP+TT4LIbtCokrdhLTYWHJRIIm3sYQZvc6yrVyGQmW+p2Hwf0BgzlD7SiKQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5C5D5106F;
	Fri, 28 Jun 2024 05:51:36 -0700 (PDT)
Received: from bogus (unknown [10.57.81.131])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EA06D3F73B;
	Fri, 28 Jun 2024 05:51:06 -0700 (PDT)
Date: Fri, 28 Jun 2024 13:51:06 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: David Dai <davidai@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Quentin Perret <qperret@google.com>,
	Masami Hiramatsu <mhiramat@google.com>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Pavan Kondeti <quic_pkondeti@quicinc.com>,
	Gupta Pankaj <pankaj.gupta@amd.com>, Mel Gorman <mgorman@suse.de>,
	kernel-team@android.com, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] cpufreq: add virtual-cpufreq driver
Message-ID: <20240628125106.i4hhyzdgt3uoskat@bogus>
References: <20240521043102.2786284-1-davidai@google.com>
 <20240521043102.2786284-3-davidai@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240521043102.2786284-3-davidai@google.com>

On Mon, May 20, 2024 at 09:30:52PM -0700, David Dai wrote:
> Introduce a virtualized cpufreq driver for guest kernels to improve
> performance and power of workloads within VMs.
>
> This driver does two main things:
>
> 1. Sends the frequency of vCPUs as a hint to the host. The host uses the
> hint to schedule the vCPU threads and decide physical CPU frequency.
>
> 2. If a VM does not support a virtualized FIE(like AMUs), it queries the
> host CPU frequency by reading a MMIO region of a virtual cpufreq device
> to update the guest's frequency scaling factor periodically. This enables
> accurate Per-Entity Load Tracking for tasks running in the guest.
>
> +
> +/*
> + * CPU0..CPUn
> + * +-------------+-------------------------------+--------+-------+
> + * | Register    | Description                   | Offset |   Len |
> + * +-------------+-------------------------------+--------+-------+
> + * | cur_perf    | read this register to get     |    0x0 |   0x4 |
> + * |             | the current perf (integer val |        |       |
> + * |             | representing perf relative to |        |       |
> + * |             | max performance)              |        |       |
> + * |             | that vCPU is running at       |        |       |
> + * +-------------+-------------------------------+--------+-------+
> + * | set_perf    | write to this register to set |    0x4 |   0x4 |
> + * |             | perf value of the vCPU        |        |       |
> + * +-------------+-------------------------------+--------+-------+
> + * | perftbl_len | number of entries in perf     |    0x8 |   0x4 |
> + * |             | table. A single entry in the  |        |       |
> + * |             | perf table denotes no table   |        |       |
> + * |             | and the entry contains        |        |       |
> + * |             | the maximum perf value        |        |       |
> + * |             | that this vCPU supports.      |        |       |
> + * |             | The guest can request any     |        |       |
> + * |             | value between 1 and max perf  |        |       |
> + * |             | when perftbls are not used.   |        |       |
> + * +---------------------------------------------+--------+-------+
> + * | perftbl_sel | write to this register to     |    0xc |   0x4 |
> + * |             | select perf table entry to    |        |       |
> + * |             | read from                     |        |       |
> + * +---------------------------------------------+--------+-------+
> + * | perftbl_rd  | read this register to get     |   0x10 |   0x4 |
> + * |             | perf value of the selected    |        |       |
> + * |             | entry based on perftbl_sel    |        |       |
> + * +---------------------------------------------+--------+-------+
> + * | perf_domain | performance domain number     |   0x14 |   0x4 |
> + * |             | that this vCPU belongs to.    |        |       |
> + * |             | vCPUs sharing the same perf   |        |       |
> + * |             | domain number are part of the |        |       |
> + * |             | same performance domain.      |        |       |
> + * +-------------+-------------------------------+--------+-------+
> + */

I think it is good idea to version this table, so that it gives flexibility
to update the entries. It is a must if we are getting away with DT. I didn't
give complete information in my previous response where I agreed with Rafael.

I am not sure how much feasible it is, but can it be queried via KVM IOCTLs
to VMM. Just a thought, I am exploring how to make this work even on ACPI
systems. It is simpler if we neednot rely on DT or ACPI.

--
Regards,
Sudeep


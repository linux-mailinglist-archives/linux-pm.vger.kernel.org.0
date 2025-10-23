Return-Path: <linux-pm+bounces-36722-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E5129C01448
	for <lists+linux-pm@lfdr.de>; Thu, 23 Oct 2025 15:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 910C635195B
	for <lists+linux-pm@lfdr.de>; Thu, 23 Oct 2025 13:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BEB6314A8D;
	Thu, 23 Oct 2025 13:09:14 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF07313544;
	Thu, 23 Oct 2025 13:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761224954; cv=none; b=NkLhz2Q+ge0pMs3dvZ/2mbsl0BPtfnIAwjyjuin69dzYduXki/8ww44mJke9L+gbxLHPQc2BITPUCP101Ne5J+CS0ewDnkP+cfquKz+xl0iY93lTtBcId+wewSMIkx8n91zHgO7XqVp7+V1mgDleaAKifOg7l0B0Cig5szG66Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761224954; c=relaxed/simple;
	bh=LY+i7YCMScinIDDvmpsQhev0bahRF1MSCvBZv/Dlh7Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o5DPkCS0gCMMoEWsl4giOLBuzS9FyQYC15jhzcL4uMkWMAsE2sYCrSmADuTDDzUHq767dNbN4BY4I+x6psjktGKkcx5vJczNYeEyiUIOrac2axgjhSo8CPSyRu/mcEKDv39fF9066W4WuxR54drSLY+UY+Idu0D9Khwb5v+DTks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C6EF1516;
	Thu, 23 Oct 2025 06:09:03 -0700 (PDT)
Received: from [10.57.3.59] (unknown [10.57.3.59])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E65E83F63F;
	Thu, 23 Oct 2025 06:09:08 -0700 (PDT)
Message-ID: <eb9abe9d-3d12-4bf1-85da-deb38b8da321@arm.com>
Date: Thu, 23 Oct 2025 14:09:36 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] PM QoS: Add CPU affinity latency QoS support and
 resctrl integration
To: Zhongqiu Han <quic_zhonhan@quicinc.com>
Cc: linux-pm@vger.kernel.org, lenb@kernel.org, christian.loehle@arm.com,
 amit.kucheria@linaro.org, ulf.hansson@linaro.org, james.morse@arm.com,
 Dave.Martin@arm.com, reinette.chatre@intel.com, tony.luck@intel.com,
 pavel@kernel.org, linux-kernel@vger.kernel.org, rafael@kernel.org
References: <20250721124104.806120-1-quic_zhonhan@quicinc.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20250721124104.806120-1-quic_zhonhan@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Zhongqui,

My apologies for being a bit late with my comments...

On 7/21/25 13:40, Zhongqiu Han wrote:
> Hi all,
> 
> This patch series introduces support for CPU affinity-based latency
> constraints in the PM QoS framework. The motivation is to allow
> finer-grained power management by enabling latency QoS requests to target
> specific CPUs, rather than applying system-wide constraints.
> 
> The current PM QoS framework supports global and per-device CPU latency
> constraints. However, in many real-world scenarios, such as IRQ affinity
> or CPU-bound kernel threads, only a subset of CPUs are
> performance-critical. Applying global constraints in such cases
> unnecessarily prevents other CPUs from entering deeper C-states, leading
> to increased power consumption.
> 
> This series addresses that limitation by introducing a new interface that
> allows latency constraints to be applied to a CPU mask. This is
> particularly useful on heterogeneous platforms (e.g., big.LITTLE) and
> embedded systems where power efficiency is critical for example:
> 
>                          driver A       rt kthread B      module C
>    CPU IDs (mask):         0-3              2-5              6-7
>    target latency(us):     20               30               100
>                            |                |                |
>                            v                v                v
>                            +---------------------------------+
>                            |        PM  QoS  Framework       |
>                            +---------------------------------+
>                            |                |                |
>                            v                v                v
>    CPU IDs (mask):        0-3            2-3,4-5            6-7
>    runtime latency(us):   20             20, 30             100
> 
> The current implementation includes only cpu_affinity_latency_qos_add()
> and cpu_affinity_latency_qos_remove() interfaces. An update interface is
> planned for future submission, along with PM QoS optimizations in the UFS
> subsystem.
> 
> Patch1 introduces the core support for CPU affinity latency QoS in the PM
> QoS framework.
> 
> Patch2 removes redundant KERN_ERR prefixes in WARN() calls in the global
> CPU PM QoS interface. This change addresses issues in existing code and is
> not related to the new interface introduced in this patch series.
> 
> Patch3 adds documentation for the new interface.
> 
> Patch4 fixes a minor documentation issue related to the return type of
> cpu_latency_qos_request_active(). This change addresses issues in existing
> doc and is not related to the new interface introduced in this patch
> series.
> 
> Patch5 updates the resctrl pseudo-locking logic to use the new CPU
> affinity latency QoS helpers, improving clarity and consistency. The only
> functional and beneficial change is that the new interface actively wakes
> up CPUs whose latency QoS values have changed, ensuring the latency limit
> takes effect immediately.

Could you describe a bit more the big picture of this proposed design,
please?

Ideally with some graph of connected frameworks & drivers and how they
are going to work together.

E.g.:
1. what are the other components in the kernel which would use this
feature?
2. is there also a user-space interface planned for it so a HAL in
the middle-ware would configure these "short-wake-up-CPU"?
3. Is it possible to view/debug from the user-space which component
requested this setting for some subsets of cpus?

Regards,
Lukasz



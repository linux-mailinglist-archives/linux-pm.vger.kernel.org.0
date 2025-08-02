Return-Path: <linux-pm+bounces-31776-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 031BFB18F26
	for <lists+linux-pm@lfdr.de>; Sat,  2 Aug 2025 16:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9165C189B82D
	for <lists+linux-pm@lfdr.de>; Sat,  2 Aug 2025 14:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980172236E8;
	Sat,  2 Aug 2025 14:39:08 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F514964E;
	Sat,  2 Aug 2025 14:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754145548; cv=none; b=LTpZrjver68Okw3vYgdP+/GAY+Xqv4fh1zIRB3x+xxKwS607YzK+BPATRsWh+XD15KROhYRJhDawMH1ExKYCe6jlaQ7qcKurGtEung+H5gKfwpPmIei/ETG75DyFvk1xGZKaiLt2oZe0XPr3KKCf+ZLqHxry7fyz9xrPA+6o+RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754145548; c=relaxed/simple;
	bh=prJVbS+16qGA/VnkiHc+1rLxYNvHramjrAFa4Rp8WQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e5wlQeyqBo81kMzqblVe82Q7xDqkawqS/sG78mUfOjFgWlklmEs0fvOuGdB7yV0RjNuy0qVT4WSpxLiWbgnk+DhUSkgYiLB8KrRq4K4eNCQu6sS27Cvc/9wGPdK5NUV9Qhkg62XWQq96XaGu5BdWqUvp8dzqgtOoVWO2BhGni6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F4461595;
	Sat,  2 Aug 2025 07:38:51 -0700 (PDT)
Received: from [192.168.0.16] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D810C3F673;
	Sat,  2 Aug 2025 07:38:56 -0700 (PDT)
Message-ID: <f682e782-ffea-48b2-997d-ddbaf7ea8a8f@arm.com>
Date: Sat, 2 Aug 2025 15:38:54 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] PM QoS: Add CPU affinity latency QoS support and
 resctrl integration
To: Zhongqiu Han <quic_zhonhan@quicinc.com>, rafael@kernel.org,
 lenb@kernel.org, pavel@kernel.org, tony.luck@intel.com,
 reinette.chatre@intel.com, Dave.Martin@arm.com, james.morse@arm.com,
 ulf.hansson@linaro.org, amit.kucheria@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250721124104.806120-1-quic_zhonhan@quicinc.com>
 <2379088e-e5d0-4766-9968-756aad04f9a3@arm.com>
 <819fb853-59f7-4296-8499-715c142487f5@quicinc.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <819fb853-59f7-4296-8499-715c142487f5@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/28/25 11:40, Zhongqiu Han wrote:
> On 7/28/2025 6:09 PM, Christian Loehle wrote:
>> On 7/21/25 13:40, Zhongqiu Han wrote:
>>> Hi all,
>>>
>>> This patch series introduces support for CPU affinity-based latency
>>> constraints in the PM QoS framework. The motivation is to allow
>>> finer-grained power management by enabling latency QoS requests to target
>>> specific CPUs, rather than applying system-wide constraints.
>>>
>>> The current PM QoS framework supports global and per-device CPU latency
>>> constraints. However, in many real-world scenarios, such as IRQ affinity
>>> or CPU-bound kernel threads, only a subset of CPUs are
>>> performance-critical. Applying global constraints in such cases
>>> unnecessarily prevents other CPUs from entering deeper C-states, leading
>>> to increased power consumption.
>>>
>>> This series addresses that limitation by introducing a new interface that
>>> allows latency constraints to be applied to a CPU mask. This is
>>> particularly useful on heterogeneous platforms (e.g., big.LITTLE) and
>>> embedded systems where power efficiency is critical for example:
>>>
>>>                          driver A       rt kthread B      module C
>>>    CPU IDs (mask):         0-3              2-5              6-7
>>>    target latency(us):     20               30               100
>>>                            |                |                |
>>>                            v                v                v
>>>                            +---------------------------------+
>>>                            |        PM  QoS  Framework       |
>>>                            +---------------------------------+
>>>                            |                |                |
>>>                            v                v                v
>>>    CPU IDs (mask):        0-3            2-3,4-5            6-7
>>>    runtime latency(us):   20             20, 30             100
>>>
>>> The current implementation includes only cpu_affinity_latency_qos_add()
>>> and cpu_affinity_latency_qos_remove() interfaces. An update interface is
>>> planned for future submission, along with PM QoS optimizations in the UFS
>>> subsystem.
>>
>> So what's needed for the UFS use-case additionally?
>> Would adding that here be too much?
>>
> 
> Hi Christian,
> Thanks for your review and discussion~
> 
> Currently my plan is only to move forward with the current patch series,
> which includes only the below interfaces:
> 
> cpu_affinity_latency_qos_add()
> cpu_affinity_latency_qos_remove()
> cpu_affinity_latency_qos_active()
> 
> 
> For most use-cases, seems these three interfaces already sufficient.

Probably, but IMO there's no real user of the new extended interface yet,
making review harder and lacking justification.

FWIW in 2014 Lina also pushed for something like $SUBJECT
https://lore.kernel.org/all/1407945689-18494-5-git-send-email-lina.iyer@linaro.org/
Lina made an interface to tie the PM QoS to the relevant irq, which I think
was a great idea. Maybe that series is interesting for you, too?

> 
> 
> The reason I mentioned UFS is to explain why the update
> interface cpu_affinity_latency_qos_update()
> 
> is not included at this stage. The UFS use-case is planned to
> use the cpu_affinity_latency_qos_update() interface in the future, which
> is similar to the global CPU PM QoS interface
> cpu_latency_qos_update_request().



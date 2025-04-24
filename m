Return-Path: <linux-pm+bounces-26109-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65DA6A9AA1F
	for <lists+linux-pm@lfdr.de>; Thu, 24 Apr 2025 12:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 860DE1B80B62
	for <lists+linux-pm@lfdr.de>; Thu, 24 Apr 2025 10:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB63A228C9D;
	Thu, 24 Apr 2025 10:25:25 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2BA223DEF;
	Thu, 24 Apr 2025 10:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745490325; cv=none; b=nTP78v+8cf/u1D4EVA9em26ZHc/9o2lgpZ6rIHMC9+7T16RJedU3RfD/Gt/KI1h4TBwgtJJlaqPQp6j2oYe4iSQz4kakbcpsSfqyY9GkPjwYXC9AmTPlN1DvXkyCxEXijXmiTZ3S2wh0KnetWr4empxlx6Z4CBiE/sMdnfCwD4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745490325; c=relaxed/simple;
	bh=cW0GuZM89HLxIlPU/JWaAt0GnAvSsNWy7YYz1yjAE9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mnzxn730Lj0mdm5Jgx9HPp/ccDHi87EhKF2nLSjqDMH7ws5BJmsds7VXcaNzl+VpBVoVtZhF95/ABPlHqScZ1iOqFzyEa1Ha4v6NVDFWuauwjYGbnE/0udSx3kZCTs/gEyGxrvnMNUv/X1xyAY3aKKQ/gOKVmS8b/O7UcJIDwNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7E3161063;
	Thu, 24 Apr 2025 03:25:17 -0700 (PDT)
Received: from [10.57.72.192] (unknown [10.57.72.192])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4B93E3F66E;
	Thu, 24 Apr 2025 03:25:21 -0700 (PDT)
Message-ID: <31742ec7-c1c5-4cb9-8c13-a30b7a6033be@arm.com>
Date: Thu, 24 Apr 2025 11:25:19 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PM: QoS: Add support for CPU affinity mask-based CPUs
 latency QoS
To: Zhongqiu Han <quic_zhonhan@quicinc.com>, rafael@kernel.org,
 pavel@kernel.org, len.brown@intel.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250424095228.1112558-1-quic_zhonhan@quicinc.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20250424095228.1112558-1-quic_zhonhan@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/24/25 10:52, Zhongqiu Han wrote:
> Currently, the PM QoS framework supports global CPU latency QoS and
> per-device CPU latency QoS requests. An example of using global CPU
> latency QoS is a commit 2777e73fc154 ("scsi: ufs: core: Add CPU latency
> QoS support for UFS driver") that improved random io performance by 15%
> for ufs on specific device platform.
> 
> However, this prevents all CPUs in the system from entering C states.
> Typically, some threads or drivers know which specific CPUs they are
> interested in. For example, drivers with IRQ affinity only want interrupts
> to wake up and be handled on specific CPUs. Similarly, kernel thread bound
> to specific CPUs through affinity only care about the latency of those
> particular CPUs.
> 
> This patch introduces support for partial CPUs PM QoS using a CPU affinity
> mask, allowing flexible and more precise latency QoS settings for specific
> CPUs. This can help save power, especially on heterogeneous platforms with
> big and little cores, as well as some power-conscious embedded systems for
> example:
> 
>                   driver A       rt kthread B      module C
> QoS cpu mask:       0-3              2-5              6-7
> target latency:     20               30               50
>                     |                |                |
>                     v                v                v
>                     +---------------------------------+
>                     |        PM  QoS  Framework       |
>                     +---------------------------------+
>                     |                |                |
>                     v                v                v
> cpu mask:          0-3            2-3,4-5            6-7
> actual latency:    20             20, 30             50
> 
> Implement this support based on per-device CPU latency PM QoS.
> 
> Signed-off-by: Zhongqiu Han <quic_zhonhan@quicinc.com>

I like the idea!
The interface does need an in-tree user, why not convert the UFS driver?



Return-Path: <linux-pm+bounces-31470-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E61B6B13897
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 12:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A4C016FFE3
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 10:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F80221F38;
	Mon, 28 Jul 2025 10:09:29 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61AF324678A;
	Mon, 28 Jul 2025 10:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753697369; cv=none; b=t4d+ZxftWa6vARTphwz3Qc2UdOrn/1ANHMXNNn78e0VekhEEkIQO607ROfBd1oHKifSvAJ6pjE1cdl6MbXNLarto9nW2UwPRAi52ipkFHk8DvsOXO2BgwyLvcwndTaBmamZlHyrU4ud9IPZCoKOZJa7P+FauZEKTAhb+utUjS1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753697369; c=relaxed/simple;
	bh=YwpDbtQ4igtklqZ11ynCP/oC/wE+ptOrTHoGDSXNf7E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nAK7OVKd3anYS59/rdK8g+lF6aF+LF4weY7zEoRvrVCNGTYZ/8+vDU0oXJGa1Pi589sOfGuv2hLHvATi4Dy0S13hRzgTDeyUECok+1XifaacWrGZoWqUakTNr+aqUa11TSFLAEhaSb80zRyPDPgcg/D/ZoFGMlBOueoAtqnsgBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 91A841515;
	Mon, 28 Jul 2025 03:09:19 -0700 (PDT)
Received: from [10.57.71.150] (unknown [10.57.71.150])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 145D93F673;
	Mon, 28 Jul 2025 03:09:24 -0700 (PDT)
Message-ID: <2379088e-e5d0-4766-9968-756aad04f9a3@arm.com>
Date: Mon, 28 Jul 2025 11:09:22 +0100
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
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20250721124104.806120-1-quic_zhonhan@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

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
>                         driver A       rt kthread B      module C
>   CPU IDs (mask):         0-3              2-5              6-7
>   target latency(us):     20               30               100
>                           |                |                |
>                           v                v                v
>                           +---------------------------------+
>                           |        PM  QoS  Framework       |
>                           +---------------------------------+
>                           |                |                |
>                           v                v                v
>   CPU IDs (mask):        0-3            2-3,4-5            6-7
>   runtime latency(us):   20             20, 30             100
> 
> The current implementation includes only cpu_affinity_latency_qos_add()
> and cpu_affinity_latency_qos_remove() interfaces. An update interface is
> planned for future submission, along with PM QoS optimizations in the UFS
> subsystem.

So what's needed for the UFS use-case additionally?
Would adding that here be too much?



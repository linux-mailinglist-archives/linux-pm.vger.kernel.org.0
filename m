Return-Path: <linux-pm+bounces-31756-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1FE3B1811D
	for <lists+linux-pm@lfdr.de>; Fri,  1 Aug 2025 13:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D50C61C829DB
	for <lists+linux-pm@lfdr.de>; Fri,  1 Aug 2025 11:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619362459F0;
	Fri,  1 Aug 2025 11:27:35 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72DAF245033;
	Fri,  1 Aug 2025 11:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754047655; cv=none; b=WY3UhIz67JH+kDc5yN9ydMr0W+4jsi2AbGAhM+JuhiJ24krYcwp/LdkKHyaKmTEyKBeOUjkxxyoJeeA7VSzvMu3e/ly+t+2cDBtA5r/WhueAsZIKzYO9F1ga0uBVnOR1mV39eGOoHgcsh8ZrM49p5Gv/+0YnT7EenC2hRCL5WLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754047655; c=relaxed/simple;
	bh=v2mGCF67snTgsVtAEP7MA8n2kzs3pVPt3RUwxeR58ZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EvLwII/vicNRauDR/oaZzVdrztP7XAPsUYNdaJ+DpV0uM5ppJauai2TNbWMEuj60n9hegF8wu/ym0zG0JX0YVrJDAPREbCP0AIVbz5aD3Oc2pU7L+su+ba4V5CBuRfCIIuKshPqsAPzp6Fwz0+pkxicD7h/RyP7WJnaBCAPCdls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 86CF31516;
	Fri,  1 Aug 2025 04:27:24 -0700 (PDT)
Received: from [10.1.27.49] (e127648.arm.com [10.1.27.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E87D53F66E;
	Fri,  1 Aug 2025 04:27:29 -0700 (PDT)
Message-ID: <04333423-56d8-4c4f-a5fe-143b179cdd43@arm.com>
Date: Fri, 1 Aug 2025 12:27:28 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] Documentation: PM: QoS: Fix return type and return
 value description
To: Zhongqiu Han <quic_zhonhan@quicinc.com>, rafael@kernel.org,
 lenb@kernel.org, pavel@kernel.org, tony.luck@intel.com,
 reinette.chatre@intel.com, Dave.Martin@arm.com, james.morse@arm.com,
 ulf.hansson@linaro.org, amit.kucheria@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250721124104.806120-1-quic_zhonhan@quicinc.com>
 <20250721124104.806120-5-quic_zhonhan@quicinc.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20250721124104.806120-5-quic_zhonhan@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/21/25 13:41, Zhongqiu Han wrote:
> The documentation for cpu_latency_qos_request_active() incorrectly stated
> the return type as 'int' instead of 'bool', and the return value
> description was incomplete. This patch corrects the return type and
> clarifies the return value semantics.
> 
> Fixes: b8e6e27c626e ("Documentation: PM: QoS: Update to reflect previous code changes")
> Signed-off-by: Zhongqiu Han <quic_zhonhan@quicinc.com>
> ---
>  Documentation/power/pm_qos_interface.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/power/pm_qos_interface.rst b/Documentation/power/pm_qos_interface.rst
> index 1ede4cafc2e3..c6b8b9cda166 100644
> --- a/Documentation/power/pm_qos_interface.rst
> +++ b/Documentation/power/pm_qos_interface.rst
> @@ -55,9 +55,9 @@ void cpu_latency_qos_remove_request(handle):
>  int cpu_latency_qos_limit():
>    Returns the aggregated value for the CPU latency QoS.
>  
> -int cpu_latency_qos_request_active(handle):
> -  Returns if the request is still active, i.e. it has not been removed from the
> -  CPU latency QoS list.
> +bool cpu_latency_qos_request_active(handle):
> +  Returns true if the request is still active, i.e. it has not been removed from
> +  the CPU latency QoS list.
>  
>  
>  From user space:

I guess this should be swapped in the series with patch 3? (First fix old, then add
new?)
Anyway it applies in and of itself.

Reviewed-by: Christian Loehle <christian.loehle@arm.com>



Return-Path: <linux-pm+bounces-20969-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5999EA1D5DB
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jan 2025 13:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B20483A346F
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jan 2025 12:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B7C1FDE09;
	Mon, 27 Jan 2025 12:17:13 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB68F1E868;
	Mon, 27 Jan 2025 12:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737980233; cv=none; b=UnmfWhGzRiMrFprjmnRQ7aBBKbW20LwbeEWoyx9ZDeHKi5normLYIz4naMRzpsVwMBcY0XN4rUSf/6qY3k89tdV6FC1Is0ArbnQDCawbGkJZ9k8SjtPAq6TbPJhBTaC1oyRxmBQA51NzeH13tJd31IZi7laUl1VhBofof6eUnEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737980233; c=relaxed/simple;
	bh=jXggkm6S75kGUTi1BnvcV4LK3S9FJ/cJMvfzq+Adi0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OCGLEgY9jodLd/A4jkmAWcdDpyVjblfwexmC+mVw7zryNmAyzYCuCIjOH0bqIF+7xH34ksAsZa0WeyLWCeLkrrIGmWcQI95J82NqJk6EG6g8u/RqWsofOEEUj9TDq5zXYU1LNF9epWP6GIIbmsZX15TlN5+AH/xeU+O2O8DLvBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 911D6497;
	Mon, 27 Jan 2025 04:17:37 -0800 (PST)
Received: from [10.57.38.3] (unknown [10.57.38.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1D2B43F694;
	Mon, 27 Jan 2025 04:17:07 -0800 (PST)
Message-ID: <31dd8c5d-0bc4-4d84-9ac9-7ca248e952cf@arm.com>
Date: Mon, 27 Jan 2025 12:16:51 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cpuidle: psci: Add trace for PSCI domain idle
To: Keita Morisaki <keyz@google.com>, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 lpieralisi@kernel.org, sudeep.holla@arm.com, rafael@kernel.org,
 daniel.lezcano@linaro.org, linux-pm@vger.kernel.org
Cc: aarontian@google.com, yimingtseng@google.com
References: <20250118072438.3647805-1-keyz@google.com>
 <20250120013616.1116126-1-keyz@google.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20250120013616.1116126-1-keyz@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/20/25 01:36, Keita Morisaki wrote:
> The trace event cpu_idle provides insufficient information for debugging
> PSCI requests due to lacking access to determined PSCI domain idle
> states. The cpu_idle usually only shows -1, 0, or 1 regardless how many
> idle states the power domain has.
> 
> Add new trace events namely psci_domain_idle_enter and
> psci_domain_idle_exit to trace enter and exit events with a determined
> idle state.
> 
> These new trace events will help developers debug CPUidle issues on ARM
> systems using PSCI by providing more detailed information about the
> requested idle states.
> 
> Signed-off-by: Keita Morisaki <keyz@google.com>
> ---
> v1->v2: Split the ftrace event into two (psci_domain_idle_(enter|exit))
> 		and rephrase the commit message accordingly. Rebased onto the latest.


Which makes it different to cpu_idle event FWIW.

> 
>  drivers/cpuidle/cpuidle-psci.c |  3 +++
>  include/trace/events/power.h   | 37 ++++++++++++++++++++++++++++++++++
>  2 files changed, 40 insertions(+)
> 
> diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
> index 2562dc001fc1..dd8d776d6e39 100644
> --- a/drivers/cpuidle/cpuidle-psci.c
> +++ b/drivers/cpuidle/cpuidle-psci.c
> @@ -25,6 +25,7 @@
>  #include <linux/syscore_ops.h>
> 
>  #include <asm/cpuidle.h>
> +#include <trace/events/power.h>
> 
>  #include "cpuidle-psci.h"
>  #include "dt_idle_states.h"
> @@ -74,7 +75,9 @@ static __cpuidle int __psci_enter_domain_idle_state(struct cpuidle_device *dev,
>  	if (!state)
>  		state = states[idx];
> 
> +	trace_psci_domain_idle_enter(dev->cpu, state, s2idle);
>  	ret = psci_cpu_suspend_enter(state) ? -1 : idx;
> +	trace_psci_domain_idle_exit(dev->cpu, state, s2idle);

Not tracking ret seems odd, is that fine?


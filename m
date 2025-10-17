Return-Path: <linux-pm+bounces-36355-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB1EBE915A
	for <lists+linux-pm@lfdr.de>; Fri, 17 Oct 2025 16:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 636954F7DDB
	for <lists+linux-pm@lfdr.de>; Fri, 17 Oct 2025 14:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41D036CE02;
	Fri, 17 Oct 2025 14:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qbcVHJiu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BJX24J5x"
X-Original-To: linux-pm@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2882836CDF2;
	Fri, 17 Oct 2025 14:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760709717; cv=none; b=PTpC1rttAd1XXgUU6qufKV5Uako8ssL/WdLyritgGcLhn2OrvDv74Ji9UPU1SQ2iVh5V3GfCjzAvNNHfRTwGy4r0HvpQ6Sjj9U0c2Ua/L8SxIcxOZmyixJrqAK53j8HeealQT0bRRcO0i2M8fOnx9FCZv0I/KehN9tF4xx2ggzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760709717; c=relaxed/simple;
	bh=4P1LGmq0vziWalLmGYRUfsRpcJ23CApxc5RLTbPcrH0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dKn45jfcJmOyYDxzEJHqlySu1Gy5GdektbcW2Q5KYNs3LUW9oweb6wItvOkogCJoyP63GTV3BeCzteA1yOa+dYZcaTkoPs+R4lGSKfFclgU0sAGuENKmE4r/tDWo8aHdhZplU1UgMn9vsGLo79Mj7wc4H5Qh5rNWzzT4Kly/oSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qbcVHJiu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BJX24J5x; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760709714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T2Pww/gGQGWQfeDScaRC/ktdjiEbzeAZRvLxrOAHIR0=;
	b=qbcVHJiua0r9iuEli8MmHVmkt+ko+4RQMBgcCB+j+/hu8DkfWsK7hZnRLMgfIp8MoPmgHE
	5POi8jezXKn2v1riWc0Hp3yr+kbGQ/OzkdQNs9DZXaSSYY1fQ94QGi6vgwQLRnGXviAL+z
	iQVj0kwIIbt+7UhFDX2khqBiAK79LCd3T6sy9jiG8q9zE2NRXFzCEUpRKb2qVv0Rv4bRxm
	fOnVLHF65fYgTCDlRo7/v6yfpUYWExaIgkBarDO57ZG+Ef94gh6lV6ITOvIW92Nx9RBwKT
	DibS6Xfz5a4c2iiVufjsiZzFv692PRx2J7MLPAOcsthjt89jWXNuasZunMLlvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760709714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T2Pww/gGQGWQfeDScaRC/ktdjiEbzeAZRvLxrOAHIR0=;
	b=BJX24J5xLMU3A3635JuUMzPUqbCVxBAtaeJMhE2HY+7QCGjy6skYASrZIflpJVMVX90XGi
	sbjLEs/wuxNaMtCQ==
To: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J . Wysocki"
 <rafael@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Maulik Shah <quic_mkshah@quicinc.com>, Sudeep Holla
 <sudeep.holla@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Vincent Guittot <vincent.guittot@linaro.org>, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Ulf
 Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/3] arm64: smp: Implement cpus_has_pending_ipi()
In-Reply-To: <20251003150251.520624-3-ulf.hansson@linaro.org>
References: <20251003150251.520624-1-ulf.hansson@linaro.org>
 <20251003150251.520624-3-ulf.hansson@linaro.org>
Date: Fri, 17 Oct 2025 16:01:53 +0200
Message-ID: <87ms5pzkxa.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Oct 03 2025 at 17:02, Ulf Hansson wrote:
> Note, the implementation is intentionally lightweight and doesn't use
> any

By some definition of lightweight.

>  static void smp_cross_call(const struct cpumask *target, unsigned int ipinr)
>  {
> +	unsigned int cpu;
> +
> +	for_each_cpu(cpu, target)
> +		per_cpu(pending_ipi, cpu) = true;

Iterating over a full cpumask on a big system is not necessarily
considered lightweight. And that comes on top of the loop in
smp_call_function_many_cond() plus the potential loop in
arm64_send_ipi()...

None of this is actually needed. If you want a lightweight racy check
whether there is an IPI en route to a set of CPUs then you can simply do
that in kernel/smp.c:

bool smp_pending_ipis_crystalball(mask)
{
	for_each_cpu(cpu, mask) {
                if (!llist_empty(per_cpu_ptr(&call_single_queue, cpu)))
                	return true;
        }
        return false;
}

No?

Thanks,

        tglx


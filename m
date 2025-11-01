Return-Path: <linux-pm+bounces-37244-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA6CC287AF
	for <lists+linux-pm@lfdr.de>; Sat, 01 Nov 2025 21:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DC2F3AA913
	for <lists+linux-pm@lfdr.de>; Sat,  1 Nov 2025 19:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFBD296BBF;
	Sat,  1 Nov 2025 19:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IsIe3nGj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Xli0ltPi"
X-Original-To: linux-pm@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5BF1F4E59;
	Sat,  1 Nov 2025 19:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762027191; cv=none; b=erLrYC89zH5gGN3yV4M582MOuCg2hsrc0p3Ne+c8Hls/L0aFA3iGKapsu5MAdYs90CDZx2lPSqhBT1eiNFy/KHx2qkr5Aw/RzZyq/akEZje/pJZvN4dJw2UYjkuqJWmoDjM9JKNFC5gL0bdaXzu9Qog4m8LlHz+RzOxZVNuhWn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762027191; c=relaxed/simple;
	bh=3KyFPGTtlAIMq89X0yxIjS4dmMPbYQqV+iBk1qm6MVI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=J6VgHS+vCcC5K1dPyoUyNr0gJjSy0/OsF6ySzBBt86+TJO3vXU/YBbKIEfKVJZ9dVvd0ZWPDSHhPC/n16o3Wbhk4ZlHnCXs7iCawwdcRamGfUXLW/zBP1JX8+/L8NOmgYg04TRWuh7x5PtxXhJpaKAfBMWySE96f5yliuI9SVPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IsIe3nGj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Xli0ltPi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762027189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w9esUrg9Ter9Q/ySJkb9E3El3zRpChNBYljx3GplElA=;
	b=IsIe3nGjD4+mFIPS/cGK5p82zifs7tYWuZwqkL+xHoOK4UukXvx2+bt/aztkvd5zAgMhzj
	9YZZbgjGFUL/zmGeo5e+EDQlmSOY1h2Cp1SgtnoU5ZB8z9m8Nrcrwg/N6VkV8GD9OZFsF1
	PivkGmLsqBa2jbxMfdINE5YQTgCN8+9WD90IfHPVA7So8O/rccyEnCvzfuCvJAb32JeiUb
	e+tmQXmm2KgclYiKYVKTVd9ajmcVBFn4alhX5g1OqspAJNKHO5P18JcR3CVJ/Nij3+7mM8
	0V0yJ22Aw8iIhOsoGktIefD6cXr1df4NczCpwJmESG4e4mTDvQSknA+zd563wg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762027189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w9esUrg9Ter9Q/ySJkb9E3El3zRpChNBYljx3GplElA=;
	b=Xli0ltPigchfb4g6wBaN2i7pjcT0uon5IYxstMvKeKhqRyMbnOQJS7ymbFGPod+iA1DSrm
	JVl+U93Ifd31KHCQ==
To: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J . Wysocki"
 <rafael@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>,
 Maulik Shah <quic_mkshah@quicinc.com>, Sudeep Holla
 <sudeep.holla@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Vincent Guittot <vincent.guittot@linaro.org>, Ben Horgan
 <ben.horgan@arm.com>, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Ulf
 Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 1/2] smp: Introduce a helper function to check for
 pending IPIs
In-Reply-To: <20251031110106.62394-2-ulf.hansson@linaro.org>
References: <20251031110106.62394-1-ulf.hansson@linaro.org>
 <20251031110106.62394-2-ulf.hansson@linaro.org>
Date: Sat, 01 Nov 2025 20:59:48 +0100
Message-ID: <875xbty157.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Oct 31 2025 at 12:00, Ulf Hansson wrote:
> +/**
> + * cpus_peek_for_pending_ipi - Check for pending IPI for CPUs
> + * @mask: The CPU mask for the CPUs to check.
> + *
> + * This function walks through the @mask to check if there are any pending IPIs
> + * scheduled, for any of the CPUs in the @mask.
> + *
> + * It's important for the caller to know that this function does not guarantee
> + * correctness. It provides a snapshot, while being as lightweight as possible.

This read clumsy. Just say:

  * It does not guarantee correctness as it only can provide a racy snapshot.

or something like that.

> + * Returns true if there is a pending IPI scheduled and false otherwise.
> + */
> +bool cpus_peek_for_pending_ipi(const struct cpumask *mask)
> +{
> +	unsigned int cpu;
> +
> +	for_each_cpu(cpu, mask) {
> +		if (!llist_empty(per_cpu_ptr(&call_single_queue, cpu)))
> +			return true;
> +	}
> +
> +        return false;
   ^^^^^^^^
White space damage. Spaces instead of TAB.

Thanks,

        tglx


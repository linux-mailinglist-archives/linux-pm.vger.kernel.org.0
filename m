Return-Path: <linux-pm+bounces-40509-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9A4D06597
	for <lists+linux-pm@lfdr.de>; Thu, 08 Jan 2026 22:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CF46830119AC
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jan 2026 21:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B714A329C49;
	Thu,  8 Jan 2026 21:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eCcPHPXG"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D9E244660;
	Thu,  8 Jan 2026 21:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767908434; cv=none; b=A5VNF9BndhM+nKnZESsNj6dKUozuymG8MyNMnGLDXni2NeR38Jcj4SbwfeVJnE0pWyl5PEtXrtA30qkKcfNwm1XGl8jf9ZQXehqqiSzEPyMGmXerNQiQ5tbVl1SpUpHQdxkN4WpthZR/biW8pV/yi87W2WzFQvbhoPcmXoHOzmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767908434; c=relaxed/simple;
	bh=3HeCr/QP0y7ZNXbG9kCEkB/k1ADvPytDc/n3I5clHXo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oXBovr8f3syOu5rUo9bIsjqgEModcnjD7D7Su6/6thW0YRYbSlyeGPX2akfJPE2XXsAOqd1tomIfH1ePvNgPZGm90eBsJb46a3Kgni5Zhc2pUODqSFOY1fIHcGMTCD0fwnv21sEAN/sp6So1LcTCLXedwnV8BQXi/JC+APYYYxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eCcPHPXG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A20FC19422;
	Thu,  8 Jan 2026 21:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767908434;
	bh=3HeCr/QP0y7ZNXbG9kCEkB/k1ADvPytDc/n3I5clHXo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=eCcPHPXGOGfBtxxNsZ/UJOTveTawk7iUEb7fbUWhvBdt2NESrOpipQ2uHFzokpZHu
	 6c/zP024KkCbuKSWIrO1jwMKVHl6tge1mvzWdlCnVeHFjGFDAKM6c0LKvTSAZtYosO
	 lTixjXHS53AWajV1ylxPvviRbb1rttTSYetQwwMSHvBPCldagoZWft+BgBStdMuU4e
	 ifq3ovaroOnURk9k+wX94gQL7B/X0tG1tBWZytG/HIVtj7Bt6xuRSAS1OVeMMXlsID
	 7fl7FhAS/Q3rpZ1xT++GsADuYY/rc02W4wImwLTUEOGFx3livydRBVHG6nw8a7nzB7
	 eVKs4yRLeTrBA==
From: Thomas Gleixner <tglx@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM
 <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Frederic Weisbecker
 <frederic@kernel.org>, Molnar Ingo <mingo@kernel.org>, Marc Zyngier
 <maz@kernel.org>, Lukas Wunner <lukas@wunner.de>, Sebastian Andrzej
 Siewior <bigeasy@linutronix.de>, Jon Hunter <jonathanh@nvidia.com>, Ulf
 Hansson <ulf.hansson@linaro.org>, Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH v2] genirq/chip: Change irq_chip_pm_put() return type to
 void
In-Reply-To: <5075294.31r3eYUQgx@rafael.j.wysocki>
References: <5075294.31r3eYUQgx@rafael.j.wysocki>
Date: Thu, 08 Jan 2026 22:40:30 +0100
Message-ID: <87secfsrzl.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Jan 08 2026 at 16:05, Rafael J. Wysocki wrote:

> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> The irq_chip_pm_put() return value is only used in __irq_do_set_handler()
> to trigger a WARN_ON() if it is negative, but doing so is not useful
> because irq_chip_pm_put() simply passes the pm_runtime_put() return value
> to its callers.
>
> Returning an error code from pm_runtime_put() merely means that it has
> not queued up a work item to check whether or not the device can be
> suspended and there are many perfectly valid situations in which that
> can happen, like after writing "on" to the devices' runtime PM "control"
> attribute in sysfs for one example.
>
> For this reason, modify irq_chip_pm_put() to discard the pm_runtime_put()
> return value, change its return type to void, and drop the WARN_ON()
> around the irq_chip_pm_put() invocation from __irq_do_set_handler().
> Also update the irq_chip_pm_put() kerneldoc comment to be more accurate.
>
> This will facilitate a planned change of the pm_runtime_put() return
> type to void in the future.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>
> This patch is requisite for converting pm_runtime_put() into a void
> function.
>
> If you decide to pick it up, please let me know.
>
> Otherwise, an ACK or equivalent will be appreciated, but also the lack
> of specific criticism will be eventually regarded as consent.
>
> The v1 is here:
>
> https://lore.kernel.org/linux-pm/4723896.LvFx2qVVIh@rafael.j.wysocki/
>
> v1 -> v2:
>    * Fix a typo in the new part of the irq_chip_pm_put() kerneldoc comment
>      and rephrase it slightly.

Still:

Reviewed-by: Thomas Gleixner <tglx@kernel.org>


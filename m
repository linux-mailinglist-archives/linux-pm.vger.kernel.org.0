Return-Path: <linux-pm+bounces-37965-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6839EC589F1
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 17:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F7D7423351
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 15:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD7135295A;
	Thu, 13 Nov 2025 15:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tU5vr2gc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AgzJqop0"
X-Original-To: linux-pm@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EEA227BA4;
	Thu, 13 Nov 2025 15:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763047775; cv=none; b=YYhULBsJrFkrGTdz/wHGyioJhZUDJ+BLwb1ab4EIx7e8LvQPtckJ8CUYkKvK6da9U9CtvsH4GJk6PRc7n+3nHSXQ7aXs1OFsu+xh6Q1Kl9MlN6YiFgR0gTeW5uvR+DqWAFTRgvx5KbYHu6weYQoVyKI+jBKI+abOkKzP/Z11pYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763047775; c=relaxed/simple;
	bh=smA20V17ZF1F2xtWy4wiqSmfxMuxp7FSVoSwrSRVQDk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ahIgIykb7iRnn0KNcsaGQOYFKEafXui2mdxqv5JkhlhRq4KM+8tvdnVBfo3wk0ta5zLdrdTDq2tiKXXWl6YrBwEWPerMC7mhU4Tu7NYHQzMHv246CwhoZCFKaJmgRXOaRXOgwWyR+zIVtSTegvtZHSgGUOLZvNlxJKRctEeD1ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tU5vr2gc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AgzJqop0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763047772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=smA20V17ZF1F2xtWy4wiqSmfxMuxp7FSVoSwrSRVQDk=;
	b=tU5vr2gcdFphwGWO7V259GwnrVBX/crtdTVtsc+FjI8oON/IEYNrN6Ln4FAGYRcRD1zVgg
	R8qdalzr9RSC2pQgiikrx2CNb0lC9FO+2/NIuNbQ/7Wjw/nuFnfTSAvlMGmQN7r0/MAp+Y
	cqGEeBcwAZru5Z84TXVp+Tb1oxVEW+fCl5fh7yR9lhbmkM3Nz4n+7pEBpaxOTN425wywkc
	D4Bx9bqyVHVVdM4dZ1vFg1T/S/YTB/RnH6iT6NMidvHfin10NDQcGCKvZ9gFqQHzptaheT
	s7FycTHvXEy8BSjBi1BElvV3mOJNUTR8TZxKqiXUeP5s2kPWwT9epIcb7lWkYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763047772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=smA20V17ZF1F2xtWy4wiqSmfxMuxp7FSVoSwrSRVQDk=;
	b=AgzJqop0o/OwWkx+w2MpwQXjEapM8ajgNebEaWYm11Cl121wviNTVCHimYjbW01CWDsA1m
	shYmfzxisZxCmeAw==
To: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J . Wysocki"
 <rafael@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>,
 Maulik Shah <quic_mkshah@quicinc.com>, Sudeep Holla
 <sudeep.holla@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Vincent Guittot <vincent.guittot@linaro.org>, Ben Horgan
 <ben.horgan@arm.com>, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Ulf
 Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v4 1/2] smp: Introduce a helper function to check for
 pending IPIs
In-Reply-To: <20251105095415.17269-2-ulf.hansson@linaro.org>
References: <20251105095415.17269-1-ulf.hansson@linaro.org>
 <20251105095415.17269-2-ulf.hansson@linaro.org>
Date: Thu, 13 Nov 2025 16:29:31 +0100
Message-ID: <874iqyc5no.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Nov 05 2025 at 10:54, Ulf Hansson wrote:
> When governors used during cpuidle try to find the most optimal idle state
> for a CPU or a group of CPUs, they are known to quite often fail. One
> reason for this is, that they are not taking into account whether there has
> been an IPI scheduled for any of the CPUs that are affected by the selected
> idle state.
>
> To enable pending IPIs to be taken into account for cpuidle decisions,
> introduce a new helper function, cpus_peek_for_pending_ipi().
>
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>


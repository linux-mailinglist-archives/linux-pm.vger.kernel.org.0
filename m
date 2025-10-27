Return-Path: <linux-pm+bounces-36924-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 48BC8C0F9BA
	for <lists+linux-pm@lfdr.de>; Mon, 27 Oct 2025 18:21:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ED9DE4EA419
	for <lists+linux-pm@lfdr.de>; Mon, 27 Oct 2025 17:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C222301474;
	Mon, 27 Oct 2025 17:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y14ZqlD0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="A42MOUxI"
X-Original-To: linux-pm@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995D322D7A5;
	Mon, 27 Oct 2025 17:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761585619; cv=none; b=I3Gyv41nQsNPgAF1z7CPWaMV47XQzT52MOwxhWOugFsDVbGKeqB57JjH0m8wkGCcsrrRNTIZPCXqSZfGV5LfJ4v9Ubh5azGADpFGM37QT7c4PC4/r9P4vdPmv5G/p3tjfXE2/M4mTEBex5WQ+APJYj73hybrGBqLbokTTQjT0Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761585619; c=relaxed/simple;
	bh=8hHDJnAKQ7TkGYVWTB6uVUYjf8D1v5bl3mhnVF4y4sw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UygcL/+FCL98X47fFNJ8kc5UuRlcRSuQOvgaQREo8DoHGQ23jEE3kG/DazRdIx+UfvDnUChr1I1NNoXspBRtEm9QjrXpMXY2R6bOl8f81wxPNh09bPxFeLj6SXm6JA7rqNGCOQQdXVlR6ixSeI4O4fbRJ8Ple3NJ1M2B8eM+cU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y14ZqlD0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=A42MOUxI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761585616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EL18DRmiuTWLATBe5Gs34HIgGkwAeVge3RkC2LhpsLg=;
	b=Y14ZqlD0EkXH4iXjM70FdXLZ+iOmw30C2f7uSB34GLPzWVrHPR6OXTNqwiVcy3+bZNKHkp
	6K1KOrw6cVb9UR7MqjEoTKh821zZ8z3a+Pf5p2aA2Axnet/8ZauSCNdRYDrIlU4dJquAFd
	jKh+n99niLkinU17cVLbaOaySoruhIk8BMB89Pi5toNhruNW+EQiH1SVEZOrH354Y+Yt06
	Viaw77hlRVAUvWKxKWJR+fynvTuYcuWFp9dNX4qtnWL1NQ0jwc+gwO+NZeRRKmA9lk5f6/
	CLJS3BiWWLqaZmxUXQuZJvOkCI5iXQEhY2/B/fd6MmpzAlE4oYYVI+jxxZrMsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761585616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EL18DRmiuTWLATBe5Gs34HIgGkwAeVge3RkC2LhpsLg=;
	b=A42MOUxIaJbK5VTM2nYXH7xNrbkEdlYKRkj/alxqESRm5Jg4OCECUkjGTLfYR5G4C0rGLJ
	SoYRkgVexCygZbBQ==
To: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J . Wysocki"
 <rafael@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>,
 Maulik Shah <quic_mkshah@quicinc.com>, Sudeep Holla
 <sudeep.holla@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Vincent Guittot <vincent.guittot@linaro.org>, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Ulf
 Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 1/2] smp: Introduce a helper function to check for
 pending IPIs
In-Reply-To: <20251020141718.150919-2-ulf.hansson@linaro.org>
References: <20251020141718.150919-1-ulf.hansson@linaro.org>
 <20251020141718.150919-2-ulf.hansson@linaro.org>
Date: Mon, 27 Oct 2025 18:20:15 +0100
Message-ID: <871pmow9bk.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Oct 20 2025 at 16:17, Ulf Hansson wrote:

> When governors used during cpuidle, tries to find the most optimal

When governors used during cpuidle trie to ...

Both plural and no comma.

> idlestate for a CPU or a group of CPUs, they are known to quite often fail.

idle state

> One reason for this, is that we are not taking into account whether there

...for this is, that they are not taking into account

> has been an IPI scheduled for any of the CPUs that are affected by the
> selected idlestate.
>
> To enable pending IPIs to be taken into account for cpuidle decisions,
> let's introduce a new helper function, cpus_may_have_pending_ipi().

s/let's//

> Note that, the implementation is intentionally as lightweight as possible,
> in favor of always providing the correct information.

That sentence doesn't make sense. It's a snapshot and therefore can't
provide the correct information.

>  For cpuidle decisions this is good enough.

Thanks,

        tglx


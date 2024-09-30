Return-Path: <linux-pm+bounces-14938-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF6E989FF6
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2024 12:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72F111F23D49
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2024 10:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A246418DF7D;
	Mon, 30 Sep 2024 10:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="loygBOXQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pVWqIRqK"
X-Original-To: linux-pm@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E84B18DF73;
	Mon, 30 Sep 2024 10:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727693787; cv=none; b=sr+/DPNa8r9oZgrm4a2f1QgXJPeVj2ZaoQCvAFO0YsyBMhhuvvvgwaGRUc3J8lsP50WQY0Fko4h7n+YXXuoOLefa7CmbR/jJOOb4a6fL08weVdU0zw48PXUJjwbFY1qg2GXjQek0xzy3LMy9xZss3iKFRW/VG5a7wxzcZZozHQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727693787; c=relaxed/simple;
	bh=UXbnqyjIHj/j3HmUbVN/ompEw6/Fd2B1YIMpdNNfKBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SU+0KWOIVz+S2BT6DIyXqy38oVwbkOes1rtT1oVWUoQuKvwlY1ORxjRNG0OhuN/yF57nNbImGrD9hGaVVeMdLU7WPT46jDeMcr9ZJcKuqwowuT74ANbXgksjJaWMpT/vMEMV98FSr5ewKpTS1XQJmLsd+deiyZ+1Hye09Y6Qut8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=loygBOXQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pVWqIRqK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 30 Sep 2024 12:56:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727693778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UXbnqyjIHj/j3HmUbVN/ompEw6/Fd2B1YIMpdNNfKBM=;
	b=loygBOXQO3uZ1hW8kOCbn2FDgxMER6CAyKPIrUWCyEVoqT4OF7oJuqajGBMtSN/7mGNTmp
	t1mA9s24hkj8LSe19qynFs4Y/HKcAI+GnIdXDZGaU6d8VFo2iCknHjSE1VbxNpmztpjYp2
	Ng82e+fWCFUFLRXB15UHOot9KaVpwYB0MN4o78UMlNZI+/KGr82PY0dihdPQ7S6W1NBqsP
	2zwLQkSVHpJHJqX40kYAMSqPCIzFrc7Jo3m4d1bPJBKA+SxD4nlAkNmqS8KZCAxEyfrfa+
	DJ56r7Ib/KJHkzJCkrbhPHVYA1SkI/9B41Yrn5mlLIVqo4/ou7nMFbZF4guUYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727693778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UXbnqyjIHj/j3HmUbVN/ompEw6/Fd2B1YIMpdNNfKBM=;
	b=pVWqIRqK5z4NPUZ7wscmVMS2soEQdGjYHMuOBEwqlHMzcJV0tkaalWsJE8iZz6zFBx2qlq
	m1kNENkDCotysjCA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@debian.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Len Brown <lenb@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, linux-pm@vger.kernel.org,
	x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
	linux-rt-users@vger.kernel.org, xiao sheng wen <atzlinux@sina.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Make hwp_notify_lock a raw
 spinlock
Message-ID: <20240930105616._7EmK9OS@linutronix.de>
References: <20240919081121.10784-2-ukleinek@debian.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240919081121.10784-2-ukleinek@debian.org>

On 2024-09-19 10:11:21 [+0200], Uwe Kleine-K=C3=B6nig wrote:
> notify_hwp_interrupt() is called via sysvec_thermal() ->
> smp_thermal_vector() -> intel_thermal_interrupt() in hard irq context.
> For this reason it must not use a simple spin_lock that sleeps with
> PREEMPT_RT enabled. So convert it to a raw spinlock.
>=20
> Reported-by: xiao sheng wen <atzlinux@sina.com>
> Link: https://bugs.debian.org/1076483
> Signed-off-by: Uwe Kleine-K=C3=B6nig <ukleinek@debian.org>
> ---
> Hello,
>=20
> this is deep in x86 land where I have *very* little experience and
> knowledge. Is sysvec_thermal() (defined in arch/x86/kernel/irq.c) really
> running in hard irq context? The stacktrace in the Debian bug report
> suggests that.
>=20
> So please double check my reasoning before applying this patch.

Yes, these things are not threaded. Ideally you should have proper
thermal setup so that you don't get any interrupts in regard to this and
start throttling. Once that interrupt fires and starts throttling then
your worst-case latency increases due to the interrupt and lower CPU
frequency.
Delaying the thermal interrupt to a thread might not be wise.

Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

> Thanks
> Uwe

Sebastian


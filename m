Return-Path: <linux-pm+bounces-10773-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7111F92A41C
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2024 15:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A22DA1C21AAD
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2024 13:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28A313AD07;
	Mon,  8 Jul 2024 13:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="idMvzb3t";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M13IblR0"
X-Original-To: linux-pm@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BE813A3FF;
	Mon,  8 Jul 2024 13:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720446795; cv=none; b=fmMNrWuKzB4vJOMK585U37yM9IvO0qeAF+Lw7uixp+wSRI/zsPL497PzSI0CvQ7oKvOdcEcy7qF/PoMzPbrsjJDEZVVxeMJZrrLuoOJAJGDbEbxhgrYhwwSZCEQbH92H0i96h8IS4okFbfOugsqVYaMEvkbdgjjjx0+swuk8tQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720446795; c=relaxed/simple;
	bh=/r+/nMzPahn0eESG2XANrb9OH0ViDm6C4ibSsbg1d6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gTZtxyQ6G5Gcx4prFln0oq10IyqUNQw0olsZ+xeEr0TeW8ueJ7X28BDfVCgRmIZTuCh9pnRsS2/RSVSvrSgnfANssctlv0+Ccq4eXYd102TnJPAVjQogcYbFjalYVInz0i+QkZCyfledlWSWLngXz7fneiOxGFMxXcJqIZgDz8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=idMvzb3t; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=M13IblR0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 8 Jul 2024 15:53:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720446791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3Msuqgjwb5He6YYwNRjzMabQUnm6Wy6XzGH5sueeY8Q=;
	b=idMvzb3tG0e27yENCyIPgOaUlpXrpKSEMlndewY3UuHO9wv93LN1IkvziRk/3yQGls+NSs
	IalS3y3r6+317icTSIpFhdcDtnpjEMoeVn4MrcNenLwPq0xMQhlaF92atj+HV95lSLhMRu
	8hIrHYBEth7PpA2EDYnnATFUeE4Cwqri2yRvD/GQycfnzzgSPM2aNAFP2qhQPirChEe5Dj
	KZ3MrpHQA+Pj+Xlw6cCKd+JERxP7jDPP+yZyibwjKG7sNs+5RInafnnd3g2wh4HPNoNbUc
	ekA2jXzXG70NIuheP5ot0ZzGxhRG2YDYa91GdfMrFXrFk3+bnk6i9tBhUCv1Cw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720446791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3Msuqgjwb5He6YYwNRjzMabQUnm6Wy6XzGH5sueeY8Q=;
	b=M13IblR0AfHP6xSVuJw+Ty5KFZaCF8douxAxyPoEdDQhvo1kTOoyk5738csvtak+08cDmb
	TwDqqBYx9O73bEAg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org,
	Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
	Nikunj Kela <nkela@quicinc.com>,
	Prasad Sodagudi <psodagud@quicinc.com>,
	Maulik Shah <quic_mkshah@quicinc.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-rt-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] pmdomain/cpuidle-psci: Support s2idle/s2ram on
 PREEMPT_RT
Message-ID: <20240708135310.3VRFnmk1@linutronix.de>
References: <20240527142557.321610-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240527142557.321610-1-ulf.hansson@linaro.org>

On 2024-05-27 16:25:50 [+0200], Ulf Hansson wrote:
> Updates in v2:
> 	- Rebased and fixed a small issue in genpd, see patch3.
> 	- Re-tested on v6.9-rt5 (PREEMPT_RT enabled)
> 	- Re-tested on v6.10-rc1 (for regressions, PREEMPT_RT disabled)
> 
> The hierarchical PM domain topology and the corresponding domain-idle-states
> are currently disabled on a PREEMPT_RT based configuration. The main reason is
> because spinlocks are turned into sleepable locks on PREEMPT_RT, which means
> genpd and runtime PM can't be use in the atomic idle-path when
> selecting/entering an idle-state.
> 
> For s2idle/s2ram this is an unnecessary limitation that this series intends to
> address. Note that, the support for cpuhotplug is left to future improvements.
> More information about this are available in the commit messages.

I looked at it and it seems limited to pmdomain/core.c, also I don't
know if there is a ->set_performance_state callback set since the one I
checked have mutex_t locking ;)
So if this is needed, then be it. s2ram wouldn't be used in "production"
but in "safe state" so I wouldn't worry too much about latency spikes.
Not sure what it means for the other modes.
I am not to worried for now, please don't let spread more than needed ;)

> Kind regards
> Ulf Hansson

Sebastian


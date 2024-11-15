Return-Path: <linux-pm+bounces-17645-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A41289CF361
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2024 18:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 554BFB2D3E1
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2024 17:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615C41D63D1;
	Fri, 15 Nov 2024 17:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TtoQcWPj"
X-Original-To: linux-pm@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8721D618E;
	Fri, 15 Nov 2024 17:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731692429; cv=none; b=MyD0OJFs6g/ZdWouhWhvt4Jwp0G3SlrtXXBL5BPAecYdVf1l379x5gbMoHOo9g0hZ+MsJpc8Qf0J+ZO17qXY+8SaKjotguwOR2t5e9u9VyeYlLnH4iL2Q+VpbccMPMzlszdXQ2AwmVMi7Cp8BoAuOFXkNjk60Mgbk7sQOnAB+6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731692429; c=relaxed/simple;
	bh=jyGslCeJMEijYiyK/PiuOjC3tz2yhl7wgmdDQ0Z8Sqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pi5KjoCQD5ZuK+TXsKhTAcSaH7nsthiUMTh0YGoVxUkmIn1TIXcCxOvkhh8xPZS4QkM4iYMWZUo8sL3AKrLMAC6oTSt6dxL7WWTAYU4VjPWA3P6Y3y9SzcuEXDV5wF35TtKF76FsUI6smxHMm0kNIJBB+TKkhYNKUq70Shu5ts0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TtoQcWPj; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CiYwYKsf5w5oGguPyRwzQ8MrK9UWm5u9QpL29PprmTc=; b=TtoQcWPjDsX6nCVOcNSAzn9e8q
	Uym0Clk6j0cjRjXN6yHba3kuxJwtpMTfPjixy9bXN3aBy/KIaxOlH7rVfZZGg3bhUK3KZD5Iwe5pG
	BTF9K4oswl6X7TMrpOMLTiiKaVwefAdGKKc4azUaFZKrqSdogXssQ8LHSlRuwnrm7H8bF9tvK4gCq
	gDW9dLEuIYcvPkiXluO/BPfySLXHD/swKhengxky3gSBb+K0WLObkxAhh2KLdGsW5CjBxvmh1ilrP
	6W+ZrcrNjJzIq/ijuSnJQLOgiEkU50sjv0Ixi+cqfahHH638PxosSu8TKZ5ocBUtDtwQs2dDB77LD
	zVpglhRg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tC0Iw-00000000J5a-39d0;
	Fri, 15 Nov 2024 17:40:23 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5AEFE30066A; Fri, 15 Nov 2024 18:40:22 +0100 (CET)
Date: Fri, 15 Nov 2024 18:40:22 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	x86 Maintainers <x86@kernel.org>,
	Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v1] cpuidle: Do not return from cpuidle_play_dead() on
 callback failures
Message-ID: <20241115174022.GF22801@noisy.programming.kicks-ass.net>
References: <4992010.31r3eYUQgx@rjwysocki.net>
 <20241115101427.GA22801@noisy.programming.kicks-ass.net>
 <CAJZ5v0gfSpzjD1PDhMOmqV_wcnCtr=m12noAqVpQkDsjetu+Ug@mail.gmail.com>
 <20241115125523.GD22801@noisy.programming.kicks-ass.net>
 <CAJZ5v0jkPb-sgrMfk+KN19+R+ezucssHKUzfJZ74Qw1Ned6gaw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jkPb-sgrMfk+KN19+R+ezucssHKUzfJZ74Qw1Ned6gaw@mail.gmail.com>

On Fri, Nov 15, 2024 at 02:25:23PM +0100, Rafael J. Wysocki wrote:
> > I mean, something like:
> >
> >         if (drv->states[i].enter_dead && !drv->states[i].enter_dead(dev, i))
> >                 panic("Dead CPU walking...");
> >
> > is 'fun' but not very useful.
> 
> The panic would be hard to debug if it ever triggers I'm afraid and
> there is the fallback to HLT in the caller.

I was being facetious, removing the return value and simply calling them
all in reverse order is fine.


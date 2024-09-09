Return-Path: <linux-pm+bounces-13887-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 631E5971AF5
	for <lists+linux-pm@lfdr.de>; Mon,  9 Sep 2024 15:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F11CCB2176E
	for <lists+linux-pm@lfdr.de>; Mon,  9 Sep 2024 13:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54FEC1B86FC;
	Mon,  9 Sep 2024 13:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Zi3ofuYo"
X-Original-To: linux-pm@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67561B86ED;
	Mon,  9 Sep 2024 13:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725888318; cv=none; b=f6PHk2O2XJyUHkj8MRFbVLHtvUrpSh9d28HCrnC/FV/aSbLEB9dXzvtZ2zCUnnP9+L2tND2fsXkB9dpG5M4p0i5rdnXGO3tlNmz4HETVFgaklDFdaq1YI0QB3bLnCkbeLn5yKsHwe9BW8+z2KoM7gGNofyJWsgfh9BfFs4ZutpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725888318; c=relaxed/simple;
	bh=w4EUsA3zjwOkUyE9Sip7sE2MjxX3WoP8w54hS7lFxFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dMaIRWaG3IsInY6ZF4X117KWCYec0wdNOP0fdYqrn/k1qeIE1/XbijNIELDA6kbPzYB75zXWmFxjJs5GJ/0ekZUOlO62QvpcaSxOp17+g7z/bV5vZYF2a3tOOgpZ79d9zB9/4pyjjZLxZtvZaNlkP9nrNU4u5P0HSpI7Mj7/Fys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Zi3ofuYo; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pI2Kedx4lZ1N+9UYmbUHkMiC1K7UmrQ4uCItrtNGI88=; b=Zi3ofuYoPPVRoPplMdymAS9TN3
	CXPlCtqRjY8RNl3f2TirNLPJMXm2qWIUovgBp1KfOsjmsRGm7Ns9OWY7uWf5g7/FZBpT+DVhxEBPR
	cM0qQuzYZN/T+lUiYFqVFrgsDSGZzdTI/p3hfgt6mmAzIBBMTwJNL+/HxSLNfxAFJ5bMPY5wMtL1W
	ztp0uo45kG3vSPXFhEVUyZtiFfSEKJfDNAf35osHhwRL7uizugzEXMAIxfw4gAE7n8dB2LPlh7LoD
	geTxSXG9NCRTm3lOHHBu4Q2dfQ9Zb1Nfka7dYBdOWeDcIPM2GN+zBJMFYHZfJHylLjg0YmZjxuhZX
	zvu6VyRA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1sneOD-00000000RLp-2Vew;
	Mon, 09 Sep 2024 13:25:09 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C774430047C; Mon,  9 Sep 2024 15:25:08 +0200 (CEST)
Date: Mon, 9 Sep 2024 15:25:08 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, vincent.guittot@linaro.org,
	qyousef@layalina.io, daniel.lezcano@linaro.org, rostedt@goodmis.org,
	dietmar.eggemann@arm.com, Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH 0/4] sched/deadline: nanoseconds clarifications
Message-ID: <20240909132508.GD4723@noisy.programming.kicks-ass.net>
References: <20240813144348.1180344-1-christian.loehle@arm.com>
 <ZruDkw2XB8iXMepz@jlelli-thinkpadt14gen4.remote.csb>
 <1f5f7643-8743-40f4-80ac-0534affd70cd@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f5f7643-8743-40f4-80ac-0534affd70cd@arm.com>

On Mon, Sep 09, 2024 at 02:01:38PM +0100, Christian Loehle wrote:
> On 8/13/24 17:02, Juri Lelli wrote:
> > Hi,
> > 
> > On 13/08/24 15:43, Christian Loehle wrote:
> >> A couple of clarifications about the time units for the deadline
> >> parameters uncovered in the discussion around
> >> https://lore.kernel.org/lkml/3c726cf5-0c94-4cc6-aff0-a453d840d452@arm.com/
> >>
> >> While at it I changed the documentation example to chrt instead
> >> of the schedtool fork.
> >>
> >> No functional changes.
> > 
> > Looks good to me!
> > 
> > At least for docs/uapi,
> > 
> > Acked-by: Juri Lelli <juri.lelli@redhat.com>
> 
> (gentle ping)
> Peter, do you want to take {1,2} and Rafael {3,4}?

I'll queue the lot if that is okay with Rafael.


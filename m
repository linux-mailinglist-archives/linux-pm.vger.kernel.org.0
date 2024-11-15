Return-Path: <linux-pm+bounces-17588-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A929CD4FE
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2024 02:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D22428277E
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2024 01:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646384F8A0;
	Fri, 15 Nov 2024 01:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ChBh6qgu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TSCTKgXP"
X-Original-To: linux-pm@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456241E522;
	Fri, 15 Nov 2024 01:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731633670; cv=none; b=aZ7KPRZ/jbjwsXqdInv4zQqfiKiKXJz+D42bS5MN/wR2dMB5D2KVTyMMz+TRFUh/AYNqAdDwzt3Y70TeNNr7CrNam5dP3rFlPJVFcu1+tVPR/QmtLSG4xt9j09A/O5gFlCI29eDdh62czzq3mVG/A7u/ACBfLQj2CeujVTykqfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731633670; c=relaxed/simple;
	bh=HLp2K0qSNQTF0zw4d2mGUxpmk9h83u/VFvEYDYSXtcs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ft6G3bfkb/sMLILzaGMq5N371fnrLfGOqwVkE1Bie2WNZ+87qu5LGNRYLmon5b4lXl2FsyWyHPeNbktjzkHW5C6jmpiazLC3VYrN50C1DW5ELPt6H56WbRD4nTxF6EY4A3KuzFX4kEtA2ZjBuYK7RX4jfSnak/cuTNnHI96D6RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ChBh6qgu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TSCTKgXP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731633665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vh6/h6C3V7m6yhXVw4h4ri51ZQJecNTwZjudLkasxj0=;
	b=ChBh6qguzawH2vKd0SipNNQEA6u+3lqDfgebn5q+xfXqdy2mhYKba1JVn/G0vwGA9vNx8P
	WnfcCpRdH13dbo+hnvW2qYtdyU87mDlOj2nnVQioFUdGxcqwO3CmKLYvA0HpPu/wyqsZ2k
	KDviVplKZvEMDvpow3cpIRKOtWv6M0ldEOhK+rclGPYT6TWCIcLMgWgoHD/B+DSPv3vPNG
	vLZiqFMe7DD1a8VtAtroMVC98uyK1JLf++2PyXKqKnPkMIRxZIUrzsbAgCSRs9oo8iQ6h4
	uhRuaGLUCNkwtboTeejAE2VHzGUzOlHX7tSv8UFngt3qpnfppcevRu0jam6bMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731633665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vh6/h6C3V7m6yhXVw4h4ri51ZQJecNTwZjudLkasxj0=;
	b=TSCTKgXPaqRRhZzDqj62uSEgydNBeAyWWCi+PPZ9OyEjb+wrBQdhuN5cQFFdvX+jV370Su
	ThQyelbbnOKHTuCw==
To: Peter Zijlstra <peterz@infradead.org>, Artem Bityutskiy
 <artem.bityutskiy@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Patryk Wlazlyn
 <patryk.wlazlyn@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 rafael.j.wysocki@intel.com, len.brown@intel.com,
 dave.hansen@linux.intel.com
Subject: Re: [PATCH v3 2/3] x86/smp native_play_dead: Prefer
 cpuidle_play_dead() over mwait_play_dead()
In-Reply-To: <20241114120315.GG38972@noisy.programming.kicks-ass.net>
References: <20241108122909.763663-1-patryk.wlazlyn@linux.intel.com>
 <20241108122909.763663-3-patryk.wlazlyn@linux.intel.com>
 <20241112114743.GQ22801@noisy.programming.kicks-ass.net>
 <CAJZ5v0ivAk1xrcJgiJnDWnL3GdijSdsuV4K_4ORjnsjPUVAEnA@mail.gmail.com>
 <20241112121843.GF6497@noisy.programming.kicks-ass.net>
 <0ecea0e5be59e63b7827f4db368f2aa3322fb71d.camel@linux.intel.com>
 <20241112140127.GH6497@noisy.programming.kicks-ass.net>
 <20241114120315.GG38972@noisy.programming.kicks-ass.net>
Date: Fri, 15 Nov 2024 02:21:19 +0100
Message-ID: <871pzd1ecw.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Nov 14 2024 at 13:03, Peter Zijlstra wrote:
> On Tue, Nov 12, 2024 at 03:01:27PM +0100, Peter Zijlstra wrote:
>
>> No, not mwait hint. We need an instruction that:
>> 
>>  - goes to deepest C state
>>  - drops into WAIT-for-Start-IPI (SIPI)
>> 
>> Notably, it should not wake from:
>> 
>>  - random memory writes
>>  - NMI, MCE, SMI and other such non-maskable thingies
>>  - anything else -- the memory pointed to by RIP might no longer exist
>> 
>> Lets call the instruction: DEAD.
>
> So, turns out that when you send INIT to an AP it does the whole drop
> into Wait-for-SIPI and ignore non-maskable crap.
>
> The reason we don't do that is because INIT to CPU0 (BP) is somewhat
> fatal, but since Thomas killed all that CPU0 hotplug crap, I think we
> can actually go do that.

Instead of playing dead or to kick out CPUs from whatever dead play
routine they are in?

playimg dead is to stay because INIT will bring back the MCE broadcast
problem, which we try to avoid by bringing SMT siblings up just to shut
them down again by playing dead.

You need a MCE broadcast free system and/or some sensible BIOS bringup
code for that to work...

Thanks,

        tglx






Return-Path: <linux-pm+bounces-17636-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 080BF9CF077
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2024 16:44:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A27F11F23793
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2024 15:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5B11E2611;
	Fri, 15 Nov 2024 15:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rUqFnNaR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="h5M+Vos+"
X-Original-To: linux-pm@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588161D54D1;
	Fri, 15 Nov 2024 15:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731685039; cv=none; b=aav7+dc04JgLt/Srab7Y1hy079jGxvt3qPRbvnApDUMtlDtGZT6aCYdPBMfu+9J3AoP81p95d8Fd3ivqsRYdpBaunJN61ynvdKruWllMhNK5GsLeYsAmCovEMMbSz17uM+X3KyYMvZaOe43XdLuJLZHijYLhUz7aPO3wwE9O7eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731685039; c=relaxed/simple;
	bh=cXVCtUbGzIkTTN/XwtMSYoetWzTGDbhh2EMBZ2OCA+4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RQr82F0k9ut92afCWekAyvRj5uBkqR3vFVK61c/QqkPQziqWE7BRWtX2EWVIclrAv1LFp+Ike9+220kxtV+VSPxDo8EMhISWzmLnq3W+H+LlVyjBYbcZORg9+M7a28NsTcO9qqs4b6fIL22ZLiTNv3/VMPA6dRypiQqR3ZJ4SCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rUqFnNaR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=h5M+Vos+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731685036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TZmbPLii/137z/6quztj4vH5r9RCU/WYr4Ns5mxJ32Y=;
	b=rUqFnNaRwAZBvK8DtimLbd8eSt66jTJ/R1aTD0dXMx0Cyjuc7WvEVPbGh6UgYeKgLrwYOz
	mWVAx5oBdDdWtpVsNZjCK9PGfmPXWABpY3vtapSmaXNYzHRt7bF2qLA0B8b4wteeYPGzpz
	cDEcapHB7SN9dhiZXPhodlbutpre5sgHc6BXJqniKIEQ+12WVYIXeC6NInUjIoV6PbqSm2
	hsl0uvhQfbxCwkRVSe/5B3qSUkStnter2viUskl6ZK4FlZs45YfcIoyjRwEGiD1A1PVx9E
	h8sZZRXR+3eJipHmGidhmUHAIipGgFCvBkelSoDo39ROpuzb/Vo98oVLyAHn1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731685036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TZmbPLii/137z/6quztj4vH5r9RCU/WYr4Ns5mxJ32Y=;
	b=h5M+Vos+tPGG0k+sH/lGYoWH3Fwxz2HWZTX3f5uBFr8MX4zey7Df1CMUXoE6LXeelvF86b
	d6rXb06p4IpGw0Cg==
To: Peter Zijlstra <peterz@infradead.org>
Cc: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 rafael.j.wysocki@intel.com, len.brown@intel.com,
 dave.hansen@linux.intel.com
Subject: Re: [PATCH v3 2/3] x86/smp native_play_dead: Prefer
 cpuidle_play_dead() over mwait_play_dead()
In-Reply-To: <20241115100718.GY22801@noisy.programming.kicks-ass.net>
References: <20241108122909.763663-1-patryk.wlazlyn@linux.intel.com>
 <20241108122909.763663-3-patryk.wlazlyn@linux.intel.com>
 <20241112114743.GQ22801@noisy.programming.kicks-ass.net>
 <CAJZ5v0ivAk1xrcJgiJnDWnL3GdijSdsuV4K_4ORjnsjPUVAEnA@mail.gmail.com>
 <20241112121843.GF6497@noisy.programming.kicks-ass.net>
 <0ecea0e5be59e63b7827f4db368f2aa3322fb71d.camel@linux.intel.com>
 <20241112140127.GH6497@noisy.programming.kicks-ass.net>
 <20241114120315.GG38972@noisy.programming.kicks-ass.net>
 <871pzd1ecw.ffs@tglx>
 <20241115100718.GY22801@noisy.programming.kicks-ass.net>
Date: Fri, 15 Nov 2024 16:37:28 +0100
Message-ID: <87v7wozex3.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Nov 15 2024 at 11:07, Peter Zijlstra wrote:
> On Fri, Nov 15, 2024 at 02:21:19AM +0100, Thomas Gleixner wrote:
>> On Thu, Nov 14 2024 at 13:03, Peter Zijlstra wrote:
>> > On Tue, Nov 12, 2024 at 03:01:27PM +0100, Peter Zijlstra wrote:
>> >
>> >> No, not mwait hint. We need an instruction that:
>> >> 
>> >>  - goes to deepest C state
>> >>  - drops into WAIT-for-Start-IPI (SIPI)
>> >> 
>> >> Notably, it should not wake from:
>> >> 
>> >>  - random memory writes
>> >>  - NMI, MCE, SMI and other such non-maskable thingies
>> >>  - anything else -- the memory pointed to by RIP might no longer exist
>> >> 
>> >> Lets call the instruction: DEAD.
>> >
>> > So, turns out that when you send INIT to an AP it does the whole drop
>> > into Wait-for-SIPI and ignore non-maskable crap.
>> >
>> > The reason we don't do that is because INIT to CPU0 (BP) is somewhat
>> > fatal, but since Thomas killed all that CPU0 hotplug crap, I think we
>> > can actually go do that.
>> 
>> Instead of playing dead or to kick out CPUs from whatever dead play
>> routine they are in?
>> 
>> playimg dead is to stay because INIT will bring back the MCE broadcast
>> problem, which we try to avoid by bringing SMT siblings up just to shut
>> them down again by playing dead.
>> 
>> You need a MCE broadcast free system and/or some sensible BIOS bringup
>> code for that to work...
>
> Isn't INIT a better state to be in during kexec than HLT?

For the kexec transition I agree that INIT is better. We just need to be
careful for a crash kexec when the crashing CPU is not CPU0...

Thanks,

        tglx


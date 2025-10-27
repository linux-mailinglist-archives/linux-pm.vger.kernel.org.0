Return-Path: <linux-pm+bounces-36923-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C1ADCC0F965
	for <lists+linux-pm@lfdr.de>; Mon, 27 Oct 2025 18:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 520574F3BC4
	for <lists+linux-pm@lfdr.de>; Mon, 27 Oct 2025 17:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B4A3164BB;
	Mon, 27 Oct 2025 17:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S+1joJJK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RCyckc7o"
X-Original-To: linux-pm@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A51E3168EB;
	Mon, 27 Oct 2025 17:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761585309; cv=none; b=MEvReKAhrauUG44mf7eYdxc7ca3etg28kvnpG8Vx8hMZc6kguHCJ5++LkIh/SEx5tmRsvqGEJ13HPzKdjWakjLXDlsJKXQvNCwmoyb4w0h84jFpZcB+nJkRx//94sz29s6TAeSUqL5nDOSxLb9Hz9KCEoCEFPwv1cMWB98Nhzro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761585309; c=relaxed/simple;
	bh=bbg2yU5WDCd/y1piJqwaFFX8rwD+L6pzaMgcKs8Sy9E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=umVeAjtc4lQSx2SfsOtLIioTmOnxb3p6DDmVe0AHfs2qqr6VPf41DJwKqbJVhzygS4wYtxWGMCTglYP5OAJ93OWoxyxmP3lw4R0InWBBcpfk2XY4POJaOFz6EwNvD9Q5FZnljx6RPNIWO8BNH1dSExffeuzQVyvJFds+oeSVtM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S+1joJJK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RCyckc7o; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761585306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a0Kmg0M/pihg+3mchefRKJW/8qhO0EXT2ncDeCzUrSc=;
	b=S+1joJJKL5HOP2QI7bePmaQsErjZHts/8tAjGua3A3++P+uxwhzP6Fx+CgA+saMowyM/Un
	qF1s+8Z1CTSJc278sFPw14sZSSoNPm71h0PyF/0QKybtsp+jpWQPmjC4zruRYx0vkSIFvy
	UWhtf5ww4Zpghxxms4sRdmPlCamm85FHT9I1E+9CpPa2boPNMt2j3JjdgppUSlh1Sn1bNR
	FmzEyEDDyPeq7kQKP/vw2ziBPXIDOqE3QlkAYQCKJeOmJf5nSl66AotEtUGLuhrOdu3wzs
	JDiizpLx+fpfP8M8doVAcRU9Vj/rT8NqbqjYG4J6tCYaCDxF4BmEUlPc/ZDVMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761585306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a0Kmg0M/pihg+3mchefRKJW/8qhO0EXT2ncDeCzUrSc=;
	b=RCyckc7oww7LF/Ey96p7Gohn/JMg7811PjAJquXTWtNmny2y8jawDxqgoepfeTcokWQ1pv
	GYPaiP3kZRgFcxBg==
To: Ulf Hansson <ulf.hansson@linaro.org>, Ben Horgan <ben.horgan@arm.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>, Maulik Shah
 <quic_mkshah@quicinc.com>, Sudeep Holla <sudeep.holla@arm.com>, Daniel
 Lezcano <daniel.lezcano@linaro.org>, Vincent Guittot
 <vincent.guittot@linaro.org>, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] smp: Introduce a helper function to check for
 pending IPIs
In-Reply-To: <CAPDyKFrY5kOsoOH-mcWFiaiggV4q84xOtiKHdNN4bMfFmYOQPQ@mail.gmail.com>
References: <20251020141718.150919-1-ulf.hansson@linaro.org>
 <20251020141718.150919-2-ulf.hansson@linaro.org>
 <a0120876-0f00-4e1a-aa17-5fe7c3512276@arm.com>
 <CAPDyKFrY5kOsoOH-mcWFiaiggV4q84xOtiKHdNN4bMfFmYOQPQ@mail.gmail.com>
Date: Mon, 27 Oct 2025 18:15:04 +0100
Message-ID: <874irkw9k7.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Oct 21 2025 at 12:08, Ulf Hansson wrote:

> On Mon, 20 Oct 2025 at 21:11, Ben Horgan <ben.horgan@arm.com> wrote:
>>
>> Hi Ulf,
>>
>> Only a comment on the naming rather than a full review.
>>
>> On 10/20/25 15:17, Ulf Hansson wrote:
>> > When governors used during cpuidle, tries to find the most optimal
>> > idlestate for a CPU or a group of CPUs, they are known to quite often fail.
>> > One reason for this, is that we are not taking into account whether there
>> > has been an IPI scheduled for any of the CPUs that are affected by the
>> > selected idlestate.
>> >
>> > To enable pending IPIs to be taken into account for cpuidle decisions,
>> > let's introduce a new helper function, cpus_may_have_pending_ipi().
>>
>> To me, "may" indicates permission, i.e. is allowed, rather than
>> correctness. Would "likely" be better here, cpus_likely_have_pending_ipi()?
>
> Sure, that sounds better to me too.

cpus_peek_for_pending_ipis() perhaps?
  


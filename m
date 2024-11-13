Return-Path: <linux-pm+bounces-17464-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C86E79C6689
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2024 02:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A1411F23A56
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2024 01:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F4104C147;
	Wed, 13 Nov 2024 01:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iPy7vTdW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oNI+wqa5"
X-Original-To: linux-pm@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B733FC7;
	Wed, 13 Nov 2024 01:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731460750; cv=none; b=JFQol7GtlMQxYWsEh3D2w/zqDepiApyCT4aCDtvKFYQu8IeiQuKVLM8G30kUIAPhCtSBPnciuw2MSj3r3fWXjbjTP+qiUhTWJn373/TkCimEKXEGvu2Kvhduv5EQszhuMn8YY5KA/vI5Vjha0lMd3dzL3gb2lhCK0vkrTCNQ3Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731460750; c=relaxed/simple;
	bh=5jgvmFj4+WU0LqMXqVA51d5UFzRMhS4VeoeO5IqLpRg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nQTDzFw0TTi2g6kHxLASRHl9wrgwK2bEtrSSeR221blcWFZFF2nZG7GE9d+hW0a9/+XU2EooaHCwl0tT1/tmkWK+v2hla4TLyeoWTtgqnFtP7fR+FOoWA93/1GK8ljEwDVWvWO/9Y6EL5xHzz5BGI7/2fYg5uWlrfPQ74kfpe+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iPy7vTdW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oNI+wqa5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731460747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=btianQLvN8jNgt2DHG+WnJggCcxBvEOk7Ma+4QGLo08=;
	b=iPy7vTdWGf8CTp8qtb4qqu9f+GKbtdCP3N88Qu8MctPZyabYsKec8odqXdkl6a7MwCR61u
	4k4ZigBwIKlKig3V0AYbzuq274OgtwGwJpFU8dDbZ/39Y+lv3dRFpRUhmlAf2nw3e0h3mA
	H1c3tczrn+oCNXuJhCZJmkl8hUri0cwPFUEvDm2VSOCOQFWbwxdT4IGPwiCfTL1+ca9LVB
	qAffCJfyf+FDujaaXar9GWnY3FckxxvHZumZIPeSaVXdF3EwDW/Wj6sP/j1C63E/sooMm5
	CyVqssRIjxwkbUasfsDkXAYz3QVQoDVThYj1h6Nq0OwFLJBLlO6uVYw3eHUf0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731460747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=btianQLvN8jNgt2DHG+WnJggCcxBvEOk7Ma+4QGLo08=;
	b=oNI+wqa5C9LOjCVQInMLxF4EDPWXinX4LnsF5UikJcb/iPd1oZdRaaCdnct615oSr9widT
	9VXE1wOQiWzpGPCg==
To: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>, Peter Zijlstra
 <peterz@infradead.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 rafael.j.wysocki@intel.com, len.brown@intel.com,
 artem.bityutskiy@linux.intel.com, dave.hansen@linux.intel.com
Subject: Re: [PATCH v3 0/3] SRF: Fix offline CPU preventing pc6 entry
In-Reply-To: <1ee47890-7f19-4c21-9d0d-94834d716159@linux.intel.com>
References: <20241108122909.763663-1-patryk.wlazlyn@linux.intel.com>
 <20241112114543.GP22801@noisy.programming.kicks-ass.net>
 <1ee47890-7f19-4c21-9d0d-94834d716159@linux.intel.com>
Date: Wed, 13 Nov 2024 02:19:20 +0100
Message-ID: <87o72klylj.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12 2024 at 16:43, Patryk Wlazlyn wrote:
>> There's a comment there that explains why this is done. If you don't
>> understand this, then please don't touch this code.
>
> /*
> =C2=A0* Kexec is about to happen. Don't go back into mwait() as
> =C2=A0* the kexec kernel might overwrite text and data including
> =C2=A0* page tables and stack. So mwait() would resume when the
> =C2=A0* monitor cache line is written to and then the CPU goes
> =C2=A0* south due to overwritten text, page tables and stack.
> =C2=A0*
> =C2=A0* Note: This does _NOT_ protect against a stray MCE, NMI,
> =C2=A0* SMI. They will resume execution at the instruction
> =C2=A0* following the HLT instruction and run into the problem
> =C2=A0* which this is trying to prevent.
> =C2=A0*/
>
> If you are referring to this comment above, I do understand the need to
> enter hlt loop before the kexec happens. I thought that I could bring
> all of the offlined CPUs back online, effectively getting them out of
> the mwait loop.

That's not really working:

  1) Regular kexec offlines them again.

  2) Kexec in panic can't do any of that.

Thanks

        tglx


Return-Path: <linux-pm+bounces-34107-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7F3B47B83
	for <lists+linux-pm@lfdr.de>; Sun,  7 Sep 2025 15:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED70D3A3EF7
	for <lists+linux-pm@lfdr.de>; Sun,  7 Sep 2025 13:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2A626FD91;
	Sun,  7 Sep 2025 13:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="koSKU14o";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GdxH4Lxi"
X-Original-To: linux-pm@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7E72749C8;
	Sun,  7 Sep 2025 13:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757250897; cv=none; b=YsxqD1cKkDBO78xveoXKoMdFd9sN0q2ZL3wK8nD/EHpQibSTZHPhyTjBYzKpJQVdenVEKbk5VWfAQUBi4n4PcjY/CupkafIKQOeBpfe328DalZukspFVPPzcmpKoGEI44UhV1mhedNbZs12+daO10jQ/aD2tqop/XphEOln/UqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757250897; c=relaxed/simple;
	bh=sEUag7aRj6ST5TGK3QaxIAu92HzwQtaOFeMELjsKBog=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bBYhxYqj4MgQtjqql2hWNrL25f2ts68wyOKTLGlWkrSQo3IXxXT3Zj5ofvMqp+mL0Qv3j7TVbK7OYqBPcIAANALeIZBZ4ZGbOudLz5WLLSET7m3JI54EhlNJfgOPZjxv6pMDacKgagzUtsnsvnYpqclbEaTGl60XdwerhJsQlcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=koSKU14o; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GdxH4Lxi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757250889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6CO/cXUOzCVMCPtjJWHU5xKcbYixzjkhyw8cUlQxkao=;
	b=koSKU14o3apGYInp0diYD8yvPheGXBjRasP27dDUWkKqcC5tQ7P0xK8CXJ7/1a8J2oCRgI
	1UBFu09wU4i/QfWFYy0p6zELNEI2wdvFtNPuOpt0YgNN25wx6sJtMh2RUXLSmUgHJMlaRb
	EwvmU6EZ3I7u4nJOAVIj2ilz2srMRQagbR2jxuHMqy3QxIeoNpPEWk+9BWdPC/466etERN
	a+dyGn80wZ4Bn0wlmVkc4uWE871PFjp7zfLi/9M/cYnLtAH05SCelG23bhLu1bfn4vZkYZ
	H+J3UKpyP+MYzMPMI9sT8yXmr5NbXq6TiUlTDKSmghcU1GyvNSbvFFTAkUpRLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757250889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6CO/cXUOzCVMCPtjJWHU5xKcbYixzjkhyw8cUlQxkao=;
	b=GdxH4LxiCNBlJKHAjY1NenIZEAKng3rAnXnPfBu2KZ+vab6+r/yoCk8VgyEyd+IF8EfN/z
	LB+Xyw7I8XGy4LAA==
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, LKML
 <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, Christian Loehle
 <christian.loehle@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v1] cpu: Add missing check to cpuhp_smt_enable()
In-Reply-To: <CAJZ5v0htmEeivbQaumRc7zw_Zx68GpUy98ksA9L42LupjO6tWA@mail.gmail.com>
References: <12740505.O9o76ZdvQC@rafael.j.wysocki> <871polxs9c.ffs@tglx>
 <CAJZ5v0jyN0=aGFOwE8fzuXi=1LgiLR5wgvvsAihGB0qpUp=mUQ@mail.gmail.com>
 <CAJZ5v0gsiuK5iFY6cHaqEgP8R1sz_pWGoqac2orYvXqLE2xbDQ@mail.gmail.com>
 <87o6rowrsp.ffs@tglx>
 <CAJZ5v0htmEeivbQaumRc7zw_Zx68GpUy98ksA9L42LupjO6tWA@mail.gmail.com>
Date: Sun, 07 Sep 2025 15:14:47 +0200
Message-ID: <87ldmqwgjc.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 05 2025 at 22:56, Rafael J. Wysocki wrote:
> On Fri, Sep 5, 2025 at 10:47=E2=80=AFPM Thomas Gleixner <tglx@linutronix.=
de> wrote:
>>
>> On Fri, Sep 05 2025 at 15:27, Rafael J. Wysocki wrote:
>> > On Fri, Sep 5, 2025 at 3:13=E2=80=AFPM Rafael J. Wysocki <rafael@kerne=
l.org> wrote:
>> >> Well, manual online can be used for onlining the secondary thread of a
>> >> core where the primary thread is offline, so this is technically
>> >> possible already.
>> >>
>> >> > Something like the completely untested below.
>> >>
>> >> So given the above, shouldn't topology_is_core_online() check if any
>> >> thread in the given core is online?
>> >
>> > Besides, this would cause the siblings of offline SMT threads to be
>> > skipped while enabling SMT via sysfs (using
>> > /sys/devices/system/cpu/smt/control), but I'm not sure if this is the
>> > expectation in the field today.  The current behavior is to online all
>> > secondary SMT threads (and more, but that part is quite arguably
>> > broken).
>>
>> It is broken, because the initial logic is to bring up primary threads
>> unconditionally and then refuse to bring up sibling threads.
>>
>> With "maxcpus=3Dxxx" this obviously limits the amount of primary threads,
>> so there is arguably no point to online any of the related secondary
>> threads of them.
>>
>> The initial implementation was naively making that assumption, but the
>> core check which was added due to PPC made this actually correct.
>>
>> It just did not snap with me back then, but it's actually the correct
>> thing to do, no?
>
> It would at least be consistent with the existing PPC behavior. :-)

Correct.


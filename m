Return-Path: <linux-pm+bounces-34028-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52638B464E6
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 22:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AB85170BFF
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 20:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD58427E7FC;
	Fri,  5 Sep 2025 20:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FH9dZHMH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gQy/fsRJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88C519343B;
	Fri,  5 Sep 2025 20:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757105227; cv=none; b=tWY/5HrR6/tJQ/uJSixOAqE+C+Hjzbgx9qBxoOprExx5Tho2nuan9vjJP89KkS2m+Chetd3Ti3ytkTltLN8CeJM+gD2BwDNmYIKUl9ux08A44i77VugrL7IaNPdguKQBm0Krj5ujJqRm4Y+4ksoQBrQeaZDyMrNsii8zkTPpzZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757105227; c=relaxed/simple;
	bh=wASYGkaSd1wlnitI6FNlQQGveT2OYeCpEpug8qcSSHI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OV5R4eQKAkcoHYObR4cGXZtq0fBU+Hv1NTDL4UEiAGQ43vORQZ9dVXWSeyn0L1RxdO+UKmMpTYmvs3CzWcaPDFRGwOhD8UkccZ72dHcMIzwWVUTWyWTwhIqJFCUGifC72PVOXhXGjoK5Wlwrlq3Ssc0TacfjUdp8AciS3IBk594=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FH9dZHMH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gQy/fsRJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757105223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SmGnGw5M+kYAIB275/yyymufOFHi5A+rvTjbZgSEz/A=;
	b=FH9dZHMH1SqbXLeK9CY0iyXgXdpL2xvcO98XonJeybbf+K7h7lZP5NqSztcPgov62V0KNI
	lPrI2YAcW7WlQqnQ3SPohXkeYs40gS6BibsuoBR92m5LFJvM2EeaXwIE7dErnxgsi07Lck
	fuFN7ZiwmVJd/q7l2GMHD8+3CTv7WkhzChc/LdVG3WZSntX4fWg0Zt4kwdKZ4P2DQeTE5f
	wMbNbeNHMaQGvk5Fsu6OW341IeOEJGc3bzbINHjMgsBUd4LPCn5KnQHD4elUTlmoGydUvU
	phDwp8+EWku/SNvQe6ULC9xPqC6EvTepkwQhRSz33CWH8qU7lMGvodNg/87G7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757105223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SmGnGw5M+kYAIB275/yyymufOFHi5A+rvTjbZgSEz/A=;
	b=gQy/fsRJg04ijqGKDZxHc5OYe86G8Q76IpJ73AQNIHlGqpA+PrEZVNekVGT3SCoiOsFz7q
	Ea7m7uHw1VIxhsCg==
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM
 <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Christian Loehle <christian.loehle@arm.com>, Dave Hansen
 <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v1] cpu: Add missing check to cpuhp_smt_enable()
In-Reply-To: <CAJZ5v0gsiuK5iFY6cHaqEgP8R1sz_pWGoqac2orYvXqLE2xbDQ@mail.gmail.com>
References: <12740505.O9o76ZdvQC@rafael.j.wysocki> <871polxs9c.ffs@tglx>
 <CAJZ5v0jyN0=aGFOwE8fzuXi=1LgiLR5wgvvsAihGB0qpUp=mUQ@mail.gmail.com>
 <CAJZ5v0gsiuK5iFY6cHaqEgP8R1sz_pWGoqac2orYvXqLE2xbDQ@mail.gmail.com>
Date: Fri, 05 Sep 2025 22:47:02 +0200
Message-ID: <87o6rowrsp.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 05 2025 at 15:27, Rafael J. Wysocki wrote:
> On Fri, Sep 5, 2025 at 3:13=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.o=
rg> wrote:
>> Well, manual online can be used for onlining the secondary thread of a
>> core where the primary thread is offline, so this is technically
>> possible already.
>>
>> > Something like the completely untested below.
>>
>> So given the above, shouldn't topology_is_core_online() check if any
>> thread in the given core is online?
>
> Besides, this would cause the siblings of offline SMT threads to be
> skipped while enabling SMT via sysfs (using
> /sys/devices/system/cpu/smt/control), but I'm not sure if this is the
> expectation in the field today.  The current behavior is to online all
> secondary SMT threads (and more, but that part is quite arguably
> broken).

It is broken, because the initial logic is to bring up primary threads
unconditionally and then refuse to bring up sibling threads.

With "maxcpus=3Dxxx" this obviously limits the amount of primary threads,
so there is arguably no point to online any of the related secondary
threads of them.

The initial implementation was naively making that assumption, but the
core check which was added due to PPC made this actually correct.

It just did not snap with me back then, but it's actually the correct
thing to do, no?

Thanks,

        tglx





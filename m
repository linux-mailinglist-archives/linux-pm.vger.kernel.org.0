Return-Path: <linux-pm+bounces-17454-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF0D9C612D
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 20:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 434EE1F25522
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 19:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633F8218937;
	Tue, 12 Nov 2024 19:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FXI6k32c";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JU2998mm"
X-Original-To: linux-pm@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5AC21832A;
	Tue, 12 Nov 2024 19:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731439105; cv=none; b=Q8j5l7cPCpfQ2oL6xeOludjECZInJj/YbMeD+P4782MNEhiUr6G4M28nWydYNVCgO6iQ7UhhJAuHUWIFoL09cBHY0qTV8tPiK+vjf4I7FhRlDW+sC8WAhDMMBVWG50+oSX08NOMBKghmgMmXMhKNn4FRKINMbCujzkFPH4vD5QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731439105; c=relaxed/simple;
	bh=SmY1KzS3axMfMj/tXPwRqqwfIuiyQTcCq1Ie7N/f44g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=U9kwkGe/e79vrSKb9QtFrfHq10g979RbrMDvB19WCh2q6P76rUYAVM3rZBwn1hkMMDf+kMehRDaXtESFs5MGH5reqmprSQRkhLR4xPXI0KrazRixKQgpDMej7e0UD7YSK0lYwlHWRvnq/KoFYTXiV1pCjZz4ZRLurnMDEC8Luk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FXI6k32c; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JU2998mm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731439098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X6X/c5pG+riV4PsRlWNGgbAkYRH6+PQq4M8cy3QLMUU=;
	b=FXI6k32cEURH3FCDwZjEYalBH8Bf7VOicFp3XQkgvitdYM3blLK4sMw68n0x9xC3W5IyyG
	y8ktr1ZvC4QKOE+WSAYE0NNkZ1I9qvDDReaACBzmN28PW6MlUnz+IuxD/miyyAi7OT92cB
	eS6xRLZ0OsbpMPrtUnRtl0wVpjq56bwyW13jXj4QhLXOIRc0h/hB38wYIhY9VH6Tl6DOJB
	60O8dcQY8TzxVQI+UGf5MBb1J9c8E7s5bBszcEr/Bsp0A21zpcpnYO/+71bLojUnsfZDNj
	lCRXvjrnVUOIJEWF0PKyy07zGPLkbBbGgv3s5dj3Q7WDxDJazGfDxtfT5U5mhw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731439098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X6X/c5pG+riV4PsRlWNGgbAkYRH6+PQq4M8cy3QLMUU=;
	b=JU2998mm8QClY90vCpYupNEfxx88WcCi8+8byKxG5hqdOUrCZ47Xv3Vxh9pvCZp/La/UA7
	8rS6CGvBsjc9ccCQ==
To: "Rafael J. Wysocki" <rafael@kernel.org>, Patryk Wlazlyn
 <patryk.wlazlyn@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 rafael.j.wysocki@intel.com, len.brown@intel.com,
 artem.bityutskiy@linux.intel.com, dave.hansen@linux.intel.com
Subject: Re: [PATCH v3 3/3] intel_idle: Provide enter_dead() handler for SRF
In-Reply-To: <CAJZ5v0gmg_6OnzR6BNm+3Mx0Wzsf2nPQEZDutYu_-Px-TsvX-w@mail.gmail.com>
References: <20241108122909.763663-1-patryk.wlazlyn@linux.intel.com>
 <20241108122909.763663-4-patryk.wlazlyn@linux.intel.com>
 <b6ab357c-1562-4035-ad3a-2159d2c8c1fa@intel.com>
 <ee9b0a70-6f44-4203-bba9-c07d94444ad6@linux.intel.com>
 <CAJZ5v0gmg_6OnzR6BNm+3Mx0Wzsf2nPQEZDutYu_-Px-TsvX-w@mail.gmail.com>
Date: Tue, 12 Nov 2024 20:17:54 +0100
Message-ID: <87serwmfbx.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12 2024 at 12:28, Rafael J. Wysocki wrote:
> On Tue, Nov 12, 2024 at 12:18=E2=80=AFPM Patryk Wlazlyn
> <patryk.wlazlyn@linux.intel.com> wrote:
>> I don't think so. The old algorithm gives fairly good heuristic for comp=
uting
>> the mwait hint for the deepest cstate. Even though it's not guaranteed t=
o work,
>> it does work on most of the platforms that don't early return. I think w=
e should
>> leave it, but prefer idle_driver.
>
> IOW, as a fallback mechanism, it is as good as it gets.
>
> As the primary source of information though, not quite.

So we have at least 5 places in the kernel which evaluate CPUID leaf 0x5
in different ways.

Can we please have _ONE_ function which evaluates the leaf correctly
once and provides the required information for all places ready to use?

Thanks,

        tglx


Return-Path: <linux-pm+bounces-34951-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 851E8B83854
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 10:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 520F22A498B
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 08:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A492F067F;
	Thu, 18 Sep 2025 08:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lu4vPTDS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="frcmEIKN"
X-Original-To: linux-pm@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8472ED17A;
	Thu, 18 Sep 2025 08:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758184271; cv=none; b=CFzsejgdr+7BphX3T54KfWb35rVpND/rTaTpp9IwylyRSXaOgXfO6nOvn8PNioRYKGaayZbPsK4a+n84xeuYLDQnwXTWvdVKgo7afK7xZJUXzALGX5PTtfoK8os62Vp38wiuG3VjcN49/A2sb+9OR94CmeS5LroGIn/6PBnD3Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758184271; c=relaxed/simple;
	bh=G4M2r631pn7Zt96E0MYNERhodv6pTD5S3MULZ7MUpBQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=e8R8FzH0Kz/4orFqGwBGTI477KICTx+aJdT8PXYmBZpJnIlYpcZDj4SsVxUZ/H7FbLrx3dvO8TvAKA6DOi5/xwjoCFGPBLOgZfm5Fb6KZxRtmiLCD9Kbm3JLjOVc5wM9etpMtWXgS2BnERUTdyWeQfhWaOI8BTjldKgqD5dafts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lu4vPTDS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=frcmEIKN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758184267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G4M2r631pn7Zt96E0MYNERhodv6pTD5S3MULZ7MUpBQ=;
	b=lu4vPTDSDrmy1XdWHB/sLy0SqaZOEv6ADAZtGJcbBWuiqi3NXackrLMUa4tY70nStxmHQA
	f8GocqMXu9uQQHpWm8RQ1MnUjy/yB223tXLGwSPWpLvbe+bG77ut89Sa2dbqm0Dj7zPl5/
	KjSY9Fztu2dN7qEPPiKmjZy3/KrXHpbUyd3eyNcVyw9wRuHqEU4HlAPWLzlLeex2tPABhn
	/F/KzbMjHWTYSpb+FXU43HSdfmRwjlFJyi0g4EOQ424a8idA/64/at4BA99lxMRWdQ50hM
	8h3x/NRaUtu5mekRqCYs/6m7W1bp7plPQv5hefziiscO21wnV9LRIbeKIZeXYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758184267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G4M2r631pn7Zt96E0MYNERhodv6pTD5S3MULZ7MUpBQ=;
	b=frcmEIKN8MoYfH2Xt5r/GzN/HG2lhTn34uPmygvDmSBBiNytSkGd5EZuf12+Z2VFeRcl2h
	Nbh+prw79Xw3v1AQ==
To: "Rafael J. Wysocki" <rafael@kernel.org>, LKML
 <linux-kernel@vger.kernel.org>
Cc: Randy Dunlap <rdunlap@infradead.org>, Linux PM
 <linux-pm@vger.kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v1] smp: Fix up and expand the smp_call_function_many()
 kerneldoc
In-Reply-To: <CAJZ5v0gEh-xoKdgAgUvnGzPV6AO51=ZagHXNCrC4BfRZk6Oydw@mail.gmail.com>
References: <6191405.lOV4Wx5bFT@rafael.j.wysocki>
 <CAJZ5v0gEh-xoKdgAgUvnGzPV6AO51=ZagHXNCrC4BfRZk6Oydw@mail.gmail.com>
Date: Thu, 18 Sep 2025 10:31:06 +0200
Message-ID: <87h5x088mt.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16 2025 at 16:13, Rafael J. Wysocki wrote:

> On Tue, Sep 9, 2025 at 1:44=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.o=
rg> wrote:
>>
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> The smp_call_function_many() kerneldoc comment got out of sync with the
>> function definition (bool parameter "wait" is incorrectly described as a
>> bitmask in it), so fix it up by copying the "wait" description from the
>> smp_call_function() kerneldoc and add information regarding the handling
>> of the local CPU to it.
>>
>> Fixes: 49b3bd213a9f ("smp: Fix all kernel-doc warnings")
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> It's been a week and no feedback.
>
> Well, in the further absence of any, I'll assume no concerns and just
> queue this up.

Sorry, was distracted. No objections from my side. Did you queue it
already?



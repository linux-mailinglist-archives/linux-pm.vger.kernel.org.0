Return-Path: <linux-pm+bounces-22918-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70296A44B6B
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 20:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F1DA4203C5
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 19:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276E61DC99C;
	Tue, 25 Feb 2025 19:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N9yxvrIY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1GdtkJ4E"
X-Original-To: linux-pm@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA5D21ABC6;
	Tue, 25 Feb 2025 19:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740512148; cv=none; b=aowc2V6KkRu1zybgRPSIeEFvWaiaF4vy8AEyI0OLZvwU+NnzUT/qQ6e6WIFNavOlE+F9UqXvLjfiRbg34fXISVUVb1bnVBWN5/mNk61jp3LUFoQuQr8hsjCi6JQdg6vm+A0hRpWXJQK/uFjBuGKht8NF1QoLfVzY0csCPJu9eKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740512148; c=relaxed/simple;
	bh=KsEFBJDMyMqE1GNzZ8NLeV+1MIUPSoldSittfrDl8pg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=s6Q3Y/NqByrA22Hue6EJItHClcd2X2XetTTPEUyy2pbcjag2JF4Uo41x2wZ5NhRezOxH7wr6LcdYjZcxHJ5wpky02BKuqymzr4IHZvexjLZSOgSVY1PUDovPc1z/dcLwDvCVb2dd+gHKe7sPyra50Ikh870gW0zdgn8WtNLETYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N9yxvrIY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1GdtkJ4E; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740512144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qDTiPxWy1P2Fx4DmRfxnMT0ntSR96+IUL871wEEDv7U=;
	b=N9yxvrIYPb1ldIap8iYrtbc3q7iYny02QmR+rGlDXYFjd+CbwCz8yoCi345xGZxvJccxy8
	joB/j5nyUZ0WJVbArA8SmfxYmN+rnNbgF7UOua2Yv56YbPF8DnnjKCL86N6QxB+ajpzL3I
	rrmyQQQv7ddcaUo9b66vBNcx+1/9qJj83UBlMyRruv6XOeM1Zg4vymnoBW9m4Q2QhjJZti
	xuS2z1Th8enwmcb5Tn4tunBSoZdkkQLRoYFCHbTvoyY+dcFeaMB2ipQ73fB8vEjjOwihzJ
	Wzdutp+wtDZJKzmbI6F++/Ppt2kzX/Mgtk8fQO7NBpcxH1T7ePJG48X1wI0IoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740512144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qDTiPxWy1P2Fx4DmRfxnMT0ntSR96+IUL871wEEDv7U=;
	b=1GdtkJ4EKnOcyKDySyhF2tEw5pENFkFHj6qA2Kc/NhsCfczyFbFIUlhCIRwuTogLz5cwpt
	gu7Lr1W81gtJjRAQ==
To: Fab Stz <fabstz-it@yahoo.fr>, John Stultz <jstultz@google.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Jacob Pan
 <jacob.jun.pan@linux.intel.com>, Len Brown <lenb@kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>
Subject: Re: [REGRESSION] ? system is stuck in clocksource, >60s delay at
 boot time without tsc=unstable
In-Reply-To: <5114de6a-e6ef-4459-9570-6dd2245fabd5@yahoo.fr>
References: <10cf96aa-1276-4bd4-8966-c890377030c3.ref@yahoo.fr>
 <10cf96aa-1276-4bd4-8966-c890377030c3@yahoo.fr>
 <22539099.EfDdHjke4D@debian>
 <CANDhNCqdpbi=r81NyXVWBbB5POj5nmrc7qo3r2bi1yYqYBgiAg@mail.gmail.com>
 <CANDhNCqFi1adk_MdejQC1bod5STHPDjaSB9imSGpRtJt3TbW1Q@mail.gmail.com>
 <c1d1b79c-bb2e-4a69-888d-a3301bcbfeb2@yahoo.fr>
 <CANDhNCreiCQUKccmW1wBtvVzQrfB=xC0GFRO65SHG-+Wfu1wtA@mail.gmail.com>
 <b9b58a9e-eb56-4acd-b854-0b5ccb8e6759@yahoo.fr> <87plkoau8w.ffs@tglx>
 <15f4f44d-6f73-4031-a7dc-d2105672bc81@yahoo.fr> <874j0jhiag.ffs@tglx>
 <5114de6a-e6ef-4459-9570-6dd2245fabd5@yahoo.fr>
Date: Tue, 25 Feb 2025 20:35:43 +0100
Message-ID: <87eczlg6ls.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Feb 25 2025 at 09:11, Fab Stz wrote:
> Thank you for the patch! I built the 6.1 kernel with it applied and it 
> apparently works as expected (no delay). Please find logs below & 
> attached dmesg log. Maybe the interesting line is:
>
> Feb 25 08:53:51 debian kernel: tsc: Marking TSC unstable due to TSC 
> halts in idle

Correct. That's the missing piece.

> Will the patch also enter the longterm releases like 6.1?

Let me write a proper change log with a Fixes tag and cc stable, so it
will be automatically picked up.

Thanks,

        tglx


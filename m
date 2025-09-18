Return-Path: <linux-pm+bounces-34997-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0E2B86DFA
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 22:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E6E95825CA
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 20:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23092D7DEC;
	Thu, 18 Sep 2025 20:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Zv3FZA0T";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GZt8R2jZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3233A8248B;
	Thu, 18 Sep 2025 20:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758226647; cv=none; b=tvJW9Y/MVSXCdS6OZeVRwnxxLamuA6kzWALcnsFh7DQF11b5eXqO1N6VKMQ3RGRokgUUBmFUoy90S4MBC475mGNOpqDO30Vmj7CJwfcqDwCDbMWGOoRT0a31tkCjEF0vQIUTYIFHU9dz9cd2pXN+QnzX0aZaQC74qjSXiXruWP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758226647; c=relaxed/simple;
	bh=WuGHsnFI9eaeja/HU/Mvew+i+MRTn5XKGNImCCQx85M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XFjr375uovsErBhGwHrzuIpLEjBqf/E/B3M1odszRrYJrqHTsI0403tU5T7DciwOAUt4Wrw0Ebrukoggz6uwqWO65YnfM8WhuQiLThS0/vOPvTiybl/rAqsVaYE4GfX3H3j10RJQOgIpIRX/nAoUyrQEQCoK6HsFeOLpGytJ3Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Zv3FZA0T; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GZt8R2jZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758226644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WuGHsnFI9eaeja/HU/Mvew+i+MRTn5XKGNImCCQx85M=;
	b=Zv3FZA0TLz+ouSaXKI1QsG0Xs/Akt1S/CuflT47iBsYPloxG5VFs5PUSj1PubucYMXYtFb
	rALroA09gMyMoaxlMLKy+xNbvCNJTOJB+J8ofoX4OOTxTrjYVy5woO5QMSIJjdiJXLvsQ8
	tfCP9Zext4k1GgIXF7lQG18Ci0PcrxQ2eJ10M5dGE24RUjka37fee9EA57yRfOcC1m6D23
	nIb+T5/1iBnAeeK8vyZGV2Ffts1JQOGtobTsgri3ZfuqT0OnN4csQJGwLsxQ3xX6JEk1N4
	/lQBilaWqJ+8Wes7TsKjh+wrQdE7moHnBgNJ+Q27ESD4CMtPwBAALLzOdLs0Hw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758226644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WuGHsnFI9eaeja/HU/Mvew+i+MRTn5XKGNImCCQx85M=;
	b=GZt8R2jZNdqqfDTjq8fQqS7QOz2uGnQ6jFMBKxx9EG0BNs9V376HouuZ+3jPMQBh+UjgEb
	+jUa1294/+ODK5Cg==
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, LKML
 <linux-kernel@vger.kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
 Linux PM <linux-pm@vger.kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v1] smp: Fix up and expand the smp_call_function_many()
 kerneldoc
In-Reply-To: <CAJZ5v0h1DgQ2xWSEXjbiwAUES4DMKL8S+B5+ed9muWTwsfeNsA@mail.gmail.com>
References: <6191405.lOV4Wx5bFT@rafael.j.wysocki>
 <CAJZ5v0gEh-xoKdgAgUvnGzPV6AO51=ZagHXNCrC4BfRZk6Oydw@mail.gmail.com>
 <87h5x088mt.ffs@tglx>
 <CAJZ5v0h1DgQ2xWSEXjbiwAUES4DMKL8S+B5+ed9muWTwsfeNsA@mail.gmail.com>
Date: Thu, 18 Sep 2025 22:17:22 +0200
Message-ID: <87ecs38qi5.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18 2025 at 12:05, Rafael J. Wysocki wrote:
> On Thu, Sep 18, 2025 at 10:31=E2=80=AFAM Thomas Gleixner <tglx@linutronix=
.de> wrote:
>>
>> On Tue, Sep 16 2025 at 16:13, Rafael J. Wysocki wrote:
>>
>> > On Tue, Sep 9, 2025 at 1:44=E2=80=AFPM Rafael J. Wysocki <rafael@kerne=
l.org> wrote:
>> >>
>> >> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> >>
>> >> The smp_call_function_many() kerneldoc comment got out of sync with t=
he
>> >> function definition (bool parameter "wait" is incorrectly described a=
s a
>> >> bitmask in it), so fix it up by copying the "wait" description from t=
he
>> >> smp_call_function() kerneldoc and add information regarding the handl=
ing
>> >> of the local CPU to it.
>> >>
>> >> Fixes: 49b3bd213a9f ("smp: Fix all kernel-doc warnings")
>> >> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> >
>> > It's been a week and no feedback.
>> >
>> > Well, in the further absence of any, I'll assume no concerns and just
>> > queue this up.
>>
>> Sorry, was distracted. No objections from my side. Did you queue it
>> already?
>
> No, I didn't.

I pick it up


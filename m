Return-Path: <linux-pm+bounces-33863-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63707B442E2
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 18:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B2395A0ADD
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 16:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75ECF230BEC;
	Thu,  4 Sep 2025 16:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="RPsQsGrF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-10696.protonmail.ch (mail-10696.protonmail.ch [79.135.106.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02153224AF2
	for <linux-pm@vger.kernel.org>; Thu,  4 Sep 2025 16:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757003718; cv=none; b=OOrbnfdt5YfD99nkwpmPam/MWakPTLoyKFjGwvMzfmon+mWM+Yz38arHOuHmbFlETQ+65AdLy/q6+CQoFa7RggJUAziJc+Gg26jR5hkLJUbmvA2wtEXuY/yTrDWVwT3a56bKk+pvvU/A7q5qiIBh+UPAsN0tQVBQI3plwgWyA4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757003718; c=relaxed/simple;
	bh=8HHGoft9HLZFEVG4PZeRJJcVgqFbDl9k0crie9ElNaU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZQLI29qLGJAqRq58RI4NgwQrd9AKoNtvX/BuQib5v6xWIXpmRpOkq9xwcJW74Hg1S0OARl95IhnT9sDX7pHmtXMmdj2YdrmzSzlhLKWOrQJOcYPDzhUx1kWPRVRQovxTCQUt6dDJ9YOJTEHxROI2yd7bRSfZ35xRWPVlgyzoW3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=RPsQsGrF; arc=none smtp.client-ip=79.135.106.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1757003707; x=1757262907;
	bh=WhFcl2TCKEpfYhCwOS7EuOgiWb3IBOc4iEecvXxJz+g=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=RPsQsGrFMsX8mJPPDeS2TN6y/rt4DjUdVBkAFUERws0RVCm5DSGlFkRQi8jqy80vR
	 pfiioXQQPLidFiEnVjcFmSpoVzYd/XATHV4BqihaRhY+uA4h6S+iJSpzxeP9gCBEwj
	 597mPQcKNWH2BrnUqWEREwGXRX//dOqONmyoUe4p/gWkmVPs89K3J3n5eGEdmcQADL
	 AJOeDk4ND4IsQtTcMF4V29aefMOZue8zy99w+Xqz1KkmdV0/QHKVMvAFSjP6C8doX1
	 G0RLmAN8ni+ULc0gR4FPMt6VWQauj736IIwnUV4V8yk6ZJMY5EpfeW5IqvYr4DwsEl
	 b5Iq4aHmOZMYA==
Date: Thu, 04 Sep 2025 16:34:26 +0000
To: Mario Limonciello <superm1@kernel.org>
From: aprilgrimoire <aprilgrimoire@proton.me>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [BUG] MECHREVO Yilong15Pro GM5HG7A: lid switch causing unwanted s2idle wakeups
Message-ID: <wkUEC8nqZzIcVXalYzsLi_YheAs0Tw07ug-73PAqUwKmquJr89CPnQKwBImSQLcDABIk4tfWPLCPKa00vG1jH8NpiH5f4yXVATYakltJAQI=@proton.me>
In-Reply-To: <5369f2b5-dba1-4b25-a093-7aa79c578975@kernel.org>
References: <6ww4uu6Gl4F5n6VY5dl1ufASfKzs4DhMxAN8BuqUpCoqU3PQukVSVSBCl_lKIzkQ-S8kt1acPd58eyolhkWN32lMLFj4ViI0Tdu2jwhnYZ8=@proton.me> <06f0c531-2cb6-4a1a-a716-406b4f5f9676@kernel.org> <MawTZCnf5jVqp47YcxRrH21nl0rN8O78_my4TxiZ3tFoNxuP568eHxnEH5-VIMa6DtNbHdXytnpRgVyay-UydMK5tbYe4-TG8e2BYEky5hc=@proton.me> <7a3a3a35-27d3-4b46-b297-475deda04656@kernel.org> <lyy4riGTLOpvYTPUeUx6krjnYdeE8iYbWRrLOJLOChOKMcys00nhNWJ_JD8V8kkVQk87ktMK8w7BAEosOs3KGipyHlvkvQ0_j6cipUfxYtA=@proton.me> <0fb5a890-63f0-412b-8d88-79b40e2c564b@kernel.org> <El5fBf0AkhefzH0LWKyMF3vOCNsHYBCEwxtvXD-tJfLGAFCeJ5ZVbgZE6ibf-KfMxtlkTwr3g1-feqSgfcafGzVGjulc-8QggWHHoJlRDNY=@proton.me> <5369f2b5-dba1-4b25-a093-7aa79c578975@kernel.org>
Feedback-ID: 151975985:user:proton
X-Pm-Message-ID: f3fbe89fe150f4788ab7f06989169e9e4d183a81
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



 > The Linux kernel will break from the s2dile loop when a device asserts
> to wake the system.
>=20
> If IRQ1 triggers when the keyboard isn't pressed that is absolutely a
> firmware bug. We can work around it with a quirk entry for
> pmc-quirks.c. The obvious trade off is that the keyboard can't be used
> as a wake source either, but if you don't disable IRQ1 then another even
> that normally wouldn't wake the system "will wake the system".
>=20
> For example if you plug in the power adapter the EC will assert the SCI
> and will notify the APU to wake up from hardware sleep. Normally the
> kernel will process the EC events and go back to sleep.
>=20
> But if IRQ1 is spuriously active during this time then it will wake the
> system when you plug in the power adapter. So I think it's the lesser
> evil to add that quirk. That being said we need to figure out what GPIO
> 0 is tied to for your system. Because maybe the better solution is to
> disable GPIO 0 and just "rely" upon the spurious IRQ1.
>=20
> With GPIO 0 enabled, can you check when it gets triggered besides the
> lid event? Try these:
>=20
> * Suspend on battery / power adapter plug in
> * Suspend on AC / power adapter plug out
> * Press power button
> * Click touchpad
>=20
> Ideally GPIO 0 is only used for the lid, but given the ASL notifies the
> PWRB device I don't have high hopes.

Hi, Mario!

I tried these events, and I am highly affirmative (on the patched kernel, w=
ith GPIO 0 disabled, these events don't trigger wakeups) that:
* Press power button and keyboard triggers GPIO 0
* Plugging / Unplugging the PD100W adapter doesn't trigger GPIO 0
  (The model also supports 240W round-pin unknown-protocol adapters, but I =
don't have one here.)
* Clicking touchpad doesn't trigger GPIO 0

I think it isn't feasible to rely on the spurious IRQ1, unless some efficie=
nt re-suspend mechanism is implemented. As mentioned in=20

https://community.frame.work/t/tracking-framework-amd-ryzen-7040-series-lid=
-wakeup-behavior-feedback/39128/10?u=3Daprilgrimoire

> I have pulled scalding hot laptops with a nearly dead battery out of my b=
ag because the laptop didn=E2=80=99t go to sleep correctly and stayed on wh=
en I closed the lid.

When put in bags, the lid could move slightly upon shaken, and I am worried=
 that IRQ1 would trigger without me knowing.

Or am I misunderstanding your suggestion on how to use the spurious IRQ1?

Thanks!


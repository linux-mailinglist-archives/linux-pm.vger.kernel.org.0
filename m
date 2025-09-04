Return-Path: <linux-pm+bounces-33802-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D29F5B4345F
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 09:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75D703A68F5
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 07:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18882BE635;
	Thu,  4 Sep 2025 07:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="kJiHNZze"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-05.mail-europe.com (mail-05.mail-europe.com [85.9.206.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADF22BD013
	for <linux-pm@vger.kernel.org>; Thu,  4 Sep 2025 07:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.206.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756971520; cv=none; b=IRVam5l1LYSNUAKxTkpqSFpzj9dBKBczgUbRtsDRXDrAzBBYVTHyZOlz5gtGQ2FnkC5/iit5wI2CWrZJjsmqZK7qg4r3JtRoi/6eJg8pGg0wD45XKK+/JG6PEc/PtnZ/UhZiRMcmslZPmmJkwHJxCGsz+/l5M+EnLNYXbo4eBKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756971520; c=relaxed/simple;
	bh=albpf8uaWOcQO1P9WNZQydQ2NzftyEAjPUEZ0ubn9pQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P+k8npvipr7r+oAwCAhNwrGz5Auuxf4AZIx4GYdmzjhbluZwFcI93CdK6zAoD4uNtx350bO43fYhOZJ4fO4fziVOc5lUUnyfx51sn3B+31p7Nl4OAXSWc8eh+OKDXw0fVaGewEs13IX0PmZHeTtBtlwlsot3F211FxUQyw0r3jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=kJiHNZze; arc=none smtp.client-ip=85.9.206.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1756971502; x=1757230702;
	bh=albpf8uaWOcQO1P9WNZQydQ2NzftyEAjPUEZ0ubn9pQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=kJiHNZze7nT6vNS6HBO8qAtSbFm7y8JWqhKXq20ehI5s0UYDZhxv1ryaQwEFJskY4
	 KzxcW5sGGWAAHr84soKHeWOZ/rv0VqF2Qc6VVm4tCtZNsjfwQ7bjNI8RNHyUlNF0TC
	 QR+iyETs85fV6Phcyy9C6ECMGNPVMRlm2ocvRSLNefHzW86vprjz+nj1EKMVjvFI2E
	 9Fe1WChQI75yHsScwpKBjFMuT7wSN9qkgv3g57ADYAZxEllEgIMPX+1HVXuaPVXjv9
	 jUokbJzek2Og7vfJpF0m8ie9LDBYAr1p0ncW8CrlRlXZVZwv5UbGVpTrS1D2JsNHsk
	 RyczmDlMwnQww==
Date: Thu, 04 Sep 2025 07:38:19 +0000
To: Mario Limonciello <superm1@kernel.org>
From: aprilgrimoire <aprilgrimoire@proton.me>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [BUG] MECHREVO Yilong15Pro GM5HG7A: lid switch causing unwanted s2idle wakeups
Message-ID: <El5fBf0AkhefzH0LWKyMF3vOCNsHYBCEwxtvXD-tJfLGAFCeJ5ZVbgZE6ibf-KfMxtlkTwr3g1-feqSgfcafGzVGjulc-8QggWHHoJlRDNY=@proton.me>
In-Reply-To: <0fb5a890-63f0-412b-8d88-79b40e2c564b@kernel.org>
References: <6ww4uu6Gl4F5n6VY5dl1ufASfKzs4DhMxAN8BuqUpCoqU3PQukVSVSBCl_lKIzkQ-S8kt1acPd58eyolhkWN32lMLFj4ViI0Tdu2jwhnYZ8=@proton.me> <06f0c531-2cb6-4a1a-a716-406b4f5f9676@kernel.org> <MawTZCnf5jVqp47YcxRrH21nl0rN8O78_my4TxiZ3tFoNxuP568eHxnEH5-VIMa6DtNbHdXytnpRgVyay-UydMK5tbYe4-TG8e2BYEky5hc=@proton.me> <7a3a3a35-27d3-4b46-b297-475deda04656@kernel.org> <lyy4riGTLOpvYTPUeUx6krjnYdeE8iYbWRrLOJLOChOKMcys00nhNWJ_JD8V8kkVQk87ktMK8w7BAEosOs3KGipyHlvkvQ0_j6cipUfxYtA=@proton.me> <0fb5a890-63f0-412b-8d88-79b40e2c564b@kernel.org>
Feedback-ID: 151975985:user:proton
X-Pm-Message-ID: 218844c56433a9edae6c4940f8e6296e7d4e3a53
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

> Got it - so it sounds like that IRQ1 quirk is probably enabled as well.
> Feel free to send a patch for that and CC me (as you already proved it
> helps remove IRQ1 from spurious wakeups for your system).
>=20
> Make sure you base it off this branch because I know this was touched
> recently for another system too.
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x8=
6.git/log/?h=3Dfixes

Hi, Mario!
Sorry for bothering you again.

I didn't do enough testing, and it turned out that this laptop does need th=
e quirk to stop lid from waking up. The unwanted wakes aren't triggered eve=
ry time.

However, this quirk comes with a significant side effect: now I'm completel=
y unable to wake it up with components builtin on the laptop. Maybe usb eve=
nts can still wake it up though, but I don't have any around me. Shall I st=
ill submit a patch for this?


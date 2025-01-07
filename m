Return-Path: <linux-pm+bounces-20045-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF372A040DB
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2025 14:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 643CA3A31DA
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2025 13:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D21E1EF0B5;
	Tue,  7 Jan 2025 13:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="G2pj0DKS"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901A91EF0B7;
	Tue,  7 Jan 2025 13:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736256640; cv=pass; b=hNJc547YG0aWxfFjG5Y3ta+Z6+40+g9+ke2kFcxsZ66zNrJCjoCR/b2TzKePW/hDANm970HHiAFpWMCuR6FPFzhdbOSldJuIIuXmDVztk1vV9w1xNXvjY/YMzZEUJ6wHRoClDCDr0yvh4OT3cqNB6jyfpM/NQ/CvFoS9bDQRbvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736256640; c=relaxed/simple;
	bh=njLN2s8U1a+9npQ5c5p1bQK9JykiYElbFKzLso2/6Dg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=uacbutB3FZ0Ld0ekLlBI5IWLzVkqdJzVF2OR+cHTi4P0FhEXnQdOdXvEgThmvlZ4K70NgRadLnxqRMTYVwPxwBKgZcW0elDL0/p/0/Fgd2auPrypaOpWtiMptSqiG1aZhdSHH1c0oQ33Lx737qU93gjR8OhoaBiTXs4LZa10e8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=G2pj0DKS; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1736256612; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=eL9tt2YE+y3Fn7MsnsqTPtBkfZrLfM2/ro9xf1TDtCK93fGMUCL/okpw4SGte7OT1hf5FfnzLX/M7Cfc07RAxlW08fv090OgTCkSUp017tvtlsYmfwmWHO0h6ivmxkIo9xT6K9kYq5e2Ng9enFOFjed29dKqRjbS3YuvJ0IQsy4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1736256612; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=hOjPDKQue/XRD97gOQVuu+Aob3TzgnZBl+jEVIrwzAc=; 
	b=jyBmJUzQAv2FWRnRqPmbZpv4ur6Kb1MTWJyFdO2JAqsg/jW3J8U3mVGvWuMIeKmFHYdnrC7DuWNXBHpSyD7b70QwwbectfptMjLC/QbZrIeNJevqUFWWkzuEGYnVRDBewxzPjQ9PXy8T4R4VrDAfzvuCkNY2/gNLEsDnez0WSGw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1736256612;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=hOjPDKQue/XRD97gOQVuu+Aob3TzgnZBl+jEVIrwzAc=;
	b=G2pj0DKS4j4AOY4fusRMXjigonEdAnKjf4Kf0GmTkebytX8/sh1n7VcWzZtWz+gl
	6HEDI9roI6gNeNHMOxzgnDYL+G97z7cA7xiW/thf2FtrnpbqASfxqXsUBaIA4BjuRzL
	eY83zIFDQQHvOQZlsbRy/x4OpswFLZlTC8Vaqpko=
Received: by mx.zohomail.com with SMTPS id 1736256609260727.2961364691213;
	Tue, 7 Jan 2025 05:30:09 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.300.87.4.3\))
Subject: Re: [PATCH V6 03/15] cpufreq: Rust implementation doesn't parse BIT()
 macro
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <2025010752-vagrantly-juiciness-cd81@gregkh>
Date: Tue, 7 Jan 2025 10:29:50 -0300
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Danilo Krummrich <dakr@redhat.com>,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 linux-pm@vger.kernel.org,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Stephen Boyd <sboyd@kernel.org>,
 Nishanth Menon <nm@ti.com>,
 rust-for-linux@vger.kernel.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Erik Schilling <erik.schilling@linaro.org>,
 =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Joakim Bech <joakim.bech@linaro.org>,
 Rob Herring <robh@kernel.org>,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <37DAF91C-2A1B-4848-A66F-3B50285AFEBA@collabora.com>
References: <cover.1736248242.git.viresh.kumar@linaro.org>
 <9719ba8b3a921bd9f2cb7ebf902c54c708b5409d.1736248242.git.viresh.kumar@linaro.org>
 <2025010752-vagrantly-juiciness-cd81@gregkh>
To: Greg KH <gregkh@linuxfoundation.org>
X-Mailer: Apple Mail (2.3826.300.87.4.3)
X-ZohoMailClient: External

Hi,

> On 7 Jan 2025, at 09:00, Greg KH <gregkh@linuxfoundation.org> wrote:
>=20
> On Tue, Jan 07, 2025 at 04:51:36PM +0530, Viresh Kumar wrote:
>> Rust isn't able to parse the macro for now, avoid using it.
>=20
> No, please fix it.  You don't want to have to fend off the =
checkpatch.pl
> cleanups that this would cause of people putting the BIT() macro back.
>=20
> Make BIT() work properly for Rust code as well, it has to be done
> eventually, right?
>=20
> thanks,
>=20
> greg k-h
>=20


Viresh, FYI, there=E2=80=99s already a patch for this floating around =
[0].

I can send a new version today. =46rom Alice=E2=80=99s last comments, it =
only
needs a minor fix anyways.

=E2=80=94 Daniel

[0] =
https://lore.kernel.org/rust-for-linux/20241024-topic-panthor-rs-genmask-v=
2-1-85237c1f0cea@collabora.com/=


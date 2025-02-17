Return-Path: <linux-pm+bounces-22203-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E6AA382D3
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 13:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA6523AC00D
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 12:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C38521A451;
	Mon, 17 Feb 2025 12:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="djEOSibu"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E73218842;
	Mon, 17 Feb 2025 12:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739794844; cv=pass; b=ew2V2i0a9edksFJQ8OAEVRgshR7LCX5ZYuekihHqxkEiBAO2HNOFm0lzpOTipCJjH+rjr29YuBGMBmBUL2Kd4PFhUQ0ikapu5Jce5ATBWXWja6m2IVmhZulyE5bcGIJMEVvU1Z3D4qBKxcCwSMijOM+gmFWCKMNYrCgzWWFGOxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739794844; c=relaxed/simple;
	bh=gAK0z1eMSFkXTRTMPAieGLJr3Bhl0DvjUlpsOZAm4jo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=dOHkYHlhk3S72PmGaz3dn7bYuQms900Oz11RDuy4Lbu+ALxO8IoEEa4gcWugv1sJzzphyGMb3B1x2wKOV1Mr7iK6TZDHgwTwWXzHgG1BIMfVL2Hbf1+zuv/ZzQbyDzDpAl2YVwh8A/61P1Q7F2L5taiiGZgFGalZqA0JOg56mu4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=djEOSibu; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1739794815; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=GuXIgRTKfl5pnsPmwHwiTzLe4SKUWKrV3qrYKBVJ2X8sRCVcOuVzlCNMdH4r3KbF5TN//FC6nnkG+1czD1/CHFHD9xyTDn+6pCnPsMTJ+W+BZ/wvb3jp6E6rWwW5pxiockASliDqWtccqobD1r2xh0id+AeOEWTyIhVbL0eHHOE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1739794815; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=gAK0z1eMSFkXTRTMPAieGLJr3Bhl0DvjUlpsOZAm4jo=; 
	b=ADkVlSunrvisvHSJYruzGBvyLQ0JgTHRlE/8vCx56tYr24gRa3DCSq80RNUK4T0PWGZE3OjJtI2cM1bXTRpYCSKVM5wwg9AizxM//2xDuScLGsnYhcN58eVj6P79DJ6uoz/GZqfCYIDvFUJg13cNtXuhQW//gDCGhD0X96w3AmE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1739794814;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=gAK0z1eMSFkXTRTMPAieGLJr3Bhl0DvjUlpsOZAm4jo=;
	b=djEOSibu6AvPYJWLed81y8oFIIl+78SQKw0jnPrX35Z1OOKFsiIFsRQylmZKUE8M
	dtr3PomY7yEBu3dJZ0ZufI17rO3ko6MGJ61Z/gh+bEpLMjP3Om/MH2xFrJBqFIEvahF
	NgyLjsXX4BdU4y11ScItRUafA22XF2vBa9ha8eL8=
Received: by mx.zohomail.com with SMTPS id 1739794812898824.9432494406607;
	Mon, 17 Feb 2025 04:20:12 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.300.87.4.3\))
Subject: Re: [PATCH V8 06/14] rust: Add bare minimal bindings for clk
 framework
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <c68081e18d939aefc7f6dac798df6b72e81bba4b.1738832118.git.viresh.kumar@linaro.org>
Date: Mon, 17 Feb 2025 09:19:51 -0300
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
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
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>,
 linux-pm@vger.kernel.org,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Nishanth Menon <nm@ti.com>,
 rust-for-linux@vger.kernel.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Erik Schilling <erik.schilling@linaro.org>,
 =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Joakim Bech <joakim.bech@linaro.org>,
 Rob Herring <robh@kernel.org>,
 linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <EC290802-2C5E-4ACA-A530-E776654C7E94@collabora.com>
References: <cover.1738832118.git.viresh.kumar@linaro.org>
 <c68081e18d939aefc7f6dac798df6b72e81bba4b.1738832118.git.viresh.kumar@linaro.org>
To: Viresh Kumar <viresh.kumar@linaro.org>
X-Mailer: Apple Mail (2.3826.300.87.4.3)
X-ZohoMailClient: External

Hi Viresh

> On 6 Feb 2025, at 06:28, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>=20
> This adds very basic bindings for the clk framework, implements only
> clk_get() and clk_put(). These are the bare minimum bindings required
> for many users and are simple enough to add in the first attempt.

I am missing clk_prepare_enable/clk_disable_unprepare.

Otherwise I see no way of enabling and disabling clks. IMHO I would also
consider these as =E2=80=9Cbare minimum=E2=80=9D.

=E2=80=94 Daniel=


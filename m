Return-Path: <linux-pm+bounces-35088-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8CAB8C5AD
	for <lists+linux-pm@lfdr.de>; Sat, 20 Sep 2025 12:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0606169281
	for <lists+linux-pm@lfdr.de>; Sat, 20 Sep 2025 10:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70A72EA75C;
	Sat, 20 Sep 2025 10:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="LenH2K7a"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60DC1EDA0F;
	Sat, 20 Sep 2025 10:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758364586; cv=pass; b=nhYnhdNAjlBioRPQLVo4FGotghRLUYd4zRENEACGIiDfpK1hCFgYTUMmXkk31oyFqml5FvA3nfeqHsVCv30ivFOtvyMOmf3ArA5R3hpPiefjllh47RRTd8eDdpVmIwr/uOiAvTngCZJO2QhnH8qMMzUGlhwYm+jssKtwB8KkUCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758364586; c=relaxed/simple;
	bh=XhVjlxD10B7EfXybmuBwRKrwLtgoQoCtuuWPtFVvw3c=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=l2jNXuIN3CXe14PL6wygjYrIg6bF+V/t+NRiOhdyrt6aL78eknu18E67J5DF3ML8jYauY+JB7wwBDLOoM/18BfHKo5v3fIhjSRhkgFjOwPzpgx7BAcDtpqJoV5NKSb07yDbp2h1A/TtSECrM/5MOIz3mYHKiKj/00dUDXW9XsL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=LenH2K7a; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1758364569; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=aQsbP1cGohIJwTQYJy8PZCuozlEMdvuu/obm9kFKGWICjT39SmHcAhSoB2Aq04Kn+CdV9JwxO+Uiwz2c6TrI2dtnFBM1TL1EyQUR0f/zFFyZHRerVZ9q/eoqtpAgwmGRyp/RFQRE77ZKLZqaW9l/phDHAV9TDmRsH1CMnfYDWi8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1758364569; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=XhVjlxD10B7EfXybmuBwRKrwLtgoQoCtuuWPtFVvw3c=; 
	b=T/AvK9Tqz8rrcwV3pCaHsndxW1AGNNp/9zAxmSMAvKmbT0H5+eArm6xiRaL2dC7axcekB61BXnDMk+3SqfybE5CpEJHMEzRtTFkvXQvYzObVy8JbDsQX6SGK4jtbkwFH2t/P/vg10eCr7S1PomMJY0hVkbSKteY+4JbehJBtWuY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1758364569;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=XhVjlxD10B7EfXybmuBwRKrwLtgoQoCtuuWPtFVvw3c=;
	b=LenH2K7a7hlAKnOI3BW3s1DJHfCCca0pezFv3H4XXXc1BUzXQAdiyQDJzdRegrLr
	gnxJusno3oyFsC37qsSlmlmUSTKSCJMKkXU01Q3xe8rTJF41M+17QnIwQ+eaJxpX1UN
	LKDNa1XCrYbUX2b58kXQqk46j+bDJIDXNdSICrys=
Received: by mx.zohomail.com with SMTPS id 175836456731956.09508853652039;
	Sat, 20 Sep 2025 03:36:07 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v2 2/2] rust: clk: use the type-state pattern
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250910-clk-type-state-v2-2-1b97c11bb631@collabora.com>
Date: Sat, 20 Sep 2025 12:35:52 +0200
Cc: linux-clk@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <93C70872-E3E5-4CF2-9CB2-56353C26FDA0@collabora.com>
References: <20250910-clk-type-state-v2-0-1b97c11bb631@collabora.com>
 <20250910-clk-type-state-v2-2-1b97c11bb631@collabora.com>
To: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External

Hi everyone, gentle ping for reviewing this patch :)

> On 10 Sep 2025, at 19:28, Daniel Almeida =
<daniel.almeida@collabora.com> wrote:
>=20
> The current Clk abstraction can still be improved on the following =
issues:
>=20
> a) It only keeps track of a count to clk_get(), which means that users =
have
> to manually call disable() and unprepare(), or a variation of those, =
like
> disable_unprepare().
>=20
> b) It allows repeated calls to prepare() or enable(), but it keeps no =
track
> of how often these were called, i.e., it's currently legal to write =
the
> following:
>=20
> clk.prepare();
> clk.prepare();
> clk.enable();
> clk.enable();
>=20
> And nothing gets undone on drop().

^ this really sucks so we should probably take in this change.

=E2=80=94 Daniel=


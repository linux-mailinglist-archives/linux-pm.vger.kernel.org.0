Return-Path: <linux-pm+bounces-35087-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0652CB8C598
	for <lists+linux-pm@lfdr.de>; Sat, 20 Sep 2025 12:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6DD646456F
	for <lists+linux-pm@lfdr.de>; Sat, 20 Sep 2025 10:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DFC92D0C78;
	Sat, 20 Sep 2025 10:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="MhRocBku"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2E219CC37;
	Sat, 20 Sep 2025 10:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758364425; cv=pass; b=nPV9fsnJn3KFZeMf3En+Hzt5dkCBQcMDgRDRnxGDu5vEfeQXEQ1Qz7IlpfdJyCwmD6hGDa61dNyaQQcG+wejP5uFyS8l1DEY6PuVNityviu6zfWezy/HbwJHTYB9S/OPHrGvd07WZlMbrb1fNV6RF1BlATLaoy38cZJzmih60RU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758364425; c=relaxed/simple;
	bh=5gbTTGLThCF49SBYHgLCDqqZ8ZxRPZA61AQy7rUHSiY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=gdvjs1xfLP3ZQKIHLErjMrh+T1hiATwVvK+Zub6HX4ZzCoN9Wh8akurdqn2+s8F66j2jdNWSDALpmoSiVU+t1hwfh/Jw6P5zAs3RYpsIxHWX+3eJcB0yji7H7PsSGMerlGif65t8371ru7nCfk/jeVL8xr3aYeM3KVIjz6ffcfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=MhRocBku; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1758364405; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=FqeKWDVbi/rNVZcN2hBUNLkdAxET5+/lI5cE3nYqcwwV61fmay5oEkEqebmxaO74w2MzgTjQtAox2oqvS0SO0Zmc1X2eF9JG9hm8DDQ4QXdqIcdcsSTQhGuwnjqcAand905BNddLV17WrE/xx752QDa2jMsDiWOUNQ3jjqezJiw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1758364405; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=5gbTTGLThCF49SBYHgLCDqqZ8ZxRPZA61AQy7rUHSiY=; 
	b=YILUi2TyGHfWa1wyH4DKUwMQWEqAQb+eeOAa6GrsODPOZjGRg4q0w39NgmaujEc6DYMKumvXSmUUX5fnNc3OWx9ymPWnbLZlmoKeULLxxyDzvrTz5XX1DbOJjp+ddSnSsnZzXNYSTRVGlD39FC5EgE7dIcIYvWE4A6CVQFs8pcg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1758364405;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=5gbTTGLThCF49SBYHgLCDqqZ8ZxRPZA61AQy7rUHSiY=;
	b=MhRocBkuRpmA06kuq+HM7Fc1u1m4HobJJotgxpjUJgTBfyy/ufIBSRm5czhz8I9J
	qzTmT979B0xlG0hSDALc3xk7dd+Q49D0y9/MOvWGc1qXhubF1gHFhp2jqSMhcwE7bLL
	aasEwomw5PDzF2pl8+kdOgGcCT0qgtjw6HNLsuls=
Received: by mx.zohomail.com with SMTPS id 1758364403012665.4098911835472;
	Sat, 20 Sep 2025 03:33:23 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v2 1/2] rust: clk: implement Send and Sync
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <175834480479.4354.6269916774389395049@lazor>
Date: Sat, 20 Sep 2025 12:33:07 +0200
Cc: Boqun Feng <boqun.feng@gmail.com>,
 Michael Turquette <mturquette@baylibre.com>,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 linux-clk@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <11324A9C-F7CC-47C7-B225-59A96C333A82@collabora.com>
References: <20250910-clk-type-state-v2-0-1b97c11bb631@collabora.com>
 <20250910-clk-type-state-v2-1-1b97c11bb631@collabora.com>
 <aMG6JVMcMxVuX7De@tardis-2.local>
 <3D936C1B-FBA9-4964-859C-84BB665BBE3B@collabora.com>
 <175834480479.4354.6269916774389395049@lazor>
To: Stephen Boyd <sboyd@kernel.org>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External

Hi Stephen,

[=E2=80=A6]

>>=20
>> You have to include your SOB when submitting patches from others.
>>=20
>> This is something I tend to forget often, so I made sure it was =
there. The
>> order may be indeed off though.
>=20
> Yes the order is wrong. The first SoB should be the commit author.

Do you want me to send a new version, or do you prefer fixing this =
before applying?

For trivial changes some maintainers prefer the latter to reduce the =
amount of noise.

=E2=80=94 Daniel=


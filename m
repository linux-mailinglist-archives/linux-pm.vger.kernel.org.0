Return-Path: <linux-pm+bounces-21753-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3AA0A2FC9C
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 23:07:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E65D1888285
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 22:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E09BF24CEF9;
	Mon, 10 Feb 2025 22:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kQIrr4TP"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA308264604;
	Mon, 10 Feb 2025 22:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739225272; cv=none; b=ml6FtKjqPSc20TaLvX+5RUPVUYoy4WrVnjDC4OnLJLKXqplJUHsGphiYe9hnLr/tjNtGCQP45JDCfvl8uSuRj9h6fQmaORbRZbBOTR6Y30TZg7QHTf9lYqVrfI2tSJBIHbr+PYfekQ4UXzHe09KSNYnua3kJYuk9nfOPTufxtmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739225272; c=relaxed/simple;
	bh=soGGYi5SZ7hfquIE86n6wxhLDKzRy/sjal53c1wfsY0=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=crzJh6qJ7dTnKaqz4b0yTJfeqazVRvyOMBXqSUp5erj8YueqfcbGl1WyWY3ZzUmGCC5zG//Nt6VJ/RXmiWaGL1csN7hPvbYL9V3dQjg4+cEt47EYnnGq9da3P99ZmHIr3AlDyhEl4ECTZjrrm/IaU+cqEIPseefQfNU7qr4tGAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kQIrr4TP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1F00C4CED1;
	Mon, 10 Feb 2025 22:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739225272;
	bh=soGGYi5SZ7hfquIE86n6wxhLDKzRy/sjal53c1wfsY0=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=kQIrr4TPbWfLCp09znKaOCMCRcXmAsnF6bsbBaRFkl9EQDQwQDEjMAA98sXrWr/hK
	 t4al5X+2jM0+HVKP1cXr/YSu36GJ8IF0hF7BD7vKVPGVAoOFYNCUzn48K2uUz8ZWMV
	 GueGQ6rWq8BEtYatNcVQ+GZntF6n+fdO8oKCcU9P54cmMIOqZflrfbD5LOpMCYx37L
	 EXCE1bF4kdkfgo0/Yqmf0GWoQtyiRtTPcgHW7OEhUkW30U7abDpQWtVr/6jZCZ8E94
	 fLOv3BG8kd2D7tdjy0CGyf+NrTWsAUn+5aG8d5urK8S5oo1io+ykfDu6Crn/e2ACuP
	 Ge2Z+QtLTbRbQ==
Message-ID: <a66c949345e9118b2ebbdca39e4962c5.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <Z6VBo51g54xAmelQ@cassiopeiae>
References: <cover.1738832118.git.viresh.kumar@linaro.org> <c68081e18d939aefc7f6dac798df6b72e81bba4b.1738832118.git.viresh.kumar@linaro.org> <Z6ShsuLykigNscz8@pollux> <Z6SiiRubSXGInbgj@pollux> <0cd42d2d683ea057e6034978b02c7f84.sboyd@kernel.org> <Z6VBo51g54xAmelQ@cassiopeiae>
Subject: Re: [PATCH V8 06/14] rust: Add bare minimal bindings for clk framework
From: Stephen Boyd <sboyd@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Rafael J. Wysocki <rafael@kernel.org>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Danilo Krummrich <dakr@redhat.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Michael Turquette <mturquette@baylibre.com>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Nishanth Menon <nm@ti.com>, rust-for-linux@vger.kernel.org, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, Erik Schilling <erik.schilling@linaro.org>, Alex =?utf-8?q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
To: Danilo Krummrich <dakr@kernel.org>
Date: Mon, 10 Feb 2025 14:07:49 -0800
User-Agent: alot/0.12.dev1+gaa8c22fdeedb

Quoting Danilo Krummrich (2025-02-06 15:11:31)
> On Thu, Feb 06, 2025 at 12:05:59PM -0800, Stephen Boyd wrote:
>=20
> > as most clk consumer operations bail out early in that case.
>=20
> Most? Does that mean NULL isn't *always* valid?

I'm hedging because the common clk framework is just one implementation
of the clk.h API in the kernel. We still have a couple other
implementations (sadly) where I haven't checked to see what they do if a
NULL pointer is passed in. But NULL should always be a valid clk handle
per the clk.h API documentation, so an implementation that fails at that
is broken.


Return-Path: <linux-pm+bounces-25539-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4769BA8B741
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 12:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6E853A5DBB
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 10:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7441B236436;
	Wed, 16 Apr 2025 10:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UNbPAASA"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B6F207643;
	Wed, 16 Apr 2025 10:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744801168; cv=none; b=FFx+2YVqM4eTRNFXSkWa+P3ac/hUEz7Ct5PvWu6Lg4zEePu1wvzvz3RgpDrEQ7Jv9dJWmWDtBgBX2I/gq5/TVYPhM7VHKqPfeNPmnULqMZkpNBufIrz6dVOuwkWnQ0f4CdDQJkUC5IHf7ueVmCwhWp64GS1aJGKSmYIUoTR5j3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744801168; c=relaxed/simple;
	bh=uMHGiZr/NxEIl4Dgh6kI7RFnOoEF1YTOBJysxCM4848=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ar2/SjxTJASTvANrUB9s7qd+Yr03QOevTXTfN/HOYVRvce9gewHi1rKi8YYfT1C8dfTN2xnZ1l4kH+6X7LWEb4/LU+2e5zTlE/sX9IVqeN0wd4fZpjoO09eP/yPrGCLvZJKw0HNLATgkybYqlctz2VB3yXYWHEzDZCWMhGvBr/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UNbPAASA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A935C4CEE2;
	Wed, 16 Apr 2025 10:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744801167;
	bh=uMHGiZr/NxEIl4Dgh6kI7RFnOoEF1YTOBJysxCM4848=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UNbPAASAdV4gXY/qLJKWOIhLqBd/aIHlj9hlvyjZm1qooedQRcuiFBLiGKWuuXa0E
	 qlPl5ThPLK3jzUT0esH99LT3Mz41Igeviw1emQOl83eIpCFblyUKs2UE0HNlfrdIbp
	 YQctoRcHp8hDxk+O1ZuM9LcHOiNJsWVWCvC5bOR9b10cyO+Vw7CcW7J+PWLsOy604B
	 IXoBfMCa1HfnE/AxemfOE2pOI+pCrET/AYBYlwBeZnanoXwUcb8dTye8L1RjOLhhJT
	 wUff6iyUrrMV1CmBZTvq0JKbiT7BptMpKWgfyuv2yEI9n/FPUUT/WO5ItsnQwjapvG
	 fvxiRDA+7341g==
Date: Wed, 16 Apr 2025 12:59:19 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Danilo Krummrich <dakr@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
	rust-for-linux@vger.kernel.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>,
	Yury Norov <yury.norov@gmail.com>, Burak Emir <bqe@google.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Russell King <linux@armlinux.org.uk>, linux-clk@vger.kernel.org,
	Michael Turquette <mturquette@baylibre.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V10 13/15] rust: cpufreq: Extend abstractions for driver
 registration
Message-ID: <Z_-Nh_dDifS1lvOD@pollux>
References: <cover.1744783509.git.viresh.kumar@linaro.org>
 <8d04ef19d7a16610dbf0dfb5c9a611c6e1e3e318.1744783509.git.viresh.kumar@linaro.org>
 <Z_9ysHFmvZvaoe8H@pollux>
 <20250416101726.g5jm6wnbbsmuskxl@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416101726.g5jm6wnbbsmuskxl@vireshk-i7>

On Wed, Apr 16, 2025 at 03:47:26PM +0530, Viresh Kumar wrote:
> On 16-04-25, 11:04, Danilo Krummrich wrote:
> > You need to justify why drv is a valid pointer to be passed to
> > cpufreq_register_driver(), i.e. something like
> > 
> > 	// SAFETY:
> > 	// - `drv` comes from Self::VTABLE and hence is a valid pointer to a `struct cpufreq_driver`,
> > 	// - `cpufreq_register_driver()` never attempts to modify the data `drv` points to
> 
> The cpufreq core can try to change the data pointed by `drv`. For now
> it updates the `cpufreq_driver->boost_enabled` flag.

VTABLE is const and hence ends up in the read-only section of the binary.

I assumed that struct cpufreq_driver (like most driver structures) is const.
Actually, I think it should be.

Anyways, that doesn't help for now. Unfortunately, I think you actually need to
dynamically allocate it. There's no need to revert everything though. You can
just allocate a new KBox from VTABLE, i.e.

	let vtable = KBox::new(Self::VTABLE, GFP_KERNEL)?;

This makes it easy for you to remove the dynamic allocation once (or if) cpufreq
is ever reworked to allow a static const struct cpufreq_driver.


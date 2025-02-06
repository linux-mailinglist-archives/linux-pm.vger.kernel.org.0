Return-Path: <linux-pm+bounces-21467-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67FCEA2A7D5
	for <lists+linux-pm@lfdr.de>; Thu,  6 Feb 2025 12:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C32181884579
	for <lists+linux-pm@lfdr.de>; Thu,  6 Feb 2025 11:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5137922ACF1;
	Thu,  6 Feb 2025 11:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ESd0vkMf"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2113922A1C2;
	Thu,  6 Feb 2025 11:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738842314; cv=none; b=t61KXAu4IJdeoClgKRfM8KMA7aRJipffljp1MdsVAUDtwEAxHfSbu8aEPorLq8omP+iI8tDAWpHvgTjOUQTTx+DYUJKpG/lfbSBA3SxnRxnj0hNVYxj1D+V1C7AA6Ja9pUBin+I+OvIrzHAPrh6M5beO2mFkvhCi/fjU77lebRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738842314; c=relaxed/simple;
	bh=noSQ+Xs1uJzUWnLdUjp+J+1wjOFITtMZFxGZIKDmVzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mMlrfra7u4a9V1gARUAsj3EIG38uaaZ0FfImNt68PHOCk3vXLMIAQYDmcqKTB2E0Hf58sEDCBI63NBm0rWD95wNrCqBAs+kJTeBAQFhMSpC0lF/3UVRBZmdKm4uBpGhj5wSalogopVVV6AQLPiAx+2aYRMKn6QBWBj8YLLXgDYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ESd0vkMf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFC8EC4CEDD;
	Thu,  6 Feb 2025 11:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738842313;
	bh=noSQ+Xs1uJzUWnLdUjp+J+1wjOFITtMZFxGZIKDmVzs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ESd0vkMfYhujEVmrRpUZ0wDb0ZV5NTnVgJUEpDrUPF4CQi+h/Cf9Esuiv0oCZ+YOG
	 L/lUns9YVFIT4P4FAOpWwpNFQKeyKDHxOIYLi1P++4nH0Jo4CFAS5IuClaWlCnF1CV
	 8BQ18cdpnGZ0IXjAqsYKtZd6XDMiqvUiEa5ChrKMKN/QXRNS5JX1bGigUNazj7+jPe
	 20ER3q7r25ncTItfphqtkZWtT2K1gG37xBfSU7bB2GSZJxBrVax4UhouPuwuC6Yseb
	 YrQsFhspM3H7f5mG8UVQuLB8pAAzX8R6Cr4B9yK/NrpKl0vx7ss2wgmOqIvIT2cGzJ
	 FY0Inw1I72C8Q==
Date: Thu, 6 Feb 2025 12:45:05 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Danilo Krummrich <dakr@redhat.com>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Benno Lossin <benno.lossin@proton.me>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	Michael Turquette <mturquette@baylibre.com>,
	Miguel Ojeda <ojeda@kernel.org>, Nishanth Menon <nm@ti.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Stephen Boyd <sboyd@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Trevor Gross <tmgross@umich.edu>, Viresh Kumar <vireshk@kernel.org>,
	Yury Norov <yury.norov@gmail.com>, linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	rust-for-linux@vger.kernel.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Erik Schilling <erik.schilling@linaro.org>,
	Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>,
	Anisse Astier <anisse@astier.eu>, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V8 00/14] Rust bindings for cpufreq and OPP core + sample
 driver
Message-ID: <Z6Sgwbgfp-9SCr8Y@pollux>
References: <cover.1738832118.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1738832118.git.viresh.kumar@linaro.org>

Hi Viresh,

On Thu, Feb 06, 2025 at 02:58:21PM +0530, Viresh Kumar wrote:
> Hello,
> 
> I am seeking a few Acks for this patch series before merging it into the PM tree
> for the 6.15 merge window, unless there are any objections.
> 
> This series introduces initial Rust bindings for two subsystems: cpufreq and
> Operating Performance Points (OPP). The bindings cover most of the interfaces
> exposed by these subsystems. It also includes minimal bindings for the clk and
> cpumask frameworks, which are required by the cpufreq bindings.
> 
> Additionally, a sample cpufreq driver, rcpufreq-dt, is included. This is a
> duplicate of the existing cpufreq-dt driver, which is a platform-agnostic,
> device-tree-based driver commonly used on ARM platforms.
> 
> The implementation has been tested using QEMU, ensuring that frequency
> transitions, various configurations, and driver binding/unbinding work as
> expected. However, performance measurements have not been conducted yet.
> 
> For those interested in testing these patches, they can be found at:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/linux.git rust/cpufreq-dt
> 
> This version is rebased on v6.14-rc1.

I gave it a quick shot and it seems there are a few Clippy warnings, plus
rustfmtcheck complains.

There are also two minor checkpatch complaints about line length.


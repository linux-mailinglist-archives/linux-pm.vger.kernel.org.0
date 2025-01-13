Return-Path: <linux-pm+bounces-20292-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A84EFA0B05D
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 08:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8964165E4A
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 07:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D690123236A;
	Mon, 13 Jan 2025 07:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Inwr+RYI"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8693122615;
	Mon, 13 Jan 2025 07:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736754812; cv=none; b=WxWL9fxRo5Se862nSQ3B4/CEiOy2DajUrDaJn39jJRQNSKdDlvCdi/Mzjqx1y4SWGHk0LpHn0xyjmqbhBiX9zZBnciBvAwIlaXj/7xp/ma9In2HyEhYX5wsGuyMe+xo/nSoBCH25X/28jA9r4L8m8GmiPRKv4IuaZJptt5KozK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736754812; c=relaxed/simple;
	bh=uKBllgZyy71g3g9qQg2i06ADs11pma9pXxJfN63M61w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QM9HMNxpYFighXJVNlQLUElyh59oTqA1yIqSc8kQ33BaOlUpzK8ouq4iMYppAR5+JD0pN4GZqfN5Jk0G+CU3zQLqBybxZgW+b3vLhU4e1WNX1EglhytXO7MjGur0kjh6ZB4zADSEpN602mzh4Gd473Yp2h6GbN/IJ/Gbh6WFPu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Inwr+RYI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 724A1C4CED6;
	Mon, 13 Jan 2025 07:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736754812;
	bh=uKBllgZyy71g3g9qQg2i06ADs11pma9pXxJfN63M61w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Inwr+RYIp1cQSYLw5aDH8MMD4EhwBV9ECiCogXH1TJ5hupWiqRGZJbT9fTsK0yKzr
	 kA3UHW43ETNWdxyiXFMVrZACyFQ5+H9xLIO692rDVWZYLQ2uOiMLiYyhGuTCWXuI5x
	 Y7/ps5k5n1bcTkcpnwAK6wnnXwUCg5PU4NNAG9V4=
Date: Mon, 13 Jan 2025 08:53:28 +0100
From: Greg KH <gregkh@linuxfoundation.org>
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
	Erik Schilling <erik.schilling@linaro.org>,
	Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V6 02/15] cpufreq: Add cpufreq_table_len()
Message-ID: <2025011327-cubbyhole-idealness-d4cc@gregkh>
References: <cover.1736248242.git.viresh.kumar@linaro.org>
 <867ba9728179ba21ff8f8aca97d416b72ccd63d9.1736248242.git.viresh.kumar@linaro.org>
 <2025010727-banner-monday-1941@gregkh>
 <20250108111253.tg6ixurijf2dvptx@vireshk-i7>
 <2025010855-cargo-quickness-a08f@gregkh>
 <20250109044117.s5s4dlmssamwicew@vireshk-i7>
 <2025010944-detective-borough-b158@gregkh>
 <20250113073040.rvtc27zcgpvcycrr@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113073040.rvtc27zcgpvcycrr@vireshk-i7>

On Mon, Jan 13, 2025 at 01:00:40PM +0530, Viresh Kumar wrote:
> On 09-01-25, 08:35, Greg KH wrote:
> > Then why not make the C code use this function as well, to keep all
> > cpufreq drivers from having to manually walk the list and that way both
> > C and Rust drivers all do the same thing?  That makes more sense to me,
> > there's no reason you can't change C code today first to make things
> > more unified, in fact, that's usually a better idea overall anyway.
> 
> I investigated a bit on this..
> 
> - The cpufreq core normally gets (from cpufreq governor's for example)
>   a frequency value to be matched against in the freq-table, and the
>   loop which run over the freq-table is already optimized enough (it
>   checks for CPUFREQ_TABLE_END) for this. Using length in this loop
>   won't improve it anymore.
> 
> - The cpufreq core then calls cpufreq driver's callbacks and passes an
>   index to the freq-table, which the drivers don't need to verify
>   against table length, since the index came from the core itself.
> 
> - The same happens on the Rust side, where the cpufreq core calls the
>   target_index() callback of the driver. While writing the Rust code,
>   I thought maybe I should validate that the index is within limits
>   (before I do pointer manipulation in Rust code). And so required
>   this extra function (which C code never uses).
> 
> - Now I can either keep doing this verification in the Rust code (and
>   so keep the new API, only used by Rust code). Or I can just remove
>   the verification and trust that the index passed by the
>   cpufreq-drivers is correct (since they have received them from the
>   cpufreq C code).
> 
> What should I do ?

I would trust the C code, keeping the apis the same between the two
types of drivers.  If in the future you want to fix up the api, then fix
both drivers.  Don't try to have unique apis for only Rust drivers if
you can help it at all, that is just going to drive us all crazy over
time.

And really, you might want to fix up the api, that too sounds crazy :)

thanks,

greg k-h


Return-Path: <linux-pm+bounces-20134-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C33E5A06F26
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jan 2025 08:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7188161F21
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jan 2025 07:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52DB214811;
	Thu,  9 Jan 2025 07:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FIOW4Twz"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4548F5E;
	Thu,  9 Jan 2025 07:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736408155; cv=none; b=MFRRg5TzMcTeEruf1kU2xmRjgJxMsko36WJyVw0ryaqxN6Pcwf/fdzlxF+8psZXnZGl1f49Qv7T7fUOselXAwkLs18o+qQMQ50YRa85svK2ozsD/M4Xmk4vE7m6dIAvzCzNdINEpFk2qaYh68LycCrZ/BeH7n+Io8b6ERSWkdv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736408155; c=relaxed/simple;
	bh=DBpGn6Ju2m3/CEGQizrf3gS7wG0QSA07waaOHI1kwsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LPfNMMRUr6nYu2zwQ2+UgCAZbxuQvF9/mUQDiMEeEtBEe4h8kkb+DcAUSxc2cYNVOZZxsCnBhdzfppeNHjNIpgB9uc4jLz2EhrHfmogARDOWTxRz6W6q808GDRP7vn+dsfuyJ+2+tk40JBT1d0zwQOdkSIOKx+sLWkqiQxTcQfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FIOW4Twz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A78BC4CEE2;
	Thu,  9 Jan 2025 07:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736408155;
	bh=DBpGn6Ju2m3/CEGQizrf3gS7wG0QSA07waaOHI1kwsw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FIOW4Twz000n2skjGqi3Zmq3poycLHYovB9005x6OG/Je1vldjdfyNkrbJnt7+pG1
	 BSiQ0sl6DrJhToQ3EibJZAH7z7WZq/uTxqBbG+ZuELDu5Ci65gZv6Pqv1sEm/tr2iU
	 ctMkFw8Pa6U1QEAl4g9CRVUf+cVWVGvfQu+/mOgA=
Date: Thu, 9 Jan 2025 08:35:04 +0100
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
Message-ID: <2025010944-detective-borough-b158@gregkh>
References: <cover.1736248242.git.viresh.kumar@linaro.org>
 <867ba9728179ba21ff8f8aca97d416b72ccd63d9.1736248242.git.viresh.kumar@linaro.org>
 <2025010727-banner-monday-1941@gregkh>
 <20250108111253.tg6ixurijf2dvptx@vireshk-i7>
 <2025010855-cargo-quickness-a08f@gregkh>
 <20250109044117.s5s4dlmssamwicew@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250109044117.s5s4dlmssamwicew@vireshk-i7>

On Thu, Jan 09, 2025 at 10:11:17AM +0530, Viresh Kumar wrote:
> On 08-01-25, 12:50, Greg KH wrote:
> > Odd, why can't Rust also know where CPUFREQ_TABLE_END is?  Why do you
> > have to do extra work here?  That feels wrong.
> 
> Well, it can, sure.
> 
> The freq table the Rust code receives is part of the C code:
> bindings::cpufreq_frequency_table. Since it is a C managed pointer, I thought it
> is better to do the parsing in C code itself. In case the implementation of the
> struct changes in future (unlikely though), we would only need to fix the C code
> and not Rust, which looks to be the right expectation.

Then why not make the C code use this function as well, to keep all
cpufreq drivers from having to manually walk the list and that way both
C and Rust drivers all do the same thing?  That makes more sense to me,
there's no reason you can't change C code today first to make things
more unified, in fact, that's usually a better idea overall anyway.

thanks,

greg k-h


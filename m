Return-Path: <linux-pm+bounces-20037-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7408EA03E75
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2025 13:01:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEC563A1D9C
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2025 12:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01431E9B18;
	Tue,  7 Jan 2025 12:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ne5IqMU7"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AA51EBA19;
	Tue,  7 Jan 2025 12:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736251315; cv=none; b=CXnEXtt8tZDnQEQLBD2g9igR2S/WlupfJXZc+oEcJXNtUG9d6uxd1lEKARuJk0/KlBUxi2t1sJ7MKeRWhS5p+C6PN646xv8iGtmikAxGZ4Mc9eSngHDfP/kTELYQGcrEH5/owiiE2mMOWrvlsSFpCJPo27/nJvaISCwbcRAHv3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736251315; c=relaxed/simple;
	bh=zsNYhuIrZeMO6B4y31HOWq0dqufQl4K91xjNn/P/NR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nFGWgLTSZzvwicuerGQDTy9SQ/fTjASGRg8cfj1JM18E98bOyBxLHlUfuchc0M+6r6Xzdy8DHP8zuHqBZs/kmGEAu1I52SnEqyb5scv1WhyUR2CPFdzFzjZL2643XWNdv3Umz1vpzWv4NPDYtRHqmFcCawldRCkNiA/7BvMS2g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ne5IqMU7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45751C4CED6;
	Tue,  7 Jan 2025 12:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736251314;
	bh=zsNYhuIrZeMO6B4y31HOWq0dqufQl4K91xjNn/P/NR8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ne5IqMU79QiBrkMY/s59DX3E8WWT80BhxWdcjMHlo5/MUmfSNCbf3ULtHyVKQ5iVu
	 r+Zx/ErK82tZgjvXePjlXHSyLlM7wiYtv22+D6j1Z8nZilv8VTmSlgSvgshX1ghZP3
	 VbbayKdbj5RQ2BAoCnru1VDXQ64HqJnR6aKm/jS4=
Date: Tue, 7 Jan 2025 13:01:51 +0100
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
Subject: Re: [PATCH V6 05/15] rust: Add bindings for cpumask
Message-ID: <2025010708-commence-exile-0946@gregkh>
References: <cover.1736248242.git.viresh.kumar@linaro.org>
 <77c33c80f878010b8cf3f8c931c3b6e46397dc34.1736248242.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77c33c80f878010b8cf3f8c931c3b6e46397dc34.1736248242.git.viresh.kumar@linaro.org>

On Tue, Jan 07, 2025 at 04:51:38PM +0530, Viresh Kumar wrote:
> Add basic Rust bindings for `struct cpumask`. Also add few Rust helpers
> for the same.

Shouldn't this be 2 patches?  You know that when you say "also" in a
changelog that's a huge hint for a reviewer to tell you to split it up.
You need to describe _why_ you can't split it up for us to not tell you
to split it up...

greg k-h


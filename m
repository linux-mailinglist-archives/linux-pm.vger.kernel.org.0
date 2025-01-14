Return-Path: <linux-pm+bounces-20434-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB46A11061
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2025 19:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DE9E1673B5
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2025 18:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5CBC1FBCA0;
	Tue, 14 Jan 2025 18:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ziXOa8bP"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844AA1FA24C;
	Tue, 14 Jan 2025 18:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736880169; cv=none; b=p8liM0A0/CZoALwk9pzCh5j7ac2dhnV62jBvq4T+I+VEyZly2jjJ0r2Yaz03Rqi9srhKEhoB28pFNnYpw0HzmRsD9ZIHBmb+8hB+yQNFgKsdlsyqr5CGzoQD44VpIhNL3T2efI3gByq2sHBJm8W+9jFbiB+UHDAoFFgk30t+A6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736880169; c=relaxed/simple;
	bh=nsEgk+tokJmXYdItkxdf6UTu6JJcRQbi4k1mXm6thMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B+sqk2sonmgSMZTGql3JpjUBYSwg4nzm+LNk1ozOWd7YBU5qUEmra7MKiiaWhn7YVLa7VP5dMW+8YHIcaHqMxW+Jw+7c7MagEfVT54cCne+LQqeuYNSEVe3QZCihgY7laV/xhLlfdYRXZydYmSk1KBvFaPtrqqwfJSOGhHLfcNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ziXOa8bP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63017C4CEDD;
	Tue, 14 Jan 2025 18:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736880169;
	bh=nsEgk+tokJmXYdItkxdf6UTu6JJcRQbi4k1mXm6thMY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ziXOa8bPorqXwR+ZlMLffK7JUf1aulQ/HsBKqHwJIO4WQC2PNHBcL+gXkgJJe20Jh
	 GOtlY+9lIYfpfzqWyAvsGDpKR3vPmsmjbd9/+M6ahHu+noLy9qojGDmlruFg+sYAVR
	 aMoJZ+2Jfvo4p2gLPfMHcE+w4EzpDLrf2/7B2XW0=
Date: Tue, 14 Jan 2025 19:42:45 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V7 04/16] rust: device: Add property_present()
Message-ID: <2025011429-gossip-hash-12e3@gregkh>
References: <cover.1736766672.git.viresh.kumar@linaro.org>
 <f43fe3f7b3151a89c261ad728b0f3bb2fc24caef.1736766672.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f43fe3f7b3151a89c261ad728b0f3bb2fc24caef.1736766672.git.viresh.kumar@linaro.org>

On Mon, Jan 13, 2025 at 04:52:59PM +0530, Viresh Kumar wrote:
> This implements Device::property_present(), which calls C APIs
> device_property_present() helper.
> 
> The new helper will be used by Rust based cpufreq drivers.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  rust/bindings/bindings_helper.h | 1 +
>  rust/kernel/device.rs           | 7 +++++++
>  2 files changed, 8 insertions(+)

Want me to take this in my driver-core tree now for 6.14-rc1?

thanks,

greg k-h


Return-Path: <linux-pm+bounces-11163-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF1F932A28
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2024 17:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 295A7288A93
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2024 15:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8825919B3E2;
	Tue, 16 Jul 2024 15:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XwWWMv2W"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8262B9B3;
	Tue, 16 Jul 2024 15:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721142934; cv=none; b=PkXnBuC9cgkBt8wKi2Qi9prV7ODZ16/0Q4Pv0NbgURYNDWMcbEYMdXtR24Szc7A+Y8T2YU4RlacaLAAVNG7ZNNU/WZwB4GE0PQB83ZzFU8xADxWF5di6Z5WjaVndzQ8UR1d7cQIkBQTBsuBmQ/yjJ7AzC15XPXWYHY57kVNnIfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721142934; c=relaxed/simple;
	bh=gH/9v8gdvRPTuEMlos4E4YaZ22thsKhD8PVSvs6RoRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PSYRC80hHQx7AxKOmMNzG9lWzS5WPeTZOcLzdSdUfeWmZN7Em5kN9a6biwGpReA5kqD9hAZAMEnnFCfDz4dUQnShfFCxtMoqzCDvhWRvqvIcjqHH9ZsRvkvvMQMVShmymqyfSMm7u6ymHjcrBa3dC+BjxiNaaotvOopkTiC62WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XwWWMv2W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA084C116B1;
	Tue, 16 Jul 2024 15:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721142933;
	bh=gH/9v8gdvRPTuEMlos4E4YaZ22thsKhD8PVSvs6RoRY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XwWWMv2W964OtTHvFJbs2l54wvapkUOVCVPZCYUMoi6Z3eVz7kmEUwOi1cDGehWOx
	 TzmJ5G4mxSLaw7HfydJ9c9OIaLssAQ6IM9lzNjj2RhXiL2jb04cK8Gu3LI5RMYI9Ns
	 +NrBMobZgoXJQyG0+WxQAcp1rKcGhQx+7soPLpbpWYVot6LX+/P1gwkmYjb+6vF7fd
	 miYJoBGoKFv+3/J61zdZ3DyRn6zssDKbw2ech2dPCGqi1lrIuufs0jdLq0FOK7H1NJ
	 C+R/tNXXuRRrfD2SAnCx9xbWf3BVyEk2taeHBiK2Aqw7F8GbIfY2g+h28RclQOaiJ2
	 4iA1Vx6t1sgKg==
Date: Tue, 16 Jul 2024 17:15:25 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Greg KH <greg@kroah.com>
Cc: Danilo Krummrich <dakr@redhat.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>, linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
	rust-for-linux@vger.kernel.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Erik Schilling <erik.schilling@linaro.org>,
	Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 8/8] cpufreq: Add Rust based cpufreq-dt driver
Message-ID: <ZpaOjcuzBsSx45jE@cassiopeiae>
References: <cover.1720680252.git.viresh.kumar@linaro.org>
 <b1601c1dbdf68a4b812fcfaf73f3b5dea67f2025.1720680252.git.viresh.kumar@linaro.org>
 <Zo-3QIPbhBsv8EjB@pollux>
 <20240711130802.vk7af6zd4um3b2cm@vireshk-i7>
 <Zo_cW57i_GMlmYV-@pollux>
 <2024071122-escargot-treadmill-6e9a@gregkh>
 <ZpAEWAzETnrVI-cs@pollux>
 <2024071111-negotiate-spoof-da94@gregkh>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024071111-negotiate-spoof-da94@gregkh>

On Thu, Jul 11, 2024 at 06:34:22PM +0200, Greg KH wrote:
> On Thu, Jul 11, 2024 at 06:12:08PM +0200, Danilo Krummrich wrote:
> > On Thu, Jul 11, 2024 at 04:37:50PM +0200, Greg KH wrote:
> > > On Thu, Jul 11, 2024 at 03:21:31PM +0200, Danilo Krummrich wrote:
> > > > (2) You require drivers to always implement a "dummy" struct platform_device,
> > > > there is platform_device_register_simple() for that purpose.
> > > 
> > > No, NEVER do that.  platform devices are only for real platform devices,
> > > do not abuse that interface any more than it already is.
> > 
> > I thought we're talking about cases like [1] or [2], but please correct me if
> > those are considered abusing the platform bus as well.
> > 
> > (Those drivers read the CPU OF nodes, instead of OF nodes that represent a
> > separate device.)
> > 
> > [1] https://elixir.bootlin.com/linux/latest/source/drivers/cpuidle/cpuidle-riscv-sbi.c#L586
> > [2] https://elixir.bootlin.com/linux/latest/source/drivers/cpuidle/cpuidle-psci.c#L441
> 
> Yes, these are abuses of that and should be virtual devices as they have
> nothing to do with the platform bus.

For those drivers, wouldn't it be better if proper devices would be derived from
the CPU OF nodes directly? This seems to be a common problem for cpuidle and
cpufreq drivers.

But it's quite a while ago I dealt with such drivers, maybe there are reasons
not to do so.

Anyway, using a virtual device for those seems a bit wrong to me.

- Danilo


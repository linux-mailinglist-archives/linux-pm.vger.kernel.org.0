Return-Path: <linux-pm+bounces-11005-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DC692EDA7
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jul 2024 19:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B61741F21301
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jul 2024 17:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1FB16D9BC;
	Thu, 11 Jul 2024 17:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="Vm6t+SFa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WG6FlA6U"
X-Original-To: linux-pm@vger.kernel.org
Received: from flow2-smtp.messagingengine.com (flow2-smtp.messagingengine.com [103.168.172.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAD9167265;
	Thu, 11 Jul 2024 17:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720718526; cv=none; b=KoXw2aJifDGrqAow42BgGvEeKJw+7ANldseAr9goMfdut1xATacNf3KxeGqdcrMZMv6zJcxb55TcJxQdY7zK7xhmRJoYq3QGyg+i1CBfk0GJX/5HqUX3eZ+jA6F3d18ggnnfiNf3/Bfi92+aM//ku/COC2eNoROJZ3x3TNIwKco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720718526; c=relaxed/simple;
	bh=3YPwM7RDd7/HErP3XW+kAuPBDMV7OW2l4AV9nh/KpEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kO9f9gvvGFEMR0L5Y+RDPCtsZEsO3BGGZ43CYqQVkJg09RkKeDHmaTHuCMH4ASRKXORzLX34jgZMUCsTGtsf0IoGCR9wvC1+ldSGgeyhOjdwbZqLLm0Vhjh6tOMVLREnebwi0WsqkCdMBf7IjQH5PU6/BFdBCedZh2uI6KHkXSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=Vm6t+SFa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WG6FlA6U; arc=none smtp.client-ip=103.168.172.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailflow.nyi.internal (Postfix) with ESMTP id 5F9092002F5;
	Thu, 11 Jul 2024 13:22:03 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 11 Jul 2024 13:22:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1720718523; x=1720725723; bh=AfoFZVQn+G
	goSzyYivpJuC8uKlNgMsqCc0W2hNrIQ7o=; b=Vm6t+SFaVOxDt/l5jp4yrFyvvz
	OfvvsGmvOWJ8+0JFLIU/jJDyDe6BTm6O7FqVR+vEO2O7DFLvJddeBxGX2ZwOWD82
	uxVYLAIjgr5JzmECBSv1pvpfT2tbr3mgzAT65qwrR37nJda/CuIiww2p/Ay5YHOF
	DHk66pkueRdL7YI9Rw1pacm8FSTDvI4gwKdElTHEnYQ/Zpif2tU2GhH45KrqSbsb
	vYQvpaki5eMRMmPRj3KJGWKTmVvs317wDsBnw5B9Sv3goim2kFsNifhE0LESwhiT
	1XBXoYeXy1hZkuk4tJbQXUeQXQkOEQbuf9n7TOnwTgNdpsK5asX8FNFaxKsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1720718523; x=1720725723; bh=AfoFZVQn+GgoSzyYivpJuC8uKlNg
	MsqCc0W2hNrIQ7o=; b=WG6FlA6U1NDUoVIQE/s+fUyOgPIjd1yuDSYKUahiULm9
	cdEph+IeZnfLlMCzfg6lipTzbvTr8PAXycxkW9E5b/ueQTUdeYc2bRLoitGo4x9r
	1Q6L5NHNFU4PmFvoODwF/ckeAPRHAxQ76lcdmRWFZS2P8JM9X3ig1n4nUN5icS6p
	DpIyQ1BlExQtQO2h52pGNA9Fxs+R1CnDNaZyNTRdxKyQLahgEwFJMGb1kE1riDSo
	xxGibvSH7L76tswZR+y1peIhZqyEREo2y8GcxwomYLXZsPiasNlrYgIxCacxjJGW
	/WHKVt7CPFCGIIOcdwO4zLWNTRJAMYRmpBHYSLX1AQ==
X-ME-Sender: <xms:uhSQZu9xahnQGmL4rLrRrP-Q0oAfs4OJgNC-ks-bELTBV738W3x1og>
    <xme:uhSQZutY-Qb1TiDP2civUYP-aL0aALfQlFsCUOwMpJkqHCQNrdZ1cQ3kfRcjXlLXg
    SfAOgjXsFlWUQ>
X-ME-Received: <xmr:uhSQZkBWErjbOlp6eMbWR7vP1ClcT0sAiUrNKrHSdb96y9ztP3uJLy98o0iUf_k_6YmgtZRdAfg2Oj46t8-dnJZxlvzc063kVKrPJQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrfeeggdduuddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepfeevie
    ffgeeuffeikeejvdegtefhuddvjeelgfevtedtgfegieegleefudeljeeknecuffhomhgr
    ihhnpegsohhothhlihhnrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:uhSQZmelLyFx92AgwUQt9YPaNn7uvhIZZEW6nlwKlHnO58Q-J3r6mg>
    <xmx:uhSQZjO7G_lQ7ijXzhqUgJlCf3ZxuY6mysp_6hQ3v6F4gN3_Ir-pQQ>
    <xmx:uhSQZgkj6UhmleoaTteksb4pxXfP5QWdc-SXOpY9nfY5hr94TGiziw>
    <xmx:uhSQZluSpw3OleWc2pK5_FNJC-4zXguFsWwN5oE1A6IgdvCRnoHV9w>
    <xmx:uxSQZq76asPjEG339KhSUNluF63ntuJDLhnlV_Qlpi23XYUE3XzLAZT3>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jul 2024 13:22:01 -0400 (EDT)
Date: Thu, 11 Jul 2024 19:21:59 +0200
From: Greg KH <greg@kroah.com>
To: Danilo Krummrich <dakr@redhat.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
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
Message-ID: <2024071106-handed-oversleep-2377@gregkh>
References: <cover.1720680252.git.viresh.kumar@linaro.org>
 <b1601c1dbdf68a4b812fcfaf73f3b5dea67f2025.1720680252.git.viresh.kumar@linaro.org>
 <Zo-3QIPbhBsv8EjB@pollux>
 <20240711130802.vk7af6zd4um3b2cm@vireshk-i7>
 <Zo_cW57i_GMlmYV-@pollux>
 <2024071122-escargot-treadmill-6e9a@gregkh>
 <ZpAEWAzETnrVI-cs@pollux>
 <2024071111-negotiate-spoof-da94@gregkh>
 <2024071149-pork-vacancy-14b8@gregkh>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024071149-pork-vacancy-14b8@gregkh>

On Thu, Jul 11, 2024 at 06:41:29PM +0200, Greg KH wrote:
> On Thu, Jul 11, 2024 at 06:34:22PM +0200, Greg KH wrote:
> > On Thu, Jul 11, 2024 at 06:12:08PM +0200, Danilo Krummrich wrote:
> > > On Thu, Jul 11, 2024 at 04:37:50PM +0200, Greg KH wrote:
> > > > On Thu, Jul 11, 2024 at 03:21:31PM +0200, Danilo Krummrich wrote:
> > > > > (2) You require drivers to always implement a "dummy" struct platform_device,
> > > > > there is platform_device_register_simple() for that purpose.
> > > > 
> > > > No, NEVER do that.  platform devices are only for real platform devices,
> > > > do not abuse that interface any more than it already is.
> > > 
> > > I thought we're talking about cases like [1] or [2], but please correct me if
> > > those are considered abusing the platform bus as well.
> > > 
> > > (Those drivers read the CPU OF nodes, instead of OF nodes that represent a
> > > separate device.)
> > > 
> > > [1] https://elixir.bootlin.com/linux/latest/source/drivers/cpuidle/cpuidle-riscv-sbi.c#L586
> > > [2] https://elixir.bootlin.com/linux/latest/source/drivers/cpuidle/cpuidle-psci.c#L441
> > 
> > Yes, these are abuses of that and should be virtual devices as they have
> > nothing to do with the platform bus.
> > 
> > > > > I think (2) is the preferred option.
> > > > 
> > > > No, not at all, sorry.
> > > > 
> > > > Use a real device, you have one somewhere that relates to this hardware,
> > > > otherwise you aren't controlling anything and then you can use a virtual
> > > > device.
> > > 
> > > Of course we should stick to a real device if there is one, I didn't meant to
> > > say anything else.
> > > 
> > > But since it came up now, some virtual drivers still require a parent device.
> > 
> > Great, use the default one that the kernel gives you :)
> > 
> > > For instance, in DRM we have vGEM [3] and vKMS [4], that use
> > > platform_device_register_simple() for this purpose.
> > 
> > Again, abuse, please do not do so.
> > 
> > > What should they use instead? I'm happy to fix things up if required.
> > > 
> > > [3] https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/vgem/vgem_drv.c
> > > [4] https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/vkms/vkms_drv.c
> > 
> > Use the virtual device interface please, that's what it is there for.
> 
> To be specific, look at the devices in /sys/devices/virtual/ that's
> where yours should be showing up in, not in the root of /sys/devices/
> like they are by creating a "fake" platform device at the root of the
> device tree.

Ok, at first glance this seems a little bit more complex than what the
platform api gives you, let me knock something up next week during the
merge window to make this more simple and then let some interns at it to
sweep the kernel tree and fix up this proliferation of platform device
abuse.

thanks,

greg k-h


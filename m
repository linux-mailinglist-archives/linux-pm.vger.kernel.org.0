Return-Path: <linux-pm+bounces-11004-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B32FD92ECF1
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jul 2024 18:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DF3BB20DEE
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jul 2024 16:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EABC116D32E;
	Thu, 11 Jul 2024 16:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="akO2jVyU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="phfrcK6o"
X-Original-To: linux-pm@vger.kernel.org
Received: from flow2-smtp.messagingengine.com (flow2-smtp.messagingengine.com [103.168.172.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A69E168C33;
	Thu, 11 Jul 2024 16:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720716095; cv=none; b=ZO6RvQAdPM2J9JA9kEQD31C4z2ln3OVIwKVMF8jHgRI/duXbr6vKPoZhmYu5VXJTUdRI6mCHSRgEgbpbMxAzKjM3SAxEHRSPrd/wiUkuRyO9pCNGCVETPa/sIoq25UVwkFQYSWrk7cTyx5nWKtZm9D58nAkzLPvm9Ox98zeWaCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720716095; c=relaxed/simple;
	bh=tDqdcDWXrpCwWTZEqSwd8VgkYmzLxNDT37XLo8t+J5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HlclHzbW5VqtNGVjS0T7ZctjCttgtSMwqicemdGm4cb/F5rfIQ+ICrzvmVTOwSQKG9u1RTlWUf+UhEa4lk4HcFBe20xJG5LETZx5qLv4i5SDTCGHVCTb59bU5o4Px/4oZf3NEV/j/vAJN82DjacS1GrNiQ+0EdWowNJLHnT1alY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=akO2jVyU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=phfrcK6o; arc=none smtp.client-ip=103.168.172.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailflow.nyi.internal (Postfix) with ESMTP id 506EB2002B4;
	Thu, 11 Jul 2024 12:41:33 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 11 Jul 2024 12:41:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1720716093; x=1720723293; bh=bxHtNbtSOk
	tEbEbZwrzKM3xZfsODZZ68qK2AmiqPvE4=; b=akO2jVyU0BK28NdbEOxaFywOiv
	3z9rJztbkejUoSHItaz9JluRKBrNKwEDN+YXoyyIHPtuOG4VJz7bkPaulUnmPPZE
	PSZW8W3k4zoS4dPaSaX5kqWXaDIKLCMIeprPzh1BRFlfIuSH+34W38xYusp/7QHZ
	VCPmE7OCauIo5paGFcxKjpff3eyKUIr8mZmtu1Se4C/bZVzkLdXlVviMCHVbajSz
	+NHm+Qv+KFdFQCr0UeyEbaMKmoni8xU49cTrt7AgleI6P7NamcedlbOUg16FnXEH
	OBO9BqvfyFFKFFY2mWlzjTVr+3rBkPRY1kVKvNUGQFuBJEfYIUEG5PgSMEDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1720716093; x=1720723293; bh=bxHtNbtSOktEbEbZwrzKM3xZfsOD
	ZZ68qK2AmiqPvE4=; b=phfrcK6ozjfTJVxbh72Qw0R6GM6oM8Ttx514GCmbeLc9
	LWnMf8MW4UjxnTFWMLmwso5hyMlanl3g/FBpz9POj9PCCxpvFC7/v91QoXGprpoB
	HxSOHRmnlAMesrXg60C99wJW5BYpItodb7wR04r/vD4bwuQVCxdA/2YVPexIrcPG
	vKFfCd4dEyGYGLR5cqrGe76J64UX3eVa5fpqVqQc938YjVbjhefMjqkM81aieFXX
	C8idq/xgjErOLKFlTk9AEluWmdw+YH6jO6r29CmpdRtRMAai4fWus5JYOQWChjNm
	4duHrHmZw2X5auG1ZAur+/mMTXqWZO2U9bXQl8xHEA==
X-ME-Sender: <xms:OwuQZixgVe5jHiZL08M3n-66QOWWSZH-dvQcVA2iW6TdDdHqrKtwlg>
    <xme:OwuQZuSWR0eZSXvJBr9MI03PHKasYOcqsuBD51-LeUaBZby3X-EBH7oDN6K_jxkTT
    2Iu5WipcI4oJA>
X-ME-Received: <xmr:OwuQZkVvnHTSvt0-0D8rRJTjI4XxPjQPNDreTJqwQB42vepsLXk7Eq0EuzjjAdLzkiJpkmHC38XcFpTzz2-J8xMEZWTdPkgjMoKxEg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrfeeggddutdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepfeevie
    ffgeeuffeikeejvdegtefhuddvjeelgfevtedtgfegieegleefudeljeeknecuffhomhgr
    ihhnpegsohhothhlihhnrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:OwuQZojKEuH3rruL99LIHKJxIyCsb3QE7XYnX_8EWn9trZa2HjBu3g>
    <xmx:OwuQZkAwmphBxP06htDJyFeH9I8QUhbHsv6gZwKaPHFbeQoWQQHAYA>
    <xmx:OwuQZpKn5vz-4otwsVeqKHGw8b87mSh7XwcT2s8vdFeuprM_J3I2FA>
    <xmx:OwuQZrAW-HET_Jurh52ExnrLK-M55psKvc946xt6gkGZZeUjJuU9Zw>
    <xmx:PQuQZp-rib06s04p35kOUgTHK8oMsn96WTadLzxlp93_bQ6tkX2RJuq8>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jul 2024 12:41:30 -0400 (EDT)
Date: Thu, 11 Jul 2024 18:41:29 +0200
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
Message-ID: <2024071149-pork-vacancy-14b8@gregkh>
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
> 
> > > > I think (2) is the preferred option.
> > > 
> > > No, not at all, sorry.
> > > 
> > > Use a real device, you have one somewhere that relates to this hardware,
> > > otherwise you aren't controlling anything and then you can use a virtual
> > > device.
> > 
> > Of course we should stick to a real device if there is one, I didn't meant to
> > say anything else.
> > 
> > But since it came up now, some virtual drivers still require a parent device.
> 
> Great, use the default one that the kernel gives you :)
> 
> > For instance, in DRM we have vGEM [3] and vKMS [4], that use
> > platform_device_register_simple() for this purpose.
> 
> Again, abuse, please do not do so.
> 
> > What should they use instead? I'm happy to fix things up if required.
> > 
> > [3] https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/vgem/vgem_drv.c
> > [4] https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/vkms/vkms_drv.c
> 
> Use the virtual device interface please, that's what it is there for.

To be specific, look at the devices in /sys/devices/virtual/ that's
where yours should be showing up in, not in the root of /sys/devices/
like they are by creating a "fake" platform device at the root of the
device tree.

thanks,

greg k-h


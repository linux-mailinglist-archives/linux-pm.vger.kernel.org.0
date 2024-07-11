Return-Path: <linux-pm+bounces-11003-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1740B92ECCF
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jul 2024 18:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72085B215E8
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jul 2024 16:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB1A16CD1B;
	Thu, 11 Jul 2024 16:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="kthwHN0P";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FP/YKxpu"
X-Original-To: linux-pm@vger.kernel.org
Received: from flow2-smtp.messagingengine.com (flow2-smtp.messagingengine.com [103.168.172.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3645916B752;
	Thu, 11 Jul 2024 16:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720715670; cv=none; b=Nzg2DmncZZG3jreyi0hEEZI521rKoCIi+jpuOst3606qyw7wY0hcQQNwTBEbWbyIJET16gOzs44idjPzd4M++zFQGy20usun1/YknLXXc5cYOFQx/GOOBUlBAyUeGmguJMKPZz3SfC5wx43UPH8CLZ/Juw5BVLYFH2z/Z84kCTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720715670; c=relaxed/simple;
	bh=smbShI+Lu4YENO9SclMUBSefMZDkT3jPuDhhU7gUJWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mLr7C0y5Wkzm5Drh5INl5Jy3XvAewXqxjtxgRjnXsC+k8WKJhCyOuKGWaIfpZM73a0X84YrJ/ZkoFmARH9j+36BWQCRgg4UixbaF8aUnmkjyMNzBHro2Z25QHaSZr+X69/muGmm1feXo5Ddb0suqMcykKzETwVWQFdw7UQ+m5sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=kthwHN0P; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FP/YKxpu; arc=none smtp.client-ip=103.168.172.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailflow.nyi.internal (Postfix) with ESMTP id 1EEF3200536;
	Thu, 11 Jul 2024 12:34:27 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 11 Jul 2024 12:34:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1720715667; x=1720722867; bh=fbai7xo9jC
	lg1MHdg/OPKg9usQQpTGfdoSS4TcKGfBY=; b=kthwHN0Pw8ta9M8XfrzzYaMkOE
	nTMTLOFla7IlMY1bMugg8KvPzldNQ7Tnw6n4HOxz+ZQXwZ+MASmF6uSiCuF0g286
	sGB+NP/a84rMorwQdvbg2jECdznuve0OOvAIv1od7SevzOg8RQJ9jXasW/EgBYw1
	ofeABA8+Jp36LkgIxqWxoFcCMfC1u7TT55DzWK2RmM8InaZ8H7TgpOR2TLgyTQOg
	UldD73Q6JJKwYO7NHgwyh0iG+vCbEsD2AJV50VBglF1v8FlgzwSS/V53hmitmEQX
	/+gNlprpFKkQjEnji2Y+eQInsU0jRBy+ut9kdmoXE8A9e+vILCF/Wz0X5myg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1720715667; x=1720722867; bh=fbai7xo9jClg1MHdg/OPKg9usQQp
	TGfdoSS4TcKGfBY=; b=FP/YKxpuBxO3Q5JpYLxvf6W2QplUNhPoeylSRgX4AIhJ
	vXXmncQzUUHeHPhN2Yk/2SzWCXySwZ52QPbqmx7kZ2lTDVc+R/p7sawmY4feKpXt
	Cy1LdFsRqSaY8OZyoPT4swTAFZ6og/m/m1tjW6O/BZMaCszxagwCDvmUor16+CwL
	00z3Mpl0Bd/Samh6DyUlBXolQr1JooXLLQaJj9O8hO2CIpdlGD5HPWIE/2aPsKxh
	N/YUSzKSdgk1zpkkgJGKU8q9RRIzjkAon9QeoynvpqtOQ9RrBf+Oa2gNi/RifFHd
	uWZDgpZGeL2cOpaBnAsQn/pSEChFpp9PI0rionksUw==
X-ME-Sender: <xms:kQmQZgEEavpCdLB7hI49ebZCsGi28Ts4Yib--CCnMPD3mxpqUw39rg>
    <xme:kQmQZpW2nrWtc3VXpi1hSbxhGz2lGvMxUQBSyTkV6g28DPCOExr6BFdhj_87WbyVy
    JrwUNqbpUm8tw>
X-ME-Received: <xmr:kQmQZqLzWWtC3-eXkW5h-ZoMjuDk_wBfVAR-CrXWxGg9rvCCjcQeisjtA95xNwqZv54oGSOaFSJSpYi2_FvDJ-qnUYpQYEc860xZnQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrfeeggddutdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepfeevie
    ffgeeuffeikeejvdegtefhuddvjeelgfevtedtgfegieegleefudeljeeknecuffhomhgr
    ihhnpegsohhothhlihhnrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:kQmQZiG0a-Bb8hBPrZBDJnpY9RSTFjQ7QzTlGXUPTD_OqIyTgA00mg>
    <xmx:kQmQZmUcYTrdyCbCsJIer9x-v2w6PLQ5WJ50C7JuC8Gqjd2OvZcZIA>
    <xmx:kQmQZlNx3l59JZsHM4tdMFUTjKWw3Na1PlLw2kIgU4CBbVXJJcwJMg>
    <xmx:kQmQZt1jqCP92pzmL5Ve3ng2xO9BftMpBWZ1zAtAJVpMAc0NlAiJQw>
    <xmx:kwmQZog6sCMXz6XxCiZeva0w0QpCygeOJcM2UlqG4vOnY2-R38E7gqLW>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jul 2024 12:34:24 -0400 (EDT)
Date: Thu, 11 Jul 2024 18:34:22 +0200
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
Message-ID: <2024071111-negotiate-spoof-da94@gregkh>
References: <cover.1720680252.git.viresh.kumar@linaro.org>
 <b1601c1dbdf68a4b812fcfaf73f3b5dea67f2025.1720680252.git.viresh.kumar@linaro.org>
 <Zo-3QIPbhBsv8EjB@pollux>
 <20240711130802.vk7af6zd4um3b2cm@vireshk-i7>
 <Zo_cW57i_GMlmYV-@pollux>
 <2024071122-escargot-treadmill-6e9a@gregkh>
 <ZpAEWAzETnrVI-cs@pollux>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZpAEWAzETnrVI-cs@pollux>

On Thu, Jul 11, 2024 at 06:12:08PM +0200, Danilo Krummrich wrote:
> On Thu, Jul 11, 2024 at 04:37:50PM +0200, Greg KH wrote:
> > On Thu, Jul 11, 2024 at 03:21:31PM +0200, Danilo Krummrich wrote:
> > > (2) You require drivers to always implement a "dummy" struct platform_device,
> > > there is platform_device_register_simple() for that purpose.
> > 
> > No, NEVER do that.  platform devices are only for real platform devices,
> > do not abuse that interface any more than it already is.
> 
> I thought we're talking about cases like [1] or [2], but please correct me if
> those are considered abusing the platform bus as well.
> 
> (Those drivers read the CPU OF nodes, instead of OF nodes that represent a
> separate device.)
> 
> [1] https://elixir.bootlin.com/linux/latest/source/drivers/cpuidle/cpuidle-riscv-sbi.c#L586
> [2] https://elixir.bootlin.com/linux/latest/source/drivers/cpuidle/cpuidle-psci.c#L441

Yes, these are abuses of that and should be virtual devices as they have
nothing to do with the platform bus.

> > > I think (2) is the preferred option.
> > 
> > No, not at all, sorry.
> > 
> > Use a real device, you have one somewhere that relates to this hardware,
> > otherwise you aren't controlling anything and then you can use a virtual
> > device.
> 
> Of course we should stick to a real device if there is one, I didn't meant to
> say anything else.
> 
> But since it came up now, some virtual drivers still require a parent device.

Great, use the default one that the kernel gives you :)

> For instance, in DRM we have vGEM [3] and vKMS [4], that use
> platform_device_register_simple() for this purpose.

Again, abuse, please do not do so.

> What should they use instead? I'm happy to fix things up if required.
> 
> [3] https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/vgem/vgem_drv.c
> [4] https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/vkms/vkms_drv.c

Use the virtual device interface please, that's what it is there for.

thanks,

greg k-h


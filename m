Return-Path: <linux-pm+bounces-11165-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66915932A59
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2024 17:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 834CB1C209BB
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2024 15:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB7119DF94;
	Tue, 16 Jul 2024 15:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="WQdNxQcM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UQMmol42"
X-Original-To: linux-pm@vger.kernel.org
Received: from flow6-smtp.messagingengine.com (flow6-smtp.messagingengine.com [103.168.172.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDF1198E80;
	Tue, 16 Jul 2024 15:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721143327; cv=none; b=BLa1HhrOe28U6GFM2VU6lnsV9ID1RfWYGeITZuD8t/qaydYlm36pQMHmE0fpsuaH1GA+ot2Ei+bFKzj75iMUMT4g3uELUTWxZ6V2pvKoD7FrjXlRL3cbQwdQlTQQd/wHXstyCijMU2cPei/gOZeDcgVQJT7XaT9pwbHbs0U53XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721143327; c=relaxed/simple;
	bh=iflZb5RJ82IVTf+RePxhBB5CWnifETNSZ+jCwTXnTkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qELdjdjGgdzeH1QFzkc0C5tL7ArQV8besHHsb5Nm7iqg4GY89Ih2Ul7DwQMdDflpdm3skMLeFCsJEfLvFjlgsB0pzm4+KlayvwSe+bCSpsFMDzbQ7073dGY4IsOQmt41ide+Vds/AcwmJAXs9/2jqiyaQBPplSlPWjttjqQmdFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=WQdNxQcM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UQMmol42; arc=none smtp.client-ip=103.168.172.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailflow.nyi.internal (Postfix) with ESMTP id 3B7B0201163;
	Tue, 16 Jul 2024 11:22:05 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 16 Jul 2024 11:22:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1721143325; x=1721150525; bh=G/aRAQbcVS
	QoKuub/bUtZMcNuVO9w8vzE4Ki+D+SaYg=; b=WQdNxQcMsZWx2NpeSZTDVq3ciN
	4FGdp3YjmrUEN84us6Y540c0d+XKxmPX32azXbnGNUL/l60B4LAy7D3MJmffxVEg
	QTJJsmscD7r0wzBdoHQwFraukwRzd92gG0z6ySl/XhWyQhGHPYFrEzwpQkF9cuni
	FuL+sMTpo5fCbwfRGaET9UIdQSlPk1OR/kl9ACkPkNkGypumlcSt0T0MoCWzCiBp
	2bGloPZvsaHk5n+C2Blx/4iLSAV9qGg2BtlsN1YLnZtHcZiKPT24nof9RO34KRw1
	OjVSBURMi0WsQ7EFN9QCEsXsX1jEaS2ijCq3fKDdP8dwoFKu3Wz7UtetR1Og==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1721143325; x=1721150525; bh=G/aRAQbcVSQoKuub/bUtZMcNuVO9
	w8vzE4Ki+D+SaYg=; b=UQMmol421ef/5NhJnTP7OTk+3p1wzZtYsHxReNwI6QNC
	0qQRupNdUdzWtzXj5706H0oUKSpB5p6l2TCw1It0dGgnXe3gk8Xtn+fH9Zljk4MW
	MPvZLoRe8wj9MhgBCKsOMJwbXu2z9lN9by7WRqhJl5FLg/WHDaURl/rSrh3b/ph5
	TrB+3eCx5SjmWiEaKI9FHnEQNezjzkzhWgPOX4ERILjiqiFCrfHXguzke6efX6Ki
	DniWggxXfqhFYwyIzTJRonp/X/p3gwpPs9BzOylijClvcGozCubX33oQNFIz1HP5
	Bmsld1n1Ep58OwxbHOCXnzCAyfVphQyC6h0sCeJDhg==
X-ME-Sender: <xms:G5CWZvehRM6Gjkf0yGmi-h5CaODDGfpCj-InflVlClwZbK6txCTZ2w>
    <xme:G5CWZlP8ZkYcZ2_-kLmrQsW_JYOXyVJv1qKSVVKOd6bUtc3XALI5Itt5RJyVkwM3r
    Ehyfnpx-ShAnA>
X-ME-Received: <xmr:G5CWZohZcA4CPz66MxF9TDLmLqhEY-kvaHQIrq9txmbo_BJEJJB3EgnphtvdmsoBU-E1Z5ODCSVH51d-uvTJzIAS4X-C6pFMzCXIdw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrgeeggdekiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeefveeiff
    egueffieekjedvgeethfduvdejlefgveettdfggeeigeelfeduleejkeenucffohhmrghi
    nhepsghoohhtlhhinhdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:G5CWZg-7idQKH2Qtn_CniuwE7XKI0KI2JgRjLNUqbk_Hfko2GIudrA>
    <xmx:G5CWZrvjy-zy2-tHveAW8ISDf0e94dIx0Dx5PcJl8_2uYPyS0QLRVA>
    <xmx:G5CWZvGUtJylgaGn-hGM5BIGHpZgloxtgZa462UR0eMW05rkPCCXrg>
    <xmx:G5CWZiOCfbV3X4ZSUqFRF6hKTXd38ZVvyyixTjKLSLKYgS9HV4zuvQ>
    <xmx:HZCWZjmh2EKxhMOKsFHSGu_7ZVCS700Q25mtd15CI6efFDAPe1EVSu-4>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Jul 2024 11:22:03 -0400 (EDT)
Date: Tue, 16 Jul 2024 17:22:01 +0200
From: Greg KH <greg@kroah.com>
To: Danilo Krummrich <dakr@kernel.org>
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
Message-ID: <2024071639-scorecard-astonish-673c@gregkh>
References: <cover.1720680252.git.viresh.kumar@linaro.org>
 <b1601c1dbdf68a4b812fcfaf73f3b5dea67f2025.1720680252.git.viresh.kumar@linaro.org>
 <Zo-3QIPbhBsv8EjB@pollux>
 <20240711130802.vk7af6zd4um3b2cm@vireshk-i7>
 <Zo_cW57i_GMlmYV-@pollux>
 <2024071122-escargot-treadmill-6e9a@gregkh>
 <ZpAEWAzETnrVI-cs@pollux>
 <2024071111-negotiate-spoof-da94@gregkh>
 <ZpaOjcuzBsSx45jE@cassiopeiae>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZpaOjcuzBsSx45jE@cassiopeiae>

On Tue, Jul 16, 2024 at 05:15:25PM +0200, Danilo Krummrich wrote:
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
> 
> For those drivers, wouldn't it be better if proper devices would be derived from
> the CPU OF nodes directly? This seems to be a common problem for cpuidle and
> cpufreq drivers.

Yes they should.

> But it's quite a while ago I dealt with such drivers, maybe there are reasons
> not to do so.

I think people just got lazy :)

thanks,

greg k-h


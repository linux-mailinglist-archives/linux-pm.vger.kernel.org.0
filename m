Return-Path: <linux-pm+bounces-11168-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA0A932C46
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2024 17:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 907601F23914
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2024 15:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F71519E7C8;
	Tue, 16 Jul 2024 15:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lt+G87j8"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A4119DF71;
	Tue, 16 Jul 2024 15:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721145212; cv=none; b=Qjve8x1LLu1EnRPwIX1NACWz9yMaRrLQl2CFNjJXXQN3yK+5Mf2FuSsqD0pIHveiRCGZNUzAFt9AUThVf15kzH/vUKMM1IZnA28wbXc8C4Aq9bktSWz8c3o2ua3WIa63dgfAbuHONpg/O50eEksYtYCXJF6X9AapTT7dhxFVDhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721145212; c=relaxed/simple;
	bh=NapcGVu3ebh4wbrpwHvy8riUZ9588UV13JcvKCyRbEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i6guZM6icRkNU4fhflxppW5v7LGcmK76uwzw3vXv6KhW1Gr38rrrDLOSr1XdZoUyg6D/MlwEA1x3a45XfA3mQFl7Wf7nnXIAt50LTaIuOWPj1HdS83oPJYrsQy5z5gbT37Er1jM3ymPla7skhjH92a7iMNdmUC/RTchfeuEToWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lt+G87j8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 168A3C4AF15;
	Tue, 16 Jul 2024 15:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721145211;
	bh=NapcGVu3ebh4wbrpwHvy8riUZ9588UV13JcvKCyRbEY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lt+G87j8jj5fWy6TvBjUHHXmcYJsU0Q7f7C58bNevm5L9SAjASFXWcyviB9iRYJIr
	 nNDrKJQzc62Mrz0lmy8h2Ld+C6uhlMfI3II9Wd8kr10j0Icxj7qcYUkyo21OzCkb+W
	 wBsjdOcxDTFhmNFDwjPaqtOCLvJzmfpV+GKn5ba8z8SfQDm8ZQiEb2+kGtLHdySshL
	 iQYrh95Ha8Q8niJsZgOJ3eSH0VsvsPuiEKp4SkHxYNqb/AQoQqWwoyvLE0GlQMJSSD
	 QjC/1H373ySYfwKnEeGLVrb4aV+4xEtU1A1DdMdKbgCoXd/rGJoEDyWQ7tSGHihcOi
	 iO0/2h5y+Ml7g==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52e9b9fb3dcso6960200e87.1;
        Tue, 16 Jul 2024 08:53:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUUIxrTZIaaikPyZXVPIfSiRszBFIUxV4d1JU7goj0O9GzpV2Q3KDiLQG9uBRb9TLZwfLnddQtBowd797OF1ZFY4JIBGhbGMOz64kBrvOm2easoc8+X3HhhsIKS31pfxfNvZutyuFyeqAJz1IsdBV78nAyYslRFuAva+6f1cVCbe81jQ8g+kg==
X-Gm-Message-State: AOJu0YwAlbo53xsf56hitxCPZUHegYyJl/qvpEXUjeLt1tGuhKK3I0gu
	gwoQOIB6/48U3YWcfFtLzotpfdFZsCphZwen1MVScUnXSfxCMuPct4GfWZSfbmannsnOMrIL9JP
	1Bqyo1FemWTLtffbJ2NOJUh5qXw==
X-Google-Smtp-Source: AGHT+IGTJMcRM8kxW1+ZS/5lOj4AJ3SyVQ9imVJGd2P0Afk+zy49hNS4yPITXIgsaX9V4PyOh9C/b7BDdC0G5/cfVq8=
X-Received: by 2002:a05:6512:10d5:b0:52c:892e:2b26 with SMTP id
 2adb3069b0e04-52edf0181d8mr1804902e87.2.1721145209308; Tue, 16 Jul 2024
 08:53:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1720680252.git.viresh.kumar@linaro.org> <b1601c1dbdf68a4b812fcfaf73f3b5dea67f2025.1720680252.git.viresh.kumar@linaro.org>
 <Zo-3QIPbhBsv8EjB@pollux> <20240711130802.vk7af6zd4um3b2cm@vireshk-i7>
 <Zo_cW57i_GMlmYV-@pollux> <2024071122-escargot-treadmill-6e9a@gregkh>
 <ZpAEWAzETnrVI-cs@pollux> <2024071111-negotiate-spoof-da94@gregkh>
 <ZpaOjcuzBsSx45jE@cassiopeiae> <2024071639-scorecard-astonish-673c@gregkh>
In-Reply-To: <2024071639-scorecard-astonish-673c@gregkh>
From: Rob Herring <robh@kernel.org>
Date: Tue, 16 Jul 2024 09:53:15 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+OHqoo9Lxpw5GE0315dmjQPvRo60=PsJXCx=heOfmBNw@mail.gmail.com>
Message-ID: <CAL_Jsq+OHqoo9Lxpw5GE0315dmjQPvRo60=PsJXCx=heOfmBNw@mail.gmail.com>
Subject: Re: [PATCH V4 8/8] cpufreq: Add Rust based cpufreq-dt driver
To: Greg KH <greg@kroah.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Danilo Krummrich <dakr@redhat.com>, 
	Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, linux-pm@vger.kernel.org, 
	Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@kernel.org>, 
	Nishanth Menon <nm@ti.com>, rust-for-linux@vger.kernel.org, 
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, Erik Schilling <erik.schilling@linaro.org>, 
	=?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
	Joakim Bech <joakim.bech@linaro.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2024 at 9:22=E2=80=AFAM Greg KH <greg@kroah.com> wrote:
>
> On Tue, Jul 16, 2024 at 05:15:25PM +0200, Danilo Krummrich wrote:
> > On Thu, Jul 11, 2024 at 06:34:22PM +0200, Greg KH wrote:
> > > On Thu, Jul 11, 2024 at 06:12:08PM +0200, Danilo Krummrich wrote:
> > > > On Thu, Jul 11, 2024 at 04:37:50PM +0200, Greg KH wrote:
> > > > > On Thu, Jul 11, 2024 at 03:21:31PM +0200, Danilo Krummrich wrote:
> > > > > > (2) You require drivers to always implement a "dummy" struct pl=
atform_device,
> > > > > > there is platform_device_register_simple() for that purpose.
> > > > >
> > > > > No, NEVER do that.  platform devices are only for real platform d=
evices,
> > > > > do not abuse that interface any more than it already is.
> > > >
> > > > I thought we're talking about cases like [1] or [2], but please cor=
rect me if
> > > > those are considered abusing the platform bus as well.
> > > >
> > > > (Those drivers read the CPU OF nodes, instead of OF nodes that repr=
esent a
> > > > separate device.)
> > > >
> > > > [1] https://elixir.bootlin.com/linux/latest/source/drivers/cpuidle/=
cpuidle-riscv-sbi.c#L586
> > > > [2] https://elixir.bootlin.com/linux/latest/source/drivers/cpuidle/=
cpuidle-psci.c#L441
> > >
> > > Yes, these are abuses of that and should be virtual devices as they h=
ave
> > > nothing to do with the platform bus.
> >
> > For those drivers, wouldn't it be better if proper devices would be der=
ived from
> > the CPU OF nodes directly? This seems to be a common problem for cpuidl=
e and
> > cpufreq drivers.
>
> Yes they should.

Well, which one do we bind? The cpufreq driver or cpuidle driver? Or
there's the thermal f/w throttling as well. It's messy. Also, the CPUs
already have a struct device associated with them for the topology
stuff, but no driver IIRC.

Another complication is it is not the CPU that determines what
cpufreq/cpuidle drivers to use, but a platform decision. That decision
may evolve as well which means it can't be driven from the DT.

> > But it's quite a while ago I dealt with such drivers, maybe there are r=
easons
> > not to do so.
>
> I think people just got lazy :)

Virtual device was probably the right thing given there isn't directly
any device we are controlling/programming. This driver is just built
on top of other subsystems (clock and regulator).

Rob


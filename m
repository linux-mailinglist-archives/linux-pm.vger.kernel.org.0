Return-Path: <linux-pm+bounces-11183-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9877E933441
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jul 2024 00:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5411A2813DE
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2024 22:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D2613CA95;
	Tue, 16 Jul 2024 22:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZawOqEtw"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1CC14A84;
	Tue, 16 Jul 2024 22:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721169219; cv=none; b=GuMaOkjDoWmehIaZ9dGLMicV38K86xBkH76nlA0azjo2MmrUgvTOp6leL+Vg5+mg3HmC3LsSD38acGAo2u2cQAJib0tXVRZg+3gTzwoIWubpA/HMPasGxmVC8V/FjiHJSf3++mZVidYhIrCqy9a/zjrvMee4MNaNI4RGE/Qr55w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721169219; c=relaxed/simple;
	bh=/aBpzjgCn/X+Hq6VZApNeXq9DCwr31hcN9A8Z1507iY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YkSOTC5tol+jpdPzmLOEhMtjeznxKOAl12j2RGqa87BCo+tSxWCE05vMkuIyaOuVIPqTM4zrS0E5qOBk1LdPPpIGupXawNgJb9RjdTBFOy0OYFcAyQZjN3jrCxdXAfWagGuhlLFoq3V7lfUFOA942JxqSqPWjo3Bue62zcC3ffc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZawOqEtw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBDBFC116B1;
	Tue, 16 Jul 2024 22:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721169218;
	bh=/aBpzjgCn/X+Hq6VZApNeXq9DCwr31hcN9A8Z1507iY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZawOqEtwcUz8fWQav/Ku24aoQjhyWckbHMK340VZ1o6FDGucXk0golp+OK0ZjlxTe
	 Pf9wbU7oNxBegC8zItphuBqpUktcZgvvfm2ArhFyQSG7grxAxo1zWsxre2Oji4KlSg
	 8gp6NpPsDObMsbphL/1ktHPAOAlFsUdkrJTz/yU9RWtZizzkuMpf2/dYim0miiz/9C
	 R94BCo+qgfPTFU4pkqUivsPZOjB1lRqWoegnZn4dOJ8GckORtbQ+L9ZLo97O/n9xD5
	 SJ8zDorgmVFoYOPPvqwTZb1y2DNBmBq5JY5LFplvZGhNn1llFF0tgV4eST7VOU8fCO
	 ylF8tP/clO90A==
Date: Wed, 17 Jul 2024 00:33:30 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Greg KH <greg@kroah.com>, Danilo Krummrich <dakr@redhat.com>,
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
	Joakim Bech <joakim.bech@linaro.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 8/8] cpufreq: Add Rust based cpufreq-dt driver
Message-ID: <Zpb1OiMj96k1kEAd@pollux>
References: <b1601c1dbdf68a4b812fcfaf73f3b5dea67f2025.1720680252.git.viresh.kumar@linaro.org>
 <Zo-3QIPbhBsv8EjB@pollux>
 <20240711130802.vk7af6zd4um3b2cm@vireshk-i7>
 <Zo_cW57i_GMlmYV-@pollux>
 <2024071122-escargot-treadmill-6e9a@gregkh>
 <ZpAEWAzETnrVI-cs@pollux>
 <2024071111-negotiate-spoof-da94@gregkh>
 <ZpaOjcuzBsSx45jE@cassiopeiae>
 <2024071639-scorecard-astonish-673c@gregkh>
 <CAL_Jsq+OHqoo9Lxpw5GE0315dmjQPvRo60=PsJXCx=heOfmBNw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_Jsq+OHqoo9Lxpw5GE0315dmjQPvRo60=PsJXCx=heOfmBNw@mail.gmail.com>

On Tue, Jul 16, 2024 at 09:53:15AM -0600, Rob Herring wrote:
> On Tue, Jul 16, 2024 at 9:22 AM Greg KH <greg@kroah.com> wrote:
> >
> > On Tue, Jul 16, 2024 at 05:15:25PM +0200, Danilo Krummrich wrote:
> > > On Thu, Jul 11, 2024 at 06:34:22PM +0200, Greg KH wrote:
> > > > On Thu, Jul 11, 2024 at 06:12:08PM +0200, Danilo Krummrich wrote:
> > > > > On Thu, Jul 11, 2024 at 04:37:50PM +0200, Greg KH wrote:
> > > > > > On Thu, Jul 11, 2024 at 03:21:31PM +0200, Danilo Krummrich wrote:
> > > > > > > (2) You require drivers to always implement a "dummy" struct platform_device,
> > > > > > > there is platform_device_register_simple() for that purpose.
> > > > > >
> > > > > > No, NEVER do that.  platform devices are only for real platform devices,
> > > > > > do not abuse that interface any more than it already is.
> > > > >
> > > > > I thought we're talking about cases like [1] or [2], but please correct me if
> > > > > those are considered abusing the platform bus as well.
> > > > >
> > > > > (Those drivers read the CPU OF nodes, instead of OF nodes that represent a
> > > > > separate device.)
> > > > >
> > > > > [1] https://elixir.bootlin.com/linux/latest/source/drivers/cpuidle/cpuidle-riscv-sbi.c#L586
> > > > > [2] https://elixir.bootlin.com/linux/latest/source/drivers/cpuidle/cpuidle-psci.c#L441
> > > >
> > > > Yes, these are abuses of that and should be virtual devices as they have
> > > > nothing to do with the platform bus.
> > >
> > > For those drivers, wouldn't it be better if proper devices would be derived from
> > > the CPU OF nodes directly? This seems to be a common problem for cpuidle and
> > > cpufreq drivers.
> >
> > Yes they should.
> 
> Well, which one do we bind? The cpufreq driver or cpuidle driver? Or
> there's the thermal f/w throttling as well. It's messy. Also, the CPUs
> already have a struct device associated with them for the topology
> stuff, but no driver IIRC.

I did not mean to say that they should bind to the CPU nodes compatible string,
but rather have devices populated from sub-nodes of the CPU / CPU cluster nodes
or from the SoC's 'simple-bus' or whatever makes sense for the specific HW.

Generally, I think there should be something in the DT that populates the
corresponding device, rather than having a virtual device. The device isn't
really virtual, it controls some real HW.

> 
> Another complication is it is not the CPU that determines what
> cpufreq/cpuidle drivers to use, but a platform decision. That decision
> may evolve as well which means it can't be driven from the DT.

Often it's SoC specific, but that should be fine, right? Or do you mean
something else?

> 
> > > But it's quite a while ago I dealt with such drivers, maybe there are reasons
> > > not to do so.
> >
> > I think people just got lazy :)
> 
> Virtual device was probably the right thing given there isn't directly
> any device we are controlling/programming. This driver is just built
> on top of other subsystems (clock and regulator).

The two examples I gave use a firmware interface to control the CPU's idle
state.

But even for the case you mention here, I'd still argue that the driver controls
some real hardware, just not directly. It controls the semantics and is still HW
specific.

Having a dedicated DT node also makes it easy to provide the resources, e.g.
regulators and clocks.

- Danilo

> 
> Rob
> 


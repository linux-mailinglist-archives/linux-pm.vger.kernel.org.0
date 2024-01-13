Return-Path: <linux-pm+bounces-2180-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA8C82CADE
	for <lists+linux-pm@lfdr.de>; Sat, 13 Jan 2024 10:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 006DA1F225FB
	for <lists+linux-pm@lfdr.de>; Sat, 13 Jan 2024 09:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39BDA48;
	Sat, 13 Jan 2024 09:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GDzN14Pi"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B695DA2A;
	Sat, 13 Jan 2024 09:37:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28057C433C7;
	Sat, 13 Jan 2024 09:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705138656;
	bh=w/zSBBUrOCogh8TXa7vV7+1viFBuWmgXZKnDrd+wg/4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GDzN14Pi0f4Pnq/RXyJZlmAXb+3jQHnB1NEEcUgJRyc5RkgaIN2MEh1c664bOhaoF
	 Q4c/L96XzgDV//riRy4W8fbXJ9fouhbrHQ4Z9RWNidU/t+EwYXSlIveNgaQo9ct8Tb
	 sZkGT0PgXZH2kAog8sFRSSlK8lr/EDywrl+BD9TCuX8XdBjSW4Etv0Oahnbkxr6gQK
	 DNiS3LlLvQr6zvg4KBKL5bXqhiblv3zBY05QgINrxYlR4ehLhxWk8iZdV/QmCS2PlU
	 hd32/uCQIhxGcNC5FrGNOiEo3i1VXkNHis3AsJ6+uwmKO6dZcD1za70LP39r7pkQWy
	 wa/Lh3v3mrMMQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1rOaSL-00BMls-Kk;
	Sat, 13 Jan 2024 09:37:33 +0000
Date: Sat, 13 Jan 2024 09:37:33 +0000
Message-ID: <86zfx98tgi.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Saravana Kannan <saravanak@google.com>
Cc: David Dai <davidai@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Quentin Perret <qperret@google.com>,
	Masami Hiramatsu <mhiramat@google.com>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Pavan Kondeti <quic_pkondeti@quicinc.com>,
	Gupta Pankaj <pankaj.gupta@amd.com>,
	Mel Gorman <mgorman@suse.de>,
	kernel-team@android.com,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: cpufreq: add virtual cpufreq device
In-Reply-To: <CAGETcx_8x4p7WTwqQiVGdtHftVjFUJruXsOXwJXgDi0GdEtLNA@mail.gmail.com>
References: <20231111014933.1934562-1-davidai@google.com>
	<20231111014933.1934562-2-davidai@google.com>
	<865y231jvj.wl-maz@kernel.org>
	<CAGETcx9-n0z5buWgtLZ+6VxW2jEko1GWzkGtGhFiZEq-x_G4nw@mail.gmail.com>
	<867clpaxel.wl-maz@kernel.org>
	<CAGETcx_8x4p7WTwqQiVGdtHftVjFUJruXsOXwJXgDi0GdEtLNA@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/29.1
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: saravanak@google.com, davidai@google.com, rafael@kernel.org, viresh.kumar@linaro.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, sudeep.holla@arm.com, qperret@google.com, mhiramat@google.com, will@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org, oliver.upton@linux.dev, dietmar.eggemann@arm.com, quic_pkondeti@quicinc.com, pankaj.gupta@amd.com, mgorman@suse.de, kernel-team@android.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Fri, 12 Jan 2024 22:02:39 +0000,
Saravana Kannan <saravanak@google.com> wrote:
>=20
> Sorry for the delay in response. Was very busy for a while and then
> holidays started.
>=20
> On Fri, Dec 8, 2023 at 12:52=E2=80=AFAM Marc Zyngier <maz@kernel.org> wro=
te:
> >
> > On Thu, 07 Dec 2023 22:44:36 +0000,
> > Saravana Kannan <saravanak@google.com> wrote:
> > >
> > > On Wed, Nov 15, 2023 at 12:49=E2=80=AFAM Marc Zyngier <maz@kernel.org=
> wrote:
> > > >
> > > > On Sat, 11 Nov 2023 01:49:29 +0000,
> > > > David Dai <davidai@google.com> wrote:
> > > > >
> > > > > Adding bindings to represent a virtual cpufreq device.
> > > > >
> > > > > Virtual machines may expose MMIO regions for a virtual cpufreq de=
vice
> > > > > for guests to read frequency information or to request frequency
> > > > > selection. The virtual cpufreq device has an individual controlle=
r for
> > > > > each frequency domain.
> > > >
> > > > I would really refrain form having absolute frequencies here. A
> > > > virtual machine can be migrated, and there are *zero* guarantees th=
at
> > > > the target system has the same clock range as the source.
> > > >
> > > > This really should be a relative number, much like the capacity. Th=
at,
> > > > at least, can be migrated across systems.
> > >
> > > There's nothing in this patch that mandates absolute frequency.
> > > In true KVM philosophy, we leave it to the VMM to decide.
> >
> > This has nothing to do with KVM. It would apply to any execution
> > environment, including QEMU in TCG mode.
> >
> > To quote the original patch:
> >
> > +    description:
> > +      Address and size of region containing frequency controls for eac=
h of the
> > +      frequency domains. Regions for each frequency domain is placed
> > +      contiugously and contain registers for controlling DVFS(Dynamic =
Frequency
> > +      and Voltage) characteristics. The size of the region is proporti=
onal to
> > +      total number of frequency domains.
> >
> > What part of that indicates that *relative* frequencies are
> > acceptable? The example explicitly uses the opp-v2 binding, which
> > clearly is about absolute frequency.
>=20
> We can update the doc to make that clearer and update the example too.
>=20
> > To reiterate: absolute frequencies are not the right tool for the job,
> > and they should explicitly be described as relative in the spec. Not
> > left as a "whatev'" option for the execution environment to interpret.
>=20
> I think it depends on the use case. If there's no plan to migrate the
> VM across different devices, there's no need to do the unnecessary
> normalization back and forth.

VM migration is a given, specially when QEMU is involved. Designing
something that doesn't support it is a bug, plain and simple.

> And if we can translate between pCPU frequency and a normalized
> frequency, we can do the same for whatever made up frequencies too. In
> fact, we plan to do exactly that in our internal use cases for this.
> There's nothing here that prevents the VMM from doing that.
>
> Also, if there are hardware virtualized performance counters (AMU,
> CPPC, etc) that are used for frequency normalization, then we have to
> use the real frequencies in those devices otherwise the "current
> frequency" can be 2 GHz while the max normalized frequency is 1024
> KHz. That'll mess up load tracking.

And that's exactly why this shouldn't be a *frequency*, but a
performance scale or some other unit-less coefficient. Just like the
big-little capacity.

	M.

--=20
Without deviation from the norm, progress is not possible.


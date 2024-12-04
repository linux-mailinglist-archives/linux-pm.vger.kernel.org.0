Return-Path: <linux-pm+bounces-18579-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BCC9E45B7
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 21:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05BD7285882
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 20:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88CAA18DF65;
	Wed,  4 Dec 2024 20:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VEVKOKZh"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590233D0D5;
	Wed,  4 Dec 2024 20:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733344229; cv=none; b=hfNYp36piMC9nsLYyTkeT2kugHVYUXEa1ix7P7u3FN9wyufzFFkRkWSK01H+DF2yj1RONSiRRuVmBypBRzheX3XCukfpzDmfKytK36aw6IXnO064v1u5AmYJD36vMeIb9Cse4voX6r5kXANkwO7nzVQh+fATKI2Hcda652Q7ICc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733344229; c=relaxed/simple;
	bh=0QZ2Q605tV7zZ2IXy/tej60uqsqxPcm8XwmDX7WT/RY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cbtY66PdZpXjwpx8GEVrZVQ27rVp9Rb1WPNAsS28ootLPXTxBO4CJtUL4OWpCO58lGXQSg+SzIt6Da0sOJZz+Yn/J+kTluh7m8+b+eiPc+utZkwZS/28xgslh9ZKtu5h2k1CzSegm1bOzkSOlMAfVi0idsiaXCqeP2VzWhOj41A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VEVKOKZh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB0BCC4CED1;
	Wed,  4 Dec 2024 20:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733344228;
	bh=0QZ2Q605tV7zZ2IXy/tej60uqsqxPcm8XwmDX7WT/RY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VEVKOKZhKAH9PZHZqgjJeTokJEQknj1vdpSKMBaUsCXHxKM6p3GSIkgeH2hlDgk8a
	 czKyZs8KuabDaRxqHH1necv0I4E9WfHxQNc+xdkpknN6Axz368ZPliAokHEdg3MAvV
	 5ZFcx3zIe7x+f66xb9btT97p0TgEB/8kv2qHrFnfs6CWI1cPX1qonsvRPEAcaziIgK
	 kymjrRph76Khlax6IwgiOAgKO5Rfjkrbw0iLupF07+75s4wsZ2veDuiHRN2ugIKERB
	 MkGSy4xKWDE0ME18m2+f06ARSvzkolv02G8pkk9sxX8PNXhSR4IbPaxm59kzeub4Lx
	 hAKoJRRHoMUrA==
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e3988fdb580so215943276.2;
        Wed, 04 Dec 2024 12:30:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUUp9Ez+1e5IgKwW0xTU2WMvA7U7cYz+vHLIRnqhS7JEolHga/9/4JtWcMQot5oBm03qWuGHR6nMWLS25eC@vger.kernel.org, AJvYcCUrhmyGkWTqllIoE8LEthz3s1jQZmS4NjRpW0yc93saTy7loUKWGd/1SPpef7oCyz2KZfGUQcsKweM=@vger.kernel.org, AJvYcCXBRki+RTev/EJdnYvPW6kld2IZ3YPWsB8N1CLe4HUe48v/Q+gvKGFMb/1KwiBYS3EBatTpk1U++iOA@vger.kernel.org
X-Gm-Message-State: AOJu0YyNnKI6w407IEd5AEfvCniv6TXWyGc6fqEa51PogGGc5XSmJceR
	u19wD7p99mGvVblN4KMJ+O76CC9vXZ7BrJ83tYMV9SAfQPfZ3EiaoFQicTdTDYkDen3l97c7UVb
	127xOqiF8RnWKx9j2OUUwvK+jmw==
X-Google-Smtp-Source: AGHT+IFvI3DCRl7+WTQJdlM4ndM6R3NZOhslGxmxHIxsC27/TWT0ruRSJxqNNdeEfNWAYZp4/cZ8qgTcVTq+Jr5aOFw=
X-Received: by 2002:a05:6902:2304:b0:e39:7fe5:3b63 with SMTP id
 3f1490d57ef6-e39d4374f06mr7331060276.40.1733344227993; Wed, 04 Dec 2024
 12:30:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203163158.580-1-ansuelsmth@gmail.com> <20241204184253.GA276662-robh@kernel.org>
 <6750a4c3.df0a0220.1ae5b6.7dfb@mx.google.com>
In-Reply-To: <6750a4c3.df0a0220.1ae5b6.7dfb@mx.google.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 4 Dec 2024 14:30:17 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJvotQ=QZKq+CHs4uW_DRegn02YoSbqmxyi__6RJ0wAuA@mail.gmail.com>
Message-ID: <CAL_JsqJvotQ=QZKq+CHs4uW_DRegn02YoSbqmxyi__6RJ0wAuA@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: cpufreq: Document support for Airoha
 EN7581 CPUFreq
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, upstream@airoha.com, 
	Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 12:51=E2=80=AFPM Christian Marangi <ansuelsmth@gmail=
.com> wrote:
>
> On Wed, Dec 04, 2024 at 12:42:53PM -0600, Rob Herring wrote:
> > On Tue, Dec 03, 2024 at 05:31:49PM +0100, Christian Marangi wrote:
> > > Document required property for Airoha EN7581 CPUFreq .
> > >
> > > On newer Airoha SoC, CPU Frequency is scaled indirectly with SMCCC co=
mmands
> > > to ATF and no clocks are exposed to the OS.
> > >
> > > The SoC have performance state described by ID for each OPP, for this=
 a
> > > Power Domain is used that sets the performance state ID according to =
the
> > > required OPPs defined in the CPU OPP tables.
> > >
> > > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > > Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > ---
> > > Changes v5:
> > > - Add Reviewed-by tag
> > > - Fix OPP node name error
> > > - Rename cpufreq node name to power-domain
> > > - Rename CPU node power domain name to perf
> > > - Add model and compatible to example
> > > Changes v4:
> > > - Add this patch
> > >
> > >  .../cpufreq/airoha,en7581-cpufreq.yaml        | 262 ++++++++++++++++=
++
> > >  1 file changed, 262 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/cpufreq/airoha,=
en7581-cpufreq.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/cpufreq/airoha,en7581-=
cpufreq.yaml b/Documentation/devicetree/bindings/cpufreq/airoha,en7581-cpuf=
req.yaml
> > > new file mode 100644
> > > index 000000000000..7e36fa037e4b
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/cpufreq/airoha,en7581-cpufreq=
.yaml
> > > @@ -0,0 +1,262 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/cpufreq/airoha,en7581-cpufreq.yam=
l#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Airoha EN7581 CPUFreq
> > > +
> > > +maintainers:
> > > +  - Christian Marangi <ansuelsmth@gmail.com>
> > > +
> > > +description: |
> > > +  On newer Airoha SoC, CPU Frequency is scaled indirectly with SMCCC=
 commands
> > > +  to ATF and no clocks are exposed to the OS.
> > > +
> > > +  The SoC have performance state described by ID for each OPP, for t=
his a
> > > +  Power Domain is used that sets the performance state ID according =
to the
> > > +  required OPPs defined in the CPU OPP tables.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: airoha,en7581-cpufreq
> > > +
> > > +  '#clock-cells':
> > > +    const: 0
> >
> > You just said no clocks are exposed to the OS.
> >
>
> Well we now simulate one due to request from cpufreq reviewers.
>
> Everything is still handled by SMC that only report the current
> frequency of the CPU.
>
> > > +
> > > +  '#power-domain-cells':
> > > +    const: 0
> > > +
> > > +  operating-points-v2: true
> > > +
> > > +required:
> > > +  - compatible
> > > +  - '#clock-cells'
> > > +  - '#power-domain-cells'
> > > +  - operating-points-v2
> > > +
> > > +additionalProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    / {
> > > +        model =3D "Airoha EN7581 Evaluation Board";
> > > +        compatible =3D "airoha,en7581-evb", "airoha,en7581";
> > > +
> > > +        #address-cells =3D <2>;
> > > +           #size-cells =3D <2>;
> >
> > mixed tab and spaces.
> >
> > Can't I just go read the actual .dts files if I want to see
> > *everything*? Examples should generally be just what the schema covers.
> >
>
> Idea here is to give example as both clock and power-domain property are
> needed in the CPU nodes for the CPUFreq driver to correctly work.

If we want to do that, then we really should have a schema defining
that. But since there's only 1 for cpus that doesn't really work.

> Should I drop and just define the CPUFreq node?

Yes.

> > > +
> > > +        cpus {
> > > +            #address-cells =3D <1>;
> > > +            #size-cells =3D <0>;
> > > +
> > > +            cpu0: cpu@0 {
> > > +                device_type =3D "cpu";
> > > +                compatible =3D "arm,cortex-a53";
> > > +                reg =3D <0x0>;
> > > +                operating-points-v2 =3D <&cpu_opp_table>;
> > > +                enable-method =3D "psci";
> > > +                clocks =3D <&cpu_pd>;
> > > +                clock-names =3D "cpu";
> > > +                power-domains =3D <&cpu_pd>;
> > > +                power-domain-names =3D "perf";
> > > +                next-level-cache =3D <&l2>;
> > > +                #cooling-cells =3D <2>;
> >
> > I don't understand why you have clocks, power-domains and OPP?
> > Certainly that's conceivable, but not with how you're abusing
> > power-domains for performance points and you said clocks are not expose=
d
> > to the OS.
> >
>
> SMC scale based on index values not frequency. That really resembles a
> power-domain.

So what is the point of the OPP table with frequency? You can set an
OPP and read the frequency, right? So a table of frequencies is
redundant.

> SMC provide frequency in MHz tho so we model that as a
> get-only clock.
>
> At times with no clocks are exposed I intend that they SoC doesn't
> provide any raw control on them in the normal way with a register, bits
> to change and logic to apply for mux and divisor, this thing is very
> special and works only with 2 command and nothing else so I'm trying my
> best to model this in the most descriptive and complete way possible.

Fair enough for the clock. Please clarify the description with what
clock is provided. Just to make sure, all CPUs run at the same
frequency?

Rob


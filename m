Return-Path: <linux-pm+bounces-18684-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BEB69E689A
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2024 09:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC7AB281256
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2024 08:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808DA1DDA1B;
	Fri,  6 Dec 2024 08:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tJ7AJVVy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3D9191F78
	for <linux-pm@vger.kernel.org>; Fri,  6 Dec 2024 08:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733472861; cv=none; b=M8Dw65Ek9Z46fAeBAHQlMMNEEsjHWUeMqlAGA5D15R3f/Fdxoi8UIciLXaIOk9/7in/Q8d1k2fqH7GP/DWsDUoRPlu9uFL/yxCHFnQr0WCHAwO5If5QXcrXG3GCjbrFMjjsgnIGzTxQZG3falBMkKxl48zuukAbZIcipj6PZNdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733472861; c=relaxed/simple;
	bh=ikL4QgOYhjAREtx+/cpTj83SMFbrEybVBWxtKQ627Gs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q+A6JYy37qS3haCAJvM5LRPmTXysnFj5c2wgn9fQVXhwZ0CeqZ2dpgrnRRAMvT6grby7YOQwNNfOZYveB7UDt3YKGZwGAPBYpZPZoVz0C+OmHf98yymn7eklmmr5+NnmMxpYyZB2TwdBRPPeNzRoMmckbEGgmQ0b1IU/iYxtbgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tJ7AJVVy; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e382589e8fdso1676214276.0
        for <linux-pm@vger.kernel.org>; Fri, 06 Dec 2024 00:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733472857; x=1734077657; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Q33HOjqrQREnRaD5TvStoDTJm6slXzivbpdSpxLoEMs=;
        b=tJ7AJVVyzkKO+WT/bm4+RhQO7QsUev+qbI+C9qRy5xtObylYbd6J2MF4eu5lvU0nXy
         bDxjbDwNmrtdz2mwxlEa8A0e1VzJOK3hSTeZD7BlfjbXA0Ddw9S6kBPPboqx2Q3yQUOA
         R3B7T0KGhGCGAIFFHbJ81vpk5IKNJC33k9o1oMpJEQtJyH5H9cC5ZxWa1qVgzvrOD/Ia
         dHrnRbPPZz2MjuDFF8vAZAIu1EMOXAXKBdaU9fg4y1OPQH8FXSYPuD/pDJ9x0CsiU94h
         NZh+0PoGDjNhMlUzTDpRWrQ+/9RHiLlrNasamczOcsxL9+b4fTGehHF7TlVndUIEYHxX
         u0Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733472857; x=1734077657;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q33HOjqrQREnRaD5TvStoDTJm6slXzivbpdSpxLoEMs=;
        b=ZNDqR5cnw/bJiiSL02xX7S7/V9u6qInr8aiCNpdkrIzr0KP+BtUsHA+unRt1LcADm5
         FAPUEeM2CDtk77N/fk+elILU3o0KV/Z7+kSUWuFE+I93MfryNjHmNR2LhI8eabLgRkSC
         pyfPEWLoCfufFfndj1SpH4L7nDwtBbwnrxByPakAqnJjvObqT8pqgZgFInjGEgEJTzke
         oEsVTmKkpn12CmP2m/f1AWThuZ7UAbJl8XFMz+jt/XzEvhXSTgwd72hBBgM0pHjDbK2F
         Kwi/cfZpzTiexbDSoZR0aLDPmZMm4ztllXuECEjiWuaCiAwinbqQVdqrKCSNHZa4gfu+
         e/wg==
X-Forwarded-Encrypted: i=1; AJvYcCWmS7f2TQkRHniXHvKjGfnGLwFVwZIBGTGXmhD4W/38mgZD+XUQxGShwKTgf4N0eo4yDMnR7N6buw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwfXfSl3CWo2c5fzqhq8t9vH0kWz29etVNhOY9+jfi1Kf0awppJ
	iFY6ZkPOPYk3MKsihE4NjjEvjSQHyI89gFGj6xnQhWYnEpK3cU1c8oyyUSYmDmDstSL7z4tiAvO
	bbsPcvL8lABmDPcMjZh3as5y080QuXfRIV/Zufg==
X-Gm-Gg: ASbGncuvux73xO1mjKlKpeqqTco78BdqmJApHy827/8onzR3FYzy1ibJnN476e9yFrW
	OgqnL61khdep2dKbiDIdks0EqEepff+10
X-Google-Smtp-Source: AGHT+IE75SjwqF/6LqRkHzj+d0Y8ur+w4Ml/+Za9qyrqL5hiYp0/PfqDdgYR2YyYkv4j4Tj9ns28wjePtyiBgp20aWY=
X-Received: by 2002:a05:6902:a83:b0:e39:82e7:ffe8 with SMTP id
 3f1490d57ef6-e3a0b0bbbb0mr2509093276.12.1733472857452; Fri, 06 Dec 2024
 00:14:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204182323.15192-1-ansuelsmth@gmail.com> <CAPDyKFqq03OnRoUiJkczbNFH4EHO6cFJkwTasdEzVSwDdxqUzg@mail.gmail.com>
 <6751ea7e.050a0220.3435c6.5c62@mx.google.com>
In-Reply-To: <6751ea7e.050a0220.3435c6.5c62@mx.google.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 6 Dec 2024 09:13:40 +0100
Message-ID: <CAPDyKFrR9eNuChJDZmnPojz2N469F5Gpw_sU12NaDonJ8XUQxw@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] dt-bindings: cpufreq: Document support for Airoha
 EN7581 CPUFreq
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, upstream@airoha.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 5 Dec 2024 at 19:01, Christian Marangi <ansuelsmth@gmail.com> wrote:
>
> On Thu, Dec 05, 2024 at 05:07:07PM +0100, Ulf Hansson wrote:
> > On Wed, 4 Dec 2024 at 19:24, Christian Marangi <ansuelsmth@gmail.com> wrote:
> > >
> > > Document required property for Airoha EN7581 CPUFreq .
> > >
> > > On newer Airoha SoC, CPU Frequency is scaled indirectly with SMCCC commands
> > > to ATF and no clocks are exposed to the OS.
> > >
> > > The SoC have performance state described by ID for each OPP, for this a
> > > Power Domain is used that sets the performance state ID according to the
> > > required OPPs defined in the CPU OPP tables.
> >
> > To clarify this, I would rather speak about a performance-domain with
> > performance-levels, where each level corresponds to a frequency that
> > is controlled by the FW/HW.
>
> (If Rob notice this and gets angry :P , v6 was posted 10 minutes before
> the review from Rob, big coincidence. No intention of ignoring the
> comments)
>
> I notice that power-domain schema also accepts node with
> performance-domain. My concern is that the API we would use
> (power-domain related) expect #power-domain-cells property and might
> reject init with #power-performance-cells.

You understood me wrong. I am not suggesting to use #power-performance-cells.

The more established way to model performance domains is using
"power-domain-cells" (a power-domain provider), which is capable of
performance scaling.

>
> I have to check this but I think it's better to have a clear idea of
> what the schema should be.
>
> >
> > >
> > > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > > Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > ---
> > > Changes v6:
> > > - No changes
> > > Changes v5:
> > > - Add Reviewed-by tag
> > > - Fix OPP node name error
> > > - Rename cpufreq node name to power-domain
> > > - Rename CPU node power domain name to perf
> > > - Add model and compatible to example
> > > Changes v4:
> > > - Add this patch
> > >
> > >  .../cpufreq/airoha,en7581-cpufreq.yaml        | 262 ++++++++++++++++++
> > >  1 file changed, 262 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/cpufreq/airoha,en7581-cpufreq.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/cpufreq/airoha,en7581-cpufreq.yaml b/Documentation/devicetree/bindings/cpufreq/airoha,en7581-cpufreq.yaml
> > > new file mode 100644
> > > index 000000000000..7e36fa037e4b
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/cpufreq/airoha,en7581-cpufreq.yaml
> > > @@ -0,0 +1,262 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/cpufreq/airoha,en7581-cpufreq.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Airoha EN7581 CPUFreq
> > > +
> > > +maintainers:
> > > +  - Christian Marangi <ansuelsmth@gmail.com>
> > > +
> > > +description: |
> > > +  On newer Airoha SoC, CPU Frequency is scaled indirectly with SMCCC commands
> > > +  to ATF and no clocks are exposed to the OS.
> > > +
> > > +  The SoC have performance state described by ID for each OPP, for this a
> > > +  Power Domain is used that sets the performance state ID according to the
> > > +  required OPPs defined in the CPU OPP tables.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: airoha,en7581-cpufreq
> > > +
> > > +  '#clock-cells':
> > > +    const: 0
> >
> > I think Rob questioned this too. Why do we need a clock provider here?
> >
> > If this is only to keep the CPUfreq DT driver happy, I think this
> > should be dropped. There is only a performance-domain here, right?
> >
>
> As said in v5, the API is fun.
> SMC have an OP to request the current frequency and that is provided in
> MHz.
>
> Then it does have a command to se the global frequency and that is in
> Index.
>
> Each index rapresent a particular frequency.
>
> For CPUFreq-DT a clock is mandatory, and is also good to provide one.

Well, that's a separate discussion. Let's settle on the bindings first.

> But in v5 Rob was O.K. for the clock. The main complain is for the OPP
> table.

We need the OPP table, else how would we be able to describe the
available performance levels?

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
> > > +        model = "Airoha EN7581 Evaluation Board";
> > > +        compatible = "airoha,en7581-evb", "airoha,en7581";
> > > +
> > > +        #address-cells = <2>;
> > > +       #size-cells = <2>;
> > > +
> > > +        cpus {
> > > +            #address-cells = <1>;
> > > +            #size-cells = <0>;
> > > +
> > > +            cpu0: cpu@0 {
> > > +                device_type = "cpu";
> > > +                compatible = "arm,cortex-a53";
> > > +                reg = <0x0>;
> > > +                operating-points-v2 = <&cpu_opp_table>;
> > > +                enable-method = "psci";
> > > +                clocks = <&cpu_pd>;
> > > +                clock-names = "cpu";
> > > +                power-domains = <&cpu_pd>;
> > > +                power-domain-names = "perf";
> > > +                next-level-cache = <&l2>;
> > > +                #cooling-cells = <2>;
> > > +            };
> > > +
> > > +            cpu1: cpu@1 {
> > > +                device_type = "cpu";
> > > +                compatible = "arm,cortex-a53";
> > > +                reg = <0x1>;
> > > +                operating-points-v2 = <&cpu_opp_table>;
> > > +                enable-method = "psci";
> > > +                clocks = <&cpu_pd>;
> > > +                clock-names = "cpu";
> > > +                power-domains = <&cpu_pd>;
> > > +                power-domain-names = "perf";
> > > +                next-level-cache = <&l2>;
> > > +                #cooling-cells = <2>;
> > > +            };
> > > +
> > > +            cpu2: cpu@2 {
> > > +                device_type = "cpu";
> > > +                compatible = "arm,cortex-a53";
> > > +                reg = <0x2>;
> > > +                operating-points-v2 = <&cpu_opp_table>;
> > > +                enable-method = "psci";
> > > +                clocks = <&cpu_pd>;
> > > +                clock-names = "cpu";
> > > +                power-domains = <&cpu_pd>;
> > > +                power-domain-names = "perf";
> > > +                next-level-cache = <&l2>;
> > > +                #cooling-cells = <2>;
> > > +            };
> > > +
> > > +            cpu3: cpu@3 {
> > > +                device_type = "cpu";
> > > +                compatible = "arm,cortex-a53";
> > > +                reg = <0x3>;
> > > +                operating-points-v2 = <&cpu_opp_table>;
> > > +                enable-method = "psci";
> > > +                clocks = <&cpu_pd>;
> > > +                clock-names = "cpu";
> > > +                power-domains = <&cpu_pd>;
> > > +                power-domain-names = "perf";
> > > +                next-level-cache = <&l2>;
> > > +                #cooling-cells = <2>;
> > > +            };
> > > +        };
> > > +
> > > +        cpu_opp_table: opp-table-cpu {
> > > +            compatible = "operating-points-v2";
> > > +            opp-shared;
> > > +
> > > +            opp-500000000 {
> > > +                opp-hz = /bits/ 64 <500000000>;
> > > +                required-opps = <&smcc_opp0>;
> > > +            };
> > > +
> > > +            opp-550000000 {
> > > +                opp-hz = /bits/ 64 <550000000>;
> > > +                required-opps = <&smcc_opp1>;
> > > +            };
> > > +
> > > +            opp-600000000 {
> > > +                opp-hz = /bits/ 64 <600000000>;
> > > +                required-opps = <&smcc_opp2>;
> > > +            };
> > > +
> > > +            opp-650000000 {
> > > +                opp-hz = /bits/ 64 <650000000>;
> > > +                required-opps = <&smcc_opp3>;
> > > +            };
> > > +
> > > +            opp-7000000000 {
> > > +                opp-hz = /bits/ 64 <700000000>;
> > > +                required-opps = <&smcc_opp4>;
> > > +            };
> > > +
> > > +            opp-7500000000 {
> > > +                opp-hz = /bits/ 64 <750000000>;
> > > +                required-opps = <&smcc_opp5>;
> > > +            };
> > > +
> > > +            opp-8000000000 {
> > > +                opp-hz = /bits/ 64 <800000000>;
> > > +                required-opps = <&smcc_opp6>;
> > > +            };
> > > +
> > > +            opp-8500000000 {
> > > +                opp-hz = /bits/ 64 <850000000>;
> > > +                required-opps = <&smcc_opp7>;
> > > +            };
> > > +
> > > +            opp-9000000000 {
> > > +                opp-hz = /bits/ 64 <900000000>;
> > > +                required-opps = <&smcc_opp8>;
> > > +            };
> > > +
> > > +            opp-9500000000 {
> > > +                opp-hz = /bits/ 64 <950000000>;
> > > +                required-opps = <&smcc_opp9>;
> > > +            };
> > > +
> > > +            opp-10000000000 {
> > > +                opp-hz = /bits/ 64 <1000000000>;
> > > +                required-opps = <&smcc_opp10>;
> > > +            };
> > > +
> > > +            opp-10500000000 {
> > > +                opp-hz = /bits/ 64 <1050000000>;
> > > +                required-opps = <&smcc_opp11>;
> > > +            };
> > > +
> > > +            opp-11000000000 {
> > > +                opp-hz = /bits/ 64 <1100000000>;
> > > +                required-opps = <&smcc_opp12>;
> > > +            };
> > > +
> > > +            opp-11500000000 {
> > > +                opp-hz = /bits/ 64 <1150000000>;
> > > +                required-opps = <&smcc_opp13>;
> > > +            };
> > > +
> > > +            opp-12000000000 {
> > > +                opp-hz = /bits/ 64 <1200000000>;
> > > +                required-opps = <&smcc_opp14>;
> > > +            };
> > > +        };
> > > +
> > > +        cpu_smcc_opp_table: opp-table-smcc {
> > > +            compatible = "operating-points-v2";
> > > +
> > > +            smcc_opp0: opp-0 {
> > > +               opp-level = <0>;
> > > +            };
> > > +
> > > +            smcc_opp1: opp-1 {
> > > +                opp-level = <1>;
> > > +            };
> > > +
> > > +            smcc_opp2: opp-2 {
> > > +               opp-level = <2>;
> > > +            };
> > > +
> > > +            smcc_opp3: opp-3 {
> > > +               opp-level = <3>;
> > > +            };
> > > +
> > > +            smcc_opp4: opp-4 {
> > > +                opp-level = <4>;
> > > +            };
> > > +
> > > +            smcc_opp5: opp-5 {
> > > +                opp-level = <5>;
> > > +            };
> > > +
> > > +            smcc_opp6: opp-6 {
> > > +               opp-level = <6>;
> > > +            };
> > > +
> > > +            smcc_opp7: opp-7 {
> > > +               opp-level = <7>;
> > > +            };
> > > +
> > > +            smcc_opp8: opp-8 {
> > > +                opp-level = <8>;
> > > +            };
> > > +
> > > +            smcc_opp9: opp-9 {
> > > +               opp-level = <9>;
> > > +            };
> > > +
> > > +            smcc_opp10: opp-10 {
> > > +                opp-level = <10>;
> > > +            };
> > > +
> > > +            smcc_opp11: opp-11 {
> > > +                opp-level = <11>;
> > > +            };
> > > +
> > > +            smcc_opp12: opp-12 {
> > > +                opp-level = <12>;
> > > +            };
> > > +
> > > +            smcc_opp13: opp-13 {
> > > +                opp-level = <13>;
> > > +            };
> > > +
> > > +            smcc_opp14: opp-14 {
> > > +                opp-level = <14>;
> > > +            };
> > > +        };
> > > +
> > > +        cpu_pd: power-domain {
> >
> > Nitpick: We could use the name *performance-domain* here instead, that
> > would make it even more clear what this node describes.
> >
> > > +            compatible = "airoha,en7581-cpufreq";
> > > +
> > > +            operating-points-v2 = <&cpu_smcc_opp_table>;
> > > +
> > > +            #power-domain-cells = <0>;
> > > +            #clock-cells = <0>;
> > > +        };
> > > +    };
> > > --
> > > 2.45.2
> > >
> >
> > With those changes I am still happy with this approach, so feel free
> > to keep my Reviewed-by tag.
> >
>
> Thanks a lot for the hint. What I think should be understood and we need
> to agree on is the OPP table.
>
> Currently we have an implementation that is
>
> CPU-OPP-Table:
> - OPP Freq in MHz 1
>   - connection to OPP for performance-domain
>   ...
>
> Performance-Domain-OPP-Table:
> - OPP Level 1 (connected to OPP Freq)
>
> Is the double table the problem and we should find a way to unify it in
> something like
> CPU-OPP-Table:
> - OPP Freq in MHz 1
>   OPP Level 1
>
> - OPP Freq in MHz 2
>   OPP Level 2
>
> ...
>
> From what I notice this is problematic as the 2 subsystems require
> dedicated table for each other.
> In any case I think a table of freq is a MUST. Dropping that would
> result in not giving to the user an idea of the supported frequency and
> scaling stats.

Why do we need to invent something new here to describe this HW?
Doesn't the existing OPP v2 DT bindings with the required-opps
property, along with the power-domains bindings work as is?

Kind regards
Uffe


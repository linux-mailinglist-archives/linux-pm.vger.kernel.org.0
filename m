Return-Path: <linux-pm+bounces-18638-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 386949E5DCE
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 19:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C6D916C32C
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 18:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EECE224AEC;
	Thu,  5 Dec 2024 18:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y0mJHmix"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA4F217F3C;
	Thu,  5 Dec 2024 18:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733421699; cv=none; b=YP8aoEFuTLPqiliC5Z0cSeGNhLmyzaKXsoYI5KNhaB1EWbOGpSMg1pFfkYiVjr4TE7+W7GAkUAKb3cPzrG98muYJq8ZJdctIsk9OxyzfpTzVWaE91VPpCPzuFYnc+4NkC7JzjeYHRApkEZcxL+cR4oRi6ccaD/HHG7GbUUKCj0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733421699; c=relaxed/simple;
	bh=2kyl1ikPvDxh/J+poe1X+Y0zzVNm8VPu/KPEGrtYCKQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=stNM2DXCw6NIOW4fzQxOTvU+N5GoKbM343by9BayNq2FoICR2HEFsEscocOfLgBAG/Pf8DdNqDv0tSRq+ujRkVSiW+PTWiVXDjM7nHA/kHhghiCiO1vhyoIr6mK0FuCGUtkjo/paYduQmXwV4FLtGSOaktO4x0qP1hI7A5svQHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y0mJHmix; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4349cc45219so12646645e9.3;
        Thu, 05 Dec 2024 10:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733421696; x=1734026496; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0v5cvZV3b0oGw3no57VyPZ4JP7hYXYK9q8bPblp55YU=;
        b=Y0mJHmixkuIijzPBGcxiw4AzNOn9d2TWLy+hqUeQQ08QLz1/gBiplaXTvhfsO11u8h
         T4k/TnEo860pjwo1d5p2yAx+Av1zdeUK8q8vRbjcycgHjhhV74bKb3i6buuzX6sZhqJJ
         0T0aOGPxrniW9WyeF2RH+Xq9ajTj2RL4iag/ADwPrdrPR0ucgnxRG9cW+kfBKD+NNgss
         vOyNBrfjHJEkpnKaMPqSLw2i3ycgUdST5O2UK0H0p3dnbCqQFlRfdmbyYqsqu3Yc6ypP
         GNYVrFjUybxucEG4B1KvHZlK8iBdizK0CO78wAxCsaIlEf+l3jnkOzHxopnJUQueNG6d
         l7Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733421696; x=1734026496;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0v5cvZV3b0oGw3no57VyPZ4JP7hYXYK9q8bPblp55YU=;
        b=u6HBx385ioSx85kkGGGtTdnvbUlYGVZ3VJ70+NKAQlfknq0rLr2qckmxO7An56KqYq
         pmCgN2a9vKCb6YIVN08wIcTB2N9c4BGuYySlY0l4vz0R0CeDUFk/kP09OJ4r1+JYsPdH
         /TYI45wHcCbQah9dnu3O7kCx4HHY/rIWC0wZDDnSVrVfo/4k5Av6/Sg2HxtjhyrelA6G
         mWnRaIMjjy2NNl7yzIMDVqSnQf0OBbHncCcT/r19KrQuJJ/sjIkDf7q8ACh4/7rHHoDH
         aQpoWVfZ7utGpBjHiGBBoZ7FHTZqWy0ekCF+b3Sgbw7aEu3xrcHUml7or0NwyDpPJV4r
         N2Vw==
X-Forwarded-Encrypted: i=1; AJvYcCUnNF8v6oJjEr8+oTKupIXMC/s7tm5E06NmjmgtsxqDgDilSH9+hFODnRZkcDgRBM/9hvBKtshFvkhqPSyz@vger.kernel.org, AJvYcCV6LAlCZoLqS5DjpAn9jgo2dzPKwYGba2cAa3DpUf3HJi7hfnWMg987i8dwRHQrl1F2+yy6C91mVdaH@vger.kernel.org, AJvYcCXStVw/FHfXAAOJ1/dlTnjtP8Wtns36AtttAIuWnSpuqSezz2/n15RTk7hhmkRHWVDftuRmR5y1WjI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHF6d5fWPT+Y7rabXjEOIh5n5EIBIKdj6XGxiLkRYU6XA8wOcT
	xdCtp4HJ6ogmokaMZ2qz9EAkyxRKQinC6TDAXi905SJc3f+esovxK+9nGQ==
X-Gm-Gg: ASbGncu2Q+hYek5U3qQ8+kfVXwmvCG9VA75+wj0ZtC2UQIAsxGZxizLSi7mCvPfh8mP
	agTnDOAcpg/1ESPSrO8zkPrylQ+KlKlLsus2qlzlreLUDtJgnb2GXr2azrWPlEKyrzRR+CjU3CP
	cUGd4iKiwq2rEGroOAmTF3WCK9i5fNdT3lQd1/PpNitXKfX3CiS5S2bh9jDlAs81lMWsNMMp1Wi
	0X2i6+ZNlja7LwMegq8cAQNpxUYp2vGyHdpxBd5o9omVs4QvxsKdNYuyhf7+0S/U8zeeQWg1toi
	p9miKw==
X-Google-Smtp-Source: AGHT+IEN7SFcEbPjkCSpz63rHmauegYa8DXtmtw/QsuOHhwAYDnIFLz+Q2VTr2I0lD/FJ5hTScaFIw==
X-Received: by 2002:a05:600c:3d90:b0:42c:b9c8:2bb0 with SMTP id 5b1f17b1804b1-434ddea3252mr2352345e9.4.1733421695545;
        Thu, 05 Dec 2024 10:01:35 -0800 (PST)
Received: from Ansuel-XPS. (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d526b577sm69823015e9.3.2024.12.05.10.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 10:01:34 -0800 (PST)
Message-ID: <6751ea7e.050a0220.3435c6.5c62@mx.google.com>
X-Google-Original-Message-ID: <Z1HqerTDoNomKmKk@Ansuel-XPS.>
Date: Thu, 5 Dec 2024 19:01:30 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [PATCH v6 1/2] dt-bindings: cpufreq: Document support for Airoha
 EN7581 CPUFreq
References: <20241204182323.15192-1-ansuelsmth@gmail.com>
 <CAPDyKFqq03OnRoUiJkczbNFH4EHO6cFJkwTasdEzVSwDdxqUzg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFqq03OnRoUiJkczbNFH4EHO6cFJkwTasdEzVSwDdxqUzg@mail.gmail.com>

On Thu, Dec 05, 2024 at 05:07:07PM +0100, Ulf Hansson wrote:
> On Wed, 4 Dec 2024 at 19:24, Christian Marangi <ansuelsmth@gmail.com> wrote:
> >
> > Document required property for Airoha EN7581 CPUFreq .
> >
> > On newer Airoha SoC, CPU Frequency is scaled indirectly with SMCCC commands
> > to ATF and no clocks are exposed to the OS.
> >
> > The SoC have performance state described by ID for each OPP, for this a
> > Power Domain is used that sets the performance state ID according to the
> > required OPPs defined in the CPU OPP tables.
> 
> To clarify this, I would rather speak about a performance-domain with
> performance-levels, where each level corresponds to a frequency that
> is controlled by the FW/HW.

(If Rob notice this and gets angry :P , v6 was posted 10 minutes before
the review from Rob, big coincidence. No intention of ignoring the
comments)

I notice that power-domain schema also accepts node with
performance-domain. My concern is that the API we would use
(power-domain related) expect #power-domain-cells property and might
reject init with #power-performance-cells.

I have to check this but I think it's better to have a clear idea of
what the schema should be.

> 
> >
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> > Changes v6:
> > - No changes
> > Changes v5:
> > - Add Reviewed-by tag
> > - Fix OPP node name error
> > - Rename cpufreq node name to power-domain
> > - Rename CPU node power domain name to perf
> > - Add model and compatible to example
> > Changes v4:
> > - Add this patch
> >
> >  .../cpufreq/airoha,en7581-cpufreq.yaml        | 262 ++++++++++++++++++
> >  1 file changed, 262 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/cpufreq/airoha,en7581-cpufreq.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/cpufreq/airoha,en7581-cpufreq.yaml b/Documentation/devicetree/bindings/cpufreq/airoha,en7581-cpufreq.yaml
> > new file mode 100644
> > index 000000000000..7e36fa037e4b
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/cpufreq/airoha,en7581-cpufreq.yaml
> > @@ -0,0 +1,262 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/cpufreq/airoha,en7581-cpufreq.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Airoha EN7581 CPUFreq
> > +
> > +maintainers:
> > +  - Christian Marangi <ansuelsmth@gmail.com>
> > +
> > +description: |
> > +  On newer Airoha SoC, CPU Frequency is scaled indirectly with SMCCC commands
> > +  to ATF and no clocks are exposed to the OS.
> > +
> > +  The SoC have performance state described by ID for each OPP, for this a
> > +  Power Domain is used that sets the performance state ID according to the
> > +  required OPPs defined in the CPU OPP tables.
> > +
> > +properties:
> > +  compatible:
> > +    const: airoha,en7581-cpufreq
> > +
> > +  '#clock-cells':
> > +    const: 0
> 
> I think Rob questioned this too. Why do we need a clock provider here?
> 
> If this is only to keep the CPUfreq DT driver happy, I think this
> should be dropped. There is only a performance-domain here, right?
> 

As said in v5, the API is fun.
SMC have an OP to request the current frequency and that is provided in
MHz.

Then it does have a command to se the global frequency and that is in
Index.

Each index rapresent a particular frequency.

For CPUFreq-DT a clock is mandatory, and is also good to provide one.
But in v5 Rob was O.K. for the clock. The main complain is for the OPP
table.

> > +
> > +  '#power-domain-cells':
> > +    const: 0
> > +
> > +  operating-points-v2: true
> > +
> > +required:
> > +  - compatible
> > +  - '#clock-cells'
> > +  - '#power-domain-cells'
> > +  - operating-points-v2
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    / {
> > +        model = "Airoha EN7581 Evaluation Board";
> > +        compatible = "airoha,en7581-evb", "airoha,en7581";
> > +
> > +        #address-cells = <2>;
> > +       #size-cells = <2>;
> > +
> > +        cpus {
> > +            #address-cells = <1>;
> > +            #size-cells = <0>;
> > +
> > +            cpu0: cpu@0 {
> > +                device_type = "cpu";
> > +                compatible = "arm,cortex-a53";
> > +                reg = <0x0>;
> > +                operating-points-v2 = <&cpu_opp_table>;
> > +                enable-method = "psci";
> > +                clocks = <&cpu_pd>;
> > +                clock-names = "cpu";
> > +                power-domains = <&cpu_pd>;
> > +                power-domain-names = "perf";
> > +                next-level-cache = <&l2>;
> > +                #cooling-cells = <2>;
> > +            };
> > +
> > +            cpu1: cpu@1 {
> > +                device_type = "cpu";
> > +                compatible = "arm,cortex-a53";
> > +                reg = <0x1>;
> > +                operating-points-v2 = <&cpu_opp_table>;
> > +                enable-method = "psci";
> > +                clocks = <&cpu_pd>;
> > +                clock-names = "cpu";
> > +                power-domains = <&cpu_pd>;
> > +                power-domain-names = "perf";
> > +                next-level-cache = <&l2>;
> > +                #cooling-cells = <2>;
> > +            };
> > +
> > +            cpu2: cpu@2 {
> > +                device_type = "cpu";
> > +                compatible = "arm,cortex-a53";
> > +                reg = <0x2>;
> > +                operating-points-v2 = <&cpu_opp_table>;
> > +                enable-method = "psci";
> > +                clocks = <&cpu_pd>;
> > +                clock-names = "cpu";
> > +                power-domains = <&cpu_pd>;
> > +                power-domain-names = "perf";
> > +                next-level-cache = <&l2>;
> > +                #cooling-cells = <2>;
> > +            };
> > +
> > +            cpu3: cpu@3 {
> > +                device_type = "cpu";
> > +                compatible = "arm,cortex-a53";
> > +                reg = <0x3>;
> > +                operating-points-v2 = <&cpu_opp_table>;
> > +                enable-method = "psci";
> > +                clocks = <&cpu_pd>;
> > +                clock-names = "cpu";
> > +                power-domains = <&cpu_pd>;
> > +                power-domain-names = "perf";
> > +                next-level-cache = <&l2>;
> > +                #cooling-cells = <2>;
> > +            };
> > +        };
> > +
> > +        cpu_opp_table: opp-table-cpu {
> > +            compatible = "operating-points-v2";
> > +            opp-shared;
> > +
> > +            opp-500000000 {
> > +                opp-hz = /bits/ 64 <500000000>;
> > +                required-opps = <&smcc_opp0>;
> > +            };
> > +
> > +            opp-550000000 {
> > +                opp-hz = /bits/ 64 <550000000>;
> > +                required-opps = <&smcc_opp1>;
> > +            };
> > +
> > +            opp-600000000 {
> > +                opp-hz = /bits/ 64 <600000000>;
> > +                required-opps = <&smcc_opp2>;
> > +            };
> > +
> > +            opp-650000000 {
> > +                opp-hz = /bits/ 64 <650000000>;
> > +                required-opps = <&smcc_opp3>;
> > +            };
> > +
> > +            opp-7000000000 {
> > +                opp-hz = /bits/ 64 <700000000>;
> > +                required-opps = <&smcc_opp4>;
> > +            };
> > +
> > +            opp-7500000000 {
> > +                opp-hz = /bits/ 64 <750000000>;
> > +                required-opps = <&smcc_opp5>;
> > +            };
> > +
> > +            opp-8000000000 {
> > +                opp-hz = /bits/ 64 <800000000>;
> > +                required-opps = <&smcc_opp6>;
> > +            };
> > +
> > +            opp-8500000000 {
> > +                opp-hz = /bits/ 64 <850000000>;
> > +                required-opps = <&smcc_opp7>;
> > +            };
> > +
> > +            opp-9000000000 {
> > +                opp-hz = /bits/ 64 <900000000>;
> > +                required-opps = <&smcc_opp8>;
> > +            };
> > +
> > +            opp-9500000000 {
> > +                opp-hz = /bits/ 64 <950000000>;
> > +                required-opps = <&smcc_opp9>;
> > +            };
> > +
> > +            opp-10000000000 {
> > +                opp-hz = /bits/ 64 <1000000000>;
> > +                required-opps = <&smcc_opp10>;
> > +            };
> > +
> > +            opp-10500000000 {
> > +                opp-hz = /bits/ 64 <1050000000>;
> > +                required-opps = <&smcc_opp11>;
> > +            };
> > +
> > +            opp-11000000000 {
> > +                opp-hz = /bits/ 64 <1100000000>;
> > +                required-opps = <&smcc_opp12>;
> > +            };
> > +
> > +            opp-11500000000 {
> > +                opp-hz = /bits/ 64 <1150000000>;
> > +                required-opps = <&smcc_opp13>;
> > +            };
> > +
> > +            opp-12000000000 {
> > +                opp-hz = /bits/ 64 <1200000000>;
> > +                required-opps = <&smcc_opp14>;
> > +            };
> > +        };
> > +
> > +        cpu_smcc_opp_table: opp-table-smcc {
> > +            compatible = "operating-points-v2";
> > +
> > +            smcc_opp0: opp-0 {
> > +               opp-level = <0>;
> > +            };
> > +
> > +            smcc_opp1: opp-1 {
> > +                opp-level = <1>;
> > +            };
> > +
> > +            smcc_opp2: opp-2 {
> > +               opp-level = <2>;
> > +            };
> > +
> > +            smcc_opp3: opp-3 {
> > +               opp-level = <3>;
> > +            };
> > +
> > +            smcc_opp4: opp-4 {
> > +                opp-level = <4>;
> > +            };
> > +
> > +            smcc_opp5: opp-5 {
> > +                opp-level = <5>;
> > +            };
> > +
> > +            smcc_opp6: opp-6 {
> > +               opp-level = <6>;
> > +            };
> > +
> > +            smcc_opp7: opp-7 {
> > +               opp-level = <7>;
> > +            };
> > +
> > +            smcc_opp8: opp-8 {
> > +                opp-level = <8>;
> > +            };
> > +
> > +            smcc_opp9: opp-9 {
> > +               opp-level = <9>;
> > +            };
> > +
> > +            smcc_opp10: opp-10 {
> > +                opp-level = <10>;
> > +            };
> > +
> > +            smcc_opp11: opp-11 {
> > +                opp-level = <11>;
> > +            };
> > +
> > +            smcc_opp12: opp-12 {
> > +                opp-level = <12>;
> > +            };
> > +
> > +            smcc_opp13: opp-13 {
> > +                opp-level = <13>;
> > +            };
> > +
> > +            smcc_opp14: opp-14 {
> > +                opp-level = <14>;
> > +            };
> > +        };
> > +
> > +        cpu_pd: power-domain {
> 
> Nitpick: We could use the name *performance-domain* here instead, that
> would make it even more clear what this node describes.
> 
> > +            compatible = "airoha,en7581-cpufreq";
> > +
> > +            operating-points-v2 = <&cpu_smcc_opp_table>;
> > +
> > +            #power-domain-cells = <0>;
> > +            #clock-cells = <0>;
> > +        };
> > +    };
> > --
> > 2.45.2
> >
> 
> With those changes I am still happy with this approach, so feel free
> to keep my Reviewed-by tag.
> 

Thanks a lot for the hint. What I think should be understood and we need
to agree on is the OPP table.

Currently we have an implementation that is

CPU-OPP-Table: 
- OPP Freq in MHz 1
  - connection to OPP for performance-domain
  ...

Performance-Domain-OPP-Table:
- OPP Level 1 (connected to OPP Freq)

Is the double table the problem and we should find a way to unify it in
something like
CPU-OPP-Table:
- OPP Freq in MHz 1
  OPP Level 1

- OPP Freq in MHz 2
  OPP Level 2

...

From what I notice this is problematic as the 2 subsystems require
dedicated table for each other.
In any case I think a table of freq is a MUST. Dropping that would
result in not giving to the user an idea of the supported frequency and
scaling stats.

-- 
	Ansuel


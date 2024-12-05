Return-Path: <linux-pm+bounces-18608-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE869E507B
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 10:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF6CF169700
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 09:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746BA1D5AD3;
	Thu,  5 Dec 2024 09:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SATSsrW3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AC31D5AB5;
	Thu,  5 Dec 2024 09:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733389306; cv=none; b=DUNk5+8jbfm1XBTY3iXauSqBFovFBCAZyE0DG8Ez9QFVq5F2YOprDZnM2wG8r5tGhk8vTp3dEDPgVYaOturBKgGfrmVsBQA7IjojEEZCPeGy4YV+rkLpt/h+H/dW/iuF2CjwKrd6WgPVsdmaUDbOPZQIcYIpVRr5uYv4EYBYahA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733389306; c=relaxed/simple;
	bh=XuYULMiBftjpDFIBFODK/ppSNxVOuvr50FoE362c0Ew=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UiRkFRub120SKdF88qSUz68JQb5bUcwWeNg0caX6PDHgsBDfXCeEE1Oe2aegg3zqzK2MNUClfW1Obn5jLMmUZWoZl3wybhdvvxKdmJz8iTSTTE+3WDqEssAzSKaDxD+IMiNIHRQQ1heNgFNqmYdtTZAjNfN7DtNpWgcZ5n5Da8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SATSsrW3; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-434aa472617so4310195e9.3;
        Thu, 05 Dec 2024 01:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733389303; x=1733994103; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=obMHPp8QnXn2Bxov7fwvFKyDBRzMfibAxCgpcc97198=;
        b=SATSsrW3t29JUpBIXVH7hTRTWerai/Ekhrs38Jit7lzJU/UJg1Z5Vhq2CYIyyPG994
         g/WrU7wHvkTGCJWa++r5DYfxbm6HbpRcApcnMJoxhThUqF2IkczT8hWEBaSypX+H36E5
         h+JcBQqEOX9V5wadpMA8y0lHBpJgPwEZJeDA7WI/oRjTlAKoxhAZfgciDEQ4CyZoS3sh
         2eqjUas++YXtznrDUDIDWbx4jXtT59uBOmV45CmQZCeRFXONSOLINtvFxc8RedKmzBbl
         1zBrmXfsLE4QBVrjzZd9enGsSuC4G0ViMh33gykhW2I962Qjk3zjZDMqJPjGCZklYd/G
         sZXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733389303; x=1733994103;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=obMHPp8QnXn2Bxov7fwvFKyDBRzMfibAxCgpcc97198=;
        b=LrSFUJWs8JE4sUkTk/yg0ExDG5SFpCYIjLy0cPuDu0+0WAS/uUTP4Xol6evSBOjwom
         SIDWZzGdZLbFqtolQLYluga3n1YmiPsKNmnjcr6kVrwTts6N00Xg1gO0Eqs9RjswzmYF
         jFTEuEjI9BUc+glLuupUAxARTTFj7tvT1XQzk/eDtTOVh3Q/ypYpgsYyzsFCVlIt+VIJ
         F4LBq9dcFD/DYwa58WxkiIMe3NA1OYm/fbtRvofRYcrTAlUTjCqeYdyGx7ct+nmPEGoG
         ybViH2BGbLi4Zy4h+L6xGjkD/r7XlD0BvDvwPNDSzYKYDSdiss9I29pCzB8kOIMApWkw
         ZPJg==
X-Forwarded-Encrypted: i=1; AJvYcCUQrAijG6ciDYywn2YY1d8mDQ0T6h3Z4wJ2wBWrRpLq5AG8NnVFh+sgYNiRP4Q2e9fd8CpSmfL9uT4f@vger.kernel.org, AJvYcCVvVlPu6m1l6w6QDK8jAWcg5hdk4GPidywscOVfm3k3N6gqW6a2QZI8pK+lckzesvXu+91M7pO5Lls=@vger.kernel.org, AJvYcCWBHf3nLEQqI2auKWbk1MAzpiMdMCH5efVZTuexgZTzAFpIMn22m0XOajrd4dtsR4CJSrQ5FEsvh3qKSuux@vger.kernel.org
X-Gm-Message-State: AOJu0YwPjAl4c9uhE4aX9dxWpJPzZPoAo2SajIgWRwz/B3FuZA6BoNgh
	x7+fFmTCD4Q5saOc4kVTYc3ZwzyL9RH0elwm6JcVrqpUFGrj8iqE
X-Gm-Gg: ASbGnctG1ub/R2lHM0xMOrAcDVee9KTXBzEVJCpNzJqy6aTx4us1iXk8xWjvySfxKCo
	PmWbwQdPaNVzCyG6qtsEk7oXgPdheXmRmzVry5yvToFrsOu8y+v4urkNPNApjm5CS9vrFjjyz1b
	4at9raul8FuBINbPaHyXi6bEvbVbz87cOaAjYq2eRLrIueIzVKd3fX02fJG+98rSs/aR4V0YPkX
	d79KtV3cxHSYEvXmmQzSIzGiaVfngBQVCjDI1dBH9xlBld28nQGoEF64wvAb0afxi10zYPTGSCq
	QSSrRQ==
X-Google-Smtp-Source: AGHT+IHyCKkWM8ua2yW/ZCwMNBgslXXuCjaxGUgPwNObwte8DZaJItuxSPYEWEtpW0ky5nqIZCJaLQ==
X-Received: by 2002:a05:6000:2a1:b0:385:fc00:f5d4 with SMTP id ffacd0b85a97d-385fd3e9d3amr6567012f8f.29.1733389302433;
        Thu, 05 Dec 2024 01:01:42 -0800 (PST)
Received: from Ansuel-XPS. (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3861f4a85f2sm1361890f8f.29.2024.12.05.01.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 01:01:41 -0800 (PST)
Message-ID: <67516bf5.df0a0220.13e893.2b1b@mx.google.com>
X-Google-Original-Message-ID: <Z1Fr844XnU-byc5Z@Ansuel-XPS.>
Date: Thu, 5 Dec 2024 10:01:39 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Rob Herring <robh@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	upstream@airoha.com, Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v5 1/2] dt-bindings: cpufreq: Document support for Airoha
 EN7581 CPUFreq
References: <20241203163158.580-1-ansuelsmth@gmail.com>
 <20241204184253.GA276662-robh@kernel.org>
 <6750a4c3.df0a0220.1ae5b6.7dfb@mx.google.com>
 <CAL_JsqJvotQ=QZKq+CHs4uW_DRegn02YoSbqmxyi__6RJ0wAuA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqJvotQ=QZKq+CHs4uW_DRegn02YoSbqmxyi__6RJ0wAuA@mail.gmail.com>

On Wed, Dec 04, 2024 at 02:30:17PM -0600, Rob Herring wrote:
> On Wed, Dec 4, 2024 at 12:51 PM Christian Marangi <ansuelsmth@gmail.com> wrote:
> >
> > On Wed, Dec 04, 2024 at 12:42:53PM -0600, Rob Herring wrote:
> > > On Tue, Dec 03, 2024 at 05:31:49PM +0100, Christian Marangi wrote:
> > > > Document required property for Airoha EN7581 CPUFreq .
> > > >
> > > > On newer Airoha SoC, CPU Frequency is scaled indirectly with SMCCC commands
> > > > to ATF and no clocks are exposed to the OS.
> > > >
> > > > The SoC have performance state described by ID for each OPP, for this a
> > > > Power Domain is used that sets the performance state ID according to the
> > > > required OPPs defined in the CPU OPP tables.
> > > >
> > > > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > > > Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > > ---
> > > > Changes v5:
> > > > - Add Reviewed-by tag
> > > > - Fix OPP node name error
> > > > - Rename cpufreq node name to power-domain
> > > > - Rename CPU node power domain name to perf
> > > > - Add model and compatible to example
> > > > Changes v4:
> > > > - Add this patch
> > > >
> > > >  .../cpufreq/airoha,en7581-cpufreq.yaml        | 262 ++++++++++++++++++
> > > >  1 file changed, 262 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/cpufreq/airoha,en7581-cpufreq.yaml
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/cpufreq/airoha,en7581-cpufreq.yaml b/Documentation/devicetree/bindings/cpufreq/airoha,en7581-cpufreq.yaml
> > > > new file mode 100644
> > > > index 000000000000..7e36fa037e4b
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/cpufreq/airoha,en7581-cpufreq.yaml
> > > > @@ -0,0 +1,262 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/cpufreq/airoha,en7581-cpufreq.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Airoha EN7581 CPUFreq
> > > > +
> > > > +maintainers:
> > > > +  - Christian Marangi <ansuelsmth@gmail.com>
> > > > +
> > > > +description: |
> > > > +  On newer Airoha SoC, CPU Frequency is scaled indirectly with SMCCC commands
> > > > +  to ATF and no clocks are exposed to the OS.
> > > > +
> > > > +  The SoC have performance state described by ID for each OPP, for this a
> > > > +  Power Domain is used that sets the performance state ID according to the
> > > > +  required OPPs defined in the CPU OPP tables.
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    const: airoha,en7581-cpufreq
> > > > +
> > > > +  '#clock-cells':
> > > > +    const: 0
> > >
> > > You just said no clocks are exposed to the OS.
> > >
> >
> > Well we now simulate one due to request from cpufreq reviewers.
> >
> > Everything is still handled by SMC that only report the current
> > frequency of the CPU.
> >
> > > > +
> > > > +  '#power-domain-cells':
> > > > +    const: 0
> > > > +
> > > > +  operating-points-v2: true
> > > > +
> > > > +required:
> > > > +  - compatible
> > > > +  - '#clock-cells'
> > > > +  - '#power-domain-cells'
> > > > +  - operating-points-v2
> > > > +
> > > > +additionalProperties: false
> > > > +
> > > > +examples:
> > > > +  - |
> > > > +    / {
> > > > +        model = "Airoha EN7581 Evaluation Board";
> > > > +        compatible = "airoha,en7581-evb", "airoha,en7581";
> > > > +
> > > > +        #address-cells = <2>;
> > > > +           #size-cells = <2>;
> > >
> > > mixed tab and spaces.
> > >
> > > Can't I just go read the actual .dts files if I want to see
> > > *everything*? Examples should generally be just what the schema covers.
> > >
> >
> > Idea here is to give example as both clock and power-domain property are
> > needed in the CPU nodes for the CPUFreq driver to correctly work.
> 
> If we want to do that, then we really should have a schema defining
> that. But since there's only 1 for cpus that doesn't really work.
> 
> > Should I drop and just define the CPUFreq node?
> 
> Yes.
> 
> > > > +
> > > > +        cpus {
> > > > +            #address-cells = <1>;
> > > > +            #size-cells = <0>;
> > > > +
> > > > +            cpu0: cpu@0 {
> > > > +                device_type = "cpu";
> > > > +                compatible = "arm,cortex-a53";
> > > > +                reg = <0x0>;
> > > > +                operating-points-v2 = <&cpu_opp_table>;
> > > > +                enable-method = "psci";
> > > > +                clocks = <&cpu_pd>;
> > > > +                clock-names = "cpu";
> > > > +                power-domains = <&cpu_pd>;
> > > > +                power-domain-names = "perf";
> > > > +                next-level-cache = <&l2>;
> > > > +                #cooling-cells = <2>;
> > >
> > > I don't understand why you have clocks, power-domains and OPP?
> > > Certainly that's conceivable, but not with how you're abusing
> > > power-domains for performance points and you said clocks are not exposed
> > > to the OS.
> > >
> >
> > SMC scale based on index values not frequency. That really resembles a
> > power-domain.
> 
> So what is the point of the OPP table with frequency? You can set an
> OPP and read the frequency, right? So a table of frequencies is
> redundant.
>

The OPP for CPU node is to describe the supported frequency and then
each OPP have a required-opp property to describe the level to configure
the power-domain. It's really to make a connection between the 2. I need
to check but from my test the separate OPP table for the power domain is
needed or it does refuse to probe.

This is a common pattern also used by Qcom and Mediatek. Example qcs404 [0]

As you notice the very same pattern is used here.

> > SMC provide frequency in MHz tho so we model that as a
> > get-only clock.
> >
> > At times with no clocks are exposed I intend that they SoC doesn't
> > provide any raw control on them in the normal way with a register, bits
> > to change and logic to apply for mux and divisor, this thing is very
> > special and works only with 2 command and nothing else so I'm trying my
> > best to model this in the most descriptive and complete way possible.
> 
> Fair enough for the clock. Please clarify the description with what
> clock is provided. Just to make sure, all CPUs run at the same
> frequency?
>

Ok, yes it's all global also signaled by the opp-shared property.

[0] https://elixir.bootlin.com/linux/v6.12.1/source/arch/arm64/boot/dts/qcom/qcs404.dtsi

-- 
	Ansuel


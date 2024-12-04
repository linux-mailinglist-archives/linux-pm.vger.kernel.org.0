Return-Path: <linux-pm+bounces-18567-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 788DD9E43CA
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 19:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DD99288E4A
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 18:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87CEA1F03C1;
	Wed,  4 Dec 2024 18:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b4BuzMla"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912C41C3BEA;
	Wed,  4 Dec 2024 18:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733338311; cv=none; b=uXqwqVFA/EUB8sSPYEQbpSEBmLUL4cv73LcuPPgy0BS3vVN+tMdzTisuBH3EvmQdir1b2KSCFVDWYACryuz1HbvJ8Y/nIDjImi3lkOMz+qTJAUmTvvrX4Qx4T/wLLbMg9XWSTpvNagpFoAn7uij7E96QdZ5tGssA4Ss/bINI/PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733338311; c=relaxed/simple;
	bh=aus5ttiJBjX8TTS/MUwcPkdHy467UoHfp/FpjH86Mg4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lo3yc4MBiLmdQH0vmjzuhL2miLYhGfZDc0L3LlmLxYG448O0BmAtkZWiuyB1wHZB45SdfAQl0NDqaCWapwcZ+R1XYZT9jMhMY/5IBQhMegd3rrX5K+0GUyBxaKb4NSwF3cQoI+jJdGE0KIQKReoO2pVyH2u3zLW3pEsDNPWk4hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b4BuzMla; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-434a852bb6eso1099725e9.3;
        Wed, 04 Dec 2024 10:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733338308; x=1733943108; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=G2budqkyjwQzfiA3PJrrIbqw0C+9tNy8E+0PJaztpSs=;
        b=b4BuzMlaiypc4qFwxP3Mr30y12b8FFjU2Bx0bIZwz37dU0RcV93uQ/ImTfBzKt5XXp
         RQFQ6tNFtFQJUkNuXyxfpbQs7s80Q9JGhZyW94HYSIdyi4AruglYf+Q/YP7IluZPQdLz
         A+RNViwh7FzJcpRy0Xpcb2cCGAwlFzGtBe96lHM/tEsCNOEN71m6Hwe6w9VLURW7zGbB
         863lb6GMXKC2SqJPihudPlunU+CXWBnNHXLr2LLi+TStRSrkVzTHxW5s1QbNTDAyO80z
         J8ORXohG+txnyOyOYGrCEv/WDfNO8Q+Pv7EZ+jUN1T5pZMqpykvhIswAWX6NVZ5l2ncn
         i8tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733338308; x=1733943108;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G2budqkyjwQzfiA3PJrrIbqw0C+9tNy8E+0PJaztpSs=;
        b=p2DjaZHI8HWpxst+VH6Js5yTUDi5La9hwXzKcSMBcLIVvnSoDpGqBU7vuLJKvLe0aG
         Vu+Jom6V33jmLJWbPt8apyjkXFQHhmD6IkivQlog6T32YqsY1O8uUCPLnoqxYPpNOiPS
         XfTTs3mDkTXMs6Wjcjagny1sqkoVZkPYCIx4ozZcIJSDB2pwUWWC4/E0yJ5M7IMKVRBd
         5fiZc8rD8SVXQ3TrAGDWrNBZg89vLkzRda1Z2SXakdNzImUZjpgZrgjtfujGjBOFSt7E
         UDCkQcWLSQKQcB31khdrJMhGOKBy8RHK1Wwe5zASFI6E29S4jJQHUqGAm8GZLc8peaZQ
         LyNw==
X-Forwarded-Encrypted: i=1; AJvYcCV/rfAOhpA5Z0JkdTjqzRRd3Y4ypkzFEvs0wXeweAMZLSVQGuNHi+BzDpaF/DcPS6Z8FIL2NyVGL8s=@vger.kernel.org, AJvYcCWi0meZSlxV6Idz9Tgya2KQFQerxr1JL6ueSU4wfZto58oNO4x9G+Sjdcu79fblut3SVmHGpXHH33hh@vger.kernel.org, AJvYcCWtdPN4rxnFF7ucJ6hytFwEVzBD794A9BnuAKQg9TJwKNh7+Pj1HyWNQSZQ7CmTnbnXP7+7Uf3wBXpqdRzj@vger.kernel.org
X-Gm-Message-State: AOJu0YxgG7w02t/g7FO6vFWSd6ip1Js4z3aWdQgGa32sl5SCkwwm8aSW
	1T06h5oF7LDc8WjVNWtwKaovZll2oEjRDfzjPl5iyYwyU4wWDcTi
X-Gm-Gg: ASbGncs2LsupXriCCvNnf8CDMHGxkQzIlWfMSbGghQTCz5PpAqbZDrDApKM5khhzyaQ
	XhAz2m+ag07tJmhn0PDRV2BrGFN/k4FMIiLmKLiO4+TP9zq1iSnf67XpWhtPDNjHmcSGsCAAQEm
	gY31cVMp34CIsuypO5+FuSIrkPAEfIPb/8s13EBitkgPmGAWJA+N/xnafnRG46Ek1EfBY+4QJ3L
	fozMUhsEt688cRb6uenqeD6dXpMAkdw51HCw2YWZXJdeUakuQr+DYghQwoYJiPU3ZjjFRqdlWfV
	RzpNNA==
X-Google-Smtp-Source: AGHT+IGV7yI0RSjvJMHWzI+iV4/blqIMxoqbn7RFl7Mrhxn/sjo8KAXamWM1dtw4lQT+BcFERYpDKg==
X-Received: by 2002:a05:600c:4450:b0:431:5043:87c3 with SMTP id 5b1f17b1804b1-434d0a07e39mr63645985e9.22.1733338307557;
        Wed, 04 Dec 2024 10:51:47 -0800 (PST)
Received: from Ansuel-XPS. (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e38078f7sm13641200f8f.111.2024.12.04.10.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 10:51:47 -0800 (PST)
Message-ID: <6750a4c3.df0a0220.1ae5b6.7dfb@mx.google.com>
X-Google-Original-Message-ID: <Z1Ckwa_IZ5txpLEE@Ansuel-XPS.>
Date: Wed, 4 Dec 2024 19:51:45 +0100
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
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204184253.GA276662-robh@kernel.org>

On Wed, Dec 04, 2024 at 12:42:53PM -0600, Rob Herring wrote:
> On Tue, Dec 03, 2024 at 05:31:49PM +0100, Christian Marangi wrote:
> > Document required property for Airoha EN7581 CPUFreq .
> > 
> > On newer Airoha SoC, CPU Frequency is scaled indirectly with SMCCC commands
> > to ATF and no clocks are exposed to the OS.
> > 
> > The SoC have performance state described by ID for each OPP, for this a
> > Power Domain is used that sets the performance state ID according to the
> > required OPPs defined in the CPU OPP tables.
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
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
> You just said no clocks are exposed to the OS.
>

Well we now simulate one due to request from cpufreq reviewers.

Everything is still handled by SMC that only report the current
frequency of the CPU.

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
> > +      	#size-cells = <2>;
> 
> mixed tab and spaces.
> 
> Can't I just go read the actual .dts files if I want to see 
> *everything*? Examples should generally be just what the schema covers.
>

Idea here is to give example as both clock and power-domain property are
needed in the CPU nodes for the CPUFreq driver to correctly work.

Should I drop and just define the CPUFreq node?

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
> 
> I don't understand why you have clocks, power-domains and OPP? 
> Certainly that's conceivable, but not with how you're abusing 
> power-domains for performance points and you said clocks are not exposed 
> to the OS.
>

SMC scale based on index values not frequency. That really resembles a
power-domain. SMC provide frequency in MHz tho so we model that as a
get-only clock.

At times with no clocks are exposed I intend that they SoC doesn't
provide any raw control on them in the normal way with a register, bits
to change and logic to apply for mux and divisor, this thing is very
special and works only with 2 command and nothing else so I'm trying my
best to model this in the most descriptive and complete way possible.

-- 
	Ansuel


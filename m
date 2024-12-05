Return-Path: <linux-pm+bounces-18628-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A739E5AC3
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 17:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FC7318846B9
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 16:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35AD21D585;
	Thu,  5 Dec 2024 16:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VtFKL0JX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A74421C197
	for <linux-pm@vger.kernel.org>; Thu,  5 Dec 2024 16:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733414868; cv=none; b=CEQ68QPO/F7jmFWgN1Bf16uV6jr/yXGomXvZaRCKMy2PsveKPDzKNN7QiAxml5J2UO5e/dy76iq+N6wzHd5i86TwePPPDSyB6LKdLECVUgMzoo6F1sdlctD+ma+Ssa37BXphQW/m2UA+za6CLRW8Vq9tpBicYAasxgPhI4ugge0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733414868; c=relaxed/simple;
	bh=bS1AiJeyV1FdE50S5p/ntCiwbSksmeWWJTfmSZhcetw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IRw42izmx3ZFqIulGad7/jY5YzYqHzKvzoYnx2h39uVq41BZjyriNsybG3/J0nx5iQObLM1n6mZ8KrfpAoLlnPRgMeeBsBz3ApEKXTYXbK7m1hz1E3qT3iRgemzWNwyJ9A6rwsPzQBtgnPu5/M/S+ssa9OS31NnXose65KjKCfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VtFKL0JX; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5d122cf8dd1so1767234a12.2
        for <linux-pm@vger.kernel.org>; Thu, 05 Dec 2024 08:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733414865; x=1734019665; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=x+V7m48apPBjAuCJ6fyNfCURcukhtBD0FGIuBJwZd0c=;
        b=VtFKL0JXs0WtMuj1f6TSF+LyW0w6KgCrV3BIF12WAtUwuPvR6SDVE2li8c5iGuzEBO
         JFS+nhoY9LnONE+6CHg9HGiqvwAc3GBoBa/RXGgsQ1NBJr07b9qgsNiMsWyU8fWCF5AL
         XAt/Y5Jw8MlYehR2o3PZiQyxodAmrTy22ZO2mIvrhiW0qNRN/MPIQOOpiBDcmgtqF3cK
         RbrPCH+Cgd1P7ic1WrhUU8WC2mor4br0WK9UM1y/yskO7ch4ZEXdE5EKBM7nm8uiKXnL
         /2u2zE6iOM/CEUh5xtC451mclQVdO6BWtS2lS7sGW9oKcmxQ40MUsBo0WdQPCJhm3NC0
         MPdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733414865; x=1734019665;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x+V7m48apPBjAuCJ6fyNfCURcukhtBD0FGIuBJwZd0c=;
        b=T5w9DRphvkLTfYHDqHC6JjCF9F7Puyf8AchT1EEi1xW1CcGU+SsakCoWu/jccvP6bx
         gTHcyqrGt4LtLChDoElbyTv4ZFA7VEpEznjJ60JrI328f5lLI6fgTDGesqFm+RvfbFn3
         fyGaKQJJE/+hkReHqTJh1HwOPEfUvSefoxGt17lHUEIcjRAxh0rSF3FlBnbjpTRAQlkd
         F5VDIFhbU4bHGFTeY+N6Y2h8zpejieBwkUOsXmgsgSDiP8joLwb+yHSn3hFq3gBN1fLV
         dl0VFgSFJP5MG5z/1+IzlJM1lPvLw+wk4vWLmUA/MAvs9NuQdDGagkclas2nKwjQZmoK
         ZsFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSRIr0CWlbzyaeR3vDz4Qm0u/ZJU/P5labiPJy50ZrxFag45odrOrTvgl6sMftrtlZlj8LYs19yQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwOgfvt/PMRGZgPzP86CcIjK2GX4sRKdpFmPsFTyJcCuNZjYknH
	SseFMuexEneYz5pWHYOMI1WN+v5tK0lbkIbzZh7ReHS1xF5UtmpIfle/iswJgT9knofxT3WnyON
	NfOCYW5wXdlCUyegaM/7ZyWd1bfqQkJd3uMZrUw==
X-Gm-Gg: ASbGncvTxHUn85H/X0u9NesulUuSnWHs5lbxUCxYVnwvcZ9xD8JtcfZzvHHFNFsbEzq
	MvQCG2hzX9oOeYiVNjr7ujlj8CB+E+VBt1JnfQViA3aBmboj8I1uYgC5V68s1SCG4FQ==
X-Google-Smtp-Source: AGHT+IGrEDZp6sJ4+Bu2mkylebWpYdSyYAxZtnULPylirbVqfrRu6SF8zr3etJzVy0DqT1d10gEiV+p5oLfQq079TOk=
X-Received: by 2002:a17:906:2189:b0:aa6:1aaf:87e3 with SMTP id
 a640c23a62f3a-aa61aaf8da4mr439853466b.2.1733414864813; Thu, 05 Dec 2024
 08:07:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204182323.15192-1-ansuelsmth@gmail.com>
In-Reply-To: <20241204182323.15192-1-ansuelsmth@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 5 Dec 2024 17:07:07 +0100
Message-ID: <CAPDyKFqq03OnRoUiJkczbNFH4EHO6cFJkwTasdEzVSwDdxqUzg@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] dt-bindings: cpufreq: Document support for Airoha
 EN7581 CPUFreq
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, upstream@airoha.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 4 Dec 2024 at 19:24, Christian Marangi <ansuelsmth@gmail.com> wrote:
>
> Document required property for Airoha EN7581 CPUFreq .
>
> On newer Airoha SoC, CPU Frequency is scaled indirectly with SMCCC commands
> to ATF and no clocks are exposed to the OS.
>
> The SoC have performance state described by ID for each OPP, for this a
> Power Domain is used that sets the performance state ID according to the
> required OPPs defined in the CPU OPP tables.

To clarify this, I would rather speak about a performance-domain with
performance-levels, where each level corresponds to a frequency that
is controlled by the FW/HW.

>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
> Changes v6:
> - No changes
> Changes v5:
> - Add Reviewed-by tag
> - Fix OPP node name error
> - Rename cpufreq node name to power-domain
> - Rename CPU node power domain name to perf
> - Add model and compatible to example
> Changes v4:
> - Add this patch
>
>  .../cpufreq/airoha,en7581-cpufreq.yaml        | 262 ++++++++++++++++++
>  1 file changed, 262 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/airoha,en7581-cpufreq.yaml
>
> diff --git a/Documentation/devicetree/bindings/cpufreq/airoha,en7581-cpufreq.yaml b/Documentation/devicetree/bindings/cpufreq/airoha,en7581-cpufreq.yaml
> new file mode 100644
> index 000000000000..7e36fa037e4b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/cpufreq/airoha,en7581-cpufreq.yaml
> @@ -0,0 +1,262 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/cpufreq/airoha,en7581-cpufreq.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Airoha EN7581 CPUFreq
> +
> +maintainers:
> +  - Christian Marangi <ansuelsmth@gmail.com>
> +
> +description: |
> +  On newer Airoha SoC, CPU Frequency is scaled indirectly with SMCCC commands
> +  to ATF and no clocks are exposed to the OS.
> +
> +  The SoC have performance state described by ID for each OPP, for this a
> +  Power Domain is used that sets the performance state ID according to the
> +  required OPPs defined in the CPU OPP tables.
> +
> +properties:
> +  compatible:
> +    const: airoha,en7581-cpufreq
> +
> +  '#clock-cells':
> +    const: 0

I think Rob questioned this too. Why do we need a clock provider here?

If this is only to keep the CPUfreq DT driver happy, I think this
should be dropped. There is only a performance-domain here, right?

> +
> +  '#power-domain-cells':
> +    const: 0
> +
> +  operating-points-v2: true
> +
> +required:
> +  - compatible
> +  - '#clock-cells'
> +  - '#power-domain-cells'
> +  - operating-points-v2
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    / {
> +        model = "Airoha EN7581 Evaluation Board";
> +        compatible = "airoha,en7581-evb", "airoha,en7581";
> +
> +        #address-cells = <2>;
> +       #size-cells = <2>;
> +
> +        cpus {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            cpu0: cpu@0 {
> +                device_type = "cpu";
> +                compatible = "arm,cortex-a53";
> +                reg = <0x0>;
> +                operating-points-v2 = <&cpu_opp_table>;
> +                enable-method = "psci";
> +                clocks = <&cpu_pd>;
> +                clock-names = "cpu";
> +                power-domains = <&cpu_pd>;
> +                power-domain-names = "perf";
> +                next-level-cache = <&l2>;
> +                #cooling-cells = <2>;
> +            };
> +
> +            cpu1: cpu@1 {
> +                device_type = "cpu";
> +                compatible = "arm,cortex-a53";
> +                reg = <0x1>;
> +                operating-points-v2 = <&cpu_opp_table>;
> +                enable-method = "psci";
> +                clocks = <&cpu_pd>;
> +                clock-names = "cpu";
> +                power-domains = <&cpu_pd>;
> +                power-domain-names = "perf";
> +                next-level-cache = <&l2>;
> +                #cooling-cells = <2>;
> +            };
> +
> +            cpu2: cpu@2 {
> +                device_type = "cpu";
> +                compatible = "arm,cortex-a53";
> +                reg = <0x2>;
> +                operating-points-v2 = <&cpu_opp_table>;
> +                enable-method = "psci";
> +                clocks = <&cpu_pd>;
> +                clock-names = "cpu";
> +                power-domains = <&cpu_pd>;
> +                power-domain-names = "perf";
> +                next-level-cache = <&l2>;
> +                #cooling-cells = <2>;
> +            };
> +
> +            cpu3: cpu@3 {
> +                device_type = "cpu";
> +                compatible = "arm,cortex-a53";
> +                reg = <0x3>;
> +                operating-points-v2 = <&cpu_opp_table>;
> +                enable-method = "psci";
> +                clocks = <&cpu_pd>;
> +                clock-names = "cpu";
> +                power-domains = <&cpu_pd>;
> +                power-domain-names = "perf";
> +                next-level-cache = <&l2>;
> +                #cooling-cells = <2>;
> +            };
> +        };
> +
> +        cpu_opp_table: opp-table-cpu {
> +            compatible = "operating-points-v2";
> +            opp-shared;
> +
> +            opp-500000000 {
> +                opp-hz = /bits/ 64 <500000000>;
> +                required-opps = <&smcc_opp0>;
> +            };
> +
> +            opp-550000000 {
> +                opp-hz = /bits/ 64 <550000000>;
> +                required-opps = <&smcc_opp1>;
> +            };
> +
> +            opp-600000000 {
> +                opp-hz = /bits/ 64 <600000000>;
> +                required-opps = <&smcc_opp2>;
> +            };
> +
> +            opp-650000000 {
> +                opp-hz = /bits/ 64 <650000000>;
> +                required-opps = <&smcc_opp3>;
> +            };
> +
> +            opp-7000000000 {
> +                opp-hz = /bits/ 64 <700000000>;
> +                required-opps = <&smcc_opp4>;
> +            };
> +
> +            opp-7500000000 {
> +                opp-hz = /bits/ 64 <750000000>;
> +                required-opps = <&smcc_opp5>;
> +            };
> +
> +            opp-8000000000 {
> +                opp-hz = /bits/ 64 <800000000>;
> +                required-opps = <&smcc_opp6>;
> +            };
> +
> +            opp-8500000000 {
> +                opp-hz = /bits/ 64 <850000000>;
> +                required-opps = <&smcc_opp7>;
> +            };
> +
> +            opp-9000000000 {
> +                opp-hz = /bits/ 64 <900000000>;
> +                required-opps = <&smcc_opp8>;
> +            };
> +
> +            opp-9500000000 {
> +                opp-hz = /bits/ 64 <950000000>;
> +                required-opps = <&smcc_opp9>;
> +            };
> +
> +            opp-10000000000 {
> +                opp-hz = /bits/ 64 <1000000000>;
> +                required-opps = <&smcc_opp10>;
> +            };
> +
> +            opp-10500000000 {
> +                opp-hz = /bits/ 64 <1050000000>;
> +                required-opps = <&smcc_opp11>;
> +            };
> +
> +            opp-11000000000 {
> +                opp-hz = /bits/ 64 <1100000000>;
> +                required-opps = <&smcc_opp12>;
> +            };
> +
> +            opp-11500000000 {
> +                opp-hz = /bits/ 64 <1150000000>;
> +                required-opps = <&smcc_opp13>;
> +            };
> +
> +            opp-12000000000 {
> +                opp-hz = /bits/ 64 <1200000000>;
> +                required-opps = <&smcc_opp14>;
> +            };
> +        };
> +
> +        cpu_smcc_opp_table: opp-table-smcc {
> +            compatible = "operating-points-v2";
> +
> +            smcc_opp0: opp-0 {
> +               opp-level = <0>;
> +            };
> +
> +            smcc_opp1: opp-1 {
> +                opp-level = <1>;
> +            };
> +
> +            smcc_opp2: opp-2 {
> +               opp-level = <2>;
> +            };
> +
> +            smcc_opp3: opp-3 {
> +               opp-level = <3>;
> +            };
> +
> +            smcc_opp4: opp-4 {
> +                opp-level = <4>;
> +            };
> +
> +            smcc_opp5: opp-5 {
> +                opp-level = <5>;
> +            };
> +
> +            smcc_opp6: opp-6 {
> +               opp-level = <6>;
> +            };
> +
> +            smcc_opp7: opp-7 {
> +               opp-level = <7>;
> +            };
> +
> +            smcc_opp8: opp-8 {
> +                opp-level = <8>;
> +            };
> +
> +            smcc_opp9: opp-9 {
> +               opp-level = <9>;
> +            };
> +
> +            smcc_opp10: opp-10 {
> +                opp-level = <10>;
> +            };
> +
> +            smcc_opp11: opp-11 {
> +                opp-level = <11>;
> +            };
> +
> +            smcc_opp12: opp-12 {
> +                opp-level = <12>;
> +            };
> +
> +            smcc_opp13: opp-13 {
> +                opp-level = <13>;
> +            };
> +
> +            smcc_opp14: opp-14 {
> +                opp-level = <14>;
> +            };
> +        };
> +
> +        cpu_pd: power-domain {

Nitpick: We could use the name *performance-domain* here instead, that
would make it even more clear what this node describes.

> +            compatible = "airoha,en7581-cpufreq";
> +
> +            operating-points-v2 = <&cpu_smcc_opp_table>;
> +
> +            #power-domain-cells = <0>;
> +            #clock-cells = <0>;
> +        };
> +    };
> --
> 2.45.2
>

With those changes I am still happy with this approach, so feel free
to keep my Reviewed-by tag.

Kind regards
Uffe


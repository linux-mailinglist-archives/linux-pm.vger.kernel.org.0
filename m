Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D935714ECE3
	for <lists+linux-pm@lfdr.de>; Fri, 31 Jan 2020 14:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbgAaNFX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 31 Jan 2020 08:05:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:55756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728514AbgAaNFX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 31 Jan 2020 08:05:23 -0500
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F38F215A4;
        Fri, 31 Jan 2020 13:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580475922;
        bh=qFY7ucXHrN4k9SomscL/5CeYo3grnsdPM8fcyq7j1fE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nIQEP8mzK2r0uiBLI6VqL0j5hLbabW6ZCaRIIAWoW9WJesZKa1bMszimARV8eE7VG
         yNOmps5m8YwT15KJpe4VdZaC02k9viWOpt4t/b0MjNRGQcNwLt4wlBlHmtoC8TK/nY
         BLBLJI69Ui/VvIQKVNVLv/FS/RiuF1I74J7AJygs=
Received: by mail-lj1-f179.google.com with SMTP id n18so6992684ljo.7;
        Fri, 31 Jan 2020 05:05:22 -0800 (PST)
X-Gm-Message-State: APjAAAXvNi5HBxaHZxxhHe1iSOGWHyTSbZCsEkBSxMx/ASC9ZEY2L4W2
        XiesvH6M82EJCC7ZwbigLwBahbNI39z2wR94n6k=
X-Google-Smtp-Source: APXvYqzqfHmDn+QFhEv+TrLKTcwhUeNTIgNZ0cG1Ae/WPNpeaCTKvGV3l0akORodBNWjmfBEKG6afCmv5wVBB7ZI+Dg=
X-Received: by 2002:a2e:7812:: with SMTP id t18mr6099414ljc.289.1580475920245;
 Fri, 31 Jan 2020 05:05:20 -0800 (PST)
MIME-Version: 1.0
References: <20200127215453.15144-1-lukasz.luba@arm.com> <20200127215453.15144-3-lukasz.luba@arm.com>
In-Reply-To: <20200127215453.15144-3-lukasz.luba@arm.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 31 Jan 2020 14:05:09 +0100
X-Gmail-Original-Message-ID: <CAJKOXPcgC1xE2=-=_hqvqrBCBzQF4113+wez=3Lqp71=yv8gZw@mail.gmail.com>
Message-ID: <CAJKOXPcgC1xE2=-=_hqvqrBCBzQF4113+wez=3Lqp71=yv8gZw@mail.gmail.com>
Subject: Re: [PATCH 2/3] ARM: dts: exynos: Add Exynos5422 CPU
 dynamic-power-coefficient information
To:     lukasz.luba@arm.com
Cc:     kgene@kernel.org, linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        Chanwoo Choi <cw00.choi@samsung.com>, robh+dt@kernel.org,
        mark.rutland@arm.com,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>, dietmar.eggemann@arm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 27 Jan 2020 at 22:55, <lukasz.luba@arm.com> wrote:
>
> From: Lukasz Luba <lukasz.luba@arm.com>
>
> Add dynamic power coefficient into CPU nodes which let CPUFreq subsystem
> register the Energy Model (EM) for the CPUs.
>
> The 'dynamic-power-coefficient' is used for calculating the dynamic power
> according to the equation in documentation [1].  The Energy Model (EM)
> framework relies on calculated power and cost for each OPP. The OPP power
> values come from CPUFreq driver, which registered required callback
> function. The simple implementation of a CPUFREQ driver, like cpufreq-dt,
> uses 'dev_pm_opp_of_register_em()' which relay on
> 'dynamic-power-coefficient' to calculate the power of requested OPP for the
> EM [2].
>
> The calculated values might be checked in
> /sys/kernel/debug/energy_model/pd*/
>
> $ grep . /sys/kernel/debug/energy_model/pd1/cs*/*
> /sys/kernel/debug/energy_model/pd1/cs:1000000/cost:558
> /sys/kernel/debug/energy_model/pd1/cs:1000000/frequency:1000000
> /sys/kernel/debug/energy_model/pd1/cs:1000000/power:310
> /sys/kernel/debug/energy_model/pd1/cs:1100000/cost:558
> /sys/kernel/debug/energy_model/pd1/cs:1100000/frequency:1100000
> /sys/kernel/debug/energy_model/pd1/cs:1100000/power:341
> /sys/kernel/debug/energy_model/pd1/cs:1200000/cost:558
> /sys/kernel/debug/energy_model/pd1/cs:1200000/frequency:1200000
> /sys/kernel/debug/energy_model/pd1/cs:1200000/power:372
> /sys/kernel/debug/energy_model/pd1/cs:1300000/cost:674
> /sys/kernel/debug/energy_model/pd1/cs:1300000/frequency:1300000
> /sys/kernel/debug/energy_model/pd1/cs:1300000/power:487
> /sys/kernel/debug/energy_model/pd1/cs:1400000/cost:675 ...
>
> $ grep . /sys/kernel/debug/energy_model/pd0/cs*/*
> /sys/kernel/debug/energy_model/pd0/cs:1000000/cost:200
> /sys/kernel/debug/energy_model/pd0/cs:1000000/frequency:1000000
> /sys/kernel/debug/energy_model/pd0/cs:1000000/power:154
> /sys/kernel/debug/energy_model/pd0/cs:1100000/cost:260
> /sys/kernel/debug/energy_model/pd0/cs:1100000/frequency:1100000
> /sys/kernel/debug/energy_model/pd0/cs:1100000/power:220
> /sys/kernel/debug/energy_model/pd0/cs:1200000/cost:260
> /sys/kernel/debug/energy_model/pd0/cs:1200000/frequency:1200000
> /sys/kernel/debug/energy_model/pd0/cs:1200000/power:240
> /sys/kernel/debug/energy_model/pd0/cs:1300000/cost:260
> /sys/kernel/debug/energy_model/pd0/cs:1300000/frequency:1300000
> /sys/kernel/debug/energy_model/pd0/cs:1300000/power:260
> /sys/kernel/debug/energy_model/pd0/cs:200000/cost:130 ...

Please, do not describe entire Energy Model in commit message touching
DTS. It brings too much information which look unrelated and therefore
it makes difficult to spot real rationale behind the change. Just
mention:
1. Why you are doing it?
2. What are you doing?
3. How did you figure out magic constants here (details of "what")?

> To provide a proper value of the 'dynamic-power-coefficient' the real power
> can be measured using a dedicated hardware, i.e. INA2xx. The Odroid-XU3
> hwmon sensors have been used to capture the power value during a sysbench
> test running on single core and at each possible OPP.

Since you mention the values, post them. That's the only thing which
reader cannot get on his own. All other values posted in commit
message will be seen after running tests...

> The measured values
> were divided by 2, since the dynamic power is typically half of the
> consumed power (the second half is static power). Next, the approximation
> was made and the power model derived, showing the 'C' value of routhly X.

s/routhly/roughly/

What is X?

> Check the example equations in drivers/opp/of.c [2].
> Thus, i.e. the power = 1.0Watt at 1GHz => 0.5W dynamic power =>
> dynamic-power-coefficient = 400
>
> Using this simple technique we can provide and needed coefficient.  The

s/and/the/ ?

> approximation does not have to be super precised. The proportion is
> important and the difference between power consumed by different CPUs
> running at the same frequency, which is then used in Energy Aware Scheduler
> algorithms. An example power values on Odroid-XU3:
>
> (LITTLE CPU)
> /sys/kernel/debug/energy_model/pd0/cs:1000000/frequency:1000000
> /sys/kernel/debug/energy_model/pd0/cs:1000000/power:154

For A7, 1V and 1 GHz this gives 142, not 154. Is it correct? What ASV
are you using?

> (big CPU)
> /sys/kernel/debug/energy_model/pd1/cs:1000000/frequency:1000000
> /sys/kernel/debug/energy_model/pd1/cs:1000000/power:310
>
> In Odroid-XU3 case the derived coefficient value for 'big' CPU has:
> dynamic-power-coefficient = <310>;
> while the 'LITTLE':
> dynamic-power-coefficient = <128>;

Make it all compact. First, you mention power values which are the
same as in the beginning of this commit message. Why repeating? Then
you mention the power coefficient in 4 lines instead of simple:
For Odroid XU3, the derived power coefficient is then 128 for an A7
CPU and 310 for an A15 CPU. Or something similar.

>
> [1] Documentation/devicetree/bindings/arm/cpus.yaml
> [2] https://elixir.bootlin.com/linux/v5.4/source/drivers/opp/of.c#L1044

Refer to path inside, no external sources unless needed.

Best regards,
Krzysztof

>
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  arch/arm/boot/dts/exynos5422-cpus.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/arm/boot/dts/exynos5422-cpus.dtsi b/arch/arm/boot/dts/exynos5422-cpus.dtsi
> index 1b8605cf2407..c9a0dc99d2fb 100644
> --- a/arch/arm/boot/dts/exynos5422-cpus.dtsi
> +++ b/arch/arm/boot/dts/exynos5422-cpus.dtsi
> @@ -31,6 +31,7 @@
>                         operating-points-v2 = <&cluster_a7_opp_table>;
>                         #cooling-cells = <2>; /* min followed by max */
>                         capacity-dmips-mhz = <539>;
> +                       dynamic-power-coefficient = <128>;
>                 };
>
>                 cpu1: cpu@101 {
> @@ -43,6 +44,7 @@
>                         operating-points-v2 = <&cluster_a7_opp_table>;
>                         #cooling-cells = <2>; /* min followed by max */
>                         capacity-dmips-mhz = <539>;
> +                       dynamic-power-coefficient = <128>;
>                 };
>
>                 cpu2: cpu@102 {
> @@ -55,6 +57,7 @@
>                         operating-points-v2 = <&cluster_a7_opp_table>;
>                         #cooling-cells = <2>; /* min followed by max */
>                         capacity-dmips-mhz = <539>;
> +                       dynamic-power-coefficient = <128>;
>                 };
>
>                 cpu3: cpu@103 {
> @@ -67,6 +70,7 @@
>                         operating-points-v2 = <&cluster_a7_opp_table>;
>                         #cooling-cells = <2>; /* min followed by max */
>                         capacity-dmips-mhz = <539>;
> +                       dynamic-power-coefficient = <128>;
>                 };
>
>                 cpu4: cpu@0 {
> @@ -79,6 +83,7 @@
>                         operating-points-v2 = <&cluster_a15_opp_table>;
>                         #cooling-cells = <2>; /* min followed by max */
>                         capacity-dmips-mhz = <1024>;
> +                       dynamic-power-coefficient = <310>;
>                 };
>
>                 cpu5: cpu@1 {
> @@ -91,6 +96,7 @@
>                         operating-points-v2 = <&cluster_a15_opp_table>;
>                         #cooling-cells = <2>; /* min followed by max */
>                         capacity-dmips-mhz = <1024>;
> +                       dynamic-power-coefficient = <310>;
>                 };
>
>                 cpu6: cpu@2 {
> @@ -103,6 +109,7 @@
>                         operating-points-v2 = <&cluster_a15_opp_table>;
>                         #cooling-cells = <2>; /* min followed by max */
>                         capacity-dmips-mhz = <1024>;
> +                       dynamic-power-coefficient = <310>;
>                 };
>
>                 cpu7: cpu@3 {
> @@ -115,6 +122,7 @@
>                         operating-points-v2 = <&cluster_a15_opp_table>;
>                         #cooling-cells = <2>; /* min followed by max */
>                         capacity-dmips-mhz = <1024>;
> +                       dynamic-power-coefficient = <310>;
>                 };
>         };
>  };
> --
> 2.17.1
>

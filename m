Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 274DEDA3CC
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2019 04:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407027AbfJQCcr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Oct 2019 22:32:47 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45384 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407014AbfJQCcq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Oct 2019 22:32:46 -0400
Received: by mail-pl1-f194.google.com with SMTP id u12so343909pls.12
        for <linux-pm@vger.kernel.org>; Wed, 16 Oct 2019 19:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pUKLlw335AcpeA+hr3tSoh4ic3jU+PwADT5iiLMP7e4=;
        b=RbnDMOq41IIBauQgpTXnbGY0pzLDA4VaMyImygPHNy6UwMPO6tPEmmNK1x+6AZOz/u
         4sjaAKnUirttmXk79GxgW8tjr4o8R7Z6zXNlWB3Pn3Hnzhqv9h8IRCbo0nVcw/x7rHqx
         CWZKf026snJCohpxNzIZoJ48/aX6O/41qxwNzJWFX2KQcOsAB7tdUgrZt12r1r+Z27IX
         3mWYAjckdQEDTEWtGyYziM8t4Aljo3H8On1nHX8cMLW2zURgKCexfGkbfUyTZIFE9JoY
         Oe1WB1tcBqgnh9TYId53vDaA9g4KCgnjsy699trt497ZvkgT96+eP/QNVoS+182LFglz
         Yi5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pUKLlw335AcpeA+hr3tSoh4ic3jU+PwADT5iiLMP7e4=;
        b=epImSsAbcekOCED7DIGkz7GjPiFou2+C9C+9rwtSvlvq+Kc82mAixOsKjswNhBKqxY
         ilD26kfhGVjcodIhbV4CsLJyOEze68WZBs9o+rjK+Xr8DW0WTB70fxI9H9qeY2cfzDOJ
         RAfKvhjDMIT8+IkCirRRGkUhg03Cx4FtYnc2pEWu9rT5fo82Kd0HMxs4ovoiv/3AlgTs
         Vc7DnsJTtdJIQ5VkzCozTJdNwOy9I+jxUf67O7v4BnUGNY5ZGuQvlBqX6vF4MrE9vvMH
         7VYk9GYu3NxsJLUrms5pI7uHwogbzyBSd5ARp2T39nvpHzBpmSSLpaJYbW8Z3x20xeky
         GdwA==
X-Gm-Message-State: APjAAAXum+Zn6u5veYG7IT+eh63ZwgNqH1qfwn/66H7jJzrNl1Eh7men
        NOImomVsaMLJCv1CyY7GZ2RnDbeyS44=
X-Google-Smtp-Source: APXvYqx+e2tCvivcAiosUPjgAAUvfKe3cRNnR/SYrZBr1EfZYqSAEImQEazE0/L2lNbXCIe9P2QTGQ==
X-Received: by 2002:a17:902:8ec1:: with SMTP id x1mr1405343plo.314.1571279565739;
        Wed, 16 Oct 2019 19:32:45 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id h4sm456284pfg.159.2019.10.16.19.32.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Oct 2019 19:32:45 -0700 (PDT)
Date:   Thu, 17 Oct 2019 08:02:43 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 11/17] ARM: dts: tegra20: Add CPU Operating
 Performance Points
Message-ID: <20191017023243.d7s4bnqan752vznx@vireshk-i7>
References: <20191015211618.20758-1-digetx@gmail.com>
 <20191015211618.20758-12-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015211618.20758-12-digetx@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 16-10-19, 00:16, Dmitry Osipenko wrote:
> Operating Point are specified per HW version. The OPP voltages are kept
> in a separate DTSI file because some boards may not define CPU regulator
> in their device-tree if voltage scaling isn't necessary, like for example
> in a case of tegra20-trimslice which is outlet-powered device.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../boot/dts/tegra20-cpu-opp-microvolt.dtsi   | 201 ++++++++++++
>  arch/arm/boot/dts/tegra20-cpu-opp.dtsi        | 302 ++++++++++++++++++
>  2 files changed, 503 insertions(+)
>  create mode 100644 arch/arm/boot/dts/tegra20-cpu-opp-microvolt.dtsi
>  create mode 100644 arch/arm/boot/dts/tegra20-cpu-opp.dtsi
> 
> diff --git a/arch/arm/boot/dts/tegra20-cpu-opp-microvolt.dtsi b/arch/arm/boot/dts/tegra20-cpu-opp-microvolt.dtsi
> new file mode 100644
> index 000000000000..e85ffdbef876
> --- /dev/null
> +++ b/arch/arm/boot/dts/tegra20-cpu-opp-microvolt.dtsi
> @@ -0,0 +1,201 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/ {
> +	cpu0_opp_table: cpu_opp_table0 {
> +		opp@216000000_750 {
> +			opp-microvolt = <750000 750000 1125000>;
> +		};
> +
> +		opp@216000000_800 {
> +			opp-microvolt = <800000 800000 1125000>;
> +		};
> +
> +		opp@312000000_750 {
> +			opp-microvolt = <750000 750000 1125000>;
> +		};
> +
> +		opp@312000000_800 {
> +			opp-microvolt = <800000 800000 1125000>;
> +		};
> +
> +		opp@456000000_750 {
> +			opp-microvolt = <750000 750000 1125000>;
> +		};
> +
> +		opp@456000000_800 {
> +			opp-microvolt = <800000 800000 1125000>;
> +		};
> +
> +		opp@456000000_800_2_2 {
> +			opp-microvolt = <800000 800000 1125000>;
> +		};
> +
> +		opp@456000000_800_3_2 {
> +			opp-microvolt = <800000 800000 1125000>;
> +		};
> +
> +		opp@456000000_825 {
> +			opp-microvolt = <825000 825000 1125000>;
> +		};
> +
> +		opp@608000000_750 {
> +			opp-microvolt = <750000 750000 1125000>;
> +		};
> +
> +		opp@608000000_800 {
> +			opp-microvolt = <800000 800000 1125000>;
> +		};
> +
> +		opp@608000000_800_3_2 {
> +			opp-microvolt = <800000 800000 1125000>;
> +		};
> +
> +		opp@608000000_825 {
> +			opp-microvolt = <825000 825000 1125000>;
> +		};
> +
> +		opp@608000000_850 {
> +			opp-microvolt = <850000 850000 1125000>;
> +		};
> +
> +		opp@608000000_900 {
> +			opp-microvolt = <900000 900000 1125000>;
> +		};
> +
> +		opp@760000000_775 {
> +			opp-microvolt = <775000 775000 1125000>;
> +		};
> +
> +		opp@760000000_800 {
> +			opp-microvolt = <800000 800000 1125000>;
> +		};
> +
> +		opp@760000000_850 {
> +			opp-microvolt = <850000 850000 1125000>;
> +		};
> +
> +		opp@760000000_875 {
> +			opp-microvolt = <875000 875000 1125000>;
> +		};
> +
> +		opp@760000000_875_1_1 {
> +			opp-microvolt = <875000 875000 1125000>;
> +		};
> +
> +		opp@760000000_875_0_2 {
> +			opp-microvolt = <875000 875000 1125000>;
> +		};
> +
> +		opp@760000000_875_1_2 {
> +			opp-microvolt = <875000 875000 1125000>;
> +		};
> +
> +		opp@760000000_900 {
> +			opp-microvolt = <900000 900000 1125000>;
> +		};
> +
> +		opp@760000000_975 {
> +			opp-microvolt = <975000 975000 1125000>;
> +		};
> +
> +		opp@816000000_800 {
> +			opp-microvolt = <800000 800000 1125000>;
> +		};
> +
> +		opp@816000000_850 {
> +			opp-microvolt = <850000 850000 1125000>;
> +		};
> +
> +		opp@816000000_875 {
> +			opp-microvolt = <875000 875000 1125000>;
> +		};
> +
> +		opp@816000000_950 {
> +			opp-microvolt = <950000 950000 1125000>;
> +		};
> +
> +		opp@816000000_1000 {
> +			opp-microvolt = <1000000 1000000 1125000>;
> +		};
> +
> +		opp@912000000_850 {
> +			opp-microvolt = <850000 850000 1125000>;
> +		};
> +
> +		opp@912000000_900 {
> +			opp-microvolt = <900000 900000 1125000>;
> +		};
> +
> +		opp@912000000_925 {
> +			opp-microvolt = <925000 925000 1125000>;
> +		};
> +
> +		opp@912000000_950 {
> +			opp-microvolt = <950000 950000 1125000>;
> +		};
> +
> +		opp@912000000_950_0_2 {
> +			opp-microvolt = <950000 950000 1125000>;
> +		};
> +
> +		opp@912000000_950_2_2 {
> +			opp-microvolt = <950000 950000 1125000>;
> +		};
> +
> +		opp@912000000_1000 {
> +			opp-microvolt = <1000000 1000000 1125000>;
> +		};
> +
> +		opp@912000000_1050 {
> +			opp-microvolt = <1050000 1050000 1125000>;
> +		};
> +
> +		opp@1000000000_875 {
> +			opp-microvolt = <875000 875000 1125000>;
> +		};
> +
> +		opp@1000000000_900 {
> +			opp-microvolt = <900000 900000 1125000>;
> +		};
> +
> +		opp@1000000000_950 {
> +			opp-microvolt = <950000 950000 1125000>;
> +		};
> +
> +		opp@1000000000_975 {
> +			opp-microvolt = <975000 975000 1125000>;
> +		};
> +
> +		opp@1000000000_1000 {
> +			opp-microvolt = <1000000 1000000 1125000>;
> +		};
> +
> +		opp@1000000000_1000_0_2 {
> +			opp-microvolt = <1000000 1000000 1125000>;
> +		};
> +
> +		opp@1000000000_1025 {
> +			opp-microvolt = <1025000 1025000 1125000>;
> +		};
> +
> +		opp@1000000000_1100 {
> +			opp-microvolt = <1100000 1100000 1125000>;
> +		};
> +
> +		opp@1200000000_1000 {
> +			opp-microvolt = <1000000 1000000 1125000>;
> +		};
> +
> +		opp@1200000000_1050 {
> +			opp-microvolt = <1050000 1050000 1125000>;
> +		};
> +
> +		opp@1200000000_1100 {
> +			opp-microvolt = <1100000 1100000 1125000>;
> +		};
> +
> +		opp@1200000000_1125 {
> +			opp-microvolt = <1125000 1125000 1125000>;
> +		};
> +	};
> +};
> diff --git a/arch/arm/boot/dts/tegra20-cpu-opp.dtsi b/arch/arm/boot/dts/tegra20-cpu-opp.dtsi
> new file mode 100644
> index 000000000000..c878f4231791
> --- /dev/null
> +++ b/arch/arm/boot/dts/tegra20-cpu-opp.dtsi
> @@ -0,0 +1,302 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/ {
> +	cpu0_opp_table: cpu_opp_table0 {
> +		compatible = "operating-points-v2";
> +		opp-shared;
> +
> +		opp@216000000_750 {
> +			clock-latency-ns = <400000>;
> +			opp-supported-hw = <0x0F 0x0003>;
> +			opp-hz = /bits/ 64 <216000000>;
> +		};
> +
> +		opp@216000000_800 {
> +			clock-latency-ns = <400000>;
> +			opp-supported-hw = <0x0F 0x0004>;
> +			opp-hz = /bits/ 64 <216000000>;
> +		};
> +
> +		opp@312000000_750 {
> +			clock-latency-ns = <400000>;
> +			opp-supported-hw = <0x0F 0x0003>;
> +			opp-hz = /bits/ 64 <312000000>;
> +		};
> +
> +		opp@312000000_800 {
> +			clock-latency-ns = <400000>;
> +			opp-supported-hw = <0x0F 0x0004>;
> +			opp-hz = /bits/ 64 <312000000>;
> +		};
> +
> +		opp@456000000_750 {
> +			clock-latency-ns = <400000>;
> +			opp-supported-hw = <0x0C 0x0003>;
> +			opp-hz = /bits/ 64 <456000000>;
> +		};
> +
> +		opp@456000000_800 {
> +			clock-latency-ns = <400000>;
> +			opp-supported-hw = <0x03 0x0006>;
> +			opp-hz = /bits/ 64 <456000000>;
> +		};
> +
> +		opp@456000000_800_2_2 {
> +			clock-latency-ns = <400000>;
> +			opp-supported-hw = <0x04 0x0004>;
> +			opp-hz = /bits/ 64 <456000000>;
> +		};
> +
> +		opp@456000000_800_3_2 {
> +			clock-latency-ns = <400000>;
> +			opp-supported-hw = <0x08 0x0004>;
> +			opp-hz = /bits/ 64 <456000000>;
> +		};
> +
> +		opp@456000000_825 {
> +			clock-latency-ns = <400000>;
> +			opp-supported-hw = <0x03 0x0001>;
> +			opp-hz = /bits/ 64 <456000000>;
> +		};
> +
> +		opp@608000000_750 {
> +			clock-latency-ns = <400000>;
> +			opp-supported-hw = <0x08 0x0003>;
> +			opp-hz = /bits/ 64 <608000000>;
> +		};
> +
> +		opp@608000000_800 {
> +			clock-latency-ns = <400000>;
> +			opp-supported-hw = <0x04 0x0006>;
> +			opp-hz = /bits/ 64 <608000000>;
> +		};
> +
> +		opp@608000000_800_3_2 {
> +			clock-latency-ns = <400000>;
> +			opp-supported-hw = <0x08 0x0004>;
> +			opp-hz = /bits/ 64 <608000000>;
> +		};
> +
> +		opp@608000000_825 {
> +			clock-latency-ns = <400000>;
> +			opp-supported-hw = <0x04 0x0001>;
> +			opp-hz = /bits/ 64 <608000000>;
> +		};
> +
> +		opp@608000000_850 {
> +			clock-latency-ns = <400000>;
> +			opp-supported-hw = <0x03 0x0006>;
> +			opp-hz = /bits/ 64 <608000000>;
> +		};
> +
> +		opp@608000000_900 {
> +			clock-latency-ns = <400000>;
> +			opp-supported-hw = <0x03 0x0001>;
> +			opp-hz = /bits/ 64 <608000000>;
> +		};
> +
> +		opp@760000000_775 {
> +			clock-latency-ns = <400000>;
> +			opp-supported-hw = <0x08 0x0003>;
> +			opp-hz = /bits/ 64 <760000000>;
> +		};
> +
> +		opp@760000000_800 {
> +			clock-latency-ns = <400000>;
> +			opp-supported-hw = <0x08 0x0004>;
> +			opp-hz = /bits/ 64 <760000000>;
> +		};
> +
> +		opp@760000000_850 {
> +			clock-latency-ns = <400000>;
> +			opp-supported-hw = <0x04 0x0006>;
> +			opp-hz = /bits/ 64 <760000000>;
> +		};
> +
> +		opp@760000000_875 {
> +			clock-latency-ns = <400000>;
> +			opp-supported-hw = <0x04 0x0001>;
> +			opp-hz = /bits/ 64 <760000000>;
> +		};
> +
> +		opp@760000000_875_1_1 {
> +			clock-latency-ns = <400000>;
> +			opp-supported-hw = <0x02 0x0002>;
> +			opp-hz = /bits/ 64 <760000000>;
> +		};
> +
> +		opp@760000000_875_0_2 {
> +			clock-latency-ns = <400000>;
> +			opp-supported-hw = <0x01 0x0004>;
> +			opp-hz = /bits/ 64 <760000000>;
> +		};
> +
> +		opp@760000000_875_1_2 {
> +			clock-latency-ns = <400000>;
> +			opp-supported-hw = <0x02 0x0004>;
> +			opp-hz = /bits/ 64 <760000000>;
> +		};
> +
> +		opp@760000000_900 {
> +			clock-latency-ns = <400000>;
> +			opp-supported-hw = <0x01 0x0002>;
> +			opp-hz = /bits/ 64 <760000000>;
> +		};
> +
> +		opp@760000000_975 {
> +			clock-latency-ns = <400000>;
> +			opp-supported-hw = <0x03 0x0001>;
> +			opp-hz = /bits/ 64 <760000000>;
> +		};
> +
> +		opp@816000000_800 {
> +			clock-latency-ns = <400000>;
> +			opp-supported-hw = <0x08 0x0007>;
> +			opp-hz = /bits/ 64 <816000000>;
> +		};
> +
> +		opp@816000000_850 {
> +			clock-latency-ns = <400000>;
> +			opp-supported-hw = <0x04 0x0002>;
> +			opp-hz = /bits/ 64 <816000000>;
> +		};
> +
> +		opp@816000000_875 {
> +			clock-latency-ns = <400000>;
> +			opp-supported-hw = <0x04 0x0005>;
> +			opp-hz = /bits/ 64 <816000000>;
> +		};
> +
> +		opp@816000000_950 {
> +			clock-latency-ns = <400000>;
> +			opp-supported-hw = <0x03 0x0006>;
> +			opp-hz = /bits/ 64 <816000000>;
> +		};
> +
> +		opp@816000000_1000 {
> +			clock-latency-ns = <400000>;
> +			opp-supported-hw = <0x03 0x0001>;
> +			opp-hz = /bits/ 64 <816000000>;
> +		};
> +
> +		opp@912000000_850 {
> +			clock-latency-ns = <400000>;
> +			opp-supported-hw = <0x08 0x0007>;
> +			opp-hz = /bits/ 64 <912000000>;
> +		};
> +
> +		opp@912000000_900 {
> +			clock-latency-ns = <400000>;
> +			opp-supported-hw = <0x04 0x0002>;
> +			opp-hz = /bits/ 64 <912000000>;
> +		};
> +
> +		opp@912000000_925 {
> +			clock-latency-ns = <400000>;
> +			opp-supported-hw = <0x04 0x0001>;
> +			opp-hz = /bits/ 64 <912000000>;
> +		};
> +
> +		opp@912000000_950 {
> +			clock-latency-ns = <400000>;
> +			opp-supported-hw = <0x02 0x0006>;
> +			opp-hz = /bits/ 64 <912000000>;
> +		};
> +
> +		opp@912000000_950_0_2 {
> +			clock-latency-ns = <400000>;
> +			opp-supported-hw = <0x01 0x0004>;
> +			opp-hz = /bits/ 64 <912000000>;
> +		};
> +
> +		opp@912000000_950_2_2 {
> +			clock-latency-ns = <400000>;
> +			opp-supported-hw = <0x04 0x0004>;
> +			opp-hz = /bits/ 64 <912000000>;
> +		};
> +
> +		opp@912000000_1000 {
> +			clock-latency-ns = <400000>;
> +			opp-supported-hw = <0x01 0x0002>;
> +			opp-hz = /bits/ 64 <912000000>;
> +		};
> +
> +		opp@912000000_1050 {
> +			clock-latency-ns = <400000>;
> +			opp-supported-hw = <0x03 0x0001>;
> +			opp-hz = /bits/ 64 <912000000>;
> +		};
> +
> +		opp@1000000000_875 {
> +			clock-latency-ns = <400000>;
> +			opp-supported-hw = <0x08 0x0007>;
> +			opp-hz = /bits/ 64 <1000000000>;
> +		};
> +
> +		opp@1000000000_900 {
> +			clock-latency-ns = <400000>;
> +			opp-supported-hw = <0x04 0x0002>;
> +			opp-hz = /bits/ 64 <1000000000>;
> +		};
> +
> +		opp@1000000000_950 {
> +			clock-latency-ns = <400000>;
> +			opp-supported-hw = <0x04 0x0004>;
> +			opp-hz = /bits/ 64 <1000000000>;
> +		};
> +
> +		opp@1000000000_975 {
> +			clock-latency-ns = <400000>;
> +			opp-supported-hw = <0x04 0x0001>;
> +			opp-hz = /bits/ 64 <1000000000>;
> +		};
> +
> +		opp@1000000000_1000 {
> +			clock-latency-ns = <400000>;
> +			opp-supported-hw = <0x02 0x0006>;
> +			opp-hz = /bits/ 64 <1000000000>;
> +		};
> +
> +		opp@1000000000_1000_0_2 {
> +			clock-latency-ns = <400000>;
> +			opp-supported-hw = <0x01 0x0004>;
> +			opp-hz = /bits/ 64 <1000000000>;
> +		};
> +
> +		opp@1000000000_1025 {
> +			clock-latency-ns = <400000>;
> +			opp-supported-hw = <0x01 0x0002>;
> +			opp-hz = /bits/ 64 <1000000000>;
> +		};
> +
> +		opp@1000000000_1100 {
> +			clock-latency-ns = <400000>;
> +			opp-supported-hw = <0x03 0x0001>;
> +			opp-hz = /bits/ 64 <1000000000>;
> +		};
> +
> +		opp@1200000000_1000 {
> +			clock-latency-ns = <400000>;
> +			opp-supported-hw = <0x08 0x0004>;
> +			opp-hz = /bits/ 64 <1200000000>;
> +		};
> +
> +		opp@1200000000_1050 {
> +			clock-latency-ns = <400000>;
> +			opp-supported-hw = <0x04 0x0004>;
> +			opp-hz = /bits/ 64 <1200000000>;
> +		};
> +
> +		opp@1200000000_1100 {
> +			clock-latency-ns = <400000>;
> +			opp-supported-hw = <0x02 0x0004>;
> +			opp-hz = /bits/ 64 <1200000000>;
> +		};
> +
> +		opp@1200000000_1125 {
> +			clock-latency-ns = <400000>;
> +			opp-supported-hw = <0x01 0x0004>;
> +			opp-hz = /bits/ 64 <1200000000>;
> +		};
> +	};
> +};

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

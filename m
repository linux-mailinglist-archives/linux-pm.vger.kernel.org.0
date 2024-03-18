Return-Path: <linux-pm+bounces-5036-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE2C87E7B1
	for <lists+linux-pm@lfdr.de>; Mon, 18 Mar 2024 11:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 346D71F21A5F
	for <lists+linux-pm@lfdr.de>; Mon, 18 Mar 2024 10:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813B72E65B;
	Mon, 18 Mar 2024 10:52:02 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83CE71E527;
	Mon, 18 Mar 2024 10:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710759122; cv=none; b=oBqLL9N0xkg5xK3f+V498SQfZ5Z3BFRJQRyI6heUbvHvRS4WpTezEwNZ2ATjFfO4Zv+cbCfnC7B13jdOxkzFZ+09k11lp5X5B1ZZRmX0g9MWoSG3lYVgFageeK+TXVqpQ2rirwPTSDX5GrWxW0Atpadd1JfttfnOvSci1s/M5CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710759122; c=relaxed/simple;
	bh=/JWCp5q2+nXWg7kGQTCue5qLlqIwKCcMXWzyiqkjiPo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j31Q9tr8smgGRVIr9LDCke7sg4yy60cBo38u1BvUy3YZCnaFwkhreGcweWslMNsiNKdRO6xvdcasVhdQsEJcBTNyiP5O1Iy/xBRupJRuO/p8rnLKKlSsG/YFR0nG4yqjOQq/+nm9H/fVLerrIwNsK5agH64zAnl87lPz/oEZeeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6C3F1DA7;
	Mon, 18 Mar 2024 03:52:33 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 297173F762;
	Mon, 18 Mar 2024 03:51:56 -0700 (PDT)
Date: Mon, 18 Mar 2024 10:51:53 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Amit Singh Tomar <amitsinght@marvell.com>
Cc: Yangtao Li <tiny.windzz@gmail.com>, Viresh Kumar <vireshk@kernel.org>,
 Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, "Rafael J . Wysocki"
 <rafael@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-sunxi@lists.linux.dev" <linux-sunxi@lists.linux.dev>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, Brandon Cheo Fusi
 <fusibrandon13@gmail.com>, Martin Botka <martin.botka@somainline.org>,
 Martin Botka <martin.botka1@gmail.com>
Subject: Re: [PATCH v2 8/8] arm64: dts: allwinner: h616: enable DVFS for all
 boards
Message-ID: <20240318105153.2c666647@donnerap.manchester.arm.com>
In-Reply-To: <MW4PR18MB5084E8C6D673B73FC208190BC62D2@MW4PR18MB5084.namprd18.prod.outlook.com>
References: <MW4PR18MB5084E8C6D673B73FC208190BC62D2@MW4PR18MB5084.namprd18.prod.outlook.com>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 Mar 2024 04:39:46 +0000
Amit Singh Tomar <amitsinght@marvell.com> wrote:

Hi Amit,

can you please try to reply using the standard quoted line prefix ('>'),
and cut the header? I almost missed your question in here.

> Hi,
> 
> -----Original Message-----
> From: linux-arm-kernel <linux-arm-kernel-bounces@lists.infradead.org> On Behalf Of Andre Przywara
> Sent: Monday, March 18, 2024 6:42 AM
> To: Yangtao Li <tiny.windzz@gmail.com>; Viresh Kumar <vireshk@kernel.org>; Nishanth Menon <nm@ti.com>; Stephen Boyd <sboyd@kernel.org>; Rob Herring <robh+dt@kernel.org>; Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley <conor+dt@kernel.org>; Chen-Yu Tsai <wens@csie.org>; Jernej Skrabec <jernej.skrabec@gmail.com>; Samuel Holland <samuel@sholland.org>; Rafael J . Wysocki <rafael@kernel.org>
> Cc: linux-pm@vger.kernel.org; devicetree@vger.kernel.org; linux-sunxi@lists.linux.dev; linux-arm-kernel@lists.infradead.org; Brandon Cheo Fusi <fusibrandon13@gmail.com>; Martin Botka <martin.botka@somainline.org>; Martin Botka <martin.botka1@gmail.com>
> Subject: [EXTERNAL] [PATCH v2 8/8] arm64: dts: allwinner: h616: enable DVFS for all boards
> 
> 
> With the DT bindings now describing the format of the CPU OPP tables, we can include the OPP table in each board's .dts file, and specify the CPU power supply.
> This allows to enable DVFS, and get up to 50% of performance benefit in the highest OPP, or up to 60% power savings in the lowest OPP, compared to the fixed 1GHz @ 1.0V OPP we are running in by default
> at the moment.
> [Amit] Could you please elaborate, what test were run to see 50 % performance benefits?

Currently all H616 boards running mainline firmware and kernels run at a
fixed 1GHz CPU clock frequency. If you happen to have a good SoC (bin 1 or
3), this patchset will allow you to run at 1.5 GHz, which is 50% faster.
So anything that scales with CPU frequency should run much quicker.

Cheers,
Andre

> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  .../boot/dts/allwinner/sun50i-h616-bigtreetech-cb1.dtsi      | 5 +++++
>  arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero2.dts | 5 +++++
>  arch/arm64/boot/dts/allwinner/sun50i-h616-x96-mate.dts       | 5 +++++
>  .../arm64/boot/dts/allwinner/sun50i-h618-orangepi-zero2w.dts | 5 +++++  arch/arm64/boot/dts/allwinner/sun50i-h618-orangepi-zero3.dts | 5 +++++
>  .../boot/dts/allwinner/sun50i-h618-transpeed-8k618-t.dts     | 5 +++++
>  6 files changed, 30 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-cb1.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-cb1.dtsi
> index 1fed2b46cfe87..86e58d1ed23ea 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-cb1.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-cb1.dtsi
> @@ -6,6 +6,7 @@
>  /dts-v1/;
>  
>  #include "sun50i-h616.dtsi"
> +#include "sun50i-h616-cpu-opp.dtsi"
>  
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> @@ -62,6 +63,10 @@ wifi_pwrseq: wifi-pwrseq {
>  	};
>  };
>  
> +&cpu0 {
> +	cpu-supply = <&reg_dcdc2>;
> +};
> +
>  &mmc0 {
>  	vmmc-supply = <&reg_dldo1>;
>  	/* Card detection pin is not connected */ diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero2.dts
> index b5d713926a341..a360d8567f955 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero2.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero2.dts
> @@ -6,12 +6,17 @@
>  /dts-v1/;
>  
>  #include "sun50i-h616-orangepi-zero.dtsi"
> +#include "sun50i-h616-cpu-opp.dtsi"
>  
>  / {
>  	model = "OrangePi Zero2";
>  	compatible = "xunlong,orangepi-zero2", "allwinner,sun50i-h616";  };
>  
> +&cpu0 {
> +	cpu-supply = <&reg_dcdca>;
> +};
> +
>  &emac0 {
>  	allwinner,rx-delay-ps = <3100>;
>  	allwinner,tx-delay-ps = <700>;
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-x96-mate.dts b/arch/arm64/boot/dts/allwinner/sun50i-h616-x96-mate.dts
> index 959b6fd18483b..26d25b5b59e0f 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h616-x96-mate.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-x96-mate.dts
> @@ -6,6 +6,7 @@
>  /dts-v1/;
>  
>  #include "sun50i-h616.dtsi"
> +#include "sun50i-h616-cpu-opp.dtsi"
>  
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> @@ -32,6 +33,10 @@ reg_vcc5v: vcc5v {
>  	};
>  };
>  
> +&cpu0 {
> +	cpu-supply = <&reg_dcdca>;
> +};
> +
>  &ehci0 {
>  	status = "okay";
>  };
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h618-orangepi-zero2w.dts b/arch/arm64/boot/dts/allwinner/sun50i-h618-orangepi-zero2w.dts
> index 21ca1977055d9..6a4f0da972330 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h618-orangepi-zero2w.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h618-orangepi-zero2w.dts
> @@ -6,6 +6,7 @@
>  /dts-v1/;
>  
>  #include "sun50i-h616.dtsi"
> +#include "sun50i-h616-cpu-opp.dtsi"
>  
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> @@ -53,6 +54,10 @@ reg_vcc3v3: vcc3v3 {
>  	};
>  };
>  
> +&cpu0 {
> +	cpu-supply = <&reg_dcdc2>;
> +};
> +
>  &ehci1 {
>  	status = "okay";
>  };
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h618-orangepi-zero3.dts b/arch/arm64/boot/dts/allwinner/sun50i-h618-orangepi-zero3.dts
> index b3b1b8692125f..e1cd7572a14ce 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h618-orangepi-zero3.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h618-orangepi-zero3.dts
> @@ -6,12 +6,17 @@
>  /dts-v1/;
>  
>  #include "sun50i-h616-orangepi-zero.dtsi"
> +#include "sun50i-h616-cpu-opp.dtsi"
>  
>  / {
>  	model = "OrangePi Zero3";
>  	compatible = "xunlong,orangepi-zero3", "allwinner,sun50i-h618";  };
>  
> +&cpu0 {
> +	cpu-supply = <&reg_dcdc2>;
> +};
> +
>  &emac0 {
>  	allwinner,tx-delay-ps = <700>;
>  	phy-mode = "rgmii-rxid";
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h618-transpeed-8k618-t.dts b/arch/arm64/boot/dts/allwinner/sun50i-h618-transpeed-8k618-t.dts
> index 8ea1fd41aebaa..2dd178a164fbe 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h618-transpeed-8k618-t.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h618-transpeed-8k618-t.dts
> @@ -6,6 +6,7 @@
>  /dts-v1/;
>  
>  #include "sun50i-h616.dtsi"
> +#include "sun50i-h616-cpu-opp.dtsi"
>  
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> @@ -41,6 +42,10 @@ reg_vcc3v3: vcc3v3 {
>  	};
>  };
>  
> +&cpu0 {
> +	cpu-supply = <&reg_dcdc2>;
> +};
> +
>  &ehci0 {
>  	status = "okay";
>  };
> --
> 2.35.8
> 
> 



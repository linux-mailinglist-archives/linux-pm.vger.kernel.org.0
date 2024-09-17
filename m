Return-Path: <linux-pm+bounces-14353-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A55297ABBD
	for <lists+linux-pm@lfdr.de>; Tue, 17 Sep 2024 09:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53BB7B225D6
	for <lists+linux-pm@lfdr.de>; Tue, 17 Sep 2024 07:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9FF14F9DD;
	Tue, 17 Sep 2024 07:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nXJ/DXix"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D10314375D;
	Tue, 17 Sep 2024 07:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726556427; cv=none; b=UUxFcbZTVQz+1pHDOWBkQAzMnWw/Mr171O6LtKGRJCtoDuLOqsiOcCBHJdwtS1VqyCXoO73ENX1nsfj4lx6yC8DL8aQEc0bD4jIBVCkPd1dLLl9ap8EzlkbiqjPwKM7yDXyf9xWrJyecTG2+febA1AMZ6qXI6pGu8Uo46lqhFWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726556427; c=relaxed/simple;
	bh=xYXjLgKIgVQVJl/mI7hl5hLIk1cdSp8r/KFLQ4nwxgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LXxNbwbjacbF5Y0l6vNvD2YrKkdB+SUkGcHYwcI9NXHcgfbKCF9a7iYNuUcjvMzuqnxCo324GP4MRgogpEYj3sTbNaIeJW7lhL9bfQn0sopSBxWa7pQ7bgBPIpQCMhvglWDnuidSBl+h3GJpSb9PKGPsXKzfa9MXr3oO96gJ0w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nXJ/DXix; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AA3FC4CEC6;
	Tue, 17 Sep 2024 07:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726556426;
	bh=xYXjLgKIgVQVJl/mI7hl5hLIk1cdSp8r/KFLQ4nwxgM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nXJ/DXixRjjDtOwXrUIh1eVPfuQ3jMIC7ZCco3EQFL4PNFnS8+SNHzXil7GkmG+Wv
	 +re5wFT9lDF+2K3ZmYXDhGY5uViKGt3AbEyjhQXiYGsoY4Rn4BGgLwoZw29/zpzAiD
	 W+tWDKUdHWrKr86gPrfGplJnUJh1TQ1Oed4gUl6BjTWgFzk+wX2l7J+Pbujqf+umyW
	 2IjmIzCBf2BnvnOtGycrodoh6oCQ53Id2Mphp5LZ7U2yg41Elqezl29tbDEEuKlp9h
	 T8dvp/BY5tcBunj6V+MSfFDgD8IxctyDLW0kgRSjsgCyhZxeuTVb0l0zNpAq32q0u5
	 envyKvvKyTDtg==
Date: Tue, 17 Sep 2024 09:00:23 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Macpaul Lin <macpaul.lin@mediatek.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Sean Wang <sean.wang@mediatek.com>, 
	Sen Chu <sen.chu@mediatek.com>, netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Chen Zhong <chen.zhong@mediatek.com>, 
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-rtc@vger.kernel.org, linux-sound@vger.kernel.org, 
	Alexandre Mergnat <amergnat@baylibre.com>, Bear Wang <bear.wang@mediatek.com>, 
	Pablo Sun <pablo.sun@mediatek.com>, Macpaul Lin <macpaul@gmail.com>, 
	Chris-qj chen <chris-qj.chen@mediatek.com>, 
	MediaTek Chromebook Upstream <Project_Global_Chrome_Upstream_Group@mediatek.com>, Chen-Yu Tsai <wenst@chromium.org>
Subject: Re: [PATCH v5 2/3] dt-bindings: mfd: mediatek: mt6397: Convert to DT
 schema format
Message-ID: <iudkiamza3lsl33tsby3sghfy66rj2tgg3kqjjwzeba46oxtpi@yrri5m5skjld>
References: <20240916151132.32321-1-macpaul.lin@mediatek.com>
 <20240916151132.32321-2-macpaul.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240916151132.32321-2-macpaul.lin@mediatek.com>

On Mon, Sep 16, 2024 at 11:11:31PM +0800, Macpaul Lin wrote:
> Convert the mfd: mediatek: mt6397 binding to DT schema format.
> 
> MT6323, MT6358, and MT6397 are PMIC devices with multiple function
> subdevices. They share a common PMIC design but have variations in
> subdevice combinations.
> 
> Key updates in this conversion:

...

> +                regulator-name = "vproc";
> +                regulator-min-microvolt = < 700000>;
> +                regulator-max-microvolt = <1350000>;
> +                regulator-ramp-delay = <12500>;
> +                regulator-always-on;
> +                regulator-boot-on;
> +            };
> +
> +            buck_vsys {
> +                regulator-name = "vsys";
> +                regulator-min-microvolt = <1400000>;
> +                regulator-max-microvolt = <2987500>;
> +                regulator-ramp-delay = <25000>;
> +                regulator-always-on;
> +                regulator-boot-on;
> +            };
> +
> +            buck_vpa {
> +                regulator-name = "vpa";
> +                regulator-min-microvolt = < 500000>;
> +                regulator-max-microvolt = <3650000>;
> +            };
> +
> +            ldo_vtcxo {
> +                regulator-name = "vtcxo";
> +                regulator-min-microvolt = <2800000>;
> +                regulator-max-microvolt = <2800000>;
> +                regulator-enable-ramp-delay = <90>;
> +                regulator-always-on;
> +                regulator-boot-on;
> +            };
> +
> +            ldo_vcn28 {
> +                regulator-name = "vcn28";
> +                regulator-min-microvolt = <2800000>;
> +                regulator-max-microvolt = <2800000>;
> +                regulator-enable-ramp-delay = <185>;
> +            };
> +
> +            ldo_vcn33_bt {
> +                regulator-name = "vcn33_bt";
> +                regulator-min-microvolt = <3300000>;
> +                regulator-max-microvolt = <3600000>;
> +                regulator-enable-ramp-delay = <185>;
> +            };
> +
> +            ldo_vcn33_wifi {
> +                regulator-name = "vcn33_wifi";
> +                regulator-min-microvolt = <3300000>;
> +                regulator-max-microvolt = <3600000>;
> +                regulator-enable-ramp-delay = <185>;
> +            };
> +
> +            ldo_va {
> +                regulator-name = "va";
> +                regulator-min-microvolt = <2800000>;
> +                regulator-max-microvolt = <2800000>;
> +                regulator-enable-ramp-delay = <216>;
> +                regulator-always-on;
> +                regulator-boot-on;
> +            };
> +
> +            ldo_vcama {
> +                regulator-name = "vcama";
> +                regulator-min-microvolt = <1500000>;
> +                regulator-max-microvolt = <2800000>;
> +                regulator-enable-ramp-delay = <216>;
> +            };
> +
> +            ldo_vio28 {
> +                regulator-name = "vio28";
> +                regulator-min-microvolt = <2800000>;
> +                regulator-max-microvolt = <2800000>;
> +                regulator-enable-ramp-delay = <216>;
> +                regulator-always-on;
> +                regulator-boot-on;
> +            };
> +
> +            ldo_vusb {
> +                regulator-name = "vusb";
> +                regulator-min-microvolt = <3300000>;
> +                regulator-max-microvolt = <3300000>;
> +                regulator-enable-ramp-delay = <216>;
> +                regulator-boot-on;
> +            };
> +
> +            ldo_vmc {
> +                regulator-name = "vmc";
> +                regulator-min-microvolt = <1800000>;
> +                regulator-max-microvolt = <3300000>;
> +                regulator-enable-ramp-delay = <36>;
> +                regulator-boot-on;
> +            };
> +
> +            ldo_vmch {
> +                regulator-name = "vmch";
> +                regulator-min-microvolt = <3000000>;
> +                regulator-max-microvolt = <3300000>;
> +                regulator-enable-ramp-delay = <36>;
> +                regulator-boot-on;
> +            };
> +
> +            ldo_vemc3v3 {
> +                regulator-name = "vemc3v3";
> +                regulator-min-microvolt = <3000000>;
> +                regulator-max-microvolt = <3300000>;
> +                regulator-enable-ramp-delay = <36>;
> +                regulator-boot-on;
> +            };
> +
> +            ldo_vgp1 {
> +                regulator-name = "vgp1";
> +                regulator-min-microvolt = <1200000>;
> +                regulator-max-microvolt = <3300000>;
> +                regulator-enable-ramp-delay = <216>;
> +            };
> +
> +            ldo_vgp2 {
> +                regulator-name = "vgp2";
> +                regulator-min-microvolt = <1200000>;
> +                regulator-max-microvolt = <3000000>;
> +                regulator-enable-ramp-delay = <216>;
> +            };
> +
> +            ldo_vgp3 {
> +                regulator-name = "vgp3";
> +                regulator-min-microvolt = <1200000>;
> +                regulator-max-microvolt = <1800000>;
> +                regulator-enable-ramp-delay = <216>;
> +            };
> +
> +            ldo_vcn18 {
> +                regulator-name = "vcn18";
> +                regulator-min-microvolt = <1800000>;
> +                regulator-max-microvolt = <1800000>;
> +                regulator-enable-ramp-delay = <216>;
> +            };
> +
> +            ldo_vsim1 {
> +                regulator-name = "vsim1";
> +                regulator-min-microvolt = <1800000>;
> +                regulator-max-microvolt = <3000000>;
> +                regulator-enable-ramp-delay = <216>;
> +            };
> +
> +            ldo_vsim2 {
> +                regulator-name = "vsim2";
> +                regulator-min-microvolt = <1800000>;
> +                regulator-max-microvolt = <3000000>;
> +                regulator-enable-ramp-delay = <216>;
> +            };
> +
> +            ldo_vrtc {
> +                regulator-name = "vrtc";
> +                regulator-min-microvolt = <2800000>;
> +                regulator-max-microvolt = <2800000>;
> +                regulator-always-on;
> +                regulator-boot-on;
> +            };
> +
> +            ldo_vcamaf {
> +                regulator-name = "vcamaf";
> +                regulator-min-microvolt = <1200000>;
> +                regulator-max-microvolt = <3300000>;
> +                regulator-enable-ramp-delay = <216>;
> +            };
> +
> +            ldo_vibr {
> +                regulator-name = "vibr";
> +                regulator-min-microvolt = <1200000>;
> +                regulator-max-microvolt = <3300000>;
> +                regulator-enable-ramp-delay = <36>;
> +            };
> +
> +            ldo_vrf18 {
> +                regulator-name = "vrf18";
> +                regulator-min-microvolt = <1825000>;
> +                regulator-max-microvolt = <1825000>;
> +                regulator-enable-ramp-delay = <187>;
> +            };
> +
> +            ldo_vm {
> +                regulator-name = "vm";
> +                regulator-min-microvolt = <1200000>;
> +                regulator-max-microvolt = <1800000>;
> +                regulator-enable-ramp-delay = <216>;
> +                regulator-always-on;
> +                regulator-boot-on;
> +            };
> +
> +            ldo_vio18 {
> +                regulator-name = "vio18";
> +                regulator-min-microvolt = <1800000>;
> +                regulator-max-microvolt = <1800000>;
> +                regulator-enable-ramp-delay = <216>;
> +                regulator-always-on;
> +                regulator-boot-on;
> +            };
> +
> +           ldo_vcamd {
> +                regulator-name = "vcamd";
> +                regulator-min-microvolt = <1200000>;
> +                regulator-max-microvolt = <1800000>;
> +                regulator-enable-ramp-delay = <216>;
> +            };
> +
> +            ldo_vcamio {
> +                regulator-name = "vcamio";
> +                regulator-min-microvolt = <1800000>;
> +                regulator-max-microvolt = <1800000>;
> +                regulator-enable-ramp-delay = <216>;
> +            };
> +        };
> +
> +        keys {
> +            compatible = "mediatek,mt6323-keys";
> +            mediatek,long-press-mode = <1>;
> +            power-off-time-sec = <0>;
> +
> +            power {
> +                    linux,keycodes = <116>;

Messed indentation.

> +                    wakeup-source;
> +            };
> +
> +            home {
> +                    linux,keycodes = <114>;
> +            };
> +        };
> +
> +        power-controller {
> +            compatible = "mediatek,mt6323-pwrc";
> +            #power-domain-cells = <0>;
> +        };
> +
> +        rtc {
> +            compatible = "mediatek,mt6323-rtc";
> +        };
> +    };

Keep one complete example. Maybye two if they are significantly
different, but I don't see these differences.


> +
> +  - |
> +    #include <dt-bindings/input/input.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    pmic {
> +        compatible = "mediatek,mt6358">


....

> -	Required properties:
> -		- compatible: "mediatek,mt6397-pinctrl"
> -	For details, see ../pinctrl/pinctrl-mt65xx.txt

Best regards,
Krzysztof



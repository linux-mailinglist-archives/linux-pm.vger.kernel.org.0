Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DEC310B6ED
	for <lists+linux-pm@lfdr.de>; Wed, 27 Nov 2019 20:40:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbfK0Tko (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Nov 2019 14:40:44 -0500
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:40735 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728342AbfK0Tko (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Nov 2019 14:40:44 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 0F7C96E1B;
        Wed, 27 Nov 2019 14:40:43 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 27 Nov 2019 14:40:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        subject:to:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm1; bh=E
        /eIlh2168YayUz7yI7wcMUEWzVWY48EgCDeJX0YMmc=; b=OGV5MB7v9L4rOLaXQ
        J2XEyZ+7vKPjJVyBSlgfr4asg+jthrU79qhCu9A77Kai+VIUoyMt/UspFCmISUvh
        fN/SwO6HeCySalYiK5IWjFxCQjK1JuL/wR7Zq/rP/FPXus35l7U45dhoceTMpckw
        koT4wVAThGHzQ+pR3pJGIef9HFXr4wln7d8bBA4PhWLWsRA/0g6MSkuONbA19g5z
        0NHcFzKOxrDS881CzG4qU5bFBACrc2qJltShmQuEG+SlpGsFIrUn21Nv9SvWfS/a
        ARl6kvtkpl52tZ26c0h1R2udVVGRSKeo9GNOhsxF2eRX57b4pBj0tGP8HisB4vT7
        /o2AQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=E/eIlh2168YayUz7yI7wcMUEWzVWY48EgCDeJX0YM
        mc=; b=a9kBxkyVK77sxjD/7mLsLVOu7ZRh8aqcB+qVA6ZhTszjPgdeGUsZCBr5W
        9XdNCfEEx0Ki8DFVR2oeEvPlpperlCQCoBXlPOBLm3lS3aalBRSBCbkiLzPz0uPk
        nF+lfeV1s+/abGu1wou3b+MktFjRpG/zLVHI7fJkZpeq5ovIdKzfoEsFTA4ZU8du
        VsuGjH05IwzNfKqIuZzm9Pmh8jPE6CWerFIAQ2EAyG9ljYIsKHsO41A750agoNdP
        IC0jeNj/pcF7thyz2zUKUUzaoTHhsDQ9eK4rpWvfi7FlkC8ih7r4Kss+UJ0HvAYN
        Aq36RAcm02qB8ha8h7unRK98xAHKQ==
X-ME-Sender: <xms:OdHeXUEWs5o7TXILYIJAwNVE41K8opmhTyiisUdezT0C-4kS03zb3w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudeihedguddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    fkphepudefiedrfedvrdeifedrvdegvdenucfrrghrrghmpehmrghilhhfrhhomhepshgr
    mhhuvghlsehshhholhhlrghnugdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:OdHeXX0aDv9YBuzW9gWZzwC_E7nc8j3Os2ip8HRqKFAqedL0SHn58w>
    <xmx:OdHeXfQ8HroTLDfDwnRpl9fDY2QZ_IhN9kghtJznHLSIqw_3YNPjvw>
    <xmx:OdHeXU0LaTyk-Lv0e1VJGkou9C58ojI5-GpBIUHTLFAdWC2enbrYxQ>
    <xmx:O9HeXUNxhlDeXv0rzUm5lt1jPWYDVLAzSEZA_u4O5InPWEkSuoNgaw>
Received: from [192.168.16.195] (unknown [136.32.63.242])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4BEF980059;
        Wed, 27 Nov 2019 14:40:40 -0500 (EST)
Subject: Re: [PATCH v6 4/7] ARM: dts: sun8i-h3: Add thermal sensor and thermal
 zones
To:     Vasily Khoruzhick <anarsoul@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        =?UTF-8?Q?Ond=c5=99ej_Jirman?= <megous@megous.com>,
        linux-kernel@vger.kernel.org
References: <20191127052935.1719897-1-anarsoul@gmail.com>
 <20191127052935.1719897-5-anarsoul@gmail.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <78c38148-872d-6aa1-5848-c0df2c22c2b6@sholland.org>
Date:   Wed, 27 Nov 2019 13:40:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191127052935.1719897-5-anarsoul@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 11/26/19 11:29 PM, Vasily Khoruzhick wrote:
> From: Ondrej Jirman <megous@megous.com>
> 
> There is just one sensor for the CPU.
> 
> Signed-off-by: Ondrej Jirman <megous@megous.com>
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
>  arch/arm/boot/dts/sun8i-h3.dtsi | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
> index e37c30e811d3..42fd0418d678 100644
> --- a/arch/arm/boot/dts/sun8i-h3.dtsi
> +++ b/arch/arm/boot/dts/sun8i-h3.dtsi
> @@ -177,6 +177,26 @@
>  			assigned-clocks = <&ccu CLK_GPU>;
>  			assigned-clock-rates = <384000000>;
>  		};
> +
> +		ths: ths@1c25000 {
> +			compatible = "allwinner,sun8i-h3-ths";
> +			reg = <0x01c25000 0x400>;
> +			interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
> +			resets = <&ccu RST_BUS_THS>;
> +			clocks = <&ccu CLK_BUS_THS>, <&ccu CLK_THS>;
> +			clock-names = "bus", "mod";
> +			nvmem-cells = <&ths_calibration>;
> +			nvmem-cell-names = "calibration";
> +			#thermal-sensor-cells = <0>;
> +		};
> +	};
> +
> +	thermal-zones {
> +		cpu_thermal: cpu-thermal {
> +			polling-delay-passive = <0>;
> +			polling-delay = <0>;
> +			thermal-sensors = <&ths 0>;
> +		};
>  	};
>  };
>  
> @@ -234,4 +254,10 @@
>  
>  &sid {
>  	compatible = "allwinner,sun8i-h3-sid";
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +
> +	ths_calibration: thermal-sensor-calibration@34 {
> +		reg = <0x34 4>;
> +	};

All of the lines added here are common between the H3 and H5, so they can go in
the shared SID node in sunxi-h3-h5.dtsi.

Cheers,
Samuel

>  };
> 


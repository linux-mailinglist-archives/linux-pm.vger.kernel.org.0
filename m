Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA8BC211D7A
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jul 2020 09:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728403AbgGBHtm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Jul 2020 03:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727043AbgGBHtl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Jul 2020 03:49:41 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E8EC08C5DC
        for <linux-pm@vger.kernel.org>; Thu,  2 Jul 2020 00:49:41 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f7so23945266wrw.1
        for <linux-pm@vger.kernel.org>; Thu, 02 Jul 2020 00:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fwfpJbIOu9tCKwQoSyX3k34gERv16DOUHr82n13fFPU=;
        b=WgVIfEWIWIZsDgecYoHJoSr0ORxYBQu1XyICcQFQee2m5YpxvE/7h5C44SOwIIPfA7
         B4s1XH8HyBK1NBAGTJO7fqytoZjouQN997rHEETXqn6YJNYAIWkZWnAQ1BwO020NEsab
         fdDNbw3qPxfdcbCu+zHDpjucvXECP1Zo6kH4QqX5KEW7oKV1QepizpDHPgX3nH1uZ+Hu
         L94LtUMjOQSl8aJMGSgHFKW8TeZzyDCwtCPC4Xe3zkPijqhSqMF/lrUI6VX4YkmChuVR
         fziM3EWaVCZZFrGWajtFRrmCSSDl7AphYxCpxVLgy7BxashK8ws/d/s20l9Ao01eIa0b
         1/1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=fwfpJbIOu9tCKwQoSyX3k34gERv16DOUHr82n13fFPU=;
        b=h054mNVRvoQDxOqn9WV+l6up+0g5cx5+irHfGKuawuw0oTGsrTnXXFdDl4qAjpimdO
         TIanW7UK2yBamfmry7lcWAmquT89iBzHpnX/a+hWkM9h3MUlXs+K0OFGcvsnhGZxq93O
         /2IiKAiKY9I5ceTUMlgaar4sBpZVDydaUN2XTEK1tr9y1Nt2ZGYAe7UrhxSeR1GAf/d5
         Izpd9QssXt8h2WG3oi4q3zjyaS5uLGSYWn+ls1ZRoQzOyq3awj7Q4KFgiYtrz4+yDrW3
         MTvWCquMP5lQ6cb9dVQPWOEYuJ8tdrXDi88X2LO4gOJMZMNKjNZJHc6Y37Pv5vXBARXG
         cSWg==
X-Gm-Message-State: AOAM530LGWGV+A3Y+sy/KnCFFkmGds/JW/KfLBf3E4LD1YPh9xPIKdqV
        zeVo3snp7QlWPSJKbiWqNsCcdQ==
X-Google-Smtp-Source: ABdhPJwaAX9WCvA+Cv/JH1yjVGwEZ4Dgk4rEsDhdosusI9cN1k4Mq+Th3cnJEOK4rARIaKZ76qpJ0Q==
X-Received: by 2002:adf:edc8:: with SMTP id v8mr29618741wro.125.1593676179630;
        Thu, 02 Jul 2020 00:49:39 -0700 (PDT)
Received: from ?IPv6:2a01:e35:2ec0:82b0:7023:727a:c688:cf9b? ([2a01:e35:2ec0:82b0:7023:727a:c688:cf9b])
        by smtp.gmail.com with ESMTPSA id y20sm9704926wmi.8.2020.07.02.00.49.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2020 00:49:38 -0700 (PDT)
Subject: Re: [PATCH v5 2/2] arm64: dts: meson-khadas-vim3: add Khadas MCU
 nodes
To:     khilman@baylibre.com
Cc:     lee.jones@linaro.org, linux-amlogic@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, amit.kucheria@verdurent.com,
        Amit Kucheria <amit.kucheria@linaro.org>
References: <20200624161528.12664-1-narmstrong@baylibre.com>
 <20200624161528.12664-3-narmstrong@baylibre.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 BSwxi7g3Mu7u5kUByanqHyA=
Organization: Baylibre
Message-ID: <b5a5de24-2fed-ebc4-52e1-9ff1ce3cfbc6@baylibre.com>
Date:   Thu, 2 Jul 2020 09:49:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200624161528.12664-3-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Kevin,

Can you apply this patch ? the rest of the serie has been pulled into Lee's tree.

Thanks,
Neil

On 24/06/2020 18:15, Neil Armstrong wrote:
> Add the Khadas MCU node with active FAN thermal nodes for all the
> Khadas VIM3 variants.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
> Hi Kevin,
> 
> The bindings has been reviewed and merged by Lee,
> could you apply this one via the amlogic tree ?
> 
> Thanks,
> Neil
> 
>  .../boot/dts/amlogic/meson-khadas-vim3.dtsi   | 23 +++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi b/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
> index 1ef1e3672b96..27408c10a811 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
> @@ -183,6 +183,23 @@
>  	hdmi-phandle = <&hdmi_tx>;
>  };
>  
> +&cpu_thermal {
> +	trips {
> +		cpu_active: cpu-active {
> +			temperature = <80000>; /* millicelsius */
> +			hysteresis = <2000>; /* millicelsius */
> +			type = "active";
> +		};
> +	};
> +
> +	cooling-maps {
> +		map {
> +			trip = <&cpu_active>;
> +			cooling-device = <&khadas_mcu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +		};
> +	};
> +};
> +
>  &ext_mdio {
>  	external_phy: ethernet-phy@0 {
>  		/* Realtek RTL8211F (0x001cc916) */
> @@ -222,6 +239,12 @@
>  	pinctrl-0 = <&i2c_ao_sck_pins>, <&i2c_ao_sda_pins>;
>  	pinctrl-names = "default";
>  
> +	khadas_mcu: system-controller@18 {
> +		compatible = "khadas,mcu";
> +		reg = <0x18>;
> +		#cooling-cells = <2>;
> +	};
> +
>  	gpio_expander: gpio-controller@20 {
>  		compatible = "ti,tca6408";
>  		reg = <0x20>;
> 


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5436DD1F9
	for <lists+linux-pm@lfdr.de>; Tue, 11 Apr 2023 07:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbjDKFqU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Apr 2023 01:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjDKFqP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Apr 2023 01:46:15 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6650B30F9
        for <linux-pm@vger.kernel.org>; Mon, 10 Apr 2023 22:46:11 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id f26so11325499ejb.1
        for <linux-pm@vger.kernel.org>; Mon, 10 Apr 2023 22:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681191969;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xihmr9JL0Vhdbfp74EXOqdqMM6EAF6p1smPLjZIdIQE=;
        b=bTkaxylAGG9cL59FJ6r3UP6O/AXJcv7OzX36B7yfYZ57VCz4O5YWb4HjDojB4jvHyb
         eCeH/s9yAOO00bUB96rxCNCaa7XwGBS+TG/GBt/NDYqGTkCYqevwopDXUPWFRpC5NIqX
         03JNqc61S0YCgKosNqMg0bCKmXspaWE6DfNyDrRZLd9jQ9wyndZCHKas5UsGU51ttY/Z
         LfW5+tmDhoaP/5GsHXQEqsrtQYRfDR4PfqaD2cuTNr623hRoD2Dz6K9ANXteWPLvmyCd
         CZCspl+lq0Q5AIzq6mNbA56dXoM6XIiHWkpi4lPSRWgIeMNyA3+IOKNwydnuhMaMTtKW
         DoRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681191969;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xihmr9JL0Vhdbfp74EXOqdqMM6EAF6p1smPLjZIdIQE=;
        b=odNXzK/jS4+59WCTqgzyP25jgJG2iHH8PA9PCSIN3DQE+lKrN/tdE+NXYHfxmuvUZp
         wuvRZmKpsOfmjiVtFMrMELqpFFrZK/9btFOhCXnLKbAHxZaiMC/HKFvjTgXCbqfATzdu
         CKpvIBifQucD7YxZAxg+MQfvNHKQndJPu2EWGe9HPMtuY3hJ8jtyg4QspXmFIjDB2bSF
         wodDzZLD0R2SKMUjvf1No439ZhuJqzpfdKCij3Fm0hpNOXNemSxOGMC5VVbTzj4vaa2I
         AxkVUOl6mAcS5Jva6XdykKwd5P8DjlRw4zk+czpOhSRfTUkCEIARlrggpqX3PTIJQ4D1
         Yw3g==
X-Gm-Message-State: AAQBX9cQHnsvUnjEqmJQwHCRoHZjjLBf/UDcFT34IkgxXcq3J+k+O3C6
        N4Si+nLDWgHMh8TUpP/ZAqqu/Q==
X-Google-Smtp-Source: AKy350Y+EqZzcprQnTEQPVL3vMWZOK+45c9QuOgJkvcIYZwiYynI5m2dsKOmr8YO99UKYCsC/hv4Xw==
X-Received: by 2002:a17:906:ca44:b0:90b:53f6:fd8b with SMTP id jx4-20020a170906ca4400b0090b53f6fd8bmr9755035ejb.31.1681191969687;
        Mon, 10 Apr 2023 22:46:09 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:dad2:72b7:3626:af61? ([2a02:810d:15c0:828:dad2:72b7:3626:af61])
        by smtp.gmail.com with ESMTPSA id m2-20020a1709062ac200b008b176df2899sm5750277eje.160.2023.04.10.22.46.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Apr 2023 22:46:09 -0700 (PDT)
Message-ID: <83c098ed-a9f4-e856-fea7-c8714c1cc1aa@linaro.org>
Date:   Tue, 11 Apr 2023 07:46:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH V2 6/6] ARM: dts: imx6ul: Add clock and PGC node to GPC
Content-Language: en-US
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     kernel@pengutronix.de, Fabio Estevam <festevam@gmail.com>,
        linux-imx@nxp.com, "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, Jacky Bai <ping.bai@nxp.com>
References: <20230410205803.45853-1-stefan.wahren@i2se.com>
 <20230410205803.45853-7-stefan.wahren@i2se.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230410205803.45853-7-stefan.wahren@i2se.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/04/2023 22:58, Stefan Wahren wrote:
> According to fsl,imx-gpc.yaml the General Power Control requires
> a ipg clock and a Power Gating Control node. So add them to fix
> the dtbs_check warnings on i.MX6UL boards:
> 
> gpc@20dc000: 'clocks' is a required property
> gpc@20dc000: 'clock-names' is a required property
> gpc@20dc000: 'pgc' is a required property
> 
> Suggested-by: Jacky Bai <ping.bai@nxp.com>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---
>  arch/arm/boot/dts/imx6ul.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
> index 118764c50d92..a8efaed69214 100644
> --- a/arch/arm/boot/dts/imx6ul.dtsi
> +++ b/arch/arm/boot/dts/imx6ul.dtsi
> @@ -719,6 +719,18 @@ gpc: gpc@20dc000 {
>  				#interrupt-cells = <3>;
>  				interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
>  				interrupt-parent = <&intc>;
> +				clocks = <&clks IMX6UL_CLK_IPG>;
> +				clock-names = "ipg";
> +
> +				pgc {
> +						#address-cells = <1>;
> +						#size-cells = <0>;

Wrong indentation.

Best regards,
Krzysztof


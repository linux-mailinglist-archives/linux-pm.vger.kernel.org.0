Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0CF3C5F7F
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jul 2021 17:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235563AbhGLPoc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Jul 2021 11:44:32 -0400
Received: from mail-io1-f51.google.com ([209.85.166.51]:34535 "EHLO
        mail-io1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235453AbhGLPob (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Jul 2021 11:44:31 -0400
Received: by mail-io1-f51.google.com with SMTP id g22so23283402iom.1;
        Mon, 12 Jul 2021 08:41:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=So363S9K1xaiE2gvVFLgGJk4L6cIe1WtHli+BpBLUGQ=;
        b=ELZ85nUOfBHoC+9bQeCIJMUsYbix6UihzlX9qtCf+/B10hg37s/s/6g5mT6qAd974k
         igKVAxfuFCVgTygOgooh8yCSSh+a9EYLWxt1dQIq127nv9ScvCgGamaadUYhrZOZQqTR
         2stOLPt8q4W6wtAn1ouGQWKkhwD8WdnTDDLBxNdl0pMttwgA5fjloeGpDpQFoPENHZt5
         Qj+vDyvMHsTGYS2lDAczdWyU/OFqHf8Lbr8rCsNa1aWnZ0qaMcYJhTrOSQiCeFqVxu7p
         BD6iqpx9VMLMP+xGo73LO/SpR9cZlkksy1Sv4J8s6G+U/AzguGDSJKLeTfG49rqq5LA3
         9tgg==
X-Gm-Message-State: AOAM533CA7PEyDyGunW56KAaMOFkYH3kWHtv2Fsh3WLQOSZuL3M4D1Ty
        8QX5QUlutLWJEKMcxRKssA==
X-Google-Smtp-Source: ABdhPJyUUnj2N0PKw9pZrLgUyzMldZX4nOEnjK8oCSzeWh+u0g8DYR7jYAAEvMLGhlVWNzAxTUh2Qg==
X-Received: by 2002:a02:93a3:: with SMTP id z32mr14042078jah.33.1626104501779;
        Mon, 12 Jul 2021 08:41:41 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id t11sm8223332iob.5.2021.07.12.08.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 08:41:40 -0700 (PDT)
Received: (nullmailer pid 1987378 invoked by uid 1000);
        Mon, 12 Jul 2021 15:41:39 -0000
Date:   Mon, 12 Jul 2021 09:41:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Peter Chen <peter.chen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        David Heidelberg <david@ixit.cz>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v3 02/12] dt-bindings: phy: tegra20-usb-phy: Document
 properties needed for OTG mode
Message-ID: <20210712154139.GB1980362@robh.at.kernel.org>
References: <20210704225433.32029-1-digetx@gmail.com>
 <20210704225433.32029-3-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210704225433.32029-3-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jul 05, 2021 at 01:54:23AM +0300, Dmitry Osipenko wrote:
> In order to support OTG mode we need these new properties:
> 
> 	- interrupt
> 	- nvidia,pmc
> 	- nvidia,phy-instance
> 
> The nvidia,phy-instance isn't strictly needed for the OTG mode since we
> know that only first controller supports it in practice, but it will be
> needed in general for supporting more complex hardware features that
> require knowledge of the PHY offset within common registers of the Power
> Management controller (PMC).
> 
> Add the new properties to the bindings.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../bindings/phy/nvidia,tegra20-usb-phy.yaml  | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/nvidia,tegra20-usb-phy.yaml b/Documentation/devicetree/bindings/phy/nvidia,tegra20-usb-phy.yaml
> index 593187234e6a..a108f1552042 100644
> --- a/Documentation/devicetree/bindings/phy/nvidia,tegra20-usb-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/nvidia,tegra20-usb-phy.yaml
> @@ -77,6 +77,9 @@ properties:
>            - const: timer
>            - const: utmi-pads
>  
> +  interrupts:
> +    maxItems: 1
> +
>    resets:
>      oneOf:
>        - maxItems: 1
> @@ -199,6 +202,17 @@ properties:
>      maxItems: 1
>      description: GPIO used to reset the PHY.
>  
> +  nvidia,pmc:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Phandle to Power Management controller.
> +

Add a cell to this for the PHY reg offset and then get rid of the index:

> +  nvidia,phy-instance:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 2
> +    description: Unique hardware ID.
> +
>  required:
>    - compatible
>    - reg
> @@ -320,6 +334,7 @@ examples:
>          compatible = "nvidia,tegra124-usb-phy", "nvidia,tegra30-usb-phy";
>          reg = <0x7d008000 0x4000>,
>                <0x7d000000 0x4000>;
> +        interrupts = <0 97 4>;
>          phy_type = "utmi";
>          clocks = <&tegra_car TEGRA124_CLK_USB3>,
>                   <&tegra_car TEGRA124_CLK_PLL_U>,
> @@ -338,6 +353,8 @@ examples:
>          nvidia,hssquelch-level = <2>;
>          nvidia,hsdiscon-level = <5>;
>          nvidia,xcvr-hsslew = <12>;
> +        nvidia,pmc = <&tegra_pmc>;
> +        nvidia,phy-instance= <2>;
>      };
>  
>    - |
> @@ -346,6 +363,7 @@ examples:
>      usb-phy@c5004000 {
>          compatible = "nvidia,tegra20-usb-phy";
>          reg = <0xc5004000 0x4000>;
> +        interrupts = <0 21 4>;
>          phy_type = "ulpi";
>          clocks = <&tegra_car TEGRA20_CLK_USB2>,
>                   <&tegra_car TEGRA20_CLK_PLL_U>,
> @@ -354,4 +372,6 @@ examples:
>          resets = <&tegra_car 58>, <&tegra_car 22>;
>          reset-names = "usb", "utmi-pads";
>          #phy-cells = <0>;
> +        nvidia,pmc = <&tegra_pmc>;
> +        nvidia,phy-instance= <1>;
>      };
> -- 
> 2.32.0
> 
> 

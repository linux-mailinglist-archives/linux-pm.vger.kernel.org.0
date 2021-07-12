Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB5073C5F66
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jul 2021 17:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234033AbhGLPl4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Jul 2021 11:41:56 -0400
Received: from mail-il1-f181.google.com ([209.85.166.181]:42675 "EHLO
        mail-il1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbhGLPl4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Jul 2021 11:41:56 -0400
Received: by mail-il1-f181.google.com with SMTP id h3so19899020ilc.9;
        Mon, 12 Jul 2021 08:39:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B+nMaHSdy0WVhCgerO1hhALOLwMm3IXshSqh6cxMfhA=;
        b=krV/7OrF1CLpK09A1bkV2O6nfnlafGq8ms09lQEs2ydMeUHaUttFSuwnIYpFGX890o
         /OzyW2d+ZsKKKA5Hy8+c7hIK09dpH4GouBG/yqYO2HBLjgDsXncpHMpTHNl6n3Rw+qvd
         oLHk76X+SMdZ2egURYlJfyyO9pTfnP0P/wQDpGE1soLmKZeMGhpOKLAKsY6MqukrQ3ff
         KEiXp9j73pYCT2A/wFTw2aKkqv452d2nNz4N08dVleioawo/8sqkPU+7fpjF/2XaWhGX
         lmhiigmrldmEhQZR4ChkF5czjoYhxKf50KNWX3mHtynmd2MvQvajhvm+0LUaRJbn+NUY
         axag==
X-Gm-Message-State: AOAM532LbtaZh71CdJi64Mi65bpdoKGk5yy40c7wWKdLyZTEOVrqKUQg
        jms5LXSyKRzPYzhz+36Odw==
X-Google-Smtp-Source: ABdhPJy7XhgyI67pFJvVw1YYTTUr6OA8qrF9lKIuPOJu/03ijIDGlddBRAX4dgpDCmbXCcnLkXbYQQ==
X-Received: by 2002:a05:6e02:1c88:: with SMTP id w8mr6129418ill.154.1626104347745;
        Mon, 12 Jul 2021 08:39:07 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id x19sm4913974iob.22.2021.07.12.08.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 08:39:07 -0700 (PDT)
Received: (nullmailer pid 1983420 invoked by uid 1000);
        Mon, 12 Jul 2021 15:39:05 -0000
Date:   Mon, 12 Jul 2021 09:39:05 -0600
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
Subject: Re: [PATCH v3 06/12] dt-bindings: power: supply: smb347-charger:
 Document USB VBUS regulator
Message-ID: <20210712153905.GA1980362@robh.at.kernel.org>
References: <20210704225433.32029-1-digetx@gmail.com>
 <20210704225433.32029-7-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210704225433.32029-7-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jul 05, 2021 at 01:54:27AM +0300, Dmitry Osipenko wrote:
> SMB347 can supply power to USB VBUS, which is required by OTG-cable
> devices that want to switch USB port into the host mode. Add USB VBUS
> regulator properties.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../power/supply/summit,smb347-charger.yaml   | 28 +++++++++++++++++++
>  .../dt-bindings/power/summit,smb347-charger.h |  4 +++
>  2 files changed, 32 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/summit,smb347-charger.yaml b/Documentation/devicetree/bindings/power/supply/summit,smb347-charger.yaml
> index 983fc215c1e5..cd3d834f734d 100644
> --- a/Documentation/devicetree/bindings/power/supply/summit,smb347-charger.yaml
> +++ b/Documentation/devicetree/bindings/power/supply/summit,smb347-charger.yaml
> @@ -73,6 +73,24 @@ properties:
>        - 1 # SMB3XX_SOFT_TEMP_COMPENSATE_CURRENT Current compensation
>        - 2 # SMB3XX_SOFT_TEMP_COMPENSATE_VOLTAGE Voltage compensation
>  
> +  summit,inok-polarity:
> +    description: |
> +      Polarity of INOK signal indicating presence of external power supply.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum:
> +      - 0 # SMB3XX_SYSOK_INOK_ACTIVE_LOW
> +      - 1 # SMB3XX_SYSOK_INOK_ACTIVE_HIGH
> +
> +  usb-vbus:
> +    $ref: "../../regulator/regulator.yaml#"
> +    type: object

       unevaluatedProperties: false

With that,

Reviewed-by: Rob Herring <robh@kernel.org>

> +
> +    properties:
> +      summit,needs-inok-toggle:
> +        type: boolean
> +        description: INOK signal is fixed and polarity needs to be toggled
> +                     in order to enable/disable output mode.
> +
>  allOf:
>    - if:
>        properties:
> @@ -134,6 +152,7 @@ examples:
>              reg = <0x7f>;
>  
>              summit,enable-charge-control = <SMB3XX_CHG_ENABLE_PIN_ACTIVE_HIGH>;
> +            summit,inok-polarity = <SMB3XX_SYSOK_INOK_ACTIVE_LOW>;
>              summit,chip-temperature-threshold-celsius = <110>;
>              summit,mains-current-limit-microamp = <2000000>;
>              summit,usb-current-limit-microamp = <500000>;
> @@ -141,6 +160,15 @@ examples:
>              summit,enable-mains-charging;
>  
>              monitored-battery = <&battery>;
> +
> +            usb-vbus {
> +                regulator-name = "usb_vbus";
> +                regulator-min-microvolt = <5000000>;
> +                regulator-max-microvolt = <5000000>;
> +                regulator-min-microamp = <750000>;
> +                regulator-max-microamp = <750000>;
> +                summit,needs-inok-toggle;
> +            };
>          };
>      };
>  
> diff --git a/include/dt-bindings/power/summit,smb347-charger.h b/include/dt-bindings/power/summit,smb347-charger.h
> index d918bf321a71..3205699b5e41 100644
> --- a/include/dt-bindings/power/summit,smb347-charger.h
> +++ b/include/dt-bindings/power/summit,smb347-charger.h
> @@ -16,4 +16,8 @@
>  #define SMB3XX_CHG_ENABLE_PIN_ACTIVE_LOW	1
>  #define SMB3XX_CHG_ENABLE_PIN_ACTIVE_HIGH	2
>  
> +/* Polarity of INOK signal */
> +#define SMB3XX_SYSOK_INOK_ACTIVE_LOW		0
> +#define SMB3XX_SYSOK_INOK_ACTIVE_HIGH		1
> +
>  #endif
> -- 
> 2.32.0
> 
> 

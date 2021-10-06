Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F75242386A
	for <lists+linux-pm@lfdr.de>; Wed,  6 Oct 2021 08:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233968AbhJFG65 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Oct 2021 02:58:57 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:49148
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237331AbhJFG64 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Oct 2021 02:58:56 -0400
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com [209.85.167.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 68CBD3FFE4
        for <linux-pm@vger.kernel.org>; Wed,  6 Oct 2021 06:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633503422;
        bh=oBd5s4+6tEQT7bthyqlL4VvsdjmF+NhdczufCXOLTMo=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=pqe/RffEYeekMLQiMSMuP49z97xEm0tFOJPR9w1hprzCLcSFtJvmvYZBM3blRfhWC
         9h1kUTfvxN+n1hq59AJiTyC8wyflvwO8bZ24z8y/Mr8vzuL+5l4SWgJGr03wUpmOLZ
         z+Yj8IP4FR1OSU57q7YlZFN6H3TqswM3uMgo3ijg6tnRBJjxE+l3C8Cr0cvwC1eply
         tM1AVVYQy7zDjXn6MA0k019AI6sfqaLp/CD8NFyhA1WjPqXUrHHp9Gf5MJ4d/8U15Q
         Fjf+an158teNHNPKry4YA1HBRMZh2gE2LbymDquWDoAqAp3ClPGjScTOO1bGRZrW7w
         rKF9eQkaWa78g==
Received: by mail-lf1-f70.google.com with SMTP id s8-20020ac25c48000000b003faf62e104eso1166160lfp.22
        for <linux-pm@vger.kernel.org>; Tue, 05 Oct 2021 23:57:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oBd5s4+6tEQT7bthyqlL4VvsdjmF+NhdczufCXOLTMo=;
        b=XjbaVvWidEJO9Kz5khBbuRzXau7Uh2Sq+5hI7U7JI7UvXX08f8PxP1KZ76KEnVJKXm
         ahow+aCuoUyUCleEMipItQW3b9V3dv5XKYV+p9einh+O75gvYIx1BMU7J5+Bz1h2HaOB
         9komEzldJvSCKZ8acBRPajRnlAq6v8gNLJUmWAxp4Sv3LKzwwF9bAWFbv/9AJEcIGXBm
         5Ak8+C2hB1XivQHNjkDngM5GrZWEAG4BuByJFnslQd+QLnGUhGUK24Lco/XMzMyIf+ci
         NkOdNVla1s7JqIC94YMoG1wSe04J4uIe8AOvjuaepOTZvjXFdi8FUIkAU0Y2C2D+cCOG
         NGsQ==
X-Gm-Message-State: AOAM533HD2lrR/52qD5XzUNwDyY9AmmCj3cIRSZw3P7sazb4OJNyIOL5
        K3w8QkfblqGU+NKPa7dEnN6v5i19j9BYw1poF7e+sLmOGlEHGxdoL7oWQUKrAjE/u00tU/a6t28
        xDFPvsBcm1AtsebgdwejL4pruEtllXnyxHiU/
X-Received: by 2002:a19:c218:: with SMTP id l24mr8078203lfc.588.1633503421704;
        Tue, 05 Oct 2021 23:57:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx0wVhgkx+rcS8gRjiHqaAE+DTq9q3wo4KrmTTq5XXnN9gwMBdMs1x5aVB70fvBmq+M87pWPg==
X-Received: by 2002:a19:c218:: with SMTP id l24mr8078186lfc.588.1633503421491;
        Tue, 05 Oct 2021 23:57:01 -0700 (PDT)
Received: from [192.168.0.20] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id d7sm2391106lfa.80.2021.10.05.23.57.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Oct 2021 23:57:00 -0700 (PDT)
Subject: Re: [PATCH 1/7] dt-bindings: arm: apple: Add apple,pmgr binding
To:     Hector Martin <marcan@marcan.st>,
        linux-arm-kernel@lists.infradead.org
Cc:     Marc Zyngier <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-serial@vger.kernel.org
References: <20211005155923.173399-1-marcan@marcan.st>
 <20211005155923.173399-2-marcan@marcan.st>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <18818eff-87d7-6a53-a4fd-7f3cbf625a0e@canonical.com>
Date:   Wed, 6 Oct 2021 08:56:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211005155923.173399-2-marcan@marcan.st>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 05/10/2021 17:59, Hector Martin wrote:
> The PMGR block in Apple Silicon SoCs is responsible for SoC power
> management. There are two PMGRs in T8103, with different register
> layouts but compatible registers. In order to support this as well
> as future SoC generations with backwards-compatible registers, we
> declare these blocks as syscons and bind to individual registers
> in child nodes. Each register controls one SoC device.
> 
> The respective apple compatibles are defined in case device-specific
> quirks are necessary in the future, but currently these nodes are
> expected to be bound by the generic syscon driver.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  .../bindings/arm/apple/apple,pmgr.yaml        | 74 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 75 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml b/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml
> new file mode 100644
> index 000000000000..0304164e4140
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml
> @@ -0,0 +1,74 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/apple/apple,pmgr.yaml#

Please don't store all Apple-related bindings in bindings/arm/apple, but
instead group per device type like in most of other bindings. In this
case - this looks like something close to power domain controller, so it
should be in bindings/power/

> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Apple SoC Power Manager (PMGR)
> +
> +maintainers:
> +  - Hector Martin <marcan@marcan.st>
> +
> +description: |
> +  Apple SoCs include a PMGR block responsible for power management,
> +  which can control various clocks, resets, power states, and
> +  performance features. This node represents the PMGR as a syscon,
> +  with sub-nodes representing individual features.
> +
> +  Apple SoCs may have a secondary "mini-PMGR"; it is represented
> +  separately in the device tree, but works the same way.
> +
> +select:
> +  properties:
> +    compatible:
> +      contains:
> +        enum:
> +          - apple,t8103-pmgr
> +          - apple,t8103-minipmgr
> +          - apple,pmgr
> +
> +  required:
> +    - compatible
> +
> +properties:
> +  $nodename:
> +    pattern: "^power-management@[0-9a-f]+$"
> +
> +  compatible:
> +    items:
> +      - enum:
> +          - apple,t8103-pmgr
> +          - apple,t8103-minipmgr
> +      - const: apple,pmgr
> +      - const: syscon
> +      - const: simple-mfd

No power-domain-cells? Why? What exactly this device is going to do?
Maybe I'll check the driver first.... :)

> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: true

additionalProperties: false

> +
> +examples:
> +  - |
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        power-management@23b700000 {
> +            compatible = "apple,t8103-pmgr", "apple,pmgr", "syscon", "simple-mfd";
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +            reg = <0x2 0x3b700000 0x0 0x14000>;
> +        };
> +
> +        power-management@23b700000 {
> +            compatible = "apple,t8103-minipmgr", "apple,pmgr", "syscon", "simple-mfd";
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +            reg = <0x2 0x3d280000 0x0 0xc000>;
> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index abdcbcfef73d..d25598842d15 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1719,6 +1719,7 @@ B:	https://github.com/AsahiLinux/linux/issues
>  C:	irc://irc.oftc.net/asahi-dev
>  T:	git https://github.com/AsahiLinux/linux.git
>  F:	Documentation/devicetree/bindings/arm/apple.yaml
> +F:	Documentation/devicetree/bindings/arm/apple/*
>  F:	Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
>  F:	Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
>  F:	arch/arm64/boot/dts/apple/
> 


Best regards,
Krzysztof

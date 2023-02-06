Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A457568C26B
	for <lists+linux-pm@lfdr.de>; Mon,  6 Feb 2023 17:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjBFQDo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Feb 2023 11:03:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjBFQDn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Feb 2023 11:03:43 -0500
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FDBA173C;
        Mon,  6 Feb 2023 08:03:42 -0800 (PST)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-1442977d77dso15625731fac.6;
        Mon, 06 Feb 2023 08:03:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cTOW8V7JT3rpM54x+sIt16Be3bXcZK7WhfxJJqhWNtM=;
        b=JU2gl/ZpHGbRB0pyqGs5eFXzFqkWrlSrRFyIJv8B/RprXnCULJVVWskUAneZtIwmWR
         AMurlyXvrJqv/RZrjrNkJr8F7p4JbBL4PTYQ8slNJUDNZYvetY9E6AQM8uVlrxAhIux3
         FQYjEk4RLpgnFu6IT2rd6tdiIIJzFiGm0z6BRCbfnWGoXrxHpbbmwoh1gvYeG1EcbMxi
         0LJIK6glbVVpAuLN9zY1Mr1Ik09rnzzSzObRqlASzC/nbmTxylMfH1d9ueD+NVIAG38d
         Bn0ckmrM6AVqMsO2ibLKIrlnvTGd+ciDLiN1Rf9tFX5WoyolFNu/wtKibzJ/qoQvJLLl
         6UlQ==
X-Gm-Message-State: AO0yUKUo/AQbnkutIVEM6PLZVql2X45hznfBOiUj+MhiaWUpBbQbdcdF
        xW1RsYdhPQDIxVILW4Xu+1wE0z44lg==
X-Google-Smtp-Source: AK7set+J7NZXn1rlB9bUSExiFFc13ucmtlEJnPhyfTmeLcUPM2hvt6eZcOUTAmG1TBhSVpJNuMVOhw==
X-Received: by 2002:a05:6870:f114:b0:15f:c2e8:6602 with SMTP id k20-20020a056870f11400b0015fc2e86602mr115020oac.20.1675699421000;
        Mon, 06 Feb 2023 08:03:41 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id n4-20020a056870880400b0014866eb34cesm4243152oam.48.2023.02.06.08.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 08:03:40 -0800 (PST)
Received: (nullmailer pid 151323 invoked by uid 1000);
        Mon, 06 Feb 2023 16:03:40 -0000
Date:   Mon, 6 Feb 2023 10:03:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: power: supply: Add Lenovo Yoga C630
 EC
Message-ID: <20230206160340.GA149179-robh@kernel.org>
References: <20230205152809.2233436-1-dmitry.baryshkov@linaro.org>
 <20230205152809.2233436-2-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230205152809.2233436-2-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Feb 05, 2023 at 05:28:07PM +0200, Dmitry Baryshkov wrote:
> From: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> Add binding for the Embedded Controller found in the Qualcomm
> Snapdragon-based Lenovo Yoga C630.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  .../power/supply/lenovo,yoga-c630-ec.yaml     | 83 +++++++++++++++++++
>  1 file changed, 83 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/lenovo,yoga-c630-ec.yaml
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/lenovo,yoga-c630-ec.yaml b/Documentation/devicetree/bindings/power/supply/lenovo,yoga-c630-ec.yaml
> new file mode 100644
> index 000000000000..37977344f157
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/lenovo,yoga-c630-ec.yaml
> @@ -0,0 +1,83 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/supply/lenovo,yoga-c630-ec.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Lenovo Yoga C630 Embedded Controller.
> +
> +maintainers:
> +  - Bjorn Andersson <bjorn.andersson@linaro.org>
> +
> +description:
> +  The Qualcomm Snapdragon-based Lenovo Yoga C630 has an Embedded Controller
> +  (EC) which handles things such as battery and USB Type-C. This binding
> +  describes the interface, on an I2C bus, to this EC.
> +
> +properties:
> +  compatible:
> +    const: lenovo,yoga-c630-ec
> +
> +  reg:
> +    const: 0x70
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +  interrupts:
> +    maxItems: 1
> +
> +patternProperties:
> +  '^connector@[01]$':
> +    $ref: /schemas/connector/usb-connector.yaml#
> +
> +    properties:
> +      reg:
> +        maxItems: 1
> +
> +    unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |+
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c1 {

i2c {

> +        clock-frequency = <400000>;

Not relevant to the example.

> +
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        embedded-controller@70 {
> +            compatible = "lenovo,yoga-c630-ec";
> +            reg = <0x70>;
> +
> +            interrupts-extended = <&tlmm 20 IRQ_TYPE_LEVEL_HIGH>;
> +
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            connector@0 {
> +                compatible = "usb-c-connector";
> +                reg = <0>;
> +                power-role = "source";
> +                data-role = "host";
> +            };
> +
> +            connector@1 {
> +                compatible = "usb-c-connector";
> +                reg = <1>;
> +                power-role = "source";
> +                data-role = "host";
> +            };
> +        };
> +    };
> +...
> -- 
> 2.39.1
> 

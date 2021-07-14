Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF063C9338
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jul 2021 23:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbhGNVml (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 14 Jul 2021 17:42:41 -0400
Received: from mail-io1-f53.google.com ([209.85.166.53]:34437 "EHLO
        mail-io1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbhGNVml (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 14 Jul 2021 17:42:41 -0400
Received: by mail-io1-f53.google.com with SMTP id g22so3970183iom.1;
        Wed, 14 Jul 2021 14:39:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Z4NVch98aD43iq8SXnnDg49i1tAZP403b8WipKs5Fxk=;
        b=rNuzhnSJRMn20FFKRa+Tduzs5viYix0G4ddQd5OlsiVSqxbtccnA9hsuURiO6BYu7/
         gN4C+bjzMLJYQFygxcdAUBwWVzgFgsI/CeSlnFIGWy4KOTBfWtHUK5KwyC2jKXB9j7m4
         le54zptkLQt2JDWlRoqDoHBCmoKjXn7OfaiIszczXpAm4kbkP7RNy7bCccnDUMLnCx9z
         LOGsuPZD3LiqebSXt2PKSP4nLweGHpqczK32cXOgF51YMWOUCjvj2dFbgbvGS36rwnZn
         lnXu2zMIAjyaB5U/MjpOvPAAst/Xo+J81W47uqTYSOWvX84WhqC3T2iOgVcAWhT7APC4
         QBBA==
X-Gm-Message-State: AOAM531DLo9LOnqp659mad8iHnFnK/qn+o+UsHWh2FVW0c9ucPPwswHa
        f9xEozcNg4Kg+CiFaK9BMw==
X-Google-Smtp-Source: ABdhPJz97bBkq0lPll10famTNgRCP51FL5VqscHn3cleh0Hvh8gNMsaxOKFtV/a39iCGHSXpmeakjQ==
X-Received: by 2002:a5d:8888:: with SMTP id d8mr156540ioo.170.1626298788855;
        Wed, 14 Jul 2021 14:39:48 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id m184sm1891441ioa.17.2021.07.14.14.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 14:39:48 -0700 (PDT)
Received: (nullmailer pid 3575334 invoked by uid 1000);
        Wed, 14 Jul 2021 21:39:46 -0000
Date:   Wed, 14 Jul 2021 15:39:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Cc:     bjorn.andersson@linaro.org, viresh.kumar@linaro.org,
        agross@kernel.org, rjw@rjwysocki.net, devicetree@vger.kernel.org,
        amit.kucheria@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, jami.kettunen@somainline.org,
        paul.bouchara@somainline.org,
        ~postmarketos/upstreaming@lists.sr.ht, jeffrey.l.hugo@gmail.com
Subject: Re: [PATCH v6 8/9] dt-bindings: cpufreq: qcom-hw: Add bindings for
 8998
Message-ID: <20210714213946.GA3568065@robh.at.kernel.org>
References: <20210701105730.322718-1-angelogioacchino.delregno@somainline.org>
 <20210701105730.322718-9-angelogioacchino.delregno@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210701105730.322718-9-angelogioacchino.delregno@somainline.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jul 01, 2021 at 12:57:29PM +0200, AngeloGioacchino Del Regno wrote:
> The OSM programming addition has been done under the
> qcom,cpufreq-hw-8998 compatible name: specify the requirement
> of two additional register spaces for this functionality.
> This implementation, with the same compatible, has been
> tested on MSM8998 and SDM630.

Certainly we should be using the new binding for any new SoCs.

> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> ---
>  .../bindings/cpufreq/cpufreq-qcom-hw.yaml     | 67 ++++++++++++++-----
>  1 file changed, 52 insertions(+), 15 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
> index bc81b6203e27..29b663321a0b 100644
> --- a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
> @@ -18,6 +18,10 @@ description: |
>  properties:
>    compatible:
>      oneOf:
> +      - description: Non-secure v1 of CPUFREQ HW
> +        items:
> +          - const: qcom,cpufreq-hw-8998
> +
>        - description: v1 of CPUFREQ HW
>          items:
>            - const: qcom,cpufreq-hw
> @@ -28,21 +32,9 @@ properties:
>                - qcom,sm8250-cpufreq-epss
>            - const: qcom,cpufreq-epss
>  
> -  reg:
> -    minItems: 2
> -    maxItems: 3
> -    items:
> -      - description: Frequency domain 0 register region
> -      - description: Frequency domain 1 register region
> -      - description: Frequency domain 2 register region
> +  reg: {}
>  
> -  reg-names:
> -    minItems: 2
> -    maxItems: 3
> -    items:
> -      - const: freq-domain0
> -      - const: freq-domain1
> -      - const: freq-domain2
> +  reg-names: {}
>  
>    clocks:
>      items:
> @@ -57,10 +49,55 @@ properties:
>    '#freq-domain-cells':
>      const: 1
>  
> +if:
> +  properties:
> +    compatible:
> +      contains:
> +        const: qcom,cpufreq-hw-8998
> +then:
> +  properties:
> +    reg:
> +      minItems: 2
> +      maxItems: 6
> +      items:
> +        - description: Frequency domain 0 register region
> +        - description: Operating State Manager domain 0 register region
> +        - description: Frequency domain 1 register region
> +        - description: Operating State Manager domain 1 register region
> +        - description: PLL ACD domain 0 register region (if ACD programming required)
> +        - description: PLL ACD domain 1 register region (if ACD programming required)
> +
> +    reg-names:
> +      minItems: 2
> +      maxItems: 6
> +      items:
> +        - const: "osm-domain0"
> +        - const: "freq-domain0"
> +        - const: "osm-domain1"
> +        - const: "freq-domain1"
> +        - const: "osm-acd0"
> +        - const: "osm-acd1"

This is different enough and there's not much else to this bindings, so 
I think you should do a separate schema doc.

BTW, Don't need quotes here.

> +
> +else:
> +  properties:
> +    reg:
> +      minItems: 2
> +      maxItems: 3
> +      items:
> +        - description: Frequency domain 0 register region
> +        - description: Frequency domain 1 register region
> +        - description: Frequency domain 2 register region
> +    reg-names:
> +      minItems: 2
> +      maxItems: 3
> +      items:
> +        - const: "freq-domain0"
> +        - const: "freq-domain1"
> +        - const: "freq-domain2"
> +
>  required:
>    - compatible
>    - reg
> -  - reg-names
>    - clocks
>    - clock-names
>    - '#freq-domain-cells'
> -- 
> 2.32.0
> 
> 

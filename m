Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF1121BAD9
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jul 2020 18:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgGJQ1C (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Jul 2020 12:27:02 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:39303 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbgGJQ1C (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jul 2020 12:27:02 -0400
Received: by mail-io1-f68.google.com with SMTP id f23so6644748iof.6;
        Fri, 10 Jul 2020 09:27:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=i9iYWjE4vBb1BFZdyqk4e90udcdzqPWgpMUqV/BqKm0=;
        b=PaQsDr2zitTWZVsEl53VuqN4WUK/l3uTsqKHOm4LQ3QtXNnDdWvShDYu2przpkxBl+
         01YS1Ovf0N3tI1QK877u/oPNdAgp44/8FTN8ckfERMZIRuI1RfgLLiRrv7UHV95oG9XK
         r1TP2csgaTXOiRf0vb3dDa1pqPHDmWOXnWE1H/AVNS8oZjPjikFzA69SG5QBGC1UDTjE
         m9pel7fovqBrflZdN0OGefQHyroZcrDrhgP2eG1b5RRMXBXtpZfiZu4yKiH8VchgP6mm
         5OHXGDiIPWaie0lBORK7R2+ZfGvqbumoq9Ael8wT2gnRWYf+WAwIyUc9UrjnyRRKem5t
         C4kg==
X-Gm-Message-State: AOAM530vMXMOUMVqVVgvTjkk5O/DaQphE27HcWCLG7AQKT2Cs51yzkDe
        NSxSHmrpnI728KtXLTjmy1qghW81ZQHx
X-Google-Smtp-Source: ABdhPJzjBcfMgGclNycTfkDjb4tT2Ho3eooPCrDhSSTj1zZ0i+J6mqv3fllk1gsBGADFLtAPqsbb6g==
X-Received: by 2002:a02:cd28:: with SMTP id h8mr65748586jaq.40.1594398421046;
        Fri, 10 Jul 2020 09:27:01 -0700 (PDT)
Received: from xps15 ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id k3sm3873588iot.42.2020.07.10.09.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 09:27:00 -0700 (PDT)
Received: (nullmailer pid 2750605 invoked by uid 1000);
        Fri, 10 Jul 2020 16:26:57 -0000
Date:   Fri, 10 Jul 2020 10:26:57 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Amit Kucheria <amit.kucheria@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] dt-bindings: thermal: tsens: document ipq8064
 bindings
Message-ID: <20200710162657.GB2743639@bogus>
References: <20200709215136.28044-1-ansuelsmth@gmail.com>
 <20200709215136.28044-4-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709215136.28044-4-ansuelsmth@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jul 09, 2020 at 11:51:33PM +0200, Ansuel Smith wrote:
> Document the use of regmap phandle for ipq8064 SoCs
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  .../bindings/thermal/qcom-tsens.yaml          | 51 ++++++++++++++++---
>  1 file changed, 44 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> index d7be931b42d2..5ceb5d720e16 100644
> --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> @@ -24,6 +24,7 @@ properties:
>            - enum:
>                - qcom,msm8916-tsens
>                - qcom,msm8974-tsens
> +              - qcom,ipq8064-tsens
>            - const: qcom,tsens-v0_1
>  
>        - description: v1 of TSENS
> @@ -47,6 +48,11 @@ properties:
>        - description: TM registers
>        - description: SROT registers
>  
> +  regmap:
> +    description:
> +      Phandle to the gcc. On ipq8064 SoCs gcc and tsense share the same regs.
> +    $ref: /schemas/types.yaml#/definitions/phandle

Can't you make this a child of the gcc and drop this property?

> +
>    interrupts:
>      minItems: 1
>      items:
> @@ -111,17 +117,48 @@ allOf:
>          interrupt-names:
>            minItems: 2
>  
> -required:
> -  - compatible
> -  - reg
> -  - "#qcom,sensors"
> -  - interrupts
> -  - interrupt-names
> -  - "#thermal-sensor-cells"
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,ipq8064-tsens
> +    then:
> +      required:
> +        - compatible
> +        - regmap
> +        - "#qcom,sensors"
> +        - interrupts
> +        - interrupt-names
> +        - "#thermal-sensor-cells"
> +
> +    else:
> +      required:
> +        - compatible
> +        - reg
> +        - "#qcom,sensors"
> +        - interrupts
> +        - interrupt-names
> +        - "#thermal-sensor-cells"

Keep all the common required properties and just put reg/regmap in the 
if/then if this ends up staying.

Rob

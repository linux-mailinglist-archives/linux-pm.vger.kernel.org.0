Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 269B33D92D2
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jul 2021 18:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236693AbhG1QKw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Jul 2021 12:10:52 -0400
Received: from mail-il1-f173.google.com ([209.85.166.173]:33617 "EHLO
        mail-il1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237436AbhG1QKJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Jul 2021 12:10:09 -0400
Received: by mail-il1-f173.google.com with SMTP id y4so3100860ilp.0;
        Wed, 28 Jul 2021 09:10:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OCZVThIbf1ShScmnxV7KW8mpeH/qB15sH5W8oxF9Flw=;
        b=n+fYXVnV7oXIOhsQYV9+CYPwdmB2ROubz9dhaf5IK+doqYRj79Kk5zy1ak6Hf3sMFF
         ZYgqg6Qp7aynv13sehSJ74dr1MTvxD2j56d9YOFzEokgbk2af0kHrcb3isBq5ZaQwfJM
         4yZrVPn6qyNJoKLQki/UWiAsB/6FuFZ5S/l18mici7lUCWIcxoBKl38NaEZTizqN0N1i
         oKrhbTCM1fLMk61q9BGwcUqTPFaPMFl3riYDObL/CBWf9gTUpeMB5G1NGJ/5s2PfA90k
         LOIO7uZlUjelEZSIJC0ZpmoxPhytvB29evr4zr1cASMZbvzGc3+WR6HEZNC8yUU9fcEl
         agHg==
X-Gm-Message-State: AOAM533saelKZsFtNXDo6AE4NJcrk6xBeye1Ew9P0PUQA4yj16VwjoZB
        0RfrXKmYBUxVc3bnlhM6FQ==
X-Google-Smtp-Source: ABdhPJxE3veSdmQ48nFHmou/1qK1TVA+w3ifTI7TRG6TpSuzPDoCqvN7s815GG+nzZ+cUao0iCffOQ==
X-Received: by 2002:a92:3207:: with SMTP id z7mr386220ile.288.1627488606095;
        Wed, 28 Jul 2021 09:10:06 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id b14sm194545ilr.45.2021.07.28.09.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 09:10:04 -0700 (PDT)
Received: (nullmailer pid 1161592 invoked by uid 1000);
        Wed, 28 Jul 2021 16:10:00 -0000
Date:   Wed, 28 Jul 2021 10:10:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        rjw@rjwysocki.net, steev@kali.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [Patch v4 6/6] dt-bindings: thermal: Add dt binding for QCOM LMh
Message-ID: <20210728161000.GA1153621@robh.at.kernel.org>
References: <20210727152512.1098329-1-thara.gopinath@linaro.org>
 <20210727152512.1098329-7-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210727152512.1098329-7-thara.gopinath@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 27, 2021 at 11:25:12AM -0400, Thara Gopinath wrote:
> Add dt binding documentation to describe Qualcomm
> Limits Management Hardware node.
> 
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> ---
> 
> v3->v4:
> 	- Changed dt property qcom,lmh-cpu-id to qcom,lmh-cpu and made it
> 	  a phandle pointing to the cpu node instead of a number as per
> 	  Rob Herring's review comments.
> 	- Added suffix -millicelsius to all temperature properties as per
> 	  Rob Herring's review comments.
> 	- Dropped unnecessary #includes in the example as pointed out by Bjorn.
> 	- Other minor fixes.
> 
>  .../devicetree/bindings/thermal/qcom-lmh.yaml | 100 ++++++++++++++++++
>  1 file changed, 100 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/qcom-lmh.yaml
> 
> diff --git a/Documentation/devicetree/bindings/thermal/qcom-lmh.yaml b/Documentation/devicetree/bindings/thermal/qcom-lmh.yaml
> new file mode 100644
> index 000000000000..0978f458b9ec
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/qcom-lmh.yaml
> @@ -0,0 +1,100 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright 2021 Linaro Ltd.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/thermal/qcom-lmh.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Limits Management Hardware(LMh)
> +
> +maintainers:
> +  - Thara Gopinath <thara.gopinath@linaro.org>
> +
> +description:
> +  Limits Management Hardware(LMh) is a hardware infrastructure on some
> +  Qualcomm SoCs that can enforce temperature and current limits as
> +  programmed by software for certain IPs like CPU.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,sdm845-lmh
> +
> +  reg:
> +    items:
> +      - description: core registers
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  '#interrupt-cells':
> +    const: 1
> +
> +  interrupt-controller: true
> +
> +  qcom,lmh-cpu:
> +    description:
> +      phandle of the first cpu in the LMh cluster
> +    $ref: /schemas/types.yaml#/definitions/phandle

'cpus' property is the somewhat standard way to reference a cpu.

But you should already have cpu topology information, why do you need 
this?

> +
> +  qcom,lmh-temp-arm-millicelsius:
> +    description:
> +      An integer expressing temperature threshold at which the LMh thermal
> +      FSM is engaged.
> +    $ref: /schemas/types.yaml#/definitions/int32

Standard unit-suffixes already have a type.

> +
> +  qcom,lmh-temp-low-millicelsius:
> +    description:
> +      An integer expressing temperature threshold at which the state machine
> +      will attempt to remove frequency throttling.
> +    $ref: /schemas/types.yaml#/definitions/int32
> +
> +  qcom,lmh-temp-high-millicelsius:
> +    description:
> +      An integer expressing temperature threshold at which the state machine
> +      will attempt to throttle the frequency.
> +    $ref: /schemas/types.yaml#/definitions/int32
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - #interrupt-cells
> +  - interrupt-controller
> +  - qcom,lmh-cpu
> +  - qcom,lmh-temp-arm-millicelsius
> +  - qcom,lmh-temp-low-millicelsius
> +  - qcom,lmh-temp-high-millicelsius
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    lmh_cluster1: lmh@17d70800 {

Drop unused labels.

> +      compatible = "qcom,sdm845-lmh";
> +      reg = <0x17d70800 0x401>;

0x401 is an odd size...

> +      interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
> +      qcom,lmh-cpu = <&CPU4>;
> +      qcom,lmh-temp-arm-millicelsius = <65000>;
> +      qcom,lmh-temp-low-millicelsius = <94500>;
> +      qcom,lmh-temp-high-millicelsius = <95000>;
> +      interrupt-controller;
> +      #interrupt-cells = <1>;
> +    };
> +  - |

Seems like this is 1 example, not 2.

> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    lmh_cluster0: lmh@17d78800 {
> +      compatible = "qcom,sdm845-lmh";
> +      reg = <0x17d78800 0x401>;
> +      interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
> +      qcom,lmh-cpu = <&CPU0>;
> +      qcom,lmh-temp-arm-millicelsius = <65000>;
> +      qcom,lmh-temp-low-millicelsius = <94500>;
> +      qcom,lmh-temp-high-millicelsius = <95000>;
> +      interrupt-controller;
> +      #interrupt-cells = <1>;
> +    };
> +  - |
> -- 
> 2.25.1
> 
> 

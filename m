Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67CAE3C61FC
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jul 2021 19:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235160AbhGLRfM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Jul 2021 13:35:12 -0400
Received: from mail-io1-f43.google.com ([209.85.166.43]:47072 "EHLO
        mail-io1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233887AbhGLRfK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Jul 2021 13:35:10 -0400
Received: by mail-io1-f43.google.com with SMTP id y8so23669534iop.13;
        Mon, 12 Jul 2021 10:32:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=f7BUFs0FlI3Hj4UaAhqIjPZ08b65CDzd+MMh8k0ttO8=;
        b=U9OLr2J+u3FHtd+6c4ggPLZtx2JH+i7LDo/EVVcim9Lc4l5nAaTtSo9cRc1Z1unNC/
         NaLjjSF0LfXzQYLvVFXfhul4Hz7IKJ9WZHw6wiZDymT/3r8pN+bvbIkyuv6GuUS2/q7N
         PcyYL4maM0g9m5kgv6fG8XiAbrYmnI916r6D3ZVWrJamBEtAyQdpz7W1KlPuOUAylmIl
         p+8gY3VHYzp6urdW6KNP42EBsyyrm3LvxkstnZZyw1U3Rw4AQlrM+B1glrDLdN1oZueO
         DpFNQLJ6Zf6tq26JZ1PSvEMboe9JXTZvpslZBFSy9M5Mu7xVepLtwwb2S9wWXfmd4DT1
         tyFQ==
X-Gm-Message-State: AOAM53187fz3cSRXF/YrA+znnvpIE0l0uNay8W6mxhOmLQ2seBw3lF6k
        hFxQl5RBGrtriP8NPxsPzQ==
X-Google-Smtp-Source: ABdhPJwG2c51hutmWd6VMKfsFj8MIYs0Zb7FuppHgPDObOEZufjTBVDkWQdC4Xux/LgL+gZJGOe4eQ==
X-Received: by 2002:a05:6638:d4d:: with SMTP id d13mr171938jak.140.1626111140345;
        Mon, 12 Jul 2021 10:32:20 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id g1sm7711422ilq.13.2021.07.12.10.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 10:32:19 -0700 (PDT)
Received: (nullmailer pid 2158356 invoked by uid 1000);
        Mon, 12 Jul 2021 17:32:16 -0000
Date:   Mon, 12 Jul 2021 11:32:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        rjw@rjwysocki.net, tdas@codeaurora.org, mka@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [Patch v3 6/6] dt-bindings: thermal: Add dt binding for QCOM LMh
Message-ID: <20210712173216.GA2150396@robh.at.kernel.org>
References: <20210708120656.663851-1-thara.gopinath@linaro.org>
 <20210708120656.663851-7-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210708120656.663851-7-thara.gopinath@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jul 08, 2021 at 08:06:56AM -0400, Thara Gopinath wrote:
> Add dt binding documentation to describe Qualcomm
> Limits Management Hardware node.
> 
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> ---
>  .../devicetree/bindings/thermal/qcom-lmh.yaml | 100 ++++++++++++++++++
>  1 file changed, 100 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/qcom-lmh.yaml
> 
> diff --git a/Documentation/devicetree/bindings/thermal/qcom-lmh.yaml b/Documentation/devicetree/bindings/thermal/qcom-lmh.yaml
> new file mode 100644
> index 000000000000..7f62bd3d543d
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
> +  qcom,lmh-cpu-id:
> +    description:
> +      CPU id of the first cpu in the LMh cluster
> +    $ref: /schemas/types.yaml#/definitions/uint32

The way we reference other nodes in DT is phandles. 'cpus' is already 
somewhat established for this case.

> +
> +  qcom,lmh-temperature-arm:
> +    description:
> +      An integer expressing temperature threshold in millicelsius at which

Use unit suffix when you have units.

> +      the LMh thermal FSM is engaged.
> +    $ref: /schemas/types.yaml#/definitions/int32
> +
> +  qcom,lmh-temperature-low:
> +    description:
> +      An integer expressing temperature threshold in millicelsius at which
> +      the LMh thermal FSM is engaged.
> +    $ref: /schemas/types.yaml#/definitions/int32
> +
> +  qcom,lmh-temperature-high:
> +    description:
> +      An integer expressing temperature threshold in millicelsius at which
> +      the LMh thermal FSM is engaged.

What's the difference in the 3 properties because the description is the 
same.

> +    $ref: /schemas/types.yaml#/definitions/int32
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - #interrupt-cells
> +  - interrupt-controller
> +  - qcom,lmh-cpu-id
> +  - qcom,lmh-temperature-arm
> +  - qcom,lmh-temperature-low
> +  - qcom,lmh-temperature-high
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/qcom,rpmh.h>
> +    #include <dt-bindings/interconnect/qcom,sdm845.h>
> +
> +    lmh_cluster1: lmh@17d70800 {
> +      compatible = "qcom,sdm845-lmh";
> +      reg = <0 0x17d70800 0 0x401>;
> +      interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
> +      qcom,lmh-cpu-id = <0x4>;
> +      qcom,lmh-temperature-arm = <65000>;
> +      qcom,lmh-temperature-low = <94500>;
> +      qcom,lmh-temperature-high = <95000>;
> +      interrupt-controller;

What devices is this an interrupt controller for?

> +      #interrupt-cells = <1>;
> +    };
> +  - |
> +    lmh_cluster0: lmh@17d78800 {
> +      compatible = "qcom,sdm845-lmh";
> +      reg = <0 0x17d78800 0 0x401>;
> +      interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
> +      qcom,lmh-cpu-id = <0x0>;
> +      qcom,lmh-temperature-arm = <65000>;
> +      qcom,lmh-temperature-low = <94500>;
> +      qcom,lmh-temperature-high = <95000>;
> +      interrupt-controller;
> +      #interrupt-cells = <1>;
> +    };
> +  - |
> -- 
> 2.25.1
> 
> 

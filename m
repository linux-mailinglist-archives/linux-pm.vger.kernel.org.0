Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6082C3C329A
	for <lists+linux-pm@lfdr.de>; Sat, 10 Jul 2021 06:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbhGJEYS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 10 Jul 2021 00:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbhGJEYR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 10 Jul 2021 00:24:17 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F34C0613E5
        for <linux-pm@vger.kernel.org>; Fri,  9 Jul 2021 21:21:32 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id z18-20020a9d7a520000b02904b28bda1885so10193229otm.7
        for <linux-pm@vger.kernel.org>; Fri, 09 Jul 2021 21:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XQEJ9AZMwo+oZd7F6ikzhcyBN0B+xoHKU7qZRGlNq+E=;
        b=A7/Wm/WNPcdvjhA6nhzwB8sCwll0eZFXv2R5MR35Ty7Z6ZF5BujG6h7WtB+8wg+CAB
         vIdBlutnIMNWqfglxRgwvJI5jPtHuJcvrxIjeaXVvQynKSoiHCXK7YvnpgLJSbxBPvFm
         0MhT1LvwvbKh9dBJuf9/vZYyux8ODoEIjVmvJZJFQ9c2NiBB1ecsVTm9TfNDwDVXX73W
         i+l2aZUtdTR7kvwLs9Pm2NYhmoTDib1YXm9Xj3Lc3UR6zn/vHFgrJLTYDycEwHhFTjvU
         YZSQEdUV12/oi4TqBOr3zTNc+34M/v02yDVWaVks0eJ/hlmUmN0CACCU77RWFA/Fzcfd
         OhNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XQEJ9AZMwo+oZd7F6ikzhcyBN0B+xoHKU7qZRGlNq+E=;
        b=bB5MIpT/fu9typod6qQaMXfL84qfp4uYL//p/KwvrRemyqwFYcS3w8g/4jRDt2BPfh
         Ll7ulGiAQ4t7wfTBr8erbf7/htOAyRIJP6Z6btrMPuMcP18FFHlK8L6w3UngPw5Nm4pc
         dnXK1gr7/zsLE+Mtn0LVOk/tIzMnoo3+tZBuU3eHd48ZLAiR3APQU9IcyMJ3NiPiQKM3
         ht9momuCCQ4uDBuWBRGNfvUUtcZ5yNUjwHsOvoxh0L1icC/KcqdZLQU24JVWCG5iADol
         LqCMNzwusaBVKuQ5nAO3H5VH2licFu5oAfyt7Pp/fiMeCg//xVDFWiOiCCegKodTeFb3
         bbtw==
X-Gm-Message-State: AOAM531SiuZ1oaiajguvXCPBygSV3Id61M2mA6QejYaVxEqA8+hHgy2S
        sJC0bwBpy1yrUlTt8S25sDB/XQ==
X-Google-Smtp-Source: ABdhPJy4kCt2KdkHGtrcKNO610uqTkaxeYYQ4zFTBO1uUPSSxS1G4vpUzyGaWgf++ghkwMrs8oYyRg==
X-Received: by 2002:a05:6830:119:: with SMTP id i25mr25287667otp.28.1625890891537;
        Fri, 09 Jul 2021 21:21:31 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id m126sm1578664oib.55.2021.07.09.21.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 21:21:31 -0700 (PDT)
Date:   Fri, 9 Jul 2021 23:21:29 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     agross@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, rjw@rjwysocki.net, robh+dt@kernel.org,
        tdas@codeaurora.org, mka@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [Patch v3 6/6] dt-bindings: thermal: Add dt binding for QCOM LMh
Message-ID: <YOkgSP5e3JaGY19V@yoga>
References: <20210708120656.663851-1-thara.gopinath@linaro.org>
 <20210708120656.663851-7-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210708120656.663851-7-thara.gopinath@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu 08 Jul 07:06 CDT 2021, Thara Gopinath wrote:

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
> +
> +  qcom,lmh-temperature-arm:
> +    description:
> +      An integer expressing temperature threshold in millicelsius at which
> +      the LMh thermal FSM is engaged.

Do we know (by any public source) what "arm", "low" and "high" means
beyond that they somehow pokes the state machine?

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

I don't see why you need qcom,rpmh.h or the interconnect include in this
example.

> +
> +    lmh_cluster1: lmh@17d70800 {
> +      compatible = "qcom,sdm845-lmh";
> +      reg = <0 0x17d70800 0 0x401>;

#address- and #size-cells are 1 in the wrapper that validates the
examples, so drop the two zeros.

> +      interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
> +      qcom,lmh-cpu-id = <0x4>;
> +      qcom,lmh-temperature-arm = <65000>;
> +      qcom,lmh-temperature-low = <94500>;
> +      qcom,lmh-temperature-high = <95000>;
> +      interrupt-controller;
> +      #interrupt-cells = <1>;
> +    };
> +  - |

This is a different example from the one above, if you intended that,
don't you need the #include of arm-gic.h here as well?

Regards,
Bjorn

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

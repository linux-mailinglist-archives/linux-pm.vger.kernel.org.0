Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D34F5106C7
	for <lists+linux-pm@lfdr.de>; Tue, 26 Apr 2022 20:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350941AbiDZS1Y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Apr 2022 14:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235205AbiDZS1W (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Apr 2022 14:27:22 -0400
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53B661524B7;
        Tue, 26 Apr 2022 11:24:14 -0700 (PDT)
Received: by mail-oi1-f170.google.com with SMTP id l203so10764556oif.0;
        Tue, 26 Apr 2022 11:24:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eYGpzVL6z/9v1Xf7+HUnb3XtEpbv7g1nd4l3yujJBqU=;
        b=g0mQlxclTxCDLMthMXeZxF5RI6PEX2kV3FVg8Oq2chf7qqniHPcRxzNo7VGLRp13/x
         UQd2tLiBscbDFvpTU7OEaM/CWo0tzVfVixSGmW7s4409hLzUKS+GZ53d/kS56SLoYUF1
         Jqjrzy2AimgDIBe28bshQQIaRShsnLB1jroVd2D3bJh3TmdKPO9fXCoTaLFv1DPVoKQL
         ruYOnTo4Iu6W2Iva0pG3rF3UIo1xjFDy0yEhzolZZ/JqIj9FPUz2alOjDhx2bbdeiuZT
         L/xfZv+HOtD5VxwVnCAQFPNzXGE9yD/9Qxa2hQMZeayLefU26dULjwjJkN8eqHdChlWg
         XmFg==
X-Gm-Message-State: AOAM5307WoZD0NL/zX7NI5lbs3ZfSgIZIbPqrW+n7k0+ZsGSDHKNWuRk
        ZY+GKhiSR4hxceumwpjl8u4kD3gPbQ==
X-Google-Smtp-Source: ABdhPJwqJ/M/GPcWpn4KFmsYPNq6cn7iuEhMpX3WrbveRkvKdJR+4UP5ufGYG8dqHTiVlMa8p7jzuw==
X-Received: by 2002:a05:6808:8da:b0:324:be6a:e866 with SMTP id k26-20020a05680808da00b00324be6ae866mr9705228oij.72.1650997453643;
        Tue, 26 Apr 2022 11:24:13 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l16-20020a9d6a90000000b0060548d240d4sm5160969otq.74.2022.04.26.11.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 11:24:13 -0700 (PDT)
Received: (nullmailer pid 2302730 invoked by uid 1000);
        Tue, 26 Apr 2022 18:24:12 -0000
Date:   Tue, 26 Apr 2022 13:24:12 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, quic_tdas@quicinc.com
Subject: Re: [PATCH v4 3/3] dt-bindings: clock: qcom,gcc-apq8064: split tsens
 to the child node
Message-ID: <Ymg4zFsQB2MAQ/T5@robh.at.kernel.org>
References: <20220426094144.2958416-1-dmitry.baryshkov@linaro.org>
 <20220426094144.2958416-4-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426094144.2958416-4-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Apr 26, 2022 at 12:41:44PM +0300, Dmitry Baryshkov wrote:
> Split tsens properties to the child node of the gcc. This follows the
> lead of ipq8064 (which also uses a separate node for tsens) and makes
> device tree closer to other platforms, where tsens is a completely
> separate device.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  .../bindings/clock/qcom,gcc-apq8064.yaml      | 45 +++++++------------
>  1 file changed, 17 insertions(+), 28 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.yaml
> index b867da12761e..f2762599f679 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.yaml
> @@ -23,47 +23,36 @@ description: |
>  
>  properties:
>    compatible:
> -    enum:
> -      - qcom,gcc-apq8064
> -      - qcom,gcc-msm8060
> -
> -  nvmem-cells:
> -    minItems: 1
> -    maxItems: 2
> -    description:
> -      Qualcomm TSENS (thermal sensor device) on some devices can
> -      be part of GCC and hence the TSENS properties can also be part
> -      of the GCC/clock-controller node.
> -      For more details on the TSENS properties please refer
> -      Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> -
> -  nvmem-cell-names:
> -    minItems: 1
>      items:
> -      - const: calib
> -      - const: calib_backup
> -
> -  '#thermal-sensor-cells':
> -    const: 1
> +      - enum:
> +          - qcom,gcc-apq8064
> +          - qcom,gcc-msm8060
> +      - const: syscon
>  
>  required:
>    - compatible
> -  - nvmem-cells
> -  - nvmem-cell-names
> -  - '#thermal-sensor-cells'
>  
>  unevaluatedProperties: false
>  
>  examples:
>    - |
>      clock-controller@900000 {
> -      compatible = "qcom,gcc-apq8064";
> +      compatible = "qcom,gcc-apq8064", "syscon";
>        reg = <0x00900000 0x4000>;
> -      nvmem-cells = <&tsens_calib>, <&tsens_backup>;
> -      nvmem-cell-names = "calib", "calib_backup";
>        #clock-cells = <1>;
>        #reset-cells = <1>;
>        #power-domain-cells = <1>;
> -      #thermal-sensor-cells = <1>;
> +
> +      thermal-sensor {

This should throw a warning I think as 'thermal-sensor' needs to be 
defined. The patch didn't apply for me though.

> +        compatible = "qcom,msm8960-tsens";
> +
> +        nvmem-cells = <&tsens_calib>, <&tsens_backup>;
> +        nvmem-cell-names = "calib", "calib_backup";
> +        interrupts = <0 178 4>;
> +        interrupt-names = "uplow";
> +
> +        #qcom,sensors = <11>;
> +        #thermal-sensor-cells = <1>;
> +        };
>      };
>  ...
> -- 
> 2.35.1
> 
> 

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4AC96F9D62
	for <lists+linux-pm@lfdr.de>; Mon,  8 May 2023 03:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbjEHB0T (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 7 May 2023 21:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjEHB0R (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 7 May 2023 21:26:17 -0400
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3542E12C;
        Sun,  7 May 2023 18:26:14 -0700 (PDT)
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6ab087111faso69987a34.3;
        Sun, 07 May 2023 18:26:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683509173; x=1686101173;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=E0WGVqQd3crr5/xk4aA5GRbZA5RzgIzcfwtNz3kKyK8=;
        b=i5lHy7cFZsT2/NY/PJhYi7WA1mLt73CE8/CRULYBQoKXMYKNXCKWdXjt/ku909QoBp
         YLgRxqWthu5uvWirLJ5wiCPYqiujHGURLHJi3qbmE+O+xOWkwJD3vpf0GIySdl9ug5Yj
         Zp6X5EWROXsf/ooXEesgl8C2cy7Kz00962Ejtx7tuJdMntEJF3l7i75aHPGzbTJOjGns
         vNXPOy1saILyQbdbjQ4ssnkV0Iu5KdmINCjvrtTtkqFV5ADZiKHCc+xgo5+trN3Z4OU/
         rVwECx9N5ODSiy6FDck+ghLod9twK5lVQx9OMjoUOTge+fLFsA0n+9OnBbXo4XhXyVqR
         bfLA==
X-Gm-Message-State: AC+VfDxwyjJzptc8zaiSZWULu7RY+UaCw+X+DMdKkIF8jQzO+B4/Swhq
        iRviDSw+8ODnnVGaCesIkg==
X-Google-Smtp-Source: ACHHUZ6H9eBYio6qGDMOwk8cjb89NYIm3MN/qp2X9z0JKWHk2TFOrWQVDdy1An/FopnsmcrTn/TLiQ==
X-Received: by 2002:a9d:7acf:0:b0:6aa:e821:88eb with SMTP id m15-20020a9d7acf000000b006aae82188ebmr2194275otn.4.1683509173213;
        Sun, 07 May 2023 18:26:13 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t13-20020a05683022ed00b006a4244d2a7asm3592444otc.9.2023.05.07.18.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 18:26:12 -0700 (PDT)
Received: (nullmailer pid 3860869 invoked by uid 1000);
        Mon, 08 May 2023 01:26:11 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        devicetree@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
In-Reply-To: <20230508003309.2363787-2-dmitry.baryshkov@linaro.org>
References: <20230508003309.2363787-1-dmitry.baryshkov@linaro.org>
 <20230508003309.2363787-2-dmitry.baryshkov@linaro.org>
Message-Id: <168350917132.3860853.17086591118019075384.robh@kernel.org>
Subject: Re: [PATCH 1/6] dt-bindings: power: reset: qcom-pon: define
 pm8941-pon
Date:   Sun, 07 May 2023 20:26:11 -0500
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On Mon, 08 May 2023 03:33:04 +0300, Dmitry Baryshkov wrote:
> On PM8941 pon doesn't store the reset reason. However we still need the
> wrapping node for pwrkey and resin nodes. Add bindings for pm8941-pon
> device.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  Documentation/devicetree/bindings/power/reset/qcom,pon.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/i2c/ovti,ov2685.example.dtb: camera-sensor@3c: port:endpoint:data-lanes: [[1]] is too short
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/i2c/ovti,ov2685.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/rockchip-isp1.example.dtb: camera@3c: port:endpoint:data-lanes: [[1]] is too short
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/i2c/ovti,ov2685.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.example.dtb: pcie-ep@33800000: Unevaluated properties are not allowed ('assigned-clock-parents', 'assigned-clock-rates', 'assigned-clocks' were unexpected)
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml

doc reference errors (make refcheckdocs):
Documentation/usb/gadget_uvc.rst: Documentation/userspace-api/media/v4l/pixfmt-packed.yuv.rst
MAINTAINERS: Documentation/devicetree/bindings/pwm/pwm-apple.yaml

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230508003309.2363787-2-dmitry.baryshkov@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


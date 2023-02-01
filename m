Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD96D686820
	for <lists+linux-pm@lfdr.de>; Wed,  1 Feb 2023 15:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbjBAOX3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Feb 2023 09:23:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232411AbjBAOXZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Feb 2023 09:23:25 -0500
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6359C6811E;
        Wed,  1 Feb 2023 06:23:20 -0800 (PST)
Received: by mail-ot1-f54.google.com with SMTP id r17-20020a056830449100b0068bb088317aso4629577otv.12;
        Wed, 01 Feb 2023 06:23:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=u6R05L+oKQbQDl8uREuRw0KJjcK3jQble/xRJpOhSC8=;
        b=Yi7Xbs48W4n8l4a6Om/bpslvESkEdjo3CAl52NfpRsPwbU3H/aY0rQVMTQ//5ifG1v
         Hh21zgDjNCCtNY5PZUx3J3owuOGHfASuoclj8Uug1j07OI3psnA6OyXF6bU8XwpMsXPm
         r4Zmax5t5Lzj96Usu1JmwXJHGbhm8sbgE7JN4LOH8fmg2L9e+ytEXZcy4H/s47UbIUrK
         dX7DF9hI0iUSw/LTUOt3p1+l1BzutrM/4EOzDviRi+n4gtT2AweuMt2GDnkj9vg6Cac3
         PpfhgryODeSa+IcucNqDh7aG7z1Z6nyh/Bc/eOoK+u6o756OHQqzSrXhT4cAZormhCBi
         zaZA==
X-Gm-Message-State: AO0yUKUys7WUGEGZmz6sybTmdCOJc26dM2pO0i+2u3wwsrrAbl5tc9uV
        8Ns1t2xSo5aonMP1gOrimv5y9mOhIA==
X-Google-Smtp-Source: AK7set/J3o9QIOKVB9FvjOVAZ5BZ3l6w1/SRn7M6R4wLuH/EwUUSeRnlTPvCDSf5vIhn3+J8sxQz5g==
X-Received: by 2002:a05:6830:1245:b0:68b:e2a3:8ef1 with SMTP id s5-20020a056830124500b0068be2a38ef1mr918568otp.35.1675261399443;
        Wed, 01 Feb 2023 06:23:19 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id k26-20020a9d761a000000b00670679748f9sm8038628otl.49.2023.02.01.06.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 06:23:18 -0800 (PST)
Received: (nullmailer pid 3335047 invoked by uid 1000);
        Wed, 01 Feb 2023 14:23:18 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Jun Nie <jun.nie@linaro.org>
Cc:     kyungmin.park@samsung.com, devicetree@vger.kernel.org,
        myungjoo.ham@samsung.com, bryan.odonoghue@linaro.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        cw00.choi@samsung.com
In-Reply-To: <20230201080227.473547-1-jun.nie@linaro.org>
References: <20230201080227.473547-1-jun.nie@linaro.org>
Message-Id: <167526125547.3331953.6245964862513509015.robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: interconnect: Add Qualcomm CCI
 dt-bindings
Date:   Wed, 01 Feb 2023 08:23:18 -0600
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


On Wed, 01 Feb 2023 16:02:26 +0800, Jun Nie wrote:
> Add devicetree binding of Qualcomm CCI on MSM8939.
> 
> Signed-off-by: Jun Nie <jun.nie@linaro.org>
> ---
>  .../bindings/interconnect/qcom,cci.yaml       | 81 +++++++++++++++++++
>  1 file changed, 81 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,cci.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/interconnect/qcom,cci.yaml:43:1: [error] syntax error: found character '\t' that cannot start any token (syntax)

dtschema/dtc warnings/errors:
make[1]: *** Deleting file 'Documentation/devicetree/bindings/interconnect/qcom,cci.example.dts'
Documentation/devicetree/bindings/interconnect/qcom,cci.yaml:43:1: found character '\t' that cannot start any token
make[1]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/interconnect/qcom,cci.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
./Documentation/devicetree/bindings/interconnect/qcom,cci.yaml:43:1: found character '\t' that cannot start any token
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interconnect/qcom,cci.yaml: ignoring, error parsing file
make: *** [Makefile:1508: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230201080227.473547-1-jun.nie@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


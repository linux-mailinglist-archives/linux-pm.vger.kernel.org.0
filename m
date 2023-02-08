Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F99E68EF85
	for <lists+linux-pm@lfdr.de>; Wed,  8 Feb 2023 14:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbjBHNJh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Feb 2023 08:09:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbjBHNJg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Feb 2023 08:09:36 -0500
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2827D47095;
        Wed,  8 Feb 2023 05:09:26 -0800 (PST)
Received: by mail-oo1-f49.google.com with SMTP id c29-20020a4ad21d000000b00517a55a78d4so1710995oos.12;
        Wed, 08 Feb 2023 05:09:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sKctfRFevEGzylkJxSTY3VRpoj1hZvHSm640h9Em5z4=;
        b=tqudxdEEH9DTZxcn6SrSB2g5saQjtvlQwvcjSxqIhNctJYHI9V2o6mIYdWt/T1GTTd
         BVVW0ajMgV4p6KtaMS9UgdiXBJL33jVo8Zr9CHYbQ5mHQhPZvnKYAq/jFKcaci4c6J/I
         bk4cBOYi2s6zC/VrtnUONEvNlkwIq4tO6wAWSGgvhHS7Xc1caQDWF46s4ktbrMBe6HWQ
         JSLWsaFDFhGMmihITd1l+cBR9frvAm8ZMQ5zPo4ISUo05VTK6CTdgLdwhVe5wSfAmFzC
         /4CfCzinIsgQnsTGBXckwjJexwOJukdc3iQgFootFP7tAjvgy67IFmKxOtIi89ihdCe1
         cSwg==
X-Gm-Message-State: AO0yUKUDNiWW29c89E2sZsLD12uayLfb7cHUvdeAWlvCKpXAah3rErqm
        rzjB3HVXDHLwix5kdGjN99/CqZk/Ug==
X-Google-Smtp-Source: AK7set92nRxfqLhEo6VH3xIGRC1voySix/Y+GAklX6sGfkt1mG8OhseTlmNN7FZBChOHr6TFaCdmIw==
X-Received: by 2002:a4a:e091:0:b0:51a:4c5d:fd1e with SMTP id w17-20020a4ae091000000b0051a4c5dfd1emr3445841oos.9.1675861765298;
        Wed, 08 Feb 2023 05:09:25 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m14-20020a9d6ace000000b0068bce0cd4e1sm8000848otq.9.2023.02.08.05.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 05:09:24 -0800 (PST)
Received: (nullmailer pid 1735857 invoked by uid 1000);
        Wed, 08 Feb 2023 13:09:24 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-rockchip@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, kernel@pengutronix.de,
        Heiko Stuebner <heiko@sntech.de>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Will Deacon <will@kernel.org>
In-Reply-To: <20230208093830.143284-19-s.hauer@pengutronix.de>
References: <20230208093830.143284-1-s.hauer@pengutronix.de>
 <20230208093830.143284-19-s.hauer@pengutronix.de>
Message-Id: <167586156991.1727589.15971216744751237430.robh@kernel.org>
Subject: Re: [PATCH v2 18/19] dt-bindings: devfreq: event: convert Rockchip
 DFI binding to yaml
Date:   Wed, 08 Feb 2023 07:09:24 -0600
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


On Wed, 08 Feb 2023 10:38:29 +0100, Sascha Hauer wrote:
> Convert the Rockchip DFI binding to yaml.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  .../bindings/devfreq/event/rockchip,dfi.yaml  | 61 +++++++++++++++++++
>  .../bindings/devfreq/event/rockchip-dfi.txt   | 18 ------
>  2 files changed, 61 insertions(+), 18 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/devfreq/event/rockchip,dfi.yaml
>  delete mode 100644 Documentation/devicetree/bindings/devfreq/event/rockchip-dfi.txt
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:


doc reference errors (make refcheckdocs):
Documentation/devicetree/bindings/memory-controllers/rockchip,rk3399-dmc.yaml: Documentation/devicetree/bindings/devfreq/event/rockchip-dfi.txt

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230208093830.143284-19-s.hauer@pengutronix.de

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


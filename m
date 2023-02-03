Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E04268A379
	for <lists+linux-pm@lfdr.de>; Fri,  3 Feb 2023 21:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbjBCUSR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Feb 2023 15:18:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233002AbjBCUSP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Feb 2023 15:18:15 -0500
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930F820073;
        Fri,  3 Feb 2023 12:18:11 -0800 (PST)
Received: by mail-oo1-f47.google.com with SMTP id 123-20020a4a0681000000b004faa9c6f6b9so606301ooj.11;
        Fri, 03 Feb 2023 12:18:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oV7cKs+Szf31+vVz6WWua+p5h+0X4GhPfD48jKFPFWA=;
        b=cPWA4yRPcMGyIw0FUv9c9Vpykcvo2e+eFBsIo0/Kni6wSdtfJDZ4zGk5WPYXZT9hVW
         Wp2ogEXfyeDrON3a8rJAsjcCZrf1WR4FFpOz2b5iQxgVXrYvETeYSNpww0cLynfcUZUh
         eGPPiyViwYl8SRZWEyznKd24kdIysr1lOQEjRak80PVkgrietWkFKBeSonIDnrMw+Ol1
         yWeIGHAqLQOrlERVSLt0J8NFO0ZjDQapiPPQUP+jBQz9P0UVEXDbNO6rQ6RTq/RwUaHi
         iJwXE0m0/bnp4o7gaROhZI8B7GJwnFEHZ03LCoq3yzb/f3FgeWxk4VD/D+SpL6T9yPCB
         IqIQ==
X-Gm-Message-State: AO0yUKWGCS11YEorcoOOEYv/gwubElGCU/Nf9JyodcgESi5zL8MEpH5S
        5fL6kaoS5TqDMDbDRgSaVw==
X-Google-Smtp-Source: AK7set/S0Ap+7JFi+KM1s+lEfgy4prFJ9nFrDC3/Ra/Hwq/IY1xtmriuQVpTYL7NYOw7MMPFZBRU6g==
X-Received: by 2002:a4a:3915:0:b0:51a:2fe9:2a8f with SMTP id m21-20020a4a3915000000b0051a2fe92a8fmr3877690ooa.7.1675455490941;
        Fri, 03 Feb 2023 12:18:10 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w1-20020a4a2741000000b004f269f9b8f3sm810690oow.25.2023.02.03.12.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 12:18:10 -0800 (PST)
Received: (nullmailer pid 825646 invoked by uid 1000);
        Fri, 03 Feb 2023 20:18:09 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-rockchip@lists.infradead.org,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-pm@vger.kernel.org, kernel@pegutronix.de,
        devicetree@vger.kernel.org,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Stuebner <heiko@sntech.de>, Will Deacon <will@kernel.org>
In-Reply-To: <20230203125012.3804008-19-s.hauer@pengutronix.de>
References: <20230203125012.3804008-1-s.hauer@pengutronix.de>
 <20230203125012.3804008-19-s.hauer@pengutronix.de>
Message-Id: <167545520027.820286.11574503514985446223.robh@kernel.org>
Subject: Re: [PATCH 18/18] dt-bindings: devfreq: event: convert Rockchip
 DFI binding to yaml
Date:   Fri, 03 Feb 2023 14:18:09 -0600
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


On Fri, 03 Feb 2023 13:50:12 +0100, Sascha Hauer wrote:
> Convert the Rockchip DFI binding to yaml. While at it add the newly
> supported rk3568-dfi to the binding.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  .../bindings/devfreq/event/rockchip-dfi.txt   | 18 ---------
>  .../bindings/devfreq/event/rockchip-dfi.yaml  | 38 +++++++++++++++++++
>  2 files changed, 38 insertions(+), 18 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/devfreq/event/rockchip-dfi.txt
>  create mode 100644 Documentation/devicetree/bindings/devfreq/event/rockchip-dfi.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/devfreq/event/rockchip-dfi.example.dtb: /example-0/dfi@fe230000: failed to match any schema with compatible: ['rockchip,rk3568-dfi']

doc reference errors (make refcheckdocs):
Documentation/devicetree/bindings/memory-controllers/rockchip,rk3399-dmc.yaml: Documentation/devicetree/bindings/devfreq/event/rockchip-dfi.txt

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230203125012.3804008-19-s.hauer@pengutronix.de

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


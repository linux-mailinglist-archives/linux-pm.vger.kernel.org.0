Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D279779138
	for <lists+linux-pm@lfdr.de>; Fri, 11 Aug 2023 16:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjHKOBA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Aug 2023 10:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjHKOBA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Aug 2023 10:01:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B33D7;
        Fri, 11 Aug 2023 07:00:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78B7F631B1;
        Fri, 11 Aug 2023 14:00:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C24B3C433C7;
        Fri, 11 Aug 2023 14:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691762458;
        bh=C4cXeWQX/r0IzEoOEZ08WLIpkcXhN7kt7P6JcA2SsfA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=rjOirqlUfvyMrYGK2PVWBJ5zUsGe2FKOjHY1dp1jcP9Za9VNrHnzeLPV7j1s1GKa1
         pnp1TVUnexW5wXbSCI3Uk3aG2vO8T4NzWCjTg3lJK8GOE2Ino+Ns0Y/bKJM3NavB2d
         3iUhkptkfGP3N80QGn989MfZaaFKYrBXKHxS/3AgluHVulS8sMU19qP0/juWN2eCCY
         DRFczAh/0LRrjffN/6Wp78U0yrotycsm4dPQ5UJL878xSXCDzRFY+d6EZFHZXMjbS9
         cuExJx9o92mxn5k/NIJeQDrfDBE/26mqajanE/DM4vYlIGsPLyiz2hHJqA/dR5sOLK
         H24h7Nxq2gFqQ==
Received: (nullmailer pid 3322998 invoked by uid 1000);
        Fri, 11 Aug 2023 14:00:55 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>, linux-pm@vger.kernel.org,
        Zhang Rui <rui.zhang@intel.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        netdev@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
In-Reply-To: <20230810144451.1459985-3-alexander.stein@ew.tq-group.com>
References: <20230810144451.1459985-1-alexander.stein@ew.tq-group.com>
 <20230810144451.1459985-3-alexander.stein@ew.tq-group.com>
Message-Id: <169176235704.3319932.12605780111430379869.robh@kernel.org>
Subject: Re: [PATCH 2/6] dt-bindings: imx-thermal: Add
 #thermal-sensor-cells property
Date:   Fri, 11 Aug 2023 08:00:55 -0600
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On Thu, 10 Aug 2023 16:44:47 +0200, Alexander Stein wrote:
> This property is defined in thermal-sensor.yaml. Reference this file and
> constraint '#thermal-sensor-cells' to 0 for imx-thermal.
> Fixes the warning:
> arch/arm/boot/dts/nxp/imx/imx6q-mba6a.dtb: tempmon:
>  '#thermal-sensor-cells' does not match any of the regexes: 'pinctrl-[0-9]+'
>  From schema: Documentation/devicetree/bindings/thermal/imx-thermal.yaml
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
>  Documentation/devicetree/bindings/thermal/imx-thermal.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/thermal/imx-thermal.example.dtb: tempmon: '#thermal-sensor-cells' is a required property
	from schema $id: http://devicetree.org/schemas/thermal/imx-thermal.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230810144451.1459985-3-alexander.stein@ew.tq-group.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


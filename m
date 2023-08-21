Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7D2782F3A
	for <lists+linux-pm@lfdr.de>; Mon, 21 Aug 2023 19:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236998AbjHURNA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Aug 2023 13:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbjHURM7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Aug 2023 13:12:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB84123;
        Mon, 21 Aug 2023 10:12:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 17E186402E;
        Mon, 21 Aug 2023 17:12:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A083C433C8;
        Mon, 21 Aug 2023 17:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692637967;
        bh=pecT+7jt2WFbXfJOVTRSd9o3RBK/Imr4a3p3S+M/2x4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F4U/ZhLydZ7TzaxBv+r0Ch2NVqY7bI4P84YF474cteSwc/8gpGPpXXr5iKbPPHc3Q
         CzWJg3qW2J9WktqjWOKHZMOyvto9vQNEyWcCPjCyx+aABrFoaPcO2pKsZgSRoHtgwU
         tM/Suhol2ESmfpub9Jiypc7ok56BnzExf039SiXVTigfExNTHbOz6eTegmmcB7l5md
         GTazQjsnarYCoQhfjMcbJ2AWtOlatA5JowGK6WkDc9qJQOEyZmCaurB2g2guXabLBL
         cgpRxS98pCfScD2RFFQMLIrcqxuy5FdfaCiDpwk/FYlBJDZcBNqQgdXE2mbfNieLeX
         IJqlKMF+abvIw==
Received: (nullmailer pid 1975482 invoked by uid 1000);
        Mon, 21 Aug 2023 17:12:44 -0000
Date:   Mon, 21 Aug 2023 12:12:44 -0500
From:   Rob Herring <robh@kernel.org>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 3/6] dt-bindings: display: imx: hdmi: Allow 'reg' and
 'interrupts'
Message-ID: <20230821171244.GA1963855-robh@kernel.org>
References: <20230810144451.1459985-1-alexander.stein@ew.tq-group.com>
 <20230810144451.1459985-4-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810144451.1459985-4-alexander.stein@ew.tq-group.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Aug 10, 2023 at 04:44:48PM +0200, Alexander Stein wrote:
> Although defined in synopsys,dw-hdmi.yaml, they need to explicitly allowed
> in fsl,imx6-hdmi.yaml. Fixes the warning:
> arch/arm/boot/dts/nxp/imx/imx6q-mba6a.dtb: hdmi@120000: 'interrupts',
>  'reg' do not match any of the regexes: 'pinctrl-[0-9]+'
>  From schema: Documentation/devicetree/bindings/display/imx/fsl,imx6-hdmi.yaml
> 
> Fixes: b935c3a2e07b ("dt-bindings: display: imx: hdmi: Convert binding to YAML")
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
>  .../devicetree/bindings/display/imx/fsl,imx6-hdmi.yaml         | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/imx/fsl,imx6-hdmi.yaml b/Documentation/devicetree/bindings/display/imx/fsl,imx6-hdmi.yaml
> index af7fe9c4d196..d6af28e86ab4 100644
> --- a/Documentation/devicetree/bindings/display/imx/fsl,imx6-hdmi.yaml
> +++ b/Documentation/devicetree/bindings/display/imx/fsl,imx6-hdmi.yaml
> @@ -22,6 +22,9 @@ properties:
>        - fsl,imx6dl-hdmi
>        - fsl,imx6q-hdmi
>  
> +  reg: true
> +  interrupts: true
> +

You should change additionalProperties to unevaluatedProperties instead.

Rob

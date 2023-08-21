Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 893A3782F3E
	for <lists+linux-pm@lfdr.de>; Mon, 21 Aug 2023 19:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237029AbjHUROp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Aug 2023 13:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234823AbjHUROp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Aug 2023 13:14:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E87DEE;
        Mon, 21 Aug 2023 10:14:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 96A9D64048;
        Mon, 21 Aug 2023 17:14:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4524C433C8;
        Mon, 21 Aug 2023 17:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692638083;
        bh=MH0wQLIkGLHxG2U7ZihHzC9EFeKAg1wwbkNonW9+XmQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JlLRBRlXU3TpIsrE1LNM4eOtfxC+6aFHGYBH060E6Qw4p3+SZfOLXGNYYik8y2DWR
         oI6LJ8ANM5iIvFhjpKnWrII6XRSSJN1G70BkaqgWhl9U1D15Kgt6oDUIDMF5suE2vl
         /tVHdi67TSjo+yLa5BL53T+JWWyIEgsOHKYl3U4qSDp2e6JhjUqJVQgCrEIok1T0LT
         Jrl6o2rF9Mq3eYWQRr4v45EMGMTrXS0XfLcGVlqve59tAi+e0l1aqUnLhcH5iK20EE
         ZnerxQ9HY7A0CPw6ryh604PXvajLCmPMz8FRUzMZAD1mKWwveFBymOBTkxINkYhOOp
         HPPDVM//gRGYA==
Received: (nullmailer pid 1978426 invoked by uid 1000);
        Mon, 21 Aug 2023 17:14:39 -0000
Date:   Mon, 21 Aug 2023 12:14:39 -0500
From:   Rob Herring <robh@kernel.org>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Eric Dumazet <edumazet@google.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Fabio Estevam <festevam@gmail.com>, linux-pm@vger.kernel.org,
        David Airlie <airlied@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        devicetree@vger.kernel.org, netdev@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>,
        linux-arm-kernel@lists.infradead.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        dri-devel@lists.freedesktop.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 4/6] dt-bindings: net: microchip: Allow nvmem-cell usage
Message-ID: <169263807888.1978386.16316859459152478945.robh@kernel.org>
References: <20230810144451.1459985-1-alexander.stein@ew.tq-group.com>
 <20230810144451.1459985-5-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810144451.1459985-5-alexander.stein@ew.tq-group.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On Thu, 10 Aug 2023 16:44:49 +0200, Alexander Stein wrote:
> MAC address can be provided by a nvmem-cell, thus allow referencing a
> source for the address. Fixes the warning:
> arch/arm/boot/dts/nxp/imx/imx6q-mba6a.dtb: ethernet@1: 'nvmem-cell-names',
>  'nvmem-cells' do not match any of the regexes: 'pinctrl-[0-9]+'
>  From schema: Documentation/devicetree/bindings/net/microchip,lan95xx.yaml
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
>  Documentation/devicetree/bindings/net/microchip,lan95xx.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


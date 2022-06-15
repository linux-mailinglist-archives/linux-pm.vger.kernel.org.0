Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA06454C665
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jun 2022 12:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235185AbiFOKmo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jun 2022 06:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiFOKmn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jun 2022 06:42:43 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655DF14081
        for <linux-pm@vger.kernel.org>; Wed, 15 Jun 2022 03:42:42 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1o1QTp-0001hu-Pd; Wed, 15 Jun 2022 12:42:33 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1o1QTp-0004OZ-3o; Wed, 15 Jun 2022 12:42:33 +0200
Date:   Wed, 15 Jun 2022 12:42:33 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Francesco Dolcini <francesco.dolcini@toradex.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 0/9] imx: thermal: Allow trip point configuration from
 DT
Message-ID: <20220615104233.gxwsi3bhzyj2rry7@pengutronix.de>
References: <20220615094804.388280-1-francesco.dolcini@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615094804.388280-1-francesco.dolcini@toradex.com>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Francesco,

nice work :)

On 22-06-15, Francesco Dolcini wrote:
> This series allows to specify the imx thermal drivers trip point from the device tree,
> without this change the threshold are hard-coded and this might not be correct given the
> thermal design of the final system.
> 
> This change is backward compatible with the existing device tree, and even
> with this change in by default the thresholds are the same as before.
> 
> Toradex board are also updated to use a system-specific thresholds.
> 
> Discussion on the current design is here:
> https://lore.kernel.org/all/4ba1d7d2-3e8c-ba60-37fd-9598f415c076@linaro.org/

Thanks for thanking our abbroaches and forming this patchset. I added
only a few comments.

Regards,
  Marco

> 
> One side note, after this change the dtbs checker starts complaining with this message
> 
> ```
> linux/arch/arm/boot/dts/imx6dl-alti6p.dtb: tempmon: '#thermal-sensor-cells' does not match any of the regexes: '^(automotive|commercial|extended-commercial|industrial)-thermal$', 'pinctrl-[0-9]+'
> 	From schema: linux/Documentation/devicetree/bindings/thermal/imx-thermal.yaml
> ```
> 
> to my understanding this is just a side effect, '#thermal-sensor-cells' is not changed in
> any way by this series. I can fix that, I wonder if I should remove the property from the
> imx dtsi files or add it to the binding yaml definition, not sure about it.
> Anybody can advise?
> 
> 
> Francesco Dolcini (9):
>   dt-bindings: thermal: Define trips node in $defs
>   thermal: thermal: Export OF trip helper function
>   dt-bindings: thermal: imx: Add trips point
>   imx: thermal: Configure trip point from DT
>   ARM: dts: imx[67]: Add trips points
>   ARM: dts: imx6qdl-apalis: Set CPU critical trip point
>   ARM: dts: imx7-colibri: Set CPU critical trip point
>   ARM: dts: imx6ull-colibri: Set CPU critical trip point
>   ARM: dts: imx6qdl-colibri: Set CPU critical trip point
> 
>  .../bindings/thermal/imx-thermal.yaml         |  27 ++++
>  .../bindings/thermal/thermal-zones.yaml       | 130 +++++++++---------
>  arch/arm/boot/dts/imx-thermal.dtsi            |  61 ++++++++
>  arch/arm/boot/dts/imx6qdl-apalis.dtsi         |  12 ++
>  arch/arm/boot/dts/imx6qdl-colibri.dtsi        |  12 ++
>  arch/arm/boot/dts/imx6qdl.dtsi                |   2 +
>  arch/arm/boot/dts/imx6sl.dtsi                 |   2 +
>  arch/arm/boot/dts/imx6sll.dtsi                |   2 +
>  arch/arm/boot/dts/imx6sx.dtsi                 |   2 +
>  arch/arm/boot/dts/imx6ul.dtsi                 |   2 +
>  arch/arm/boot/dts/imx6ull-colibri.dtsi        |  12 ++
>  arch/arm/boot/dts/imx7-colibri.dtsi           |  12 ++
>  arch/arm/boot/dts/imx7s.dtsi                  |   2 +
>  drivers/thermal/imx_thermal.c                 |  49 +++++++
>  drivers/thermal/thermal_core.h                |   7 +
>  drivers/thermal/thermal_of.c                  |   5 +-
>  16 files changed, 274 insertions(+), 65 deletions(-)
>  create mode 100644 arch/arm/boot/dts/imx-thermal.dtsi
> 
> -- 
> 2.25.1
> 
> 
> 

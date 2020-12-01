Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA79D2CA151
	for <lists+linux-pm@lfdr.de>; Tue,  1 Dec 2020 12:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730553AbgLAL2C (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Dec 2020 06:28:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbgLAL2B (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Dec 2020 06:28:01 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C13FC0613D2
        for <linux-pm@vger.kernel.org>; Tue,  1 Dec 2020 03:27:21 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1kk3oM-0006sl-FO; Tue, 01 Dec 2020 12:27:10 +0100
Message-ID: <34146e8424bf9fdf5865fc954ee9964612ab88dc.camel@pengutronix.de>
Subject: Re: [PATCH 3/6] arm64: dts: imx8mq: Add interconnect for lcdif
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>, robh@kernel.org,
        shawnguo@kernel.org, festevam@gmail.com, catalin.marinas@arm.com,
        will@kernel.org, georgi.djakov@linaro.org, cdleonard@gmail.com
Cc:     devicetree@vger.kernel.org, kernel@puri.sm,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org
Date:   Tue, 01 Dec 2020 12:27:08 +0100
In-Reply-To: <20201201100124.4676-4-martin.kepplinger@puri.sm>
References: <20201201100124.4676-1-martin.kepplinger@puri.sm>
         <20201201100124.4676-4-martin.kepplinger@puri.sm>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1 (3.38.1-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Am Dienstag, den 01.12.2020, 11:01 +0100 schrieb Martin Kepplinger:
> Add interconnect ports for lcdif to set bus capabilities.
> 
> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> ---
>  arch/arm64/boot/dts/freescale/imx8mq.dtsi | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> index 244e28e54b35..7384a69ed36c 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> @@ -11,6 +11,7 @@
>  #include "dt-bindings/input/input.h"
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/thermal/thermal.h>
> +#include <dt-bindings/interconnect/imx8mq.h>
>  #include "imx8mq-pinfunc.h"
>  
> 
> 
> 
>  / {
> @@ -522,6 +523,8 @@
>  						  <&clk IMX8MQ_VIDEO_PLL1>,
>  						  <&clk IMX8MQ_VIDEO_PLL1_OUT>;
>  				assigned-clock-rates = <0>, <0>, <0>, <594000000>;
> +				interconnects = <&noc IMX8MQ_ICM_LCDIF &noc IMX8MQ_ICS_DRAM>;
> +				interconnect-names = "lcdif-dram";

This needs to be documented in the binding. Also I would argue that you
can drop the lcdif prefix in the name, as it's part of the lcdif DT
node.

Regards,
Lucas

>  				status = "disabled";
>  
> 
> 
> 
>  				port@0 {



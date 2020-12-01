Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 478FA2CA15D
	for <lists+linux-pm@lfdr.de>; Tue,  1 Dec 2020 12:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730599AbgLALai (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Dec 2020 06:30:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727717AbgLALah (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Dec 2020 06:30:37 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD8FC0613D4
        for <linux-pm@vger.kernel.org>; Tue,  1 Dec 2020 03:29:57 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1kk3qv-00073U-QX; Tue, 01 Dec 2020 12:29:49 +0100
Message-ID: <f2752e5d36f97d9da3d83b2d0a987dbd9c2d1a9c.camel@pengutronix.de>
Subject: Re: [PATCH 5/6] arm64: defconfig: Enable interconnect for imx8mq
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>, robh@kernel.org,
        shawnguo@kernel.org, festevam@gmail.com, catalin.marinas@arm.com,
        will@kernel.org, georgi.djakov@linaro.org, cdleonard@gmail.com
Cc:     devicetree@vger.kernel.org, kernel@puri.sm,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org
Date:   Tue, 01 Dec 2020 12:29:48 +0100
In-Reply-To: <20201201100124.4676-6-martin.kepplinger@puri.sm>
References: <20201201100124.4676-1-martin.kepplinger@puri.sm>
         <20201201100124.4676-6-martin.kepplinger@puri.sm>
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
> Enable INTERCONNECT_IMX8MQ in order to make interconnect more widely
> available for testing.
> 
> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> ---
>  arch/arm64/configs/defconfig | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 867cc4a5f00f..57cf2f50b5f7 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -1051,10 +1051,11 @@ CONFIG_OF_FPGA_REGION=m
>  CONFIG_TEE=y
>  CONFIG_OPTEE=y
>  CONFIG_SLIMBUS=m
> +CONFIG_MUX_MMIO=y

This change should be part of the other patch to regenerate the config
without functional changes. Also order of the patches should be the
other way around: first regenerate without changes, then stack the
INTERCONNECT_IMX8MQ enable on top.

Regards,
Lucas

>  CONFIG_SLIM_QCOM_CTRL=m
>  CONFIG_SLIM_QCOM_NGD_CTRL=m
> -CONFIG_MUX_MMIO=y
> -CONFIG_INTERCONNECT=y
> +CONFIG_INTERCONNECT_IMX=m
> +CONFIG_INTERCONNECT_IMX8MQ=m
>  CONFIG_INTERCONNECT_QCOM=y
>  CONFIG_INTERCONNECT_QCOM_MSM8916=m
>  CONFIG_INTERCONNECT_QCOM_OSM_L3=m



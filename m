Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 100572F75C6
	for <lists+linux-pm@lfdr.de>; Fri, 15 Jan 2021 10:48:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728828AbhAOJsR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Jan 2021 04:48:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:48454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727128AbhAOJsR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 15 Jan 2021 04:48:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 16D4D2339D;
        Fri, 15 Jan 2021 09:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610704066;
        bh=jZM9pYh4SO+Xj3TGT5wTV7fU3bAxysfMgnPoPjj1b9s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bR5v9gj1SJgRHYVRQbG98fQ2O+2FPg1RykuZJVpQupAmNALu4g+RVtg4bVkpmNhzt
         813+L8815TCP7to7zlNlJ+sbvwGwLtn/SOPZeX2zHc56dpZn6pVYZR2btIx9sC6yLG
         auqd+X1XF8gZe5BjPHh8uBIAyfyknism8R0XikaAjBymK3KeL1ylp3k5q7aNDkrWx0
         Cbs0f24SxdgNDdEupLbZz6Lib2lUUvbkJHs8Va07MtdY0btMMqnYZkLT5D0vkUqzTD
         f1Y1J2uGN4FGso8wU4h9jFY41cJM/ZVksfkKSnxHXrmvNi6R7sm5As9G3p5FdwTpdh
         ny96Jfk1sQBdg==
Date:   Fri, 15 Jan 2021 17:47:39 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     robh@kernel.org, festevam@gmail.com, catalin.marinas@arm.com,
        will@kernel.org, georgi.djakov@linaro.org, cdleonard@gmail.com,
        gregkh@linuxfoundation.org, kernel@pengutronix.de,
        linux-imx@nxp.com, kernel@puri.sm, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 4/5] arm64: dts: imx8mq: Add interconnect for lcdif
Message-ID: <20210115094738.GL28365@dragon>
References: <20210107121754.3295-1-martin.kepplinger@puri.sm>
 <20210107121754.3295-5-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210107121754.3295-5-martin.kepplinger@puri.sm>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jan 07, 2021 at 01:17:53PM +0100, Martin Kepplinger wrote:
> Add interconnect ports for lcdif to set bus capabilities.
> 
> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> ---
>  arch/arm64/boot/dts/freescale/imx8mq.dtsi | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> index 89e7de2e7f7a..9300be8c9b53 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> @@ -11,6 +11,7 @@
>  #include "dt-bindings/input/input.h"
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/thermal/thermal.h>
> +#include <dt-bindings/interconnect/imx8mq.h>
>  #include "imx8mq-pinfunc.h"
>  
>  / {
> @@ -522,6 +523,8 @@
>  						  <&clk IMX8MQ_VIDEO_PLL1>,
>  						  <&clk IMX8MQ_VIDEO_PLL1_OUT>;
>  				assigned-clock-rates = <0>, <0>, <0>, <594000000>;
> +				interconnects = <&noc IMX8MQ_ICM_LCDIF &noc IMX8MQ_ICS_DRAM>;
> +				interconnect-names = "dram";

Hmm, two interconnect phandles but only one name?

Shawn

>  				status = "disabled";
>  
>  				port@0 {
> -- 
> 2.20.1
> 

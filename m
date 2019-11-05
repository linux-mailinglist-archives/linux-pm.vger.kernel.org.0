Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2071AEF6B4
	for <lists+linux-pm@lfdr.de>; Tue,  5 Nov 2019 08:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387856AbfKEH7U (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Nov 2019 02:59:20 -0500
Received: from gloria.sntech.de ([185.11.138.130]:35328 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387810AbfKEH7U (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 5 Nov 2019 02:59:20 -0500
Received: from ip5f5a6266.dynamic.kabel-deutschland.de ([95.90.98.102] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iRtjt-0006Im-4m; Tue, 05 Nov 2019 08:58:57 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Elaine Zhang <zhangqing@rock-chips.com>
Cc:     amit.kucheria@verdurent.com, rui.zhang@intel.com,
        edubezval@gmail.com, daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        xxx@rock-chips.com, xf@rock-chips.com, huangtao@rock-chips.com,
        andy.yan@rock-chips.com
Subject: Re: [PATCH v1 1/3] dt-bindings: rockchip-thermal: Support the RK3308 SoC compatible
Date:   Tue, 05 Nov 2019 08:58:56 +0100
Message-ID: <2284763.Jna2nk2sLt@diego>
In-Reply-To: <1572923846-23310-2-git-send-email-zhangqing@rock-chips.com>
References: <1572923846-23310-1-git-send-email-zhangqing@rock-chips.com> <1572923846-23310-2-git-send-email-zhangqing@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Am Dienstag, 5. November 2019, 04:17:24 CET schrieb Elaine Zhang:
> Add a new compatible for thermal founding on RK3308 SoCs.
> 
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

> ---
>  Documentation/devicetree/bindings/thermal/rockchip-thermal.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
> index c6aac9bcacf1..3a0a9556680e 100644
> --- a/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
> +++ b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
> @@ -6,6 +6,7 @@ Required properties:
>     "rockchip,rv1108-tsadc": found on RV1108 SoCs
>     "rockchip,rk3228-tsadc": found on RK3228 SoCs
>     "rockchip,rk3288-tsadc": found on RK3288 SoCs
> +   "rockchip,rk3308-tsadc": found on RK3308 SoCs
>     "rockchip,rk3328-tsadc": found on RK3328 SoCs
>     "rockchip,rk3368-tsadc": found on RK3368 SoCs
>     "rockchip,rk3399-tsadc": found on RK3399 SoCs
> 





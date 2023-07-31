Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD9576A229
	for <lists+linux-pm@lfdr.de>; Mon, 31 Jul 2023 22:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjGaUs6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 31 Jul 2023 16:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjGaUs5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 Jul 2023 16:48:57 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80255198B
        for <linux-pm@vger.kernel.org>; Mon, 31 Jul 2023 13:48:51 -0700 (PDT)
Received: from i53875aa8.versanet.de ([83.135.90.168] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1qQZot-0008UV-QH; Mon, 31 Jul 2023 22:48:47 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, Jagan Teki <jagan@edgeble.ai>
Cc:     Jagan Teki <jagan@edgeble.ai>, linux-pm@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 01/14] genpd: rockchip: Add PD_VO entry for rv1126
Date:   Mon, 31 Jul 2023 22:48:45 +0200
Message-ID: <5699457.DvuYhMxLoT@diego>
In-Reply-To: <20230731110012.2913742-2-jagan@edgeble.ai>
References: <20230731110012.2913742-1-jagan@edgeble.ai>
 <20230731110012.2913742-2-jagan@edgeble.ai>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Am Montag, 31. Juli 2023, 12:59:59 CEST schrieb Jagan Teki:
> PD_VO power-domain entry in RV1126 are connected to
> - BIU_VO
> - VOP
> - RGA
> - IEP
> - DSIHOST
> 
> Add an entry for it.
> 
> Signed-off-by: Jagan Teki <jagan@edgeble.ai>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

@Ulf: now that we have a genpd subsystem, I assume you're going
to pick up this patch, right?

Thanks
Heiko

> ---
> Cc: linux-pm@vger.kernel.org
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> 
>  drivers/genpd/rockchip/pm-domains.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/genpd/rockchip/pm-domains.c b/drivers/genpd/rockchip/pm-domains.c
> index e3de49e671dc..d5d3ecb38283 100644
> --- a/drivers/genpd/rockchip/pm-domains.c
> +++ b/drivers/genpd/rockchip/pm-domains.c
> @@ -976,6 +976,7 @@ static const struct rockchip_domain_info px30_pm_domains[] = {
>  static const struct rockchip_domain_info rv1126_pm_domains[] = {
>  	[RV1126_PD_VEPU]	= DOMAIN_RV1126("vepu", BIT(2),  BIT(9),  BIT(9), false),
>  	[RV1126_PD_VI]		= DOMAIN_RV1126("vi", BIT(4),  BIT(6),  BIT(6),  false),
> +	[RV1126_PD_VO]		= DOMAIN_RV1126("vo", BIT(5),  BIT(7),  BIT(7),  false),
>  	[RV1126_PD_ISPP]	= DOMAIN_RV1126("ispp", BIT(1), BIT(8), BIT(8),  false),
>  	[RV1126_PD_VDPU]	= DOMAIN_RV1126("vdpu", BIT(3), BIT(10), BIT(10), false),
>  	[RV1126_PD_NVM]		= DOMAIN_RV1126("nvm", BIT(7), BIT(11), BIT(11),  false),
> 





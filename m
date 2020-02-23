Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 634EF16984D
	for <lists+linux-pm@lfdr.de>; Sun, 23 Feb 2020 16:09:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbgBWPJY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 23 Feb 2020 10:09:24 -0500
Received: from gloria.sntech.de ([185.11.138.130]:60702 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726208AbgBWPJY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 23 Feb 2020 10:09:24 -0500
Received: from p508fd060.dip0.t-ipconnect.de ([80.143.208.96] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1j5ssh-0003kj-Ga; Sun, 23 Feb 2020 16:09:19 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     khilman@kernel.org
Cc:     nm@ti.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        christoph.muellner@theobroma-systems.com
Subject: Re: [PATCH] PM / AVS: rockchip-io: fix the supply naming for the emmc supply on px30
Date:   Sun, 23 Feb 2020 16:09:18 +0100
Message-ID: <2116646.O5uUgpsMTn@phil>
In-Reply-To: <20200121222859.4069263-1-heiko@sntech.de>
References: <20200121222859.4069263-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

Am Dienstag, 21. Januar 2020, 23:28:59 CET schrieb Heiko Stuebner:
> From: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
> 
> The supply going to the emmc/flash is named vccio6, not vccio0 and while
> the code does this correctly already, the comments and error output do not.
> 
> So just change these values to the correct ones.
> 
> Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>

oh so gently ping on this tiny patch ;-)

Thanks for considering
Heiko

> ---
>  drivers/power/avs/rockchip-io-domain.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/power/avs/rockchip-io-domain.c b/drivers/power/avs/rockchip-io-domain.c
> index 398fc954419e..eece97f97ef8 100644
> --- a/drivers/power/avs/rockchip-io-domain.c
> +++ b/drivers/power/avs/rockchip-io-domain.c
> @@ -152,18 +152,18 @@ static void px30_iodomain_init(struct rockchip_iodomain *iod)
>  	int ret;
>  	u32 val;
>  
> -	/* if no VCCIO0 supply we should leave things alone */
> +	/* if no VCCIO6 supply we should leave things alone */
>  	if (!iod->supplies[PX30_IO_VSEL_VCCIO6_SUPPLY_NUM].reg)
>  		return;
>  
>  	/*
> -	 * set vccio0 iodomain to also use this framework
> +	 * set vccio6 iodomain to also use this framework
>  	 * instead of a special gpio.
>  	 */
>  	val = PX30_IO_VSEL_VCCIO6_SRC | (PX30_IO_VSEL_VCCIO6_SRC << 16);
>  	ret = regmap_write(iod->grf, PX30_IO_VSEL, val);
>  	if (ret < 0)
> -		dev_warn(iod->dev, "couldn't update vccio0 ctrl\n");
> +		dev_warn(iod->dev, "couldn't update vccio6 ctrl\n");
>  }
>  
>  static void rk3288_iodomain_init(struct rockchip_iodomain *iod)
> 





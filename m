Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B07A3B9D92
	for <lists+linux-pm@lfdr.de>; Fri,  2 Jul 2021 10:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbhGBIgL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Fri, 2 Jul 2021 04:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbhGBIgK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 2 Jul 2021 04:36:10 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79FEAC061762
        for <linux-pm@vger.kernel.org>; Fri,  2 Jul 2021 01:33:38 -0700 (PDT)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1lzEbx-0002MD-KP; Fri, 02 Jul 2021 10:33:21 +0200
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1lzEbt-0002gx-GA; Fri, 02 Jul 2021 10:33:17 +0200
Message-ID: <bf4f26cdca7174ba687e29a581a5276511112fe7.camel@pengutronix.de>
Subject: Re: [PATCH v19 3/7] soc: mediatek: SVS: introduce MTK SVS engine
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Roger Lu <roger.lu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Boichat <drinkcat@google.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Fan Chen <fan.chen@mediatek.com>,
        HenryC Chen <HenryC.Chen@mediatek.com>,
        YT Lee <yt.lee@mediatek.com>,
        Xiaoqing Liu <Xiaoqing.Liu@mediatek.com>,
        Charles Yang <Charles.Yang@mediatek.com>,
        Angus Lin <Angus.Lin@mediatek.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Guenter Roeck <linux@roeck-us.net>
Date:   Fri, 02 Jul 2021 10:33:17 +0200
In-Reply-To: <20210702031214.21597-4-roger.lu@mediatek.com>
References: <20210702031214.21597-1-roger.lu@mediatek.com>
         <20210702031214.21597-4-roger.lu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Roger,

On Fri, 2021-07-02 at 11:12 +0800, Roger Lu wrote:
[...]
> diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
> new file mode 100644
> index 000000000000..c2fcbc204b1d
> --- /dev/null
> +++ b/drivers/soc/mediatek/mtk-svs.c
> @@ -0,0 +1,1724 @@
[...]
> +static int svs_suspend(struct device *dev)
> +{
> +	struct svs_platform *svsp = dev_get_drvdata(dev);
> +	struct svs_bank *svsb;
> +	unsigned long flags;
> +	int ret;
> +	u32 idx;
> +
> +	for (idx = 0; idx < svsp->bank_num; idx++) {
> +		svsb = &svsp->banks[idx];
> +
> +		/* Wait if svs_isr() is still in process. */
> +		spin_lock_irqsave(&mtk_svs_lock, flags);
> +		svsp->pbank = svsb;
> +		svs_switch_bank(svsp);
> +		svs_writel(svsp, SVSB_EN_OFF, SVSEN);
> +		svs_writel(svsp, SVSB_INTSTS_CLEAN, INTSTS);
> +		spin_unlock_irqrestore(&mtk_svs_lock, flags);
> +
> +		svsb->suspended = true;
> +		if (svsb->phase != SVSB_PHASE_INIT01) {
> +			svsb->phase = SVSB_PHASE_ERROR;
> +			svs_adjust_pm_opp_volts(svsb, true);
> +		}
> +	}
> +
> +	if (svsp->rst) {

This is not necessary, reset_control_assert() checks for (rstc == NULL)
itself.

> +		ret = reset_control_assert(svsp->rst);
> +		if (ret) {
> +			dev_err(svsp->dev, "cannot assert reset %d\n", ret);
> +			return ret;
> +		}
> +	}
> +
> +	clk_disable_unprepare(svsp->main_clk);
> +
> +	return 0;
> +}
> +
> +static int svs_resume(struct device *dev)
> +{
> +	struct svs_platform *svsp = dev_get_drvdata(dev);
> +	struct svs_bank *svsb;
> +	int ret;
> +	u32 idx;
> +
> +	ret = clk_prepare_enable(svsp->main_clk);
> +	if (ret) {
> +		dev_err(svsp->dev, "cannot enable main_clk, disable svs\n");
> +		return ret;
> +	}
> +
> +	if (svsp->rst) {

Same as above, reset_control_deassert(NULL) will just return 0.

> +		ret = reset_control_deassert(svsp->rst);
> +		if (ret) {
> +			dev_err(svsp->dev, "cannot deassert reset %d\n", ret);
> +			return ret;
> +		}
> +	}
> +
> +	for (idx = 0; idx < svsp->bank_num; idx++) {
> +		svsb = &svsp->banks[idx];
> +		svsb->suspended = false;
> +	}
> +
> +	ret = svs_init02(svsp);
> +	if (ret)
> +		return ret;
> +
> +	svs_mon_mode(svsp);
> +
> +	return 0;
> +}

regards
Philipp

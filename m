Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1F8892540
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2019 15:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbfHSNim (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Aug 2019 09:38:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:50268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727301AbfHSNil (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 19 Aug 2019 09:38:41 -0400
Received: from X250 (37.80-203-192.nextgentel.com [80.203.192.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3448120644;
        Mon, 19 Aug 2019 13:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566221921;
        bh=47ZKROnn84RKEvkEyiFYQznmN0p3z6+yXmQR9SMFTMo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yOVGtXx9Ke+ACtLOruQ8xvXQWXqBmbRxFvzbqQIVQ7iOm+klS13QjFZZ7uIgcxIo3
         pFofrGRRBoWyHpTzR75z6Aduga1/zuvMatrTJM/DpzX/qYB7A8W+1FkOvb2Z2m86AZ
         JUvuGYvXp7sVRAkT8pD70BHw7ks9dAPiwQg/HDI8=
Date:   Mon, 19 Aug 2019 15:38:28 +0200
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, mturquette@baylibre.com,
        sboyd@kernel.org, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        leonard.crestez@nxp.com, abel.vesa@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH RESEND V2 5/7] clk: imx8mn: Add missing rate_count
 assignment for each PLL structure
Message-ID: <20190819133827.GN5999@X250>
References: <1566109945-11149-1-git-send-email-Anson.Huang@nxp.com>
 <1566109945-11149-5-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1566109945-11149-5-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Aug 18, 2019 at 02:32:23AM -0400, Anson Huang wrote:
> Add .rate_count assignment which is necessary for searching required
> PLL rate from the each PLL table.
> 
> Fixes: 96d6392b54db ("clk: imx: Add support for i.MX8MN clock driver")

The commit ID is not stable before the commit lands on mainline, so I
dropped it and applied the patch.

Shawn

> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> Changes since V1:
> 	- split the patch into 2 patches, #1 fixed those missing .rate_count assignment,
> 	  #2 add missing frequency points.
> ---
>  drivers/clk/imx/clk-imx8mn.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
> index ecd1062..b5a027c 100644
> --- a/drivers/clk/imx/clk-imx8mn.c
> +++ b/drivers/clk/imx/clk-imx8mn.c
> @@ -67,36 +67,43 @@ static const struct imx_pll14xx_rate_table imx8mn_drampll_tbl[] = {
>  static struct imx_pll14xx_clk imx8mn_audio_pll = {
>  		.type = PLL_1443X,
>  		.rate_table = imx8mn_audiopll_tbl,
> +		.rate_count = ARRAY_SIZE(imx8mn_audiopll_tbl),
>  };
>  
>  static struct imx_pll14xx_clk imx8mn_video_pll = {
>  		.type = PLL_1443X,
>  		.rate_table = imx8mn_videopll_tbl,
> +		.rate_count = ARRAY_SIZE(imx8mn_videopll_tbl),
>  };
>  
>  static struct imx_pll14xx_clk imx8mn_dram_pll = {
>  		.type = PLL_1443X,
>  		.rate_table = imx8mn_drampll_tbl,
> +		.rate_count = ARRAY_SIZE(imx8mn_drampll_tbl),
>  };
>  
>  static struct imx_pll14xx_clk imx8mn_arm_pll = {
>  		.type = PLL_1416X,
>  		.rate_table = imx8mn_pll1416x_tbl,
> +		.rate_count = ARRAY_SIZE(imx8mn_pll1416x_tbl),
>  };
>  
>  static struct imx_pll14xx_clk imx8mn_gpu_pll = {
>  		.type = PLL_1416X,
>  		.rate_table = imx8mn_pll1416x_tbl,
> +		.rate_count = ARRAY_SIZE(imx8mn_pll1416x_tbl),
>  };
>  
>  static struct imx_pll14xx_clk imx8mn_vpu_pll = {
>  		.type = PLL_1416X,
>  		.rate_table = imx8mn_pll1416x_tbl,
> +		.rate_count = ARRAY_SIZE(imx8mn_pll1416x_tbl),
>  };
>  
>  static struct imx_pll14xx_clk imx8mn_sys_pll = {
>  		.type = PLL_1416X,
>  		.rate_table = imx8mn_pll1416x_tbl,
> +		.rate_count = ARRAY_SIZE(imx8mn_pll1416x_tbl),
>  };
>  
>  static const char * const pll_ref_sels[] = { "osc_24m", "dummy", "dummy", "dummy", };
> -- 
> 2.7.4
> 

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 924CD551F82
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jun 2022 16:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbiFTO65 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Jun 2022 10:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242726AbiFTO6e (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Jun 2022 10:58:34 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2567201AB
        for <linux-pm@vger.kernel.org>; Mon, 20 Jun 2022 07:21:13 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 997DD660159D;
        Mon, 20 Jun 2022 15:21:11 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655734871;
        bh=1IzybNISo/qb6ajNmb/E3/HYWTJnWgW68XVLtKxjpQw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=R+Zk4qEZVjVF10Y0lFJzWvE1/eed+MdfL/c3tDFkgtrZX38tOIjJd1c0QMXwToIaC
         uE1XLJ/nHZd95PXP8CzGxccUfszQWWoSnM8RnbHYc+x34QabPELyrevasvliIFGch8
         GNHwPT+f3LiQQGOe5OnWPyapchfVR2QY+f7gSg4xIJKP6T+cwiMlQP2dy+QOtLKAxO
         FbN6trgIEWvQtDucS4hATU3oPsPFqd8uNlExwFbgJ7wTmuU66tvFPdPObEu29ocKe1
         m+ehzep8YZlO3DjSQuuy/eTBih8ycSU30gOfHx2F5a90Ksxc+ML7zRRlIXKsEljAwE
         NufvhcuMZ4xmA==
Message-ID: <25da54a7-3fc1-39c2-ed93-0ad72ce54e11@collabora.com>
Date:   Mon, 20 Jun 2022 16:21:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] PM / devfreq: mediatek: Fix possible dereference of null
 pointer
Content-Language: en-US
To:     matthias.bgg@kernel.org, dan.carpenter@oracle.com,
        johnson.wang@mediatek.com
Cc:     linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>
References: <20220617133330.6510-1-matthias.bgg@kernel.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220617133330.6510-1-matthias.bgg@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Il 17/06/22 15:33, matthias.bgg@kernel.org ha scritto:
> From: Matthias Brugger <matthias.bgg@gmail.com>
> 
> We dereference the driver data before checking of it's valid.
> This patch fixes this, by accessing the PLL data struct after cheching
> the pointer
> 

Hello Matthias,

honestly, I don't think that this commit is right: mtk_ccifreq_target() is the
devfreq_dev_profile's .target() callback!

Checking mtk_ccifreq_probe(), we are setting drvdata long before adding the
devfreq device so, actually, it's impossible for dev_get_drvdata(dev) to return
NULL, or whatever invalid pointer.

This means that the right thing to do in mtk_ccifreq_target() is to simply remove
the `drv` NULL check, as this can never happen! :-)

Cheers,
Angelo

> Fixes: 07dc787be231 ("Add linux-next specific files for 20220617")
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> ---
>   drivers/devfreq/mtk-cci-devfreq.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/devfreq/mtk-cci-devfreq.c b/drivers/devfreq/mtk-cci-devfreq.c
> index 71abb3fbd042..77522f16c878 100644
> --- a/drivers/devfreq/mtk-cci-devfreq.c
> +++ b/drivers/devfreq/mtk-cci-devfreq.c
> @@ -127,7 +127,7 @@ static int mtk_ccifreq_target(struct device *dev, unsigned long *freq,
>   			      u32 flags)
>   {
>   	struct mtk_ccifreq_drv *drv = dev_get_drvdata(dev);
> -	struct clk *cci_pll = clk_get_parent(drv->cci_clk);
> +	struct clk *cci_pll;
>   	struct dev_pm_opp *opp;
>   	unsigned long opp_rate;
>   	int voltage, pre_voltage, inter_voltage, target_voltage, ret;
> @@ -138,6 +138,7 @@ static int mtk_ccifreq_target(struct device *dev, unsigned long *freq,
>   	if (drv->pre_freq == *freq)
>   		return 0;
>   
> +	cci_pll = clk_get_parent(drv->cci_clk);
>   	inter_voltage = drv->inter_voltage;
>   
>   	opp_rate = *freq;
> 



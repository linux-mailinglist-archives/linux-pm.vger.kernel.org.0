Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D36E7CBDFE
	for <lists+linux-pm@lfdr.de>; Tue, 17 Oct 2023 10:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234776AbjJQInj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Oct 2023 04:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234782AbjJQInf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Oct 2023 04:43:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6026AED;
        Tue, 17 Oct 2023 01:43:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB809C433C7;
        Tue, 17 Oct 2023 08:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697532214;
        bh=CuMFUN7SSAJyB5Hs2Sw1yPemkO2qhqwV3uarBTFnFsc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Jfo+B2I8RflD38I2fr0TkxwP3YiH8ldKGiaD0Z7y9lFawxu7zg4RgBVu5yw5fdi0a
         wRurigC6+9sehsxN+piW9AtmgeYw10xAWKekLmrWXHk++KAd2oSzhe72EKB1dZbXzi
         +zdDrALYdprbZQcIy6svl+6eO1RYch7MjjLo+MU+S6K0jLcxCSs+JOMhYkpa+XqrS+
         +5QhkyBeH9cu0Is691po8zR4M0BrSbRNoPBbuiFqfg2PVNx29hMkRTgdn2BsaSvvHY
         1izyoBWnc7YjCDQiINlYya1B1WKot/Riwkxrc56t/jPSut8pv3IF5oIddNWhMYPiHh
         0VBKbCyyB/YPw==
Message-ID: <82958ea9-cc1c-44af-9144-53cf2bd5c23b@kernel.org>
Date:   Tue, 17 Oct 2023 17:43:30 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PM / devfreq: mediatek: unlock on error in
 mtk_ccifreq_target()
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@linaro.org>,
        Mark Tseng <chun-jen.tseng@mediatek.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org,
        kernel-janitors@vger.kernel.org
References: <1bada9b2-d276-4123-bfdf-03d165569543@moroto.mountain>
From:   Chanwoo Choi <chanwoo@kernel.org>
In-Reply-To: <1bada9b2-d276-4123-bfdf-03d165569543@moroto.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 23. 10. 12. 18:41, Dan Carpenter wrote:
> Call mutex_unlock(&drv->reg_lock) before returning the error code.
> 
> Fixes: d2805601988f ("PM / devfreq: mediatek: protect oop in critical session")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/devfreq/mtk-cci-devfreq.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/devfreq/mtk-cci-devfreq.c b/drivers/devfreq/mtk-cci-devfreq.c
> index b0ed25e33f2b..11bc3d03494c 100644
> --- a/drivers/devfreq/mtk-cci-devfreq.c
> +++ b/drivers/devfreq/mtk-cci-devfreq.c
> @@ -146,7 +146,8 @@ static int mtk_ccifreq_target(struct device *dev, unsigned long *freq,
>  	opp = devfreq_recommended_opp(dev, &opp_rate, 1);
>  	if (IS_ERR(opp)) {
>  		dev_err(dev, "failed to find opp for freq: %ld\n", opp_rate);
> -		return PTR_ERR(opp);
> +		ret = PTR_ERR(opp);
> +		goto out_unlock;
>  	}
>  
>  	voltage = dev_pm_opp_get_voltage(opp);

Applied it. Thanks.

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi


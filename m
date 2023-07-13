Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF28B751CDB
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jul 2023 11:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234096AbjGMJLW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Jul 2023 05:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232181AbjGMJLE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Jul 2023 05:11:04 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDDD82D4C
        for <linux-pm@vger.kernel.org>; Thu, 13 Jul 2023 02:10:33 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-3143b72c5ffso647155f8f.3
        for <linux-pm@vger.kernel.org>; Thu, 13 Jul 2023 02:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689239432; x=1691831432;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XznQUuiJb54uwYssnpziXtdB1g0ycFoSN01wYyxF/c0=;
        b=FHeBakREsG4Z6rum1jL3V/EaDxVsP+vazLfvdtBwMKVlQ5rsBg2X8Es6ckTs4R1DOc
         sS5A1ZZZz/4S3XRRFhkoZDGGO7bg1jvPazO5bo13XXJvoWdCtZczsDhI4V87qrB/EXK+
         x+KOZuE66xkOoP8C/vJjqWPL//edg8WsgU9PXmKu7wjkBTe8qOLlqfRqVpvzCH8C3P08
         xU92KmLZ6owDVyComAGhfeHDHd+VQtXFYE4TzSkIL4iT2g7GNIIgNN8yUIvSeXl2hF46
         du+AeDp//Mi/i7Q81ZA98FOx00pKdhnwalFNnDBUt6LSIpSD6bgJsIZIb3WpBA7BhckA
         qD+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689239432; x=1691831432;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XznQUuiJb54uwYssnpziXtdB1g0ycFoSN01wYyxF/c0=;
        b=RlyyO5L2yX6QdTb6eiBrHvbNb6M7VLBxZ6JYZ+Ep2hnsrI0mgVl4eBs6V5mLMXnytL
         cCpwtprgI4fAhFe7SY1s0fmiGpVWEjnPfcpBr70Zht+mg28tixUpLxybXG7EDByX1wJW
         V7ouFD6FSvEUEO6MUQHy1rOI1ca1fq+6AAJCL5WbnABuGhdks7A6Iuln7buTui1L/Nqt
         o6jc4OCyKSU/wuiUBVeNOJRGr8uKJjISHavzhtNIssArHe9aMViNWexG8y5F0AJXsrZP
         yBLBvS7odBfdVbNCodWoZMl6is2UjNmkl9BeYjA/wR+PBpPYxnTctLEcdW3yVn2WECzp
         QpFw==
X-Gm-Message-State: ABy/qLZkdCGDf3tyXVUUX6gPCMMOTf79ofwkaliU1eC/sd1QpYn/Sw05
        0beqdmgT/xBQYganZEcOdYyeyQ==
X-Google-Smtp-Source: APBJJlHhw9AYxg1hAv2II73+0rasYKMnkDxHEkSNwa5YORkhO8HmoSJ3UF4LYWWLNCqBqfFXl1cdyg==
X-Received: by 2002:a05:6000:1c4:b0:314:7fb:92c2 with SMTP id t4-20020a05600001c400b0031407fb92c2mr1172184wrx.30.1689239431891;
        Thu, 13 Jul 2023 02:10:31 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id y17-20020adfee11000000b0031274a184d5sm7350195wrn.109.2023.07.13.02.10.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 02:10:31 -0700 (PDT)
Message-ID: <b2a5f64f-3861-6345-3c2c-acba6ed40ee2@linaro.org>
Date:   Thu, 13 Jul 2023 11:10:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1] drivers: mediatek: fix parameter check in
 lvts_debugfs_init()
Content-Language: en-US
To:     Minjie Du <duminjie@vivo.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Cc:     opensource.kernel@vivo.com
References: <20230713042413.2519-1-duminjie@vivo.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230713042413.2519-1-duminjie@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 13/07/2023 06:24, Minjie Du wrote:
> Make IS_ERR() judge the debugfs_create_dir() function return
> in lvts_debugfs_init().
> 
> Signed-off-by: Minjie Du <duminjie@vivo.com>

Applied (but massaged the changelog)

Thanks for the fix

> ---
>   drivers/thermal/mediatek/lvts_thermal.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
> index b693fac2d..b46f351d1 100644
> --- a/drivers/thermal/mediatek/lvts_thermal.c
> +++ b/drivers/thermal/mediatek/lvts_thermal.c
> @@ -190,7 +190,7 @@ static int lvts_debugfs_init(struct device *dev, struct lvts_domain *lvts_td)
>   	int i;
>   
>   	lvts_td->dom_dentry = debugfs_create_dir(dev_name(dev), NULL);
> -	if (!lvts_td->dom_dentry)
> +	if (IS_ERR(lvts_td->dom_dentry))
>   		return 0;
>   
>   	for (i = 0; i < lvts_td->num_lvts_ctrl; i++) {

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


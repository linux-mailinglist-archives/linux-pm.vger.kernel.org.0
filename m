Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51ECB550F72
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jun 2022 06:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237592AbiFTEnF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Jun 2022 00:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237564AbiFTEnD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Jun 2022 00:43:03 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7757D60F4
        for <linux-pm@vger.kernel.org>; Sun, 19 Jun 2022 21:43:02 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id k127so3969194pfd.10
        for <linux-pm@vger.kernel.org>; Sun, 19 Jun 2022 21:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XuPCzTzhcmOZzHOmk2sFdgEFNoZlfvJu9dKlztxiN/Y=;
        b=v2uTas0ITpi6sQ50rCEMiLgEQR9vCoVW8ykoCP10v0VHG7XLW9lbVQXcTERpNEkdBl
         yQGU3U23/U+g3a64sDok8eq+zzWMr1dnUcDpvansrDgbrCg66FWQZYKvva4AkLKbMWoZ
         8dbbX8Fo4bmY8KFxhOYkNuHZ4W/pEwF7wYX3oXNGZOBY+UaVRJxNT2sFIonlJAR7ap7p
         OgV3hh4RJGh+onEG9mQKJvwMGM0HVbp/asqZxsudKFOh9bK3xv/cW+v4aatOIlIzpg4K
         IrpKKR7Yu+MwA/BgE54nYrAlkva2582Ea+Pn9asSrhQCryKo/YKsWFb4cZUuWTPMCA8H
         s8Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XuPCzTzhcmOZzHOmk2sFdgEFNoZlfvJu9dKlztxiN/Y=;
        b=BqJSEqTS2pni1E3CPaKWpoyRekhI85cKGlqUTkEHHNk7R6WpEaiaTpkh2MZMLA6bHs
         B30YZ9NWVh4B6boWpAMXGx5EWDAogc4svwPt2gcioaMEc8EJ3/FZMLvyOPpr+WRdhJZt
         A6XaP4aO+48HVywVtmCeXTURehdmS57Q7AOaALUq+gT+txuKo4j76RZ0rPVXNi3j1fdT
         gsXP6+mUufpQQLWU+q+1UL3f+/8LoujNslqYKpsrmUS1nXYno5MTxXd4ZGFWSjIhlTNT
         Plmuvxfe4QqKHA7NGFAMZuy06FwCdoesqCIQSmBGz+6fA0KfQG15SgOL/TGMyUazt3TN
         f6Ew==
X-Gm-Message-State: AJIora+bdIyc4pq2xJyTemPNr5cH54dkBFmiXi1DNEkdY/nj5U+ZH0oj
        utnpD0cpyUPAGPLN4FxKkOURIQ==
X-Google-Smtp-Source: AGRyM1u9VfNHrad/tqs9W/bOQOD4E8u6NsMRQEd+0M8Qya2WVZ9s43KSlqXGkWaUUjAwmTx+ToXCLw==
X-Received: by 2002:a05:6a00:198c:b0:51c:7547:58e0 with SMTP id d12-20020a056a00198c00b0051c754758e0mr22239590pfl.82.1655700181896;
        Sun, 19 Jun 2022 21:43:01 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id h2-20020a170902f70200b0015e8d4eb231sm7527303plo.123.2022.06.19.21.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 21:43:01 -0700 (PDT)
Date:   Mon, 20 Jun 2022 10:12:51 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     rafael@kernel.org, matthias.bgg@gmail.com,
        rex-bc.chen@mediatek.com, jia-wei.chang@mediatek.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2] cpufreq: Add MT8186 to cpufreq-dt-platdev blocklist
Message-ID: <20220620044251.ice5qcuw26utmups@vireshk-i7>
References: <20220617110926.90313-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220617110926.90313-1-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 17-06-22, 13:09, AngeloGioacchino Del Regno wrote:
> This SoC shall use the mediatek-cpufreq driver, or the system will
> crash upon any clock scaling request: add it to the cpufreq-dt-platdev
> blocklist.
> 
> Fixes: 39b360102f3a ("cpufreq: mediatek: Add support for MT8186")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> ---
> 
> v2: Moved fixes tag on top of SoB (oops!), added Matthias' R-b
> 
>  drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index 96de1536e1cb..2c96de3f2d83 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -127,6 +127,7 @@ static const struct of_device_id blocklist[] __initconst = {
>  	{ .compatible = "mediatek,mt8173", },
>  	{ .compatible = "mediatek,mt8176", },
>  	{ .compatible = "mediatek,mt8183", },
> +	{ .compatible = "mediatek,mt8186", },
>  	{ .compatible = "mediatek,mt8365", },
>  	{ .compatible = "mediatek,mt8516", },

Applied. Thanks.

-- 
viresh

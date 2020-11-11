Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C99C2AF6D7
	for <lists+linux-pm@lfdr.de>; Wed, 11 Nov 2020 17:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbgKKQrV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Nov 2020 11:47:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726849AbgKKQrT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Nov 2020 11:47:19 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF87C0613D6
        for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2020 08:47:18 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id c17so3129806wrc.11
        for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2020 08:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=iFsaSefHhmkCScyFYoknkXxLil5Qp2yw29m3QJALDc0=;
        b=B/+8hOwVHut4qAjEftspH+8vOftFemj7qMkkqsNfSt9PH1QrCUn7bFMuufqiEPYHvf
         CdmPz2mS5JPSwdBBTN3N+khMGnoAGP2AMLWxir+wYUZpoPc8LzHTAHww18QLMHCLtGYB
         WdS1kZXw1Wk0uKOLDhIKppmqhF3IRsIPWNzfTn9bLxl5JmBlg6Q7imM185QgomyT7bns
         goQSjXEEH8X/SURQO3CsKV8CgFklhDx6f8EPYOP2Wn8iCNBG0Nh+SLEoIZhcKXUsGWMQ
         Qy/b3ca3qV3J2XYHhKzCGO+yZLvq7xFp70cyUOg4Cn2HgU4qdJ00TQIkU9tKw04hBuju
         YPXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=iFsaSefHhmkCScyFYoknkXxLil5Qp2yw29m3QJALDc0=;
        b=T6Mhuk3rrMA7slvSfE9wdrLZFU7543V/glVEwklD8z8Kqf6K7SrqhXpXaJ/rPSTVsn
         Zkxz6OioZxniYvjNEB8XfQY4lmkeNP1O6v7fGRPl93z1sV5GUmUHve3A2pD6U0tcrYtU
         8HXND9iPi0UcLECH1W/IKCFpCKDyAJVMzdEPWatQg4dyvueW+nsPXd16OOFw8noDIwu6
         5Bsz+tVzKspzeXHPR/ZOzrBc/Ko54fVs73P1xfd4lNgdeG1NNj+D59grg0m02k1vwldQ
         1xmqQMqYnf0tvNJU29hK0tSTsPJMOcrV+5z+jEjS8AoU2aTTryzEpV2vFn/0e2pXz004
         cPSA==
X-Gm-Message-State: AOAM533LQvGOw/gbEeTxC018yjEwSD6xBvil8071gKKq/Y2Dj+KRFM+X
        +PWT8tcEPUW5BxqTpeD7QoY6Yg==
X-Google-Smtp-Source: ABdhPJzRnnvVYKTjowXa7ib7kM/imqHcA0TsWc1jxSxFSms9DDStsTD9noYghcLYEnaRaNhZGEfe7g==
X-Received: by 2002:adf:ffc3:: with SMTP id x3mr2959101wrs.32.1605113237207;
        Wed, 11 Nov 2020 08:47:17 -0800 (PST)
Received: from dell ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id s4sm3225443wro.10.2020.11.11.08.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 08:47:16 -0800 (PST)
Date:   Wed, 11 Nov 2020 16:47:14 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     sre@kernel.org, matthias.bgg@gmail.com, robh+dt@kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com,
        benjamin.chao@mediatek.com
Subject: Re: [PATCH v6 11/11] mfd: mt6360: Remove MT6360 regulator
 of_compatible attribute
Message-ID: <20201111164714.GR2063125@dell>
References: <1604656432-10215-1-git-send-email-gene.chen.richtek@gmail.com>
 <1604656432-10215-12-git-send-email-gene.chen.richtek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1604656432-10215-12-git-send-email-gene.chen.richtek@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 06 Nov 2020, Gene Chen wrote:

> From: Gene Chen <gene_chen@richtek.com>
> 
> Remove MT6360 regulator of_compatible attribute because
> MFD device should just instantiate the platform device.
> 
> Signed-off-by: Gene Chen <gene_chen@richtek.com>
> ---
>  drivers/mfd/mt6360-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/mt6360-core.c b/drivers/mfd/mt6360-core.c
> index 4bcfa7f..539ab43 100644
> --- a/drivers/mfd/mt6360-core.c
> +++ b/drivers/mfd/mt6360-core.c
> @@ -340,7 +340,7 @@ static const struct mfd_cell mt6360_devs[] = {
>  	OF_MFD_CELL("mt6360-led", mt6360_led_resources,
>  		    NULL, 0, 0, "mediatek,mt6360-led"),
>  	OF_MFD_CELL("mt6360-regulator", mt6360_regulator_resources,
> -		    NULL, 0, 0, "mediatek,mt6360-regulator"),
> +		    NULL, 0, 0, NULL),

If you're no longer providing an OF compatible, you should use one of
the simper helpers.

>  	OF_MFD_CELL("mt6360-tcpc", NULL,
>  		    NULL, 0, 0, "mediatek,mt6360-tcpc"),
>  };

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog

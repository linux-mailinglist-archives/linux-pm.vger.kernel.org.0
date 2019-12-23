Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74BC5129864
	for <lists+linux-pm@lfdr.de>; Mon, 23 Dec 2019 16:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbfLWPmn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Dec 2019 10:42:43 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40955 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbfLWPmm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Dec 2019 10:42:42 -0500
Received: by mail-lj1-f194.google.com with SMTP id u1so18130243ljk.7;
        Mon, 23 Dec 2019 07:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=UfH6R7URisIBJYt/MBDGH5nz2k2vfj6ZWJ4j+/k+CPY=;
        b=JcX2oVN3ptxY2GpvfCvva21mMZF0U/9nHZiLNdZES054N4kY1FycncMmQ/rwOj/BkL
         1nIsIm4YqetOO5Lwr+SmkxRUlFh4evXomIl404VOhD/aG3IjcR3LdiS2ZzLgaDcaphJW
         7Gr0EtkE+aGI7XhN7mYycGl+HUSFvNYWTucr+Vx7bQ/v0Jpbeg+BUT7BvFd104gzVdCt
         T7fX0U9LACPJVbsdN4XKGh178cNa2spcOyu8cN9bGdJ84vYjTZr56AVRQlnoTSV96LB7
         LjkolJ7dzOnp1NcKwdpm3w1o/wsuxNUroOQUGnQQvLgTyA4fH39pCbFC+wrnaH8IMLEE
         s4GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UfH6R7URisIBJYt/MBDGH5nz2k2vfj6ZWJ4j+/k+CPY=;
        b=Adf+c3MDYzApuTL6L+Y/xYBz+vKyDNG44MJV36rN5eZLkMEAKfxwW7Xyr8FZnjqwZ4
         YUAPHanpeJyzH4WNPeCHgwRc/OxSanHWKZwsHcALV1MnGxHC6ZiHCjaQD8jR04UHOsH5
         NrO/y4UWqZGRlqcsXwfn6kkzE+T1myIAEk1QyMKxYG+4IHdSjYiwWt4gMTp38ricxwvf
         JXf5UYxldC/0pqa/EFO8PolSPQxXkl0abucRg1OeXm2SqgctQZQ6LbXk9u+233FF544A
         Qj58WgxrAJUJ88oWKdOkmwMm8vERa1fAJP6fbykLn2/wAd1zKaKSMjuxJoD0cgMtqrdx
         uy4Q==
X-Gm-Message-State: APjAAAXWqbeoSuuG+wMdlbWISZOraHezQLmIdEyOz5tnt3zDykRH4aja
        QN22lkLNyzbsdiKRqszlDsLRVdnz
X-Google-Smtp-Source: APXvYqxPpddbnO1oaHYjYKe79636XT0Af+JvtDZqrCXBmTftfr8pcshxfnvAxMJy3qrn5gr9oinTbQ==
X-Received: by 2002:a2e:974b:: with SMTP id f11mr18478200ljj.173.1577115759073;
        Mon, 23 Dec 2019 07:42:39 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id 21sm6953071ljv.19.2019.12.23.07.42.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Dec 2019 07:42:38 -0800 (PST)
Subject: Re: [PATCH 4/9] memory: tegra: convert to
 devm_platform_ioremap_resource
To:     Yangtao Li <tiny.windzz@gmail.com>, ssantosh@kernel.org,
        paul@crapouillou.net, matthias.bgg@gmail.com, rogerq@ti.com,
        tony@atomide.com, lukasz.luba@arm.com, kgene@kernel.org,
        krzk@kernel.org, thierry.reding@gmail.com, jonathanh@nvidia.com,
        allison@lohutok.net, tglx@linutronix.de, yong.wu@mediatek.com,
        jroedel@suse.de, evgreen@chromium.org, rfontana@redhat.com,
        pdeschrijver@nvidia.com, john@phrozen.org,
        alexios.zavras@intel.com, sboyd@kernel.org,
        kstewart@linuxfoundation.org, info@metux.net,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-tegra@vger.kernel.org
References: <20191222185034.4665-1-tiny.windzz@gmail.com>
 <20191222185034.4665-4-tiny.windzz@gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <04758814-8e22-79b9-8ed1-ac0c31762d21@gmail.com>
Date:   Mon, 23 Dec 2019 18:42:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191222185034.4665-4-tiny.windzz@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

22.12.2019 21:50, Yangtao Li пишет:
> Use devm_platform_ioremap_resource() to simplify code.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/memory/tegra/mc.c           | 4 +---
>  drivers/memory/tegra/tegra124-emc.c | 4 +---
>  drivers/memory/tegra/tegra186.c     | 4 +---
>  drivers/memory/tegra/tegra20-emc.c  | 4 +---
>  4 files changed, 4 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
> index ec8403557ed4..71390d4ad809 100644
> --- a/drivers/memory/tegra/mc.c
> +++ b/drivers/memory/tegra/mc.c
> @@ -593,7 +593,6 @@ static __maybe_unused irqreturn_t tegra20_mc_irq(int irq, void *data)
>  
>  static int tegra_mc_probe(struct platform_device *pdev)
>  {
> -	struct resource *res;
>  	struct tegra_mc *mc;
>  	void *isr;
>  	u64 mask;
> @@ -619,8 +618,7 @@ static int tegra_mc_probe(struct platform_device *pdev)
>  	/* length of MC tick in nanoseconds */
>  	mc->tick = 30;
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	mc->regs = devm_ioremap_resource(&pdev->dev, res);
> +	mc->regs = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(mc->regs))
>  		return PTR_ERR(mc->regs);
>  
> diff --git a/drivers/memory/tegra/tegra124-emc.c b/drivers/memory/tegra/tegra124-emc.c
> index 464f0ceaee63..2c73260654ba 100644
> --- a/drivers/memory/tegra/tegra124-emc.c
> +++ b/drivers/memory/tegra/tegra124-emc.c
> @@ -1085,7 +1085,6 @@ static int tegra_emc_probe(struct platform_device *pdev)
>  	struct platform_device *mc;
>  	struct device_node *np;
>  	struct tegra_emc *emc;
> -	struct resource *res;
>  	u32 ram_code;
>  	int err;
>  
> @@ -1095,8 +1094,7 @@ static int tegra_emc_probe(struct platform_device *pdev)
>  
>  	emc->dev = &pdev->dev;
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	emc->regs = devm_ioremap_resource(&pdev->dev, res);
> +	emc->regs = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(emc->regs))
>  		return PTR_ERR(emc->regs);
>  
> diff --git a/drivers/memory/tegra/tegra186.c b/drivers/memory/tegra/tegra186.c
> index 441213a35930..226d2b16036d 100644
> --- a/drivers/memory/tegra/tegra186.c
> +++ b/drivers/memory/tegra/tegra186.c
> @@ -534,7 +534,6 @@ static const struct tegra_mc_client tegra186_mc_clients[] = {
>  
>  static int tegra186_mc_probe(struct platform_device *pdev)
>  {
> -	struct resource *res;
>  	struct tegra_mc *mc;
>  	unsigned int i;
>  	int err = 0;
> @@ -543,8 +542,7 @@ static int tegra186_mc_probe(struct platform_device *pdev)
>  	if (!mc)
>  		return -ENOMEM;
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	mc->regs = devm_ioremap_resource(&pdev->dev, res);
> +	mc->regs = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(mc->regs))
>  		return PTR_ERR(mc->regs);
>  
> diff --git a/drivers/memory/tegra/tegra20-emc.c b/drivers/memory/tegra/tegra20-emc.c
> index 1b23b1c34476..d2efd0c658c0 100644
> --- a/drivers/memory/tegra/tegra20-emc.c
> +++ b/drivers/memory/tegra/tegra20-emc.c
> @@ -482,7 +482,6 @@ static int tegra_emc_probe(struct platform_device *pdev)
>  {
>  	struct device_node *np;
>  	struct tegra_emc *emc;
> -	struct resource *res;
>  	int irq, err;
>  
>  	/* driver has nothing to do in a case of memory timing absence */
> @@ -518,8 +517,7 @@ static int tegra_emc_probe(struct platform_device *pdev)
>  	if (err)
>  		return err;
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	emc->regs = devm_ioremap_resource(&pdev->dev, res);
> +	emc->regs = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(emc->regs))
>  		return PTR_ERR(emc->regs);
>  
> 

Looks good, thanks!

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>

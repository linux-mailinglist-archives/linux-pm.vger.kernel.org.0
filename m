Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C26114C4F6E
	for <lists+linux-pm@lfdr.de>; Fri, 25 Feb 2022 21:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236381AbiBYUSs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 25 Feb 2022 15:18:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236509AbiBYUSp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 25 Feb 2022 15:18:45 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875E41BB710;
        Fri, 25 Feb 2022 12:18:04 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id i5so8482794oih.1;
        Fri, 25 Feb 2022 12:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dnuBu7FE6HipsCr42q6w6ggScj8iD6Wyz1O+BQagHm0=;
        b=msi/JRuHrAS/pprloEWQ/M3fX5vmXYTBKBuQcopxcjN3RwOg46P0Hcnh2bdDXvY5qA
         Qh59hTvluEVFtmCk2RDsuxv/D9ZiG/cSaJ5c6MBBwPmorA8ANJEWH9UFLiL/X8Wd6fqg
         mMfZfeAkXDDmaYGkEb5SLZBj7/bok4ZzNc3wIsRiRQ9ijb4pIchLhZKERyVOJBpB7Qsu
         l9JFcjZYrAz8BbQPI+JXBURM+D2SsQD3BcYrGESfDB4bmCVXBmPDw8I/LbGRLKL4dHUd
         y3SNSKVS1g/EpDZrzhTC9Mu93rA3RqyidAa6+EhLSeXCS7538Dy0SVeRQo+9gcufF8hq
         pEaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=dnuBu7FE6HipsCr42q6w6ggScj8iD6Wyz1O+BQagHm0=;
        b=1dukX8Fr8/yi9Gq0SpCJBx35LlqnkZlA6HDTVx++VQofRviog5rXObpBUgDrE0MSKH
         szaBBeQV7ri4HFeSHPTXLEHQOw23UCjGMwOmf8gkidM0GvZMQDuEPgWtHdQfdaIXGlAb
         Vz9SMjmRdgEkrwQUYiRl2dJqaWbA8jD9pgR01JeSEYGWrzrIKbPUTyXpWzJ/wuc/0Sfv
         JgeGsm0jVKLphzUeHpXiC0aBcpwhRV+tnLSBzpUI3Q15IrTEUSoM1k0Kz8p5dEgkY/NA
         63kLFdLlhw5dbxIxa7pAgsOnxZU3BnAGYmboO7jG8hTAnAhFYoZy2wt7o0XhzzNiurZJ
         myew==
X-Gm-Message-State: AOAM5324v2K+x76k0+AJBKrpfXOD46sURhnm0yJRLGE4/Soh7BC6dbI4
        tPp5o2IzMjIGPDNqftGWkh8HN/QBawY=
X-Google-Smtp-Source: ABdhPJzjjHRmGjQCbxmJAtB6HQP3wIUJfiZJ+LAitb2bJ45dp5Vb66y+15C/oaz+YmAXK5Z8JCKFwg==
X-Received: by 2002:a05:6808:488:b0:2d4:fb86:6fed with SMTP id z8-20020a056808048800b002d4fb866fedmr2831615oid.133.1645820283503;
        Fri, 25 Feb 2022 12:18:03 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id cz42-20020a05687064aa00b000d6c97027b7sm1634020oab.30.2022.02.25.12.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 12:18:02 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 25 Feb 2022 12:18:00 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org,
        Linux PM list <linux-pm@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v5 3/7] watchdog: rzg2l_wdt: Fix 'BUG: Invalid wait
 context'
Message-ID: <20220225201800.GB2900426@roeck-us.net>
References: <20220225175320.11041-1-biju.das.jz@bp.renesas.com>
 <20220225175320.11041-4-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225175320.11041-4-biju.das.jz@bp.renesas.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Feb 25, 2022 at 05:53:16PM +0000, Biju Das wrote:
> This patch fixes the issue 'BUG: Invalid wait context' during restart()
> callback by using clk_prepare_enable() instead of pm_runtime_get_sync()
> for turning on the clocks during restart.
> 
> This issue is noticed when testing with renesas_defconfig.
> 
> [   42.213802] reboot: Restarting system
> [   42.217860]
> [   42.219364] =============================
> [   42.223368] [ BUG: Invalid wait context ]
> [   42.227372] 5.17.0-rc5-arm64-renesas-00002-g10393723e35e #522 Not tainted
> [   42.234153] -----------------------------
> [   42.238155] systemd-shutdow/1 is trying to lock:
> [   42.242766] ffff00000a650828 (&genpd->mlock){+.+.}-{3:3}, at: genpd_lock_mtx+0x14/0x20
> [   42.250709] other info that might help us debug this:
> [   42.255753] context-{4:4}
> [   42.258368] 2 locks held by systemd-shutdow/1:
> [   42.262806]  #0: ffff80000944e1c8 (system_transition_mutex#2){+.+.}-{3:3}, at: __do_sys_reboot+0xd0/0x250
> [   42.272388]  #1: ffff8000094c4e40 (rcu_read_lock){....}-{1:2}, at: atomic_notifier_call_chain+0x0/0x150
> [   42.281795] stack backtrace:
> [   42.284672] CPU: 0 PID: 1 Comm: systemd-shutdow Not tainted 5.17.0-rc5-arm64-renesas-00002-g10393723e35e #522
> [   42.294577] Hardware name: Renesas SMARC EVK based on r9a07g044c2 (DT)
> [   42.301096] Call trace:
> [   42.303538]  dump_backtrace+0xcc/0xd8
> [   42.307203]  show_stack+0x14/0x30
> [   42.310517]  dump_stack_lvl+0x88/0xb0
> [   42.314180]  dump_stack+0x14/0x2c
> [   42.317492]  __lock_acquire+0x1b24/0x1b50
> [   42.321502]  lock_acquire+0x120/0x3a8
> [   42.325162]  __mutex_lock+0x84/0x8f8
> [   42.328737]  mutex_lock_nested+0x30/0x58
> [   42.332658]  genpd_lock_mtx+0x14/0x20
> [   42.336319]  genpd_runtime_resume+0xc4/0x228
> [   42.340587]  __rpm_callback+0x44/0x170
> [   42.344337]  rpm_callback+0x64/0x70
> [   42.347824]  rpm_resume+0x4e0/0x6b8
> [   42.351310]  __pm_runtime_resume+0x50/0x78
> [   42.355404]  rzg2l_wdt_restart+0x28/0x68
> [   42.359329]  watchdog_restart_notifier+0x1c/0x30
> [   42.363943]  atomic_notifier_call_chain+0x94/0x150
> [   42.368732]  do_kernel_restart+0x24/0x30
> [   42.372652]  machine_restart+0x44/0x70
> [   42.376399]  kernel_restart+0x3c/0x60
> [   42.380058]  __do_sys_reboot+0x228/0x250
> [   42.383977]  __arm64_sys_reboot+0x20/0x28
> [   42.387983]  invoke_syscall+0x40/0xf8
> 
> Fixes: 2cbc5cd0b55fa2 ("watchdog: Add Watchdog Timer driver for RZ/G2L")
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> V4->V5:
>  * Added Rb tag from Geert.
>  * CC'ed Linux PM.
> V4:
>  * New patch
> ---
>  drivers/watchdog/rzg2l_wdt.c | 25 +++++++++++++------------
>  1 file changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/watchdog/rzg2l_wdt.c b/drivers/watchdog/rzg2l_wdt.c
> index 0fc73b8a9567..48dfe6e5e64f 100644
> --- a/drivers/watchdog/rzg2l_wdt.c
> +++ b/drivers/watchdog/rzg2l_wdt.c
> @@ -43,6 +43,8 @@ struct rzg2l_wdt_priv {
>  	struct reset_control *rstc;
>  	unsigned long osc_clk_rate;
>  	unsigned long delay;
> +	struct clk *pclk;
> +	struct clk *osc_clk;
>  };
>  
>  static void rzg2l_wdt_wait_delay(struct rzg2l_wdt_priv *priv)
> @@ -118,7 +120,9 @@ static int rzg2l_wdt_restart(struct watchdog_device *wdev,
>  
>  	/* Reset the module before we modify any register */
>  	reset_control_reset(priv->rstc);
> -	pm_runtime_get_sync(wdev->parent);
> +
> +	clk_prepare_enable(priv->pclk);
> +	clk_prepare_enable(priv->osc_clk);
>  
>  	/* smallest counter value to reboot soon */
>  	rzg2l_wdt_write(priv, WDTSET_COUNTER_VAL(1), WDTSET);
> @@ -165,7 +169,6 @@ static int rzg2l_wdt_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct rzg2l_wdt_priv *priv;
>  	unsigned long pclk_rate;
> -	struct clk *wdt_clk;
>  	int ret;
>  
>  	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> @@ -177,22 +180,20 @@ static int rzg2l_wdt_probe(struct platform_device *pdev)
>  		return PTR_ERR(priv->base);
>  
>  	/* Get watchdog main clock */
> -	wdt_clk = clk_get(&pdev->dev, "oscclk");
> -	if (IS_ERR(wdt_clk))
> -		return dev_err_probe(&pdev->dev, PTR_ERR(wdt_clk), "no oscclk");
> +	priv->osc_clk = devm_clk_get(&pdev->dev, "oscclk");
> +	if (IS_ERR(priv->osc_clk))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(priv->osc_clk), "no oscclk");
>  
> -	priv->osc_clk_rate = clk_get_rate(wdt_clk);
> -	clk_put(wdt_clk);
> +	priv->osc_clk_rate = clk_get_rate(priv->osc_clk);
>  	if (!priv->osc_clk_rate)
>  		return dev_err_probe(&pdev->dev, -EINVAL, "oscclk rate is 0");
>  
>  	/* Get Peripheral clock */
> -	wdt_clk = clk_get(&pdev->dev, "pclk");
> -	if (IS_ERR(wdt_clk))
> -		return dev_err_probe(&pdev->dev, PTR_ERR(wdt_clk), "no pclk");
> +	priv->pclk = devm_clk_get(&pdev->dev, "pclk");
> +	if (IS_ERR(priv->pclk))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(priv->pclk), "no pclk");
>  
> -	pclk_rate = clk_get_rate(wdt_clk);
> -	clk_put(wdt_clk);
> +	pclk_rate = clk_get_rate(priv->pclk);
>  	if (!pclk_rate)
>  		return dev_err_probe(&pdev->dev, -EINVAL, "pclk rate is 0");
>  
> -- 
> 2.17.1
> 

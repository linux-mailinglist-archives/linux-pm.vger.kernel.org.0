Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6815517C65C
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2020 20:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbgCFTdP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Mar 2020 14:33:15 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37024 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbgCFTdO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Mar 2020 14:33:14 -0500
Received: by mail-pl1-f193.google.com with SMTP id b8so1271710plx.4;
        Fri, 06 Mar 2020 11:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=z3KT8EeBZ4kaVLgnDAz4UiYDB1f5ZpcHkzDsT+BdSZk=;
        b=rxSdDrqzraT4uwdK4VFCE5tw55F0ImCJ4F37HWzATRmaxytGqnISM36ath42eIQYyS
         rBxO7a6vHaGFt06R6XSFwSP1nK647qwCkhSGR3uLvqqK0Zl6BgHyntKqbDXBoqlJf96k
         mwsBKxGe3/qFV7x7SqiCwoCNzEaFRucueRUkHjxI/aduFKiKdxl109Pf5SL+vws6BKUK
         +eMM7neFp8TqrDj96iPZM2jdRCKC3rsRpjxGUVUmlbD2WmHYrE+Ns/PpMw6e2BZbL4rF
         kDtclqHTx03ggdYNn8/LVa11NjdycrQMnWIfiK/oLXyIG2vM3XUsWAvm3PMHLW5RPo/O
         WW0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=z3KT8EeBZ4kaVLgnDAz4UiYDB1f5ZpcHkzDsT+BdSZk=;
        b=gCmpp87GTQqwQXl65UfJp9nS9h6YuVB5ivacdhRDBxl1sT5OJJTibJPw3Gq2hbyPvF
         UVEKg3nealg/mUZ92R7jgOOHuPQy3Jv4pJevwMcRVVgQGFjIaZCz5n/uXVF8FcZG3ATK
         lrFbL1s9mXH//6zrIwXZRZ3/qQ3qX7ZGddBqyUTDefn+bGaDDDmcAK1BWT37i/iFuC+Y
         vdWGy5HzjHRY6wDgiw3cavll8qb2Ni7HdYhu6HCF2diO5pJvwWMdc+Nir995GGZq34q4
         8BaOwhL99gVz0qcMWQ7BPgGKFhOhUBC2fkdxTkSO5usnODjv6akYYxYS3JGdYBexNx7k
         ekeg==
X-Gm-Message-State: ANhLgQ0LgpLAN/JIMq4X+5waFi9omsLKILTSrAzuKBEAB0kEqZdChKTd
        q9F0oxyFrLG/DlYPL8dzYcs=
X-Google-Smtp-Source: ADFU+vsT3WVYwhpJooawROdOiTWGvCsUv6cL9HuV5P5d1U/LqQqpNY07JVvpUBPh8/8LLWwZnSFs9Q==
X-Received: by 2002:a17:90a:ef17:: with SMTP id k23mr5138094pjz.139.1583523193162;
        Fri, 06 Mar 2020 11:33:13 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3c2a:73a9:c2cf:7f45])
        by smtp.gmail.com with ESMTPSA id a7sm10093043pjo.11.2020.03.06.11.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 11:33:12 -0800 (PST)
Date:   Fri, 6 Mar 2020 11:33:10 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, amit.kucheria@verdurent.com,
        wim@linux-watchdog.org, linux@roeck-us.net, daniel.baluta@nxp.com,
        linux@rempel-privat.de, gregkh@linuxfoundation.org,
        tglx@linutronix.de, m.felsch@pengutronix.de,
        andriy.shevchenko@linux.intel.com, arnd@arndb.de,
        enric.balletbo@collabora.com, ronald@innovation.ch,
        krzk@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-watchdog@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH 3/5] input: keyboard: add COMPILE_TEST support for
 KEYBOARD_IMX_SC_KEY
Message-ID: <20200306193310.GI217608@dtor-ws>
References: <1583509356-8265-1-git-send-email-Anson.Huang@nxp.com>
 <1583509356-8265-3-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583509356-8265-3-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Mar 06, 2020 at 11:42:34PM +0800, Anson Huang wrote:
> Add COMPILE_TEST support to i.MX SC keyboard driver for better compile
> testing coverage.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thank you.

> ---
>  drivers/input/keyboard/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
> index 4706ff0..81e26f6 100644
> --- a/drivers/input/keyboard/Kconfig
> +++ b/drivers/input/keyboard/Kconfig
> @@ -467,7 +467,7 @@ config KEYBOARD_IMX
>  
>  config KEYBOARD_IMX_SC_KEY
>  	tristate "IMX SCU Key Driver"
> -	depends on IMX_SCU
> +	depends on IMX_SCU || COMPILE_TEST
>  	help
>  	  This is the system controller key driver for NXP i.MX SoCs with
>  	  system controller inside.
> -- 
> 2.7.4
> 

-- 
Dmitry

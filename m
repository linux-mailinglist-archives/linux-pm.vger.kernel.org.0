Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9087A4C286C
	for <lists+linux-pm@lfdr.de>; Thu, 24 Feb 2022 10:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232950AbiBXJqJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Feb 2022 04:46:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232105AbiBXJqI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Feb 2022 04:46:08 -0500
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A1A27DF33;
        Thu, 24 Feb 2022 01:45:39 -0800 (PST)
Received: by mail-ua1-f48.google.com with SMTP id 4so631069uaf.0;
        Thu, 24 Feb 2022 01:45:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+lUFsauCON4uBivZiDW6aBreXALMZIV7erNXYGtZ9bM=;
        b=IPT1h4tfmsYFiyG5KoTdbMlwPehEs6riA+GuVGmtDP7Ea5GIiUSsncifR1JSn16Gvz
         P2oN83HZMB0LeblrfUwRxBQffEzKYpVlC93Hm8XnVn0ZD4nbu2dMube+lHSzOk7ENsrC
         uIYzetkkzROJlxcUb+j2YbOF6His3MTDEQRYl1f5nRCl/AYFlW2IM+tZFZr9WWNe+2Kz
         bFoO25wz4QpE8iP63nDOXif33Hc3YWai8tQH2l8nY7P2d9F4sxdODc1zMXyh61o3OiQm
         rGG4njC9pPRmuqOmV7011jNXiofVuEVRzxH8cresm9bZtDR0EB1gb8wYlxU2LSY0onBN
         Wimw==
X-Gm-Message-State: AOAM533Eeg8i9OTIZS7TmGMphpaF2Jem0WD6lyvIHzKatuMQszMa4QQc
        Z/D+jquUw15m3rtPvqp9PlL54J/DNU3ogw==
X-Google-Smtp-Source: ABdhPJzZeG4Hge21dDOd4Yfdip2ErudvA9DQP97j3Lu/1PV/h/y1P9hYJETU2AOg3SZFRtf7cQaNQA==
X-Received: by 2002:ab0:6486:0:b0:343:2539:6e23 with SMTP id p6-20020ab06486000000b0034325396e23mr750271uam.38.1645695938416;
        Thu, 24 Feb 2022 01:45:38 -0800 (PST)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com. [209.85.217.49])
        by smtp.gmail.com with ESMTPSA id s13sm302758vsk.7.2022.02.24.01.45.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Feb 2022 01:45:38 -0800 (PST)
Received: by mail-vs1-f49.google.com with SMTP id d11so1499896vsm.5;
        Thu, 24 Feb 2022 01:45:38 -0800 (PST)
X-Received: by 2002:a05:6102:4411:b0:31b:6df1:3b80 with SMTP id
 df17-20020a056102441100b0031b6df13b80mr756933vsb.5.1645695937899; Thu, 24 Feb
 2022 01:45:37 -0800 (PST)
MIME-Version: 1.0
References: <20220223160100.23543-1-biju.das.jz@bp.renesas.com> <20220223160100.23543-4-biju.das.jz@bp.renesas.com>
In-Reply-To: <20220223160100.23543-4-biju.das.jz@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 24 Feb 2022 10:45:26 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX9bzHQJb=w6qcLqB2Lzf6mvL1Bkjzdut+xcPqkxiwr9Q@mail.gmail.com>
Message-ID: <CAMuHMdX9bzHQJb=w6qcLqB2Lzf6mvL1Bkjzdut+xcPqkxiwr9Q@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] watchdog: rzg2l_wdt: Fix 'BUG: Invalid wait context'
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Biju,

CC linux-pm

On Wed, Feb 23, 2022 at 5:01 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
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

> Fixes: 2cbc5cd0b55fa2 ("watchdog: Add Watchdog Timer driver for RZ/G2L")
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Thanks for your patch!

> --- a/drivers/watchdog/rzg2l_wdt.c
> +++ b/drivers/watchdog/rzg2l_wdt.c

> @@ -118,7 +120,9 @@ static int rzg2l_wdt_restart(struct watchdog_device *wdev,
>
>         /* Reset the module before we modify any register */
>         reset_control_reset(priv->rstc);
> -       pm_runtime_get_sync(wdev->parent);
> +
> +       clk_prepare_enable(priv->pclk);
> +       clk_prepare_enable(priv->osc_clk);

I'm not super-happy with this circumvention of Runtime PM, but I
don't see a better option, so
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

PM: Is there a better option?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

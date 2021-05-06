Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA76374EB6
	for <lists+linux-pm@lfdr.de>; Thu,  6 May 2021 06:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232696AbhEFEwQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 6 May 2021 00:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbhEFEwP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 6 May 2021 00:52:15 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A50DC061574;
        Wed,  5 May 2021 21:51:17 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id r26-20020a056830121ab02902a5ff1c9b81so3806584otp.11;
        Wed, 05 May 2021 21:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BkR8EzMQJSRdUTCzoWgn3x8ok1vavL42w7HcwP25SNc=;
        b=AKS72qspds8ZGn6uyQ758fmEadTumeLpLvpwTPI2aGoyZViv4xqGFRghS9ylyVbYZh
         stktQwWC2RvQY1cde0m5Fas2rdCCT0MXQ39vHFrgWqyOaU3y8pPQUZTed31DOIBy0I6l
         cdOxXjNjWyd58FF/mk6WKVLbE82dnn5t4YTwX4moqntGyUJ2eyRjnJe/bOF1lmuOOWiZ
         zzOK65+PCOQMLYL0lOM/D8PoqmGOslwyEjnmiHMlKLpt5u1TtipMimZEbDgzwdO6EIi8
         AqmXvQm2gjgXTHhg84OhGtDfhKJFNhJjN4cVt1PV3HhPM85Yyv0aBujyShD1cfEI+k2t
         rC4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=BkR8EzMQJSRdUTCzoWgn3x8ok1vavL42w7HcwP25SNc=;
        b=enkP7Fg20TxbGw2PoLB1R+lXrJ3TnTLzf5uA6+0VAgJgsZImjjML2liuD+A7d/cjg7
         dmS1lqOLyVWlk/VsViAuFS+9wiI8oUe03+p25AHfMsUobCeZktG3rpJ1jIYyZ6OtdmbU
         lVNel00WpMgNFivok550l17uYkV2Z6412IcEkvsc9CXFlU2kbgpWAjYs205ZSyspDOzw
         hb2ZdBAPbUJnBZ5AeagjEWFjTYpIM/p9UAMas3PIADEQnuMv1X/USzSIVU883Nnd1h8M
         9GPrnkALa+fphiLf9rEng8XRhemE5+9Fg3JnWypCYTR6d64UNUamBLtWkLDu8Ksf3tPj
         LuWQ==
X-Gm-Message-State: AOAM530wlL4UGdMf3hyoGU4oGqhvkXbmmafTjrP4iJ8EZASH2nqd8U5g
        Sm0jSn0k9UvZFuHDU1ezxTU=
X-Google-Smtp-Source: ABdhPJy9PNmpSVm6f5o/j9WfXm1EkTWXxyRg3ZZdfU7fedQjxTyCpUl8W0IJgannFMMAVJWw4xbH2A==
X-Received: by 2002:a05:6830:1150:: with SMTP id x16mr1965608otq.294.1620276676992;
        Wed, 05 May 2021 21:51:16 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p1sm366549otk.58.2021.05.05.21.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 21:51:16 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 5 May 2021 21:51:15 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Roger Lu <roger.lu@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Boichat <drinkcat@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Fan Chen <fan.chen@mediatek.com>,
        HenryC Chen <HenryC.Chen@mediatek.com>,
        YT Lee <yt.lee@mediatek.com>,
        Xiaoqing Liu <Xiaoqing.Liu@mediatek.com>,
        Charles Yang <Charles.Yang@mediatek.com>,
        Angus Lin <Angus.Lin@mediatek.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v16 3/7] soc: mediatek: SVS: introduce MTK SVS engine
Message-ID: <20210506045115.GA767398@roeck-us.net>
References: <20210428065440.3704-1-roger.lu@mediatek.com>
 <20210428065440.3704-4-roger.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210428065440.3704-4-roger.lu@mediatek.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Apr 28, 2021 at 02:54:36PM +0800, Roger Lu wrote:
> The Smart Voltage Scaling(SVS) engine is a piece of hardware
> which calculates suitable SVS bank voltages to OPP voltage table.
> Then, DVFS driver could apply those SVS bank voltages to PMIC/Buck
> when receiving OPP_EVENT_ADJUST_VOLTAGE.
> 
> Signed-off-by: Roger Lu <roger.lu@mediatek.com>
> ---
>  drivers/soc/mediatek/Kconfig   |   10 +
>  drivers/soc/mediatek/Makefile  |    1 +
>  drivers/soc/mediatek/mtk-svs.c | 1723 ++++++++++++++++++++++++++++++++
>  3 files changed, 1734 insertions(+)
>  create mode 100644 drivers/soc/mediatek/mtk-svs.c
> 
[ ... ]

> +
> +	svsp_irq = irq_of_parse_and_map(svsp->dev->of_node, 0);
> +	ret = devm_request_threaded_irq(svsp->dev, svsp_irq, NULL, svs_isr,
> +					svsp->irqflags, svsp->name, svsp);

0-day reports:

drivers/soc/mediatek/mtk-svs.c:1663:7-32: ERROR:
	Threaded IRQ with no primary handler requested without IRQF_ONESHOT

I would be a bit concerned about this. There is no primary (hard)
interrupt handler, meaning the hard interrupt may be re-enabled after
the default hard interrupt handler runs. This might result in endless
interrupts.

Guenter

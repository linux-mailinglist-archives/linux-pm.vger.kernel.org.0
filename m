Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66C7CA5343
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2019 11:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730233AbfIBJrG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Sep 2019 05:47:06 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52734 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729831AbfIBJrF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Sep 2019 05:47:05 -0400
Received: by mail-wm1-f67.google.com with SMTP id t17so13812598wmi.2
        for <linux-pm@vger.kernel.org>; Mon, 02 Sep 2019 02:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=d0Fmd8+tPhsncECjkpyfN40FKyAZ9dwp7GhgzrHppXE=;
        b=qVngIIwui1J9tByelwV/mGZbVHFBFHyDB8d+zUgLu3YBU/pt2PyBLaNu6aJVP3PZu+
         ihkRHhUgNreGoIsCbkx1FNEXIz6W3YzxsPtykCOFZra1Ph5YrfDGBk5pUhNPXnyQhdOw
         D9ABWajSIFLGxjIDL3ZgE8fjcP4o/qvxAq8ScG/ooH2FuTnduj/fyZWm7jHaTjH42E/D
         Ei0dGMTfBr8owiAqXxN0DezEgPDMt9Z1EvGzVnLLyrgPVWZ3lXxJ9oZIffCqMvqKZt1l
         C76KOLTdO84oTFmQbF26UtdsQg6gT2TxP7R0Ue3uQ2+bt919+f7rtplpS6l1WtkiwEYy
         +qOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=d0Fmd8+tPhsncECjkpyfN40FKyAZ9dwp7GhgzrHppXE=;
        b=Hz7ovyMdGTN/9chzACI/GcCEcArrQdXI4/EChss2azFyLvNsAW6rmNCIP8hwgHNNhX
         Ono3bhWgqxhJ27F1AXyNcAJ4xBc8NRfEtg5E6Z65lUU4RKkIrEvVxHEYlqkhf6bPehvu
         zQsF3LvrWTkzA+6PfDIdmZuntp7aIxCE/rWN6c3AKatw+PTSty9eBik6wVabN7nZKrEi
         g5E62YRvHKSn/rdrQBk/eUl+///jfBXNpFOw25tgVCSlyQM2jKj4UnVvvBApiSr+EO3c
         79jY4c0HezdVmXqlIEF8t05gt3zPZW5LXGA+oxqJPJ9Tgzh84OGAlCW1wJXB2F19oWpg
         cj5g==
X-Gm-Message-State: APjAAAUB1rN02IyZi3lqD9AlqZaf7kkoXgUkanJgXX1YTjLtq8wsFiEx
        FO+U6VejiwxRT/RoBLEeBhJ6dc7mtc8y3A==
X-Google-Smtp-Source: APXvYqzpAmIdXWUOa0YAoYYeALNbgpYYaMFH/Rih64cJ0rC02eyJ+NoygykybAEJqvvgTgzMlJYBEA==
X-Received: by 2002:a1c:f106:: with SMTP id p6mr31938241wmh.148.1567417622917;
        Mon, 02 Sep 2019 02:47:02 -0700 (PDT)
Received: from dell ([95.147.198.93])
        by smtp.gmail.com with ESMTPSA id b18sm18199417wro.34.2019.09.02.02.47.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Sep 2019 02:47:02 -0700 (PDT)
Date:   Mon, 2 Sep 2019 10:47:00 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        "linux-arm-kernel @ lists . infradead . org Alessandro Zummo" 
        <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Josef Friedl <josef.friedl@speed.at>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Sebastian Reichel <sre@kernel.org>,
        Tianping Fang <tianping.fang@mediatek.com>
Subject: Re: [PATCH v6 05/13] rtc: mt6397: move some common definitions into
 rtc.h
Message-ID: <20190902094700.GS32232@dell>
References: <20190818135611.7776-1-frank-w@public-files.de>
 <20190818135611.7776-6-frank-w@public-files.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190818135611.7776-6-frank-w@public-files.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, 18 Aug 2019, Frank Wunderlich wrote:

> From: Josef Friedl <josef.friedl@speed.at>
> 
> move code to separate header-file to reuse definitions later
> in poweroff-driver (drivers/power/reset/mt6323-poweroff.c)
> 
> Suggested-by: Frank Wunderlich <frank-w@public-files.de>
> Signed-off-by: Josef Friedl <josef.friedl@speed.at>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
> changes since v5: none
> changes since v4: none
> changes since v3: none
> changes since v2: add missing commit-message
> ---
>  drivers/rtc/rtc-mt6397.c       | 55 +-------------------------
>  include/linux/mfd/mt6397/rtc.h | 71 ++++++++++++++++++++++++++++++++++
>  2 files changed, 72 insertions(+), 54 deletions(-)
>  create mode 100644 include/linux/mfd/mt6397/rtc.h
> 
> diff --git a/drivers/rtc/rtc-mt6397.c b/drivers/rtc/rtc-mt6397.c
> index b46ed4dc7015..c08ee5edf865 100644
> --- a/drivers/rtc/rtc-mt6397.c
> +++ b/drivers/rtc/rtc-mt6397.c
> @@ -9,60 +9,7 @@
>  #include <linux/module.h>
>  #include <linux/regmap.h>
>  #include <linux/rtc.h>
> -#include <linux/irqdomain.h>
> -#include <linux/platform_device.h>
> -#include <linux/of_address.h>
> -#include <linux/of_irq.h>
> -#include <linux/io.h>
> -#include <linux/mfd/mt6397/core.h>
> -
> -#define RTC_BBPU		0x0000
> -#define RTC_BBPU_CBUSY		BIT(6)
> -
> -#define RTC_WRTGR		0x003c
> -
> -#define RTC_IRQ_STA		0x0002
> -#define RTC_IRQ_STA_AL		BIT(0)
> -#define RTC_IRQ_STA_LP		BIT(3)
> -
> -#define RTC_IRQ_EN		0x0004
> -#define RTC_IRQ_EN_AL		BIT(0)
> -#define RTC_IRQ_EN_ONESHOT	BIT(2)
> -#define RTC_IRQ_EN_LP		BIT(3)
> -#define RTC_IRQ_EN_ONESHOT_AL	(RTC_IRQ_EN_ONESHOT | RTC_IRQ_EN_AL)
> -
> -#define RTC_AL_MASK		0x0008
> -#define RTC_AL_MASK_DOW		BIT(4)
> -
> -#define RTC_TC_SEC		0x000a
> -/* Min, Hour, Dom... register offset to RTC_TC_SEC */
> -#define RTC_OFFSET_SEC		0
> -#define RTC_OFFSET_MIN		1
> -#define RTC_OFFSET_HOUR		2
> -#define RTC_OFFSET_DOM		3
> -#define RTC_OFFSET_DOW		4
> -#define RTC_OFFSET_MTH		5
> -#define RTC_OFFSET_YEAR		6
> -#define RTC_OFFSET_COUNT	7
> -
> -#define RTC_AL_SEC		0x0018
> -
> -#define RTC_PDN2		0x002e
> -#define RTC_PDN2_PWRON_ALARM	BIT(4)
> -
> -#define RTC_MIN_YEAR		1968
> -#define RTC_BASE_YEAR		1900
> -#define RTC_NUM_YEARS		128
> -#define RTC_MIN_YEAR_OFFSET	(RTC_MIN_YEAR - RTC_BASE_YEAR)
> -
> -struct mt6397_rtc {
> -	struct device		*dev;
> -	struct rtc_device	*rtc_dev;
> -	struct mutex		lock;
> -	struct regmap		*regmap;
> -	int			irq;
> -	u32			addr_base;
> -};
> +#include <linux/mfd/mt6397/rtc.h>
>  
>  static int mtk_rtc_write_trigger(struct mt6397_rtc *rtc)
>  {
> diff --git a/include/linux/mfd/mt6397/rtc.h b/include/linux/mfd/mt6397/rtc.h
> new file mode 100644
> index 000000000000..b702c29e8c74
> --- /dev/null
> +++ b/include/linux/mfd/mt6397/rtc.h
> @@ -0,0 +1,71 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2014-2018 MediaTek Inc.

This is out of date.

Once corrected, please apply my:

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE9A198D24
	for <lists+linux-pm@lfdr.de>; Tue, 31 Mar 2020 09:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730011AbgCaHjI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 31 Mar 2020 03:39:08 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:42905 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729989AbgCaHjH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Mar 2020 03:39:07 -0400
Received: by mail-vs1-f68.google.com with SMTP id s10so12819393vsi.9
        for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2020 00:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mf4BvDmC+BGalJU9mD8gdNB8rFbbjrC+WqY4Crh0V9U=;
        b=Dmi4tPnjWtoexjKLMIWqLDO5lCj3eQdHzUN071JAVkhCTGW2dViDrf3zad75bGYIPc
         d0tqnzqL8Bj8qwzVlVzHOjntDEyZw9VhRwUYwJur//Tfk8ueGnJdlsdF2P4u2IE6rzEw
         5vzDSI7EvnvF1qwMf1GqeACswRLGjCYk2lItk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mf4BvDmC+BGalJU9mD8gdNB8rFbbjrC+WqY4Crh0V9U=;
        b=gaIA/IOnXBSRacrugNGrjsr9xs4cHHeoRKYjkt69sjTnvn41H+9/to1R5Rb9tyX2yI
         ufUDp5kt87epdpisna9poHyo2Np9sMcU3O/e/dH2yeBKsIjRRtGR6ZIUORtno1WRCmvO
         /pd4ALsUoSZruWauZMBjTUNEpS36gdxTbBq4oRpe3xQxNwNyHdXE4hSJcXGV5cui2xmG
         Lk6F8pG2CTR6tKcipaHtjZYFsCMNPtYuhLfWKYwpkc2jug1/ZNzpyZPoLiBSGQoa+dmc
         DJUCKBExJ0uFxJZxYj/xHhhV6UEDghnm6TeJXQ1GPaXu6aTm3/ybNp4AQtgUqgPUz1AJ
         PDgw==
X-Gm-Message-State: AGi0PuZk+VnCqaT+glInYCkAuFk0Eqqn2Yp/DPXz0AxJMcIFwYhjB4Qc
        YQaPjPLPNC+6wQFwKZZa2dmrC6iKifEw7W18LSJ5nA==
X-Google-Smtp-Source: APiQypJ8tjSDzNqqzb7QPP0t8s2sSqBWUkMLyEdCd2TJFUnJLO+3bNKncFxIFwNs73XDYJEY31KCmS0oC5Cf+GSpzZw=
X-Received: by 2002:a67:d45:: with SMTP id 66mr10355355vsn.1.1585640346189;
 Tue, 31 Mar 2020 00:39:06 -0700 (PDT)
MIME-Version: 1.0
References: <1585627657-3265-1-git-send-email-hsin-hsiung.wang@mediatek.com> <1585627657-3265-5-git-send-email-hsin-hsiung.wang@mediatek.com>
In-Reply-To: <1585627657-3265-5-git-send-email-hsin-hsiung.wang@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Tue, 31 Mar 2020 15:38:55 +0800
Message-ID: <CANMq1KAT0x7rLeRVQ7uzxSFbq+g_ef_OCAfAVf3dtYySJwYG2Q@mail.gmail.com>
Subject: Re: [PATCH v11 4/5] rtc: mt6397: Add support for the MediaTek MT6358 RTC
To:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Sebastian Reichel <sre@kernel.org>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Richard Fontana <rfontana@redhat.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Josef Friedl <josef.friedl@speed.at>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ran Bi <ran.bi@mediatek.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-rtc@vger.kernel.org,
        srv_heupstream <srv_heupstream@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Mar 31, 2020 at 12:07 PM Hsin-Hsiung Wang
<hsin-hsiung.wang@mediatek.com> wrote:
>
> From: Ran Bi <ran.bi@mediatek.com>
>
> This add support for the MediaTek MT6358 RTC. Driver using
> compatible data to store different RTC_WRTGR address offset.
> This replace RTC_WRTGR to RTC_WRTGR_MT6323 in mt6323-poweroff
> driver which only needed by armv7 CPU without ATF.
>
> Signed-off-by: Ran Bi <ran.bi@mediatek.com>
> Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>

This looks good to me now, thanks.

Reviewed-by: Nicolas Boichat <drinkcat@chromium.org>

> ---
>  drivers/power/reset/mt6323-poweroff.c |  2 +-
>  drivers/rtc/rtc-mt6397.c              | 23 +++++++++++++++++++----
>  include/linux/mfd/mt6397/rtc.h        |  9 ++++++++-
>  3 files changed, 28 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/power/reset/mt6323-poweroff.c b/drivers/power/reset/mt6323-poweroff.c
> index 1caf43d..0532803 100644
> --- a/drivers/power/reset/mt6323-poweroff.c
> +++ b/drivers/power/reset/mt6323-poweroff.c
> @@ -30,7 +30,7 @@ static void mt6323_do_pwroff(void)
>         int ret;
>
>         regmap_write(pwrc->regmap, pwrc->base + RTC_BBPU, RTC_BBPU_KEY);
> -       regmap_write(pwrc->regmap, pwrc->base + RTC_WRTGR, 1);
> +       regmap_write(pwrc->regmap, pwrc->base + RTC_WRTGR_MT6323, 1);
>
>         ret = regmap_read_poll_timeout(pwrc->regmap,
>                                         pwrc->base + RTC_BBPU, val,
> diff --git a/drivers/rtc/rtc-mt6397.c b/drivers/rtc/rtc-mt6397.c
> index cda238d..7f3dfd2 100644
> --- a/drivers/rtc/rtc-mt6397.c
> +++ b/drivers/rtc/rtc-mt6397.c
> @@ -9,6 +9,7 @@
>  #include <linux/mfd/mt6397/core.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
> +#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  #include <linux/rtc.h>
> @@ -20,7 +21,7 @@ static int mtk_rtc_write_trigger(struct mt6397_rtc *rtc)
>         int ret;
>         u32 data;
>
> -       ret = regmap_write(rtc->regmap, rtc->addr_base + RTC_WRTGR, 1);
> +       ret = regmap_write(rtc->regmap, rtc->addr_base + rtc->data->wrtgr, 1);
>         if (ret < 0)
>                 return ret;
>
> @@ -269,6 +270,8 @@ static int mtk_rtc_probe(struct platform_device *pdev)
>         res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>         rtc->addr_base = res->start;
>
> +       rtc->data = of_device_get_match_data(&pdev->dev);
> +
>         rtc->irq = platform_get_irq(pdev, 0);
>         if (rtc->irq < 0)
>                 return rtc->irq;
> @@ -325,10 +328,22 @@ static int mt6397_rtc_resume(struct device *dev)
>  static SIMPLE_DEV_PM_OPS(mt6397_pm_ops, mt6397_rtc_suspend,
>                         mt6397_rtc_resume);
>
> +static const struct mtk_rtc_data mt6358_rtc_data = {
> +       .wrtgr = RTC_WRTGR_MT6358,
> +};
> +
> +static const struct mtk_rtc_data mt6397_rtc_data = {
> +       .wrtgr = RTC_WRTGR_MT6397,
> +};
> +
>  static const struct of_device_id mt6397_rtc_of_match[] = {
> -       { .compatible = "mediatek,mt6323-rtc", },
> -       { .compatible = "mediatek,mt6397-rtc", },
> -       { }
> +       { .compatible = "mediatek,mt6323-rtc",
> +               .data = &mt6397_rtc_data, },
> +       { .compatible = "mediatek,mt6358-rtc",
> +               .data = &mt6358_rtc_data, },
> +       { .compatible = "mediatek,mt6397-rtc",
> +               .data = &mt6397_rtc_data, },
> +       {}
>  };
>  MODULE_DEVICE_TABLE(of, mt6397_rtc_of_match);
>
> diff --git a/include/linux/mfd/mt6397/rtc.h b/include/linux/mfd/mt6397/rtc.h
> index 7dfb63b..6200f3b 100644
> --- a/include/linux/mfd/mt6397/rtc.h
> +++ b/include/linux/mfd/mt6397/rtc.h
> @@ -18,7 +18,9 @@
>  #define RTC_BBPU_CBUSY         BIT(6)
>  #define RTC_BBPU_KEY            (0x43 << 8)
>
> -#define RTC_WRTGR              0x003c
> +#define RTC_WRTGR_MT6358       0x3a
> +#define RTC_WRTGR_MT6397       0x3c
> +#define RTC_WRTGR_MT6323       RTC_WRTGR_MT6397
>
>  #define RTC_IRQ_STA            0x0002
>  #define RTC_IRQ_STA_AL         BIT(0)
> @@ -65,6 +67,10 @@
>  #define MTK_RTC_POLL_DELAY_US  10
>  #define MTK_RTC_POLL_TIMEOUT   (jiffies_to_usecs(HZ))
>
> +struct mtk_rtc_data {
> +       u32                     wrtgr;
> +};
> +
>  struct mt6397_rtc {
>         struct device           *dev;
>         struct rtc_device       *rtc_dev;
> @@ -74,6 +80,7 @@ struct mt6397_rtc {
>         struct regmap           *regmap;
>         int                     irq;
>         u32                     addr_base;
> +       const struct mtk_rtc_data *data;
>  };
>
>  #endif /* _LINUX_MFD_MT6397_RTC_H_ */
> --
> 2.6.4

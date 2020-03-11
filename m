Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44793180E6D
	for <lists+linux-pm@lfdr.de>; Wed, 11 Mar 2020 04:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbgCKDYr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Mar 2020 23:24:47 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:36867 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727591AbgCKDYr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Mar 2020 23:24:47 -0400
Received: by mail-vs1-f65.google.com with SMTP id o24so414680vsp.4
        for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2020 20:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0CaP0wmRgm/BeB7X7G0uC38j94dJCuNhBHwKXDeM8MY=;
        b=CtPgrXa2cnSfiHSesbp0ZgIPKUi/e/8l6UQAKfhwBQeoYmLZENk2RTJeifkVDa4N2f
         6TtIjeG759VrQk6UUS9OiVg5AhhTraLWaiYKRvJawx2Nu8X7hZSWYY36zxVFRzYyC/u9
         CzSzh16ZRuZ92L+OvQ7dIu+0DnNo8kd2T144U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0CaP0wmRgm/BeB7X7G0uC38j94dJCuNhBHwKXDeM8MY=;
        b=KLNTl3SlFDyUjkChaSFpSl33j+ASM1xjFJV6NS0OM0rEQyfVEAYaYZJ2ZjZQ6Yzcfo
         5Mpbsw8fiXB5dlw7WWC3xijFmow0pTG8mEOQ1xuzzcjev/RjtvLP4xr8zQCy9PnLG8/D
         wIzaz5d7cDa/D/WCM5P/E5cfz//rAfwwhf161EOJe85aJDABrXjEvlcblTHCQbWnIbu5
         w/XHCy6mMyyB2hps0NSxUD47lyyjTIrbWbQY7VM0O/kefVd9KzhyN//p1ykgBJxLcy4M
         61DN7OZJMB6Xm5mwpb+xkMEtvCxeOhFpbPRH4HtF/LJKDShYDGhxIUciMe3GxwFIWlbM
         lZkA==
X-Gm-Message-State: ANhLgQ2PK44lY+12h57bfHc+jMHgddU4uwUj1buc4uPxlxp46KyVEEHE
        Q97DNAywXQqcFAOtxplxb9NRvhvL3RJMt/srxzcs5g==
X-Google-Smtp-Source: ADFU+vvzY+bxois87ERnhOsmkCaLgyI2emx+UgxVfcr4o9pfSIalK4aZScMpftN+vS9C9nrgv5qWlZCt5m4WJIdzyeE=
X-Received: by 2002:a67:3201:: with SMTP id y1mr765745vsy.54.1583897084227;
 Tue, 10 Mar 2020 20:24:44 -0700 (PDT)
MIME-Version: 1.0
References: <1583835040-19157-1-git-send-email-hsin-hsiung.wang@mediatek.com> <1583835040-19157-4-git-send-email-hsin-hsiung.wang@mediatek.com>
In-Reply-To: <1583835040-19157-4-git-send-email-hsin-hsiung.wang@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Wed, 11 Mar 2020 11:24:33 +0800
Message-ID: <CANMq1KDF32v-YnFRcz8BT6tnD0yq2OOBy9t-R09yA+4zNUZj3A@mail.gmail.com>
Subject: Re: [PATCH v9 3/5] mfd: Add support for the MediaTek MT6358 PMIC
To:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Sebastian Reichel <sre@kernel.org>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Frank Wunderlich <frank-w@public-files.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Richard Fontana <rfontana@redhat.com>,
        Josef Friedl <josef.friedl@speed.at>,
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

Thanks, much better. Just one issue left.

On Tue, Mar 10, 2020 at 6:10 PM Hsin-Hsiung Wang
<hsin-hsiung.wang@mediatek.com> wrote:
>
> This adds support for the MediaTek MT6358 PMIC. This is a
> multifunction device with the following sub modules:
>
> - Regulator
> - RTC
> - Codec
> - Interrupt
>
> It is interfaced to the host controller using SPI interface
> by a proprietary hardware called PMIC wrapper or pwrap.
> MT6358 MFD is a child device of the pwrap.
>
> Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
> ---
>  drivers/mfd/Makefile                 |   2 +-
>  drivers/mfd/mt6358-irq.c             | 238 +++++++++++++++++++++++++++++
>  drivers/mfd/mt6397-core.c            |  55 ++++++-
>  include/linux/mfd/mt6358/core.h      | 158 ++++++++++++++++++++
>  include/linux/mfd/mt6358/registers.h | 282 +++++++++++++++++++++++++++++++++++
>  include/linux/mfd/mt6397/core.h      |   3 +
>  6 files changed, 733 insertions(+), 5 deletions(-)
>  create mode 100644 drivers/mfd/mt6358-irq.c
>  create mode 100644 include/linux/mfd/mt6358/core.h
>  create mode 100644 include/linux/mfd/mt6358/registers.h
>
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index b83f172..9af1414 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -238,7 +238,7 @@ obj-$(CONFIG_INTEL_SOC_PMIC)        += intel-soc-pmic.o
>  obj-$(CONFIG_INTEL_SOC_PMIC_BXTWC)     += intel_soc_pmic_bxtwc.o
>  obj-$(CONFIG_INTEL_SOC_PMIC_CHTWC)     += intel_soc_pmic_chtwc.o
>  obj-$(CONFIG_INTEL_SOC_PMIC_CHTDC_TI)  += intel_soc_pmic_chtdc_ti.o
> -mt6397-objs    := mt6397-core.o mt6397-irq.o
> +mt6397-objs                    := mt6397-core.o mt6397-irq.o mt6358-irq.o
>  obj-$(CONFIG_MFD_MT6397)       += mt6397.o
>  obj-$(CONFIG_INTEL_SOC_PMIC_MRFLD)     += intel_soc_pmic_mrfld.o
>
> diff --git a/drivers/mfd/mt6358-irq.c b/drivers/mfd/mt6358-irq.c
> new file mode 100644
> index 0000000..0b99a39
> --- /dev/null
> +++ b/drivers/mfd/mt6358-irq.c
> @@ -0,0 +1,238 @@
> [snip]
> +static irqreturn_t mt6358_irq_handler(int irq, void *data)
> +{
> +       struct mt6397_chip *chip = data;
> +       struct pmic_irq_data *mt6358_irq_data = chip->irq_data;
> +       unsigned int bit, i, top_irq_status;
> +       int ret;
> +
> +       ret = regmap_read(chip->regmap,
> +                         mt6358_irq_data->top_int_status_reg,
> +                         &top_irq_status);
> +       if (ret) {
> +               dev_err(chip->dev,
> +                       "Failed to read status from the device, ret=%d\n", ret);
> +               return IRQ_NONE;
> +       }
> +
> +       for (i = 0; i < mt6358_irq_data->num_top; i++) {
> +               for (i = 0; i < mt6358_irq_data->num_top; i++) {

Only one loop needed.

> +                       bit = BIT(mt6358_ints[i].top_offset);
> +                       if (top_irq_status & bit) {
> +                               mt6358_irq_sp_handler(chip, i);
> +                               top_irq_status &= ~bit;
> +                               if (!top_irq_status)
> +                                       break;
> +                       }
> +               }
> +       }
> +
> +       return IRQ_HANDLED;
> +}
> +
> +static int pmic_irq_domain_map(struct irq_domain *d, unsigned int irq,
> +                              irq_hw_number_t hw)
> +{
> +       struct mt6397_chip *mt6397 = d->host_data;
> +
> +       irq_set_chip_data(irq, mt6397);
> +       irq_set_chip_and_handler(irq, &mt6358_irq_chip, handle_level_irq);
> +       irq_set_nested_thread(irq, 1);
> +       irq_set_noprobe(irq);
> +
> +       return 0;
> +}
> [snip]

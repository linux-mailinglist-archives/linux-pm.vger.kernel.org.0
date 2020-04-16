Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8EA1ABC08
	for <lists+linux-pm@lfdr.de>; Thu, 16 Apr 2020 11:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503124AbgDPJCj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Apr 2020 05:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502927AbgDPIsR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Apr 2020 04:48:17 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3255EC061A41
        for <linux-pm@vger.kernel.org>; Thu, 16 Apr 2020 01:48:12 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id u13so3862804wrp.3
        for <linux-pm@vger.kernel.org>; Thu, 16 Apr 2020 01:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=gCC6rxpfNBHEEJoswTl2+v3GlY13e+wv1Apu4C5uUJ0=;
        b=qMyY08os0xXarDJEQ8j9nJU1G/4i1ajvSN1547JGWNAU4kptYy+l0ETyItzmwelvLC
         nCDep5Cl1t95mbiIhlCDcowJNJGFakofRU/UeiPQv049DorrDQDyvOhQ0iXlohLp8hin
         3bAdw+39EFnaQiFiejH+534QfsSXNhMyYx4ZtJs1O8APzJpuT9KiZORIU2xx8m9me3GJ
         nRCzeSz6fhZnRuGUV65gJOj0k8DMrASVs1ffDMfO5wQ+4MKhMzyo1Hf7xWdNJii/ENzy
         uOrTcZOmWLeo1D6phvtKajqfSbjF0JkyzG19tN5chV4GtOZYui9witk4RNmc7L0KIuBW
         GEOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=gCC6rxpfNBHEEJoswTl2+v3GlY13e+wv1Apu4C5uUJ0=;
        b=aUY1C1LMKgSB3HrjWLziiVSg7ltmRM4nsvEsTM0vbnffdeBEBi/eS14DYGz3XbVEJy
         sfWc/vm+d+F7exGYG04KtB1TAvUhXaK/Xz91l+lLoriJJrMldKcp0rFWW7d0i3sZpcFd
         VME6u6hfQUjMO4JBEtAKdh0FStPWkwaAA3Ux9/frEyhdpMRoeEhohEViTx4ys1jgqrD+
         Xmba63h23ciwTbF6X8BDMhKCK3DXFK7bTCbR9NVy16Yf4+aDtMeH65HikkRIvrLpu+TB
         vU1iusaK/426+0acXxP0EYxZhEHdJlPjFa2lj8X3/nj4DJ2YOJRd0hLWR2vfxnKFVSTH
         qWeg==
X-Gm-Message-State: AGi0PuYIs166MqObkGANwbWwprD57z+5sRQiJ9Xf2jCXvEV36eILlnYb
        6UWgHJ4Uci5Y7phrla/3PfTv8Q==
X-Google-Smtp-Source: APiQypLyhDVW4E+VOlBHWErivAdlGrtxixDqwonOAkbRNQamJnKVsV0vJKLtvSLryabLtX0HhH0tLg==
X-Received: by 2002:a5d:4286:: with SMTP id k6mr21252278wrq.222.1587026890846;
        Thu, 16 Apr 2020 01:48:10 -0700 (PDT)
Received: from dell ([95.149.164.124])
        by smtp.gmail.com with ESMTPSA id z15sm14429845wrs.47.2020.04.16.01.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 01:48:10 -0700 (PDT)
Date:   Thu, 16 Apr 2020 09:49:10 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
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
        Ran Bi <ran.bi@mediatek.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
        srv_heupstream@mediatek.com
Subject: Re: [PATCH v12 1/6] mfd: mt6397: Modify suspend/resume behavior
Message-ID: <20200416084910.GX2167633@dell>
References: <1586333531-21641-1-git-send-email-hsin-hsiung.wang@mediatek.com>
 <1586333531-21641-2-git-send-email-hsin-hsiung.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1586333531-21641-2-git-send-email-hsin-hsiung.wang@mediatek.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 08 Apr 2020, Hsin-Hsiung Wang wrote:

> Some pmics don't need backup interrupt settings, so we change to use
> pm notifier for the pmics which are necessary to store settings.
> 
> Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
> ---
>  drivers/mfd/mt6397-core.c       | 30 ------------------------------
>  drivers/mfd/mt6397-irq.c        | 35 ++++++++++++++++++++++++++++++++++-
>  include/linux/mfd/mt6397/core.h |  2 ++
>  3 files changed, 36 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
> index 0437c85..d2e70d8 100644
> --- a/drivers/mfd/mt6397-core.c
> +++ b/drivers/mfd/mt6397-core.c
> @@ -100,35 +100,6 @@ static const struct mfd_cell mt6397_devs[] = {
>  	}
>  };
>  
> -#ifdef CONFIG_PM_SLEEP
> -static int mt6397_irq_suspend(struct device *dev)
> -{
> -	struct mt6397_chip *chip = dev_get_drvdata(dev);
> -
> -	regmap_write(chip->regmap, chip->int_con[0], chip->wake_mask[0]);
> -	regmap_write(chip->regmap, chip->int_con[1], chip->wake_mask[1]);
> -
> -	enable_irq_wake(chip->irq);
> -
> -	return 0;
> -}
> -
> -static int mt6397_irq_resume(struct device *dev)
> -{
> -	struct mt6397_chip *chip = dev_get_drvdata(dev);
> -
> -	regmap_write(chip->regmap, chip->int_con[0], chip->irq_masks_cur[0]);
> -	regmap_write(chip->regmap, chip->int_con[1], chip->irq_masks_cur[1]);
> -
> -	disable_irq_wake(chip->irq);
> -
> -	return 0;
> -}
> -#endif
> -
> -static SIMPLE_DEV_PM_OPS(mt6397_pm_ops, mt6397_irq_suspend,
> -			mt6397_irq_resume);
> -
>  struct chip_data {
>  	u32 cid_addr;
>  	u32 cid_shift;
> @@ -238,7 +209,6 @@ static struct platform_driver mt6397_driver = {
>  	.driver = {
>  		.name = "mt6397",
>  		.of_match_table = of_match_ptr(mt6397_of_match),
> -		.pm = &mt6397_pm_ops,
>  	},
>  	.id_table = mt6397_id,
>  };
> diff --git a/drivers/mfd/mt6397-irq.c b/drivers/mfd/mt6397-irq.c
> index b2d3ce1..2924919 100644
> --- a/drivers/mfd/mt6397-irq.c
> +++ b/drivers/mfd/mt6397-irq.c
> @@ -9,6 +9,7 @@
>  #include <linux/of_irq.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
> +#include <linux/suspend.h>
>  #include <linux/mfd/mt6323/core.h>
>  #include <linux/mfd/mt6323/registers.h>
>  #include <linux/mfd/mt6397/core.h>
> @@ -81,7 +82,7 @@ static struct irq_chip mt6397_irq_chip = {
>  static void mt6397_irq_handle_reg(struct mt6397_chip *mt6397, int reg,
>  				  int irqbase)
>  {
> -	unsigned int status;
> +	unsigned int status = 0;

This looks like an unrelated change, no?

>  	int i, irq, ret;
>  
>  	ret = regmap_read(mt6397->regmap, reg, &status);
> @@ -128,6 +129,36 @@ static const struct irq_domain_ops mt6397_irq_domain_ops = {
>  	.map = mt6397_irq_domain_map,
>  };

Other than that.

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

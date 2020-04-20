Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE2AB1B0725
	for <lists+linux-pm@lfdr.de>; Mon, 20 Apr 2020 13:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbgDTLP1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Apr 2020 07:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726020AbgDTLP0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Apr 2020 07:15:26 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE3AC061A0C
        for <linux-pm@vger.kernel.org>; Mon, 20 Apr 2020 04:15:26 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id x18so11657581wrq.2
        for <linux-pm@vger.kernel.org>; Mon, 20 Apr 2020 04:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=4uCgchzEKUbGCjVb5ErPQQvp7VtDEqWO3rkjRlf6Z0c=;
        b=Z69BlBZc3+yIjY+OiSNwt8bsyBI0gsYDwMfdiucsDa5C+MKP/wOJquAOhh0jY8LvP8
         DrypNHoQ8098wugctLVFMem6rV1KysE9rL4PQbw9dgV9IX4vzDo8vaR3IolrnwdZnlue
         oiYWMkYalyjVcjm2bEgoiKKZoPYWWSYOSW2mlfPKPx+R10IJHuVAXZKI+CMv1NXjZwBe
         4ApmE0F3A3wQai4D9aDrDuXakAc3roQsOINa7eE95IHRnzDQ2WMpJIYitHW849I7SOu2
         /WgTnsClHrd3yTWNDwW+tMRpyK1PDxfZIy/Qi+no+uSblRgwH6XmDdXWWcVSG1+c8QGu
         WI1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=4uCgchzEKUbGCjVb5ErPQQvp7VtDEqWO3rkjRlf6Z0c=;
        b=reqsQKsUN9TLoGlJaRYTBpgYQ7hsGoIG/oTEl9Vqapp8/67RUENXj8qLMCwpRtOCUL
         kYNxQISI9cQNvWBsP73/h5cLRZTe7slZucs2nUI+vsxmyxG4tHNbPNFRgnlHlM/gxqIZ
         +miiwoJpmhIt2UCH5aZAFypGss/eqJKElxGvkDbDmNWImpw29kSD1EVB9OAuxDp1fV+R
         BPRAmixScBxGagGpYWZMhvS9HG0bVW/+a6wlaBfZrlKCGR+iBOVb3FNMqvazzcV5xTCB
         Qz6jXX8a1zEbg6YqKzwle0XQ/wGM9ntv3IWbkoV7eXPnPhxAPbGZ38yzD1CRfr+/Zeef
         JjIA==
X-Gm-Message-State: AGi0PuY/W5n5Ww9j/pdo9SDVoHR1RKqcBE47ANS5cqJtecNpewIFlkWH
        iI+IdXn92lyuW/GZt5EQmqtXRg==
X-Google-Smtp-Source: APiQypJhmbeviPbiHBjSOOZlAdECJVyeKqJZLm8MMiKHA1YJPMBCV2InSlX2aY5iSqxkecD8aYWnaQ==
X-Received: by 2002:a5d:5147:: with SMTP id u7mr17746146wrt.290.1587381324902;
        Mon, 20 Apr 2020 04:15:24 -0700 (PDT)
Received: from dell ([95.149.164.107])
        by smtp.gmail.com with ESMTPSA id q143sm969035wme.31.2020.04.20.04.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 04:15:24 -0700 (PDT)
Date:   Mon, 20 Apr 2020 12:15:22 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Hsin-hsiung Wang <hsin-hsiung.wang@mediatek.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org,
        Richard Fontana <rfontana@redhat.com>,
        linux-rtc@vger.kernel.org, Nicolas Boichat <drinkcat@chromium.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        Frank Wunderlich <frank-w@public-files.de>,
        Ran Bi <ran.bi@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eddie Huang <eddie.huang@mediatek.com>,
        linux-arm-kernel@lists.infradead.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Josef Friedl <josef.friedl@speed.at>,
        srv_heupstream@mediatek.com, Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v12 1/6] mfd: mt6397: Modify suspend/resume behavior
Message-ID: <20200420111522.GB3612@dell>
References: <1586333531-21641-1-git-send-email-hsin-hsiung.wang@mediatek.com>
 <1586333531-21641-2-git-send-email-hsin-hsiung.wang@mediatek.com>
 <20200416084910.GX2167633@dell>
 <1587379959.6297.2.camel@mtksdaap41>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1587379959.6297.2.camel@mtksdaap41>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 20 Apr 2020, Hsin-hsiung Wang wrote:

> Hi,
> 
> On Thu, 2020-04-16 at 09:49 +0100, Lee Jones wrote:
> > On Wed, 08 Apr 2020, Hsin-Hsiung Wang wrote:
> > 
> > > Some pmics don't need backup interrupt settings, so we change to use
> > > pm notifier for the pmics which are necessary to store settings.
> > > 
> > > Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
> > > ---
> > >  drivers/mfd/mt6397-core.c       | 30 ------------------------------
> > >  drivers/mfd/mt6397-irq.c        | 35 ++++++++++++++++++++++++++++++++++-
> > >  include/linux/mfd/mt6397/core.h |  2 ++
> > >  3 files changed, 36 insertions(+), 31 deletions(-)
> > > 
> > > diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
> > > index 0437c85..d2e70d8 100644
> > > --- a/drivers/mfd/mt6397-core.c
> > > +++ b/drivers/mfd/mt6397-core.c
> > > @@ -100,35 +100,6 @@ static const struct mfd_cell mt6397_devs[] = {
> > >  	}
> > >  };
> > >  
> > > -#ifdef CONFIG_PM_SLEEP
> > > -static int mt6397_irq_suspend(struct device *dev)
> > > -{
> > > -	struct mt6397_chip *chip = dev_get_drvdata(dev);
> > > -
> > > -	regmap_write(chip->regmap, chip->int_con[0], chip->wake_mask[0]);
> > > -	regmap_write(chip->regmap, chip->int_con[1], chip->wake_mask[1]);
> > > -
> > > -	enable_irq_wake(chip->irq);
> > > -
> > > -	return 0;
> > > -}
> > > -
> > > -static int mt6397_irq_resume(struct device *dev)
> > > -{
> > > -	struct mt6397_chip *chip = dev_get_drvdata(dev);
> > > -
> > > -	regmap_write(chip->regmap, chip->int_con[0], chip->irq_masks_cur[0]);
> > > -	regmap_write(chip->regmap, chip->int_con[1], chip->irq_masks_cur[1]);
> > > -
> > > -	disable_irq_wake(chip->irq);
> > > -
> > > -	return 0;
> > > -}
> > > -#endif
> > > -
> > > -static SIMPLE_DEV_PM_OPS(mt6397_pm_ops, mt6397_irq_suspend,
> > > -			mt6397_irq_resume);
> > > -
> > >  struct chip_data {
> > >  	u32 cid_addr;
> > >  	u32 cid_shift;
> > > @@ -238,7 +209,6 @@ static struct platform_driver mt6397_driver = {
> > >  	.driver = {
> > >  		.name = "mt6397",
> > >  		.of_match_table = of_match_ptr(mt6397_of_match),
> > > -		.pm = &mt6397_pm_ops,
> > >  	},
> > >  	.id_table = mt6397_id,
> > >  };
> > > diff --git a/drivers/mfd/mt6397-irq.c b/drivers/mfd/mt6397-irq.c
> > > index b2d3ce1..2924919 100644
> > > --- a/drivers/mfd/mt6397-irq.c
> > > +++ b/drivers/mfd/mt6397-irq.c
> > > @@ -9,6 +9,7 @@
> > >  #include <linux/of_irq.h>
> > >  #include <linux/platform_device.h>
> > >  #include <linux/regmap.h>
> > > +#include <linux/suspend.h>
> > >  #include <linux/mfd/mt6323/core.h>
> > >  #include <linux/mfd/mt6323/registers.h>
> > >  #include <linux/mfd/mt6397/core.h>
> > > @@ -81,7 +82,7 @@ static struct irq_chip mt6397_irq_chip = {
> > >  static void mt6397_irq_handle_reg(struct mt6397_chip *mt6397, int reg,
> > >  				  int irqbase)
> > >  {
> > > -	unsigned int status;
> > > +	unsigned int status = 0;
> > 
> > This looks like an unrelated change, no?
> > 
> 
> It is to fix the coverity defect.

Which isn't mentioned in the commit log and doesn't have anything to
do with this patch.  Thus it should be in a separate patch, but I'm
not going to lose any sleep over it.

> > >  	int i, irq, ret;
> > >  
> > >  	ret = regmap_read(mt6397->regmap, reg, &status);
> > > @@ -128,6 +129,36 @@ static const struct irq_domain_ops mt6397_irq_domain_ops = {
> > >  	.map = mt6397_irq_domain_map,
> > >  };
> > 
> > Other than that.
> > 
> > For my own reference:
> >   Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> > 
> Thanks for your review. I will add it in the next version.
> 

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

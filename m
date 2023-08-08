Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2D84773D3C
	for <lists+linux-pm@lfdr.de>; Tue,  8 Aug 2023 18:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbjHHQO5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Aug 2023 12:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232176AbjHHQNZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Aug 2023 12:13:25 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFBDC212C
        for <linux-pm@vger.kernel.org>; Tue,  8 Aug 2023 08:47:33 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1bc73a2b0easo13116675ad.0
        for <linux-pm@vger.kernel.org>; Tue, 08 Aug 2023 08:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691509653; x=1692114453;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hpGMNxDDvo9T1v6v+RkICvblRXd4nkGe288y9gyoNGg=;
        b=OMoT8gYdXBR3P4DHHf7l6UARjohyP+3i/vkEzNYanul6tF0OZaGlNGS9BdAY/cAbzn
         4xvtrYw0LV2JAP6ZCJkx0zuRV30d36+WYSqU8SltQ/dSfonAX4/ia7Y6dE+G5cfZZra/
         TMMxycTPwpTtNCTaIF0XqF15MYB3RH5KWO0ere+cQg7qJ67BybLnWDUyQKIsFoo7gvly
         y+XdSNXfCZe06dHIGF/DpMrkP9XGig+7IRxzDfWyv6UCXyZfeyBnBS5Nh8hP01ToMF5K
         2l6NUX4h1LUr4AnOjiqphHr0oIev9CW5o3EsfKKhhFaPt4nxNVkAbc0a4hS6dvtP9FQ1
         uHIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691509653; x=1692114453;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hpGMNxDDvo9T1v6v+RkICvblRXd4nkGe288y9gyoNGg=;
        b=At9MhtUF1SNUNjZ+elP63nNJVr86hlrfwusxIfx1S7OZ0WsgGkKwnGcNTV3vauYkRo
         BPV1Fv2cxwCJn2BxS2Kw/5ogDYlmYtu0feibL7v8Qq+G3DhkbNTIWtztc2E/zZtTSXCq
         jbI2s4np5aMFmBk366Z2OAUm8Yu1+bBX5yMzyXQIQBOgSW90S86GX6dTf8+k7JumWaFQ
         shwFzNkzePq2uJFzjCprHYF5vkwFyzrGu7sl2qR4dJmy1Boe7uM/nlgwnOnoXTymkNrj
         u6JDuUjhzwv/rjZsDqU1YHW6jeWD5BCCLhzh6jkQoS8JmtUPJBCsXdSqobX5xne/p6n7
         f0hA==
X-Gm-Message-State: AOJu0YwxYdqM7fufrcmoOOCHlSaxsG+eLJhXve39xrhjoh/UgTDNEM3d
        UPkFqXFwlq1r5MEVY4/MZYqvUEgUKZUlPInhsUMZBL155cHfagR2
X-Google-Smtp-Source: AGHT+IEQ0B+zFHwu6lwq9ShhqNgqoAUPtqEjQdph6xX3V3JEjoRX0Qpcb7z9XgUddzrDP+CIGW7eIVIsmdM1+EjIYR4=
X-Received: by 2002:a25:df82:0:b0:d47:4ed4:43eb with SMTP id
 w124-20020a25df82000000b00d474ed443ebmr10840010ybg.63.1691505778468; Tue, 08
 Aug 2023 07:42:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230803063703.5659-1-zhuyinbo@loongson.cn> <20230803063703.5659-3-zhuyinbo@loongson.cn>
 <4fef9725-7aea-43fb-b8ef-d20a4c6d9a68@app.fastmail.com>
In-Reply-To: <4fef9725-7aea-43fb-b8ef-d20a4c6d9a68@app.fastmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 8 Aug 2023 16:42:22 +0200
Message-ID: <CAPDyKFo7p=aEWWrW2OGbhN1tFjHanpqjLApzCMipdPSzE+NknQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] soc: loongson2_pm: add power management support
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Yinbo Zhu <zhuyinbo@loongson.cn>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        soc@kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
        wanghongliang@loongson.cn, Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn, loongarch@lists.linux.dev,
        Liu Yun <liuyun@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 3 Aug 2023 at 09:03, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Aug 3, 2023, at 08:37, Yinbo Zhu wrote:
> > The Loongson-2's power management controller was ACPI, supports ACPI
> > S2Idle (Suspend To Idle), ACPI S3 (Suspend To RAM), ACPI S4 (Suspend To
> > Disk), ACPI S5 (Soft Shutdown) and supports multiple wake-up methods
> > (USB, GMAC, PWRBTN, etc.). This driver was to add power management
> > controller support that base on dts for Loongson-2 series SoCs.
> >
> > Co-developed-by: Liu Yun <liuyun@loongson.cn>
> > Signed-off-by: Liu Yun <liuyun@loongson.cn>
> > Co-developed-by: Liu Peibao <liupeibao@loongson.cn>
> > Signed-off-by: Liu Peibao <liupeibao@loongson.cn>
> > Cc: soc@kernel.org
> > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
>
> I'm still waiting for Ulf to take a look here to see whether
> this should be in drivers/genpd instead, but he might still
> be on vacation.

I don't think this belongs in drivers/genpd/ as it's not a genpd
provider. Besides that, no further comments from me at this point.

Kind regards
Uffe

>
> A few minor comments from me in the meantime:
>
> > +#define loongson2_pm_readw(reg)              readw(loongson2_pm.base + reg)
> > +#define loongson2_pm_readl(reg)              readl(loongson2_pm.base + reg)
> > +#define loongson2_pm_writew(val, reg)        writew(val, loongson2_pm.base +
> > reg)
> > +#define loongson2_pm_writel(val, reg)        writel(val, loongson2_pm.base +
> > reg)
>
> I would prefer these to be 'static inline' functions rather than
> macros, or you can just open-code them, as each macro is only
> used once at the moment.
>
> > +static irqreturn_t loongson2_pm_irq_handler(int irq, void *dev_id)
> > +{
> > +     u16 status = loongson2_pm_readw(LOONGSON2_PM1_STS_REG);
> > +
> > +     if (!loongson2_pm.suspended && (status & LOONGSON2_PM1_PWRBTN_STS)) {
> > +             pr_info("Power Button pressed...\n");
>
> The message is probably more appropriate as a pr_debug() than
> pr_info().
>
> > +static int __maybe_unused loongson2_pm_suspend(struct device *dev)
> > +{
> > +     loongson2_pm.suspended = true;
> > +
> > +     return 0;
> > +}
> > +
> > +static int __maybe_unused loongson2_pm_resume(struct device *dev)
> > +{
> > +     loongson2_pm.suspended = false;
> > +
> > +     return 0;
> > +}
> > +static SIMPLE_DEV_PM_OPS(loongson2_pm_ops, loongson2_pm_suspend,
> > loongson2_pm_resume);
>
> Please change this to DEFINE_SIMPLE_DEV_PM_OPS() and remove the
> __maybe_unused, this is what all drivers should have these days.
>
> > +
> > +static int loongson2_pm_probe(struct platform_device *pdev)
> > +{
> > +     int irq, retval;
> > +     u64 suspend_addr;
> > +     struct device *dev = &pdev->dev;
> > +
> > +     loongson2_pm.base = devm_platform_ioremap_resource(pdev, 0);
> > +     if (IS_ERR(loongson2_pm.base))
> > +             return PTR_ERR(loongson2_pm.base);
> > +
> > +     irq = platform_get_irq(pdev, 0);
> > +     if (irq < 0)
> > +             return irq;
> > +
> > +     if (!device_property_read_u64(dev, "loongson,suspend-address",
> > &suspend_addr))
> > +             loongson_sysconf.suspend_addr = (u64)phys_to_virt(suspend_addr);
> > +     else
>
> Having a custom "loongson,suspend-address" property here feels wrong
> to me. Can't this be moved into the "regs" property that holds
> the other mmio registers?
>
>     Arnd

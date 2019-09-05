Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7902AA9A6A
	for <lists+linux-pm@lfdr.de>; Thu,  5 Sep 2019 08:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730844AbfIEGPn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Sep 2019 02:15:43 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:34083 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730809AbfIEGPn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Sep 2019 02:15:43 -0400
Received: by mail-vk1-f193.google.com with SMTP id h192so227473vka.1
        for <linux-pm@vger.kernel.org>; Wed, 04 Sep 2019 23:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lxv2YjVDy5w6AQ+Z95Jd1OHt1865rQWbHzl1H0ckHb4=;
        b=IurRXFpodLHrXjhNeDu0PBjJR6aKmlNT/dzeEONMU1V5mjYfCIsKTQIXkLXspZuRLT
         SO2IeUW73ig0y4hTpIc1LeJScYwe/7jF3x1ItS7fkoJd9YSTWsUH2sI/3COuK4II6o/r
         +Kj20DSoITETteLabp2V7jA4ju9DbWda2nuGTSuEzhZ1KGohbqZEVKqkpRJCAhcLSXD9
         kEdWKNMJEgbkZzacsvDJtyDbgG7jhbcfx/K1U5vEhgoviC+KwrwJF0gUE3d7mSshVMHg
         A0LYcz1miwyWZt1OUA9B7KkZFPklzUWf8pMOs0ddGs8nwCkutop0K9qwCxD0ooyRsoi+
         ohUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lxv2YjVDy5w6AQ+Z95Jd1OHt1865rQWbHzl1H0ckHb4=;
        b=GwQ5UgboE2Ggy6t/0ACoe3GkFLwoyAa+Q9JLp4AW5ko6oZ9sQbaV3mgN+w6u34CYBU
         ZX2GPR7Fgf01+OsCCG+Bv8KjhR5B4l7Dh0Qafy5k6aha8wifwezIfTzvpnlxAjp3QMzb
         x8epC/VWNteHI3/qnCPCIM7xYZWpUR6Yi4cEAi015PMiD0DBkgTnwY+C4JKSk5AZOdZY
         4CT+NWtVEfXV+aHUQFsPzxM4Qv6CfGRjvG8Ysc6UB1zLwZmOT/HZWYJlONP7R8iK1U4o
         6ukkg2mQs1a+C1GOGwprBa8O5w6+mGFkXbXrgYuwGj9CWghT6NhOGAkQJm01cVQs/bk7
         6VUQ==
X-Gm-Message-State: APjAAAXOO2EzMl45WxZfPlGDxCFVIDtN+dTYnHubc8AqTPAicW+J1zXu
        dCkbxfs8RvLOrPLY8/vmNQS/SnhXS2uY+U1USrCTUA==
X-Google-Smtp-Source: APXvYqwVi7szQ+w3nsCf0zPQZyYdR4HeVO1GXvtz/sWMMhtS2v2QWLsWh3Ip3Jb3oWwBQ9pfzHwoVyT/iOmN8ovRJtE=
X-Received: by 2002:a1f:4981:: with SMTP id w123mr690507vka.13.1567664142296;
 Wed, 04 Sep 2019 23:15:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190904122939.23780-1-yuehaibing@huawei.com> <20190904122939.23780-9-yuehaibing@huawei.com>
In-Reply-To: <20190904122939.23780-9-yuehaibing@huawei.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Thu, 5 Sep 2019 11:45:30 +0530
Message-ID: <CAHLCerOVuNEAkCggBoDU4NgbzhTVxpdJXeTXVrTs5tp7ZVtSMg@mail.gmail.com>
Subject: Re: [PATCH -next 08/15] thermal: tsens: use devm_platform_ioremap_resource()
 to simplify code
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     miquel.raynal@bootlin.com, Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Eric Anholt <eric@anholt.net>, wahrenst@gmx.net,
        f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com,
        Markus Mayer <mmayer@broadcom.com>,
        computersforpeace@gmail.com, gregory.0xf0@gmail.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, Marc Gonzalez <marc.w.gonzalez@free.fr>,
        mans@mansr.com, talel@amazon.com, Jun Nie <jun.nie@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, phil@raspberrypi.org,
        gregkh@linuxfoundation.org, david.hernandezsanchez@st.com,
        horms+renesas@verge.net.au, wsa+renesas@sang-engineering.com,
        bcm-kernel-feedback-list@broadcom.com,
        Linux PM list <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rpi-kernel@lists.infradead.org,
        lakml <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-rockchip@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Sep 4, 2019 at 6:05 PM YueHaibing <yuehaibing@huawei.com> wrote:
>
> Use devm_platform_ioremap_resource() to simplify the code a bit.
> This is detected by coccinelle.
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Acked-by: Amit Kucheria <amit.kucheria@linaro.org>

> ---
>  drivers/thermal/qcom/tsens-common.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
> index 528df88..43ce4fb 100644
> --- a/drivers/thermal/qcom/tsens-common.c
> +++ b/drivers/thermal/qcom/tsens-common.c
> @@ -155,7 +155,6 @@ int __init init_common(struct tsens_priv *priv)
>  {
>         void __iomem *tm_base, *srot_base;
>         struct device *dev = priv->dev;
> -       struct resource *res;
>         u32 enabled;
>         int ret, i, j;
>         struct platform_device *op = of_find_device_by_node(priv->dev->of_node);
> @@ -166,8 +165,7 @@ int __init init_common(struct tsens_priv *priv)
>         if (op->num_resources > 1) {
>                 /* DT with separate SROT and TM address space */
>                 priv->tm_offset = 0;
> -               res = platform_get_resource(op, IORESOURCE_MEM, 1);
> -               srot_base = devm_ioremap_resource(&op->dev, res);
> +               srot_base = devm_platform_ioremap_resource(op, 1);
>                 if (IS_ERR(srot_base)) {
>                         ret = PTR_ERR(srot_base);
>                         goto err_put_device;
> @@ -184,8 +182,7 @@ int __init init_common(struct tsens_priv *priv)
>                 priv->tm_offset = 0x1000;
>         }
>
> -       res = platform_get_resource(op, IORESOURCE_MEM, 0);
> -       tm_base = devm_ioremap_resource(&op->dev, res);
> +       tm_base = devm_platform_ioremap_resource(op, 0);
>         if (IS_ERR(tm_base)) {
>                 ret = PTR_ERR(tm_base);
>                 goto err_put_device;
> --
> 2.7.4
>
>

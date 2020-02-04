Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 953D7151FA0
	for <lists+linux-pm@lfdr.de>; Tue,  4 Feb 2020 18:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbgBDRlB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Feb 2020 12:41:01 -0500
Received: from mail-vk1-f194.google.com ([209.85.221.194]:43722 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727382AbgBDRlB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Feb 2020 12:41:01 -0500
Received: by mail-vk1-f194.google.com with SMTP id m195so5413782vkh.10
        for <linux-pm@vger.kernel.org>; Tue, 04 Feb 2020 09:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yoiAXhoixmdJYs8LD0r9kQphcdYUs7qTHA0kGn1fjD8=;
        b=ziMjW1G2ZC36prlStBh0BoqSZzrOzkvJgh4cxQJxzi2UYxeh0U6jYD3ceYaUFbxW/1
         b/0ePQTGd+lyMBeZqKeC+hxGtEkgpE8EH6Y2lxFMYCqrv3Ak4nk42IGHFOldLsCDBsae
         40BgwcClVqsWD2sMrahZCAeYJeX4pCF94iZDkyUXuVDghCn/cjfqG/vLYIBWmkBikA9A
         eRyRF06XfBOXrwxWbGj01NEg1HYXx3jibtOA0Q8TgAXWtmUJtRWBcjd9p7DDi/LBAckX
         sqg7bIML+x1oxWc2FraBge5N9fzLy5A/TX2gVJmTuwEDW/TJgkzZtOYi0HKw+k5Ll1XH
         YlWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yoiAXhoixmdJYs8LD0r9kQphcdYUs7qTHA0kGn1fjD8=;
        b=qff+O9O+EgeRJ/LIHhetjwhWvEYCkGZwMi0ESgQhlC8NCZDmcjIdxdOQJablQvjggV
         FqV2UvlHU0UBnQr2FzqpmG2QqSYP5slq12bejNKhGKMn3eCQhFQi+5O1oLev4Tp/iXIT
         GxCHiC4kgZZ8W2lfSQZj5eCPR+QV8OBV2boKAjwO8aO89VCRap7cl42c3XIJ6MloLnW7
         nN/zHQUe11Nm64ySMHg4B3A+PMcdYxcWJZHnFco23mZ6D/Hp4SDfJJftOYm6y7ejSYJj
         plWwQ3TmKCtM/l+8U6nMmjQjWE004VwpYeIzvpooTHkQNdwCSmlnBX218JsRR5MgEENl
         6RWg==
X-Gm-Message-State: APjAAAU6UrztwwbBJ6Na4XZNsfMkuRnrWKlbH7ItzTBbKH8B8ymD8oqt
        zmehnrc2PTOqLGRPIPFbEj/2Rh3eTqdEDC7vl7vUMg==
X-Google-Smtp-Source: APXvYqxED+wsvoC+QCgQxKOUzWUnXH8k+A/0E762um0DhW/ZNecciMz+Dh5mSPvBTLSIOsbmDHFEDhbxvV++vZ1id2Y=
X-Received: by 2002:a1f:94c1:: with SMTP id w184mr19267627vkd.43.1580838060111;
 Tue, 04 Feb 2020 09:41:00 -0800 (PST)
MIME-Version: 1.0
References: <1574254593-16078-1-git-send-email-thara.gopinath@linaro.org> <1574254593-16078-6-git-send-email-thara.gopinath@linaro.org>
In-Reply-To: <1574254593-16078-6-git-send-email-thara.gopinath@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 4 Feb 2020 18:40:24 +0100
Message-ID: <CAPDyKFopiajhFymXo3q558AYBkdDYzU6Ye9HU9XSdN4r8j+qaw@mail.gmail.com>
Subject: Re: [Patch v4 5/7] soc: qcom: Extend RPMh power controller driver to
 register warming devices.
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 20 Nov 2019 at 13:56, Thara Gopinath <thara.gopinath@linaro.org> wrote:
>
> RPMh power control hosts power domains that can be used as
> thermal warming devices. Register these power domains
> with the generic power domain warming device thermal framework.
>
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> ---
> v3->v4:
>         - Introduce a boolean value is_warming_dev in rpmhpd structure to
>           indicate if a generic power domain can be used as a warming
>           device or not.With this change, device tree no longer has to
>           specify which power domain inside the rpmh power domain provider
>           is a warming device.
>         - Move registering of warming devices into a late initcall to
>           ensure that warming devices are registerd after thermal
>           framework is initialized.
>
>  drivers/soc/qcom/rpmhpd.c | 38 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 37 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/soc/qcom/rpmhpd.c b/drivers/soc/qcom/rpmhpd.c
> index 9d37534..5666d1f 100644
> --- a/drivers/soc/qcom/rpmhpd.c
> +++ b/drivers/soc/qcom/rpmhpd.c
> @@ -11,6 +11,7 @@
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_opp.h>
> +#include <linux/pwr_domain_warming.h>
>  #include <soc/qcom/cmd-db.h>
>  #include <soc/qcom/rpmh.h>
>  #include <dt-bindings/power/qcom-rpmpd.h>
> @@ -48,6 +49,7 @@ struct rpmhpd {
>         bool            enabled;
>         const char      *res_name;
>         u32             addr;
> +       bool            is_warming_dev;
>  };
>
>  struct rpmhpd_desc {
> @@ -55,6 +57,8 @@ struct rpmhpd_desc {
>         size_t num_pds;
>  };
>
> +const struct rpmhpd_desc *global_desc;
> +
>  static DEFINE_MUTEX(rpmhpd_lock);
>
>  /* SDM845 RPMH powerdomains */
> @@ -89,6 +93,7 @@ static struct rpmhpd sdm845_mx = {
>         .pd = { .name = "mx", },
>         .peer = &sdm845_mx_ao,
>         .res_name = "mx.lvl",
> +       .is_warming_dev = true,
>  };
>
>  static struct rpmhpd sdm845_mx_ao = {
> @@ -396,7 +401,14 @@ static int rpmhpd_probe(struct platform_device *pdev)
>                                                &rpmhpds[i]->pd);
>         }
>
> -       return of_genpd_add_provider_onecell(pdev->dev.of_node, data);
> +       ret = of_genpd_add_provider_onecell(pdev->dev.of_node, data);
> +
> +       if (ret)
> +               return ret;
> +
> +       global_desc = desc;

I assume this works fine, for now.

Although, nothing prevents this driver from being probed for two
different compatibles for the same platform. Thus the global_desc
could be overwritten with the last one being probed, so then how do
you know which one to use?

> +
> +       return 0;
>  }
>
>  static struct platform_driver rpmhpd_driver = {
> @@ -413,3 +425,27 @@ static int __init rpmhpd_init(void)
>         return platform_driver_register(&rpmhpd_driver);
>  }
>  core_initcall(rpmhpd_init);
> +
> +static int __init rpmhpd_init_warming_device(void)
> +{
> +       size_t num_pds;
> +       struct rpmhpd **rpmhpds;
> +       int i;
> +
> +       if (!global_desc)
> +               return -EINVAL;
> +
> +       rpmhpds = global_desc->rpmhpds;
> +       num_pds = global_desc->num_pds;
> +
> +       if (!of_find_property(rpmhpds[0]->dev->of_node, "#cooling-cells", NULL))
> +               return 0;
> +
> +       for (i = 0; i < num_pds; i++)
> +               if (rpmhpds[i]->is_warming_dev)
> +                       pwr_domain_warming_register(rpmhpds[i]->dev,
> +                                                   rpmhpds[i]->res_name, i);
> +
> +       return 0;
> +}
> +late_initcall(rpmhpd_init_warming_device);

For the record, there are limitations with this approach, for example
you can't deal with -EPROBE_DEFER.

On the other hand, I don't have anything better to suggest, from the
top of my head. So, feel free to add:

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

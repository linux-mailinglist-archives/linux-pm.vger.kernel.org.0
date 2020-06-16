Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBB01FAC45
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jun 2020 11:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbgFPJW1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Jun 2020 05:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728156AbgFPJWL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Jun 2020 05:22:11 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90563C08C5C2
        for <linux-pm@vger.kernel.org>; Tue, 16 Jun 2020 02:22:11 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id d5so2561194vkb.12
        for <linux-pm@vger.kernel.org>; Tue, 16 Jun 2020 02:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+wHrMEFkxSMye57oHUOG3l7PNKPowUwTpUrNyYP51eE=;
        b=P3LtKPchCGZi6AsLylkhutT1uyaRVoQxStI7htwR5DFc8uzpiyChRcZUMNiTD66rmR
         rQJWx94FUnFx9QxhSxXkL4L52UeWm/B07rF6VD8nX6U6h8kjzOjumzRIc8dowg+A3J4i
         j6Dd+ehlVD5HMEqQ3cyoLBGtfuyDS8nANlDhQ7ZEiMfBnh2yyzk7I3EW5px7VsbWndf8
         0gvoE3GrNabmzklxvZvT6yZfl/zOaOvbTWav7k6aKeF0miXPdY3KgTB/4TUv0qPFyPih
         xlTFxKkaNUeBR9le0uQx/J4w9emkXM6FUzvJH0md6EAPqkJEG4pGTml8Of2MuHq7OMw8
         uISg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+wHrMEFkxSMye57oHUOG3l7PNKPowUwTpUrNyYP51eE=;
        b=RVFq8yxVtreIhTNyMxi4BTvEJAInSn7DY31+0iKtNBkLOUtkWaHqxavf1YpWGRD8U5
         5uXJ0wL/5KH/dcwRlYkJx4OOYCZKqa8ZzBRl3vUqEYqz66BMOJ6StWYu0YjCd8cN1z1o
         uix+CZY5yT464fpku/uPwW3Nkh2xL+a9xPrtCLnysEal2VepiRjHWcACGaGiPt4O7D/s
         eA5yY6vCaVRuCCF4bxsO5sxVVdv6Mp1a1Hastgsqj2euLxKg2qukVwAs071oOpNK5jHr
         02CeEtHwQnOOUPaKJw0OIaSU6NX3JQ+GDhCAy2JUco9QDP4q3BarvGWIpOYX905mscEJ
         zVFg==
X-Gm-Message-State: AOAM532Dx9yFflw8l4/sUmuxdH9VuauK0UW91+NjiD44os09ZzlKH9d+
        /WxBC03tYVLu/YXccOAl0fEWfYAQKiSPA13Jt2cOYQ==
X-Google-Smtp-Source: ABdhPJwPCZDjW/KUF8DkihImNCRixs1CXrunDl+3U4RE60hp7VvcksieyuGMZjVan0p8JTUjjsL3Kr2tQcRij7uHDqE=
X-Received: by 2002:ac5:cc44:: with SMTP id l4mr821024vkm.43.1592299330804;
 Tue, 16 Jun 2020 02:22:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200604015317.31389-1-thara.gopinath@linaro.org> <20200604015317.31389-5-thara.gopinath@linaro.org>
In-Reply-To: <20200604015317.31389-5-thara.gopinath@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 16 Jun 2020 11:21:34 +0200
Message-ID: <CAPDyKFpYkF8d8Pv3zg7rw4pC6gC_H7auywziEYDi4mfue1OEJQ@mail.gmail.com>
Subject: Re: [PATCH v6 4/6] soc: qcom: Extend RPMh power controller driver to
 register warming devices.
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>, Rob Herring <robh@kernel.org>,
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

On Thu, 4 Jun 2020 at 03:53, Thara Gopinath <thara.gopinath@linaro.org> wrote:
>
> RPMh power control hosts power domains that can be used as
> thermal warming devices. Register these power domains
> with the generic power domain warming device thermal framework.
>
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe


> ---
>
> v3->v4:
>         - Introduce a boolean value is_warming_dev in rpmhpd structure to
>           indicate if a generic power domain can be used as a warming
>           device or not.With this change, device tree no longer has to
>           specify which power domain inside the rpmh power domain provider
>           is a warming device.
>         - Move registering of warming devices into a late initcall to
>           ensure that warming devices are registered after thermal
>           framework is initialized.
>
> v5->v6:
>         - Moved back registering of warming devices into probe since
>           Bjorn pointed out that now the driver can be initialized as
>           as a module, late_initcall will not work. Thermal framework
>           takes care of binding a cooling device to a thermal zone even
>           if the cooling device is registered before the thermal framework
>           is initialized.
>
>  drivers/soc/qcom/rpmhpd.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/soc/qcom/rpmhpd.c b/drivers/soc/qcom/rpmhpd.c
> index a9c597143525..29e1eb4d11af 100644
> --- a/drivers/soc/qcom/rpmhpd.c
> +++ b/drivers/soc/qcom/rpmhpd.c
> @@ -12,6 +12,7 @@
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_opp.h>
> +#include <linux/pd_warming.h>
>  #include <soc/qcom/cmd-db.h>
>  #include <soc/qcom/rpmh.h>
>  #include <dt-bindings/power/qcom-rpmpd.h>
> @@ -49,6 +50,7 @@ struct rpmhpd {
>         bool            enabled;
>         const char      *res_name;
>         u32             addr;
> +       bool            is_warming_dev;
>  };
>
>  struct rpmhpd_desc {
> @@ -90,6 +92,7 @@ static struct rpmhpd sdm845_mx = {
>         .pd = { .name = "mx", },
>         .peer = &sdm845_mx_ao,
>         .res_name = "mx.lvl",
> +       .is_warming_dev = true,
>  };
>
>  static struct rpmhpd sdm845_mx_ao = {
> @@ -472,7 +475,19 @@ static int rpmhpd_probe(struct platform_device *pdev)
>                                                &rpmhpds[i]->pd);
>         }
>
> -       return of_genpd_add_provider_onecell(pdev->dev.of_node, data);
> +       ret = of_genpd_add_provider_onecell(pdev->dev.of_node, data);
> +
> +       if (ret)
> +               return ret;
> +
> +       if (!of_find_property(dev->of_node, "#cooling-cells", NULL))
> +               return 0;
> +
> +       for (i = 0; i < num_pds; i++)
> +               if (rpmhpds[i]->is_warming_dev)
> +                       of_pd_warming_register(rpmhpds[i]->dev, i);
> +
> +       return 0;
>  }
>
>  static struct platform_driver rpmhpd_driver = {
> --
> 2.20.1
>

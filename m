Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D36B997FF
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2019 17:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732002AbfHVPTp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Aug 2019 11:19:45 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:41633 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389147AbfHVPTp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Aug 2019 11:19:45 -0400
Received: by mail-vs1-f66.google.com with SMTP id m62so4036977vsc.8
        for <linux-pm@vger.kernel.org>; Thu, 22 Aug 2019 08:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0YL8L0tV1l50JDm88/vMbIROFNJ/FU1iner7nW8kAxc=;
        b=G+6Avqtj/KAC9DhPzAXHojIBsZVb+HRBOMPcXYYjEa496fbgly265J0bWULN0h0Vin
         i3trVTFXmLUmxMUXvs0JYMUkA/zA+4wJWfEDeeINEpxtTge6JrnQuLxC8xvjxMsMyG/O
         wQHeEvvABouHLX6GI05q5+L2cRUlAqcL5RptKwVp6kTcaTj6th/BNYwg16LQmy1XkdI0
         1oCy34wODp59lfKLqv8qvDM3Ta0cXs6yAAtC2Qb5jnRqQi86w05HyXE2vJWOdoVjtbu8
         QMjUrnDtyWAgY2jGkrPboeIKhmVHtP9jgILEBrv1xAzGxFHAKF47IkJX3v6GPLUM9yui
         lJYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0YL8L0tV1l50JDm88/vMbIROFNJ/FU1iner7nW8kAxc=;
        b=qlFprivMK4A/oMKl+g/nYEZGbX5bRuj4ol63CCSsb3cPbV2XKGmU8z0TV1D+2um7rN
         lSEMRvDa1Dtua6vmyIplzPEeNcaAu0Et7N8BBsGDchod9QeXLHx1Wv3s9IZIJrZ2WE8Y
         k6uBnDrXOw6F+tUXFuRxOWhhE2kR1wjI/5jmNfUr7bkoSewDSlKVNE+Hz5HtJbFuPLiF
         +etk3vyJSQbU/wHP+RQeasb1zTLlcMy62mZH8l3zR7B6JPGR8/ur9bVHGscvvGz+yVBM
         9k2REzOrc2DxX91Mv6VByvCZoJTTPLqkOoZJl8BrJ6niSoAnsKd0TiarVNqfBwuYiOU2
         Vb8w==
X-Gm-Message-State: APjAAAXdxnhsUCtXEoCofcfiQCkJi57vtihsPyeAl5uODIIfGolyKmMS
        bWf47AEgtqIUFrufg/XdB3Ic4+JpFaYB4Fo6ATjiNuha8pY=
X-Google-Smtp-Source: APXvYqzGiJd+Mkr+yyXy3pv59B85OMOGNOpSIXp4QuYq/4KygfFX5YKbEmPPB89bY8S4t/WjbZzfJuVxDkvY4rgXVo8=
X-Received: by 2002:a67:347:: with SMTP id 68mr19393563vsd.35.1566487183694;
 Thu, 22 Aug 2019 08:19:43 -0700 (PDT)
MIME-Version: 1.0
References: <1565398727-23090-1-git-send-email-thara.gopinath@linaro.org> <1565398727-23090-4-git-send-email-thara.gopinath@linaro.org>
In-Reply-To: <1565398727-23090-4-git-send-email-thara.gopinath@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 22 Aug 2019 17:19:07 +0200
Message-ID: <CAPDyKFoj=f4+r=PaRq-EEZjVooYGCy6k1crepS2TChgcHD0WRQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] thermal: qcom: Add RPMHPD cooling device driver.
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     qualcomm-lt@lists.linaro.org, Linux PM <linux-pm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, 10 Aug 2019 at 02:58, Thara Gopinath <thara.gopinath@linaro.org> wrote:
>
> The MX power domain in RPMH can be used to warm the
> the SoC in SDM845. To support this feature, introduce
> a RPMH power domain cooling device driver that can be
> plugged into the thermal framework.(The thermal framework
> itself requires further modifiction to support a warming
> device in place of a cooling device. Those extensions are
> not introduced in this patch series).
>
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> ---
>  drivers/thermal/qcom/Kconfig            |   7 ++
>  drivers/thermal/qcom/Makefile           |   1 +
>  drivers/thermal/qcom/qcom-rpmhpd-cdev.c | 141 ++++++++++++++++++++++++++++++++
>  3 files changed, 149 insertions(+)
>  create mode 100644 drivers/thermal/qcom/qcom-rpmhpd-cdev.c
>
> diff --git a/drivers/thermal/qcom/Kconfig b/drivers/thermal/qcom/Kconfig
> index aa9c1d8..a540130 100644
> --- a/drivers/thermal/qcom/Kconfig
> +++ b/drivers/thermal/qcom/Kconfig
> @@ -20,3 +20,10 @@ config QCOM_SPMI_TEMP_ALARM
>           trip points. The temperature reported by the thermal sensor reflects the
>           real time die temperature if an ADC is present or an estimate of the
>           temperature based upon the over temperature stage value.
> +
> +config CONFIG_QCOM_RPMHPD_CDEV
> +       tristate "Qualcomm RPMHPD based cooling device"
> +       depends on QCOM_RPMHPD
> +       help
> +         This enables RPMHPD based cooling devices. On SDM845, this is
> +         MX power domain.
> diff --git a/drivers/thermal/qcom/Makefile b/drivers/thermal/qcom/Makefile
> index 7c8dc6e..e4eb520 100644
> --- a/drivers/thermal/qcom/Makefile
> +++ b/drivers/thermal/qcom/Makefile
> @@ -4,3 +4,4 @@ obj-$(CONFIG_QCOM_TSENS)        += qcom_tsens.o
>  qcom_tsens-y                   += tsens.o tsens-common.o tsens-v0_1.o \
>                                    tsens-8960.o tsens-v2.o tsens-v1.o
>  obj-$(CONFIG_QCOM_SPMI_TEMP_ALARM)     += qcom-spmi-temp-alarm.o
> +obj-$(CONFIG_QCOM_RPMHPD_CDEV)         += qcom-rpmhpd-cdev.o
> diff --git a/drivers/thermal/qcom/qcom-rpmhpd-cdev.c b/drivers/thermal/qcom/qcom-rpmhpd-cdev.c
> new file mode 100644
> index 0000000..265523b
> --- /dev/null
> +++ b/drivers/thermal/qcom/qcom-rpmhpd-cdev.c
> @@ -0,0 +1,141 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2019, Linaro Ltd
> + */
> +#include <linux/err.h>
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/module.h>
> +#include <linux/pm_domain.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/thermal.h>
> +
> +struct rpmhpd_cooling_device {
> +       struct thermal_cooling_device *cdev;
> +       struct device *pwr_domain;
> +       int max_state;
> +       int cur_state;
> +       bool is_pwr_domain_on;
> +};
> +
> +static const char sdm845_rpmhpd_cdev_name[] = "mx";
> +
> +static const struct of_device_id rpmhpd_cdev_match_table[] = {
> +       { .compatible = "qcom,sdm845-rpmhpd-cdev", .data = &sdm845_rpmhpd_cdev_name },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(of, rpmhpd_cdev_match_table);
> +
> +static int rpmhpd_cdev_get_max_state(struct thermal_cooling_device *cdev,
> +                                    unsigned long *state)
> +{
> +       struct rpmhpd_cooling_device *rpmhpd_cdev = cdev->devdata;
> +
> +       *state = rpmhpd_cdev->max_state;
> +       return 0;
> +}
> +
> +static int rpmhpd_cdev_get_cur_state(struct thermal_cooling_device *cdev,
> +                                    unsigned long *state)
> +{
> +       struct rpmhpd_cooling_device *rpmhpd_cdev = cdev->devdata;
> +       int perf_state;
> +
> +       dev_pm_genpd_get_performance_state(rpmhpd_cdev->pwr_domain,
> +                                          &perf_state);
> +       *state = perf_state;
> +       return 0;
> +}
> +
> +static int rpmhpd_cdev_set_cur_state(struct thermal_cooling_device *cdev,
> +                                    unsigned long state)
> +{
> +       struct rpmhpd_cooling_device *rpmhpd_cdev = cdev->devdata;
> +       struct device *pwr_domain = rpmhpd_cdev->pwr_domain;

Nitpick: Using pwr_domain as the name of the variable is a bit
confusing. Why not just name it "dev"?

> +       int ret;
> +
> +       ret = dev_pm_genpd_set_performance_state(pwr_domain, state);
> +
> +       if (ret)
> +               return ret;
> +
> +       if (state && !rpmhpd_cdev->is_pwr_domain_on) {

Nitpick: To clarify, I would suggest to rename "is_pwr_domain_on" to
"runtime_resumed".

> +               ret = pm_runtime_get_sync(pwr_domain);
> +               rpmhpd_cdev->is_pwr_domain_on = true;
> +       } else if (!state && rpmhpd_cdev->is_pwr_domain_on) {
> +               ret = pm_runtime_put(pwr_domain);
> +               rpmhpd_cdev->is_pwr_domain_on = false;
> +       }
> +
> +       return ret;
> +}
> +
> +static struct thermal_cooling_device_ops rpmhpd_cooling_device_ops = {
> +       .get_max_state = rpmhpd_cdev_get_max_state,
> +       .get_cur_state = rpmhpd_cdev_get_cur_state,
> +       .set_cur_state = rpmhpd_cdev_set_cur_state,
> +};
> +
> +static int rpmhpd_cdev_probe(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev, *pd_dev;
> +       struct rpmhpd_cooling_device *rpmhpd_cdev;
> +       const char *rpmhpd_cdev_name = of_device_get_match_data(dev);
> +       unsigned int count;
> +       int ret;
> +
> +       if (!dev->pm_domain) {
> +               pd_dev = dev_pm_domain_attach_by_name(dev, rpmhpd_cdev_name);

I don't think this is needed, unless you have multiple PM domains that
can be attached per device.

If there is only one PM domain the platform bus should already have
attached it at this point.

> +               if (IS_ERR(pd_dev))
> +                       return PTR_ERR(pd_dev);
> +       } else {
> +               pd_dev = dev;
> +       }
> +
> +       rpmhpd_cdev = devm_kzalloc(dev, sizeof(*rpmhpd_cdev), GFP_KERNEL);
> +       if (!rpmhpd_cdev) {
> +               ret = -ENOMEM;
> +               goto detach_pd;
> +       }
> +
> +       ret = dev_pm_genpd_performance_state_count(pd_dev, &count);
> +       if (ret)
> +               goto detach_pd;
> +
> +       rpmhpd_cdev->pwr_domain = pd_dev;
> +       rpmhpd_cdev->max_state = count - 1;
> +       rpmhpd_cdev->is_pwr_domain_on = false;
> +
> +       pm_runtime_enable(pd_dev);
> +
> +       rpmhpd_cdev->cdev = thermal_of_cooling_device_register
> +                                       (dev->of_node, rpmhpd_cdev_name,
> +                                        rpmhpd_cdev,
> +                                        &rpmhpd_cooling_device_ops);
> +       if (IS_ERR(rpmhpd_cdev->cdev)) {
> +               dev_err(dev, "unable to register %s cooling device\n",
> +                       rpmhpd_cdev_name);
> +               ret = PTR_ERR(rpmhpd_cdev->cdev);
> +               goto detach_pd;
> +       }
> +
> +       return 0;
> +
> +detach_pd:
> +       dev_pm_domain_detach(pd_dev, false);

Not needed, see above.

> +       return ret;
> +}
> +
> +static struct platform_driver rpmhpd_cdev_driver = {
> +       .driver = {
> +               .name = "qcom-rpmhpd-cdev",
> +               .of_match_table = rpmhpd_cdev_match_table,
> +       },
> +       .probe = rpmhpd_cdev_probe,

Looks like you should implement a ->remove() callback as well. Or
perhaps you think this should be a built-in-driver?

> +};
> +module_platform_driver(rpmhpd_cdev_driver);
> +
> +MODULE_DESCRIPTION("Qualcomm RPMHPD cooling device driver");
> +MODULE_LICENSE("GPL v2");
> --
> 2.1.4
>

Kind regards
Uffe

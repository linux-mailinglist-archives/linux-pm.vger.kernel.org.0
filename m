Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43AB910392B
	for <lists+linux-pm@lfdr.de>; Wed, 20 Nov 2019 12:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728774AbfKTLyf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Nov 2019 06:54:35 -0500
Received: from mail-vk1-f194.google.com ([209.85.221.194]:34491 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728601AbfKTLyf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Nov 2019 06:54:35 -0500
Received: by mail-vk1-f194.google.com with SMTP id t184so5958021vka.1
        for <linux-pm@vger.kernel.org>; Wed, 20 Nov 2019 03:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hd8BHJelmiH7/pGl0JXnpAERmqT/asDnXzYH4tiA08o=;
        b=kWDe/OR+xrpFY2ZWZ9QgnDbLI1qbez2/Q4j2h+SwBS60b1kq4rhVMwEj/2IxDaEtt4
         ROhTWAMMhyvCVRNbcr1OYKhZEisV3KAWH6Het0Sfycb+1hxvWaUpDx2S9s4yrwF2addz
         qlKHFOb3n3gPlKLWSWQRCjTP2DunaJvFBaS5tra4Uoz9tq+b5cU7Ezoh3svqiwJMS4/o
         sgSpBN6bgH80u6Td0pFU8KgDhg766SKwDZ2wo8CfuMhOzBDgLTfZF9TtXaTgBRd9pAeG
         AQoF7EbcS76adSKv5KB13os1g9jJJJYhfQV9PIx9Um+DQg0ZoAYYgwNo3z08SLVfVzsv
         xQXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hd8BHJelmiH7/pGl0JXnpAERmqT/asDnXzYH4tiA08o=;
        b=Q/8pAoqKnHhEQMrH8AVyEDDPGGgxUazczEvlxuASfDoJ0B8LKEBgH0ekjXEjvhs6jC
         aCa5N+QDnHkL2FV+zkfJ3Sc42hsk7my0UlC5DSB/0sQpYdOsJ+knq9DPjH7alUKiiU2/
         QD67NV+1EBzlhbtKd2w1FL/to3soblh3QW6Z1VqO5+EOEuXsJzmLnNKIaB5yvYOBE0rz
         w66y7Guj8lYqGT0Wbzfytx7EZaOpWJpzVH0aslpTz3KF/Th0tqM4YZy111SnKjZmbPhD
         w9nfHzX1vSEE4hWRR0opIASnM+ngiTENkDudnlnIZ0UEjQx4iP3hvSI/V/rBfu+9kQm+
         /yKg==
X-Gm-Message-State: APjAAAUlA8Tvun9X7dzH9pNdks50ZKR7y1gm6Hpe6jFWpmzVCkrApZvy
        mi8w7glIiH+C1+jnxD77aZnmbvij/ldOBB2cEtEsgw==
X-Google-Smtp-Source: APXvYqz3p+vyZepa81xazUV+vueqO73U5XJVYPTPNT7iJK44D3pSLUvhOGS3+vbJ6+HmQ5Kk99Ux8bgyg3mPWtHjIec=
X-Received: by 2002:a1f:fe0a:: with SMTP id l10mr1230084vki.59.1574250873647;
 Wed, 20 Nov 2019 03:54:33 -0800 (PST)
MIME-Version: 1.0
References: <20191119154621.55341-1-niklas.cassel@linaro.org> <20191119154621.55341-3-niklas.cassel@linaro.org>
In-Reply-To: <20191119154621.55341-3-niklas.cassel@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 20 Nov 2019 12:53:57 +0100
Message-ID: <CAPDyKFrLJ253Uzn3jLWwcOUtB5dfdzEtoUMgWR_=V0xGd1NaJQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/5] power: avs: Add support for CPR (Core Power Reduction)
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Kevin Hilman <khilman@kernel.org>, Nishanth Menon <nm@ti.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 19 Nov 2019 at 16:46, Niklas Cassel <niklas.cassel@linaro.org> wrote:
>
> CPR (Core Power Reduction) is a technology that reduces core power on a
> CPU or other device. It reads voltage settings in efuse from product
> test process as initial settings.
> Each OPP corresponds to a "corner" that has a range of valid voltages
> for a particular frequency. While the device is running at a particular
> frequency, CPR monitors dynamic factors such as temperature, etc. and
> adjusts the voltage for that frequency accordingly to save power
> and meet silicon characteristic requirements.
>
> This driver is based on an RFC by Stephen Boyd[1], which in turn is
> based on work by others on codeaurora.org[2].
>
> [1] https://lkml.org/lkml/2015/9/18/833
> [2] https://www.codeaurora.org/cgit/quic/la/kernel/msm-3.10/tree/drivers/regulator/cpr-regulator.c?h=msm-3.10
>
> Co-developed-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>

I have had a look at the genpd provider specific parts. So here are
few comments.

[...]

> +
> +struct cpr_drv {
> +       unsigned int            num_corners;
> +
> +       unsigned int            ref_clk_khz;
> +       unsigned int            performance_state;

Without looking into the details of how this is being used, I assume
this reflects the performance state of the genpd provider, which is
also tracked by genpd, of course.

Could you perhaps make use of an API that gives you the current
performance state of the genpd, rather than having to duplicate this?

There is patch, reviewed, but not queued yet.
https://lore.kernel.org/patchwork/patch/1140368/

> +
> +       struct generic_pm_domain pd;
> +       struct device           *dev;
> +       struct mutex            lock;
> +       void __iomem            *base;
> +       struct corner           *corner;
> +       struct regulator        *vdd_apc;
> +       struct clk              *cpu_clk;
> +       struct regmap           *tcsr;
> +       bool                    loop_disabled;
> +       u32                     gcnt;
> +       unsigned long           flags;
> +
> +       struct fuse_corner      *fuse_corners;
> +       struct corner           *corners;
> +
> +       const struct cpr_desc *desc;
> +       const struct acc_desc *acc_desc;
> +       const struct cpr_fuse *cpr_fuses;
> +
> +       struct dentry *debugfs;
> +};
> +

[...]

> +
> +static int cpr_find_initial_corner(struct cpr_drv *drv)
> +{
> +       unsigned long rate;
> +       const struct corner *end;
> +       struct corner *iter;
> +       int i = 0;
> +
> +       if (!drv->cpu_clk) {
> +               dev_err(drv->dev, "cannot get rate from NULL clk\n");
> +               return -EINVAL;
> +       }
> +
> +       end = &drv->corners[drv->num_corners - 1];
> +       rate = clk_get_rate(drv->cpu_clk);
> +
> +       for (iter = drv->corners; iter <= end; iter++) {
> +               if (iter->freq > rate)
> +                       break;
> +               i++;
> +               if (iter->freq == rate) {
> +                       drv->corner = iter;
> +                       drv->performance_state = i;
> +                       break;
> +               }
> +               if (iter->freq < rate) {
> +                       drv->corner = iter;
> +                       drv->performance_state = i;
> +               }
> +       }
> +
> +       if (!drv->corner) {
> +               dev_err(drv->dev, "boot up corner not found\n");
> +               return -EINVAL;
> +       }
> +
> +       dev_dbg(drv->dev, "boot up perf state: %d\n", i);
> +
> +       return 0;
> +}

[...]

> +
> +static int cpr_pd_attach_dev(struct generic_pm_domain *domain,
> +                            struct device *dev)
> +{
> +       struct cpr_drv *drv = container_of(domain, struct cpr_drv, pd);
> +       const struct acc_desc *acc_desc = drv->acc_desc;
> +       int ret;
> +
> +       dev_dbg(drv->dev, "attach callback for: %s\n", dev_name(dev));
> +
> +       if (drv->cpu_clk)
> +               return 0;
> +
> +       drv->cpu_clk = devm_clk_get(dev, NULL);
> +       if (IS_ERR(drv->cpu_clk)) {
> +               ret = PTR_ERR(drv->cpu_clk);
> +               if (ret != -EPROBE_DEFER)
> +                       dev_err(drv->dev, "could not get cpu clk: %d\n", ret);
> +               return ret;
> +       }

I have several thoughts around this..

I understand that you don't want to run the below code more than once
per instance of the genpd provider, which seems fine to me. Just to
make that clear.

However, the above code fetches and stores the clock found from the
attached device's OF node, in the cpr driver instance. But, only for
the device that is being attached first.

I assume this is intentional, but it looks a bit odd. Why isn't the
other devices that becomes attached, interesting to fecth/store the
clock for?

In regards to the clock consumer DT binding, I couldn't find it, but
maybe I am not looking at the correct place.

Moreover, genpd may run this code in parallel, as the genpd lock isn't
being held while invoking the ->attach_dev() callback. This is
probably safe anyway, because you don't run
dev_pm_domain_attach_by_name(), while attaching the CPU devices,
asynchronously. On the other hand, you already have a mutex for the
cpr drv, so we might as well use that for protecting against this,
don't you think?

> +
> +       dev_dbg(drv->dev, "using cpu clk from: %s\n", dev_name(dev));
> +
> +       /*
> +        * Everything related to (virtual) corners has to be initialized
> +        * here, when attaching to the power domain, since it depends on
> +        * the power domain's OPP table, which isn't available earlier.
> +        */
> +       drv->num_corners = dev_pm_opp_get_opp_count(&drv->pd.dev);
> +       if (drv->num_corners < 0)
> +               return drv->num_corners;
> +       if (drv->num_corners < 2) {
> +               dev_err(drv->dev, "need at least 2 OPPs to use CPR\n");
> +               return -EINVAL;
> +       }
> +
> +       dev_dbg(drv->dev, "number of OPPs: %d\n", drv->num_corners);
> +
> +       drv->corners = devm_kcalloc(dev, drv->num_corners,
> +                                   sizeof(*drv->corners),
> +                                   GFP_KERNEL);
> +       if (!drv->corners)
> +               return -ENOMEM;
> +
> +       ret = cpr_corner_init(drv);
> +       if (ret)
> +               return ret;
> +
> +       cpr_set_loop_allowed(drv);
> +
> +       ret = cpr_init_parameters(drv);
> +       if (ret)
> +               return ret;
> +
> +       /* Configure CPR HW but keep it disabled */
> +       ret = cpr_config(drv);
> +       if (ret)
> +               return ret;
> +
> +       ret = cpr_find_initial_corner(drv);
> +       if (ret)
> +               return ret;
> +
> +       if (acc_desc->config)
> +               regmap_multi_reg_write(drv->tcsr, acc_desc->config,
> +                                      acc_desc->num_regs_per_fuse);
> +
> +       /* Enable ACC if required */
> +       if (acc_desc->enable_mask)
> +               regmap_update_bits(drv->tcsr, acc_desc->enable_reg,
> +                                  acc_desc->enable_mask,
> +                                  acc_desc->enable_mask);
> +
> +       return 0;
> +}

[...]

> +
> +static int cpr_probe(struct platform_device *pdev)
> +{
> +       struct resource *res;
> +       struct device *dev = &pdev->dev;
> +       struct cpr_drv *drv;
> +       int irq, ret;
> +       const struct cpr_acc_desc *data;
> +       struct device_node *np;
> +       u32 cpr_rev = FUSE_REVISION_UNKNOWN;
> +
> +       data = of_device_get_match_data(dev);
> +       if (!data || !data->cpr_desc || !data->acc_desc)
> +               return -EINVAL;
> +
> +       drv = devm_kzalloc(dev, sizeof(*drv), GFP_KERNEL);
> +       if (!drv)
> +               return -ENOMEM;
> +       drv->dev = dev;
> +       drv->desc = data->cpr_desc;
> +       drv->acc_desc = data->acc_desc;
> +
> +       drv->fuse_corners = devm_kcalloc(dev, drv->desc->num_fuse_corners,
> +                                        sizeof(*drv->fuse_corners),
> +                                        GFP_KERNEL);
> +       if (!drv->fuse_corners)
> +               return -ENOMEM;
> +
> +       np = of_parse_phandle(dev->of_node, "acc-syscon", 0);
> +       if (!np)
> +               return -ENODEV;
> +
> +       drv->tcsr = syscon_node_to_regmap(np);
> +       of_node_put(np);
> +       if (IS_ERR(drv->tcsr))
> +               return PTR_ERR(drv->tcsr);
> +
> +       mutex_init(&drv->lock);

Nitpick, you might as well move this a few lines below, as you may
bail out while fetching some of the resources below.

> +
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       drv->base = devm_ioremap_resource(dev, res);
> +       if (IS_ERR(drv->base))
> +               return PTR_ERR(drv->base);
> +
> +       irq = platform_get_irq(pdev, 0);
> +       if (irq < 0)
> +               return -EINVAL;
> +
> +       drv->vdd_apc = devm_regulator_get(dev, "vdd-apc");
> +       if (IS_ERR(drv->vdd_apc))
> +               return PTR_ERR(drv->vdd_apc);
> +
> +       /*
> +        * Initialize fuse corners, since it simply depends
> +        * on data in efuses.
> +        * Everything related to (virtual) corners has to be
> +        * initialized after attaching to the power domain,
> +        * since is depends on the OPP table.
> +        */
> +       ret = cpr_read_efuse(dev, "cpr_fuse_revision", &cpr_rev);
> +       if (ret)
> +               return ret;
> +
> +       drv->cpr_fuses = cpr_get_fuses(drv);
> +       if (IS_ERR(drv->cpr_fuses))
> +               return PTR_ERR(drv->cpr_fuses);
> +
> +       ret = cpr_populate_ring_osc_idx(drv);
> +       if (ret)
> +               return ret;
> +
> +       ret = cpr_fuse_corner_init(drv);
> +       if (ret)
> +               return ret;
> +
> +       ret = devm_request_threaded_irq(dev, irq, NULL,
> +                                       cpr_irq_handler,
> +                                       IRQF_ONESHOT | IRQF_TRIGGER_RISING,
> +                                       "cpr", drv);
> +       if (ret)
> +               return ret;
> +
> +       drv->pd.name = devm_kstrdup_const(dev, dev->of_node->full_name,
> +                                         GFP_KERNEL);
> +       if (!drv->pd.name)
> +               return -EINVAL;
> +
> +       drv->pd.power_off = cpr_power_off;
> +       drv->pd.power_on = cpr_power_on;
> +       drv->pd.set_performance_state = cpr_set_performance;
> +       drv->pd.opp_to_performance_state = cpr_get_performance;
> +       drv->pd.attach_dev = cpr_pd_attach_dev;
> +
> +       ret = pm_genpd_init(&drv->pd, NULL, true);
> +       if (ret)
> +               return ret;
> +
> +       ret = of_genpd_add_provider_simple(dev->of_node, &drv->pd);
> +       if (ret)
> +               return ret;
> +
> +       platform_set_drvdata(pdev, drv);
> +       cpr_debugfs_init(drv);
> +
> +       return 0;
> +}
> +
> +static int cpr_remove(struct platform_device *pdev)
> +{
> +       struct cpr_drv *drv = platform_get_drvdata(pdev);
> +
> +       if (cpr_is_allowed(drv)) {
> +               cpr_ctl_disable(drv);
> +               cpr_irq_set(drv, 0);
> +       }
> +
> +       of_genpd_del_provider(pdev->dev.of_node);
> +       pm_genpd_remove(&drv->pd);
> +
> +       debugfs_remove_recursive(drv->debugfs);
> +
> +       return 0;
> +}
> +
> +static const struct of_device_id cpr_match_table[] = {
> +       { .compatible = "qcom,qcs404-cpr", .data = &qcs404_cpr_acc_desc },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(of, cpr_match_table);
> +
> +static struct platform_driver cpr_driver = {
> +       .probe          = cpr_probe,
> +       .remove         = cpr_remove,
> +       .driver         = {
> +               .name   = "qcom-cpr",
> +               .of_match_table = cpr_match_table,
> +       },
> +};
> +module_platform_driver(cpr_driver);
> +
> +MODULE_DESCRIPTION("Core Power Reduction (CPR) driver");
> +MODULE_LICENSE("GPL v2");

Otherwise this looks good to me.

Kind regards
Uffe

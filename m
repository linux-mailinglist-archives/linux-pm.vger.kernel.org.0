Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13927E2695
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2019 00:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407852AbfJWWsN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Oct 2019 18:48:13 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:40367 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406216AbfJWWsN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Oct 2019 18:48:13 -0400
Received: by mail-oi1-f194.google.com with SMTP id b25so7263832oib.7;
        Wed, 23 Oct 2019 15:48:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5rO+uc1ILY9OMG2v2SNvpBcmRQmpBzHDB/LO32aNzZk=;
        b=AFwErGSLrYGobTrDvc4ak66z3eI5uVBsCrhMFkGaRv57vS6giS9IIqqzhSH1vSdtVg
         gUOOxvna4y8L83UAOwd298/QqHJWWDOkjpl5Oo3eEeFg9TZHnDbP1SC+iFbwhp5aGcoR
         ef1SNE8mp7xdmr19+0dy5tqvshjFZdLwy8Jhj7YOi1dePxkiF3eSk2arAvO+Oh/pN5ds
         aCxygLhFO9CqFeHciVBiaYf9nQ9//7Cw9DW7NkGKRo57FYFW2WmNw/MndxwSld3teoD6
         zi81SEdlQUXBR7tTN8ff7yR+V+FRZJJFxnBViP237hbAyizcV6DwIbRisEfKIxileKRy
         DCiQ==
X-Gm-Message-State: APjAAAUNZ8p0YeFi/K7MMojQN7r0PH6ss9WFeU8eb75BLMVF8HWFlESJ
        w+VKCfMjRsrQuDFSK4QZOqBcc9RMvdY=
X-Google-Smtp-Source: APXvYqw7YIlLXT+3gf1USNvjMkhOekidJ1vR7tkFdzzR84Xqp+m/hfz5iZxFZU+5aNzk3uj/0vSo9w==
X-Received: by 2002:a54:418c:: with SMTP id 12mr2017573oiy.154.1571870891151;
        Wed, 23 Oct 2019 15:48:11 -0700 (PDT)
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com. [209.85.210.51])
        by smtp.gmail.com with ESMTPSA id c21sm6518688otp.15.2019.10.23.15.48.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2019 15:48:10 -0700 (PDT)
Received: by mail-ot1-f51.google.com with SMTP id g13so18904906otp.8;
        Wed, 23 Oct 2019 15:48:10 -0700 (PDT)
X-Received: by 2002:a05:6830:22d6:: with SMTP id q22mr5171244otc.74.1571870889734;
 Wed, 23 Oct 2019 15:48:09 -0700 (PDT)
MIME-Version: 1.0
References: <20191023082423.12569-1-ran.wang_1@nxp.com> <20191023082423.12569-3-ran.wang_1@nxp.com>
In-Reply-To: <20191023082423.12569-3-ran.wang_1@nxp.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Wed, 23 Oct 2019 17:47:58 -0500
X-Gmail-Original-Message-ID: <CADRPPNTwzz8M-Gi-371ROmYLrzXUAyxc+2_u6uUp0Fwd1dggLA@mail.gmail.com>
Message-ID: <CADRPPNTwzz8M-Gi-371ROmYLrzXUAyxc+2_u6uUp0Fwd1dggLA@mail.gmail.com>
Subject: Re: [PATCH v9 3/3] soc: fsl: add RCPM driver
To:     Ran Wang <ran.wang_1@nxp.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Pavel Machek <pavel@ucw.cz>, Huang Anson <anson.huang@nxp.com>,
        Li Biwen <biwen.li@nxp.com>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Oct 23, 2019 at 3:24 AM Ran Wang <ran.wang_1@nxp.com> wrote:
>
> The NXP's QorIQ Processors based on ARM Core have RCPM module

Actually not just ARM based QorIQ processors are having RCPM, PowerPC
based QorIQ SoCs also have RCPM.  Does this driver also work with the
PowerPC SoCs?  Please clarify in the commit message and Kconfig
description.

> (Run Control and Power Management), which performs system level
> tasks associated with power management such as wakeup source control.
>
> This driver depends on PM wakeup source framework which help to
> collect wake information.
>
> Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> ---
> Change in v9:
>         - Add kerneldoc for rcpm_pm_prepare().
>         - Use pr_debug() to replace dev_info(), to print message when decide
>           skip current wakeup object, this is mainly for debugging (in order
>           to detect potential improper implementation on device tree which
>           might cause this skip).
>         - Refactor looping implementation in rcpm_pm_prepare(), add more
>           comments to help clarify.
>
> Change in v8:
>         - Adjust related API usage to meet wakeup.c's update in patch 1/3.
>         - Add sanity checking for the case of ws->dev or ws->dev->parent
>           is null.
>
> Change in v7:
>         - Replace 'ws->dev' with 'ws->dev->parent' to get aligned with
>         c8377adfa781 ("PM / wakeup: Show wakeup sources stats in sysfs")
>         - Remove '+obj-y += ftm_alarm.o' since it is wrong.
>         - Cosmetic work.
>
> Change in v6:
>         - Adjust related API usage to meet wakeup.c's update in patch 1/3.
>
> Change in v5:
>         - Fix v4 regression of the return value of wakeup_source_get_next()
>         didn't pass to ws in while loop.
>         - Rename wakeup_source member 'attached_dev' to 'dev'.
>         - Rename property 'fsl,#rcpm-wakeup-cells' to '#fsl,rcpm-wakeup-cells'.
>         please see https://lore.kernel.org/patchwork/patch/1101022/
>
> Change in v4:
>         - Remove extra ',' in author line of rcpm.c
>         - Update usage of wakeup_source_get_next() to be less confusing to the
> reader, code logic remain the same.
>
> Change in v3:
>         - Some whitespace ajdustment.
>
> Change in v2:
>         - Rebase Kconfig and Makefile update to latest mainline.
>
>  drivers/soc/fsl/Kconfig  |   8 +++
>  drivers/soc/fsl/Makefile |   1 +
>  drivers/soc/fsl/rcpm.c   | 148 +++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 157 insertions(+)
>  create mode 100644 drivers/soc/fsl/rcpm.c
>
> diff --git a/drivers/soc/fsl/Kconfig b/drivers/soc/fsl/Kconfig
> index f9ad8ad..4918856 100644
> --- a/drivers/soc/fsl/Kconfig
> +++ b/drivers/soc/fsl/Kconfig
> @@ -40,4 +40,12 @@ config DPAA2_CONSOLE
>           /dev/dpaa2_mc_console and /dev/dpaa2_aiop_console,
>           which can be used to dump the Management Complex and AIOP
>           firmware logs.
> +
> +config FSL_RCPM
> +       bool "Freescale RCPM support"
> +       depends on PM_SLEEP

If this is only for ARM, probably add more dependency here?

> +       help
> +         The NXP QorIQ Processors based on ARM Core have RCPM module
> +         (Run Control and Power Management), which performs all device-level
> +         tasks associated with power management, such as wakeup source control.
>  endmenu
> diff --git a/drivers/soc/fsl/Makefile b/drivers/soc/fsl/Makefile
> index 71dee8d..906f1cd 100644
> --- a/drivers/soc/fsl/Makefile
> +++ b/drivers/soc/fsl/Makefile
> @@ -6,6 +6,7 @@
>  obj-$(CONFIG_FSL_DPAA)                 += qbman/
>  obj-$(CONFIG_QUICC_ENGINE)             += qe/
>  obj-$(CONFIG_CPM)                      += qe/
> +obj-$(CONFIG_FSL_RCPM)                 += rcpm.o
>  obj-$(CONFIG_FSL_GUTS)                 += guts.o
>  obj-$(CONFIG_FSL_MC_DPIO)              += dpio/
>  obj-$(CONFIG_DPAA2_CONSOLE)            += dpaa2-console.o
> diff --git a/drivers/soc/fsl/rcpm.c b/drivers/soc/fsl/rcpm.c
> new file mode 100644
> index 0000000..9378073
> --- /dev/null
> +++ b/drivers/soc/fsl/rcpm.c
> @@ -0,0 +1,148 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// rcpm.c - Freescale QorIQ RCPM driver
> +//
> +// Copyright 2019 NXP
> +//
> +// Author: Ran Wang <ran.wang_1@nxp.com>
> +
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/of_address.h>
> +#include <linux/slab.h>
> +#include <linux/suspend.h>
> +#include <linux/kernel.h>
> +
> +#define RCPM_WAKEUP_CELL_MAX_SIZE      7
> +
> +struct rcpm {
> +       unsigned int    wakeup_cells;
> +       void __iomem    *ippdexpcr_base;
> +       bool            little_endian;
> +};
> +
> +/**
> + * rcpm_pm_prepare - performs device-level tasks associated with power
> + * management, such as programming related to the wakeup source control.
> + * @dev: Device to handle.
> + *
> + */
> +static int rcpm_pm_prepare(struct device *dev)
> +{
> +       int i, ret, idx;
> +       void __iomem *base;
> +       struct wakeup_source    *ws;
> +       struct rcpm             *rcpm;
> +       struct device_node      *np = dev->of_node;
> +       u32 value[RCPM_WAKEUP_CELL_MAX_SIZE + 1];
> +
> +       rcpm = dev_get_drvdata(dev);
> +       if (!rcpm)
> +               return -EINVAL;
> +
> +       base = rcpm->ippdexpcr_base;
> +       idx = wakeup_sources_read_lock();
> +
> +       /* Begin with first registered wakeup source */
> +       for_each_wakeup_source(ws) {
> +
> +               /* skip object which is not attached to device */
> +               if (!ws->dev || !ws->dev->parent)
> +                       continue;
> +
> +               ret = device_property_read_u32_array(ws->dev->parent,
> +                               "fsl,rcpm-wakeup", value,
> +                               rcpm->wakeup_cells + 1);
> +
> +               /*  Wakeup source should refer to current rcpm device */
> +               if (ret || (np->phandle != value[0])) {
> +                       pr_debug("%s doesn't refer to this rcpm\n", ws->name);

I agree with Rafael that this looks a little bit weird.

> +                       continue;
> +               }
> +
> +               /* Property "#fsl,rcpm-wakeup-cells" of rcpm node defines the
> +                * number of IPPDEXPCR register cells, and "fsl,rcpm-wakeup"
> +                * of wakeup source IP contains an integer array: <phandle to
> +                * RCPM node, IPPDEXPCR0 setting, IPPDEXPCR1 setting,
> +                * IPPDEXPCR2 setting, etc>.
> +                *
> +                * So we will go thought them and do programming accordngly.
> +                */
> +               for (i = 0; i < rcpm->wakeup_cells; i++) {
> +                       u32 tmp = value[i + 1];
> +                       void __iomem *address = base + i * 4;
> +
> +                       if (!tmp)
> +                               continue;
> +
> +                       /* We can only OR related bits */
> +                       if (rcpm->little_endian) {
> +                               tmp |= ioread32(address);
> +                               iowrite32(tmp, address);
> +                       } else {
> +                               tmp |= ioread32be(address);
> +                               iowrite32be(tmp, address);
> +                       }

Can we do read once at the beginning and write once at the end,
instead of doing IO read/write for every wakeup source?

> +               }
> +       }
> +
> +       wakeup_sources_read_unlock(idx);
> +
> +       return 0;
> +}
> +
> +static const struct dev_pm_ops rcpm_pm_ops = {
> +       .prepare =  rcpm_pm_prepare,
> +};
> +
> +static int rcpm_probe(struct platform_device *pdev)
> +{
> +       struct device   *dev = &pdev->dev;
> +       struct resource *r;
> +       struct rcpm     *rcpm;
> +       int ret;
> +
> +       rcpm = devm_kzalloc(dev, sizeof(*rcpm), GFP_KERNEL);
> +       if (!rcpm)
> +               return -ENOMEM;
> +
> +       r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       if (!r)
> +               return -ENODEV;
> +
> +       rcpm->ippdexpcr_base = devm_ioremap_resource(&pdev->dev, r);
> +       if (IS_ERR(rcpm->ippdexpcr_base)) {
> +               ret =  PTR_ERR(rcpm->ippdexpcr_base);
> +               return ret;
> +       }
> +
> +       rcpm->little_endian = device_property_read_bool(
> +                       &pdev->dev, "little-endian");
> +
> +       ret = device_property_read_u32(&pdev->dev,
> +                       "#fsl,rcpm-wakeup-cells", &rcpm->wakeup_cells);
> +       if (ret)
> +               return ret;
> +
> +       dev_set_drvdata(&pdev->dev, rcpm);
> +
> +       return 0;
> +}
> +
> +static const struct of_device_id rcpm_of_match[] = {
> +       { .compatible = "fsl,qoriq-rcpm-2.1+", },
> +       {}
> +};
> +MODULE_DEVICE_TABLE(of, rcpm_of_match);
> +
> +static struct platform_driver rcpm_driver = {
> +       .driver = {
> +               .name = "rcpm",
> +               .of_match_table = rcpm_of_match,
> +               .pm     = &rcpm_pm_ops,
> +       },
> +       .probe = rcpm_probe,
> +};
> +
> +module_platform_driver(rcpm_driver);
> --
> 2.7.4
>

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5BC2A6455
	for <lists+linux-pm@lfdr.de>; Wed,  4 Nov 2020 13:29:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729783AbgKDM3e (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Nov 2020 07:29:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729520AbgKDM3c (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Nov 2020 07:29:32 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97579C0613D3;
        Wed,  4 Nov 2020 04:29:31 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id 141so26898874lfn.5;
        Wed, 04 Nov 2020 04:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=W9CSq1/z/w6dQrQJIH3s8/F1/jOY1033Kyx6gnaB33c=;
        b=jeDUu9lMd7TvukvIRxF8vJPZ7uEnK4VUy81MYXX/rUqLTnqWzdD6bS1RXM2KlozDmz
         dR/dmRHoAVlIIb1eagaec61jmV5OPRXK1uPWqryEQy4+4uSHnSV6fpoRTk2zg+O/NGwt
         ydc+P88OMkHeCoR8tT94pXC9hnKM+ysFH09iHpHdeqWAluTt8o9rlR9O+oaUD4vgwiQY
         YItUnUWGUSshvLUnokzLU83K1zNQCliBURVV4EVF/tl4sCAq5FnTv/zKjSFLsURGayHb
         b+zx0q5s55LPX33Ecucb43NACwsgmZ+jJvrcPlst83REb31vR+xX1yKgH0drzBQJTP3k
         sdfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=W9CSq1/z/w6dQrQJIH3s8/F1/jOY1033Kyx6gnaB33c=;
        b=ZCgFnek1xd52f/Y5c9pqA+Yb5ezC9PEZFD46kA0gFjXzWTQyPUB9OBmoBoG4UwWzrx
         sns6x8oQ23CFuAwexrl8egTQIjwYQdUqQ9sM8J/q6JaepsGu59PuBJ8+KDGr1rL+DY3o
         zbkgQswLKgeCOgkEW+346KTY4Se6b71V8EyutEtKnrw3KEMF2P8jDwnnQW02EHJ9Nj+T
         xOUhKek9oYJuSx/KVUgO600oRIwMP7rkVQD3y4ukqZCTrRFxUE/8CeLHCUq7zdI2x7WX
         WQOeLwqo/eyR2b4K5JyAdHQPq7JwhLFwMXhHJLBbn3ShLQiHdNAfeXSms1PX5rSXZsQN
         slrw==
X-Gm-Message-State: AOAM531VnhHwZZkdo1qGZfw74QSavMWdMsin/h0DCcoWSLyH0MkuAd1z
        XAMDF4IxX4GtIqYvHAdz9rOk26m97Y24bBHssqFqHscpTriARQ==
X-Google-Smtp-Source: ABdhPJzC0QxwSStYvUBIkSJFBChIeLJmCCrOE3HGww/cwv9GR0qI67cwueytwNduWUPY+1BDkFb8kYFyENvRde2DsQ8=
X-Received: by 2002:ac2:563c:: with SMTP id b28mr1263018lff.289.1604492970029;
 Wed, 04 Nov 2020 04:29:30 -0800 (PST)
MIME-Version: 1.0
References: <CGME20201104103720eucas1p1014217e751a681796ed508af22c6bb12@eucas1p1.samsung.com>
 <20201104103657.18007-1-s.nawrocki@samsung.com> <20201104103657.18007-3-s.nawrocki@samsung.com>
In-Reply-To: <20201104103657.18007-3-s.nawrocki@samsung.com>
Reply-To: cwchoi00@gmail.com
From:   Chanwoo Choi <cwchoi00@gmail.com>
Date:   Wed, 4 Nov 2020 21:28:53 +0900
Message-ID: <CAGTfZH0-xDOVUiVPoncUkekEYtGSSWb3wv1JANMrZmFo24eCVw@mail.gmail.com>
Subject: Re: [PATCH v8 2/7] interconnect: Add generic interconnect driver for
 Exynos SoCs
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Sylwester,

On Wed, Nov 4, 2020 at 7:37 PM Sylwester Nawrocki
<s.nawrocki@samsung.com> wrote:
>
> This patch adds a generic interconnect driver for Exynos SoCs in order
> to provide interconnect functionality for each "samsung,exynos-bus"
> compatible device.
>
> The SoC topology is a graph (or more specifically, a tree) and its
> edges are described by specifying in the 'interconnects' property
> the interconnect consumer path for each interconnect provider DT node.
>
> Each bus is now an interconnect provider and an interconnect node as
> well (cf. Documentation/interconnect/interconnect.rst), i.e. every bus
> registers itself as a node. Node IDs are not hard coded but rather
> assigned dynamically at runtime. This approach allows for using this
> driver with various Exynos SoCs.
>
> Frequencies requested via the interconnect API for a given node are
> propagated to devfreq using dev_pm_qos_update_request(). Please note
> that it is not an error when CONFIG_INTERCONNECT is 'n', in which
> case all interconnect API functions are no-op.
>
> The samsung,data-clk-ratio DT property is used to specify the ratio
> of the interconect bandwidth to the minimum data clock frequency
> for each bus.
>
> Due to unspecified relative probing order, -EPROBE_DEFER may be
> propagated to ensure that the parent is probed before its children.
>
> Signed-off-by: Artur =C5=9Awigo=C5=84 <a.swigon@samsung.com>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
> Changes for v8:
>  - renamed drivers/interconnect/exynos to drivers/interconnect/samsung,
>  - added missing driver sync_state callback assignment.
>
> Changes for v7:
>  - adjusted to the DT property changes: "interconnects" instead
>    of "samsung,interconnect-parent", "samsung,data-clk-ratio"
>    instead of "bus-width",
>  - adaptation to of_icc_get_from_provider() function changes
>    in v5.10-rc1.
>
> Changes for v6:
>  - corrected of_node dereferencing in exynos_icc_get_parent()
>    function,
>  - corrected initialization of icc_node->name so as to avoid
>    direct of_node->name dereferencing,
>  - added parsing of bus-width DT property.
>
> Changes for v5:
>  - adjust to renamed exynos,interconnect-parent-node property,
>  - use automatically generated platform device id as the interconect
>    node id instead of a now unavailable devfreq->id field,
>  - add icc_ prefix to some variables to make the code more self-commentin=
g,
>  - use icc_nodes_remove() instead of icc_node_del() + icc_node_destroy(),
>  - adjust to exynos,interconnect-parent-node property rename to
>    samsung,interconnect-parent,
>  - converted to a separate platform driver in drivers/interconnect.
> ---
>  drivers/interconnect/Kconfig          |   1 +
>  drivers/interconnect/Makefile         |   1 +
>  drivers/interconnect/samsung/Kconfig  |  13 +++
>  drivers/interconnect/samsung/Makefile |   4 +
>  drivers/interconnect/samsung/exynos.c | 199 ++++++++++++++++++++++++++++=
++++++
>  5 files changed, 218 insertions(+)
>  create mode 100644 drivers/interconnect/samsung/Kconfig
>  create mode 100644 drivers/interconnect/samsung/Makefile
>  create mode 100644 drivers/interconnect/samsung/exynos.c
>
> diff --git a/drivers/interconnect/Kconfig b/drivers/interconnect/Kconfig
> index 5b7204e..d637a89 100644
> --- a/drivers/interconnect/Kconfig
> +++ b/drivers/interconnect/Kconfig
> @@ -13,5 +13,6 @@ if INTERCONNECT
>
>  source "drivers/interconnect/imx/Kconfig"
>  source "drivers/interconnect/qcom/Kconfig"
> +source "drivers/interconnect/samsung/Kconfig"
>
>  endif
> diff --git a/drivers/interconnect/Makefile b/drivers/interconnect/Makefil=
e
> index d203520..c2f9e9d 100644
> --- a/drivers/interconnect/Makefile
> +++ b/drivers/interconnect/Makefile
> @@ -6,3 +6,4 @@ icc-core-objs                           :=3D core.o bulk.=
o
>  obj-$(CONFIG_INTERCONNECT)             +=3D icc-core.o
>  obj-$(CONFIG_INTERCONNECT_IMX)         +=3D imx/
>  obj-$(CONFIG_INTERCONNECT_QCOM)                +=3D qcom/
> +obj-$(CONFIG_INTERCONNECT_SAMSUNG)     +=3D samsung/
> \ No newline at end of file
> diff --git a/drivers/interconnect/samsung/Kconfig b/drivers/interconnect/=
samsung/Kconfig
> new file mode 100644
> index 0000000..508ed64
> --- /dev/null
> +++ b/drivers/interconnect/samsung/Kconfig
> @@ -0,0 +1,13 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +config INTERCONNECT_SAMSUNG
> +       bool "Samsung interconnect drivers"
> +       depends on ARCH_EXYNOS || COMPILE_TEST
> +       help
> +         Interconnect drivers for Samsung SoCs.
> +
> +
> +config INTERCONNECT_EXYNOS
> +       tristate "Exynos generic interconnect driver"
> +       depends on INTERCONNECT_SAMSUNG
> +       help
> +         Generic interconnect driver for Exynos SoCs.
> diff --git a/drivers/interconnect/samsung/Makefile b/drivers/interconnect=
/samsung/Makefile
> new file mode 100644
> index 0000000..e19d1df
> --- /dev/null
> +++ b/drivers/interconnect/samsung/Makefile
> @@ -0,0 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
> +exynos-interconnect-objs               :=3D exynos.o
> +
> +obj-$(CONFIG_INTERCONNECT_EXYNOS)      +=3D exynos-interconnect.o
> diff --git a/drivers/interconnect/samsung/exynos.c b/drivers/interconnect=
/samsung/exynos.c
> new file mode 100644
> index 0000000..6559d8c
> --- /dev/null
> +++ b/drivers/interconnect/samsung/exynos.c
> @@ -0,0 +1,199 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Exynos generic interconnect provider driver
> + *
> + * Copyright (c) 2020 Samsung Electronics Co., Ltd.
> + *
> + * Authors: Artur =C5=9Awigo=C5=84 <a.swigon@samsung.com>
> + *          Sylwester Nawrocki <s.nawrocki@samsung.com>
> + */
> +#include <linux/device.h>
> +#include <linux/interconnect-provider.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_qos.h>
> +#include <linux/slab.h>
> +
> +#define EXYNOS_ICC_DEFAULT_BUS_CLK_RATIO       8
> +
> +struct exynos_icc_priv {
> +       struct device *dev;
> +
> +       /* One interconnect node per provider */
> +       struct icc_provider provider;
> +       struct icc_node *node;
> +
> +       struct dev_pm_qos_request qos_req;
> +       u32 bus_clk_ratio;
> +};
> +
> +static struct icc_node *exynos_icc_get_parent(struct device_node *np)
> +{
> +       struct of_phandle_args args;
> +       struct icc_node_data *icc_node_data;
> +       struct icc_node *icc_node;
> +       int num, ret;
> +
> +       num =3D of_count_phandle_with_args(np, "interconnects",
> +                                        "#interconnect-cells");
> +       if (num < 1)
> +               return NULL; /* parent nodes are optional */
> +
> +       /* Get the interconnect target node */
> +       ret =3D of_parse_phandle_with_args(np, "interconnects",
> +                                       "#interconnect-cells", 0, &args);
> +       if (ret < 0)
> +               return ERR_PTR(ret);
> +
> +       icc_node_data =3D of_icc_get_from_provider(&args);
> +       of_node_put(args.np);
> +
> +       if (IS_ERR(icc_node_data))
> +               return ERR_CAST(icc_node_data);
> +
> +       icc_node =3D icc_node_data->node;
> +       kfree(icc_node_data);
> +
> +       return icc_node;
> +}
> +
> +static int exynos_generic_icc_set(struct icc_node *src, struct icc_node =
*dst)
> +{
> +       struct exynos_icc_priv *src_priv =3D src->data, *dst_priv =3D dst=
->data;
> +       s32 src_freq =3D max(src->avg_bw, src->peak_bw) / src_priv->bus_c=
lk_ratio;
> +       s32 dst_freq =3D max(dst->avg_bw, dst->peak_bw) / dst_priv->bus_c=
lk_ratio;
> +       int ret;
> +
> +       ret =3D dev_pm_qos_update_request(&src_priv->qos_req, src_freq);
> +       if (ret < 0) {
> +               dev_err(src_priv->dev, "failed to update PM QoS of %s (sr=
c)\n",
> +                       src->name);
> +               return ret;
> +       }
> +
> +       ret =3D dev_pm_qos_update_request(&dst_priv->qos_req, dst_freq);
> +       if (ret < 0) {
> +               dev_err(dst_priv->dev, "failed to update PM QoS of %s (ds=
t)\n",
> +                       dst->name);
> +               return ret;
> +       }
> +
> +       return 0;
> +}
> +
> +static struct icc_node *exynos_generic_icc_xlate(struct of_phandle_args =
*spec,
> +                                                void *data)
> +{
> +       struct exynos_icc_priv *priv =3D data;
> +
> +       if (spec->np !=3D priv->dev->parent->of_node)
> +               return ERR_PTR(-EINVAL);
> +
> +       return priv->node;
> +}
> +
> +static int exynos_generic_icc_remove(struct platform_device *pdev)
> +{
> +       struct exynos_icc_priv *priv =3D platform_get_drvdata(pdev);
> +       struct icc_node *parent_node, *node =3D priv->node;
> +
> +       parent_node =3D exynos_icc_get_parent(priv->dev->parent->of_node)=
;
> +       if (parent_node && !IS_ERR(parent_node))
> +               icc_link_destroy(node, parent_node);
> +
> +       icc_nodes_remove(&priv->provider);
> +       icc_provider_del(&priv->provider);
> +
> +       return 0;
> +}
> +
> +static int exynos_generic_icc_probe(struct platform_device *pdev)
> +{
> +       struct device *bus_dev =3D pdev->dev.parent;
> +       struct exynos_icc_priv *priv;
> +       struct icc_provider *provider;
> +       struct icc_node *icc_node, *icc_parent_node;
> +       int ret;
> +
> +       priv =3D devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +       if (!priv)
> +               return -ENOMEM;
> +
> +       priv->dev =3D &pdev->dev;
> +       platform_set_drvdata(pdev, priv);
> +
> +       provider =3D &priv->provider;
> +
> +       provider->set =3D exynos_generic_icc_set;
> +       provider->aggregate =3D icc_std_aggregate;
> +       provider->xlate =3D exynos_generic_icc_xlate;
> +       provider->dev =3D bus_dev;
> +       provider->inter_set =3D true;
> +       provider->data =3D priv;
> +
> +       ret =3D icc_provider_add(provider);
> +       if (ret < 0)
> +               return ret;
> +
> +       icc_node =3D icc_node_create(pdev->id);
> +       if (IS_ERR(icc_node)) {
> +               ret =3D PTR_ERR(icc_node);
> +               goto err_prov_del;
> +       }
> +
> +       priv->node =3D icc_node;
> +       icc_node->name =3D devm_kasprintf(&pdev->dev, GFP_KERNEL, "%pOFn"=
,
> +                                       bus_dev->of_node);
> +       if (of_property_read_u32(bus_dev->of_node, "samsung,data-clock-ra=
tio",
> +                                &priv->bus_clk_ratio))
> +               priv->bus_clk_ratio =3D EXYNOS_ICC_DEFAULT_BUS_CLK_RATIO;
> +
> +       /*
> +        * Register a PM QoS request for the parent (devfreq) device.
> +        */
> +       ret =3D dev_pm_qos_add_request(bus_dev, &priv->qos_req,
> +                                    DEV_PM_QOS_MIN_FREQUENCY, 0);
> +       if (ret < 0)
> +               goto err_node_del;
> +
> +       icc_node->data =3D priv;
> +       icc_node_add(icc_node, provider);
> +
> +       icc_parent_node =3D exynos_icc_get_parent(bus_dev->of_node);
> +       if (IS_ERR(icc_parent_node)) {
> +               ret =3D PTR_ERR(icc_parent_node);
> +               goto err_pmqos_del;
> +       }
> +       if (icc_parent_node) {
> +               ret =3D icc_link_create(icc_node, icc_parent_node->id);
> +               if (ret < 0)
> +                       goto err_pmqos_del;
> +       }
> +
> +       return 0;
> +
> +err_pmqos_del:
> +       dev_pm_qos_remove_request(&priv->qos_req);
> +err_node_del:
> +       icc_nodes_remove(provider);
> +err_prov_del:
> +       icc_provider_del(provider);
> +       return ret;
> +}
> +
> +static struct platform_driver exynos_generic_icc_driver =3D {
> +       .driver =3D {
> +               .name =3D "exynos-generic-icc",
> +               .sync_state =3D icc_sync_state,
> +       },
> +       .probe =3D exynos_generic_icc_probe,
> +       .remove =3D exynos_generic_icc_remove,
> +};
> +module_platform_driver(exynos_generic_icc_driver);
> +
> +MODULE_DESCRIPTION("Exynos generic interconnect driver");
> +MODULE_AUTHOR("Artur =C5=9Awigo=C5=84 <a.swigon@samsung.com>");
> +MODULE_AUTHOR("Sylwester Nawrocki <s.nawrocki@samsung.com>");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:exynos-generic-icc");
> --
> 2.7.4
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

--=20
Best Regards,
Chanwoo Choi

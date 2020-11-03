Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8F22A3FED
	for <lists+linux-pm@lfdr.de>; Tue,  3 Nov 2020 10:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727668AbgKCJXj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Nov 2020 04:23:39 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:48796 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727676AbgKCJXh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Nov 2020 04:23:37 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20201103092331epoutp03231c36de97f9de463e9ee90f41c9519e~D9SBqUl4B0786507865epoutp03n
        for <linux-pm@vger.kernel.org>; Tue,  3 Nov 2020 09:23:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20201103092331epoutp03231c36de97f9de463e9ee90f41c9519e~D9SBqUl4B0786507865epoutp03n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1604395411;
        bh=t1B906RqYkSGezfQu6S2EAYprv6ig9jtCZKRr3yBMGI=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Ij3/UTDZiOz2aqcfSdvrMabZLWObEHyYAXLg8t1NNnXpcDdszKeXZ3oCMS59Fg/DQ
         zXRs+o8XJ1adlL4xDGDp0pxCVv4S/zxql3+nB77DKsbWAFP6oo3po8LMnoWmET4gxw
         y5MeFF/FB5N55u8/4JB/OE/8C2gIgP9iHXSWsTSQ=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20201103092330epcas1p488beb56652baa99b89d476de5edfe23b~D9SA1_DHp0459604596epcas1p4J;
        Tue,  3 Nov 2020 09:23:30 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.153]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4CQPTr5mm7zMqYkV; Tue,  3 Nov
        2020 09:23:28 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        42.11.10463.09121AF5; Tue,  3 Nov 2020 18:23:28 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20201103092327epcas1p1b44e9a0095459568b93e967a85bbcfd0~D9R9zV4Yh0967009670epcas1p1N;
        Tue,  3 Nov 2020 09:23:27 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201103092327epsmtrp1904f079a45fcbee2db81cd54dc35c5b5~D9R9ycR4p0737907379epsmtrp1Q;
        Tue,  3 Nov 2020 09:23:27 +0000 (GMT)
X-AuditID: b6c32a38-efbff700000028df-40-5fa121905268
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        58.43.13470.F8121AF5; Tue,  3 Nov 2020 18:23:27 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20201103092327epsmtip1419c15d45ccb64ab9ea98583891761ed~D9R9dpE_Y3123331233epsmtip1J;
        Tue,  3 Nov 2020 09:23:27 +0000 (GMT)
Subject: Re: [PATCH v7 2/6] interconnect: Add generic interconnect driver
 for Exynos SoCs
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        georgi.djakov@linaro.org, krzk@kernel.org
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        a.swigon@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, dri-devel@lists.freedesktop.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <88af4e53-6c7a-c2e6-ad28-a9d6bb5bf623@samsung.com>
Date:   Tue, 3 Nov 2020 18:37:25 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20201030125149.8227-3-s.nawrocki@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHJsWRmVeSWpSXmKPExsWy7bCmnu4ExYXxBhf2a1vcn9fKaLFxxnpW
        i/lHzrFaXPn6ns1i+t5NbBaT7k9gsTh/fgO7xeVdc9gsPvceYbSYcX4fk8XaI3fZLW43rmCz
        aN17hN3i8Jt2VosZk1+yOfB7bFrVyeZx59oeNo/73ceZPPq2rGL0+LxJLoA1KtsmIzUxJbVI
        ITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE31VbJxSdA1y0zB+hcJYWyxJxSoFBAYnGx
        kr6dTVF+aUmqQkZ+cYmtUmpBSk6BZYFecWJucWleul5yfq6VoYGBkSlQYUJ2RsPCyUwFv2Mq
        HtzRaWDc7d3FyMkhIWAisbVxL0sXIxeHkMAORonJf7cxQzifGCXOz9nIBOF8Y5RYePoDI0zL
        9wffwWwhgb2MEg27uCGK3jNKPNv1ghUkISwQLfFw8i6gURwcIgIxEuvfRYCEmQVOMEkcuSMI
        YrMJaEnsf3GDDcTmF1CUuPrjMdhMXgE7iUUzTzCB2CwCKhL9p5ayg9iiAmESJ7e1QNUISpyc
        +YQFxOYUsJZ41bqPFWK+uMStJ/OZIGx5ieats8G+kRC4wSFx8N0KVogHXCQmXTvKDmELS7w6
        vgXKlpJ42d8GZVdLrDx5hA2iuYNRYsv+C1DNxhL7l05mAnmMWUBTYv0ufYiwosTO33MZIRbz
        Sbz72sMKUiIhwCvR0SYEUaIscfnBXSYIW1JicXsn2wRGpVlI3pmF5IVZSF6YhbBsASPLKkax
        1ILi3PTUYsMCE+S43sQITshaFjsY5779oHeIkYmD8RCjBAezkghvTeS8eCHelMTKqtSi/Pii
        0pzU4kOMpsAAnsgsJZqcD8wJeSXxhqZGxsbGFiaGZqaGhkrivH+0O+KFBNITS1KzU1MLUotg
        +pg4OKUamOZcej33wu+ydQKXXC5O+zbDL0lbJu+adXOFpahnIqsBX2KtOv/kI1rHE/4zqLvu
        UpLgW+aet6XBbJp974qJm5YUflk6c7+uz6Lps78/t774//KJiRV9W/SUF/ebpzwsnFd+45Lp
        jCe3V+X1ZtzwXJbEreASItprz+xlFLrvd8Vvj+fcMat/ywjFd2yZtEl12rtDS+8u4Dz/SaVD
        I7/ySmvFimdNEy2macWyNx75snj5O3ZlqczamRXcP9f3XwsyO3PxR79+It9pw+d67M1h2znP
        zVp+I+PKV8HYW/fmXGK6xfwn5vDK6gsLll2zV3lw45jmv+T01eedaoSmPl1xp5XL+8bJDm2W
        v0qJU82Dlx1VYinOSDTUYi4qTgQA2fSBolEEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJIsWRmVeSWpSXmKPExsWy7bCSnG6/4sJ4g32dqhb357UyWmycsZ7V
        Yv6Rc6wWV76+Z7OYvncTm8Wk+xNYLM6f38BucXnXHDaLz71HGC1mnN/HZLH2yF12i9uNK9gs
        WvceYbc4/Kad1WLG5JdsDvwem1Z1snncubaHzeN+93Emj74tqxg9Pm+SC2CN4rJJSc3JLEst
        0rdL4MpoWDiZqeB3TMWDOzoNjLu9uxg5OSQETCS+P/jOCGILCexmlLh7hwkiLikx7eJR5i5G
        DiBbWOLw4eIuRi6gkreMEi0L1rCAxIUFoiWmfnAEKRcRiJE4NXkWC0gNs8AJJomPqx4wQTTs
        Z5RYdPIxC0gVm4CWxP4XN9hAbH4BRYmrPx6DLeYVsJNYNPME2GIWARWJ/lNL2UFsUYEwiZ1L
        HjNB1AhKnJz5BGwOp4C1xKvWfawgNrOAusSfeZeYIWxxiVtP5jNB2PISzVtnM09gFJ6FpH0W
        kpZZSFpmIWlZwMiyilEytaA4Nz232LDAMC+1XK84Mbe4NC9dLzk/dxMjODa1NHcwbl/1Qe8Q
        IxMH4yFGCQ5mJRHemsh58UK8KYmVValF+fFFpTmpxYcYpTlYlMR5bxQujBMSSE8sSc1OTS1I
        LYLJMnFwSjUweTMfTZjbwpFRFhhet5HB8/I2+YMvtmfyL7jgeGXyuqbk6b07zW/zL2CQ3qbw
        PHKFqdk2oahnc7zNgjgLFL5ppgSlv5YU6k/zzrK10BZz3XNb6pPmtRO8kzV7tmy9pKZ0yE3i
        T+vCWU2RLMpbdVYc6DTgvtit0aKzVW+nlp0m9zKdxf9yii4lR66Lzfx3+GCt+xxmxgqRRMYl
        lj/r4huC1qxzU6v4fYFHulE34NOfj7e9BR58ZOVSne/LMoP/a97fr+WXtA9rbRKtFN8478Ck
        A6dnPxAptWYvmx1bbGxStUa7PPetCEtogUjMsqnM6lPmv4+59vLMxgI3rpmbRGtEM9iZPj3R
        YuWOlLcUvq7EUpyRaKjFXFScCACftNB+PAMAAA==
X-CMS-MailID: 20201103092327epcas1p1b44e9a0095459568b93e967a85bbcfd0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20201030125301eucas1p218b0e654cb4c826b05280f28836da8d9
References: <20201030125149.8227-1-s.nawrocki@samsung.com>
        <CGME20201030125301eucas1p218b0e654cb4c826b05280f28836da8d9@eucas1p2.samsung.com>
        <20201030125149.8227-3-s.nawrocki@samsung.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Sylwester,

On 10/30/20 9:51 PM, Sylwester Nawrocki wrote:
> This patch adds a generic interconnect driver for Exynos SoCs in order
> to provide interconnect functionality for each "samsung,exynos-bus"
> compatible device.
> 
> The SoC topology is a graph (or more specifically, a tree) and its
> edges are specified using the 'samsung,interconnect-parent' in the

samsung,interconnect-parent -> interconnects?


> DT. Due to unspecified relative probing order, -EPROBE_DEFER may be
> propagated to ensure that the parent is probed before its children.
> 
> Each bus is now an interconnect provider and an interconnect node as
> well (cf. Documentation/interconnect/interconnect.rst), i.e. every bus
> registers itself as a node. Node IDs are not hardcoded but rather
> assigned dynamically at runtime. This approach allows for using this
> driver with various Exynos SoCs.
> 
> Frequencies requested via the interconnect API for a given node are
> propagated to devfreq using dev_pm_qos_update_request(). Please note
> that it is not an error when CONFIG_INTERCONNECT is 'n', in which
> case all interconnect API functions are no-op.
> 
> The bus-width DT property is to determine the interconnect data
> width and traslate requested bandwidth to clock frequency for each
> bus.
> 
> Signed-off-by: Artur Świgoń <a.swigon@samsung.com>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
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
>  - add icc_ prefix to some variables to make the code more self-commenting,
>  - use icc_nodes_remove() instead of icc_node_del() + icc_node_destroy(),
>  - adjust to exynos,interconnect-parent-node property rename to
>    samsung,interconnect-parent,
>  - converted to a separate platform driver in drivers/interconnect.
> 
> ---
>  drivers/interconnect/Kconfig         |   1 +
>  drivers/interconnect/Makefile        |   1 +
>  drivers/interconnect/exynos/Kconfig  |   6 ++
>  drivers/interconnect/exynos/Makefile |   4 +
>  drivers/interconnect/exynos/exynos.c | 198 +++++++++++++++++++++++++++++++++++
>  5 files changed, 210 insertions(+)
>  create mode 100644 drivers/interconnect/exynos/Kconfig
>  create mode 100644 drivers/interconnect/exynos/Makefile
>  create mode 100644 drivers/interconnect/exynos/exynos.c
> 
> diff --git a/drivers/interconnect/Kconfig b/drivers/interconnect/Kconfig
> index 5b7204e..eca6eda 100644
> --- a/drivers/interconnect/Kconfig
> +++ b/drivers/interconnect/Kconfig
> @@ -11,6 +11,7 @@ menuconfig INTERCONNECT
>  
>  if INTERCONNECT
>  
> +source "drivers/interconnect/exynos/Kconfig"
>  source "drivers/interconnect/imx/Kconfig"
>  source "drivers/interconnect/qcom/Kconfig"
>  
> diff --git a/drivers/interconnect/Makefile b/drivers/interconnect/Makefile
> index d203520..665538d 100644
> --- a/drivers/interconnect/Makefile
> +++ b/drivers/interconnect/Makefile
> @@ -4,5 +4,6 @@ CFLAGS_core.o				:= -I$(src)
>  icc-core-objs				:= core.o bulk.o
>  
>  obj-$(CONFIG_INTERCONNECT)		+= icc-core.o
> +obj-$(CONFIG_INTERCONNECT_EXYNOS)	+= exynos/
>  obj-$(CONFIG_INTERCONNECT_IMX)		+= imx/
>  obj-$(CONFIG_INTERCONNECT_QCOM)		+= qcom/
> diff --git a/drivers/interconnect/exynos/Kconfig b/drivers/interconnect/exynos/Kconfig
> new file mode 100644
> index 0000000..e51e52e
> --- /dev/null
> +++ b/drivers/interconnect/exynos/Kconfig
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +config INTERCONNECT_EXYNOS
> +	tristate "Exynos generic interconnect driver"
> +	depends on ARCH_EXYNOS || COMPILE_TEST
> +	help
> +	  Generic interconnect driver for Exynos SoCs.
> diff --git a/drivers/interconnect/exynos/Makefile b/drivers/interconnect/exynos/Makefile
> new file mode 100644
> index 0000000..e19d1df
> --- /dev/null
> +++ b/drivers/interconnect/exynos/Makefile
> @@ -0,0 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
> +exynos-interconnect-objs		:= exynos.o
> +
> +obj-$(CONFIG_INTERCONNECT_EXYNOS)	+= exynos-interconnect.o
> diff --git a/drivers/interconnect/exynos/exynos.c b/drivers/interconnect/exynos/exynos.c
> new file mode 100644
> index 0000000..772d1fc
> --- /dev/null
> +++ b/drivers/interconnect/exynos/exynos.c
> @@ -0,0 +1,198 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Exynos generic interconnect provider driver
> + *
> + * Copyright (c) 2020 Samsung Electronics Co., Ltd.
> + *
> + * Authors: Artur Świgoń <a.swigon@samsung.com>
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
> +#define EXYNOS_ICC_DEFAULT_BUS_CLK_RATIO	8
> +
> +struct exynos_icc_priv {
> +	struct device *dev;
> +
> +	/* One interconnect node per provider */
> +	struct icc_provider provider;
> +	struct icc_node *node;
> +
> +	struct dev_pm_qos_request qos_req;
> +	u32 bus_clk_ratio;
> +};
> +
> +static struct icc_node *exynos_icc_get_parent(struct device_node *np)
> +{
> +	struct of_phandle_args args;
> +	struct icc_node_data *icc_node_data;
> +	struct icc_node *icc_node;
> +	int num, ret;
> +
> +	num = of_count_phandle_with_args(np, "interconnects",
> +					 "#interconnect-cells");
> +	if (num < 1)
> +		return NULL; /* parent nodes are optional */
> +
> +	/* Get the interconnect target node */
> +	ret = of_parse_phandle_with_args(np, "interconnects",
> +					"#interconnect-cells", 0, &args);
> +	if (ret < 0)
> +		return ERR_PTR(ret);
> +
> +	icc_node_data = of_icc_get_from_provider(&args);
> +	of_node_put(args.np);
> +
> +	if (IS_ERR(icc_node_data))
> +		return ERR_CAST(icc_node_data);
> +
> +	icc_node = icc_node_data->node;
> +	kfree(icc_node_data);
> +
> +	return icc_node;
> +}

I have a question about exynos_icc_get_parent().
As I checked, this function returns the only one icc_node
as parent node. But, bus_display dt node in the exynos4412.dtsi
specifies the two interconnect node as following with bus_leftbus, bus_dmc,

When I checked the return value of exynos_icc_get_parent()
during probing for bus_display device, exynos_icc_get_parent() function
only returns 'bus_leftbus' icc_node. Do you need to add two phandle
of icc node?

diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
index d07739ec8740..9e4045ceb6ab 100644
--- a/arch/arm/boot/dts/exynos4412.dtsi
+++ b/arch/arm/boot/dts/exynos4412.dtsi
@@ -472,7 +472,7 @@
                        clocks = <&clock CLK_ACLK160>;
                        clock-names = "bus";
                        operating-points-v2 = <&bus_display_opp_table>;
                        interconnects = <&bus_leftbus &bus_dmc>;
                        #interconnect-cells = <0>;
                        status = "disabled";
                };


> +
> +static int exynos_generic_icc_set(struct icc_node *src, struct icc_node *dst)
> +{
> +	struct exynos_icc_priv *src_priv = src->data, *dst_priv = dst->data;
> +	s32 src_freq = max(src->avg_bw, src->peak_bw) / src_priv->bus_clk_ratio;
> +	s32 dst_freq = max(dst->avg_bw, dst->peak_bw) / dst_priv->bus_clk_ratio;
> +	int ret;
> +
> +	ret = dev_pm_qos_update_request(&src_priv->qos_req, src_freq);
> +	if (ret < 0) {
> +		dev_err(src_priv->dev, "failed to update PM QoS of %s (src)\n",
> +			src->name);
> +		return ret;
> +	}
> +
> +	ret = dev_pm_qos_update_request(&dst_priv->qos_req, dst_freq);
> +	if (ret < 0) {
> +		dev_err(dst_priv->dev, "failed to update PM QoS of %s (dst)\n",
> +			dst->name);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static struct icc_node *exynos_generic_icc_xlate(struct of_phandle_args *spec,
> +						 void *data)
> +{
> +	struct exynos_icc_priv *priv = data;
> +
> +	if (spec->np != priv->dev->parent->of_node)
> +		return ERR_PTR(-EINVAL);
> +
> +	return priv->node;
> +}
> +
> +static int exynos_generic_icc_remove(struct platform_device *pdev)
> +{
> +	struct exynos_icc_priv *priv = platform_get_drvdata(pdev);
> +	struct icc_node *parent_node, *node = priv->node;
> +
> +	parent_node = exynos_icc_get_parent(priv->dev->parent->of_node);
> +	if (parent_node && !IS_ERR(parent_node))
> +		icc_link_destroy(node, parent_node);
> +
> +	icc_nodes_remove(&priv->provider);
> +	icc_provider_del(&priv->provider);
> +
> +	return 0;
> +}
> +
> +static int exynos_generic_icc_probe(struct platform_device *pdev)
> +{
> +	struct device *bus_dev = pdev->dev.parent;
> +	struct exynos_icc_priv *priv;
> +	struct icc_provider *provider;
> +	struct icc_node *icc_node, *icc_parent_node;
> +	int ret;
> +
> +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->dev = &pdev->dev;
> +	platform_set_drvdata(pdev, priv);
> +
> +	provider = &priv->provider;
> +
> +	provider->set = exynos_generic_icc_set;
> +	provider->aggregate = icc_std_aggregate;
> +	provider->xlate = exynos_generic_icc_xlate;
> +	provider->dev = bus_dev;
> +	provider->inter_set = true;
> +	provider->data = priv;
> +
> +	ret = icc_provider_add(provider);
> +	if (ret < 0)
> +		return ret;
> +
> +	icc_node = icc_node_create(pdev->id);
> +	if (IS_ERR(icc_node)) {
> +		ret = PTR_ERR(icc_node);
> +		goto err_prov_del;
> +	}
> +
> +	priv->node = icc_node;
> +	icc_node->name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "%pOFn",
> +					bus_dev->of_node);
> +	if (of_property_read_u32(bus_dev->of_node, "samsung,data-clock-ratio",
> +				 &priv->bus_clk_ratio))
> +		priv->bus_clk_ratio = EXYNOS_ICC_DEFAULT_BUS_CLK_RATIO;
> +
> +	/*
> +	 * Register a PM QoS request for the parent (devfreq) device.
> +	 */
> +	ret = dev_pm_qos_add_request(bus_dev, &priv->qos_req,
> +				     DEV_PM_QOS_MIN_FREQUENCY, 0);
> +	if (ret < 0)
> +		goto err_node_del;
> +
> +	icc_node->data = priv;
> +	icc_node_add(icc_node, provider);
> +
> +	icc_parent_node = exynos_icc_get_parent(bus_dev->of_node);
> +	if (IS_ERR(icc_parent_node)) {
> +		ret = PTR_ERR(icc_parent_node);
> +		goto err_pmqos_del;
> +	}
> +	if (icc_parent_node) {
> +		ret = icc_link_create(icc_node, icc_parent_node->id);
> +		if (ret < 0)
> +			goto err_pmqos_del;
> +	}
> +
> +	return 0;
> +
> +err_pmqos_del:
> +	dev_pm_qos_remove_request(&priv->qos_req);
> +err_node_del:
> +	icc_nodes_remove(provider);
> +err_prov_del:
> +	icc_provider_del(provider);
> +	return ret;
> +}
> +
> +static struct platform_driver exynos_generic_icc_driver = {
> +	.driver = {
> +		.name = "exynos-generic-icc",
> +	},
> +	.probe = exynos_generic_icc_probe,
> +	.remove = exynos_generic_icc_remove,
> +};
> +module_platform_driver(exynos_generic_icc_driver);
> +
> +MODULE_DESCRIPTION("Exynos generic interconnect driver");
> +MODULE_AUTHOR("Artur Świgoń <a.swigon@samsung.com>");
> +MODULE_AUTHOR("Sylwester Nawrocki <s.nawrocki@samsung.com>");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:exynos-generic-icc");
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics

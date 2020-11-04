Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1759E2A6478
	for <lists+linux-pm@lfdr.de>; Wed,  4 Nov 2020 13:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729583AbgKDMhe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Wed, 4 Nov 2020 07:37:34 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41483 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728523AbgKDMhe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Nov 2020 07:37:34 -0500
Received: by mail-wr1-f65.google.com with SMTP id s9so21858483wro.8;
        Wed, 04 Nov 2020 04:37:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=aPE6BsDWzXc+KakR/ZtGTT7r35e3EQiLtx1b9EAe820=;
        b=jtQ2K2mTBJgXgtWJMf9Inmj3mfyb4OFXFvaxgpCqNnzwdFOwuCs4GVuL0QqfyDYB46
         8TosRjGqO9d9I2yJxbGGvOhoiRD0cSML6Eo82ZPNmpS/w66ezrIO5vliooY9jW/ZBfk4
         bR8eIYJckS+fFXapw5IFdvVDRt13pDF7bXwBqmmK79Gbu7X2scwyEZdlrAJZn5nX42tg
         JNH2QSC7vxKApsYUSlTZgbXhruczMQeQAYImtjALKsA2d36fa8X7LouSWpPBgIKtyq+I
         bNPz3/6fBSG7OnXspVxqPEGRd1PDKxXwiv2whsEbHQ/taneTXc4+qDhUO18cRWhy4pf1
         y8Xw==
X-Gm-Message-State: AOAM531V4TcEh2gk3SnRNZvBZe55KlsZL82TmsnCt940jj92A+ORDBTo
        RuwyP8LTKuquVHbsRs+lckw=
X-Google-Smtp-Source: ABdhPJwKfOeqc27FocjtFaKOEUlce8qKmIPqr9gDR9kjQdHt6UJEC263ArSfSMQTdZgIlgZbwI+wRg==
X-Received: by 2002:adf:fd49:: with SMTP id h9mr33638867wrs.115.1604493451973;
        Wed, 04 Nov 2020 04:37:31 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id a12sm2352845wrr.31.2020.11.04.04.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 04:37:30 -0800 (PST)
Date:   Wed, 4 Nov 2020 13:37:29 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     georgi.djakov@linaro.org, cw00.choi@samsung.com,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        a.swigon@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v8 2/7] interconnect: Add generic interconnect driver for
 Exynos SoCs
Message-ID: <20201104123729.GA13371@kozik-lap>
References: <20201104103657.18007-1-s.nawrocki@samsung.com>
 <CGME20201104103720eucas1p1014217e751a681796ed508af22c6bb12@eucas1p1.samsung.com>
 <20201104103657.18007-3-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20201104103657.18007-3-s.nawrocki@samsung.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 04, 2020 at 11:36:52AM +0100, Sylwester Nawrocki wrote:
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
> Signed-off-by: Artur Świgoń <a.swigon@samsung.com>
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
>  - add icc_ prefix to some variables to make the code more self-commenting,
>  - use icc_nodes_remove() instead of icc_node_del() + icc_node_destroy(),
>  - adjust to exynos,interconnect-parent-node property rename to
>    samsung,interconnect-parent,
>  - converted to a separate platform driver in drivers/interconnect.
> ---
>  drivers/interconnect/Kconfig          |   1 +
>  drivers/interconnect/Makefile         |   1 +
>  drivers/interconnect/samsung/Kconfig  |  13 +++
>  drivers/interconnect/samsung/Makefile |   4 +
>  drivers/interconnect/samsung/exynos.c | 199 ++++++++++++++++++++++++++++++++++
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
> diff --git a/drivers/interconnect/Makefile b/drivers/interconnect/Makefile
> index d203520..c2f9e9d 100644
> --- a/drivers/interconnect/Makefile
> +++ b/drivers/interconnect/Makefile
> @@ -6,3 +6,4 @@ icc-core-objs				:= core.o bulk.o
>  obj-$(CONFIG_INTERCONNECT)		+= icc-core.o
>  obj-$(CONFIG_INTERCONNECT_IMX)		+= imx/
>  obj-$(CONFIG_INTERCONNECT_QCOM)		+= qcom/
> +obj-$(CONFIG_INTERCONNECT_SAMSUNG)	+= samsung/
> \ No newline at end of file

This needs a fix.

> diff --git a/drivers/interconnect/samsung/Kconfig b/drivers/interconnect/samsung/Kconfig
> new file mode 100644
> index 0000000..508ed64
> --- /dev/null
> +++ b/drivers/interconnect/samsung/Kconfig
> @@ -0,0 +1,13 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +config INTERCONNECT_SAMSUNG
> +	bool "Samsung interconnect drivers"

"Samsung SoC interconnect drivers"

> +	depends on ARCH_EXYNOS || COMPILE_TEST

Don't the depend on INTERCONNECT?

> +	help
> +	  Interconnect drivers for Samsung SoCs.
> +
> +

One line break

> +config INTERCONNECT_EXYNOS
> +	tristate "Exynos generic interconnect driver"
> +	depends on INTERCONNECT_SAMSUNG

How about:
default y if ARCH_EXYNOS

> +	help
> +	  Generic interconnect driver for Exynos SoCs.
> diff --git a/drivers/interconnect/samsung/Makefile b/drivers/interconnect/samsung/Makefile
> new file mode 100644
> index 0000000..e19d1df
> --- /dev/null
> +++ b/drivers/interconnect/samsung/Makefile
> @@ -0,0 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
> +exynos-interconnect-objs		:= exynos.o

What is this line for?

Best regards,
Krzysztof


> +
> +obj-$(CONFIG_INTERCONNECT_EXYNOS)	+= exynos-interconnect.o
> diff --git a/drivers/interconnect/samsung/exynos.c b/drivers/interconnect/samsung/exynos.c
> new file mode 100644
> index 0000000..6559d8c

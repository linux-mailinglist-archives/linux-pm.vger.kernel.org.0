Return-Path: <linux-pm+bounces-22412-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77163A3BD01
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 12:36:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4F05177CA7
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 11:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105751DF273;
	Wed, 19 Feb 2025 11:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="qOOdExDL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oN02PbD1"
X-Original-To: linux-pm@vger.kernel.org
Received: from flow-a5-smtp.messagingengine.com (flow-a5-smtp.messagingengine.com [103.168.172.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968FA1D88D7;
	Wed, 19 Feb 2025 11:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739964871; cv=none; b=SuB3PLI3Sf5w1tvP/DrBaa2nMv59rT+l8xX2dJdvOidJkjcXcpKKPmg0JbpQn6pYCjgnQp8rwZlai66MFfv6F4y7XRsKMZ3AoiuorzY8vbPPQ9MkID3qZOYOpwiY6QvoWTmNHURJ2zm/hfxalLWOUo6Qz1w86dEXGqU63k1x6z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739964871; c=relaxed/simple;
	bh=ZKFJCSUhaRPnsN8qScYBCMA8IrkgHkfPq42YAQBpoCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=smVI44VEHin0p+5eYVQtRIuqj/gPPVeDHNbMVhy8t0dD1gvh2GBytrTccbW4xlwc3QhTB1Fd3WxGeY83BZJ5rg+H+ySxzbN/oRIkuVf8iU0Bcd3fRhuxa22GTrhBsLXbApNWWYJx/Nl8xc+fna64OS5Zwpvgcipk6vEUo3Sbwek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=qOOdExDL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oN02PbD1; arc=none smtp.client-ip=103.168.172.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailflow.phl.internal (Postfix) with ESMTP id 7C624201775;
	Wed, 19 Feb 2025 06:34:26 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 19 Feb 2025 06:34:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1739964866; x=1739972066; bh=4Nqfbpvtsx
	rCpCAe9ieHrcp2u9odpK5GUYTz6e9Gvcw=; b=qOOdExDLXjjPMISghsMmokH//H
	pKMd4eMzxrx0ZyY9vtzoTtByFkET7JXrDWbYDO1oK30VKmu59aQj4aGg3YUvDEuA
	9YUhZAe+3IgZz9yeE1P+JhA/RctHgTXCHL2f/G/vg8euOlTf6iQBfPOgksaaNwW9
	ZKzAKzkQ6D6oZKl1gPiOWaKeedYWpHJNRQuL1Frrs36NoYbPTA8u/6IwnugxjWyt
	RBJcgiSiwkRbis/sq/GbmKGN35f5CdiQ2L7OieaTqPWqXOfMgHANVEBFaeWyXnrA
	tKH5ggRelCim2M+WuAuvnF22o3ENaw+is0G7wCP1mEZ1GfkjmF0euIh0lh0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739964866; x=1739972066; bh=4NqfbpvtsxrCpCAe9ieHrcp2u9odpK5GUYT
	z6e9Gvcw=; b=oN02PbD1tshBdOaahZD3IZQHyU/P2zULLig6Xe6xg3mCwRBwAqT
	4uoHxs+F4Tu1TNRf6GI4fa5mbiekOg+95YkaHxUi2Aq3cOZnHGOXVUM4Cf/zMg03
	k+MZpjiCMED/sPwXMgQYqf7WsLGn2ViB7av7ZnE2LfAikXdjLQeAef7LrbNLp8en
	F4G3x8IEEO4y6ko9syjeMiy3PLPWj7bKI+fO6UNYzt9DH9ZQfQMwTWWUE0kStlKH
	PLU4wwrE6RzZAknyGgOwP/+v7LrkUJHG5X0YAc140VWErOY8BjDxy41ieMdiEWUX
	rcR+p+tbqlkUG7HklvfNJKx+G2Cji3mkbHw==
X-ME-Sender: <xms:wMG1Z1x1BEozbmwDrSZZpuNwd5qkTqSqWXy9b4GoBI8G8U9cur3m5Q>
    <xme:wMG1Z1S8HMZDIizVqpZsQaqSlDCgD5IMOy9dQbNC-WQJKi8hmJz7GVvPocro4pcPj
    STDKX8ux_daKLz5IUA>
X-ME-Received: <xmr:wMG1Z_X_P5jXN9xGnJ7iFDfsyUxScsOHA-VRKExjY9iQHYeTve_g0hfzOCdx3gnaSRuLDtm5AKVvC-89LgtQD67uXYQyqaSlHFo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeigedugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttdej
    necuhfhrohhmpeflrghnnhgvucfirhhunhgruhcuoehjsehjrghnnhgruhdrnhgvtheqne
    cuggftrfgrthhtvghrnhepgfdvffevleegudejfeefheehkeehleehfefgjefffeetudeg
    tefhuedufeehfeetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepjhesjhgrnhhnrghurdhnvghtpdhnsggprhgtphhtthhopedvvddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepfhhnkhhlrdhkvghrnhgvlhesghhmrghilhdrtg
    homhdprhgtphhtthhopehsvhgvnhesshhvvghnphgvthgvrhdruggvvhdprhgtphhtthho
    pegrlhihshhsrgesrhhoshgvnhiifigvihhgrdhiohdprhgtphhtthhopehrohgshheskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hmrghrtggrnhesmhgrrhgtrghnrdhsthdprhgtphhtthhopehulhhfrdhhrghnshhsohhn
    sehlihhnrghrohdrohhrghdprhgtphhtthhopehmtghhvghhrggssehkvghrnhgvlhdroh
    hrgh
X-ME-Proxy: <xmx:wMG1Z3iF9QNbhjo-8PX3LKCQwuAF6-JBImBeIIG-PzD5YPrA6eLnXg>
    <xmx:wMG1Z3BoV5xeMZoy3kxKRf-pez8JyeaqatcOxJ_uuiiD7K_GnJrJDQ>
    <xmx:wMG1ZwK0MgHxmIWva-dMZ8fuT7rXwWLyLL_H2o7pFd9TaB7HrfHeXw>
    <xmx:wMG1Z2ACxjCWiBGuIS0A3JIqY-BRzRIA9SNMZjIJ6EDayyFKDT3exA>
    <xmx:wsG1Z-UCoOJaVt1XhwvLDMi3csvUhUXsVBcUYf5_CQBTD-6EMfwPTspR>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Feb 2025 06:34:24 -0500 (EST)
Date: Wed, 19 Feb 2025 12:34:22 +0100
From: Janne Grunau <j@jannau.net>
To: fnkl.kernel@gmail.com
Cc: Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Hector Martin <marcan@marcan.st>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-media@vger.kernel.org, imx@lists.linux.dev,
	Eileen Yoon <eyn@gmx.com>, Asahi Lina <lina@asahilina.net>
Subject: Re: [PATCH 4/5] media: apple: Add Apple ISP driver
Message-ID: <20250219113422.GA26386@robin.jannau.net>
References: <20250219-isp-v1-0-6d3e89b67c31@gmail.com>
 <20250219-isp-v1-4-6d3e89b67c31@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250219-isp-v1-4-6d3e89b67c31@gmail.com>

Hej,

On Wed, Feb 19, 2025 at 10:27:00AM +0100, Sasha Finkelstein via B4 Relay wrote:
> From: Eileen Yoon <eyn@gmx.com>
> 
> This is the ISP and camera module present on certain Apple laptops
> 
> Signed-off-by: Eileen Yoon <eyn@gmx.com>
> Co-developed-by: Hector Martin <marcan@marcan.st>
> Signed-off-by: Hector Martin <marcan@marcan.st>
> Co-developed-by: Asahi Lina <lina@asahilina.net>
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> Co-developed-by: Janne Grunau <j@jannau.net>
> Signed-off-by: Janne Grunau <j@jannau.net>
> Co-developed-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
> Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
> ---
>  MAINTAINERS                                  |   1 +
>  drivers/media/platform/Kconfig               |   1 +
>  drivers/media/platform/Makefile              |   1 +
>  drivers/media/platform/apple/Kconfig         |   5 +
>  drivers/media/platform/apple/Makefile        |   3 +
>  drivers/media/platform/apple/isp/Kconfig     |  16 +
>  drivers/media/platform/apple/isp/Makefile    |   3 +
>  drivers/media/platform/apple/isp/isp-cam.c   | 414 ++++++++++++
>  drivers/media/platform/apple/isp/isp-cam.h   |  21 +
>  drivers/media/platform/apple/isp/isp-cmd.c   | 635 +++++++++++++++++++
>  drivers/media/platform/apple/isp/isp-cmd.h   | 692 ++++++++++++++++++++
>  drivers/media/platform/apple/isp/isp-drv.c   | 586 +++++++++++++++++
>  drivers/media/platform/apple/isp/isp-drv.h   | 284 +++++++++
>  drivers/media/platform/apple/isp/isp-fw.c    | 770 +++++++++++++++++++++++
>  drivers/media/platform/apple/isp/isp-fw.h    |  24 +
>  drivers/media/platform/apple/isp/isp-iommu.c | 251 ++++++++
>  drivers/media/platform/apple/isp/isp-iommu.h |  20 +
>  drivers/media/platform/apple/isp/isp-ipc.c   | 258 ++++++++
>  drivers/media/platform/apple/isp/isp-ipc.h   |  25 +
>  drivers/media/platform/apple/isp/isp-regs.h  |  56 ++
>  drivers/media/platform/apple/isp/isp-v4l2.c  | 900 +++++++++++++++++++++++++++
>  drivers/media/platform/apple/isp/isp-v4l2.h  |  16 +
>  22 files changed, 4982 insertions(+)

quick partial review

> diff --git a/MAINTAINERS b/MAINTAINERS
> index dea7239ee0f5464b31efed5a2e0e5e602bcb6439..60517f7dcee14fc942dd3f77ed5d58eae394f7fa 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2248,6 +2248,7 @@ F:	drivers/i2c/busses/i2c-pasemi-platform.c
>  F:	drivers/iommu/apple-dart.c
>  F:	drivers/iommu/io-pgtable-dart.c
>  F:	drivers/irqchip/irq-apple-aic.c
> +F:	drivers/media/platform/apple/*
>  F:	drivers/nvme/host/apple.c
>  F:	drivers/nvmem/apple-efuses.c
>  F:	drivers/pinctrl/pinctrl-apple-gpio.c
> diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
> index 85d2627776b6a424fbd392187669535c4159ec97..ba75cfdb57f710cca086136e4524d3e1bc1910ac 100644
> --- a/drivers/media/platform/Kconfig
> +++ b/drivers/media/platform/Kconfig
> @@ -65,6 +65,7 @@ config VIDEO_MUX
>  source "drivers/media/platform/allegro-dvt/Kconfig"
>  source "drivers/media/platform/amlogic/Kconfig"
>  source "drivers/media/platform/amphion/Kconfig"
> +source "drivers/media/platform/apple/Kconfig"
>  source "drivers/media/platform/aspeed/Kconfig"
>  source "drivers/media/platform/atmel/Kconfig"
>  source "drivers/media/platform/broadcom/Kconfig"
> diff --git a/drivers/media/platform/Makefile b/drivers/media/platform/Makefile
> index ace4e34483ddce6c3361479989086145dd495f29..e59e4259064bf04b718ea8d128031af859a13d2e 100644
> --- a/drivers/media/platform/Makefile
> +++ b/drivers/media/platform/Makefile
> @@ -8,6 +8,7 @@
>  obj-y += allegro-dvt/
>  obj-y += amlogic/
>  obj-y += amphion/
> +obj-y += apple/
>  obj-y += aspeed/
>  obj-y += atmel/
>  obj-y += broadcom/
> diff --git a/drivers/media/platform/apple/Kconfig b/drivers/media/platform/apple/Kconfig
> new file mode 100644
> index 0000000000000000000000000000000000000000..f16508bff5242a0bc433bf8a1d8e3f29737d20d1
> --- /dev/null
> +++ b/drivers/media/platform/apple/Kconfig
> @@ -0,0 +1,5 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +comment "Apple media platform drivers"
> +
> +source "drivers/media/platform/apple/isp/Kconfig"
> diff --git a/drivers/media/platform/apple/Makefile b/drivers/media/platform/apple/Makefile
> new file mode 100644
> index 0000000000000000000000000000000000000000..d8fe985b0e6c377de6c77d30a3a796c40f3da116
> --- /dev/null
> +++ b/drivers/media/platform/apple/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +obj-y += isp/
> diff --git a/drivers/media/platform/apple/isp/Kconfig b/drivers/media/platform/apple/isp/Kconfig
> new file mode 100644
> index 0000000000000000000000000000000000000000..8e94962990031304d51cdd7cd6190b05b05b40bb
> --- /dev/null
> +++ b/drivers/media/platform/apple/isp/Kconfig
> @@ -0,0 +1,16 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +config VIDEO_APPLE_ISP
> +	tristate "Apple Silicon Image Signal Processor driver"
> +	select VIDEOBUF2_CORE
> +	select VIDEOBUF2_V4L2
> +	select VIDEOBUF2_DMA_SG
> +	depends on ARCH_APPLE || COMPILE_TEST
> +	depends on V4L_PLATFORM_DRIVERS
> +	depends on VIDEO_DEV

missing dependency on DRM for drm_mm. I don't remember why iova's top
down allocation was a problem but if we can avoid drm_mm that would be
an option as well.

> +	help
> +	  Say Y here to enable support for the ISP and cameras persent
> +	  in Apple ARM laptops.
> +
> +	  To compile this driver as a module, choose M here. The module will be
> +	  called apple_isp
> diff --git a/drivers/media/platform/apple/isp/Makefile b/drivers/media/platform/apple/isp/Makefile
> new file mode 100644
> index 0000000000000000000000000000000000000000..4649f32987f025a639945a37d774d4ecdc83b02a
> --- /dev/null
> +++ b/drivers/media/platform/apple/isp/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +apple-isp-y := isp-cam.o isp-cmd.o isp-drv.o isp-fw.o isp-iommu.o isp-ipc.o isp-v4l2.o
> +obj-$(CONFIG_VIDEO_APPLE_ISP) += apple-isp.o

...

> diff --git a/drivers/media/platform/apple/isp/isp-drv.c b/drivers/media/platform/apple/isp/isp-drv.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..b0c73b4f43d73f4ee29093fe62ed1d39ccfa33dd
> --- /dev/null
> +++ b/drivers/media/platform/apple/isp/isp-drv.c
> @@ -0,0 +1,586 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Apple Image Signal Processor driver
> + *
> + * Copyright (C) 2023 The Asahi Linux Contributors
> + */
> +
> +#include <linux/iommu.h>
> +#include <linux/module.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_domain.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/workqueue.h>
> +
> +#include "isp-cam.h"
> +#include "isp-fw.h"
> +#include "isp-iommu.h"
> +#include "isp-v4l2.h"
> +

...

> +static int apple_isp_init_iommu(struct apple_isp *isp)
> +{
> +	struct device *dev = isp->dev;
> +	phys_addr_t heap_base;
> +	size_t heap_size;
> +	u64 vm_size;
> +	int err;
> +	int size;
> +	struct device_node *mem_node;
> +	const __be32 *maps, *end;
> +
> +	isp->domain = iommu_get_domain_for_dev(isp->dev);
> +	if (!isp->domain)
> +		return -ENODEV;
> +	isp->shift = __ffs(isp->domain->pgsize_bitmap);
> +
> +	mem_node = of_parse_phandle(dev->of_node, "memory-region", 0);
> +	if (!mem_node) {
> +		dev_err(dev, "No memory-region found for heap\n");
> +		return -ENODEV;
> +	}
> +
> +	maps = of_get_property(mem_node, "iommu-addresses", &size);
> +	if (!maps || !size) {
> +		dev_err(dev, "No valid iommu-addresses found for heap\n");
> +		return -ENODEV;
> +	}
> +
> +	end = maps + size / sizeof(__be32);
> +
> +	while (maps < end) {
> +		maps++;
> +		maps = of_translate_dma_region(dev->of_node, maps, &heap_base,
> +					       &heap_size);
> +	}

The hand-rolled reserved memory parsing looks like it can be replaced
with of_iommu_get_resv_region();
> +

> +	isp->fw.heap_top = heap_base + heap_size;
> +
> +	err = of_property_read_u64(dev->of_node, "apple,dart-vm-size",
> +				   &vm_size);

This is not necessary and can be inferred from
isp->domain->geometry.aperture_{start,end}.

> +	if (err) {
> +		dev_err(dev, "failed to read 'apple,dart-vm-size': %d\n", err);
> +		return err;
> +	}
> +
> +	drm_mm_init(&isp->iovad, isp->fw.heap_top,
> +		    vm_size - (heap_base & 0xffffffff));

drm_mm probably should be replaced with something else. As I wrote above
I don't understand / remember what the problem was with relying on the
DMA api and iova. I can't imagine that the firmware cares about top-down
vs. bottom-up allocation. I could image it was related to
"apple,dart-vm-size" and iova's top down allocation only allocated
outside of the device's aperture. That should be solved by our current
downstream handling of the "vm-base" and "vm-size" properties from
Apple's devicetree.

ciao Janne


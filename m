Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8C6596951
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2019 21:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730142AbfHTTY1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Aug 2019 15:24:27 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:15943 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728185AbfHTTY0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Aug 2019 15:24:26 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d5c48ea0000>; Tue, 20 Aug 2019 12:24:26 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 20 Aug 2019 12:24:26 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 20 Aug 2019 12:24:26 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 20 Aug
 2019 19:24:25 +0000
Received: from [10.2.172.48] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 20 Aug
 2019 19:24:24 +0000
Subject: Re: [PATCH v3 2/9] soc: samsung: Convert exynos-chipid driver to use
 the regmap API
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>, <krzk@kernel.org>
CC:     <robh+dt@kernel.org>, <vireshk@kernel.org>,
        <devicetree@vger.kernel.org>, <kgene@kernel.org>,
        <pankaj.dubey@samsung.com>, <linux-samsung-soc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <b.zolnierkie@samsung.com>, <m.szyprowski@samsung.com>,
        linux-tegra <linux-tegra@vger.kernel.org>
References: <20190813150827.31972-1-s.nawrocki@samsung.com>
 <CGME20190813150852eucas1p2be4c0ab5ec2c079e3daf1af24283b27c@eucas1p2.samsung.com>
 <20190813150827.31972-3-s.nawrocki@samsung.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <b5359603-b337-dcd8-b025-ca7dff5f4a06@nvidia.com>
Date:   Tue, 20 Aug 2019 20:24:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190813150827.31972-3-s.nawrocki@samsung.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1566329066; bh=aqrV0qozQvPyCJF5OMU0O0mUi+RuzpeTvQFTlPYLGYo=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=k+uQ9whCpdQaPncRO5pqbWY5peXZs4u76HSG7FdTncaFHyBVBUU0+VUmNGh9l9uZf
         rpeWK8ybyj9BjBvzww8775rlL+xFRbAdnnTVOBDBMWnpyymV0Nnhrsa5laXm4Hk3qD
         pZ1wGU6rKdyQAowtuZcJ0eS5DEAA91UoASJ7hFBMi3BIgQwcv7WgObfF73CRAdTfBW
         pjAUvOqjr6lPkT/PyLVElqPjTsAjP0Ftpf96uHk8GNi8f3BSD5Zq2keebN1h20A4U9
         ScTNMW3THbcgO4H9B/gbFW1EJ323YLHH/MOahU6KmAH/fuSUpSLLER37mWG1YWVC+M
         z7KT+ONPzKgTw==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 13/08/2019 16:08, Sylwester Nawrocki wrote:
> Convert the driver to use regmap API in order to allow other
> drivers, like ASV, to access the CHIPID registers.
> 
> This patch adds definition of selected CHIPID register offsets
> and register bit fields for Exynos5422 SoC.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
> Changes since v2:
>  - s/_EXYNOS_ASV_H/__LINU_SOC_EXYNOS_ASV_H,
>  - removed __func__ from error log,
>  - removed unneeded <linux/of_address.h> header inclusion.
> 
> Changes since v1 (RFC):
>  - new patch
> ---
>  drivers/soc/samsung/exynos-chipid.c       | 34 ++++++---------
>  include/linux/soc/samsung/exynos-chipid.h | 52 +++++++++++++++++++++++
>  2 files changed, 65 insertions(+), 21 deletions(-)
>  create mode 100644 include/linux/soc/samsung/exynos-chipid.h
> 
> diff --git a/drivers/soc/samsung/exynos-chipid.c b/drivers/soc/samsung/exynos-chipid.c
> index bcf691f2b650..006a95feb618 100644
> --- a/drivers/soc/samsung/exynos-chipid.c
> +++ b/drivers/soc/samsung/exynos-chipid.c
> @@ -9,16 +9,13 @@
>   */
>  
>  #include <linux/io.h>
> +#include <linux/mfd/syscon.h>
>  #include <linux/of.h>
> -#include <linux/of_address.h>
> +#include <linux/regmap.h>
>  #include <linux/slab.h>
> +#include <linux/soc/samsung/exynos-chipid.h>
>  #include <linux/sys_soc.h>
>  
> -#define EXYNOS_SUBREV_MASK	(0xF << 4)
> -#define EXYNOS_MAINREV_MASK	(0xF << 0)
> -#define EXYNOS_REV_MASK		(EXYNOS_SUBREV_MASK | EXYNOS_MAINREV_MASK)
> -#define EXYNOS_MASK		0xFFFFF000
> -
>  static const struct exynos_soc_id {
>  	const char *name;
>  	unsigned int id;
> @@ -51,29 +48,24 @@ static const char * __init product_id_to_soc_id(unsigned int product_id)
>  int __init exynos_chipid_early_init(void)
>  {
>  	struct soc_device_attribute *soc_dev_attr;
> -	void __iomem *exynos_chipid_base;
>  	struct soc_device *soc_dev;
>  	struct device_node *root;
> -	struct device_node *np;
> +	struct regmap *regmap;
>  	u32 product_id;
>  	u32 revision;
> +	int ret;
>  
> -	/* look up for chipid node */
> -	np = of_find_compatible_node(NULL, NULL, "samsung,exynos4210-chipid");
> -	if (!np)
> -		return -ENODEV;
> -
> -	exynos_chipid_base = of_iomap(np, 0);
> -	of_node_put(np);
> -
> -	if (!exynos_chipid_base) {
> -		pr_err("Failed to map SoC chipid\n");
> -		return -ENXIO;
> +	regmap = syscon_regmap_lookup_by_compatible("samsung,exynos4210-chipid");
> +	if (IS_ERR(regmap)) {
> +		pr_err("Failed to get CHIPID regmap\n");
> +		return PTR_ERR(regmap);
>  	}

Following this change, I am now seeing the above error on our Tegra
boards where this driver is enabled. This is triggering a kernel
warnings test we have to fail. Hence, I don't think that you can remove
the compatible node test here, unless you have a better way to determine
if this is a samsung device.

Cheers
Jon

-- 
nvpublic

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4148441D21D
	for <lists+linux-pm@lfdr.de>; Thu, 30 Sep 2021 06:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347976AbhI3EQF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Sep 2021 00:16:05 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:22693 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347971AbhI3EQF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Sep 2021 00:16:05 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210930041421epoutp021ed066a9ff9592397d8e7d6917761258~pfllGl65O3088930889epoutp02f
        for <linux-pm@vger.kernel.org>; Thu, 30 Sep 2021 04:14:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210930041421epoutp021ed066a9ff9592397d8e7d6917761258~pfllGl65O3088930889epoutp02f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1632975261;
        bh=6Q+7kVAC7WzF5mnx52TAxBTQ287egXrn7GHkEgBdKfY=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=EN75HJPSUnPla5F3cVF6vRAKTFl6r8GImBBhdd+3G4X+v6QJsuoRQC93feiRGl7rE
         zR07LkhffDFUy/x/2cpa0hfoYEudSPqIf8LtVTpYbLeINwiw9iy2wOQeFYd3zfQA1r
         pB8RGtMtGCoKN5Emcg55apAv5RAEr/u0Cwef1ygA=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20210930041420epcas1p36ace5babb040d08e18c14750529d72d2~pfljdD7hL1744217442epcas1p3J;
        Thu, 30 Sep 2021 04:14:20 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.38.236]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4HKfyC6jstz4x9Px; Thu, 30 Sep
        2021 04:14:11 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        DB.84.24398.09935516; Thu, 30 Sep 2021 13:14:08 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210930041407epcas1p1440b4fc36ba89c40876114ca80e48f6a~pflXd0C0n1937319373epcas1p1r;
        Thu, 30 Sep 2021 04:14:07 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210930041407epsmtrp1659cd8fdb5c3437a1338452a9a780b3b~pflXcxqxl1750817508epsmtrp15;
        Thu, 30 Sep 2021 04:14:07 +0000 (GMT)
X-AuditID: b6c32a35-0edff70000005f4e-59-61553990bdc0
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        07.E3.08750.E8935516; Thu, 30 Sep 2021 13:14:07 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210930041406epsmtip1f09dba5f4b07391307ef971ce9e11dbf~pflXJwA5D1263012630epsmtip1b;
        Thu, 30 Sep 2021 04:14:06 +0000 (GMT)
Subject: Re: [PATCH 10/10] PM / devfreq: Add a driver for the sun8i/sun50i
 MBUS
To:     Samuel Holland <samuel@sholland.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <c06f1e6f-fa99-4506-e410-c38a468519b7@samsung.com>
Date:   Thu, 30 Sep 2021 13:35:22 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20210929044254.38301-11-samuel@sholland.org>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPJsWRmVeSWpSXmKPExsWy7bCmnu4Ey9BEg77X/Bbzj5xjtXg+fx2j
        xdmmN+wWmx5fY7W4vGsOm8Xn3iOMFlP27WKzaOtcxmpx8ZSrxe3GFWwWrXuPsFs8f9TJZvHv
        2kYWi5+HzjM58Hm8v9HK7rHh0WpWj52z7rJ7bFrVyeaxeUm9x4vNMxk9+rasYvR49XUuo8fn
        TXIBnFHZNhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+AbpumTlA
        tysplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1JyCkwL9IoTc4tL89L18lJLrAwNDIxM
        gQoTsjOWvljFVtDfxFjRM2MGUwPj04wuRk4OCQETiSvXn7N0MXJxCAnsYJSYOG0ZK0hCSOAT
        o0TD/WyIxGdGifU3FzHBdPRcm8UMkdjFKHHkZj9U+3tGie7+LYwgVcICgRJHd71lA0mICExk
        kph9/wBYFbPAW0aJhbt2MINUsQloSex/cYMNxOYXUJS4+uMxUDcHB6+AncSpWQ4gYRYBVYkz
        i4+yg9iiAmESJ7e1gC3gFRCUODnzCQuIzSlgJXHq7BewkcwC4hK3nsxngrDlJba/nQN2qoTA
        Gw6Jjq0nmSF+cJHY9W41I4QtLPHq+BZ2CFtK4mV/G5RdLbHy5BE2iOYORokt+y+wQiSMJfYv
        ncwEciizgKbE+l36EGFFiZ2/5zJCLOaTePe1hxWkREKAV6KjTQiiRFni8oO70GCUlFjc3sk2
        gVFpFpJ3ZiF5YRaSF2YhLFvAyLKKUSy1oDg3PbXYsMAQHt/J+bmbGMEpW8t0B+PEtx/0DjEy
        cTAeYpTgYFYS4f0hHpwoxJuSWFmVWpQfX1Sak1p8iNEUGMATmaVEk/OBWSOvJN7QxNLAxMzI
        2MTC0MxQSZz32GvLRCGB9MSS1OzU1ILUIpg+Jg5OqQam7QsUurXYBCTufrBM3HZX9BnD0/eL
        jIU+ayZ3fWbkrZqn3u3xxa1+9aSvCV6874td3r3NOys8w+XAdq9ffqvtWuMfH9nG4RmQrLw8
        Qm+3cKPr3+i45mfq5VXfewx/lv95bLRaSW7C0fj7Orm5Kz9N32vZeC08vFz0cqmx5ZJq12+2
        G9JLTyd6JhzLti+9n9uo0eXtxjpP+g3D4XWXfZsefZnl4qKV0J12y9g74/I03TeTFp1Q+1xf
        P5FVRuP7twKJD/+m7V/2YSt7aPWsa3MT5y4udC3r4b4kHtihEqkbILr9vbLKcp//h/h2z17E
        wz+18ROr/eGy+ft+bFsZuvVQJXfQxHlVEWdYL5gviZBXYinOSDTUYi4qTgQAlUMvXWIEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFIsWRmVeSWpSXmKPExsWy7bCSnG6/ZWiiwc92Rov5R86xWjyfv47R
        4mzTG3aLTY+vsVpc3jWHzeJz7xFGiyn7drFZtHUuY7W4eMrV4nbjCjaL1r1H2C2eP+pks/h3
        bSOLxc9D55kc+Dze32hl99jwaDWrx85Zd9k9Nq3qZPPYvKTe48XmmYwefVtWMXq8+jqX0ePz
        JrkAzigum5TUnMyy1CJ9uwSujKUvVrEV9DcxVvTMmMHUwPg0o4uRk0NCwESi59os5i5GLg4h
        gR2MEkeWbWSFSEhKTLt4FCjBAWQLSxw+XAxR85ZRYs7FW2wgNcICgRJHd71lA0mICExmkji5
        9TgTiMMMUvXqwnVGiJY9jBJ7ep+AjWUT0JLY/+IGWDu/gKLE1R+PGUFW8ArYSZya5QASZhFQ
        lTiz+Cg7iC0qECaxc8ljJhCbV0BQ4uTMJywgNqeAlcSps1+YQWxmAXWJP/MuQdniEreezGeC
        sOUltr+dwzyBUXgWkvZZSFpmIWmZhaRlASPLKkbJ1ILi3PTcYsMCo7zUcr3ixNzi0rx0veT8
        3E2M4OjV0trBuGfVB71DjEwcjIcYJTiYlUR4f4gHJwrxpiRWVqUW5ccXleakFh9ilOZgURLn
        vdB1Ml5IID2xJDU7NbUgtQgmy8TBKdXAxH22a6mHXJWG4NNMYY0JkTEfa48W3o24ZS9yiv/y
        cn69+hsJqoccry26fmvBnv0Pr8Xk8z0wfpcjFaIgXSbI9SyQTWAee+gLtWNKix6+rL/DlLp8
        ytW9B+0z7WqZNVfPbqlr2v1M+180J5vHuiynpHUzsz1WlZ2o9Fr/R0+WW7hCYcYmzRiVe9vT
        a7hvFnu/Lnt8J7h3aVqVgLDglpVlrKu8z26uZ1I+yHFxV3vvS64VIpyH2U6U3ZHsYE8u7sj3
        3Cq6mj9jae6k4/ETNn7SyjwSU9/IxTPrrKb1hiy9xQ+NVI632Z7dsWap6Ls6Y8+zcfEsf+qk
        0xgrtk/g/XHmrue3FXzzlhqZak2/zuWsxFKckWioxVxUnAgA/f8ABE0DAAA=
X-CMS-MailID: 20210930041407epcas1p1440b4fc36ba89c40876114ca80e48f6a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210929044306epcas1p341878fd746d7c3aeecb852a8dc32c27d
References: <20210929044254.38301-1-samuel@sholland.org>
        <CGME20210929044306epcas1p341878fd746d7c3aeecb852a8dc32c27d@epcas1p3.samsung.com>
        <20210929044254.38301-11-samuel@sholland.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Samuel,


On 9/29/21 1:42 PM, Samuel Holland wrote:
> This driver works by adjusting the divider on the DRAM controller's
> module clock. Thus there is no fixed set of OPPs, only "full speed" down
> to "quarter speed" (or whatever the maximum divider is on that variant).
> 
> It makes use of the MDFS hardware in the MBUS, in "DFS" mode, which
> takes care of updating registers during the critical section while DRAM
> is inaccessible.
> 
> This driver should support several sunxi SoCs, starting with the A33,
> which have a DesignWare DDR3 controller with merged PHY register space
> and the matching MBUS register layout (so not A63 or later). However,
> the driver has only been tested on the A64/H5, so those are the only
> compatibles enabled for now.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>  drivers/devfreq/Kconfig          |   8 +
>  drivers/devfreq/Makefile         |   1 +
>  drivers/devfreq/sun8i-a33-mbus.c | 482 +++++++++++++++++++++++++++++++
>  3 files changed, 491 insertions(+)
>  create mode 100644 drivers/devfreq/sun8i-a33-mbus.c
> 
> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
> index e87d01c0b76a..b94eb04761f6 100644
> --- a/drivers/devfreq/Kconfig
> +++ b/drivers/devfreq/Kconfig
> @@ -132,6 +132,14 @@ config ARM_RK3399_DMC_DEVFREQ
>  	  It sets the frequency for the memory controller and reads the usage counts
>  	  from hardware.
>  
> +config ARM_SUN8I_A33_MBUS_DEVFREQ
> +	tristate "sun8i/sun50i MBUS DEVFREQ Driver"
> +	depends on ARCH_SUNXI || COMPILE_TEST
> +	select DEVFREQ_GOV_SIMPLE_ONDEMAND
> +	help
> +	  This adds the DEVFREQ driver for the MBUS controller in some
> +	  Allwinner sun8i (A33 through H3) and sun50i (A64 and H5) SoCs.
> +
>  source "drivers/devfreq/event/Kconfig"
>  
>  endif # PM_DEVFREQ
> diff --git a/drivers/devfreq/Makefile b/drivers/devfreq/Makefile
> index a16333ea7034..0b6be92a25d9 100644
> --- a/drivers/devfreq/Makefile
> +++ b/drivers/devfreq/Makefile
> @@ -12,6 +12,7 @@ obj-$(CONFIG_ARM_EXYNOS_BUS_DEVFREQ)	+= exynos-bus.o
>  obj-$(CONFIG_ARM_IMX_BUS_DEVFREQ)	+= imx-bus.o
>  obj-$(CONFIG_ARM_IMX8M_DDRC_DEVFREQ)	+= imx8m-ddrc.o
>  obj-$(CONFIG_ARM_RK3399_DMC_DEVFREQ)	+= rk3399_dmc.o
> +obj-$(CONFIG_ARM_SUN8I_A33_MBUS_DEVFREQ)	+= sun8i-a33-mbus.o
>  obj-$(CONFIG_ARM_TEGRA_DEVFREQ)		+= tegra30-devfreq.o
>  
>  # DEVFREQ Event Drivers
> diff --git a/drivers/devfreq/sun8i-a33-mbus.c b/drivers/devfreq/sun8i-a33-mbus.c
> new file mode 100644
> index 000000000000..00f24850cf8d
> --- /dev/null
> +++ b/drivers/devfreq/sun8i-a33-mbus.c
> @@ -0,0 +1,482 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +//
> +// Copyright (C) 2020-2021 Samuel Holland <samuel@sholland.org>
> +//
> +
> +#include <linux/clk.h>
> +#include <linux/devfreq.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
> +
> +#define MBUS_CR				0x0000
> +#define MBUS_CR_GET_DRAM_TYPE(x)	(((x) >> 16) & 0x7)
> +#define MBUS_CR_DRAM_TYPE_DDR2		2
> +#define MBUS_CR_DRAM_TYPE_DDR3		3
> +#define MBUS_CR_DRAM_TYPE_DDR4		4
> +#define MBUS_CR_DRAM_TYPE_LPDDR2	6
> +#define MBUS_CR_DRAM_TYPE_LPDDR3	7
> +
> +#define MBUS_TMR			0x000c
> +#define MBUS_TMR_PERIOD(x)		((x) - 1)
> +
> +#define MBUS_PMU_CFG			0x009c
> +#define MBUS_PMU_CFG_PERIOD(x)		(((x) - 1) << 16)
> +#define MBUS_PMU_CFG_UNIT		(0x3 << 1)
> +#define MBUS_PMU_CFG_UNIT_B		(0x0 << 1)
> +#define MBUS_PMU_CFG_UNIT_KB		(0x1 << 1)
> +#define MBUS_PMU_CFG_UNIT_MB		(0x2 << 1)
> +#define MBUS_PMU_CFG_ENABLE		(0x1 << 0)
> +
> +#define MBUS_PMU_BWCR(n)		(0x00a0 + (0x04 * (n)))
> +
> +#define MBUS_TOTAL_BWCR			MBUS_PMU_BWCR(5)
> +#define MBUS_TOTAL_BWCR_H616		MBUS_PMU_BWCR(13)
> +
> +#define MBUS_MDFSCR			0x0100
> +#define MBUS_MDFSCR_BUFFER_TIMING	(0x1 << 15)
> +#define MBUS_MDFSCR_PAD_HOLD		(0x1 << 13)
> +#define MBUS_MDFSCR_BYPASS		(0x1 << 4)
> +#define MBUS_MDFSCR_MODE		(0x1 << 1)
> +#define MBUS_MDFSCR_MODE_DFS		(0x0 << 1)
> +#define MBUS_MDFSCR_MODE_CFS		(0x1 << 1)
> +#define MBUS_MDFSCR_START		(0x1 << 0)
> +
> +#define MBUS_MDFSMRMR			0x0108
> +
> +#define DRAM_PWRCTL			0x0004
> +#define DRAM_PWRCTL_SELFREF_EN		(0x1 << 0)
> +
> +#define DRAM_RFSHTMG			0x0090
> +#define DRAM_RFSHTMG_TREFI(x)		((x) << 16)
> +#define DRAM_RFSHTMG_TRFC(x)		((x) << 0)
> +
> +#define DRAM_VTFCR			0x00b8
> +#define DRAM_VTFCR_VTF_ENABLE		(0x3 << 8)
> +
> +#define DRAM_ODTMAP			0x0120
> +
> +#define DRAM_DX_MAX			4
> +
> +#define DRAM_DXnGCR0(n)			(0x0344 + 0x80 * (n))
> +#define DRAM_DXnGCR0_DXODT		(0x3 << 4)
> +#define DRAM_DXnGCR0_DXODT_DYNAMIC	(0x0 << 4)
> +#define DRAM_DXnGCR0_DXODT_ENABLED	(0x1 << 4)
> +#define DRAM_DXnGCR0_DXODT_DISABLED	(0x2 << 4)
> +#define DRAM_DXnGCR0_DXEN		(0x1 << 0)
> +
> +struct sun8i_a33_mbus_variant {
> +	u32					min_dram_divider;
> +	u32					max_dram_divider;
> +	u32					odt_freq_mhz;
> +};
> +
> +struct sun8i_a33_mbus {
> +	const struct sun8i_a33_mbus_variant	*variant;
> +	void __iomem				*reg_dram;
> +	void __iomem				*reg_mbus;
> +	struct clk				*clk_bus;
> +	struct clk				*clk_dram;
> +	struct clk				*clk_mbus;
> +	struct devfreq				*devfreq_dram;
> +	struct devfreq_simple_ondemand_data	gov_data;
> +	struct devfreq_dev_profile		profile;
> +	u32					data_width;
> +	u32					nominal_bw;
> +	u32					odtmap;
> +	u32					tREFI_ns;
> +	u32					tRFC_ns;
> +	unsigned long				freq_table[];
> +};
> +
> +/*
> + * The unit for this value is (MBUS clock cycles / MBUS_TMR_PERIOD). When
> + * MBUS_TMR_PERIOD is programmed to match the MBUS clock frequency in MHz, as
> + * it is during DRAM init and during probe, the resulting unit is microseconds.
> + */
> +static int pmu_period = 50000;
> +module_param(pmu_period, int, 0644);
> +MODULE_PARM_DESC(pmu_period, "Bandwidth measurement period (microseconds)");
> +
> +static u32 sun8i_a33_mbus_get_peak_bw(struct sun8i_a33_mbus *priv)
> +{
> +	/* Returns the peak transfer (in KiB) during any single PMU period. */
> +	return readl_relaxed(priv->reg_mbus + MBUS_TOTAL_BWCR);
> +}
> +
> +static void sun8i_a33_mbus_restart_pmu_counters(struct sun8i_a33_mbus *priv)
> +{
> +	u32 pmu_cfg = MBUS_PMU_CFG_PERIOD(pmu_period) | MBUS_PMU_CFG_UNIT_KB;
> +
> +	/* All PMU counters are cleared on a disable->enable transition. */
> +	writel_relaxed(pmu_cfg,
> +		       priv->reg_mbus + MBUS_PMU_CFG);
> +	writel_relaxed(pmu_cfg | MBUS_PMU_CFG_ENABLE,
> +		       priv->reg_mbus + MBUS_PMU_CFG);
> +
> +}
> +
> +static void sun8i_a33_mbus_update_nominal_bw(struct sun8i_a33_mbus *priv,
> +					     u32 ddr_freq_mhz)
> +{
> +	/*
> +	 * Nominal bandwidth (KiB per PMU period):
> +	 *
> +	 *   DDR transfers   microseconds     KiB
> +	 *   ------------- * ------------ * --------
> +	 *    microsecond     PMU period    transfer
> +	 */
> +	priv->nominal_bw = ddr_freq_mhz * pmu_period * priv->data_width / 1024;
> +}
> +
> +static int sun8i_a33_mbus_set_dram_freq(struct sun8i_a33_mbus *priv,
> +					unsigned long freq)
> +{
> +	u32  ddr_freq_mhz = freq / USEC_PER_SEC; /* DDR */
> +	u32 dram_freq_mhz =    ddr_freq_mhz / 2; /* SDR */
> +	u32 mctl_freq_mhz =   dram_freq_mhz / 2; /* HDR */
> +	u32 dxodt, mdfscr, pwrctl, vtfcr;
> +	u32 i, tREFI_32ck, tRFC_ck;
> +	int ret;
> +
> +	/* The rate change is not effective until the MDFS process runs. */
> +	ret = clk_set_rate(priv->clk_dram, freq);
> +	if (ret)
> +		return ret;
> +
> +	/* Disable automatic self-refesh and VTF before starting MDFS. */
> +	pwrctl = readl_relaxed(priv->reg_dram + DRAM_PWRCTL) &
> +		 ~DRAM_PWRCTL_SELFREF_EN;
> +	writel_relaxed(pwrctl, priv->reg_dram + DRAM_PWRCTL);
> +	vtfcr = readl_relaxed(priv->reg_dram + DRAM_VTFCR);
> +	writel_relaxed(vtfcr & ~DRAM_VTFCR_VTF_ENABLE,
> +		       priv->reg_dram + DRAM_VTFCR);
> +
> +	/* Set up MDFS and enable double buffering for timing registers. */
> +	mdfscr = MBUS_MDFSCR_MODE_DFS |
> +		 MBUS_MDFSCR_BYPASS |
> +		 MBUS_MDFSCR_PAD_HOLD |
> +		 MBUS_MDFSCR_BUFFER_TIMING;
> +	writel(mdfscr, priv->reg_mbus + MBUS_MDFSCR);
> +
> +	/* Update the buffered copy of RFSHTMG. */
> +	tREFI_32ck = priv->tREFI_ns * mctl_freq_mhz / 1000 / 32;
> +	tRFC_ck = DIV_ROUND_UP(priv->tRFC_ns * mctl_freq_mhz, 1000);
> +	writel(DRAM_RFSHTMG_TREFI(tREFI_32ck) | DRAM_RFSHTMG_TRFC(tRFC_ck),
> +	       priv->reg_dram + DRAM_RFSHTMG);
> +
> +	/* Enable ODT if needed, or disable it to save power. */
> +	if (priv->odtmap && dram_freq_mhz > priv->variant->odt_freq_mhz) {
> +		dxodt = DRAM_DXnGCR0_DXODT_DYNAMIC;
> +		writel(priv->odtmap, priv->reg_dram + DRAM_ODTMAP);
> +	} else {
> +		dxodt = DRAM_DXnGCR0_DXODT_DISABLED;
> +		writel(0, priv->reg_dram + DRAM_ODTMAP);
> +	}
> +	for (i = 0; i < DRAM_DX_MAX; ++i) {
> +		void __iomem *reg = priv->reg_dram + DRAM_DXnGCR0(i);
> +
> +		writel((readl(reg) & ~DRAM_DXnGCR0_DXODT) | dxodt, reg);
> +	}
> +
> +	dev_dbg(priv->devfreq_dram->dev.parent,
> +		"Setting DRAM to %u MHz, tREFI=%u, tRFC=%u, ODT=%s\n",
> +		dram_freq_mhz, tREFI_32ck, tRFC_ck,
> +		dxodt == DRAM_DXnGCR0_DXODT_DYNAMIC ? "dynamic" : "disabled");
> +
> +	/* Trigger hardware MDFS. */
> +	writel(mdfscr | MBUS_MDFSCR_START, priv->reg_mbus + MBUS_MDFSCR);
> +	ret = readl_poll_timeout_atomic(priv->reg_mbus + MBUS_MDFSCR, mdfscr,
> +					!(mdfscr & MBUS_MDFSCR_START), 10, 1000);
> +	if (ret)
> +		return ret;
> +
> +	/* Disable double buffering. */
> +	writel(0, priv->reg_mbus + MBUS_MDFSCR);
> +
> +	/* Restore VTF configuration. */
> +	writel_relaxed(vtfcr, priv->reg_dram + DRAM_VTFCR);
> +
> +	/* Enable automatic self-refresh at the lowest frequency only. */
> +	if (freq == priv->freq_table[0])
> +		pwrctl |= DRAM_PWRCTL_SELFREF_EN;
> +	writel_relaxed(pwrctl, priv->reg_dram + DRAM_PWRCTL);
> +
> +	sun8i_a33_mbus_restart_pmu_counters(priv);
> +	sun8i_a33_mbus_update_nominal_bw(priv, ddr_freq_mhz);
> +
> +	return 0;
> +}
> +
> +static int sun8i_a33_mbus_set_dram_target(struct device *dev,
> +					  unsigned long *freq, u32 flags)
> +{
> +	struct sun8i_a33_mbus *priv = dev_get_drvdata(dev);
> +	struct devfreq *devfreq = priv->devfreq_dram;
> +	int ret;
> +
> +	devfreq_recommended_freq(devfreq, freq, flags);
> +
> +	if (*freq == devfreq->previous_freq)
> +		return 0;
> +
> +	ret = sun8i_a33_mbus_set_dram_freq(priv, *freq);
> +	if (ret) {
> +		dev_warn(dev, "failed to set DRAM frequency: %d\n", ret);
> +		*freq = devfreq->previous_freq;
> +	}
> +
> +	return ret;
> +}
> +
> +static int sun8i_a33_mbus_get_dram_status(struct device *dev,
> +					  struct devfreq_dev_status *stat)
> +{
> +	struct sun8i_a33_mbus *priv = dev_get_drvdata(dev);
> +
> +	stat->busy_time		= sun8i_a33_mbus_get_peak_bw(priv);
> +	stat->total_time	= priv->nominal_bw;
> +	stat->current_frequency	= priv->devfreq_dram->previous_freq;
> +
> +	sun8i_a33_mbus_restart_pmu_counters(priv);
> +
> +	dev_dbg(dev, "Using %lu/%lu (%lu%%) at %lu MHz\n",
> +		stat->busy_time, stat->total_time,
> +		DIV_ROUND_CLOSEST(stat->busy_time * 100, stat->total_time),
> +		stat->current_frequency / USEC_PER_SEC);
> +
> +	return 0;
> +}
> +
> +static int sun8i_a33_mbus_hw_init(struct device *dev,
> +				  struct sun8i_a33_mbus *priv,
> +				  unsigned long ddr_freq)
> +{
> +	u32 i, mbus_cr, mbus_freq_mhz;
> +
> +	/* Choose tREFI and tRFC to match the configured DRAM type. */
> +	mbus_cr = readl_relaxed(priv->reg_mbus + MBUS_CR);
> +	switch (MBUS_CR_GET_DRAM_TYPE(mbus_cr)) {
> +	case MBUS_CR_DRAM_TYPE_DDR2:
> +	case MBUS_CR_DRAM_TYPE_DDR3:
> +	case MBUS_CR_DRAM_TYPE_DDR4:
> +		priv->tREFI_ns = 7800;
> +		priv->tRFC_ns = 350;
> +		break;
> +	case MBUS_CR_DRAM_TYPE_LPDDR2:
> +	case MBUS_CR_DRAM_TYPE_LPDDR3:
> +		priv->tREFI_ns = 3900;
> +		priv->tRFC_ns = 210;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	/* Save ODTMAP so it can be restored when raising the frequency. */
> +	priv->odtmap = readl_relaxed(priv->reg_dram + DRAM_ODTMAP);
> +
> +	/* Compute the DRAM data bus width by counting enabled DATx8 blocks. */
> +	for (i = 0; i < DRAM_DX_MAX; ++i) {
> +		void __iomem *reg = priv->reg_dram + DRAM_DXnGCR0(i);
> +
> +		if (!(readl_relaxed(reg) & DRAM_DXnGCR0_DXEN))
> +			break;
> +	}
> +	priv->data_width = i;
> +
> +	dev_dbg(dev, "Detected %u-bit %sDDRx with%s ODT\n",
> +		priv->data_width * 8,
> +		MBUS_CR_GET_DRAM_TYPE(mbus_cr) > 4 ? "LP" : "",
> +		priv->odtmap ? "" : "out");
> +
> +	/* Program MBUS_TMR such that the PMU period unit is microseconds. */
> +	mbus_freq_mhz = clk_get_rate(priv->clk_mbus) / USEC_PER_SEC;
> +	writel_relaxed(MBUS_TMR_PERIOD(mbus_freq_mhz),
> +		       priv->reg_mbus + MBUS_TMR);
> +
> +	/* "Master Ready Mask Register" bits must be set or MDFS will block. */
> +	writel_relaxed(0xffffffff, priv->reg_mbus + MBUS_MDFSMRMR);
> +
> +	sun8i_a33_mbus_restart_pmu_counters(priv);
> +	sun8i_a33_mbus_update_nominal_bw(priv, ddr_freq / USEC_PER_SEC);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused sun8i_a33_mbus_suspend(struct device *dev)
> +{
> +	struct sun8i_a33_mbus *priv = dev_get_drvdata(dev);
> +
> +	clk_disable_unprepare(priv->clk_bus);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused sun8i_a33_mbus_resume(struct device *dev)
> +{
> +	struct sun8i_a33_mbus *priv = dev_get_drvdata(dev);
> +
> +	return clk_prepare_enable(priv->clk_bus);
> +}
> +
> +static int sun8i_a33_mbus_probe(struct platform_device *pdev)
> +{
> +	const struct sun8i_a33_mbus_variant *variant;
> +	struct device *dev = &pdev->dev;
> +	struct sun8i_a33_mbus *priv;
> +	unsigned long base_freq;
> +	unsigned int max_state;
> +	unsigned int div;
> +	const char *err;
> +	int i, ret;
> +
> +	variant = device_get_match_data(dev);
> +	if (!variant)
> +		return -EINVAL;
> +
> +	max_state = variant->max_dram_divider - variant->min_dram_divider + 1;
> +
> +	priv = devm_kzalloc(dev, struct_size(priv, freq_table, max_state), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, priv);
> +
> +	priv->variant = variant;
> +
> +	priv->reg_dram = devm_platform_ioremap_resource_byname(pdev, "dram");
> +	if (IS_ERR(priv->reg_dram))
> +		return PTR_ERR(priv->reg_dram);
> +
> +	priv->reg_mbus = devm_platform_ioremap_resource_byname(pdev, "mbus");
> +	if (IS_ERR(priv->reg_mbus))
> +		return PTR_ERR(priv->reg_mbus);
> +
> +	priv->clk_bus = devm_clk_get(dev, "bus");
> +	if (IS_ERR(priv->clk_bus))
> +		return dev_err_probe(dev, PTR_ERR(priv->clk_bus),
> +				     "failed to get bus clock\n");
> +
> +	priv->clk_dram = devm_clk_get(dev, "dram");
> +	if (IS_ERR(priv->clk_dram))
> +		return dev_err_probe(dev, PTR_ERR(priv->clk_dram),
> +				     "failed to get dram clock\n");
> +
> +	priv->clk_mbus = devm_clk_get(dev, "mbus");
> +	if (IS_ERR(priv->clk_mbus))
> +		return dev_err_probe(dev, PTR_ERR(priv->clk_mbus),
> +				     "failed to get mbus clock\n");
> +
> +	ret = clk_prepare_enable(priv->clk_bus);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "failed to enable bus clock\n");
> +
> +	/* Lock the DRAM clock rate to keep priv->nominal_bw in sync. */
> +	ret = clk_rate_exclusive_get(priv->clk_dram);
> +	if (ret) {
> +		err = "failed to lock dram clock rate\n";
> +		goto err_disable_bus;
> +	}
> +
> +	/* Lock the MBUS clock rate to keep MBUS_TMR_PERIOD in sync. */
> +	ret = clk_rate_exclusive_get(priv->clk_mbus);
> +	if (ret) {
> +		err = "failed to lock mbus clock rate\n";
> +		goto err_unlock_dram;
> +	}
> +
> +	priv->gov_data.upthreshold	= 10;
> +	priv->gov_data.downdifferential	=  5;
> +
> +	priv->profile.initial_freq	= clk_get_rate(priv->clk_dram);
> +	priv->profile.polling_ms	= 1000;
> +	priv->profile.target		= sun8i_a33_mbus_set_dram_target;
> +	priv->profile.get_dev_status	= sun8i_a33_mbus_get_dram_status;
> +	priv->profile.freq_table	= priv->freq_table;
> +	priv->profile.max_state		= max_state;
> +
> +	base_freq = clk_get_rate(clk_get_parent(priv->clk_dram));
> +	for (i = 0, div = variant->max_dram_divider; i < max_state; ++i, --div)
> +		priv->freq_table[i] = base_freq / div;

This patchset supports the case without OPP.
But, if you use dev_pm_opp_add() function at this point,
you can use the existing devfreq core without any modification for no OPP case.

Why don't you use dev_pm_opp_add at this point?

(snip)

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics

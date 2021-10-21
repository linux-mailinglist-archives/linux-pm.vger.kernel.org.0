Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30F27435D3F
	for <lists+linux-pm@lfdr.de>; Thu, 21 Oct 2021 10:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbhJUIsf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Oct 2021 04:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbhJUIsf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Oct 2021 04:48:35 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962F1C06161C;
        Thu, 21 Oct 2021 01:46:19 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 9E1C01F42D13
Subject: Re: [PATCH v16 3/7] soc: mediatek: SVS: introduce MTK SVS engine
To:     Roger Lu <roger.lu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Boichat <drinkcat@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Fan Chen <fan.chen@mediatek.com>,
        HenryC Chen <HenryC.Chen@mediatek.com>,
        YT Lee <yt.lee@mediatek.com>,
        Xiaoqing Liu <Xiaoqing.Liu@mediatek.com>,
        Charles Yang <Charles.Yang@mediatek.com>,
        Angus Lin <Angus.Lin@mediatek.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20210428065440.3704-1-roger.lu@mediatek.com>
 <20210428065440.3704-4-roger.lu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <c97f7dcd-32e5-616e-1bf9-fbd110ecd218@collabora.com>
Date:   Thu, 21 Oct 2021 10:46:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210428065440.3704-4-roger.lu@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Il 28/04/21 08:54, Roger Lu ha scritto:
> The Smart Voltage Scaling(SVS) engine is a piece of hardware
> which calculates suitable SVS bank voltages to OPP voltage table.
> Then, DVFS driver could apply those SVS bank voltages to PMIC/Buck
> when receiving OPP_EVENT_ADJUST_VOLTAGE.
> 
> Signed-off-by: Roger Lu <roger.lu@mediatek.com>
> ---
>   drivers/soc/mediatek/Kconfig   |   10 +
>   drivers/soc/mediatek/Makefile  |    1 +
>   drivers/soc/mediatek/mtk-svs.c | 1723 ++++++++++++++++++++++++++++++++
>   3 files changed, 1734 insertions(+)
>   create mode 100644 drivers/soc/mediatek/mtk-svs.c
> 
> diff --git a/drivers/soc/mediatek/Kconfig b/drivers/soc/mediatek/Kconfig
> index fdd8bc08569e..3c3eedea35f7 100644
> --- a/drivers/soc/mediatek/Kconfig
> +++ b/drivers/soc/mediatek/Kconfig
> @@ -73,4 +73,14 @@ config MTK_MMSYS
>   	  Say yes here to add support for the MediaTek Multimedia
>   	  Subsystem (MMSYS).
>   
> +config MTK_SVS
> +	tristate "MediaTek Smart Voltage Scaling(SVS)"
> +	depends on MTK_EFUSE && NVMEM
> +	help
> +	  The Smart Voltage Scaling(SVS) engine is a piece of hardware
> +	  which has several controllers(banks) for calculating suitable
> +	  voltage to different power domains(CPU/GPU/CCI) according to
> +	  chip process corner, temperatures and other factors. Then DVFS
> +	  driver could apply SVS bank voltage to PMIC/Buck.
> +
>   endmenu
> diff --git a/drivers/soc/mediatek/Makefile b/drivers/soc/mediatek/Makefile
> index 90270f8114ed..0e9e703c931a 100644
> --- a/drivers/soc/mediatek/Makefile
> +++ b/drivers/soc/mediatek/Makefile
> @@ -7,3 +7,4 @@ obj-$(CONFIG_MTK_SCPSYS) += mtk-scpsys.o
>   obj-$(CONFIG_MTK_SCPSYS_PM_DOMAINS) += mtk-pm-domains.o
>   obj-$(CONFIG_MTK_MMSYS) += mtk-mmsys.o
>   obj-$(CONFIG_MTK_MMSYS) += mtk-mutex.o
> +obj-$(CONFIG_MTK_SVS) += mtk-svs.o
> diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
> new file mode 100644
> index 000000000000..2d2153c92373
> --- /dev/null
> +++ b/drivers/soc/mediatek/mtk-svs.c
> @@ -0,0 +1,1723 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2020 MediaTek Inc.
> + */
> +
> +#include <linux/bits.h>
> +#include <linux/clk.h>
> +#include <linux/completion.h>
> +#include <linux/device.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/kthread.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/nvmem-consumer.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_domain.h>
> +#include <linux/pm_opp.h>
> +#include <linux/pm_qos.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/reset.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +#include <linux/thermal.h>
> +
> +/* svs bank 1-line sw id */
> +#define SVSB_CPU_LITTLE			BIT(0)
> +#define SVSB_CPU_BIG			BIT(1)
> +#define SVSB_CCI			BIT(2)
> +#define SVSB_GPU			BIT(3)
> +
> +/* svs bank mode support */
> +#define SVSB_MODE_ALL_DISABLE		0
> +#define SVSB_MODE_INIT01		BIT(1)
> +#define SVSB_MODE_INIT02		BIT(2)
> +#define SVSB_MODE_MON			BIT(3)
> +
> +/* svs bank volt flags */
> +#define SVSB_INIT01_VOLT_IGNORE		BIT(1)
> +#define SVSB_INIT01_VOLT_INC_ONLY	BIT(2)
> +#define SVSB_INIT02_RM_DVTFIXED		BIT(8)
> +#define SVSB_MON_VOLT_IGNORE		BIT(16)
> +
> +/* svs bank common setting */
> +#define SVSB_DET_CLK_EN			BIT(31)
> +#define SVSB_TZONE_HIGH_TEMP_MAX	U32_MAX
> +#define SVSB_RUNCONFIG_DEFAULT		0x80000000
> +#define SVSB_DC_SIGNED_BIT		0x8000
> +#define SVSB_INTEN_INIT0x		0x00005f01
> +#define SVSB_INTEN_MONVOPEN		0x00ff0000
> +#define SVSB_EN_OFF			0x0
> +#define SVSB_EN_MASK			0x7
> +#define SVSB_EN_INIT01			0x1
> +#define SVSB_EN_INIT02			0x5
> +#define SVSB_EN_MON			0x2
> +#define SVSB_INTSTS_MONVOP		0x00ff0000
> +#define SVSB_INTSTS_COMPLETE		0x1
> +#define SVSB_INTSTS_CLEAN		0x00ffffff
> +
> +static DEFINE_SPINLOCK(mtk_svs_lock);
> +
> +/*

Thanks for using kernel-doc!! However, to be proper, this has to be
/**
  * ..........

> + * enum svsb_phase - svs bank phase enumeration
> + * @SVSB_PHASE_INIT01: basic init for svs bank
> + * @SVSB_PHASE_INIT02: svs bank can provide voltages
> + * @SVSB_PHASE_MON: svs bank can provide voltages with thermal effect
> + * @SVSB_PHASE_ERROR: svs bank encounters unexpected condition

Please move @SVSB_PHASE_ERROR before @SVSB_PHASE_INIT01: the order
is important here, and has to be the same as the actual enumeration.

> + *
> + * Each svs bank has its own independent phase. We enable each svs bank by
> + * running their phase orderly. However, When svs bank encounters unexpected
> + * condition, it will fire an irq (PHASE_ERROR) to inform svs software.
> + *
> + * svs bank general phase-enabled order:
> + * SVSB_PHASE_INIT01 -> SVSB_PHASE_INIT02 -> SVSB_PHASE_MON
> + */
> +enum svsb_phase {
> +	SVSB_PHASE_ERROR = 0,
> +	SVSB_PHASE_INIT01,
> +	SVSB_PHASE_INIT02,
> +	SVSB_PHASE_MON,
> +};
> +
> +enum svs_reg_index {
> +	DESCHAR = 0,
> +	TEMPCHAR,
> +	DETCHAR,
> +	AGECHAR,
> +	DCCONFIG,
> +	AGECONFIG,
> +	FREQPCT30,
> +	FREQPCT74,
> +	LIMITVALS,
> +	VBOOT,
> +	DETWINDOW,
> +	CONFIG,
> +	TSCALCS,
> +	RUNCONFIG,
> +	SVSEN,
> +	INIT2VALS,
> +	DCVALUES,
> +	AGEVALUES,
> +	VOP30,
> +	VOP74,
> +	TEMP,
> +	INTSTS,
> +	INTSTSRAW,
> +	INTEN,
> +	CHKINT,
> +	CHKSHIFT,
> +	STATUS,
> +	VDESIGN30,
> +	VDESIGN74,
> +	DVT30,
> +	DVT74,
> +	AGECOUNT,
> +	SMSTATE0,
> +	SMSTATE1,
> +	CTL0,
> +	DESDETSEC,
> +	TEMPAGESEC,
> +	CTRLSPARE0,
> +	CTRLSPARE1,
> +	CTRLSPARE2,
> +	CTRLSPARE3,
> +	CORESEL,
> +	THERMINTST,
> +	INTST,
> +	THSTAGE0ST,
> +	THSTAGE1ST,
> +	THSTAGE2ST,
> +	THAHBST0,
> +	THAHBST1,
> +	SPARE0,
> +	SPARE1,
> +	SPARE2,
> +	SPARE3,
> +	THSLPEVEB,
> +};
> +
> +static const u32 svs_regs_v2[] = {
> +	[DESCHAR]		= 0xc00,
> +	[TEMPCHAR]		= 0xc04,
> +	[DETCHAR]		= 0xc08,
> +	[AGECHAR]		= 0xc0c,
> +	[DCCONFIG]		= 0xc10,
> +	[AGECONFIG]		= 0xc14,
> +	[FREQPCT30]		= 0xc18,
> +	[FREQPCT74]		= 0xc1c,
> +	[LIMITVALS]		= 0xc20,
> +	[VBOOT]			= 0xc24,
> +	[DETWINDOW]		= 0xc28,
> +	[CONFIG]		= 0xc2c,
> +	[TSCALCS]		= 0xc30,
> +	[RUNCONFIG]		= 0xc34,
> +	[SVSEN]			= 0xc38,
> +	[INIT2VALS]		= 0xc3c,
> +	[DCVALUES]		= 0xc40,
> +	[AGEVALUES]		= 0xc44,
> +	[VOP30]			= 0xc48,
> +	[VOP74]			= 0xc4c,
> +	[TEMP]			= 0xc50,
> +	[INTSTS]		= 0xc54,
> +	[INTSTSRAW]		= 0xc58,
> +	[INTEN]			= 0xc5c,
> +	[CHKINT]		= 0xc60,
> +	[CHKSHIFT]		= 0xc64,
> +	[STATUS]		= 0xc68,
> +	[VDESIGN30]		= 0xc6c,
> +	[VDESIGN74]		= 0xc70,
> +	[DVT30]			= 0xc74,
> +	[DVT74]			= 0xc78,
> +	[AGECOUNT]		= 0xc7c,
> +	[SMSTATE0]		= 0xc80,
> +	[SMSTATE1]		= 0xc84,
> +	[CTL0]			= 0xc88,
> +	[DESDETSEC]		= 0xce0,
> +	[TEMPAGESEC]		= 0xce4,
> +	[CTRLSPARE0]		= 0xcf0,
> +	[CTRLSPARE1]		= 0xcf4,
> +	[CTRLSPARE2]		= 0xcf8,
> +	[CTRLSPARE3]		= 0xcfc,
> +	[CORESEL]		= 0xf00,
> +	[THERMINTST]		= 0xf04,
> +	[INTST]			= 0xf08,
> +	[THSTAGE0ST]		= 0xf0c,
> +	[THSTAGE1ST]		= 0xf10,
> +	[THSTAGE2ST]		= 0xf14,
> +	[THAHBST0]		= 0xf18,
> +	[THAHBST1]		= 0xf1c,
> +	[SPARE0]		= 0xf20,
> +	[SPARE1]		= 0xf24,
> +	[SPARE2]		= 0xf28,
> +	[SPARE3]		= 0xf2c,
> +	[THSLPEVEB]		= 0xf30,
> +};
> +
> +/*
> + * struct thermal_parameter - This is for storing thermal efuse data.
> + * We calculate thermal efuse data to produce "mts" and "bts" for
> + * svs bank mon mode.
> + */
> +struct thermal_parameter {
> +	int adc_ge_t;
> +	int adc_oe_t;
> +	int ge;
> +	int oe;
> +	int gain;
> +	int o_vtsabb;
> +	int o_vtsmcu1;
> +	int o_vtsmcu2;
> +	int o_vtsmcu3;
> +	int o_vtsmcu4;
> +	int o_vtsmcu5;
> +	int degc_cali;
> +	int adc_cali_en_t;
> +	int o_slope;
> +	int o_slope_sign;
> +	int ts_id;
> +};
> +
> +/*

Same here, use /**

> + * struct svs_platform - svs platform data
> + * @dev: svs platform device
> + * @base: svs platform register address base
> + * @main_clk: main clock for svs bank
> + * @pbank: phandle of svs bank and needs to be protected by spin_lock
> + * @banks: phandle of the banks that support
> + * @efuse_parsing: phandle of efuse parsing function
> + * @irqflags: irq settings flags
> + * @rst: svs reset control
> + * @regs: phandle to the registers map
> + * @efuse_num: the total number of svs platform efuse
> + * @tefuse_num: the total number of thermal efuse
> + * @bank_num: the total number of banks
> + * @efuse_check: the svs efuse check index
> + * @efuse: svs platform efuse data received from NVMEM framework
> + * @tefuse: thermal efuse data received from NVMEM framework
> + * @name: svs platform name
> + */
> +struct svs_platform {
> +	struct device *dev;
> +	void __iomem *base;
> +	struct clk *main_clk;
> +	struct svs_bank *pbank;
> +	struct svs_bank *banks;
> +	bool (*efuse_parsing)(struct svs_platform *svsp);
> +	unsigned long irqflags;
> +	struct reset_control *rst;
> +	const u32 *regs;
> +	char *name;
> +	size_t efuse_num;
> +	size_t tefuse_num;
> +	u32 bank_num;
> +	u32 efuse_check;
> +	u32 *efuse;
> +	u32 *tefuse;
> +};
> +
> +/*

ditto.

> + * struct svs_bank - svs bank representation
> + * @dev: svs bank device
> + * @opp_dev: device for opp table/buck control
> + * @pd_dev: power domain device for SoC mtcmos control
> + * @init_completion: the timeout completion for bank init
> + * @buck: phandle of the regulator
> + * @lock: mutex lock to protect voltage update process
> + * @phase: bank current phase
> + * @name: bank name
> + * @tzone_name: thermal zone name
> + * @buck_name: regulator name
> + * @suspended: suspend flag of this bank
> + * @pd_req: bank's power-domain on request
> + * @enable_pm_runtime_ever: bank enables pm-runtime flag
> + * @set_freqs_pct: phandle of set frequencies percent function
> + * @get_vops: phandle of get bank voltages function
> + * @volt_offset: bank voltage offset controlled by svs software
> + * @mode_support: bank mode support.
> + * @opp_freqs: signed-off frequencies from default opp table
> + * @opp_volts: signed-off voltages from default opp table
> + * @freqs_pct: percent of "opp_freqs / freq_base" for bank init
> + * @volts: bank voltages
> + * @freq_base: reference frequency for bank init
> + * @vboot: voltage request for bank init01 stage only
> + * @volt_step: bank voltage step
> + * @volt_base: bank voltage base
> + * @volt_flags: bank voltage flags
> + * @vmax: bank voltage maximum
> + * @vmin: bank voltage minimum
> + * @temp: bank temperature
> + * @temp_upper_bound: bank temperature upper bound
> + * @temp_lower_bound: bank temperature lower bound
> + * @tzone_high_temp: thermal zone high temperature threshold
> + * @tzone_high_temp_offset: thermal zone high temperature offset
> + * @tzone_low_temp: thermal zone low temperature threshold
> + * @tzone_low_temp_offset: thermal zone low temperature offset
> + * @core_sel: bank selection
> + * @opp_count: bank opp count
> + * @int_st: bank interrupt identification
> + * @sw_id: bank software identification
> + * @ctl0: bank thermal sensor selection
> + * @cpu_id: cpu core id for SVS CPU only
> + *
> + * Other structure members which are not listed above are svs platform
> + * efuse data for bank init
> + */
> +struct svs_bank {
> +	struct device *dev;
> +	struct device *opp_dev;
> +	struct device *pd_dev;
> +	struct completion init_completion;
> +	struct regulator *buck;
> +	struct mutex lock;	/* lock to protect voltage update process */
> +	enum svsb_phase phase;
> +	char *name;
> +	char *tzone_name;
> +	char *buck_name;
> +	bool suspended;
> +	bool pd_req;
> +	bool enable_pm_runtime_ever;
> +	void (*set_freqs_pct)(struct svs_platform *svsp);
> +	void (*get_vops)(struct svs_platform *svsp);
> +	s32 volt_offset;
> +	u32 mode_support;
> +	u32 opp_freqs[16];
> +	u32 opp_volts[16];
> +	u32 freqs_pct[16];
> +	u32 volts[16];
> +	u32 freq_base;
> +	u32 vboot;
> +	u32 volt_step;
> +	u32 volt_base;
> +	u32 volt_flags;
> +	u32 vmax;
> +	u32 vmin;
> +	u32 bts;
> +	u32 mts;
> +	u32 bdes;
> +	u32 mdes;
> +	u32 mtdes;
> +	u32 dcbdet;
> +	u32 dcmdet;
> +	u32 dthi;
> +	u32 dtlo;
> +	u32 det_window;
> +	u32 det_max;
> +	u32 age_config;
> +	u32 age_voffset_in;
> +	u32 agem;
> +	u32 dc_config;
> +	u32 dc_voffset_in;
> +	u32 dvt_fixed;
> +	u32 vco;
> +	u32 chk_shift;
> +	u32 temp;
> +	u32 temp_upper_bound;
> +	u32 temp_lower_bound;
> +	u32 tzone_high_temp;
> +	u32 tzone_high_temp_offset;
> +	u32 tzone_low_temp;
> +	u32 tzone_low_temp_offset;
> +	u32 core_sel;
> +	u32 opp_count;
> +	u32 int_st;
> +	u32 sw_id;
> +	u32 ctl0;
> +	u32 cpu_id;
> +};
> +
> +static u32 percent(u32 numerator, u32 denominator)
> +{
> +	/* If not divide 1000, "numerator * 100" will have data overflow. */
> +	numerator /= 1000;
> +	denominator /= 1000;
> +
> +	return DIV_ROUND_UP(numerator * 100, denominator);
> +}
> +
> +static u32 svs_readl(struct svs_platform *svsp, enum svs_reg_index rg_i)
> +{
> +	return readl(svsp->base + svsp->regs[rg_i]);
> +}
> +
> +static void svs_writel(struct svs_platform *svsp, u32 val,
> +		       enum svs_reg_index rg_i)
> +{
> +	writel(val, svsp->base + svsp->regs[rg_i]);
> +}
> +
> +static void svs_switch_bank(struct svs_platform *svsp)
> +{
> +	struct svs_bank *svsb = svsp->pbank;
> +
> +	svs_writel(svsp, svsb->core_sel, CORESEL);
> +}
> +
> +static u32 svs_bank_volt_to_opp_volt(u32 svsb_volt, u32 svsb_volt_step,
> +				     u32 svsb_volt_base)
> +{
> +	return (svsb_volt * svsb_volt_step) + svsb_volt_base;
> +}
> +
> +static int svs_get_bank_zone_temperature(const char *tzone_name,
> +					 int *tzone_temp)
> +{
> +	struct thermal_zone_device *tzd;
> +
> +	tzd = thermal_zone_get_zone_by_name(tzone_name);
> +	if (IS_ERR(tzd))
> +		return PTR_ERR(tzd);
> +
> +	return thermal_zone_get_temp(tzd, tzone_temp);
> +}
> +
> +static int svs_adjust_pm_opp_volts(struct svs_bank *svsb, bool force_update)
> +{
> +	int tzone_temp = 0, ret = -EPERM;
> +	u32 i, svsb_volt, opp_volt, temp_offset = 0;
> +
> +	mutex_lock(&svsb->lock);
> +
> +	/*
> +	 * If svs bank is suspended, it means signed-off voltages are applied.
> +	 * Don't need to update opp voltage anymore.
> +	 */
> +	if (svsb->suspended && !force_update) {
> +		dev_notice(svsb->dev, "bank is suspended\n");
> +		ret = -EPERM;
> +		goto unlock_mutex;
> +	}
> +
> +	/* Get thermal effect */
> +	if (svsb->phase == SVSB_PHASE_MON) {
> +		if (svsb->temp > svsb->temp_upper_bound &&
> +		    svsb->temp < svsb->temp_lower_bound) {
> +			dev_warn(svsb->dev, "svsb temp = 0x%x?\n", svsb->temp);
> +			ret = -EINVAL;
> +			goto unlock_mutex;
> +		}
> +
> +		ret = svs_get_bank_zone_temperature(svsb->tzone_name,
> +						    &tzone_temp);
> +		if (ret) {
> +			dev_err(svsb->dev, "no %s? (%d), run default volts\n",
> +				svsb->tzone_name, ret);
> +			svsb->phase = SVSB_PHASE_ERROR;
> +		}
> +
> +		if (tzone_temp >= svsb->tzone_high_temp)
> +			temp_offset += svsb->tzone_high_temp_offset;
> +		else if (tzone_temp <= svsb->tzone_low_temp)
> +			temp_offset += svsb->tzone_low_temp_offset;
> +	}
> +
> +	/* vmin <= svsb_volt (opp_volt) <= signed-off (default) voltage */
> +	for (i = 0; i < svsb->opp_count; i++) {

What about using switch here?

		switch (svsb->phase) {
		case SVSB_PHASE_MON:
			......
			break;
		case .......:
			.........
			break;
		default:
			dev_err(......);
			ret = -EINVAL;
			goto unlock_mutex;
		}

> +		if (svsb->phase == SVSB_PHASE_MON) {
> +			svsb_volt = max(svsb->volts[i] + svsb->volt_offset +
> +					temp_offset, svsb->vmin);
> +			opp_volt = svs_bank_volt_to_opp_volt(svsb_volt,
> +							     svsb->volt_step,
> +							     svsb->volt_base);
> +		} else if (svsb->phase == SVSB_PHASE_INIT02) {
> +			svsb_volt = max(svsb->volts[i] + svsb->volt_offset,
> +					svsb->vmin);
> +			opp_volt = svs_bank_volt_to_opp_volt(svsb_volt,
> +							     svsb->volt_step,
> +							     svsb->volt_base);
> +		} else if (svsb->phase == SVSB_PHASE_ERROR) {
> +			opp_volt = svsb->opp_volts[i];
> +		} else {
> +			dev_err(svsb->dev, "unknown phase: %u?\n", svsb->phase);
> +			ret = -EINVAL;
> +			goto unlock_mutex;
> +		}
> +
> +		opp_volt = min(opp_volt, svsb->opp_volts[i]);
> +		ret = dev_pm_opp_adjust_voltage(svsb->opp_dev,
> +						svsb->opp_freqs[i],
> +						opp_volt, opp_volt,
> +						svsb->opp_volts[i]);
> +		if (ret) {
> +			dev_err(svsb->dev, "set voltage fail: %d\n", ret);
> +			goto unlock_mutex;
> +		}
> +	}
> +
> +unlock_mutex:
> +	mutex_unlock(&svsb->lock);
> +
> +	return ret;
> +}
> +
> +static u32 interpolate(u32 f0, u32 f1, u32 v0, u32 v1, u32 fx)
> +{
> +	u32 vx;
> +
> +	if (v0 == v1 || f0 == f1)
> +		return v0;
> +
> +	/* *100 to have decimal fraction factor */
> +	vx = (v0 * 100) - ((((v0 - v1) * 100) / (f0 - f1)) * (f0 - fx));
> +
> +	return DIV_ROUND_UP(vx, 100);
> +}
> +
> +static void svs_get_vops_v2(struct svs_platform *svsp)
> +{
> +	struct svs_bank *svsb = svsp->pbank;
> +	u32 temp, i;
> +
> +	if (svsb->phase == SVSB_PHASE_MON &&
> +	    svsb->volt_flags & SVSB_MON_VOLT_IGNORE)
> +		return;
> +
> +	temp = svs_readl(svsp, VOP74);
> +	svsb->volts[14] = (temp >> 24) & GENMASK(7, 0);
> +	svsb->volts[12] = (temp >> 16) & GENMASK(7, 0);
> +	svsb->volts[10] = (temp >> 8)  & GENMASK(7, 0);
> +	svsb->volts[8] = (temp & GENMASK(7, 0));
> +
> +	temp = svs_readl(svsp, VOP30);
> +	svsb->volts[6] = (temp >> 24) & GENMASK(7, 0);
> +	svsb->volts[4] = (temp >> 16) & GENMASK(7, 0);
> +	svsb->volts[2] = (temp >> 8)  & GENMASK(7, 0);
> +	svsb->volts[0] = (temp & GENMASK(7, 0));
> +
> +	for (i = 0; i <= 12; i += 2)
> +		svsb->volts[i + 1] =
> +			interpolate(svsb->freqs_pct[i],
> +				    svsb->freqs_pct[i + 2],
> +				    svsb->volts[i],
> +				    svsb->volts[i + 2],
> +				    svsb->freqs_pct[i + 1]);
> +
> +	svsb->volts[15] =
> +		interpolate(svsb->freqs_pct[12],
> +			    svsb->freqs_pct[14],
> +			    svsb->volts[12],
> +			    svsb->volts[14],
> +			    svsb->freqs_pct[15]);
> +
> +	if (svsb->volt_flags & SVSB_INIT02_RM_DVTFIXED)
> +		for (i = 0; i < svsb->opp_count; i++)
> +			svsb->volts[i] -= svsb->dvt_fixed;
> +}
> +
> +static void svs_set_freqs_pct_v2(struct svs_platform *svsp)
> +{
> +	struct svs_bank *svsb = svsp->pbank;
> +
> +	svs_writel(svsp,
> +		   (svsb->freqs_pct[14] << 24) |
> +		   (svsb->freqs_pct[12] << 16) |
> +		   (svsb->freqs_pct[10] << 8) |
> +		   svsb->freqs_pct[8],
> +		   FREQPCT74);
> +
> +	svs_writel(svsp,
> +		   (svsb->freqs_pct[6] << 24) |
> +		   (svsb->freqs_pct[4] << 16) |
> +		   (svsb->freqs_pct[2] << 8) |
> +		   svsb->freqs_pct[0],
> +		   FREQPCT30);
> +}
> +
> +static void svs_set_bank_phase(struct svs_platform *svsp,
> +			       enum svsb_phase target_phase)
> +{
> +	struct svs_bank *svsb = svsp->pbank;
> +	u32 des_char, temp_char, det_char, limit_vals;
> +	u32 init2vals, ts_calcs, val, filter, i;
> +
> +	svs_switch_bank(svsp);
> +
> +	des_char = (svsb->bdes << 8) | svsb->mdes;
> +	svs_writel(svsp, des_char, DESCHAR);
> +
> +	temp_char = (svsb->vco << 16) | (svsb->mtdes << 8) | svsb->dvt_fixed;
> +	svs_writel(svsp, temp_char, TEMPCHAR);
> +
> +	det_char = (svsb->dcbdet << 8) | svsb->dcmdet;
> +	svs_writel(svsp, det_char, DETCHAR);
> +
> +	svs_writel(svsp, svsb->dc_config, DCCONFIG);
> +	svs_writel(svsp, svsb->age_config, AGECONFIG);
> +
> +	if (!svsb->agem) {
> +		svs_writel(svsp, SVSB_RUNCONFIG_DEFAULT, RUNCONFIG);
> +	} else {
> +		val = 0x0;

		val = 0;

> +
> +		for (i = 0; i < 24; i += 2) {
> +			filter = 0x3 << i;
> +
> +			if (!(svsb->age_config & filter))
> +				val |= (0x1 << i);

				val |= BIT(i);

> +			else
> +				val |= (svsb->age_config & filter);
> +		}
> +		svs_writel(svsp, val, RUNCONFIG);
> +	}
> +
> +	svsb->set_freqs_pct(svsp);
> +
> +	limit_vals = (svsb->vmax << 24) | (svsb->vmin << 16) |
> +		     (svsb->dthi << 8) | svsb->dtlo;
> +	svs_writel(svsp, limit_vals, LIMITVALS);
> +	svs_writel(svsp, svsb->vboot, VBOOT);
> +	svs_writel(svsp, svsb->det_window, DETWINDOW);
> +	svs_writel(svsp, svsb->det_max, CONFIG);
> +
> +	if (svsb->chk_shift)
> +		svs_writel(svsp, svsb->chk_shift, CHKSHIFT);
> +
> +	if (svsb->ctl0)
> +		svs_writel(svsp, svsb->ctl0, CTL0);
> +
> +	svs_writel(svsp, SVSB_INTSTS_CLEAN, INTSTS);
> +
> +	switch (target_phase) {
> +	case SVSB_PHASE_INIT01:
> +		svs_writel(svsp, SVSB_INTEN_INIT0x, INTEN);
> +		svs_writel(svsp, SVSB_EN_INIT01, SVSEN);
> +		break;
> +	case SVSB_PHASE_INIT02:
> +		svs_writel(svsp, SVSB_INTEN_INIT0x, INTEN);
> +		init2vals = (svsb->age_voffset_in << 16) | svsb->dc_voffset_in;
> +		svs_writel(svsp, init2vals, INIT2VALS);
> +		svs_writel(svsp, SVSB_EN_INIT02, SVSEN);
> +		break;
> +	case SVSB_PHASE_MON:
> +		ts_calcs = (svsb->bts << 12) | svsb->mts;
> +		svs_writel(svsp, ts_calcs, TSCALCS);
> +		svs_writel(svsp, SVSB_INTEN_MONVOPEN, INTEN);
> +		svs_writel(svsp, SVSB_EN_MON, SVSEN);
> +		break;
> +	default:
> +		WARN_ON(1);

I agree about printing a big warning in kmsg here, but you can do that in a
slightly more descriptive way:

		WARN(1, "Requested unknown target phase %u", target_phase);

> +		break;
> +	}
> +}
> +
> +static inline void svs_init01_isr_handler(struct svs_platform *svsp)
> +{
> +	struct svs_bank *svsb = svsp->pbank;
> +
> +	dev_info(svsb->dev, "%s: VDN74~30:0x%08x~0x%08x, DC:0x%08x\n",
> +		 __func__, svs_readl(svsp, VDESIGN74),
> +		 svs_readl(svsp, VDESIGN30), svs_readl(svsp, DCVALUES));
> +
> +	svsb->phase = SVSB_PHASE_INIT01;
> +	svsb->dc_voffset_in = ~(svs_readl(svsp, DCVALUES) & GENMASK(15, 0)) + 1;
> +	if (svsb->volt_flags & SVSB_INIT01_VOLT_IGNORE ||
> +	    (svsb->dc_voffset_in & SVSB_DC_SIGNED_BIT &&
> +	     svsb->volt_flags & SVSB_INIT01_VOLT_INC_ONLY))
> +		svsb->dc_voffset_in = 0;
> +
> +	svsb->age_voffset_in = svs_readl(svsp, AGEVALUES) & GENMASK(15, 0);
> +
> +	svs_writel(svsp, SVSB_EN_OFF, SVSEN);
> +	svs_writel(svsp, SVSB_INTSTS_COMPLETE, INTSTS);
> +
> +	/* svs init01 clock gating */
> +	svsb->core_sel &= ~SVSB_DET_CLK_EN;
> +}
> +
> +static inline void svs_init02_isr_handler(struct svs_platform *svsp)
> +{
> +	struct svs_bank *svsb = svsp->pbank;
> +
> +	dev_info(svsb->dev, "%s: VOP74~30:0x%08x~0x%08x, DC:0x%08x\n",
> +		 __func__, svs_readl(svsp, VOP74), svs_readl(svsp, VOP30),
> +		 svs_readl(svsp, DCVALUES));
> +
> +	svsb->phase = SVSB_PHASE_INIT02;
> +	svsb->get_vops(svsp);
> +
> +	svs_writel(svsp, SVSB_EN_OFF, SVSEN);
> +	svs_writel(svsp, SVSB_INTSTS_COMPLETE, INTSTS);
> +}
> +
> +static inline void svs_mon_mode_isr_handler(struct svs_platform *svsp)
> +{
> +	struct svs_bank *svsb = svsp->pbank;
> +
> +	svsb->phase = SVSB_PHASE_MON;
> +	svsb->temp = svs_readl(svsp, TEMP) & GENMASK(7, 0);
> +	svsb->get_vops(svsp);
> +
> +	svs_writel(svsp, SVSB_INTSTS_MONVOP, INTSTS);
> +}
> +
> +static inline void svs_error_isr_handler(struct svs_platform *svsp)
> +{
> +	struct svs_bank *svsb = svsp->pbank;
> +
> +	dev_err(svsb->dev, "%s: CORESEL = 0x%08x\n",
> +		__func__, svs_readl(svsp, CORESEL));
> +	dev_err(svsb->dev, "SVSEN = 0x%08x, INTSTS = 0x%08x\n",
> +		svs_readl(svsp, SVSEN), svs_readl(svsp, INTSTS));
> +	dev_err(svsb->dev, "SMSTATE0 = 0x%08x, SMSTATE1 = 0x%08x\n",
> +		svs_readl(svsp, SMSTATE0), svs_readl(svsp, SMSTATE1));
> +	dev_err(svsb->dev, "TEMP = 0x%08x\n", svs_readl(svsp, TEMP));
> +
> +	svsb->mode_support = SVSB_MODE_ALL_DISABLE;
> +	svsb->phase = SVSB_PHASE_ERROR;
> +
> +	svs_writel(svsp, SVSB_EN_OFF, SVSEN);
> +	svs_writel(svsp, SVSB_INTSTS_CLEAN, INTSTS);
> +}
> +
> +static irqreturn_t svs_isr(int irq, void *data)
> +{
> +	struct svs_platform *svsp = data;
> +	struct svs_bank *svsb = NULL;
> +	unsigned long flags;
> +	u32 idx, int_sts, svs_en;
> +
> +	for (idx = 0; idx < svsp->bank_num; idx++) {
> +		svsb = &svsp->banks[idx];
> +		WARN_ON(!svsb);
> +
> +		spin_lock_irqsave(&mtk_svs_lock, flags);
> +		svsp->pbank = svsb;
> +
> +		/* Find out which svs bank fires interrupt */
> +		if (svsb->int_st & svs_readl(svsp, INTST)) {
> +			spin_unlock_irqrestore(&mtk_svs_lock, flags);
> +			continue;
> +		}
> +
> +		if (!svsb->suspended) {
> +			svs_switch_bank(svsp);
> +			int_sts = svs_readl(svsp, INTSTS);
> +			svs_en = svs_readl(svsp, SVSEN) & SVSB_EN_MASK;
> +
> +			if (int_sts == SVSB_INTSTS_COMPLETE &&
> +			    svs_en == SVSB_EN_INIT01)
> +				svs_init01_isr_handler(svsp);
> +			else if (int_sts == SVSB_INTSTS_COMPLETE &&
> +				 svs_en == SVSB_EN_INIT02)
> +				svs_init02_isr_handler(svsp);
> +			else if (int_sts & SVSB_INTSTS_MONVOP)
> +				svs_mon_mode_isr_handler(svsp);
> +			else
> +				svs_error_isr_handler(svsp);
> +		}
> +
> +		spin_unlock_irqrestore(&mtk_svs_lock, flags);
> +		break;
> +	}
> +
> +	if (svsb->phase != SVSB_PHASE_INIT01)
> +		svs_adjust_pm_opp_volts(svsb, false);
> +
> +	if (svsb->phase == SVSB_PHASE_INIT01 ||
> +	    svsb->phase == SVSB_PHASE_INIT02)
> +		complete(&svsb->init_completion);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static void svs_mon_mode(struct svs_platform *svsp)
> +{
> +	struct svs_bank *svsb;
> +	unsigned long flags;
> +	u32 idx;
> +
> +	for (idx = 0; idx < svsp->bank_num; idx++) {
> +		svsb = &svsp->banks[idx];
> +
> +		if (!(svsb->mode_support & SVSB_MODE_MON))
> +			continue;
> +
> +		spin_lock_irqsave(&mtk_svs_lock, flags);
> +		svsp->pbank = svsb;
> +		svs_set_bank_phase(svsp, SVSB_PHASE_MON);
> +		spin_unlock_irqrestore(&mtk_svs_lock, flags);
> +	}
> +}
> +
> +static int svs_init02(struct svs_platform *svsp)
> +{
> +	struct svs_bank *svsb;
> +	unsigned long flags, time_left;
> +	u32 idx;
> +
> +	for (idx = 0; idx < svsp->bank_num; idx++) {
> +		svsb = &svsp->banks[idx];
> +
> +		if (!(svsb->mode_support & SVSB_MODE_INIT02))
> +			continue;
> +
> +		reinit_completion(&svsb->init_completion);
> +		spin_lock_irqsave(&mtk_svs_lock, flags);
> +		svsp->pbank = svsb;
> +		svs_set_bank_phase(svsp, SVSB_PHASE_INIT02);
> +		spin_unlock_irqrestore(&mtk_svs_lock, flags);
> +
> +		time_left =
> +			wait_for_completion_timeout(&svsb->init_completion,
> +						    msecs_to_jiffies(5000));

There's no need to break the line... that's going to be fine:

		time_left = wait_for_completion_timeout(&svsb->init_completion,

							msecs_to_jiffies(5000));

> +		if (!time_left) {
> +			dev_err(svsb->dev, "init02 completion timeout\n");
> +			return -EBUSY;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int svs_init01(struct svs_platform *svsp)
> +{
> +	struct svs_bank *svsb;
> +	struct pm_qos_request *qos_request;
> +	unsigned long flags, time_left;
> +	bool search_done;
> +	int ret = 0;
> +	u32 opp_freqs, opp_vboot, buck_volt, idx, i;
> +
> +	qos_request = kzalloc(sizeof(*qos_request), GFP_KERNEL);
> +	if (!qos_request)
> +		return -ENOMEM;
> +
> +	/* Let CPUs leave idle-off state for initializing svs_init01. */
> +	cpu_latency_qos_add_request(qos_request, 0);
> +
> +	/*
> +	 * Sometimes two svs banks use the same buck.
> +	 * Therefore, we set each svs bank to vboot voltage first.
> +	 */
> +	for (idx = 0; idx < svsp->bank_num; idx++) {
> +		svsb = &svsp->banks[idx];
> +
> +		if (!(svsb->mode_support & SVSB_MODE_INIT01))
> +			continue;
> +
> +		search_done = false;
> +
> +		if (svsb->pd_req) {
> +			ret = regulator_enable(svsb->buck);
> +			if (ret) {
> +				dev_err(svsb->dev, "%s enable fail: %d\n",
> +					svsb->buck_name, ret);
> +				goto init01_finish;
> +			}
> +
> +			if (!pm_runtime_enabled(svsb->pd_dev)) {
> +				pm_runtime_enable(svsb->pd_dev);
> +				svsb->enable_pm_runtime_ever = true;
> +			}
> +
> +			ret = pm_runtime_get_sync(svsb->pd_dev);
> +			if (ret < 0) {
> +				dev_err(svsb->dev, "mtcmos on fail: %d\n", ret);
> +				goto init01_finish;
> +			}
> +		}
> +
> +		if (regulator_set_mode(svsb->buck, REGULATOR_MODE_FAST))
> +			dev_notice(svsb->dev, "set fast mode fail\n");
> +
> +		/*
> +		 * Find the fastest freq that can be run at vboot and
> +		 * fix to that freq until svs_init01 is done.
> +		 */
> +		opp_vboot = svs_bank_volt_to_opp_volt(svsb->vboot,
> +						      svsb->volt_step,
> +						      svsb->volt_base);
> +
> +		for (i = 0; i < svsb->opp_count; i++) {
> +			opp_freqs = svsb->opp_freqs[i];
> +			if (!search_done && svsb->opp_volts[i] <= opp_vboot) {
> +				ret = dev_pm_opp_adjust_voltage(svsb->opp_dev,
> +								opp_freqs,
> +								opp_vboot,
> +								opp_vboot,
> +								opp_vboot);
> +				if (ret) {
> +					dev_err(svsb->dev,
> +						"set voltage fail: %d\n", ret);
> +					goto init01_finish;
> +				}
> +
> +				search_done = true;
> +			} else {
> +				dev_pm_opp_disable(svsb->opp_dev,
> +						   svsb->opp_freqs[i]);
> +			}
> +		}
> +	}
> +
> +	/* svs bank init01 begins */
> +	for (idx = 0; idx < svsp->bank_num; idx++) {
> +		svsb = &svsp->banks[idx];
> +
> +		if (!(svsb->mode_support & SVSB_MODE_INIT01))
> +			continue;
> +
> +		opp_vboot = svs_bank_volt_to_opp_volt(svsb->vboot,
> +						      svsb->volt_step,
> +						      svsb->volt_base);
> +
> +		buck_volt = regulator_get_voltage(svsb->buck);
> +		if (buck_volt != opp_vboot) {
> +			dev_err(svsb->dev,
> +				"buck voltage: %u, expected vboot: %u\n",
> +				buck_volt, opp_vboot);
> +			ret = -EPERM;
> +			goto init01_finish;
> +		}
> +
> +		spin_lock_irqsave(&mtk_svs_lock, flags);
> +		svsp->pbank = svsb;
> +		svs_set_bank_phase(svsp, SVSB_PHASE_INIT01);
> +		spin_unlock_irqrestore(&mtk_svs_lock, flags);
> +
> +		time_left =
> +			wait_for_completion_timeout(&svsb->init_completion,

81 columns is ok to have.

> +						    msecs_to_jiffies(5000));
> +		if (!time_left) {
> +			dev_err(svsb->dev, "init01 completion timeout\n");
> +			ret = -EBUSY;
> +			goto init01_finish;
> +		}
> +	}
> +
> +init01_finish:
> +	for (idx = 0; idx < svsp->bank_num; idx++) {
> +		svsb = &svsp->banks[idx];
> +
> +		if (!(svsb->mode_support & SVSB_MODE_INIT01))
> +			continue;
> +
> +		for (i = 0; i < svsb->opp_count; i++)
> +			dev_pm_opp_enable(svsb->opp_dev, svsb->opp_freqs[i]);
> +
> +		if (regulator_set_mode(svsb->buck, REGULATOR_MODE_NORMAL))
> +			dev_notice(svsb->dev, "fail to set normal mode\n");
> +
> +		if (svsb->pd_req) {
> +			if (pm_runtime_put_sync(svsb->pd_dev))
> +				dev_err(svsb->dev, "mtcmos off fail\n");
> +
> +			if (svsb->enable_pm_runtime_ever) {
> +				pm_runtime_disable(svsb->pd_dev);
> +				svsb->enable_pm_runtime_ever = false;
> +			}
> +
> +			if (regulator_disable(svsb->buck))
> +				dev_err(svsb->dev, "%s disable fail: %d\n",
> +					svsb->buck_name, ret);
> +		}
> +	}
> +
> +	cpu_latency_qos_remove_request(qos_request);
> +	kfree(qos_request);
> +
> +	return ret;
> +}
> +
> +static int svs_start(struct svs_platform *svsp)
> +{
> +	int ret;
> +
> +	ret = svs_init01(svsp);
> +	if (ret)
> +		return ret;
> +
> +	ret = svs_init02(svsp);
> +	if (ret)
> +		return ret;
> +
> +	svs_mon_mode(svsp);
> +
> +	return 0;
> +}
> +
> +static struct device *svs_get_subsys_device(struct svs_platform *svsp,
> +					    const char *node_name)
> +{
> +	struct platform_device *pdev;
> +	struct device_node *np;
> +
> +	np = of_find_node_by_name(NULL, node_name);
> +	if (!np) {
> +		dev_err(svsp->dev, "cannot find %s node\n", node_name);
> +		return ERR_PTR(-ENODEV);
> +	}
> +
> +	pdev = of_find_device_by_node(np);
> +	if (!pdev) {
> +		of_node_put(np);
> +		dev_err(svsp->dev, "cannot find pdev by %s\n", node_name);
> +		return ERR_PTR(-ENXIO);
> +	}
> +
> +	of_node_put(np);
> +
> +	return &pdev->dev;
> +}
> +
> +static struct device *svs_add_device_link(struct svs_platform *svsp,
> +					  const char *node_name)
> +{
> +	struct device *dev;
> +	struct device_link *sup_link;
> +
> +	if (!node_name) {
> +		dev_err(svsp->dev, "node name cannot be null\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	dev = svs_get_subsys_device(svsp, node_name);
> +	if (IS_ERR(dev))
> +		return dev;
> +
> +	sup_link = device_link_add(svsp->dev, dev,
> +				   DL_FLAG_AUTOREMOVE_CONSUMER);
> +	if (!sup_link) {
> +		dev_err(svsp->dev, "sup_link is NULL\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	if (sup_link->supplier->links.status != DL_DEV_DRIVER_BOUND)
> +		return ERR_PTR(-EPROBE_DEFER);
> +
> +	return dev;
> +}
> +
> +static int svs_resource_setup(struct svs_platform *svsp)
> +{
> +	struct svs_bank *svsb;
> +	struct dev_pm_opp *opp;
> +	unsigned long freq;
> +	int count, ret;
> +	u32 idx, i;
> +
> +	dev_set_drvdata(svsp->dev, svsp);
> +
> +	for (idx = 0; idx < svsp->bank_num; idx++) {
> +		svsb = &svsp->banks[idx];
> +
> +		switch (svsb->sw_id) {
> +		case SVSB_CPU_LITTLE:
> +			svsb->name = "SVSB_CPU_LITTLE";
> +			break;
> +		case SVSB_CPU_BIG:
> +			svsb->name = "SVSB_CPU_BIG";
> +			break;
> +		case SVSB_CCI:
> +			svsb->name = "SVSB_CCI";
> +			break;
> +		case SVSB_GPU:
> +			svsb->name = "SVSB_GPU";
> +			break;
> +		default:
> +			WARN_ON(1);
> +			return -EINVAL;
> +		}
> +
> +		svsb->dev = devm_kzalloc(svsp->dev, sizeof(*svsb->dev),
> +					 GFP_KERNEL);
> +		if (!svsb->dev)
> +			return -ENOMEM;
> +
> +		ret = dev_set_name(svsb->dev, "%s", svsb->name);
> +		if (ret)
> +			return ret;
> +
> +		dev_set_drvdata(svsb->dev, svsp);
> +
> +		ret = dev_pm_opp_of_add_table(svsb->opp_dev);
> +		if (ret) {
> +			dev_err(svsb->dev, "add opp table fail: %d\n", ret);
> +			return ret;
> +		}
> +
> +		mutex_init(&svsb->lock);
> +		init_completion(&svsb->init_completion);
> +
> +		svsb->buck = devm_regulator_get_optional(svsb->opp_dev,
> +							 svsb->buck_name);
> +		if (IS_ERR(svsb->buck)) {
> +			dev_err(svsb->dev, "cannot get \"%s-supply\"\n",
> +				svsb->buck_name);
> +			return PTR_ERR(svsb->buck);
> +		}
> +
> +		count = dev_pm_opp_get_opp_count(svsb->opp_dev);
> +		if (svsb->opp_count != count) {
> +			dev_err(svsb->dev,
> +				"opp_count not \"%u\" but get \"%d\"?\n",
> +				svsb->opp_count, count);
> +			return count;
> +		}
> +
> +		for (i = 0, freq = U32_MAX; i < svsb->opp_count; i++, freq--) {
> +			opp = dev_pm_opp_find_freq_floor(svsb->opp_dev, &freq);
> +			if (IS_ERR(opp)) {
> +				dev_err(svsb->dev, "cannot find freq = %ld\n",
> +					PTR_ERR(opp));
> +				return PTR_ERR(opp);
> +			}
> +
> +			svsb->opp_freqs[i] = freq;
> +			svsb->opp_volts[i] = dev_pm_opp_get_voltage(opp);
> +			svsb->freqs_pct[i] = percent(svsb->opp_freqs[i],
> +						     svsb->freq_base);
> +			dev_pm_opp_put(opp);
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static bool svs_mt8183_efuse_parsing(struct svs_platform *svsp)
> +{
> +	struct thermal_parameter tp;
> +	struct svs_bank *svsb;
> +	bool mon_mode_support = true;
> +	int format[6], x_roomt[6], tb_roomt = 0;
> +	struct nvmem_cell *cell;
> +	u32 idx, i, ft_pgm, mts, temp0, temp1, temp2;
> +
> +	for (i = 0; i < svsp->efuse_num; i++)
> +		if (svsp->efuse[i])
> +			dev_info(svsp->dev, "M_HW_RES%d: 0x%08x\n",
> +				 i, svsp->efuse[i]);
> +
> +	/* Svs efuse parsing */
> +	ft_pgm = (svsp->efuse[0] >> 4) & GENMASK(3, 0);
> +
> +	for (idx = 0; idx < svsp->bank_num; idx++) {
> +		svsb = &svsp->banks[idx];
> +
> +		if (ft_pgm <= 1)
> +			svsb->volt_flags |= SVSB_INIT01_VOLT_IGNORE;
> +
> +		switch (svsb->sw_id) {
> +		case SVSB_CPU_LITTLE:
> +			svsb->bdes = svsp->efuse[16] & GENMASK(7, 0);
> +			svsb->mdes = (svsp->efuse[16] >> 8) & GENMASK(7, 0);
> +			svsb->dcbdet = (svsp->efuse[16] >> 16) & GENMASK(7, 0);
> +			svsb->dcmdet = (svsp->efuse[16] >> 24) & GENMASK(7, 0);
> +			svsb->mtdes  = (svsp->efuse[17] >> 16) & GENMASK(7, 0);
> +
> +			if (ft_pgm <= 3)
> +				svsb->volt_offset += 10;
> +			else
> +				svsb->volt_offset += 2;
> +			break;
> +		case SVSB_CPU_BIG:
> +			svsb->bdes = svsp->efuse[18] & GENMASK(7, 0);
> +			svsb->mdes = (svsp->efuse[18] >> 8) & GENMASK(7, 0);
> +			svsb->dcbdet = (svsp->efuse[18] >> 16) & GENMASK(7, 0);
> +			svsb->dcmdet = (svsp->efuse[18] >> 24) & GENMASK(7, 0);
> +			svsb->mtdes  = svsp->efuse[17] & GENMASK(7, 0);
> +
> +			if (ft_pgm <= 3)
> +				svsb->volt_offset += 15;
> +			else
> +				svsb->volt_offset += 12;
> +			break;
> +		case SVSB_CCI:
> +			svsb->bdes = svsp->efuse[4] & GENMASK(7, 0);
> +			svsb->mdes = (svsp->efuse[4] >> 8) & GENMASK(7, 0);
> +			svsb->dcbdet = (svsp->efuse[4] >> 16) & GENMASK(7, 0);
> +			svsb->dcmdet = (svsp->efuse[4] >> 24) & GENMASK(7, 0);
> +			svsb->mtdes  = (svsp->efuse[5] >> 16) & GENMASK(7, 0);
> +
> +			if (ft_pgm <= 3)
> +				svsb->volt_offset += 10;
> +			else
> +				svsb->volt_offset += 2;
> +			break;
> +		case SVSB_GPU:
> +			svsb->bdes = svsp->efuse[6] & GENMASK(7, 0);
> +			svsb->mdes = (svsp->efuse[6] >> 8) & GENMASK(7, 0);
> +			svsb->dcbdet = (svsp->efuse[6] >> 16) & GENMASK(7, 0);
> +			svsb->dcmdet = (svsp->efuse[6] >> 24) & GENMASK(7, 0);
> +			svsb->mtdes  = svsp->efuse[5] & GENMASK(7, 0);
> +
> +			if (ft_pgm >= 2) {
> +				svsb->freq_base = 800000000; /* 800MHz */
> +				svsb->dvt_fixed = 2;
> +			}
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +
> +	/* Get thermal efuse by nvmem */
> +	cell = nvmem_cell_get(svsp->dev, "t-calibration-data");
> +	if (IS_ERR_OR_NULL(cell)) {
> +		dev_err(svsp->dev, "no thermal cell, no mon mode\n");
> +		for (idx = 0; idx < svsp->bank_num; idx++) {
> +			svsb = &svsp->banks[idx];
> +			svsb->mode_support &= ~SVSB_MODE_MON;
> +		}
> +
> +		return true;
> +	}
> +
> +	svsp->tefuse = nvmem_cell_read(cell, &svsp->tefuse_num);

nvmem_cell_read may return an error pointer: you have to check that.

	if (IS_ERR(svsp->tefuse))
		.........

Failing to perform this check will produce unpredictable behavior
during the parsing stage.

> +	svsp->tefuse_num /= sizeof(u32);
> +	nvmem_cell_put(cell);
> +
> +	/* Thermal efuse parsing */
> +	tp.adc_ge_t = (svsp->tefuse[1] >> 22) & GENMASK(9, 0);
> +	tp.adc_oe_t = (svsp->tefuse[1] >> 12) & GENMASK(9, 0);
> +
> +	tp.o_vtsmcu1 = (svsp->tefuse[0] >> 17) & GENMASK(8, 0);
> +	tp.o_vtsmcu2 = (svsp->tefuse[0] >> 8) & GENMASK(8, 0);
> +	tp.o_vtsmcu3 = svsp->tefuse[1] & GENMASK(8, 0);
> +	tp.o_vtsmcu4 = (svsp->tefuse[2] >> 23) & GENMASK(8, 0);
> +	tp.o_vtsmcu5 = (svsp->tefuse[2] >> 5) & GENMASK(8, 0);
> +	tp.o_vtsabb = (svsp->tefuse[2] >> 14) & GENMASK(8, 0);
> +
> +	tp.degc_cali = (svsp->tefuse[0] >> 1) & GENMASK(5, 0);
> +	tp.adc_cali_en_t = svsp->tefuse[0] & BIT(0);
> +	tp.o_slope_sign = (svsp->tefuse[0] >> 7) & BIT(0);
> +
> +	tp.ts_id = (svsp->tefuse[1] >> 9) & BIT(0);
> +	tp.o_slope = (svsp->tefuse[0] >> 26) & GENMASK(5, 0);
> +

Regards,
- Angelo



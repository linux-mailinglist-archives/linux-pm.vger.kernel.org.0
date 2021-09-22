Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8DDD414B1A
	for <lists+linux-pm@lfdr.de>; Wed, 22 Sep 2021 15:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232895AbhIVNzC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 Sep 2021 09:55:02 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:42266 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232213AbhIVNzA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 Sep 2021 09:55:00 -0400
X-UUID: 9378bcf779b644509b35f0aa320da901-20210922
X-UUID: 9378bcf779b644509b35f0aa320da901-20210922
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <roger.lu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1107840328; Wed, 22 Sep 2021 21:53:27 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 22 Sep 2021 21:53:25 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 22 Sep 2021 21:53:25 +0800
Message-ID: <112e94e60e7f83b0932c3feb96575db5713433ed.camel@mediatek.com>
Subject: Re: [PATCH v20 3/7] soc: mediatek: SVS: introduce MTK SVS engine
From:   mtk11157 <roger.lu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Boichat <drinkcat@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     Fan Chen <fan.chen@mediatek.com>,
        HenryC Chen <HenryC.Chen@mediatek.com>,
        YT Lee <yt.lee@mediatek.com>,
        Xiaoqing Liu <Xiaoqing.Liu@mediatek.com>,
        Charles Yang <Charles.Yang@mediatek.com>,
        Angus Lin <Angus.Lin@mediatek.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nishanth Menon <nm@ti.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Guenter Roeck <linux@roeck-us.net>
Date:   Wed, 22 Sep 2021 21:53:25 +0800
In-Reply-To: <495a2300-ca65-9caf-1522-1c44e5892c39@gmail.com>
References: <20210721070904.15636-1-roger.lu@mediatek.com>
         <20210721070904.15636-4-roger.lu@mediatek.com>
         <495a2300-ca65-9caf-1522-1c44e5892c39@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Matthias,

Sorry for the late reply and thanks for all the advices.
I'll update next version based on the feedback from this comment.
Thanks very much again.

On Fri, 2021-09-03 at 16:26 +0200, Matthias Brugger wrote:
> 
> On 21/07/2021 09:09, Roger Lu wrote:
> > The Smart Voltage Scaling(SVS) engine is a piece of hardware
> > which calculates suitable SVS bank voltages to OPP voltage table.
> > Then, DVFS driver could apply those SVS bank voltages to PMIC/Buck
> > when receiving OPP_EVENT_ADJUST_VOLTAGE.
> > 
> > Signed-off-by: Roger Lu <roger.lu@mediatek.com>
> > ---
> >  drivers/soc/mediatek/Kconfig   |   10 +
> >  drivers/soc/mediatek/Makefile  |    1 +
> >  drivers/soc/mediatek/mtk-svs.c | 1720 ++++++++++++++++++++++++++++++++
> 
> That's a lot of code. Are you sure you tried hard to just implement basic
> functionality. It'll take a long time to even understand what the driver does
> etc. If there is a minimal working version that is smaller, then that could be
> a
> good starting point for review.
> 
> For example, leave alone monitor mode for now, as not all banks use it, and we
> can live with it disabled due to missing efuse data.
> 
> Please see below some random comments. I wasn't able to read and understand
> the
> whole driver but I have doubts about some basic building blocks of it.

Thanks for the advice. I'll separate svs_init01/svs_init02 and monitor mode in
two patches for minimal working version support.

> 
> >  3 files changed, 1731 insertions(+)
> >  create mode 100644 drivers/soc/mediatek/mtk-svs.c
> > 
> > diff --git a/drivers/soc/mediatek/Kconfig b/drivers/soc/mediatek/Kconfig
> > index fdd8bc08569e..3c3eedea35f7 100644
> > --- a/drivers/soc/mediatek/Kconfig
> > +++ b/drivers/soc/mediatek/Kconfig
> > @@ -73,4 +73,14 @@ config MTK_MMSYS
> >  	  Say yes here to add support for the MediaTek Multimedia
> >  	  Subsystem (MMSYS).
> >  
> > +config MTK_SVS
> > +	tristate "MediaTek Smart Voltage Scaling(SVS)"
> > +	depends on MTK_EFUSE && NVMEM
> > +	help
> > +	  The Smart Voltage Scaling(SVS) engine is a piece of hardware
> > +	  which has several controllers(banks) for calculating suitable
> > +	  voltage to different power domains(CPU/GPU/CCI) according to
> > +	  chip process corner, temperatures and other factors. Then DVFS
> > +	  driver could apply SVS bank voltage to PMIC/Buck.
> > +
> >  endmenu
> > diff --git a/drivers/soc/mediatek/Makefile b/drivers/soc/mediatek/Makefile
> > index 90270f8114ed..0e9e703c931a 100644
> > --- a/drivers/soc/mediatek/Makefile
> > +++ b/drivers/soc/mediatek/Makefile
> > @@ -7,3 +7,4 @@ obj-$(CONFIG_MTK_SCPSYS) += mtk-scpsys.o
> >  obj-$(CONFIG_MTK_SCPSYS_PM_DOMAINS) += mtk-pm-domains.o
> >  obj-$(CONFIG_MTK_MMSYS) += mtk-mmsys.o
> >  obj-$(CONFIG_MTK_MMSYS) += mtk-mutex.o
> > +obj-$(CONFIG_MTK_SVS) += mtk-svs.o
> > diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
> > new file mode 100644
> > index 000000000000..013667752ec2
> > --- /dev/null
> > +++ b/drivers/soc/mediatek/mtk-svs.c
> > @@ -0,0 +1,1720 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (C) 2020 MediaTek Inc.
> > + */
> > +
> > +#include <linux/bits.h>
> > +#include <linux/clk.h>
> > +#include <linux/completion.h>
> > +#include <linux/device.h>
> > +#include <linux/init.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/kernel.h>
> > +#include <linux/kthread.h>
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/nvmem-consumer.h>
> > +#include <linux/of_address.h>
> > +#include <linux/of_irq.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/pm_domain.h>
> > +#include <linux/pm_opp.h>
> > +#include <linux/pm_qos.h>
> > +#include <linux/pm_runtime.h>
> > +#include <linux/regulator/consumer.h>
> > +#include <linux/reset.h>
> > +#include <linux/slab.h>
> > +#include <linux/spinlock.h>
> > +#include <linux/thermal.h>
> > +
> > +/* svs bank 1-line sw id */
> > +#define SVSB_CPU_LITTLE			BIT(0)
> > +#define SVSB_CPU_BIG			BIT(1)
> > +#define SVSB_CCI			BIT(2)
> > +#define SVSB_GPU			BIT(3)
> > +
> > +/* svs bank mode support */
> > +#define SVSB_MODE_ALL_DISABLE		0
> > +#define SVSB_MODE_INIT01		BIT(1)
> > +#define SVSB_MODE_INIT02		BIT(2)
> > +#define SVSB_MODE_MON			BIT(3)
> > +
> > +/* svs bank volt flags */
> > +#define SVSB_INIT01_VOLT_IGNORE		BIT(1)
> > +#define SVSB_INIT01_VOLT_INC_ONLY	BIT(2)
> > +#define SVSB_INIT02_RM_DVTFIXED		BIT(8)
> > +#define SVSB_MON_VOLT_IGNORE		BIT(16)
> 
> Some flags get never set so they are not used. Please clean up the driver.

Okay. I'll remove the unused flags from mt8183 patch. Thanks.

> 
> > +
> > +/* svs bank common setting */
> > +#define SVSB_DET_CLK_EN			BIT(31)
> > +#define SVSB_TZONE_HIGH_TEMP_MAX	U32_MAX
> > +#define SVSB_RUNCONFIG_DEFAULT		0x80000000
> > +#define SVSB_DC_SIGNED_BIT		0x8000
> > +#define SVSB_INTEN_INIT0x		0x00005f01
> > +#define SVSB_INTEN_MONVOPEN		0x00ff0000
> > +#define SVSB_EN_OFF			0x0
> > +#define SVSB_EN_MASK			0x7
> > +#define SVSB_EN_INIT01			0x1
> > +#define SVSB_EN_INIT02			0x5
> > +#define SVSB_EN_MON			0x2
> > +#define SVSB_INTSTS_MONVOP		0x00ff0000
> 
> Same value used for register INTEN and INTSTS.
> I suppose INTEN enables the interrupt. Is there any HW functionality to write
> to
> INTSTS though? It seems it is just used to flag an interrupt as handeled.

Yes, INTSTS has HW functionality. SVS HW uses it to reflect SVS bank interrupt
status.
> 
> > +#define SVSB_INTSTS_COMPLETE		0x1
> > +#define SVSB_INTSTS_CLEAN		0x00ffffff
> > +
> > 

[snip]

> > +/*
> > + * struct thermal_parameter - This is for storing thermal efuse data.
> > + * We calculate thermal efuse data to produce "mts" and "bts" for
> > + * svs bank mon mode.
> > + */
> > +struct thermal_parameter {
> > +	int adc_ge_t;
> > +	int adc_oe_t;
> > +	int ge;
> > +	int oe;
> > +	int gain;
> > +	int o_vtsabb;
> > +	int o_vtsmcu1;
> > +	int o_vtsmcu2;
> > +	int o_vtsmcu3;
> > +	int o_vtsmcu4;
> > +	int o_vtsmcu5;
> > +	int degc_cali;
> > +	int adc_cali_en_t;
> > +	int o_slope;
> > +	int o_slope_sign;
> > +	int ts_id;
> > +};
> > +
> > +/*
> > + * struct svs_platform - svs platform data
> > + * @dev: svs platform device
> > + * @base: svs platform register address base
> > + * @main_clk: main clock for svs bank
> > + * @pbank: phandle of svs bank and needs to be protected by spin_lock
> > + * @banks: phandle of the banks that support
> > + * @efuse_parsing: phandle of efuse parsing function
> > + * @irqflags: irq settings flags
> > + * @rst: svs reset control
> > + * @regs: phandle to the registers map
> 
> Please review the comments here. Most of the so called phandle aren't phandle
> at
> all. E.g. efuse_parsing is a function pointer.

Okay. I'll revise the comments in the next patchset. Thanks.

> 
> > + * @efuse_num: the total number of svs platform efuse
> > + * @tefuse_num: the total number of thermal efuse
> > + * @bank_num: the total number of banks
> > + * @efuse_check: the svs efuse check index
> > + * @efuse: svs platform efuse data received from NVMEM framework
> > + * @tefuse: thermal efuse data received from NVMEM framework
> > + * @name: svs platform name
> 
> Please make sure comments and struct members are aligned. E.g. 'name' is not
> the
> last member of the struct.

Okay, I'll revise the order in the next patchset. Thanks.

> 
> > + */
> > +struct svs_platform {
> > +	struct device *dev;
> > +	void __iomem *base;
> > +	struct clk *main_clk;
> > +	struct svs_bank *pbank;
> > +	struct svs_bank *banks;
> > +	bool (*efuse_parsing)(struct svs_platform *svsp);
> > +	unsigned long irqflags;
> > +	struct reset_control *rst;
> > +	const u32 *regs;
> > +	char *name;
> > +	size_t efuse_num;
> > +	size_t tefuse_num;
> > +	u32 bank_num;
> > +	u32 efuse_check;
> > +	u32 *efuse;
> > +	u32 *tefuse;
> > +};
> > +
> > +/*
> > + * struct svs_bank - svs bank representation
> > + * @dev: svs bank device
> > + * @opp_dev: device for opp table/buck control
> > + * @pd_dev: power domain device for SoC mtcmos control
> > + * @init_completion: the timeout completion for bank init
> > + * @buck: phandle of the regulator
> > + * @lock: mutex lock to protect voltage update process
> > + * @phase: bank current phase
> > + * @name: bank name
> > + * @tzone_name: thermal zone name
> > + * @buck_name: regulator name
> > + * @suspended: suspend flag of this bank
> > + * @pd_req: bank's power-domain on request
> > + * @enable_pm_runtime_ever: bank enables pm-runtime flag
> > + * @set_freqs_pct: phandle of set frequencies percent function
> > + * @get_vops: phandle of get bank voltages function
> > + * @volt_offset: bank voltage offset controlled by svs software
> > + * @mode_support: bank mode support.
> > + * @opp_freqs: signed-off frequencies from default opp table
> > + * @opp_volts: signed-off voltages from default opp table
> > + * @freqs_pct: percent of "opp_freqs / freq_base" for bank init
> > + * @volts: bank voltages
> > + * @freq_base: reference frequency for bank init
> > + * @vboot: voltage request for bank init01 stage only
> > + * @volt_step: bank voltage step
> > + * @volt_base: bank voltage base
> > + * @volt_flags: bank voltage flags
> > + * @vmax: bank voltage maximum
> > + * @vmin: bank voltage minimum
> > + * @temp: bank temperature
> > + * @temp_upper_bound: bank temperature upper bound
> > + * @temp_lower_bound: bank temperature lower bound
> > + * @tzone_high_temp: thermal zone high temperature threshold
> > + * @tzone_high_temp_offset: thermal zone high temperature offset
> > + * @tzone_low_temp: thermal zone low temperature threshold
> > + * @tzone_low_temp_offset: thermal zone low temperature offset
> > + * @core_sel: bank selection
> > + * @opp_count: bank opp count
> > + * @int_st: bank interrupt identification
> > + * @sw_id: bank software identification
> > + * @ctl0: bank thermal sensor selection
> > + * @cpu_id: cpu core id for SVS CPU only
> > + *
> > + * Other structure members which are not listed above are svs platform
> > + * efuse data for bank init
> > + */
> > +struct svs_bank {
> > +	struct device *dev;
> > +	struct device *opp_dev;
> > +	struct device *pd_dev;
> > +	struct completion init_completion;
> > +	struct regulator *buck;
> > +	struct mutex lock;	/* lock to protect voltage update process */
> > +	enum svsb_phase phase;
> > +	char *name;
> > +	char *tzone_name;
> > +	char *buck_name;
> > +	bool suspended;
> > +	bool pd_req;
> > +	bool enable_pm_runtime_ever;
> > +	void (*set_freqs_pct)(struct svs_platform *svsp);
> > +	void (*get_vops)(struct svs_platform *svsp);
> > +	s32 volt_offset;
> > +	u32 mode_support;
> 
> In which concrete case do we need this? When we suspend before probe
> (svs_start)
> has finished?
> Please explain why we need that at all. I think a one-bit flag that shows us
> if
> a bank supports monitor mode should be enough.

Generally, not all SVS banks support monitor mode (based on Post-Silicon
designer decision). So, SW needs this variable "mode_support" to understand
which bank supports which mode. Thanks.

> 
> > +	u32 opp_freqs[16];
> > +	u32 opp_volts[16];
> > +	u32 freqs_pct[16];
> > +	u32 volts[16];
> > +	u32 freq_base;
> > +	u32 vboot;
> > +	u32 volt_step;
> > +	u32 volt_base;
> > +	u32 volt_flags;
> > +	u32 vmax;
> > +	u32 vmin;
> > +	u32 bts;
> > +	u32 mts;
> > +	u32 bdes;
> > +	u32 mdes;
> > +	u32 mtdes;
> > +	u32 dcbdet;
> > +	u32 dcmdet;
> > +	u32 dthi;
> > +	u32 dtlo;
> > +	u32 det_window;
> > +	u32 det_max;
> > +	u32 age_config;
> > +	u32 age_voffset_in;
> > +	u32 agem;
> > +	u32 dc_config;
> > +	u32 dc_voffset_in;
> > +	u32 dvt_fixed;
> > +	u32 vco;
> > +	u32 chk_shift;
> > +	u32 temp;
> > +	u32 temp_upper_bound;
> > +	u32 temp_lower_bound;
> > +	u32 tzone_high_temp;
> > +	u32 tzone_high_temp_offset;
> > +	u32 tzone_low_temp;
> > +	u32 tzone_low_temp_offset;
> > +	u32 core_sel;
> > +	u32 opp_count;
> > +	u32 int_st;
> > +	u32 sw_id;
> > +	u32 ctl0;
> > +	u32 cpu_id;
> > +};
> > +
> > +static u32 percent(u32 numerator, u32 denominator)
> > +{
> > +	/* If not divide 1000, "numerator * 100" will have data overflow. */
> > +	numerator /= 1000;
> > +	denominator /= 1000;
> > +
> > +	return DIV_ROUND_UP(numerator * 100, denominator);
> > +}
> > +
> > +static u32 svs_readl(struct svs_platform *svsp, enum svs_reg_index rg_i)
> > +{
> > +	return readl(svsp->base + svsp->regs[rg_i]);
> > +}
> > +
> > +static void svs_writel(struct svs_platform *svsp, u32 val,
> > +		       enum svs_reg_index rg_i)
> > +{
> > +	writel(val, svsp->base + svsp->regs[rg_i]);
> > +}
> 
> Read write functions don't add a great deal, why did you decide to ecapsualte
> them?

Encapsulation is for considering as better readability here. Please let us know
if we need to change it. Thanks a lot. 
- Encapsulation: int_sts = svs_readl(svsp, INTSTS)
- No encapsulation: int_sts = readl(svsp->base + svsp->regs[INTSTS]);

> Why not use [writel,readl]_relaxed?

I think it is ok to use [writel,readl]_relaxed as well and will use it in the
next patchset. If it can't, we'll let you know. Thanks for the advice.

> 
> > +
> > +static void svs_switch_bank(struct svs_platform *svsp)
> 
> 
> 
> > +{
> > +	struct svs_bank *svsb = svsp->pbank;
> 
> Reading the comment, pbank needs to be protected by spin_lock but isn't here.
> What's wrong, the comment or the function?

The spin_lock that protects this pbank is at the outside of function because it 
needs to protect multiple registers control after SVS hardware (HW) switches to
the target SVS bank.

Please let me explain more. SVS HW uses bank concept to support different SVS
(CPU/CCI/GPU) bank and it means all different SVS banks have its own register
(INTSTS/SVSEN/..) data independently. For example, If we want to read register
(INTSTS) from SVS GPU bank, we need to switch SVS HW to SVS GPU bank by
svs_switch_bank() first and read register (INTSTS) afterward. Then, this
register (INTSTS) data comes from SVS GPU bank. So does the other SVS banks
(CPU/CCI) register read.
  
#svs_switch_bank() example in the code
static irqreturn_t svs_isr(int irq, void *data)
{
...
        for (idx = 0; idx < svsp->bank_num; idx++) {
                svsb = &svsp->banks[idx];
                WARN_ON(!svsb);

                spin_lock_irqsave(&mtk_svs_lock, flags);
                svsp->pbank = svsb;
...
                if (!svsb->suspended) {
                        svs_switch_bank(svsp);
                        int_sts = svs_readl(svsp, INTSTS);
                        svs_en = svs_readl(svsp, SVSEN) & SVSB_EN_MASK;
...

[snip]

> > +
> > +static u32 svs_bank_volt_to_opp_volt(u32 svsb_volt, u32 svsb_volt_step,
> > +				     u32 svsb_volt_base)
> > +{
> > +	return (svsb_volt * svsb_volt_step) + svsb_volt_base;
> > +}
> > +
> > +static void svs_set_bank_phase(struct svs_platform *svsp,
> > +			       enum svsb_phase target_phase)
> > +{
> > +	struct svs_bank *svsb = svsp->pbank;
> > +	u32 des_char, temp_char, det_char, limit_vals;
> > +	u32 init2vals, ts_calcs, val, filter, i;
> > +
> > +	svs_switch_bank(svsp);
> > +
> > +	des_char = (svsb->bdes << 8) | svsb->mdes;
> > +	svs_writel(svsp, des_char, DESCHAR);
> > +
> > +	temp_char = (svsb->vco << 16) | (svsb->mtdes << 8) | svsb->dvt_fixed;
> > +	svs_writel(svsp, temp_char, TEMPCHAR);
> > +
> > +	det_char = (svsb->dcbdet << 8) | svsb->dcmdet;
> > +	svs_writel(svsp, det_char, DETCHAR);
> > +
> > +	svs_writel(svsp, svsb->dc_config, DCCONFIG);
> > +	svs_writel(svsp, svsb->age_config, AGECONFIG);
> > +
> > +	if (!svsb->agem) {
> > +		svs_writel(svsp, SVSB_RUNCONFIG_DEFAULT, RUNCONFIG);
> 
> All banks have agem (whatever it means) set to zero, so else branch does only
> bloat the code here. Please review the whole driver for this kind of cases to
> trim the code size down. Once the driver got accepted, adding 'agem' support
> will be an easy reviewable patch.

Thanks for the advice. I'll revise them in the whole driver to trim the code
size down.

...

[snip]

> > +
> > +static irqreturn_t svs_isr(int irq, void *data)
> > +{
> > +	struct svs_platform *svsp = data;
> > +	struct svs_bank *svsb = NULL;
> > +	unsigned long flags;
> > +	u32 idx, int_sts, svs_en;
> > +
> > +	for (idx = 0; idx < svsp->bank_num; idx++) {
> > +		svsb = &svsp->banks[idx];
> > +		WARN_ON(!svsb);
> > +
> > +		spin_lock_irqsave(&mtk_svs_lock, flags);
> > +		svsp->pbank = svsb;
> > +
> > +		/* Find out which svs bank fires interrupt */
> > +		if (svsb->int_st & svs_readl(svsp, INTST)) {
> 
> Why are you looping over all banks to find out which bank got a pending
> interrupt? Couldn't we just read INTST and handle pending interrupts shown in
> that register?

Because we cannot know which bank fires interrupt until comparing
INTST with bank info. If reading INTST first, we still need to figure out this
INTST is triggered by which bank (maybe figured out by if-statement or current
way).

> > +			spin_unlock_irqrestore(&mtk_svs_lock, flags);
> > +			continue;
> > +		}
> > +
> > +		if (!svsb->suspended) {
> 
> An interrupt can fire for a suspended bank? Is that an HW limitation?

After SVS bank is suspended, it cannot fire interrupt. For example, if SVS GPU
bank is suspended, it cannot fire interrupt anymore. However, SVS CCI bank can
still fire interrupt because it is not suspended.

> Further
> more, do we need that at all? Can't we just disable interrupts globally in
> suspend and enable them in resume. It seems you are trying to work around some
> race condition between suspend/resume in an interrupt occuring.

I got it. Currently, all SVS banks will be disabled in svs_suspend() and I think
it matches your point about "disable interrupts globally in suspend". Therefore,
I will try to remove it and check if it is ok without any side effects. If no
side effects, I'll remove it in the next patchset. Thanks for the advice.

> > +			svs_switch_bank(svsp);
> > +			int_sts = svs_readl(svsp, INTSTS);
> > +			svs_en = svs_readl(svsp, SVSEN) & SVSB_EN_MASK;
> > +
> > +			if (int_sts == SVSB_INTSTS_COMPLETE &&
> 
> SVSB_INTSTS_COMPLETE get's written to int_sts in the different state ISR
> handlers. So it seems as if this is used for a race condition betweeen having
> finished svs_init_0[1-2]_isr_handler. Can't we just mask the interrupt until
> the
> handler is done?

1. The SVSB_INTSTS_COMPLETE in svs_isr() is to help check the svs bank interrupt
condition.
2. The SVSB_INTSTS_COMPLETE in svs_init0[1-2]_isr_handler is for clearing INTSTS
as HW request.

> 
> > +			    svs_en == SVSB_EN_INIT01)
> > +				svs_init01_isr_handler(svsp);
> > +			else if (int_sts == SVSB_INTSTS_COMPLETE &&
> > +				 svs_en == SVSB_EN_INIT02)
> > +				svs_init02_isr_handler(svsp);
> > +			else if (int_sts & SVSB_INTSTS_MONVOP)
> > +				svs_mon_mode_isr_handler(svsp);
> > +			else
> > +				svs_error_isr_handler(svsp);
> > +		}
> > +
> > +		spin_unlock_irqrestore(&mtk_svs_lock, flags);
> > +		break;
> > +	}
> > +
> > +	if (svsb->phase != SVSB_PHASE_INIT01)
> > +		svs_adjust_pm_opp_volts(svsb, false);
> > +
> > +	if (svsb->phase == SVSB_PHASE_INIT01 ||
> > +	    svsb->phase == SVSB_PHASE_INIT02)
> > +		complete(&svsb->init_completion);
> > +
> > +	return IRQ_HANDLED;
> > +}

[snip]

> > +static int svs_resource_setup(struct svs_platform *svsp)
> > +{
> > +	struct svs_bank *svsb;
> > +	struct dev_pm_opp *opp;
> > +	unsigned long freq;
> > +	int count, ret;
> > +	u32 idx, i;
> > +
> > +	dev_set_drvdata(svsp->dev, svsp);
> > +
> > +	for (idx = 0; idx < svsp->bank_num; idx++) {
> > +		svsb = &svsp->banks[idx];
> > +
> > +		switch (svsb->sw_id) {
> > +		case SVSB_CPU_LITTLE:
> > +			svsb->name = "SVSB_CPU_LITTLE";
> > +			break;
> > +		case SVSB_CPU_BIG:
> > +			svsb->name = "SVSB_CPU_BIG";
> > +			break;
> > +		case SVSB_CCI:
> > +			svsb->name = "SVSB_CCI";
> > +			break;
> > +		case SVSB_GPU:
> > +			svsb->name = "SVSB_GPU";
> > +			break;
> 
> Why not set the name dircetly in svs_mt8183_banks?

Oh, I think they belongs to common setting.

> > +		default:
> > +			WARN_ON(1);
> > +			return -EINVAL;
> > +		}
> > +
> > +		svsb->dev = devm_kzalloc(svsp->dev, sizeof(*svsb->dev),
> > +					 GFP_KERNEL);
> > +		if (!svsb->dev)
> > +			return -ENOMEM;
> > +
> > +		ret = dev_set_name(svsb->dev, "%s", svsb->name);
> > +		if (ret)
> > +			return ret;
> > +
> > +		dev_set_drvdata(svsb->dev, svsp);
> > +
> > +		ret = dev_pm_opp_of_add_table(svsb->opp_dev);
> > +		if (ret) {
> > +			dev_err(svsb->dev, "add opp table fail: %d\n", ret);
> > +			return ret;
> > +		}
> > +
> > +		mutex_init(&svsb->lock);
> > +		init_completion(&svsb->init_completion);
> > +
> > +		svsb->buck = devm_regulator_get_optional(svsb->opp_dev,
> > +							 svsb->buck_name);
> > +		if (IS_ERR(svsb->buck)) {
> > +			dev_err(svsb->dev, "cannot get \"%s-supply\"\n",
> > +				svsb->buck_name);
> > +			return PTR_ERR(svsb->buck);
> > +		}
> > +
> > +		count = dev_pm_opp_get_opp_count(svsb->opp_dev);
> > +		if (svsb->opp_count != count) {
> > +			dev_err(svsb->dev,
> > +				"opp_count not \"%u\" but get \"%d\"?\n",
> > +				svsb->opp_count, count);
> > +			return count;
> > +		}
> > +
> > +		for (i = 0, freq = U32_MAX; i < svsb->opp_count; i++, freq--) {
> > +			opp = dev_pm_opp_find_freq_floor(svsb->opp_dev, &freq);
> > +			if (IS_ERR(opp)) {
> > +				dev_err(svsb->dev, "cannot find freq = %ld\n",
> > +					PTR_ERR(opp));
> > +				return PTR_ERR(opp);
> > +			}
> > +
> > +			svsb->opp_freqs[i] = freq;
> > +			svsb->opp_volts[i] = dev_pm_opp_get_voltage(opp);
> > +			svsb->freqs_pct[i] = percent(svsb->opp_freqs[i],
> > +						     svsb->freq_base);
> > +			dev_pm_opp_put(opp);
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static bool svs_mt8183_efuse_parsing(struct svs_platform *svsp)
> 
> Is it me or do we always return true? Please make sure that the code is clean
> and return types make sense.

Oh, my bad. I should move efuse check in ->efuse_parsing() so this function will
return false when efuse data isn't correct.

> 
> > +{
> > +	struct thermal_parameter tp;
> > +	struct svs_bank *svsb;
> > +	bool mon_mode_support = true;
> > +	int format[6], x_roomt[6], tb_roomt = 0;
> > +	struct nvmem_cell *cell;
> > +	u32 idx, i, ft_pgm, mts, temp0, temp1, temp2;
> > +
> > +	for (i = 0; i < svsp->efuse_num; i++)
> > +		if (svsp->efuse[i])
> > +			dev_info(svsp->dev, "M_HW_RES%d: 0x%08x\n",
> > +				 i, svsp->efuse[i]);
> > +
> > +	/* Svs efuse parsing */
> > +	ft_pgm = (svsp->efuse[0] >> 4) & GENMASK(3, 0);
> > +
> > +	for (idx = 0; idx < svsp->bank_num; idx++) {
> > +		svsb = &svsp->banks[idx];
> > +
> > +		if (ft_pgm <= 1)
> > +			svsb->volt_flags |= SVSB_INIT01_VOLT_IGNORE;
> > +
> > +		switch (svsb->sw_id) {
> > +		case SVSB_CPU_LITTLE:
> > +			svsb->bdes = svsp->efuse[16] & GENMASK(7, 0);
> > +			svsb->mdes = (svsp->efuse[16] >> 8) & GENMASK(7, 0);
> > +			svsb->dcbdet = (svsp->efuse[16] >> 16) & GENMASK(7, 0);
> > +			svsb->dcmdet = (svsp->efuse[16] >> 24) & GENMASK(7, 0);
> > +			svsb->mtdes  = (svsp->efuse[17] >> 16) & GENMASK(7, 0);
> > +
> > +			if (ft_pgm <= 3)
> > +				svsb->volt_offset += 10;
> > +			else
> > +				svsb->volt_offset += 2;
> > +			break;
> > +		case SVSB_CPU_BIG:
> > +			svsb->bdes = svsp->efuse[18] & GENMASK(7, 0);
> > +			svsb->mdes = (svsp->efuse[18] >> 8) & GENMASK(7, 0);
> > +			svsb->dcbdet = (svsp->efuse[18] >> 16) & GENMASK(7, 0);
> > +			svsb->dcmdet = (svsp->efuse[18] >> 24) & GENMASK(7, 0);
> > +			svsb->mtdes  = svsp->efuse[17] & GENMASK(7, 0);
> > +
> > +			if (ft_pgm <= 3)
> > +				svsb->volt_offset += 15;
> > +			else
> > +				svsb->volt_offset += 12;
> > +			break;
> > +		case SVSB_CCI:
> > +			svsb->bdes = svsp->efuse[4] & GENMASK(7, 0);
> > +			svsb->mdes = (svsp->efuse[4] >> 8) & GENMASK(7, 0);
> > +			svsb->dcbdet = (svsp->efuse[4] >> 16) & GENMASK(7, 0);
> > +			svsb->dcmdet = (svsp->efuse[4] >> 24) & GENMASK(7, 0);
> > +			svsb->mtdes  = (svsp->efuse[5] >> 16) & GENMASK(7, 0);
> > +
> > +			if (ft_pgm <= 3)
> > +				svsb->volt_offset += 10;
> > +			else
> > +				svsb->volt_offset += 2;
> > +			break;
> > +		case SVSB_GPU:
> > +			svsb->bdes = svsp->efuse[6] & GENMASK(7, 0);
> > +			svsb->mdes = (svsp->efuse[6] >> 8) & GENMASK(7, 0);
> > +			svsb->dcbdet = (svsp->efuse[6] >> 16) & GENMASK(7, 0);
> > +			svsb->dcmdet = (svsp->efuse[6] >> 24) & GENMASK(7, 0);
> > +			svsb->mtdes  = svsp->efuse[5] & GENMASK(7, 0);
> > +
> > +			if (ft_pgm >= 2) {
> > +				svsb->freq_base = 800000000; /* 800MHz */
> > +				svsb->dvt_fixed = 2;
> > +			}
> > +			break;
> > +		default:
> > +			break;
> > +		}
> > +	}
> > +
> > +	/* Get thermal efuse by nvmem */
> > +	cell = nvmem_cell_get(svsp->dev, "t-calibration-data");
> > +	if (IS_ERR_OR_NULL(cell)) {
> > +		dev_err(svsp->dev, "no thermal cell, no mon mode\n");
> > +		for (idx = 0; idx < svsp->bank_num; idx++) {
> > +			svsb = &svsp->banks[idx];
> > +			svsb->mode_support &= ~SVSB_MODE_MON;
> > +		}
> > +
> > +		return true;
> > +	}
> > +
> > +	svsp->tefuse = nvmem_cell_read(cell, &svsp->tefuse_num);
> > +	svsp->tefuse_num /= sizeof(u32);
> > +	nvmem_cell_put(cell);
> > +
> > +	/* Thermal efuse parsing */
> > +	tp.adc_ge_t = (svsp->tefuse[1] >> 22) & GENMASK(9, 0);
> > +	tp.adc_oe_t = (svsp->tefuse[1] >> 12) & GENMASK(9, 0);
> > +
> > +	tp.o_vtsmcu1 = (svsp->tefuse[0] >> 17) & GENMASK(8, 0);
> > +	tp.o_vtsmcu2 = (svsp->tefuse[0] >> 8) & GENMASK(8, 0);
> > +	tp.o_vtsmcu3 = svsp->tefuse[1] & GENMASK(8, 0);
> > +	tp.o_vtsmcu4 = (svsp->tefuse[2] >> 23) & GENMASK(8, 0);
> > +	tp.o_vtsmcu5 = (svsp->tefuse[2] >> 5) & GENMASK(8, 0);
> > +	tp.o_vtsabb = (svsp->tefuse[2] >> 14) & GENMASK(8, 0);
> > +
> > +	tp.degc_cali = (svsp->tefuse[0] >> 1) & GENMASK(5, 0);
> > +	tp.adc_cali_en_t = svsp->tefuse[0] & BIT(0);
> > +	tp.o_slope_sign = (svsp->tefuse[0] >> 7) & BIT(0);
> > +
> > +	tp.ts_id = (svsp->tefuse[1] >> 9) & BIT(0);
> > +	tp.o_slope = (svsp->tefuse[0] >> 26) & GENMASK(5, 0);
> > +
> > +	if (tp.adc_cali_en_t == 1) {
> > +		if (!tp.ts_id)
> > +			tp.o_slope = 0;
> > +
> > +		if (tp.adc_ge_t < 265 || tp.adc_ge_t > 758 ||
> > +		    tp.adc_oe_t < 265 || tp.adc_oe_t > 758 ||
> > +		    tp.o_vtsmcu1 < -8 || tp.o_vtsmcu1 > 484 ||
> > +		    tp.o_vtsmcu2 < -8 || tp.o_vtsmcu2 > 484 ||
> > +		    tp.o_vtsmcu3 < -8 || tp.o_vtsmcu3 > 484 ||
> > +		    tp.o_vtsmcu4 < -8 || tp.o_vtsmcu4 > 484 ||
> > +		    tp.o_vtsmcu5 < -8 || tp.o_vtsmcu5 > 484 ||
> > +		    tp.o_vtsabb < -8 || tp.o_vtsabb > 484 ||
> > +		    tp.degc_cali < 1 || tp.degc_cali > 63) {
> > +			dev_err(svsp->dev, "bad thermal efuse, no mon mode\n");
> > +			mon_mode_support = false;
> > +		}
> > +	} else {
> > +		dev_err(svsp->dev, "no thermal efuse, no mon mode\n");
> > +		mon_mode_support = false;
> > +	}
> > +
> > +	if (!mon_mode_support) {
> > +		for (idx = 0; idx < svsp->bank_num; idx++) {
> > +			svsb = &svsp->banks[idx];
> > +			svsb->mode_support &= ~SVSB_MODE_MON;
> > +		}
> > +
> > +		return true;
> > +	}
> > +
> > +	tp.ge = ((tp.adc_ge_t - 512) * 10000) / 4096;
> > +	tp.oe = (tp.adc_oe_t - 512);
> > +	tp.gain = (10000 + tp.ge);
> > +
> > +	format[0] = (tp.o_vtsmcu1 + 3350 - tp.oe);
> > +	format[1] = (tp.o_vtsmcu2 + 3350 - tp.oe);
> > +	format[2] = (tp.o_vtsmcu3 + 3350 - tp.oe);
> > +	format[3] = (tp.o_vtsmcu4 + 3350 - tp.oe);
> > +	format[4] = (tp.o_vtsmcu5 + 3350 - tp.oe);
> > +	format[5] = (tp.o_vtsabb + 3350 - tp.oe);
> > +
> > +	for (i = 0; i < 6; i++)
> > +		x_roomt[i] = (((format[i] * 10000) / 4096) * 10000) / tp.gain;
> > +
> > +	temp0 = (10000 * 100000 / tp.gain) * 15 / 18;
> > +
> > +	if (!tp.o_slope_sign)
> > +		mts = (temp0 * 10) / (1534 + tp.o_slope * 10);
> > +	else
> > +		mts = (temp0 * 10) / (1534 - tp.o_slope * 10);
> > +
> > +	for (idx = 0; idx < svsp->bank_num; idx++) {
> > +		svsb = &svsp->banks[idx];
> > +		svsb->mts = mts;
> > +
> > +		switch (svsb->sw_id) {
> > +		case SVSB_CPU_LITTLE:
> > +			tb_roomt = x_roomt[3];
> > +			break;
> > +		case SVSB_CPU_BIG:
> > +			tb_roomt = x_roomt[4];
> > +			break;
> > +		case SVSB_CCI:
> > +			tb_roomt = x_roomt[3];
> > +			break;
> > +		case SVSB_GPU:
> > +			tb_roomt = x_roomt[1];
> > +			break;
> > +		default:
> > +			break;
> > +		}
> > +
> > +		temp0 = (tp.degc_cali * 10 / 2);
> > +		temp1 = ((10000 * 100000 / 4096 / tp.gain) *
> > +			 tp.oe + tb_roomt * 10) * 15 / 18;
> > +
> > +		if (!tp.o_slope_sign)
> > +			temp2 = temp1 * 100 / (1534 + tp.o_slope * 10);
> > +		else
> > +			temp2 = temp1 * 100 / (1534 - tp.o_slope * 10);
> > +
> > +		svsb->bts = (temp0 + temp2 - 250) * 4 / 10;
> > +	}
> > +
> > +	return true;
> > +}

[snip]

> > +static struct svs_bank svs_mt8183_banks[] = {
> > +	{
> > +		.sw_id			= SVSB_CPU_LITTLE,
> > +		.set_freqs_pct		= svs_set_freqs_pct_v2,
> > +		.get_vops		= svs_get_vops_v2,
> > +		.cpu_id			= 0,
> > +		.tzone_name		= "tzts4",
> > +		.buck_name		= "proc",
> > +		.pd_req			= false,
> > +		.volt_flags		= SVSB_INIT01_VOLT_INC_ONLY,
> > +		.mode_support		= SVSB_MODE_INIT01 |
> > SVSB_MODE_INIT02,
> > +		.opp_count		= 16,
> > +		.freq_base		= 1989000000,
> > +		.vboot			= 0x30,
> > +		.volt_step		= 6250,
> > +		.volt_base		= 500000,
> > +		.volt_offset		= 0,
> > +		.vmax			= 0x64,
> > +		.vmin			= 0x18,
> > +		.dthi			= 0x1,
> > +		.dtlo			= 0xfe,
> > +		.det_window		= 0xa28,
> > +		.det_max		= 0xffff,
> > +		.age_config		= 0x555555,
> > +		.agem			= 0,
> > +		.dc_config		= 0x555555,
> > +		.dvt_fixed		= 0x7,
> > +		.vco			= 0x10,
> > +		.chk_shift		= 0x77,
> > +		.temp_upper_bound	= 0x64,
> > +		.temp_lower_bound	= 0xb2,
> > +		.tzone_high_temp	= SVSB_TZONE_HIGH_TEMP_MAX,
> > +		.tzone_low_temp		= 25000,
> > +		.tzone_low_temp_offset	= 0,
> > +		.core_sel		= 0x8fff0000,
> > +		.int_st			= BIT(0),
> > +		.ctl0			= 0x00010001,
> 
> Can we try to make that data structure smaller. I'm struggeling to understand
> how this all works together.
> Apart from that I think it would make sense to describe the banks in DT. Maybe
> we can find a way then to create the device links using phandles instead of
> hard-code that.
> Please try to find a balanca between information in DTS and information
> hardcoded in the driver. As for example done for mkt-pm-domains driver.

Okay, I'll try to shrink the data structure first. Thanks for the advice.

> 
> > +	},
> > +	{
> > +		.sw_id			= SVSB_CPU_BIG,
> > +		.set_freqs_pct		= svs_set_freqs_pct_v2,
> > +		.get_vops		= svs_get_vops_v2,
> > +		.cpu_id			= 4,
> > +		.tzone_name		= "tzts5",
> > +		.buck_name		= "proc",
> > +		.pd_req			= false,
> > +		.volt_flags		= SVSB_INIT01_VOLT_INC_ONLY,
> > +		.mode_support		= SVSB_MODE_INIT01 |
> > SVSB_MODE_INIT02,
> > +		.opp_count		= 16,
> > +		.freq_base		= 1989000000,
> > +		.vboot			= 0x30,
> > +		.volt_step		= 6250,
> > +		.volt_base		= 500000,
> > +		.volt_offset		= 0,
> > +		.vmax			= 0x58,
> > +		.vmin			= 0x10,
> > +		.dthi			= 0x1,
> > +		.dtlo			= 0xfe,
> > +		.det_window		= 0xa28,
> > +		.det_max		= 0xffff,
> > +		.age_config		= 0x555555,
> > +		.agem			= 0,
> > +		.dc_config		= 0x555555,
> > +		.dvt_fixed		= 0x7,
> > +		.vco			= 0x10,
> > +		.chk_shift		= 0x77,
> > +		.temp_upper_bound	= 0x64,
> > +		.temp_lower_bound	= 0xb2,
> > +		.tzone_high_temp	= SVSB_TZONE_HIGH_TEMP_MAX,
> > +		.tzone_low_temp		= 25000,
> > +		.tzone_low_temp_offset	= 0,
> > +		.core_sel		= 0x8fff0001,
> > +		.int_st			= BIT(1),
> > +		.ctl0			= 0x00000001,
> > +	},
> > +	{
> > +		.sw_id			= SVSB_CCI,
> > +		.set_freqs_pct		= svs_set_freqs_pct_v2,
> > +		.get_vops		= svs_get_vops_v2,
> > +		.tzone_name		= "tzts4",
> > +		.buck_name		= "proc",
> > +		.pd_req			= false,
> > +		.volt_flags		= SVSB_INIT01_VOLT_INC_ONLY,
> > +		.mode_support		= SVSB_MODE_INIT01 |
> > SVSB_MODE_INIT02,
> > +		.opp_count		= 16,
> > +		.freq_base		= 1196000000,
> > +		.vboot			= 0x30,
> > +		.volt_step		= 6250,
> > +		.volt_base		= 500000,
> > +		.volt_offset		= 0,
> > +		.vmax			= 0x64,
> > +		.vmin			= 0x18,
> > +		.dthi			= 0x1,
> > +		.dtlo			= 0xfe,
> > +		.det_window		= 0xa28,
> > +		.det_max		= 0xffff,
> > +		.age_config		= 0x555555,
> > +		.agem			= 0,
> > +		.dc_config		= 0x555555,
> > +		.dvt_fixed		= 0x7,
> > +		.vco			= 0x10,
> > +		.chk_shift		= 0x77,
> > +		.temp_upper_bound	= 0x64,
> > +		.temp_lower_bound	= 0xb2,
> > +		.tzone_high_temp	= SVSB_TZONE_HIGH_TEMP_MAX,
> > +		.tzone_low_temp		= 25000,
> > +		.tzone_low_temp_offset	= 0,
> > +		.core_sel		= 0x8fff0002,
> > +		.int_st			= BIT(2),
> > +		.ctl0			= 0x00100003,
> > +	},
> > +	{
> > +		.sw_id			= SVSB_GPU,
> > +		.set_freqs_pct		= svs_set_freqs_pct_v2,
> > +		.get_vops		= svs_get_vops_v2,
> > +		.tzone_name		= "tzts2",
> > +		.buck_name		= "mali",
> > +		.pd_req			= true,
> > +		.volt_flags		= SVSB_INIT01_VOLT_INC_ONLY,
> > +		.mode_support		= SVSB_MODE_INIT01 |
> > SVSB_MODE_INIT02 |
> > +					  SVSB_MODE_MON,
> > +		.opp_count		= 16,
> > +		.freq_base		= 900000000,
> > +		.vboot			= 0x30,
> > +		.volt_step		= 6250,
> > +		.volt_base		= 500000,
> > +		.volt_offset		= 0,
> > +		.vmax			= 0x40,
> > +		.vmin			= 0x14,
> > +		.dthi			= 0x1,
> > +		.dtlo			= 0xfe,
> > +		.det_window		= 0xa28,
> > +		.det_max		= 0xffff,
> > +		.age_config		= 0x555555,
> > +		.agem			= 0,
> > +		.dc_config		= 0x555555,
> > +		.dvt_fixed		= 0x3,
> > +		.vco			= 0x10,
> > +		.chk_shift		= 0x77,
> > +		.temp_upper_bound	= 0x64,
> > +		.temp_lower_bound	= 0xb2,
> > +		.tzone_high_temp	= SVSB_TZONE_HIGH_TEMP_MAX,
> > +		.tzone_low_temp		= 25000,
> > +		.tzone_low_temp_offset	= 3,
> > +		.core_sel		= 0x8fff0003,
> > +		.int_st			= BIT(3),
> > +		.ctl0			= 0x00050001,
> > +	},
> > +};
> > +
> > +static int svs_get_svs_mt8183_platform_data(struct svs_platform *svsp)
> > +{
> > +	struct device *dev;
> > +	struct svs_bank *svsb;
> > +	u32 idx;
> > +
> > +	svsp->name = "mt8183-svs";
> > +	svsp->banks = svs_mt8183_banks;
> > +	svsp->efuse_parsing = svs_mt8183_efuse_parsing;
> > +	svsp->regs = svs_regs_v2;
> > +	svsp->irqflags = IRQF_TRIGGER_LOW;
> > +	svsp->rst = NULL;
> > +	svsp->bank_num = ARRAY_SIZE(svs_mt8183_banks);
> > +	svsp->efuse_check = 2;
> > +
> 
> We are mixing up platform data with a SoC specific probe function, please
> split
> that.

Okay, I'll split them up in the next patchset. Thanks.

> 
> > +	dev = svs_add_device_link(svsp, "thermal");
> > +	if (IS_ERR(dev))
> > +		return PTR_ERR(dev);
> > +
> > +	for (idx = 0; idx < svsp->bank_num; idx++) {
> > +		svsb = &svsp->banks[idx];
> > +
> > +		switch (svsb->sw_id) {
> > +		case SVSB_CPU_LITTLE:
> > +		case SVSB_CPU_BIG:
> > +			svsb->opp_dev = get_cpu_device(svsb->cpu_id);
> > +			break;
> > +		case SVSB_CCI:
> > +			svsb->opp_dev = svs_add_device_link(svsp, "cci");
> > +			break;
> > +		case SVSB_GPU:
> > +			svsb->opp_dev = svs_add_device_link(svsp, "mali");
> > +			svsb->pd_dev = svs_add_device_link(svsp,
> > +							   "mali_gpu_core2");
> > +			if (IS_ERR(svsb->pd_dev))
> > +				return PTR_ERR(svsb->pd_dev);
> > +			break;
> > +		default:
> > +			WARN_ON(1);
> > +			return -EINVAL;
> > +		}
> > +
> > +		if (IS_ERR(svsb->opp_dev))
> > +			return PTR_ERR(svsb->opp_dev);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct of_device_id mtk_svs_of_match[] = {
> > +	{
> > +		.compatible = "mediatek,mt8183-svs",
> > +		.data = &svs_get_svs_mt8183_platform_data,
> > +	}, {
> > +		/* Sentinel */
> > +	},
> > +};
> > +
> > +static int svs_probe(struct platform_device *pdev)
> > +{
> > +	int (*svs_get_svs_platform_data)(struct svs_platform *svsp);
> > +	struct svs_platform *svsp;
> > +	unsigned int svsp_irq;
> > +	int ret;
> > +
> > +	svsp = devm_kzalloc(&pdev->dev, sizeof(*svsp), GFP_KERNEL);
> > +	if (!svsp)
> > +		return -ENOMEM;
> > +
> > +	svs_get_svs_platform_data = of_device_get_match_data(&pdev->dev);
> > +	if (!svs_get_svs_platform_data) {
> > +		dev_err(svsp->dev, "no svs platform data? why?\n");
> > +		return -EPERM;
> > +	}
> > +
> > +	svsp->dev = &pdev->dev;
> > +	ret = svs_get_svs_platform_data(svsp);
> > +	if (ret) {
> > +		dev_err_probe(svsp->dev, ret, "fail to get svsp data\n");
> > +		return ret;
> > +	}
> > +
> > +	if (!svs_is_supported(svsp)) {
> 
> If svs is not supported, the device node shouldn't be enabled.

Oh, this function name makes people confuse and I'll change it to
svs_is_efuse_data_correct().

> 
> > +		dev_notice(svsp->dev, "svs is not supported\n");
> > +		return -EPERM;
> > +	}
> > +
> > +	ret = svs_resource_setup(svsp);
> > +	if (ret) {
> > +		dev_err(svsp->dev, "svs resource setup fail: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	svsp_irq = irq_of_parse_and_map(svsp->dev->of_node, 0);
> > +	ret = devm_request_threaded_irq(svsp->dev, svsp_irq, NULL, svs_isr,
> > +					svsp->irqflags | IRQF_ONESHOT,
> > +					svsp->name, svsp);
> > +	if (ret) {
> > +		dev_err(svsp->dev, "register irq(%d) failed: %d\n",
> > +			svsp_irq, ret);
> > +		return ret;
> > +	}
> > +
> > +	svsp->main_clk = devm_clk_get(svsp->dev, "main");
> > +	if (IS_ERR(svsp->main_clk)) {
> > +		dev_err(svsp->dev, "failed to get clock: %ld\n",
> > +			PTR_ERR(svsp->main_clk));
> > +		return PTR_ERR(svsp->main_clk);
> > +	}
> > +
> > +	ret = clk_prepare_enable(svsp->main_clk);
> > +	if (ret) {
> > +		dev_err(svsp->dev, "cannot enable main clk: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	svsp->base = of_iomap(svsp->dev->of_node, 0);
> > +	if (IS_ERR_OR_NULL(svsp->base)) {
> > +		dev_err(svsp->dev, "cannot find svs register base\n");
> > +		ret = -EINVAL;
> > +		goto svs_probe_clk_disable;
> > +	}
> > +
> > +	ret = svs_start(svsp);
> > +	if (ret) {
> > +		dev_err(svsp->dev, "svs start fail: %d\n", ret);
> > +		goto svs_probe_iounmap;
> > +	}
> > +
> > +	return 0;
> > +
> > +svs_probe_iounmap:
> > +	iounmap(svsp->base);
> > +
> > +svs_probe_clk_disable:
> > +	clk_disable_unprepare(svsp->main_clk);
> > +
> > +	return ret;
> > +}
> > +
> > +static SIMPLE_DEV_PM_OPS(svs_pm_ops, svs_suspend, svs_resume);
> > +
> > +static struct platform_driver svs_driver = {
> > +	.probe	= svs_probe,
> > +	.driver	= {
> > +		.name		= "mtk-svs",
> > +		.pm		= &svs_pm_ops,
> > +		.of_match_table	= of_match_ptr(mtk_svs_of_match),
> > +	},
> > +};
> > +
> > +module_platform_driver(svs_driver);
> > +
> > +MODULE_AUTHOR("Roger Lu <roger.lu@mediatek.com>");
> > +MODULE_DESCRIPTION("MediaTek SVS driver");
> > +MODULE_LICENSE("GPL v2");
> > 


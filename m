Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB6C2E7DA7
	for <lists+linux-pm@lfdr.de>; Thu, 31 Dec 2020 03:12:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgLaCL0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Dec 2020 21:11:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgLaCLZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Dec 2020 21:11:25 -0500
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ECEFC061575
        for <linux-pm@vger.kernel.org>; Wed, 30 Dec 2020 18:10:45 -0800 (PST)
Received: by mail-vs1-xe34.google.com with SMTP id p7so9436270vsf.8
        for <linux-pm@vger.kernel.org>; Wed, 30 Dec 2020 18:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jUVGJI1Fyytcjgy4YX3z5MnzbP77DLn/Bm4jNbs/3ZA=;
        b=fLh9Tyw/vz72tjMPGW/7YNNAHqPQDow2zwV2TtiNa3MeAliQ5YhMhmiwpKyfC1bpUj
         97uAiVRaF4276LQGH3JuecMKMoaZDtw7Qja4tpbrf3E3paY/JHxbpZ7YVjSotU11ybob
         M1BA/kdk8nd/zcEyV2k5w4CUbD5G27WUltla4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jUVGJI1Fyytcjgy4YX3z5MnzbP77DLn/Bm4jNbs/3ZA=;
        b=fGqya9IdknTH2eGHRJ9+RxpUev/Ph+RnlxIS0CaWYARoIDkUGAmEjdsTfsGIjg1iP5
         MsHGaUYGknAcu1lBu9mdMW++c4u6it43yW9xZMHTmG+MKtBgloxQ1QDbA/UU/IiWS+F5
         fnU0UPr//sb0M0XdpuxFyihk2CbzWmyvzL6r+WF3jVWzTiZf6npDC7wMLFq0TaLKBvzv
         HDxXl70bU8Ruqo/c7uUAhk3UWxUTN4gJsDJP1mxrDBNrXhhV6LHCqOwrq0teqtBZx6Cm
         T6EjTosGI9lVdRN/EVGMI2g2HzxUpbUTYhCWV0VNof4Dc8aKIo8eaWya7pqdLAjgClek
         aE6w==
X-Gm-Message-State: AOAM530TZi0DrjiwP4fgyCMPZdVMAZ8z/h1J0Xf27shxqpvXUFVXN32U
        XHxrT0mt0labIAz4NHXjvgWjBj7YuhfeeSZBa0njcg==
X-Google-Smtp-Source: ABdhPJwfA/MQAPTERcMuz/vs9UEJlHRAq/7BhZ+7J5feTgJtkX8n/M83d0b+ymghnQA1+qINeAOpLfNs+D5ZLI/f52I=
X-Received: by 2002:a67:5c03:: with SMTP id q3mr34680676vsb.47.1609380643698;
 Wed, 30 Dec 2020 18:10:43 -0800 (PST)
MIME-Version: 1.0
References: <20201227105449.11452-1-roger.lu@mediatek.com> <20201227105449.11452-4-roger.lu@mediatek.com>
In-Reply-To: <20201227105449.11452-4-roger.lu@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Thu, 31 Dec 2020 10:10:32 +0800
Message-ID: <CANMq1KBNKy708Vz67WOc+n7V7ne4L1EZVkUVGj6abd5voxKjxA@mail.gmail.com>
Subject: Re: [PATCH v10 3/7] [v10, 3/7]: soc: mediatek: SVS: introduce MTK SVS engine
To:     Roger Lu <roger.lu@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Boichat <drinkcat@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Nishanth Menon <nm@ti.com>, Angus Lin <Angus.Lin@mediatek.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Xiaoqing Liu <Xiaoqing.Liu@mediatek.com>,
        YT Lee <yt.lee@mediatek.com>, Fan Chen <fan.chen@mediatek.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        HenryC Chen <HenryC.Chen@mediatek.com>,
        Charles Yang <Charles.Yang@mediatek.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Dec 27, 2020 at 6:55 PM Roger Lu <roger.lu@mediatek.com> wrote:
>
> The Smart Voltage Scaling(SVS) engine is a piece of hardware
> which calculats suitable SVS bank voltages to OPP voltage table.

calculates

> Then, DVFS driver could apply those SVS bank voltages to PMIC/Buck
> when receiving OPP_EVENT_ADJUST_VOLTAGE.
>
> Signed-off-by: Roger Lu <roger.lu@mediatek.com>
> ---
>  drivers/soc/mediatek/Kconfig   |   10 +
>  drivers/soc/mediatek/Makefile  |    1 +
>  drivers/soc/mediatek/mtk-svs.c | 1748 ++++++++++++++++++++++++++++++++
>  3 files changed, 1759 insertions(+)
>  create mode 100644 drivers/soc/mediatek/mtk-svs.c
>
> diff --git a/drivers/soc/mediatek/Kconfig b/drivers/soc/mediatek/Kconfig
> index 59a56cd790ec..f33da25f8336 100644
> --- a/drivers/soc/mediatek/Kconfig
> +++ b/drivers/soc/mediatek/Kconfig
> @@ -51,4 +51,14 @@ config MTK_MMSYS
>           Say yes here to add support for the MediaTek Multimedia
>           Subsystem (MMSYS).
>
> +config MTK_SVS
> +       tristate "MediaTek Smart Voltage Scaling(SVS)"
> +       depends on MTK_EFUSE && NVMEM
> +       help
> +         The Smart Voltage Scaling(SVS) engine is a piece of hardware
> +         which has several controllers(banks) for calculating suitable
> +         voltage to different power domains(CPU/GPU/CCI) according to
> +         chip process corner, temperatures and other factors. Then DVFS
> +         driver could apply SVS bank voltage to PMIC/Buck.
> +
>  endmenu
> diff --git a/drivers/soc/mediatek/Makefile b/drivers/soc/mediatek/Makefile
> index 01f9f873634a..e10f2cd87514 100644
> --- a/drivers/soc/mediatek/Makefile
> +++ b/drivers/soc/mediatek/Makefile
> @@ -4,3 +4,4 @@ obj-$(CONFIG_MTK_INFRACFG) += mtk-infracfg.o
>  obj-$(CONFIG_MTK_PMIC_WRAP) += mtk-pmic-wrap.o
>  obj-$(CONFIG_MTK_SCPSYS) += mtk-scpsys.o
>  obj-$(CONFIG_MTK_MMSYS) += mtk-mmsys.o
> +obj-$(CONFIG_MTK_SVS) += mtk-svs.o
> diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
> new file mode 100644
> index 000000000000..0efefb48839d
> --- /dev/null
> +++ b/drivers/soc/mediatek/mtk-svs.c
> @@ -0,0 +1,1748 @@
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
> +#define SVSB_CPU_LITTLE                        BIT(0)
> +#define SVSB_CPU_BIG                   BIT(1)
> +#define SVSB_CCI                       BIT(2)
> +#define SVSB_GPU                       BIT(3)
> +
> +/* svs bank mode support */
> +#define SVSB_MODE_ALL_DISABLE          0
> +#define SVSB_MODE_INIT01               BIT(1)
> +#define SVSB_MODE_INIT02               BIT(2)
> +#define SVSB_MODE_MON                  BIT(3)
> +
> +/* svs bank init01 condition */
> +#define SVSB_INIT01_VOLT_IGNORE                BIT(1)
> +#define SVSB_INIT01_VOLT_INC_ONLY      BIT(2)
> +#define SVSB_INIT01_CLK_EN             BIT(31)
> +
> +/* svs bank common setting */
> +#define SVSB_TZONE_HIGH_TEMP_MAX       U32_MAX
> +#define SVSB_RUNCONFIG_DEFAULT         0x80000000
> +#define SVSB_DC_SIGNED_BIT             0x8000
> +#define SVSB_INTEN_INIT0x              0x00005f01
> +#define SVSB_INTEN_MONVOPEN            0x00ff0000
> +#define SVSB_EN_OFF                    0x0
> +#define SVSB_EN_MASK                   0x7
> +#define SVSB_EN_INIT01                 0x1
> +#define SVSB_EN_INIT02                 0x5
> +#define SVSB_EN_MON                    0x2
> +#define SVSB_INTSTS_MONVOP             0x00ff0000
> +#define SVSB_INTSTS_COMPLETE           0x1
> +#define SVSB_INTSTS_CLEAN              0x00ffffff
> +
> +static DEFINE_SPINLOCK(mtk_svs_lock);
> +
> +/*
> + * enum svsb_phase - svs bank phase enumeration
> + * @SVSB_PHASE_INIT01: basic init for svs bank
> + * @SVSB_PHASE_INIT02: svs bank can provide voltages
> + * @SVSB_PHASE_MON: svs bank can provide voltages with thermal effect
> + * @SVSB_PHASE_ERROR: svs bank encouters unexpected condition

encounters

> + *
> + * Each svs bank has its own independent phase. We enable each svs bank by
> + * running their phase orderly. However, When svs bank ecnounters unexpected

encounters

> + * condition, it will fire an irq (PHASE_ERROR) to inform svs software.
> + *
> + * svs bank general phase-enabled order:
> + * SVSB_PHASE_INIT01 -> SVSB_PHASE_INIT02 -> SVSB_PHASE_MON
> + */
> +enum svsb_phase {
> +       SVSB_PHASE_INIT01 = 0,
> +       SVSB_PHASE_INIT02,
> +       SVSB_PHASE_MON,
> +       SVSB_PHASE_ERROR,
> +};
> +
> +enum svs_reg_index {
> +       DESCHAR = 0,
> +       TEMPCHAR,
> +       DETCHAR,
> +       AGECHAR,
> +       DCCONFIG,
> +       AGECONFIG,
> +       FREQPCT30,
> +       FREQPCT74,
> +       LIMITVALS,
> +       VBOOT,
> +       DETWINDOW,
> +       CONFIG,
> +       TSCALCS,
> +       RUNCONFIG,
> +       SVSEN,
> +       INIT2VALS,
> +       DCVALUES,
> +       AGEVALUES,
> +       VOP30,
> +       VOP74,
> +       TEMP,
> +       INTSTS,
> +       INTSTSRAW,
> +       INTEN,
> +       CHKINT,
> +       CHKSHIFT,
> +       STATUS,
> +       VDESIGN30,
> +       VDESIGN74,
> +       DVT30,
> +       DVT74,
> +       AGECOUNT,
> +       SMSTATE0,
> +       SMSTATE1,
> +       CTL0,
> +       DESDETSEC,
> +       TEMPAGESEC,
> +       CTRLSPARE0,
> +       CTRLSPARE1,
> +       CTRLSPARE2,
> +       CTRLSPARE3,
> +       CORESEL,
> +       THERMINTST,
> +       INTST,
> +       THSTAGE0ST,
> +       THSTAGE1ST,
> +       THSTAGE2ST,
> +       THAHBST0,
> +       THAHBST1,
> +       SPARE0,
> +       SPARE1,
> +       SPARE2,
> +       SPARE3,
> +       THSLPEVEB,
> +       reg_num,

What do you need reg_num for? Maybe remove it?

If you need it, it should probably be named SVS_REG_NUM.

> +};
> +
> +static const u32 svs_regs_v2[] = {
> +       [DESCHAR]               = 0xc00,
> +       [TEMPCHAR]              = 0xc04,
> +       [DETCHAR]               = 0xc08,
> +       [AGECHAR]               = 0xc0c,
> +       [DCCONFIG]              = 0xc10,
> +       [AGECONFIG]             = 0xc14,
> +       [FREQPCT30]             = 0xc18,
> +       [FREQPCT74]             = 0xc1c,
> +       [LIMITVALS]             = 0xc20,
> +       [VBOOT]                 = 0xc24,
> +       [DETWINDOW]             = 0xc28,
> +       [CONFIG]                = 0xc2c,
> +       [TSCALCS]               = 0xc30,
> +       [RUNCONFIG]             = 0xc34,
> +       [SVSEN]                 = 0xc38,
> +       [INIT2VALS]             = 0xc3c,
> +       [DCVALUES]              = 0xc40,
> +       [AGEVALUES]             = 0xc44,
> +       [VOP30]                 = 0xc48,
> +       [VOP74]                 = 0xc4c,
> +       [TEMP]                  = 0xc50,
> +       [INTSTS]                = 0xc54,
> +       [INTSTSRAW]             = 0xc58,
> +       [INTEN]                 = 0xc5c,
> +       [CHKINT]                = 0xc60,
> +       [CHKSHIFT]              = 0xc64,
> +       [STATUS]                = 0xc68,
> +       [VDESIGN30]             = 0xc6c,
> +       [VDESIGN74]             = 0xc70,
> +       [DVT30]                 = 0xc74,
> +       [DVT74]                 = 0xc78,
> +       [AGECOUNT]              = 0xc7c,
> +       [SMSTATE0]              = 0xc80,
> +       [SMSTATE1]              = 0xc84,
> +       [CTL0]                  = 0xc88,
> +       [DESDETSEC]             = 0xce0,
> +       [TEMPAGESEC]            = 0xce4,
> +       [CTRLSPARE0]            = 0xcf0,
> +       [CTRLSPARE1]            = 0xcf4,
> +       [CTRLSPARE2]            = 0xcf8,
> +       [CTRLSPARE3]            = 0xcfc,
> +       [CORESEL]               = 0xf00,
> +       [THERMINTST]            = 0xf04,
> +       [INTST]                 = 0xf08,
> +       [THSTAGE0ST]            = 0xf0c,
> +       [THSTAGE1ST]            = 0xf10,
> +       [THSTAGE2ST]            = 0xf14,
> +       [THAHBST0]              = 0xf18,
> +       [THAHBST1]              = 0xf1c,
> +       [SPARE0]                = 0xf20,
> +       [SPARE1]                = 0xf24,
> +       [SPARE2]                = 0xf28,
> +       [SPARE3]                = 0xf2c,
> +       [THSLPEVEB]             = 0xf30,
> +};
> +
> +/*
> + * struct thermal_parameter - This is for storing thermal efuse data.
> + * We cacluate thermal efuse data to produce "mts" and "bts" for

calculate

> + * svs bank mon mode.
> + */
> +struct thermal_parameter {
> +       int adc_ge_t;
> +       int adc_oe_t;
> +       int ge;
> +       int oe;
> +       int gain;
> +       int o_vtsabb;
> +       int o_vtsmcu1;
> +       int o_vtsmcu2;
> +       int o_vtsmcu3;
> +       int o_vtsmcu4;
> +       int o_vtsmcu5;
> +       int degc_cali;
> +       int adc_cali_en_t;
> +       int o_slope;
> +       int o_slope_sign;
> +       int ts_id;
> +};
> +
> +/*
> + * struct svs_bank - svs bank representation
> + * @dev: svs bank device
> + * @opp_dev: device for opp table/buck control
> + * @pd_dev: power domain device for SOC mtcmos control
> + * @init_completion: the timeout completion for bank init
> + * @buck: phandle of the regulator
> + * @lock: mutex lock to protect voltage update process
> + * @suspended: suspend flag of this bank
> + * @pd_req: bank's power-domain on request
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
> + * @init01_volt_flag: bank init01 voltage flag
> + * @phase: bank current phase
> + * @vmax: bank voltage maximum
> + * @vmin: bank votlage minimum

voltage

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
> + * @name: bank name
> + * @tzone_name: thermal zone name
> + * @buck_name: regulator name
> + *
> + * Other structure members which are not listed above are svs platform
> + * efuse data for bank init
> + */
> +struct svs_bank {
> +       struct device *dev;
> +       struct device *opp_dev;
> +       struct device *pd_dev;
> +       struct completion init_completion;
> +       struct regulator *buck;
> +       struct mutex lock;      /* lock to protect voltage update process */
> +       bool suspended;
> +       bool pd_req;
> +       s32 volt_offset;
> +       u32 mode_support;
> +       u32 opp_freqs[16];
> +       u32 opp_volts[16];
> +       u32 freqs_pct[16];
> +       u32 volts[16];
> +       u32 freq_base;
> +       u32 vboot;
> +       u32 volt_step;
> +       u32 volt_base;
> +       u32 init01_volt_flag;
> +       u32 phase;
> +       u32 vmax;
> +       u32 vmin;
> +       u32 bts;
> +       u32 mts;
> +       u32 bdes;
> +       u32 mdes;
> +       u32 mtdes;
> +       u32 dcbdet;
> +       u32 dcmdet;
> +       u32 dthi;
> +       u32 dtlo;
> +       u32 det_window;
> +       u32 det_max;
> +       u32 age_config;
> +       u32 age_voffset_in;
> +       u32 agem;
> +       u32 dc_config;
> +       u32 dc_voffset_in;
> +       u32 dvt_fixed;
> +       u32 vco;
> +       u32 chk_shift;
> +       u32 temp;
> +       u32 temp_upper_bound;
> +       u32 temp_lower_bound;
> +       u32 tzone_high_temp;
> +       u32 tzone_high_temp_offset;
> +       u32 tzone_low_temp;
> +       u32 tzone_low_temp_offset;
> +       u32 core_sel;
> +       u32 opp_count;
> +       u32 int_st;
> +       u32 sw_id;
> +       u32 ctl0;
> +       u32 cpu_id;
> +       u8 *name;
> +       u8 *tzone_name;
> +       u8 *buck_name;
> +};
> +
> +/*
> + * struct svs_platform - svs platform data
> + * @dev: svs platform device
> + * @base: svs platform register address base
> + * @main_clk: main clock for svs bank
> + * @pbank: phandle of svs bank and needs to be protected by spin_lock
> + * @banks: phandle of the banks that support
> + * @efuse_parsing: phandle of efuse parsing function
> + * @set_freqs_pct: phandle of set frequencies percent function
> + * @get_vops: phandle of  get bank voltages function
> + * @irqflags: irq settings flags
> + * @fake_efuse: the flag for running svs with fake efuse
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
> +       struct device *dev;
> +       void __iomem *base;
> +       struct clk *main_clk;
> +       struct svs_bank *pbank;
> +       struct svs_bank *banks;
> +       bool (*efuse_parsing)(struct svs_platform *svsp);
> +       void (*set_freqs_pct)(struct svs_platform *svsp);
> +       void (*get_vops)(struct svs_platform *svsp);
> +       unsigned long irqflags;
> +       bool fake_efuse;
> +       struct reset_control *rst;
> +       const u32 *regs;
> +       size_t efuse_num;
> +       size_t tefuse_num;
> +       u32 bank_num;
> +       u32 efuse_check;
> +       u32 *efuse;
> +       u32 *tefuse;
> +       u8 *name;
> +};
> +
> +static u32 percent(u32 numerator, u32 denominator)
> +{
> +       u32 pct;
> +
> +       /* If not divide 1000, "numerator * 100" will have data overflow. */
> +       numerator /= 1000;
> +       denominator /= 1000;
> +       pct = ((numerator * 100) + denominator - 1) / denominator;

pct = DIV_ROUND_UP(numerator * 100, denominator);

> +       pct &= GENMASK(7, 0);

Why do you need this?

Maybe you should just return a u8 here?

> +
> +       return pct;
> +}
> +
> +static u32 svs_readl(struct svs_platform *svsp, enum svs_reg_index rg_i)
> +{
> +       return readl(svsp->base + svsp->regs[rg_i]);
> +}
> +
> +static void svs_writel(struct svs_platform *svsp, u32 val,
> +                      enum svs_reg_index rg_i)
> +{
> +       writel(val, svsp->base + svsp->regs[rg_i]);
> +}
> +
> +static void svs_switch_bank(struct svs_platform *svsp)
> +{
> +       struct svs_bank *svsb = svsp->pbank;
> +
> +       svs_writel(svsp, svsb->core_sel, CORESEL);
> +}
> +
> +static u32 svs_bank_volt_to_opp_volt(u32 svsb_volt, u32 svsb_volt_step,
> +                                    u32 svsb_volt_base)
> +{
> +       u32 opp_u_volt;
> +
> +       opp_u_volt = (svsb_volt * svsb_volt_step) + svsb_volt_base;
> +
> +       return opp_u_volt;

return (svsb_volt * svsb_volt_step) + svsb_volt_base;

> +}
> +
> +static int svs_get_bank_zone_temperature(u8 *tzone_name, int *tzone_temp)

`const char *tzone_name` is probably more appropriate.

> +{
> +       struct thermal_zone_device *tzd;
> +
> +       tzd = thermal_zone_get_zone_by_name(tzone_name);
> +       if (IS_ERR(tzd))
> +               return PTR_ERR(tzd);
> +
> +       return thermal_zone_get_temp(tzd, tzone_temp);
> +}
> +
> +static int svs_adjust_pm_opp_volts(struct svs_bank *svsb, bool force_update)
> +{
> +       int tzone_temp, ret = -EPERM;

No need to initialize ret.

> +       u32 i, svsb_volt, opp_volt, temp_offset = 0;
> +
> +       mutex_lock(&svsb->lock);
> +
> +       /*
> +        * If svs bank is suspended, it means signed-off voltages are applied.
> +        * Don't need to update opp voltage anymore.
> +        */
> +       if (svsb->suspended && !force_update) {
> +               dev_notice(svsb->dev, "bank is suspended\n");
> +               ret = -EPERM;
> +               goto unlock_mutex;
> +       }
> +
> +       /* Get thermal effect */
> +       if (svsb->phase == SVSB_PHASE_MON) {
> +               if (svsb->temp > svsb->temp_upper_bound &&
> +                   svsb->temp < svsb->temp_lower_bound) {
> +                       dev_warn(svsb->dev, "svsb temp = 0x%x?\n", svsb->temp);
> +                       ret = -EINVAL;
> +                       goto unlock_mutex;
> +               }
> +
> +               ret = svs_get_bank_zone_temperature(svsb->tzone_name,
> +                                                   &tzone_temp);
> +               if (ret) {
> +                       dev_err(svsb->dev, "no \"%s\"?(%d)?\n",
> +                               svsb->tzone_name, ret);
> +                       dev_err(svsb->dev, "set signed-off voltage\n");

Please merge the error message in one line (I'm not sure what "set
signed-off voltage" means here).

> +                       svsb->phase = SVSB_PHASE_ERROR;
> +               }
> +
> +               if (tzone_temp >= svsb->tzone_high_temp)
> +                       temp_offset += svsb->tzone_high_temp_offset;
> +               else if (tzone_temp <= svsb->tzone_low_temp)
> +                       temp_offset += svsb->tzone_low_temp_offset;
> +       }
> +
> +       /* vmin <= svsb_volt (opp_volt) <= signed-off voltage */
> +       for (i = 0; i < svsb->opp_count; i++) {
> +               if (svsb->phase == SVSB_PHASE_MON) {
> +                       svsb_volt = max((svsb->volts[i] + svsb->volt_offset +
> +                                        temp_offset), svsb->vmin);

parentheses inside the max parameter not needed

> +                       opp_volt = svs_bank_volt_to_opp_volt(svsb_volt,
> +                                                            svsb->volt_step,
> +                                                            svsb->volt_base);
> +               } else if (svsb->phase == SVSB_PHASE_INIT02) {
> +                       svsb_volt = max((svsb->volts[i] + svsb->volt_offset),
> +                                       svsb->vmin);

ditto.

> +                       opp_volt = svs_bank_volt_to_opp_volt(svsb_volt,
> +                                                            svsb->volt_step,
> +                                                            svsb->volt_base);
> +               } else if (svsb->phase == SVSB_PHASE_ERROR) {
> +                       opp_volt = svsb->opp_volts[i];
> +               } else {
> +                       dev_err(svsb->dev, "unknown phase: %u?\n", svsb->phase);
> +                       ret = -EINVAL;
> +                       goto unlock_mutex;
> +               }
> +
> +               opp_volt = min(opp_volt, svsb->opp_volts[i]);
> +               ret = dev_pm_opp_adjust_voltage(svsb->opp_dev,
> +                                               svsb->opp_freqs[i],
> +                                               opp_volt, opp_volt,
> +                                               svsb->opp_volts[i]);
> +               if (ret) {
> +                       dev_err(svsb->dev, "set voltage fail: %d\n", ret);
> +                       goto unlock_mutex;
> +               }
> +       }
> +
> +unlock_mutex:
> +       mutex_unlock(&svsb->lock);
> +
> +       return ret;
> +}
> +
> +static u32 interpolate(u32 f0, u32 f1, u32 v0, u32 v1, u32 fx)
> +{
> +       u32 vy;
> +
> +       if (v0 == v1 || f0 == f1)
> +               return v0;
> +
> +       /* *100 to have decimal fraction factor, +99 for rounding up. */
> +       vy = (v0 * 100) - ((((v0 - v1) * 100) / (f0 - f1)) * (f0 - fx));
> +       vy = (vy + 99) / 100;

vy = DIV_ROUND_UP(vy, 100);

> +
> +       return vy;
> +}
> +
> +static void svs_get_vops_v2(struct svs_platform *svsp)
> +{
> +       struct svs_bank *svsb = svsp->pbank;
> +       u32 temp, i;
> +
> +       temp = svs_readl(svsp, VOP74);
> +       svsb->volts[14] = (temp >> 24) & GENMASK(7, 0);
> +       svsb->volts[12] = (temp >> 16) & GENMASK(7, 0);
> +       svsb->volts[10] = (temp >> 8)  & GENMASK(7, 0);
> +       svsb->volts[8] = (temp & GENMASK(7, 0));
> +
> +       temp = svs_readl(svsp, VOP30);
> +       svsb->volts[6] = (temp >> 24) & GENMASK(7, 0);
> +       svsb->volts[4] = (temp >> 16) & GENMASK(7, 0);
> +       svsb->volts[2] = (temp >> 8)  & GENMASK(7, 0);
> +       svsb->volts[0] = (temp & GENMASK(7, 0));
> +
> +       for (i = 0; i <= 7; i++) {
> +               if (i < 7) {
> +                       svsb->volts[(i * 2) + 1] =
> +                               interpolate(svsb->freqs_pct[i * 2],
> +                                           svsb->freqs_pct[(i + 1) * 2],
> +                                           svsb->volts[i * 2],
> +                                           svsb->volts[(i + 1) * 2],
> +                                           svsb->freqs_pct[(i * 2) + 1]);
> +               } else if (i == 7) {
> +                       svsb->volts[(i * 2) + 1] =
> +                               interpolate(svsb->freqs_pct[(i - 1) * 2],
> +                                           svsb->freqs_pct[i * 2],
> +                                           svsb->volts[(i - 1) * 2],
> +                                           svsb->volts[i * 2],
> +                                           svsb->freqs_pct[(i * 2) + 1]);
> +               }
> +       }

Please double-check, but I think we can do:

for (i = 0; i <= 12; i += 2) {
    svsb->volts[i + 1] =
        interpolate(svsb->freqs_pct[i],
                    svsb->freqs_pct[i + 2],
                    svsb->volts[i],
                    svsb->volts[i + 2],
                    svsb->freqs_pct[i + 1]);
}

svsb->volts[i + 1] =
    interpolate(svsb->freqs_pct[i - 2],
                svsb->freqs_pct[i],
                svsb->volts[i - 2],
                svsb->volts[i],
                svsb->freqs_pct[i + 1]);


(or maybe replace i with 14 in the computation for this last iteration.

> +}
> +
> +static void svs_set_freqs_pct_v2(struct svs_platform *svsp)
> +{
> +       struct svs_bank *svsb = svsp->pbank;
> +
> +       svs_writel(svsp,
> +                  ((svsb->freqs_pct[14] << 24) & GENMASK(31, 24)) |

Well you already took care of making sure freqs_pct does not have more
than 8 bits set, so I don't think you need GENMASK(31, 24).

> +                  ((svsb->freqs_pct[12] << 16) & GENMASK(23, 16)) |
> +                  ((svsb->freqs_pct[10] << 8) & GENMASK(15, 8)) |
> +                  ((svsb->freqs_pct[8]) & GENMASK(7, 0)),
> +                  FREQPCT74);
> +
> +       svs_writel(svsp,
> +                  ((svsb->freqs_pct[6] << 24) & GENMASK(31, 24)) |
> +                  ((svsb->freqs_pct[4] << 16) & GENMASK(23, 16)) |
> +                  ((svsb->freqs_pct[2] << 8) & GENMASK(15, 8)) |
> +                  (svsb->freqs_pct[0] & GENMASK(7, 0)),
> +                  FREQPCT30);
> +}
> +
> +static void svs_set_bank_phase(struct svs_platform *svsp, u32 target_phase)
> +{
> +       struct svs_bank *svsb = svsp->pbank;
> +       u32 des_char, temp_char, det_char, limit_vals;
> +       u32 init2vals, ts_calcs, val, filter, i;
> +
> +       svs_switch_bank(svsp);
> +
> +       des_char = ((svsb->bdes << 8) & GENMASK(15, 8)) |
> +                  (svsb->mdes & GENMASK(7, 0));

Similar to my suggestion about, consider chaging bdes type to u8 so
you don't need all these masks?

> +       svs_writel(svsp, des_char, DESCHAR);
> +
> +       temp_char = ((svsb->vco << 16) & GENMASK(23, 16)) |
> +                   ((svsb->mtdes << 8) & GENMASK(15, 8)) |
> +                   (svsb->dvt_fixed & GENMASK(7, 0));
> +       svs_writel(svsp, temp_char, TEMPCHAR);
> +
> +       det_char = ((svsb->dcbdet << 8) & GENMASK(15, 8)) |
> +                  (svsb->dcmdet & GENMASK(7, 0));
> +       svs_writel(svsp, det_char, DETCHAR);
> +
> +       svs_writel(svsp, svsb->dc_config, DCCONFIG);
> +       svs_writel(svsp, svsb->age_config, AGECONFIG);
> +
> +       if (!svsb->agem) {
> +               svs_writel(svsp, SVSB_RUNCONFIG_DEFAULT, RUNCONFIG);
> +       } else {
> +               val = 0x0;
> +
> +               for (i = 0; i < 24; i += 2) {
> +                       filter = 0x3 << i;
> +
> +                       if (!(svsb->age_config & filter))
> +                               val |= (0x1 << i);
> +                       else
> +                               val |= (svsb->age_config & filter);
> +               }
> +               svs_writel(svsp, val, RUNCONFIG);
> +       }
> +
> +       svsp->set_freqs_pct(svsp);
> +
> +       limit_vals = ((svsb->vmax << 24) & GENMASK(31, 24)) |
> +                    ((svsb->vmin << 16) & GENMASK(23, 16)) |
> +                    ((svsb->dthi << 8) & GENMASK(15, 8)) |
> +                    (svsb->dtlo & GENMASK(7, 0));
> +       svs_writel(svsp, limit_vals, LIMITVALS);
> +       svs_writel(svsp, (svsb->vboot & GENMASK(7, 0)), VBOOT);
> +       svs_writel(svsp, (svsb->det_window & GENMASK(15, 0)), DETWINDOW);
> +       svs_writel(svsp, (svsb->det_max & GENMASK(15, 0)), CONFIG);
> +
> +       if (svsb->chk_shift)
> +               svs_writel(svsp, (svsb->chk_shift & GENMASK(7, 0)), CHKSHIFT);
> +
> +       if (svsb->ctl0)
> +               svs_writel(svsp, svsb->ctl0, CTL0);
> +
> +       svs_writel(svsp, SVSB_INTSTS_CLEAN, INTSTS);
> +
> +       switch (target_phase) {
> +       case SVSB_PHASE_INIT01:
> +               svs_writel(svsp, SVSB_INTEN_INIT0x, INTEN);
> +               svs_writel(svsp, SVSB_EN_INIT01, SVSEN);
> +               break;
> +       case SVSB_PHASE_INIT02:
> +               svs_writel(svsp, SVSB_INTEN_INIT0x, INTEN);
> +               init2vals = ((svsb->age_voffset_in << 16) & GENMASK(31, 16)) |
> +                           (svsb->dc_voffset_in & GENMASK(15, 0));
> +               svs_writel(svsp, init2vals, INIT2VALS);
> +               svs_writel(svsp, SVSB_EN_INIT02, SVSEN);
> +               break;
> +       case SVSB_PHASE_MON:
> +               ts_calcs = ((svsb->bts << 12) & GENMASK(23, 12)) |
> +                          (svsb->mts & GENMASK(11, 0));
> +               svs_writel(svsp, ts_calcs, TSCALCS);
> +               svs_writel(svsp, SVSB_INTEN_MONVOPEN, INTEN);
> +               svs_writel(svsp, SVSB_EN_MON, SVSEN);
> +               break;
> +       default:
> +               WARN_ON(1);
> +               break;
> +       }
> +}
> +
> +static inline void svs_init01_isr_handler(struct svs_platform *svsp)
> +{
> +       struct svs_bank *svsb = svsp->pbank;
> +
> +       dev_info(svsb->dev, "%s: VDN74~30:0x%08x~0x%08x, DC:0x%08x\n",

dev_dbg?

> +                __func__, svs_readl(svsp, VDESIGN74),
> +                svs_readl(svsp, VDESIGN30), svs_readl(svsp, DCVALUES));
> +
> +       svsb->phase = SVSB_PHASE_INIT01;
> +       svsb->dc_voffset_in = ~(svs_readl(svsp, DCVALUES) & GENMASK(15, 0)) + 1;
> +       if (svsb->init01_volt_flag == SVSB_INIT01_VOLT_IGNORE)
> +               svsb->dc_voffset_in = 0;
> +       else if ((svsb->dc_voffset_in & SVSB_DC_SIGNED_BIT) &&
> +                (svsb->init01_volt_flag == SVSB_INIT01_VOLT_INC_ONLY))
> +               svsb->dc_voffset_in = 0;

Merge these 2 if tests into one, since you do the same operation in both cases.

> +
> +       svsb->age_voffset_in = svs_readl(svsp, AGEVALUES) & GENMASK(15, 0);
> +
> +       svs_writel(svsp, SVSB_EN_OFF, SVSEN);
> +       svs_writel(svsp, SVSB_INTSTS_COMPLETE, INTSTS);
> +
> +       /* svs init01 clock gating */
> +       svsb->core_sel &= ~SVSB_INIT01_CLK_EN;
> +}
> +
> +static inline void svs_init02_isr_handler(struct svs_platform *svsp)
> +{
> +       struct svs_bank *svsb = svsp->pbank;
> +
> +       dev_info(svsb->dev, "%s: VOP74~30:0x%08x~0x%08x, DC:0x%08x\n",
> +                __func__, svs_readl(svsp, VOP74), svs_readl(svsp, VOP30),
> +                svs_readl(svsp, DCVALUES));

dev_dbg?

> +
> +       svsb->phase = SVSB_PHASE_INIT02;
> +       svsp->get_vops(svsp);
> +
> +       svs_writel(svsp, SVSB_EN_OFF, SVSEN);
> +       svs_writel(svsp, SVSB_INTSTS_COMPLETE, INTSTS);
> +}
> +
> +static inline void svs_mon_mode_isr_handler(struct svs_platform *svsp)
> +{
> +       struct svs_bank *svsb = svsp->pbank;
> +
> +       svsb->phase = SVSB_PHASE_MON;
> +       svsb->temp = svs_readl(svsp, TEMP) & GENMASK(7, 0);
> +       svsp->get_vops(svsp);
> +
> +       svs_writel(svsp, SVSB_INTSTS_MONVOP, INTSTS);
> +}
> +
> +static inline void svs_error_isr_handler(struct svs_platform *svsp)
> +{
> +       struct svs_bank *svsb = svsp->pbank;
> +
> +       dev_err(svsb->dev, "%s: CORESEL = 0x%08x\n",
> +               __func__, svs_readl(svsp, CORESEL));
> +       dev_err(svsb->dev, "SVSEN = 0x%08x, INTSTS = 0x%08x\n",
> +               svs_readl(svsp, SVSEN), svs_readl(svsp, INTSTS));
> +       dev_err(svsb->dev, "SMSTATE0 = 0x%08x, SMSTATE1 = 0x%08x\n",
> +               svs_readl(svsp, SMSTATE0), svs_readl(svsp, SMSTATE1));
> +       dev_err(svsb->dev, "TEMP = 0x%08x\n", svs_readl(svsp, TEMP));
> +
> +       svsb->mode_support = SVSB_MODE_ALL_DISABLE;
> +       svsb->phase = SVSB_PHASE_ERROR;
> +
> +       svs_writel(svsp, SVSB_EN_OFF, SVSEN);
> +       svs_writel(svsp, SVSB_INTSTS_CLEAN, INTSTS);
> +}
> +
> +static irqreturn_t svs_isr(int irq, void *data)
> +{
> +       struct svs_platform *svsp = (struct svs_platform *)data;

cast not needed.

> +       struct svs_bank *svsb = NULL;
> +       unsigned long flags;
> +       u32 idx, int_sts, svs_en;
> +
> +       for (idx = 0; idx < svsp->bank_num; idx++) {
> +               svsb = &svsp->banks[idx];
> +
> +               spin_lock_irqsave(&mtk_svs_lock, flags);
> +               svsp->pbank = svsb;
> +
> +               /* Find out which svs bank fires interrupt */
> +               if (svsb->int_st & svs_readl(svsp, INTST)) {
> +                       spin_unlock_irqrestore(&mtk_svs_lock, flags);
> +                       continue;
> +               }
> +
> +               if (!svsb->suspended) {
> +                       svs_switch_bank(svsp);
> +                       int_sts = svs_readl(svsp, INTSTS);
> +                       svs_en = svs_readl(svsp, SVSEN);
> +
> +                       if (int_sts == SVSB_INTSTS_COMPLETE &&
> +                           ((svs_en & SVSB_EN_MASK) == SVSB_EN_INIT01))
> +                               svs_init01_isr_handler(svsp);
> +                       else if ((int_sts == SVSB_INTSTS_COMPLETE) &&
> +                                ((svs_en & SVSB_EN_MASK) == SVSB_EN_INIT02))
> +                               svs_init02_isr_handler(svsp);
> +                       else if (!!(int_sts & SVSB_INTSTS_MONVOP))

!! is not required.

> +                               svs_mon_mode_isr_handler(svsp);
> +                       else
> +                               svs_error_isr_handler(svsp);
> +               }
> +
> +               spin_unlock_irqrestore(&mtk_svs_lock, flags);
> +               break;
> +       }

This will panic if svsb is NULL, is that ok or do you want to catch that?

> +
> +       if (svsb->phase != SVSB_PHASE_INIT01)
> +               svs_adjust_pm_opp_volts(svsb, false);
> +
> +       if (svsb->phase == SVSB_PHASE_INIT01 ||
> +           svsb->phase == SVSB_PHASE_INIT02)
> +               complete(&svsb->init_completion);
> +
> +       return IRQ_HANDLED;
> +}
> +
> +static void svs_mon_mode(struct svs_platform *svsp)
> +{
> +       struct svs_bank *svsb;
> +       unsigned long flags;
> +       u32 idx;
> +
> +       for (idx = 0; idx < svsp->bank_num; idx++) {
> +               svsb = &svsp->banks[idx];
> +
> +               if (!(svsb->mode_support & SVSB_MODE_MON))
> +                       continue;
> +
> +               spin_lock_irqsave(&mtk_svs_lock, flags);
> +               svsp->pbank = svsb;
> +               svs_set_bank_phase(svsp, SVSB_PHASE_MON);
> +               spin_unlock_irqrestore(&mtk_svs_lock, flags);
> +       }
> +}
> +
> +static int svs_init02(struct svs_platform *svsp)
> +{
> +       struct svs_bank *svsb;
> +       unsigned long flags, time_left;
> +       u32 idx;
> +
> +       for (idx = 0; idx < svsp->bank_num; idx++) {
> +               svsb = &svsp->banks[idx];
> +
> +               if (!(svsb->mode_support & SVSB_MODE_INIT02))
> +                       continue;
> +
> +               reinit_completion(&svsb->init_completion);
> +               spin_lock_irqsave(&mtk_svs_lock, flags);
> +               svsp->pbank = svsb;
> +               svs_set_bank_phase(svsp, SVSB_PHASE_INIT02);
> +               spin_unlock_irqrestore(&mtk_svs_lock, flags);
> +
> +               time_left =
> +                       wait_for_completion_timeout(&svsb->init_completion,
> +                                                   msecs_to_jiffies(2000));
> +               if (!time_left) {
> +                       dev_err(svsb->dev, "init02 completion timeout\n");
> +                       return -EBUSY;
> +               }
> +       }
> +
> +       return 0;
> +}
> +
> +static int svs_init01(struct svs_platform *svsp)
> +{
> +       struct svs_bank *svsb;
> +       struct pm_qos_request *qos_request;
> +       unsigned long flags, time_left;
> +       bool search_done, does_svsb_set_pd_on;
> +       int ret = 0;
> +       u32 opp_freqs, opp_vboot, buck_volt, idx, i;
> +
> +       qos_request = kzalloc(sizeof(*qos_request), GFP_KERNEL);
> +       if (!qos_request)
> +               return -ENOMEM;
> +
> +       /* Let CPUs leave idle-off state for initializing svs_init01. */
> +       cpu_latency_qos_add_request(qos_request, 0);
> +
> +       /*
> +        * Sometimes two svs banks use the same buck.
> +        * Therefore, we set each svs bank to vboot voltage first.
> +        */
> +       for (idx = 0; idx < svsp->bank_num; idx++) {
> +               svsb = &svsp->banks[idx];
> +
> +               if (!(svsb->mode_support & SVSB_MODE_INIT01))
> +                       continue;
> +
> +               search_done = false;
> +               does_svsb_set_pd_on = false;
> +
> +               if (regulator_set_mode(svsb->buck, REGULATOR_MODE_FAST))
> +                       dev_notice(svsb->dev, "set fast mode fail\n");
> +
> +               if (svsb->pd_req) {
> +                       ret = regulator_enable(svsb->buck);
> +                       if (ret) {
> +                               dev_err(svsb->dev, "\"%s\" enable fail: %d\n",
> +                                       svsb->buck_name, ret);
> +                               goto init01_finish;
> +                       }
> +
> +                       if (!pm_runtime_enabled(svsb->pd_dev)) {
> +                               pm_runtime_enable(svsb->pd_dev);
> +                               does_svsb_set_pd_on = true;
> +                       }
> +
> +                       ret = pm_runtime_get_sync(svsb->pd_dev);
> +                       if (ret < 0) {
> +                               dev_err(svsb->dev, "mtcmos on fail: %d\n",
> +                                       ret);
> +                               goto init01_finish;
> +                       }
> +               }
> +
> +               /*
> +                * Find the fastest freq that can be run at vboot and
> +                * fix to that freq until svs_init01 is done.
> +                */
> +               opp_vboot = svs_bank_volt_to_opp_volt(svsb->vboot,
> +                                                     svsb->volt_step,
> +                                                     svsb->volt_base);
> +
> +               for (i = 0; i < svsb->opp_count; i++) {
> +                       opp_freqs = svsb->opp_freqs[i];
> +                       if (!search_done && svsb->opp_volts[i] <= opp_vboot) {
> +                               ret = dev_pm_opp_adjust_voltage(svsb->opp_dev,
> +                                                               opp_freqs,
> +                                                               opp_vboot,
> +                                                               opp_vboot,
> +                                                               opp_vboot);
> +                               if (ret) {
> +                                       dev_err(svsb->dev,
> +                                               "set voltage fail: %d\n", ret);
> +                                       goto init01_finish;
> +                               }
> +
> +                               search_done = true;
> +                       } else {
> +                               dev_pm_opp_disable(svsb->opp_dev,
> +                                                  svsb->opp_freqs[i]);
> +                       }
> +               }
> +       }
> +
> +       /* svs bank init01 begins */
> +       for (idx = 0; idx < svsp->bank_num; idx++) {
> +               svsb = &svsp->banks[idx];
> +
> +               if (!(svsb->mode_support & SVSB_MODE_INIT01))
> +                       continue;
> +
> +               opp_vboot = svs_bank_volt_to_opp_volt(svsb->vboot,
> +                                                     svsb->volt_step,
> +                                                     svsb->volt_base);
> +
> +               buck_volt = regulator_get_voltage(svsb->buck);
> +               if (buck_volt != opp_vboot) {
> +                       dev_err(svsb->dev,
> +                               "buck voltage: %u, expected vboot: %u\n",
> +                               buck_volt, opp_vboot);
> +                       ret = -EPERM;
> +                       goto init01_finish;
> +               }
> +
> +               spin_lock_irqsave(&mtk_svs_lock, flags);
> +               svsp->pbank = svsb;
> +               svs_set_bank_phase(svsp, SVSB_PHASE_INIT01);
> +               spin_unlock_irqrestore(&mtk_svs_lock, flags);
> +
> +               time_left =
> +                       wait_for_completion_timeout(&svsb->init_completion,
> +                                                   msecs_to_jiffies(2000));
> +               if (!time_left) {
> +                       dev_err(svsb->dev, "init01 completion timeout\n");
> +                       ret = -EBUSY;
> +                       goto init01_finish;
> +               }
> +       }
> +
> +init01_finish:
> +       for (idx = 0; idx < svsp->bank_num; idx++) {
> +               svsb = &svsp->banks[idx];
> +
> +               if (!(svsb->mode_support & SVSB_MODE_INIT01))
> +                       continue;
> +
> +               for (i = 0; i < svsb->opp_count; i++)
> +                       dev_pm_opp_enable(svsb->opp_dev, svsb->opp_freqs[i]);
> +
> +               if (regulator_set_mode(svsb->buck, REGULATOR_MODE_NORMAL))
> +                       dev_notice(svsb->dev, "fail to set normal mode\n");
> +
> +               if (svsb->pd_req) {
> +                       if (pm_runtime_put_sync(svsb->pd_dev))
> +                               dev_err(svsb->dev, "mtcmos off fail\n");
> +
> +                       if (does_svsb_set_pd_on) {
> +                               pm_runtime_disable(svsb->pd_dev);
> +                               does_svsb_set_pd_on = false;
> +                       }
> +
> +                       if (regulator_disable(svsb->buck))
> +                               dev_err(svsb->dev, "disable power fail\n");
> +               }
> +       }
> +
> +       cpu_latency_qos_remove_request(qos_request);
> +       kfree(qos_request);
> +
> +       return ret;
> +}
> +
> +static int svs_start(struct svs_platform *svsp)
> +{
> +       int ret;
> +
> +       ret = svs_init01(svsp);
> +       if (ret)
> +               return ret;
> +
> +       ret = svs_init02(svsp);
> +       if (ret)
> +               return ret;
> +
> +       svs_mon_mode(svsp);
> +
> +       return ret;

Or just return 0;

> +}
> +
> +static struct device *svs_get_subsys_device(struct svs_platform *svsp,
> +                                           u8 *node_name)
> +{
> +       struct platform_device *pdev;
> +       struct device_node *np;
> +
> +       np = of_find_node_by_name(NULL, node_name);
> +       if (!np) {
> +               dev_err(svsp->dev, "cannot find %s node\n", node_name);
> +               return ERR_PTR(-ENODEV);
> +       }
> +
> +       pdev = of_find_device_by_node(np);
> +       if (!pdev) {
> +               of_node_put(np);
> +               dev_err(svsp->dev, "cannot find pdev by %s\n", node_name);
> +               return ERR_PTR(-ENXIO);
> +       }
> +
> +       of_node_put(np);
> +
> +       return &pdev->dev;
> +}
> +
> +static struct device *svs_add_device_link(struct svs_platform *svsp,
> +                                         u8 *node_name)
> +{
> +       struct device *dev;
> +       struct device_link *sup_link;
> +
> +       if (!node_name) {
> +               dev_err(svsp->dev, "node name cannot be null\n");
> +               return ERR_PTR(-EINVAL);
> +       }
> +
> +       dev = svs_get_subsys_device(svsp, node_name);
> +       if (IS_ERR(dev))
> +               return dev;
> +
> +       sup_link = device_link_add(svsp->dev, dev,
> +                                  DL_FLAG_AUTOREMOVE_CONSUMER);
> +
> +       if (sup_link->status == DL_STATE_DORMANT)
> +               return ERR_PTR(-EPROBE_DEFER);
> +
> +       return dev;
> +}
> +
> +static int svs_resource_setup(struct svs_platform *svsp)
> +{
> +       struct svs_bank *svsb;
> +       struct dev_pm_opp *opp;
> +       unsigned long freq;
> +       int count, ret;
> +       u32 idx, i;
> +
> +       dev_set_drvdata(svsp->dev, svsp);
> +
> +       for (idx = 0; idx < svsp->bank_num; idx++) {
> +               svsb = &svsp->banks[idx];
> +
> +               switch (svsb->sw_id) {
> +               case SVSB_CPU_LITTLE:
> +                       svsb->name = "SVSB_CPU_LITTLE";
> +                       break;
> +               case SVSB_CPU_BIG:
> +                       svsb->name = "SVSB_CPU_BIG";
> +                       break;
> +               case SVSB_CCI:
> +                       svsb->name = "SVSB_CCI";
> +                       break;
> +               case SVSB_GPU:
> +                       svsb->name = "SVSB_GPU";
> +                       break;
> +               default:
> +                       WARN_ON(1);
> +                       return -EINVAL;
> +               }
> +
> +               svsb->dev = devm_kzalloc(svsp->dev, sizeof(*svsb->dev),
> +                                        GFP_KERNEL);
> +               if (!svsb->dev)
> +                       return -ENOMEM;
> +
> +               ret = dev_set_name(svsb->dev, svsb->name);
> +               if (ret)
> +                       return ret;
> +
> +               dev_set_drvdata(svsb->dev, svsp);
> +
> +               ret = dev_pm_opp_of_add_table(svsb->opp_dev);
> +               if (ret) {
> +                       dev_err(svsb->dev, "add opp table fail: %d\n", ret);
> +                       return ret;
> +               }
> +
> +               mutex_init(&svsb->lock);
> +               init_completion(&svsb->init_completion);
> +
> +               svsb->buck = devm_regulator_get_optional(svsb->opp_dev,
> +                                                        svsb->buck_name);
> +               if (IS_ERR(svsb->buck)) {
> +                       dev_err(svsb->dev, "cannot get \"%s-supply\"\n",
> +                               svsb->buck_name);
> +                       return PTR_ERR(svsb->buck);
> +               }
> +
> +               count = dev_pm_opp_get_opp_count(svsb->opp_dev);
> +               if (svsb->opp_count != count) {
> +                       dev_err(svsb->dev,
> +                               "opp_count not \"%u\" but get \"%d\"?\n",
> +                               svsb->opp_count, count);
> +                       return count;
> +               }
> +
> +               for (i = 0, freq = U32_MAX; i < svsb->opp_count; i++, freq--) {
> +                       opp = dev_pm_opp_find_freq_floor(svsb->opp_dev, &freq);
> +                       if (IS_ERR(opp)) {
> +                               dev_err(svsb->dev, "cannot find freq = %ld\n",
> +                                       PTR_ERR(opp));
> +                               return PTR_ERR(opp);
> +                       }
> +
> +                       svsb->opp_freqs[i] = freq;
> +                       svsb->opp_volts[i] = dev_pm_opp_get_voltage(opp);
> +                       svsb->freqs_pct[i] = percent(svsb->opp_freqs[i],
> +                                                    svsb->freq_base);
> +                       dev_pm_opp_put(opp);
> +               }
> +       }
> +
> +       return 0;
> +}
> +
> +static bool svs_mt8183_efuse_parsing(struct svs_platform *svsp)
> +{
> +       struct thermal_parameter tp;
> +       struct svs_bank *svsb;
> +       bool mon_mode_support = true;
> +       int format[6], x_roomt[6], tb_roomt = 0;
> +       struct nvmem_cell *cell;
> +       u32 idx, i, ft_pgm, mts, temp0, temp1, temp2;
> +
> +       if (svsp->fake_efuse) {
> +               pr_notice("fake efuse\n");
> +               svsp->efuse[0] = 0x00310080;
> +               svsp->efuse[1] = 0xabfbf757;
> +               svsp->efuse[2] = 0x47c747c7;
> +               svsp->efuse[3] = 0xabfbf757;
> +               svsp->efuse[4] = 0xe7fca0ec;
> +               svsp->efuse[5] = 0x47bf4b88;
> +               svsp->efuse[6] = 0xabfb8fa5;
> +               svsp->efuse[7] = 0xabfb217b;
> +               svsp->efuse[8] = 0x4bf34be1;
> +               svsp->efuse[9] = 0xabfb670d;
> +               svsp->efuse[16] = 0xabfbc653;
> +               svsp->efuse[17] = 0x47f347e1;
> +               svsp->efuse[18] = 0xabfbd848;
> +       }

Looks like debugging code, drop this?

> +
> +       for (i = 0; i < svsp->efuse_num; i++)
> +               if (svsp->efuse[i])
> +                       dev_notice(svsp->dev, "M_HW_RES%d: 0x%08x\n",
> +                                  i, svsp->efuse[i]);

dev_dbg?

> +
> +       /* Svs efuse parsing */
> +       ft_pgm = (svsp->efuse[0] >> 4) & GENMASK(3, 0);
> +
> +       for (idx = 0; idx < svsp->bank_num; idx++) {
> +               svsb = &svsp->banks[idx];
> +
> +               if (ft_pgm <= 1)
> +                       svsb->init01_volt_flag = SVSB_INIT01_VOLT_IGNORE;
> +
> +               switch (svsb->sw_id) {
> +               case SVSB_CPU_LITTLE:
> +                       svsb->bdes = svsp->efuse[16] & GENMASK(7, 0);
> +                       svsb->mdes = (svsp->efuse[16] >> 8) & GENMASK(7, 0);
> +                       svsb->dcbdet = (svsp->efuse[16] >> 16) & GENMASK(7, 0);
> +                       svsb->dcmdet = (svsp->efuse[16] >> 24) & GENMASK(7, 0);
> +                       svsb->mtdes  = (svsp->efuse[17] >> 16) & GENMASK(7, 0);

Again, if all of those values were u8, there'd be no need for these GENMASK

> +
> +                       if (ft_pgm <= 3)
> +                               svsb->volt_offset += 10;
> +                       else
> +                               svsb->volt_offset += 2;
> +                       break;
> +               case SVSB_CPU_BIG:
> +                       svsb->bdes = svsp->efuse[18] & GENMASK(7, 0);
> +                       svsb->mdes = (svsp->efuse[18] >> 8) & GENMASK(7, 0);
> +                       svsb->dcbdet = (svsp->efuse[18] >> 16) & GENMASK(7, 0);
> +                       svsb->dcmdet = (svsp->efuse[18] >> 24) & GENMASK(7, 0);
> +                       svsb->mtdes  = svsp->efuse[17] & GENMASK(7, 0);
> +
> +                       if (ft_pgm <= 3)
> +                               svsb->volt_offset += 15;
> +                       else
> +                               svsb->volt_offset += 12;
> +                       break;
> +               case SVSB_CCI:
> +                       svsb->bdes = svsp->efuse[4] & GENMASK(7, 0);
> +                       svsb->mdes = (svsp->efuse[4] >> 8) & GENMASK(7, 0);
> +                       svsb->dcbdet = (svsp->efuse[4] >> 16) & GENMASK(7, 0);
> +                       svsb->dcmdet = (svsp->efuse[4] >> 24) & GENMASK(7, 0);
> +                       svsb->mtdes  = (svsp->efuse[5] >> 16) & GENMASK(7, 0);
> +
> +                       if (ft_pgm <= 3)
> +                               svsb->volt_offset += 10;
> +                       else
> +                               svsb->volt_offset += 2;
> +                       break;
> +               case SVSB_GPU:
> +                       svsb->bdes = svsp->efuse[6] & GENMASK(7, 0);
> +                       svsb->mdes = (svsp->efuse[6] >> 8) & GENMASK(7, 0);
> +                       svsb->dcbdet = (svsp->efuse[6] >> 16) & GENMASK(7, 0);
> +                       svsb->dcmdet = (svsp->efuse[6] >> 24) & GENMASK(7, 0);
> +                       svsb->mtdes  = svsp->efuse[5] & GENMASK(7, 0);
> +
> +                       if (ft_pgm >= 2) {
> +                               svsb->freq_base = 800000000; /* 800MHz */
> +                               svsb->dvt_fixed = 2;
> +                       }
> +                       break;
> +               default:
> +                       break;
> +               }
> +       }
> +
> +       /* Get thermal efuse by nvmem */
> +       cell = nvmem_cell_get(svsp->dev, "t-calibration-data");
> +       if (IS_ERR_OR_NULL(cell)) {
> +               dev_err(svsp->dev, "no thermal cell, no mon mode\n");
> +               for (idx = 0; idx < svsp->bank_num; idx++) {
> +                       svsb = &svsp->banks[idx];
> +                       svsb->mode_support &= ~SVSB_MODE_MON;
> +               }
> +
> +               return true;
> +       }
> +
> +       svsp->tefuse = (u32 *)nvmem_cell_read(cell, &svsp->tefuse_num);

Cast not needed.

Also, this need to be freed somewhere in remove code (kfree(svsp->tefuse)).

And it seems like svsp->tefuse is only used in this function, can you
just allocate it here?

> +       svsp->tefuse_num /= sizeof(u32);
> +       nvmem_cell_put(cell);
> +
> +       if (svsp->fake_efuse) {
> +               svsp->tefuse[0] = 0x02873f69;
> +               svsp->tefuse[1] = 0xa11d9142;
> +               svsp->tefuse[2] = 0xa2526900;
> +       }
> +
> +       /* Thermal efuse parsing */
> +       tp.adc_ge_t = (svsp->tefuse[1] >> 22) & GENMASK(9, 0);
> +       tp.adc_oe_t = (svsp->tefuse[1] >> 12) & GENMASK(9, 0);
> +
> +       tp.o_vtsmcu1 = (svsp->tefuse[0] >> 17) & GENMASK(8, 0);
> +       tp.o_vtsmcu2 = (svsp->tefuse[0] >> 8) & GENMASK(8, 0);
> +       tp.o_vtsmcu3 = svsp->tefuse[1] & GENMASK(8, 0);
> +       tp.o_vtsmcu4 = (svsp->tefuse[2] >> 23) & GENMASK(8, 0);
> +       tp.o_vtsmcu5 = (svsp->tefuse[2] >> 5) & GENMASK(8, 0);
> +       tp.o_vtsabb = (svsp->tefuse[2] >> 14) & GENMASK(8, 0);
> +
> +       tp.degc_cali = (svsp->tefuse[0] >> 1) & GENMASK(5, 0);
> +       tp.adc_cali_en_t = svsp->tefuse[0] & BIT(0);
> +       tp.o_slope_sign = (svsp->tefuse[0] >> 7) & BIT(0);
> +
> +       tp.ts_id = (svsp->tefuse[1] >> 9) & BIT(0);
> +       tp.o_slope = (svsp->tefuse[0] >> 26) & GENMASK(5, 0);
> +
> +       if (tp.adc_cali_en_t == 1) {
> +               if (!tp.ts_id)
> +                       tp.o_slope = 0;
> +
> +               if ((tp.adc_ge_t < 265 || tp.adc_ge_t > 758) ||
> +                   (tp.adc_oe_t < 265 || tp.adc_oe_t > 758) ||
> +                   (tp.o_vtsmcu1 < -8 || tp.o_vtsmcu1 > 484) ||
> +                   (tp.o_vtsmcu2 < -8 || tp.o_vtsmcu2 > 484) ||
> +                   (tp.o_vtsmcu3 < -8 || tp.o_vtsmcu3 > 484) ||
> +                   (tp.o_vtsmcu4 < -8 || tp.o_vtsmcu4 > 484) ||
> +                   (tp.o_vtsmcu5 < -8 || tp.o_vtsmcu5 > 484) ||
> +                   (tp.o_vtsabb < -8 || tp.o_vtsabb > 484) ||
> +                   (tp.degc_cali < 1 || tp.degc_cali > 63)) {
> +                       dev_err(svsp->dev, "bad thermal efuse, no mon mode\n");
> +                       mon_mode_support = false;
> +               }
> +       } else {
> +               dev_err(svsp->dev, "no thermal efuse, no mon mode\n");
> +               mon_mode_support = false;
> +       }
> +
> +       if (!mon_mode_support) {
> +               for (idx = 0; idx < svsp->bank_num; idx++) {
> +                       svsb = &svsp->banks[idx];
> +                       svsb->mode_support &= ~SVSB_MODE_MON;
> +               }
> +
> +               return true;
> +       }
> +
> +       tp.ge = ((tp.adc_ge_t - 512) * 10000) / 4096;
> +       tp.oe = (tp.adc_oe_t - 512);
> +       tp.gain = (10000 + tp.ge);
> +
> +       format[0] = (tp.o_vtsmcu1 + 3350 - tp.oe);
> +       format[1] = (tp.o_vtsmcu2 + 3350 - tp.oe);
> +       format[2] = (tp.o_vtsmcu3 + 3350 - tp.oe);
> +       format[3] = (tp.o_vtsmcu4 + 3350 - tp.oe);
> +       format[4] = (tp.o_vtsmcu5 + 3350 - tp.oe);
> +       format[5] = (tp.o_vtsabb + 3350 - tp.oe);
> +
> +       for (i = 0; i < 6; i++)
> +               x_roomt[i] = (((format[i] * 10000) / 4096) * 10000) / tp.gain;
> +
> +       temp0 = (10000 * 100000 / tp.gain) * 15 / 18;
> +
> +       if (!tp.o_slope_sign)
> +               mts = (temp0 * 10) / (1534 + tp.o_slope * 10);
> +       else
> +               mts = (temp0 * 10) / (1534 - tp.o_slope * 10);
> +
> +       for (idx = 0; idx < svsp->bank_num; idx++) {
> +               svsb = &svsp->banks[idx];
> +               svsb->mts = mts;
> +
> +               switch (svsb->sw_id) {
> +               case SVSB_CPU_LITTLE:
> +                       tb_roomt = x_roomt[3];
> +                       break;
> +               case SVSB_CPU_BIG:
> +                       tb_roomt = x_roomt[4];
> +                       break;
> +               case SVSB_CCI:
> +                       tb_roomt = x_roomt[3];
> +                       break;
> +               case SVSB_GPU:
> +                       tb_roomt = x_roomt[1];
> +                       break;
> +               default:
> +                       break;
> +               }
> +
> +               temp0 = (tp.degc_cali * 10 / 2);
> +               temp1 = ((10000 * 100000 / 4096 / tp.gain) *
> +                        tp.oe + tb_roomt * 10) * 15 / 18;
> +
> +               if (!tp.o_slope_sign)
> +                       temp2 = temp1 * 100 / (1534 + tp.o_slope * 10);
> +               else
> +                       temp2 = temp1 * 100 / (1534 - tp.o_slope * 10);
> +
> +               svsb->bts = (temp0 + temp2 - 250) * 4 / 10;
> +       }
> +
> +       return true;
> +}
> +
> +static bool svs_is_supported(struct svs_platform *svsp)
> +{
> +       struct nvmem_cell *cell;
> +
> +       /* Get svs efuse by nvmem */
> +       cell = nvmem_cell_get(svsp->dev, "svs-calibration-data");
> +       if (IS_ERR_OR_NULL(cell)) {
> +               dev_err(svsp->dev,
> +                       "no \"svs-calibration-data\" from dts? disable svs\n");
> +               return false;
> +       }
> +
> +       svsp->efuse = (u32 *)nvmem_cell_read(cell, &svsp->efuse_num);

Similar to tefuse, I think efuse is only used at init time, so maybe
it ca be a local variable?

> +       svsp->efuse_num /= sizeof(u32);
> +       nvmem_cell_put(cell);
> +
> +       if (!svsp->fake_efuse && !svsp->efuse[svsp->efuse_check]) {
> +               dev_err(svsp->dev, "svs_efuse[%u] = 0x%x?\n",
> +                       svsp->efuse_check, svsp->efuse[svsp->efuse_check]);
> +               return false;
> +       }
> +
> +       return svsp->efuse_parsing(svsp);
> +}
> +
> +static int svs_suspend(struct device *dev)
> +{
> +       struct svs_platform *svsp = dev_get_drvdata(dev);
> +       struct svs_bank *svsb;
> +       unsigned long flags;
> +       int ret;
> +       u32 idx;
> +
> +       for (idx = 0; idx < svsp->bank_num; idx++) {
> +               svsb = &svsp->banks[idx];
> +
> +               /* Wait if svs_isr() is still in process. */
> +               spin_lock_irqsave(&mtk_svs_lock, flags);
> +               svsp->pbank = svsb;
> +               svs_switch_bank(svsp);
> +               svs_writel(svsp, SVSB_EN_OFF, SVSEN);
> +               svs_writel(svsp, SVSB_INTSTS_CLEAN, INTSTS);
> +               spin_unlock_irqrestore(&mtk_svs_lock, flags);
> +
> +               svsb->suspended = true;
> +               if (svsb->phase != SVSB_PHASE_INIT01) {
> +                       svsb->phase = SVSB_PHASE_ERROR;
> +                       svs_adjust_pm_opp_volts(svsb, true);
> +               }
> +       }
> +
> +       if (svsp->rst) {
> +               ret = reset_control_assert(svsp->rst);
> +               if (ret) {
> +                       dev_err(svsp->dev, "cannot assert reset %d\n", ret);
> +                       return ret;
> +               }
> +       }
> +
> +       clk_disable_unprepare(svsp->main_clk);
> +
> +       return 0;
> +}
> +
> +static int svs_resume(struct device *dev)
> +{
> +       struct svs_platform *svsp = dev_get_drvdata(dev);
> +       struct svs_bank *svsb;
> +       int ret;
> +       u32 idx;
> +
> +       ret = clk_prepare_enable(svsp->main_clk);
> +       if (ret) {
> +               dev_err(svsp->dev, "cannot enable main_clk, disable svs\n");
> +               return ret;
> +       }
> +
> +       if (svsp->rst) {
> +               ret = reset_control_deassert(svsp->rst);
> +               if (ret) {
> +                       dev_err(svsp->dev, "cannot deassert reset %d\n", ret);
> +                       return ret;
> +               }
> +       }
> +
> +       for (idx = 0; idx < svsp->bank_num; idx++) {
> +               svsb = &svsp->banks[idx];
> +               svsb->suspended = false;
> +       }
> +
> +       ret = svs_init02(svsp);
> +       if (ret)
> +               return ret;
> +
> +       svs_mon_mode(svsp);
> +
> +       return 0;
> +}
> +
> +static struct svs_bank svs_mt8183_banks[4] = {
> +       {
> +               .sw_id                  = SVSB_CPU_LITTLE,
> +               .cpu_id                 = 0,
> +               .tzone_name             = "tzts4",
> +               .buck_name              = "proc",
> +               .pd_req                 = false,
> +               .init01_volt_flag       = SVSB_INIT01_VOLT_INC_ONLY,
> +               .mode_support           = SVSB_MODE_INIT01 | SVSB_MODE_INIT02,
> +               .opp_count              = 16,
> +               .freq_base              = 1989000000,
> +               .vboot                  = 0x30,
> +               .volt_step              = 6250,
> +               .volt_base              = 500000,
> +               .volt_offset            = 0,
> +               .vmax                   = 0x64,
> +               .vmin                   = 0x18,
> +               .dthi                   = 0x1,
> +               .dtlo                   = 0xfe,
> +               .det_window             = 0xa28,
> +               .det_max                = 0xffff,
> +               .age_config             = 0x555555,
> +               .agem                   = 0,
> +               .dc_config              = 0x555555,
> +               .dvt_fixed              = 0x7,
> +               .vco                    = 0x10,
> +               .chk_shift              = 0x77,
> +               .temp_upper_bound       = 0x64,
> +               .temp_lower_bound       = 0xb2,
> +               .tzone_high_temp        = SVSB_TZONE_HIGH_TEMP_MAX,
> +               .tzone_low_temp         = 25000,
> +               .tzone_low_temp_offset  = 0,
> +               .core_sel               = 0x8fff0000,
> +               .int_st                 = BIT(0),
> +               .ctl0                   = 0x00010001,
> +       },
> +       {
> +               .sw_id                  = SVSB_CPU_BIG,
> +               .cpu_id                 = 4,
> +               .tzone_name             = "tzts5",
> +               .buck_name              = "proc",
> +               .pd_req                 = false,
> +               .init01_volt_flag       = SVSB_INIT01_VOLT_INC_ONLY,
> +               .mode_support           = SVSB_MODE_INIT01 | SVSB_MODE_INIT02,
> +               .opp_count              = 16,
> +               .freq_base              = 1989000000,
> +               .vboot                  = 0x30,
> +               .volt_step              = 6250,
> +               .volt_base              = 500000,
> +               .volt_offset            = 0,
> +               .vmax                   = 0x58,
> +               .vmin                   = 0x10,
> +               .dthi                   = 0x1,
> +               .dtlo                   = 0xfe,
> +               .det_window             = 0xa28,
> +               .det_max                = 0xffff,
> +               .age_config             = 0x555555,
> +               .agem                   = 0,
> +               .dc_config              = 0x555555,
> +               .dvt_fixed              = 0x7,
> +               .vco                    = 0x10,
> +               .chk_shift              = 0x77,
> +               .temp_upper_bound       = 0x64,
> +               .temp_lower_bound       = 0xb2,
> +               .tzone_high_temp        = SVSB_TZONE_HIGH_TEMP_MAX,
> +               .tzone_low_temp         = 25000,
> +               .tzone_low_temp_offset  = 0,
> +               .core_sel               = 0x8fff0001,
> +               .int_st                 = BIT(1),
> +               .ctl0                   = 0x00000001,
> +       },
> +       {
> +               .sw_id                  = SVSB_CCI,
> +               .tzone_name             = "tzts4",
> +               .buck_name              = "proc",
> +               .pd_req                 = false,
> +               .init01_volt_flag       = SVSB_INIT01_VOLT_INC_ONLY,
> +               .mode_support           = SVSB_MODE_INIT01 | SVSB_MODE_INIT02,
> +               .opp_count              = 16,
> +               .freq_base              = 1196000000,
> +               .vboot                  = 0x30,
> +               .volt_step              = 6250,
> +               .volt_base              = 500000,
> +               .volt_offset            = 0,
> +               .vmax                   = 0x64,
> +               .vmin                   = 0x18,
> +               .dthi                   = 0x1,
> +               .dtlo                   = 0xfe,
> +               .det_window             = 0xa28,
> +               .det_max                = 0xffff,
> +               .age_config             = 0x555555,
> +               .agem                   = 0,
> +               .dc_config              = 0x555555,
> +               .dvt_fixed              = 0x7,
> +               .vco                    = 0x10,
> +               .chk_shift              = 0x77,
> +               .temp_upper_bound       = 0x64,
> +               .temp_lower_bound       = 0xb2,
> +               .tzone_high_temp        = SVSB_TZONE_HIGH_TEMP_MAX,
> +               .tzone_low_temp         = 25000,
> +               .tzone_low_temp_offset  = 0,
> +               .core_sel               = 0x8fff0002,
> +               .int_st                 = BIT(2),
> +               .ctl0                   = 0x00100003,
> +       },
> +       {
> +               .sw_id                  = SVSB_GPU,
> +               .tzone_name             = "tzts2",
> +               .buck_name              = "mali",
> +               .pd_req                 = true,
> +               .init01_volt_flag       = SVSB_INIT01_VOLT_INC_ONLY,
> +               .mode_support           = SVSB_MODE_INIT01 | SVSB_MODE_INIT02 |
> +                                         SVSB_MODE_MON,
> +               .opp_count              = 16,
> +               .freq_base              = 900000000,
> +               .vboot                  = 0x30,
> +               .volt_step              = 6250,
> +               .volt_base              = 500000,
> +               .volt_offset            = 0,
> +               .vmax                   = 0x40,
> +               .vmin                   = 0x14,
> +               .dthi                   = 0x1,
> +               .dtlo                   = 0xfe,
> +               .det_window             = 0xa28,
> +               .det_max                = 0xffff,
> +               .age_config             = 0x555555,
> +               .agem                   = 0,
> +               .dc_config              = 0x555555,
> +               .dvt_fixed              = 0x3,
> +               .vco                    = 0x10,
> +               .chk_shift              = 0x77,
> +               .temp_upper_bound       = 0x64,
> +               .temp_lower_bound       = 0xb2,
> +               .tzone_high_temp        = SVSB_TZONE_HIGH_TEMP_MAX,
> +               .tzone_low_temp         = 25000,
> +               .tzone_low_temp_offset  = 3,
> +               .core_sel               = 0x8fff0003,
> +               .int_st                 = BIT(3),
> +               .ctl0                   = 0x00050001,
> +       },
> +};
> +
> +static int svs_get_svs_mt8183_platform_data(struct svs_platform *svsp)
> +{
> +       struct device *dev;
> +       struct svs_bank *svsb;
> +       u32 idx;
> +
> +       svsp->name = "mt8183-svs";
> +       svsp->banks = svs_mt8183_banks;
> +       svsp->efuse_parsing = svs_mt8183_efuse_parsing;
> +       svsp->set_freqs_pct = svs_set_freqs_pct_v2;
> +       svsp->get_vops = svs_get_vops_v2;
> +       svsp->regs = svs_regs_v2;
> +       svsp->irqflags = IRQF_TRIGGER_LOW | IRQF_ONESHOT;
> +       svsp->rst = NULL;
> +       svsp->fake_efuse = false;
> +       svsp->bank_num = 4;
> +       svsp->efuse_check = 2;
> +
> +       dev = svs_add_device_link(svsp, "thermal");
> +       if (IS_ERR(dev))
> +               return PTR_ERR(dev);
> +
> +       for (idx = 0; idx < svsp->bank_num; idx++) {
> +               svsb = &svsp->banks[idx];
> +
> +               switch (svsb->sw_id) {
> +               case SVSB_CPU_LITTLE:
> +               case SVSB_CPU_BIG:
> +                       svsb->opp_dev = get_cpu_device(svsb->cpu_id);
> +                       break;
> +               case SVSB_CCI:
> +                       svsb->opp_dev = svs_add_device_link(svsp, "cci");
> +                       break;
> +               case SVSB_GPU:
> +                       svsb->opp_dev = svs_add_device_link(svsp, "mali");
> +                       svsb->pd_dev = svs_add_device_link(svsp,
> +                                                          "mali_gpu_core2");
> +                       if (IS_ERR(svsb->pd_dev))
> +                               return PTR_ERR(svsb->pd_dev);
> +                       break;
> +               default:
> +                       WARN_ON(1);
> +                       return -EINVAL;
> +               }
> +
> +               if (IS_ERR(svsb->opp_dev))
> +                       return PTR_ERR(svsb->opp_dev);
> +       }
> +
> +       return 0;
> +}
> +
> +static const struct of_device_id mtk_svs_of_match[] = {
> +       {
> +               .compatible = "mediatek,mt8183-svs",
> +               .data = &svs_get_svs_mt8183_platform_data,
> +       }, {
> +               /* Sentinel */
> +       },
> +};
> +
> +static int svs_probe(struct platform_device *pdev)
> +{
> +       int (*svs_get_svs_platform_data)(struct svs_platform *svsp);
> +       struct svs_platform *svsp;
> +       unsigned int svsp_irq;
> +       int ret;
> +
> +       svsp = devm_kzalloc(&pdev->dev, sizeof(*svsp), GFP_KERNEL);
> +       if (!svsp)
> +               return -ENOMEM;
> +
> +       svs_get_svs_platform_data = of_device_get_match_data(&pdev->dev);
> +       if (!svs_get_svs_platform_data) {
> +               dev_err(svsp->dev, "no svs platform data? why?\n");
> +               return -EPERM;
> +       }
> +
> +       svsp->dev = &pdev->dev;
> +       ret = svs_get_svs_platform_data(svsp);
> +       if (ret) {
> +               dev_err_probe(svsp->dev, ret, "fail to get svsp data\n");
> +               return ret;
> +       }
> +
> +       if (!svs_is_supported(svsp)) {
> +               dev_notice(svsp->dev, "svs is not supported\n");
> +               return -EPERM;
> +       }
> +
> +       ret = svs_resource_setup(svsp);
> +       if (ret) {
> +               dev_err(svsp->dev, "svs resource setup fail: %d\n", ret);
> +               return ret;
> +       }
> +
> +       svsp_irq = irq_of_parse_and_map(svsp->dev->of_node, 0);
> +       ret = devm_request_threaded_irq(svsp->dev, svsp_irq, NULL, svs_isr,
> +                                       svsp->irqflags, svsp->name, svsp);
> +       if (ret) {
> +               dev_err(svsp->dev, "register irq(%d) failed: %d\n",
> +                       svsp_irq, ret);
> +               return ret;
> +       }
> +
> +       svsp->main_clk = devm_clk_get(svsp->dev, "main");
> +       if (IS_ERR(svsp->main_clk)) {
> +               dev_err(svsp->dev, "failed to get clock: %ld\n",
> +                       PTR_ERR(svsp->main_clk));
> +               return PTR_ERR(svsp->main_clk);
> +       }
> +
> +       ret = clk_prepare_enable(svsp->main_clk);
> +       if (ret) {
> +               dev_err(svsp->dev, "cannot enable main clk: %d\n", ret);
> +               return ret;
> +       }
> +
> +       svsp->base = of_iomap(svsp->dev->of_node, 0);
> +       if (IS_ERR_OR_NULL(svsp->base)) {
> +               dev_err(svsp->dev, "cannot find svs register base\n");
> +               ret = -EINVAL;
> +               goto svs_probe_clk_disable;
> +       }
> +
> +       ret = svs_start(svsp);
> +       if (ret) {
> +               dev_err(svsp->dev, "svs start fail: %d\n", ret);
> +               goto svs_probe_iounmap;
> +       }
> +
> +       return 0;
> +
> +svs_probe_iounmap:
> +       iounmap(svsp->base);
> +
> +svs_probe_clk_disable:
> +       clk_disable_unprepare(svsp->main_clk);
> +
> +       return ret;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(svs_pm_ops, svs_suspend, svs_resume);
> +
> +static struct platform_driver svs_driver = {
> +       .probe  = svs_probe,
> +       .driver = {
> +               .name           = "mtk-svs",
> +               .pm             = &svs_pm_ops,
> +               .of_match_table = of_match_ptr(mtk_svs_of_match),
> +       },
> +};
> +
> +module_platform_driver(svs_driver);
> +
> +MODULE_AUTHOR("Roger Lu <roger.lu@mediatek.com>");
> +MODULE_DESCRIPTION("MediaTek SVS driver");
> +MODULE_LICENSE("GPL v2");
> --
> 2.18.0
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A752A913D6
	for <lists+linux-pm@lfdr.de>; Sun, 18 Aug 2019 03:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbfHRBEU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 17 Aug 2019 21:04:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:42804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726208AbfHRBEU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 17 Aug 2019 21:04:20 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A100F21019;
        Sun, 18 Aug 2019 01:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566090255;
        bh=crBdsEARSPldkAvJX9b0WienJkCly05l4WP24t4o1n4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Z4A3wxshlwud3bdAT1NJ3c4XUYX7roDkQilRQQW1yVunpLUygT8oUnDkhGNAzaWDq
         6SZ5GXw6Jb8CDgMSOiTla9PdRm1OjAcOenFMo6P5yLU3251LgoIJv5o+EmenaczBfh
         liwExh3pqzo8lReDFh87lTDJXNm3K1UC1AW5qVvg=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190725104144.22924-12-niklas.cassel@linaro.org>
References: <20190725104144.22924-1-niklas.cassel@linaro.org> <20190725104144.22924-12-niklas.cassel@linaro.org>
Subject: Re: [PATCH v2 11/14] power: avs: Add support for CPR (Core Power Reduction)
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, vireshk@kernel.org,
        bjorn.andersson@linaro.org, ulf.hansson@linaro.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
To:     Andy Gross <agross@kernel.org>,
        Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Nishanth Menon <nm@ti.com>
User-Agent: alot/0.8.1
Date:   Sat, 17 Aug 2019 18:04:14 -0700
Message-Id: <20190818010415.A100F21019@mail.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Niklas Cassel (2019-07-25 03:41:39)
> diff --git a/drivers/power/avs/Kconfig b/drivers/power/avs/Kconfig
> index b5a217b828dc..4d4d742b3c6f 100644
> --- a/drivers/power/avs/Kconfig
> +++ b/drivers/power/avs/Kconfig
> @@ -12,6 +12,21 @@ menuconfig POWER_AVS
> =20
>           Say Y here to enable Adaptive Voltage Scaling class support.
> =20
> +config QCOM_CPR
> +       tristate "QCOM Core Power Reduction (CPR) support"
> +       depends on POWER_AVS
> +       select PM_OPP
> +       help
> +         Say Y here to enable support for the CPR hardware found on Qual=
comm
> +         SoCs like MSM8916.

Maybe mention qcs404 too, because it looks like 8916 isn't actually here
:)

> +
> +         This driver populates CPU OPPs tables and makes adjustments to =
the
> +         tables based on feedback from the CPR hardware. If you want to =
do
> +         CPUfrequency scaling say Y here.
> +
> +         To compile this driver as a module, choose M here: the module w=
ill
> +         be called qcom-cpr
> +
>  config ROCKCHIP_IODOMAIN
>          tristate "Rockchip IO domain support"
>          depends on POWER_AVS && ARCH_ROCKCHIP && OF
> diff --git a/drivers/power/avs/Makefile b/drivers/power/avs/Makefile
> index a1b8cd453f19..8cd17e6660ee 100644
> --- a/drivers/power/avs/Makefile
> +++ b/drivers/power/avs/Makefile
> @@ -1,3 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  obj-$(CONFIG_POWER_AVS_OMAP)           +=3D smartreflex.o
>  obj-$(CONFIG_ROCKCHIP_IODOMAIN)                +=3D rockchip-io-domain.o
> +obj-$(CONFIG_QCOM_CPR)                 +=3D qcom-cpr.o

Try to make this alphabetical on config name?

> diff --git a/drivers/power/avs/qcom-cpr.c b/drivers/power/avs/qcom-cpr.c
> new file mode 100644
> index 000000000000..d6bce2832589
> --- /dev/null
> +++ b/drivers/power/avs/qcom-cpr.c
> @@ -0,0 +1,1885 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2013-2015, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2019, Linaro Limited
> + */
> +
> +#include <linux/module.h>
> +#include <linux/err.h>
> +#include <linux/debugfs.h>
> +#include <linux/string.h>
> +#include <linux/kernel.h>
> +#include <linux/list.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/bitops.h>
> +#include <linux/slab.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_domain.h>
> +#include <linux/pm_opp.h>
> +#include <linux/interrupt.h>
> +#include <linux/regmap.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/clk.h>
> +#include <linux/nvmem-consumer.h>
> +#include <linux/bitops.h>
> +
> +/* Register Offsets for RB-CPR and Bit Definitions */
> +
> +/* RBCPR Version Register */
> +#define REG_RBCPR_VERSION              0
> +#define RBCPR_VER_2                    0x02
> +#define FLAGS_IGNORE_1ST_IRQ_STATUS    BIT(0)
> +
> +/* RBCPR Gate Count and Target Registers */
> +#define REG_RBCPR_GCNT_TARGET(n)       (0x60 + 4 * (n))
> +
> +#define RBCPR_GCNT_TARGET_TARGET_SHIFT 0
> +#define RBCPR_GCNT_TARGET_TARGET_MASK  GENMASK(11, 0)
> +#define RBCPR_GCNT_TARGET_GCNT_SHIFT   12
> +#define RBCPR_GCNT_TARGET_GCNT_MASK    GENMASK(9, 0)
> +
> +/* RBCPR Timer Control */
> +#define REG_RBCPR_TIMER_INTERVAL       0x44
> +#define REG_RBIF_TIMER_ADJUST          0x4c
> +
> +#define RBIF_TIMER_ADJ_CONS_UP_MASK    GENMASK(3, 0)
> +#define RBIF_TIMER_ADJ_CONS_UP_SHIFT   0
> +#define RBIF_TIMER_ADJ_CONS_DOWN_MASK  GENMASK(3, 0)
> +#define RBIF_TIMER_ADJ_CONS_DOWN_SHIFT 4
> +#define RBIF_TIMER_ADJ_CLAMP_INT_MASK  GENMASK(7, 0)
> +#define RBIF_TIMER_ADJ_CLAMP_INT_SHIFT 8
> +
> +/* RBCPR Config Register */
> +#define REG_RBIF_LIMIT                 0x48
> +#define RBIF_LIMIT_CEILING_MASK                GENMASK(5, 0)
> +#define RBIF_LIMIT_CEILING_SHIFT       6
> +#define RBIF_LIMIT_FLOOR_BITS          6
> +#define RBIF_LIMIT_FLOOR_MASK          GENMASK(5, 0)
> +
> +#define RBIF_LIMIT_CEILING_DEFAULT     RBIF_LIMIT_CEILING_MASK
> +#define RBIF_LIMIT_FLOOR_DEFAULT       0
> +
> +#define REG_RBIF_SW_VLEVEL             0x94
> +#define RBIF_SW_VLEVEL_DEFAULT         0x20
> +
> +#define REG_RBCPR_STEP_QUOT            0x80
> +#define RBCPR_STEP_QUOT_STEPQUOT_MASK  GENMASK(7, 0)
> +#define RBCPR_STEP_QUOT_IDLE_CLK_MASK  GENMASK(3, 0)
> +#define RBCPR_STEP_QUOT_IDLE_CLK_SHIFT 8
> +
> +/* RBCPR Control Register */
> +#define REG_RBCPR_CTL                  0x90
> +
> +#define RBCPR_CTL_LOOP_EN                      BIT(0)
> +#define RBCPR_CTL_TIMER_EN                     BIT(3)
> +#define RBCPR_CTL_SW_AUTO_CONT_ACK_EN          BIT(5)
> +#define RBCPR_CTL_SW_AUTO_CONT_NACK_DN_EN      BIT(6)
> +#define RBCPR_CTL_COUNT_MODE                   BIT(10)
> +#define RBCPR_CTL_UP_THRESHOLD_MASK    GENMASK(3, 0)
> +#define RBCPR_CTL_UP_THRESHOLD_SHIFT   24
> +#define RBCPR_CTL_DN_THRESHOLD_MASK    GENMASK(3, 0)
> +#define RBCPR_CTL_DN_THRESHOLD_SHIFT   28
> +
> +/* RBCPR Ack/Nack Response */
> +#define REG_RBIF_CONT_ACK_CMD          0x98
> +#define REG_RBIF_CONT_NACK_CMD         0x9c
> +
> +/* RBCPR Result status Register */
> +#define REG_RBCPR_RESULT_0             0xa0
> +
> +#define RBCPR_RESULT0_BUSY_SHIFT       19
> +#define RBCPR_RESULT0_BUSY_MASK                BIT(RBCPR_RESULT0_BUSY_SH=
IFT)
> +#define RBCPR_RESULT0_ERROR_LT0_SHIFT  18
> +#define RBCPR_RESULT0_ERROR_SHIFT      6
> +#define RBCPR_RESULT0_ERROR_MASK       GENMASK(11, 0)
> +#define RBCPR_RESULT0_ERROR_STEPS_SHIFT        2
> +#define RBCPR_RESULT0_ERROR_STEPS_MASK GENMASK(3, 0)
> +#define RBCPR_RESULT0_STEP_UP_SHIFT    1
> +
> +/* RBCPR Interrupt Control Register */
> +#define REG_RBIF_IRQ_EN(n)             (0x100 + 4 * (n))
> +#define REG_RBIF_IRQ_CLEAR             0x110
> +#define REG_RBIF_IRQ_STATUS            0x114
> +
> +#define CPR_INT_DONE           BIT(0)
> +#define CPR_INT_MIN            BIT(1)
> +#define CPR_INT_DOWN           BIT(2)
> +#define CPR_INT_MID            BIT(3)
> +#define CPR_INT_UP             BIT(4)
> +#define CPR_INT_MAX            BIT(5)
> +#define CPR_INT_CLAMP          BIT(6)
> +#define CPR_INT_ALL    (CPR_INT_DONE | CPR_INT_MIN | CPR_INT_DOWN | \
> +                       CPR_INT_MID | CPR_INT_UP | CPR_INT_MAX | CPR_INT_=
CLAMP)
> +#define CPR_INT_DEFAULT        (CPR_INT_UP | CPR_INT_DOWN)
> +
> +#define CPR_NUM_RING_OSC       8
> +
> +/* CPR eFuse parameters */
> +#define CPR_FUSE_TARGET_QUOT_BITS_MASK GENMASK(11, 0)
> +
> +#define CPR_FUSE_MIN_QUOT_DIFF         50
> +
> +#define FUSE_REVISION_UNKNOWN          (-1)
> +
> +enum voltage_change_dir {
> +       NO_CHANGE,
> +       DOWN,
> +       UP,
> +};
> +
> +struct cpr_fuse {
> +       char *ring_osc;
> +       char *init_voltage;
> +       char *quotient;
> +       char *quotient_offset;
> +};
> +
> +struct fuse_corner_data {
> +       int ref_uV;
> +       int max_uV;
> +       int min_uV;
> +       int max_volt_scale;
> +       int max_quot_scale;
> +       /* fuse quot */
> +       int quot_offset;
> +       int quot_scale;
> +       int quot_adjust;
> +       /* fuse quot_offset */
> +       int quot_offset_scale;
> +       int quot_offset_adjust;
> +};
> +
> +struct cpr_fuses {
> +       int init_voltage_step;
> +       int init_voltage_width;
> +       struct fuse_corner_data *fuse_corner_data;
> +};
> +
> +struct pvs_bin {

Why does this struct exist?

> +       int *uV;
> +};
> +
> +struct pvs_fuses {
> +       char **pvs_fuse;
> +       struct pvs_bin *pvs_bins;

This can be int **pvs_bins?

> +};
> +
> +struct corner_data {
> +       unsigned int fuse_corner;
> +       unsigned long freq;
> +};
> +
> +struct cpr_desc {
> +       unsigned int num_fuse_corners;
> +       int min_diff_quot;
> +       int *step_quot;
> +       struct cpr_fuses cpr_fuses;
> +       struct pvs_fuses *pvs_fuses;
> +       bool reduce_to_fuse_uV;
> +       bool reduce_to_corner_uV;
> +};
> +
> +struct acc_desc {
> +       unsigned int    enable_reg;
> +       u32             enable_mask;
> +
> +       struct reg_sequence     *config;
> +       struct reg_sequence     *settings;
> +       int                     num_regs_per_fuse;
> +};
> +
> +struct cpr_acc_desc {
> +       const struct cpr_desc *cpr_desc;
> +       const struct acc_desc *acc_desc;
> +};
> +
> +struct fuse_corner {
> +       int min_uV;
> +       int max_uV;
> +       int uV;
> +       int quot;
> +       int step_quot;
> +       const struct reg_sequence *accs;
> +       int num_accs;
> +       unsigned long max_freq;
> +       u32 ring_osc_idx;

Can this be a u8?

> +};
> +
> +struct corner {
> +       int min_uV;
> +       int max_uV;
> +       int uV;
> +       int last_uV;
> +       int quot_adjust;
> +       u32 save_ctl;
> +       u32 save_irq;
> +       unsigned long freq;
> +       struct fuse_corner *fuse_corner;
> +};
> +
> +struct cpr_drv {
> +       unsigned int            num_corners;
> +
> +       unsigned int            ref_clk_khz;
> +       unsigned int            timer_delay_us;
> +       unsigned int            timer_cons_up;
> +       unsigned int            timer_cons_down;
> +       unsigned int            up_threshold;
> +       unsigned int            down_threshold;
> +       unsigned int            idle_clocks;
> +       unsigned int            gcnt_us;
> +       unsigned int            vdd_apc_step_up_limit;
> +       unsigned int            vdd_apc_step_down_limit;
> +       unsigned int            clamp_timer_interval;
> +       unsigned int            performance_state;
> +
> +       struct generic_pm_domain pd;
> +       struct device           *dev;
> +       struct mutex            lock;
> +       void __iomem            *base;
> +       struct corner           *corner;
> +       struct regulator        *vdd_apc;
> +       struct clk              *cpu_clk;
> +       struct regmap           *tcsr;
> +       bool                    loop_disabled;
> +       bool                    suspended;
> +       u32                     gcnt;
> +       unsigned long           flags;
> +
> +       struct fuse_corner      *fuse_corners;
> +       struct corner           *corners;
> +
> +       const struct cpr_desc *desc;
> +       const struct acc_desc *acc_desc;
> +       const struct cpr_fuse *cpr_fuses;
> +
> +       struct dentry *debugfs;
> +};
> +
> +static bool cpr_is_allowed(struct cpr_drv *drv)
> +{
> +       if (drv->loop_disabled)
> +               return false;
> +       else
> +               return true;

Simplify to return !drv->loop_disabled

> +}
> +
> +static void cpr_write(struct cpr_drv *drv, u32 offset, u32 value)
> +{
> +       writel_relaxed(value, drv->base + offset);
> +}
> +
[...]
> +
> +static void cpr_corner_restore(struct cpr_drv *drv, struct corner *corne=
r)
> +{
> +       u32 gcnt, ctl, irq, ro_sel, step_quot;
> +       struct fuse_corner *fuse =3D corner->fuse_corner;
> +       int i;
> +
> +       ro_sel =3D fuse->ring_osc_idx;
> +       gcnt =3D drv->gcnt;
> +       gcnt |=3D fuse->quot - corner->quot_adjust;
> +
> +       /* Program the step quotient and idle clocks */
> +       step_quot =3D drv->idle_clocks << RBCPR_STEP_QUOT_IDLE_CLK_SHIFT;
> +       step_quot |=3D fuse->step_quot & RBCPR_STEP_QUOT_STEPQUOT_MASK;
> +       cpr_write(drv, REG_RBCPR_STEP_QUOT, step_quot);
> +
> +       /* Clear the target quotient value and gate count of all ROs */
> +       for (i =3D 0; i < CPR_NUM_RING_OSC; i++)
> +               cpr_write(drv, REG_RBCPR_GCNT_TARGET(i), 0);
> +
> +       cpr_write(drv, REG_RBCPR_GCNT_TARGET(ro_sel), gcnt);
> +       ctl =3D corner->save_ctl;
> +       cpr_write(drv, REG_RBCPR_CTL, ctl);
> +       irq =3D corner->save_irq;
> +       cpr_irq_set(drv, irq);
> +       dev_dbg(drv->dev, "gcnt =3D 0x%08x, ctl =3D 0x%08x, irq =3D 0x%08=
x\n", gcnt,

Use %#08x to get the 0x part?

> +               ctl, irq);
> +}
> +
> +static void cpr_set_acc(struct regmap *tcsr, struct fuse_corner *f,
> +                       struct fuse_corner *end)
> +{
> +       if (f < end) {
> +               for (f +=3D 1; f <=3D end; f++)
> +                       regmap_multi_reg_write(tcsr, f->accs, f->num_accs=
);
> +       } else {
> +               for (f -=3D 1; f >=3D end; f--)
> +                       regmap_multi_reg_write(tcsr, f->accs, f->num_accs=
);
> +       }
> +}
> +
> +static int cpr_pre_voltage(struct cpr_drv *drv,
> +                          struct fuse_corner *fuse_corner,
> +                          enum voltage_change_dir dir)
> +{
> +       int ret =3D 0;
> +       struct fuse_corner *prev_fuse_corner =3D drv->corner->fuse_corner;
> +
> +       if (drv->tcsr && dir =3D=3D DOWN)
> +               cpr_set_acc(drv->tcsr, prev_fuse_corner, fuse_corner);
> +
> +       return ret;
> +}
> +
> +static int cpr_post_voltage(struct cpr_drv *drv,
> +                           struct fuse_corner *fuse_corner,
> +                           enum voltage_change_dir dir)
> +{
> +       int ret =3D 0;

ret never changes in the above two functions. Remove it?

> +       struct fuse_corner *prev_fuse_corner =3D drv->corner->fuse_corner;
> +
> +       if (drv->tcsr && dir =3D=3D UP)
> +               cpr_set_acc(drv->tcsr, prev_fuse_corner, fuse_corner);
> +
> +       return ret;
> +}
> +
> +static int cpr_scale_voltage(struct cpr_drv *drv, struct corner *corner,
> +                            int new_uV, enum voltage_change_dir dir)
> +{
> +       int ret =3D 0;

Drop initial assignment to 0 because it's overwritten immediately below.

> +       struct fuse_corner *fuse_corner =3D corner->fuse_corner;
> +
> +       ret =3D cpr_pre_voltage(drv, fuse_corner, dir);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D regulator_set_voltage(drv->vdd_apc, new_uV, new_uV);
> +       if (ret) {
> +               dev_err_ratelimited(drv->dev, "failed to set apc voltage =
%d\n",
> +                                   new_uV);
> +               return ret;
> +       }
> +
> +       ret =3D cpr_post_voltage(drv, fuse_corner, dir);
> +       if (ret)
> +               return ret;
> +
> +       return 0;
> +}
> +
[...]
> +
> +static irqreturn_t cpr_irq_handler(int irq, void *dev)
> +{
> +       struct cpr_drv *drv =3D dev;
> +       u32 val;
> +
> +       mutex_lock(&drv->lock);
> +
> +       val =3D cpr_read(drv, REG_RBIF_IRQ_STATUS);
> +       if (drv->flags & FLAGS_IGNORE_1ST_IRQ_STATUS)
> +               val =3D cpr_read(drv, REG_RBIF_IRQ_STATUS);
> +
> +       dev_dbg(drv->dev, "IRQ_STATUS =3D %#02x\n", val);
> +
> +       if (!cpr_ctl_is_enabled(drv)) {
> +               dev_dbg(drv->dev, "CPR is disabled\n");

Shouldn't this return IRQ_NONE because it's spurious?

> +               goto unlock;
> +       } else if (cpr_ctl_is_busy(drv) && !drv->clamp_timer_interval) {
> +               dev_dbg(drv->dev, "CPR measurement is not ready\n");
> +               goto unlock;
> +       } else if (!cpr_is_allowed(drv)) {
> +               val =3D cpr_read(drv, REG_RBCPR_CTL);
> +               dev_err_ratelimited(drv->dev,
> +                                   "Interrupt broken? RBCPR_CTL =3D %#02=
x\n",
> +                                   val);

Same case, return IRQ_NONE?

> +               goto unlock;

Maybe the goto can be dropped and you can use an else here to fall into
the 'normal' processing modes. Everything would have to be indented
again, but it will probably look alright.

> +       }
> +
> +       /* Following sequence of handling is as per each IRQ's priority */
> +       if (val & CPR_INT_UP) {
> +               cpr_scale(drv, UP);
> +       } else if (val & CPR_INT_DOWN) {
> +               cpr_scale(drv, DOWN);
> +       } else if (val & CPR_INT_MIN) {
> +               cpr_irq_clr_nack(drv);
> +       } else if (val & CPR_INT_MAX) {
> +               cpr_irq_clr_nack(drv);
> +       } else if (val & CPR_INT_MID) {
> +               /* RBCPR_CTL_SW_AUTO_CONT_ACK_EN is enabled */
> +               dev_dbg(drv->dev, "IRQ occurred for Mid Flag\n");
> +       } else {
> +               dev_dbg(drv->dev, "IRQ occurred for unknown flag (%#08x)\=
n",
> +                       val);
> +       }
> +
> +       /* Save register values for the corner */
> +       cpr_corner_save(drv, drv->corner);
> +
> +unlock:
> +       mutex_unlock(&drv->lock);
> +
> +       return IRQ_HANDLED;
> +}
> +
> +static int cpr_enable(struct cpr_drv *drv)
> +{
> +       int ret;
> +
> +       ret =3D regulator_enable(drv->vdd_apc);
> +       if (ret)
> +               return ret;
> +
> +       mutex_lock(&drv->lock);
> +
> +       if (cpr_is_allowed(drv) && drv->corner) {
> +               cpr_irq_clr(drv);
> +               cpr_corner_restore(drv, drv->corner);
> +               cpr_ctl_enable(drv, drv->corner);
> +       }
> +       mutex_unlock(&drv->lock);
> +
> +       return 0;
> +}
> +
> +static int cpr_disable(struct cpr_drv *drv)
> +{
> +       int ret;
> +
> +       ret =3D regulator_disable(drv->vdd_apc);
> +       if (ret)
> +               return ret;
> +
> +       mutex_lock(&drv->lock);
> +
> +       if (cpr_is_allowed(drv))
> +               cpr_ctl_disable(drv);
> +       mutex_unlock(&drv->lock);

Seems weird to disable cpr in reverse order. Is that OK? Or should the
cpr monitoring be disabled first and then regulator is disabled? When is
the CPU's regulator disabled in relation to when it is hotplugged or
idle? I haven't followed the power domain stuff too closely.

> +
> +       return 0;
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int cpr_suspend(struct device *dev)
> +{
> +       struct cpr_drv *drv =3D platform_get_drvdata(to_platform_device(d=
ev));
> +
> +       if (cpr_is_allowed(drv)) {

Sometimes cpr_is_allowed() is tested inside the mutex and other times
not. Please be consistent.

> +               mutex_lock(&drv->lock);
> +               cpr_ctl_disable(drv);
> +               cpr_irq_clr(drv);
> +               drv->suspended =3D true;
> +               mutex_unlock(&drv->lock);
> +       }
> +
> +       return 0;
> +}
> +
> +static int cpr_resume(struct device *dev)
> +{
> +       struct cpr_drv *drv =3D platform_get_drvdata(to_platform_device(d=
ev));
> +
> +       if (cpr_is_allowed(drv)) {
> +               mutex_lock(&drv->lock);
> +               drv->suspended =3D false;
> +               cpr_irq_clr(drv);
> +               cpr_ctl_enable(drv, drv->corner);
> +               mutex_unlock(&drv->lock);
> +       }
> +
> +       return 0;
> +}
> +#endif
> +
> +static SIMPLE_DEV_PM_OPS(cpr_pm_ops, cpr_suspend, cpr_resume);
> +
> +static int cpr_config(struct cpr_drv *drv)
> +{
> +       int i;
> +       u32 val, gcnt;
> +       struct corner *corner;
> +
> +       /* Disable interrupt and CPR */
> +       cpr_write(drv, REG_RBIF_IRQ_EN(0), 0);
> +       cpr_write(drv, REG_RBCPR_CTL, 0);
> +
> +       /* Program the default HW Ceiling, Floor and vlevel */

Why capitalize ceiling and floor?

> +       val =3D (RBIF_LIMIT_CEILING_DEFAULT & RBIF_LIMIT_CEILING_MASK)
> +               << RBIF_LIMIT_CEILING_SHIFT;
> +       val |=3D RBIF_LIMIT_FLOOR_DEFAULT & RBIF_LIMIT_FLOOR_MASK;
> +       cpr_write(drv, REG_RBIF_LIMIT, val);
> +       cpr_write(drv, REG_RBIF_SW_VLEVEL, RBIF_SW_VLEVEL_DEFAULT);
> +
> +       /* Clear the target quotient value and gate count of all ROs */

RO =3D=3D ring oscillator? Maybe just write ring oscillator.

> +       for (i =3D 0; i < CPR_NUM_RING_OSC; i++)
> +               cpr_write(drv, REG_RBCPR_GCNT_TARGET(i), 0);
> +
> +       /* Init and save gcnt */
> +       gcnt =3D (drv->ref_clk_khz * drv->gcnt_us) / 1000;
> +       gcnt =3D gcnt & RBCPR_GCNT_TARGET_GCNT_MASK;
> +       gcnt <<=3D RBCPR_GCNT_TARGET_GCNT_SHIFT;
> +       drv->gcnt =3D gcnt;
> +
> +       /* Program the delay count for the timer */
> +       val =3D (drv->ref_clk_khz * drv->timer_delay_us) / 1000;
> +       cpr_write(drv, REG_RBCPR_TIMER_INTERVAL, val);
> +       dev_dbg(drv->dev, "Timer count: 0x%0x (for %d us)\n", val,
> +               drv->timer_delay_us);
> +
[...]
> +
> +static int cpr_read_efuse(struct device *dev, const char *cname, u32 *da=
ta)
> +{
> +       struct nvmem_cell *cell;
> +       ssize_t len;
> +       char *ret;
> +       int i;
> +
> +       if (!data) {

Looks like debug stuff, drop it?

> +               dev_err(dev, "invalid storage to read cell %s\n", cname);
> +               return -EINVAL;
> +       }
> +
> +       /* Optional cells will use their initialition values */

initialization?

> +       if (!cname)

Same?

> +               return 0;
> +
> +       *data =3D 0;
> +
> +       cell =3D nvmem_cell_get(dev, cname);
> +       if (IS_ERR(cell)) {
> +               if (PTR_ERR(cell) !=3D -EPROBE_DEFER)
> +                       dev_info(dev, "undefined cell %s\n", cname);

dev_err()?

> +               return PTR_ERR(cell);
> +       }
> +
> +       ret =3D nvmem_cell_read(cell, &len);
> +       nvmem_cell_put(cell);
> +       if (IS_ERR(ret)) {
> +               dev_err(dev, "can't read cell %s\n", cname);
> +               return PTR_ERR(ret);
> +       }
> +
> +       for (i =3D 0; i < len; i++)
> +               *data |=3D ret[i] << (8 * i);

Amazing we don't have some sort of char array to u32 function.

> +
> +       kfree(ret);
> +       dev_dbg(dev, "efuse read(%s) =3D %x, bytes %ld\n", cname, *data, =
len);
> +
> +       return 0;
> +}
> +
[...]
> +
> +static int cpr_calculate_scaling(const char *quot_offset,
> +                                struct cpr_drv *drv,
> +                                const struct fuse_corner_data *fdata,
> +                                const struct corner *corner)
> +{
> +       u32 quot_diff =3D 0;
> +       unsigned long freq_diff;
> +       int scaling;
> +       const struct fuse_corner *fuse, *prev_fuse;
> +       int ret;
> +
> +       fuse =3D corner->fuse_corner;
> +       prev_fuse =3D fuse - 1;
> +
> +       if (quot_offset) {
> +               ret =3D cpr_read_efuse(drv->dev, quot_offset, &quot_diff);
> +               if (ret)
> +                       return ret;
> +
> +               quot_diff *=3D fdata->quot_offset_scale;
> +               quot_diff +=3D fdata->quot_offset_adjust;
> +       } else {
> +               quot_diff =3D fuse->quot - prev_fuse->quot;
> +       }
> +
> +       freq_diff =3D fuse->max_freq - prev_fuse->max_freq;
> +       freq_diff /=3D 1000000; /* Convert to MHz */
> +       scaling =3D 1000 * quot_diff / freq_diff;
> +       return min(scaling, fdata->max_quot_scale);
> +}
> +
> +static int cpr_interpolate(const struct corner *corner, int step_volt,
> +                          const struct fuse_corner_data *fdata)
> +{
> +       unsigned long f_high, f_low, f_diff;
> +       int uV_high, uV_low, uV;
> +       u64 temp, temp_limit;
> +       const struct fuse_corner *fuse, *prev_fuse;
> +
> +       fuse =3D corner->fuse_corner;
> +       prev_fuse =3D fuse - 1;
> +
> +       f_high =3D fuse->max_freq;
> +       f_low =3D prev_fuse->max_freq;
> +       uV_high =3D fuse->uV;
> +       uV_low =3D prev_fuse->uV;
> +       f_diff =3D fuse->max_freq - corner->freq;
> +
> +       /*
> +        * Don't interpolate in the wrong direction. This could happen
> +        * if the adjusted fuse voltage overlaps with the previous fuse's
> +        * adjusted voltage.
> +        */
> +       if (f_high <=3D f_low || uV_high <=3D uV_low || f_high <=3D corne=
r->freq)
> +               return corner->uV;
> +
> +       temp =3D f_diff * (uV_high - uV_low);
> +       do_div(temp, f_high - f_low);
> +
> +       /*
> +        * max_volt_scale has units of uV/MHz while freq values
> +        * have units of Hz.  Divide by 1000000 to convert to.
> +        */
> +       temp_limit =3D f_diff * fdata->max_volt_scale;
> +       do_div(temp_limit, 1000000);
> +
> +       uV =3D uV_high - min(temp, temp_limit);
> +       return roundup(uV, step_volt);
> +}
> +
> +static unsigned int cpr_get_fuse_corner(struct dev_pm_opp *opp)
> +{
> +       struct device_node *np;
> +       unsigned int fuse_corner =3D 0;
> +
> +       np =3D dev_pm_opp_get_of_node(opp);
> +       if (of_property_read_u32(np, "qcom,opp-fuse-level", &fuse_corner)=
) {
> +               pr_err("%s: missing 'qcom,opp-fuse-level' property\n",
> +                      __func__);
> +               return 0;
> +       }
> +
> +       of_node_put(np);

Do you need to of_node_put() on error above?

> +
> +       return fuse_corner;
> +}
> +
> +unsigned long cpr_get_opp_hz_for_req(struct dev_pm_opp *ref)
> +{
> +       u64 rate =3D 0;
> +       struct device *cpu_dev;
> +       struct device_node *ref_np;
> +       struct device_node *desc_np;
> +       struct device_node *child_np =3D NULL;
> +       struct device_node *child_req_np =3D NULL;
> +
> +       cpu_dev =3D get_cpu_device(0);
> +       if (!cpu_dev)
> +               return 0;
> +
> +       desc_np =3D dev_pm_opp_of_get_opp_desc_node(cpu_dev);
> +       if (!desc_np)
> +               return 0;
> +
> +       ref_np =3D dev_pm_opp_get_of_node(ref);
> +       if (!ref_np)
> +               goto out_ref;
> +
> +       do {
> +               of_node_put(child_req_np);
> +               child_np =3D of_get_next_available_child(desc_np, child_n=
p);
> +               child_req_np =3D of_parse_phandle(child_np, "required-opp=
s", 0);
> +       } while (child_np && child_req_np !=3D ref_np);
> +
> +       if (child_np && child_req_np =3D=3D ref_np)
> +               of_property_read_u64(child_np, "opp-hz", &rate);
> +
> +       of_node_put(child_req_np);
> +       of_node_put(child_np);
> +       of_node_put(ref_np);
> +out_ref:
> +       of_node_put(desc_np);
> +
> +       return (unsigned long) rate;
> +}
> +
> +static int cpr_corner_init(struct cpr_drv *drv)
> +{
> +       const struct cpr_desc *desc =3D drv->desc;
> +       const struct cpr_fuse *fuses =3D drv->cpr_fuses;
> +       int i, level, count, scaling =3D 0;
> +       unsigned int fnum, fc;
> +       const char *quot_offset;
> +       struct fuse_corner *fuse, *prev_fuse;
> +       struct corner *corner, *end;
> +       struct corner_data *cdata;
> +       const struct fuse_corner_data *fdata;
> +       bool apply_scaling;
> +       unsigned long freq_diff, freq_diff_mhz;
> +       unsigned long freq;
> +       int step_volt =3D regulator_get_linear_step(drv->vdd_apc);
> +       struct dev_pm_opp *opp;
> +       struct device *pd_dev;
> +
> +       if (!step_volt)
> +               return -EINVAL;
> +
> +       corner =3D drv->corners;
> +       end =3D &corner[drv->num_corners - 1];
> +
> +       pd_dev =3D &drv->pd.dev;
> +       cdata =3D devm_kzalloc(drv->dev,
> +                            sizeof(struct corner_data) * drv->num_corner=
s,
> +                            GFP_KERNEL);
> +       if (!cdata)
> +               return -ENOMEM;
> +
> +       /*
> +        * Store maximum frequency for each fuse corner based on the freq=
uency
> +        * plan
> +        */
> +       count =3D dev_pm_opp_get_opp_count(pd_dev);
> +       for (level =3D 1; level <=3D count; level++) {
> +               opp =3D dev_pm_opp_find_level_exact(pd_dev, level);
> +               if (IS_ERR(opp))
> +                       return -EINVAL;
> +               fc =3D cpr_get_fuse_corner(opp);
> +               if (!fc) {
> +                       dev_pm_opp_put(opp);
> +                       return -EINVAL;
> +               }
> +               fnum =3D fc - 1;
> +               freq =3D cpr_get_opp_hz_for_req(opp);
> +               if (!freq) {
> +                       dev_pm_opp_put(opp);
> +                       return -EINVAL;
> +               }
> +               cdata[level - 1].fuse_corner =3D fnum;
> +               cdata[level - 1].freq =3D freq;
> +
> +               fuse =3D &drv->fuse_corners[fnum];
> +               dev_dbg(drv->dev, "freq: %lu level: %u fuse level: %u\n",
> +                       freq, dev_pm_opp_get_level(opp) - 1, fnum);
> +               if (freq > fuse->max_freq)
> +                       fuse->max_freq =3D freq;
> +               dev_pm_opp_put(opp);
> +       }
> +
> +       /*
> +        * Get the quotient adjustment scaling factor, according to:
> +        *
> +        * scaling =3D min(1000 * (QUOT(corner_N) - QUOT(corner_N-1))
> +        *              / (freq(corner_N) - freq(corner_N-1)), max_factor)
> +        *
> +        * QUOT(corner_N):      quotient read from fuse for fuse corner N
> +        * QUOT(corner_N-1):    quotient read from fuse for fuse corner (=
N - 1)
> +        * freq(corner_N):      max frequency in MHz supported by fuse co=
rner N
> +        * freq(corner_N-1):    max frequency in MHz supported by fuse co=
rner
> +        *                       (N - 1)
> +        *
> +        * Then walk through the corners mapped to each fuse corner
> +        * and calculate the quotient adjustment for each one using the
> +        * following formula:
> +        *
> +        * quot_adjust =3D (freq_max - freq_corner) * scaling / 1000
> +        *
> +        * freq_max: max frequency in MHz supported by the fuse corner
> +        * freq_corner: frequency in MHz corresponding to the corner
> +        * scaling: calculated from above equation
> +        *
> +        *
> +        *     +                           +
> +        *     |                         v |
> +        *   q |           f c           o |           f c
> +        *   u |         c               l |         c
> +        *   o |       f                 t |       f
> +        *   t |     c                   a |     c
> +        *     | c f                     g | c f
> +        *     |                         e |
> +        *     +---------------            +----------------
> +        *       0 1 2 3 4 5 6               0 1 2 3 4 5 6
> +        *          corner                      corner
> +        *
> +        *    c =3D corner
> +        *    f =3D fuse corner
> +        *
> +        */
> +       for (apply_scaling =3D false, i =3D 0; corner <=3D end; corner++,=
 i++) {
> +               fnum =3D cdata[i].fuse_corner;
> +               fdata =3D &desc->cpr_fuses.fuse_corner_data[fnum];
> +               quot_offset =3D fuses[fnum].quotient_offset;
> +               fuse =3D &drv->fuse_corners[fnum];
> +               if (fnum)
> +                       prev_fuse =3D &drv->fuse_corners[fnum - 1];
> +               else
> +                       prev_fuse =3D NULL;
> +
> +               corner->fuse_corner =3D fuse;
> +               corner->freq =3D cdata[i].freq;
> +               corner->uV =3D fuse->uV;
> +
> +               if (prev_fuse && cdata[i - 1].freq =3D=3D prev_fuse->max_=
freq) {
> +                       scaling =3D cpr_calculate_scaling(quot_offset, dr=
v,
> +                                                       fdata, corner);
> +                       if (scaling < 0)
> +                               return scaling;
> +
> +                       apply_scaling =3D true;
> +               } else if (corner->freq =3D=3D fuse->max_freq) {
> +                       /* This is a fuse corner; don't scale anything */
> +                       apply_scaling =3D false;
> +               }
> +
> +               if (apply_scaling) {
> +                       freq_diff =3D fuse->max_freq - corner->freq;
> +                       freq_diff_mhz =3D freq_diff / 1000000;
> +                       corner->quot_adjust =3D scaling * freq_diff_mhz /=
 1000;
> +
> +                       corner->uV =3D cpr_interpolate(corner, step_volt,=
 fdata);
> +               }
> +
> +               corner->max_uV =3D fuse->max_uV;
> +               corner->min_uV =3D fuse->min_uV;
> +               corner->uV =3D clamp(corner->uV, corner->min_uV, corner->=
max_uV);
> +               corner->last_uV =3D corner->uV;
> +
> +               /* Reduce the ceiling voltage if needed */
> +               if (desc->reduce_to_corner_uV && corner->uV < corner->max=
_uV)
> +                       corner->max_uV =3D corner->uV;
> +               else if (desc->reduce_to_fuse_uV && fuse->uV < corner->ma=
x_uV)
> +                       corner->max_uV =3D max(corner->min_uV, fuse->uV);
> +
> +               dev_dbg(drv->dev, "corner %d: [%d %d %d] quot %d\n", i,
> +                       corner->min_uV, corner->uV, corner->max_uV,
> +                       fuse->quot - corner->quot_adjust);
> +       }
> +
> +       return 0;
> +}
> +
> +static const struct cpr_fuse *cpr_get_fuses(struct cpr_drv *drv)
> +{
> +       const struct cpr_desc *desc =3D drv->desc;
> +       struct cpr_fuse *fuses;
> +       int i;
> +
> +       fuses =3D devm_kzalloc(drv->dev,
> +                            sizeof(struct cpr_fuse) * desc->num_fuse_cor=
ners,
> +                            GFP_KERNEL);
> +       if (!fuses)
> +               return ERR_PTR(-ENOMEM);
> +
> +       for (i =3D 0; i < desc->num_fuse_corners; i++) {
> +               char tbuf[32];
> +
> +               snprintf(tbuf, 32, "cpr_ring_osc%d", i + 1);
> +               fuses[i].ring_osc =3D devm_kstrdup(drv->dev, tbuf, GFP_KE=
RNEL);
> +               if (!fuses[i].ring_osc)
> +                       return ERR_PTR(-ENOMEM);
> +
> +               snprintf(tbuf, 32, "cpr_init_voltage%d", i + 1);
> +               fuses[i].init_voltage =3D devm_kstrdup(drv->dev, tbuf,
> +                                                    GFP_KERNEL);
> +               if (!fuses[i].init_voltage)
> +                       return ERR_PTR(-ENOMEM);
> +
> +               snprintf(tbuf, 32, "cpr_quotient%d", i + 1);
> +               fuses[i].quotient =3D devm_kstrdup(drv->dev, tbuf, GFP_KE=
RNEL);
> +               if (!fuses[i].quotient)
> +                       return ERR_PTR(-ENOMEM);
> +
> +               snprintf(tbuf, 32, "cpr_quotient_offset%d", i + 1);
> +               fuses[i].quotient_offset =3D devm_kstrdup(drv->dev, tbuf,
> +                                                       GFP_KERNEL);
> +               if (!fuses[i].quotient_offset)
> +                       return ERR_PTR(-ENOMEM);
> +       }
> +
> +       return fuses;
> +}
> +
> +static int cpr_set_loop_allowed(struct cpr_drv *drv)
> +{
> +       drv->loop_disabled =3D false;
> +
> +       return 0;

Drop the return code?

> +}
> +
> +static int cpr_init_parameters(struct cpr_drv *drv)
> +{
> +       struct device_node *of_node =3D drv->dev->of_node;
> +       int ret;
> +       struct clk *clk;
> +
> +       clk =3D clk_get(drv->dev, "ref");
> +       if (IS_ERR(clk))
> +               return PTR_ERR(clk);
> +
> +       drv->ref_clk_khz =3D clk_get_rate(clk) / 1000;
> +       clk_put(clk);
> +
> +       ret =3D of_property_read_u32(of_node, "qcom,cpr-timer-delay-us",
> +                                  &drv->timer_delay_us);
> +       if (ret)
> +               return ret;
> +       ret =3D of_property_read_u32(of_node, "qcom,cpr-timer-cons-up",
> +                                  &drv->timer_cons_up);
> +       if (ret)
> +               return ret;
> +       drv->timer_cons_up &=3D RBIF_TIMER_ADJ_CONS_UP_MASK;
> +       ret =3D of_property_read_u32(of_node, "qcom,cpr-timer-cons-down",
> +                                  &drv->timer_cons_down);
> +       if (ret)
> +               return ret;
> +       drv->timer_cons_down &=3D RBIF_TIMER_ADJ_CONS_DOWN_MASK;
> +
> +       ret =3D of_property_read_u32(of_node, "qcom,cpr-up-threshold",
> +                                  &drv->up_threshold);
> +       drv->up_threshold &=3D RBCPR_CTL_UP_THRESHOLD_MASK;
> +       if (ret)
> +               return ret;
> +
> +       ret =3D of_property_read_u32(of_node, "qcom,cpr-down-threshold",
> +                                  &drv->down_threshold);
> +       drv->down_threshold &=3D RBCPR_CTL_DN_THRESHOLD_MASK;
> +       if (ret)
> +               return ret;
> +
> +       ret =3D of_property_read_u32(of_node, "qcom,cpr-idle-clocks",
> +                                  &drv->idle_clocks);
> +       drv->idle_clocks &=3D RBCPR_STEP_QUOT_IDLE_CLK_MASK;
> +       if (ret)
> +               return ret;
> +
> +       ret =3D of_property_read_u32(of_node, "qcom,cpr-gcnt-us", &drv->g=
cnt_us);
> +       if (ret)
> +               return ret;
> +       ret =3D of_property_read_u32(of_node, "qcom,vdd-apc-step-up-limit=
",
> +                                  &drv->vdd_apc_step_up_limit);
> +       if (ret)
> +               return ret;
> +       ret =3D of_property_read_u32(of_node, "qcom,vdd-apc-step-down-lim=
it",
> +                                  &drv->vdd_apc_step_down_limit);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D of_property_read_u32(of_node, "qcom,cpr-clamp-timer-inter=
val",
> +                                  &drv->clamp_timer_interval);
> +       if (ret && ret !=3D -EINVAL)
> +               return ret;
> +
> +       drv->clamp_timer_interval =3D min_t(unsigned int,
> +                                         drv->clamp_timer_interval,
> +                                         RBIF_TIMER_ADJ_CLAMP_INT_MASK);
> +
> +       dev_dbg(drv->dev, "up threshold =3D %u, down threshold =3D %u\n",
> +               drv->up_threshold, drv->down_threshold);
> +
> +       return 0;
> +}
> +
> +static int cpr_find_initial_corner(struct cpr_drv *drv)
> +{
> +       unsigned long rate;
> +       const struct corner *end;
> +       struct corner *iter;
> +       int i =3D 0;
> +
> +       if (IS_ERR_OR_NULL(drv->cpu_clk)) {

Will this ever happen?

> +               dev_err(drv->dev, "cpu clk is not set\n");
> +               return -EINVAL;
> +       }
> +
> +       end =3D &drv->corners[drv->num_corners - 1];
> +       rate =3D clk_get_rate(drv->cpu_clk);
> +
> +       for (iter =3D drv->corners; iter <=3D end; iter++) {
> +               if (iter->freq > rate)
> +                       break;
> +               i++;
> +               if (iter->freq =3D=3D rate) {
> +                       drv->corner =3D iter;
> +                       drv->performance_state =3D i;
> +                       break;
> +               }
> +               if (iter->freq < rate) {
> +                       drv->corner =3D iter;
> +                       drv->performance_state =3D i;
> +               }
> +       }
> +
> +       if (!drv->corner) {
> +               dev_err(drv->dev, "boot up corner not found\n");
> +               return -EINVAL;
> +       }
> +
> +       dev_dbg(drv->dev, "boot up perf state: %d\n", i);
> +
> +       return 0;
> +}
[...]
> +
> +static unsigned int cpr_get_performance(struct generic_pm_domain *genpd,
> +                                       struct dev_pm_opp *opp)
> +{
> +       return dev_pm_opp_get_level(opp);
> +}
> +
> +static int cpr_power_off(struct generic_pm_domain *domain)
> +{
> +       struct cpr_drv *drv =3D container_of(domain, struct cpr_drv, pd);
> +
> +       return cpr_disable(drv);
> +}
> +
> +static int cpr_power_on(struct generic_pm_domain *domain)
> +{
> +       struct cpr_drv *drv =3D container_of(domain, struct cpr_drv, pd);
> +
> +       return cpr_enable(drv);
> +}
> +
> +static int cpr_pd_attach_dev(struct generic_pm_domain *domain,
> +                            struct device *dev)
> +{
> +       struct cpr_drv *drv =3D container_of(domain, struct cpr_drv, pd);
> +       const struct acc_desc *acc_desc =3D drv->acc_desc;
> +       size_t len;
> +       int ret;
> +
> +       dev_dbg(drv->dev, "attach callback for: %s\n", dev_name(dev));
> +
> +       if (!drv->cpu_clk) {

Maybe this could be if (drv->cpu_clk) return 0, and then deindent
everything else.

> +               drv->cpu_clk =3D devm_clk_get(dev, NULL);
> +               if (IS_ERR_OR_NULL(drv->cpu_clk)) {

NULL is a valid clk. Probably just want to check for IS_ERR() and also
not do anything with the return value besides PTR_ERR() on it?
Eventually EPROBE_DEFER will arrive.

> +                       dev_err(drv->dev, "could not get cpu clk\n");
> +                       return -EINVAL;
> +               }
> +
> +               dev_dbg(drv->dev, "using cpu clk from: %s\n", dev_name(de=
v));
> +
> +               /* Everything related to (virtual) corners has to be init=
ialized
> +                * here, when attaching to the power domain, since it dep=
ends on
> +                * the power domain's OPP table, which isn't available ea=
rlier.
> +                */
> +               drv->num_corners =3D dev_pm_opp_get_opp_count(&drv->pd.de=
v);
> +               if (drv->num_corners < 0)
> +                       return drv->num_corners;
> +               if (drv->num_corners < 2) {
> +                       dev_err(drv->dev, "need at least 2 OPPs to use CP=
R\n");
> +                       return -EINVAL;
> +               }
> +
> +               dev_dbg(drv->dev, "number of OPPs: %d\n", drv->num_corner=
s);
> +
> +               len =3D sizeof(*drv->corners) * drv->num_corners;
> +               drv->corners =3D devm_kzalloc(dev, len, GFP_KERNEL);
> +               if (!drv->corners)
> +                       return -ENOMEM;
> +
> +               ret =3D cpr_corner_init(drv);
> +               if (ret)
> +                       return ret;
> +
> +               ret =3D cpr_set_loop_allowed(drv);
> +               if (ret)
> +                       return ret;
> +
> +               ret =3D cpr_init_parameters(drv);
> +               if (ret)
> +                       return ret;
> +
> +               /* Configure CPR HW but keep it disabled */
> +               ret =3D cpr_config(drv);
> +               if (ret)
> +                       return ret;
> +
> +               ret =3D cpr_find_initial_corner(drv);
> +               if (ret)
> +                       return ret;
> +
> +               if (acc_desc->config)
> +                       regmap_multi_reg_write(drv->tcsr, acc_desc->confi=
g,
> +                                              acc_desc->num_regs_per_fus=
e);
> +
> +               /* Enable ACC if required */
> +               if (acc_desc->enable_mask)
> +                       regmap_update_bits(drv->tcsr, acc_desc->enable_re=
g,
> +                                          acc_desc->enable_mask,
> +                                          acc_desc->enable_mask);
> +       }
> +
> +       return 0;
> +}
> +
> +static int cpr_debug_info_open(struct inode *inode, struct file *file)
> +{
> +       file->private_data =3D inode->i_private;
> +
> +       return 0;
> +}
> +
> +static ssize_t cpr_debug_info_read(struct file *file, char __user *buff,
> +                                  size_t count, loff_t *ppos)
> +{
> +       u32 gcnt, ro_sel, ctl, irq_status, reg, error_steps;
> +       u32 step_dn, step_up, error, error_lt0, busy;
> +       struct cpr_drv *drv =3D file->private_data;
> +       struct fuse_corner *fuse_corner;
> +       struct corner *corner;
> +       ssize_t len, ret =3D 0;
> +       char *debugfs_buf;
> +
> +       debugfs_buf =3D kmalloc(PAGE_SIZE, GFP_KERNEL);
> +       if (!debugfs_buf)
> +               return -ENOMEM;
> +
> +       mutex_lock(&drv->lock);
> +
> +       corner =3D drv->corner;
> +       fuse_corner =3D corner->fuse_corner;
> +
> +       len =3D snprintf(debugfs_buf + ret, PAGE_SIZE - ret,
> +                      "corner, current_volt =3D %d uV\n",
> +                      corner->last_uV);
> +       ret +=3D len;
> +
> +       ro_sel =3D fuse_corner->ring_osc_idx;
> +       gcnt =3D cpr_read(drv, REG_RBCPR_GCNT_TARGET(ro_sel));
> +       len =3D snprintf(debugfs_buf + ret, PAGE_SIZE - ret,
> +                      "rbcpr_gcnt_target (%u) =3D 0x%02X\n", ro_sel, gcn=
t);
> +       ret +=3D len;
> +
> +       ctl =3D cpr_read(drv, REG_RBCPR_CTL);
> +       len =3D snprintf(debugfs_buf + ret, PAGE_SIZE - ret,
> +                      "rbcpr_ctl =3D 0x%02X\n", ctl);
> +       ret +=3D len;
> +
> +       irq_status =3D cpr_read(drv, REG_RBIF_IRQ_STATUS);
> +       len =3D snprintf(debugfs_buf + ret, PAGE_SIZE - ret,
> +                      "rbcpr_irq_status =3D 0x%02X\n", irq_status);
> +       ret +=3D len;
> +
> +       reg =3D cpr_read(drv, REG_RBCPR_RESULT_0);
> +       len =3D snprintf(debugfs_buf + ret, PAGE_SIZE - ret,
> +                      "rbcpr_result_0 =3D 0x%02X\n", reg);
> +       ret +=3D len;
> +
> +       step_dn =3D reg & 0x01;
> +       step_up =3D (reg >> RBCPR_RESULT0_STEP_UP_SHIFT) & 0x01;
> +       len =3D snprintf(debugfs_buf + ret, PAGE_SIZE - ret,
> +                      "  [step_dn =3D %u", step_dn);
> +       ret +=3D len;
> +
> +       len =3D snprintf(debugfs_buf + ret, PAGE_SIZE - ret,
> +                      ", step_up =3D %u", step_up);
> +       ret +=3D len;
> +
> +       error_steps =3D (reg >> RBCPR_RESULT0_ERROR_STEPS_SHIFT)
> +                               & RBCPR_RESULT0_ERROR_STEPS_MASK;
> +       len =3D snprintf(debugfs_buf + ret, PAGE_SIZE - ret,

> +                      ", error_steps =3D %u", error_steps);
> +       ret +=3D len;
> +
> +       error =3D (reg >> RBCPR_RESULT0_ERROR_SHIFT) & RBCPR_RESULT0_ERRO=
R_MASK;
> +       len =3D snprintf(debugfs_buf + ret, PAGE_SIZE - ret,
> +                      ", error =3D %u", error);
> +       ret +=3D len;
> +
> +       error_lt0 =3D (reg >> RBCPR_RESULT0_ERROR_LT0_SHIFT) & 0x01;
> +       len =3D snprintf(debugfs_buf + ret, PAGE_SIZE - ret,
> +                      ", error_lt_0 =3D %u", error_lt0);
> +       ret +=3D len;
> +
> +       busy =3D (reg >> RBCPR_RESULT0_BUSY_SHIFT) & 0x01;
> +       len =3D snprintf(debugfs_buf + ret, PAGE_SIZE - ret,
> +                      ", busy =3D %u]\n", busy);
> +       ret +=3D len;
> +       mutex_unlock(&drv->lock);

What is the mutex for? Doesn't seem like a good idea for the debugfs API
to be able to DDOS the threaded irq.

> +
> +       ret =3D simple_read_from_buffer(buff, count, ppos, debugfs_buf, r=
et);

Can this use a seq_file instead of simple_read_from_buffer()?

> +       kfree(debugfs_buf);
> +       return ret;
> +}
> +
> +static const struct file_operations cpr_debug_info_fops =3D {
> +       .open =3D cpr_debug_info_open,
> +       .read =3D cpr_debug_info_read,
> +};
> +
> +static void cpr_debugfs_init(struct cpr_drv *drv)
> +{
> +       drv->debugfs =3D debugfs_create_dir("qcom_cpr", NULL);
> +
> +       debugfs_create_file("debug_info", 0444, drv->debugfs,
> +                           drv, &cpr_debug_info_fops);
> +}
> +
> +static int cpr_probe(struct platform_device *pdev)
> +{
> +       struct resource *res;
> +       struct device *dev =3D &pdev->dev;
> +       struct cpr_drv *drv;
> +       size_t len;
> +       int irq, ret;
> +       const struct cpr_acc_desc *data;
> +       struct device_node *np;
> +       u32 cpr_rev =3D FUSE_REVISION_UNKNOWN;
> +
> +       data =3D of_device_get_match_data(dev);
> +       if (!data || !data->cpr_desc || !data->acc_desc)
> +               return -EINVAL;
> +
> +       drv =3D devm_kzalloc(dev, sizeof(*drv), GFP_KERNEL);
> +       if (!drv)
> +               return -ENOMEM;
> +       drv->dev =3D dev;
> +       drv->desc =3D data->cpr_desc;
> +       drv->acc_desc =3D data->acc_desc;
> +
> +       len =3D sizeof(*drv->fuse_corners) * drv->desc->num_fuse_corners;
> +       drv->fuse_corners =3D devm_kzalloc(dev, len, GFP_KERNEL);

Use devm_kcalloc() to allocate arrays

> +       if (!drv->fuse_corners)
> +               return -ENOMEM;
> +
> +       np =3D of_parse_phandle(dev->of_node, "acc-syscon", 0);
> +       if (!np)
> +               return -ENODEV;
> +
> +       drv->tcsr =3D syscon_node_to_regmap(np);
> +       of_node_put(np);
> +       if (IS_ERR(drv->tcsr))
> +               return PTR_ERR(drv->tcsr);
> +
> +       mutex_init(&drv->lock);
> +
> +       res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       drv->base =3D devm_ioremap_resource(dev, res);
> +       if (IS_ERR(drv->base))
> +               return PTR_ERR(drv->base);
> +
> +       irq =3D platform_get_irq(pdev, 0);
> +       if (irq < 0)
> +               return -EINVAL;
> +
> +       drv->vdd_apc =3D devm_regulator_get(dev, "vdd-apc");
> +       if (IS_ERR(drv->vdd_apc))
> +               return PTR_ERR(drv->vdd_apc);
> +
> +       /* Initialize fuse corners, since it simply depends

Please fix multi line comment style to have a single /* at the
beginning.

> +        * on data in efuses.
> +        * Everything related to (virtual) corners has to be
> +        * initialized after attaching to the power domain,
> +        * since is depends on the OPP table.
> +        */
> +       ret =3D cpr_read_efuse(dev, "cpr_fuse_revision", &cpr_rev);
> +       if (ret)
> +               return ret;
> +
> +       drv->cpr_fuses =3D cpr_get_fuses(drv);
> +       if (IS_ERR(drv->cpr_fuses))
> +               return PTR_ERR(drv->cpr_fuses);
> +
> +       ret =3D cpr_populate_ring_osc_idx(drv);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D cpr_fuse_corner_init(drv);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D devm_request_threaded_irq(dev, irq, NULL,
> +                                       cpr_irq_handler,
> +                                       IRQF_ONESHOT | IRQF_TRIGGER_RISIN=
G,
> +                                       "cpr", drv);
> +       if (ret)
> +               return ret;
> +
> +       drv->pd.name =3D devm_kstrdup_const(dev, dev->of_node->full_name,
> +                                         GFP_KERNEL);
> +       if (!drv->pd.name)
> +               return -EINVAL;
> +
> +       drv->pd.power_off =3D cpr_power_off;
> +       drv->pd.power_on =3D cpr_power_on;
> +       drv->pd.set_performance_state =3D cpr_set_performance;
> +       drv->pd.opp_to_performance_state =3D cpr_get_performance;
> +       drv->pd.attach_dev =3D cpr_pd_attach_dev;
> +
> +       ret =3D pm_genpd_init(&drv->pd, NULL, true);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D of_genpd_add_provider_simple(dev->of_node, &drv->pd);
> +       if (ret)
> +               return ret;
> +
> +       platform_set_drvdata(pdev, drv);
> +       cpr_debugfs_init(drv);
> +
> +       return 0;
> +}
> +
> +static int cpr_remove(struct platform_device *pdev)
> +{
> +       struct cpr_drv *drv =3D platform_get_drvdata(pdev);
> +
> +       if (cpr_is_allowed(drv)) {
> +               cpr_ctl_disable(drv);
> +               cpr_irq_set(drv, 0);
> +       }
> +
> +       of_genpd_del_provider(pdev->dev.of_node);
> +       pm_genpd_remove(&drv->pd);
> +
> +       debugfs_remove_recursive(drv->debugfs);
> +
> +       return 0;
> +}
> +
> +static const struct of_device_id cpr_match_table[] =3D {
> +       { .compatible =3D "qcom,qcs404-cpr", .data =3D &qcs404_cpr_acc_de=
sc },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(of, cpr_match_table);
> +
> +static struct platform_driver cpr_driver =3D {
> +       .probe          =3D cpr_probe,
> +       .remove         =3D cpr_remove,
> +       .driver         =3D {
> +               .name   =3D "qcom-cpr",
> +               .of_match_table =3D cpr_match_table,
> +               .pm =3D &cpr_pm_ops,
> +       },
> +};
> +module_platform_driver(cpr_driver);
> +
> +MODULE_DESCRIPTION("Core Power Reduction (CPR) driver");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:qcom-cpr");

Is the alias needed?


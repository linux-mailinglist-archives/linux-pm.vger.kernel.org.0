Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE97A76B3B7
	for <lists+linux-pm@lfdr.de>; Tue,  1 Aug 2023 13:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234388AbjHALrX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Tue, 1 Aug 2023 07:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234393AbjHALrW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Aug 2023 07:47:22 -0400
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B54892;
        Tue,  1 Aug 2023 04:47:18 -0700 (PDT)
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-56c9f7830c2so265502eaf.0;
        Tue, 01 Aug 2023 04:47:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690890437; x=1691495237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nwNIXaKmJkxkXd4e8nxYP0imjvaI0tNQYqyQY//BuIw=;
        b=cjPE+7KAKdLpiRn9uOArH0qWWCHedpj0sl8YnWrsMDWNjJZPFUwC/9g0UvuxZ2vbKx
         1OrOaYdq553AdXcGkkFLuN3keCEL/5bTGsQ83MAlAU5EjlnzuXGalWwkUBYXKZWbuq/W
         mOmuXpVhvSuKp+O9/fV5qsY8lzI6rki11gqCMP6mrLOZwM+cfDEPh1FyLyFA/CxesA1c
         tBlQRlNX5WYIbPnBzLfWRPibm/weTxaI5sY3fy2dnDHIp6gjPuIbUvwVQVz0UhwzSWhx
         udyx53cCWtgUBUZr4F8FhnIA86l3OpQOyGyZffJ2OPzLhrEw/aJ/wk2BNrEcUJ4wr3dL
         zPwA==
X-Gm-Message-State: ABy/qLanJFxrbWUJw8bnnn0LXp0o9F/84UthA5VFp6O9o5OfAPw0EkCI
        28im+uH99zgc4oY1B7mXYMYoHWs2kPULGEu4etk=
X-Google-Smtp-Source: APBJJlE9n8j8E9yZxVhKkPsUNqN0I7zhzOQDTwEy8ipMnQ19VfsSeZdaWKWMyrYdjEGbXDCsrI3X/wVA8k6zzHnxMrQ=
X-Received: by 2002:a05:6820:1686:b0:56c:5e21:c730 with SMTP id
 bc6-20020a056820168600b0056c5e21c730mr8402689oob.1.1690890437461; Tue, 01 Aug
 2023 04:47:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230725053912.133521-1-rui.zhang@intel.com>
In-Reply-To: <20230725053912.133521-1-rui.zhang@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 1 Aug 2023 13:47:06 +0200
Message-ID: <CAJZ5v0hLYVzdh+F-WQ1tWj7wV_kSM2eu8SX7OxZS1HMZ-ycQHQ@mail.gmail.com>
Subject: Re: [V2 PATCH] powercap/intel_rapl: Fix a sparse warning
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com,
        David.Laight@aculab.com, daniel.lezcano@linaro.org,
        linux-kernel@vger.kernel.org, lkp@intel.com, wendy.wang@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 25, 2023 at 7:39 AM Zhang Rui <rui.zhang@intel.com> wrote:
>
> Depends on the interface used, the RAPL registers can either be MSR
> indexes or memory mapped IO addresses. Current rapl common code uses U64
> to save both MSR and memory mapped IO registers. With this, when
> handling register address with an __iomem annotation, it causes sparse
> warning like below
>
> sparse warnings: (new ones prefixed by >>)
> >> drivers/powercap/intel_rapl_tpmi.c:141:41: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [usertype] *tpmi_rapl_regs @@     got void [noderef] __iomem * @@
>    drivers/powercap/intel_rapl_tpmi.c:141:41: sparse:     expected unsigned long long [usertype] *tpmi_rapl_regs
>    drivers/powercap/intel_rapl_tpmi.c:141:41: sparse:     got void [noderef] __iomem *
>
> Fix the problem by using a union to save the registers instead.
>
> Suggested-by: David Laight <David.Laight@ACULAB.COM>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202307031405.dy3druuy-lkp@intel.com/
> Tested-by: Wang Wendy <wendy.wang@intel.com>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/powercap/intel_rapl_common.c          | 14 +++---
>  drivers/powercap/intel_rapl_msr.c             | 49 ++++++++++---------
>  drivers/powercap/intel_rapl_tpmi.c            | 17 +++----
>  .../int340x_thermal/processor_thermal_rapl.c  | 16 +++---
>  include/linux/intel_rapl.h                    | 14 ++++--
>  5 files changed, 58 insertions(+), 52 deletions(-)
>
> diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
> index 4e646e5e48f6..8fac57b28f8a 100644
> --- a/drivers/powercap/intel_rapl_common.c
> +++ b/drivers/powercap/intel_rapl_common.c
> @@ -818,7 +818,7 @@ static int rapl_read_data_raw(struct rapl_domain *rd,
>                 return -EINVAL;
>
>         ra.reg = rd->regs[rpi->id];
> -       if (!ra.reg)
> +       if (!ra.reg.val)
>                 return -EINVAL;
>
>         /* non-hardware data are collected by the polling thread */
> @@ -830,7 +830,7 @@ static int rapl_read_data_raw(struct rapl_domain *rd,
>         ra.mask = rpi->mask;
>
>         if (rd->rp->priv->read_raw(get_rid(rd->rp), &ra)) {
> -               pr_debug("failed to read reg 0x%llx for %s:%s\n", ra.reg, rd->rp->name, rd->name);
> +               pr_debug("failed to read reg 0x%llx for %s:%s\n", ra.reg.val, rd->rp->name, rd->name);
>                 return -EIO;
>         }
>
> @@ -920,7 +920,7 @@ static int rapl_check_unit_core(struct rapl_domain *rd)
>         ra.mask = ~0;
>         if (rd->rp->priv->read_raw(get_rid(rd->rp), &ra)) {
>                 pr_err("Failed to read power unit REG 0x%llx on %s:%s, exit.\n",
> -                       ra.reg, rd->rp->name, rd->name);
> +                       ra.reg.val, rd->rp->name, rd->name);
>                 return -ENODEV;
>         }
>
> @@ -948,7 +948,7 @@ static int rapl_check_unit_atom(struct rapl_domain *rd)
>         ra.mask = ~0;
>         if (rd->rp->priv->read_raw(get_rid(rd->rp), &ra)) {
>                 pr_err("Failed to read power unit REG 0x%llx on %s:%s, exit.\n",
> -                       ra.reg, rd->rp->name, rd->name);
> +                       ra.reg.val, rd->rp->name, rd->name);
>                 return -ENODEV;
>         }
>
> @@ -1135,7 +1135,7 @@ static int rapl_check_unit_tpmi(struct rapl_domain *rd)
>         ra.mask = ~0;
>         if (rd->rp->priv->read_raw(get_rid(rd->rp), &ra)) {
>                 pr_err("Failed to read power unit REG 0x%llx on %s:%s, exit.\n",
> -                       ra.reg, rd->rp->name, rd->name);
> +                       ra.reg.val, rd->rp->name, rd->name);
>                 return -ENODEV;
>         }
>
> @@ -1411,8 +1411,8 @@ static int rapl_get_domain_unit(struct rapl_domain *rd)
>         struct rapl_defaults *defaults = get_defaults(rd->rp);
>         int ret;
>
> -       if (!rd->regs[RAPL_DOMAIN_REG_UNIT]) {
> -               if (!rd->rp->priv->reg_unit) {
> +       if (!rd->regs[RAPL_DOMAIN_REG_UNIT].val) {
> +               if (!rd->rp->priv->reg_unit.val) {
>                         pr_err("No valid Unit register found\n");
>                         return -ENODEV;
>                 }
> diff --git a/drivers/powercap/intel_rapl_msr.c b/drivers/powercap/intel_rapl_msr.c
> index 569e25eab1e1..dd471021f237 100644
> --- a/drivers/powercap/intel_rapl_msr.c
> +++ b/drivers/powercap/intel_rapl_msr.c
> @@ -34,28 +34,32 @@ static struct rapl_if_priv *rapl_msr_priv;
>
>  static struct rapl_if_priv rapl_msr_priv_intel = {
>         .type = RAPL_IF_MSR,
> -       .reg_unit = MSR_RAPL_POWER_UNIT,
> -       .regs[RAPL_DOMAIN_PACKAGE] = {
> -               MSR_PKG_POWER_LIMIT, MSR_PKG_ENERGY_STATUS, MSR_PKG_PERF_STATUS, 0, MSR_PKG_POWER_INFO },
> -       .regs[RAPL_DOMAIN_PP0] = {
> -               MSR_PP0_POWER_LIMIT, MSR_PP0_ENERGY_STATUS, 0, MSR_PP0_POLICY, 0 },
> -       .regs[RAPL_DOMAIN_PP1] = {
> -               MSR_PP1_POWER_LIMIT, MSR_PP1_ENERGY_STATUS, 0, MSR_PP1_POLICY, 0 },
> -       .regs[RAPL_DOMAIN_DRAM] = {
> -               MSR_DRAM_POWER_LIMIT, MSR_DRAM_ENERGY_STATUS, MSR_DRAM_PERF_STATUS, 0, MSR_DRAM_POWER_INFO },
> -       .regs[RAPL_DOMAIN_PLATFORM] = {
> -               MSR_PLATFORM_POWER_LIMIT, MSR_PLATFORM_ENERGY_STATUS, 0, 0, 0},
> +       .reg_unit.msr = MSR_RAPL_POWER_UNIT,
> +       .regs[RAPL_DOMAIN_PACKAGE][RAPL_DOMAIN_REG_LIMIT].msr   = MSR_PKG_POWER_LIMIT,
> +       .regs[RAPL_DOMAIN_PACKAGE][RAPL_DOMAIN_REG_STATUS].msr  = MSR_PKG_ENERGY_STATUS,
> +       .regs[RAPL_DOMAIN_PACKAGE][RAPL_DOMAIN_REG_PERF].msr    = MSR_PKG_PERF_STATUS,
> +       .regs[RAPL_DOMAIN_PACKAGE][RAPL_DOMAIN_REG_INFO].msr    = MSR_PKG_POWER_INFO,
> +       .regs[RAPL_DOMAIN_PP0][RAPL_DOMAIN_REG_LIMIT].msr       = MSR_PP0_POWER_LIMIT,
> +       .regs[RAPL_DOMAIN_PP0][RAPL_DOMAIN_REG_STATUS].msr      = MSR_PP0_ENERGY_STATUS,
> +       .regs[RAPL_DOMAIN_PP0][RAPL_DOMAIN_REG_POLICY].msr      = MSR_PP0_POLICY,
> +       .regs[RAPL_DOMAIN_PP1][RAPL_DOMAIN_REG_LIMIT].msr       = MSR_PP1_POWER_LIMIT,
> +       .regs[RAPL_DOMAIN_PP1][RAPL_DOMAIN_REG_STATUS].msr      = MSR_PP1_ENERGY_STATUS,
> +       .regs[RAPL_DOMAIN_PP1][RAPL_DOMAIN_REG_POLICY].msr      = MSR_PP1_POLICY,
> +       .regs[RAPL_DOMAIN_DRAM][RAPL_DOMAIN_REG_LIMIT].msr      = MSR_DRAM_POWER_LIMIT,
> +       .regs[RAPL_DOMAIN_DRAM][RAPL_DOMAIN_REG_STATUS].msr     = MSR_DRAM_ENERGY_STATUS,
> +       .regs[RAPL_DOMAIN_DRAM][RAPL_DOMAIN_REG_PERF].msr       = MSR_DRAM_PERF_STATUS,
> +       .regs[RAPL_DOMAIN_DRAM][RAPL_DOMAIN_REG_INFO].msr       = MSR_DRAM_POWER_INFO,
> +       .regs[RAPL_DOMAIN_PLATFORM][RAPL_DOMAIN_REG_LIMIT].msr  = MSR_PLATFORM_POWER_LIMIT,
> +       .regs[RAPL_DOMAIN_PLATFORM][RAPL_DOMAIN_REG_STATUS].msr = MSR_PLATFORM_ENERGY_STATUS,
>         .limits[RAPL_DOMAIN_PACKAGE] = BIT(POWER_LIMIT2),
>         .limits[RAPL_DOMAIN_PLATFORM] = BIT(POWER_LIMIT2),
>  };
>
>  static struct rapl_if_priv rapl_msr_priv_amd = {
>         .type = RAPL_IF_MSR,
> -       .reg_unit = MSR_AMD_RAPL_POWER_UNIT,
> -       .regs[RAPL_DOMAIN_PACKAGE] = {
> -               0, MSR_AMD_PKG_ENERGY_STATUS, 0, 0, 0 },
> -       .regs[RAPL_DOMAIN_PP0] = {
> -               0, MSR_AMD_CORE_ENERGY_STATUS, 0, 0, 0 },
> +       .reg_unit.msr = MSR_AMD_RAPL_POWER_UNIT,
> +       .regs[RAPL_DOMAIN_PACKAGE][RAPL_DOMAIN_REG_STATUS].msr  = MSR_AMD_PKG_ENERGY_STATUS,
> +       .regs[RAPL_DOMAIN_PP0][RAPL_DOMAIN_REG_STATUS].msr      = MSR_AMD_CORE_ENERGY_STATUS,
>  };
>
>  /* Handles CPU hotplug on multi-socket systems.
> @@ -99,10 +103,8 @@ static int rapl_cpu_down_prep(unsigned int cpu)
>
>  static int rapl_msr_read_raw(int cpu, struct reg_action *ra)
>  {
> -       u32 msr = (u32)ra->reg;
> -
> -       if (rdmsrl_safe_on_cpu(cpu, msr, &ra->value)) {
> -               pr_debug("failed to read msr 0x%x on cpu %d\n", msr, cpu);
> +       if (rdmsrl_safe_on_cpu(cpu, ra->reg.msr, &ra->value)) {
> +               pr_debug("failed to read msr 0x%x on cpu %d\n", ra->reg.msr, cpu);
>                 return -EIO;
>         }
>         ra->value &= ra->mask;
> @@ -112,17 +114,16 @@ static int rapl_msr_read_raw(int cpu, struct reg_action *ra)
>  static void rapl_msr_update_func(void *info)
>  {
>         struct reg_action *ra = info;
> -       u32 msr = (u32)ra->reg;
>         u64 val;
>
> -       ra->err = rdmsrl_safe(msr, &val);
> +       ra->err = rdmsrl_safe(ra->reg.msr, &val);
>         if (ra->err)
>                 return;
>
>         val &= ~ra->mask;
>         val |= ra->value;
>
> -       ra->err = wrmsrl_safe(msr, val);
> +       ra->err = wrmsrl_safe(ra->reg.msr, val);
>  }
>
>  static int rapl_msr_write_raw(int cpu, struct reg_action *ra)
> @@ -171,7 +172,7 @@ static int rapl_msr_probe(struct platform_device *pdev)
>
>         if (id) {
>                 rapl_msr_priv->limits[RAPL_DOMAIN_PACKAGE] |= BIT(POWER_LIMIT4);
> -               rapl_msr_priv->regs[RAPL_DOMAIN_PACKAGE][RAPL_DOMAIN_REG_PL4] =
> +               rapl_msr_priv->regs[RAPL_DOMAIN_PACKAGE][RAPL_DOMAIN_REG_PL4].msr =
>                         MSR_VR_CURRENT_CONFIG;
>                 pr_info("PL4 support detected.\n");
>         }
> diff --git a/drivers/powercap/intel_rapl_tpmi.c b/drivers/powercap/intel_rapl_tpmi.c
> index 4f4f13ded225..891c90fefd8b 100644
> --- a/drivers/powercap/intel_rapl_tpmi.c
> +++ b/drivers/powercap/intel_rapl_tpmi.c
> @@ -59,10 +59,10 @@ static struct powercap_control_type *tpmi_control_type;
>
>  static int tpmi_rapl_read_raw(int id, struct reg_action *ra)
>  {
> -       if (!ra->reg)
> +       if (!ra->reg.mmio)
>                 return -EINVAL;
>
> -       ra->value = readq((void __iomem *)ra->reg);
> +       ra->value = readq(ra->reg.mmio);
>
>         ra->value &= ra->mask;
>         return 0;
> @@ -72,15 +72,15 @@ static int tpmi_rapl_write_raw(int id, struct reg_action *ra)
>  {
>         u64 val;
>
> -       if (!ra->reg)
> +       if (!ra->reg.mmio)
>                 return -EINVAL;
>
> -       val = readq((void __iomem *)ra->reg);
> +       val = readq(ra->reg.mmio);
>
>         val &= ~ra->mask;
>         val |= ra->value;
>
> -       writeq(val, (void __iomem *)ra->reg);
> +       writeq(val, ra->reg.mmio);
>         return 0;
>  }
>
> @@ -138,8 +138,7 @@ static int parse_one_domain(struct tpmi_rapl_package *trp, u32 offset)
>         enum tpmi_rapl_register reg_index;
>         enum rapl_domain_reg_id reg_id;
>         int tpmi_domain_size, tpmi_domain_flags;
> -       u64 *tpmi_rapl_regs = trp->base + offset;
> -       u64 tpmi_domain_header = readq((void __iomem *)tpmi_rapl_regs);
> +       u64 tpmi_domain_header = readq(trp->base + offset);
>
>         /* Domain Parent bits are ignored for now */
>         tpmi_domain_version = tpmi_domain_header & 0xff;
> @@ -180,7 +179,7 @@ static int parse_one_domain(struct tpmi_rapl_package *trp, u32 offset)
>                 return -EINVAL;
>         }
>
> -       if (trp->priv.regs[domain_type][RAPL_DOMAIN_REG_UNIT]) {
> +       if (trp->priv.regs[domain_type][RAPL_DOMAIN_REG_UNIT].mmio) {
>                 pr_warn(FW_BUG "Duplicate Domain type %d\n", tpmi_domain_type);
>                 return -EINVAL;
>         }
> @@ -218,7 +217,7 @@ static int parse_one_domain(struct tpmi_rapl_package *trp, u32 offset)
>                 default:
>                         continue;
>                 }
> -               trp->priv.regs[domain_type][reg_id] = (u64)&tpmi_rapl_regs[reg_index];
> +               trp->priv.regs[domain_type][reg_id].mmio = trp->base + offset + reg_index * 8;
>         }
>
>         return 0;
> diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_rapl.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_rapl.c
> index 013f1633f082..2f00fc3bf274 100644
> --- a/drivers/thermal/intel/int340x_thermal/processor_thermal_rapl.c
> +++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_rapl.c
> @@ -57,10 +57,10 @@ static int rapl_mmio_cpu_down_prep(unsigned int cpu)
>
>  static int rapl_mmio_read_raw(int cpu, struct reg_action *ra)
>  {
> -       if (!ra->reg)
> +       if (!ra->reg.mmio)
>                 return -EINVAL;
>
> -       ra->value = readq((void __iomem *)ra->reg);
> +       ra->value = readq(ra->reg.mmio);
>         ra->value &= ra->mask;
>         return 0;
>  }
> @@ -69,13 +69,13 @@ static int rapl_mmio_write_raw(int cpu, struct reg_action *ra)
>  {
>         u64 val;
>
> -       if (!ra->reg)
> +       if (!ra->reg.mmio)
>                 return -EINVAL;
>
> -       val = readq((void __iomem *)ra->reg);
> +       val = readq(ra->reg.mmio);
>         val &= ~ra->mask;
>         val |= ra->value;
> -       writeq(val, (void __iomem *)ra->reg);
> +       writeq(val, ra->reg.mmio);
>         return 0;
>  }
>
> @@ -92,13 +92,13 @@ int proc_thermal_rapl_add(struct pci_dev *pdev, struct proc_thermal_device *proc
>         for (domain = RAPL_DOMAIN_PACKAGE; domain < RAPL_DOMAIN_MAX; domain++) {
>                 for (reg = RAPL_DOMAIN_REG_LIMIT; reg < RAPL_DOMAIN_REG_MAX; reg++)
>                         if (rapl_regs->regs[domain][reg])
> -                               rapl_mmio_priv.regs[domain][reg] =
> -                                               (u64)proc_priv->mmio_base +
> +                               rapl_mmio_priv.regs[domain][reg].mmio =
> +                                               proc_priv->mmio_base +
>                                                 rapl_regs->regs[domain][reg];
>                 rapl_mmio_priv.limits[domain] = rapl_regs->limits[domain];
>         }
>         rapl_mmio_priv.type = RAPL_IF_MMIO;
> -       rapl_mmio_priv.reg_unit = (u64)proc_priv->mmio_base + rapl_regs->reg_unit;
> +       rapl_mmio_priv.reg_unit.mmio = proc_priv->mmio_base + rapl_regs->reg_unit;
>
>         rapl_mmio_priv.read_raw = rapl_mmio_read_raw;
>         rapl_mmio_priv.write_raw = rapl_mmio_write_raw;
> diff --git a/include/linux/intel_rapl.h b/include/linux/intel_rapl.h
> index e6936cb25047..33f21bd85dbf 100644
> --- a/include/linux/intel_rapl.h
> +++ b/include/linux/intel_rapl.h
> @@ -100,10 +100,16 @@ struct rapl_package;
>
>  #define RAPL_DOMAIN_NAME_LENGTH 16
>
> +union rapl_reg {
> +       void __iomem *mmio;
> +       u32 msr;
> +       u64 val;
> +};
> +
>  struct rapl_domain {
>         char name[RAPL_DOMAIN_NAME_LENGTH];
>         enum rapl_domain_type id;
> -       u64 regs[RAPL_DOMAIN_REG_MAX];
> +       union rapl_reg regs[RAPL_DOMAIN_REG_MAX];
>         struct powercap_zone power_zone;
>         struct rapl_domain_data rdd;
>         struct rapl_power_limit rpl[NR_POWER_LIMITS];
> @@ -116,7 +122,7 @@ struct rapl_domain {
>  };
>
>  struct reg_action {
> -       u64 reg;
> +       union rapl_reg reg;
>         u64 mask;
>         u64 value;
>         int err;
> @@ -143,8 +149,8 @@ struct rapl_if_priv {
>         enum rapl_if_type type;
>         struct powercap_control_type *control_type;
>         enum cpuhp_state pcap_rapl_online;
> -       u64 reg_unit;
> -       u64 regs[RAPL_DOMAIN_MAX][RAPL_DOMAIN_REG_MAX];
> +       union rapl_reg reg_unit;
> +       union rapl_reg regs[RAPL_DOMAIN_MAX][RAPL_DOMAIN_REG_MAX];
>         int limits[RAPL_DOMAIN_MAX];
>         int (*read_raw)(int id, struct reg_action *ra);
>         int (*write_raw)(int id, struct reg_action *ra);
> --

Applied (with some edits in the subject and changelog) as 6.5-rc
material, thanks!

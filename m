Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1F7A1E1D3A
	for <lists+linux-pm@lfdr.de>; Tue, 26 May 2020 10:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731491AbgEZIYx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 May 2020 04:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731394AbgEZIYx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 May 2020 04:24:53 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D6ABC08C5C0
        for <linux-pm@vger.kernel.org>; Tue, 26 May 2020 01:24:53 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id k3so6934743ual.8
        for <linux-pm@vger.kernel.org>; Tue, 26 May 2020 01:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oSi+AtdhRmnPFfjArA39Nl6kTxOyVsgzR4xACr8nKSQ=;
        b=ifubUX9hVVvApdJ8/P5VSmZ8GCfF2AbdnugRMizG275kA6TAh8E/ju+Wf3jsn7UarL
         QK4MCRYHb4Rc/DhSpiedJqq2wScXnH4gBvp+szJUGRfiDLuol9krf/dd4pqwXui4EPWg
         NWo3rkuVz5nv9HAM09x51pn4ZyPbD26lZOdjqphCohbsRLqV8gCyA2zhxpp5Z1LFN8EH
         iLtOMrPdiVzvu9pEEpS1pqKVh/xlY4BYZU+RH8njyLbFgVHQBDUMbKcVR+xkfvjAFG3M
         w8gycwaEAG94yYPHLBEKgjS1d8AvKzgSLLh3c1nDZSxmi+V0121e8Gth+KqlnCAL9aHA
         j3Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oSi+AtdhRmnPFfjArA39Nl6kTxOyVsgzR4xACr8nKSQ=;
        b=t/KGjKiyyl5Z5gYDkK51EBefwg/eGQzLdHB96Kfhc4EbGUxstK4tHN/fk4PqEgv7Gl
         8Us9AdxzFgqMOeckbJe9iPXJakcjxSpUtLmEneksp4h8dU8Uf2TFvFquNg+F2n/WWidi
         zEx051WXl3XuPsGAtYOzOknC1cnHIz0UvRuLWzYYZ1JOxE12qFfW3it+4R8/Ns2WvACW
         Z1N+HQXnEoLFEDxNppw57KFbkhKb0U3Vwq1HJ7v0/OaageWsRypCJCuYagOgWO42ours
         SpnQECb/F8Pwt2KLyO8PhhHblt+T41lNnZIK1jGRkAj0Tmm1Q5iu6uyJPUVFQAng1Dtb
         zpZA==
X-Gm-Message-State: AOAM532geolmSeaTQix6WvDfWcUL2M4Bo8aQNPWY3lBgmQx0eHeNqgEC
        dfIhkmy0YvR22F9Sd6DxI+PqTliDh4mToGIp03Kohg==
X-Google-Smtp-Source: ABdhPJxgHZ4GquHP8yPjUoYR2rthkm3MhzcX6EG3uVb2Gqk13LYahLNrX0BpRmYUilySI9i2svk4UlqS6Kovqyqyxbo=
X-Received: by 2002:a9f:3701:: with SMTP id z1mr11512517uad.100.1590481491900;
 Tue, 26 May 2020 01:24:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200416085821.108778-1-stephan@gerhold.net>
In-Reply-To: <20200416085821.108778-1-stephan@gerhold.net>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 26 May 2020 10:24:15 +0200
Message-ID: <CAPDyKFq0qFjS_VB7okPdXzc0DfWf8saNax7ZsuxeUWB6svRnhQ@mail.gmail.com>
Subject: Re: [PATCH v2] cpuidle: Convert Qualcomm SPM driver to a generic
 CPUidle driver
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Lina Iyer <ilina@codeaurora.org>,
        ~postmarketos/upstreaming@lists.sr.ht, Luca Weiss <luca@z3ntu.xyz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 16 Apr 2020 at 10:59, Stephan Gerhold <stephan@gerhold.net> wrote:
>
> The Qualcomm SPM cpuidle driver seems to be the last driver still
> using the generic ARM CPUidle infrastructure.
>
> Converting it actually allows us to simplify the driver,
> and we end up being able to remove more lines than adding new ones:
>
>   - We can parse the CPUidle states in the device tree directly
>     with dt_idle_states (and don't need to duplicate that
>     functionality into the spm driver).
>
>   - Each "saw" device managed by the SPM driver now directly
>     registers its own cpuidle driver, removing the need for
>     any global (per cpu) state.
>
> The device tree binding is the same, so the driver stays
> compatible with all old device trees.
>
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>

Rafael, I think we all believed that you were intending to pick this
up. Is there anything additional you need to make that happen?

FYI, this allows further cleanup to be made on the ARM cpuidle code.
Both in arch and cpuidle code.

Kind regards
Uffe

> ---
> Related change for the PSCI cpuidle driver:
>   https://lore.kernel.org/linux-pm/cover.1565348376.git.lorenzo.pieralisi@arm.com/
> (converting the QCOM SPM driver was mentioned there)
>
> Changes in v2:
>   - Rebase on top of linux-next, fix conflicts
>     (Apparently sending shortly before the end of the merge window
>      was a bad idea... ;) )
>
> v1: https://lore.kernel.org/linux-arm-msm/20200405162052.53622-1-stephan@gerhold.net/
> ---
>  MAINTAINERS                                   |   1 +
>  drivers/cpuidle/Kconfig.arm                   |  13 ++
>  drivers/cpuidle/Makefile                      |   1 +
>  .../qcom/spm.c => cpuidle/cpuidle-qcom-spm.c} | 138 +++++++-----------
>  drivers/soc/qcom/Kconfig                      |  10 --
>  drivers/soc/qcom/Makefile                     |   1 -
>  6 files changed, 67 insertions(+), 97 deletions(-)
>  rename drivers/{soc/qcom/spm.c => cpuidle/cpuidle-qcom-spm.c} (75%)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e64e5db31497..2fd05a6835a6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2223,6 +2223,7 @@ F:        drivers/*/qcom*
>  F:     drivers/*/qcom/
>  F:     drivers/bluetooth/btqcomsmd.c
>  F:     drivers/clocksource/timer-qcom.c
> +F:     drivers/cpuidle/cpuidle-qcom-spm.c
>  F:     drivers/extcon/extcon-qcom*
>  F:     drivers/i2c/busses/i2c-qcom-geni.c
>  F:     drivers/i2c/busses/i2c-qup.c
> diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
> index 99a2d72ac02b..51a7e89085c0 100644
> --- a/drivers/cpuidle/Kconfig.arm
> +++ b/drivers/cpuidle/Kconfig.arm
> @@ -94,3 +94,16 @@ config ARM_TEGRA_CPUIDLE
>         select ARM_CPU_SUSPEND
>         help
>           Select this to enable cpuidle for NVIDIA Tegra20/30/114/124 SoCs.
> +
> +config ARM_QCOM_SPM_CPUIDLE
> +       bool "CPU Idle Driver for Qualcomm Subsystem Power Manager (SPM)"
> +       depends on (ARCH_QCOM || COMPILE_TEST) && !ARM64
> +       select ARM_CPU_SUSPEND
> +       select CPU_IDLE_MULTIPLE_DRIVERS
> +       select DT_IDLE_STATES
> +       select QCOM_SCM
> +       help
> +         Select this to enable cpuidle for Qualcomm processors.
> +         The Subsystem Power Manager (SPM) controls low power modes for the
> +         CPU and L2 cores. It interface with various system drivers to put
> +         the cores in low power modes.
> diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
> index 55a464f6a78b..f07800cbb43f 100644
> --- a/drivers/cpuidle/Makefile
> +++ b/drivers/cpuidle/Makefile
> @@ -25,6 +25,7 @@ obj-$(CONFIG_ARM_PSCI_CPUIDLE)                += cpuidle_psci.o
>  cpuidle_psci-y                         := cpuidle-psci.o
>  cpuidle_psci-$(CONFIG_PM_GENERIC_DOMAINS_OF) += cpuidle-psci-domain.o
>  obj-$(CONFIG_ARM_TEGRA_CPUIDLE)                += cpuidle-tegra.o
> +obj-$(CONFIG_ARM_QCOM_SPM_CPUIDLE)     += cpuidle-qcom-spm.o
>
>  ###############################################################################
>  # MIPS drivers
> diff --git a/drivers/soc/qcom/spm.c b/drivers/cpuidle/cpuidle-qcom-spm.c
> similarity index 75%
> rename from drivers/soc/qcom/spm.c
> rename to drivers/cpuidle/cpuidle-qcom-spm.c
> index 8e10e02c6aa5..adf91a6e4d7d 100644
> --- a/drivers/soc/qcom/spm.c
> +++ b/drivers/cpuidle/cpuidle-qcom-spm.c
> @@ -19,10 +19,11 @@
>  #include <linux/cpu_pm.h>
>  #include <linux/qcom_scm.h>
>
> -#include <asm/cpuidle.h>
>  #include <asm/proc-fns.h>
>  #include <asm/suspend.h>
>
> +#include "dt_idle_states.h"
> +
>  #define MAX_PMIC_DATA          2
>  #define MAX_SEQ_DATA           64
>  #define SPM_CTL_INDEX          0x7f
> @@ -62,6 +63,7 @@ struct spm_reg_data {
>  };
>
>  struct spm_driver_data {
> +       struct cpuidle_driver cpuidle_driver;
>         void __iomem *reg_base;
>         const struct spm_reg_data *reg_data;
>  };
> @@ -107,11 +109,6 @@ static const struct spm_reg_data spm_reg_8064_cpu = {
>         .start_index[PM_SLEEP_MODE_SPC] = 2,
>  };
>
> -static DEFINE_PER_CPU(struct spm_driver_data *, cpu_spm_drv);
> -
> -typedef int (*idle_fn)(void);
> -static DEFINE_PER_CPU(idle_fn*, qcom_idle_ops);
> -
>  static inline void spm_register_write(struct spm_driver_data *drv,
>                                         enum spm_reg reg, u32 val)
>  {
> @@ -172,10 +169,9 @@ static int qcom_pm_collapse(unsigned long int unused)
>         return -1;
>  }
>
> -static int qcom_cpu_spc(void)
> +static int qcom_cpu_spc(struct spm_driver_data *drv)
>  {
>         int ret;
> -       struct spm_driver_data *drv = __this_cpu_read(cpu_spm_drv);
>
>         spm_set_low_power_mode(drv, PM_SLEEP_MODE_SPC);
>         ret = cpu_suspend(0, qcom_pm_collapse);
> @@ -190,94 +186,49 @@ static int qcom_cpu_spc(void)
>         return ret;
>  }
>
> -static int qcom_idle_enter(unsigned long index)
> +static int spm_enter_idle_state(struct cpuidle_device *dev,
> +                               struct cpuidle_driver *drv, int idx)
>  {
> -       return __this_cpu_read(qcom_idle_ops)[index]();
> +       struct spm_driver_data *data = container_of(drv, struct spm_driver_data,
> +                                                   cpuidle_driver);
> +
> +       return CPU_PM_CPU_IDLE_ENTER_PARAM(qcom_cpu_spc, idx, data);
>  }
>
> -static const struct of_device_id qcom_idle_state_match[] __initconst = {
> -       { .compatible = "qcom,idle-state-spc", .data = qcom_cpu_spc },
> +static struct cpuidle_driver qcom_spm_idle_driver = {
> +       .name = "qcom_spm",
> +       .owner = THIS_MODULE,
> +       .states[0] = {
> +               .enter                  = spm_enter_idle_state,
> +               .exit_latency           = 1,
> +               .target_residency       = 1,
> +               .power_usage            = UINT_MAX,
> +               .name                   = "WFI",
> +               .desc                   = "ARM WFI",
> +       }
> +};
> +
> +static const struct of_device_id qcom_idle_state_match[] = {
> +       { .compatible = "qcom,idle-state-spc", .data = spm_enter_idle_state },
>         { },
>  };
>
> -static int __init qcom_cpuidle_init(struct device_node *cpu_node, int cpu)
> +static int spm_cpuidle_init(struct cpuidle_driver *drv, int cpu)
>  {
> -       const struct of_device_id *match_id;
> -       struct device_node *state_node;
> -       int i;
> -       int state_count = 1;
> -       idle_fn idle_fns[CPUIDLE_STATE_MAX];
> -       idle_fn *fns;
> -       cpumask_t mask;
> -       bool use_scm_power_down = false;
> -
> -       if (!qcom_scm_is_available())
> -               return -EPROBE_DEFER;
> -
> -       for (i = 0; ; i++) {
> -               state_node = of_parse_phandle(cpu_node, "cpu-idle-states", i);
> -               if (!state_node)
> -                       break;
> -
> -               if (!of_device_is_available(state_node))
> -                       continue;
> -
> -               if (i == CPUIDLE_STATE_MAX) {
> -                       pr_warn("%s: cpuidle states reached max possible\n",
> -                                       __func__);
> -                       break;
> -               }
> -
> -               match_id = of_match_node(qcom_idle_state_match, state_node);
> -               if (!match_id)
> -                       return -ENODEV;
> -
> -               idle_fns[state_count] = match_id->data;
> -
> -               /* Check if any of the states allow power down */
> -               if (match_id->data == qcom_cpu_spc)
> -                       use_scm_power_down = true;
> -
> -               state_count++;
> -       }
> -
> -       if (state_count == 1)
> -               goto check_spm;
> -
> -       fns = devm_kcalloc(get_cpu_device(cpu), state_count, sizeof(*fns),
> -                       GFP_KERNEL);
> -       if (!fns)
> -               return -ENOMEM;
> -
> -       for (i = 1; i < state_count; i++)
> -               fns[i] = idle_fns[i];
> +       int ret;
>
> -       if (use_scm_power_down) {
> -               /* We have atleast one power down mode */
> -               cpumask_clear(&mask);
> -               cpumask_set_cpu(cpu, &mask);
> -               qcom_scm_set_warm_boot_addr(cpu_resume_arm, &mask);
> -       }
> +       memcpy(drv, &qcom_spm_idle_driver, sizeof(*drv));
> +       drv->cpumask = (struct cpumask *)cpumask_of(cpu);
>
> -       per_cpu(qcom_idle_ops, cpu) = fns;
> +       /* Parse idle states from device tree */
> +       ret = dt_init_idle_driver(drv, qcom_idle_state_match, 1);
> +       if (ret <= 0)
> +               return ret ? : -ENODEV;
>
> -       /*
> -        * SPM probe for the cpu should have happened by now, if the
> -        * SPM device does not exist, return -ENXIO to indicate that the
> -        * cpu does not support idle states.
> -        */
> -check_spm:
> -       return per_cpu(cpu_spm_drv, cpu) ? 0 : -ENXIO;
> +       /* We have atleast one power down mode */
> +       return qcom_scm_set_warm_boot_addr(cpu_resume_arm, drv->cpumask);
>  }
>
> -static const struct cpuidle_ops qcom_cpuidle_ops __initconst = {
> -       .suspend = qcom_idle_enter,
> -       .init = qcom_cpuidle_init,
> -};
> -
> -CPUIDLE_METHOD_OF_DECLARE(qcom_idle_v1, "qcom,kpss-acc-v1", &qcom_cpuidle_ops);
> -CPUIDLE_METHOD_OF_DECLARE(qcom_idle_v2, "qcom,kpss-acc-v2", &qcom_cpuidle_ops);
> -
>  static struct spm_driver_data *spm_get_drv(struct platform_device *pdev,
>                 int *spm_cpu)
>  {
> @@ -323,11 +274,15 @@ static int spm_dev_probe(struct platform_device *pdev)
>         struct resource *res;
>         const struct of_device_id *match_id;
>         void __iomem *addr;
> -       int cpu;
> +       int cpu, ret;
> +
> +       if (!qcom_scm_is_available())
> +               return -EPROBE_DEFER;
>
>         drv = spm_get_drv(pdev, &cpu);
>         if (!drv)
>                 return -EINVAL;
> +       platform_set_drvdata(pdev, drv);
>
>         res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>         drv->reg_base = devm_ioremap_resource(&pdev->dev, res);
> @@ -340,6 +295,10 @@ static int spm_dev_probe(struct platform_device *pdev)
>
>         drv->reg_data = match_id->data;
>
> +       ret = spm_cpuidle_init(&drv->cpuidle_driver, cpu);
> +       if (ret)
> +               return ret;
> +
>         /* Write the SPM sequences first.. */
>         addr = drv->reg_base + drv->reg_data->reg_offset[SPM_REG_SEQ_ENTRY];
>         __iowrite32_copy(addr, drv->reg_data->seq,
> @@ -362,13 +321,20 @@ static int spm_dev_probe(struct platform_device *pdev)
>         /* Set up Standby as the default low power mode */
>         spm_set_low_power_mode(drv, PM_SLEEP_MODE_STBY);
>
> -       per_cpu(cpu_spm_drv, cpu) = drv;
> +       return cpuidle_register(&drv->cpuidle_driver, NULL);
> +}
> +
> +static int spm_dev_remove(struct platform_device *pdev)
> +{
> +       struct spm_driver_data *drv = platform_get_drvdata(pdev);
>
> +       cpuidle_unregister(&drv->cpuidle_driver);
>         return 0;
>  }
>
>  static struct platform_driver spm_driver = {
>         .probe = spm_dev_probe,
> +       .remove = spm_dev_remove,
>         .driver = {
>                 .name = "saw",
>                 .of_match_table = spm_match_table,
> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> index bf42a17a45de..285baa7e474e 100644
> --- a/drivers/soc/qcom/Kconfig
> +++ b/drivers/soc/qcom/Kconfig
> @@ -80,16 +80,6 @@ config QCOM_PDR_HELPERS
>         tristate
>         select QCOM_QMI_HELPERS
>
> -config QCOM_PM
> -       bool "Qualcomm Power Management"
> -       depends on ARCH_QCOM && !ARM64
> -       select ARM_CPU_SUSPEND
> -       select QCOM_SCM
> -       help
> -         QCOM Platform specific power driver to manage cores and L2 low power
> -         modes. It interface with various system drivers to put the cores in
> -         low power modes.
> -
>  config QCOM_QMI_HELPERS
>         tristate
>         depends on NET
> diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
> index 5d6b83dc58e8..92cc4232d72c 100644
> --- a/drivers/soc/qcom/Makefile
> +++ b/drivers/soc/qcom/Makefile
> @@ -8,7 +8,6 @@ obj-$(CONFIG_QCOM_GSBI) +=      qcom_gsbi.o
>  obj-$(CONFIG_QCOM_MDT_LOADER)  += mdt_loader.o
>  obj-$(CONFIG_QCOM_OCMEM)       += ocmem.o
>  obj-$(CONFIG_QCOM_PDR_HELPERS) += pdr_interface.o
> -obj-$(CONFIG_QCOM_PM)  +=      spm.o
>  obj-$(CONFIG_QCOM_QMI_HELPERS) += qmi_helpers.o
>  qmi_helpers-y  += qmi_encdec.o qmi_interface.o
>  obj-$(CONFIG_QCOM_RMTFS_MEM)   += rmtfs_mem.o
> --
> 2.26.1
>

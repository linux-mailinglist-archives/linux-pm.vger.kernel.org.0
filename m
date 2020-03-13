Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D964184879
	for <lists+linux-pm@lfdr.de>; Fri, 13 Mar 2020 14:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgCMNwl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Mar 2020 09:52:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:51480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726323AbgCMNwk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 13 Mar 2020 09:52:40 -0400
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D67FF2074C;
        Fri, 13 Mar 2020 13:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584107559;
        bh=Uo31ewP+/PXXv7NHEny0wiYtZ/dDkUb+jY51sW/nxjA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=yq4tTMqNNpaPtv+8xoY85Pt+Pz6hrjcIaVW9telePW6uQHvnzraj/c1KCrj/Nwx3S
         cmhi99CBv3i3qy10AyVACsq6sOjyvHt+mvvGGGHxmPN6hip8sjWvOrFuNoHDtecMtt
         V3CuwHk131953VnrPDuWPKhLVnq+6pqAYJRnGIsg=
Received: by mail-lf1-f50.google.com with SMTP id b13so7934599lfb.12;
        Fri, 13 Mar 2020 06:52:38 -0700 (PDT)
X-Gm-Message-State: ANhLgQ3jzen1wqQoK/wpQGMrU1+jMl3Vrbx40yJEIFXetUg1uMfVf7as
        uYkLwiUWjHeagXX0MJcEJYHxT9At47SYLfnZpYs=
X-Google-Smtp-Source: ADFU+vs2p31zuqJ5xltHH34pjCGngOoKf0FQoMUKlPx4MFaSj9NMaEL0kSgcycGnolpkqNE3HIsaspbpOXFv6FZWQVE=
X-Received: by 2002:ac2:4c85:: with SMTP id d5mr8537761lfl.94.1584107556806;
 Fri, 13 Mar 2020 06:52:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200219205546.6800-1-ansuelsmth@gmail.com>
In-Reply-To: <20200219205546.6800-1-ansuelsmth@gmail.com>
From:   Ilia Lin <ilia.lin@kernel.org>
Date:   Fri, 13 Mar 2020 15:52:25 +0200
X-Gmail-Original-Message-ID: <CA+5LGR1tcKvoj0ON_OJ17UmnuVpo_iv1NdFiiJSrfDJgoy1ZDw@mail.gmail.com>
Message-ID: <CA+5LGR1tcKvoj0ON_OJ17UmnuVpo_iv1NdFiiJSrfDJgoy1ZDw@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: qcom: Add support for krait based socs
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Sricharan R <sricharan@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

See inline.



On Wed, Feb 19, 2020 at 10:56 PM Ansuel Smith <ansuelsmth@gmail.com> wrote:
>
> In Certain QCOM SoCs like ipq8064, apq8064, msm8960, msm8974
> that has KRAIT processors the voltage/current value of each OPP
> varies based on the silicon variant in use.
>
> The required OPP related data is determined based on
> the efuse value. This is similar to the existing code for
> kryo cores. So adding support for krait cores here.
>
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  .../bindings/opp/qcom-nvmem-cpufreq.txt       |   3 +-
>  drivers/cpufreq/Kconfig.arm                   |   2 +-
>  drivers/cpufreq/cpufreq-dt-platdev.c          |   5 +
>  drivers/cpufreq/qcom-cpufreq-nvmem.c          | 181 ++++++++++++++++--
>  4 files changed, 173 insertions(+), 18 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt b/Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt
> index 4751029b9b74..64f07417ecfb 100644
> --- a/Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt
> +++ b/Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt
> @@ -19,7 +19,8 @@ In 'cpu' nodes:
>
>  In 'operating-points-v2' table:
>  - compatible: Should be
> -       - 'operating-points-v2-kryo-cpu' for apq8096 and msm8996.
> +       - 'operating-points-v2-kryo-cpu' for apq8096, msm8996, msm8974,
> +                                            apq8064, ipq8064, msm8960 and ipq8074.
>
>  Optional properties:
>  --------------------
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index 3858d86cf409..15c1a1231516 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -128,7 +128,7 @@ config ARM_OMAP2PLUS_CPUFREQ
>
>  config ARM_QCOM_CPUFREQ_NVMEM
>         tristate "Qualcomm nvmem based CPUFreq"
> -       depends on ARM64
> +       depends on ARCH_QCOM
>         depends on QCOM_QFPROM
>         depends on QCOM_SMEM
>         select PM_OPP
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index f2ae9cd455c1..cb9db16bea61 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -141,6 +141,11 @@ static const struct of_device_id blacklist[] __initconst = {
>         { .compatible = "ti,dra7", },
>         { .compatible = "ti,omap3", },
>
> +       { .compatible = "qcom,ipq8064", },
> +       { .compatible = "qcom,apq8064", },
> +       { .compatible = "qcom,msm8974", },
> +       { .compatible = "qcom,msm8960", },
> +
>         { }
>  };
>
> diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> index f0d2d5035413..35a616189030 100644
> --- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
> +++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> @@ -49,12 +49,14 @@ struct qcom_cpufreq_drv;
>  struct qcom_cpufreq_match_data {
>         int (*get_version)(struct device *cpu_dev,
>                            struct nvmem_cell *speedbin_nvmem,
> +                          char **pvs_name,
>                            struct qcom_cpufreq_drv *drv);
>         const char **genpd_names;
>  };
>
>  struct qcom_cpufreq_drv {
> -       struct opp_table **opp_tables;
> +       struct opp_table **names_opp_tables;
> +       struct opp_table **hw_opp_tables;
>         struct opp_table **genpd_opp_tables;
>         u32 versions;
>         const struct qcom_cpufreq_match_data *data;
> @@ -62,6 +64,81 @@ struct qcom_cpufreq_drv {
>
>  static struct platform_device *cpufreq_dt_pdev, *cpufreq_pdev;
>
> +static void get_krait_bin_format_a(struct device *cpu_dev,
> +                                         int *speed, int *pvs, int *pvs_ver,
> +                                         struct nvmem_cell *pvs_nvmem, u8 *buf)
> +{
> +       u32 pte_efuse;
> +
> +       pte_efuse = *((u32 *)buf);
> +
> +       *speed = pte_efuse & 0xf;
> +       if (*speed == 0xf)
> +               *speed = (pte_efuse >> 4) & 0xf;
> +
> +       if (*speed == 0xf) {
> +               *speed = 0;
> +               dev_warn(cpu_dev, "Speed bin: Defaulting to %d\n", *speed);
> +       } else {
> +               dev_dbg(cpu_dev, "Speed bin: %d\n", *speed);
> +       }
> +
> +       *pvs = (pte_efuse >> 10) & 0x7;
> +       if (*pvs == 0x7)
> +               *pvs = (pte_efuse >> 13) & 0x7;
> +
> +       if (*pvs == 0x7) {
> +               *pvs = 0;
> +               dev_warn(cpu_dev, "PVS bin: Defaulting to %d\n", *pvs);
> +       } else {
> +               dev_dbg(cpu_dev, "PVS bin: %d\n", *pvs);
> +       }
> +}
> +
> +static void get_krait_bin_format_b(struct device *cpu_dev,
> +                                         int *speed, int *pvs, int *pvs_ver,
> +                                         struct nvmem_cell *pvs_nvmem, u8 *buf)
> +{
> +       u32 pte_efuse, redundant_sel;
> +
> +       pte_efuse = *((u32 *)buf);
> +       redundant_sel = (pte_efuse >> 24) & 0x7;
> +       *speed = pte_efuse & 0x7;
Why wouldn't you move this into the switch?
> +
> +       /* 4 bits of PVS are in efuse register bits 31, 8-6. */
> +       *pvs = ((pte_efuse >> 28) & 0x8) | ((pte_efuse >> 6) & 0x7);
> +       *pvs_ver = (pte_efuse >> 4) & 0x3;
Same as above.
> +
> +       switch (redundant_sel) {
> +       case 1:
> +               *speed = (pte_efuse >> 27) & 0xf;
> +               break;
> +       case 2:
> +               *pvs = (pte_efuse >> 27) & 0xf;
> +               break;
IMHO, it is worth to handle the default case here.
> +       }
> +
> +       /* Check SPEED_BIN_BLOW_STATUS */
> +       if (pte_efuse & BIT(3)) {
> +               dev_dbg(cpu_dev, "Speed bin: %d\n", *speed);
> +       } else {
> +               dev_warn(cpu_dev, "Speed bin not set. Defaulting to 0!\n");
> +               *speed = 0;
> +       }
> +
> +       /* Check PVS_BLOW_STATUS */
> +       pte_efuse = *(((u32 *)buf) + 4);
> +       pte_efuse &= BIT(21);
> +       if (pte_efuse) {
> +               dev_dbg(cpu_dev, "PVS bin: %d\n", *pvs);
> +       } else {
> +               dev_warn(cpu_dev, "PVS bin not set. Defaulting to 0!\n");
> +               *pvs = 0;
> +       }
> +
> +       dev_dbg(cpu_dev, "PVS version: %d\n", *pvs_ver);
> +}
> +
>  static enum _msm8996_version qcom_cpufreq_get_msm_id(void)
>  {
>         size_t len;
> @@ -93,11 +170,13 @@ static enum _msm8996_version qcom_cpufreq_get_msm_id(void)
>
>  static int qcom_cpufreq_kryo_name_version(struct device *cpu_dev,
>                                           struct nvmem_cell *speedbin_nvmem,
> +                                         char **pvs_name,
>                                           struct qcom_cpufreq_drv *drv)
>  {
>         size_t len;
>         u8 *speedbin;
>         enum _msm8996_version msm8996_version;
> +       *pvs_name = NULL;
>
>         msm8996_version = qcom_cpufreq_get_msm_id();
>         if (NUM_OF_MSM8996_VERSIONS == msm8996_version) {
> @@ -125,10 +204,44 @@ static int qcom_cpufreq_kryo_name_version(struct device *cpu_dev,
>         return 0;
>  }
>
> +static int qcom_cpufreq_krait_name_version(struct device *cpu_dev,
> +                                          struct nvmem_cell *speedbin_nvmem,
> +                                          char **pvs_name,
> +                                          struct qcom_cpufreq_drv *drv)
> +{
> +       int speed = 0, pvs = 0, pvs_ver = 0;
> +       u8 *speedbin;
> +       size_t len;
> +
> +       speedbin = nvmem_cell_read(speedbin_nvmem, &len);
> +       if (len == 4) {
Preferably doing this with switch-case.
> +               get_krait_bin_format_a(cpu_dev, &speed, &pvs, &pvs_ver,
> +                                      speedbin_nvmem, speedbin);
> +       } else if (len == 8) {
> +               get_krait_bin_format_b(cpu_dev, &speed, &pvs, &pvs_ver,
> +                                      speedbin_nvmem, speedbin);
> +       } else {
> +               dev_err(cpu_dev, "Unable to read nvmem data. Defaulting to 0!\n");
> +               return -ENODEV;
> +       }
> +
> +       snprintf(*pvs_name, sizeof("speedXX-pvsXX-vXX"), "speed%d-pvs%d-v%d",
> +                speed, pvs, pvs_ver);
> +
> +       drv->versions = (1 << speed);
> +
> +       kfree(speedbin);
> +       return 0;
> +}
> +
>  static const struct qcom_cpufreq_match_data match_data_kryo = {
>         .get_version = qcom_cpufreq_kryo_name_version,
>  };
>
> +static const struct qcom_cpufreq_match_data match_data_krait = {
> +       .get_version = qcom_cpufreq_krait_name_version,
> +};
> +
>  static const char *qcs404_genpd_names[] = { "cpr", NULL };
>
>  static const struct qcom_cpufreq_match_data match_data_qcs404 = {
> @@ -141,6 +254,7 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
>         struct nvmem_cell *speedbin_nvmem;
>         struct device_node *np;
>         struct device *cpu_dev;
> +       char *pvs_name = "speedXX-pvsXX-vXX";
>         unsigned cpu;
>         const struct of_device_id *match;
>         int ret;
> @@ -153,7 +267,7 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
>         if (!np)
>                 return -ENOENT;
>
> -       ret = of_device_is_compatible(np, "operating-points-v2-kryo-cpu");
> +       ret = of_device_is_compatible(np, "operating-points-v2-qcom-cpu");
>         if (!ret) {
>                 of_node_put(np);
>                 return -ENOENT;
> @@ -181,7 +295,8 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
>                         goto free_drv;
>                 }
>
> -               ret = drv->data->get_version(cpu_dev, speedbin_nvmem, drv);
> +               ret = drv->data->get_version(cpu_dev,
> +                                                       speedbin_nvmem, &pvs_name, drv);
>                 if (ret) {
>                         nvmem_cell_put(speedbin_nvmem);
>                         goto free_drv;
> @@ -190,12 +305,20 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
>         }
>         of_node_put(np);
>
> -       drv->opp_tables = kcalloc(num_possible_cpus(), sizeof(*drv->opp_tables),
> +       drv->names_opp_tables = kcalloc(num_possible_cpus(),
> +                                 sizeof(*drv->names_opp_tables),
>                                   GFP_KERNEL);
> -       if (!drv->opp_tables) {
> +       if (!drv->names_opp_tables) {
>                 ret = -ENOMEM;
>                 goto free_drv;
>         }
> +       drv->hw_opp_tables = kcalloc(num_possible_cpus(),
> +                                 sizeof(*drv->hw_opp_tables),
> +                                 GFP_KERNEL);
> +       if (!drv->hw_opp_tables) {
> +               ret = -ENOMEM;
> +               goto free_opp1;
> +       }
>
>         drv->genpd_opp_tables = kcalloc(num_possible_cpus(),
>                                         sizeof(*drv->genpd_opp_tables),
> @@ -213,11 +336,23 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
>                 }
>
>                 if (drv->data->get_version) {
> -                       drv->opp_tables[cpu] =
> -                               dev_pm_opp_set_supported_hw(cpu_dev,
> -                                                           &drv->versions, 1);
> -                       if (IS_ERR(drv->opp_tables[cpu])) {
> -                               ret = PTR_ERR(drv->opp_tables[cpu]);
> +
> +                       if (pvs_name) {
> +                               drv->names_opp_tables[cpu] = dev_pm_opp_set_prop_name(
> +                                                                    cpu_dev,
> +                                                                    pvs_name);
> +                               if (IS_ERR(drv->names_opp_tables[cpu])) {
> +                                       ret = PTR_ERR(drv->names_opp_tables[cpu]);
> +                                       dev_err(cpu_dev, "Failed to add OPP name %s\n",
> +                                               pvs_name);
> +                                       goto free_opp;
> +                               }
> +                       }
> +
> +                       drv->hw_opp_tables[cpu] = dev_pm_opp_set_supported_hw(
> +                                                                        cpu_dev, &drv->versions, 1);
> +                       if (IS_ERR(drv->hw_opp_tables[cpu])) {
> +                               ret = PTR_ERR(drv->hw_opp_tables[cpu]);
>                                 dev_err(cpu_dev,
>                                         "Failed to set supported hardware\n");
>                                 goto free_genpd_opp;
> @@ -259,11 +394,18 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
>         kfree(drv->genpd_opp_tables);
>  free_opp:
>         for_each_possible_cpu(cpu) {
> -               if (IS_ERR_OR_NULL(drv->opp_tables[cpu]))
> +               if (IS_ERR_OR_NULL(drv->names_opp_tables[cpu]))
> +                       break;
> +               dev_pm_opp_put_prop_name(drv->names_opp_tables[cpu]);
> +       }
> +       for_each_possible_cpu(cpu) {
> +               if (IS_ERR_OR_NULL(drv->hw_opp_tables[cpu]))
>                         break;
> -               dev_pm_opp_put_supported_hw(drv->opp_tables[cpu]);
> +               dev_pm_opp_put_supported_hw(drv->hw_opp_tables[cpu]);
>         }
> -       kfree(drv->opp_tables);
> +       kfree(drv->hw_opp_tables);
> +free_opp1:
Please, use better naming here.
> +       kfree(drv->names_opp_tables);
>  free_drv:
>         kfree(drv);
>
> @@ -278,13 +420,16 @@ static int qcom_cpufreq_remove(struct platform_device *pdev)
>         platform_device_unregister(cpufreq_dt_pdev);
>
>         for_each_possible_cpu(cpu) {
> -               if (drv->opp_tables[cpu])
> -                       dev_pm_opp_put_supported_hw(drv->opp_tables[cpu]);
> +               if (drv->names_opp_tables[cpu])
> +                       dev_pm_opp_put_supported_hw(drv->names_opp_tables[cpu]);
> +               if (drv->hw_opp_tables[cpu])
> +                       dev_pm_opp_put_supported_hw(drv->hw_opp_tables[cpu]);
>                 if (drv->genpd_opp_tables[cpu])
>                         dev_pm_opp_detach_genpd(drv->genpd_opp_tables[cpu]);
>         }
>
> -       kfree(drv->opp_tables);
> +       kfree(drv->names_opp_tables);
> +       kfree(drv->hw_opp_tables);
>         kfree(drv->genpd_opp_tables);
>         kfree(drv);
>
> @@ -303,6 +448,10 @@ static const struct of_device_id qcom_cpufreq_match_list[] __initconst = {
>         { .compatible = "qcom,apq8096", .data = &match_data_kryo },
>         { .compatible = "qcom,msm8996", .data = &match_data_kryo },
>         { .compatible = "qcom,qcs404", .data = &match_data_qcs404 },
> +       { .compatible = "qcom,ipq8064", .data = &match_data_krait },
> +       { .compatible = "qcom,apq8064", .data = &match_data_krait },
> +       { .compatible = "qcom,msm8974", .data = &match_data_krait },
> +       { .compatible = "qcom,msm8960", .data = &match_data_krait },
>         {},
>  };
>
> --
> 2.25.0
>

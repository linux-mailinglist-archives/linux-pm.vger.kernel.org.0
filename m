Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18CE16E65DF
	for <lists+linux-pm@lfdr.de>; Tue, 18 Apr 2023 15:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbjDRN3W convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Tue, 18 Apr 2023 09:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbjDRN3S (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Apr 2023 09:29:18 -0400
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA6C21444D;
        Tue, 18 Apr 2023 06:29:16 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-94a342f4c8eso120649266b.0;
        Tue, 18 Apr 2023 06:29:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681824555; x=1684416555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZCGJZmiDaXUr6E+Un0VfEGsGoElU57wR/KiS8iD8bVA=;
        b=FvlVE4kEA/LSR5Wm0E3cBqdbpv2wU29wBEaWjlS8jIQA0jriiJxAZo5fn3hU1FHPq+
         q0sLPevk8Jq3P6Em1/k8IhWG1X7v15sspMECIVV6deqSUgOJ4j9/Itd7gy406QGJwbih
         dDu7K+vJ5nfXCtgulS8VcvdFt0LPF8IPbXUKuwVJv37lnJ0DZzakASh0YQ7wEla1UncX
         m3BrujxmcfvYqdv8Dn25sXJicxlzX9vQ5OnNX2kg4s8vSSTAzhi6/YgYJjR06lO/5uTS
         sWkqSKZFUnN/2aORSX803o8lP9ONEsURWqSYuUpvJZHgcAI+j/73cUkbZNEc8lKIk07U
         aSpA==
X-Gm-Message-State: AAQBX9eM38JcNoyoWxev0AefjrvLdHNxPFE28pYWVaJo6d1NOiSHZ7C5
        CRY9uVDfHlQlnRtVZxwvCstw5gfPVXdqEMUoBkA=
X-Google-Smtp-Source: AKy350ZWQq0rKulBEIjTFrkiWvQTFsfl7bsAYBld8ZhslWjQDt5epqPSFTPq0C+MxXIakpzAt957V2wsF+xgJIy/vww=
X-Received: by 2002:a17:906:7a45:b0:94e:9235:d77e with SMTP id
 i5-20020a1709067a4500b0094e9235d77emr10564133ejo.3.1681824554867; Tue, 18 Apr
 2023 06:29:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230413213753.129962-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20230413213753.129962-1-srinivas.pandruvada@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 18 Apr 2023 15:29:03 +0200
Message-ID: <CAJZ5v0hEr=NXs4O9LidkT1LYdwa_Pbr2Z3CYHncCzOaQt6jsrg@mail.gmail.com>
Subject: Re: [PATCH v2] thermal/drivers/intel/int340x: Add DLVR support
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     rafael@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Apr 13, 2023 at 11:38 PM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> Add support for DLVR (Digital Linear Voltage Regulator) attributes,
> which can be used to control RFIM.
> Here instead of "fivr" another directory "dlvr" is created with DLVR
> attributes:
>
> /sys/bus/pci/devices/0000:00:04.0/dlvr
> ├── dlvr_freq_mhz
> ├── dlvr_freq_select
> ├── dlvr_hardware_rev
> ├── dlvr_pll_busy
> ├── dlvr_rfim_enable
> └── dlvr_spread_spectrum_pct
> └── dlvr_control_mode
> └── dlvr_control_lock
>
> Attributes
> dlvr_freq_mhz (RO):
> Current DLVR PLL frequency in MHz.
>
> dlvr_freq_select (RW):
> Sets DLVR PLL clock frequency.
>
> dlvr_hardware_rev (RO):
> DLVR hardware revision.
>
> dlvr_pll_busy (RO):
> PLL can't accept frequency change when set.
>
> dlvr_rfim_enable (RW):
> 0: Disable RF frequency hopping, 1: Enable RF frequency hopping.
>
> dlvr_control_mode (RW):
> Specifies how frequencies are spread. 0: Down spread, 1: Spread in Center.
>
> dlvr_control_lock (RW):
> 1: future writes are ignored.
>
> dlvr_spread_spectrum_pct (RW)
> A write to this register updates the DLVR spread spectrum percent value.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
> v2
> - Updated documentation
> - Added dlvr_control_lock attribute
>
>  .../driver-api/thermal/intel_dptf.rst         | 46 +++++++++-
>  .../processor_thermal_device.c                |  3 +-
>  .../processor_thermal_device.h                |  1 +
>  .../processor_thermal_device_pci.c            |  2 +-
>  .../int340x_thermal/processor_thermal_rfim.c  | 92 ++++++++++++++++++-
>  5 files changed, 135 insertions(+), 9 deletions(-)
>
> diff --git a/Documentation/driver-api/thermal/intel_dptf.rst b/Documentation/driver-api/thermal/intel_dptf.rst
> index f5c193cccbda..9ab4316322a1 100644
> --- a/Documentation/driver-api/thermal/intel_dptf.rst
> +++ b/Documentation/driver-api/thermal/intel_dptf.rst
> @@ -184,8 +184,9 @@ ABI.
>  DPTF Processor thermal RFIM interface
>  --------------------------------------------
>
> -RFIM interface allows adjustment of FIVR (Fully Integrated Voltage Regulator)
> -and DDR (Double Data Rate)frequencies to avoid RF interference with WiFi and 5G.
> +RFIM interface allows adjustment of FIVR (Fully Integrated Voltage Regulator),
> +DDR (Double Data Rate) and DLVR (Digital Linear Voltage Regulator)
> +frequencies to avoid RF interference with WiFi and 5G.
>
>  Switching voltage regulators (VR) generate radiated EMI or RFI at the
>  fundamental frequency and its harmonics. Some harmonics may interfere
> @@ -196,6 +197,15 @@ small % and shift away the switching noise harmonic interference from
>  radio channels.  OEM or ODMs can use the driver to control SOC IVR
>  operation within the range where it does not impact IVR performance.
>
> +Some products use DLVR instead of FIVR as switching voltage regulator.
> +In this case attributes of DLVR must be adjusted instead of FIVR.
> +
> +While shifting the frequencies additional clock noise can be introduced,
> +which is compensated by adjusting Spread spectrum percent. This helps
> +to reduce the clock noise to meet regulatory compliance. This spreading
> +% increases bandwidth of signal transmission and hence reduces the
> +effects of interference, noise and signal fading.
> +
>  DRAM devices of DDR IO interface and their power plane can generate EMI
>  at the data rates. Similar to IVR control mechanism, Intel offers a
>  mechanism by which DDR data rates can be changed if several conditions
> @@ -264,6 +274,38 @@ DVFS attributes
>  ``rfi_disable (RW)``
>         Disable DDR rate change feature
>
> +DLVR attributes
> +
> +:file:`/sys/bus/pci/devices/0000\:00\:04.0/dlvr/`
> +
> +``dlvr_hardware_rev`` (RO)
> +       DLVR hardware revision.
> +
> +``dlvr_freq_mhz`` (RO)
> +       Current DLVR PLL frequency in MHz.
> +
> +``dlvr_freq_select`` (RW)
> +       Sets DLVR PLL clock frequency. Once set, and enabled via
> +       dlvr_rfim_enable, the dlvr_freq_mhz will show the current
> +       DLVR PLL frequency.
> +
> +``dlvr_pll_busy`` (RO)
> +       PLL can't accept frequency change when set.
> +
> +``dlvr_rfim_enable`` (RW)
> +       0: Disable RF frequency hopping, 1: Enable RF frequency hopping.
> +
> +``dlvr_spread_spectrum_pct`` (RW)
> +       Sets DLVR spread spectrum percent value.
> +
> +``dlvr_control_mode`` (RW)
> +        Specifies how frequencies are spread using spread spectrum.
> +        0: Down spread,
> +        1: Spread in the Center.
> +
> +``dlvr_control_lock`` (RW)
> +    1: future writes are ignored.
> +
>  DPTF Power supply and Battery Interface
>  ----------------------------------------
>
> diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> index a1dc18be7609..3ca0a2f5937f 100644
> --- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> +++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> @@ -337,7 +337,8 @@ int proc_thermal_mmio_add(struct pci_dev *pdev,
>         }
>
>         if (feature_mask & PROC_THERMAL_FEATURE_FIVR ||
> -           feature_mask & PROC_THERMAL_FEATURE_DVFS) {
> +           feature_mask & PROC_THERMAL_FEATURE_DVFS ||
> +           feature_mask & PROC_THERMAL_FEATURE_DLVR) {
>                 ret = proc_thermal_rfim_add(pdev, proc_priv);
>                 if (ret) {
>                         dev_err(&pdev->dev, "failed to add RFIM interface\n");
> diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
> index 7d52fcff4937..7acaa8f1b896 100644
> --- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
> +++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
> @@ -60,6 +60,7 @@ struct rapl_mmio_regs {
>  #define PROC_THERMAL_FEATURE_FIVR      0x02
>  #define PROC_THERMAL_FEATURE_DVFS      0x04
>  #define PROC_THERMAL_FEATURE_MBOX      0x08
> +#define PROC_THERMAL_FEATURE_DLVR      0x10
>
>  #if IS_ENABLED(CONFIG_PROC_THERMAL_MMIO_RAPL)
>  int proc_thermal_rapl_add(struct pci_dev *pdev, struct proc_thermal_device *proc_priv);
> diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
> index d71ee50e7878..8b260dd9221b 100644
> --- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
> +++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
> @@ -351,7 +351,7 @@ static SIMPLE_DEV_PM_OPS(proc_thermal_pci_pm, proc_thermal_pci_suspend,
>
>  static const struct pci_device_id proc_thermal_pci_ids[] = {
>         { PCI_DEVICE_DATA(INTEL, ADL_THERMAL, PROC_THERMAL_FEATURE_RAPL | PROC_THERMAL_FEATURE_FIVR | PROC_THERMAL_FEATURE_DVFS | PROC_THERMAL_FEATURE_MBOX) },
> -       { PCI_DEVICE_DATA(INTEL, MTLP_THERMAL, PROC_THERMAL_FEATURE_RAPL | PROC_THERMAL_FEATURE_FIVR | PROC_THERMAL_FEATURE_DVFS | PROC_THERMAL_FEATURE_MBOX) },
> +       { PCI_DEVICE_DATA(INTEL, MTLP_THERMAL, PROC_THERMAL_FEATURE_RAPL | PROC_THERMAL_FEATURE_FIVR | PROC_THERMAL_FEATURE_DVFS | PROC_THERMAL_FEATURE_MBOX | PROC_THERMAL_FEATURE_DLVR) },
>         { PCI_DEVICE_DATA(INTEL, RPL_THERMAL, PROC_THERMAL_FEATURE_RAPL | PROC_THERMAL_FEATURE_FIVR | PROC_THERMAL_FEATURE_DVFS | PROC_THERMAL_FEATURE_MBOX) },
>         { },
>  };
> diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c
> index 92ed1213fe37..546b70434004 100644
> --- a/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c
> +++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c
> @@ -39,6 +39,29 @@ static const struct mmio_reg tgl_fivr_mmio_regs[] = {
>         { 1, 0x5A14, 2, 0x3, 1}, /* fivr_fffc_rev */
>  };
>
> +static const char * const dlvr_strings[] = {
> +       "dlvr_spread_spectrum_pct",
> +       "dlvr_control_mode",
> +       "dlvr_control_lock",
> +       "dlvr_rfim_enable",
> +       "dlvr_freq_select",
> +       "dlvr_hardware_rev",
> +       "dlvr_freq_mhz",
> +       "dlvr_pll_busy",
> +       NULL
> +};
> +
> +static const struct mmio_reg dlvr_mmio_regs[] = {
> +       { 0, 0x15A08, 5, 0x1F, 0}, /* dlvr_spread_spectrum_pct */
> +       { 0, 0x15A08, 1, 0x1, 5}, /* dlvr_control_mode */
> +       { 0, 0x15A08, 1, 0x1, 6}, /* dlvr_control_lock */
> +       { 0, 0x15A08, 1, 0x1, 7}, /* dlvr_rfim_enable */
> +       { 0, 0x15A08, 12, 0xFFF, 8}, /* dlvr_freq_select */
> +       { 1, 0x15A10, 2, 0x3, 30}, /* dlvr_hardware_rev */
> +       { 1, 0x15A10, 16, 0xFFFF, 0}, /* dlvr_freq_mhz */
> +       { 1, 0x15A10, 1, 0x1, 16}, /* dlvr_pll_busy */
> +};
> +
>  /* These will represent sysfs attribute names */
>  static const char * const dvfs_strings[] = {
>         "rfi_restriction_run_busy",
> @@ -78,14 +101,16 @@ static ssize_t suffix##_show(struct device *dev,\
>         int ret;\
>  \
>         proc_priv = pci_get_drvdata(pdev);\
> -       if (table) {\
> +       if (table == 1) {\
>                 match_strs = (const char **)dvfs_strings;\
>                 mmio_regs = adl_dvfs_mmio_regs;\
> -       } else { \
> +       } else if (table == 2) { \
> +               match_strs = (const char **)dlvr_strings;\
> +               mmio_regs = dlvr_mmio_regs;\
> +       } else {\
>                 match_strs = (const char **)fivr_strings;\
>                 mmio_regs = tgl_fivr_mmio_regs;\
>         } \
> -       \
>         ret = match_string(match_strs, -1, attr->attr.name);\
>         if (ret < 0)\
>                 return ret;\
> @@ -109,10 +134,13 @@ static ssize_t suffix##_store(struct device *dev,\
>         u32 mask;\
>  \
>         proc_priv = pci_get_drvdata(pdev);\
> -       if (table) {\
> +       if (table == 1) {\
>                 match_strs = (const char **)dvfs_strings;\
>                 mmio_regs = adl_dvfs_mmio_regs;\
> -       } else { \
> +       } else if (table == 2) { \
> +               match_strs = (const char **)dlvr_strings;\
> +               mmio_regs = dlvr_mmio_regs;\
> +       } else {\
>                 match_strs = (const char **)fivr_strings;\
>                 mmio_regs = tgl_fivr_mmio_regs;\
>         } \
> @@ -147,6 +175,47 @@ RFIM_STORE(spread_spectrum_clk_enable, 0)
>  RFIM_STORE(rfi_vco_ref_code, 0)
>  RFIM_STORE(fivr_fffc_rev, 0)
>
> +RFIM_SHOW(dlvr_spread_spectrum_pct, 2)
> +RFIM_SHOW(dlvr_control_mode, 2)
> +RFIM_SHOW(dlvr_control_lock, 2)
> +RFIM_SHOW(dlvr_hardware_rev, 2)
> +RFIM_SHOW(dlvr_freq_mhz, 2)
> +RFIM_SHOW(dlvr_pll_busy, 2)
> +RFIM_SHOW(dlvr_freq_select, 2)
> +RFIM_SHOW(dlvr_rfim_enable, 2)
> +
> +RFIM_STORE(dlvr_spread_spectrum_pct, 2)
> +RFIM_STORE(dlvr_rfim_enable, 2)
> +RFIM_STORE(dlvr_freq_select, 2)
> +RFIM_STORE(dlvr_control_mode, 2)
> +RFIM_STORE(dlvr_control_lock, 2)
> +
> +static DEVICE_ATTR_RW(dlvr_spread_spectrum_pct);
> +static DEVICE_ATTR_RW(dlvr_control_mode);
> +static DEVICE_ATTR_RW(dlvr_control_lock);
> +static DEVICE_ATTR_RW(dlvr_freq_select);
> +static DEVICE_ATTR_RO(dlvr_hardware_rev);
> +static DEVICE_ATTR_RO(dlvr_freq_mhz);
> +static DEVICE_ATTR_RO(dlvr_pll_busy);
> +static DEVICE_ATTR_RW(dlvr_rfim_enable);
> +
> +static struct attribute *dlvr_attrs[] = {
> +       &dev_attr_dlvr_spread_spectrum_pct.attr,
> +       &dev_attr_dlvr_control_mode.attr,
> +       &dev_attr_dlvr_control_lock.attr,
> +       &dev_attr_dlvr_freq_select.attr,
> +       &dev_attr_dlvr_hardware_rev.attr,
> +       &dev_attr_dlvr_freq_mhz.attr,
> +       &dev_attr_dlvr_pll_busy.attr,
> +       &dev_attr_dlvr_rfim_enable.attr,
> +       NULL
> +};
> +
> +static const struct attribute_group dlvr_attribute_group = {
> +       .attrs = dlvr_attrs,
> +       .name = "dlvr"
> +};
> +
>  static DEVICE_ATTR_RW(vco_ref_code_lo);
>  static DEVICE_ATTR_RW(vco_ref_code_hi);
>  static DEVICE_ATTR_RW(spread_spectrum_pct);
> @@ -277,12 +346,22 @@ int proc_thermal_rfim_add(struct pci_dev *pdev, struct proc_thermal_device *proc
>                         return ret;
>         }
>
> +       if (proc_priv->mmio_feature_mask & PROC_THERMAL_FEATURE_DLVR) {
> +               ret = sysfs_create_group(&pdev->dev.kobj, &dlvr_attribute_group);
> +               if (ret)
> +                       return ret;
> +       }
> +
>         if (proc_priv->mmio_feature_mask & PROC_THERMAL_FEATURE_DVFS) {
>                 ret = sysfs_create_group(&pdev->dev.kobj, &dvfs_attribute_group);
>                 if (ret && proc_priv->mmio_feature_mask & PROC_THERMAL_FEATURE_FIVR) {
>                         sysfs_remove_group(&pdev->dev.kobj, &fivr_attribute_group);
>                         return ret;
>                 }
> +               if (ret && proc_priv->mmio_feature_mask & PROC_THERMAL_FEATURE_DLVR) {
> +                       sysfs_remove_group(&pdev->dev.kobj, &dlvr_attribute_group);
> +                       return ret;
> +               }
>         }
>
>         return 0;
> @@ -296,6 +375,9 @@ void proc_thermal_rfim_remove(struct pci_dev *pdev)
>         if (proc_priv->mmio_feature_mask & PROC_THERMAL_FEATURE_FIVR)
>                 sysfs_remove_group(&pdev->dev.kobj, &fivr_attribute_group);
>
> +       if (proc_priv->mmio_feature_mask & PROC_THERMAL_FEATURE_DLVR)
> +               sysfs_remove_group(&pdev->dev.kobj, &dlvr_attribute_group);
> +
>         if (proc_priv->mmio_feature_mask & PROC_THERMAL_FEATURE_DVFS)
>                 sysfs_remove_group(&pdev->dev.kobj, &dvfs_attribute_group);
>  }
> --

Applied as 6.4 material under a slightly edited subject, thanks!

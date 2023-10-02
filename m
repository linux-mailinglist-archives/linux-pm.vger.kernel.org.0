Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31BE67B5A6C
	for <lists+linux-pm@lfdr.de>; Mon,  2 Oct 2023 20:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238735AbjJBSmH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Mon, 2 Oct 2023 14:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238650AbjJBSmG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Oct 2023 14:42:06 -0400
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81DC69B;
        Mon,  2 Oct 2023 11:42:03 -0700 (PDT)
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-57bf04841ccso12955eaf.0;
        Mon, 02 Oct 2023 11:42:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696272123; x=1696876923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W8a704JflSj3pI3y3Xgh4yVCmyPmtThEVtu9+wifhXA=;
        b=aARAi0QFI4PI1RkkCILAJiWksK/y8+JJ8Tv05qsR7o1GPOPYRN/yUkOcIcQZQodc94
         VbYZYtbuTN4DwzoKEegesvkc4eU985Z2AbH7n3LS8N2BNVXI/tMBXcaCIWngz8enVRKP
         cLnQOq5uJMt61Ppe42Ic6r7Vw5xTPIbQrR0m+wY/8t3k6uErcS4UllEDgzvhKgaFAn49
         8xA8xE1qowggZzLSfUN5K6dsaJ21WCPcYq0P90pb36PoUyKyMq/MZM0aciqu3Lfp3xJ/
         J3rsKMsBJOO9dvgx8ige1hK6la/ZqdRQGPaddjuRePv5E5i0IYk7jOt6UvaG2iOZ0aPd
         qPFg==
X-Gm-Message-State: AOJu0YwEBMcT1MNhOUeOnwqokNb/hvBtN8qMagBYUu5xLBjEkXs0jS3H
        aOrCvMetlwhaHQBN2ormoicIJIEQVl9Rbyq8sAqXHo0bUpw=
X-Google-Smtp-Source: AGHT+IH+UsSXasSZjFIpClF3O5SDMHWAtaPKZFRCQbQiMAsDqWYaDD0Ezv3bN1fme2Bb501+fx0Y9pcPD+oHhcrg17c=
X-Received: by 2002:a05:6808:97:b0:3a1:d457:83b5 with SMTP id
 s23-20020a056808009700b003a1d45783b5mr11496334oic.3.1696272122527; Mon, 02
 Oct 2023 11:42:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230926225813.995948-1-srinivas.pandruvada@linux.intel.com> <20230926225813.995948-3-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20230926225813.995948-3-srinivas.pandruvada@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 2 Oct 2023 20:41:51 +0200
Message-ID: <CAJZ5v0i8Y=tphmYtmwq-i93_OkxuiNvk_N-k1dUkqn46CwUj0w@mail.gmail.com>
Subject: Re: [PATCH 2/5] thermal: int340x: processor_thermal: Support power
 floor notifications
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     daniel.lezcano@linaro.org, rafael@kernel.org, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Sep 27, 2023 at 12:58 AM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> When the hardware reduces the power to the minimum possible, the power
> floor is notified via an interrupt. This can happen when user space
> requests a power limit via powercap RAPL interface, which forces the
> system to enter to the lowest power. This power floor indication can
> be used as a hint to resort to other methods of reducing power than
> via RAPL power limit.
>
> Before power floor status can be read or get notifications from the
> firmware, it needs to be configured via a mailbox command. Actual power
> floor status is read via bit 39 of MMIO offset 0x5B18 of the processor
> thermal PCI device.
>
> To show the current power floor status and get notification
> on a sysfs attribute, add additional attributes to
> /sys/bus/pci/devices/0000\:00\:04.0/power_limits/
>
> power_floor_enable : This attribute is present when a SoC supports
> power floor notification. This attribute allows to enable/disable
> power floor notifications.
>
> power_floor_status : This attribute is present when a SoC supports
> power floor notification. When enabled this shows the current
> status of power floor.
>
> The power floor implementation provides interfaces, which are called
> from the sysfs callbacks to enable/disable and read power floor
> status. Also provides two additional interface to check if the current
> processor thermal device interrupt is for power floor status and
> send notification to user space.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  .../driver-api/thermal/intel_dptf.rst         |   8 ++
>  .../thermal/intel/int340x_thermal/Makefile    |   1 +
>  .../processor_thermal_device.c                |  68 ++++++++++-
>  .../processor_thermal_device.h                |   8 ++
>  .../processor_thermal_power_floor.c           | 114 ++++++++++++++++++
>  5 files changed, 198 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/thermal/intel/int340x_thermal/processor_thermal_power_floor.c
>
> diff --git a/Documentation/driver-api/thermal/intel_dptf.rst b/Documentation/driver-api/thermal/intel_dptf.rst
> index 2d11e74ac665..55d90eafd94b 100644
> --- a/Documentation/driver-api/thermal/intel_dptf.rst
> +++ b/Documentation/driver-api/thermal/intel_dptf.rst
> @@ -164,6 +164,14 @@ ABI.
>  ``power_limit_1_tmax_us`` (RO)
>         Maximum powercap sysfs constraint_1_time_window_us for Intel RAPL
>
> +``power_floor_status`` (RO)
> +       When set to 1, hardware is not able to satisfy the requested power limit
> +       via Intel RAPL.
> +
> +``power_floor_enable`` (RW)
> +       When set to 1, enable reading and notification of power floor status.
> +       Notifications are issued for changes in the power_floor_status attribute.
> +
>  :file:`/sys/bus/pci/devices/0000\:00\:04.0/`
>
>  ``tcc_offset_degree_celsius`` (RW)
> diff --git a/drivers/thermal/intel/int340x_thermal/Makefile b/drivers/thermal/intel/int340x_thermal/Makefile
> index f33a3ad3bef3..fe3f43924525 100644
> --- a/drivers/thermal/intel/int340x_thermal/Makefile
> +++ b/drivers/thermal/intel/int340x_thermal/Makefile
> @@ -12,5 +12,6 @@ obj-$(CONFIG_INT340X_THERMAL) += processor_thermal_rfim.o
>  obj-$(CONFIG_INT340X_THERMAL)  += processor_thermal_mbox.o
>  obj-$(CONFIG_INT340X_THERMAL)  += processor_thermal_wt_req.o
>  obj-$(CONFIG_INT340X_THERMAL)  += processor_thermal_wt_hint.o
> +obj-$(CONFIG_INT340X_THERMAL)  += processor_thermal_power_floor.o
>  obj-$(CONFIG_INT3406_THERMAL)  += int3406_thermal.o
>  obj-$(CONFIG_ACPI_THERMAL_REL) += acpi_thermal_rel.o
> diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> index 29ed7d0f7022..649f67fdf345 100644
> --- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> +++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> @@ -26,6 +26,48 @@ static ssize_t power_limit_##index##_##suffix##_show(struct device *dev, \
>         (unsigned long)proc_dev->power_limits[index].suffix * 1000); \
>  }
>
> +static ssize_t power_floor_status_show(struct device *dev,
> +                                      struct device_attribute *attr,
> +                                      char *buf)
> +{
> +       struct proc_thermal_device *proc_dev = dev_get_drvdata(dev);
> +       int ret;
> +
> +       ret = proc_thermal_read_power_floor_status(proc_dev);
> +
> +       return sysfs_emit(buf, "%d\n", ret);
> +}
> +
> +static ssize_t power_floor_enable_show(struct device *dev,
> +                                      struct device_attribute *attr,
> +                                      char *buf)
> +{
> +       struct proc_thermal_device *proc_dev = dev_get_drvdata(dev);
> +       bool ret;
> +
> +       ret = proc_thermal_power_floor_get_state(proc_dev);
> +
> +       return sysfs_emit(buf, "%d\n", ret);
> +}
> +
> +static ssize_t power_floor_enable_store(struct device *dev,
> +                                       struct device_attribute *attr,
> +                                       const char *buf, size_t count)
> +{
> +       struct proc_thermal_device *proc_dev = dev_get_drvdata(dev);
> +       u8 state;
> +       int ret;
> +
> +       if (kstrtou8(buf, 0, &state))
> +               return -EINVAL;
> +
> +       ret = proc_thermal_power_floor_set_state(proc_dev, !!state);
> +       if (ret)
> +               return ret;
> +
> +       return count;
> +}
> +
>  POWER_LIMIT_SHOW(0, min_uw)
>  POWER_LIMIT_SHOW(0, max_uw)
>  POWER_LIMIT_SHOW(0, step_uw)
> @@ -50,6 +92,9 @@ static DEVICE_ATTR_RO(power_limit_1_step_uw);
>  static DEVICE_ATTR_RO(power_limit_1_tmin_us);
>  static DEVICE_ATTR_RO(power_limit_1_tmax_us);
>
> +static DEVICE_ATTR_RO(power_floor_status);
> +static DEVICE_ATTR_RW(power_floor_enable);
> +
>  static struct attribute *power_limit_attrs[] = {
>         &dev_attr_power_limit_0_min_uw.attr,
>         &dev_attr_power_limit_1_min_uw.attr,
> @@ -61,12 +106,30 @@ static struct attribute *power_limit_attrs[] = {
>         &dev_attr_power_limit_1_tmin_us.attr,
>         &dev_attr_power_limit_0_tmax_us.attr,
>         &dev_attr_power_limit_1_tmax_us.attr,
> +       &dev_attr_power_floor_status.attr,
> +       &dev_attr_power_floor_enable.attr,
>         NULL
>  };
>
> +static umode_t power_limit_attr_visible(struct kobject *kobj, struct attribute *attr, int unused)
> +{
> +       struct device *dev = kobj_to_dev(kobj);
> +       struct proc_thermal_device *proc_dev;
> +
> +       if (attr != &dev_attr_power_floor_status.attr && attr != &dev_attr_power_floor_enable.attr)
> +               return attr->mode;
> +
> +       proc_dev = dev_get_drvdata(dev);
> +       if (!proc_dev || !(proc_dev->mmio_feature_mask & PROC_THERMAL_FEATURE_POWER_FLOOR))
> +               return 0;
> +
> +       return attr->mode;
> +}
> +
>  static const struct attribute_group power_limit_attribute_group = {
>         .attrs = power_limit_attrs,
> -       .name = "power_limits"
> +       .name = "power_limits",
> +       .is_visible = power_limit_attr_visible,
>  };
>
>  static ssize_t tcc_offset_degree_celsius_show(struct device *dev,
> @@ -380,6 +443,9 @@ void proc_thermal_mmio_remove(struct pci_dev *pdev, struct proc_thermal_device *
>             proc_priv->mmio_feature_mask & PROC_THERMAL_FEATURE_DVFS)
>                 proc_thermal_rfim_remove(pdev);
>
> +       if (proc_priv->mmio_feature_mask & PROC_THERMAL_FEATURE_POWER_FLOOR)
> +               proc_thermal_power_floor_set_state(proc_priv, false);
> +
>         if (proc_priv->mmio_feature_mask & PROC_THERMAL_FEATURE_WT_REQ)
>                 proc_thermal_wt_req_remove(pdev);
>         else if (proc_priv->mmio_feature_mask & PROC_THERMAL_FEATURE_WT_HINT)
> diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
> index dd025c8c2bac..89e98f025a49 100644
> --- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
> +++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
> @@ -63,6 +63,7 @@ struct rapl_mmio_regs {
>  #define PROC_THERMAL_FEATURE_WT_REQ    0x08
>  #define PROC_THERMAL_FEATURE_DLVR      0x10
>  #define PROC_THERMAL_FEATURE_WT_HINT   0x20
> +#define PROC_THERMAL_FEATURE_POWER_FLOOR       0x40
>
>  #if IS_ENABLED(CONFIG_PROC_THERMAL_MMIO_RAPL)
>  int proc_thermal_rapl_add(struct pci_dev *pdev, struct proc_thermal_device *proc_priv);
> @@ -91,6 +92,13 @@ void proc_thermal_wt_req_remove(struct pci_dev *pdev);
>  #define MBOX_DATA_BIT_AC_DC            30
>  #define MBOX_DATA_BIT_VALID            31
>
> +int proc_thermal_read_power_floor_status(struct proc_thermal_device *proc_priv);
> +int proc_thermal_power_floor_set_state(struct proc_thermal_device *proc_priv, bool enable);
> +bool proc_thermal_power_floor_get_state(struct proc_thermal_device *proc_priv);
> +void proc_thermal_power_floor_intr_callback(struct pci_dev *pdev,
> +                                           struct proc_thermal_device *proc_priv);
> +bool proc_thermal_check_power_floor_intr(struct proc_thermal_device *proc_priv);
> +
>  int processor_thermal_send_mbox_read_cmd(struct pci_dev *pdev, u16 id, u64 *resp);
>  int processor_thermal_send_mbox_write_cmd(struct pci_dev *pdev, u16 id, u32 data);
>  int processor_thermal_mbox_interrupt_config(struct pci_dev *pdev, bool enable, int enable_bit,
> diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_power_floor.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_power_floor.c
> new file mode 100644
> index 000000000000..cac3a38f430f
> --- /dev/null
> +++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_power_floor.c
> @@ -0,0 +1,114 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Processor thermal device module for registering and processing
> + * power floor. When the hardware reduces the power to the minimum
> + * possible, the power floor is notified via an interrupt.
> + *
> + * Operation:
> + * When user space enables power floor reporting:
> + * - Use mailbox to:
> + *     Enable processor thermal device interrupt
> + *
> + * - Current status of power floor is read from offset 0x5B18
> + *   bit 39.
> + *
> + * Two interface functions are provided to call when there is a
> + * thermal device interrupt:
> + * - proc_thermal_power_floor_intr():
> + *     Check if the interrupt is for change in power floor.
> + *     Called from interrupt context.
> + *
> + * - proc_thermal_power_floor_intr_callback():
> + *     Callback for interrupt processing in thread context. This involves
> + *     sending notification to user space that there is a change in the
> + *     power floor status.
> + *
> + * Copyright (c) 2023, Intel Corporation.
> + */
> +
> +#include <linux/pci.h>
> +#include "processor_thermal_device.h"
> +
> +#define SOC_POWER_FLOOR_INT_STATUS_OFF 0x5B18

"OFFSET" would be better than "OFF" IMO.

> +#define SOC_POWER_FLOOR_STATUS         BIT(39)
> +#define SOC_POWER_FLOOR_SHIFT          39
> +
> +#define SOC_POWER_FLOOR_INT_ENABLE_BIT 31
> +#define SOC_POWER_FLOOR_INT_ACTIVE     BIT(3)
> +
> +/* Mark time windows as invalid as this is not applicable */

The meaning of the above comment is unclear.

> +#define SOC_POWER_FLOOR_TIME_WINDOW    -1
> +
> +int proc_thermal_read_power_floor_status(struct proc_thermal_device *proc_priv)
> +{
> +       u64 status = 0;
> +
> +       status = readq(proc_priv->mmio_base + SOC_POWER_FLOOR_INT_STATUS_OFF);
> +       return (status & SOC_POWER_FLOOR_STATUS) >> SOC_POWER_FLOOR_SHIFT;
> +}
> +EXPORT_SYMBOL_NS_GPL(proc_thermal_read_power_floor_status, INT340X_THERMAL);
> +
> +static bool enable_state;
> +static DEFINE_MUTEX(pf_lock);
> +
> +int proc_thermal_power_floor_set_state(struct proc_thermal_device *proc_priv, bool enable)
> +{
> +       int ret = 0;
> +
> +       mutex_lock(&pf_lock);
> +       if (enable_state == enable)
> +               goto pf_unlock;
> +
> +       ret = processor_thermal_mbox_interrupt_config(to_pci_dev(proc_priv->dev), enable,
> +                                                     SOC_POWER_FLOOR_INT_ENABLE_BIT,
> +                                                     SOC_POWER_FLOOR_TIME_WINDOW);
> +       if (!ret)
> +               enable_state = enable;
> +
> +pf_unlock:
> +       mutex_unlock(&pf_lock);
> +
> +       return ret;
> +}
> +EXPORT_SYMBOL_NS_GPL(proc_thermal_power_floor_set_state, INT340X_THERMAL);
> +
> +bool proc_thermal_power_floor_get_state(struct proc_thermal_device *proc_priv)
> +{
> +       return enable_state;
> +}
> +EXPORT_SYMBOL_NS_GPL(proc_thermal_power_floor_get_state, INT340X_THERMAL);
> +
> +/*
> + * Callback to check if interrupt for power floor is active.
> + * Caution: Called from interrupt context.
> + */

I would prefer this comment and the one below to be proper kerneldoc
ones or to be moved inside the functions.

> +bool proc_thermal_check_power_floor_intr(struct proc_thermal_device *proc_priv)
> +{
> +       u64 int_status;
> +
> +       int_status = readq(proc_priv->mmio_base + SOC_POWER_FLOOR_INT_STATUS_OFF);
> +       if (int_status & SOC_POWER_FLOOR_INT_ACTIVE)
> +               return true;
> +
> +       return false;

return !!(int_status & SOC_POWER_FLOOR_INT_ACTIVE);

> +}
> +EXPORT_SYMBOL_NS_GPL(proc_thermal_check_power_floor_intr, INT340X_THERMAL);
> +
> +/* Callback to notify user space */

Notify user space about what and how?  As is, this comment isn't very
useful IMO.

> +void proc_thermal_power_floor_intr_callback(struct pci_dev *pdev,
> +                                           struct proc_thermal_device *proc_priv)
> +{
> +       u64 status;
> +
> +       status = readq(proc_priv->mmio_base + SOC_POWER_FLOOR_INT_STATUS_OFF);
> +       if (!(status & SOC_POWER_FLOOR_INT_ACTIVE))
> +               return;
> +
> +       writeq(status & ~SOC_POWER_FLOOR_INT_ACTIVE,
> +              proc_priv->mmio_base + SOC_POWER_FLOOR_INT_STATUS_OFF);
> +       sysfs_notify(&pdev->dev.kobj, "power_limits", "power_floor_status");
> +}
> +EXPORT_SYMBOL_NS_GPL(proc_thermal_power_floor_intr_callback, INT340X_THERMAL);
> +
> +MODULE_IMPORT_NS(INT340X_THERMAL);
> +MODULE_LICENSE("GPL");
> --

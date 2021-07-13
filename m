Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 380DA3C6B2C
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jul 2021 09:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234202AbhGMHZc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Jul 2021 03:25:32 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:34821 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234142AbhGMHZc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Jul 2021 03:25:32 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1Mqagw-1lPh562HdA-00mbhF; Tue, 13 Jul 2021 09:22:40 +0200
Received: by mail-wr1-f52.google.com with SMTP id p8so29098755wrr.1;
        Tue, 13 Jul 2021 00:22:40 -0700 (PDT)
X-Gm-Message-State: AOAM53323+GQ0VqQHWtWWSs7gAlleiqWy7KbyigvdBk2uRNvXQOumMHl
        fY92ZBWQPi8KLZ6VrGQWkFPojdj8gmhIvaEUUK8=
X-Google-Smtp-Source: ABdhPJx/cHUDiL51pTmYQWuBZSOmF343oEkR8ER9MQ4caOVvAqKR7rUdqAKTKBM7zSpN98e8pajTPc1nSCySyl+j2O8=
X-Received: by 2002:adf:b318:: with SMTP id j24mr3854102wrd.361.1626160960111;
 Tue, 13 Jul 2021 00:22:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210713065347.21554-1-pandith.n@intel.com>
In-Reply-To: <20210713065347.21554-1-pandith.n@intel.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 13 Jul 2021 09:22:24 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1ZYzHQTPDQP+kQH1-x6DmA70H8bJ+kE_iE4NbTs8w3vw@mail.gmail.com>
Message-ID: <CAK8P3a1ZYzHQTPDQP+kQH1-x6DmA70H8bJ+kE_iE4NbTs8w3vw@mail.gmail.com>
Subject: Re: [PATCH V5 1/1] misc: NOC Probe Counters
To:     pandith.n@intel.com
Cc:     gregkh <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        furong.zhou@intel.com, mgross@linux.intel.com,
        mallikarjunappa.sangannavar@intel.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        lakshmi.bai.raja.subramanian@intel.com,
        Georgi Djakov <djakov@kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:t9ZtazSd7kgz7gLA6p+3romqDaXPjt7SaauR+ixs09PbFiRKos8
 LDVw1zmBnPXoKAQeR27kKw7ax7Ja92NfzVVYBwFZ1w4Zkghxfy1iuspCtekEFTROVzQF5M+
 3eDvKwRp4pOYNoMWMVOzFOmwjsBtdCLL5nrgw5a/Bd2lZuOv2l1O1djIBDLEKmKw+QT14Mn
 hmn4MTgd0T8fDcUVrsfwA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:TWXK0ug64TE=:oroMZ2ORXXa0q0z/IbVxKL
 eG/c2ry4M6c19W5uQS4km3DVKNiBdOwg0GR/fhL1A6Y4+MqOSAfFV+ZfLUK6Iz20gOCjzUDVk
 YXnyl1CF3BlYtc0xa4wJRTv+gyt8LfA00xvhLQ3xm/fDD7aI45HBkTG+KPjje7tqqTj1hwZID
 FnhxZVtKGxzLBqLq1/dXJakoh241JSGblhnFPAAuL87CSwEWsaSBfbgpPufI/RjfTkyfMYvmR
 IAsTNaCBJBu4hTKMwyy0ltJ2Y0c1CoI8ahz+m2mUBbah2FVxa0wkyiZZHQuRAVgo0fTLRRbme
 ucpLPTLDg92A11MAGcspozPl393IqDA1BAcEKVGNtx12mwRnisgddzivSYSEpDHuf5q7nW6Iw
 YIQ1yNePLYUteUnT5ACj5O0nfyhJyGsirUJ7FEQWfvyo0AH2eqmY2FKqqm4ggu/hXzSsnaIdW
 EAJ0Vh8jxONwj34FgaZRTzK4hhP8uJWCd0y91E0GREomB+NqsGXqyVRatMiIpVt38J1UharKo
 BKOBtu/1xfPw5BvCVpXKC2mZhUBzvr+NUGdCpGQEuD/m2lgLCGUNt4UNKn7ApdD0qT32PDCpT
 BuOTMd+/OMO+1IAWTzCG1nVtBpkEzff2EdnDYOA1eOT1cvcPvFXkOir+6AxJztY4w1/WIIL6M
 L6Hb2bTz1wwDvlGB3hauyhSHINP1FI5gTsWAHC4P0u6LZNeXpIqTx8G/IDQww8Ugx1CMyRG8n
 pN+8zewrH/tIuDgm33RWSmpK8nJ1yYGwPvls3MwtE2+fg+n/a70BeXTe82k40d8XN7hNWR2zk
 oTrHLIIy6eEKA5CYiS8WQrxxfetpnHqRshBDZ1/W3OhvQOBf1W0rqpGZrRzOz7+KyadIbMS
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 13, 2021 at 8:54 AM <pandith.n@intel.com> wrote:
>
> From: Pandith N <pandith.n@intel.com>
>
> Add support for Network on Chip(NOC) counters. Enable features to configure
> and capture NOC probe counters, needed for DDR bandwidth measurement. NOC
> driver is specific to Intel Keem Bay SOC. NOC hardware counters are used
> for DDR statistics profiling, it is not related to timers.
> Interface details are provided in include/uapi/linux/noc_uapi.h
>
> Signed-off-by: Pandith N <pandith.n@intel.com>
> Reviewed-by: Mark Gross <mgross@linux.intel.com>

I'm missing some explanation here regarding why this is not part of
drivers/interconnect/.

I assume you have discussed this with Georgi Djakov before, but if not, then
please do. From a very high-level perspective, I would have guessed that this
would be part of the interconnect framework, with any user facing setup being
either derived from the DT, or exposed through debugfs.

(full quote below for Georgi, no further comments there)

          Arnd


> ---
> Changes in V2 :
> NOC is class driver, platform driver not needed.
> Removed LINUX syscall note from noc_driver.c.
> Order variable from longest to shortest.
> Using varaible in sizeof parameter, rather than data type.
> Consistent project naming as Keem Bay
>
> Changes in V3 :
> Free noc device in failure case and module exit.
> Remove platform device references.
>
> Changes in V4 :
> Rephrased commit description, added missing punctuation in Kconfig.
>
> Changes in V5 :
> Local variables are always initialized before use in all cases
> of capture function
> No need of counter 3 definiton in enumeration
> Signed-off-by: Pandith N <pandith.n@intel.com>
> Signed-off-by: Pandith N <pandith.n@intel.com>
> Signed-off-by: Pandith N <pandith.n@intel.com>
> ---
>  MAINTAINERS                   |   6 +
>  drivers/misc/Kconfig          |   1 +
>  drivers/misc/Makefile         |   1 +
>  drivers/misc/noc/Kconfig      |  16 ++
>  drivers/misc/noc/Makefile     |   6 +
>  drivers/misc/noc/noc_driver.c | 305 ++++++++++++++++++++++++++++++++++
>  drivers/misc/noc/noc_driver.h | 110 ++++++++++++
>  include/uapi/linux/noc_uapi.h |  42 +++++
>  8 files changed, 487 insertions(+)
>  create mode 100644 drivers/misc/noc/Kconfig
>  create mode 100644 drivers/misc/noc/Makefile
>  create mode 100644 drivers/misc/noc/noc_driver.c
>  create mode 100644 drivers/misc/noc/noc_driver.h
>  create mode 100644 include/uapi/linux/noc_uapi.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6eff4f720c72..0cf5ab4f134f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12589,6 +12589,12 @@ F:     include/linux/nitro_enclaves.h
>  F:     include/uapi/linux/nitro_enclaves.h
>  F:     samples/nitro_enclaves/
>
> +NOC, DSS NOC SUPPORT
> +M:     Pandith N <pandith.n@intel.com>
> +S:     Supported
> +F:     drivers/misc/noc
> +F:     include/uapi/linux/noc_uapi.h
> +
>  NOHZ, DYNTICKS SUPPORT
>  M:     Frederic Weisbecker <fweisbec@gmail.com>
>  M:     Thomas Gleixner <tglx@linutronix.de>
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index fafa8b0d8099..2690cc57baa5 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -480,5 +480,6 @@ source "drivers/misc/cxl/Kconfig"
>  source "drivers/misc/ocxl/Kconfig"
>  source "drivers/misc/cardreader/Kconfig"
>  source "drivers/misc/habanalabs/Kconfig"
> +source "drivers/misc/noc/Kconfig"
>  source "drivers/misc/uacce/Kconfig"
>  endmenu
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index d23231e73330..bd854845bf96 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -54,6 +54,7 @@ obj-$(CONFIG_OCXL)            += ocxl/
>  obj-y                          += cardreader/
>  obj-$(CONFIG_PVPANIC)          += pvpanic.o
>  obj-$(CONFIG_HABANA_AI)                += habanalabs/
> +obj-$(CONFIG_NOC_DSS)          += noc/
>  obj-$(CONFIG_UACCE)            += uacce/
>  obj-$(CONFIG_XILINX_SDFEC)     += xilinx_sdfec.o
>  obj-$(CONFIG_HISI_HIKEY_USB)   += hisi_hikey_usb.o
> diff --git a/drivers/misc/noc/Kconfig b/drivers/misc/noc/Kconfig
> new file mode 100644
> index 000000000000..e70ba0c33614
> --- /dev/null
> +++ b/drivers/misc/noc/Kconfig
> @@ -0,0 +1,16 @@
> +# Copyright (C) 2019 Intel Corporation
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +
> +config NOC_DSS
> +       tristate "Enable DSS NOC probing"
> +       depends on ARCH_KEEMBAY
> +       default y
> +       help
> +         Enable this option for DSS bandwidth measurements using noc
> +
> +         Add support for Network on chip (NOC) counters. Enable features
> +         to configure nd capture NOC probe counters, needed for DSS
> +         bandwidth measurement.
> +         Say Y if using a processor that includes the Intel VPU such as
> +         Keem Bay.  If unsure, say N.
> diff --git a/drivers/misc/noc/Makefile b/drivers/misc/noc/Makefile
> new file mode 100644
> index 000000000000..cd4622c6753c
> --- /dev/null
> +++ b/drivers/misc/noc/Makefile
> @@ -0,0 +1,6 @@
> +# Copyright (C) 2019 Intel Corporation
> +# SPDX-License-Identifier: GPL-2.0-only
> +#     Makefile for Keem Bay NOC
> +#
> +obj-$(CONFIG_NOC_DSS) += noc_dss.o
> +noc_dss-objs += noc_driver.o
> diff --git a/drivers/misc/noc/noc_driver.c b/drivers/misc/noc/noc_driver.c
> new file mode 100644
> index 000000000000..1af81eb3ef86
> --- /dev/null
> +++ b/drivers/misc/noc/noc_driver.c
> @@ -0,0 +1,305 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*  Copyright (C) 2020 Intel Corporation
> + *
> + *  Purpose: Keem Bay NOC probe bandwidth measurement interface
> + *
> + */
> +#include <linux/arm-smccc.h>
> +#include <linux/compiler_types.h>
> +#include <linux/device.h>
> +#include <linux/delay.h>
> +#include <linux/fs.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/noc_uapi.h>
> +#include <linux/of_device.h>
> +#include <linux/types.h>
> +#include <linux/uaccess.h>
> +#include "noc_driver.h"
> +
> +/* Filter and counter offset */
> +static const int f_offset[] = {0x44, 0x80, 0xbc, 0xf8};
> +static const int c_offset[] = {0x134, 0x148, 0x15c, 0x170};
> +static struct noc_device noc_dev;
> +
> +static inline u32 noc_readl(u32 offset)
> +{
> +       struct arm_smccc_res res;
> +
> +       arm_smccc_smc(PLATFORM_SIP_SVC_DSS_NOC_PROBE_READ, offset,
> +                     0, 0, 0, 0, 0, 0, &res);
> +       return res.a1;
> +}
> +
> +static inline void noc_writel(u32 offset, u32 value)
> +{
> +       struct arm_smccc_res res;
> +
> +       arm_smccc_smc(PLATFORM_SIP_SVC_DSS_NOC_PROBE_WRITE, offset,
> +                     value, 0, 0, 0, 0, 0, &res);
> +}
> +
> +/**
> + * flex_noc_setup() - Setup two counters for the NOC probe
> + * @noc: NOC type to setup counters
> + * @counter: Counter number to set up counter n and n+1
> + * @trace_port: trace port number to setup counters
> + *
> + * This function will setup the counters for the trace port given.
> + */
> +int flex_noc_setup(enum noc_ss_type noc, enum noc_counter counter, int trace_port)
> +{
> +       int offset;
> +
> +       if (noc >= NOC_TYPE_MAX || counter >= NOC_COUNTER_MAX)
> +               return -EINVAL;
> +
> +       offset = f_offset[counter / 2];
> +
> +       /* Stop ongoing stats */
> +       noc_writel(MAINCTL, 0);
> +       noc_writel(CFGCTL, 0);
> +
> +       /* Setup trace port and counters port select */
> +       noc_writel(TRACEPORTSEL, trace_port);
> +       noc_writel((c_offset[counter] + C_PORTSEL), trace_port);
> +       noc_writel((c_offset[counter + 1] + C_PORTSEL), trace_port);
> +
> +       /* Setup counter sources & triggers, Alarm mode - OFF */
> +       noc_writel((c_offset[counter] + C_SRC), COUNTERS_0_SRC_VAL);
> +       noc_writel((c_offset[counter] + C_ALARMMODE), COUNTERS_ALARMMODE_VAL);
> +       noc_writel((c_offset[counter + 1] + C_SRC), COUNTERS_1_SRC_VAL);
> +       noc_writel((c_offset[counter + 1] + C_ALARMMODE),
> +                  COUNTERS_ALARMMODE_VAL);
> +
> +       /* Setup filters - RouteID mask, addr base, window size */
> +       noc_writel((offset + F_ROUTEIDBASE), 0);
> +       noc_writel((offset + F_ROUTEIDMASK), 0);
> +       noc_writel((offset + F_ADDRBASE_LOW), 0);
> +       noc_writel((offset + F_ADDRBASE_HIGH), 0);
> +       noc_writel((offset + F_WINDOWSIZE), FILTER_WINDOW_VAL);
> +       noc_writel((offset + F_OPCODE), FILTER_OPCODE_VAL);
> +       noc_writel((offset + F_STATUS), FILTER_STATUS_VAL);
> +       noc_writel((offset + F_LENGTH), FILTER_OPCODE_VAL);
> +
> +       return 0;
> +}
> +
> +/**
> + * flexnoc_probe_start() - Start two counters for the NOC probe
> + * @noc: NOC type to setup counters
> + *
> + * This function will start the counters.  When this
> + * function returns NOC_PROBE_CAPTURE_STARTED, it is guaranteed that NOC
> + * is setup for probing counters.
> + *
> + */
> +enum noc_status flexnoc_probe_start(enum noc_ss_type noc)
> +{
> +       if (noc >= NOC_TYPE_MAX)
> +               return NOC_PROBE_ERR_INVALID_ARGS;
> +
> +       /* Setting up probe */
> +       noc_writel(MAINCTL, (1 << MAINCTL_STATEN_POS));
> +       noc_writel(FILTERLUT, 1);
> +       noc_writel(STATALARMMIN, 0);
> +       noc_writel(STATALARMMAX, 1);
> +       noc_writel(STATALARMEN, 1);
> +       noc_writel(MAINCTL, ((1 << MAINCTL_STATEN_POS) |
> +                            (1 << MAINCTL_ALARM_EN_POS) |
> +                            (1 << MAINCTL_ALWAYS_CHAINABLE_POS)));
> +       noc_writel(STATPERIOD, NOC_STATPERIOD_VAL);
> +       noc_writel(FILTERLUT, 0x00000001);
> +       noc_writel(CFGCTL, 0x00000001);
> +
> +       return NOC_PROBE_CAPTURE_STARTED;
> +}
> +
> +/**
> + * flexnoc_counterp_capture() - Capture the counter statistic values
> + * @noc: NOC type to setup counters
> + * @counter:  Counter number to capture statistics values for n and n+1
> + * @value: statistics values read are returned in this address passed
> + *
> + * This function will return the statistics value of started counters.
> + * When this function returns NOC_PROBE_COMPLETED, it is guaranteed that NOC
> + * counters are idle and finished probing.
> + * Algo : The values should not returned when counters are active/running.
> + * Once the counter is frozen, the values are good to read. There is an
> + * iteration logic implemented to check this. An maximum timeout config
> + * is provided to for capture timeout - NOC_CAPTURE_TIMEOUT_MSEC
> + *
> + */
> +enum noc_status flexnoc_counter_capture(enum noc_ss_type noc,
> +                                       enum noc_counter counter, u32  *value)
> +{
> +       unsigned long j0, j1, delay;
> +       u32 c0_0, c0_1;
> +
> +       if (noc >= NOC_TYPE_MAX ||
> +           counter >= NOC_COUNTER_MAX  ||
> +           !value)
> +               return NOC_PROBE_ERR_INVALID_ARGS;
> +
> +       delay = msecs_to_jiffies(NOC_CAPTURE_TIMEOUT_MSEC);
> +       j0 = jiffies;
> +       j1 = j0 + delay;
> +       do {
> +               c0_0 = noc_readl((c_offset[counter] + C_VAL));
> +               usleep_range(10000, 11000);
> +               c0_1 = noc_readl((c_offset[counter] + C_VAL));
> +               /* If mainctrl is zero , return error */
> +               if (noc_readl(MAINCTL) == 0)
> +                       return NOC_PROBE_ERR_IN_PROGRESS;
> +               /* If counters are zero, keep reading */
> +               if (0 == c0_0 && 0 == c0_1) {
> +                       break;
> +               } else if (c0_0 != c0_1) {
> +                       continue;
> +               } else {
> +                       /* counters look good break the while */
> +                       break;
> +               }
> +       } while (time_before(jiffies, j1));
> +
> +       if (c0_0 != c0_1)
> +               return NOC_PROBE_ERR_IN_PROGRESS;
> +
> +       c0_0 = noc_readl((c_offset[counter] + C_VAL));
> +       c0_1 = noc_readl((c_offset[counter + 1] + C_VAL));
> +       *value = (c0_0 | (c0_1 << 16));
> +
> +       return NOC_PROBE_COMPLETED;
> +}
> +
> +static long noc_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> +{
> +       struct flexnoc_countercapture capture_data;
> +       void __user *argp = (void __user *)arg;
> +       struct flexnoc_probestart probe_data;
> +       struct flexnoc_setup setup_data;
> +       int rc;
> +
> +       if (!arg) {
> +               pr_err("NOC: Null pointer from user\n");
> +               return -EINVAL;
> +       }
> +       switch (cmd) {
> +       case NOC_SETUP:
> +               if (copy_from_user(&setup_data,
> +                                  argp, sizeof(setup_data))) {
> +                       return -EFAULT;
> +               }
> +               rc =  flex_noc_setup(setup_data.noc_type, setup_data.counter,
> +                                    setup_data.traceport);
> +               setup_data.ret_id = rc;
> +
> +               if (copy_to_user(argp,
> +                                &setup_data, sizeof(setup_data))) {
> +                       return -EFAULT;
> +               }
> +       break;
> +       case NOC_PROBE_START:
> +               if (copy_from_user(&probe_data, argp,
> +                                  sizeof(probe_data))) {
> +                       return -EFAULT;
> +               }
> +               rc = flexnoc_probe_start(probe_data.noc_type);
> +               probe_data.ret_id = rc;
> +
> +               if (copy_to_user(argp,
> +                                &probe_data, sizeof(probe_data))) {
> +                       return -EFAULT;
> +               }
> +       break;
> +       case NOC_COUNTER_CAPTURE:
> +               if (copy_from_user(&capture_data, argp,
> +                                  sizeof(capture_data))) {
> +                       return -EFAULT;
> +               }
> +               rc = flexnoc_counter_capture(capture_data.noc_type,
> +                                            capture_data.counter,
> +                                            &capture_data.bw_res);
> +               capture_data.ret_id = rc;
> +
> +               if (copy_to_user(argp, &capture_data,
> +                                sizeof(capture_data))) {
> +                       return -EFAULT;
> +               }
> +       break;
> +       default:
> +               return -EINVAL;
> +       }
> +       return 0;
> +}
> +
> +static const struct file_operations noc_fops = {
> +       .owner  = THIS_MODULE,
> +       .unlocked_ioctl = noc_ioctl,
> +};
> +
> +static int intel_noc_cdev_init(struct noc_device *nocdev)
> +{
> +       if ((alloc_chrdev_region(&nocdev->cdev, 0, 1, "nocdev")) < 0) {
> +               pr_err("Cannot allocate major number for NOC\n");
> +               return -EINVAL;
> +       }
> +
> +       cdev_init(&nocdev->noc_cdev, &noc_fops);
> +       if ((cdev_add(&nocdev->noc_cdev, nocdev->cdev, 1)) < 0) {
> +               pr_err("Cannot add NOC device to the system\n");
> +               goto r_class;
> +       }
> +
> +       nocdev->dev_class = class_create(THIS_MODULE, "noc_class");
> +       if (!nocdev->dev_class) {
> +               pr_err("Cannot create the NOC class\n");
> +               cdev_del(&nocdev->noc_cdev);
> +               goto r_class;
> +       }
> +
> +       if ((device_create(nocdev->dev_class, NULL, nocdev->cdev,
> +                          NULL, "noc")) == NULL) {
> +               pr_err("Cannot create NOC device\n");
> +               cdev_del(&nocdev->noc_cdev);
> +               goto r_cdev;
> +       }
> +
> +       return 0;
> +
> +r_cdev:
> +       class_destroy(nocdev->dev_class);
> +r_class:
> +       unregister_chrdev_region(nocdev->cdev, 1);
> +       return -EINVAL;
> +}
> +
> +static void intel_noc_cdev_exit(struct noc_device *nocdev)
> +{
> +       cdev_del(&nocdev->noc_cdev);
> +       class_destroy(nocdev->dev_class);
> +       unregister_chrdev_region(nocdev->cdev, 1);
> +}
> +
> +static int __init noc_driver_module_init(void)
> +{
> +       int ret;
> +
> +       ret = intel_noc_cdev_init(&noc_dev);
> +       if (ret)
> +               pr_err("NOC char device init failed\n");
> +       return ret;
> +}
> +
> +static void noc_driver_module_exit(void)
> +{
> +       intel_noc_cdev_exit(&noc_dev);
> +}
> +
> +module_init(noc_driver_module_init);
> +module_exit(noc_driver_module_exit);
> +
> +MODULE_DESCRIPTION("Keem Bay NOC Device driver");
> +MODULE_AUTHOR("Pandith N <pandith.n@intel.com>");
> +MODULE_AUTHOR("Sudarshan Ravula <sudarshan.ravula@intel.com>");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/misc/noc/noc_driver.h b/drivers/misc/noc/noc_driver.h
> new file mode 100644
> index 000000000000..30b152186ddf
> --- /dev/null
> +++ b/drivers/misc/noc/noc_driver.h
> @@ -0,0 +1,110 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*  Copyright (C) 2020 Intel Corporation
> + *
> + *  Purpose: KMB NOC probe bandwidth measurement interface
> + *
> + */
> +#ifndef LINUX_NOCDRIVER_H
> +#define LINUX_NOCDRIVER_H
> +
> +#include <linux/cdev.h>
> +#include <linux/device.h>
> +#include <linux/types.h>
> +#include <uapi/linux/noc_uapi.h>
> +
> +/**
> + * enum noc_status - NOC probe status
> + * @NOC_PROBE_CAPTURE_STARTED: Probe counters monitoring started
> + * @NOC_PROBE_ERR_IN_PROGRESS: Probe counters are active, capture failure
> + * @NOC_PROBE_ERR_INVALID_ARGS: NOC error, Invalid arguments passed
> + * @NOC_PROBE_ERR_COMPLETED: NOC counter values captured successfully
> + */
> +enum noc_status {
> +       NOC_PROBE_CAPTURE_STARTED,
> +       NOC_PROBE_ERR_IN_PROGRESS,
> +       NOC_PROBE_ERR_INVALID_ARGS,
> +       NOC_PROBE_COMPLETED,
> +};
> +
> +/**
> + * enum noc_counter - NOC counter
> + * @NOC_COUNTER_0: NOC Counter 0
> + * @NOC_COUNTER_1: NOC Counter 1
> + */
> +enum noc_counter {
> +       NOC_COUNTER_0,
> +       NOC_COUNTER_1,
> +       NOC_COUNTER_2,
> +       NOC_COUNTER_MAX
> +};
> +
> +/* NOC Control Register Probe offsets */
> +#define ID_COREID              0x0000
> +#define ID_REVISIONID          0x0004
> +#define MAINCTL                        0x0008
> +#define CFGCTL                 0x000C
> +#define TRACEPORTSEL           0x0010
> +#define FILTERLUT              0x0014
> +#define TRACEALARMEN           0x0018
> +#define TRACEALARMSTATUS       0x001C
> +#define TRACEALARMCLR          0x0020
> +#define STATPERIOD             0x0024
> +#define STATGO                 0x0028
> +#define STATALARMMIN           0x002C
> +#define STATALARMMAX           0x0030
> +#define STATALARMSTATUS                0x0034
> +#define STATALARMCLR           0x0038
> +#define STATALARMEN            0x003C
> +
> +/* NOC Filter Registers offsets */
> +#define F_ROUTEIDBASE          0x0000
> +#define F_ROUTEIDMASK          0x0004
> +#define F_ADDRBASE_LOW         0x0008
> +#define F_ADDRBASE_HIGH                0x000C
> +#define F_WINDOWSIZE           0x0010
> +#define F_OPCODE               0x001C
> +#define F_STATUS               0x0020
> +#define F_LENGTH               0x0024
> +#define F_URGENCY              0x0028
> +#define F_USERBASE             0x002C
> +#define F_USERMASK             0x0030
> +
> +/* NOC Counter Registers offsets */
> +#define C_PORTSEL              0x0000
> +#define C_SRC                  0x0004
> +#define C_ALARMMODE            0x0008
> +#define C_VAL                  0x000C
> +
> +/* NOC register secure access r/w */
> +#define PLATFORM_SIP_SVC_DSS_NOC_PROBE_READ            (0x8200ff28)
> +#define PLATFORM_SIP_SVC_DSS_NOC_PROBE_WRITE           (0x8200ff29)
> +
> +/* Timeout(msec) for checking active counters */
> +#define NOC_CAPTURE_TIMEOUT_MSEC       2000
> +#define NOC_STATPERIOD_VAL             0x1B
> +
> +#define COUNTERS_0_SRC_VAL     0x14
> +#define COUNTERS_1_SRC_VAL     0x10
> +#define COUNTERS_ALARMMODE_VAL 0x02
> +#define FILTER_WINDOW_VAL      0xFFFFFFFF
> +#define FILTER_OPCODE_VAL      0x0F
> +#define FILTER_STATUS_VAL      0x03
> +#define FILTER_LENGTH_VAL      0x03
> +
> +/* NOC Probe Main controli register fields */
> +#define MAINCTL_STATEN_POS             3
> +#define MAINCTL_ALARM_EN_POS           4
> +#define MAINCTL_ALWAYS_CHAINABLE_POS   7
> +
> +struct noc_device {
> +       struct class *dev_class;
> +       struct cdev noc_cdev;
> +       dev_t cdev;
> +};
> +
> +int flex_noc_setup(enum noc_ss_type noc, enum noc_counter counter, int trace_port);
> +enum noc_status flexnoc_probe_start(enum noc_ss_type noc);
> +enum noc_status flexnoc_counter_capture(enum noc_ss_type noc,
> +                                       enum noc_counter counter, u32 *value);
> +
> +#endif
> diff --git a/include/uapi/linux/noc_uapi.h b/include/uapi/linux/noc_uapi.h
> new file mode 100644
> index 000000000000..2a35b4a88259
> --- /dev/null
> +++ b/include/uapi/linux/noc_uapi.h
> @@ -0,0 +1,42 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/*  Copyright (C) 2020 Intel Corporation
> + *
> + *  Purpose: KMB NOC header for user space access.
> + */
> +
> +#ifndef __NOC_UAPI_H
> +#define __NOC_UAPI_H
> +
> +#include <linux/types.h>
> +
> +#define NOC_MAGIC 'n'
> +#define NOC_SETUP                _IOW(NOC_MAGIC, 1, void*)
> +#define NOC_PROBE_START          _IOW(NOC_MAGIC, 2, void*)
> +#define NOC_COUNTER_CAPTURE      _IOW(NOC_MAGIC, 3, void*)
> +
> +enum noc_ss_type {
> +       DSS_NOC = 0,
> +       NOC_TYPE_MAX
> +};
> +
> +struct flexnoc_setup {
> +       enum noc_ss_type noc_type;
> +       __u16 counter;
> +       __u16 traceport;
> +       __u16 ret_id;
> +};
> +
> +struct flexnoc_probestart {
> +       enum noc_ss_type noc_type;
> +       __u16 ret_id;
> +       __u32 captime;
> +};
> +
> +struct flexnoc_countercapture {
> +       enum noc_ss_type noc_type;
> +       __u32 bw_res;
> +       __u16 counter;
> +       __u16 ret_id;
> +};
> +
> +#endif  /*_NOC__UAPI_H*/
> --
> 2.17.1
>

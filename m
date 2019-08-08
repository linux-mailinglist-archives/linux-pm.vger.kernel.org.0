Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FDF3868EF
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2019 20:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390231AbfHHSkV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Aug 2019 14:40:21 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43992 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390228AbfHHSkU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Aug 2019 14:40:20 -0400
Received: by mail-pg1-f195.google.com with SMTP id r26so8551728pgl.10
        for <linux-pm@vger.kernel.org>; Thu, 08 Aug 2019 11:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:from:cc:to:user-agent:date;
        bh=7NN04FEl7bvWdIxYSdH6KV6rKdpmdwVRM9IjBo0UhHs=;
        b=bq74X2mT6DcA6A0FY6YvwMrqIFPQNTQW56JpfiIVVvB0b/VUTBT1f6x0ODMTPTCd68
         svuYBtypdWGQM7RNjun5TEWkuV3RGe6rlm5+xQTKebpD9NEVADlkL9Q+3Ap2JODVs5rA
         S3WMpqXcuIqFz0DjgGOXKV8MmzxrlmLS61rxg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:from:cc:to
         :user-agent:date;
        bh=7NN04FEl7bvWdIxYSdH6KV6rKdpmdwVRM9IjBo0UhHs=;
        b=BlgkSx6mIYAAQVCX8n/lGYXS2k+V2hjoavbMAYj9ZnbYW4mk4BE2CCIIEEu8+kjTZ1
         K8EA4mLrXpnPLezOI0I3HaAosewKGoGH3C8H21N8rQJxYznsTQEKLhkKXntWPWPqYrnb
         lQDatwigaYUMvmiONvTWc6wN37TFlMBj8Qj3UNLaPYVENQcHj59TZMf4aXC20MBC1I7e
         FPxPbk7mXRU1siOo1PkNx8HnyL63LVzpJIFdjTDE+oCxvlDpEO8mVgzhRBlU2y4WaKtj
         cQCNnHbADCuAEyNTNRfW0Y1/2KVm83pBps3I4nIiNtjEuewc7mmWly6eC6W/kXM7vAA3
         QzGw==
X-Gm-Message-State: APjAAAVmGCm3YnB0mQP339A+1vmyiikKetMssNQ6M72W0xbe/3ejX6t0
        yfRSGYN0uMhy6+GsQJk7cMDlVg==
X-Google-Smtp-Source: APXvYqwIttXOQSLrliAc8oKmvGlPitcplGRoPMPqnF058BiKj9lgglcyKeIhBnaP9fPUFlHdSHUOnQ==
X-Received: by 2002:a62:e806:: with SMTP id c6mr17182540pfi.158.1565289619342;
        Thu, 08 Aug 2019 11:40:19 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id j20sm91226002pfr.113.2019.08.08.11.40.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 11:40:18 -0700 (PDT)
Message-ID: <5d4c6c92.1c69fb81.876aa.90c6@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190808061228.16573-3-mkshah@codeaurora.org>
References: <20190808061228.16573-1-mkshah@codeaurora.org> <20190808061228.16573-3-mkshah@codeaurora.org>
Subject: Re: [PATCH 2/2] drivers: qcom: Add SoC sleep stats driver
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        bjorn.andersson@linaro.org, evgreen@chromium.org,
        dianders@chromium.org, rnayak@codeaurora.org, ilina@codeaurora.org,
        lsrao@codeaurora.org, mkshah@codeaurora.org,
        Mahesh Sivasubramanian <msivasub@codeaurora.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Maulik Shah <mkshah@codeaurora.org>, andy.gross@linaro.org,
        david.brown@linaro.org, linux-arm-msm@vger.kernel.org
User-Agent: alot/0.8.1
Date:   Thu, 08 Aug 2019 11:40:17 -0700
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Maulik Shah (2019-08-07 23:12:28)
> Qualcomm Technologies Inc's (QTI) chipsets support SoC level
> low power modes. Statistics for SoC sleep stats are produced
> by remote processor.
>=20
> Lets's add a driver to read the shared memory exported by the
> remote processor and export to sysfs.
>=20
> Signed-off-by: Mahesh Sivasubramanian <msivasub@codeaurora.org>
> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>

SoB chain is weird here too.

> ---
>  drivers/soc/qcom/Kconfig           |   9 ++
>  drivers/soc/qcom/Makefile          |   1 +
>  drivers/soc/qcom/soc_sleep_stats.c | 249 +++++++++++++++++++++++++++++

There should be a Documentation/ABI/ path in this diffstat above because
you're adding sysfs attributes.

There's some similar support in the ARM PSCI spec for extracting
idle/suspend stats, see section 5.21 PSCI_STAT_RESIDENCY/COUNT. Maybe
this code can align with that feature in PSCI? At the least, I hope we
can come up with a generic sysfs ABI that can be used to describe CPU
and system wide power states in a way that userspace can read and
understand how long the device was in these different power states. I
would guess that other architectures like x86 may also want to get
involved in reporting this information in a standard way, so please loop
in some x86 power folks too.

It would be neat if the PSCI feature could be used for this instead of
having a custom SoC driver. Maybe that won't work though because this
works for shipping firmware and/or because of the 'client_votes' thing
which looks like special extra data describing the other subsystems? At
least for some SoCs it may be all they need though, so keeping the PSCI
call in mind would be good when developing the ABI and may be enough for
userspace purposes. The client_votes part may be possible to layer on
top of the PSCI calls anyway, and go into some other file so we can
figure out which remoteproc is holding up suspend or idle states.

>=20
> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> index 880cf0290962..7aac24430e99 100644
> --- a/drivers/soc/qcom/Kconfig
> +++ b/drivers/soc/qcom/Kconfig
> @@ -163,6 +163,15 @@ config QCOM_SMSM
>           Say yes here to support the Qualcomm Shared Memory State Machin=
e.
>           The state machine is represented by bits in shared memory.
> =20
> +config QCOM_SOC_SLEEP_STATS
> +       tristate "Qualcomm Technologies Inc. (QTI) SoC sleep stats driver"
> +       depends on ARCH_QCOM
> +       help
> +         Qualcomm Technologies Inc. (QTI) SoC sleep stats driver to read
> +         the shared memory exported by the remote processor related to

Shared memory sounds like DDR.

> +         various SoC level low power modes statistics and export to sysfs
> +         interface.
> +
>  config QCOM_WCNSS_CTRL
>         tristate "Qualcomm WCNSS control driver"
>         depends on ARCH_QCOM || COMPILE_TEST
> diff --git a/drivers/soc/qcom/soc_sleep_stats.c b/drivers/soc/qcom/soc_sl=
eep_stats.c
> new file mode 100644
> index 000000000000..5b95d68512ec
> --- /dev/null
> +++ b/drivers/soc/qcom/soc_sleep_stats.c
> @@ -0,0 +1,249 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +/*
> + * Copyright (c) 2011-2019, The Linux Foundation. All rights reserved.
> + */
> +
> +#define pr_fmt(fmt) "%s: " fmt, __func__
> +
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/uaccess.h>

Is this include used?

> +
> +#define ARCH_TIMER_FREQ        19200000

Can't this come through clk APIs? Or is this the ARM architected timer
freqeuency?

> +
> +struct stats_config {
> +       u32 offset_addr;
> +       u32 num_records;
> +       bool appended_stats_avail;
> +};
> +
> +struct soc_sleep_stats_data {
> +       phys_addr_t stats_base;
> +       resource_size_t stats_size;
> +       const struct stats_config *config;
> +       struct kobject *kobj;
> +       struct kobj_attribute ka;
> +       struct mutex lock;
> +};
> +
> +struct entry {
> +       __le32 stat_type;
> +       __le32 count;
> +       __le64 last_entered_at;
> +       __le64 last_exited_at;
> +       __le64 accumulated;
> +};
> +
> +struct appended_entry {
> +       __le32 client_votes;
> +       __le32 reserved[3];
> +};
> +
> +struct stats_entry {
> +       struct entry entry;
> +       struct appended_entry appended_entry;
> +};
> +
> +static inline u64 get_time_in_sec(u64 counter)
> +{
> +       do_div(counter, ARCH_TIMER_FREQ);
> +
> +       return counter;
> +}
> +
> +static inline ssize_t append_data_to_buf(char *buf, int length,
> +                                        struct stats_entry *data)
> +{
> +       char stat_type[5] =3D {0};
> +
> +       memcpy(stat_type, &data->entry.stat_type, sizeof(u32));

sizeof(u32) !=3D 5. Is this on purpose?

> +
> +       return scnprintf(buf, length,
> +                        "%s\n"
> +                        "\tCount                    :%u\n"
> +                        "\tLast Entered At(sec)     :%llu\n"
> +                        "\tLast Exited At(sec)      :%llu\n"
> +                        "\tAccumulated Duration(sec):%llu\n"
> +                        "\tClient Votes             :0x%x\n\n",
> +                        stat_type, data->entry.count,
> +                        data->entry.last_entered_at,
> +                        data->entry.last_exited_at,
> +                        data->entry.accumulated,
> +                        data->appended_entry.client_votes);
> +}
> +
> +static ssize_t stats_show(struct kobject *obj, struct kobj_attribute *at=
tr,
> +                         char *buf)
> +{
> +       void __iomem *reg;
> +       int i;
> +       uint32_t offset;
> +       ssize_t length =3D 0, op_length;
> +       struct stats_entry data;
> +       struct entry *e =3D &data.entry;
> +       struct appended_entry *ae =3D &data.appended_entry;
> +       struct soc_sleep_stats_data *drv =3D container_of(attr,
> +                                          struct soc_sleep_stats_data, k=
a);
> +
> +       mutex_lock(&drv->lock);
> +       reg =3D ioremap_nocache(drv->stats_base, drv->stats_size);
> +       if (!reg) {
> +               pr_err("io remap failed\n");

This looks like a real bad idea to ioremap each time the stats are
shown. Why not just map once in probe so we don't have to create a
mapping and suffer the overhead involved in that?

> +               mutex_unlock(&drv->lock);
> +               return length;
> +       }
> +
> +       for (i =3D 0; i < drv->config->num_records; i++) {
> +               offset =3D offsetof(struct entry, stat_type);
> +               e->stat_type =3D le32_to_cpu(readl_relaxed(reg + offset));
> +
> +               offset =3D offsetof(struct entry, count);
> +               e->count =3D le32_to_cpu(readl_relaxed(reg + offset));
> +
> +               offset =3D offsetof(struct entry, last_entered_at);
> +               e->last_entered_at =3D le64_to_cpu(readq_relaxed(reg + of=
fset));
> +
> +               offset =3D offsetof(struct entry, last_exited_at);
> +               e->last_exited_at =3D le64_to_cpu(readq_relaxed(reg + off=
set));
> +
> +               offset =3D offsetof(struct entry, last_exited_at);
> +               e->accumulated =3D le64_to_cpu(readq_relaxed(reg + offset=
));
> +
> +               e->last_entered_at =3D get_time_in_sec(e->last_entered_at=
);
> +               e->last_exited_at =3D get_time_in_sec(e->last_exited_at);
> +               e->accumulated =3D get_time_in_sec(e->accumulated);
> +
> +               reg +=3D sizeof(struct entry);
> +
> +               if (drv->config->appended_stats_avail) {
> +                       offset =3D offsetof(struct appended_entry, client=
_votes);
> +                       ae->client_votes =3D le32_to_cpu(readl_relaxed(re=
g +
> +                                                                    offs=
et));
> +
> +                       reg +=3D sizeof(struct appended_entry);
> +               } else
> +                       ae->client_votes =3D 0;

Please add braces to the else statement when the if statement has
braces.

> +
> +               op_length =3D append_data_to_buf(buf + length, PAGE_SIZE =
- length,
> +                                              &data);
> +               if (op_length >=3D PAGE_SIZE - length)
> +                       goto exit;
> +
> +               length +=3D op_length;
> +       }
> +exit:
> +       iounmap(reg);
> +       mutex_unlock(&drv->lock);
> +       return length;
> +}
> +
> +static int soc_sleep_stats_create_sysfs(struct platform_device *pdev,
> +                                       struct soc_sleep_stats_data *drv)
> +{
> +       int ret =3D -ENOMEM;
> +
> +       drv->kobj =3D kobject_create_and_add("soc_sleep", power_kobj);
> +       if (!drv->kobj)
> +               goto fail;

Just return -ENOMEM here. It is really weird to make kobjects directly
like this. How is userspace expected to use this?

> +
> +       sysfs_attr_init(drv->ka.attr);
> +       drv->ka.attr.mode =3D 0444;
> +       drv->ka.attr.name =3D "stats";
> +       drv->ka.show =3D stats_show;
> +
> +       ret =3D sysfs_create_file(drv->kobj, &drv->ka.attr);
> +       if (ret)
> +               goto fail;

Just return sysfs_create_file()?

> +
> +       platform_set_drvdata(pdev, drv);

Do this platform_set_drvdata in probe?

> +fail:
> +       return ret;
> +}
> +
> +static const struct stats_config rpm_data =3D {
> +       .offset_addr =3D 0x14,
> +       .num_records =3D 2,
> +       .appended_stats_avail =3D true,
> +};
> +
> +static const struct stats_config rpmh_data =3D {
> +       .offset_addr =3D 0x4,
> +       .num_records =3D 3,
> +       .appended_stats_avail =3D false,
> +};
> +
> +static const struct of_device_id soc_sleep_stats_table[] =3D {
> +       { .compatible =3D "qcom,rpm-sleep-stats", .data =3D &rpm_data},
> +       { .compatible =3D "qcom,rpmh-sleep-stats", .data =3D &rpmh_data},
> +       { },
> +};
> +
> +static int soc_sleep_stats_probe(struct platform_device *pdev)
> +{
> +       const struct of_device_id *match;
> +       struct soc_sleep_stats_data *drv;
> +       struct resource *res;
> +       void __iomem *offset_addr;
> +       int ret;
> +
> +       drv =3D devm_kzalloc(&pdev->dev, sizeof(*drv), GFP_KERNEL);
> +       if (!drv)
> +               return -ENOMEM;
> +
> +       match =3D of_match_node(soc_sleep_stats_table, pdev->dev.of_node);
> +       if (!match)
> +               return -ENODEV;
> +
> +       drv->config =3D match->data;

Is this of_device_get_match_data()?

> +
> +       res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       if (!res)
> +               return PTR_ERR(res);
> +
> +       offset_addr =3D ioremap_nocache(res->start + drv->config->offset_=
addr,
> +                                     sizeof(u32));

Why not just devm_platform_ioremap_resource()?

> +       if (IS_ERR(offset_addr))
> +               return PTR_ERR(offset_addr);
> +
> +       drv->stats_base =3D res->start | readl_relaxed(offset_addr);
> +       drv->stats_size =3D resource_size(res);
> +       iounmap(offset_addr);
> +       mutex_init(&drv->lock);

Hopefully this lock isn't required?

> +
> +       ret =3D soc_sleep_stats_create_sysfs(pdev, drv);
> +       if (ret)
> +               pr_info("Failed to create sysfs interface\n");

Not pr_err()? Or dev_err()?

> +
> +       return ret;
> +}
> +
> +static int soc_sleep_stats_remove(struct platform_device *pdev)
> +{
> +       struct soc_sleep_stats_data *drv =3D platform_get_drvdata(pdev);
> +
> +       sysfs_remove_file(drv->kobj, &drv->ka.attr);
> +       kobject_put(drv->kobj);
> +       platform_set_drvdata(pdev, NULL);

This last line isn't necessary. Please remove.

> +
> +       return 0;
> +}
> +

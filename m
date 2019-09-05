Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED17AAB34
	for <lists+linux-pm@lfdr.de>; Thu,  5 Sep 2019 20:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730303AbfIEShl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Sep 2019 14:37:41 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45226 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731401AbfIEShk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Sep 2019 14:37:40 -0400
Received: by mail-pf1-f194.google.com with SMTP id y72so2302185pfb.12
        for <linux-pm@vger.kernel.org>; Thu, 05 Sep 2019 11:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:subject:to:from:user-agent:date;
        bh=DVXLinOn8C5sgE/iJ6npN/AotN1/ZmynoznI4Mz+Yz0=;
        b=Wo036a/MVNiRCY/8ieCzuvcqpY38/FuRDkEbUTBQuXEfSFeNwRPPX/cxgd5gjpRfLY
         +00gU4JEE5ti9UAcc825apaiLqvovOSFyI0Nc0arVCbtnNJ5R9N+GUlBorrxHwUL7IW1
         jsLjvCT8iDRcVyhMVf4qRdvJ96DMU6u6SRpB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:subject:to:from
         :user-agent:date;
        bh=DVXLinOn8C5sgE/iJ6npN/AotN1/ZmynoznI4Mz+Yz0=;
        b=mVurR22pK51ho1O5QCkp1FDvWRIvaqmmqj+yUUKFIyPI663TVEoQlkhIeEpxZzmncQ
         YjrWjZ5NrKqKNJTztsve3t4x+TnJZN/d7oMWNfqw3N9XoT9C6QBiFAHQ46uOzb/S/seX
         vwtY49zNz1jBO8iWJbPnHqSAtsH0uHp7XevEk4BRs7l/j4MjQ3Yd0ivxnZV2ZKs1AGP5
         vZC0iwpAFDKRIl3C5cWLOngGnXp2pEMjE1/zRXyEqLJ2tf5tG3J6O+jl7P4660UVNsfe
         x2B55B5rBNzGhQCdVVluq5vdDEFH4NlBaLBGu9PDeHqoEtK9ovT88W9oIgRdm+0cbFXD
         TLmw==
X-Gm-Message-State: APjAAAV/YrjPAJ2l0LfFFpTg9NtJ90Qzhn/7eMV0sH/R00fxNmkiwPul
        4WBfygA5sUB3zo4kARZVZRjTbg==
X-Google-Smtp-Source: APXvYqzRud8B7hHX6wOgPLr5I8uTQvu8FG1Bk3AlyCTavbs7z3RrA6y/AQaftautCcysHal9XB2ZPg==
X-Received: by 2002:a62:e50c:: with SMTP id n12mr5678778pff.206.1567708659361;
        Thu, 05 Sep 2019 11:37:39 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id a134sm7202286pfa.162.2019.09.05.11.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 11:37:38 -0700 (PDT)
Message-ID: <5d7155f2.1c69fb81.61bf.f862@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190905091707.14420-1-mkshah@codeaurora.org>
References: <20190905091707.14420-1-mkshah@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        bjorn.andersson@linaro.org, evgreen@chromium.org,
        dianders@chromium.org, rnayak@codeaurora.org, ilina@codeaurora.org,
        lsrao@codeaurora.org, Maulik Shah <mkshah@codeaurora.org>
Subject: Re: [PATCH v2] soc: qcom: Introduce subsystem sleep stats driver
To:     Maulik Shah <mkshah@codeaurora.org>, agross@kernel.org,
        david.brown@linaro.org, linux-arm-msm@vger.kernel.org
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Thu, 05 Sep 2019 11:37:37 -0700
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Maulik Shah (2019-09-05 02:17:07)
> Multiple subsystems like modem, spss, adsp, cdsp present on
> Qualcomm Technologies Inc's (QTI) SoCs maintains low power mode
> statistics in shared memory (SMEM). Lets add a driver to read
> and display this information using sysfs.
>=20
> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
> ---
> Changes in v2:
>         - Correct Makefile to use QCOM_SS_SLEEP_STATS config
> ---
>  Documentation/ABI/testing/sysfs-power    |  10 ++
>  drivers/soc/qcom/Kconfig                 |   9 ++
>  drivers/soc/qcom/Makefile                |   1 +
>  drivers/soc/qcom/subsystem_sleep_stats.c | 146 +++++++++++++++++++++++
>  4 files changed, 166 insertions(+)
>  create mode 100644 drivers/soc/qcom/subsystem_sleep_stats.c
>=20
> diff --git a/Documentation/ABI/testing/sysfs-power b/Documentation/ABI/te=
sting/sysfs-power
> index 18b7dc929234..1f8bb201246a 100644
> --- a/Documentation/ABI/testing/sysfs-power
> +++ b/Documentation/ABI/testing/sysfs-power
> @@ -288,6 +288,16 @@ Description:
>                 writing a "0" (default) to it disables them.  Reads from
>                 this file return the current value.
> =20
> +What:          /sys/power/subsystem_sleep/stats
> +Date:          December 2017

It isn't December 2017.

> +Contact:       Maulik Shah <mkshah@codeaurora.org>
> +Description:
> +               The /sys/power/subsystem_sleep/stats file prints the subs=
ystem
> +               sleep information on Qualcomm Technologies, Inc. (QTI) So=
Cs.
> +
> +               Reading from this file will display subsystem level low p=
ower
> +               mode statistics.
> +

This directory doesn't make any sense to me. It's in the top-level power
directory and it is specific to qcom. Is this debugging information? Why
does userspace care about understanding the sleep stats information?
Please Cc Rafael on anything touching /sys/power/

>  What:          /sys/power/resume_offset
>  Date:          April 2018
>  Contact:       Mario Limonciello <mario.limonciello@dell.com>
> diff --git a/drivers/soc/qcom/subsystem_sleep_stats.c b/drivers/soc/qcom/=
subsystem_sleep_stats.c
> new file mode 100644
> index 000000000000..5379714b6ba4
> --- /dev/null
> +++ b/drivers/soc/qcom/subsystem_sleep_stats.c
> @@ -0,0 +1,146 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +/*
> + * Copyright (c) 2017-2019, The Linux Foundation. All rights reserved.
> + */
> +
> +#define pr_fmt(fmt) "%s: " fmt, KBUILD_MODNAME
> +
> +#include <linux/errno.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/types.h>
> +
> +#include <linux/soc/qcom/smem.h>
> +
> +enum subsystem_item_id {
> +       MODEM =3D 605,
> +       ADSP,
> +       CDSP,
> +       SLPI,
> +       GPU,
> +       DISPLAY,
> +};
> +
> +enum subsystem_pid {
> +       PID_APSS =3D 0,
> +       PID_MODEM =3D 1,
> +       PID_ADSP =3D 2,
> +       PID_SLPI =3D 3,
> +       PID_CDSP =3D 5,
> +       PID_GPU =3D PID_APSS,
> +       PID_DISPLAY =3D PID_APSS,
> +};
> +
> +struct subsystem_data {
> +       char *name;
> +       enum subsystem_item_id item_id;
> +       enum subsystem_pid pid;
> +};
> +
> +static const struct subsystem_data subsystems[] =3D {
> +       {"MODEM", MODEM, PID_MODEM},
> +       {"ADSP", ADSP, PID_ADSP},
> +       {"CDSP", CDSP, PID_CDSP},
> +       {"SLPI", SLPI, PID_SLPI},
> +       {"GPU", GPU, PID_GPU},
> +       {"DISPLAY", DISPLAY, PID_DISPLAY},

Please put spaces around braces.

> +};
> +
> +struct subsystem_stats {
> +       uint32_t version_id;
> +       uint32_t count;
> +       uint64_t last_entered;
> +       uint64_t last_exited;
> +       uint64_t accumulated_duration;
> +};
> +
> +struct subsystem_stats_prv_data {
> +       struct kobj_attribute ka;
> +       struct kobject *kobj;
> +};
> +
> +static struct subsystem_stats_prv_data *prvdata;
> +
> +static inline ssize_t subsystem_stats_print(char *prvbuf, ssize_t length,
> +                                           struct subsystem_stats *recor=
d,
> +                                           const char *name)
> +{
> +       return scnprintf(prvbuf, length, "%s\n\tVersion:0x%x\n"
> +                       "\tSleep Count:0x%x\n"
> +                       "\tSleep Last Entered At:0x%llx\n"
> +                       "\tSleep Last Exited At:0x%llx\n"
> +                       "\tSleep Accumulated Duration:0x%llx\n\n",
> +                       name, record->version_id, record->count,
> +                       record->last_entered, record->last_exited,
> +                       record->accumulated_duration);

Information in sysfs is supposed to be one value per file. This is a
bunch of different values and it includes a version field. Looks almost
like something we would put into /proc, but of course that doesn't make
any sense to put in /proc either.

Please rethink the whole approach here. Can this be placed under the
remoteproc nodes for each remote processor that's in the system? That
would make it more discoverable by userspace looking at the remoteproc
devices. I suppose GPU and DISPLAY aren't "remoteproc"s though so maybe
this should be a new 'class' for devices that have an RPMh RSC? Maybe
make a qcom_rpmh_rsc class and then have these be stats in there.

> +}
> +
> +static ssize_t subsystem_stats_show(struct kobject *kobj,
> +                                   struct kobj_attribute *attr, char *bu=
f)
> +{
> +       ssize_t length =3D 0;
> +       int i =3D 0;
> +       size_t size =3D 0;
> +       struct subsystem_stats *record =3D NULL;
> +
> +       /* Read SMEM data written by other subsystems */
> +       for (i =3D 0; i < ARRAY_SIZE(subsystems); i++) {
> +               record =3D (struct subsystem_stats *) qcom_smem_get(
> +                         subsystems[i].pid, subsystems[i].item_id, &size=
);
> +
> +               if (!IS_ERR_OR_NULL(record) && (PAGE_SIZE - length > 0))

It can return ERR pointer or NULL? Why?

> +                       length +=3D subsystem_stats_print(buf + length,
> +                                                       PAGE_SIZE - lengt=
h,
> +                                                       record,
> +                                                       subsystems[i].nam=
e);
> +       }
> +
> +       return length;
> +}
> +
> +static int __init subsystem_sleep_stats_init(void)
> +{
> +       struct kobject *ss_stats_kobj;
> +       int ret;
> +
> +       prvdata =3D kmalloc(sizeof(*prvdata), GFP_KERNEL);
> +       if (!prvdata)
> +               return -ENOMEM;
> +
> +       ss_stats_kobj =3D kobject_create_and_add("subsystem_sleep",
> +                                              power_kobj);
> +       if (!ss_stats_kobj)
> +               return -ENOMEM;
> +
> +       prvdata->kobj =3D ss_stats_kobj;
> +
> +       sysfs_attr_init(&prvdata->ka.attr);
> +       prvdata->ka.attr.mode =3D 0444;
> +       prvdata->ka.attr.name =3D "stats";
> +       prvdata->ka.show =3D subsystem_stats_show;
> +       prvdata->ka.store =3D NULL;

Does it need to be set to NULL explicitly? Why not kzalloc() prvdata
above?

> +
> +       ret =3D sysfs_create_file(prvdata->kobj, &prvdata->ka.attr);
> +       if (ret) {
> +               pr_err("sysfs_create_file failed\n");

Seems useless. Presumably sysfs_create_file() can complain itself.

> +               kobject_put(prvdata->kobj);
> +               kfree(prvdata);
> +               return ret;
> +       }
> +
> +       return ret;
> +}
> +
> +static void __exit subsystem_sleep_stats_exit(void)
> +{
> +       sysfs_remove_file(prvdata->kobj, &prvdata->ka.attr);
> +       kobject_put(prvdata->kobj);
> +       kfree(prvdata);
> +}
> +
> +module_init(subsystem_sleep_stats_init);

So if this is compiled into an arm/arm64 image that doesn't include qcom
platform support it will create this directory? That's just nonsensical.


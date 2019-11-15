Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04AEDFE68B
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2019 21:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfKOUqA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Nov 2019 15:46:00 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34751 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbfKOUp7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Nov 2019 15:45:59 -0500
Received: by mail-pl1-f194.google.com with SMTP id h13so5472413plr.1
        for <linux-pm@vger.kernel.org>; Fri, 15 Nov 2019 12:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:to:subject:from:user-agent:date;
        bh=YmzpnFwOPgE0XZ0FUKK1QiXjMq4DEEA521y7+3+D1hE=;
        b=lV77Si8nf2rXnKOCZ7xW/oNAjBaiKIpNXZbMMwU1n8akZpCF32VndeJKQLLKESGbc0
         FVEBoR9AaNNczGbyvQTyHhD3uwBwUVRdpgomdJGwEQKqajEQRWBmY6gylgqN7hF+nU3U
         XONheAr8E/Hf5vsoKksCLUWZMQs1f8aUnnwkU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:to:subject:from
         :user-agent:date;
        bh=YmzpnFwOPgE0XZ0FUKK1QiXjMq4DEEA521y7+3+D1hE=;
        b=faRfgWTXKFy6JjeRM0jZKm9pQN/QBZXzZMd1Y5BAJPX1DVJJJiGgbtrUkDF00XhJN+
         QZac87EgUhAI298Sts9BjiLgPCjIwzlPXDKlgVA8N4tSIiV+8LQrvbFmyuj9GE/VFw9h
         bXtpxVhqMYD31jFX/EignrRHNpusabWHW39j9pY8jBHrohnolnosB893LPKhteT8uiGO
         zPQ3Mq6LTnMuC02JTBY3AQE+DWaaY5bq7szZEAeteHh8VTRwtf2j/QEJiuRHsJ1D4QYf
         cRv60hp3jhaLM56iY3DM6VVRAJR5RFQ2cczwD7nYR/XwUUyT3+F3mccyviQHszK6N3aP
         bQRA==
X-Gm-Message-State: APjAAAXzgDDfb9XYo/Sd/Ex7DnACjJf+UX3fmz3eTG3eXPjXNZ+u9bCG
        trdUr2ILwKGSD0ME3M06eoma/Q==
X-Google-Smtp-Source: APXvYqxWgTk3dfmmxcbJQlCuJDpAzbvz/Iv7KkuGI4ThtNhdpvGb1tothE1ZO7Y75zNdr9ezEoDZ1g==
X-Received: by 2002:a17:902:40a:: with SMTP id 10mr16904603ple.306.1573850758695;
        Fri, 15 Nov 2019 12:45:58 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id f19sm13178941pfk.109.2019.11.15.12.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 12:45:58 -0800 (PST)
Message-ID: <5dcf0e86.1c69fb81.a126f.5beb@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1573039165-30435-1-git-send-email-mkshah@codeaurora.org>
References: <1573039165-30435-1-git-send-email-mkshah@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, bjorn.andersson@linaro.org,
        evgreen@chromium.org, dianders@chromium.org, rnayak@codeaurora.org,
        ilina@codeaurora.org, lsrao@codeaurora.org,
        Maulik Shah <mkshah@codeaurora.org>
To:     Maulik Shah <mkshah@codeaurora.org>, agross@kernel.org,
        david.brown@linaro.org, rafael@kernel.org
Subject: Re: [v3] soc: qcom: Introduce subsystem sleep stats driver
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Fri, 15 Nov 2019 12:45:56 -0800
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Maulik Shah (2019-11-06 03:19:25)
> diff --git a/Documentation/ABI/testing/sysfs-power b/Documentation/ABI/te=
sting/sysfs-power
> index 6f87b9d..e095eae 100644
> --- a/Documentation/ABI/testing/sysfs-power
> +++ b/Documentation/ABI/testing/sysfs-power
> @@ -288,6 +288,16 @@ Description:
>                 writing a "0" (default) to it disables them.  Reads from
>                 this file return the current value.
> =20
> +What:          /sys/power/subsystem_sleep/stats
> +Date:          December 2017
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

I still don't understand what this has to do with the kernel's power
management support.

> +
>  What:          /sys/power/resume_offset
>  Date:          April 2018
>  Contact:       Mario Limonciello <mario.limonciello@dell.com>
> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> index 79d8265..bed0704 100644
> --- a/drivers/soc/qcom/Kconfig
> +++ b/drivers/soc/qcom/Kconfig
> @@ -185,6 +185,15 @@ config QCOM_SOCINFO
>          Say yes here to support the Qualcomm socinfo driver, providing
>          information about the SoC to user space.
> =20
> +config QCOM_SS_SLEEP_STATS
> +       tristate "Qualcomm Technologies Inc. Subsystem Sleep Stats driver"
> +       depends on QCOM_SMEM
> +       help
> +         Say y here to enable support for the Qualcomm Technologies Inc =
(QTI)

This 'Inc' is missing the full stop like in the summary above. Please be
consistent.

> +         SS sleep stats driver to read the sleep stats of various subsys=
tems

what is 'SS'?

> +         from SMEM. The stats are exported to sysfs. The driver also mai=
ntains
> +         application processor sleep stats.
> +
>  config QCOM_WCNSS_CTRL
>         tristate "Qualcomm WCNSS control driver"
>         depends on ARCH_QCOM || COMPILE_TEST
> diff --git a/drivers/soc/qcom/subsystem_sleep_stats.c b/drivers/soc/qcom/=
subsystem_sleep_stats.c
> new file mode 100644
> index 00000000..724b213
> --- /dev/null
> +++ b/drivers/soc/qcom/subsystem_sleep_stats.c
> @@ -0,0 +1,143 @@
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

I think we need to include linux/kernel.h for scnprintf() too.

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

Can these just be defines? There seems to be no value in enum because
we're not testing these in switch statements and they're randomly
assigned values.

> +
> +struct subsystem_data {
> +       char *name;
> +       enum subsystem_item_id item_id;
> +       enum subsystem_pid pid;
> +};
> +
> +static const struct subsystem_data subsystems[] =3D {
> +       { "MODEM", MODEM, PID_MODEM },
> +       { "ADSP", ADSP, PID_ADSP },
> +       { "CDSP", CDSP, PID_CDSP },
> +       { "SLPI", SLPI, PID_SLPI },
> +       { "GPU", GPU, PID_GPU },
> +       { "DISPLAY", DISPLAY, PID_DISPLAY },
> +};
> +
> +struct subsystem_stats {
> +       uint32_t version_id;
> +       uint32_t count;
> +       uint64_t last_entered;
> +       uint64_t last_exited;
> +       uint64_t accumulated_duration;

We use u32 and u64 in kernel code. Also, is this the value in shared
memory? Probably it's little endian so needs to be __le32 an __le64.

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

This isn't one value per file as per sysfs rules. Why can't this go to
debugfs? Otherwise, it would be better to split it up into multiple
files.

And it still looks like something that should be plumbed into the remote
proc subsystem so we can see from userspace what remote processors are
1) present in the system and 2) how long they've been in a sleep state.

> +}
> +
> +static ssize_t subsystem_stats_show(struct kobject *kobj,
> +                                   struct kobj_attribute *attr, char *bu=
f)
> +{
> +       ssize_t length =3D 0;
> +       int i =3D 0;

Drop assignment to i here.

> +       size_t size =3D 0;

Why assign size to 0? It looks unused in this function besides to store
the size in qcom_smem_get(). It looks like we can pass NULL for that
argument if we don't care to actually look at the size of what is
returned.

> +       struct subsystem_stats *record =3D NULL;

Please don't assign to NULL and then overwrite it without testing in
between.

> +
> +       /* Read SMEM data written by other subsystems */
> +       for (i =3D 0; i < ARRAY_SIZE(subsystems); i++) {
> +               record =3D (struct subsystem_stats *) qcom_smem_get(

The cast is unnecessary, it returns a void * already.

> +                         subsystems[i].pid, subsystems[i].item_id, &size=
);
> +
> +               if (!IS_ERR(record) && (PAGE_SIZE - length > 0))
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
> +       prvdata =3D kzalloc(sizeof(*prvdata), GFP_KERNEL);
> +       if (!prvdata)
> +               return -ENOMEM;
> +
> +       ss_stats_kobj =3D kobject_create_and_add("subsystem_sleep",
> +                                              power_kobj);

If this module is loaded on non-qcom platforms we'll create
subsystem_sleep directory still. Please don't do that. If this was
connected to remote proc it would be easier to avoid this problem.

> +       if (!ss_stats_kobj)
> +               return -ENOMEM;
> +
> +       prvdata->kobj =3D ss_stats_kobj;
> +
> +       sysfs_attr_init(&prvdata->ka.attr);
> +       prvdata->ka.attr.mode =3D 0444;
> +       prvdata->ka.attr.name =3D "stats";
> +       prvdata->ka.show =3D subsystem_stats_show;
> +
> +       ret =3D sysfs_create_file(prvdata->kobj, &prvdata->ka.attr);
> +       if (ret) {
> +               kobject_put(prvdata->kobj);
> +               kfree(prvdata);
> +       }
> +
> +       return ret;
> +}
> +

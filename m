Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 928F8EA7E3
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2019 00:40:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbfJ3Xkv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Oct 2019 19:40:51 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:38774 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfJ3Xkv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Oct 2019 19:40:51 -0400
Received: by mail-il1-f194.google.com with SMTP id y5so3741934ilb.5;
        Wed, 30 Oct 2019 16:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=quqshQ137yqtN7t6AIFEtWJn/EYUuG9xXWX7suw57qo=;
        b=eFRizubuBqk1f0vXFPgTKFQskl+SbCIjE8UIMP0k+4x6QnQYNeRE4R+infFSulKCLd
         uj9QH9H1NA+4zo2blgEarT6+Zw28qBQZxeRUT7hWQjpQS4YoZJlimK+XmgosoB3BxOqU
         y5OXNth1xrJeKe+CEAYc6FwG5hBSHcVv6S/jyOrTwlLAzW+b+4kI7pOeb4sqzJ8l/LST
         X8RciW1EJwU3+fPuB+H0iS45P42Cv3HW/l/0i1dYc8d2ku/MpG7qHjIX/lPVKPe2AjIS
         BhAvpBwkue2W1RwsNj5dKnpwSsNMPHUAiKBePZ8bE+CE3gLwrnBjpmkQUTFmvg+xwdbB
         stTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=quqshQ137yqtN7t6AIFEtWJn/EYUuG9xXWX7suw57qo=;
        b=gJ9oWmkeUEzyi/kDdkumqwSXENV3EjI1lIhrYVvv7O15/GWgHUEb9c0AmczofuWBKV
         ogZIPGJJGw/wpM8zbzXt+nIWvwUjZXUrMjplGmvsJ7TrftR7Th/vX1leJWnRNlowNbdM
         SCvwCYaEQ+WCdxGgIS80omPYYqNYoQxx8LqGFJeAhCiDi7pS+hs3lfV6it+/Zu2qz5ES
         h2ygNZurvjOffXR+4efJYLX4JDYeRDEbIVDfN4Et2CXZSYYY1xB053Xrk5u3sKZkvn+K
         j4K7Jo4HIZI6vSIvLqo6BLfEFBUsNr2rJdLfKNeMsxBPopFL8fAbiDQIpelvq2oDOIdI
         1fZA==
X-Gm-Message-State: APjAAAX399BnF9Ypq5OlY3v8zF+4vgIZSscEK47BILEi+oezlO9jRw/a
        cyxxNH56bwxiRcGx52AwQBUN9jrv9Uf+Mframhw=
X-Google-Smtp-Source: APXvYqx1TAibZGxEERdHkYEX5qTtmkltCoaPf4OU2X2Qj92QukKDIrJLFVOde2JwxxhJkfIEEp9f8v6U4XMJvpi5JR8=
X-Received: by 2002:a92:5c4f:: with SMTP id q76mr2757323ilb.158.1572478850034;
 Wed, 30 Oct 2019 16:40:50 -0700 (PDT)
MIME-Version: 1.0
References: <20191029223214.18889-1-linux@roeck-us.net>
In-Reply-To: <20191029223214.18889-1-linux@roeck-us.net>
From:   Chris Healy <cphealy@gmail.com>
Date:   Wed, 30 Oct 2019 16:40:39 -0700
Message-ID: <CAFXsbZo1hObASv5RO6EcGcuJin=SL8+epTJG9iSF1LHn+A3uZw@mail.gmail.com>
Subject: Re: [PATCH v2] nvme: Add hardware monitoring support
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-nvme@lists.infradead.org,
        Akinobu Mita <akinobu.mita@gmail.com>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On an ARM64 system with Toshiba SSD:

Tested-by: Chris Healy <cphealy@gmail.com>

On Tue, Oct 29, 2019 at 3:32 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> nvme devices report temperature information in the controller information
> (for limits) and in the smart log. Currently, the only means to retrieve
> this information is the nvme command line interface, which requires
> super-user privileges.
>
> At the same time, it would be desirable to use NVME temperature informati=
on
> for thermal control.
>
> This patch adds support to read NVME temperatures from the kernel using t=
he
> hwmon API and adds temperature zones for NVME drives. The thermal subsyst=
em
> can use this information to set thermal policies, and userspace can acces=
s
> it using libsensors and/or the "sensors" command.
>
> Example output from the "sensors" command:
>
> nvme0-pci-0100
> Adapter: PCI adapter
> Composite:    +39.0=C2=B0C  (high =3D +85.0=C2=B0C, crit =3D +85.0=C2=B0C=
)
> Sensor 1:     +39.0=C2=B0C
> Sensor 2:     +41.0=C2=B0C
>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2: Use devm_kfree() to release memory in error path
>
>  drivers/nvme/host/Kconfig      |  10 ++
>  drivers/nvme/host/Makefile     |   1 +
>  drivers/nvme/host/core.c       |   5 +
>  drivers/nvme/host/nvme-hwmon.c | 163 +++++++++++++++++++++++++++++++++
>  drivers/nvme/host/nvme.h       |   8 ++
>  5 files changed, 187 insertions(+)
>  create mode 100644 drivers/nvme/host/nvme-hwmon.c
>
> diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
> index 2b36f052bfb9..aeb49e16e386 100644
> --- a/drivers/nvme/host/Kconfig
> +++ b/drivers/nvme/host/Kconfig
> @@ -23,6 +23,16 @@ config NVME_MULTIPATH
>            /dev/nvmeXnY device will show up for each NVMe namespaces,
>            even if it is accessible through multiple controllers.
>
> +config NVME_HWMON
> +       bool "NVME hardware monitoring"
> +       depends on (NVME_CORE=3Dy && HWMON=3Dy) || (NVME_CORE=3Dm && HWMO=
N)
> +       help
> +         This provides support for NVME hardware monitoring. If enabled,
> +         a hardware monitoring device will be created for each NVME driv=
e
> +         in the system.
> +
> +         If unsure, say N.
> +
>  config NVME_FABRICS
>         tristate
>
> diff --git a/drivers/nvme/host/Makefile b/drivers/nvme/host/Makefile
> index 8a4b671c5f0c..03de4797a877 100644
> --- a/drivers/nvme/host/Makefile
> +++ b/drivers/nvme/host/Makefile
> @@ -14,6 +14,7 @@ nvme-core-$(CONFIG_TRACING)           +=3D trace.o
>  nvme-core-$(CONFIG_NVME_MULTIPATH)     +=3D multipath.o
>  nvme-core-$(CONFIG_NVM)                        +=3D lightnvm.o
>  nvme-core-$(CONFIG_FAULT_INJECTION_DEBUG_FS)   +=3D fault_inject.o
> +nvme-core-$(CONFIG_NVME_HWMON)         +=3D nvme-hwmon.o
>
>  nvme-y                                 +=3D pci.o
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index fa7ba09dca77..fc1d4b146717 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2796,6 +2796,9 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
>         ctrl->oncs =3D le16_to_cpu(id->oncs);
>         ctrl->mtfa =3D le16_to_cpu(id->mtfa);
>         ctrl->oaes =3D le32_to_cpu(id->oaes);
> +       ctrl->wctemp =3D le16_to_cpu(id->wctemp);
> +       ctrl->cctemp =3D le16_to_cpu(id->cctemp);
> +
>         atomic_set(&ctrl->abort_limit, id->acl + 1);
>         ctrl->vwc =3D id->vwc;
>         if (id->mdts)
> @@ -2897,6 +2900,8 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
>
>         ctrl->identified =3D true;
>
> +       nvme_hwmon_init(ctrl);
> +
>         return 0;
>
>  out_free:
> diff --git a/drivers/nvme/host/nvme-hwmon.c b/drivers/nvme/host/nvme-hwmo=
n.c
> new file mode 100644
> index 000000000000..af5eda326ec6
> --- /dev/null
> +++ b/drivers/nvme/host/nvme-hwmon.c
> @@ -0,0 +1,163 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * NVM Express hardware monitoring support
> + * Copyright (c) 2019, Guenter Roeck
> + */
> +
> +#include <linux/hwmon.h>
> +
> +#include "nvme.h"
> +
> +struct nvme_hwmon_data {
> +       struct nvme_ctrl *ctrl;
> +       struct nvme_smart_log log;
> +};
> +
> +static int nvme_hwmon_get_smart_log(struct nvme_hwmon_data *data)
> +{
> +       return nvme_get_log(data->ctrl, NVME_NSID_ALL, NVME_LOG_SMART, 0,
> +                           &data->log, sizeof(data->log), 0);
> +}
> +
> +static int nvme_hwmon_read(struct device *dev, enum hwmon_sensor_types t=
ype,
> +                          u32 attr, int channel, long *val)
> +{
> +       struct nvme_hwmon_data *data =3D dev_get_drvdata(dev);
> +       struct nvme_smart_log *log =3D &data->log;
> +       int err;
> +       int temp;
> +
> +       err =3D nvme_hwmon_get_smart_log(data);
> +       if (err)
> +               return err < 0 ? err : -EPROTO;
> +
> +       switch (attr) {
> +       case hwmon_temp_max:
> +               *val =3D (data->ctrl->wctemp - 273) * 1000;
> +               break;
> +       case hwmon_temp_crit:
> +               *val =3D (data->ctrl->cctemp - 273) * 1000;
> +               break;
> +       case hwmon_temp_input:
> +               if (!channel)
> +                       temp =3D le16_to_cpup((__le16 *)log->temperature)=
;
> +               else
> +                       temp =3D le16_to_cpu(log->temp_sensor[channel - 1=
]);
> +               *val =3D (temp - 273) * 1000;
> +               break;
> +       case hwmon_temp_crit_alarm:
> +               *val =3D !!(log->critical_warning & NVME_SMART_CRIT_TEMPE=
RATURE);
> +               break;
> +       default:
> +               err =3D -EOPNOTSUPP;
> +               break;
> +       }
> +       return err;
> +}
> +
> +static const char * const nvme_hwmon_sensor_names[] =3D {
> +       "Composite",
> +       "Sensor 1",
> +       "Sensor 2",
> +       "Sensor 3",
> +       "Sensor 4",
> +       "Sensor 5",
> +       "Sensor 6",
> +       "Sensor 7",
> +       "Sensor 8",
> +};
> +
> +static int nvme_hwmon_read_string(struct device *dev,
> +                                 enum hwmon_sensor_types type, u32 attr,
> +                                 int channel, const char **str)
> +{
> +       *str =3D nvme_hwmon_sensor_names[channel];
> +       return 0;
> +}
> +
> +static umode_t nvme_hwmon_is_visible(const void *_data,
> +                                    enum hwmon_sensor_types type,
> +                                    u32 attr, int channel)
> +{
> +       const struct nvme_hwmon_data *data =3D _data;
> +
> +       switch (attr) {
> +       case hwmon_temp_crit:
> +               if (!channel && data->ctrl->cctemp)
> +                       return 0444;
> +               break;
> +       case hwmon_temp_max:
> +               if (!channel && data->ctrl->wctemp)
> +                       return 0444;
> +               break;
> +       case hwmon_temp_crit_alarm:
> +               if (!channel)
> +                       return 0444;
> +               break;
> +       case hwmon_temp_input:
> +       case hwmon_temp_label:
> +               if (!channel || data->log.temp_sensor[channel - 1])
> +                       return 0444;
> +               break;
> +       default:
> +               break;
> +       }
> +       return 0;
> +}
> +
> +static const struct hwmon_channel_info *nvme_hwmon_info[] =3D {
> +       HWMON_CHANNEL_INFO(chip, HWMON_C_REGISTER_TZ),
> +       HWMON_CHANNEL_INFO(temp,
> +                          HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_CRIT |
> +                               HWMON_T_LABEL | HWMON_T_CRIT_ALARM,
> +                          HWMON_T_INPUT | HWMON_T_LABEL,
> +                          HWMON_T_INPUT | HWMON_T_LABEL,
> +                          HWMON_T_INPUT | HWMON_T_LABEL,
> +                          HWMON_T_INPUT | HWMON_T_LABEL,
> +                          HWMON_T_INPUT | HWMON_T_LABEL,
> +                          HWMON_T_INPUT | HWMON_T_LABEL,
> +                          HWMON_T_INPUT | HWMON_T_LABEL,
> +                          HWMON_T_INPUT | HWMON_T_LABEL),
> +       NULL
> +};
> +
> +static const struct hwmon_ops nvme_hwmon_ops =3D {
> +       .is_visible =3D nvme_hwmon_is_visible,
> +       .read =3D nvme_hwmon_read,
> +       .read_string =3D nvme_hwmon_read_string,
> +};
> +
> +static const struct hwmon_chip_info nvme_hwmon_chip_info =3D {
> +       .ops =3D &nvme_hwmon_ops,
> +       .info =3D nvme_hwmon_info,
> +};
> +
> +void nvme_hwmon_init(struct nvme_ctrl *ctrl)
> +{
> +       struct device *dev =3D ctrl->device;
> +       struct nvme_hwmon_data *data;
> +       struct device *hwmon;
> +       int err;
> +
> +       data =3D devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +       if (!data)
> +               return;
> +
> +       data->ctrl =3D ctrl;
> +
> +       err =3D nvme_hwmon_get_smart_log(data);
> +       if (err) {
> +               dev_warn(dev, "Failed to read smart log (error %d)\n", er=
r);
> +               devm_kfree(dev, data);
> +               return;
> +       }
> +
> +       hwmon =3D devm_hwmon_device_register_with_info(dev, dev_name(dev)=
,
> +                                                    data,
> +                                                    &nvme_hwmon_chip_inf=
o,
> +                                                    NULL);
> +       if (IS_ERR(hwmon)) {
> +               dev_warn(dev, "Failed to instantiate hwmon device\n");
> +               devm_kfree(dev, data);
> +       }
> +}
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 22e8401352c2..e6460c1216bc 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -231,6 +231,8 @@ struct nvme_ctrl {
>         u16 kas;
>         u8 npss;
>         u8 apsta;
> +       u16 wctemp;
> +       u16 cctemp;
>         u32 oaes;
>         u32 aen_result;
>         u32 ctratt;
> @@ -652,4 +654,10 @@ static inline struct nvme_ns *nvme_get_ns_from_dev(s=
truct device *dev)
>         return dev_to_disk(dev)->private_data;
>  }
>
> +#if IS_ENABLED(CONFIG_NVME_HWMON)
> +void nvme_hwmon_init(struct nvme_ctrl *ctrl);
> +#else
> +static inline void nvme_hwmon_init(struct nvme_ctrl *ctrl) { }
> +#endif
> +
>  #endif /* _NVME_H */
> --
> 2.17.1
>

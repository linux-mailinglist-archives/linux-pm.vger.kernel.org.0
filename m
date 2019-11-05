Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74AEAF01A0
	for <lists+linux-pm@lfdr.de>; Tue,  5 Nov 2019 16:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730988AbfKEPix (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Nov 2019 10:38:53 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45772 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727889AbfKEPix (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Nov 2019 10:38:53 -0500
Received: by mail-lj1-f193.google.com with SMTP id n21so8750825ljg.12;
        Tue, 05 Nov 2019 07:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EIBHT5s6k+333mQe6iMA24qOIrnpa2LpfWWRGm3y8Uk=;
        b=Gk33wkxLvAqPOKdHBeJ6/Wa+w97SPkh9B3EAkkX7ibmcliP2i+jxA/tLdWb7LJQcao
         22DiooKESnaW5Fr1zKJC2eDwcXyX9eDXs8BkHVl1mglyDeJsj3Tc8MDf4Kgrt0LEzcCD
         6re7DGPQuAlrVVB+LWbQM9X1Z7SLuzsS1dhaSWU8BLN201a2TVuFP28M2anLI1/JmtsO
         gl/6KVoA1f5ZldRpmIbIXKELKfQvbRGgKsG5C0/HUkNHrEDNx7BLUGEMCvE2uNW5eH5E
         oVdhEc1kPI3nfsLIM9tAFvhe3CN426XtFhX3D7Kiq0WIrJXFgVIYt2KzzkOoGIT+fD74
         uxcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EIBHT5s6k+333mQe6iMA24qOIrnpa2LpfWWRGm3y8Uk=;
        b=nk0QWyDakuSphyDGI/gDteik8EAuPwebbgbJ3DdS64HTSF8jOK7rOAiSNDMtcVe94D
         wN0Z2GgZxKTzdTu3xbcQ9qU4CSRbZt2+kuFMgNKYUELJmIq5biRxq1ciGZPqNjfgk3sT
         rZcI2Eg8j9bzeM1wmTg3Gpk5WU6vtvf11rrnNnpCGQjx7jlOCUAr7NOvGnJTSEOAGz90
         ArjSH9pYctpMyxGQIEex/9J7koUfbnj/GBoELVf7V5SFtjE1Y+0Kg+D+f/lf8hMTzTJR
         8DnsZHuN4a/ei5fHTdhrzuY//+DiqlJ7H4W1/tUNxt7SL3x5ykKYsGfyMd0lbar3OStY
         PLBw==
X-Gm-Message-State: APjAAAWQ1yqQWXMnBqvkGABk9F6uiH4OjcFnuZ/NKVacQLDOWl3JkOs1
        tmBqzIp+HP/WGx16FDBnR3CWSix/ZVVEfChbc0SdiLaD
X-Google-Smtp-Source: APXvYqyiGPWvrCoBqJQH7r/HG/3sG6Ju3FA5kbjzd30hxCt/lsfpv0gfRpsiNbY1AP1GIFX/pQGmwzTzcF1+WHkGSGU=
X-Received: by 2002:a2e:9842:: with SMTP id e2mr6634886ljj.93.1572968331102;
 Tue, 05 Nov 2019 07:38:51 -0800 (PST)
MIME-Version: 1.0
References: <20191102145530.16104-1-linux@roeck-us.net>
In-Reply-To: <20191102145530.16104-1-linux@roeck-us.net>
From:   Akinobu Mita <akinobu.mita@gmail.com>
Date:   Wed, 6 Nov 2019 00:38:39 +0900
Message-ID: <CAC5umyi9PuMTERNvNShfzu725bhBtkOZsD3NWtcxhKq5XGU2CQ@mail.gmail.com>
Subject: Re: [PATCH v4] nvme: Add hardware monitoring support
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Keith Busch <kbusch@kernel.org>, Chris Healy <cphealy@gmail.com>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-nvme@lists.infradead.org, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

2019=E5=B9=B411=E6=9C=882=E6=97=A5(=E5=9C=9F) 23:55 Guenter Roeck <linux@ro=
eck-us.net>:
> diff --git a/drivers/nvme/host/nvme-hwmon.c b/drivers/nvme/host/nvme-hwmo=
n.c
> new file mode 100644
> index 000000000000..28b4b7f43bb0
> --- /dev/null
> +++ b/drivers/nvme/host/nvme-hwmon.c
> @@ -0,0 +1,181 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * NVM Express hardware monitoring support
> + * Copyright (c) 2019, Guenter Roeck
> + */
> +
> +#include <linux/hwmon.h>
> +#include <asm/unaligned.h>
> +
> +#include "nvme.h"
> +
> +struct nvme_hwmon_data {
> +       struct nvme_ctrl *ctrl;
> +       struct nvme_smart_log log;
> +       struct mutex read_lock;
> +};
> +
> +static int nvme_hwmon_get_smart_log(struct nvme_hwmon_data *data)
> +{
> +       int ret;
> +
> +       ret =3D nvme_get_log(data->ctrl, NVME_NSID_ALL, NVME_LOG_SMART, 0=
,
> +                          &data->log, sizeof(data->log), 0);
> +
> +       return ret <=3D 0 ? ret : -EIO;
> +}
> +
> +static int nvme_hwmon_read(struct device *dev, enum hwmon_sensor_types t=
ype,
> +                          u32 attr, int channel, long *val)
> +{
> +       struct nvme_hwmon_data *data =3D dev_get_drvdata(dev);
> +       struct nvme_smart_log *log =3D &data->log;
> +       int temp;
> +       int err;
> +
> +       /*
> +        * First handle attributes which don't require us to read
> +        * the smart log.
> +        */
> +       switch (attr) {
> +       case hwmon_temp_max:
> +               *val =3D (data->ctrl->wctemp - 273) * 1000;
> +               return 0;
> +       case hwmon_temp_crit:
> +               *val =3D (data->ctrl->cctemp - 273) * 1000;

This attribute should be 'hwmon_temp_max_alarm' rather than
'hwmon_temp_crit_alarm'?

The 'hwmon_temp_crit_alarm' indicates that the temperature is greater
than CCTEMP.

But according to the description of the Critical Warning field in the NVMe
spec, the bit 1 is set to '1' when the temperature is greater than or
equal to an over temperature threshold.  The default value of the over
temperature threshold for Composite Temperature is WCTEMP.

That's why I think this attribute should be 'hwmon_temp_max_alarm' which
indicates that the temperature is greater than WCTEMP.

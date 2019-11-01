Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9060EC685
	for <lists+linux-pm@lfdr.de>; Fri,  1 Nov 2019 17:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbfKAQTP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 Nov 2019 12:19:15 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43414 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbfKAQTP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Nov 2019 12:19:15 -0400
Received: by mail-pf1-f194.google.com with SMTP id 3so7385964pfb.10;
        Fri, 01 Nov 2019 09:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dAGwFFDGn7AorxgIz/AEpdCiGhCVLv3rIV9fz6SUeP8=;
        b=UMeh5QejuPBHRPk70ICMaxUtljVz04aSCgfhYqis0E+f/qX9YksRLO7gylTYEKYdZS
         mY9BheeLRGuXG96psRHLn7eGWKCfiXCVooi3Nr0pcj3xbx2JxEuIzoA5NikKE+TwNcac
         Czof0g0/HS6tjeFTLI3/C15xuzNymXh4xk/+5dl1tK0aCNXvDpZM/Cboof8NnyTLUGaJ
         5IbU+Tod3smBHkiY8bEnMCuwChwcxbDBZSc18TTgQc9rUsf3QZtbQyYcd/PmHgY81sNi
         Q7R5vkOLrftO5A+Hp7WcOYjnqVl2MANl57fpvIWa6ly2F/Bn0aiAELMZOR+mvVP8pXR6
         QbWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dAGwFFDGn7AorxgIz/AEpdCiGhCVLv3rIV9fz6SUeP8=;
        b=OZAIRAoZlKPAUAXoSyW/akRSX+BfpC1Opf9pizKBvlLRUoRfJDzwO0ldeoeBxiloqU
         ApLFaomjStQracM8Jo9mM9Ea7v/yGFe/hrpPruKYWpgfs9tf+8BhX/TnS4lt/lE1IpMN
         DR6NzP9p65KVdUrlyfN/J662YAWLZL/G7ds69aVK5o/FP9CmZ2PDk/TV/qvG7HgPZM1V
         3uYd2+LjY4SKl35/BHoQI1vMquhXcqvAxlNa0RVgm6Jn4pht7xhDZ4jMHX40tas4v3eD
         CAk6PtL3emrL3YSKmHgBG14kCluTcsFUrgj0H1keV561UHbZuZ55kX36nh5ofLPSjlDG
         B+Yg==
X-Gm-Message-State: APjAAAV3Tov7xdDJv2QT4tNqwUH3AmzXXFKstYvw1kP8QTtpYLqDazcs
        soPugdjLSvCllpXl+2lez8G5uHE7OxuJixOGp8A=
X-Google-Smtp-Source: APXvYqyI9lotw31W/ZvoHgHNajTKgybh89AhP1kwZOAh1wJBGAWlmqvLx8kWHzHz2ipfEJOIxWHoPn6XBMDYrjsksTw=
X-Received: by 2002:a62:fb06:: with SMTP id x6mr6778318pfm.231.1572625154324;
 Fri, 01 Nov 2019 09:19:14 -0700 (PDT)
MIME-Version: 1.0
References: <20191101035646.25644-1-linux@roeck-us.net>
In-Reply-To: <20191101035646.25644-1-linux@roeck-us.net>
From:   Akinobu Mita <akinobu.mita@gmail.com>
Date:   Sat, 2 Nov 2019 01:19:03 +0900
Message-ID: <CAC5umyhiOiAiYWs2Y=L5133CCQNnAgi8oq6AbGzgkznZKz5f-w@mail.gmail.com>
Subject: Re: [PATCH v3] nvme: Add hardware monitoring support
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

2019=E5=B9=B411=E6=9C=881=E6=97=A5(=E9=87=91) 12:56 Guenter Roeck <linux@ro=
eck-us.net>:
> +void nvme_hwmon_init(struct nvme_ctrl *ctrl)
> +{
> +       struct device *dev =3D ctrl->device;

Should we use 'ctrl->dev' instead of 'ctrl->device'?

The 'ctrl->device' is a pointer to char device and the '->of_node' member
is NULL.

So if devm_hwmon_device_register_with_info() (i.e. __hwmon_device_register)
is called with 'ctrl->device', it doesn't attempt to register a sensor to a
DT thermal zone (i.e. hwmon_thermal_add_sensor() is not called at all).

This change was required, when I tried this nvme hwmon patch with the
following DT thermal setup.

https://lore.kernel.org/linux-devicetree/1561990354-4084-3-git-send-email-a=
kinobu.mita@gmail.com/

> +       struct nvme_hwmon_data *data;
> +       struct device *hwmon;
> +       int err;
> +
> +       data =3D devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +       if (!data)
> +               return;
> +
> +       data->ctrl =3D ctrl;
> +       mutex_init(&data->read_lock);
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
, data,
> +                                                    &nvme_hwmon_chip_inf=
o,
> +                                                    NULL);

If the above change is applied, the second 'name' argument is changed
from 'nvme0' to '0000:01:00.0' as a side effect.  So we may want to
change the second argument, too.

> +       if (IS_ERR(hwmon)) {
> +               dev_warn(dev, "Failed to instantiate hwmon device\n");
> +               devm_kfree(dev, data);
> +       }
> +}

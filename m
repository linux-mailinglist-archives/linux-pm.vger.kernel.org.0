Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF060427AE7
	for <lists+linux-pm@lfdr.de>; Sat,  9 Oct 2021 16:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233799AbhJIOtA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 9 Oct 2021 10:49:00 -0400
Received: from mail-oi1-f177.google.com ([209.85.167.177]:41690 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233789AbhJIOtA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 9 Oct 2021 10:49:00 -0400
Received: by mail-oi1-f177.google.com with SMTP id s24so17721987oij.8;
        Sat, 09 Oct 2021 07:47:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C+x39jmHq8RQg6vmuJTMtrdvhN5piCFzTvf7qxI80EA=;
        b=1zdkZhPeF1FmegjE/1uTBKwwMuZFsGu8KCCpjJZwPGsJ+MEkIvOr3po1xwXuqZKkTX
         Fs8JcDfNAbzEs3iUQtlOuEdmSDK6BnVBRbYoxDt4pX+jm78oveAIIZshrIePlXR6V3qu
         BD3lDLh2sX8fGcfsrCdDf0r+2PO7W+QtLaH1Ad5hdOSAZwblY5vsbzb9mkaqEq0XdnCu
         O5RcUMg7UGVLlvahB+sG+den39yEJpR4hF2zABUQjnonNd8h/0g51qbmx2riEFshHr5r
         AJDIWq6cJby4v6wZPzhdnl5E4OwOtHhYJ5WGGH4F7KyRbnB72MQ9cwvaFmxpmdVMSJYS
         CkAw==
X-Gm-Message-State: AOAM533nBqJfP0KnfYKeWNyTYVOyr1R650bz9PZZyebB6VvmSRjj4b64
        m+qJuCqdKvsZ6jkyy8mLRR6mkEy+p0I1wGrn7CI=
X-Google-Smtp-Source: ABdhPJyaFl2215JVJWW+4ziX4BEq+UioTRjdmQapZd/+6YkUwOyPpmnt0zT6bbCc3QIHZNIVpZzjIP6D1cgEGe3IoyI=
X-Received: by 2002:aca:5c5:: with SMTP id 188mr5863261oif.154.1633790823222;
 Sat, 09 Oct 2021 07:47:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210917072732.611140-1-abailon@baylibre.com> <20210917072732.611140-3-abailon@baylibre.com>
 <CAJZ5v0hzS-bquhW_wbsd81EpJYx5RHxeXkamdZ+MBs4oczDw1A@mail.gmail.com>
In-Reply-To: <CAJZ5v0hzS-bquhW_wbsd81EpJYx5RHxeXkamdZ+MBs4oczDw1A@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 9 Oct 2021 16:46:52 +0200
Message-ID: <CAJZ5v0gTJSzPXimxwK6RUZfE-XJAPD0OcpdbchXxZ5hN=C_Euw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] thermal: add a virtual sensor to aggregate temperatures
To:     Alexandre Bailon <abailon@baylibre.com>
Cc:     "Zhang, Rui" <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ben.tseng@mediatek.com, Kevin Hilman <khilman@baylibre.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 7, 2021 at 6:38 PM Rafael J. Wysocki <rafael@kernel.org> wrote:

[cut]

> > +static int virtual_thermal_sensor_probe(struct platform_device *pdev)
> > +{
> > +       struct virtual_thermal_sensor *sensor;
> > +       struct device *dev = &pdev->dev;
> > +       struct of_phandle_args args;
> > +       u32 type;
> > +       int ret;
> > +       int i;
> > +
> > +       sensor = devm_kzalloc(dev, sizeof(*sensor), GFP_KERNEL);
> > +       if (!sensor)
> > +               return -ENOMEM;
> > +
> > +       sensor->count = of_count_phandle_with_args(dev->of_node,
> > +                                                  "thermal-sensors",
> > +                                                  "#thermal-sensor-cells");
> > +       if (sensor->count <= 0)
> > +               return -EINVAL;
> > +
> > +       sensor->sensors = devm_kmalloc_array(dev, sensor->count,
> > +                                            sizeof(*sensor->sensors),
> > +                                            GFP_KERNEL);
> > +       if (!sensor->sensors)
> > +               return -ENOMEM;
> > +
> > +       for (i = 0; i < sensor->count; i++) {
> > +               ret = of_parse_phandle_with_args(dev->of_node,
> > +                                                "thermal-sensors",
> > +                                                "#thermal-sensor-cells",
> > +                                                i,
> > +                                                &args);
> > +               if (ret)
> > +                       return ret;
> > +
> > +               ret = virtual_sensor_add_sensor(sensor, args, i);
> > +               if (ret)
> > +                       return ret;

One more issue that escaped me earlier is that if the hardware sensor
being looked for is not there in the thermal_sensors list at this
point (say because it has not been added to it yet by whoever is
expected to do that), the above will return -ENODEV and all probe will
fail without a way to retry.

It would be better to return -EPROBE_DEFER from here IIUC.

However, this still wouldn't address a more general issue that if the
hardware sensor gets unregistered and then registered again (eg. by
unloading and reloading a module managing it), it will not be added
back to the corresponding virtual sensor's data set.  This should not
be very hard to address and it would take care of the above
initialization ordering issue automatically.

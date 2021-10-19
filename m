Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6846433C86
	for <lists+linux-pm@lfdr.de>; Tue, 19 Oct 2021 18:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234478AbhJSQlI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Oct 2021 12:41:08 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:39865 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234483AbhJSQlI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Oct 2021 12:41:08 -0400
Received: by mail-ot1-f49.google.com with SMTP id e59-20020a9d01c1000000b00552c91a99f7so3577937ote.6;
        Tue, 19 Oct 2021 09:38:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pf+ZmgtAsq2+DIlmaBCIGg+7IqnLeyahgZKALzDPrlI=;
        b=rU/fxWfYlKDNmuFJq4ltBDdZI1YVe23qrbPOYFMZxoRKf326QK1J/xRkGNYcJ8yA1e
         68FFqMI7WeIrO8DITQ0uoi4n8vlnFXx8VUeTKwSczcmqgMbwrhbic1c/ktGmHCTnM0lN
         7F57hYjb2lo9F4uQl8cXupcYuPJQ58g5VHIz37S3WDmSFUkr/uLYhFOTEt8ud+XuUj3d
         wI2cmBl5gRTiGcZGnBTSKv8/EoA0QCgjEFQIE/6FBBD0A0ZQqk06PZrTgFp3JO4cFRQ0
         T7xYvoa2CDj04HwFRnNoamEBi4JBaJjiohmtORjOpiL9cmhNZFEcFrbnaOzQG4y0S7F0
         oSfg==
X-Gm-Message-State: AOAM533j90wWMGUjcS8/xUSXIITEe5yrkJF9ftu3NiCktuSHvFO4C92K
        DLHdrdepmTzupL6sF+INC5fqaP/JgBG/XR3gHjc=
X-Google-Smtp-Source: ABdhPJz4tX4Yv52Culq0N48P2cv9qe6Npaic2i0EqWNOmgxyZFUmbGtx/PpMdt1CGVdzt50qxEKujGBy6dKL5zgPZww=
X-Received: by 2002:a05:6830:1af0:: with SMTP id c16mr5911496otd.16.1634661534934;
 Tue, 19 Oct 2021 09:38:54 -0700 (PDT)
MIME-Version: 1.0
References: <20211019163506.2831454-1-daniel.lezcano@linaro.org> <20211019163506.2831454-2-daniel.lezcano@linaro.org>
In-Reply-To: <20211019163506.2831454-2-daniel.lezcano@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 19 Oct 2021 18:38:44 +0200
Message-ID: <CAJZ5v0i=v8KvmZzyoaXNuTa-+C4PyQGBe1k2UYbXAg6GksoNzQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] thermal/core: Deprecate changing cooling device
 state from userspace
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 19, 2021 at 6:35 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> The cooling devices have their cooling device set_cur_state
> read-writable all the time in the sysfs directory, thus allowing the
> userspace to act on it.
>
> The thermal framework is wrongly used by userspace as a power capping
> framework by acting on the cooling device opaque state. This one then
> competes with the in-kernel governor decision.
>
> We have seen in out-of-tree kernels, a big number of devices which are
> abusely declaring themselves as cooling device just to act on their
> power.
>
> The role of the thermal framework is to protect the junction
> temperature of the silicon. Letting the userspace to play with a
> cooling device is invalid and potentially dangerous.
>
> The powercap framework is the right framework to do power capping and
> moreover it deals with the aggregation via the dev pm qos.
>
> As the userspace governor is marked deprecated and about to be
> removed, there is no point to keep this file writable also in the
> future.
>
> Emit a warning and deprecate the interface.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/thermal/thermal_sysfs.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
> index 1c4aac8464a7..f154bada2906 100644
> --- a/drivers/thermal/thermal_sysfs.c
> +++ b/drivers/thermal/thermal_sysfs.c
> @@ -610,6 +610,9 @@ cur_state_store(struct device *dev, struct device_attribute *attr,
>         unsigned long state;
>         int result;
>
> +       dev_warn_once(&cdev->device,
> +                     "Setting cooling device state is deprecated\n");
> +
>         if (sscanf(buf, "%ld\n", &state) != 1)
>                 return -EINVAL;
>
> --
> 2.25.1
>

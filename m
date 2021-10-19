Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7C3843372C
	for <lists+linux-pm@lfdr.de>; Tue, 19 Oct 2021 15:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235691AbhJSNik (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Oct 2021 09:38:40 -0400
Received: from mail-oi1-f171.google.com ([209.85.167.171]:45901 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbhJSNij (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Oct 2021 09:38:39 -0400
Received: by mail-oi1-f171.google.com with SMTP id z126so4890917oiz.12;
        Tue, 19 Oct 2021 06:36:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lnpf5eUhLXI8j2gElhp4/XH3DNWhAe73BljjrUh6kl8=;
        b=Pbi6+9DMUxbit0oG3gzVRUD/GcvF2sgEnNrpkajuvHt0KH5RpZehhA8BKJkunj85TH
         tmpKcS7Om4t45RHBqYmj8eHMpnjMucxJFosjGi/8RHeFmcqQgpnRrELFw0AsNAY1pmMd
         N5iXe8ldVQXWttwdSZqfHScjLhnRc71lPQjgsHpx7VoLe6nAHk7nf23qORJ3kN3g04cq
         qzx2v397AASQRTdO5Pj7QweDUz0UQH8m3STXLMsUqsgenQ4nq1i209hkCrWMxyaaCy07
         RaY9486sT7fyxb+JCS0ZvtbSmW0V0bqGDggNFgKrjSpMRIk0x8Ut6j6Bx60vR7rxnyv4
         jXRA==
X-Gm-Message-State: AOAM530RfRgwCnJ8A179J/s1QLURim3eDmJ995G8yMBWLKAqNdVEkP7C
        mn4koMXYJyqeEFcss/23aAgEwCBKKBSdYeZmVXs=
X-Google-Smtp-Source: ABdhPJyLg69p7yFiPbQt3tlp9YiwCFJ/XYkoJTm1uPJm5yZpYQx4xx6EANj90TymnUjmY5/AQesSv8GqTSHHSArXNwQ=
X-Received: by 2002:aca:b5c3:: with SMTP id e186mr4383173oif.51.1634650586176;
 Tue, 19 Oct 2021 06:36:26 -0700 (PDT)
MIME-Version: 1.0
References: <20211019132211.2792475-1-daniel.lezcano@linaro.org> <20211019132211.2792475-2-daniel.lezcano@linaro.org>
In-Reply-To: <20211019132211.2792475-2-daniel.lezcano@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 19 Oct 2021 15:36:15 +0200
Message-ID: <CAJZ5v0hdhHiSEOrMp+pK0=MvNjT9sTRS8=o0M2bCfwC43GK=6g@mail.gmail.com>
Subject: Re: [PATCH 2/2] thermal/core: Make deprecated cooling device state
 change from userspace
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

On Tue, Oct 19, 2021 at 3:22 PM Daniel Lezcano
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
> temperature of the silicon.

It's more than that.  You also don't want to let the system's skin
temperature get too high, for example.

I would just say that the role of the thermal framework is thermal control.

> Letting the userspace to play with a
> cooling device is wrong and potentially dangerous.

Agreed, although I would say "invalid" instead of "wrong".

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
> ---
>  drivers/thermal/thermal_sysfs.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
> index 1c4aac8464a7..3f4ea3a283ae 100644
> --- a/drivers/thermal/thermal_sysfs.c
> +++ b/drivers/thermal/thermal_sysfs.c
> @@ -610,6 +610,8 @@ cur_state_store(struct device *dev, struct device_attribute *attr,
>         unsigned long state;
>         int result;
>
> +       WARN_ON_ONCE(1, "Setting cooling device state is deprecated\n");
> +

I would use pr_warn_once() instead.

>         if (sscanf(buf, "%ld\n", &state) != 1)
>                 return -EINVAL;
>
> --

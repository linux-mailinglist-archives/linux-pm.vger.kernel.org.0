Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDB3F433AD7
	for <lists+linux-pm@lfdr.de>; Tue, 19 Oct 2021 17:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbhJSPm0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Oct 2021 11:42:26 -0400
Received: from mail-ot1-f50.google.com ([209.85.210.50]:44003 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbhJSPmZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Oct 2021 11:42:25 -0400
Received: by mail-ot1-f50.google.com with SMTP id x33-20020a9d37a4000000b0054733a85462so3507497otb.10;
        Tue, 19 Oct 2021 08:40:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1GW53ULgIVo+eA02uouA/6vfgssXmkywyaW+hiJaZjo=;
        b=uNX7Z30gJdXlK6ZZF22Q8XJa07PBHGH4UjQnAcJMCVW7A8L5ztKG87AaivI9MSrn7F
         6m84HNOQYVllz51AZ5GaeuubF1w6UT7HGxEL6qn2x/m9wzAjTW3sGIbKp/LUc7vJTnv9
         23b18AjaxXC38FqPicyQnXdiuDX1w3SWIzpv2KhpkmFF1OM1xGkLTDC3gHovcI0Cg2+O
         KXk9nMwLnW8lGverjUNkzSZyygUtyRaBqIL0rTdW5H8iJpIhGATksDCiyfYdcxseuc6q
         NcVlK58P98UYSYOAGThycKtXEUhJeIjnZXQ97d12LsArDI4TAZlx7xDKxjWu8DVXrHcc
         Nc3w==
X-Gm-Message-State: AOAM532tkqYEkL1Rf+C68YIQZrhkdN9/3sQ7jgSVpLUNi0/ZaEqKjYKu
        9940ErY56yxMFLq5qeqhHUsU/SLzw5t+eBXrzNc=
X-Google-Smtp-Source: ABdhPJzQ3xKCus2gtYjTCdvxMA5NMHFXLLXfxfx4CaaGTuLGCFu7eW8RuF2oUwhwVswCtH4Hy+jWbOZlGr0zA8HXEPo=
X-Received: by 2002:a9d:65c1:: with SMTP id z1mr5844673oth.198.1634658012684;
 Tue, 19 Oct 2021 08:40:12 -0700 (PDT)
MIME-Version: 1.0
References: <20211019150203.2805738-1-daniel.lezcano@linaro.org> <20211019150203.2805738-2-daniel.lezcano@linaro.org>
In-Reply-To: <20211019150203.2805738-2-daniel.lezcano@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 19 Oct 2021 17:40:01 +0200
Message-ID: <CAJZ5v0i1RCKs8nMCc0ROsM03beOPL941r+=NPbQpidiZJ2OA8A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] thermal/core: Make deprecated cooling device state
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

On Tue, Oct 19, 2021 at 5:02 PM Daniel Lezcano
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
> ---
>  drivers/thermal/thermal_sysfs.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
> index 1c4aac8464a7..730f1361dbef 100644
> --- a/drivers/thermal/thermal_sysfs.c
> +++ b/drivers/thermal/thermal_sysfs.c
> @@ -610,6 +610,8 @@ cur_state_store(struct device *dev, struct device_attribute *attr,
>         unsigned long state;
>         int result;
>
> +       pr_warn_once("Setting cooling device state is deprecated\n");

Maybe dev_warn_once() even?  I guess it won\t hurt to print it once
per the affected device?

> +
>         if (sscanf(buf, "%ld\n", &state) != 1)
>                 return -EINVAL;
>
> --

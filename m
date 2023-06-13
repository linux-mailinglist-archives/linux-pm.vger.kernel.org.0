Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03BEF72DE1D
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jun 2023 11:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236663AbjFMJqj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Jun 2023 05:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237887AbjFMJqg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Jun 2023 05:46:36 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144B21701
        for <linux-pm@vger.kernel.org>; Tue, 13 Jun 2023 02:46:13 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id ada2fe7eead31-43b315e9024so257327137.2
        for <linux-pm@vger.kernel.org>; Tue, 13 Jun 2023 02:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686649564; x=1689241564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+CTHmKkHNWByXyeBUovPKyikwKUIQOVtMr6b873iA1w=;
        b=QQHEZTpd3ZLQ/BJK+Ibj0xc45IVTepo0ry0PdpSFy8ykAoGvQKKZp1mAzXMjHcTbTH
         AKYE3ZeZYzZppdmxt9ZA6Cmu5ZskQHnuLjKCK4pIrIHLr1w4b7lsN06+DBYnw7QwoZ1+
         Hag0OGW6BVVUpUv4E5lvPkIwgL+clAUCA0cKM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686649564; x=1689241564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+CTHmKkHNWByXyeBUovPKyikwKUIQOVtMr6b873iA1w=;
        b=lkJlV2b7vgISmAZjbeVZVY5tOxikAzvU7BhcYK/xzTmrH4BN/9O3o82bgAoCOwL/IZ
         2SiMxuELQj+JvI0ewK5a+9uSHN4+JKXf78s29TjGXmNydCZZ13T5hHbc82xJMujpmkB+
         KWOD2KGQP7kD6N7IAm/id/yuNeak3wNUkkNL6XALv9SI6Ut7p188sXWAERKfQYuhBHXx
         8knlvuEeMM0BORrpb9rwiU3oQBjkIedW61Gny3+VDxVgBhx1o2DeJtCddhRpL28UhYtD
         RIedIw1lGIY+tk0M9/o0izmtfjCES45hrqFmW/DWayME3QobZ8SkAat8tnpczRX7gYOP
         9RmQ==
X-Gm-Message-State: AC+VfDwlT3szmp1AaePLkBrLGrrD37zztK2Xz16TM7VVIl/0KHDq5NtF
        AazVAaXD+rcLx8hIcy+VgJpNQhB+nPd2Yfse+gOKJA==
X-Google-Smtp-Source: ACHHUZ6AkBvw7iO1Q0lsGEkgYddBpw1XFOsqhtz1oA5XjXJSK+muNfwgQDM9lVtrMjtA+AdUtTcuGGTogVGPmmmLQMg=
X-Received: by 2002:a67:bc0d:0:b0:43b:3eec:5e2b with SMTP id
 t13-20020a67bc0d000000b0043b3eec5e2bmr5654868vsn.33.1686649563843; Tue, 13
 Jun 2023 02:46:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230613093054.2067340-1-wenst@chromium.org> <3a840fbf-8250-9870-3caa-3e12c468aa24@linaro.org>
In-Reply-To: <3a840fbf-8250-9870-3caa-3e12c468aa24@linaro.org>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 13 Jun 2023 17:45:52 +0800
Message-ID: <CAGXv+5GWArqHok_ZcL=L9cMGfBnbP8vm26DM==F0i+6LQ24rxg@mail.gmail.com>
Subject: Re: [PATCH] thermal/drivers/generic-adc: Register thermal zones as
 hwmon sensors
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jun 13, 2023 at 5:44=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 13/06/2023 11:30, Chen-Yu Tsai wrote:
> > Register thermal zones as hwmon sensors to let userspace read
> > temperatures using standard hwmon interface.
> >
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > ---
> >   drivers/thermal/thermal-generic-adc.c | 8 ++++++++
> >   1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/thermal/thermal-generic-adc.c b/drivers/thermal/th=
ermal-generic-adc.c
> > index 017b0ce52122..e95dc354f192 100644
> > --- a/drivers/thermal/thermal-generic-adc.c
> > +++ b/drivers/thermal/thermal-generic-adc.c
> > @@ -13,6 +13,8 @@
> >   #include <linux/slab.h>
> >   #include <linux/thermal.h>
> >
> > +#include "thermal_hwmon.h"
> > +
> >   struct gadc_thermal_info {
> >       struct device *dev;
> >       struct thermal_zone_device *tz_dev;
> > @@ -153,6 +155,12 @@ static int gadc_thermal_probe(struct platform_devi=
ce *pdev)
> >               return ret;
> >       }
> >
> > +     ret =3D devm_thermal_add_hwmon_sysfs(&pdev->dev, gti->tz_dev);
> > +     if (ret) {
> > +             dev_err(&pdev->dev, "Failed to add hwmon sysfs attributes=
\n");
> > +             return ret;
> > +     }
>
> Usually, if the hwmon registering fails this is not fatal.

Ack. I'll change it to dev_warn.

ChenYu

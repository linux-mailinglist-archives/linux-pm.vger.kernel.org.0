Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 315B152AB45
	for <lists+linux-pm@lfdr.de>; Tue, 17 May 2022 20:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350085AbiEQSyI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 May 2022 14:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352390AbiEQSyH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 May 2022 14:54:07 -0400
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256634E3AD;
        Tue, 17 May 2022 11:54:06 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id t26so652049ybt.3;
        Tue, 17 May 2022 11:54:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qF0GVGEWML04R3eflXhzjNR3bh9aYLmjOF0GGxt5/MQ=;
        b=4IY94HE/DSxjckkD6sW/DIMiaOGO+PfpZYEMTgGQGTf7Afp6ZfJBRkuAzIF94jd3mT
         7rcSPtWzHVkIh2G9QwNSNqyTU85o1pIbVQKV+mr9K8L7MWaK6adLXlZls/J+lG1cFAIc
         k2FViWoKsgn9+Y8x3v/NJ5dfDu6ZGyLlnNr+RcuKMtGERjT9BlsJ+Nkyo10W3MKCb86C
         30ndygtCv3EwezbmgzaT6No4CHHkTjl2ghOF1VfxZOKOeY3BnhzIChCbDON/bgpwdyl/
         E2kQBijsHVYdxYsJKB1FvDAjMWxneayE5KGZPhZYd1co2TIkAHbgyqxRheWmgrwN+lUy
         b9XQ==
X-Gm-Message-State: AOAM530bA5b/JNbLDaxwEsfvyfFtasxoYzsoIyQ9Er3TbjniiadtwsW5
        ZDuxifOVWy01axrCUNHFYJ2HDZcB5rJBcqXf4UI=
X-Google-Smtp-Source: ABdhPJyGBw4F87Ht0i2/yHvICsShiFUUkK8/5v8rdIg8QWB5ngXGjygxVqdY3mWc6GMP5EQodHlMgx+0it1423H00xE=
X-Received: by 2002:a25:1145:0:b0:64d:d6be:c741 with SMTP id
 66-20020a251145000000b0064dd6bec741mr8839716ybr.137.1652813645345; Tue, 17
 May 2022 11:54:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220507125443.2766939-1-daniel.lezcano@linexp.org>
 <20220507125443.2766939-2-daniel.lezcano@linexp.org> <CAJZ5v0ik_JQ4Awtw7iR68W4-9ZL8FRDsDd-kWmL-n09fgg3reg@mail.gmail.com>
 <7b1a9f3b5b5087f47bf4839858c7bfebdb60aa2f.camel@linux.intel.com>
In-Reply-To: <7b1a9f3b5b5087f47bf4839858c7bfebdb60aa2f.camel@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 17 May 2022 20:53:54 +0200
Message-ID: <CAJZ5v0hqN-zKZvWTNPzW2P22Dirmyh99qyycf+US4Z9Yxw9mhA@mail.gmail.com>
Subject: Re: [PATCH v2 01/14] thermal/core: Change thermal_zone_ops to thermal_sensor_ops
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linexp.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Jonathan Corbet <corbet@lwn.net>, Len Brown <lenb@kernel.org>,
        Raju Rangoju <rajur@chelsio.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Ido Schimmel <idosch@nvidia.com>,
        Petr Machata <petrm@nvidia.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Kalle Valo <kvalo@kernel.org>, Peter Kaestle <peter@piie.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Chuansheng Liu <chuansheng.liu@intel.com>,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        Antoine Tenart <atenart@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "open list:ACPI THERMAL DRIVER" <linux-acpi@vger.kernel.org>,
        "open list:CXGB4 ETHERNET DRIVER (CXGB4)" <netdev@vger.kernel.org>,
        "open list:INTEL WIRELESS WIFI LINK (iwlwifi)" 
        <linux-wireless@vger.kernel.org>,
        "open list:ACER ASPIRE ONE TEMPERATURE AND FAN DRIVER" 
        <platform-driver-x86@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:RENESAS R-CAR THERMAL DRIVERS" 
        <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, May 17, 2022 at 6:51 PM srinivas pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Tue, 2022-05-17 at 17:42 +0200, Rafael J. Wysocki wrote:
> > On Sat, May 7, 2022 at 2:55 PM Daniel Lezcano
> > <daniel.lezcano@linexp.org> wrote:
> > >
> > > A thermal zone is software abstraction of a sensor associated with
> > > properties and cooling devices if any.
> > >
> > > The fact that we have thermal_zone and thermal_zone_ops mixed is
> > > confusing and does not clearly identify the different components
> > > entering in the thermal management process. A thermal zone appears
> > > to
> > > be a sensor while it is not.
> >
> > Well, the majority of the operations in thermal_zone_ops don't apply
> > to thermal sensors.  For example, ->set_trips(), ->get_trip_type(),
> > ->get_trip_temp().
> >
> In past we discussed adding thermal sensor sysfs with threshold to
> notify temperature.
>
> So sensor can have set/get_threshold() functions instead of the
> set/get_trip for zones.
>
> Like we have /sys/class/thermal_zone* we can have
> /sys/class/thermal_sensor*.

Exactly, so renaming thermal_zone_ops as thermal_sensor_ops isn't
quite helpful in this respect.

IMO there should be operations for sensors and there should be
operations for thermal zones and those two sets of operations should
be different.

> Thermal sensor(s) are bound to  thermal zones.

So I think that this binding should be analogous to the binding
between thermal zones and cooling devices.

> This can also include multiple sensors in a zone and can create a virtual sensor also.

It can.

However, what's the difference between a thermal zone with multiple
sensors and a thermal zone with one virtual sensor being an aggregate
of multiple physical sensors?

Both involve some type of aggregation of temperature values measured
by the physical sensors.

> > > In order to set the scene for multiple thermal sensors aggregated
> > > into
> > > a single thermal zone. Rename the thermal_zone_ops to
> > > thermal_sensor_ops, that will appear clearyl the thermal zone is
> > > not a
> > > sensor but an abstraction of one [or multiple] sensor(s).
> >
> > So I'm not convinced that the renaming mentioned above is
> > particularly
> > clean either.
> >
> > IMV the way to go would be to split the thermal sensor operations,
> > like ->get_temp(), out of thermal_zone_ops.
> >
> > But then it is not clear what a thermal zone with multiple sensors in
> > it really means.  I guess it would require an aggregation function to
> > combine the thermal sensors in it that would produce an effective
> > temperature to check against the trip points.
> >
> > Honestly, I don't think that setting a separate set of trips for each
> > sensor in a thermal zone would make a lot of sense.
>

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E99122798D
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jul 2020 09:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgGUHdQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Jul 2020 03:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbgGUHdQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Jul 2020 03:33:16 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D66CC061794
        for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2020 00:33:16 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id j21so5889398ual.11
        for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2020 00:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+t/pnEQ4NNsqTluf7AOakEjbmVq5C7q3xQXEC/0fJBA=;
        b=hKVAoug+rm4SkarqQwzg/++fjVRG4oiIPogO8e0bICWCuEXK/kE+OzQGD7MJfE5ch/
         9s6NoIXjhs92TDnSItNmYR39osn/gMrY8f2oC4JsK/WQ3A2nFXYdLxp5iESP6VD3efKj
         5h+7CrLcyKOsNrvrJf+mwowor5kfNx4dVkBTkNPU6GQx+cwhDyquhLWnS/E9c6IYFPnL
         /RNNJesXGMk+Sq3Sz1unfPGmKyXBd0mQhMAUEj7hyO+N2KF/81xHxrFPpld4xUjtUZel
         fkr1Yk3IgBofZgiW66pVvhpKHoKIVAz1vBc2eFn5kjE1TIz2ylvmLj7LnMPLty9tTu77
         Wheg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+t/pnEQ4NNsqTluf7AOakEjbmVq5C7q3xQXEC/0fJBA=;
        b=jOD4YKlyQB0s+DftLT8P+lesjLF79dM66FAkq8xYSORsgj3S6GvFnSfLRPZLvhwqT4
         DRr2Zr2cFwg6OxZLiNWNDA+AdgLrZ5fZMo1lHn8Lx8fihcbK0CzCt/f27rS23tZbhs3o
         JXc/AedmDGomviNCx6P9X+1gzz90W2gdZJAs7Kn70x4ACNFTgelRYzt84Kl2GFqno9+9
         AW2xcs4EHB/UoCVd8RTIoikZgP1hcsajAb4eef9P6Fzr0zvpKRzeWgZOzeXh/MuS2Sbk
         XCemn5SbIFJsdeW+6EyTwXXvjEpZifo0bKo/SR+gGiWAHpKcTEV2T2pPtqCsTBtmuEWw
         b8SQ==
X-Gm-Message-State: AOAM5301WIiWu2bRQU1bfRbiS6lf/LE2L1ykW8h93gPaLTuAmVrv9oTY
        pUCC+ItWMRoPGxCAY1sooQA2IklMqlJhMP08Wci3+A==
X-Google-Smtp-Source: ABdhPJxdCf21+4YrLutOnbYPUYtdkGx185wgV6qOn7mlEW9JyhPdivZaYT7Gg4HJEMTzXqkCG0pNVhT8kPDP2Sq3j1g=
X-Received: by 2002:ab0:1167:: with SMTP id g39mr18207671uac.60.1595316795342;
 Tue, 21 Jul 2020 00:33:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200707090159.1018-1-daniel.lezcano@linaro.org>
In-Reply-To: <20200707090159.1018-1-daniel.lezcano@linaro.org>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Tue, 21 Jul 2020 13:03:04 +0530
Message-ID: <CAHLCerMa+gev2DC=CQ-KA2shjuK7LmkKCmUWTVwoA9rv5Hd6mA@mail.gmail.com>
Subject: Re: [PATCH] thermal: netlink: Fix compilation error when CONFIG_NET=n
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        rdunlap@infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 7, 2020 at 2:32 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> When the network is not configured, the netlink are disabled on all
> the system. The thermal framework assumed the netlink are always

nit: s/are/is/ in both places above

> opt-in.
>
> Fix this by adding a Kconfig option for the netlink notification,
> defaulting to yes and depending on CONFIG_NET.
>
> As the change implies multiple stubs and in order to not pollute the
> internal thermal header, the thermal_nelink.h has been added and
> included in the thermal_core.h, so this one regain some kind of
> clarity.
>
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>

> ---
>  drivers/thermal/Kconfig           | 10 ++++
>  drivers/thermal/Makefile          |  5 +-
>  drivers/thermal/thermal_core.h    | 20 +------
>  drivers/thermal/thermal_netlink.h | 98 +++++++++++++++++++++++++++++++
>  4 files changed, 114 insertions(+), 19 deletions(-)
>  create mode 100644 drivers/thermal/thermal_netlink.h
>
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 3eb2348e5242..07983bef8d6a 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -17,6 +17,16 @@ menuconfig THERMAL
>
>  if THERMAL
>
> +config THERMAL_NETLINK
> +       bool "Thermal netlink management"
> +       depends on NET
> +       default y
> +       help
> +         The thermal framework has a netlink interface to do thermal
> +         zones discovery, temperature readings and events such as
> +         trip point crossed, cooling device update or governor
> +         change. It is recommended to enable the feature.
> +
>  config THERMAL_STATISTICS
>         bool "Thermal state transition statistics"
>         help
> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index 1bbf0805fb04..589f6fb0d381 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -5,7 +5,10 @@
>
>  obj-$(CONFIG_THERMAL)          += thermal_sys.o
>  thermal_sys-y                  += thermal_core.o thermal_sysfs.o \
> -                                       thermal_helpers.o thermal_netlink.o
> +                                       thermal_helpers.o
> +
> +# netlink interface to manage the thermal framework
> +thermal_sys-$(CONFIG_THERMAL_NETLINK)          += thermal_netlink.o
>
>  # interface to/from other layers providing sensors
>  thermal_sys-$(CONFIG_THERMAL_HWMON)            += thermal_hwmon.o
> diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
> index b44969d50ec0..99d065e6ed08 100644
> --- a/drivers/thermal/thermal_core.h
> +++ b/drivers/thermal/thermal_core.h
> @@ -12,6 +12,8 @@
>  #include <linux/device.h>
>  #include <linux/thermal.h>
>
> +#include "thermal_netlink.h"
> +
>  /* Default Thermal Governor */
>  #if defined(CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE)
>  #define DEFAULT_THERMAL_GOVERNOR       "step_wise"
> @@ -52,24 +54,6 @@ int for_each_thermal_governor(int (*cb)(struct thermal_governor *, void *),
>
>  struct thermal_zone_device *thermal_zone_get_by_id(int id);
>
> -/* Netlink notification function */
> -int thermal_notify_tz_create(int tz_id, const char *name);
> -int thermal_notify_tz_delete(int tz_id);
> -int thermal_notify_tz_enable(int tz_id);
> -int thermal_notify_tz_disable(int tz_id);
> -int thermal_notify_tz_trip_down(int tz_id, int id);
> -int thermal_notify_tz_trip_up(int tz_id, int id);
> -int thermal_notify_tz_trip_delete(int tz_id, int id);
> -int thermal_notify_tz_trip_add(int tz_id, int id, int type,
> -                              int temp, int hyst);
> -int thermal_notify_tz_trip_change(int tz_id, int id, int type,
> -                                 int temp, int hyst);
> -int thermal_notify_cdev_state_update(int cdev_id, int state);
> -int thermal_notify_cdev_add(int cdev_id, const char *name, int max_state);
> -int thermal_notify_cdev_delete(int cdev_id);
> -int thermal_notify_tz_gov_change(int tz_id, const char *name);
> -int thermal_genl_sampling_temp(int id, int temp);
> -
>  struct thermal_attr {
>         struct device_attribute attr;
>         char name[THERMAL_NAME_LENGTH];
> diff --git a/drivers/thermal/thermal_netlink.h b/drivers/thermal/thermal_netlink.h
> new file mode 100644
> index 000000000000..0ec28d105da5
> --- /dev/null
> +++ b/drivers/thermal/thermal_netlink.h
> @@ -0,0 +1,98 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + *  Copyright (C) Linaro Ltd 2020
> + *  Author: Daniel Lezcano <daniel.lezcano@linaro.org>
> + */
> +
> +/* Netlink notification function */
> +#ifdef CONFIG_THERMAL_NETLINK
> +int thermal_notify_tz_create(int tz_id, const char *name);
> +int thermal_notify_tz_delete(int tz_id);
> +int thermal_notify_tz_enable(int tz_id);
> +int thermal_notify_tz_disable(int tz_id);
> +int thermal_notify_tz_trip_down(int tz_id, int id);
> +int thermal_notify_tz_trip_up(int tz_id, int id);
> +int thermal_notify_tz_trip_delete(int tz_id, int id);
> +int thermal_notify_tz_trip_add(int tz_id, int id, int type,
> +                              int temp, int hyst);
> +int thermal_notify_tz_trip_change(int tz_id, int id, int type,
> +                                 int temp, int hyst);
> +int thermal_notify_cdev_state_update(int cdev_id, int state);
> +int thermal_notify_cdev_add(int cdev_id, const char *name, int max_state);
> +int thermal_notify_cdev_delete(int cdev_id);
> +int thermal_notify_tz_gov_change(int tz_id, const char *name);
> +int thermal_genl_sampling_temp(int id, int temp);
> +#else
> +static inline int thermal_notify_tz_create(int tz_id, const char *name)
> +{
> +       return 0;
> +}
> +
> +static inline int thermal_notify_tz_delete(int tz_id)
> +{
> +       return 0;
> +}
> +
> +static inline int thermal_notify_tz_enable(int tz_id)
> +{
> +       return 0;
> +}
> +
> +static inline int thermal_notify_tz_disable(int tz_id)
> +{
> +       return 0;
> +}
> +
> +static inline int thermal_notify_tz_trip_down(int tz_id, int id)
> +{
> +       return 0;
> +}
> +
> +static inline int thermal_notify_tz_trip_up(int tz_id, int id)
> +{
> +       return 0;
> +}
> +
> +static inline int thermal_notify_tz_trip_delete(int tz_id, int id)
> +{
> +       return 0;
> +}
> +
> +static inline int thermal_notify_tz_trip_add(int tz_id, int id, int type,
> +                                            int temp, int hyst)
> +{
> +       return 0;
> +}
> +
> +static inline int thermal_notify_tz_trip_change(int tz_id, int id, int type,
> +                                               int temp, int hyst)
> +{
> +       return 0;
> +}
> +
> +static inline int thermal_notify_cdev_state_update(int cdev_id, int state)
> +{
> +       return 0;
> +}
> +
> +static inline int thermal_notify_cdev_add(int cdev_id, const char *name,
> +                                         int max_state)
> +{
> +       return 0;
> +}
> +
> +static inline int thermal_notify_cdev_delete(int cdev_id)
> +{
> +       return 0;
> +}
> +
> +static inline int thermal_notify_tz_gov_change(int tz_id, const char *name)
> +{
> +       return 0;
> +}
> +
> +static inline int thermal_genl_sampling_temp(int id, int temp)
> +{
> +       return 0;
> +}
> +#endif /* CONFIG_THERMAL_NETLINK */
> --
> 2.17.1
>

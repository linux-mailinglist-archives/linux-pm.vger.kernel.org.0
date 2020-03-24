Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 404F6190E32
	for <lists+linux-pm@lfdr.de>; Tue, 24 Mar 2020 13:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgCXMzM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Mar 2020 08:55:12 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44021 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbgCXMzM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Mar 2020 08:55:12 -0400
Received: by mail-oi1-f193.google.com with SMTP id p125so18305877oif.10;
        Tue, 24 Mar 2020 05:55:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qLKgIYJQEqHTqd+u1W76X3WMfphIXILu6cZ8FvSyZwA=;
        b=cqdJ4fradQTITllQb5Kcz2AD5XM5gjkRFksVV7Vp/ZX/CkekUWBawHEDIurVnuh7m2
         Vk7PWLVIIo4frFIym8naLVMOH6yoxcDwafmioLaESy4hkbgKU2GYr/luO/ZOuZ/vyJnK
         nT0t/dKpZ+bTh5hmsFSSDfeWTRnGuvZPX1uIW+pNoVqFYNp2ZCNevnTjGC3kBeEL15YM
         cs3rmpY2FYkT66i9xrbYeMQX3UwBCyfLgvXidmcWv/u+GM2NSzVVsY3hj3nqb3uw4OM3
         JVnhrz+k77ZqJaSfOIUxOpJi6qCVlRAQIOEWQfCTz82NM+05sXXnZYFb3/stRwcK6RXW
         PfCA==
X-Gm-Message-State: ANhLgQ3tg8nfljGSXp4iVTmbFrnlsTL5WUHlHgf/LRI57wXOl8jKanmi
        r+Y4uWuzmmg8AwVmyHsv9pxXz6vSYcRI2xtkywdo9w==
X-Google-Smtp-Source: ADFU+vveVI0u0rTnuGesTqV06iz9TMXQNxEAnNwAOUYhvLCWQhsyd1sdoK7k3745+LO4xGe9z3GI62OkaoNJC5rmQ14=
X-Received: by 2002:a05:6808:8f:: with SMTP id s15mr3366415oic.110.1585054511257;
 Tue, 24 Mar 2020 05:55:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200324122023.9649-1-andriy.shevchenko@linux.intel.com> <20200324122023.9649-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20200324122023.9649-2-andriy.shevchenko@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 24 Mar 2020 13:55:00 +0100
Message-ID: <CAJZ5v0jounauixe8jt1_z9zKmT5BdqhG6hvWREDDrP-VAUUNKQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] driver core: Read atomic counter once in driver_probe_done()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Ferry Toth <fntoth@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Mar 24, 2020 at 1:20 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Between printing the debug message and actual check atomic counter can be
> altered. For better debugging experience read atomic counter value only once.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Tested-by: Ferry Toth <fntoth@gmail.com>

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
> v2: picked up tags
>  drivers/base/dd.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 43720beb5300..efd0e4c16ba5 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -669,9 +669,10 @@ static int really_probe_debug(struct device *dev, struct device_driver *drv)
>   */
>  int driver_probe_done(void)
>  {
> -       pr_debug("%s: probe_count = %d\n", __func__,
> -                atomic_read(&probe_count));
> -       if (atomic_read(&probe_count))
> +       int local_probe_count = atomic_read(&probe_count);
> +
> +       pr_debug("%s: probe_count = %d\n", __func__, local_probe_count);
> +       if (local_probe_count)
>                 return -EBUSY;
>         return 0;
>  }
> --
> 2.25.1
>

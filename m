Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4C02DE6B9
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2019 10:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbfJUIiU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Oct 2019 04:38:20 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37106 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbfJUIiT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Oct 2019 04:38:19 -0400
Received: by mail-ot1-f68.google.com with SMTP id k32so10290143otc.4;
        Mon, 21 Oct 2019 01:38:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Isdqq0Ubh24QJiFJ2l26RYaK1W86JQo/S0O5rntTFZ0=;
        b=Z0TWIWcDFOQa1mesVbE2AV3RFGqL/hqwyU2Kg6KuPVvSfYXID05T9Lq8Gk3tE21XLz
         Lqxr/dIn1eN5vAla+SYfeNc1MDjotOOO9dk20OHs9aIxNv/OfA1FO2ZBvbM1oM7pgL4I
         cTF6PMvIVpVv9c7k/6WKB6NBlOvFj8N3gZ6bMN6q6ANZ9+nKeHWJoee807tQf5hMX6kB
         gAbAQkv3wB+0tIVNtoj4r3qKuC6VWincHXSZDV6fPSm5K0/GuqoapTxT/8bihEdXK4Hw
         ZPEcLyrz8SQ8uYjOKXYePjVABAWgi0gHnVupXEDuV5aXEtBYQzKxtVUMfOYwfOlDqCx1
         jEjQ==
X-Gm-Message-State: APjAAAVfWsfD2y5pccTvY3T37yyWHHJCppKbszvdbiwnsTNp0pd1eR44
        WKOquBeAI+CmwqVRvhduRGmBoiM8S6NqdWGd5ZE=
X-Google-Smtp-Source: APXvYqzxJsJuV6BUauy4Sb2At789fmamDYr15BmrQGLKIW7qtsWxPoUU1OE8Ucyvvce+T2vjIx84kc60si7Pd9H8+Xs=
X-Received: by 2002:a05:6830:1e69:: with SMTP id m9mr17885485otr.262.1571647098420;
 Mon, 21 Oct 2019 01:38:18 -0700 (PDT)
MIME-Version: 1.0
References: <20191021034927.19300-1-ran.wang_1@nxp.com>
In-Reply-To: <20191021034927.19300-1-ran.wang_1@nxp.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 21 Oct 2019 10:38:07 +0200
Message-ID: <CAJZ5v0hO5Jtr_kyBbCawYc+fS0JQGcU-xfhS9S7DKiFQYJSJvQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] PM: wakeup: Add routine to help fetch wakeup
 source object.
To:     Ran Wang <ran.wang_1@nxp.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Pavel Machek <pavel@ucw.cz>, Li Biwen <biwen.li@nxp.com>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Oct 21, 2019 at 5:49 AM Ran Wang <ran.wang_1@nxp.com> wrote:
>
> Some user might want to go through all registered wakeup sources
> and doing things accordingly. For example, SoC PM driver might need to
> do HW programming to prevent powering down specific IP which wakeup
> source depending on. So add this API to help walk through all registered
> wakeup source objects on that list and return them one by one.
>
> Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> Tested-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
> Change in v7:
>         - Remove define of member *dev in wake_irq to fix conflict with commit
>         c8377adfa781 ("PM / wakeup: Show wakeup sources stats in sysfs"), user
>         will use ws->dev->parent instead.
>         - Remove '#include <linux/of_device.h>' because it is not used.
>
> Change in v6:
>         - Add wakeup_source_get_star() and wakeup_source_get_stop() to aligned
>         with wakeup_sources_stats_seq_start/nex/stop.
>
> Change in v5:
>         - Update commit message, add decription of walk through all wakeup
>         source objects.
>         - Add SCU protection in function wakeup_source_get_next().
>         - Rename wakeup_source member 'attached_dev' to 'dev' and move it up
>         (before wakeirq).
>
> Change in v4:
>         - None.
>
> Change in v3:
>         - Adjust indentation of *attached_dev;.
>
> Change in v2:
>         - None.
>
>  drivers/base/power/wakeup.c | 37 +++++++++++++++++++++++++++++++++++++
>  include/linux/pm_wakeup.h   |  3 +++
>  2 files changed, 40 insertions(+)
>
> diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> index 5817b51..dee1b09 100644
> --- a/drivers/base/power/wakeup.c
> +++ b/drivers/base/power/wakeup.c
> @@ -248,6 +248,43 @@ void wakeup_source_unregister(struct wakeup_source *ws)
>  EXPORT_SYMBOL_GPL(wakeup_source_unregister);
>
>  /**
> + * wakeup_source_get_star - Begin a walk on wakeup source list

The "get" in the name suggests acquiring a reference of some kind
which doesn't happen here.

What about renaming it to wakeup_sources_walk_start()?

> + * @srcuidx: Lock index allocated for this caller.
> + */
> +struct wakeup_source *wakeup_source_get_start(int *srcuidx)

I don't quite like the calling convention here with passing an int
pointer to get the SRCU index back.

What about splitting this into, say, wakeup_sources_read_lock() (that
will return the SRCU index) and wakeup_sources_walk_start() (that will
return the first list entry)?

Then, you could do something like

idx = wakeup_sources_read_lock();

ws = wakeup_sources_walk_start();
while (ws) {

        stuff

        ws = wakeup_sources_walk_next();
}

wakeup_sources_read_unlock(idx);

Or even define for_each_wakeup_source(ws) as

    for (ws = wakeup_sources_walk_start(); ws; ws = wakeup_sources_walk_next())

and use that under a _read_lock()/_read_unlock() pair?

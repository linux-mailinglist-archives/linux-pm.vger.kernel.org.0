Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E521E91B7
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2019 22:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfJ2VTk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Oct 2019 17:19:40 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33928 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727706AbfJ2VTj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Oct 2019 17:19:39 -0400
Received: by mail-ot1-f68.google.com with SMTP id m19so239765otp.1;
        Tue, 29 Oct 2019 14:19:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ecDqSfSuAIrQpm88YN5y/79NJNgXFx+waZx0U92w3DQ=;
        b=MVNbcmDWKkwBYwJhxKx5Hb4jhCkYU26aI3Lw6occxjLF4VDYwCD/FV2UgX283wTAve
         izoaQY9ncOwzg7C3w6jg5jQaSrVsdSf7cRx3ghvkpE3j1s99ZlxVzl8WEpBiPWgs5TpH
         Gs5a+ostZxaOUecicQNJgYX8Pfg/FpxSZJBf5VXMPU9FElfd9XIjBvvEgiTMNj6x3mXu
         qOhzBFa2qx7b8NmNtBTtl+QnkJ8ItjGnN4uU6LLei6mBwm7lr9DY4J0YWgtujOc+Uezc
         PYaOgDuMqxdAWl9VekrMDEwgp4J0g7cdjA9Ij3mbq8bPYNsHaZwfhVdEioNDUoD2kq6M
         XtfQ==
X-Gm-Message-State: APjAAAVfRAL0gLmy134/tLe8pHmDiVCXrgo9bW7Yr+4PoqyG/lITRjON
        XzA5PQZz+rDYIlyhdsmss1p9lNM19Ao=
X-Google-Smtp-Source: APXvYqwad8XV+0tM14Xmpvqz9e9R5YPGusPpN7XuwHI5LwQvtbgGY6hNd8j8rtGSMfvO79lFQrFtEA==
X-Received: by 2002:a9d:1a5:: with SMTP id e34mr20767800ote.286.1572383978012;
        Tue, 29 Oct 2019 14:19:38 -0700 (PDT)
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com. [209.85.210.43])
        by smtp.gmail.com with ESMTPSA id b31sm46672otc.70.2019.10.29.14.19.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Oct 2019 14:19:37 -0700 (PDT)
Received: by mail-ot1-f43.google.com with SMTP id 94so203961oty.8;
        Tue, 29 Oct 2019 14:19:37 -0700 (PDT)
X-Received: by 2002:a05:6830:2322:: with SMTP id q2mr14516847otg.74.1572383976764;
 Tue, 29 Oct 2019 14:19:36 -0700 (PDT)
MIME-Version: 1.0
References: <20191024092644.26583-1-ran.wang_1@nxp.com>
In-Reply-To: <20191024092644.26583-1-ran.wang_1@nxp.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Tue, 29 Oct 2019 16:19:25 -0500
X-Gmail-Original-Message-ID: <CADRPPNSTq8=uH-HLP0qhzR1Ob+BQc5=h53km+z3vumMSBX1ccQ@mail.gmail.com>
Message-ID: <CADRPPNSTq8=uH-HLP0qhzR1Ob+BQc5=h53km+z3vumMSBX1ccQ@mail.gmail.com>
Subject: Re: [PATCH v10 1/3] PM: wakeup: Add routine to help fetch wakeup
 source object.
To:     Ran Wang <ran.wang_1@nxp.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Pavel Machek <pavel@ucw.cz>, Huang Anson <anson.huang@nxp.com>,
        Li Biwen <biwen.li@nxp.com>, Len Brown <len.brown@intel.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 24, 2019 at 4:29 AM Ran Wang <ran.wang_1@nxp.com> wrote:
>
> Some user might want to go through all registered wakeup sources
> and doing things accordingly. For example, SoC PM driver might need to
> do HW programming to prevent powering down specific IP which wakeup
> source depending on. So add this API to help walk through all registered
> wakeup source objects on that list and return them one by one.
>
> Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> Tested-by: Leonard Crestez <leonard.crestez@nxp.com>
> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Series applied to soc/fsl for next.  Thanks.

Regards,
Leo
> ---
> Change in v10:
>         - Add 'Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>'
>           to commit message.
>
> Change in v9:
>         - Supplement comments for wakeup_sources_read_lock(),
>           wakeup_sources_read_unlock, wakeup_sources_walk_start and
>           wakeup_sources_walk_next().
>
> Change in v8:
>         - Rename wakeup_source_get_next() to wakeup_sources_walk_next().
>         - Add wakeup_sources_read_lock() to take over locking job of
>           wakeup_source_get_star().
>         - Rename wakeup_source_get_start() to wakeup_sources_walk_start().
>         - Replace wakeup_source_get_stop() with wakeup_sources_read_unlock().
>         - Define macro for_each_wakeup_source(ws).
>
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
>  drivers/base/power/wakeup.c | 54 +++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pm_wakeup.h   |  9 ++++++++
>  2 files changed, 63 insertions(+)
>
> diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> index 5817b51..70a9edb 100644
> --- a/drivers/base/power/wakeup.c
> +++ b/drivers/base/power/wakeup.c
> @@ -248,6 +248,60 @@ void wakeup_source_unregister(struct wakeup_source *ws)
>  EXPORT_SYMBOL_GPL(wakeup_source_unregister);
>
>  /**
> + * wakeup_sources_read_lock - Lock wakeup source list for read.
> + *
> + * Returns an index of srcu lock for struct wakeup_srcu.
> + * This index must be passed to the matching wakeup_sources_read_unlock().
> + */
> +int wakeup_sources_read_lock(void)
> +{
> +       return srcu_read_lock(&wakeup_srcu);
> +}
> +EXPORT_SYMBOL_GPL(wakeup_sources_read_lock);
> +
> +/**
> + * wakeup_sources_read_unlock - Unlock wakeup source list.
> + * @idx: return value from corresponding wakeup_sources_read_lock()
> + */
> +void wakeup_sources_read_unlock(int idx)
> +{
> +       srcu_read_unlock(&wakeup_srcu, idx);
> +}
> +EXPORT_SYMBOL_GPL(wakeup_sources_read_unlock);
> +
> +/**
> + * wakeup_sources_walk_start - Begin a walk on wakeup source list
> + *
> + * Returns first object of the list of wakeup sources.
> + *
> + * Note that to be safe, wakeup sources list needs to be locked by calling
> + * wakeup_source_read_lock() for this.
> + */
> +struct wakeup_source *wakeup_sources_walk_start(void)
> +{
> +       struct list_head *ws_head = &wakeup_sources;
> +
> +       return list_entry_rcu(ws_head->next, struct wakeup_source, entry);
> +}
> +EXPORT_SYMBOL_GPL(wakeup_sources_walk_start);
> +
> +/**
> + * wakeup_sources_walk_next - Get next wakeup source from the list
> + * @ws: Previous wakeup source object
> + *
> + * Note that to be safe, wakeup sources list needs to be locked by calling
> + * wakeup_source_read_lock() for this.
> + */
> +struct wakeup_source *wakeup_sources_walk_next(struct wakeup_source *ws)
> +{
> +       struct list_head *ws_head = &wakeup_sources;
> +
> +       return list_next_or_null_rcu(ws_head, &ws->entry,
> +                               struct wakeup_source, entry);
> +}
> +EXPORT_SYMBOL_GPL(wakeup_sources_walk_next);
> +
> +/**
>   * device_wakeup_attach - Attach a wakeup source object to a device object.
>   * @dev: Device to handle.
>   * @ws: Wakeup source object to attach to @dev.
> diff --git a/include/linux/pm_wakeup.h b/include/linux/pm_wakeup.h
> index 661efa0..aa3da66 100644
> --- a/include/linux/pm_wakeup.h
> +++ b/include/linux/pm_wakeup.h
> @@ -63,6 +63,11 @@ struct wakeup_source {
>         bool                    autosleep_enabled:1;
>  };
>
> +#define for_each_wakeup_source(ws) \
> +       for ((ws) = wakeup_sources_walk_start();        \
> +            (ws);                                      \
> +            (ws) = wakeup_sources_walk_next((ws)))
> +
>  #ifdef CONFIG_PM_SLEEP
>
>  /*
> @@ -92,6 +97,10 @@ extern void wakeup_source_remove(struct wakeup_source *ws);
>  extern struct wakeup_source *wakeup_source_register(struct device *dev,
>                                                     const char *name);
>  extern void wakeup_source_unregister(struct wakeup_source *ws);
> +extern int wakeup_sources_read_lock(void);
> +extern void wakeup_sources_read_unlock(int idx);
> +extern struct wakeup_source *wakeup_sources_walk_start(void);
> +extern struct wakeup_source *wakeup_sources_walk_next(struct wakeup_source *ws);
>  extern int device_wakeup_enable(struct device *dev);
>  extern int device_wakeup_disable(struct device *dev);
>  extern void device_set_wakeup_capable(struct device *dev, bool capable);
> --
> 2.7.4
>

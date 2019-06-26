Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B234255D24
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2019 02:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbfFZA7f (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Jun 2019 20:59:35 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42279 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfFZA7f (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Jun 2019 20:59:35 -0400
Received: by mail-ot1-f68.google.com with SMTP id l15so784621otn.9
        for <linux-pm@vger.kernel.org>; Tue, 25 Jun 2019 17:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wKHRg8uOA5yOOWmOFVjkDPxJJux0F6cgriRh/pJljaI=;
        b=IM4uCCJP6fx9lJ1slU8HqlGbugehpag1yFr2gXzhHbts2RXC6jVzadtropQMIYDzZG
         6/7uhc7UgWitsU6inNaR6b+oDEr7EZgy4KJt8Cv3zOWkstmX7D71f1eO0Yd9XpTcmhEt
         K5JkTePoPh4A8UYxOacHhHXb5lkBzuPddeGCDf2B4RgcW2XK/1W/jaQlpzXaeuldsyq8
         OHo65giv9ELk1E/k4L6M6vkYMTei4478ZFpDPOKDtO5v61PDrFH+YkZwHBtHA4TVjSPW
         WKAKiNcERpm8+GzCtWNQE0ivuIBbYiXvBQORlLeVElCYLGuJUcEFnJFpISFleYMbqkYY
         HWvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wKHRg8uOA5yOOWmOFVjkDPxJJux0F6cgriRh/pJljaI=;
        b=blvMgwGAgdXnJrQGZqOLTyx6SPv7jRVaen9ST6dz+zhH8FRf2+L/pv2XEkGDPLVq3h
         L9IOrhd7CXHZgbTso2Zu9P+/xzHifSacALwBVazm9wuZmA/1ISVX/gPifSMlxQqaEYr6
         sxkgsMbrcwZ0pEiuEkxVZ4NeuBm7StW4RNpHHVZFfD83MMs4YlxRdgdfh8LcISElMsM3
         MEE4uibqkxmrY6bcRfiHdVx/rpKQMLp4CaeIZ03tRmr5wbKY/wztxzjvbFYn22x7YE5B
         eUIVN3hJPxuLqkfwSn0YchiLEmnxvWAl2tvSLGhq9+KqXW2Qobl2L/PofLmjMepAVIUn
         BZ4Q==
X-Gm-Message-State: APjAAAUK5wVnkVVak+HOuyoG0B+ViSWv4QWERSX1tAmP1S75QUZUgYIM
        fMEgqeFK+tVDB1Bv4t63H4FMY0p0o6JUmCyB7yD4+A==
X-Google-Smtp-Source: APXvYqwbpUhZXs/okqa3xCGE2T9qwbsjqnRskhy7bVjiHOUjMtPzlvS5U+svMNy2Lt0BfPb5KQh2zcXATO6RpiLfpL0=
X-Received: by 2002:a9d:7a45:: with SMTP id z5mr1068288otm.197.1561510774685;
 Tue, 25 Jun 2019 17:59:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190626005449.225796-1-trong@android.com>
In-Reply-To: <20190626005449.225796-1-trong@android.com>
From:   Tri Vo <trong@android.com>
Date:   Tue, 25 Jun 2019 17:59:23 -0700
Message-ID: <CANA+-vAKFqaAdNMp2boKa6g0=j4szSUHUjW4e94Xi3YGina2=g@mail.gmail.com>
Subject: Re: [PATCH] PM / wakeup: show wakeup sources stats in sysfs
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Hridya Valsaraju <hridya@google.com>,
        Sandeep Patil <sspatil@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jun 25, 2019 at 5:55 PM Tri Vo <trong@android.com> wrote:
>
> Userspace can use wakeup_sources debugfs node to plot history of suspend
> blocking wakeup sources over device's boot cycle. This information can
> then be used (1) for power-specific bug reporting and (2) towards
> attributing battery consumption to specific processes over a period of
> time.
>
> However, debugfs doesn't have stable ABI. For this reason, expose wakeup
> sources statistics in sysfs under /sys/power/wakeup_sources/<name>/
>
> Add following attributes to each wakeup source. These attributes match
> the columns of /sys/kernel/debug/wakeup_sources.
>
>   active_count
>   event_count
>   wakeup_count
>   expire_count
>   active_time (named "active_since" in debugfs)
>   total_time
>   max_time
>   last_change
>   prevent_suspend_time
>
> Embedding a struct kobject into struct wakeup_source changes lifetime
> requirements on the latter. To that end, change deallocation of struct
> wakeup_source using kfree to kobject_put().
>
> Signed-off-by: Tri Vo <trong@android.com>
> ---
>  drivers/base/power/Makefile       |   2 +-
>  drivers/base/power/wakeup.c       |  13 +-
>  drivers/base/power/wakeup_sysfs.c | 204 ++++++++++++++++++++++++++++++
>  include/linux/pm_wakeup.h         |   9 ++
>  kernel/power/wakelock.c           |  13 +-
>  5 files changed, 236 insertions(+), 5 deletions(-)
>  create mode 100644 drivers/base/power/wakeup_sysfs.c
>
> diff --git a/drivers/base/power/Makefile b/drivers/base/power/Makefile
> index e1bb691cf8f1..e6ea9eb46275 100644
> --- a/drivers/base/power/Makefile
> +++ b/drivers/base/power/Makefile
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_PM)       += sysfs.o generic_ops.o common.o qos.o runtime.o wakeirq.o
> -obj-$(CONFIG_PM_SLEEP) += main.o wakeup.o
> +obj-$(CONFIG_PM_SLEEP) += main.o wakeup.o wakeup_sysfs.o
>  obj-$(CONFIG_PM_TRACE_RTC)     += trace.o
>  obj-$(CONFIG_PM_GENERIC_DOMAINS)       +=  domain.o domain_governor.o
>  obj-$(CONFIG_HAVE_CLK) += clock_ops.o
> diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> index 5b2b6a05a4f3..6fcbb4d2045f 100644
> --- a/drivers/base/power/wakeup.c
> +++ b/drivers/base/power/wakeup.c
> @@ -96,12 +96,22 @@ EXPORT_SYMBOL_GPL(wakeup_source_prepare);
>  struct wakeup_source *wakeup_source_create(const char *name)
>  {
>         struct wakeup_source *ws;
> +       int ret;
>
>         ws = kmalloc(sizeof(*ws), GFP_KERNEL);
>         if (!ws)
>                 return NULL;
>
>         wakeup_source_prepare(ws, name ? kstrdup_const(name, GFP_KERNEL) : NULL);
> +
> +       ws->kobj.kset = wakeup_source_kset;
> +       ret = kobject_init_and_add(&ws->kobj, &wakeup_source_ktype, NULL, "%s",
> +                       ws->name);
> +       if (ret) {
> +               kobject_put(&ws->kobj);
> +               return NULL;
> +       }
> +
>         return ws;
>  }
>  EXPORT_SYMBOL_GPL(wakeup_source_create);
> @@ -147,8 +157,7 @@ void wakeup_source_destroy(struct wakeup_source *ws)
>
>         __pm_relax(ws);
>         wakeup_source_record(ws);
> -       kfree_const(ws->name);
> -       kfree(ws);
> +       kobject_put(&ws->kobj);
>  }
>  EXPORT_SYMBOL_GPL(wakeup_source_destroy);
>
> diff --git a/drivers/base/power/wakeup_sysfs.c b/drivers/base/power/wakeup_sysfs.c
> new file mode 100644
> index 000000000000..d872afc645d9
> --- /dev/null
> +++ b/drivers/base/power/wakeup_sysfs.c
> @@ -0,0 +1,204 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/slab.h>
> +
> +#include "power.h"
> +
> +struct wakeup_source_attribute {
> +       struct attribute attr;
> +       ssize_t (*show)(struct wakeup_source *ws,
> +                       struct wakeup_source_attribute *attr, char *buf);
> +       ssize_t (*store)(struct wakeup_source *ws,
> +                        struct wakeup_source_attribute *attr, const char *buf,
> +                        size_t count);
> +};
> +
> +#define to_wakeup_source_obj(x) container_of(x, struct wakeup_source, kobj)
> +#define to_wakeup_source_attr(x) \
> +       container_of(x, struct wakeup_source_attribute, attr)
> +
> +static ssize_t wakeup_source_attr_show(struct kobject *kobj,
> +                                      struct attribute *attr,
> +                                      char *buf)
> +{
> +       struct wakeup_source_attribute *attribute;
> +       struct wakeup_source *ws;
> +
> +       ws = to_wakeup_source_obj(kobj);
> +       attribute = to_wakeup_source_attr(attr);
> +
> +       if (!attribute->show)
> +               return -EIO;
> +
> +       return attribute->show(ws, attribute, buf);
> +}
> +
> +static const struct sysfs_ops wakeup_source_sysfs_ops = {
> +       .show = wakeup_source_attr_show,
> +};
> +
> +static void wakeup_source_release(struct kobject *kobj)
> +{
> +       struct wakeup_source *ws;
> +
> +       ws = to_wakeup_source_obj(kobj);
> +       kfree_const(ws->name);
> +       kfree(ws);
> +}
> +
> +static ssize_t wakeup_source_count_show(struct wakeup_source *ws,
> +                                       struct wakeup_source_attribute *attr,
> +                                       char *buf)
> +{
> +       unsigned long flags;
> +       unsigned long var;
> +
> +       spin_lock_irqsave(&ws->lock, flags);
> +       if (strcmp(attr->attr.name, "active_count") == 0)
> +               var = ws->active_count;
> +       else if (strcmp(attr->attr.name, "event_count") == 0)
> +               var = ws->event_count;
> +       else if (strcmp(attr->attr.name, "wakeup_count") == 0)
> +               var = ws->wakeup_count;
> +       else
> +               var = ws->expire_count;
> +       spin_unlock_irqrestore(&ws->lock, flags);
> +
> +       return sprintf(buf, "%lu\n", var);
> +}
> +
> +#define wakeup_source_count_attr(_name)                        \
> +static struct wakeup_source_attribute _name##_attr = { \
> +       .attr   = {                                     \
> +               .name = __stringify(_name),             \
> +               .mode = 0444,                           \
> +       },                                              \
> +       .show   = wakeup_source_count_show,             \
> +}
> +
> +wakeup_source_count_attr(active_count);
> +wakeup_source_count_attr(event_count);
> +wakeup_source_count_attr(wakeup_count);
> +wakeup_source_count_attr(expire_count);
> +
> +#define wakeup_source_attr(_name) \
> +static struct wakeup_source_attribute _name##_attr = __ATTR_RO(_name)
> +
> +static ssize_t active_time_show(struct wakeup_source *ws,
> +                               struct wakeup_source_attribute *attr,
> +                               char *buf)
> +{
> +       unsigned long flags;
> +       ktime_t active_time;
> +
> +       spin_lock_irqsave(&ws->lock, flags);
> +       active_time = ws->active ? ktime_sub(ktime_get(), ws->last_time) : 0;
> +       spin_unlock_irqrestore(&ws->lock, flags);
> +       return sprintf(buf, "%lld\n", ktime_to_ms(active_time));
> +}
> +wakeup_source_attr(active_time);
> +
> +static ssize_t total_time_show(struct wakeup_source *ws,
> +                              struct wakeup_source_attribute *attr,
> +                              char *buf)
> +{
> +       unsigned long flags;
> +       ktime_t active_time;
> +       ktime_t total_time;
> +
> +       spin_lock_irqsave(&ws->lock, flags);
> +       total_time = ws->total_time;
> +       if (ws->active) {
> +               active_time = ktime_sub(ktime_get(), ws->last_time);
> +               total_time = ktime_add(total_time, active_time);
> +       }
> +       spin_unlock_irqrestore(&ws->lock, flags);
> +       return sprintf(buf, "%lld\n", ktime_to_ms(total_time));
> +}
> +wakeup_source_attr(total_time);
> +
> +static ssize_t max_time_show(struct wakeup_source *ws,
> +                            struct wakeup_source_attribute *attr,
> +                            char *buf)
> +{
> +       unsigned long flags;
> +       ktime_t active_time;
> +       ktime_t max_time;
> +
> +       spin_lock_irqsave(&ws->lock, flags);
> +       max_time = ws->max_time;
> +       if (ws->active) {
> +               active_time = ktime_sub(ktime_get(), ws->last_time);
> +               if (active_time > max_time)
> +                       max_time = active_time;
> +       }
> +       spin_unlock_irqrestore(&ws->lock, flags);
> +       return sprintf(buf, "%lld\n", ktime_to_ms(max_time));
> +}
> +wakeup_source_attr(max_time);
> +
> +static ssize_t last_change_show(struct wakeup_source *ws,
> +                               struct wakeup_source_attribute *attr,
> +                               char *buf)
> +{
> +       unsigned long flags;
> +       ktime_t last_time;
> +
> +       spin_lock_irqsave(&ws->lock, flags);
> +       last_time = ws->last_time;
> +       spin_unlock_irqrestore(&ws->lock, flags);
> +       return sprintf(buf, "%lld\n", ktime_to_ms(last_time));
> +}
> +wakeup_source_attr(last_change);
> +
> +static ssize_t prevent_suspend_time_show(struct wakeup_source *ws,
> +                                        struct wakeup_source_attribute *attr,
> +                                        char *buf)
> +{
> +       unsigned long flags;
> +       ktime_t prevent_sleep_time;
> +
> +       spin_lock_irqsave(&ws->lock, flags);
> +       prevent_sleep_time = ws->prevent_sleep_time;
> +       if (ws->active && ws->autosleep_enabled) {
> +               prevent_sleep_time = ktime_add(prevent_sleep_time,
> +                       ktime_sub(ktime_get(), ws->start_prevent_time));
> +       }
> +       spin_unlock_irqrestore(&ws->lock, flags);
> +       return sprintf(buf, "%lld\n", ktime_to_ms(prevent_sleep_time));
> +}
> +wakeup_source_attr(prevent_suspend_time);
> +
> +static struct attribute *wakeup_source_default_attrs[] = {
> +       &active_count_attr.attr,
> +       &event_count_attr.attr,
> +       &wakeup_count_attr.attr,
> +       &expire_count_attr.attr,
> +       &active_time_attr.attr,
> +       &total_time_attr.attr,
> +       &max_time_attr.attr,
> +       &last_change_attr.attr,
> +       &prevent_suspend_time_attr.attr,
> +       NULL,
> +};
> +ATTRIBUTE_GROUPS(wakeup_source_default);
> +
> +struct kobj_type wakeup_source_ktype = {
> +       .sysfs_ops = &wakeup_source_sysfs_ops,
> +       .release = wakeup_source_release,
> +       .default_groups = wakeup_source_default_groups,
> +};
> +
> +struct kset *wakeup_source_kset;
> +
> +static int __init wakeup_sources_sysfs_init(void)
> +{
> +       wakeup_source_kset = kset_create_and_add("wakeup_sources", NULL,
> +                       power_kobj);
> +       if (!wakeup_source_kset)
> +               return -ENOMEM;
> +
> +       return 0;
> +}
> +
> +postcore_initcall(wakeup_sources_sysfs_init);
> diff --git a/include/linux/pm_wakeup.h b/include/linux/pm_wakeup.h
> index ce57771fab9b..9af3bdd50557 100644
> --- a/include/linux/pm_wakeup.h
> +++ b/include/linux/pm_wakeup.h
> @@ -57,6 +57,7 @@ struct wakeup_source {
>         unsigned long           wakeup_count;
>         bool                    active:1;
>         bool                    autosleep_enabled:1;
> +       struct kobject          kobj;
>  };
>
>  #ifdef CONFIG_PM_SLEEP
> @@ -100,6 +101,10 @@ extern void pm_relax(struct device *dev);
>  extern void pm_wakeup_ws_event(struct wakeup_source *ws, unsigned int msec, bool hard);
>  extern void pm_wakeup_dev_event(struct device *dev, unsigned int msec, bool hard);
>
> +/* drivers/base/power/wakeup_sysfs.c */
> +extern struct kobj_type wakeup_source_ktype;
> +extern struct kset *wakeup_source_kset;
> +
>  #else /* !CONFIG_PM_SLEEP */
>
>  static inline void device_set_wakeup_capable(struct device *dev, bool capable)
> @@ -179,6 +184,10 @@ static inline void pm_wakeup_ws_event(struct wakeup_source *ws,
>  static inline void pm_wakeup_dev_event(struct device *dev, unsigned int msec,
>                                        bool hard) {}
>
> +/* drivers/base/power/wakeup_sysfs.c */
> +static struct kobj_type wakeup_source_ktype;
> +static struct kset *wakeup_source_kset;
> +
>  #endif /* !CONFIG_PM_SLEEP */
>
>  static inline void wakeup_source_init(struct wakeup_source *ws,
> diff --git a/kernel/power/wakelock.c b/kernel/power/wakelock.c
> index 4210152e56f0..71535eebfbbf 100644
> --- a/kernel/power/wakelock.c
> +++ b/kernel/power/wakelock.c
> @@ -124,8 +124,7 @@ static void __wakelocks_gc(struct work_struct *work)
>                         wakeup_source_remove(&wl->ws);
>                         rb_erase(&wl->node, &wakelocks_tree);
>                         list_del(&wl->lru);
> -                       kfree(wl->name);
> -                       kfree(wl);
> +                       kobject_put(&wl->ws->kobj);
>                         decrement_wakelocks_number();
>                 }
>         }
> @@ -153,6 +152,7 @@ static struct wakelock *wakelock_lookup_add(const char *name, size_t len,
>         struct rb_node **node = &wakelocks_tree.rb_node;
>         struct rb_node *parent = *node;
>         struct wakelock *wl;
> +       int ret;
>
>         while (*node) {
>                 int diff;
> @@ -189,6 +189,15 @@ static struct wakelock *wakelock_lookup_add(const char *name, size_t len,
>         }
>         wl->ws.name = wl->name;
>         wl->ws.last_time = ktime_get();
> +
> +       wl->ws.kobj.kset = wakeup_source_kset;
> +       ret = kobject_init_and_add(&wl->ws.kobj, &wakeup_source_ktype, NULL,
> +                       "%s", wl->ws.name);
> +       if (ret) {
> +               kobject_put(&wl->ws.kobj);
> +               return ERR_PTR(ret);
> +       }
> +
>         wakeup_source_add(&wl->ws);
>         rb_link_node(&wl->node, parent, node);
>         rb_insert_color(&wl->node, &wakelocks_tree);
> --
> 2.22.0.410.gd8fdbe21b5-goog
>

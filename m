Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF342221136
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jul 2020 17:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgGOPf2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jul 2020 11:35:28 -0400
Received: from mail-oo1-f68.google.com ([209.85.161.68]:35911 "EHLO
        mail-oo1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbgGOPf1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jul 2020 11:35:27 -0400
Received: by mail-oo1-f68.google.com with SMTP id z127so550324ooa.3;
        Wed, 15 Jul 2020 08:35:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+lRS/tWjF+I7awdCql4jqwqaHB+t8A414qDcPmgKQpY=;
        b=c2qVcQeaQB/dHqFZxebtn/y0Yxpa9rRzUqP9YgqFxd+gb+isVyNvcZ6Zk9wU7j4ZO3
         maD3LbMeCozUolAX6CCFxuIfvTjKEXH5/SAidNTRxl/BlTpjwyx3SFy6EHzdQDDPEOpr
         tbAInZ7vVmrZ4OfCpKSH82jOMOJ6cneFtruvlg8rW9VcryHXsO5+D+C7uySFzGZVJvr3
         TQVLWblN0tVMWCJzE9mIRhHL1dtc3HRwHIKv0j8iKLyXeIaP7l46P4Wt2lruoOQjP504
         ivBjSBe0dgidh4MkuVytCa8EiWa4x5O8bxrmbo7DjF+mYF+YmD0hhckOYvgahMMsrmup
         pSGg==
X-Gm-Message-State: AOAM531p03m+zDWtJgDTnPxoRMOdLKl3cVImmnXvMtNNqmJtVO23UzJ7
        Itp+DvEyFwZDMjswu+EOIqCgv3lb4584V6yzQ9Q=
X-Google-Smtp-Source: ABdhPJx2GJR5NbirfZQYle2m74jHodHyWXkLAVZ4Al4BzULCempQvTyGmEvulXneNhcu36SBd/LUki2wPRk7m97876k=
X-Received: by 2002:a4a:9552:: with SMTP id n18mr9927340ooi.1.1594827327053;
 Wed, 15 Jul 2020 08:35:27 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1594790493.git.yu.c.chen@intel.com> <9c261b5001c853006e4fe719726948dfe3b4d487.1594790493.git.yu.c.chen@intel.com>
In-Reply-To: <9c261b5001c853006e4fe719726948dfe3b4d487.1594790493.git.yu.c.chen@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 15 Jul 2020 17:35:16 +0200
Message-ID: <CAJZ5v0ikdBn-hunahd_jtawizTHra5iZ4Ff4q=C2ip6HOeGV7w@mail.gmail.com>
Subject: Re: [PATCH 1/2][RESEND v3] PM-runtime: Move all runtime usage related
 function to runtime.c
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Miroslaw <mirq-linux@rere.qmqm.pl>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jul 15, 2020 at 8:26 AM Chen Yu <yu.c.chen@intel.com> wrote:
>
> In order to track all the runtime usage count change, move the code
> related to runtime usage count change from pm_runtime.h to runtime.c,
> so that in runtime.c we can leverage trace event to do the tracking.
> Meanwhile export pm_runtime_get_noresume() and pm_runtime_put_noidle()
> so the module can use them.
>
> No functional changes intended.
>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
>  drivers/base/power/runtime.c | 12 ++++++++++++
>  include/linux/pm_runtime.h   | 12 ++----------
>  2 files changed, 14 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index 9f62790f644c..85a248e196ca 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -1738,6 +1738,18 @@ void pm_runtime_drop_link(struct device *dev)
>         spin_unlock_irq(&dev->power.lock);
>  }
>
> +void pm_runtime_get_noresume(struct device *dev)
> +{
> +       atomic_inc(&dev->power.usage_count);
> +}
> +EXPORT_SYMBOL_GPL(pm_runtime_get_noresume);
> +
> +void pm_runtime_put_noidle(struct device *dev)
> +{
> +       atomic_add_unless(&dev->power.usage_count, -1, 0);
> +}
> +EXPORT_SYMBOL_GPL(pm_runtime_put_noidle);

I honestly don't think that this is going in the right direction.

> +
>  static bool pm_runtime_need_not_resume(struct device *dev)
>  {
>         return atomic_read(&dev->power.usage_count) <= 1 &&
> diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
> index 3dbc207bff53..26510fef2acd 100644
> --- a/include/linux/pm_runtime.h
> +++ b/include/linux/pm_runtime.h
> @@ -59,6 +59,8 @@ extern void pm_runtime_get_suppliers(struct device *dev);
>  extern void pm_runtime_put_suppliers(struct device *dev);
>  extern void pm_runtime_new_link(struct device *dev);
>  extern void pm_runtime_drop_link(struct device *dev);
> +extern void pm_runtime_get_noresume(struct device *dev);
> +extern void pm_runtime_put_noidle(struct device *dev);
>
>  static inline int pm_runtime_get_if_in_use(struct device *dev)
>  {
> @@ -70,16 +72,6 @@ static inline void pm_suspend_ignore_children(struct device *dev, bool enable)
>         dev->power.ignore_children = enable;
>  }
>
> -static inline void pm_runtime_get_noresume(struct device *dev)
> -{
> -       atomic_inc(&dev->power.usage_count);
> -}
> -
> -static inline void pm_runtime_put_noidle(struct device *dev)
> -{
> -       atomic_add_unless(&dev->power.usage_count, -1, 0);
> -}
> -
>  static inline bool pm_runtime_suspended(struct device *dev)
>  {
>         return dev->power.runtime_status == RPM_SUSPENDED
> --
> 2.17.1
>

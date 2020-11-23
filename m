Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3A092C1222
	for <lists+linux-pm@lfdr.de>; Mon, 23 Nov 2020 18:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390406AbgKWRgz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Nov 2020 12:36:55 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:43621 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726844AbgKWRgz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Nov 2020 12:36:55 -0500
Received: by mail-oi1-f193.google.com with SMTP id t143so20508200oif.10;
        Mon, 23 Nov 2020 09:36:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ihfaEk8OOAQEu6DS1TpnCL04XgGFF4EmUrnN3Gl4aC8=;
        b=eluRYhuNyNciUVPrW7cI9SHqJfjKy82I9dyl90eZ8EY9hFSp/ChKnhjy2s2Rs8JaVa
         8HZlDXEEE/5tNO1r0bxifE9ErBABlJUFKqYUjdPOvDICbm4HSOrwr+jLGEjxBLK63J4S
         uUlcELnzLl5dn4LJuGVG3iGfp/XBqvpdalPUWXB6zFbUvk+Fe8HGICYDcPbnKIjEl8kZ
         VNKWUssBL4LphL/BNC9YAaRu2uWQP60yGdORuPVNWefrxK4We9b8wDD/M1ZVWGNmUmZ4
         lDCrQOr54nNyXIyXCeHmTmdh5aAx+1CsItw74cSF7hxqxv7aXRT70SG5x7YP7qerZ+2y
         he2A==
X-Gm-Message-State: AOAM532lRKPYhhUdGL6mIAoptTfbPkk/wM0mR9Gy8xH20HbTZajh4eQb
        7Uq4KPwfnhOHgV1cxYAb4Bbj45uLIwB8HoxwyFY=
X-Google-Smtp-Source: ABdhPJzco8//TF2l7cZ1HyKSPVvOjLfv+k7LFgkSV/2yFeIABkJ+g1Pxg6rSoB3bVXfkfJJzCdmuRY0nqsonf3oNKGI=
X-Received: by 2002:aca:5a42:: with SMTP id o63mr200888oib.69.1606153013076;
 Mon, 23 Nov 2020 09:36:53 -0800 (PST)
MIME-Version: 1.0
References: <20201119072539.5673-1-patrice.chotard@st.com>
In-Reply-To: <20201119072539.5673-1-patrice.chotard@st.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 23 Nov 2020 18:36:42 +0100
Message-ID: <CAJZ5v0hUGt5O7zS7yRVC-3tk2fqVOYt2=bV_D0521A09p-S4-g@mail.gmail.com>
Subject: Re: [PATCH v2] PM: Add dev_wakeup_path() helper
To:     patrice.chotard@st.com
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        Erwan Le Ray <erwan.leray@st.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Pierre-Yves MORDRET <pierre-yves.mordret@st.com>,
        amelie.delaunay@st.com, alain.volmat@st.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Nov 19, 2020 at 8:26 AM <patrice.chotard@st.com> wrote:
>
> From: Patrice Chotard <patrice.chotard@st.com>
>
> Add dev_wakeup_path() helper to avoid to spread
> dev->power.wakeup_path test in drivers.
>
> Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>
> Changes from v1:
>   - Fold the 4 v1 patches into one
>   - Add Ulf's Reviewed-by
>
>  drivers/base/power/domain.c      |  4 ++--
>  drivers/base/power/main.c        |  4 ++--
>  drivers/i2c/busses/i2c-stm32f7.c |  4 ++--
>  include/linux/pm_wakeup.h        | 10 ++++++++++
>  4 files changed, 16 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 743268996336..e0894ef8457c 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -1142,7 +1142,7 @@ static int genpd_finish_suspend(struct device *dev, bool poweroff)
>         if (ret)
>                 return ret;
>
> -       if (dev->power.wakeup_path && genpd_is_active_wakeup(genpd))
> +       if (device_wakeup_path(dev) && genpd_is_active_wakeup(genpd))
>                 return 0;
>
>         if (genpd->dev_ops.stop && genpd->dev_ops.start &&
> @@ -1196,7 +1196,7 @@ static int genpd_resume_noirq(struct device *dev)
>         if (IS_ERR(genpd))
>                 return -EINVAL;
>
> -       if (dev->power.wakeup_path && genpd_is_active_wakeup(genpd))
> +       if (device_wakeup_path(dev) && genpd_is_active_wakeup(genpd))
>                 return pm_generic_resume_noirq(dev);
>
>         genpd_lock(genpd);
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index c7ac49042cee..921c5b2ec30a 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -1359,7 +1359,7 @@ static void dpm_propagate_wakeup_to_parent(struct device *dev)
>
>         spin_lock_irq(&parent->power.lock);
>
> -       if (dev->power.wakeup_path && !parent->power.ignore_children)
> +       if (device_wakeup_path(dev) && !parent->power.ignore_children)
>                 parent->power.wakeup_path = true;
>
>         spin_unlock_irq(&parent->power.lock);
> @@ -1627,7 +1627,7 @@ static int __device_suspend(struct device *dev, pm_message_t state, bool async)
>                 goto Complete;
>
>         /* Avoid direct_complete to let wakeup_path propagate. */
> -       if (device_may_wakeup(dev) || dev->power.wakeup_path)
> +       if (device_may_wakeup(dev) || device_wakeup_path(dev))
>                 dev->power.direct_complete = false;
>
>         if (dev->power.direct_complete) {
> diff --git a/drivers/i2c/busses/i2c-stm32f7.c b/drivers/i2c/busses/i2c-stm32f7.c
> index f41f51a176a1..9aa8e65b511e 100644
> --- a/drivers/i2c/busses/i2c-stm32f7.c
> +++ b/drivers/i2c/busses/i2c-stm32f7.c
> @@ -2322,7 +2322,7 @@ static int stm32f7_i2c_suspend(struct device *dev)
>
>         i2c_mark_adapter_suspended(&i2c_dev->adap);
>
> -       if (!device_may_wakeup(dev) && !dev->power.wakeup_path) {
> +       if (!device_may_wakeup(dev) && !device_wakeup_path(dev)) {
>                 ret = stm32f7_i2c_regs_backup(i2c_dev);
>                 if (ret < 0) {
>                         i2c_mark_adapter_resumed(&i2c_dev->adap);
> @@ -2341,7 +2341,7 @@ static int stm32f7_i2c_resume(struct device *dev)
>         struct stm32f7_i2c_dev *i2c_dev = dev_get_drvdata(dev);
>         int ret;
>
> -       if (!device_may_wakeup(dev) && !dev->power.wakeup_path) {
> +       if (!device_may_wakeup(dev) && !device_wakeup_path(dev)) {
>                 ret = pm_runtime_force_resume(dev);
>                 if (ret < 0)
>                         return ret;
> diff --git a/include/linux/pm_wakeup.h b/include/linux/pm_wakeup.h
> index aa3da6611533..196a157456aa 100644
> --- a/include/linux/pm_wakeup.h
> +++ b/include/linux/pm_wakeup.h
> @@ -84,6 +84,11 @@ static inline bool device_may_wakeup(struct device *dev)
>         return dev->power.can_wakeup && !!dev->power.wakeup;
>  }
>
> +static inline bool device_wakeup_path(struct device *dev)
> +{
> +       return dev->power.wakeup_path;
> +}
> +
>  static inline void device_set_wakeup_path(struct device *dev)
>  {
>         dev->power.wakeup_path = true;
> @@ -174,6 +179,11 @@ static inline bool device_may_wakeup(struct device *dev)
>         return dev->power.can_wakeup && dev->power.should_wakeup;
>  }
>
> +static inline bool device_wakeup_path(struct device *dev)
> +{
> +       return false;
> +}
> +
>  static inline void device_set_wakeup_path(struct device *dev) {}
>
>  static inline void __pm_stay_awake(struct wakeup_source *ws) {}
> --

Applied as 5.11 material, thanks!

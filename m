Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A01447E3D
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2019 11:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbfFQJX5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 Jun 2019 05:23:57 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:39517 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbfFQJX4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Jun 2019 05:23:56 -0400
Received: by mail-vs1-f68.google.com with SMTP id n2so5681951vso.6
        for <linux-pm@vger.kernel.org>; Mon, 17 Jun 2019 02:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/cJsdUbTg52BU1sHp4mMC2Qx85mUTaA7lh4cOcSR1MI=;
        b=Pkm8OoUC8CSPsobb9vleTt1tZGqnjtzFYFO9two55tNU0DfMf/4X2hwuWrxMr3fV6Z
         FCRVMyrdWh6f5e4A1qxsqhq5QGbgNTS+89ZPm8BcioRnOlCtwbUxMnYMvnKJIMdcmoBO
         XvCk9HikcZD/Upl0u60Sm2JiZt7c+4xdDgtFnS+0tnUPpJjt7BjWS3NP7JA750mdVHxA
         a6e3mqF90lOxvl5LQUPA/hWP2HMg4Tk5FvLu1YKvRu5lNYBMleg+gPII6awd31UGnAs3
         2uSWKseBT+kWfiFFsDuCCpt9Mgftwml0HCaC7ZvL6lyOQAogMLM9w6Ms5uMqt20SDlY4
         oNag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/cJsdUbTg52BU1sHp4mMC2Qx85mUTaA7lh4cOcSR1MI=;
        b=Nh+qTRxr1fFgWMcc+QxAjcJ9pkFd7cN3M5dT09aBkb7K9iUkTmKFmCXnObGND91Sk8
         M00tWb5ErGR2pw7QX3D+ZBunQXKhCM8T9VFYeqvdoIOXcv7HGuyNd6RKLLPzSyNi6//j
         +AnGKxjLeZ5s3jvCA/C+JrY+xs+nWp6dt6MFsiaWT69N6aRR78vHsWdW1WYYH08kWvCY
         rscHdD1Wq9ECfXfZC0gl8rbCAeoJMdKkzHR+BkkaLNafC4OUDo6nbwbIvxW5VY43BCDN
         C57F/6yRQ05t7eD2ATvjY/wMW+TSuUhwQdPCH5DuTj5QOruc/7zxEMNgfhhax+HA+ROG
         Q9cA==
X-Gm-Message-State: APjAAAXCvKni7XFTf2Tv3cNyGf/2nsXTvntgcshwi0BIbutYa/nCbQev
        1GoApXPHQSDqBoBattMYez+e6qWbqF0u3uoS0M5R3w==
X-Google-Smtp-Source: APXvYqwReTfX7h8azAwmNimt5ZvymCwl6dptR340BiX83vjWhUBkT72xFhsrtNPRVyVXBVJTHx2P0r9zOWHnkB9jPqo=
X-Received: by 2002:a67:ee5b:: with SMTP id g27mr25855640vsp.165.1560763435517;
 Mon, 17 Jun 2019 02:23:55 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1560163748.git.viresh.kumar@linaro.org> <c263629a53dba33f9e7190b82172a88cc79654d1.1560163748.git.viresh.kumar@linaro.org>
In-Reply-To: <c263629a53dba33f9e7190b82172a88cc79654d1.1560163748.git.viresh.kumar@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 17 Jun 2019 11:23:19 +0200
Message-ID: <CAPDyKFqiwVbmbnOZzpT-yokwwWrRTYXgmBtuUsdawEd3D0ySqQ@mail.gmail.com>
Subject: Re: [PATCH V3 1/5] PM / QOS: Pass request type to dev_pm_qos_{add|remove}_notifier()
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Kevin Hilman <khilman@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Qais.Yousef@arm.com, Matthias Kaehlcke <mka@chromium.org>,
        juri.lelli@gmail.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 10 Jun 2019 at 12:51, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> In order to use the same set of routines to register notifiers for
> different request types, update the existing
> dev_pm_qos_{add|remove}_notifier() routines with an additional
> parameter: request-type.
>
> For now, it only supports resume-latency request type.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe


> ---
>  Documentation/power/pm_qos_interface.txt | 10 ++++++----
>  drivers/base/power/domain.c              |  8 +++++---
>  drivers/base/power/qos.c                 | 14 ++++++++++++--
>  include/linux/pm_qos.h                   | 12 ++++++++----
>  4 files changed, 31 insertions(+), 13 deletions(-)
>
> diff --git a/Documentation/power/pm_qos_interface.txt b/Documentation/power/pm_qos_interface.txt
> index 19c5f7b1a7ba..ec7d662d1707 100644
> --- a/Documentation/power/pm_qos_interface.txt
> +++ b/Documentation/power/pm_qos_interface.txt
> @@ -164,12 +164,14 @@ directory.
>  Notification mechanisms:
>  The per-device PM QoS framework has a per-device notification tree.
>
> -int dev_pm_qos_add_notifier(device, notifier):
> -Adds a notification callback function for the device.
> +int dev_pm_qos_add_notifier(device, notifier, type):
> +Adds a notification callback function for the device for a particular request
> +type.
> +
>  The callback is called when the aggregated value of the device constraints list
> -is changed (for resume latency device PM QoS only).
> +is changed.
>
> -int dev_pm_qos_remove_notifier(device, notifier):
> +int dev_pm_qos_remove_notifier(device, notifier, type):
>  Removes the notification callback function for the device.
>
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 33c30c1e6a30..b063bc41b0a9 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -1536,7 +1536,8 @@ static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
>         if (ret)
>                 genpd_free_dev_data(dev, gpd_data);
>         else
> -               dev_pm_qos_add_notifier(dev, &gpd_data->nb);
> +               dev_pm_qos_add_notifier(dev, &gpd_data->nb,
> +                                       DEV_PM_QOS_RESUME_LATENCY);
>
>         return ret;
>  }
> @@ -1569,7 +1570,8 @@ static int genpd_remove_device(struct generic_pm_domain *genpd,
>
>         pdd = dev->power.subsys_data->domain_data;
>         gpd_data = to_gpd_data(pdd);
> -       dev_pm_qos_remove_notifier(dev, &gpd_data->nb);
> +       dev_pm_qos_remove_notifier(dev, &gpd_data->nb,
> +                                  DEV_PM_QOS_RESUME_LATENCY);
>
>         genpd_lock(genpd);
>
> @@ -1597,7 +1599,7 @@ static int genpd_remove_device(struct generic_pm_domain *genpd,
>
>   out:
>         genpd_unlock(genpd);
> -       dev_pm_qos_add_notifier(dev, &gpd_data->nb);
> +       dev_pm_qos_add_notifier(dev, &gpd_data->nb, DEV_PM_QOS_RESUME_LATENCY);
>
>         return ret;
>  }
> diff --git a/drivers/base/power/qos.c b/drivers/base/power/qos.c
> index 6c91f8df1d59..cfd463212513 100644
> --- a/drivers/base/power/qos.c
> +++ b/drivers/base/power/qos.c
> @@ -467,6 +467,7 @@ EXPORT_SYMBOL_GPL(dev_pm_qos_remove_request);
>   *
>   * @dev: target device for the constraint
>   * @notifier: notifier block managed by caller.
> + * @type: request type.
>   *
>   * Will register the notifier into a notification chain that gets called
>   * upon changes to the target value for the device.
> @@ -474,10 +475,14 @@ EXPORT_SYMBOL_GPL(dev_pm_qos_remove_request);
>   * If the device's constraints object doesn't exist when this routine is called,
>   * it will be created (or error code will be returned if that fails).
>   */
> -int dev_pm_qos_add_notifier(struct device *dev, struct notifier_block *notifier)
> +int dev_pm_qos_add_notifier(struct device *dev, struct notifier_block *notifier,
> +                           enum dev_pm_qos_req_type type)
>  {
>         int ret = 0;
>
> +       if (WARN_ON(type != DEV_PM_QOS_RESUME_LATENCY))
> +               return -EINVAL;
> +
>         mutex_lock(&dev_pm_qos_mtx);
>
>         if (IS_ERR(dev->power.qos))
> @@ -500,15 +505,20 @@ EXPORT_SYMBOL_GPL(dev_pm_qos_add_notifier);
>   *
>   * @dev: target device for the constraint
>   * @notifier: notifier block to be removed.
> + * @type: request type.
>   *
>   * Will remove the notifier from the notification chain that gets called
>   * upon changes to the target value.
>   */
>  int dev_pm_qos_remove_notifier(struct device *dev,
> -                              struct notifier_block *notifier)
> +                              struct notifier_block *notifier,
> +                              enum dev_pm_qos_req_type type)
>  {
>         int retval = 0;
>
> +       if (WARN_ON(type != DEV_PM_QOS_RESUME_LATENCY))
> +               return -EINVAL;
> +
>         mutex_lock(&dev_pm_qos_mtx);
>
>         /* Silently return if the constraints object is not present. */
> diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
> index 6ea1ae373d77..1f4d456e8fff 100644
> --- a/include/linux/pm_qos.h
> +++ b/include/linux/pm_qos.h
> @@ -146,9 +146,11 @@ int dev_pm_qos_add_request(struct device *dev, struct dev_pm_qos_request *req,
>  int dev_pm_qos_update_request(struct dev_pm_qos_request *req, s32 new_value);
>  int dev_pm_qos_remove_request(struct dev_pm_qos_request *req);
>  int dev_pm_qos_add_notifier(struct device *dev,
> -                           struct notifier_block *notifier);
> +                           struct notifier_block *notifier,
> +                           enum dev_pm_qos_req_type type);
>  int dev_pm_qos_remove_notifier(struct device *dev,
> -                              struct notifier_block *notifier);
> +                              struct notifier_block *notifier,
> +                              enum dev_pm_qos_req_type type);
>  void dev_pm_qos_constraints_init(struct device *dev);
>  void dev_pm_qos_constraints_destroy(struct device *dev);
>  int dev_pm_qos_add_ancestor_request(struct device *dev,
> @@ -202,10 +204,12 @@ static inline int dev_pm_qos_update_request(struct dev_pm_qos_request *req,
>  static inline int dev_pm_qos_remove_request(struct dev_pm_qos_request *req)
>                         { return 0; }
>  static inline int dev_pm_qos_add_notifier(struct device *dev,
> -                                         struct notifier_block *notifier)
> +                                         struct notifier_block *notifier,
> +                                         enum dev_pm_qos_req_type type);
>                         { return 0; }
>  static inline int dev_pm_qos_remove_notifier(struct device *dev,
> -                                            struct notifier_block *notifier)
> +                                            struct notifier_block *notifier,
> +                                            enum dev_pm_qos_req_type type)
>                         { return 0; }
>  static inline void dev_pm_qos_constraints_init(struct device *dev)
>  {
> --
> 2.21.0.rc0.269.g1a574e7a288b
>

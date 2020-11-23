Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 659B72C1241
	for <lists+linux-pm@lfdr.de>; Mon, 23 Nov 2020 18:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730892AbgKWRnW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Nov 2020 12:43:22 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:36051 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730356AbgKWRnW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Nov 2020 12:43:22 -0500
Received: by mail-oi1-f194.google.com with SMTP id d9so20566142oib.3;
        Mon, 23 Nov 2020 09:43:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EaqMapxrqa7xGgGK1+Km6QmMQ60wo3L70aBFri8Em9U=;
        b=hFhWbgeuBL3GnsLVZBmt1NBAXdJ3duroHr5R6MOVi94kvFsvLmz2JrG83jT3aVRl0Y
         aQXmD6ZRHokaHSmKayhoD/SoW7pG0vCBT14bDvWUy6kIx39ZYDLxgLsY4VzWZXaujBzO
         NOYKZnyG+84NsekeAD2ecAwN/4yGjPSQQn5WUOiwTOwutMd7Gt3neRbPRCoI6t/i/vPU
         yZAAU6b0mPYMgi18mSHhkx8yMBcFSzFt66fTROBl6jq0fVopp8YTLxIG3njC/TBz+Isv
         QpnaI8UTqG3D8eK5DpvQKn8jUbmoXjWzCGftVkvZosSCsxJ4IL0m+Y+9LTM5bxAfR0RG
         JVJQ==
X-Gm-Message-State: AOAM5312d3yZmR+GguZJD7HKq6oMlLz7CKpV/8qdx9VUn0d6s4dt91Br
        4URrXwYunvJplR+1Q9rzk4HN51U1XUxXasFllW0=
X-Google-Smtp-Source: ABdhPJwWV9WY5ZP7OL5x1zmlnZGpsksZaSacJjSj3rwjBQIbrMtPEVvOs/LUZ5GrQSQYsGey22+KXcIsQEY8rbOQcEI=
X-Received: by 2002:aca:5a42:: with SMTP id o63mr2775oib.69.1606153401297;
 Mon, 23 Nov 2020 09:43:21 -0800 (PST)
MIME-Version: 1.0
References: <20201119164325.9536-1-ilina@codeaurora.org>
In-Reply-To: <20201119164325.9536-1-ilina@codeaurora.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 23 Nov 2020 18:43:10 +0100
Message-ID: <CAJZ5v0g-TxSvT9wp2fUoT1FEyq3=aMfrFJL1KYMb7NjWCokA8g@mail.gmail.com>
Subject: Re: [PATCH v2] PM / Domains: replace -ENOTSUPP with -EOPNOTSUPP
To:     Lina Iyer <ilina@codeaurora.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Nov 19, 2020 at 5:44 PM Lina Iyer <ilina@codeaurora.org> wrote:
>
> While submitting a patch to add next_wakeup, checkpatch reported this -
>
> WARNING: ENOTSUPP is not a SUSV4 error code, prefer EOPNOTSUPP
> +       return -ENOTSUPP;
>
> Address the above warning in other functions in pm_domain.h.
>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> ---
>  include/linux/pm_domain.h | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index 34a8784b0ad4..e55781333695 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -259,24 +259,24 @@ static inline int pm_genpd_init(struct generic_pm_domain *genpd,
>  }
>  static inline int pm_genpd_remove(struct generic_pm_domain *genpd)
>  {
> -       return -ENOTSUPP;
> +       return -EOPNOTSUPP;
>  }
>
>  static inline int dev_pm_genpd_set_performance_state(struct device *dev,
>                                                      unsigned int state)
>  {
> -       return -ENOTSUPP;
> +       return -EOPNOTSUPP;
>  }
>
>  static inline int dev_pm_genpd_add_notifier(struct device *dev,
>                                             struct notifier_block *nb)
>  {
> -       return -ENOTSUPP;
> +       return -EOPNOTSUPP;
>  }
>
>  static inline int dev_pm_genpd_remove_notifier(struct device *dev)
>  {
> -       return -ENOTSUPP;
> +       return -EOPNOTSUPP;
>  }
>
>  static inline int dev_pm_genpd_set_next_wakeup(struct device *dev, ktime_t next)
> @@ -334,13 +334,13 @@ struct device *genpd_dev_pm_attach_by_name(struct device *dev,
>  static inline int of_genpd_add_provider_simple(struct device_node *np,
>                                         struct generic_pm_domain *genpd)
>  {
> -       return -ENOTSUPP;
> +       return -EOPNOTSUPP;
>  }
>
>  static inline int of_genpd_add_provider_onecell(struct device_node *np,
>                                         struct genpd_onecell_data *data)
>  {
> -       return -ENOTSUPP;
> +       return -EOPNOTSUPP;
>  }
>
>  static inline void of_genpd_del_provider(struct device_node *np) {}
> @@ -396,7 +396,7 @@ static inline struct device *genpd_dev_pm_attach_by_name(struct device *dev,
>  static inline
>  struct generic_pm_domain *of_genpd_remove_last(struct device_node *np)
>  {
> -       return ERR_PTR(-ENOTSUPP);
> +       return ERR_PTR(-EOPNOTSUPP);
>  }
>  #endif /* CONFIG_PM_GENERIC_DOMAINS_OF */
>
> --

Applied as 5.11 material, thanks!

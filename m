Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF0E997A9
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2019 17:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731226AbfHVPEN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Aug 2019 11:04:13 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:39771 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729704AbfHVPEM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Aug 2019 11:04:12 -0400
Received: by mail-ua1-f65.google.com with SMTP id k7so2098492uao.6
        for <linux-pm@vger.kernel.org>; Thu, 22 Aug 2019 08:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tJx874thq0B3RRtsLQbldc2TAn3xe1/rPVNxP0ErCtY=;
        b=NthyVkf75TKHqhHOvlfwCXFzZGwrHQ+4j7L0gcCOFwVZYhWn3jt6veHpLgv1ebJdiw
         b4Mh9fBUkDSRnIHBl6u5YvnCp5m1jvAOssDXhPo9O8tc9ajjmGKHhJ8EN03F1Ek1sbLy
         RaHf7eHTtMHPTJtqzbPAxqkeiBGeQMaw+BY4PwEE40efsy14AbGU3nJ44LHlhCHzELv4
         ATxSGyXpGYwk6KwiwxjgnniniYkngzjoS5IvHa6fwMdLpPAq+QG2mS8vVMNqldVmaKvu
         EI5o50Psu6t4J9isol1cdpbN0Q4PEiGqChdWpph1TUcIlVMQhnfTshmHbqrU4IGedU7q
         yA0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tJx874thq0B3RRtsLQbldc2TAn3xe1/rPVNxP0ErCtY=;
        b=R2KozRnzVTBZW5CqeEK6UfR6rMPHGKAssKRu8qfwkQPBdPpQxbQWRlnI6Y7Lszgtv/
         Aj4cRgjMAPQH7EXe/T6cicTLC1x71ifR4Jee3oarKkh71fa5T+84CLMu2B0skGtRl9vL
         V2VurEGKLJus6jgaQUwEaFZlD+lw3AHWPl548aYz0Xr6x2NIFlEWhj7I8CSx+huqIUAc
         omeQn19ay8dwl8Z9ylxmXCwdLF8uOfsjP0DqFkqZnhGXicmo6sK3lnDSQe3oQkr0+GoL
         0Fa3q473AJq6gtx+MTpmBX63aBr0fBaceAcrRhFo/nxVtrx+mDTYAyDw5fyXDje4Briv
         YY0g==
X-Gm-Message-State: APjAAAUajvGTB47JPE8lekCnYOXcZOg2Xui9TZWAtva79bFind/WePNs
        61oEdBKnbXumRmCWFaWsNm/x8DuuSlyemIcq/0gqaQ==
X-Google-Smtp-Source: APXvYqxAz984KybIdfOFEoMJFDD+vaTXLNt6CB+jW8lgEqcYzBzdAJcm+l8BCt7chInI2mod5bLqrJb6UtxeYHfmJrI=
X-Received: by 2002:ab0:210f:: with SMTP id d15mr5944621ual.129.1566486250989;
 Thu, 22 Aug 2019 08:04:10 -0700 (PDT)
MIME-Version: 1.0
References: <1565398727-23090-1-git-send-email-thara.gopinath@linaro.org> <1565398727-23090-2-git-send-email-thara.gopinath@linaro.org>
In-Reply-To: <1565398727-23090-2-git-send-email-thara.gopinath@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 22 Aug 2019 17:03:34 +0200
Message-ID: <CAPDyKFrcK+Jub0gAeevrscoGaHA+PRGmVHZHxB2T6_3Fqm=ceA@mail.gmail.com>
Subject: Re: [PATCH 1/4] PM/Domains: Add support for retrieving genpd
 performance states information
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     qualcomm-lt@lists.linaro.org, Linux PM <linux-pm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, 10 Aug 2019 at 02:58, Thara Gopinath <thara.gopinath@linaro.org> wrote:
>
> Add two new APIs in the genpd framework,
> dev_pm_genpd_get_performance_state to return the current performance
> state of a power domain and dev_pm_genpd_performance_state_count to
> return the total number of performance states supported by a
> power domain. Since the genpd framework does not maintain
> a count of number of performance states supported by a power domain,
> introduce a new callback(.get_performance_state_count) that can be used
> to retrieve this information from power domain drivers.

I think some brief background to *why* this is useful needs to be
squeezed into the changelog. Or at least state that following changes
makes use of it, somehow.

>
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> ---
>  drivers/base/power/domain.c | 38 ++++++++++++++++++++++++++++++++++++++
>  include/linux/pm_domain.h   | 18 ++++++++++++++++++
>  2 files changed, 56 insertions(+)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index b063bc4..17e0375 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -413,6 +413,44 @@ int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state)
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_genpd_set_performance_state);
>
> +int dev_pm_genpd_get_performance_state(struct device *dev,
> +                                      unsigned int *state)
> +{
> +       struct generic_pm_domain *genpd;
> +
> +       genpd = dev_to_genpd(dev);

We need to verify that the there is a genpd attached before doing this
cast. Let me post a patch in a day or so, it will give you a helper
function that covers this.

> +       if (IS_ERR(genpd))
> +               return -ENODEV;
> +
> +       genpd_lock(genpd);
> +       *state = genpd->performance_state;

Why not return the state, rather than assigning an out-parameter?

> +       genpd_unlock(genpd);
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(dev_pm_genpd_get_performance_state);
> +
> +int dev_pm_genpd_performance_state_count(struct device *dev,
> +                                        unsigned int *count)
> +{
> +       struct generic_pm_domain *genpd;
> +       int ret;
> +
> +       genpd = dev_to_genpd(dev);
> +       if (IS_ERR(genpd))
> +               return -ENODEV;
> +
> +       if (unlikely(!genpd->get_performance_state_count))
> +               return -EINVAL;
> +
> +       genpd_lock(genpd);
> +       ret = genpd->get_performance_state_count(genpd, count);

Why not having the callback to return the state, rather than using an
out-parameter?

> +       genpd_unlock(genpd);
> +
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(dev_pm_genpd_performance_state_count);
> +
>  static int _genpd_power_on(struct generic_pm_domain *genpd, bool timed)
>  {
>         unsigned int state_idx = genpd->state_idx;
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index 91d9bf4..0e5f502 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -117,6 +117,8 @@ struct generic_pm_domain {
>                                                  struct dev_pm_opp *opp);
>         int (*set_performance_state)(struct generic_pm_domain *genpd,
>                                      unsigned int state);
> +       int (*get_performance_state_count)(struct generic_pm_domain *genpd,
> +                                          unsigned int *count);
>         struct gpd_dev_ops dev_ops;
>         s64 max_off_time_ns;    /* Maximum allowed "suspended" time. */
>         bool max_off_time_changed;
> @@ -204,6 +206,10 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
>                   struct dev_power_governor *gov, bool is_off);
>  int pm_genpd_remove(struct generic_pm_domain *genpd);
>  int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state);
> +int dev_pm_genpd_get_performance_state(struct device *dev,
> +                                      unsigned int *state);
> +int dev_pm_genpd_performance_state_count(struct device *dev,
> +                                        unsigned int *count);
>
>  extern struct dev_power_governor simple_qos_governor;
>  extern struct dev_power_governor pm_domain_always_on_gov;
> @@ -251,6 +257,18 @@ static inline int dev_pm_genpd_set_performance_state(struct device *dev,
>         return -ENOTSUPP;
>  }
>
> +static inline int dev_pm_genpd_get_performance_state(struct device *dev,
> +                                                    unsigned int *state);
> +{
> +       return -ENOTSUPP;
> +}
> +
> +static inline int dev_pm_genpd_performance_state_count(struct device *dev,
> +                                                      unsigned int *count);
> +{
> +       return -ENOTSUPP;
> +}
> +
>  #define simple_qos_governor            (*(struct dev_power_governor *)(NULL))
>  #define pm_domain_always_on_gov                (*(struct dev_power_governor *)(NULL))
>  #endif
> --
> 2.1.4
>

Kind regards
Uffe

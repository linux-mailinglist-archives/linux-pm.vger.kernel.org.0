Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 863E9747359
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jul 2023 15:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbjGDNzI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Jul 2023 09:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbjGDNzG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Jul 2023 09:55:06 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243D1BE
        for <linux-pm@vger.kernel.org>; Tue,  4 Jul 2023 06:55:05 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-be49ca27e1fso6184991276.3
        for <linux-pm@vger.kernel.org>; Tue, 04 Jul 2023 06:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688478904; x=1691070904;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bbInuMOaeGH2/pfUXBP7Ae3B0+gOG6gDsXRs6oqX8sQ=;
        b=B68oywBDw6QM9sPH3nKNiCHT/pSIoiCPuIIkzAkCxCa8GJ5lpYfWjfDdH0trlCaTJd
         2xK/cpi/YT3sxzulpr3nj7jYseH50FY4ahSlV4PfRQzRvZwgKh9pOb4hfs8EwW4ovnNp
         Ju6CXm1AvuUp/Y4cp94R1qefX9ERrpQJto1M4iRQiIQEMybWzU4iCYjJLHo1UEZC95Tt
         +EgY7Q8FnyB6hjhllftqxmwgCaqTUMtD6gKvd9Wsaj1XoO7T+70WMobYUaP3QofKXC1I
         52FEykZzJyaJMWXRy27mu3oi48ll39hqlYQKQoZUMp4JlG1KCgZejX9l2AG1uFWaxBPY
         6PnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688478904; x=1691070904;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bbInuMOaeGH2/pfUXBP7Ae3B0+gOG6gDsXRs6oqX8sQ=;
        b=AcZIa7Jf22/bmXEKUYYUo1oepb511/lXftIlVmUOzF4ZBOHzbycugZp/nTbdisr7O4
         LiCH+GHbujA/1IzehJuF90unAjqa4ET/VP+yDLO4x5jNwTDvtsRj0DL5X75iTZHGlciI
         M+ZF0x/70nt+dFRkInWwcdm1iJB09PqW1Id+SFQzdcOuI2c9LhwiAk6UUUQyqOHcs1It
         lHPieR2K72WO4/k0FgIvI2eOTcEkWUCCBvi2WuRGQsxJfiPNHnf9tHBz3YMrFvx8moaa
         cbrYBKrXo0YRE0ByZ5PmFUxmqjq7YtA9QbgddfLavd8KQtDpSR9Q68u7uGDXhjj4n4Pg
         5dDA==
X-Gm-Message-State: ABy/qLbcZG/BIgijEx8wG3jJ6acdDgzR1AdYCU21Hceix5iSskSqDfAE
        2Sn0Y3RwhVznzKJbCzSvtF/J2ijzoT1OfGe5riNVtg==
X-Google-Smtp-Source: APBJJlE/ZZiKuvpdnr9LwWHHgdmOPydDsK5lYvgSF5VC1VJFhX6g20gb+lSl/bQIvqlE5yD64J2YYrOM5X4CtMON5GA=
X-Received: by 2002:a25:b326:0:b0:c01:287b:41f9 with SMTP id
 l38-20020a25b326000000b00c01287b41f9mr10447897ybj.59.1688478904309; Tue, 04
 Jul 2023 06:55:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230621144019.3219858-1-abel.vesa@linaro.org> <20230621144019.3219858-5-abel.vesa@linaro.org>
In-Reply-To: <20230621144019.3219858-5-abel.vesa@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 4 Jul 2023 15:54:28 +0200
Message-ID: <CAPDyKFpPNYYxECPpk0Qbos70WeZgOXCtu7qXGGzvLLizzrdjtA@mail.gmail.com>
Subject: Re: [RFC PATCH v5 4/4] PM: domains: Add and set generic sync state callback
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 21 Jun 2023 at 16:40, Abel Vesa <abel.vesa@linaro.org> wrote:
>
> For every provider that doesn't register a sync_state callback,
> register a generic one. This new generic sync_state callback queues up a
> power off request.
>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  drivers/base/power/domain.c | 23 +++++++++++++++++++++++
>  include/linux/pm_domain.h   |  3 +++
>  2 files changed, 26 insertions(+)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 5967ade160e2..ec16db0599ac 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -654,6 +654,27 @@ static void genpd_queue_power_off_work(struct generic_pm_domain *genpd)
>         queue_work(pm_wq, &genpd->power_off_work);
>  }
>
> +/**
> + * pm_genpd_power_off_unused_sync_state - Power off all domains for provider.
> + * @dev: Provider's device.
> + *
> + * Request power off for all unused domains of the provider.
> + * This should be used exclusively as sync state callback for genpd providers.
> + */
> +void pm_genpd_power_off_unused_sync_state(struct device *dev)
> +{
> +       struct generic_pm_domain *genpd;
> +
> +       mutex_lock(&gpd_list_lock);
> +
> +       list_for_each_entry(genpd, &gpd_list, gpd_list_node)
> +               if (genpd->provider && genpd->provider->dev == dev)

Not all genpds have the ->provider assigned. Moreover, the
of_genpd_mutex is protecting the list of providers, we should use that
instead.

> +                       genpd_queue_power_off_work(genpd);
> +
> +       mutex_unlock(&gpd_list_lock);
> +}
> +EXPORT_SYMBOL_GPL(pm_genpd_power_off_unused_sync_state);

Why does this need to be exported? Is there a provider that assigns
it's own sync state callback that needs to call this? If that is the
case, I would prefer to see a user of this API as a part of the series
too.

> +
>  /**
>   * genpd_keep_on - Tells if the domain should skip the power 'off' request
>   * @genpd: PM domain to be checked.
> @@ -2329,6 +2350,8 @@ static int genpd_add_provider(struct device_node *np, genpd_xlate_t xlate,
>         cp->xlate = xlate;
>         fwnode_dev_initialized(&np->fwnode, true);
>
> +       dev_set_drv_sync_state(np->fwnode.dev, pm_genpd_power_off_unused_sync_state);
> +
>         mutex_lock(&of_genpd_mutex);
>         list_add(&cp->link, &of_genpd_providers);
>         mutex_unlock(&of_genpd_mutex);
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index 3eb32c4b6d4f..78164244b89f 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -279,6 +279,9 @@ static inline int pm_genpd_remove(struct generic_pm_domain *genpd)
>         return -EOPNOTSUPP;
>  }
>
> +static inline void pm_genpd_power_off_unused_sync_state(struct device *dev)
> +{ }
> +
>  static inline int dev_pm_genpd_set_performance_state(struct device *dev,
>                                                      unsigned int state)
>  {

Kind regards
Uffe

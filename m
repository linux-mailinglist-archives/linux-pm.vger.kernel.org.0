Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D02F372F8DD
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jun 2023 11:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243942AbjFNJRi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 14 Jun 2023 05:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243927AbjFNJRf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 14 Jun 2023 05:17:35 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF76E1FCE
        for <linux-pm@vger.kernel.org>; Wed, 14 Jun 2023 02:17:33 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-bb2ffa1e235so408406276.0
        for <linux-pm@vger.kernel.org>; Wed, 14 Jun 2023 02:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686734253; x=1689326253;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PTBVmOmDMzb6HOpg6itSeV5ALgSNkSQSXEOkc+hECJ8=;
        b=BB9fyBqmXlKZDGNoU7VNBFDrTJ46l95A4aSDynBQlfQwrIIb/XObfpZH8bWZltwpn4
         iCMJWJVPZs0mwYyN1FoOREZr6D4/A0xgewxT/lAACHKWra1NBmZZh32yLyjRDcH/cr6i
         gyj1oRwdQ0qNkQfDrnmputbtxN5selufbM3sR94Jd80HCMlmrAsPjD98hUzNqvCzhyNh
         Z/Ipm/wE7d6HJWGT9cCGgzdWtuyT7zNZDQhdpXGXLIx8xsHqwabioVkU1LD894/rN04p
         Xd0lWbeGaaplMeTLWHGWoLIS2om/niNhaPLsSU7x6w97gPat/IF3U63ltp8b1wf3pblX
         I2kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686734253; x=1689326253;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PTBVmOmDMzb6HOpg6itSeV5ALgSNkSQSXEOkc+hECJ8=;
        b=hydmF1KAjhZv/U/aFIYIC7i3rWV/FVyuQ0t6vi800H4b33u768LtLyvb1rDjqbHvpX
         KFFehqotvDWaOp7nNKtp5w9zJsvpi6wgQSMvVNw5ggTrF3SH0/Z4s0sWnpJ7+7Wcmf+8
         rpk4jiiqka8pLwnFlu+EL8L21/th4BjcdhC866K6Qkpli+IVmDXg3r5jZQiq5cIJCpeC
         7o4KbT/eLmFdZgE56qwvDLxuFJzSEwqe8cYRqDdCSQgTn16EEknsJSj0xXk65MBqOdPT
         SMUXwSv/BouXmZJdFNDLeLivbXmTnoG3Q8HnbzG0T2qdPzNLXvDPd/VlXcG0iSYXYgc5
         rNqg==
X-Gm-Message-State: AC+VfDxnkx0qvG21E0s2YFFTECcQWVsL1dEznYH4GNt8HOg8ccD4JQi2
        1Cd4CT9zb1M9eLoLpmgmXhV4AHZi1RoX9uxXXrbifg==
X-Google-Smtp-Source: ACHHUZ5K3Z1ZY2o1DME5MRP1AC+d8PZOTVwaEBC/JSKMbOui3OhK7Bm2pYMA5+S0TcqZAtYuucWIid+8eww9cMezAsc=
X-Received: by 2002:a25:d381:0:b0:bb1:6e29:a84d with SMTP id
 e123-20020a25d381000000b00bb16e29a84dmr1285988ybf.53.1686734253076; Wed, 14
 Jun 2023 02:17:33 -0700 (PDT)
MIME-Version: 1.0
References: <8f4574ab6c334dfe1d76c567062e43d751af2457.1686729428.git.viresh.kumar@linaro.org>
In-Reply-To: <8f4574ab6c334dfe1d76c567062e43d751af2457.1686729428.git.viresh.kumar@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 14 Jun 2023 11:16:56 +0200
Message-ID: <CAPDyKFprofLjxuBjF6HG8Ja3tG-d0YtAjFD2rPXEODcWxeX3_A@mail.gmail.com>
Subject: Re: [PATCH] OPP: don't drop performance constraint on OPP table removal
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 14 Jun 2023 at 09:57, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> This code was added (long back) by commit 009acd196fc8 ("PM / OPP:
> Support updating performance state of device's power domain") and at
> that time the `opp->pstate` field was used to store the performance
> state required by a device's OPP.
>
> Over time that changed and the `->pstate` field is now used only for
> genpd devices and consumer devices access that via the required-opps
> instead.
>
> Because of all these changes, _opp_table_kref_release() now drops the
> constraint only when the genpd's OPP table gets freed and not the
> device's. Which is definitely not what we wanted. And dropping the
> constraint doesn't have much meaning as the genpd itself is going away.
>
> Moreover, if we want to drop constraints here, then just dropping the
> performance constraint alone isn't sufficient as there are other
> resource constraints like clk, regulator, etc. too, which must be
> handled.
>
> Probably the right thing to do here is to leave this decision to the
> consumers, which can call `dev_pm_opp_set_rate(dev, 0)` or similar APIs
> to drop all constraints properly. Which many of the consumers already
> do.
>
> Remove the special code, which is broken anyway.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

One good step to clean up the mess. Thanks!

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

> ---
>  drivers/opp/core.c | 10 +---------
>  drivers/opp/of.c   |  8 --------
>  drivers/opp/opp.h  |  2 --
>  3 files changed, 1 insertion(+), 19 deletions(-)
>
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 9f918077cd62..7290168ec806 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -1522,16 +1522,8 @@ static void _opp_table_kref_release(struct kref *kref)
>
>         WARN_ON(!list_empty(&opp_table->opp_list));
>
> -       list_for_each_entry_safe(opp_dev, temp, &opp_table->dev_list, node) {
> -               /*
> -                * The OPP table is getting removed, drop the performance state
> -                * constraints.
> -                */
> -               if (opp_table->genpd_performance_state)
> -                       dev_pm_genpd_set_performance_state((struct device *)(opp_dev->dev), 0);
> -
> +       list_for_each_entry_safe(opp_dev, temp, &opp_table->dev_list, node)
>                 _remove_opp_dev(opp_dev, opp_table);
> -       }
>
>         mutex_destroy(&opp_table->genpd_virt_dev_lock);
>         mutex_destroy(&opp_table->lock);
> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> index ac2179d5da4c..943c7fb7402b 100644
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -1034,14 +1034,6 @@ static int _of_add_opp_table_v2(struct device *dev, struct opp_table *opp_table)
>                 goto remove_static_opp;
>         }
>
> -       list_for_each_entry(opp, &opp_table->opp_list, node) {
> -               /* Any non-zero performance state would enable the feature */
> -               if (opp->pstate) {
> -                       opp_table->genpd_performance_state = true;
> -                       break;
> -               }
> -       }
> -
>         lazy_link_required_opp_table(opp_table);
>
>         return 0;
> diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
> index eb71385d96c1..3805b92a6100 100644
> --- a/drivers/opp/opp.h
> +++ b/drivers/opp/opp.h
> @@ -182,7 +182,6 @@ enum opp_table_access {
>   * @paths: Interconnect path handles
>   * @path_count: Number of interconnect paths
>   * @enabled: Set to true if the device's resources are enabled/configured.
> - * @genpd_performance_state: Device's power domain support performance state.
>   * @is_genpd: Marks if the OPP table belongs to a genpd.
>   * @set_required_opps: Helper responsible to set required OPPs.
>   * @dentry:    debugfs dentry pointer of the real device directory (not links).
> @@ -233,7 +232,6 @@ struct opp_table {
>         struct icc_path **paths;
>         unsigned int path_count;
>         bool enabled;
> -       bool genpd_performance_state;
>         bool is_genpd;
>         int (*set_required_opps)(struct device *dev,
>                 struct opp_table *opp_table, struct dev_pm_opp *opp, bool scaling_down);
> --
> 2.31.1.272.g89b43f80a514
>

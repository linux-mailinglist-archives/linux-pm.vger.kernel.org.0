Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB0D462898E
	for <lists+linux-pm@lfdr.de>; Mon, 14 Nov 2022 20:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237236AbiKNTlc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Nov 2022 14:41:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237284AbiKNTl3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Nov 2022 14:41:29 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E00852339B
        for <linux-pm@vger.kernel.org>; Mon, 14 Nov 2022 11:41:27 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id f3so4715406pgc.2
        for <linux-pm@vger.kernel.org>; Mon, 14 Nov 2022 11:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Yd27tgQr+0/60rgjYTAmAKuLM8bTPM8JxSoQaSar6No=;
        b=wm5MacI9Icz3uTsibnoP0tS3rbE085GVnTJR3uBY6eeg9Y0CUTRmfpy2UUIPyMU0aB
         1tsiI+xnhFsMqSDkmq1jb0Tar0dErUI85TRFcRMMWKI9wWCYx7dX9ppSdCzON9SZvDfp
         k3p+yVaA/f9AuB0lmmeqGlEiZaobkSigurkq6dW2rPmlIKphoCPqbdmk3iWRKxoZYJP/
         D14hyf09VrytR4xyk0D5UlP96veA3RmbYrdj23Z814rN6msvEIrE7xICHrMkwVdRE5gt
         HLrtLcq+3LREaKREMbQclF/hZXDxmY68KkWIaaJ9j3nn9gCdlx979bck0sGvmTNguNSh
         SBlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yd27tgQr+0/60rgjYTAmAKuLM8bTPM8JxSoQaSar6No=;
        b=VYDK7tpWW2v9olwXJ4pDRRbsO24gWcLHVA0wxLfKmFGUu5UMig8azXPAN1VWWPyOox
         KGgPt2EDseiD/PYUhQi5RTgXhoviLETQQp4J2mLoyTX4lHEApfcvHNxSM4sJQsppxr5B
         vxIFxvNpipAMnC8zF5fnd8SQFv9GL0TACvtPsYXOG1+X8FcHYeDFHmzkGXMAszVAIK3w
         rvP/WbmSmsLQVtqF/CG0CNLO9n8RIGajClzxPDrblan7Iu3iq7UCy84kbnjXPkPj5wNd
         +YisOUpkiI8qyP+P+pij9QA9RPMEnIVmpzesMHAQyknmjAbVbNQDxSAlkznRyVFGyC5R
         P9nQ==
X-Gm-Message-State: ANoB5pn1oXdqLSXit9k9mvPoVxFKDjlqx9vfTnCTWkkxPgC3MaYGyKxd
        Azeiqddzx98RsYIdrGEHmiT68CDmx3RhnfDtHZjzrQ==
X-Google-Smtp-Source: AA0mqf6+Ps0tnDmGtxM5PjS7+fsyJ9xn6V2nTtdaGUJIaciaB0E+S+B+jWQVKytEt4DtrLr5itomEiLh2oDfWs6cV8s=
X-Received: by 2002:a05:6a00:88c:b0:56b:e1d8:e7a1 with SMTP id
 q12-20020a056a00088c00b0056be1d8e7a1mr15136590pfj.28.1668454887057; Mon, 14
 Nov 2022 11:41:27 -0800 (PST)
MIME-Version: 1.0
References: <20221108013517.749665-1-marex@denx.de>
In-Reply-To: <20221108013517.749665-1-marex@denx.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 14 Nov 2022 20:40:50 +0100
Message-ID: <CAPDyKFoUdfUjZMgzU-3SS0gVstj-04FbTSjxihdar2wxu5c97w@mail.gmail.com>
Subject: Re: [PATCH 1/3] [RFC] PM: domains: Introduce .power_pre/post_on/off callbacks
To:     Marek Vasut <marex@denx.de>
Cc:     linux-pm@vger.kernel.org, Adam Ford <aford173@gmail.com>,
        Fabio Estevam <festevam@denx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jacky Bai <ping.bai@nxp.com>,
        Kevin Hilman <khilman@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Len Brown <len.brown@intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Mark Brown <broonie@kernel.org>,
        Martin Kepplinger <martink@posteo.de>,
        Pavel Machek <pavel@ucw.cz>, Peng Fan <peng.fan@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-imx@nxp.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 8 Nov 2022 at 02:35, Marek Vasut <marex@denx.de> wrote:
>
> Currently it is possible that a power domain power on or off would claim
> the genpd lock first and clock core prepare_lock second, while another
> thread could do the reverse, and this would trigger lockdep warning.

I am not quite sure I fully understand. In this case is the lockdep
warning relevant or just something that we want to silence?

>
> Introduce new callbacks, .power_pre/post_on() and .power_off_pre/post(), which
> are triggered before the genpd_lock() and after genpd_unlock() respectively in
> case the domain is powered on and off. Those are meant to let drivers claim
> clock core prepare_lock via clk_*prepare() call and release the lock via
> clk_*unprepare() call to always assure that the clock and genpd lock ordering
> is correct.

To me, this sounds like a problem that may be better fixed by trying
to model the parent/child-domains in a more strict way, through genpd.

There is a comment in the code in imx8mp_blk_ctrl_probe() that seems
to be pointing in this direction too.

"* We use runtime PM to trigger power on/off of the upstream GPC
  * domain, as a strict hierarchical parent/child power domain
  * setup doesn't allow us to meet the sequencing requirements......"

I am wondering about what those "sequencing requirements" are - and
whether it could make better sense to fix these issues instead?

Kind regards
Uffe

>
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Adam Ford <aford173@gmail.com>
> Cc: Fabio Estevam <festevam@denx.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jacky Bai <ping.bai@nxp.com>
> Cc: Kevin Hilman <khilman@kernel.org>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Marek Vasut <marex@denx.de>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Martin Kepplinger <martink@posteo.de>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Shengjiu Wang <shengjiu.wang@nxp.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: linux-clk@vger.kernel.org
> Cc: linux-imx@nxp.com
> Cc: linux-pm@vger.kernel.org
> To: linux-arm-kernel@lists.infradead.org
> ---
>  drivers/base/power/domain.c | 103 ++++++++++++++++++++++++++++++++----
>  include/linux/pm_domain.h   |   4 ++
>  2 files changed, 97 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 6471b559230e9..df2a93d0674e4 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -494,6 +494,22 @@ void dev_pm_genpd_set_next_wakeup(struct device *dev, ktime_t next)
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_genpd_set_next_wakeup);
>
> +static int genpd_power_pre_on(struct generic_pm_domain *genpd)
> +{
> +       if (!genpd->power_pre_on)
> +               return 0;
> +
> +       return genpd->power_pre_on(genpd);
> +}
> +
> +static int genpd_power_post_on(struct generic_pm_domain *genpd)
> +{
> +       if (!genpd->power_post_on)
> +               return 0;
> +
> +       return genpd->power_post_on(genpd);
> +}
> +
>  static int _genpd_power_on(struct generic_pm_domain *genpd, bool timed)
>  {
>         unsigned int state_idx = genpd->state_idx;
> @@ -544,6 +560,22 @@ static int _genpd_power_on(struct generic_pm_domain *genpd, bool timed)
>         return ret;
>  }
>
> +static int genpd_power_off_pre(struct generic_pm_domain *genpd)
> +{
> +       if (!genpd->power_off_pre)
> +               return 0;
> +
> +       return genpd->power_off_pre(genpd);
> +}
> +
> +static int genpd_power_off_post(struct generic_pm_domain *genpd)
> +{
> +       if (!genpd->power_off_post)
> +               return 0;
> +
> +       return genpd->power_off_post(genpd);
> +}
> +
>  static int _genpd_power_off(struct generic_pm_domain *genpd, bool timed)
>  {
>         unsigned int state_idx = genpd->state_idx;
> @@ -816,12 +848,18 @@ static int genpd_dev_pm_qos_notifier(struct notifier_block *nb,
>  static void genpd_power_off_work_fn(struct work_struct *work)
>  {
>         struct generic_pm_domain *genpd;
> +       int ret;
>
>         genpd = container_of(work, struct generic_pm_domain, power_off_work);
>
> +       ret = genpd_power_off_pre(genpd);
> +       if (ret)
> +               return;
>         genpd_lock(genpd);
>         genpd_power_off(genpd, false, 0);
>         genpd_unlock(genpd);
> +       ret = genpd_power_off_post(genpd);
> +       WARN_ON_ONCE(ret);
>  }
>
>  /**
> @@ -938,12 +976,14 @@ static int genpd_runtime_suspend(struct device *dev)
>         if (irq_safe_dev_in_sleep_domain(dev, genpd))
>                 return 0;
>
> +       ret = genpd_power_off_pre(genpd);
> +       if (ret)
> +               return ret;
>         genpd_lock(genpd);
>         gpd_data->rpm_pstate = genpd_drop_performance_state(dev);
>         genpd_power_off(genpd, true, 0);
>         genpd_unlock(genpd);
> -
> -       return 0;
> +       return genpd_power_off_post(genpd);
>  }
>
>  /**
> @@ -977,12 +1017,21 @@ static int genpd_runtime_resume(struct device *dev)
>         if (irq_safe_dev_in_sleep_domain(dev, genpd))
>                 goto out;
>
> +       ret = genpd_power_pre_on(genpd);
> +       if (ret)
> +               return ret;
>         genpd_lock(genpd);
>         ret = genpd_power_on(genpd, 0);
>         if (!ret)
>                 genpd_restore_performance_state(dev, gpd_data->rpm_pstate);
>         genpd_unlock(genpd);
>
> +       if (ret) {
> +               genpd_power_post_on(genpd);
> +               return ret;
> +       }
> +
> +       ret = genpd_power_post_on(genpd);
>         if (ret)
>                 return ret;
>
> @@ -1017,10 +1066,13 @@ static int genpd_runtime_resume(struct device *dev)
>         genpd_stop_dev(genpd, dev);
>  err_poweroff:
>         if (!pm_runtime_is_irq_safe(dev) || genpd_is_irq_safe(genpd)) {
> -               genpd_lock(genpd);
> -               gpd_data->rpm_pstate = genpd_drop_performance_state(dev);
> -               genpd_power_off(genpd, true, 0);
> -               genpd_unlock(genpd);
> +               if (!genpd_power_off_pre(genpd)) {
> +                       genpd_lock(genpd);
> +                       gpd_data->rpm_pstate = genpd_drop_performance_state(dev);
> +                       genpd_power_off(genpd, true, 0);
> +                       genpd_unlock(genpd);
> +                       genpd_power_off_post(genpd);
> +               }
>         }
>
>         return ret;
> @@ -1225,12 +1277,14 @@ static int genpd_finish_suspend(struct device *dev, bool poweroff)
>                 }
>         }
>
> +       ret = genpd_power_off_pre(genpd);
> +       if (ret)
> +               return ret;
>         genpd_lock(genpd);
>         genpd->suspended_count++;
>         genpd_sync_power_off(genpd, true, 0);
>         genpd_unlock(genpd);
> -
> -       return 0;
> +       return genpd_power_off_post(genpd);
>  }
>
>  /**
> @@ -1267,10 +1321,16 @@ static int genpd_resume_noirq(struct device *dev)
>         if (device_wakeup_path(dev) && genpd_is_active_wakeup(genpd))
>                 return pm_generic_resume_noirq(dev);
>
> +       ret = genpd_power_pre_on(genpd);
> +       if (ret)
> +               return ret;
>         genpd_lock(genpd);
>         genpd_sync_power_on(genpd, true, 0);
>         genpd->suspended_count--;
>         genpd_unlock(genpd);
> +       ret = genpd_power_post_on(genpd);
> +       if (ret)
> +               return ret;
>
>         if (genpd->dev_ops.stop && genpd->dev_ops.start &&
>             !pm_runtime_status_suspended(dev)) {
> @@ -1378,6 +1438,9 @@ static int genpd_restore_noirq(struct device *dev)
>          * At this point suspended_count == 0 means we are being run for the
>          * first time for the given domain in the present cycle.
>          */
> +       ret = genpd_power_pre_on(genpd);
> +       if (ret)
> +               return ret;
>         genpd_lock(genpd);
>         if (genpd->suspended_count++ == 0) {
>                 /*
> @@ -1390,6 +1453,9 @@ static int genpd_restore_noirq(struct device *dev)
>
>         genpd_sync_power_on(genpd, true, 0);
>         genpd_unlock(genpd);
> +       ret = genpd_power_post_on(genpd);
> +       if (ret)
> +               return ret;
>
>         if (genpd->dev_ops.stop && genpd->dev_ops.start &&
>             !pm_runtime_status_suspended(dev)) {
> @@ -1413,6 +1479,7 @@ static int genpd_restore_noirq(struct device *dev)
>  static void genpd_complete(struct device *dev)
>  {
>         struct generic_pm_domain *genpd;
> +       int ret;
>
>         dev_dbg(dev, "%s()\n", __func__);
>
> @@ -1435,6 +1502,7 @@ static void genpd_switch_state(struct device *dev, bool suspend)
>  {
>         struct generic_pm_domain *genpd;
>         bool use_lock;
> +       int ret;
>
>         genpd = dev_to_genpd_safe(dev);
>         if (!genpd)
> @@ -1442,8 +1510,13 @@ static void genpd_switch_state(struct device *dev, bool suspend)
>
>         use_lock = genpd_is_irq_safe(genpd);
>
> -       if (use_lock)
> +       if (use_lock) {
> +               ret = suspend ? genpd_power_off_pre(genpd) :
> +                               genpd_power_pre_on(genpd);
> +               if (ret)
> +                       return;
>                 genpd_lock(genpd);
> +       }
>
>         if (suspend) {
>                 genpd->suspended_count++;
> @@ -1453,8 +1526,12 @@ static void genpd_switch_state(struct device *dev, bool suspend)
>                 genpd->suspended_count--;
>         }
>
> -       if (use_lock)
> +       if (use_lock) {
>                 genpd_unlock(genpd);
> +               ret = suspend ? genpd_power_off_post(genpd) :
> +                               genpd_power_post_on(genpd);
> +               WARN_ON_ONCE(ret);
> +       }
>  }
>
>  /**
> @@ -2750,9 +2827,15 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
>         dev->pm_domain->sync = genpd_dev_pm_sync;
>
>         if (power_on) {
> +               ret = genpd_power_pre_on(pd);
> +               if (ret)
> +                       return ret;
>                 genpd_lock(pd);
>                 ret = genpd_power_on(pd, 0);
>                 genpd_unlock(pd);
> +               ret = genpd_power_post_on(pd);
> +               if (ret)
> +                       return ret;
>         }
>
>         if (ret) {
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index ebc3516980907..3cf231a27cb1b 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -134,8 +134,12 @@ struct generic_pm_domain {
>         unsigned int prepared_count;    /* Suspend counter of prepared devices */
>         unsigned int performance_state; /* Aggregated max performance state */
>         cpumask_var_t cpus;             /* A cpumask of the attached CPUs */
> +       int (*power_off_pre)(struct generic_pm_domain *domain);
>         int (*power_off)(struct generic_pm_domain *domain);
> +       int (*power_off_post)(struct generic_pm_domain *domain);
> +       int (*power_pre_on)(struct generic_pm_domain *domain);
>         int (*power_on)(struct generic_pm_domain *domain);
> +       int (*power_post_on)(struct generic_pm_domain *domain);
>         struct raw_notifier_head power_notifiers; /* Power on/off notifiers */
>         struct opp_table *opp_table;    /* OPP table of the genpd */
>         unsigned int (*opp_to_performance_state)(struct generic_pm_domain *genpd,
> --
> 2.35.1
>

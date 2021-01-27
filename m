Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CADB305E81
	for <lists+linux-pm@lfdr.de>; Wed, 27 Jan 2021 15:42:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233803AbhA0Ol4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Jan 2021 09:41:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233825AbhA0OlT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Jan 2021 09:41:19 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B09D9C06178A
        for <linux-pm@vger.kernel.org>; Wed, 27 Jan 2021 06:40:39 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id c20so1964333ilj.13
        for <linux-pm@vger.kernel.org>; Wed, 27 Jan 2021 06:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jzwhiuIMgxXUYuu1Ru3vR7CYONoCsBdpX3AQaJbwxsw=;
        b=ZY3E8lP/MKmJdCZYqLk2azZ9DaDQohUKzrRiRAa1IoLhzzibImibXNS5OIW04VczPQ
         b60sCrNEBkJrzm7T/tua6PdZ/+p4g1U5F1Ev7tdMG4AGubr7jdWJuSy0mSWuaUK/Fl35
         CbDYXmNYX17kYsMfOeSnV2Pxokj6/GnvEiPQM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jzwhiuIMgxXUYuu1Ru3vR7CYONoCsBdpX3AQaJbwxsw=;
        b=ajDbUvgZIFPs1j/jtlsF0Ke0tEJJWW4w9mLTamY4x94f+UaOwq2dFPKUcDQmUs+igH
         fsy/V/PASxaabMlYlndgsgzHYLs5E5W35e23Vmo26IigCmFeYnPC7gSLLDpLTjs0A3vQ
         SmvCaNi6+Hfct3A3B1cAFPF9UeUkEqA613nTGO7C8iR8gqmE55P00BVcw9sZ59vhhiIJ
         wP6SMxCopKvtWlzbw49auHXBJuFyLKou2dXLcxljd2ElvFAW9tvfNfMsd27NBIo5vEX9
         TyVw3oYD0VCXmnDYHpDeo7Mr/wXOKSrJjNPnqsoJkw6usgeyfJA7HvlT5+iEhGEdcYKn
         VkPg==
X-Gm-Message-State: AOAM532b5XC0XrDzrDleKfJOv93nXMyLjkzi3wOlXgStB3hQQOWroPB+
        1krSU3+uMC4YJIvi4yure6eUJq6jGnZwCQIn8Kul3w==
X-Google-Smtp-Source: ABdhPJy9NOG/CaEPC9bcl3BpLFj7OTRg09Mxn1bT7aKsx8PvAdGRgM/uIySSSIspXv5uc768Ca4vLM/NHxvFIl1lkZ4=
X-Received: by 2002:a05:6e02:509:: with SMTP id d9mr9227482ils.150.1611758438854;
 Wed, 27 Jan 2021 06:40:38 -0800 (PST)
MIME-Version: 1.0
References: <20190717222340.137578-1-saravanak@google.com> <20190717222340.137578-4-saravanak@google.com>
 <20191125112812.26jk5hsdwqfnofc2@vireshk-i7> <20200127061118.5bxei6nghowlmf53@vireshk-i7>
 <b0be1275-c5cb-8171-58fa-64d65f60eaf8@codeaurora.org> <20200130042126.ahkik6ffb5vnzdim@vireshk-i7>
 <CAJMQK-gmO-tLZkRRxRdgU9eyfo95omw_RnffFVdhv2A6_9T-nQ@mail.gmail.com>
 <20210118073430.a6lr3ynkd2duv34l@vireshk-i7> <CAJMQK-j6EYjU1z_SUY4MFEJO6qTtOH7mQ_QWj2iUMewBKAghng@mail.gmail.com>
 <20210127115415.7zjpf6uaybwswno3@vireshk-i7>
In-Reply-To: <20210127115415.7zjpf6uaybwswno3@vireshk-i7>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Wed, 27 Jan 2021 22:40:12 +0800
Message-ID: <CAJMQK-hgeOv9XDasmmWGguxyC62SCsSoX5_enEb46whE8_Emew@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] OPP: Improve require-opps linking
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Sibi Sankar <sibis@codeaurora.org>,
        Saravana Kannan <saravanak@google.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Android Kernel Team <kernel-team@android.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jan 27, 2021 at 7:54 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 18-01-21, 15:39, Hsin-Yi Wang wrote:
> > Thanks. I can test this with the mt8183-cci series.
>
> Can you please give this a try ?
>
> Apply over:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/linux-next
>

Hi Viresh,

I tested this patch with devfreq passive governor[1] and mt8183
cci[2]. It's also working as expected.

[1] https://patchwork.kernel.org/project/linux-pm/cover/20190724014222.110767-1-saravanak@google.com/
(patch 2,4,5)
[2] https://patchwork.kernel.org/project/linux-mediatek/cover/1594348284-14199-1-git-send-email-andrew-sh.cheng@mediatek.com/

In my testing case, required_opp_table is not genpd case (mt8183 cci
is not genpd), so I remove the following constraint. Does that make
sense to you?

@@ -377,13 +377,6 @@ static void lazy_link_required_opp_table(struct
opp_table *new_table)
        struct dev_pm_opp *opp;
        int i, ret;

-       /*
-        * We only support genpd's OPPs in the "required-opps" for now,
-        * as we don't know much about other cases.
-        */
-       if (!new_table->is_genpd)
-               return;
-
        mutex_lock(&opp_table_lock);

Thanks.

Hsin-Yi
> -------------------------8<-------------------------
> Subject: [PATCH] opp: Allow lazy-linking of required-opps
>
> The OPP core currently requires the required opp tables to be available
> before the dependent OPP table is added, as it needs to create links
> from the dependent OPP table to the required ones. This may not be
> convenient for all the platforms though, as this requires strict
> ordering for probing the drivers.
>
> This patch allows lazy-linking of the required-opps. The OPP tables for
> which the required-opp-tables aren't available at the time of their
> initialization, are added to a special list of OPP tables:
> lazy_opp_tables. Later on, whenever a new OPP table is registered with
> the OPP core, we check if it is required by an OPP table in the pending
> list; if yes, then we complete the linking then and there.
>
> An OPP table is marked unusable until the time all its required-opp
> tables are available. And if lazy-linking fails for an OPP table, the
> OPP core disables all of its OPPs to make sure no one can use them.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/opp/core.c |  45 +++++++++++++----
>  drivers/opp/of.c   | 122 +++++++++++++++++++++++++++++++++++++++++++--
>  drivers/opp/opp.h  |  10 +++-
>  3 files changed, 161 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 7e4a51be5bb0..d886840628a0 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -27,6 +27,10 @@
>   * various states of availability.
>   */
>  LIST_HEAD(opp_tables);
> +
> +/* OPP tables with uninitialized required OPPs */
> +LIST_HEAD(lazy_opp_tables);
> +
>  /* Lock to allow exclusive modification to the device and opp lists */
>  DEFINE_MUTEX(opp_table_lock);
>  /* Flag indicating that opp_tables list is being updated at the moment */
> @@ -163,6 +167,10 @@ unsigned int dev_pm_opp_get_required_pstate(struct dev_pm_opp *opp,
>                 return 0;
>         }
>
> +       /* required-opps not fully initialized yet */
> +       if (lazy_linking_pending(opp->opp_table))
> +               return 0;
> +
>         return opp->required_opps[index]->pstate;
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_opp_get_required_pstate);
> @@ -885,6 +893,10 @@ static int _set_required_opps(struct device *dev,
>         if (!required_opp_tables)
>                 return 0;
>
> +       /* required-opps not fully initialized yet */
> +       if (lazy_linking_pending(opp_table))
> +               return -EBUSY;
> +
>         /* Single genpd case */
>         if (!genpd_virt_devs)
>                 return _set_required_opp(dev, dev, opp, 0);
> @@ -1182,6 +1194,7 @@ static struct opp_table *_allocate_opp_table(struct device *dev, int index,
>         mutex_init(&opp_table->lock);
>         mutex_init(&opp_table->genpd_virt_dev_lock);
>         INIT_LIST_HEAD(&opp_table->dev_list);
> +       INIT_LIST_HEAD(&opp_table->lazy);
>
>         /* Mark regulator count uninitialized */
>         opp_table->regulator_count = -1;
> @@ -1623,6 +1636,21 @@ static int _opp_is_duplicate(struct device *dev, struct dev_pm_opp *new_opp,
>         return 0;
>  }
>
> +void _opp_required_opps_available(struct dev_pm_opp *opp, int count)
> +{
> +       int i;
> +
> +       for (i = 0; i < count; i++) {
> +               if (opp->required_opps[i]->available)
> +                       continue;
> +
> +               opp->available = false;
> +               pr_warn("%s: OPP not supported by required OPP %pOF (%lu)\n",
> +                        __func__, opp->required_opps[i]->np, opp->rate);
> +               return;
> +       }
> +}
> +
>  /*
>   * Returns:
>   * 0: On success. And appropriate error message for duplicate OPPs.
> @@ -1637,7 +1665,6 @@ int _opp_add(struct device *dev, struct dev_pm_opp *new_opp,
>              struct opp_table *opp_table, bool rate_not_available)
>  {
>         struct list_head *head;
> -       unsigned int i;
>         int ret;
>
>         mutex_lock(&opp_table->lock);
> @@ -1663,15 +1690,11 @@ int _opp_add(struct device *dev, struct dev_pm_opp *new_opp,
>                          __func__, new_opp->rate);
>         }
>
> -       for (i = 0; i < opp_table->required_opp_count; i++) {
> -               if (new_opp->required_opps[i]->available)
> -                       continue;
> +       /* required-opps not fully initialized yet */
> +       if (lazy_linking_pending(opp_table))
> +               return 0;
>
> -               new_opp->available = false;
> -               dev_warn(dev, "%s: OPP not supported by required OPP %pOF (%lu)\n",
> -                        __func__, new_opp->required_opps[i]->np, new_opp->rate);
> -               break;
> -       }
> +       _opp_required_opps_available(new_opp, opp_table->required_opp_count);
>
>         return 0;
>  }
> @@ -2377,6 +2400,10 @@ int dev_pm_opp_xlate_performance_state(struct opp_table *src_table,
>         if (!src_table || !src_table->required_opp_count)
>                 return pstate;
>
> +       /* required-opps not fully initialized yet */
> +       if (lazy_linking_pending(src_table))
> +               return -EBUSY;
> +
>         for (i = 0; i < src_table->required_opp_count; i++) {
>                 if (src_table->required_opp_tables[i]->np == dst_table->np)
>                         break;
> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> index 20ccdaab9384..31ac55714b57 100644
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -144,7 +144,7 @@ static void _opp_table_free_required_tables(struct opp_table *opp_table)
>
>         for (i = 0; i < opp_table->required_opp_count; i++) {
>                 if (IS_ERR_OR_NULL(required_opp_tables[i]))
> -                       break;
> +                       continue;
>
>                 dev_pm_opp_put_opp_table(required_opp_tables[i]);
>         }
> @@ -153,6 +153,7 @@ static void _opp_table_free_required_tables(struct opp_table *opp_table)
>
>         opp_table->required_opp_count = 0;
>         opp_table->required_opp_tables = NULL;
> +       list_del(&opp_table->lazy);
>  }
>
>  /*
> @@ -165,6 +166,7 @@ static void _opp_table_alloc_required_tables(struct opp_table *opp_table,
>  {
>         struct opp_table **required_opp_tables;
>         struct device_node *required_np, *np;
> +       bool lazy = false;
>         int count, i;
>
>         /* Traversing the first OPP node is all we need */
> @@ -195,8 +197,10 @@ static void _opp_table_alloc_required_tables(struct opp_table *opp_table,
>                 required_opp_tables[i] = _find_table_of_opp_np(required_np);
>                 of_node_put(required_np);
>
> -               if (IS_ERR(required_opp_tables[i]))
> -                       goto free_required_tables;
> +               if (IS_ERR(required_opp_tables[i])) {
> +                       lazy = true;
> +                       continue;
> +               }
>
>                 /*
>                  * We only support genpd's OPPs in the "required-opps" for now,
> @@ -210,6 +214,10 @@ static void _opp_table_alloc_required_tables(struct opp_table *opp_table,
>                 }
>         }
>
> +       /* Let's do the linking later on */
> +       if (lazy)
> +               list_add(&opp_table->lazy, &lazy_opp_tables);
> +
>         goto put_np;
>
>  free_required_tables:
> @@ -278,14 +286,14 @@ void _of_opp_free_required_opps(struct opp_table *opp_table,
>
>         for (i = 0; i < opp_table->required_opp_count; i++) {
>                 if (!required_opps[i])
> -                       break;
> +                       continue;
>
>                 /* Put the reference back */
>                 dev_pm_opp_put(required_opps[i]);
>         }
>
> -       kfree(required_opps);
>         opp->required_opps = NULL;
> +       kfree(required_opps);
>  }
>
>  /* Populate all required OPPs which are part of "required-opps" list */
> @@ -309,6 +317,10 @@ static int _of_opp_alloc_required_opps(struct opp_table *opp_table,
>         for (i = 0; i < count; i++) {
>                 required_table = opp_table->required_opp_tables[i];
>
> +               /* Required table not added yet, we will link later */
> +               if (IS_ERR_OR_NULL(required_table))
> +                       continue;
> +
>                 np = of_parse_required_opp(opp->np, i);
>                 if (unlikely(!np)) {
>                         ret = -ENODEV;
> @@ -334,6 +346,104 @@ static int _of_opp_alloc_required_opps(struct opp_table *opp_table,
>         return ret;
>  }
>
> +/* Link required OPPs for an individual OPP */
> +static int lazy_link_required_opps(struct opp_table *opp_table,
> +                                  struct opp_table *new_table, int index)
> +{
> +       struct device_node *required_np;
> +       struct dev_pm_opp *opp;
> +
> +       list_for_each_entry(opp, &opp_table->opp_list, node) {
> +               required_np = of_parse_required_opp(opp->np, index);
> +               if (unlikely(!required_np))
> +                       return -ENODEV;
> +
> +               opp->required_opps[index] = _find_opp_of_np(new_table, required_np);
> +               of_node_put(required_np);
> +
> +               if (!opp->required_opps[index]) {
> +                       pr_err("%s: Unable to find required OPP node: %pOF (%d)\n",
> +                              __func__, opp->np, index);
> +                       return -ENODEV;
> +               }
> +       }
> +
> +       return 0;
> +}
> +
> +/* Link required OPPs for all OPPs of the newly added OPP table */
> +static void lazy_link_required_opp_table(struct opp_table *new_table)
> +{
> +       struct opp_table *opp_table, *temp, **required_opp_tables;
> +       struct device_node *required_np, *opp_np, *required_table_np;
> +       struct dev_pm_opp *opp;
> +       int i, ret;
> +
> +       /*
> +        * We only support genpd's OPPs in the "required-opps" for now,
> +        * as we don't know much about other cases.
> +        */
> +       if (!new_table->is_genpd)
> +               return;
> +
> +       mutex_lock(&opp_table_lock);
> +
> +       list_for_each_entry_safe(opp_table, temp, &lazy_opp_tables, lazy) {
> +               bool lazy = false;
> +
> +               /* opp_np can't be invalid here */
> +               opp_np = of_get_next_available_child(opp_table->np, NULL);
> +
> +               for (i = 0; i < opp_table->required_opp_count; i++) {
> +                       required_opp_tables = opp_table->required_opp_tables;
> +
> +                       /* Required opp-table is already parsed */
> +                       if (!IS_ERR(required_opp_tables[i]))
> +                               continue;
> +
> +                       /* required_np can't be invalid here */
> +                       required_np = of_parse_required_opp(opp_np, i);
> +                       required_table_np = of_get_parent(required_np);
> +
> +                       of_node_put(required_table_np);
> +                       of_node_put(required_np);
> +
> +                       /*
> +                        * Newly added table isn't the required opp-table for
> +                        * opp_table.
> +                        */
> +                       if (required_table_np != new_table->np) {
> +                               lazy = true;
> +                               continue;
> +                       }
> +
> +                       required_opp_tables[i] = new_table;
> +                       _get_opp_table_kref(new_table);
> +
> +                       /* Link OPPs now */
> +                       ret = lazy_link_required_opps(opp_table, new_table, i);
> +                       if (ret) {
> +                               /* The OPPs will be marked unusable */
> +                               lazy = false;
> +                               break;
> +                       }
> +               }
> +
> +               of_node_put(opp_np);
> +
> +               /* All required opp-tables found, remove from lazy list */
> +               if (!lazy) {
> +                       list_del(&opp_table->lazy);
> +                       INIT_LIST_HEAD(&opp_table->lazy);
> +
> +                       list_for_each_entry(opp, &opp_table->opp_list, node)
> +                               _opp_required_opps_available(opp, opp_table->required_opp_count);
> +               }
> +       }
> +
> +       mutex_unlock(&opp_table_lock);
> +}
> +
>  static int _bandwidth_supported(struct device *dev, struct opp_table *opp_table)
>  {
>         struct device_node *np, *opp_np;
> @@ -889,6 +999,8 @@ static int _of_add_opp_table_v2(struct device *dev, struct opp_table *opp_table)
>                 }
>         }
>
> +       lazy_link_required_opp_table(opp_table);
> +
>         return 0;
>
>  remove_static_opp:
> diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
> index 734df1f764ec..a5a10b685bf7 100644
> --- a/drivers/opp/opp.h
> +++ b/drivers/opp/opp.h
> @@ -26,7 +26,7 @@ struct regulator;
>  /* Lock to allow exclusive modification to the device and opp lists */
>  extern struct mutex opp_table_lock;
>
> -extern struct list_head opp_tables;
> +extern struct list_head opp_tables, lazy_opp_tables;
>
>  /*
>   * Internal data structure organization with the OPP layer library is as
> @@ -168,7 +168,7 @@ enum opp_table_access {
>   * meant for book keeping and private to OPP library.
>   */
>  struct opp_table {
> -       struct list_head node;
> +       struct list_head node, lazy;
>
>         struct blocking_notifier_head head;
>         struct list_head dev_list;
> @@ -230,6 +230,12 @@ void _dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask, int last_cp
>  struct opp_table *_add_opp_table(struct device *dev);
>  struct opp_table *_add_opp_table_indexed(struct device *dev, int index, bool getclk);
>  void _put_opp_list_kref(struct opp_table *opp_table);
> +void _opp_required_opps_available(struct dev_pm_opp *opp, int count);
> +
> +static inline bool lazy_linking_pending(struct opp_table *opp_table)
> +{
> +       return unlikely(!list_empty(&opp_table->lazy));
> +}
>
>  #ifdef CONFIG_OF
>  void _of_init_opp_table(struct opp_table *opp_table, struct device *dev, int index);
>
> --
> viresh

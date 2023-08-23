Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20DDB785D27
	for <lists+linux-pm@lfdr.de>; Wed, 23 Aug 2023 18:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbjHWQXj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Aug 2023 12:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237513AbjHWQXf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Aug 2023 12:23:35 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD010E78
        for <linux-pm@vger.kernel.org>; Wed, 23 Aug 2023 09:23:32 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-d71c3a32e1aso5413367276.3
        for <linux-pm@vger.kernel.org>; Wed, 23 Aug 2023 09:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692807812; x=1693412612;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IgMNT86Z22z96gO4xCO8LycBD/jTwX067iwUZoTggXM=;
        b=BWtiyn5gO067QLvIGZTse69sez5QCtvbR0aydCcDJWL8Uwqv5tHx95JR2FdQbyvUe/
         xt4J8A3RJr60cDXCZLvr4jeocqgXlbYDqCpT1R4cAeEBq8P/fOeCPe/6RmupyHdHvEMe
         bmett1gsb+p/ydy+Da1M+DBF/yLFgjGHO18KZyJ7tY4snmPXt0C8BFXBHalX86Rig/S4
         ueyvvJ2rnAI3u/DidTaW830939C1WCKvB2BtcoY7Vk/LJGkNagFLXUhEIwZfHbPMHMIK
         wPqssjcD9OkupMyqcl4UajRD6SK2eaHuHhIveBGVyWGLGUy8Wuh4Fjr7uke1Rb8gnnRr
         6ooA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692807812; x=1693412612;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IgMNT86Z22z96gO4xCO8LycBD/jTwX067iwUZoTggXM=;
        b=RPJTEdqnYACTYNTf/ZVpyp8wCYXX4lTwCTrXsRmxLhFEjUkJuXbFYXK0BW4huQuBw5
         muQgiCSe7J0FXcnvfNV/Z6PWz4ldJ+ah/SQjXLQ3DZy4c2enPr3P/DjoSyamozZWpP+S
         YZsdqqNX94gB9JOp84zfUBUfBJk+wzxiGkrLt6Y3/5rDW4pZYlULtk4hRMQbtINYqf8e
         i8n0VbV3QytwTUmEdQvp3LQXz8nzPyKEK9JUk459IzQTwmkL0oVUQceXXVuCvJCMv0Dn
         RHzuh5Uvj1xRW4PP/1fKS8CChfzhKb4Vl3jQnzFKXhuwwLAKR2Q5eQP2bQHvUZ/GKryl
         46RQ==
X-Gm-Message-State: AOJu0Yy7Ec+A03gIzS/ePpVAjAx3qPxDXuBaxJ3oSriPxI7pzreguDyC
        YlLgxZjGO1Tfx0Bt5jXO+G1zzobLG+6IFbaclqBrrg==
X-Google-Smtp-Source: AGHT+IHrwdAEA9WB5CPmo1YyH9mp4YcDQYwNVRCOBHYhovobWQ9KoftGQ4a4Zbj5o9UxCsssXYzfoBS2rjusfEq3JcI=
X-Received: by 2002:a25:34d5:0:b0:d4c:6b49:fed7 with SMTP id
 b204-20020a2534d5000000b00d4c6b49fed7mr12564508yba.45.1692807812039; Wed, 23
 Aug 2023 09:23:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230823114528.3677667-1-abel.vesa@linaro.org> <20230823114528.3677667-3-abel.vesa@linaro.org>
In-Reply-To: <20230823114528.3677667-3-abel.vesa@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 23 Aug 2023 18:22:55 +0200
Message-ID: <CAPDyKFreStawBf-2txj=ZL0jA0N-Cd22J1Y6u-3H0nJttzKw8Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] PM: domains: Add the domain HW-managed mode to the summary
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <tdas@qti.qualcomm.com>, linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, Taniya Das <quic_tdas@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 23 Aug 2023 at 13:45, Abel Vesa <abel.vesa@linaro.org> wrote:
>
> Now that genpd supports dynamically switching the control for an
> attached device between hardware- and software-mode,  let's add this
> information to the genpd summary in debugfs.
>
> Suggested-by: Taniya Das <quic_tdas@quicinc.com>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>
> Changes since v2:
>  * Reworded the commit according to Ulf's suggestion
>  * Dropped the _mode suffix from the status
>  * Replaced "mode" with "managed by" in summary show function
>
>  drivers/base/power/domain.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index dfb4f1de540d..93350e67b0e8 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -3171,6 +3171,15 @@ static void rtpm_status_str(struct seq_file *s, struct device *dev)
>         seq_printf(s, "%-25s  ", p);
>  }
>
> +static void mode_status_str(struct seq_file *s, struct device *dev)
> +{
> +       struct generic_pm_domain_data *gpd_data;
> +
> +       gpd_data = to_gpd_data(dev->power.subsys_data->domain_data);
> +
> +       seq_printf(s, "%20s", gpd_data->hw_mode ? "HW" : "SW");
> +}
> +
>  static void perf_status_str(struct seq_file *s, struct device *dev)
>  {
>         struct generic_pm_domain_data *gpd_data;
> @@ -3229,6 +3238,7 @@ static int genpd_summary_one(struct seq_file *s,
>                 seq_printf(s, "\n    %-50s  ", kobj_path);
>                 rtpm_status_str(s, pm_data->dev);
>                 perf_status_str(s, pm_data->dev);
> +               mode_status_str(s, pm_data->dev);
>                 kfree(kobj_path);
>         }
>
> @@ -3245,8 +3255,9 @@ static int summary_show(struct seq_file *s, void *data)
>         int ret = 0;
>
>         seq_puts(s, "domain                          status          children                           performance\n");
> -       seq_puts(s, "    /device                                             runtime status\n");
> -       seq_puts(s, "----------------------------------------------------------------------------------------------\n");
> +       seq_puts(s, "    /device                                             runtime status                           managed by\n");
> +       seq_puts(s, "------------------------------------------------------------------------------------------------------------\n");
> +
>
>         ret = mutex_lock_interruptible(&gpd_list_lock);
>         if (ret)
> --
> 2.34.1
>

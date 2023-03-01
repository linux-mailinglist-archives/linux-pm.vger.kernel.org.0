Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA96C6A6CCD
	for <lists+linux-pm@lfdr.de>; Wed,  1 Mar 2023 14:04:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjCAND7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Mar 2023 08:03:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbjCANDq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Mar 2023 08:03:46 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07FC42CC5A
        for <linux-pm@vger.kernel.org>; Wed,  1 Mar 2023 05:03:41 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id 132so7616704pgh.13
        for <linux-pm@vger.kernel.org>; Wed, 01 Mar 2023 05:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iKkN3A4Osh2piEOGCkx6fyCR8EN+P86mMCpSI/kyzzM=;
        b=EQmQxWTOKwHqRHus1aXRnQewm7/Cipj0WZQz7Po6IiqxAiW/mub5DoifHi54nrvrf8
         hiMolYN0tBtBLhD948M8W99tJW0ou7nbDdedbB4U8Jr/dJIXgfVsxCx+dBG1cRoMEF50
         mTq20H2qTTNhsan8908we4nNMWkZdVtuQxdjeSuxbJhcU5vLs4p0FNqvCPlRfYob3LfB
         tPcdbUfdqmwbk0yXDytTSjtTflPRqPACp2TStavR+wk8Fu9kJC/doIGZzpLnxWGgBI8e
         mqQqIoWnKyTGdLQtLBOFSeJzYYRcmFr/kiN1ubdavI2FxlH+Qknz2hNJ735Pn2zx38Ho
         4VfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iKkN3A4Osh2piEOGCkx6fyCR8EN+P86mMCpSI/kyzzM=;
        b=pXGbsjD8nGHWp2GxKDe/Up2h9Oy9I8hhTCg3T7HPu4+WLoP16C7p7Nf8/LoylBN6UK
         rMKO6/QGR5yomYMMfQ7QkX99l8QHS+mTvLgNBoRQncxAY4a3WHu35mPxLL1f4+YnLE6/
         +LG8xs0fsb172HlVpbe1AgPGbNDOAXLvp4H8Fa1rjsN5efhti0kzSQTCmdHacE86jzqY
         mMCbdtGIlJLD9fVfAFdtKBOiiJwkLroWKzWz9yyl5OXFbQOZYBYMStudbzxRnh8KCcUO
         ZXVKKLXg8ZXQQTdWHcPq5fZo3TsAcAsG7+2CURn1GHiilj+PsyDaUnPfAd4VEbU9MLqi
         xEEA==
X-Gm-Message-State: AO0yUKWZ57gOVTBlcqxZ9pke6Efu/npcxQGkFbKQmTOqEnONF7yTqR2c
        SSAY1umbjdFDsAoxZi9yU88gzlKkwJg54Ug7uS5C2Q==
X-Google-Smtp-Source: AK7set9l3A8Q13trFL4jc5C5g/OPP+o5cpBA5yb/8XU8e+NCPo/IhTJiHt2k5ezR6UfWLUYRTV/o/fbvHtLZeQatQnA=
X-Received: by 2002:aa7:88c8:0:b0:5a9:d579:6902 with SMTP id
 k8-20020aa788c8000000b005a9d5796902mr4266652pff.0.1677675821355; Wed, 01 Mar
 2023 05:03:41 -0800 (PST)
MIME-Version: 1.0
References: <cover.1677063656.git.viresh.kumar@linaro.org> <8f9fba47f91ef04fa2cf0c3adba9299a23d5280a.1677063656.git.viresh.kumar@linaro.org>
In-Reply-To: <8f9fba47f91ef04fa2cf0c3adba9299a23d5280a.1677063656.git.viresh.kumar@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 1 Mar 2023 14:03:05 +0100
Message-ID: <CAPDyKFroDPdUq+QT18svWfHShSGkNuOeVmT2oyMO89CzSyY+Yg@mail.gmail.com>
Subject: Re: [PATCH 1/3] OPP: Handle all genpd cases together in _set_required_opps()
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Jun Nie <jun.nie@linaro.org>, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 22 Feb 2023 at 12:07, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> There is no real need of keeping separate code for single genpd case, it
> can be made to work with a simple change.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/opp/core.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index e87567dbe99f..6d7016ce8c53 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -959,7 +959,8 @@ static int _set_required_opps(struct device *dev,
>                               struct dev_pm_opp *opp, bool up)
>  {
>         struct opp_table **required_opp_tables = opp_table->required_opp_tables;
> -       struct device **genpd_virt_devs = opp_table->genpd_virt_devs;
> +       struct device **genpd_virt_devs =
> +               opp_table->genpd_virt_devs ? opp_table->genpd_virt_devs : &dev;
>         int i, ret = 0;
>
>         if (!required_opp_tables)
> @@ -979,12 +980,6 @@ static int _set_required_opps(struct device *dev,
>                 return -ENOENT;
>         }
>
> -       /* Single genpd case */
> -       if (!genpd_virt_devs)
> -               return _set_required_opp(dev, dev, opp, 0);
> -
> -       /* Multiple genpd case */
> -
>         /*
>          * Acquire genpd_virt_dev_lock to make sure we don't use a genpd_dev
>          * after it is freed from another thread.
> --
> 2.31.1.272.g89b43f80a514
>

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4C22FE8C9
	for <lists+linux-pm@lfdr.de>; Thu, 21 Jan 2021 12:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbhAUL3g (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Jan 2021 06:29:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbhAUL33 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Jan 2021 06:29:29 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B94C061757
        for <linux-pm@vger.kernel.org>; Thu, 21 Jan 2021 03:28:48 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id m6so1337405pfk.1
        for <linux-pm@vger.kernel.org>; Thu, 21 Jan 2021 03:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=huY+KC/gEp573SNNBNWHPTaHjdoKETtT7Ro68K+8opY=;
        b=MGR0m11onGFZ3r3ghkbbbbafSIuaMZIlX9t609QHVCmqOM9IrDgBVV+RnzWxZ9c8cM
         l9DxSqjnLAkV02i/0SrvQFkarzl4z5EFCq8lVgYZGZfk2V+2x3marPii5hO6sZcrhEDE
         IMmQzQKK3XCcsI08zKtaoVyohc4oEomnA3eZ0WwM89z3qSA/oJOVh9BD1ATcSWBPOY2b
         j2EoqGNwSbCb6yMtQVxAh7TkBVo3QaVvXEtmMIlt30QvyD0boYqeqQofXptmxdKb7e/A
         ZPj1xaXEtc2neQqwCB+PYdG5qz/nQW4DJSFfTo/IafeOV7K5yU6gzK58SbP6fe13a0Xu
         f/Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=huY+KC/gEp573SNNBNWHPTaHjdoKETtT7Ro68K+8opY=;
        b=W3pQtGt6PfjttB18t3ww3SMneaXUHRBBKJFzlljR3khjke7YIXln/jZAm8orEhOJhp
         Ky8ngPqRwQcrkN/Uo9BR6MW520A0NMHfAA4RBb5v8w9JnGErqJld6BsZhOp+xIwS62sc
         7CBHmR9xqJV+f1jVK1reMMiqWV8jDAeiyeNyqcW1gf+z0RN+buNCM47M0kv8XaPjjvx7
         JIumBLBmQ4iXetdy912hX4ipncA7ztbXgpGrRbwjMnKVwS0QAFkgKv6FynQgJZSU2fc4
         ibi0NByno7jhjbtLKM/GQyKpTlwcF32oSy5aRd4NUUUyl8qHmrjzU9SUz6wv9bRi2Hot
         lGaQ==
X-Gm-Message-State: AOAM532Oin6CBMSSSxhgJWsdjyRdi87FYGs386acD/ef5vz6pRgQkdmE
        NL370RtkWjH0Fd7EMIJnDI/7AQ==
X-Google-Smtp-Source: ABdhPJyZ9MJX8Kwm8tbNkiRPLk2ZzY0XdKZs5UhqqTMRIitX1Fef5dEki6ICReP6VfFb9ivRgaD8Zg==
X-Received: by 2002:aa7:8b51:0:b029:1ae:687f:d39b with SMTP id i17-20020aa78b510000b02901ae687fd39bmr13557158pfd.50.1611228528086;
        Thu, 21 Jan 2021 03:28:48 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id y11sm3425797pfo.121.2021.01.21.03.28.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jan 2021 03:28:47 -0800 (PST)
Date:   Thu, 21 Jan 2021 16:58:45 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] opp: Prepare for ->set_opp() helper to work without
 regulators
Message-ID: <20210121112845.hq5ry6mdbvuglg6e@vireshk-i7>
References: <fb69353c-a35b-9b7c-46bc-d464c6dab6f5@gmail.com>
 <302c014726dbd9fcde852985528c139d2214a1f2.1611038066.git.viresh.kumar@linaro.org>
 <20210120080833.bw4c5bh2wntmiaqi@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210120080833.bw4c5bh2wntmiaqi@vireshk-i7>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 20-01-21, 13:38, Viresh Kumar wrote:
> On 19-01-21, 12:05, Viresh Kumar wrote:
> > Until now the ->set_opp() helper (i.e. special implementation for
> > setting the OPPs for platforms) was implemented only to take care of
> > multiple regulators case, but going forward we would need that for other
> > use cases as well.
> > 
> > This patch prepares for that by allocating the regulator specific part
> > from dev_pm_opp_set_regulators() and the opp helper part from
> > dev_pm_opp_register_set_opp_helper().
> > 
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> > Dmitry,
> > 
> > I haven't tested this patch, can you please help with that ?
> > 
> >  drivers/opp/core.c | 81 ++++++++++++++++++++++++----------------------
> >  drivers/opp/opp.h  |  2 ++
> >  2 files changed, 45 insertions(+), 38 deletions(-)
> 
> Pushed with this diff.
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 1ed673334565..1dc5ca3f6d26 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -1939,7 +1939,6 @@ struct opp_table *dev_pm_opp_set_regulators(struct device *dev,
>                                             unsigned int count)
>  {
>         struct dev_pm_opp_supply *supplies;
> -       struct dev_pm_set_opp_data *data;
>         struct opp_table *opp_table;
>         struct regulator *reg;
>         int ret, i;
> @@ -1990,9 +1989,8 @@ struct opp_table *dev_pm_opp_set_regulators(struct device *dev,
>         mutex_lock(&opp_table->lock);
>         opp_table->sod_supplies = supplies;
>         if (opp_table->set_opp_data) {
> -               data = opp_table->set_opp_data;
> -               data->old_opp.supplies = supplies;
> -               data->new_opp.supplies = supplies + count;
> +               opp_table->set_opp_data->old_opp.supplies = supplies;
> +               opp_table->set_opp_data->new_opp.supplies = supplies + count;
>         }
>         mutex_unlock(&opp_table->lock);
>  
> @@ -2038,7 +2036,7 @@ void dev_pm_opp_put_regulators(struct opp_table *opp_table)
>                 regulator_put(opp_table->regulators[i]);
>  
>         mutex_lock(&opp_table->lock);
> -       if (opp_table->sod_supplies) {
> +       if (opp_table->set_opp_data) {
>                 opp_table->set_opp_data->old_opp.supplies = NULL;
>                 opp_table->set_opp_data->new_opp.supplies = NULL;
>         }

And some more as pointed out by Dmitry (I will resend it again
properly).

t a/drivers/opp/core.c b/drivers/opp/core.c
index d8ca15d96ce9..747bdc4338f3 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -2118,8 +2118,12 @@ void dev_pm_opp_unregister_set_opp_helper(struct opp_table *opp_table)
        WARN_ON(!list_empty(&opp_table->opp_list));
 
        opp_table->set_opp = NULL;
+
+       mutex_lock(&opp_table->lock);
        kfree(opp_table->set_opp_data);
        opp_table->set_opp_data = NULL;
+       mutex_unlock(&opp_table->lock);
+
        dev_pm_opp_put_opp_table(opp_table);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_unregister_set_opp_helper);

-- 
viresh

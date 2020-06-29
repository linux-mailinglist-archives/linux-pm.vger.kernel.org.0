Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B51F720E20E
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jun 2020 00:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390053AbgF2VCJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Jun 2020 17:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731148AbgF2TMv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Jun 2020 15:12:51 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924DFC014AA5
        for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2020 01:05:16 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id j18so14448079wmi.3
        for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2020 01:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5+hczelMMEDbYcHP5+CW5lQUh+iqmRD+aRAJuSk8CxM=;
        b=uGXdcKt0pHO/pN/1e1d6qjxm6dypuBJxXYRvEDVJpohbWz0nM3+E0h2zX19UjPTDJT
         /TUbDJkiNOZdbwZfrECDpJW5FBCvhNuLpD8BwD1Yd+fp+lBP4iODaZJxq6IaS4XkeiIM
         xV6HwIgYOETVk8DEQy7tRQuOSAjBKL9Y4EmcnT1soTsMJDWuonlBeqo23WJSnrlCbREa
         7PUtod/r12dmFpz1eTNc5ZYslMpGhvZiXtOepOO2ld9AbC+qtNFtB9Kozz8wjHYtLzuu
         KPgEFHYSO9twXbF5nASFfCOLAXf6qhdYQjt5FbVZBB5uFhg0BeZngnyKJ9/q3fHxRsW9
         O+7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5+hczelMMEDbYcHP5+CW5lQUh+iqmRD+aRAJuSk8CxM=;
        b=FTDG6pKT1QDg9C32KxpVLr40hihR5sr/7Vz+ziemfYOLjuWp7IvGYHW4tsEH9EcWVL
         82V7sswqu8ehiFQTvdiypLDX1McoGJq3JLKF6/Dh37sOjnwud7VECnG5gyMgLFYQPxnZ
         EpMoHdxISgDKckJtorcyRQ6recB4apWwn0qSB5nkQ58GXNI7usZHT7XawUmuXdGVeOTq
         mkDl3tmt0Y6h6LZFr9wPSrot+OOQKZwxnBWp3btzu15sqPFg7YqH4JisGWeNA98OWh2S
         diE/5Hxjj6tJABEKn/SNOHbKLC4nf48Nc0SWzjSXp3nJkEMPtoNk4UVvQ/J0cr6qTTDn
         HW1g==
X-Gm-Message-State: AOAM532biveqvyUT3GIbRFNsFjE98ZFFPAnmG+mh4qTlUwQ9CwSwyvUY
        51EbLyWq4dcK6NGqY87AKnNOtQ==
X-Google-Smtp-Source: ABdhPJxzGmtYixvHk5OQIS11ERm+5ABmfFXTzChdfi8AO/NDYvXEPyeBiFluSdHDuoghA2KTZOI0yQ==
X-Received: by 2002:a1c:a7c4:: with SMTP id q187mr15114921wme.0.1593417915196;
        Mon, 29 Jun 2020 01:05:15 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id y16sm47498532wro.71.2020.06.29.01.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 01:05:14 -0700 (PDT)
Date:   Mon, 29 Jun 2020 09:05:11 +0100
From:   Quentin Perret <qperret@google.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        kernel-team@android.com, tkjos@google.com, adharmap@codeaurora.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 1/3] cpufreq: Fix locking issues with governors
Message-ID: <20200629080511.GB1217385@google.com>
References: <cover.1593143118.git.viresh.kumar@linaro.org>
 <f366ed3dd3dd111e42173b366fe4dd5a0e4647fd.1593143118.git.viresh.kumar@linaro.org>
 <20200626082433.GA284605@google.com>
 <20200629021309.eleyysuh5f5g52qw@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629021309.eleyysuh5f5g52qw@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Monday 29 Jun 2020 at 07:43:09 (+0530), Viresh Kumar wrote:
> I described why I chose to keep it that way in the other email, but I
> am all for dropping the variable. And so what about this ?
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index e798a1193bdf..d9e9ae7051bb 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1064,18 +1064,17 @@ static int cpufreq_init_policy(struct cpufreq_policy *policy)
>         struct cpufreq_governor *def_gov = cpufreq_default_governor();
>         struct cpufreq_governor *gov = NULL;
>         unsigned int pol = CPUFREQ_POLICY_UNKNOWN;
> -       bool put_governor = false;
>         int ret;
>  
>         if (has_target()) {
>                 /* Update policy governor to the one used before hotplug. */
>                 gov = get_governor(policy->last_governor);
>                 if (gov) {
> -                       put_governor = true;
>                         pr_debug("Restoring governor %s for cpu %d\n",
>                                  policy->governor->name, policy->cpu);
>                 } else if (def_gov) {
>                         gov = def_gov;
> +                       module_get(gov->owner);
>                 } else {
>                         return -ENODATA;
>                 }
> @@ -1099,7 +1098,7 @@ static int cpufreq_init_policy(struct cpufreq_policy *policy)
>         }
>  
>         ret = cpufreq_set_policy(policy, gov, pol);
> -       if (put_governor)
> +       if (gov)
>                 module_put(gov->owner);
>  
>         return ret;

Right, I guess this is a good trade-off, so that works for me.

Thanks,
Quentin

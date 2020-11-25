Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4195B2C415F
	for <lists+linux-pm@lfdr.de>; Wed, 25 Nov 2020 14:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725875AbgKYNtk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Nov 2020 08:49:40 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42861 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727626AbgKYNtk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Nov 2020 08:49:40 -0500
Received: by mail-ot1-f67.google.com with SMTP id 11so2239571oty.9;
        Wed, 25 Nov 2020 05:49:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IoB39l7/Alku48XvRUqPTRybG7CsyQ69DBTAGxbwHjw=;
        b=SP+O3utneY1PIysIp+cjXgAfYj2bjY4kVXUNzE18nD5NC7yTDU8IbIiTWc2kPI7tK5
         VhoDyqAx+MTjwjlXvGz4Mp7epQ0WU1ToBsddhgQklJRu9/7L90AzhVvAfthhzrFIthQL
         yNUvF3LuM7zZP+gpqTNVlju49H4MHwNeWX3T+mWdZh8CVmxGvPesSPSBaunmAldNa7oV
         pnrhYIwh9ey2VxudNplP1KgGZIN7Llo0Euj0mZkVL+kguqYU/616RrHh+AE5zc50LW5d
         SKdUlKZxJ1trt0CBinPDQ09qOS8/cKFWKm4c68EGbwxETD8NjEZi9v2L2hCXM9IGejvJ
         iGBQ==
X-Gm-Message-State: AOAM532eRJXPiIBuM84HQq97dQtW96HQnUsoePmoeSLy8fEpiPa+zTA8
        vJDhILLI8y/9FJ/FChzgO77FMmxZb8mpYbXDI3k=
X-Google-Smtp-Source: ABdhPJw5w/2J41GdEDwUgKSmvns2TIZoyK0IwuxNVT1RyPUt20JeQhWEjP6HDAicqNH+QQlJ9FiRn2TN427DKLaQF5g=
X-Received: by 2002:a9d:171a:: with SMTP id i26mr2881261ota.260.1606312166377;
 Wed, 25 Nov 2020 05:49:26 -0800 (PST)
MIME-Version: 1.0
References: <20201125124853.30470-1-bobo.shaobowang@huawei.com>
In-Reply-To: <20201125124853.30470-1-bobo.shaobowang@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 25 Nov 2020 14:49:13 +0100
Message-ID: <CAJZ5v0gac0CejDBHmvEh6eeSuQVO1OadYfxT05X6L8Tc=rE1vg@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: Fix error return code in cpufreq_online()
To:     Wang ShaoBo <bobo.shaobowang@huawei.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        huawei.libin@huawei.com, cj.chengjian@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 25, 2020 at 1:49 PM Wang ShaoBo <bobo.shaobowang@huawei.com> wrote:
>
> Fix to return proper error code instaed of 0 in cpufreq_online(), as done

s/instaed/instead/

> elsewhere in this function.
>
> Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
> ---
>  drivers/cpufreq/cpufreq.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 1e7e3f2ff09f..4645c2b78682 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1391,8 +1391,10 @@ static int cpufreq_online(unsigned int cpu)
>
>                 policy->min_freq_req = kzalloc(2 * sizeof(*policy->min_freq_req),
>                                                GFP_KERNEL);
> -               if (!policy->min_freq_req)
> +               if (!policy->min_freq_req) {
> +                       ret = -ENOMEM;
>                         goto out_destroy_policy;
> +               }
>
>                 ret = freq_qos_add_request(&policy->constraints,
>                                            policy->min_freq_req, FREQ_QOS_MIN,
> @@ -1429,6 +1431,7 @@ static int cpufreq_online(unsigned int cpu)
>         if (cpufreq_driver->get && has_target()) {
>                 policy->cur = cpufreq_driver->get(policy->cpu);
>                 if (!policy->cur) {
> +                       ret = -EINVAL;

This error code isn't suitable to be returned from here.  -EIO would be better.

>                         pr_err("%s: ->get() failed\n", __func__);
>                         goto out_destroy_policy;
>                 }
> --

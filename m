Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A84D2C5A3C
	for <lists+linux-pm@lfdr.de>; Thu, 26 Nov 2020 18:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391625AbgKZRJQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Nov 2020 12:09:16 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34082 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391620AbgKZRJQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Nov 2020 12:09:16 -0500
Received: by mail-oi1-f195.google.com with SMTP id s18so2984007oih.1;
        Thu, 26 Nov 2020 09:09:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lQiKxXJPBMu/PrWo9eRuof5ZeEL0++jnroD0J4EB9xg=;
        b=ItoJMMgsAwWAC/hBeA9Mj4QK/AKtL7S8HEhb3oYkh6CXf1Cy2FX23hh+MtwL8gfK34
         NjKkOB5MlQKSlglMb32tbMJWsDNmd4O6rohzQL6maDDRV08I1KCSKAjNV8UGaPzsilx3
         Zi+VhiRYnbRt4kKc++rMiYoQ2Zmt5T7bW1J+6BR7TtfUMncwclX656xL5W3Gnhnj/BZn
         53/uzRMAHb8MMGE2VCBjMxFhVxUvxIN2nR89czaEcOxvZ9rMzHMQ9n+p6BqkbeHRM2Fz
         F+SnA41M+VIi/dq4TLmG8jE/5LIw4HJjpJm/YQPZ4mOvKjiEDjjeKv7HW9knWN25Dh5M
         qiHQ==
X-Gm-Message-State: AOAM5302c41rauNWJC6MWt5Al0ebG359yze2gt2sY0MGutajhYAvTvqd
        uIHwpwaW3GVt09uw5yAtGVNKKh2sgw5i8oeFksw=
X-Google-Smtp-Source: ABdhPJxckI5XQZB62zQH0NHjzFWoYkjR2R96iz6DTSdazuSbIHQpgSfu3IVD0VokJAwyApsUolNT3bewvbxfQncJVYY=
X-Received: by 2002:aca:5a42:: with SMTP id o63mr2564525oib.69.1606410554408;
 Thu, 26 Nov 2020 09:09:14 -0800 (PST)
MIME-Version: 1.0
References: <20201126011239.42294-1-bobo.shaobowang@huawei.com>
In-Reply-To: <20201126011239.42294-1-bobo.shaobowang@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 26 Nov 2020 18:09:03 +0100
Message-ID: <CAJZ5v0gBR862AmXAfzPnHyWddJR4Ap8_=F3Os-LtVXHvRKt47Q@mail.gmail.com>
Subject: Re: [PATCH v2] cpufreq: Fix error return code in cpufreq_online()
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

On Thu, Nov 26, 2020 at 2:12 AM Wang ShaoBo <bobo.shaobowang@huawei.com> wrote:
>
> Fix to return proper error code instead of 0 in cpufreq_online(), as done
> elsewhere in this function.
>
> Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
> ---
>  drivers/cpufreq/cpufreq.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 1e7e3f2ff09f..d3a28de35593 100644
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
> +                       ret = -EIO;
>                         pr_err("%s: ->get() failed\n", __func__);
>                         goto out_destroy_policy;
>                 }
> --

Applied as 5.11 material with a modified subject and some changelog
edits, thanks!

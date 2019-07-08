Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86F4861D3D
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2019 12:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730166AbfGHKsH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Jul 2019 06:48:07 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34750 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729370AbfGHKsG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Jul 2019 06:48:06 -0400
Received: by mail-ot1-f66.google.com with SMTP id n5so15742963otk.1;
        Mon, 08 Jul 2019 03:48:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZxlZywmK8T9tIPU2IKXMhQPp/KiZ2NrHs16HgI1BxC4=;
        b=QhVgifHrJJEUGLAWKKbaKPFlqr96hv5MQqUE83ll4opaMzdrWaBoKci4FQS60yaf9E
         cqieYGAghPOTUa3q1wGso3LNckY7ryDpO/1uXIa8MBun4iNy8mDktKvWzHqmCrvaIRoZ
         W5bn0QR5RKgaEdYRtJIZtGwjoSvdqUvLyEeVVHk9FIKCkhhON/HYFv0JlXUK6nYwWJ5z
         wsnfHsSO6NuqAIWXlGxrfDDIjvIUMliOYduYYBlQQEYLJ1pn+5TA/JKTwRgXNLVt+d5X
         yXJv8J9UoDlOS+Xs3jntV5kw3FZ4VYt7uNCTJshNZLSufjSyoocd6Yp7DYZmmpPseUgu
         6Q+A==
X-Gm-Message-State: APjAAAWBDkoGn/Oovbh0kPEU4lLW/eC6MELvc2BCAs5R01h5uFmc+ceo
        0mgB75tBvW1CqYIYdUmk0/GeI9lc9Z7Bc3xXO/8=
X-Google-Smtp-Source: APXvYqwwV0/BDF5hnTYnjD6dVM9yPpn6aDXVZFKyRIiAAfmsiHUk1TGMqlQAAUZ3IpCdRe/TDXiFCZLrONwUYQfrKVU=
X-Received: by 2002:a9d:6959:: with SMTP id p25mr13156165oto.118.1562582885715;
 Mon, 08 Jul 2019 03:48:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190704192020.GA3771@amd> <CAJZ5v0gn7FWpqW+WmCzj1=K-pjY=SjRNuEsMR3bRTSO8FzFG=Q@mail.gmail.com>
 <20190705185001.GA4068@amd> <CAJZ5v0irbn-Xd47KExw=h7On7KShCm6rThCo0q4-zn=o_x6_HQ@mail.gmail.com>
 <20190706203032.GA26828@amd> <20190708030505.kvrg6sh6bd4xzzwa@vireshk-i7>
 <CAJZ5v0hTXtjkatT4wVftPac-LgL1GSAbwLZ0mMDSpFn=8k9Ssg@mail.gmail.com> <20190708092840.ynibtrntval6krc4@vireshk-i7>
In-Reply-To: <20190708092840.ynibtrntval6krc4@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 8 Jul 2019 12:47:54 +0200
Message-ID: <CAJZ5v0gHNNkcYk5bV-oHDyxmrP=c7G_-bPZd5KXwHTo2oTDHnA@mail.gmail.com>
Subject: Re: cpufreq notifiers break suspend -- Re: suspend broken in
 next-20190704 on Thinkpad X60
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Pavel Machek <pavel@ucw.cz>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux-pm mailing list <linux-pm@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jul 8, 2019 at 11:28 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 08-07-19, 10:28, Rafael J. Wysocki wrote:
> > Pavel has tested the latest version of the patch series AFAICS.
> >
> > The locking added by the commit in question to
> > refresh_frequency_limits() requires an update of
> > cpufreq_update_policy(), or it will deadlock in there because of the
> > lock acquired by cpufreq_cpu_get() if I haven't missed anything.
>
> Ah, looks quite straight forward.
>
> @Pavel: Can you please try this diff ?
>
> -------------------------8<-------------------------
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 9f68d0f306b8..4d6043ee7834 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1109,16 +1109,12 @@ void refresh_frequency_limits(struct cpufreq_policy *policy)
>  {
>         struct cpufreq_policy new_policy;
>
> -       down_write(&policy->rwsem);
> -
>         if (!policy_is_inactive(policy)) {
>                 new_policy = *policy;
>                 pr_debug("updating policy for CPU %u\n", policy->cpu);
>
>                 cpufreq_set_policy(policy, &new_policy);
>         }
> -
> -       up_write(&policy->rwsem);
>  }
>  EXPORT_SYMBOL(refresh_frequency_limits);
>
> @@ -1128,7 +1124,9 @@ static void handle_update(struct work_struct *work)
>                 container_of(work, struct cpufreq_policy, update);
>
>         pr_debug("handle_update for cpu %u called\n", policy->cpu);
> +       down_write(&policy->rwsem);
>         refresh_frequency_limits(policy);
> +       up_write(&policy->rwsem);
>  }
>
> -------------------------8<-------------------------
>
> Though it makes me wonder why I didn't hit this thing. I was using the
> cpu_cooling device the other day, which calls cpufreq_update_policy()
> very frequently on heat-up. And I had a hair dryer blowing over my
> board to heat it up. Lemme check that again :)
>
> @Rafael: You want me to send a new diff patch with Fixes tag this time
> if this works out fine ?

I would prefer the original patch to be updated to avoid possible
bisection woes in the future.

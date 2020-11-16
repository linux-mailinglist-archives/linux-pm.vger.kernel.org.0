Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5702B3AD8
	for <lists+linux-pm@lfdr.de>; Mon, 16 Nov 2020 01:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbgKPAmd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 15 Nov 2020 19:42:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728080AbgKPAmd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 15 Nov 2020 19:42:33 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE197C0613CF;
        Sun, 15 Nov 2020 16:42:32 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id p1so16884828wrf.12;
        Sun, 15 Nov 2020 16:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5Lixo7STShzvL4Shbmq3YhowNswAkb873wBmSE1Y13w=;
        b=dBRO2LdMURQbXCYeOgDMFzwf9OpuawKxB98cUFbNWVMA+RAYjhHucrv3WRdwgwkRYP
         a/R5o7COE0K/39wPh4FgBCsPWhB5AQ3ehckhoM2XFIctfyLfvCg9zgNCyvcf9UhPWC4T
         9Js530aun26joscwa9VQV5OiebElbvCgREXj6uNmIcnySJ+kNMerTe/LUYHEp6k18aoh
         pcqozalBW3KfH7xaOdWzramtIEhLdPN23YMjihoiWfU3Z+OumikPx2yvU5KSKKdXh5Qz
         Fl+gKv2iTWqfArr4izj/gNkVaz1NPQipG3gdGnFwSZD0gYYwXRIHzaAAnlz28zhzPfO+
         +ujg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5Lixo7STShzvL4Shbmq3YhowNswAkb873wBmSE1Y13w=;
        b=dB8sT4z2t0F0NT/xPVGwUTxRgIv5Ggw5EUsxpLqvxSGLDfTITN5GPKp3A68VwyBHEM
         g2lU+YAInDXvOhBsnTU4PqzTo0FtNYJVvIz37+HFB2BKU7AIzvXKsGEgleBrj6z9/ATn
         JkczXLCe2HuosEIXdMCUPGnoVqrDEBdAzrxjkMp/Fn5L5YnkhWO/RwdcKD33zNIjAH/S
         zbRjPumuFgnMyi1mU4/HVhaZcmvS6FaRTZ0dPGHyfGEoQXVelzZqmGyj0oo8K2DQElXh
         tumsQKje//BELOyyI83fJRGt77u3VRNj/4yAcz+Ibm8XShmwB9sXJtLHS7E4BXBqcMj1
         LDkA==
X-Gm-Message-State: AOAM533AnzaH6lGxdcIHjqeV+2pnwr2HGH0/pF4DXKNGa53gxKfc2bXC
        DhswNmPzZv4MD1Rw/as6HNiUw+FpHPu0bNXpt3M=
X-Google-Smtp-Source: ABdhPJyCi0a9S7gjdZqwzODzPyvwyWgMmD8zlfJqg3PCOAe7bH5Q8KR/A7tGoTxSfEe28LjiQ281DhlKdg/CthtF5R8=
X-Received: by 2002:adf:fd0d:: with SMTP id e13mr15636451wrr.85.1605487351726;
 Sun, 15 Nov 2020 16:42:31 -0800 (PST)
MIME-Version: 1.0
References: <cover.1604646059.git.viresh.kumar@linaro.org> <2518c14df2f16cc3c4fee35499895a32513c174b.1604646059.git.viresh.kumar@linaro.org>
In-Reply-To: <2518c14df2f16cc3c4fee35499895a32513c174b.1604646059.git.viresh.kumar@linaro.org>
From:   Qiang Yu <yuq825@gmail.com>
Date:   Mon, 16 Nov 2020 08:42:20 +0800
Message-ID: <CAKGbVbth8X84xv7rU3TcnUFbHuX4-=Ny9gexQMsd89DYwvveaQ@mail.gmail.com>
Subject: Re: [PATCH 5/7] drm/lima: dev_pm_opp_put_*() accepts NULL argument
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        digetx@gmail.com, dri-devel <dri-devel@lists.freedesktop.org>,
        lima@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Looks good for me, patch is:
Reviewed-by: Qiang Yu <yuq825@gmail.com>

Regards,
Qiang

On Fri, Nov 6, 2020 at 3:05 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> The dev_pm_opp_put_*() APIs now accepts a NULL opp_table pointer and so
> there is no need for us to carry the extra check. Drop them.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/gpu/drm/lima/lima_devfreq.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/lima/lima_devfreq.c b/drivers/gpu/drm/lima/lima_devfreq.c
> index bbe02817721b..e7b7b8dfd792 100644
> --- a/drivers/gpu/drm/lima/lima_devfreq.c
> +++ b/drivers/gpu/drm/lima/lima_devfreq.c
> @@ -110,15 +110,10 @@ void lima_devfreq_fini(struct lima_device *ldev)
>                 devfreq->opp_of_table_added = false;
>         }
>
> -       if (devfreq->regulators_opp_table) {
> -               dev_pm_opp_put_regulators(devfreq->regulators_opp_table);
> -               devfreq->regulators_opp_table = NULL;
> -       }
> -
> -       if (devfreq->clkname_opp_table) {
> -               dev_pm_opp_put_clkname(devfreq->clkname_opp_table);
> -               devfreq->clkname_opp_table = NULL;
> -       }
> +       dev_pm_opp_put_regulators(devfreq->regulators_opp_table);
> +       dev_pm_opp_put_clkname(devfreq->clkname_opp_table);
> +       devfreq->regulators_opp_table = NULL;
> +       devfreq->clkname_opp_table = NULL;
>  }
>
>  int lima_devfreq_init(struct lima_device *ldev)
> --
> 2.25.0.rc1.19.g042ed3e048af
>

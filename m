Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20E335449BC
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jun 2022 13:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241664AbiFILH0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Jun 2022 07:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236455AbiFILHY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jun 2022 07:07:24 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 810BD2B1D74
        for <linux-pm@vger.kernel.org>; Thu,  9 Jun 2022 04:07:23 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id t25so37390966lfg.7
        for <linux-pm@vger.kernel.org>; Thu, 09 Jun 2022 04:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k0STqMGE6EHPg5YXwPix1pYW0LNnMbek6MsOHirBCow=;
        b=HoLiH0S5K8gvsrlB/HmnAXE6JUITioaWiRBzpucMksflVk0Gwq/o+6YL4sve/ej+PA
         dnOfK+U35wzfwZ+RcHgQyO/aRzUWB5YYkGGrZNWEDzyyv2nuKEuxcnnPi4I6f6w2KxJc
         kGwb9cgpe/iB3d8+Y/vbmpzmEjTfF6GPN6S0KuMldVFxOUB7JHCFeMwY/EA7mbToB+eo
         /ogV3jUS3IyNyeiXodKrH0MaVxsFsfTwey9T0Cb0Kzf2rUASuBZ6mx2VNsP9wPFK/hrN
         F5mPQGzOG250mWif+jQdeqjgFyKpRdOjXkkSDm69pd8OtydIrsdJJwh9s3F3ZQIPy1k6
         D3MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k0STqMGE6EHPg5YXwPix1pYW0LNnMbek6MsOHirBCow=;
        b=2kVaJ6BSpLgKom+nGjpVSZmB2SoQWfx1ZHL+SIE11gvltNZhU++IiiUXMhvRPGV8Pr
         Guy0eA7R6Wzpi5PkZlnzR9OQ81MRLq6+ld4JsMIMRF6EXlwlwRkgBbjWn/TTiyND2E9X
         qc5IDlrH0Q3IeAR5dphzU8Ny/QRE17zwlcb3V9XCI+5/CtaoufmRYy3XyAnHXnk38ZF1
         ZRP/h/L2ZRI7hGu46A5jaSi1YecZ1/GOroYsOEOCiGq6TDPFnW4F5OXtRF8MJ86pI3xL
         DEIUuhz0pDoOCxgGBvGJJwwqWIvCm0Lqcmh+ZbzzrdMIuI93mFxA9aHdbJgshvS08LVB
         yfog==
X-Gm-Message-State: AOAM530zK5d+grK2toIJ01zlpmKFZ1mejpGNb+eDwjcLHDYkKfuYCw/r
        tndC7ehf+yAnxCy19vo8cLBv00xyBKE5gvCTxrM8rA==
X-Google-Smtp-Source: ABdhPJw6DKemGz6NSrs1gDgu344pLnvhhXrMqTa1pk2eikOE4sq6J7UJ88rQk7aBc73svNDK6dmOsqR+8y37dXdguTk=
X-Received: by 2002:a05:6512:3085:b0:479:3986:1d23 with SMTP id
 z5-20020a056512308500b0047939861d23mr14338140lfd.373.1654772841505; Thu, 09
 Jun 2022 04:07:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220524210721.2072317-1-vladimir.zapolskiy@linaro.org>
In-Reply-To: <20220524210721.2072317-1-vladimir.zapolskiy@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 9 Jun 2022 13:06:45 +0200
Message-ID: <CAPDyKFpXOc2bfF2WmZ6hJd7k71z3RjnJRm8v1ShvW-YeuHAc-Q@mail.gmail.com>
Subject: Re: [RFC PATCH] PM: domains: Decrement subdomain counter after
 powering it off
To:     Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 24 May 2022 at 23:07, Vladimir Zapolskiy
<vladimir.zapolskiy@linaro.org> wrote:
>
> Over the code a counter of powered on subdomains is incremented before
> an attempt to power some subdomain on, which makes a perfect sense,
> however it is asymmetric to a decrement of the counter on power off,
> which is also done before powering a subdomain off.
>
> As a result of a race over powering off domains it might happen that
> a parent power domain could get misinformed about actual power states
> of its subdomains, and thus a parent power domain can be powered off
> in front of its children domains, while an expected result is to
> bail out with a busy state.

Thanks for a nice description of the problem. However, I would be
surprised if you have managed to observe this accordingly. Anyway,
let's look at the code.

>
> Signed-off-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
> ---
> I found this problem while debugging simultaneous and dependant parent
> and children power domain operations, a parent domain can be turned off
> right before its last still enabled child. While in my particular case
> it does not lead to any noticeable issues, it seems that the change is
> necessary to have anyway.
>
> Sending with RFC tag and without Fixes, I would appreciate to get
> feedback, thanks.
>
>  drivers/base/power/domain.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 739e52cd4aba..ee66c54d87b1 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -690,10 +690,10 @@ static int genpd_power_off(struct generic_pm_domain *genpd, bool one_dev_on,
>         genpd->states[genpd->state_idx].usage++;
>
>         list_for_each_entry(link, &genpd->child_links, child_node) {
> -               genpd_sd_counter_dec(link->parent);
>                 genpd_lock_nested(link->parent, depth + 1);
>                 genpd_power_off(link->parent, false, depth + 1);
>                 genpd_unlock(link->parent);
> +               genpd_sd_counter_dec(link->parent);

By moving the decrementation to this point, will always prevent the
parent from being powered off.

Moreover, the current (the child) genpd has already been powered off
at this point, so it's certainly safe to power off its parents at this
point (unless the parent has other children being powered on of
course). So, I am not sure I understand the issue correctly.

>         }
>
>         return 0;
> @@ -748,10 +748,10 @@ static int genpd_power_on(struct generic_pm_domain *genpd, unsigned int depth)
>         list_for_each_entry_continue_reverse(link,
>                                         &genpd->child_links,
>                                         child_node) {
> -               genpd_sd_counter_dec(link->parent);
>                 genpd_lock_nested(link->parent, depth + 1);
>                 genpd_power_off(link->parent, false, depth + 1);
>                 genpd_unlock(link->parent);
> +               genpd_sd_counter_dec(link->parent);

Similar comment as above. As this is the error path in
genpd_power_on(), the current (the child) genpd failed to be powered
on, so it's safe to power off the parent.

Moving the decrementation of the parent->sd_count to this point will
prevent the parent from being off with genpd_power_off() as few lines
above.

>         }
>
>         return ret;
> @@ -1096,8 +1096,6 @@ static void genpd_sync_power_off(struct generic_pm_domain *genpd, bool use_lock,
>         genpd->status = GENPD_STATE_OFF;
>
>         list_for_each_entry(link, &genpd->child_links, child_node) {
> -               genpd_sd_counter_dec(link->parent);
> -
>                 if (use_lock)
>                         genpd_lock_nested(link->parent, depth + 1);
>
> @@ -1105,6 +1103,8 @@ static void genpd_sync_power_off(struct generic_pm_domain *genpd, bool use_lock,
>
>                 if (use_lock)
>                         genpd_unlock(link->parent);
> +
> +               genpd_sd_counter_dec(link->parent);
>         }
>  }
>
> --
> 2.33.0
>

Kind regards
Uffe

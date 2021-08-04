Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 136B93E005C
	for <lists+linux-pm@lfdr.de>; Wed,  4 Aug 2021 13:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237770AbhHDLkr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Aug 2021 07:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237747AbhHDLkr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Aug 2021 07:40:47 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B9CC0613D5
        for <linux-pm@vger.kernel.org>; Wed,  4 Aug 2021 04:40:33 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id f4so375182vkb.10
        for <linux-pm@vger.kernel.org>; Wed, 04 Aug 2021 04:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N7aTfCxAKJ2/XU/on5/jv3kZr0ZUiaYr+3A3j6P4Pxo=;
        b=F58Cvd96+VeMEyWQZWIhBEZM7Vhgt/eKNvvl5M3d6yxCe4oWUtOM5+UiJ5F/4wyubz
         HAbgd+EExQL8lCLg0LqPWO/RE19sOT2PtiKwzNHgp2Ag5H0YXnZbS47iQz8/ARPveUf2
         L1begTuBFdnQ9JaDlkFITHE1gi3CKxf8d20ob4G6hMnHLiyXzyvTGzpS13LQRZZx7bz1
         XgWA86Skwuh43dTiStAjaTUC+M7VH+w6k2IlKdAGkdwL/20XNaADZ391zeWPbvBJ40pR
         8dXOIu7xU889d8ai1rVE45XAPWJfjrhb2LgXCo+BsvhnxHh1F2HKZntXuY/AsHoJ77fV
         s71Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N7aTfCxAKJ2/XU/on5/jv3kZr0ZUiaYr+3A3j6P4Pxo=;
        b=BfPC1pWsZO30BZ8M9Fm4zYlYJDrnmmkv9efbQkvRD07gO2PVwhe8rsW5Kcodio/87j
         A3XgCkOhYv4p4hL1n3ttudhu3UL5za3yaTNd0tY/LmDqCl9mYD9V6Tils/TFlGreK/ep
         M/zbFMdqfgiCg5q9El98KGFPIJAqRBb/JKZEqLL2czfcEz8jttbFegYfu35RzDhtmYLZ
         72NAQHWWx/ybeJhUdeWr/rTmQ0F1QhXKHXCALSAlvz0FJ3R6b11GO1pbHfsykHArIFEs
         K17maigYU+Ky+JpzHYFlkQAZFp3OHZYhq4Q6bkcUR0VPuyF7nqS6NW/xFjyVGKUjBy0b
         melQ==
X-Gm-Message-State: AOAM5324NwtDoQ5zFv0vWx2xxod5KJ6hiaGeas4kGWXF9C3EuZwNy6KZ
        VM20Br6b29p7js0kpLxaSuYXFB7UBvbw4FPqx1YZaA==
X-Google-Smtp-Source: ABdhPJwd7X+yAh+jm61MAYmQnQU0NWt09TvXYK9U3lvNwCskd5VyvewblGteqgYoLsoVAlGrwuIhaqntzGyE3/mMCsk=
X-Received: by 2002:a1f:cf47:: with SMTP id f68mr16089473vkg.7.1628077232121;
 Wed, 04 Aug 2021 04:40:32 -0700 (PDT)
MIME-Version: 1.0
References: <1626764876-10229-1-git-send-email-rnayak@codeaurora.org>
 <1626764876-10229-2-git-send-email-rnayak@codeaurora.org> <CAPDyKFrzHD6rXP5TnqrAVnrZExc2JLFe3HoGF+yM_tsaZYwh8g@mail.gmail.com>
 <35950d34-5cab-1b09-9864-49217a83f68d@codeaurora.org> <6fe7d326-1822-5a49-cca7-df9a2739dca8@codeaurora.org>
In-Reply-To: <6fe7d326-1822-5a49-cca7-df9a2739dca8@codeaurora.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 4 Aug 2021 13:39:55 +0200
Message-ID: <CAPDyKFrTQ0jy_u_oPN3kAXkd+FYMpHmStuU2pm8FHLa_OvXzBA@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] PM / Domains: Add support for 'required-opps' to
 set default perf state
To:     Rajendra Nayak <rnayak@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Roja Rani Yarubandi <rojay@codeaurora.org>,
        Stephan Gerhold <stephan@gerhold.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 4 Aug 2021 at 13:08, Rajendra Nayak <rnayak@codeaurora.org> wrote:
>
>
> On 8/3/2021 10:08 AM, Rajendra Nayak wrote:
> >
> > On 8/2/2021 6:29 PM, Ulf Hansson wrote:
> >> On Tue, 20 Jul 2021 at 09:12, Rajendra Nayak <rnayak@codeaurora.org> wrote:
> >>>
> >>> Some devices within power domains with performance states do not
> >>> support DVFS, but still need to vote on a default/static state
> >>> while they are active. They can express this using the 'required-opps'
> >>> property in device tree, which points to the phandle of the OPP
> >>> supported by the corresponding power-domains.
> >>>
> >>> Add support to parse this information from DT and then set the
> >>> specified performance state during attach and drop it on detach.
> >>> runtime suspend/resume callbacks already have logic to drop/set
> >>> the vote as needed and should take care of dropping the default
> >>> perf state vote on runtime suspend and restore it back on runtime
> >>> resume.
> >>>
> >>> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> >>> ---
> >>>   drivers/base/power/domain.c | 28 +++++++++++++++++++++++++---
> >>>   include/linux/pm_domain.h   |  1 +
> >>>   2 files changed, 26 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> >>> index a934c67..f454031 100644
> >>> --- a/drivers/base/power/domain.c
> >>> +++ b/drivers/base/power/domain.c
> >>> @@ -2598,6 +2598,12 @@ static void genpd_dev_pm_detach(struct device *dev, bool power_off)
> >>>
> >>>          dev_dbg(dev, "removing from PM domain %s\n", pd->name);
> >>>
> >>> +       /* Drop the default performance state */
> >>> +       if (dev_gpd_data(dev)->default_pstate) {
> >>> +               dev_pm_genpd_set_performance_state(dev, 0);
> >>> +               dev_gpd_data(dev)->default_pstate = 0;
> >>> +       }
> >>> +
> >>>          for (i = 1; i < GENPD_RETRY_MAX_MS; i <<= 1) {
> >>>                  ret = genpd_remove_device(pd, dev);
> >>>                  if (ret != -EAGAIN)
> >>> @@ -2635,9 +2641,10 @@ static void genpd_dev_pm_sync(struct device *dev)
> >>>   static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
> >>>                                   unsigned int index, bool power_on)
> >>>   {
> >>> +       struct device_node *np;
> >>>          struct of_phandle_args pd_args;
> >>>          struct generic_pm_domain *pd;
> >>> -       int ret;
> >>> +       int ret, pstate;
> >>>
> >>>          ret = of_parse_phandle_with_args(dev->of_node, "power-domains",
> >>>                                  "#power-domain-cells", index, &pd_args);
> >>> @@ -2675,10 +2682,25 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
> >>>                  genpd_unlock(pd);
> >>>          }
> >>>
> >>> -       if (ret)
> >>> +       if (ret) {
> >>>                  genpd_remove_device(pd, dev);
> >>> +               return -EPROBE_DEFER;
> >>> +       }
> >>> +
> >>> +       /* Set the default performance state */
> >>> +       np = base_dev->of_node;
> >>
> >> Please use dev->of_node instead (it is set to the same of_node as
> >> base_dev by the callers of __genpd_dev_pm_attach) as it's more
> >> consistent with existing code.
> >>
> >>> +       if (of_parse_phandle(np, "required-opps", index)) {
> >>> +               pstate = of_get_required_opp_performance_state(np, index);
> >>> +               if (pstate < 0) {
> >>> +                       ret = pstate;
> >>> +                       dev_err(dev, "failed to set required performance state for power-domain %s: %d\n",
> >>> +                               pd->name, ret);
> >>> +               }
> >>> +               dev_pm_genpd_set_performance_state(dev, pstate);
> >>> +               dev_gpd_data(dev)->default_pstate = pstate;
> >>
> >> This doesn't look entirely correct to me. If we fail to translate a
> >> required opp to a performance state, we shouldn't try to set it.
> >
> > yeah, that does not seem right at all :(
> >
> >> Perhaps it's also easier to call
> >> of_get_required_opp_performance_state() unconditionally of whether a
> >> "required-opps" specifier exists. If it fails with the translation,
> >> then we just skip setting a default state and continue with returning
> >> 1.
> >>
> >> Would that work?
>
> Looks like calling of_get_required_opp_performance_state() unconditionally
> makes it spit out a pr_err() in case the node is missing "required-opps" property,
> so I posted a v6 [1] with the check in place and adding the missing else
> condition.

I see.

Viresh, would it make sense to remove that print? I mean, the
required-opps property could be considered as optional and it seems a
bit silly that a pre-parsing of the property is needed to figure that
out.

>
> [1] https://lore.kernel.org/patchwork/project/lkml/list/?series=510727

Kind regards
Uffe

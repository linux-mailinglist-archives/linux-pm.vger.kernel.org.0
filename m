Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1E316AF4B
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2019 20:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728366AbfGPSza (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Jul 2019 14:55:30 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:33525 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728137AbfGPSz1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Jul 2019 14:55:27 -0400
Received: by mail-oi1-f196.google.com with SMTP id u15so16470986oiv.0
        for <linux-pm@vger.kernel.org>; Tue, 16 Jul 2019 11:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v2qNIAYunawQIOohUStC2uepdglhwjwNOkwTkSmuqwA=;
        b=DeeInblYehK96jBMO3XTQUdyzYaeEVHMZgQIndRYrUd9D1cOKxD8eTfnqmgOSgcWy6
         hitcxSyOWzAU8UsMCUrjhnTI7MRbGSyXY690citOC32HcgrbvpSF5TcgLApM7Cc8CGIx
         SJCkuTpkpVX5wAE6kht0Q+nou/kd5HugDoIUXHr59eCA16ydTVoQ/cjxSjPZ7KIsrgGi
         CPNWtPYU+XGPiIrUdQyYcumIPK8ai++jlqHQIhkqPXF9+HPAZT0jODNb9EW6lShGkCun
         auq/F5854ub9jzRFf+PRksDCB06DskHTntI609gpESvV2yCam3ieYSRYrzkKzpHOeVjZ
         6W5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v2qNIAYunawQIOohUStC2uepdglhwjwNOkwTkSmuqwA=;
        b=WBSfnu2FviMRZ9sMCINGRcYfEqa1dKUmd4VT/IoglbA4P6Bi/K2+FNGmTGPdwjc3w7
         JKAo9EqtvxQdn4oy+whEuTaWcoB4JxU2BrxQY6P7xpWyfBLQPD51N6bLP1cHFI3xJoHW
         KDiU2X0LiUZtshqZ+CsLQJdJSUAzzSxNv5yzdPiEoXwRWXO0NpJH5q7J2h5Fg4bPVTWq
         QHYXI/UaLZlRfO77PlBuxZbir3zXfsNbAa2ctrJ9oUkpIAP4iHqqygXWcOsVEFbZ6+91
         j7TxrhEvIvemoe5mYf6OWkgiVwUZcnNbPrNuw1gsmroi/r0Qy5OYxXr7NcJwI2LlrBzr
         sz+Q==
X-Gm-Message-State: APjAAAU6UkSDuthf6vGf2OMVhUbqvQzUN15HHOn54PBAS6MqHvPXJ98A
        wrQzouq47UEV4OJNoZpbvi3ztBXaM6Nz/3uYrpolpQ==
X-Google-Smtp-Source: APXvYqyZHRObC1IQXBl7JWeBwdhhIJvZKAUPMDYyGOaNWtOTh51kTOUJLNL2kGv1V4wKcLNIT7kbgrPtItAfztGuAbs=
X-Received: by 2002:aca:5106:: with SMTP id f6mr18146549oib.69.1563303326562;
 Tue, 16 Jul 2019 11:55:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190625213337.157525-1-saravanak@google.com> <20190625213337.157525-2-saravanak@google.com>
 <e7a5b387-fa85-15a8-8d79-fbc441c36293@codeaurora.org>
In-Reply-To: <e7a5b387-fa85-15a8-8d79-fbc441c36293@codeaurora.org>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 16 Jul 2019 11:54:50 -0700
Message-ID: <CAGETcx_LLj0Kd_1STijmPm+BbOK4UoY=qQ5Ruhjei3JCoOGhFw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] OPP: Allow required-opps even if the device
 doesn't have power-domains
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Android Kernel Team <kernel-team@android.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 16, 2019 at 10:18 AM Sibi Sankar <sibis@codeaurora.org> wrote:
>
> Hey Saravana,
> Thanks for taking time to post out this series.
>
> On 6/26/19 3:03 AM, Saravana Kannan wrote:
> > A Device-A can have a (minimum) performance requirement on another
> > Device-B to be able to function correctly. This performance requirement
> > on Device-B can also change based on the current performance level of
> > Device-A.
> >
> > The existing required-opps feature fits well to describe this need. So,
> > instead of limiting required-opps to point to only PM-domain devices,
> > allow it to point to any device.
> >
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> >   drivers/opp/core.c |  2 +-
> >   drivers/opp/of.c   | 14 --------------
> >   2 files changed, 1 insertion(+), 15 deletions(-)
> >
> > diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> > index 0e7703fe733f..74c7bdc6f463 100644
> > --- a/drivers/opp/core.c
> > +++ b/drivers/opp/core.c
> > @@ -710,7 +710,7 @@ static int _set_required_opps(struct device *dev,
> >               return 0;
> >
> >       /* Single genpd case */
> > -     if (!genpd_virt_devs) {
> > +     if (!genpd_virt_devs && required_opp_tables[0]->is_genpd) {
> https://patchwork.kernel.org/patch/10940671/
> This was already removed as a part of ^^ and is in linux-next.

Thanks for the heads up.

>
> >               pstate = opp->required_opps[0]->pstate;
> >               ret = dev_pm_genpd_set_performance_state(dev, pstate);
> >               if (ret) {
> > diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> > index c10c782d15aa..7c8336e94aff 100644
> > --- a/drivers/opp/of.c
> > +++ b/drivers/opp/of.c
> > @@ -195,9 +195,6 @@ static void _opp_table_alloc_required_tables(struct opp_table *opp_table,
> >        */
> >       count_pd = of_count_phandle_with_args(dev->of_node, "power-domains",
> >                                             "#power-domain-cells");
> > -     if (!count_pd)
> > -             goto put_np;
> > -
> >       if (count_pd > 1) {
> >               genpd_virt_devs = kcalloc(count, sizeof(*genpd_virt_devs),
> >                                       GFP_KERNEL);
> > @@ -226,17 +223,6 @@ static void _opp_table_alloc_required_tables(struct opp_table *opp_table,
> >
> >               if (IS_ERR(required_opp_tables[i]))
> >                       goto free_required_tables;
> > -
> > -             /*
> > -              * We only support genpd's OPPs in the "required-opps" for now,
> > -              * as we don't know how much about other cases. Error out if the
> > -              * required OPP doesn't belong to a genpd.
> > -              */
> > -             if (!required_opp_tables[i]->is_genpd) {
> > -                     dev_err(dev, "required-opp doesn't belong to genpd: %pOF\n",
> > -                             required_np);
> > -                     goto free_required_tables;
> > -             }
>
> I expect the series to not work as is in its current state since I
> see a circular dependency here. The required-opp tables of the parent
> devfreq won't be populated until we add the opp-table of the child
> devfreq node while the child devfreq using passive governor would
> return -EPROBE_DEFER until the parent devfreq probes.

I looked into this when I wrote the patches. I thought I handled it
correctly. Let me take another look.

-Saravana

> The same applies to this patch -> https://patchwork.kernel.org/patch
> /11046147/ I posted out based on your series. So we would probably have
> to address the dependency here.
>
> >       }
> >
> >       goto put_np;
> >
>
> --
> Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc, is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project

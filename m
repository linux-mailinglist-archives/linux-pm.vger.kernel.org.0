Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4990E31FBDA
	for <lists+linux-pm@lfdr.de>; Fri, 19 Feb 2021 16:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbhBSPT2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Feb 2021 10:19:28 -0500
Received: from mail-ot1-f51.google.com ([209.85.210.51]:44582 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbhBSPT0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Feb 2021 10:19:26 -0500
Received: by mail-ot1-f51.google.com with SMTP id g6so1215521otk.11
        for <linux-pm@vger.kernel.org>; Fri, 19 Feb 2021 07:19:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Il3TOjpZP4PrrqnJVznjmFj1tcP2e0SIqI7SVYcR2LY=;
        b=DcP5HbkaJoi1+GAeF7yDLOqX/PD3/CIgF/YvR/U2SRm0Lx6jQFgb2g9NkGGYEuppqv
         h+qMhJOqqQZxNikzm/Sj4Wutah7saRr9K25OzIAFMdshvRVTNsfDUb6pW4Cbpemnn0ei
         /Hm1J2dGC8BDWlHlyix+jS95Mgpm4CQBH429GnQao67LkG+/PFhV40DsOckSR4jTI63W
         yGgYT/ywguwaMS7KtQ4mV71w7U57MRRQXtVhWZviSb36QCy4SQhsFz8uk5xmpMtn4iJ8
         ynOZCG+rpncKHiiy8h88EQJTVA2zyfJBp8lSUc1z6uumy2gCCndBSQdqLhckmdKasXSn
         ogcg==
X-Gm-Message-State: AOAM533MnlRTgyoj9YP5O6MRIQQcYJyBw2rMh1MSGVwa03Ha81bv56pv
        l0iuSN2DDPkAv5ScRMOhQHDg87dilSAVqOWrtJ4=
X-Google-Smtp-Source: ABdhPJz8sa9vI2FtV0AuwRXO6AWZgVBvp2hYcQTd38BfBQcVTH1hw+/KVEiBMY8Vj1Wp1tcKHCTpghg4LX2v+ZF+9Xw=
X-Received: by 2002:a05:6830:2106:: with SMTP id i6mr7162934otc.260.1613747924934;
 Fri, 19 Feb 2021 07:18:44 -0800 (PST)
MIME-Version: 1.0
References: <20210218095338.1766-1-zbestahu@gmail.com> <20210218100511.nsjgtu3mdkr6f4zf@vireshk-i7>
In-Reply-To: <20210218100511.nsjgtu3mdkr6f4zf@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 19 Feb 2021 16:18:32 +0100
Message-ID: <CAJZ5v0jRU=nxd9f4pvNHi9Z7QJZNW9XqC9CD8Qy0P0sYQHjyDw@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: Fix typo in comments
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Yue Hu <zbestahu@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>, Yue Hu <huyue2@yulong.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Feb 18, 2021 at 11:50 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 18-02-21, 17:53, Yue Hu wrote:
> > From: Yue Hu <huyue2@yulong.com>
> >
> > Change 'Terget' to 'Target'.
> >
> > Should be Target.
> >
> > Signed-off-by: Yue Hu <huyue2@yulong.com>
> > ---
> >  drivers/cpufreq/cpufreq.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index d0a3525..e4ec74d 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -2101,7 +2101,7 @@ unsigned int cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
> >   * cpufreq_driver_adjust_perf - Adjust CPU performance level in one go.
> >   * @cpu: Target CPU.
> >   * @min_perf: Minimum (required) performance level (units of @capacity).
> > - * @target_perf: Terget (desired) performance level (units of @capacity).
> > + * @target_perf: Target (desired) performance level (units of @capacity).
> >   * @capacity: Capacity of the target CPU.
> >   *
> >   * Carry out a fast performance level switch of @cpu without sleeping.
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied as 5.12-rc material, thanks!

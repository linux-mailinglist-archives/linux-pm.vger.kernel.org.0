Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 741902557FC
	for <lists+linux-pm@lfdr.de>; Fri, 28 Aug 2020 11:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbgH1Jtl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Aug 2020 05:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728556AbgH1Jtj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Aug 2020 05:49:39 -0400
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8730BC06121B
        for <linux-pm@vger.kernel.org>; Fri, 28 Aug 2020 02:49:39 -0700 (PDT)
Received: by mail-vk1-xa43.google.com with SMTP id s127so84706vkg.3
        for <linux-pm@vger.kernel.org>; Fri, 28 Aug 2020 02:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w9MzcXp7Zv4T4qzmBXRcvcnXSh8rk6DDo3kSFK2/hp4=;
        b=enF6AvtG5bVBqOHn/jdPVGXAen7fbZALoxZvEjcFqpQ786XitsRhBBZhPP77KI5osv
         aDKGMRveQ+pP+6ADDUGY+7ToQbl6x8MoPSpwvIWOeAWahQj+GLVlj3yzUwvGrIPzHfuW
         LPPrHGuZHRcvI9KCRWXb+Hkco1rBTHL7KwThIezI0meM0BUNaZHH0z+5W2OIkwwLZB5k
         whfTQnmVEz0hGw8oKMDmLgnBDbGp62ix9wx+DnexJUhqxnoN/+xJE/Gvu5eoD1/wWPzi
         wW7cdy+G2JGMVilyMooTTl46FjdXGm8bauIe2giw0Tx726WUrUpC3/vgV4BFK1f7bRtu
         bXsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w9MzcXp7Zv4T4qzmBXRcvcnXSh8rk6DDo3kSFK2/hp4=;
        b=dRcrMIGCaUWdqDLYpVfBiafIeCQwz/IKsJ3IGVwbhwrmZtEkOOVCiDotF0FR1JnH3E
         ElZWrQOrzBHBE1ViQWTACcDDm09DZlC6iXOWUiudILvVi4NSvyHQbm7O0nc5z8Ly5Ub9
         0NCdcNclAmGcotuWl7ZdYDCFlLn+It8hCDZ0Gjxgru4btS5XQrfR6v4zRFm7C3cKuywp
         6M5jnfFOhTSGts5hKVeRf16MhOBxEV1Z6cMqIBxslX9jNPPu2x5vOIIK4z0i2wjEj0T+
         SsnNqJ2uJsKgorbA9mwKrSjOc0IEBSJSAIqHGK/+xcErbt/8s+YQVR5dQtE8N00u2OGR
         hPlQ==
X-Gm-Message-State: AOAM5338fx1fd/5+Y3YqgJwbCBfbG3eZXkCJjKdRTj0QuMn8TNa7cg6q
        fqKLTTGZeBGiDJ6Dn51/s+8C0LzGWcJ7WRnRksBAkA==
X-Google-Smtp-Source: ABdhPJxInf4ozm1ow2zl3o3yR14YGHeF+fncV9uzFsoD6t5s0aLYDlhojEDfKGcq0+hIyIEQBVgO4aqHIkrN8C0+TLg=
X-Received: by 2002:a1f:13c6:: with SMTP id 189mr287585vkt.81.1598608178621;
 Fri, 28 Aug 2020 02:49:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200826093328.88268-1-stephan@gerhold.net> <20200827100104.yuf2nzb6qras7zcw@vireshk-i7>
 <20200827114422.GA1784@gerhold.net> <20200828063511.y47ofywtu5qo57bq@vireshk-i7>
In-Reply-To: <20200828063511.y47ofywtu5qo57bq@vireshk-i7>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 28 Aug 2020 11:49:01 +0200
Message-ID: <CAPDyKFoJrTUEY3a1W+Xf=az_60L=iT_6OUtWmY-JJxLx5HTC6w@mail.gmail.com>
Subject: Re: [PATCH v2] opp: Power on (virtual) power domains managed by the
 OPP core
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Daniel Baluta <daniel.baluta@oss.nxp.com>,
        Stephan Gerhold <stephan@gerhold.net>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Niklas Cassel <nks@flawful.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

+ Daniel

> > Commit 17a8f868ae3e ("opp: Return genpd virtual devices from dev_pm_opp_attach_genpd()"):
> >  "The cpufreq drivers don't need to do runtime PM operations on
> >   the virtual devices returned by dev_pm_domain_attach_by_name() and so
> >   the virtual devices weren't shared with the callers of
> >   dev_pm_opp_attach_genpd() earlier.
> >
> >   But the IO device drivers would want to do that. This patch updates
> >   the prototype of dev_pm_opp_attach_genpd() to accept another argument
> >   to return the pointer to the array of genpd virtual devices."
>
> Not just that I believe. There were also arguments that only the real
> consumer knows how to handle multiple power domains. For example for a
> USB or Camera module which can work in multiple modes, we may want to
> enable only one power domain in say slow mode and another power domain
> in fast mode. And so these kind of complex behavior/choices better be
> left for the end consumer and not try to handle this generically in
> the OPP core.
>
> > But the reason why I made this patch is that actually something *should*
> > enable the power domains even for the cpufreq case.
>
> Ulf, what do you think about this ? IIRC from our previous discussions
> someone asked me not do so.

Yes, that's correct, I recall that now as well.

In some cases I have been told that, depending on the running use
case, one of the PM domains could stay off while the other needed to
be on. I was trying to find some thread in the archive, but I failed.
Sorry.

>
> > If every user of dev_pm_opp_attach_genpd() ends up creating these device
> > links we might as well manage those directly from the OPP core.
>
> Sure, I am all in for reducing code duplication, but ...
>
> > I cannot think of any use case where you would not want to manage those
> > power domains using device links. And if there is such a use case,
> > chances are good that this use case is so special that using the OPP API
> > to set the performance states would not work either. In either case,
> > this seems like something that should be discussed once there is such a
> > use case.
>
> The example I gave earlier shows a common case where we need to handle
> this at the end users which still want to use the OPP API.
>
> > At the moment, there are only two users of dev_pm_opp_attach_genpd():
> >
> >   - cpufreq (qcom-cpufreq-nvmem)
> >   - I/O (venus, recently added in linux-next [1])
> >
> > [1]: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=9a538b83612c8b5848bf840c2ddcd86dda1c8c76
> >
> > In fact, venus adds the device link exactly the same way as in my patch.
> > So we could move that to the OPP core, simplify the venus code and
> > remove the virt_devs parameter. That would be my suggestion.
> >
> > I can submit a v3 with that if you agree (or we take this patch as-is
> > and remove the parameter separately - I just checked and creating a
> > device link twice does not seem to cause any problems...)
>
> I normally tend to agree with the logic that lets only focus on what's
> upstream and not think of virtual cases which may never happen. But I
> was told that this is too common of a scenario and so it made sense to
> do it this way.
>
> Maybe Ulf can again throw some light here :)

There is another series that is being discussed [1], which could be
used by the consumer driver to help manage the device links. Maybe
that is the way we should go, to leave room for flexibility.

[1]
[PATCH v3 0/2] Introduce multi PM domains helpers
https://www.spinics.net/lists/kernel/msg3565672.html

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EEE73E0643
	for <lists+linux-pm@lfdr.de>; Wed,  4 Aug 2021 19:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239760AbhHDRAt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Aug 2021 13:00:49 -0400
Received: from mail-oi1-f180.google.com ([209.85.167.180]:33410 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239640AbhHDRAt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Aug 2021 13:00:49 -0400
Received: by mail-oi1-f180.google.com with SMTP id 26so3673942oiy.0;
        Wed, 04 Aug 2021 10:00:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XxImQQRd4D1ugKiTX4wzCD+33Wg69xMML2J4wGzPmQU=;
        b=bMfdquAM2XPq+dUDEdB1u8SiOtImCU9c20C0k+TfbTLTNJ5mllBYDlWh7m/MFEGT3v
         5KzjA6F2lRcD14UhZMAFO/6ULyvu2JRHPsvU0EbkDBdB9urTLcU3lmB8rD549Ty/zpnh
         bwbw9x+wTf1QRu53AyLHl1fokPqVAl2mm8JOpcg3Kp+b3FQGO3hwHJ5hGwvw4CzntgUf
         GZT4Zkx1lBKs/8ZiyDqYf/PHgo908lWBsulLb47UMBTZHA0kvojPhTQGusUgtYoyI9m7
         7elmEZEwSElzOyd/00juwYbBMh0dVMSEWt2cEZfKk4m4jCak1bBsSbBTRvUh34TA9urz
         AJAg==
X-Gm-Message-State: AOAM532GOFExtvDp8d5N18+rxu+z5olqEstf+0TgWaFAW3byDcQJoMY7
        rPWJfovMJSHRjTSsVApSfBCB+4SZyAUUb75CQ64=
X-Google-Smtp-Source: ABdhPJx5JQpQu99HXyDJXrqIFjHkd4lBZL8Mm/gOHKvlGj/KmDBTmbAGVD0Uiumul4r+DCDkygVWzU8btsx8DtiHmEI=
X-Received: by 2002:a05:6808:198c:: with SMTP id bj12mr350174oib.71.1628096435307;
 Wed, 04 Aug 2021 10:00:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210721101658.9235-1-ray.huang@amd.com> <20210803001339.GG2563957@hr-amd>
In-Reply-To: <20210803001339.GG2563957@hr-amd>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 4 Aug 2021 19:00:23 +0200
Message-ID: <CAJZ5v0gMqFBDubQyG3YSnt1RcGzfjnxvLtTNpCdqZDjdAMJh=w@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: enhance the sequency of governor change
To:     Huang Rui <ray.huang@amd.com>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Aug 3, 2021 at 2:13 AM Huang Rui <ray.huang@amd.com> wrote:
>
> Ping~

I prefer the existing code, sorry.

> On Wed, Jul 21, 2021 at 06:16:58PM +0800, Huang, Ray wrote:
> > Keep the "success" case of governor change in the mainline of the
> > function not in "if" case. And using restart_old_gov flag to indicate
> > the fallback case to old governor. This is more readable and no function
> > change.
> >
> > Signed-off-by: Huang Rui <ray.huang@amd.com>
> > ---
> >  drivers/cpufreq/cpufreq.c | 23 +++++++++++++++--------
> >  1 file changed, 15 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index 802abc925b2a..4f7005ddb70c 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -2545,18 +2545,25 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
> >       /* start new governor */
> >       policy->governor = new_gov;
> >       ret = cpufreq_init_governor(policy);
> > -     if (!ret) {
> > -             ret = cpufreq_start_governor(policy);
> > -             if (!ret) {
> > -                     pr_debug("governor change\n");
> > -                     sched_cpufreq_governor_change(policy, old_gov);
> > -                     return 0;
> > -             }
> > +     if (ret)
> > +             goto restart_old_gov;
> > +
> > +     ret = cpufreq_start_governor(policy);
> > +     if (ret) {
> >               cpufreq_exit_governor(policy);
> > +             goto restart_old_gov;
> >       }
> >
> > +     pr_debug("governor change\n");
> > +
> > +     sched_cpufreq_governor_change(policy, old_gov);
> > +
> > +     return 0;
> > +
> > +restart_old_gov:
> >       /* new governor failed, so re-start old one */
> > -     pr_debug("starting governor %s failed\n", policy->governor->name);
> > +     pr_debug("starting governor %s failed\n",
> > +              policy->governor->name);
> >       if (old_gov) {
> >               policy->governor = old_gov;
> >               if (cpufreq_init_governor(policy))
> > --

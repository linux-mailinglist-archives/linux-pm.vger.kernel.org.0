Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9C1275B6A
	for <lists+linux-pm@lfdr.de>; Wed, 23 Sep 2020 17:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgIWPRy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Sep 2020 11:17:54 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39466 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbgIWPRy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Sep 2020 11:17:54 -0400
Received: by mail-ot1-f68.google.com with SMTP id u25so65000otq.6;
        Wed, 23 Sep 2020 08:17:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AKkObmW9WFZRFIJQwwPvMt/KAyiqqGXD9pYl1RmYb7o=;
        b=BPTv0wwBUN6ts8ozS3UYwj1V/7ljmA9c6T1efrnX+aY1Oyd6nsmDRNwdadIrYZuwuE
         ofHCzgrZB1CxyZAqJxERpeU3qYjfjBqO+gr9e7fS8qy72Ik1Kyd1XkhKh/bNuM4H+1nK
         owAhbQAtf6pP32rdKT0m9OH7Bt4+t85svWr3fzBf2FreUSYxnkbHz5H8FhCo0So1+MJ1
         t9xClzCpz3DeujMQwRuq7a+1TjjNPgajZHnF9NgP4CzaChYaukCYzSU3nAx9TDU5e96P
         6aTijNV6tZFTyo9bKGAYgqg0bJPNzw9bEq4JX1DQZdED9AIh7BaHA0iKn5wIyipcvOXV
         eP0g==
X-Gm-Message-State: AOAM532MrwKqFpvGElII/4EIRkxMYevPjIrh6OvYYO6wpoSB6EwDuXZ/
        iEMFIn4xrpZtoJ6RzvMD0HGIewq7HenQWCQKIic=
X-Google-Smtp-Source: ABdhPJy2x6F/RAnpzP7PW0wXYvjb9iX6IdZ+A80YTufFP/u6VzmeP8+bzJRAeu++/FSjDMsOn61n1sMH/9/i4D1bdNM=
X-Received: by 2002:a9d:6010:: with SMTP id h16mr124765otj.262.1600874273426;
 Wed, 23 Sep 2020 08:17:53 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1600238586.git.viresh.kumar@linaro.org> <c9dc39f9956ad9851511d6710e8f8a5cb142789e.1600238586.git.viresh.kumar@linaro.org>
 <CAJZ5v0hpT9CAb1hxKcQVA-OJP3UYja=Kqvgh-Ed4N8Ln+=2b5A@mail.gmail.com>
In-Reply-To: <CAJZ5v0hpT9CAb1hxKcQVA-OJP3UYja=Kqvgh-Ed4N8Ln+=2b5A@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 23 Sep 2020 17:17:42 +0200
Message-ID: <CAJZ5v0gvEZx+o8SRmZ6S9bCetVz0n3Fr4uDdAYvhj3rNdHVwHw@mail.gmail.com>
Subject: Re: [PATCH V2 3/4] cpufreq: stats: Enable stats for fast-switch as well
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>, cristian.marussi@arm.com,
        Sudeep Holla <sudeep.holla@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Sep 23, 2020 at 5:14 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, Sep 16, 2020 at 8:46 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > Now that all the blockers are gone for enabling stats in fast-switching
> > case, enable it.
> >
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >  drivers/cpufreq/cpufreq.c       | 6 +++++-
> >  drivers/cpufreq/cpufreq_stats.c | 6 ------
> >  2 files changed, 5 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index 47aa90f9a7c2..d5fe64e96be9 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -2057,8 +2057,12 @@ unsigned int cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
> >                                         unsigned int target_freq)
> >  {
> >         target_freq = clamp_val(target_freq, policy->min, policy->max);
> > +       target_freq = cpufreq_driver->fast_switch(policy, target_freq);
> >
> > -       return cpufreq_driver->fast_switch(policy, target_freq);
> > +       if (target_freq)
> > +               cpufreq_stats_record_transition(policy, target_freq);
>
> So this adds two extra branches in the scheduler path for the cases
> when the stats are not used at all which seems avoidable to some
> extent.
>
> Can we check policy->stats upfront here and bail out right away if it
> is not set, for example?

Well, scratch this, the next patch fixes it up.

Cheers!

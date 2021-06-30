Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7F8A3B871C
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jun 2021 18:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbhF3QfR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Jun 2021 12:35:17 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:41884 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhF3QfQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Jun 2021 12:35:16 -0400
Received: by mail-ot1-f41.google.com with SMTP id m6-20020a9d1d060000b029044e2d8e855eso3303485otm.8;
        Wed, 30 Jun 2021 09:32:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xjiwcwmwYVU/Y0LKZ3Up/yPWW67ykZw9kfOwYgExw7A=;
        b=G6qS367FD1QKC6bno/AP2nyWpY3qXcLnA3UclT+3eizEdF3wvHYjo2qYhBnPq2+ub0
         hOUoIfLCfOXP+kLuZ82ZmG0gvablffdzbtl+2gDKnWVJNMJQoPLEJCT70CCDQrprEqcI
         FojbpmTV12WBQGC7MM81Trw0XFKjyvDoodu3S3xlPQTJr7JkJfETJi3YWr2ZT/Q4x/1t
         JUOI8QUcXf2iBi40scLivEhy0UGtdR2OnvtIbiDx2uqiMa7HRqyHCm7liaHrcIbltDxX
         dH2V6WG8uGfcTEoqiaae6sA7471RuoNLKpfGXN02tjl6HIE0JjXb24c2C7uFkWdOlAeW
         i0iw==
X-Gm-Message-State: AOAM531CsFtbZPgsvwLNhC3MS/+5pAjqrF4JwFBfc1yuM9DC2uCrQtf3
        sdiHxX48Pq4984W2kwWWwZOeecAfwQIM32OLQ+I=
X-Google-Smtp-Source: ABdhPJxfrb8HvU4LnjaS0Rjd6JV80ARcJH49aa6L8I/mgHtJMzv8D4zC8Uxs6rvB5RN02anw7eODG50Q8pyJ77E6X+k=
X-Received: by 2002:a05:6830:1d8:: with SMTP id r24mr3146657ota.206.1625070767446;
 Wed, 30 Jun 2021 09:32:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210626162324.8236-1-tung-chen.shih@mediatek.com> <20210629061758.wdavb2a4bpklmqi3@vireshk-i7>
In-Reply-To: <20210629061758.wdavb2a4bpklmqi3@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 30 Jun 2021 18:32:36 +0200
Message-ID: <CAJZ5v0g2fc7UDFajbFCZS0ctSZcV-h_JCwts6w6fe3Xy_S=gzA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] cpufreq: fix the target freq not in the range of
 policy->min & max
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        TungChen Shih <tung-chen.shih@mediatek.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC..." 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jun 29, 2021 at 8:18 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 27-06-21, 00:23, TungChen Shih wrote:
> >     The function cpufreq_driver_resolve_freq() should return the lowest
>
> Don't add extra spaces at the beginning of paragraphs here.
>
> > supported freq greater than or equal to the given target_freq, subject
> > to policy (min/max) and driver limitations. However, the index returned
> > by cpufreq_frequency_table_target() won't subject to policy min/max in
> > some cases.
> >
> >     In cpufreq_frequency_table_target(), this function will try to find
> > an index for @target_freq in freq_table, and the frequency of selected
> > index should be in the range [policy->min, policy->max], which means:
> >
> >     policy->min <= policy->freq_table[idx].frequency <= policy->max
> >
> >     Though "clamp_val(target_freq, policy->min, policy->max);" would
> > have been called to check this condition, when policy->max or min is
> > not exactly one of the frequency in the frequency table,
> > policy->freq_table[idx].frequency may still go out of the range
> >
> >     For example, if our sorted freq_table is [3000, 2000, 1000], and
> > suppose we have:
> >
> >     @target_freq = 2500
> >     @policy->min = 2000
> >     @policy->max = 2200
> >     @relation = CPUFREQ_RELATION_L
> >
> > 1. After clamp_val(target_freq, policy->min, policy->max); @target_freq
> > becomes 2200
> > 2. Since we use CPUFREQ_REALTION_L, final selected freq will be 3000 which
> > beyonds policy->max
>
> Right so the problem does exist,

That IMO is a matter for discussion and the patch author seems to have
decided to ignore my previous comments.

> and not only with
> cpufreq_driver_resolve_freq(), but __cpufreq_driver_target() as well.

That all depends on what the policy min and max limits are expected to
mean and so far the interpretation has been that they are applied to
the target frequency coming from the governor.

Drivers have never been expected to ensure that the final effective
frequency will always be between the policy min and max and, indeed,
they may not even be able to ensure that.

Now, because RELATION_L is defined as "the closest frequency equal to
or above the target", running at a frequency below the target is
questionable even if the max limit gets in the way.  IOW, RELATION_L
takes precedence over the policy max limit.

Accordingly, I'm not going to apply this patch or anything similar to
it until I'm given a really convincing argument otherwise.

> I have a sent a patchset to update both of these to start sharing some
> code and we need to fix this for both now.
>
> > Signed-off-by: TungChen Shih <tung-chen.shih@mediatek.com>
> > ---
> >  drivers/cpufreq/cpufreq.c | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index 802abc925b2a..8e3a17781618 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -544,8 +544,23 @@ unsigned int cpufreq_driver_resolve_freq(struct cpufreq_policy *policy,
> >       if (cpufreq_driver->target_index) {
> >               unsigned int idx;
> >
> > +             /*  to find the frequency >= target_freq */
> >               idx = cpufreq_frequency_table_target(policy, target_freq,
> >                                                    CPUFREQ_RELATION_L);
> > +
> > +             /* frequency should subject to policy (min/max) */
> > +             if (policy->freq_table[idx].frequency > policy->max) {
> > +                     if (policy->freq_table_sorted == CPUFREQ_TABLE_SORTED_ASCENDING)
> > +                             idx--;
> > +                     else
> > +                             idx++;
> > +             } else if (policy->freq_table[idx].frequency < policy->min) {
> > +                     if (policy->freq_table_sorted == CPUFREQ_TABLE_SORTED_ASCENDING)
> > +                             idx++;
> > +                     else
> > +                             idx--;
> > +             }
>
> This doesn't look clean to be honest.
>
> Rafael, does it make sense to update cpufreq_frequency_table_target()
> (and its internal routines) to take policy bounds in consideration, or
> something else ?
>
> --
> viresh

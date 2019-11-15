Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 622EAFD864
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2019 10:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbfKOJHu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Nov 2019 04:07:50 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45487 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfKOJHu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Nov 2019 04:07:50 -0500
Received: by mail-oi1-f194.google.com with SMTP id 14so7989296oir.12;
        Fri, 15 Nov 2019 01:07:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1T8ZMHXbmRWySVpMqhSZ6mvt4yKvrwJAfUEqvmZGEFo=;
        b=P/x/cM6ow2zgScqWC0SOz4iKlG6fUHX2J8MeFvzRIt/SLnDnb18fqmBNULk5Q6ZHFn
         utszk13Edbnu2W6HmoSLZM2I/LiCX21jr2KG50LYh9h+7zHvwfiES92mEqfxF77/lOEA
         bvqPPunW1w5YprdXDkdsHbI4apU7vbWr4oQasCLZ+siiBtNWntCOxy/nYlCGH9Y4M6UR
         PXHfKPOohtluARPwZu8QCk0/WMr9rQCy1gh7wvwiIfREGCM6KfzCa0t1CaKfkinVrDsd
         9InEu7NoGjVawep4Ju65/wfXvpMhsad0X0q8dmRzozXKyzBEbVHUL5eZz8b3D02GYZan
         4GCA==
X-Gm-Message-State: APjAAAU6P3DbNXL3yDjosegGrF/+aKvlwC3h60VBXBbtVbDdw3a0kXdZ
        P0j9tvXqCPtyfLEfP1aAjo+/sxMORF1+4kaBuSc=
X-Google-Smtp-Source: APXvYqzI/FOo/sg1miVsMISAbvdhiV1iv9fSqVjCPwEZmKhXSlDhRP22rwowRwXpxJKt6JU7K34qSmypZWxBY3coMQY=
X-Received: by 2002:aca:1101:: with SMTP id 1mr7322552oir.103.1573808869178;
 Fri, 15 Nov 2019 01:07:49 -0800 (PST)
MIME-Version: 1.0
References: <13588000.TfE7eV4KYW@kreacher> <3144686.I8R4d9A2JO@kreacher>
 <CAJZ5v0jiBrx2xxf2EdvGrqke0ByK5YWXEw0R2rpHZYAJjgwJmg@mail.gmail.com> <001a01d59b53$5eb8ae10$1c2a0a30$@net>
In-Reply-To: <001a01d59b53$5eb8ae10$1c2a0a30$@net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 15 Nov 2019 10:07:38 +0100
Message-ID: <CAJZ5v0ig_Juva_nHjtWjWPv4bghFYasxiJOZbtv8==cwqhBpdQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] cpuidle: teo: Avoid expecting unrealistic idle times
To:     Doug Smythies <dsmythies@telus.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Nov 15, 2019 at 2:24 AM Doug Smythies <dsmythies@telus.net> wrote:
>
> On 2019.11.14 15:51 Rafael J. Wysocki wrote:
> > On Wed, Nov 13, 2019 at 1:11 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >>
> >> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>
> >> If an idle state shallower than the one "matching" the time till the
> >> next timer event is considered for selection, expect the idle duration
> >> to fall in the middle of the "bin" corresponding to that state rather
> >> than at the beginning of it which is unrealistic.
> >>
> >> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >> ---
> >>  drivers/cpuidle/governors/teo.c |    9 ++++++++-
> >>  1 file changed, 8 insertions(+), 1 deletion(-)
> >>
> >> Index: linux-pm/drivers/cpuidle/governors/teo.c
> >> ===================================================================
> >> --- linux-pm.orig/drivers/cpuidle/governors/teo.c
> >> +++ linux-pm/drivers/cpuidle/governors/teo.c
> >> @@ -360,7 +360,14 @@ static int teo_select(struct cpuidle_dri
> >>
> >>                 if (max_early_idx >= 0) {
> >>                         idx = max_early_idx;
> >> -                       duration_ns = drv->states[idx].target_residency_ns;
> >> +                       /*
> >> +                        * Expect the idle duration to fall in the middle of the
> >> +                        * "bin" corresponding to idx (note that the maximum
> >> +                        * state index is guaranteed to be greater than idx at
> >> +                        * this point).
> >> +                        */
> >> +                       duration_ns = (drv->states[idx].target_residency_ns +
> >> +                               drv->states[idx+1].target_residency_ns) / 2;
> >>                 }
> >>         }
> >
> > This change turns out to cause the governor to choose idle states that
> > are too deep or too shallow too often, so I'm withdrawing it.
>
> O.K. thanks for letting us know.
> I did see some differences in the testing I did so far, but hadn't drilled down
> into it yet.
> I am somewhat wondering about the above and below stats in general.
>
> By the way, I had a daft mistake in my post processing program, such that the
> "below" graph for idle state 0 was always plotting 0.
>
> Reference for that sweep test that I do (which is as far I got so far):
> http://www.smythies.com/~doug/linux/idle/teo-2019-11/sweep/index.html
>
> Legend:
>
> teo-v2: re-run of previous teo-v2 so that I could get non-zero idle state "below" data
> linux-next 2019.11.07 + cpuidle: Consolidate disabled state checks +
> [PATCH v2] cpuidle: Use nanoseconds as the unit of time
>
> teo-v3: teo-v2 + cpuidle: teo: Exclude cpuidle overhead from computations
>
> teo-v4: linux-pm + linux-next 2019.11.12 +
> cpuidle: teo: Avoid code duplication in conditionals
> cpuidle: teo: Avoid expecting unrealistic idle times
> cpuidle: teo: Avoid using "early hits" incorrectly
>
> teo-v5: teo-v4 + cpuidle: teo: Exclude cpuidle overhead from computations

Thanks for running the tests, appreciated!

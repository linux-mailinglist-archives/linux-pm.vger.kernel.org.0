Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC8BD2ED46F
	for <lists+linux-pm@lfdr.de>; Thu,  7 Jan 2021 17:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbhAGQkQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 Jan 2021 11:40:16 -0500
Received: from mail-ot1-f44.google.com ([209.85.210.44]:40679 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbhAGQkQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 Jan 2021 11:40:16 -0500
Received: by mail-ot1-f44.google.com with SMTP id j12so6821138ota.7;
        Thu, 07 Jan 2021 08:40:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6f15dDz/sBid4bA08/uLFiWT+A9f5KxxTm6Kjvrbx5o=;
        b=r97fbXAkSfFvW7v31pbLgEytAiwCyhDS51c0lp4rEVvQUZmnzoWbBrDC5F4Umnx1pd
         Yw0e+sCE5ru9K/hnzm2q/p8hfjpyJgAFJnwTspvYGIX6U42g2F8fv8wkt6gUylhWT9qh
         aThDZkFWK3tJ1C+/ImC/eFLromXhkGX6Vl13GEe0aVsr5QIPHk++u8lo1pYj37Z9E5VX
         +TUsYlZEKazRlECUoeaIoo02r7DJIZ1VmjbI9Z3JqXSSGS3p7Ls0CCB8rDuh0Rc20Px1
         Kp1kcXGnL5f58OwCd11NOYxumUxsZLOM6rPYr4U9S6CFs1U75OVclPxhLLwI9qfipcLA
         8Dyw==
X-Gm-Message-State: AOAM533opNkbbghwf4Hkieq3xnsl3vyZ2OkXDESLd3qxBBH92/1rhS6V
        +L/DlrP5TsUIYY8+5gHaGuz0h+zpGDwUo/ecRCo=
X-Google-Smtp-Source: ABdhPJyRCd+XcKa12I5Zg+gyy1RnqAUd0zOrCx8YgJzzFAyySoyWiJ2m+CdecnCaGOeHVUXx+emZxEUWfFIS7uirqiw=
X-Received: by 2002:a9d:67da:: with SMTP id c26mr7245123otn.321.1610037575690;
 Thu, 07 Jan 2021 08:39:35 -0800 (PST)
MIME-Version: 1.0
References: <20210105101957.59072-1-colin.king@canonical.com> <20210105102101.y4jdqdmcru5ouec4@vireshk-i7>
In-Reply-To: <20210105102101.y4jdqdmcru5ouec4@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 7 Jan 2021 17:39:24 +0100
Message-ID: <CAJZ5v0gF9XRNnn+O+kCRFtas9sgrQgk8piF1OoHqmGhi66qZwg@mail.gmail.com>
Subject: Re: [PATCH][V3] cpufreq: powernow-k8: pass policy rather than use cpufreq_cpu_get
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Colin King <colin.king@canonical.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Stephen Warren <swarren@nvidia.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jan 5, 2021 at 11:22 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 05-01-21, 10:19, Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> >
> > Currently there is an unlikely case where cpufreq_cpu_get returns a
> > null policy and this will cause a null pointer dereference later on.
> > Fix this by passing the policy to transition_frequency_fidvid from the
> > caller and hence eliminating the need for the cpufreq_cpu_get and
> > cpufreq_cpu_put.  Thanks to Viresh Kumar for suggesting the fix.
> >
> > Addresses-Coverity: ("Dereference null return")
> > Fixes: b43a7ffbf33b ("cpufreq: Notify all policy->cpus in cpufreq_notify_transition()")
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > ---
> >
> > V2: pass the policy to transition_frequency_fidvid rather than add
> >     a null pointer check on the return from a cpufreq_cpu_get call.
> > V3: update subject line to match the fix
> >
> > ---
> >  drivers/cpufreq/powernow-k8.c | 9 +++------
> >  1 file changed, 3 insertions(+), 6 deletions(-)
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied as 5.11-rc material, thanks!

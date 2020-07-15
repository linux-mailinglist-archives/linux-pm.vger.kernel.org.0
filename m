Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACF2220D0F
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jul 2020 14:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730985AbgGOMjD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jul 2020 08:39:03 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39128 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728975AbgGOMjD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jul 2020 08:39:03 -0400
Received: by mail-ot1-f68.google.com with SMTP id 18so1318094otv.6;
        Wed, 15 Jul 2020 05:39:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qEMirJ4iEA7/amJKPxcxC1aWj+9/XnHViK3CvAKtiJ0=;
        b=QAhf7V7FSx5b8wlN/lMBk4IoBkG/jyYs0j35csRjCQkVMUX7kjtbMZAyEHyoagyc3j
         WA+7Ors3l0duNyKg9LLUCk9TxD4WnUaux+V41CxeaX3XJjBm7B5XGuJVd/9RWRXHHU6o
         aD3dO0qOeN0Q+z3BAuSdUXx/tAJoppjQ2bZ+d70h0mLdl3TWsBaGs0f0oL0JmdCpKbKT
         6JpctTKzHlJQxSr0XaWQlxrN7NH5WDfs0TYmL8eNcrbouAzm1Gr5CHZwgq+IiujkLHpA
         Qdcn9rSLOjTQ8zH6ucYJFkMjOehhRIOo7X1udwpHO60zXvnCgEDx2dpeBBDHz0sT2ZAF
         AGWQ==
X-Gm-Message-State: AOAM532HDHSHsKNb5J1lIw7hYWIb8ksq1gu46cHk2lGLt/vCvL9W3EKK
        pQNOSeIsRlvoAQsZIVdC+xoEkIBfUxJs+QlJTMM=
X-Google-Smtp-Source: ABdhPJxvkSkL+mL03a/+kUFCkWVChdwL/udtsAeVBYfe6BwLRVZ83g1tMqK2UpQXTukqQs8HVYr+WcUxT5xBvtdSoFo=
X-Received: by 2002:a9d:590a:: with SMTP id t10mr8727872oth.262.1594816742784;
 Wed, 15 Jul 2020 05:39:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200714145049.2496163-1-lee.jones@linaro.org>
 <20200714145049.2496163-13-lee.jones@linaro.org> <CAJZ5v0jkDWD6Ea2_oEDtFfPDWh5ByphUqEa=3jE2ZbnW0DVEcQ@mail.gmail.com>
 <20200714210306.GI1398296@dell>
In-Reply-To: <20200714210306.GI1398296@dell>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 15 Jul 2020 14:38:51 +0200
Message-ID: <CAJZ5v0jCyfi3Gd83UrC5NJ3QrCceUprT1QMtc4KgROBP2deGuQ@mail.gmail.com>
Subject: Re: [PATCH 12/13] cpufreq: intel_pstate: Supply struct attribute
 description for get_aperf_mperf_shift()
To:     Lee Jones <lee.jones@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 14, 2020 at 11:28 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Tue, 14 Jul 2020, Rafael J. Wysocki wrote:
>
> > On Tue, Jul 14, 2020 at 4:51 PM Lee Jones <lee.jones@linaro.org> wrote:
> > >
> > > Fixes the following W=1 kernel build warning(s):
> > >
> > >  drivers/cpufreq/intel_pstate.c:293: warning: Function parameter or member 'get_aperf_mperf_shift' not described in 'pstate_funcs'
> > >
> > > Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > > Cc: Len Brown <lenb@kernel.org>
> > > Cc: Dirk Brandewie <dirk.j.brandewie@intel.com>
> > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > ---
> > >  drivers/cpufreq/intel_pstate.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> > > index 44c7b4677675d..f92fc69c87269 100644
> > > --- a/drivers/cpufreq/intel_pstate.c
> > > +++ b/drivers/cpufreq/intel_pstate.c
> > > @@ -275,6 +275,8 @@ static struct cpudata **all_cpu_data;
> > >   * @get_min:           Callback to get minimum P state
> > >   * @get_turbo:         Callback to get turbo P state
> > >   * @get_scaling:       Callback to get frequency scaling factor
> > > + * @get_aperf_mperf_shift: Callback to get the number of clock cycles after
> > > + *                     aperf, merf is incremented
> >
> > This added description is inaccurate.  It should be something like
> > "Callback to get the APERF vs MPERF frequency difference".
>
> Does that mean the description of @aperf_mperf_shift above is also
> incorrect?

It is slightly unclear, let me improve it.

Thanks!

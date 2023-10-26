Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF5407D85B5
	for <lists+linux-pm@lfdr.de>; Thu, 26 Oct 2023 17:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbjJZPNq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Oct 2023 11:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbjJZPNq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Oct 2023 11:13:46 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA4518F
        for <linux-pm@vger.kernel.org>; Thu, 26 Oct 2023 08:13:43 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6b36e1fcea0so932457b3a.1
        for <linux-pm@vger.kernel.org>; Thu, 26 Oct 2023 08:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698333223; x=1698938023; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sIQNokBhQSScd068h2R0va+GxK2e4ptgRXBIV8yGO3Q=;
        b=N62rOjtivORs1dnaKyFdptn0As3ebL4e2NRp4MbtpxB9NhDjEp5XfFLDjW5wu9AikT
         v4ZEReFBnrUJnqqwDpG6EOTYtHxx3iZSge7qELAO4/Uvt/M6tPB0cCuQbRw4HPvQs8dz
         6dB9UpZt+wWSe+JfhagQGXCePRB8a/pULdL186CltT7SodHSkcsiYi5/QYd91htniKuv
         18HUO0QyHm44ye30s416GpgwfRB2jxi5uXQVNrVLSaHOqkGWlWTYooI31FEONHkgzsGa
         LRsXBkfmhFTolbfVbWPiSK+V2+oO2gTNsOQhVy5PS+HCBt44Bxii7dpGrdCRJiAbOlhs
         gUBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698333223; x=1698938023;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sIQNokBhQSScd068h2R0va+GxK2e4ptgRXBIV8yGO3Q=;
        b=k0fWLEd/tD8aNawKRItMEhw1eA7XVPg5fMOBul5ubYSxsqf7ocW6hSHkTv8I7Swqza
         hcT9SDMH1XEdmmGE9+2HgCDOpdHQ3GBoFQVIYANe2nG7TmOgipbZb5RyrV5cr1q0XIoO
         iaOLW6TITp+BO0uVM2eDJdcNStrEZ9gK1eEUyrO1GUcNsQ6P8qgUiukJonMsPgnRv61f
         cxfaHAw4nB4QkIPPnB+6IQ6Ok5HzN663SMJjpeCId9Xxdo6BHK+Z2scNXb9nO8SztqPi
         t3QiWi+lUenuxlTRE2dTls2d+dT4rE+zu3R9byLjQ9Ul+2KfLq5yPmLq8+v2AR9ODu+J
         4Cgg==
X-Gm-Message-State: AOJu0YxWoEHw1VxRlH+aaLZm7mmdD0TEiKgXJlJQZ43bl6wcXVZaTNqt
        OhaUOrZciV8RANG+qr2pFDkbuhjrszUdBA6mxroOfg==
X-Google-Smtp-Source: AGHT+IHpvFfxEX2wvpX4oLmokC74kO3PgHJfv15pxMoSpuOPt/vENsjW1mHuLxZFo88vzceGkfO3QCACBcu/EM6N+5k=
X-Received: by 2002:a17:90a:1a43:b0:27d:12e1:94e0 with SMTP id
 3-20020a17090a1a4300b0027d12e194e0mr12590526pjl.36.1698333223116; Thu, 26 Oct
 2023 08:13:43 -0700 (PDT)
MIME-Version: 1.0
References: <20231018162540.667646-1-vincent.guittot@linaro.org>
 <20231018162540.667646-4-vincent.guittot@linaro.org> <f5e398f3-fbb7-4840-9084-14c8254b2118@arm.com>
In-Reply-To: <f5e398f3-fbb7-4840-9084-14c8254b2118@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 26 Oct 2023 17:13:31 +0200
Message-ID: <CAKfTPtBJRT56dL7+UW-viZuK3wKfGimQfrkvtuCQ_20g4N5LPQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] cpufreq/schedutil: use a fixed reference frequency
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, sudeep.holla@arm.com,
        gregkh@linuxfoundation.org, rafael@kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, viresh.kumar@linaro.org, lenb@kernel.org,
        robert.moore@intel.com, lukasz.luba@arm.com,
        ionela.voinescu@arm.com, pierre.gondois@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-acpi@vger.kernel.org, acpica-devel@lists.linuxfoundation.org,
        conor.dooley@microchip.com, suagrfillet@gmail.com,
        ajones@ventanamicro.com, lftan@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 25 Oct 2023 at 22:13, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> On 18/10/2023 18:25, Vincent Guittot wrote:
> > cpuinfo.max_freq can change at runtime because of boost as an example. This
> > implies that the value could be different than the one that has been
> > used when computing the capacity of a CPU.
> >
> > The new arch_scale_freq_ref() returns a fixed and coherent reference
> > frequency that can be used when computing a frequency based on utilization.
> >
> > Use this arch_scale_freq_ref() when available and fallback to
> > policy otherwise.
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
> > Tested-by: Lukasz Luba <lukasz.luba@arm.com>
> >
> > ---
> >  kernel/sched/cpufreq_schedutil.c | 26 ++++++++++++++++++++++++--
> >  1 file changed, 24 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > index 458d359f5991..6e4030482ae8 100644
> > --- a/kernel/sched/cpufreq_schedutil.c
> > +++ b/kernel/sched/cpufreq_schedutil.c
> > @@ -114,6 +114,28 @@ static void sugov_deferred_update(struct sugov_policy *sg_policy)
> >       }
> >  }
> >
> > +/**
> > + * cpufreq_get_capacity_ref_freq - get the reference frequency of a given CPU that
>
> s/cpufreq_get_capacity_ref_freq/get_capacity_ref_freq
>
> s/of a given CPU/for a given cpufreq policy ? (of which the CPU managing
> it is used for the arch_scale_freq_ref() call in the function.
>
> > + * has been used to correlate frequency and compute capacity.
> > + * @policy: the cpufreq policy of the CPU in question.
> > + * @use_current: Fallback to current freq instead of policy->cpuinfo.max_freq.
>
> Looks like use_current does not exists as a parameter.

Thanks for the review. I'm going to apply your comments

>
> > + *
> > + * Return: the reference CPU frequency to compute a capacity.
> > + */
> > +static __always_inline
> > +unsigned long get_capacity_ref_freq(struct cpufreq_policy *policy)
> > +{
> > +     unsigned int freq = arch_scale_freq_ref(policy->cpu);
> > +
> > +     if (freq)
> > +             return freq;
> > +
> > +     if (arch_scale_freq_invariant())
> > +             return policy->cpuinfo.max_freq;
> > +
> > +     return policy->cur;
> > +}
>
> Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
>
>
>

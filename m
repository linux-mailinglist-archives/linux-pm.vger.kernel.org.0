Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29DB17A1FE5
	for <lists+linux-pm@lfdr.de>; Fri, 15 Sep 2023 15:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235250AbjIONgD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Sep 2023 09:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234575AbjIONgC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Sep 2023 09:36:02 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C911BEB
        for <linux-pm@vger.kernel.org>; Fri, 15 Sep 2023 06:35:57 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-271d9823cacso1757573a91.1
        for <linux-pm@vger.kernel.org>; Fri, 15 Sep 2023 06:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694784957; x=1695389757; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OZ8CSbGWetSq5KjL5/lk3LJxa/SsVHXEdQVhCsaB3uQ=;
        b=e03rzlJcRntEqIV3Uqw0KoNz31SrYbmAEcZDfcQti6dJMAb1bzfUSnByULwcD2SfFI
         VrGeXwQpbJF9o9Wd1u5UCLvymFOfxadiv9//cC1u/4rdabxz0ySx6+U/ugbJYPwxpfUi
         e1FwpGHFu7SiSnCTtAmXquoZhkWKvWm1YULiYOseG0P6xgQnc6lbGbhMUybG6lTGynEH
         0NVLj5faI78bwyK+zc/RUeggADWG1LEwMa1IxspZZES21ka/ZTtNUzYZiqIte/1l0VvE
         yBOdOzrLg+vqvYNxwMIfULmRnDo0Mme2+dPOKuRjSpu11bIrZZZa3fNs1TMy5FIFNa4E
         omFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694784957; x=1695389757;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OZ8CSbGWetSq5KjL5/lk3LJxa/SsVHXEdQVhCsaB3uQ=;
        b=shKAcCLIfuAY3DnVxEqmcD25v0tld33L3+CkUXSe5Hb6AQSCfCffMZs2/nuWsIV3TF
         4B7Cd7P+8PsTMSNBNQ9ZtJX7C7h5LC79kM1sqxX+8phfvZu8icVaY8ox/TdQMwjPAlMU
         G3s+oJUvQhxhOMxZryxgZYv7LVtORBZns1AQEx+/4bmLb/5LDYJPmccgmdsX9s0pb0Z9
         O7Ywe1QoE6Kbp/Qle4QHMU8frKx+O8/CKY1FsY6MViAaogZHnekKn9fmnKboTTjp18zS
         OUPCk1dgz8fEv8mqCNS7yXIyBbmA4N2dvFpSozGZnMMC1CY1vWN8Obi8sPh9etYq8h7O
         XWDQ==
X-Gm-Message-State: AOJu0YxR8/rJsXWbt3G+rEINO3pFjTvbpsV9TDsHqQKxCTL40Wur90ir
        su0NFkemoeh/U82PoQpt0XM9IemrbnUfpZU4rU2T1w==
X-Google-Smtp-Source: AGHT+IFwjT0h9F2Ard6U8WLpdM+nhA36OwS1IIu8c2vCtkZ5nia7iOFHTHVgtD7ruyjxTYqWUmmfnL6OvVnvqIMepmU=
X-Received: by 2002:a17:90a:6746:b0:269:524f:2a19 with SMTP id
 c6-20020a17090a674600b00269524f2a19mr1537651pjm.26.1694784957249; Fri, 15 Sep
 2023 06:35:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230901130312.247719-1-vincent.guittot@linaro.org>
 <20230901130312.247719-5-vincent.guittot@linaro.org> <8cfa9edb-67f9-80f9-0a5c-1920f95b338a@arm.com>
In-Reply-To: <8cfa9edb-67f9-80f9-0a5c-1920f95b338a@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 15 Sep 2023 15:35:46 +0200
Message-ID: <CAKfTPtDxJjj6wtpRnLjUi65j+5sQyYcHsQzbd+eSQCf4MVOiWA@mail.gmail.com>
Subject: Re: [PATCH 4/4] energy_model: use a fixed reference frequency
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, sudeep.holla@arm.com,
        gregkh@linuxfoundation.org, rafael@kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, viresh.kumar@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org,
        conor.dooley@microchip.com, suagrfillet@gmail.com,
        ajones@ventanamicro.com, lftan@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 14 Sept 2023 at 23:07, Dietmar Eggemann
<dietmar.eggemann@arm.com> wrote:
>
> On 01/09/2023 15:03, Vincent Guittot wrote:
>
> [...]
>
> > diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
> > index b9caa01dfac4..7ee07be6928e 100644
> > --- a/include/linux/energy_model.h
> > +++ b/include/linux/energy_model.h
> > @@ -204,6 +204,20 @@ struct em_perf_state *em_pd_get_efficient_state(struct em_perf_domain *pd,
> >       return ps;
> >  }
> >
> > +#ifdef arch_scale_freq_ref
> > +static __always_inline
> > +unsigned long  arch_scale_freq_ref_em(int cpu, struct em_perf_domain *pd)
>
> Why is this function named with the arch prefix?
>
> So far we have 5 arch functions (arch_scale_freq_tick() <->
> arch_scale_freq_ref()) and e.g. Arm/Arm64 defines them with there
> topology_foo implementations.
>
> Isn't arch_scale_freq_ref_em() (as well as arch_scale_freq_ref_policy())
> different in this sense and so a proper EM function which should
> manifest in its name?

arch_scale_freq_ref_em() is there to handle cases where
arch_scale_freq_ref() is not defined by arch. I keep arch_ prefix
because this should be provided by architecture which wants to use EM.

In the case of EM, it's only there for allyes|randconfig on arch that
doesn't use arch_topology.c like x86_64

>
> > +{
> > +     return arch_scale_freq_ref(cpu);
> > +}
> > +#else
> > +static __always_inline
> > +unsigned long  arch_scale_freq_ref_em(int cpu, struct em_perf_domain *pd)
> > +{
> > +     return pd->table[pd->nr_perf_states - 1].frequency;
> > +}
> > +#endif
>
> [...]
>
> > @@ -241,11 +255,11 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
> >        */
> >       cpu = cpumask_first(to_cpumask(pd->cpus));
> >       scale_cpu = arch_scale_cpu_capacity(cpu);
> > -     ps = &pd->table[pd->nr_perf_states - 1];
> > +     ref_freq = arch_scale_freq_ref_em(cpu, pd);
>
> Why not using existing `unsigned long freq` here like in schedutil's
> get_next_freq()?

Find it easier to read and understand and will not make any difference
in the compiled code

>
> >
> >       max_util = map_util_perf(max_util);
>
> [...]
>

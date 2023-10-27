Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0712D7D9CC6
	for <lists+linux-pm@lfdr.de>; Fri, 27 Oct 2023 17:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345887AbjJ0PTX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 27 Oct 2023 11:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231785AbjJ0PTW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 27 Oct 2023 11:19:22 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9E818A
        for <linux-pm@vger.kernel.org>; Fri, 27 Oct 2023 08:19:20 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-5b8a88038b4so2511925a12.1
        for <linux-pm@vger.kernel.org>; Fri, 27 Oct 2023 08:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698419960; x=1699024760; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=W/jyxUKjs+ivpArfOLxbtvoP8jhQ6Kn3kdcGQik3464=;
        b=t5dz3JOSfKZgW8Sobzq+LJBU5J1pp60EKogyCKLZ2CwqFxpDX6CpsOZ19rrk5SBNtp
         VZTgFKZ5R13bAqMFf8EALaD+grB8h1bso+csJX7T6+BKCuMHiCKIR3oCDUge40PQv0sP
         bTv25e2d1YI2GOIV3AlzTgKqRF8XqXzmxsnQAv/QnalnMnmZ3rBMN1vxEU//CO3TN7TR
         B8RIJsvcOR6j2T6TO+ru0E6ZRim8p6dMorFviqqVC761UFld3qw0yjY0N3UbAi4ELVFm
         +33ZAaqA5OOw47zMdDFxgmAoOxKLvow315DyoO6+3mjXNO3YGRe6DmrRvwrWR79kfo8r
         mcyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698419960; x=1699024760;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W/jyxUKjs+ivpArfOLxbtvoP8jhQ6Kn3kdcGQik3464=;
        b=K9a9n+Alh79idAV0PhXOSFMXjjh6oJcXx0kuH8c2woo2W4HogS2YSUYKuLhzKFyI4r
         RWMosWHhXlTk95aVqhwgCYOiZQDSrk159BeQAXdPeBla8TmR/U++HtgIXCb6/sEGgZN3
         0cO+I1AcRNB1pSJbOed7OdrALkc6YZaEjWIMtK9Sq7Hz9/+Ins5f3icOhkwNXESF03Bo
         FQzV3QjTTw6GvxUi6RkfKym6cr2qAc8Fc6jEJuBQs/FYVDbCscrlYrbOJSkNOw8gt6VA
         n8dW0qdqJd/9IVlsrbFDVyHUnOtcLJAQ2KHPZLyFsFbFFdUjMZwLAdRQ121jVsF6KmIq
         K09Q==
X-Gm-Message-State: AOJu0YzaypMMiIrT651ajnmdAyvJXPJRv2kEUO9VDZMnoVNOqMR025VI
        mRx0Kr0K59Pcj2twGoP/5T7bJ2cplYrQw0wpsHA8fg==
X-Google-Smtp-Source: AGHT+IGUKBp+yhr0SGL/r8fauv9ZI3qMIv5o/cI5+TiZ/hDpbOWH1EASH2mun47zrYT67G9szswD5PDJM//8CmhEj8w=
X-Received: by 2002:a17:90b:33c8:b0:274:77b3:64d0 with SMTP id
 lk8-20020a17090b33c800b0027477b364d0mr7422882pjb.17.1698419959769; Fri, 27
 Oct 2023 08:19:19 -0700 (PDT)
MIME-Version: 1.0
References: <20231027080400.56703-1-vincent.guittot@linaro.org>
 <20231027080400.56703-2-vincent.guittot@linaro.org> <ZTuDW8lXZLQP1Ruq@gmail.com>
In-Reply-To: <ZTuDW8lXZLQP1Ruq@gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 27 Oct 2023 17:19:07 +0200
Message-ID: <CAKfTPtDgUiY3COzR4xMZ80yKuK2FWNx=wnVXhRTR8vZ6JSnAoA@mail.gmail.com>
Subject: Re: [PATCH v4 1/7] topology: add a new arch_scale_freq_reference
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, sudeep.holla@arm.com,
        gregkh@linuxfoundation.org, rafael@kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        viresh.kumar@linaro.org, lenb@kernel.org, robert.moore@intel.com,
        lukasz.luba@arm.com, ionela.voinescu@arm.com,
        pierre.gondois@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        acpica-devel@lists.linuxfoundation.org, conor.dooley@microchip.com,
        suagrfillet@gmail.com, ajones@ventanamicro.com, lftan@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 27 Oct 2023 at 11:31, Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Vincent Guittot <vincent.guittot@linaro.org> wrote:
>
> > --- a/include/linux/arch_topology.h
> > +++ b/include/linux/arch_topology.h
> > @@ -27,6 +27,13 @@ static inline unsigned long topology_get_cpu_scale(int cpu)
> >
> >  void topology_set_cpu_scale(unsigned int cpu, unsigned long capacity);
> >
> > +DECLARE_PER_CPU(unsigned long, capacity_ref_freq);
> > +
> > +static inline unsigned long topology_get_freq_ref(int cpu)
> > +{
> > +     return per_cpu(capacity_ref_freq, cpu);
> > +}
> > +
> >  DECLARE_PER_CPU(unsigned long, arch_freq_scale);
>
> So mind naming it in a way that expresses that this is indeed a maximum
> frequency? arch_scale_ref_freq_max or so?

This does not always have to be the max frequency of the CPU but the
frequency that has been used to compute the capacity of the CPU so
it's the "reference" frequency used for computing the capacity and
that must be used to compute  the capacity for a given frequency and
the other way. That 's why I have intentionally not used freq_max

Then other similar functions start with arch_scale_freq_something

>
> Also, is there any particular concept behind naming one new symbol
> 'freq_ref', the other 'ref_freq'? If not then please standardize on one
> variant.

no particular reason. ref_freq comes from "reference frequency" but
interfaces follows arch_scale_freq_something or
topology_*_freq_something

so we should keep freq_ref to keep interfaces aligned

>
> Thanks,
>
>         Ingo

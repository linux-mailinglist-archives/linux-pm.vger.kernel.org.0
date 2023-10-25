Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CCEB7D6C62
	for <lists+linux-pm@lfdr.de>; Wed, 25 Oct 2023 14:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234927AbjJYMwE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Oct 2023 08:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343638AbjJYMwC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Oct 2023 08:52:02 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 775E2187
        for <linux-pm@vger.kernel.org>; Wed, 25 Oct 2023 05:51:59 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-27d3ede72f6so4947632a91.1
        for <linux-pm@vger.kernel.org>; Wed, 25 Oct 2023 05:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698238319; x=1698843119; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RvB5kqMmUp8d1e0rOJcbxAUMfkyNt35m6Sgeu0KyMRI=;
        b=mztaV7iFjr0+5+COhpsmf/wpHvLbAoF3+yaQhER4ju9cFd5PIAgaSI87l1o5WgdKbZ
         8JBs6uTfZJgVViQhPANmAHneT69Ecs2M990ESuDG9IzOsxqpe6pGrXXOtvH9w10xn939
         s/8xu2BERIpPvVf+8pWEvx4eZg6lE6pPJB+7ZFlPAodS4AthzJg5CU7H3LclrK6FqXM2
         2lNZx0xGnT8F0p0ZbDxCMi8mCgbgV9sz+DmE0S/myMlYxRRTTbsWXD/FLTkeIts3ty7r
         Sbna1S2/HrBgJGNnW7zFh8qd9BqDhcKgPyUSfnmOksnSDwToT66lwDXmiOtS9Pnk47eq
         42jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698238319; x=1698843119;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RvB5kqMmUp8d1e0rOJcbxAUMfkyNt35m6Sgeu0KyMRI=;
        b=IiH+OqxJj0jXIt7y4w2mndQp/T/5Xb93mBW4dEl8xcfA7KXLt6WV1/R+ej3NojpRv+
         V7ZNwEPNDRoUsdb6IBk7K1SUsWqPRpXr9hdyqT9kIbhTQHY4CtV/s09U11aSeFVknTIq
         Zlfcvb+cGK5oClA6Tfa4+/r2yCx5upsiNBWD2xIlvlx8Pq9kSzcGrxydXuvy/EVWdAir
         MspENDJ7VGH+4MmyE7NxFccweFU44UOKRzXZd8tfi1sG0gytHUC6H3UnXE+MgA1oWmhv
         S99wXfpeaRpie3QVMy0V2TIF7VzHHk5FG1E0AVJShXk1DqfOZAi8d1YO7RMQSEil6Rjc
         42RA==
X-Gm-Message-State: AOJu0YwMIyG4zWoKB7tkozHMxnK8MK/jqDQi73fCmJ+ufXENeR1q4qSM
        xo3DADQ3xeC0JsmJmY5YdiM42GCN8OztdfvPjC+QkA==
X-Google-Smtp-Source: AGHT+IHijcqV2IeYBlPNx3nDgeekbmnpc78OqqMTYbjFqpHUU23WlyO9HzPiT25aLo3D0rYXf7TXF9N6YnljdscPOco=
X-Received: by 2002:a17:90a:800b:b0:26d:43f0:7ce4 with SMTP id
 b11-20020a17090a800b00b0026d43f07ce4mr14485024pjn.8.1698238318938; Wed, 25
 Oct 2023 05:51:58 -0700 (PDT)
MIME-Version: 1.0
References: <20231018162540.667646-1-vincent.guittot@linaro.org>
 <20231018162540.667646-4-vincent.guittot@linaro.org> <20231025115324.GC31201@noisy.programming.kicks-ass.net>
In-Reply-To: <20231025115324.GC31201@noisy.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 25 Oct 2023 14:51:47 +0200
Message-ID: <CAKfTPtDqFy-1dXH51JJ28XdH452K4ACrC3gr-v212s5-hH9RBw@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] cpufreq/schedutil: use a fixed reference frequency
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, sudeep.holla@arm.com,
        gregkh@linuxfoundation.org, rafael@kernel.org, mingo@redhat.com,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, viresh.kumar@linaro.org,
        lenb@kernel.org, robert.moore@intel.com, lukasz.luba@arm.com,
        ionela.voinescu@arm.com, pierre.gondois@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-acpi@vger.kernel.org, acpica-devel@lists.linuxfoundation.org,
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

On Wed, 25 Oct 2023 at 13:53, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Oct 18, 2023 at 06:25:37PM +0200, Vincent Guittot wrote:
>
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
> Hmm, what should x86 do here? I know it mostly doesn't use these things,
> but would it make sense to stick the base frequency in ?

get_capacity_ref_freq() should return the frequency that is used as
the reference for the max compute capacity.

On Arm64, we have seen some inconsistency especially because we use
the energy model, we compute the CPU's capacity at boot and we can
have different compute capacity in our system whereas x86 always uses
SCHED_CAPACITY_SCALE even on hybrid system if I'm not wrong

So I was not sure that this will make any difference for x86 platform

>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

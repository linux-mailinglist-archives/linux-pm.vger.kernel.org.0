Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4F87A1FB2
	for <lists+linux-pm@lfdr.de>; Fri, 15 Sep 2023 15:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235230AbjIONUn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Sep 2023 09:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233006AbjIONUm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Sep 2023 09:20:42 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 564431713
        for <linux-pm@vger.kernel.org>; Fri, 15 Sep 2023 06:20:37 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-2746af1b835so1464315a91.2
        for <linux-pm@vger.kernel.org>; Fri, 15 Sep 2023 06:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694784037; x=1695388837; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BaoDBq4J2WQTMoM6JUbluW9HfoAxhmWc40Mme5H8iVo=;
        b=qLTmk4z/j8Rgs/Y/z2xJvzcsFsNxWeJOcBgx6EzfgdXtYFhjvYc1hOll2SgfQju6hx
         FgDryovX7syL8CribAbv0S9MDeEy5/kMtIkSu1dRg9pt4dwkMcVkf6KIj/VWGPzM5bpJ
         0BK/jhU5uTp93B1++arpeX59XGctwvJ6I6/dlLn8Ent9zZwW7gytH1wZp6XHIcH8yKyC
         FM4LxqHYYdJw9449tkRjM3yJErElZzQkvm13U6QCkBJArI5ELvATd/dYX4WBjg17acJy
         Xz4kBWrLZ9d1FglMgTJ/wlFKAle8p6m9sdCf5a8cZ7USlke3nAo1QvlxNgicV7o1uDWy
         Ejeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694784037; x=1695388837;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BaoDBq4J2WQTMoM6JUbluW9HfoAxhmWc40Mme5H8iVo=;
        b=tv0vGMeC6fts/ydHJroAIxmZTpCG0dIZN1h4Hffxqx8ESnPJWnGppsX0A0cK3TUaFq
         4OAlngRI1KuVpllw0/wOVXaQcCftE/Hu434+QEq0z+/jqG6u6UtFV1mFwftMCuRCsWkj
         Roocs1PD5FQnQ9vnJ7mIFhLYiVMu38XULKbcRdeYniyVm5N7s9szRhHdNlHducMhnnT2
         lbYGMHkCTeqxIWaUThex1eIDkAfzGS6Rw5GBl6WIX9MPgtXqcq9YhED8vvWGuGykoSy0
         Zpu4bZqSL2rRvprcqGfzgcciL253iCjedbxbG/ICJoNflrV79a0azlxWjZYv4l8NWsvS
         Iv/g==
X-Gm-Message-State: AOJu0YypXG/XsKzCyaJv2V9N2DUbG43rIwR4Dg8HFG1xAgVMQcFSCdgu
        7I9DS+3dzz6yY7GYaY3/n6+fW3FvmAB3LYpn1qeLjw==
X-Google-Smtp-Source: AGHT+IEvUA9BR5BcrVOwtToL5WSZnMVL5hq1LhRR/C2UP2bV5CCmF6GnSfYb0YjLTzwW2flky6W/bE61lpkBlQ/Gnuc=
X-Received: by 2002:a17:90a:4b06:b0:26f:2c5a:bbb3 with SMTP id
 g6-20020a17090a4b0600b0026f2c5abbb3mr1316852pjh.40.1694784036728; Fri, 15 Sep
 2023 06:20:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230901130312.247719-1-vincent.guittot@linaro.org>
 <20230901130312.247719-2-vincent.guittot@linaro.org> <be527eb1-d253-b9fe-ecc9-4c7b04da9efd@arm.com>
In-Reply-To: <be527eb1-d253-b9fe-ecc9-4c7b04da9efd@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 15 Sep 2023 15:20:25 +0200
Message-ID: <CAKfTPtANMnLAdw9y86zsx_HdjpWxQPA+Gnaa=qvXC+4xWwNa=A@mail.gmail.com>
Subject: Re: [PATCH 1/4] sched: consolidate and cleanup access to CPU's max
 compute capacity
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

On Thu, 14 Sept 2023 at 22:46, Dietmar Eggemann
<dietmar.eggemann@arm.com> wrote:
>
> On 01/09/2023 15:03, Vincent Guittot wrote:
> > Remove struct rq cpu_capacity_orig field and use arch_scale_cpu_capacity()
> > instead.
> >
> > Scheduler uses 3 methods to get access to the CPU's max compute capacity:
> > - arch_scale_cpu_capacity(cpu) which is the default way to get CPU's capacity.
> > - cpu_capacity_orig field which is periodically updated with
> >   arch_scale_cpu_capacity().
> > - capacity_orig_of(cpu) which encapsulates rq->cpu_capacity_orig
> >
> > There is no real need to save the value returned by arch_scale_cpu_capacity()
> > in struct rq. arch_scale_cpu_capacity() returns:
> > - either a per_cpu variable.
> > - or a const value for systems which have only one capacity.
> >
> > Remove cpu_capacity_orig and use arch_scale_cpu_capacity() everywhere.
> >
> > No functional changes.
> >
> > some tests of Arm64:
> > small SMP device (hikey): no noticeable changes
> > HMP device (RB5): hackbench shows minor improvement (1-2%)
> > large smp (thx2): hackbench and tbench shows minor improvement (1%)
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
>
> Next to util_fits_cpu() which uses capacity_orig as a local variable
> (which is fine) there is sis() referring to capacity_orig in a comment.
>
> Documentation/scheduler/sched-capacity.rst uses the term `capacity_orig`
> in chapter 1.2 to explain the difference between CPU's maximum
> (attainable) capacity and capacity as the former reduced by pressure.

ok, I will have a look at those references to capacity_orig

>
> Not sure if you want to change those refs as well with this patch?
> People might get confused about the term `capacity_orig` pretty soon.
>
> Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

Thanks

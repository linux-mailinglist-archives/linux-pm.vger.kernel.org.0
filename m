Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 582C76ADEE9
	for <lists+linux-pm@lfdr.de>; Tue,  7 Mar 2023 13:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbjCGMjZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Tue, 7 Mar 2023 07:39:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbjCGMjX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Mar 2023 07:39:23 -0500
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC475DED5
        for <linux-pm@vger.kernel.org>; Tue,  7 Mar 2023 04:39:22 -0800 (PST)
Received: by mail-ed1-f45.google.com with SMTP id cw28so51657841edb.5
        for <linux-pm@vger.kernel.org>; Tue, 07 Mar 2023 04:39:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678192760;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KGyNN9KJMeclprx5hS1bksFMh/iFUKsq22LcLzAGvAo=;
        b=NYmoqZCJeI6RUsRaNB3nAiPVBS4niKjBDRURcg/QeNMN5Rm/AOpKykbMzl2NcKgNp5
         6+mvWYKFbxW4NGVMSw6CmzBl/WQhSZC8s2CktLANfs/LGHQbgHzgDIeO6WlOAVfDJk45
         BHo1M8+Ovw411ODXAl7MMwOOO+bDxYmb9dZBVL3ZBWwil2O+YQurCwBC/fsahaayZz+a
         KpYCtLrhRF422CU7B7Q35Yv+2J0QPjNxkKcJ+xm2JAGd2V50xFPXVD71jLV1mO82aS6T
         altiX/xHdw0VX58P9VjMCoN+W5Uicm2HdirDbdHMluOoAg/EryKqGGZ+N/fWtrQs8W+N
         odsg==
X-Gm-Message-State: AO0yUKXvGzGbtclvUzL2p/hXjnlKqmWay1sTzFejQ6r5X/CqYCt7yxaW
        EKcmpa+R6bEgL4h4PcUcI+KagiDJPxQ3qkaZyvY=
X-Google-Smtp-Source: AK7set+ABAAbwn15m3tllIaNVEWYEjwFSyNRyWcrncqJsy7djIn90j8m+i34ZdUgdwYHBWgHCEn7TXe5ltTJWdQ2KH8=
X-Received: by 2002:a17:906:2bcc:b0:895:58be:964 with SMTP id
 n12-20020a1709062bcc00b0089558be0964mr7165673ejg.2.1678192760600; Tue, 07 Mar
 2023 04:39:20 -0800 (PST)
MIME-Version: 1.0
References: <20230306123418.720679-1-dedekind1@gmail.com> <20230306123418.720679-4-dedekind1@gmail.com>
 <20230306153215.GG1267364@hirez.programming.kicks-ass.net>
In-Reply-To: <20230306153215.GG1267364@hirez.programming.kicks-ass.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 7 Mar 2023 13:39:09 +0100
Message-ID: <CAJZ5v0gFrWCdyVNPUoU4tq2vTzcx5WtzvhbXVx1WeyTtt=Gqvg@mail.gmail.com>
Subject: Re: [PATCH 3/3] intel_idle: add C0.2 state for Sapphire Rapids Xeon
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Artem Bityutskiy <dedekind1@gmail.com>, x86@kernel.org,
        Linux PM Mailing List <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Mar 6, 2023 at 4:32 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Mar 06, 2023 at 02:34:18PM +0200, Artem Bityutskiy wrote:
> > @@ -225,6 +229,27 @@ static __cpuidle int intel_idle_s2idle(struct cpuidle_device *dev,
> >       return 0;
> >  }
> >
> > +/**
> > + * intel_idle_umwait_irq - Request C0.x using the 'umwait' instruction.
> > + * @dev: cpuidle device of the target CPU.
> > + * @drv: cpuidle driver (assumed to point to intel_idle_driver).
> > + * @index: Target idle state index.
> > + *
> > + * Request C0.1 or C0.2 using 'umwait' instruction with interrupts enabled.
> > + */
> > +static __cpuidle int intel_idle_umwait_irq(struct cpuidle_device *dev,
> > +                                        struct cpuidle_driver *drv,
> > +                                        int index)
> > +{
> > +     u32 state = flg2MWAIT(drv->states[index].flags);
> > +
> > +     raw_local_irq_enable();
> > +     umwait_idle(rdtsc() + umwait_limit, state);
> > +     local_irq_disable();
> > +
> > +     return index;
> > +}
>
> Bad copy paste job there...
>
> vmlinux.o: warning: objtool: intel_idle_umwait_irq+0x8c: call to trace_hardirqs_off() leaves .noinstr.text section

Well, it would be kind of nice to say that this is related to commit
6d9c7f51b1d9 ("cpuidle, intel_idle: Fix CPUIDLE_FLAG_IRQ_ENABLE
*again*") that is present in 6.3-rc1.

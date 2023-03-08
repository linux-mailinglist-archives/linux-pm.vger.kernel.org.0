Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 811476B0723
	for <lists+linux-pm@lfdr.de>; Wed,  8 Mar 2023 13:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbjCHMci (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Mar 2023 07:32:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjCHMch (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Mar 2023 07:32:37 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27548BF381
        for <linux-pm@vger.kernel.org>; Wed,  8 Mar 2023 04:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=g93j4sciifNtiIViZbXDGczP+j4YLGkmpu+N4lDCjjc=; b=ZG848N/AgvGqDRdrHvyONe1klq
        r8a5Xof91zLbheBahdQ57aDCulA14cBb1yd05PtVtRWo9M6GM9L2eCUHXQ91dTXZZO5Fj3ct/dKZt
        sF58v+QZaGsd+vOW1g6ZHuaZzipYT3VpV/IVhTmOT9hmlQ0G4xIwAfuvRlf4oyy6hy8adjN+I6KDV
        bkEjcnAxmswvIQleGpedJiiMy4SPA8f9+ov73DvLOiMvFl8oY601p7nCrG8K4RGo7GFkwsS0Z0X++
        RN07Jv6hilCLIWBwWiY718qOORee3S+goYK8FtXupmpRAc4sDU1cHoXk/7wiQSPkUJQmsb7RNRBbW
        F2XgbJKQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pZsy0-00HNbM-2X;
        Wed, 08 Mar 2023 12:32:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 17FA83001E5;
        Wed,  8 Mar 2023 13:32:23 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DAD47202648EA; Wed,  8 Mar 2023 13:32:22 +0100 (CET)
Date:   Wed, 8 Mar 2023 13:32:22 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Artem Bityutskiy <dedekind1@gmail.com>, x86@kernel.org,
        Linux PM Mailing List <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 3/3] intel_idle: add C0.2 state for Sapphire Rapids Xeon
Message-ID: <20230308123222.GF2017917@hirez.programming.kicks-ass.net>
References: <20230306123418.720679-1-dedekind1@gmail.com>
 <20230306123418.720679-4-dedekind1@gmail.com>
 <20230306153215.GG1267364@hirez.programming.kicks-ass.net>
 <CAJZ5v0gFrWCdyVNPUoU4tq2vTzcx5WtzvhbXVx1WeyTtt=Gqvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gFrWCdyVNPUoU4tq2vTzcx5WtzvhbXVx1WeyTtt=Gqvg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Mar 07, 2023 at 01:39:09PM +0100, Rafael J. Wysocki wrote:
> On Mon, Mar 6, 2023 at 4:32 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Mon, Mar 06, 2023 at 02:34:18PM +0200, Artem Bityutskiy wrote:
> > > @@ -225,6 +229,27 @@ static __cpuidle int intel_idle_s2idle(struct cpuidle_device *dev,
> > >       return 0;
> > >  }
> > >
> > > +/**
> > > + * intel_idle_umwait_irq - Request C0.x using the 'umwait' instruction.
> > > + * @dev: cpuidle device of the target CPU.
> > > + * @drv: cpuidle driver (assumed to point to intel_idle_driver).
> > > + * @index: Target idle state index.
> > > + *
> > > + * Request C0.1 or C0.2 using 'umwait' instruction with interrupts enabled.
> > > + */
> > > +static __cpuidle int intel_idle_umwait_irq(struct cpuidle_device *dev,
> > > +                                        struct cpuidle_driver *drv,
> > > +                                        int index)
> > > +{
> > > +     u32 state = flg2MWAIT(drv->states[index].flags);
> > > +
> > > +     raw_local_irq_enable();
> > > +     umwait_idle(rdtsc() + umwait_limit, state);
> > > +     local_irq_disable();
> > > +
> > > +     return index;
> > > +}
> >
> > Bad copy paste job there...
> >
> > vmlinux.o: warning: objtool: intel_idle_umwait_irq+0x8c: call to trace_hardirqs_off() leaves .noinstr.text section
> 
> Well, it would be kind of nice to say that this is related to commit
> 6d9c7f51b1d9 ("cpuidle, intel_idle: Fix CPUIDLE_FLAG_IRQ_ENABLE
> *again*") that is present in 6.3-rc1.

Right, but he said the patches were based on -next, which would've had
that commit for a fair while too.

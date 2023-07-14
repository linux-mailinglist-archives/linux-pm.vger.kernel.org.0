Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 654E075440D
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jul 2023 23:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233912AbjGNVBp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Jul 2023 17:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjGNVBo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Jul 2023 17:01:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7CB213C
        for <linux-pm@vger.kernel.org>; Fri, 14 Jul 2023 14:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=LEGwiRpA+dxASTbn24Hm/jT/cS+Pgru7YSUIxTFLyYc=; b=vlHST921tZ97DNJDeHVm7ddTLW
        nDTl7zJZCv3nScXDpmmOILyxq/xawGnCSNfm7XhCJsCWFQR22qaT4ZXTTTDwVlbupjbtKyLHIdvIj
        aYLqsRPpsNvXAee+Jke2ORrk4tIRnBapih0FPZxECu8YjDUdp7fYTMfQAYqRMFKvgtZPa9RAl/nHl
        axNpEPKQJ4j1Z8XzFvpag2OBOkOyrgKouF79+Fg7scDpbZP4ovAFXze43ZMMIA4/yKSzCFt4n+Gx4
        y7YjcF5GpyXf+EvnOuu6IJ53qndAASO7jKTw07prVUhAmu/n5Z7su4pobjvq9WdUsUQ+zcaJZcgE7
        fc/L8DDA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qKPuw-001O9C-Uu; Fri, 14 Jul 2023 21:01:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 169D03001FD;
        Fri, 14 Jul 2023 23:01:33 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E789221372899; Fri, 14 Jul 2023 23:01:32 +0200 (CEST)
Date:   Fri, 14 Jul 2023 23:01:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Artem Bityutskiy <dedekind1@gmail.com>, x86@kernel.org,
        Linux PM Mailing List <linux-pm@vger.kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v4 3/4] intel_idle: rename 'intel_idle_hlt_irq_on()'
Message-ID: <20230714210132.GA3275140@hirez.programming.kicks-ass.net>
References: <20230710093100.918337-1-dedekind1@gmail.com>
 <20230710093100.918337-4-dedekind1@gmail.com>
 <CAJZ5v0hb9ns2yZ==n83viqniCr4QqupY+FKR2Dy0jE0Obahq_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0hb9ns2yZ==n83viqniCr4QqupY+FKR2Dy0jE0Obahq_g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jul 14, 2023 at 05:34:43PM +0200, Rafael J. Wysocki wrote:
> On Mon, Jul 10, 2023 at 11:31 AM Artem Bityutskiy <dedekind1@gmail.com> wrote:
> >
> > From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> >
> > Rename 'intel_idle_hlt_irq_on()' to 'intel_idle_hlt_irq()' for consistency with
> > 'intel_idle_irq()'.
> >
> > While on it, fix indentation in 'intel_idle_hlt_irq()' declaration to use tabs
> > instead of white-spaces.
> >
> > Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> 
> I think I can apply this right away without the rest of the series as
> it doesn't seem to depend on the other patches.
> 
> Any concerns regarding this?

Yeah, as per:

  https://lkml.kernel.org/r/20230711132553.GN3062772%40hirez.programming.kicks-ass.net

that function is complete drivel, renaming it isn't going to help.

In fact, I don't buy the whole premise of that intel_idle guest mode
stuff, can we please just delete all of that and start over?

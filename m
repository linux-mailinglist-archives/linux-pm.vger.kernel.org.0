Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8433B754423
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jul 2023 23:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236054AbjGNVMd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Jul 2023 17:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236473AbjGNVMb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Jul 2023 17:12:31 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27653A9F
        for <linux-pm@vger.kernel.org>; Fri, 14 Jul 2023 14:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=fHNe3mg1So3+jmX3xDx5Uh8SmNCOdkOQS2IdW+rBsFE=; b=QFzoNRHRNpuJTG7zDyi20NUN+A
        kon6x/q2bQa9vV5Fq4Q3LgFfJRUDgcWq5eKk6+dn6cIehOYOxhZzaoimJhdpKwSzQQh4WAoJsxnSZ
        LmZEzji+BtG0yNbGR+RpcHfSfOK/SocLh0wb1ZOseo0+vOh1w6WZhgvxAjgQuosgTLbQSmK7woOkd
        OpyotZjvukWXv3NE1YeqN2cVTBR121sNpsVYyKVwOsEjhph7LLCCe0bUHA4nHUgssGjrD6ppp+YC5
        bpi4sYf6k1jTu5jZRsAbshd+Op/pwYsW2UncAScRL6savtmxJIb7cWhIGI1MexFP51GNBlAPG53m1
        wlMY4Shg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qKQ5K-006NcR-2e;
        Fri, 14 Jul 2023 21:12:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 764F430023F;
        Fri, 14 Jul 2023 23:12:18 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 67FA021372891; Fri, 14 Jul 2023 23:12:18 +0200 (CEST)
Date:   Fri, 14 Jul 2023 23:12:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Arjan van de Ven <arjan@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Artem Bityutskiy <dedekind1@gmail.com>, x86@kernel.org,
        Linux PM Mailing List <linux-pm@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v4 3/4] intel_idle: rename 'intel_idle_hlt_irq_on()'
Message-ID: <20230714211218.GD3275140@hirez.programming.kicks-ass.net>
References: <20230710093100.918337-1-dedekind1@gmail.com>
 <20230710093100.918337-4-dedekind1@gmail.com>
 <CAJZ5v0hb9ns2yZ==n83viqniCr4QqupY+FKR2Dy0jE0Obahq_g@mail.gmail.com>
 <20230714210132.GA3275140@hirez.programming.kicks-ass.net>
 <6dd1be2f-184b-fc0e-da28-c2244aed9d70@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6dd1be2f-184b-fc0e-da28-c2244aed9d70@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jul 14, 2023 at 02:02:51PM -0700, Arjan van de Ven wrote:
> On 7/14/2023 2:01 PM, Peter Zijlstra wrote:
> > On Fri, Jul 14, 2023 at 05:34:43PM +0200, Rafael J. Wysocki wrote:
> > > On Mon, Jul 10, 2023 at 11:31 AM Artem Bityutskiy <dedekind1@gmail.com> wrote:
> > > > 
> > > > From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> > > > 
> > > > Rename 'intel_idle_hlt_irq_on()' to 'intel_idle_hlt_irq()' for consistency with
> > > > 'intel_idle_irq()'.
> > > > 
> > > > While on it, fix indentation in 'intel_idle_hlt_irq()' declaration to use tabs
> > > > instead of white-spaces.
> > > > 
> > > > Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> > > 
> > > I think I can apply this right away without the rest of the series as
> > > it doesn't seem to depend on the other patches.
> > > 
> > > Any concerns regarding this?
> > 
> > Yeah, as per:
> > 
> >    https://lkml.kernel.org/r/20230711132553.GN3062772%40hirez.programming.kicks-ass.net
> 
> and it's going to get deleted - renaming is harmless for that

Yeah, but what's the point, why waste more commits on this?

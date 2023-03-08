Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC526B0731
	for <lists+linux-pm@lfdr.de>; Wed,  8 Mar 2023 13:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbjCHMfO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Mar 2023 07:35:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjCHMfK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Mar 2023 07:35:10 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6232FBCFCE
        for <linux-pm@vger.kernel.org>; Wed,  8 Mar 2023 04:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=IC76Uj3MliMRjbnHSSXxLEmrdt8NTTVNvjgl4QoBL4Y=; b=eXi8TE/wDWMHfH62RE3JU9ZwEU
        KMbHCPLiVDxkP1KLmBufVN7s9/B9lBBokIC7lUkrFoi4i0SrA0nqjrM/OQt01Fph/MdrR25/ij+Dq
        kgFmsckq/oZa6n5LpN8XoD66GcILUTb7LXsWkxyOvJmJ23eyCVUgjO0WMSj5zYfTUBv22vIyibYCU
        Co/i1RALfebR6XR2W/L7llmx4F312uP9/wovQCbwOA1KhU7UlFyFP/swfSWbTqJVj+PjGTuCiUyXk
        QBpF0P5WCwhDc6EFvkhKIRFWFBRhON04bnrNubFngvmwtleYNj/2eVqbAQcQVV066j86AkzcGdehb
        Rr8lLtug==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pZt0b-00HNeM-2W;
        Wed, 08 Mar 2023 12:35:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3B6C2300193;
        Wed,  8 Mar 2023 13:35:05 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1D1A1202648EA; Wed,  8 Mar 2023 13:35:05 +0100 (CET)
Date:   Wed, 8 Mar 2023 13:35:05 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Artem Bityutskiy <dedekind1@gmail.com>, x86@kernel.org,
        Linux PM Mailing List <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 1/3] x86/mwait: Add support for idle via umwait
Message-ID: <20230308123505.GG2017917@hirez.programming.kicks-ass.net>
References: <20230306123418.720679-1-dedekind1@gmail.com>
 <20230306123418.720679-2-dedekind1@gmail.com>
 <20230306145524.GF1267364@hirez.programming.kicks-ass.net>
 <CAJZ5v0iAitp+4UHfSJWyNACYthRHCSj5nBpJ1_5Zzq4fnJNKeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0iAitp+4UHfSJWyNACYthRHCSj5nBpJ1_5Zzq4fnJNKeA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Mar 07, 2023 at 12:55:45PM +0100, Rafael J. Wysocki wrote:
> On Mon, Mar 6, 2023 at 3:56 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Mon, Mar 06, 2023 at 02:34:16PM +0200, Artem Bityutskiy wrote:
> > > From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> > >
> > > On Intel platforms, C-states are requested using the 'monitor/mwait'
> > > instructions pair, as implemented in 'mwait_idle_with_hints()'. This
> > > mechanism allows for entering C1 and deeper C-states.
> > >
> > > Sapphire Rapids Xeon supports new idle states - C0.1 and C0.2 (later C0.x).
> > > These idle states have lower latency comparing to C1, and can be requested
> > > with either 'tpause' and 'umwait' instructions.
> > >
> > > Linux already uses the 'tpause' instruction in delay functions like
> > > 'udelay()'. This patch adds 'umwait' and 'umonitor' instructions support.
> > >
> > > 'umwait' and 'tpause' instructions are very similar - both send the CPU to
> > > C0.x and have the same break out rules. But unlike 'tpause', 'umwait' works
> > > together with 'umonitor' and exits the C0.x when the monitored memory
> > > address is modified (similar idea as with 'monitor/mwait').
> > >
> > > This patch implements the 'umwait_idle()' function, which works very
> > > similarly to existing 'mwait_idle_with_hints()', but requests C0.x. The
> > > intention is to use it from the 'intel_idle' driver.
> >
> > Still wondering wth regular mwait can't access these new idle states.
> 
> But is this a question for Artem to answer?

Maybe, maybe not, but I did want to call out this 'design' in public. It
is really weird IMO.

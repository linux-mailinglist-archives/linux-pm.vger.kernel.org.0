Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA5FB6C475B
	for <lists+linux-pm@lfdr.de>; Wed, 22 Mar 2023 11:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbjCVKSO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 Mar 2023 06:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjCVKSO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 Mar 2023 06:18:14 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70202448A
        for <linux-pm@vger.kernel.org>; Wed, 22 Mar 2023 03:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GtmtFfb5Qcuqutz98F+7yP39Yz6cwkW+1BQR2iODtZo=; b=XrY/XWit6oGXmhapluKC0rCrzt
        J8xb4GB40eVNQGyzqXWuUpTc27gTY0vLFtEZZ+2oELcIwpjieSC00Uc6Uia6Bm8sinFXIfzX0Jy5U
        yzQ1PJRLLUXssNtMEJpJ7aYYQIKr5aXzyf8s2Ka6FK7Cryzc9WDUwTTzzFiYo8eCZu65RjkrQYRue
        vvGWVHCfxe56JYF+3lMArPM1MB/csqlwtkLiLGiVpkU/hil6mEYJrCgaDbFQ3ry0MKIiTlRR4CVy5
        BAqm3vxRPRb1BAbI/kkcyri1l7QwVvtn268vfopY8nfsj6MOveAzrc++7RZkz0tZsE6VE4h+DsTd2
        TMSs5prQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pevXk-004X9z-2H;
        Wed, 22 Mar 2023 10:18:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3CCCC3002FC;
        Wed, 22 Mar 2023 11:18:08 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1BE0E2408A2F9; Wed, 22 Mar 2023 11:18:08 +0100 (CET)
Date:   Wed, 22 Mar 2023 11:18:08 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Artem Bityutskiy <dedekind1@gmail.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux PM Mailing List <linux-pm@vger.kernel.org>,
        "luto@amacapital.net" <luto@amacapital.net>
Subject: Re: [PATCH v2 3/3] intel_idle: add C0.2 state for Sapphire Rapids
 Xeon
Message-ID: <20230322101808.GU2017917@hirez.programming.kicks-ass.net>
References: <20230310122110.895093-1-dedekind1@gmail.com>
 <20230310122110.895093-4-dedekind1@gmail.com>
 <20230320145034.GM2194297@hirez.programming.kicks-ass.net>
 <05fdea5a-bfad-4d7c-9925-9a45b2882782@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05fdea5a-bfad-4d7c-9925-9a45b2882782@app.fastmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Mar 20, 2023 at 11:27:54AM -0700, Andy Lutomirski wrote:

> This is all busted.

Well, yes.

> UMWAIT has a U for *user mode*.  We have the MSR set to a small value
> because USER waits are a big can of worms, and long user waits don't
> actually behave in any particularly intelligent manner unless that
> core is dedicated to just one user task, and no virt is involved, and
> the user code involved is extremely careful.

Idem for virt. [U]MWAIT only really works for virt when the CPU is
dedicated to the one (vcpu) task.

> But now UMWAIT got extended in a way to make it useful for the kernel,
> but it's controlled by the same MSR.  And this is busted.  What we
> want is for CPL0 UMWAIT to ignore the MSR or use a different MSR (for
> virt, sigh, except that this whole mechanism is presuambly still
> useless on virt).  Or for a different instruction to be used from the
> kernel, maybe spelled MWAIT.

Yes, CPL0 usage should not be subject to the same limit. I'm not sure if
there's a good argument to have a different limit on virt vs random
other userspace.

> Also, this series needs to be tested on virt.  Because UMWAIT, if it
> works at all on virt, is going to have all manner of odd concequences
> due to the fact that the hypervisor hasn't the faintest clue what's
> going on because there's no feedback.  For all that UiPI is nasty and
> half-baked, at least it tries to notify the next privilege level up as
> to what's going on.  Explicit wakeups virtualize much better than
> cacheline monitors.

Virt is supposedly a big trumpet case for UMWAIT because VMMs
(rightfully) restrict MWAIT. At the same time, you *REALLY* do not want
your vcpu task doing long UMWAITs when there's other vcpu threads
waiting to do real work, so the MSR value *SHOULD* be really low.

Increasing this value randomly is bad.. increasing it beyond 1 tick is
abysmal.

Unless dedicated vcpu:cpu relations, in which case kvm already should be
exposing MWAIT in any case.

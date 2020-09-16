Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5C5D26BEFA
	for <lists+linux-pm@lfdr.de>; Wed, 16 Sep 2020 10:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbgIPIRe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Sep 2020 04:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgIPIRd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Sep 2020 04:17:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 273CDC06174A;
        Wed, 16 Sep 2020 01:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Kh6YUXUrBNEvAabKe5sOkZzm5XNcGGAK/6w734vH3zI=; b=Z1F+9jUxoSdp/6tvJG54Cr1c5e
        2xs1aVE1vuFmzk8PvUT8kk2V7fZ5WRQ8B/0nhpsiuzOC934Gb0i2t2jzMeYXnIe3z4XgO5fly3Gue
        OT/izm1DVeqqzb0lYFDs3AVyb07i4cYVTGbM5Kys20DfAaOo13zXxqmXsUSyeWKPkHV6V1F5p5QU0
        jPyLuEOkeT/4xAJ5b+l7b2PYmnT0OA5ifW9iVsWMtcrykv0pZOjQaNyNMRhr/zW8a2S5RDBRRBMhp
        G6Dxw6T7PXzFoYHSRMdq3gSTabM600YaSaw5TVQsa6CrtJndi/biswTGBH6HpGicydVfPdlmfk56Q
        K4SpVsAg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kIScn-0006Eg-OF; Wed, 16 Sep 2020 08:17:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A89BE305815;
        Wed, 16 Sep 2020 10:17:08 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 94CA92C27E219; Wed, 16 Sep 2020 10:17:08 +0200 (CEST)
Date:   Wed, 16 Sep 2020 10:17:08 +0200
From:   peterz@infradead.org
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Borislav Petkov <bp@alien8.de>, Roman Kiryanov <rkir@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        linux-pm@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Alistair Delva <adelva@google.com>,
        Haitao Shan <hshan@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>
Subject: Re: [PATCH] arch: x86: power: cpu: init %gs before
 __restore_processor_state (clang)
Message-ID: <20200916081708.GK2674@hirez.programming.kicks-ass.net>
References: <20200915172658.1432732-1-rkir@google.com>
 <20200915174643.GT14436@zn.tnic>
 <CAKwvOdm9bQmL=gZypkosH0MG=S28=jJ6wZiTMCNP6=Z+NfN1AA@mail.gmail.com>
 <20200915182530.GV14436@zn.tnic>
 <CAKwvOdkKk1KuAFDoWNLnMUi3_JnV7atDFnvS7CdkgNXnNg0p1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdkKk1KuAFDoWNLnMUi3_JnV7atDFnvS7CdkgNXnNg0p1g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Sep 15, 2020 at 12:51:47PM -0700, Nick Desaulniers wrote:
> It would be much nicer if we had the flexibility to disable stack
> protectors per function, rather than per translation unit.  I'm going
> to encourage you to encourage your favorite compile vendor ("write to
> your senator") to support the function attribute
> __attribute__((no_stack_protector)) so that one day, we can use that
> to stop shipping crap like a9a3ed1eff360 ("x86: Fix early boot crash
> on gcc-10, third try"). 

I think we were all in favour of having that, not sure why it hasn't
happened yet. More important matters I suppose :/

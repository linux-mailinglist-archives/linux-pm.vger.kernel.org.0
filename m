Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51F43312DF8
	for <lists+linux-pm@lfdr.de>; Mon,  8 Feb 2021 10:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbhBHJwA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Feb 2021 04:52:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:32806 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231734AbhBHJsO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 8 Feb 2021 04:48:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 92CADAE52;
        Mon,  8 Feb 2021 09:47:32 +0000 (UTC)
Date:   Mon, 8 Feb 2021 10:47:29 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        rcu@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>,
        X86 ML <x86@kernel.org>, lkft-triage@lists.linaro.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, rui.zhang@intel.com,
        Borislav Petkov <bp@alien8.de>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: WARNING: at arch/x86/kernel/irq.c:390 thermal_set_handler
Message-ID: <20210208094729.GA17908@zn.tnic>
References: <CA+G9fYtURD4R+KT+5mFHxYNZSPbmhBF9rS+RXaFqyZhV+k-U3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYtURD4R+KT+5mFHxYNZSPbmhBF9rS+RXaFqyZhV+k-U3g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Feb 08, 2021 at 03:01:39PM +0530, Naresh Kamboju wrote:
> The following kernel warning noticed on Linux next tag 20210205 while booting
> x86_64 and i386.
> 
> step to reproduce:
>   - Boot linux next tag 20210205 on x86_64
>   - While booting you will notice the below warning
> 
> 
> [    1.046552] ------------[ cut here ]------------
> [    1.046552] WARNING: CPU: 1 PID: 0 at arch/x86/kernel/irq.c:390
> thermal_set_handler+0x31/0x40

This has been reworked into:

https://lkml.kernel.org/r/20210201142704.12495-1-bp@alien8.de

and I'll queue it later.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg

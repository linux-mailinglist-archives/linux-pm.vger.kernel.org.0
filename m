Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01F122CD32C
	for <lists+linux-pm@lfdr.de>; Thu,  3 Dec 2020 11:06:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388527AbgLCKFz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Dec 2020 05:05:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388501AbgLCKFy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Dec 2020 05:05:54 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A037C061A4F;
        Thu,  3 Dec 2020 02:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=0oCifexuK7HOXM8h8g6CDA6pzYc9XTvaQ9l7Cn1Yimw=; b=jHxb5b+521zqEZ9o4ilTdiC1nv
        /GYu1rQHRBwdvIEZ/73GeurDGmUm50Jut7MDfzxnsrXROc/QT6UrWTAl12koDGnrs5u4i9bMU5VH7
        /XHQlgnylRsZ0PjCG/NWjmgCCgMt/9DSTIYC6FCvfo68RfS8gg797EPu0UPXvw1mKtiYthqUoq54n
        ONgFdJT/bBkpQJfsXePkK15v04duxCcNgKeIsrU+aS+OsvfIpBMf/QzPToQxPG3+w4oCs0c8RqBmp
        ZPz2rZP1nEBZyWmLivAbyDOvSIYJilx3Z0ES4o5/7bPBhEwNudGELWP9qNcfKOiLjyGDx6zyCPG0G
        Obqfi6SA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kklU5-000668-QN; Thu, 03 Dec 2020 10:05:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 70625302753;
        Thu,  3 Dec 2020 11:05:07 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 60C0220D20FFA; Thu,  3 Dec 2020 11:05:07 +0100 (CET)
Date:   Thu, 3 Dec 2020 11:05:07 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Rui Salvaterra <rsalvaterra@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG] intel_idle: build failure on Linux 5.10-rc6
Message-ID: <20201203100507.GI2414@hirez.programming.kicks-ass.net>
References: <CALjTZvYX5opqV4xDcQefE3U1h22E0nkOR7R9WN4pBqrXBmq0Rg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALjTZvYX5opqV4xDcQefE3U1h22E0nkOR7R9WN4pBqrXBmq0Rg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Dec 03, 2020 at 09:23:11AM +0000, Rui Salvaterra wrote:
> Hi, Peter,
> 
> I'm sorry to bother you, but commit
> 6e1d2bc675bd57640f5658a4a657ae488db4c204 ("intel_idle: Fix
> intel_idle() vs tracing") broke my build, when CONFIG_ACPI_PROCESSOR
> is disabled (possibly because it selects CONFIG_ACPI_PROCESSOR_IDLE):
> 
> drivers/idle/intel_idle.c: In function ‘intel_idle_init_cstates_icpu’:
> drivers/idle/intel_idle.c:1510:7: error: implicit declaration of
> function ‘intel_idle_state_needs_timer_stop’
> [-Werror=implicit-function-declaration]
>  1510 |   if (intel_idle_state_needs_timer_stop(&drv->states[drv->state_count]))
>       |       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Reverting the aforementioned commit fixes it. Config attached. Please
> let me know if you need anything else!

Yeah sorry about that, just queued the build fix.

https://git.kernel.org/tip/4d916140bf28ff027997144ea1bb4299e1536f87

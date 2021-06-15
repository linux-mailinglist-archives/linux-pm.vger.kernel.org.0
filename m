Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0572A3A8B2A
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jun 2021 23:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhFOViP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Jun 2021 17:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbhFOViP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Jun 2021 17:38:15 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51CA1C061574;
        Tue, 15 Jun 2021 14:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Wi0fmY7/5hNcSRx+LpL3yzYhlga9NyYasEWcqt5QiSM=; b=LTiLUzP37yrcJqmTwnAMCelrFi
        BHKUcaRiw5KI29DxzdAonJTD7rlvY0U7iEOEJ17385Tj3gF8vD4gKyzDjfoZDHAKxIEXl6yjDKtMX
        DIBJR+sebgpwpmmNAY2aQfUnk0zk/Xe595kYMGrBfTLLB9Bq/fgpW70lJc+nzsyJAGXMBuADF/5xG
        2HObnUtO3Iko6GERvvDa5W8r5ZsJEPmZTxfPSVYrgq7prwS+v3+Hp9g3Dv/5gPBwUlWbND3B0m8yk
        29nK+Eiga3ixQzkSUf0y+jgIhRg2PB3KbZHi+kzhAByMGcdS6oTWODSQDguwLOJt7+XIf5ZtyaHKs
        Zkd9ELyA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ltGiH-00876K-55; Tue, 15 Jun 2021 21:35:38 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 94202982227; Tue, 15 Jun 2021 23:35:18 +0200 (CEST)
Date:   Tue, 15 Jun 2021 23:35:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     rjw@rjwysocki.net, mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        Will Deacon <will@kernel.org>, Tejun Heo <tj@kernel.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] freezer,sched: Rewrite core freezer logic
Message-ID: <20210615213518.GC4272@worktop.programming.kicks-ass.net>
References: <YMMijNqaLDbS3sIv@hirez.programming.kicks-ass.net>
 <20210614154246.GB13677@redhat.com>
 <20210614161221.GC68749@worktop.programming.kicks-ass.net>
 <20210614165422.GC13677@redhat.com>
 <20210614183801.GE68749@worktop.programming.kicks-ass.net>
 <20210615154539.GA30333@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210615154539.GA30333@redhat.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jun 15, 2021 at 05:45:39PM +0200, Oleg Nesterov wrote:

> But this reminds me... can't we implement selective wakeups? So that if a
> task T sleeps in state = STOPPED | FROZEN, then ttwu(T, FROZEN) won't wake
> it up, it will only clear FROZEN from T->state. Similarly, ttwu(T, STOPPED)
> will leave this task with state == FROZEN.

All this started because I didn't want to touch the wakeup path for
freezing :/

> See also
> 
> 	https://lore.kernel.org/lkml/20131112162136.GA29065@redhat.com/
> 	https://lore.kernel.org/lkml/20131113170724.GA17739@redhat.com/
> 
> just to remind you that we already discussed TASK_FROZEN a little bit almost
> 10 years ago ;)
> 
> What has been shall be, and what has been done is what will be done, and
> there is nothing new under the sun.

Ha!, I had completely forgotten.

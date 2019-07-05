Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 017DD6054F
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2019 13:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbfGELiW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Jul 2019 07:38:22 -0400
Received: from merlin.infradead.org ([205.233.59.134]:33974 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbfGELiV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Jul 2019 07:38:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=lB8z0jtulGzmPbIejumDh4AviELPAnIF6LFnZL8rAIQ=; b=jYcoqeXkjry3ASEOSiR/KLv9c/
        qbgnuhLFKF2sUZQWtKNsrdmb8jFYgrwGoUzK7RYSnRCaqZORA1qHd7+0a/yrerz5Aa5paxOMd+NIc
        ypvBZQnUd5/37xnDbiBvuGz7IjWHmys92gukvnU2sOqd4jtR0M69af+vtSEg5hgLnXbP6VfeLYZ6y
        WfjL2NJszrBsXOyIPg+D69Ae1tOn4Z+Eh5A+YLcW2DymOzH3N3bqe7sI8kpeNtbM1BJyad3RXASY9
        CTMF9FwLVhEg4+JLFhKA75OqHeKbelQP7inVyAk6LccZHnMc/Z37WXSb1zGHcQiMWoybpiJlli32T
        oZYSlF3g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hjMXZ-0001O7-45; Fri, 05 Jul 2019 11:38:09 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8018F2026E806; Fri,  5 Jul 2019 13:38:06 +0200 (CEST)
Date:   Fri, 5 Jul 2019 13:38:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alan Jenkins <alan.christopher.jenkins@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Doug Smythies <dsmythies@telus.net>, linux-pm@vger.kernel.org
Subject: Re: iowait v.s. idle accounting is "inconsistent" - iowait is too low
Message-ID: <20190705113806.GP3402@hirez.programming.kicks-ass.net>
References: <2ff025f1-9a3e-3eae-452b-ef84824009b4@gmail.com>
 <000001d531a8$8931b2a0$9b9517e0$@net>
 <e82b9d7c-81e5-dd80-b9c0-f5f065344e2f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e82b9d7c-81e5-dd80-b9c0-f5f065344e2f@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jul 05, 2019 at 12:25:46PM +0100, Alan Jenkins wrote:
> Hi, scheduler experts!
> 
> My cpu "iowait" time appears to be reported incorrectly.  Do you know why
> this could happen?

Because iowait is a magic random number that has no sane meaning.
Personally I'd prefer to just delete the whole thing, except ABI :/

Also see the comment near nr_iowait():

/*
 * IO-wait accounting, and how its mostly bollocks (on SMP).
 *
 * The idea behind IO-wait account is to account the idle time that we could
 * have spend running if it were not for IO. That is, if we were to improve the
 * storage performance, we'd have a proportional reduction in IO-wait time.
 *
 * This all works nicely on UP, where, when a task blocks on IO, we account
 * idle time as IO-wait, because if the storage were faster, it could've been
 * running and we'd not be idle.
 *
 * This has been extended to SMP, by doing the same for each CPU. This however
 * is broken.
 *
 * Imagine for instance the case where two tasks block on one CPU, only the one
 * CPU will have IO-wait accounted, while the other has regular idle. Even
 * though, if the storage were faster, both could've ran at the same time,
 * utilising both CPUs.
 *
 * This means, that when looking globally, the current IO-wait accounting on
 * SMP is a lower bound, by reason of under accounting.
 *
 * Worse, since the numbers are provided per CPU, they are sometimes
 * interpreted per CPU, and that is nonsensical. A blocked task isn't strictly
 * associated with any one particular CPU, it can wake to another CPU than it
 * blocked on. This means the per CPU IO-wait number is meaningless.
 *
 * Task CPU affinities can make all that even more 'interesting'.
 */



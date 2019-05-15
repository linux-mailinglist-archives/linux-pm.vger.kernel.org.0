Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 351C21F8F1
	for <lists+linux-pm@lfdr.de>; Wed, 15 May 2019 18:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbfEOQs7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 May 2019 12:48:59 -0400
Received: from merlin.infradead.org ([205.233.59.134]:49054 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbfEOQs7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 May 2019 12:48:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=I9b5O3t91nRnKaPiDj7b09CmwJCZOHCIeDVo1tkyaEo=; b=1Ibci09C5bcghosVjzuvVBDlG
        uCiEvLMMdMwm19qEU87UcA5ETmfXSmdQU9/qMHOPBEchMzKzp7us1sQxEVhRU9rJ1K22g1YX8ZHB+
        aD8ba824YUYhvv8drTyFlQ701ImDmOxTkzMH7y6Xzv5rpLvn+QP2Wnvslk6w83ZDiXK7BoKI4p0HU
        48ow/7uTwcej0kp/NvwoR/N0Ti9SFTRT4bjX+qdmaQ7SE34U97t+Rt/YohTwxW/p0h04kyxaFzwQ6
        YL4xb/4NaUad88A8H6OwN6VUfrC4izIXrtBUQC9OycRai105dT3W7jBZiUE7/tSjE91G4RMD2MUBy
        8nE25lhYw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hQx5L-0001Q9-UF; Wed, 15 May 2019 16:48:56 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B35712029906B; Wed, 15 May 2019 18:48:54 +0200 (CEST)
Date:   Wed, 15 May 2019 18:48:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Parth Shah <parth@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        mingo@redhat.com, dietmar.eggemann@arm.com, dsmythies@telus.net
Subject: Re: [RFCv2 0/6] TurboSched: A scheduler for sustaining Turbo
 Frequencies for longer durations
Message-ID: <20190515164854.GZ2589@hirez.programming.kicks-ass.net>
References: <20190515135322.19393-1-parth@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190515135322.19393-1-parth@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, May 15, 2019 at 07:23:16PM +0530, Parth Shah wrote:
> Abstract
> ========
> 
> The modern servers allows multiple cores to run at range of
> frequencies higher than rated range of frequencies. But the power budget
> of the system inhibits sustaining these higher frequencies for
> longer durations.
> 
> However when certain cores are put to idle states, the power can be
> effectively channelled to other busy cores, allowing them to sustain
> the higher frequency.
> 
> One way to achieve this is to pack tasks onto fewer cores keeping others idle,
> but it may lead to performance penalty for such tasks and sustaining higher
> frequencies proves to be of no benefit. But if one can identify unimportant low
> utilization tasks which can be packed on the already active cores then waking up
> of new cores can be avoided. Such tasks are short and/or bursty "jitter tasks"
> and waking up new core is expensive for such case.
> 
> Current CFS algorithm in kernel scheduler is performance oriented and hence
> tries to assign any idle CPU first for the waking up of new tasks. This policy
> is perfect for major categories of the workload, but for jitter tasks, one
> can save energy by packing it onto active cores and allow other cores to run at
> higher frequencies.
> 
> These patch-set tunes the task wake up logic in scheduler to pack exclusively
> classified jitter tasks onto busy cores. The work involves the use of additional
> attributes inside "cpu" cgroup controller to manually classify tasks as jitter. 

Why does this make sense? Don't these higher freq bins burn power like
stupid? That is, it makes sense to use turbo-bins for single threaded
workloads that are CPU-bound and need performance.

But why pack a bunch of 'crap' tasks onto a core and give it turbo;
that's just burning power without getting anything back for it.



Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0993115D7B2
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2020 13:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbgBNMxA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Feb 2020 07:53:00 -0500
Received: from merlin.infradead.org ([205.233.59.134]:38204 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728036AbgBNMxA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Feb 2020 07:53:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=t2we0PE4j6hAaHGoRgkn7qXbGUrgutHcAcfmLiFHRWw=; b=gTW/aS9oGb4ii6R1UHqUFibeIu
        HVTlUHsngfOl9p+lAIz8fXKg99K2QHktwiGApSQmfU10a7bdqhzAhmD/8mYBb5RplQ/wddEhRhzl0
        UNibu0iKNWFvS84vncGjjwRiK1z9eBJ/+SzzOYlZ10UQZ9v0Ejx1MMzf3TwX3kJe9loNp7x8nQ/lY
        TSSsBT/V5FBv8iIEl2xXglUvl1zqVe7Varbf7SW4CmyuMHqzwKjI5zh9ZuoY4ZB+Y4DyEeWrFXRA/
        F6Di1f7xaHUaoIasPGQ97V6TFm9+AoLrfJ8+X6z/HVa+f5IG+f9A3oYt1HaM/89g4T5irIK6X0xo5
        GwzrEyIg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j2aSh-0002aC-Kx; Fri, 14 Feb 2020 12:52:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E1DF330067C;
        Fri, 14 Feb 2020 13:50:59 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C73B620B33554; Fri, 14 Feb 2020 13:52:49 +0100 (CET)
Date:   Fri, 14 Feb 2020 13:52:49 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Douglas Raillard <douglas.raillard@arm.com>
Cc:     linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        qperret@google.com, linux-pm@vger.kernel.org
Subject: Re: [RFC PATCH v4 0/6] sched/cpufreq: Make schedutil energy aware
Message-ID: <20200214125249.GL14879@hirez.programming.kicks-ass.net>
References: <20200122173538.1142069-1-douglas.raillard@arm.com>
 <c49ca012-bb3e-580d-9b45-359caa67d7c1@arm.com>
 <20200210132133.GH14897@hirez.programming.kicks-ass.net>
 <4a664419-f5a6-882f-83ee-5bbf20ff33d3@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a664419-f5a6-882f-83ee-5bbf20ff33d3@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Feb 13, 2020 at 05:49:48PM +0000, Douglas Raillard wrote:
> On 2/10/20 1:21 PM, Peter Zijlstra wrote:

> > assuming cs[].cost ~ f^3, and given our cost_margin ~ f, that leaves a
> > factor f^2 on the table.
> 
> I'm guessing that you arrived to `cost_margin ~ f` this way:
> 
> cost_margin = util - util_est_enqueued
> cost_margin = util - constant
> 
> # with constant small enough
> cost_margin ~ util
> 
> # with util ~ 1/f
> cost_margin ~ 1/f
> 
> In the case you describe, `constant` is actually almost equal to `util`
> so `cost_margin ~! util`, and that series assumes frequency invariant
> util_avg so `util !~ 1/f` (I'll probably have to fix that).

Nah, perhaps already clear from the other email; but it goes like:

  boost = util_avg - util_est
  cost_margin = boost * C = C * util_avg - C * util_est

And since u ~ f (per schedutil construction), cost_margin is a function
linear in either u or f.

> > So the higher the min_freq, the less effective the boost.
> 
> Yes, since the boost is allowing a fixed amount of extra power. Higher
> OPPs are less efficient than lower ones, so if min_freq is high, we
> won't speed up as much as if min_freq was low.
> 
> > Maybe it all works out in practise, but I'm missing a big picture
> 
> Here is a big picture :)
> 
> https://gist.github.com/douglas-raillard-arm/f76586428836ec70c6db372993e0b731#file-ramp_boost-svg
> 
> The board is a Juno R0, with a periodic task pinned on a big CPU
> (capa=1024):
> * phase 1:  5% duty cycle (=51 PELT units)
> * phase 2: 75% duty cycle (=768 PELT units)
> 
> Legend:
> * blue square wave: when the task executes (like in kernelshark)
> * base_cost = cost of frequency as selected by schedutil in normal
> operations
> * allowed_cost = base_cost + cost_margin
> * util = util_avg
> 
> note: the small gaps right after the duty cycle transition between
> t=4.15 and 4.25 are due to sugov task executing, so there is no dequeue
> and no util_est update.

I'm confused by the giant drop in frequency (blue line) around 4.18

schedutil shouldn't select f < max(util_avg, util_est), which is
violated right about there.

I'm also confused by the base_cost line; how can that be flat until
somewhere around 4.16. Sadly there is no line for pure schedutil freq to
compare against.

Other than that, I can see the green line is consistent with
util_avg>util_est, and how it help grow the frequency (blue).


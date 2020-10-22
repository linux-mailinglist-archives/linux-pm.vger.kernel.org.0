Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 924E1295DDC
	for <lists+linux-pm@lfdr.de>; Thu, 22 Oct 2020 13:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2897588AbgJVL6H (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Oct 2020 07:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2897730AbgJVL6D (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Oct 2020 07:58:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55BFEC0613CE;
        Thu, 22 Oct 2020 04:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=I6klDVnQcrqiqkHEDRJqE0N4Ugd/ob+1NQ2ptWfMYdk=; b=Lfpzj/X0purmxvaViHT2xcRSq2
        i8pKJrLPnsXE/XCPBnEE7X+4reJKp30RjIEvOLZ2K9O0/hiaQjSCQXjfN6WCyiYuGWIzpMY3FVzb8
        SvqcAujgUefDduyLEpTdxR1IjA5i+sxu3abYYV4WH75S/oOo7NlOSVaSKg5MKVpFKONifJAhf+ppl
        bb4P/Dt40ITxx6lgApona00JzQGEdqFZpqM54cq0KiyMni8aCnTROQVd9bJOtCbjMH/+a9Fd7xFrh
        XZyvRXMcfmQWQbV3Wx2MQJp3vNvDHWDSwQUdYAPnvG40RbarjETHkPQTlXATVgUkcpvJ0ax5pK5ds
        biBmVJ2w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kVZEA-0007kY-1h; Thu, 22 Oct 2020 11:57:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2197030377D;
        Thu, 22 Oct 2020 13:57:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 05AD2203CC4B2; Thu, 22 Oct 2020 13:57:53 +0200 (CEST)
Date:   Thu, 22 Oct 2020 13:57:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Quentin Perret <qperret@google.com>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>
Subject: Re: [PATCH 2/2] thermal: cpufreq_cooling: Reuse effective_cpu_util()
Message-ID: <20201022115752.GF2611@hirez.programming.kicks-ass.net>
References: <cover.1594707424.git.viresh.kumar@linaro.org>
 <b051b42f0c4f36d7177978e090c6a85df17922c6.1594707424.git.viresh.kumar@linaro.org>
 <20200716115605.GR10769@hirez.programming.kicks-ass.net>
 <20201022083255.37xl3lffwk5qo6uk@vireshk-i7>
 <20201022090523.GV2628@hirez.programming.kicks-ass.net>
 <20201022110656.gaphjv2tzhj4f5y6@vireshk-i7>
 <CAJZ5v0jZC=UwW9L+KB3pugsTL9P1tZmvQ-sVMV-udn7+L_gEeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jZC=UwW9L+KB3pugsTL9P1tZmvQ-sVMV-udn7+L_gEeA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 22, 2020 at 01:30:01PM +0200, Rafael J. Wysocki wrote:

> Many people use intel_pstate in the active mode with HWP enabled too.

We now have HWP-passive supported, afaict. So we should discourage that.

That is; I'll care less and less about people not using schedutil as
time goes on.

> Arguably, that doesn't need to compute the effective utilization, so I
> guess it is not relevant for the discussion here, but it is not
> negligible in general.

Why not? cpufreq-cooling should still be able to throttle the system by
setting HWP.Highest_Performance no?

In which case it still needs an energy estimate.

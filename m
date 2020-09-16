Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6364B26BF6E
	for <lists+linux-pm@lfdr.de>; Wed, 16 Sep 2020 10:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgIPIgS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Sep 2020 04:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbgIPIgQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Sep 2020 04:36:16 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D665C06174A
        for <linux-pm@vger.kernel.org>; Wed, 16 Sep 2020 01:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/R0dhD7qfMUS+GFLfA/L8HdB939za9i4Qgy+8QTO6LA=; b=XW8EWZrsEvPPz3+Ilx0v5ZRtIb
        2mzhpOzpNq75rEORR74yM1pe1NKOKXk8dcvsacNLBGif6yjg4i/QcVtpnWah7jgXSdd1Rm+gMr3a8
        YEzLlJZbVqPEpSQvZIDtCQLGQJYL/aJgB+4UwF0x69LAv3MyBMe5hPGMQ/z1lGBOJXLEXkTrdDcgy
        P6VYFHpSAXXhBtKAYVFbDYF1XjDpLrPVS2bH3uolb+nEcuBci+XIOJswjLyhkxHNLBzku9iqo6MWy
        EeXP0uthXvv1Nald8J6OGAmsLjVpWoglxByxgRcEAyfMBPGcXc6wr5YAKANe8zoof8qZLnAp3tegr
        weaITqpw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kISv6-00026w-6d; Wed, 16 Sep 2020 08:36:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9E8B03050F0;
        Wed, 16 Sep 2020 10:36:02 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8AAC82C32F85B; Wed, 16 Sep 2020 10:36:02 +0200 (CEST)
Date:   Wed, 16 Sep 2020 10:36:02 +0200
From:   peterz@infradead.org
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: Re: [PATCH] cpuidle: psci: Fix suspicious RCU usage
Message-ID: <20200916083602.GM2674@hirez.programming.kicks-ass.net>
References: <20200904064705.239614-1-ulf.hansson@linaro.org>
 <20200904141304.GE29330@paulmck-ThinkPad-P72>
 <CAPDyKFrgs+EGZQr_cqWiq_7v1qDi3WBWQpmZFPwu034Y5a8M1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFrgs+EGZQr_cqWiq_7v1qDi3WBWQpmZFPwu034Y5a8M1Q@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Sep 15, 2020 at 11:17:20PM +0200, Ulf Hansson wrote:
> Peter, Rafael,
> 
> Is $subject patch okay as the short term solution? If so, I can
> continue to look at the CPU PM notifiers, etc.

Yes, it's a proper band-aid :-)

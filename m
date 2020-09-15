Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3470C26A33F
	for <lists+linux-pm@lfdr.de>; Tue, 15 Sep 2020 12:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbgIOKg1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Sep 2020 06:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbgIOKgY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Sep 2020 06:36:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4784DC06174A;
        Tue, 15 Sep 2020 03:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hvBH9n99n7oBLdgOlNEw3Z7fdQr8iLuKKj8rbR9iWPQ=; b=deVBQ6TIRiVTUZ0zB3/0okwYOA
        rbEP5YPP0/s6nWJA/LqMozIFOiPEcexK9dlQoaX2+oljyaco3rIsgqQXXb/7N998cNNcsb3UnYU7g
        AtrWzR1ZqrWwv4ykmjHinWHNRT9Os+gddd994F6BdKLIVX1dGqyNqUOZbrDUAWE4A0FLU157j0s4f
        RZQ4D1X24y6tx+8FYeA5kEDkT0sI/d8zJm1hy6bIoratb2BofjnAmo4RzXjxz0wMbHzlict2UfFZE
        i/W4CUBpWaGT3zJy1lqdjHAJcIf8HE23nbsQ9MowRvO6ApQGmLpKOUapFfL5kNkuO6oPWm/KIRBi8
        In92fpJA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kI8JL-0006QD-95; Tue, 15 Sep 2020 10:35:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3A9E63050F0;
        Tue, 15 Sep 2020 12:35:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B2263214EDD4A; Tue, 15 Sep 2020 12:35:39 +0200 (CEST)
Date:   Tue, 15 Sep 2020 12:35:39 +0200
From:   peterz@infradead.org
To:     Qian Cai <cai@redhat.com>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        rcu@vger.kernel.org, linux-mm <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, Linux PM <linux-pm@vger.kernel.org>,
        ": Paul E. McKenney" <paulmck@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Will Deacon <will@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: Re: WARNING: suspicious RCU usage: race/events/tlb.h:57 suspicious
 rcu_dereference_check() usage!
Message-ID: <20200915103539.GW1362448@hirez.programming.kicks-ass.net>
References: <CA+G9fYuRquEtm53yz9SYqa6O5gg4e6d9BCmDn163Fe2VwhWcJw@mail.gmail.com>
 <d7bdc37f6e3f98379289b262aea812e1894cd69b.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7bdc37f6e3f98379289b262aea812e1894cd69b.camel@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Sep 14, 2020 at 01:29:34PM -0400, Qian Cai wrote:
> On Wed, 2020-09-09 at 10:08 +0530, Naresh Kamboju wrote:
> > While booting x86_64 with Linux next 20200908 tag kernel this warning
> > was noticed.
> 
> This pretty much looks like the same issue in:
> 
> https://lore.kernel.org/lkml/20200902035146.GA45826@roeck-us.net/
> 
> Can you revert the patchset to see if it is related?

Don't bother..  I'll be sending patches soon.

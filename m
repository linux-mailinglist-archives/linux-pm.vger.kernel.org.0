Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D87D7CB97A
	for <lists+linux-pm@lfdr.de>; Fri,  4 Oct 2019 13:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729970AbfJDLtJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Oct 2019 07:49:09 -0400
Received: from merlin.infradead.org ([205.233.59.134]:36314 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbfJDLtJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Oct 2019 07:49:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=t94arAtwMSELxUeSxpVTRDoonLVl+3+fPDniWRezYE8=; b=ssUMEk0fG4hKLEBdEcLJQEOxz
        LFy6cOOMbYFukHC1NZ2ZG0eZfVtOZCQsPO+caJ/EQDphxs0JXz6bFbkbO3aqq7pk2KyWwJGt7PFOj
        Rz2lQ/VBLuV11Go8JEfsvZU1zLjxol+GFuQH3ezo1ypR3Ei5l7eM4XD08fpe42VK6y+QmR/FwGj8R
        YRs7g23kkaMKM4iVb7VUfghQIickBpaI+GT6gNzt7J6lKDKJI8U3MqzewVE2jWKq4mDUndhMWryV1
        OmyJ7YlNnyrk71hpOXXw06WPg0N8S3CoIsDjUhr1Z8negxd01F+M8iqp20pwP+2dKzrxzLexm+Ead
        /3zgFnZKQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iGM4a-0006CC-Jk; Fri, 04 Oct 2019 11:48:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1D1D430034F;
        Fri,  4 Oct 2019 13:47:45 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B90C3203E50D2; Fri,  4 Oct 2019 13:48:34 +0200 (CEST)
Date:   Fri, 4 Oct 2019 13:48:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Giovanni Gherdovich <ggherdovich@suse.cz>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@suse.de>,
        Len Brown <lenb@kernel.org>, x86@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Paul Turner <pjt@google.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Quentin Perret <qperret@qperret.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Doug Smythies <dsmythies@telus.net>
Subject: Re: [PATCH v2 1/2] x86,sched: Add support for frequency invariance
Message-ID: <20191004114834.GE19463@hirez.programming.kicks-ass.net>
References: <20191002122926.385-1-ggherdovich@suse.cz>
 <1906426.HDqaVa71mF@kreacher>
 <20191003121537.GR4536@hirez.programming.kicks-ass.net>
 <1990043.dY4KdrEkPr@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1990043.dY4KdrEkPr@kreacher>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 03, 2019 at 07:53:49PM +0200, Rafael J. Wysocki wrote:
> On Thursday, October 3, 2019 2:15:37 PM CEST Peter Zijlstra wrote:
> > On Thu, Oct 03, 2019 at 12:27:52PM +0200, Rafael J. Wysocki wrote:
> > > > +	if (smp_processor_id() != 0)
> > > > +		return;

> Well, but the smp_processor_id() check has nothing to do with whether or not
> this is "core" or "atom" or something else, for example.

It is dodgy to begin with, it hard assumes we boot on cpu-0. A
'initialized' state would probably be better.

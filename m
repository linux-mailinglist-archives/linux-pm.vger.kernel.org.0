Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A32301251F4
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2019 20:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbfLRTeo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Dec 2019 14:34:44 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53344 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727417AbfLRTeo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Dec 2019 14:34:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=F0qw+ZgAxUoSNUdtsCy/4y9ChBD5n/nHwz3C1MaWdgs=; b=HHNAemO2hQMNhgUhEnLcMkVsR
        iSxylsO6FhuzfM+X/t9mAWu3giItRNswznlmDgzqRYiN+xmGhY3vq9TxT4Ht8xNDIAYMVcjQzup8+
        0RJ2E+mYGLRezrOlBUNuYHxJ+wh5Oeev0LT4/vyTlWSkJZ1MJOMrDRdiAhDbLPV7xoF8rsmqjic7s
        Vw+FLSPx+1wgmWM24nDkNJzGJw9xkE+4L+iy1uu4eVVY8G2RnvuWuNlre++qoN4bXrFvekH9YvGFm
        Z8VRyHEhCU69fJjtNwWt862jCce2fhGupp/sOl/O/CodhTWkju1VuOkZJSWsStwbfZ/o3kborZ7iJ
        Yv5Pb5HRg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ihf5b-0002JF-32; Wed, 18 Dec 2019 19:34:31 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 20D5D980E35; Wed, 18 Dec 2019 20:34:29 +0100 (CET)
Date:   Wed, 18 Dec 2019 20:34:29 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Giovanni Gherdovich <ggherdovich@suse.cz>
Cc:     Ionela Voinescu <ionela.voinescu@arm.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@suse.de>,
        Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, x86@kernel.org,
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
Subject: Re: [PATCH v4 1/6] x86,sched: Add support for frequency invariance
Message-ID: <20191218193429.GH11457@worktop.programming.kicks-ass.net>
References: <20191113124654.18122-1-ggherdovich@suse.cz>
 <20191113124654.18122-2-ggherdovich@suse.cz>
 <20191202162232.GA9777@arm.com>
 <4d1b776d8e797224e92952a4d590a625@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d1b776d8e797224e92952a4d590a625@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Dec 06, 2019 at 12:57:46PM +0100, Giovanni Gherdovich wrote:
> > On Wednesday 13 Nov 2019 at 13:46:49 (+0100), Giovanni Gherdovich wrote:
> > I see above that you enable the static key (and therefore frequency
> > invariance before setting the max frequency ratio (if possible) and
> > before you initialise the counter references. Is there any reason for
> > doing this?

> This is a fair point; mine was a deliberate choice but you're the second
> person making this remark (Peter Zijlstra also suggested I find the max
> frequency before I set the static key), so it appears this design is
> unpopular
> enough to warrant a change in v5.

You actually 'fix' this in the next patch. I thought it was a patch
management 'fail' that it didn't end up in this patch.

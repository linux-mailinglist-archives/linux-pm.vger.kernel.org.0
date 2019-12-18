Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86BC7125391
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2019 21:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbfLRUiY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Dec 2019 15:38:24 -0500
Received: from merlin.infradead.org ([205.233.59.134]:40938 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbfLRUiY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Dec 2019 15:38:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1K6xXaDuBfn2qwB6e1FIot8njTH5XBdzAZMVOayqv0Y=; b=wj6Qswyd89IgEckS6AjxhVd1x
        F9f1eAcda9I/okfSWXN47oL96PDkhK+N1eQrhr4FlroYgQICh7c6xsW5pZT8GmeDBcS4eUziCAZ4T
        Mh0JRdhd99QlLjz6MfkjKEy4BPqSYFhzpTksWibUYIz8u2hPSbzkmZBUeSHLA+MOGrAjVoZi9NFp8
        nXlbhUEZQxHRZbNRRNSR2rhCWoGzHOVfYA8Yempzqir2kaxiQFW2gqi+UJuyvStr4GUsf/tEGLrj+
        nlNT0gSq9lyAWDXAlGAuonhAh44ML7Cp6rub4MVkauudwI3Nk8hkmRCTX/UaW1UQR6x/1Ip5HiYjd
        +nItrGcYw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ihg4n-0001iY-65; Wed, 18 Dec 2019 20:37:45 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 64FB8980E35; Wed, 18 Dec 2019 21:37:42 +0100 (CET)
Date:   Wed, 18 Dec 2019 21:37:42 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Giovanni Gherdovich <ggherdovich@suse.cz>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
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
Subject: Re: [PATCH v4 0/6] Add support for frequency invariance for (some)
 x86
Message-ID: <20191218203742.GK11457@worktop.programming.kicks-ass.net>
References: <20191113124654.18122-1-ggherdovich@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191113124654.18122-1-ggherdovich@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Over all I really like these. I'm tempted to just merge v5 and do any
further changes on top if/when needed.

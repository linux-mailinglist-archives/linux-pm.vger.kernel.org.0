Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6AA126EE1
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2019 21:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfLSU1Y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Dec 2019 15:27:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:49880 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726869AbfLSU1Y (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 19 Dec 2019 15:27:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A75B9B3A2;
        Thu, 19 Dec 2019 20:27:22 +0000 (UTC)
Message-ID: <1576787590.8929.16.camel@suse.cz>
Subject: Re: [PATCH v4 0/6] Add support for frequency invariance for (some)
 x86
From:   Giovanni Gherdovich <ggherdovich@suse.cz>
To:     Peter Zijlstra <peterz@infradead.org>
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
Date:   Thu, 19 Dec 2019 21:33:10 +0100
In-Reply-To: <20191218203742.GK11457@worktop.programming.kicks-ass.net>
References: <20191113124654.18122-1-ggherdovich@suse.cz>
         <20191218203742.GK11457@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 2019-12-18 at 21:37 +0100, Peter Zijlstra wrote:
> Over all I really like these. I'm tempted to just merge v5 and do any
> further changes on top if/when needed.

Thanks! I've got a little side-tracked but v5 is coming.


Giovanni

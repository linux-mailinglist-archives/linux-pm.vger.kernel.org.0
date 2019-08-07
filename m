Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A533A848C1
	for <lists+linux-pm@lfdr.de>; Wed,  7 Aug 2019 11:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbfHGJmO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Aug 2019 05:42:14 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:58390 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbfHGJmO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Aug 2019 05:42:14 -0400
Received: from 79.184.254.29.ipv4.supernova.orange.pl (79.184.254.29) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.275)
 id ca2a68884a7246d6; Wed, 7 Aug 2019 11:42:11 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Qais Yousef <qais.yousef@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@redhat.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: schedutil: fix equation in comment
Date:   Wed, 07 Aug 2019 11:42:11 +0200
Message-ID: <13854122.nn4VJ8hDQq@kreacher>
In-Reply-To: <20190805130620.GL2349@hirez.programming.kicks-ass.net>
References: <20190802104628.8410-1-qais.yousef@arm.com> <20190805130620.GL2349@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Monday, August 5, 2019 3:06:20 PM CEST Peter Zijlstra wrote:
> On Fri, Aug 02, 2019 at 11:46:28AM +0100, Qais Yousef wrote:
> > scale_irq_capacity() call in schedutil_cpu_util() does
> > 
> > 	util *= (max - irq)
> > 	util /= max
> > 
> > But the comment says
> > 
> > 	util *= (1 - irq)
> > 	util /= max
> > 
> > Fix the comment to match what the scaling function does.
> > 
> > Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> 
> Thanks!
> 

I've applied this, so please let me know if it has gone into -tip too and I'll drop it then.




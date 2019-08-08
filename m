Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 352958610E
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2019 13:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729023AbfHHLoF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Aug 2019 07:44:05 -0400
Received: from foss.arm.com ([217.140.110.172]:60428 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729018AbfHHLoF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 8 Aug 2019 07:44:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CEE3F15A2;
        Thu,  8 Aug 2019 04:44:04 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.194.52])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E5D513F694;
        Thu,  8 Aug 2019 04:44:03 -0700 (PDT)
Date:   Thu, 8 Aug 2019 12:44:01 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@redhat.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: schedutil: fix equation in comment
Message-ID: <20190808114401.ziyxnm5yffjupnpm@e107158-lin.cambridge.arm.com>
References: <20190802104628.8410-1-qais.yousef@arm.com>
 <20190805130620.GL2349@hirez.programming.kicks-ass.net>
 <13854122.nn4VJ8hDQq@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <13854122.nn4VJ8hDQq@kreacher>
User-Agent: NeoMutt/20171215
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 08/07/19 11:42, Rafael J. Wysocki wrote:
> On Monday, August 5, 2019 3:06:20 PM CEST Peter Zijlstra wrote:
> > On Fri, Aug 02, 2019 at 11:46:28AM +0100, Qais Yousef wrote:
> > > scale_irq_capacity() call in schedutil_cpu_util() does
> > > 
> > > 	util *= (max - irq)
> > > 	util /= max
> > > 
> > > But the comment says
> > > 
> > > 	util *= (1 - irq)
> > > 	util /= max
> > > 
> > > Fix the comment to match what the scaling function does.
> > > 
> > > Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> > 
> > Thanks!
> > 
> 
> I've applied this, so please let me know if it has gone into -tip too and I'll drop it then.

FYI I've just got an email from tip-bot that it was committed there.

Thanks!

--
Qais Yousef

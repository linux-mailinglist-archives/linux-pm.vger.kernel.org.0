Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70BC7277645
	for <lists+linux-pm@lfdr.de>; Thu, 24 Sep 2020 18:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728482AbgIXQKE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Sep 2020 12:10:04 -0400
Received: from foss.arm.com ([217.140.110.172]:50056 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728448AbgIXQKE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 24 Sep 2020 12:10:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F01961396;
        Thu, 24 Sep 2020 09:10:03 -0700 (PDT)
Received: from localhost (unknown [10.1.199.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 91EFB3F718;
        Thu, 24 Sep 2020 09:10:03 -0700 (PDT)
Date:   Thu, 24 Sep 2020 17:10:02 +0100
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Quentin Perret <qperret@google.com>
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        catalin.marinas@arm.com, will@kernel.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, dietmar.eggemann@arm.com,
        valentin.schneider@arm.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] arm64: rebuild sched domains on invariance status
 changes
Message-ID: <20200924161002.GC17927@arm.com>
References: <20200924123937.20938-1-ionela.voinescu@arm.com>
 <20200924123937.20938-4-ionela.voinescu@arm.com>
 <20200924133925.GC3920949@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924133925.GC3920949@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thursday 24 Sep 2020 at 14:39:25 (+0100), Quentin Perret wrote:
> On Thursday 24 Sep 2020 at 13:39:37 (+0100), Ionela Voinescu wrote:
> > For arm64 this affects the task scheduler behavior which builds its
> > scheduling domain hierarchy well before the late counter-based FI init.
> > During that process it will disable EAS due to its dependency on FI.
> 
> Does it mean we get a warn on every boot, even though this is a
> perfectly normal scenario?
> 

Yes, we will get a few "Disabling EAS: frequency-invariant load tracking
not supported" warnings until the final rebuild of the sched domains
finds FI supported and enables EAS (silently this time, which possibly
makes things worse). We have the same behavior for removing and adding
the schedutil governor.

I'm not sure what is a good way of fixing this.. I could add more info
to the warning to suggest it might be temporary ("Disabling EAS:
frequency-invariant load tracking currently not supported"). For further
debugging there are the additional prints guarded by sched_debug().

I'll look over the code some more to see if other ideas pop out. Any
suggestions are appreciated.

Many thanks for the review,
Ionela.

> Thanks,
> Quentin

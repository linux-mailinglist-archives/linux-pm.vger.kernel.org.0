Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6A21EFFF8
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jun 2020 20:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbgFESoD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Jun 2020 14:44:03 -0400
Received: from winnie.ispras.ru ([83.149.199.91]:33477 "EHLO smtp.ispras.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726077AbgFESoD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 5 Jun 2020 14:44:03 -0400
X-Greylist: delayed 481 seconds by postgrey-1.27 at vger.kernel.org; Fri, 05 Jun 2020 14:44:03 EDT
Received: from monopod.intra.ispras.ru (monopod.intra.ispras.ru [10.10.3.121])
        by smtp.ispras.ru (Postfix) with ESMTP id D0453203BF;
        Fri,  5 Jun 2020 21:35:56 +0300 (MSK)
Date:   Fri, 5 Jun 2020 21:35:56 +0300 (MSK)
From:   Alexander Monakov <amonakov@ispras.ru>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
cc:     linux-kernel@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>, qperret@google.com,
        juri.lelli@redhat.com,
        Valentin Schneider <valentin.schneider@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Doug Smythies <dsmythies@telus.net>
Subject: Re: schedutil issue with serial workloads
In-Reply-To: <c3145e26-56c8-4979-513c-cfac191e989b@intel.com>
Message-ID: <alpine.LNX.2.20.13.2006052058560.3984@monopod.intra.ispras.ru>
References: <alpine.LNX.2.20.13.2006042341160.3984@monopod.intra.ispras.ru> <c3145e26-56c8-4979-513c-cfac191e989b@intel.com>
User-Agent: Alpine 2.20.13 (LNX 116 2015-12-14)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 5 Jun 2020, Rafael J. Wysocki wrote:

> > This sounds like it should be a known problem, but I couldn't find any
> > mention of it in the documentation.
> 
> Well, what would you expect to happen instead of what you see?

Not sure why you ask. Named workloads are pretty common for example on
"build-bot" machines. If you don't work exclusively on the kernel you
probably recognize that on, let's say, more "traditionally engineered"
packages ./configure can take 10x more wall-clock time than subsequent
'make -j $(nproc)', and if schedutil makes the problem worse by
consistently choosing the lowest possible frequency for the configure
phase, that's a huge pitfall that's worth fixing or documenting.

To answer your question, assuming schedutil is intended to become a good
choice for a wide range of use-cases, I'd expect it to choose a high
frequency, ideally the highest, and definitely not the lowest. I think I
was pretty transparent about that in my initial mail. I understand there
is no obvious fix and inventing one may prove difficult.

Short term, better Kconfig help text to help people make a suitable choice
for their workloads would be nice.

I'd also like to point out that current Kconfig is confusingly worded
where it says "If the utilization is frequency-invariant, ...". It can
be interpreted as "the workload is producing the same utilization
irrespective of frequency", but what it actually refers to is the
implementation detail of how the "utilization" metric is interpreted.
Does that sentence need to be in Kconfig help at all?

Thanks.
Alexander

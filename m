Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D62251999
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2019 19:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732365AbfFXReK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Jun 2019 13:34:10 -0400
Received: from foss.arm.com ([217.140.110.172]:55534 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731032AbfFXReK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 24 Jun 2019 13:34:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 80E7BC0A;
        Mon, 24 Jun 2019 10:34:09 -0700 (PDT)
Received: from e110439-lin (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4810F3F718;
        Mon, 24 Jun 2019 10:34:07 -0700 (PDT)
Date:   Mon, 24 Jun 2019 18:34:05 +0100
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alessio Balsini <balsini@android.com>
Subject: Re: [PATCH v10 13/16] sched/core: uclamp: Propagate parent clamps
Message-ID: <20190624173405.enrxqalaqinbgsut@e110439-lin>
References: <20190621084217.8167-1-patrick.bellasi@arm.com>
 <20190621084217.8167-14-patrick.bellasi@arm.com>
 <20190622150750.GN657710@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190622150750.GN657710@devbig004.ftw2.facebook.com>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 22-Jun 08:07, Tejun Heo wrote:
> Hello,

Hi,
 
> On Fri, Jun 21, 2019 at 09:42:14AM +0100, Patrick Bellasi wrote:
> > Since it can be interesting for userspace, e.g. system management
> > software, to know exactly what the currently propagated/enforced
> > configuration is, the effective clamp values are exposed to user-space
> > by means of a new pair of read-only attributes
> > cpu.util.{min,max}.effective.
> 
> Can we not add the effective interface file for now?

You mean just the (read-only) user-space API right?

I found it quite convenient, even just for debugging.
Moreover it allows a container to know what it's exactly getting...

> I don't think it's a bad idea but would like to think more about it.
> For cpuset, it was needed because configuration was so interwoven
> with the effective masks, but we don't generally do this for other
> min/max or weight knobs, all of which have effective hierarchical
> values and I'm not quite sure about adding .effective for all of
> them.
> It could be that that's what we end up doing eventually but
> I'd like to think a bit more about it.

... but I see your point and, since it's not strictly required, I
think we can drop it in v11. Will check better if it's of any use
apart from debugging/testing support.

> Thanks.
> 
> -- 
> tejun

Cheers,
Patrick

-- 
#include <best/regards.h>

Patrick Bellasi

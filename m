Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6F06AA33
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2019 16:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387770AbfGPODZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Jul 2019 10:03:25 -0400
Received: from foss.arm.com ([217.140.110.172]:35354 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728004AbfGPODZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 16 Jul 2019 10:03:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 709A5337;
        Tue, 16 Jul 2019 07:03:24 -0700 (PDT)
Received: from e110439-lin (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1312E3F59C;
        Tue, 16 Jul 2019 07:03:21 -0700 (PDT)
Date:   Tue, 16 Jul 2019 15:03:20 +0100
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
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
Subject: Re: [PATCH v11 0/5] Add utilization clamping support (CGroups API)
Message-ID: <20190716140319.hdmgcuevnpwdqobl@e110439-lin>
References: <20190708084357.12944-1-patrick.bellasi@arm.com>
 <20190715165116.GB21982@blackbody.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190715165116.GB21982@blackbody.suse.cz>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 15-Jul 18:51, Michal Koutný wrote:
> Hello Patrick.

Hi Michal,

> I took a look at your series and I've posted some notes to your patches.

thanks for your review!

> One applies more to the series overall -- I see there is enum uclamp_id
> defined but at many places (local variables, function args) int or
> unsigned int is used. Besides the inconsistency, I think it'd be nice to
> use the enum at these places.

Right, I think in some of the original versions I had few code paths
where it was not possible to use enum values. That seems no more the case.

Since this change is likely affecting also core bits already merged in
5.3, in v12 I'm going to add a bulk rename patch at the end of the
series, so that we can keep a better tracking of this change.

> (Also, I may suggest CCing ML cgroups@vger.kernel.org where more eyes
> may be available to the cgroup part of your series.)

Good point, I'll add that for the upcoming v12 posting.

Cheers,
Patrick

-- 
#include <best/regards.h>

Patrick Bellasi

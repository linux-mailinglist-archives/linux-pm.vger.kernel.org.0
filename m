Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8062A3BA320
	for <lists+linux-pm@lfdr.de>; Fri,  2 Jul 2021 18:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbhGBQQs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 2 Jul 2021 12:16:48 -0400
Received: from foss.arm.com ([217.140.110.172]:50296 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229499AbhGBQQr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 2 Jul 2021 12:16:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 07AFDD6E;
        Fri,  2 Jul 2021 09:14:15 -0700 (PDT)
Received: from e120877-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A0C533F5A1;
        Fri,  2 Jul 2021 09:14:13 -0700 (PDT)
Date:   Fri, 2 Jul 2021 17:13:51 +0100
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Lukasz Luba <lukasz.luba@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Quentin Perret <qperret@google.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH v3 3/6] cpufreq: Add an interface to mark inefficient
 frequencies
Message-ID: <20210702161351.GA102441@e120877-lin.cambridge.arm.com>
References: <20210615101706.mabloqrmakeiwcf5@vireshk-i7>
 <20210615171530.GA277695@e120877-lin.cambridge.arm.com>
 <20210616073500.b5wazdssoa5djp5o@vireshk-i7>
 <a4971ab0-87d7-4457-49ec-ce20106be358@arm.com>
 <20210616093127.lfpi4rje56b3dhwx@vireshk-i7>
 <ff9a9daa-7d25-ea08-2cd9-fc56f778acde@arm.com>
 <20210616105327.wnppsau4gg5ihrlv@vireshk-i7>
 <4d975236-943c-ea82-547b-04f2bead9f48@arm.com>
 <0a930559-a648-c20d-f3f6-09e4974a031d@arm.com>
 <CAJZ5v0iMHeAOpDStN_qZLbM7-My4rQuAC9nEcT3sHCC33bH3NA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iMHeAOpDStN_qZLbM7-My4rQuAC9nEcT3sHCC33bH3NA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

[...]

Hi Rafael,

> >
> > It would be great if you could have a look.
> > I will be grateful for your time spend on it and opinion.
> 
> First of all, IMO checking whether or not a given frequency is
> "efficient" doesn't belong to cpufreq governors.  The governor knows
> what the min and max supported frequencies are and selects one from
> that range and note that it doesn't even check whether or not the
> selected frequency is present in the frequency table.  That part
> belongs to the driver or the general frequency table handling in the
> cpufreq core.
> 
> So the governor doesn't care and it shouldn't care IMO.

A governor such as userspace should probably be able select any frequency
with no regard to efficiency.

> 
> Besides, in the cpufreq_driver_fast_switch() case the driver's
> ->fast_switch() callback is entirely responsible for applying the
> selected frequency, so I'm not sure how this "efficient" thing is
> going to work then?

This shouldn't be a problem if a governor that leverages inefficient OPPs
resolves an inefficient one to an efficient one. The target_freq would simply
point to a frequency known as efficient.

> Anyway, since we are talking about frequency tables, that would be the
> __cpufreq_driver_target() case only and specifically in the
> __target_index() case only (note how far away this is from the
> governor).
> 
> Now, you may think about modifying cpufreq_frequency_table_target() to
> skip "inefficient" frequencies, but then the question is why those
> frequencies need to be there in the frequency table in the first
> place?

Cpufreq_cooling needs those frequencies, even inefficients, also there's
probably no reason to hide them from the userspace.

-- 
Vincent

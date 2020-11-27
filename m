Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 046D52C6806
	for <lists+linux-pm@lfdr.de>; Fri, 27 Nov 2020 15:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730696AbgK0OkG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 27 Nov 2020 09:40:06 -0500
Received: from outbound-smtp54.blacknight.com ([46.22.136.238]:35805 "EHLO
        outbound-smtp54.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729913AbgK0OkG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 27 Nov 2020 09:40:06 -0500
X-Greylist: delayed 307 seconds by postgrey-1.27 at vger.kernel.org; Fri, 27 Nov 2020 09:40:06 EST
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp54.blacknight.com (Postfix) with ESMTPS id E5433FA975
        for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2020 14:34:58 +0000 (GMT)
Received: (qmail 18228 invoked from network); 27 Nov 2020 14:34:58 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 27 Nov 2020 14:34:58 -0000
Date:   Fri, 27 Nov 2020 14:34:57 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] cpuidle: Allow configuration of the polling interval
 before cpuidle enters a c-state
Message-ID: <20201127143457.GP3371@techsingularity.net>
References: <20201126171824.GK3371@techsingularity.net>
 <CAJZ5v0hz4dBzUcvoyLoJf8Fmajws-uP3MB-_4dmzEYvMDJwEwQ@mail.gmail.com>
 <20201127140811.GA39892@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20201127140811.GA39892@fuller.cnet>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Nov 27, 2020 at 11:08:11AM -0300, Marcelo Tosatti wrote:
> > Well, IMV this is not straightforward at all.
> > 
> > It requires the admin to know how cpuidle works and why this
> > particular polling limit is likely to be suitable for the given
> > workload.  And whether or not the default polling limit should be
> > changed at all.
> 
> KVM polling (virt/kvm/kvm_main.c grow_halt_poll_ns/shrink_halt_poll_ns)
> tries to adjust the polling window based on poll success/failure. 
> 
> The cpuidle haltpoll governor (for KVM guests) uses the same adjustment
> logic.
> 
> Perhaps a similar (or improved) scheme can be adapted to baremetal.
> 
> https://www.kernel.org/doc/Documentation/virtual/kvm/halt-polling.txt

I'm aware of the haltpoll driver and why it's needed there. Given that
it adds cost to the refect callback and increases exit latency that it
would be unpopular on bare metal.

I'm prototyping a v2 that simply picks different balance point to see if
that gets a better reception.

-- 
Mel Gorman
SUSE Labs

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC8FD232F36
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jul 2020 11:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728528AbgG3JKY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Jul 2020 05:10:24 -0400
Received: from foss.arm.com ([217.140.110.172]:36742 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726819AbgG3JKX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 30 Jul 2020 05:10:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A42C7D6E;
        Thu, 30 Jul 2020 02:10:22 -0700 (PDT)
Received: from bogus (unknown [10.37.12.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 637473F792;
        Thu, 30 Jul 2020 02:10:20 -0700 (PDT)
Date:   Thu, 30 Jul 2020 10:10:14 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        cristian.marussi@arm.com, rjw@rjwysocki.net,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 0/4] CPUFreq statistics retrieved by drivers
Message-ID: <20200730091014.GA13158@bogus>
References: <20200729151208.27737-1-lukasz.luba@arm.com>
 <20200730085333.qubrsv7ufqninihd@vireshk-mac-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200730085333.qubrsv7ufqninihd@vireshk-mac-ubuntu>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jul 30, 2020 at 02:23:33PM +0530, Viresh Kumar wrote:
> On 29-07-20, 16:12, Lukasz Luba wrote:
> > The existing CPUFreq framework does not tracks the statistics when the
> > 'fast switch' is used or when firmware changes the frequency independently
> > due to e.g. thermal reasons. However, the firmware might track the frequency
> > changes and expose this to the kernel.
> >
> > This patch set aims to introduce CPUfreq statistics gathered by firmware
> > and retrieved by CPUFreq driver. It would require a new API functions
> > in the CPUFreq, which allows to poke drivers to get these stats.
> >
> > The needed CPUFreq infrastructure is in patch 1/4, patch 2/4 extends
> > ARM SCMI protocol layer, patches 3/4, 4/4  modify ARM SCMI CPUFreq driver.
>
> Are you doing this for the fast switch case or because your platform
> actually runs at frequencies which may be different from what cpufreq
> core has requested ?
>

I think so.

> I am also not sure what these tables should represent, what the
> cpufreq core has decided for the CPUs or the frequencies we actually
> run at, as these two can be very different for example if the hardware
> runs at frequencies which don't match exactly to what is there in the
> freq table. I believe these are rather to show what cpufreq and its
> governors are doing with the CPUs.
>

Exactly, I raised similar point in internal discussion and asked Lukasz
to take up the same on the list. I assume it was always what cpufreq
requested rather than what was delivered. So will we break the userspace
ABI if we change that is the main question.

> Over that I would like the userspace stats to work exactly as the way
> they work right now, i.e. capture all transitions from one freq to
> other, not just time-in-state. Also resetting of the stats from
> userspace for example. All allocation and printing of the data must be
> done from stats core, the only thing which the driver would do at the
> end is updating the stats structure and nothing more. Instead of
> reading all stats from the firmware, it will be much easier if you can
> just get the information from the firmware whenever there is a
> frequency switch and then we can update the stats the way it is done
> right now. And that would be simple.
>

Good point, but notifications may not be lightweight. If that is no good,
alternatively, I suggested to keep these firmware stats in a separate
debugfs. Thoughts ?

--
Regards,
Sudeep

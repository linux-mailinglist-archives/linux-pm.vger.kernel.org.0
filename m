Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C715212277
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jul 2020 13:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728385AbgGBLlz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Jul 2020 07:41:55 -0400
Received: from foss.arm.com ([217.140.110.172]:42548 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727016AbgGBLlz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 2 Jul 2020 07:41:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 829D41FB;
        Thu,  2 Jul 2020 04:41:54 -0700 (PDT)
Received: from localhost (unknown [10.1.198.53])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 239563F71E;
        Thu,  2 Jul 2020 04:41:54 -0700 (PDT)
Date:   Thu, 2 Jul 2020 12:41:52 +0100
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     rjw@rjwysocki.net, catalin.marinas@arm.com, sudeep.holla@arm.com,
        will@kernel.org, linux@armlinux.org.uk, valentin.schneider@arm.com,
        mingo@redhat.com, peterz@infradead.org, dietmar.eggemann@arm.com,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Liviu Dudau <liviu.dudau@arm.com>
Subject: Re: [PATCH 4/8] cpufreq,vexpress-spc: fix Frequency Invariance (FI)
 for bL switching
Message-ID: <20200702114123.GA28120@arm.com>
References: <20200701090751.7543-1-ionela.voinescu@arm.com>
 <20200701090751.7543-5-ionela.voinescu@arm.com>
 <20200701095414.2wjcnyhndgcedk2q@vireshk-i7>
 <20200701140735.GB32736@arm.com>
 <20200702030551.p4cevaahgfvpum4o@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702030551.p4cevaahgfvpum4o@vireshk-i7>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Thursday 02 Jul 2020 at 08:35:51 (+0530), Viresh Kumar wrote:
> On 01-07-20, 15:07, Ionela Voinescu wrote:
> > On Wednesday 01 Jul 2020 at 16:16:19 (+0530), Viresh Kumar wrote:
> > > Is there anyone who cares for this driver and EAS ? I will just skip doing the
> > > FIE thing here and mark it skipped.
> > 
> > That is a good question. The vexpress driver is still used for TC2, but
> > I don't know of any users of this bL switcher functionality that's part
> > of the driver. I think there were a few people wondering recently if
> > it's still used [1].
> 
> Even if it is used by some, there is no need, I believe, to enable
> freq-invariance for it, which wasn't enabled until now.
>

It was enabled until now, but it was partially broken. If you look over
the driver you'll see arch_set_freq_scale() being called for both
is_bL_switching_enabled() and for when it's not [1].

For !is_bL_switching_enabled() this is fine. But for
is_bL_switching_enabled(), it is broken as described in 4/8.

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/cpufreq/vexpress-spc-cpufreq.c?h=v5.8-rc3#n203

> And considering that we are going to enable the flag only for the
> interested parties now, as from the discussion on 1/8, this shouldn't
> be required.
> 

If we just don't want frequency invariance for
is_bL_switching_enabled(), I can just guard the setting of the flag
suggested by Rafael at 1/8 by !CONFIG_BL_SWITCHER.

I'll proceed to do that and remove the fix at 4/8.

Many thanks!
Ionela.

> -- 
> viresh

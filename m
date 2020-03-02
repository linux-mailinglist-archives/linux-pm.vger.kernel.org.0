Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52FDF175CDC
	for <lists+linux-pm@lfdr.de>; Mon,  2 Mar 2020 15:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbgCBOX2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Mar 2020 09:23:28 -0500
Received: from foss.arm.com ([217.140.110.172]:33320 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726969AbgCBOX2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 2 Mar 2020 09:23:28 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D20BE2F;
        Mon,  2 Mar 2020 06:23:27 -0800 (PST)
Received: from localhost (e108754-lin.cambridge.arm.com [10.1.198.53])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 72AF63F534;
        Mon,  2 Mar 2020 06:23:27 -0800 (PST)
Date:   Mon, 2 Mar 2020 14:23:26 +0000
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     will@kernel.org, mark.rutland@arm.com, maz@kernel.org,
        suzuki.poulose@arm.com, sudeep.holla@arm.com, lukasz.luba@arm.com,
        valentin.schneider@arm.com, dietmar.eggemann@arm.com,
        rjw@rjwysocki.net, pkondeti@codeaurora.org, peterz@infradead.org,
        mingo@redhat.com, vincent.guittot@linaro.org,
        viresh.kumar@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 1/7] arm64: add support for the AMU extension v1
Message-ID: <20200302142326.GA15709@arm.com>
References: <20200226132947.29738-1-ionela.voinescu@arm.com>
 <20200226132947.29738-2-ionela.voinescu@arm.com>
 <20200228103234.GA3904776@arrakis.emea.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200228103234.GA3904776@arrakis.emea.arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Catalin,

On Friday 28 Feb 2020 at 10:32:34 (+0000), Catalin Marinas wrote:
> Hi Ionela,
> 
> On Wed, Feb 26, 2020 at 01:29:41PM +0000, Ionela Voinescu wrote:
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index dbc22d684627..49f0c436928f 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -318,6 +318,15 @@
> >  			Format: <a>,<b>
> >  			See also Documentation/input/joydev/joystick.rst
> >  
> > +	amu=		[ARM64]
> > +			Enables or disables detection, enablement and access to
> > +			counter registers of the Activity Monitors Unit (AMU).
> > +			Format: amu=[0/1/on/off/y/n]
> > +			amu=[0/off/n] ensures access to AMU's counter registers
> > +				      is not attempted.
> > +			amu=[1/on/y] (default) enables detection and access to
> > +				     AMU's counter registers.
> 
> Is the only reason for this parameter to be able to disable the feature
> if the firmware doesn't support it? According to the Kconfig entry, you
> may see weird behaviour, firmware lock-up. Is the user supposed to try
> again with amu=0?
> 
> I'm not particularly fond of adding kernel parameters to work around
> broken firmware. We have other architecture features (e.g. PtrAuth) that
> need enabling at EL3 but we don't have such parameters. If it's likely
> that we hit this issue in practice, I'd rather have the firmware
> describing the presence of AMU via some DT entry. But I'd rather not
> bother at all, just get the vendors to update their firmware.
> 

The firmware is supposed to do three actions for the kernel to be able
to use the counters: enable access to EL2/EL1, enable the counters and
save/restore the counters before/after core-off.

Improper firmware support can trigger different issues: kernel/firmware
lockup/panic, invalid counter values (0, non-monotonic). Some of them
might be less likely (firmware lockups), and some might just be due to
present but improper support(save/restore) and therefore more likely.

The users of the counters, for example frequency invariance [6/7], does
some validation for this, but unfortunately not all conditions can be
fully mitigated - validate and bail out if some condition is not
accomplished - for example the save and restore functionality. This
might result in improper scale values after idle.

Therefore, the amu kernel parameter is not only there if the firmware
does not support AMU, but it's also there if the firmware support is
broken/improper. The kernel parameter was added at Suzuki's
recommendation to be able to bypass its use in single kernels that are
meant to run on multiple platforms. I also believe this is nice to have
even for platforms that properly support AMU, but they might not want
the use of the feature in the kernel.

> If we drop this parameter, patch 1 would need to change. Otherwise the
> patches look fine.
> 

This being said, I agree this was added as a 'just in case' and not as
support for a likely scenario, therefore, I don't fully disagree to drop
it for now.

Let me know what you think. If you'd still rather I drop it, I can do that
and rebase on top of Marc's changes and push v6.

Thanks,
Ionela.

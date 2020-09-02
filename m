Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD1EC25AC4D
	for <lists+linux-pm@lfdr.de>; Wed,  2 Sep 2020 15:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgIBNtx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Sep 2020 09:49:53 -0400
Received: from foss.arm.com ([217.140.110.172]:38380 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727852AbgIBNtx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 2 Sep 2020 09:49:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 888AED6E;
        Wed,  2 Sep 2020 06:24:32 -0700 (PDT)
Received: from bogus (unknown [10.57.4.218])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1F2923F885;
        Wed,  2 Sep 2020 06:24:31 -0700 (PDT)
Date:   Wed, 2 Sep 2020 14:24:28 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     rjw@rjwysocki.net, viresh.kumar@linaro.org,
        dietmar.eggemann@arm.com, catalin.marinas@arm.com, will@kernel.org,
        valentin.schneider@arm.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/5] arch_topology, arm, arm64: define
 arch_scale_freq_invariant()
Message-ID: <20200902132428.GD25462@bogus>
References: <20200901205549.30096-1-ionela.voinescu@arm.com>
 <20200901205549.30096-6-ionela.voinescu@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901205549.30096-6-ionela.voinescu@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Sep 01, 2020 at 09:55:49PM +0100, Ionela Voinescu wrote:
> From: Valentin Schneider <valentin.schneider@arm.com>
> 
> arch_scale_freq_invariant() is used by schedutil to determine whether
> the scheduler's load-tracking signals are frequency invariant. Its
> definition is overridable, though by default it is hardcoded to 'true'
> if arch_scale_freq_capacity() is defined ('false' otherwise).
> 
> This behaviour is not overridden on arm, arm64 and other users of the
> generic arch topology driver, which is somewhat precarious:
> arch_scale_freq_capacity() will always be defined, yet not all cpufreq
> drivers are guaranteed to drive the frequency invariance scale factor
> setting. In other words, the load-tracking signals may very well *not*
> be frequency invariant.
> 
> Now that cpufreq can be queried on whether the current driver is driving
> the Frequency Invariance (FI) scale setting, the current situation can
> be improved. This combines the query of whether cpufreq supports the
> setting of the frequency scale factor, with whether all online CPUs are
> counter-based FI enabled.
> 
> While cpufreq FI enablement applies at system level, for all CPUs,
> counter-based FI support could also be used for only a subset of CPUs to
> set the invariance scale factor. Therefore, if cpufreq-based FI support
> is present, we consider the system to be invariant. If missing, we
> require all online CPUs to be counter-based FI enabled in order for the
> full system to be considered invariant.
> 
> If the system ends up not being invariant, a new condition is needed in
> the counter initialization code that disables all scale factor setting
> based on counters.
> 
> Precedence of counters over cpufreq use is not important here. The
> invariant status is only given to the system if all CPUs have at least
> one method of setting the frequency scale factor.
> 
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Sudeep Holla <sudeep.holla@arm.com>

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep

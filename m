Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C13E23311C
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jul 2020 13:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbgG3Lox (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Jul 2020 07:44:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:51340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726267AbgG3Lox (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 30 Jul 2020 07:44:53 -0400
Received: from gaia (unknown [95.146.230.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FDAD2082E;
        Thu, 30 Jul 2020 11:44:50 +0000 (UTC)
Date:   Thu, 30 Jul 2020 12:44:48 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     rjw@rjwysocki.net, viresh.kumar@linaro.org,
        dietmar.eggemann@arm.com, sudeep.holla@arm.com, will@kernel.org,
        linux@armlinux.org.uk, mingo@redhat.com, peterz@infradead.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: Re: [PATCH v2 6/7] arch_topology,arm,arm64: define
 arch_scale_freq_invariant()
Message-ID: <20200730114447.GK25149@gaia>
References: <20200722093732.14297-1-ionela.voinescu@arm.com>
 <20200722093732.14297-7-ionela.voinescu@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722093732.14297-7-ionela.voinescu@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jul 22, 2020 at 10:37:31AM +0100, Ionela Voinescu wrote:
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
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Sudeep Holla <sudeep.holla@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

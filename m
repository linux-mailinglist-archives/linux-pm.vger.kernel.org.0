Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 395B62861F6
	for <lists+linux-pm@lfdr.de>; Wed,  7 Oct 2020 17:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbgJGPVX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Oct 2020 11:21:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:54386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726100AbgJGPVX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 7 Oct 2020 11:21:23 -0400
Received: from gaia (unknown [95.149.105.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7E2020797;
        Wed,  7 Oct 2020 15:21:20 +0000 (UTC)
Date:   Wed, 7 Oct 2020 16:21:18 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     sudeep.holla@arm.com, will@kernel.org, linux@armlinux.org.uk,
        rjw@rjwysocki.net, viresh.kumar@linaro.org,
        dietmar.eggemann@arm.com, valentin.schneider@arm.com,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] cpufreq,arm,arm64: restructure definitions of
 arch_set_freq_scale()
Message-ID: <20201007152117.GM3462@gaia>
References: <20200924123016.13427-1-ionela.voinescu@arm.com>
 <20200924123016.13427-2-ionela.voinescu@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924123016.13427-2-ionela.voinescu@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Sep 24, 2020 at 01:30:15PM +0100, Ionela Voinescu wrote:
> Compared to other arch_* functions, arch_set_freq_scale() has an atypical
> weak definition that can be replaced by a strong architecture specific
> implementation.
> 
> The more typical support for architectural functions involves defining
> an empty stub in a header file if the symbol is not already defined in
> architecture code. Some examples involve:
>  - #define arch_scale_freq_capacity	topology_get_freq_scale
>  - #define arch_scale_freq_invariant	topology_scale_freq_invariant
>  - #define arch_scale_cpu_capacity	topology_get_cpu_scale
>  - #define arch_update_cpu_topology	topology_update_cpu_topology
>  - #define arch_scale_thermal_pressure	topology_get_thermal_pressure
>  - #define arch_set_thermal_pressure	topology_set_thermal_pressure
> 
> Bring arch_set_freq_scale() in line with these functions by renaming it to
> topology_set_freq_scale() in the arch topology driver, and by defining the
> arch_set_freq_scale symbol to point to the new function for arm and arm64.
> 
> While there are other users of the arch_topology driver, this patch defines
> arch_set_freq_scale for arm and arm64 only, due to their existing
> definitions of arch_scale_freq_capacity. This is the getter function of the
> frequency invariance scale factor and without a getter function, the
> setter function - arch_set_freq_scale() has not purpose.
> 
> Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>

For the arm64 changes:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05B853A3D56
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jun 2021 09:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbhFKHkb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Jun 2021 03:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbhFKHka (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Jun 2021 03:40:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA9AEC061574;
        Fri, 11 Jun 2021 00:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=d+ZiczX7/nBR1jMhSfL1TaMj90+rVYq9+YaMIRDOsZE=; b=DpbRdQxX7AHqEpiFo8nq82GbOM
        PGuW69uCPEf2CcxctkEUO4jHZbgI8RbIj18OvWnpt3qJllBw/BMnliIALO+iIPy2Rp9w8f6mriOm2
        rY5nGTB3D2j8cd6PniRszOoXdM1kW6ZsFpXAeEojncXy+KDHRmkxJnK1grdoM8DKk8IT3V88EDsle
        Xoc9mjCC6IxNA7P0UVPO8Ko0+rGn8XbaIvi/sfWbfCgXFXursU1RFH5+oSRKLeHVS7vO9cLGhLJfu
        t84+dGJB2ZcrIfIfKNlStbY+ds+wGccjqiKGp4w9BZXA8wUyleuSK0HrbkkMulUV/5HjIRlz/KkB/
        y+mOEOiA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lrbjN-002Vyn-67; Fri, 11 Jun 2021 07:37:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9B8CC30008D;
        Fri, 11 Jun 2021 09:37:27 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 546502BCF392F; Fri, 11 Jun 2021 09:37:27 +0200 (CEST)
Date:   Fri, 11 Jun 2021 09:37:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Qian Cai <quic_qiancai@quicinc.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] Revert "cpufreq: CPPC: Add support for frequency
 invariance"
Message-ID: <YMMSt65aj0KKHy1A@hirez.programming.kicks-ass.net>
References: <a71c48fb0150f505680da68a82b4e4fca9a18439.1623381430.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a71c48fb0150f505680da68a82b4e4fca9a18439.1623381430.git.viresh.kumar@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jun 11, 2021 at 08:48:02AM +0530, Viresh Kumar wrote:
> This reverts commit 4c38f2df71c8e33c0b64865992d693f5022eeaad.
> 
> There are few races in the frequency invariance support for CPPC driver,
> namely the driver doesn't stop the kthread_work and irq_work on policy
> exit during suspend/resume or CPU hotplug.
> 
> A proper fix won't be possible for the 5.13-rc, as it requires a lot of
> changes. Lets revert the patch instead for now.
> 
> Fixes: 4c38f2df71c8 ("cpufreq: CPPC: Add support for frequency invariance")
> Reported-by: Qian Cai <quic_qiancai@quicinc.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> V2: Revert the original patch instead of marking it broken.
> 
>  drivers/cpufreq/Kconfig.arm    |  10 --
>  drivers/cpufreq/cppc_cpufreq.c | 245 ++-------------------------------
>  include/linux/arch_topology.h  |   1 -
>  kernel/sched/core.c            |   1 -
>  4 files changed, 12 insertions(+), 245 deletions(-)
> 
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index a5c5f70acfc9..e65e0a43be64 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -19,16 +19,6 @@ config ACPI_CPPC_CPUFREQ
>  
>  	  If in doubt, say N.
>  
> -config ACPI_CPPC_CPUFREQ_FIE
> -	bool "Frequency Invariance support for CPPC cpufreq driver"
> -	depends on ACPI_CPPC_CPUFREQ && GENERIC_ARCH_TOPOLOGY
> -	default y
> -	help
> -	  This extends frequency invariance support in the CPPC cpufreq driver,
> -	  by using CPPC delivered and reference performance counters.
> -
> -	  If in doubt, say N.
> -

Alternatively: "depends on BROKEN" ?

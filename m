Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D22D54E21C
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jun 2022 15:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376805AbiFPNhn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Jun 2022 09:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377107AbiFPNhl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Jun 2022 09:37:41 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9FAB9F
        for <linux-pm@vger.kernel.org>; Thu, 16 Jun 2022 06:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655386660; x=1686922660;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=piiUIJtA073ctQ3E/w3UM24ZPVf9he8zrqXvjP5vZNo=;
  b=iK/CQseLrMNpZ2iCUlGwdOYTXU2GrlOZMFfljbHEaGf9wuiB4HlWWaCJ
   W6nTMB1bhDsxNXFROqWLGBwYwlzShmmj5swfnWMGG8rxyu6OFrNFUFBer
   s2tNAKaJq2aXAy084gom4ZRIAAfe/dQJnEcqiN7VdE8DFmjHcQ95G5GfF
   cyf+9tZnEi6XaaNa++wkFafMy/kvklof73GlnUjgsO6llO7c6siKTR1Ia
   /je52pujUBDBjb4EKukqxOIahVuExNMJ7zvKUseBYoeZB3ECIFOlJk2dH
   4zVP/+lFHldd22lL+wL8uFaoIdIKbjpCOQJqVe/yBdBbZjl7nFZ/cKGRK
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10379"; a="262269836"
X-IronPort-AV: E=Sophos;i="5.92,305,1650956400"; 
   d="scan'208";a="262269836"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 06:37:38 -0700
X-IronPort-AV: E=Sophos;i="5.92,305,1650956400"; 
   d="scan'208";a="641543681"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.143])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 06:37:36 -0700
Date:   Thu, 16 Jun 2022 21:37:34 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>, linux-pm@vger.kernel.org,
        lkp@lists.01.org, lkp@intel.com
Subject: Re: [cpuidle]  f01f07f0a5:
 WARNING:at_drivers/cpuidle/cpuidle.c:#cpuidle_enter_state
Message-ID: <20220616133734.GB25633@xsang-OptiPlex-9020>
References: <20220602092019.GE27190@xsang-OptiPlex-9020>
 <YpiKWcbyoNnvUU6W@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YpiKWcbyoNnvUU6W@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

hi Peter,

On Thu, Jun 02, 2022 at 12:00:57PM +0200, Peter Zijlstra wrote:
> On Thu, Jun 02, 2022 at 05:20:19PM +0800, kernel test robot wrote:
> > 
> > 
> > Greeting,
> > 
> > FYI, we noticed the following commit (built with gcc-11):
> > 
> > commit: f01f07f0a50134a775f8e60fdaa559d2f5d63663 ("cpuidle: Move IRQ state validation")
> > https://git.kernel.org/cgit/linux/kernel/git/peterz/queue.git sched/idle
> > 
> > in testcase: netperf
> > version: netperf-x86_64-2.7-0_20220601
> > with following parameters:
> > 
> > 	ip: ipv4
> > 	runtime: 300s
> > 	nr_threads: 1
> > 	cluster: cs-localhost
> > 	send_size: 10K
> > 	test: SCTP_STREAM_MANY
> > 	cpufreq_governor: performance
> > 	ucode: 0xd000331
> > 
> > test-description: Netperf is a benchmark that can be use to measure various aspect of networking performance.
> > test-url: http://www.netperf.org/netperf/
> > 
> > 
> > on test machine: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz with 128G memory
> 
> I know this is a bit of an ask, but would it at all be possible to
> translate that into a code name; specifically, that "Platinum 8358"
> thing is "Ice Lake".

thanks for great suggestion! we will try to update our report-tool next week
to supply code name as well.

> 
> Our dear marketing department has made it absolutely impossible (without
> just plain googling it) to know what is what :/
> 
> > 
> > caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> Please, start the quote at the "------------[ cut here ]------------"
> marker, that's what it's for. Then you don't miss the actual warning:
> 
> [    4.147181][    T0] ------------[ cut here ]------------
> [    4.147182][    T0] intel_idle leaked IRQ state
>                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^ is the useful bit that went missing.

thanks a lot for education! we will check our report-tool logic why it behave
like this way and update it to let it give full useful information.

> 
> > [ 4.147200][ T0] WARNING: CPU: 1 PID: 0 at drivers/cpuidle/cpuidle.c:239 cpuidle_enter_state (drivers/cpuidle/cpuidle.c:239 (discriminator 3)) 
> > [    4.147205][    T0] Modules linked in:
> > [    4.147207][    T0] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.18.0-11271-gf01f07f0a501 #1
> 
> That's commit c227233ad64c ("intel_idle: enable interrupts before C1 on Xeons")
> breaking things. Fix below I suppose.
> 
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -129,21 +129,36 @@ static unsigned int mwait_substates __in
>   *
>   * Must be called under local_irq_disable().
>   */
> -static __cpuidle int intel_idle(struct cpuidle_device *dev,
> -				struct cpuidle_driver *drv, int index)
> +static __always_inline int __intel_idle(struct cpuidle_device *dev,
> +					struct cpuidle_driver *drv, int index)
>  {
>  	struct cpuidle_state *state = &drv->states[index];
>  	unsigned long eax = flg2MWAIT(state->flags);
>  	unsigned long ecx = 1; /* break on interrupt flag */
>  
> -	if (state->flags & CPUIDLE_FLAG_IRQ_ENABLE)
> -		local_irq_enable();
> -
>  	mwait_idle_with_hints(eax, ecx);
>  
>  	return index;
>  }
>  
> +static __cpuidle int intel_idle(struct cpuidle_device *dev,
> +				struct cpuidle_driver *drv, int index)
> +{
> +	return __intel_idle(dev, drv, index);
> +}
> +
> +static __cpuidle int intel_idle_irq(struct cpuidle_device *dev,
> +				    struct cpuidle_driver *drv, int index)
> +{
> +	int ret;
> +
> +	raw_local_irq_enable();
> +	ret = __intel_idle(dev, drv, index);
> +	raw_local_irq_disable();
> +
> +	return ret;
> +}
> +
>  /**
>   * intel_idle_s2idle - Ask the processor to enter the given idle state.
>   * @dev: cpuidle device of the target CPU.
> @@ -1801,6 +1816,9 @@ static void __init intel_idle_init_cstat
>  		/* Structure copy. */
>  		drv->states[drv->state_count] = cpuidle_state_table[cstate];
>  
> +		if (cpuidle_state_table[cstate].flags & CPUIDLE_FLAG_IRQ_ENABLE)
> +			drv->states[drv->state_count].enter = intel_idle_irq;
> +
>  		if ((disabled_states_mask & BIT(drv->state_count)) ||
>  		    ((icpu->use_acpi || force_use_acpi) &&
>  		     intel_idle_off_by_default(mwait_hint) &&

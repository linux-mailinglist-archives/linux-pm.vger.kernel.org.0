Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61ACF4F377
	for <lists+linux-pm@lfdr.de>; Sat, 22 Jun 2019 05:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbfFVDwP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Jun 2019 23:52:15 -0400
Received: from mga11.intel.com ([192.55.52.93]:17287 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726049AbfFVDwP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 21 Jun 2019 23:52:15 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jun 2019 20:52:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,403,1557212400"; 
   d="scan'208";a="154663951"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 21 Jun 2019 20:52:12 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1heX4V-0002Sl-Io; Sat, 22 Jun 2019 11:52:11 +0800
Date:   Sat, 22 Jun 2019 11:52:09 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     kbuild-all@01.org, rafael@kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:CPU IDLE TIME MANAGEMENT FRAMEWORK" 
        <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] cpuidle/drivers/mobile: Add new governor for
 mobile/embedded systems
Message-ID: <201906221104.YRaP3P6c%lkp@intel.com>
References: <20190620115826.4897-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190620115826.4897-1-daniel.lezcano@linaro.org>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Daniel,

I love your patch! Perhaps something to improve:

[auto build test WARNING on pm/linux-next]
[also build test WARNING on v5.2-rc5 next-20190621]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Daniel-Lezcano/cpuidle-drivers-mobile-Add-new-governor-for-mobile-embedded-systems/20190622-064303
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-rc1-7-g2b96cd8-dirty
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)


vim +502 kernel/irq/timings.c

bbba0e7c Daniel Lezcano      2019-03-28  437  
e1c92149 Daniel Lezcano      2017-06-23  438  /**
e1c92149 Daniel Lezcano      2017-06-23  439   * irq_timings_next_event - Return when the next event is supposed to arrive
e1c92149 Daniel Lezcano      2017-06-23  440   *
e1c92149 Daniel Lezcano      2017-06-23  441   * During the last busy cycle, the number of interrupts is incremented
e1c92149 Daniel Lezcano      2017-06-23  442   * and stored in the irq_timings structure. This information is
e1c92149 Daniel Lezcano      2017-06-23  443   * necessary to:
e1c92149 Daniel Lezcano      2017-06-23  444   *
e1c92149 Daniel Lezcano      2017-06-23  445   * - know if the index in the table wrapped up:
e1c92149 Daniel Lezcano      2017-06-23  446   *
e1c92149 Daniel Lezcano      2017-06-23  447   *      If more than the array size interrupts happened during the
e1c92149 Daniel Lezcano      2017-06-23  448   *      last busy/idle cycle, the index wrapped up and we have to
e1c92149 Daniel Lezcano      2017-06-23  449   *      begin with the next element in the array which is the last one
e1c92149 Daniel Lezcano      2017-06-23  450   *      in the sequence, otherwise it is a the index 0.
e1c92149 Daniel Lezcano      2017-06-23  451   *
e1c92149 Daniel Lezcano      2017-06-23  452   * - have an indication of the interrupts activity on this CPU
e1c92149 Daniel Lezcano      2017-06-23  453   *   (eg. irq/sec)
e1c92149 Daniel Lezcano      2017-06-23  454   *
e1c92149 Daniel Lezcano      2017-06-23  455   * The values are 'consumed' after inserting in the statistical model,
e1c92149 Daniel Lezcano      2017-06-23  456   * thus the count is reinitialized.
e1c92149 Daniel Lezcano      2017-06-23  457   *
e1c92149 Daniel Lezcano      2017-06-23  458   * The array of values **must** be browsed in the time direction, the
e1c92149 Daniel Lezcano      2017-06-23  459   * timestamp must increase between an element and the next one.
e1c92149 Daniel Lezcano      2017-06-23  460   *
e1c92149 Daniel Lezcano      2017-06-23  461   * Returns a nanosec time based estimation of the earliest interrupt,
e1c92149 Daniel Lezcano      2017-06-23  462   * U64_MAX otherwise.
e1c92149 Daniel Lezcano      2017-06-23  463   */
e1c92149 Daniel Lezcano      2017-06-23  464  u64 irq_timings_next_event(u64 now)
e1c92149 Daniel Lezcano      2017-06-23  465  {
bbba0e7c Daniel Lezcano      2019-03-28  466  	struct irq_timings *irqts = this_cpu_ptr(&irq_timings);
bbba0e7c Daniel Lezcano      2019-03-28  467  	struct irqt_stat *irqs;
bbba0e7c Daniel Lezcano      2019-03-28  468  	struct irqt_stat __percpu *s;
bbba0e7c Daniel Lezcano      2019-03-28  469  	u64 ts, next_evt = U64_MAX;
bbba0e7c Daniel Lezcano      2019-03-28  470  	int i, irq = 0;
bbba0e7c Daniel Lezcano      2019-03-28  471  
e1c92149 Daniel Lezcano      2017-06-23  472  	/*
e1c92149 Daniel Lezcano      2017-06-23  473  	 * This function must be called with the local irq disabled in
e1c92149 Daniel Lezcano      2017-06-23  474  	 * order to prevent the timings circular buffer to be updated
e1c92149 Daniel Lezcano      2017-06-23  475  	 * while we are reading it.
e1c92149 Daniel Lezcano      2017-06-23  476  	 */
a934d4d1 Frederic Weisbecker 2017-11-06  477  	lockdep_assert_irqs_disabled();
e1c92149 Daniel Lezcano      2017-06-23  478  
bbba0e7c Daniel Lezcano      2019-03-28  479  	if (!irqts->count)
bbba0e7c Daniel Lezcano      2019-03-28  480  		return next_evt;
bbba0e7c Daniel Lezcano      2019-03-28  481  
bbba0e7c Daniel Lezcano      2019-03-28  482  	/*
bbba0e7c Daniel Lezcano      2019-03-28  483  	 * Number of elements in the circular buffer: If it happens it
bbba0e7c Daniel Lezcano      2019-03-28  484  	 * was flushed before, then the number of elements could be
bbba0e7c Daniel Lezcano      2019-03-28  485  	 * smaller than IRQ_TIMINGS_SIZE, so the count is used,
bbba0e7c Daniel Lezcano      2019-03-28  486  	 * otherwise the array size is used as we wrapped. The index
bbba0e7c Daniel Lezcano      2019-03-28  487  	 * begins from zero when we did not wrap. That could be done
bbba0e7c Daniel Lezcano      2019-03-28  488  	 * in a nicer way with the proper circular array structure
bbba0e7c Daniel Lezcano      2019-03-28  489  	 * type but with the cost of extra computation in the
bbba0e7c Daniel Lezcano      2019-03-28  490  	 * interrupt handler hot path. We choose efficiency.
bbba0e7c Daniel Lezcano      2019-03-28  491  	 *
bbba0e7c Daniel Lezcano      2019-03-28  492  	 * Inject measured irq/timestamp to the pattern prediction
bbba0e7c Daniel Lezcano      2019-03-28  493  	 * model while decrementing the counter because we consume the
bbba0e7c Daniel Lezcano      2019-03-28  494  	 * data from our circular buffer.
bbba0e7c Daniel Lezcano      2019-03-28  495  	 */
bbba0e7c Daniel Lezcano      2019-03-28  496  
bbba0e7c Daniel Lezcano      2019-03-28  497  	i = (irqts->count & IRQ_TIMINGS_MASK) - 1;
bbba0e7c Daniel Lezcano      2019-03-28  498  	irqts->count = min(IRQ_TIMINGS_SIZE, irqts->count);
bbba0e7c Daniel Lezcano      2019-03-28  499  
bbba0e7c Daniel Lezcano      2019-03-28  500  	for (; irqts->count > 0; irqts->count--, i = (i + 1) & IRQ_TIMINGS_MASK) {
bbba0e7c Daniel Lezcano      2019-03-28  501  		irq = irq_timing_decode(irqts->values[i], &ts);
bbba0e7c Daniel Lezcano      2019-03-28 @502  		s = idr_find(&irqt_stats, irq);
bbba0e7c Daniel Lezcano      2019-03-28  503  		if (s)
bbba0e7c Daniel Lezcano      2019-03-28  504  			irq_timings_store(irq, this_cpu_ptr(s), ts);
bbba0e7c Daniel Lezcano      2019-03-28  505  	}
bbba0e7c Daniel Lezcano      2019-03-28  506  
bbba0e7c Daniel Lezcano      2019-03-28  507  	/*
bbba0e7c Daniel Lezcano      2019-03-28  508  	 * Look in the list of interrupts' statistics, the earliest
bbba0e7c Daniel Lezcano      2019-03-28  509  	 * next event.
bbba0e7c Daniel Lezcano      2019-03-28  510  	 */
bbba0e7c Daniel Lezcano      2019-03-28 @511  	idr_for_each_entry(&irqt_stats, s, i) {
bbba0e7c Daniel Lezcano      2019-03-28  512  
bbba0e7c Daniel Lezcano      2019-03-28  513  		irqs = this_cpu_ptr(s);
bbba0e7c Daniel Lezcano      2019-03-28  514  
bbba0e7c Daniel Lezcano      2019-03-28  515  		ts = __irq_timings_next_event(irqs, i, now);
bbba0e7c Daniel Lezcano      2019-03-28  516  		if (ts <= now)
bbba0e7c Daniel Lezcano      2019-03-28  517  			return now;
bbba0e7c Daniel Lezcano      2019-03-28  518  
bbba0e7c Daniel Lezcano      2019-03-28  519  		if (ts < next_evt)
bbba0e7c Daniel Lezcano      2019-03-28  520  			next_evt = ts;
bbba0e7c Daniel Lezcano      2019-03-28  521  	}
bbba0e7c Daniel Lezcano      2019-03-28  522  
bbba0e7c Daniel Lezcano      2019-03-28  523  	return next_evt;
e1c92149 Daniel Lezcano      2017-06-23  524  }
e1c92149 Daniel Lezcano      2017-06-23  525  
e1c92149 Daniel Lezcano      2017-06-23  526  void irq_timings_free(int irq)
e1c92149 Daniel Lezcano      2017-06-23  527  {
e1c92149 Daniel Lezcano      2017-06-23  528  	struct irqt_stat __percpu *s;
e1c92149 Daniel Lezcano      2017-06-23  529  
e1c92149 Daniel Lezcano      2017-06-23  530  	s = idr_find(&irqt_stats, irq);
e1c92149 Daniel Lezcano      2017-06-23  531  	if (s) {
e1c92149 Daniel Lezcano      2017-06-23  532  		free_percpu(s);
e1c92149 Daniel Lezcano      2017-06-23  533  		idr_remove(&irqt_stats, irq);
e1c92149 Daniel Lezcano      2017-06-23  534  	}
e1c92149 Daniel Lezcano      2017-06-23  535  }
e1c92149 Daniel Lezcano      2017-06-23  536  
e1c92149 Daniel Lezcano      2017-06-23  537  int irq_timings_alloc(int irq)
e1c92149 Daniel Lezcano      2017-06-23  538  {
e1c92149 Daniel Lezcano      2017-06-23  539  	struct irqt_stat __percpu *s;
e1c92149 Daniel Lezcano      2017-06-23  540  	int id;
e1c92149 Daniel Lezcano      2017-06-23  541  
e1c92149 Daniel Lezcano      2017-06-23  542  	/*
e1c92149 Daniel Lezcano      2017-06-23  543  	 * Some platforms can have the same private interrupt per cpu,
e1c92149 Daniel Lezcano      2017-06-23  544  	 * so this function may be be called several times with the
e1c92149 Daniel Lezcano      2017-06-23  545  	 * same interrupt number. Just bail out in case the per cpu
e1c92149 Daniel Lezcano      2017-06-23  546  	 * stat structure is already allocated.
e1c92149 Daniel Lezcano      2017-06-23  547  	 */
e1c92149 Daniel Lezcano      2017-06-23  548  	s = idr_find(&irqt_stats, irq);
e1c92149 Daniel Lezcano      2017-06-23  549  	if (s)
e1c92149 Daniel Lezcano      2017-06-23  550  		return 0;
e1c92149 Daniel Lezcano      2017-06-23  551  
e1c92149 Daniel Lezcano      2017-06-23  552  	s = alloc_percpu(*s);
e1c92149 Daniel Lezcano      2017-06-23  553  	if (!s)
e1c92149 Daniel Lezcano      2017-06-23  554  		return -ENOMEM;
e1c92149 Daniel Lezcano      2017-06-23  555  
e1c92149 Daniel Lezcano      2017-06-23  556  	idr_preload(GFP_KERNEL);
e1c92149 Daniel Lezcano      2017-06-23 @557  	id = idr_alloc(&irqt_stats, s, irq, irq + 1, GFP_NOWAIT);

:::::: The code at line 502 was first introduced by commit
:::::: bbba0e7c5cdadb47a91edea1d5cd0caadbbb016f genirq/timings: Add array suffix computation code

:::::: TO: Daniel Lezcano <daniel.lezcano@linaro.org>
:::::: CC: Thomas Gleixner <tglx@linutronix.de>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3134E8082
	for <lists+linux-pm@lfdr.de>; Sat, 26 Mar 2022 11:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232603AbiCZKpy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 26 Mar 2022 06:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232566AbiCZKpx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 26 Mar 2022 06:45:53 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EADD17FD20;
        Sat, 26 Mar 2022 03:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648291456; x=1679827456;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6mJPEImCGgeuD3H9umE30PP85vJYCZO7oY6Zb/9uvlc=;
  b=XTDWBd33wd268zix0wewKj06FxHUK99lFDZBA40szbuqGQpBN0IqR/YO
   NqWw75banjpqOH2OLk0lR2LtRi1oNXxTiGy7RiOE2rSWuqHgQBPDXSfwQ
   Drdc7wTmmGMxx1pEFxlh3aOOmLQXgrfl9c2+6C/YAHVJcwRJkM9e0PwTg
   UdwczCgf/mesANTgP5H3y7YZEQZQ6/R6uQhgNramKlyjcS4PEpxO3Hty/
   rCJsFuQ1z9tzqk8UwVS02NMb/LJnImN1u1rGCkocOnTbAMtdyYZhMbLQ9
   yyyo4eHDYGHQl0Ox1vA37jvBplRxO8WgosBftzW9ugXZf38mdRWRaws1j
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10297"; a="258490961"
X-IronPort-AV: E=Sophos;i="5.90,213,1643702400"; 
   d="scan'208";a="258490961"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2022 03:44:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,213,1643702400"; 
   d="scan'208";a="650496391"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 26 Mar 2022 03:44:12 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nY3u0-000NHm-2w; Sat, 26 Mar 2022 10:44:12 +0000
Date:   Sat, 26 Mar 2022 18:43:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Subject: Re: [PATCH v3 3/4] cpufreq: qcom-hw: fix the opp entries refcounting
Message-ID: <202203261801.7gUYlIj3-lkp@intel.com>
References: <20220325194721.2263571-4-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220325194721.2263571-4-dmitry.baryshkov@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Dmitry,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on v5.17 next-20220325]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Dmitry-Baryshkov/cpufreq-qcom-hw-Fixes-for-cpu-hotplug-support/20220326-040226
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20220326/202203261801.7gUYlIj3-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0f6d9501cf49ce02937099350d08f20c4af86f3d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/0day-ci/linux/commit/0c1c62881dde7d4b3e6f74d8ab44f038f82f2f60
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Dmitry-Baryshkov/cpufreq-qcom-hw-Fixes-for-cpu-hotplug-support/20220326-040226
        git checkout 0c1c62881dde7d4b3e6f74d8ab44f038f82f2f60
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/cpufreq/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/cpufreq/qcom-cpufreq-hw.c:314:54: warning: variable 'throttled_freq' is uninitialized when used here [-Wuninitialized]
                   arch_update_thermal_pressure(policy->related_cpus, throttled_freq);
                                                                      ^~~~~~~~~~~~~~
   drivers/cpufreq/qcom-cpufreq-hw.c:295:39: note: initialize the variable 'throttled_freq' to silence this warning
           unsigned long freq_hz, throttled_freq;
                                                ^
                                                 = 0
   1 warning generated.


vim +/throttled_freq +314 drivers/cpufreq/qcom-cpufreq-hw.c

275157b367f479 Thara Gopinath   2021-08-09  289  
275157b367f479 Thara Gopinath   2021-08-09  290  static void qcom_lmh_dcvs_notify(struct qcom_cpufreq_data *data)
275157b367f479 Thara Gopinath   2021-08-09  291  {
275157b367f479 Thara Gopinath   2021-08-09  292  	struct cpufreq_policy *policy = data->policy;
054b9f6e7282ce Dmitry Baryshkov 2022-03-25  293  	int cpu = cpumask_first(policy->related_cpus);
275157b367f479 Thara Gopinath   2021-08-09  294  	struct device *dev = get_cpu_device(cpu);
0258cb19c77deb Lukasz Luba      2021-11-09  295  	unsigned long freq_hz, throttled_freq;
275157b367f479 Thara Gopinath   2021-08-09  296  	struct dev_pm_opp *opp;
275157b367f479 Thara Gopinath   2021-08-09  297  	unsigned int freq;
275157b367f479 Thara Gopinath   2021-08-09  298  
275157b367f479 Thara Gopinath   2021-08-09  299  	/*
275157b367f479 Thara Gopinath   2021-08-09  300  	 * Get the h/w throttled frequency, normalize it using the
275157b367f479 Thara Gopinath   2021-08-09  301  	 * registered opp table and use it to calculate thermal pressure.
275157b367f479 Thara Gopinath   2021-08-09  302  	 */
275157b367f479 Thara Gopinath   2021-08-09  303  	freq = qcom_lmh_get_throttle_freq(data);
275157b367f479 Thara Gopinath   2021-08-09  304  	freq_hz = freq * HZ_PER_KHZ;
275157b367f479 Thara Gopinath   2021-08-09  305  
275157b367f479 Thara Gopinath   2021-08-09  306  	opp = dev_pm_opp_find_freq_floor(dev, &freq_hz);
275157b367f479 Thara Gopinath   2021-08-09  307  	if (IS_ERR(opp) && PTR_ERR(opp) == -ERANGE)
0c1c62881dde7d Dmitry Baryshkov 2022-03-25  308  		opp = dev_pm_opp_find_freq_ceil(dev, &freq_hz);
275157b367f479 Thara Gopinath   2021-08-09  309  
0c1c62881dde7d Dmitry Baryshkov 2022-03-25  310  	if (IS_ERR(opp)) {
0c1c62881dde7d Dmitry Baryshkov 2022-03-25  311  		dev_warn(dev, "Can't find the OPP for throttling: %pe!\n", opp);
0c1c62881dde7d Dmitry Baryshkov 2022-03-25  312  	} else {
0258cb19c77deb Lukasz Luba      2021-11-09  313  		/* Update thermal pressure (the boost frequencies are accepted) */
0258cb19c77deb Lukasz Luba      2021-11-09 @314  		arch_update_thermal_pressure(policy->related_cpus, throttled_freq);
275157b367f479 Thara Gopinath   2021-08-09  315  
0c1c62881dde7d Dmitry Baryshkov 2022-03-25  316  		dev_pm_opp_put(opp);
0c1c62881dde7d Dmitry Baryshkov 2022-03-25  317  	}
0c1c62881dde7d Dmitry Baryshkov 2022-03-25  318  
275157b367f479 Thara Gopinath   2021-08-09  319  	/*
275157b367f479 Thara Gopinath   2021-08-09  320  	 * In the unlikely case policy is unregistered do not enable
275157b367f479 Thara Gopinath   2021-08-09  321  	 * polling or h/w interrupt
275157b367f479 Thara Gopinath   2021-08-09  322  	 */
275157b367f479 Thara Gopinath   2021-08-09  323  	mutex_lock(&data->throttle_lock);
275157b367f479 Thara Gopinath   2021-08-09  324  	if (data->cancel_throttle)
275157b367f479 Thara Gopinath   2021-08-09  325  		goto out;
275157b367f479 Thara Gopinath   2021-08-09  326  
275157b367f479 Thara Gopinath   2021-08-09  327  	/*
275157b367f479 Thara Gopinath   2021-08-09  328  	 * If h/w throttled frequency is higher than what cpufreq has requested
275157b367f479 Thara Gopinath   2021-08-09  329  	 * for, then stop polling and switch back to interrupt mechanism.
275157b367f479 Thara Gopinath   2021-08-09  330  	 */
275157b367f479 Thara Gopinath   2021-08-09  331  	if (throttled_freq >= qcom_cpufreq_hw_get(cpu))
275157b367f479 Thara Gopinath   2021-08-09  332  		enable_irq(data->throttle_irq);
275157b367f479 Thara Gopinath   2021-08-09  333  	else
275157b367f479 Thara Gopinath   2021-08-09  334  		mod_delayed_work(system_highpri_wq, &data->throttle_work,
275157b367f479 Thara Gopinath   2021-08-09  335  				 msecs_to_jiffies(10));
275157b367f479 Thara Gopinath   2021-08-09  336  
275157b367f479 Thara Gopinath   2021-08-09  337  out:
275157b367f479 Thara Gopinath   2021-08-09  338  	mutex_unlock(&data->throttle_lock);
275157b367f479 Thara Gopinath   2021-08-09  339  }
275157b367f479 Thara Gopinath   2021-08-09  340  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

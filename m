Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2E1F51FEDD
	for <lists+linux-pm@lfdr.de>; Mon,  9 May 2022 15:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236616AbiEIN4R (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 May 2022 09:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236529AbiEIN4M (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 May 2022 09:56:12 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C21BBE07
        for <linux-pm@vger.kernel.org>; Mon,  9 May 2022 06:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652104337; x=1683640337;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=kU+skApzpOV77ptWSa9MmY3qt6uJPKTjCq/D4Ml+90o=;
  b=H3ScxuqRj+os458yvesWp2PWSHIq8COUPZdKz++Kn4ElwhE6a/p/XezQ
   TqvgZ5Mnvo2f2dqptEGDJz0wyAfBFaZw7ta7ZUTiwN2SICZ8Oe0oVkpFe
   rbijT15sQ4rVL81cSoDYynZWTvBKW6OysMC/2UjXzop8HdxjXX+0z1J7h
   A13EiprzaxTOVdQyaZy2oc1N5KYPzwl+kD446En04aeIDx5dPqdBYmaf5
   82up5Bb2ZKVw6KTX4IW/bfCDEoxPYCyKZtJ1MT097mWUsR5C4AFAzinBH
   HgQcjZhy/D/7XBUHoJ9baBlOaJSgG0OnsN8kRwvtAQsxdkzOhg8Y1v+KN
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="268720525"
X-IronPort-AV: E=Sophos;i="5.91,211,1647327600"; 
   d="scan'208";a="268720525"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 06:52:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,211,1647327600"; 
   d="scan'208";a="551027046"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 09 May 2022 06:52:14 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1no3o6-000GYc-7m;
        Mon, 09 May 2022 13:52:14 +0000
Date:   Mon, 9 May 2022 21:51:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-pm@vger.kernel.org
Subject: [chanwoo:devfreq-testing 5/5]
 drivers/devfreq/governor_passive.c:409:2: error: use of undeclared
 identifier 'ret'
Message-ID: <202205092158.pfjjAl5S-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git devfreq-testing
head:   edb11683479cd9e51010f571ae4011ae01e88ee5
commit: edb11683479cd9e51010f571ae4011ae01e88ee5 [5/5] PM / devfreq: passive: Update frequency when start governor
config: arm64-randconfig-r034-20220509 (https://download.01.org/0day-ci/archive/20220509/202205092158.pfjjAl5S-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a385645b470e2d3a1534aae618ea56b31177639f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/commit/?id=edb11683479cd9e51010f571ae4011ae01e88ee5
        git remote add chanwoo https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git
        git fetch --no-tags chanwoo devfreq-testing
        git checkout edb11683479cd9e51010f571ae4011ae01e88ee5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/devfreq/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/devfreq/governor_passive.c:409:2: error: use of undeclared identifier 'ret'
           ret = devfreq_update_target(devfreq, parent->previous_freq);
           ^
   drivers/devfreq/governor_passive.c:410:6: error: use of undeclared identifier 'ret'
           if (ret < 0)
               ^
   drivers/devfreq/governor_passive.c:424:18: warning: unused variable 'parent' [-Wunused-variable]
           struct devfreq *parent = (struct devfreq *)p_data->parent;
                           ^
   1 warning and 2 errors generated.


vim +/ret +409 drivers/devfreq/governor_passive.c

   387	
   388	static int devfreq_passive_register_notifier(struct devfreq *devfreq)
   389	{
   390		struct devfreq_passive_data *p_data
   391				= (struct devfreq_passive_data *)devfreq->data;
   392		struct devfreq *parent = (struct devfreq *)p_data->parent;
   393		struct notifier_block *nb = &p_data->nb;
   394	
   395		if (!parent)
   396			return -EPROBE_DEFER;
   397	
   398		/*
   399		 * If the parent device changes the their frequency before
   400		 * registering the passive device, the passive device cannot
   401		 * receive the notification from parent device and then the
   402		 * passive device cannot be able to set the proper frequency
   403		 * according to the frequency of parent device.
   404		 *
   405		 * When start the passive governor, update the frequency
   406		 * according to the frequency of parent device.
   407		 */
   408		mutex_lock(&devfreq->lock);
 > 409		ret = devfreq_update_target(devfreq, parent->previous_freq);
   410		if (ret < 0)
   411			dev_warn(&devfreq->dev,
   412			"failed to update devfreq using passive governor\n");
   413		mutex_unlock(&devfreq->lock);
   414	
   415		nb->notifier_call = devfreq_passive_notifier_call;
   416		return devfreq_register_notifier(parent, nb, DEVFREQ_TRANSITION_NOTIFIER);
   417	}
   418	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

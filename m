Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D55307A0585
	for <lists+linux-pm@lfdr.de>; Thu, 14 Sep 2023 15:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238934AbjINNZa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Sep 2023 09:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235397AbjINNZa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Sep 2023 09:25:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49EA01BEB
        for <linux-pm@vger.kernel.org>; Thu, 14 Sep 2023 06:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694697926; x=1726233926;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uMETyqtbGd0+2yZ6vcmk8p1UWyK4xWyn8bFDmPW9z1k=;
  b=IJD28pYjs+y7bYnTOrO8s2sptpXSf1RkUqScH5VJXuYAWE/IlT1ETm7L
   waURxWd810NvL8/I4olv/8mr4i+HToxPZIRyFefnfYuWPs6cFr6uEc+ib
   NVhRIOyoxZ+uAwaSrZ5OHTRZMDyiYqfSot54NC0dXgwJseks+5mce9m/e
   4fOBWbMQTBdTfSdwqqKS//kuSOjqW1rHTHql0iE8egfIv2tW1urF7/72+
   S83iAGIxj3PtF2YRLULUR5XGGQaLCpOPOaNkOcNGDMkeOMBUm+swO+6KF
   EtQ0VmysKwdoPTeOIaMn559CGaq68UkBu6t5+ZUxw4OOQk3XC8U8PJU1N
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="377856370"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="377856370"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 06:25:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="779625823"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="779625823"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 14 Sep 2023 06:25:03 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qgmL7-0001cf-2f;
        Thu, 14 Sep 2023 13:25:01 +0000
Date:   Thu, 14 Sep 2023 21:24:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiazi Li <jqqlijiazi@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     oe-kbuild-all@lists.linux.dev, Jiazi Li <jiazi.li@transsion.com>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH] PM / devfreq: Show trans_stat info via debugfs
Message-ID: <202309142101.hL5Buk6G-lkp@intel.com>
References: <20230914102317.29302-1-jiazi.li@transsion.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914102317.29302-1-jiazi.li@transsion.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Jiazi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on chanwoo/devfreq-testing]
[also build test WARNING on linus/master v6.6-rc1 next-20230914]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jiazi-Li/PM-devfreq-Show-trans_stat-info-via-debugfs/20230914-182515
base:   https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git devfreq-testing
patch link:    https://lore.kernel.org/r/20230914102317.29302-1-jiazi.li%40transsion.com
patch subject: [PATCH] PM / devfreq: Show trans_stat info via debugfs
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230914/202309142101.hL5Buk6G-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230914/202309142101.hL5Buk6G-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309142101.hL5Buk6G-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/devfreq/devfreq.c:1699: warning: Function parameter or member 'unused' not described in 'devfreq_trans_stat_show'
>> drivers/devfreq/devfreq.c:1699: warning: Excess function parameter 'data' description in 'devfreq_trans_stat_show'


vim +1699 drivers/devfreq/devfreq.c

  1689	
  1690	/**
  1691	 * devfreq_trans_stat_show() - show trans stat info through debugfs
  1692	 * @s:		seq_file instance to show trans_stat info of devfreq devices
  1693	 * @data:	not used
  1694	 *
  1695	 * Show detailed information for some device which has more than PAGE_SIZE
  1696	 * bytes of trans stat info.
  1697	 */
  1698	static int devfreq_trans_stat_show(struct seq_file *s, void *unused)
> 1699	{
  1700		struct devfreq *df = s->private;
  1701		unsigned int max_state;
  1702		int i, j;
  1703	
  1704		if (!df->profile)
  1705			return -EINVAL;
  1706		max_state = df->max_state;
  1707	
  1708		if (max_state == 0) {
  1709			seq_puts(s, "Not Supported.\n");
  1710			return 0;
  1711		}
  1712	
  1713		mutex_lock(&df->lock);
  1714		if (!df->stop_polling &&
  1715				devfreq_update_status(df, df->previous_freq)) {
  1716			mutex_unlock(&df->lock);
  1717			return 0;
  1718		}
  1719		mutex_unlock(&df->lock);
  1720	
  1721		seq_puts(s, "     From  :   To\n");
  1722		seq_puts(s, "           :");
  1723		for (i = 0; i < max_state; i++)
  1724			seq_printf(s, "%10lu", df->freq_table[i]);
  1725	
  1726		seq_puts(s, "   time(ms)\n");
  1727	
  1728		for (i = 0; i < max_state; i++) {
  1729			if (df->freq_table[i] == df->previous_freq)
  1730				seq_puts(s, "*");
  1731			else
  1732				seq_puts(s, " ");
  1733	
  1734			seq_printf(s, "%10lu:", df->freq_table[i]);
  1735	
  1736			for (j = 0; j < max_state; j++)
  1737				seq_printf(s, "%10u",
  1738					df->stats.trans_table[(i * max_state) + j]);
  1739	
  1740			seq_printf(s, "%10llu\n", (u64)
  1741				jiffies64_to_msecs(df->stats.time_in_state[i]));
  1742		}
  1743	
  1744		seq_printf(s, "Total transition : %u\n", df->stats.total_trans);
  1745	
  1746		return 0;
  1747	}
  1748	DEFINE_SHOW_ATTRIBUTE(devfreq_trans_stat);
  1749	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

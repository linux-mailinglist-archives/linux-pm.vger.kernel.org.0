Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B42578E3A0
	for <lists+linux-pm@lfdr.de>; Thu, 31 Aug 2023 02:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245217AbjHaAAd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Aug 2023 20:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244290AbjHaAAd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Aug 2023 20:00:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15BF3CDA;
        Wed, 30 Aug 2023 17:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693440029; x=1724976029;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wxwZZlb+EbAktrV9eW/BB6Z1DDRExWjc1tkBuUp5vHE=;
  b=msrsD3aAItSt+hcBo/QkL8IaqmrTLRPI6KigMyf7cBfTTJMXyHqBD1Sq
   qvIjNGFJ/JOCW/FJZpXXfriyUu+8CN/I5TTliORQ1yh48v/U97rhsQ+vf
   9xJx/mMCN9Iut6YYfVZ8CywTWUa7M2CeZIOPIUqpbFRyo+B16VLhZtBnM
   HHuiSDDdfFsdG7TG6Q49E7IAb9s7I4sQa4y2IKLxQk6XXKgEmEiyChgrW
   6yoVMDBwXgyurtcC2i/nzZAh4tQZpI3Vl4mg79CRNgE6bFca46EngHq8g
   Fp6l5+sX9/EjXrTHMvtFpZ0vn3wFXmqvzliK6SDaCs2x7GBh9vuuq1qwh
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="379526983"
X-IronPort-AV: E=Sophos;i="6.02,215,1688454000"; 
   d="scan'208";a="379526983"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 17:00:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="1070008382"
X-IronPort-AV: E=Sophos;i="6.02,215,1688454000"; 
   d="scan'208";a="1070008382"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 30 Aug 2023 17:00:14 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qbV6Y-000ANV-1p;
        Thu, 31 Aug 2023 00:00:10 +0000
Date:   Thu, 31 Aug 2023 07:59:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Fabio Estevam <festevam@gmail.com>, rafael@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, daniel.lezcano@linaro.org,
        amitk@kernel.org, rui.zhang@intel.com, linux-pm@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        Fabio Estevam <festevam@denx.de>
Subject: Re: [PATCH v6 3/3] thermal: thermal_core: Allow rebooting after
 critical temp
Message-ID: <202308310713.tQbEYXi1-lkp@intel.com>
References: <20230830151908.2149847-3-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830151908.2149847-3-festevam@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Fabio,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/thermal]
[also build test WARNING on linus/master v6.5 next-20230830]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Fabio-Estevam/reboot-Introduce-hw_protection_reboot/20230831-034226
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal
patch link:    https://lore.kernel.org/r/20230830151908.2149847-3-festevam%40gmail.com
patch subject: [PATCH v6 3/3] thermal: thermal_core: Allow rebooting after critical temp
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230831/202308310713.tQbEYXi1-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230831/202308310713.tQbEYXi1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308310713.tQbEYXi1-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/thermal/thermal_of.c:221:27: warning: 'critical_actions' defined but not used [-Wunused-const-variable=]
     221 | static const char * const critical_actions[] = {
         |                           ^~~~~~~~~~~~~~~~


vim +/critical_actions +221 drivers/thermal/thermal_of.c

   220	
 > 221	static const char * const critical_actions[] = {
   222		[THERMAL_CRITICAL_ACTION_SHUTDOWN]	= "shutdown",
   223		[THERMAL_CRITICAL_ACTION_REBOOT]	= "reboot",
   224	};
   225	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

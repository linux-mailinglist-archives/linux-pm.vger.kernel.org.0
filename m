Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC9D778E996
	for <lists+linux-pm@lfdr.de>; Thu, 31 Aug 2023 11:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbjHaJgB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 31 Aug 2023 05:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243816AbjHaJgB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 31 Aug 2023 05:36:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D18ACEB;
        Thu, 31 Aug 2023 02:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693474558; x=1725010558;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=D3KjoyegWgCFqbsvoAhvULbaH+lWNnUj86eE942AVgc=;
  b=WxbpgxIBX4arNrs0N0yAhGKl0ob17ZUcchqxH6ermJa/JDxBQuW1/0II
   ZtxYABxepBzKYAORe0Cst8TBVYCQjvFssQyTbz9ybTaI6+1fj82KpiAWx
   955yecPR6qW6OHWY3bD/c7Gld1Wrg2IonT7v7uf3P6iMEy8UMvxGcJqt0
   u3fnMhVPjy5ouE015doKy+P7nIdKsuuh9+434NhAU4OEJstZz5ow0cT3E
   FU/YElhz4c1lby6jNGucmcdZkqlA8U8WAimvfIHLg77IcoHjKYFatT0Wq
   8WllsIxxGZs1P4pCINP4Q8zDPnpQ/6gGbf/jlmrIDgILex98VtPJ/xF2b
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="360871343"
X-IronPort-AV: E=Sophos;i="6.02,216,1688454000"; 
   d="scan'208";a="360871343"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 02:35:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="986145667"
X-IronPort-AV: E=Sophos;i="6.02,216,1688454000"; 
   d="scan'208";a="986145667"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 31 Aug 2023 02:35:54 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qbe5Y-000BBn-2G;
        Thu, 31 Aug 2023 09:35:50 +0000
Date:   Thu, 31 Aug 2023 17:35:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Fabio Estevam <festevam@gmail.com>, rafael@kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@denx.de>
Subject: Re: [PATCH v6 3/3] thermal: thermal_core: Allow rebooting after
 critical temp
Message-ID: <202308311705.C7t4Vtwu-lkp@intel.com>
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
[also build test WARNING on linus/master v6.5 next-20230831]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Fabio-Estevam/reboot-Introduce-hw_protection_reboot/20230831-034226
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal
patch link:    https://lore.kernel.org/r/20230830151908.2149847-3-festevam%40gmail.com
patch subject: [PATCH v6 3/3] thermal: thermal_core: Allow rebooting after critical temp
config: s390-randconfig-r025-20230831 (https://download.01.org/0day-ci/archive/20230831/202308311705.C7t4Vtwu-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230831/202308311705.C7t4Vtwu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308311705.C7t4Vtwu-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/thermal/thermal_of.c:221:27: warning: unused variable 'critical_actions' [-Wunused-const-variable]
   static const char * const critical_actions[] = {
                             ^
   1 warning generated.


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

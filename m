Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 642687F00CB
	for <lists+linux-pm@lfdr.de>; Sat, 18 Nov 2023 16:59:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233095AbjKRP7K (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 18 Nov 2023 10:59:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbjKRP7A (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 18 Nov 2023 10:59:00 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ECFB2103
        for <linux-pm@vger.kernel.org>; Sat, 18 Nov 2023 07:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700323070; x=1731859070;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=skP3LCXJ9xsI3+N/L6EA++C4Xkj5EvMu+Gb62HwFpxI=;
  b=SttlCeejDsdFlKMWRntT5wFLxzqCF308utTZnWq4cZCbTL+cxurt9dNw
   sMt+Og/bGZkoC0RTytG6oPGV/fTM51hw0r8T+WVJImoZKYg6o9z+XOYEC
   O1GTzTutcLgAOwBATNb1ireaSTErQBOy6NBTCcZoTHvw6fL7yKQpeK/Lz
   E7K0ntHQ9AqEdsdF9sX0Gdy4KRxvuhRAIEqMJGq+CY14txtpOdJDwoewG
   wJpUiBpeF49A4m0RGcbLQOZ/FjXRU0p3DCOhGhkO5S7cTDE7kc9SusLtA
   xZ3bjaUPtoJR7M8oSw0UDcxAPwJKCK0XbkNolIhcdlCMA0Tn6eB7MudgN
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10898"; a="4534374"
X-IronPort-AV: E=Sophos;i="6.04,209,1695711600"; 
   d="scan'208";a="4534374"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2023 07:56:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10898"; a="769483332"
X-IronPort-AV: E=Sophos;i="6.04,209,1695711600"; 
   d="scan'208";a="769483332"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 18 Nov 2023 07:56:01 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r4Nfr-000427-1L;
        Sat, 18 Nov 2023 15:55:59 +0000
Date:   Sat, 18 Nov 2023 23:54:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Radu Solea <radusolea@google.com>, linux-pm@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, rafael@kernel.org,
        Radu Solea <radusolea@google.com>
Subject: Re: [PATCH RESEND] thermal core: add option to run PM_POST_SUSPEND
 asynchronously
Message-ID: <202311182337.iQCfkhrO-lkp@intel.com>
References: <20231116222842.2121193-1-radusolea@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231116222842.2121193-1-radusolea@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Radu,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/thermal]
[also build test WARNING on linus/master v6.7-rc1 next-20231117]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Radu-Solea/thermal-core-add-option-to-run-PM_POST_SUSPEND-asynchronously/20231117-063150
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal
patch link:    https://lore.kernel.org/r/20231116222842.2121193-1-radusolea%40google.com
patch subject: [PATCH RESEND] thermal core: add option to run PM_POST_SUSPEND asynchronously
config: csky-randconfig-r111-20231118 (https://download.01.org/0day-ci/archive/20231118/202311182337.iQCfkhrO-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231118/202311182337.iQCfkhrO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311182337.iQCfkhrO-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/thermal/thermal_core.c:49:20: sparse: sparse: symbol 'resume_thermal_zones_wk' was not declared. Should it be static?
   drivers/thermal/thermal_core.c: note: in included file (through include/linux/rculist.h, include/linux/pid.h, include/linux/sched.h, ...):
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true

vim +/resume_thermal_zones_wk +49 drivers/thermal/thermal_core.c

    47	
    48	#ifdef CONFIG_THERMAL_ASYNC_RESUME
  > 49	struct work_struct *resume_thermal_zones_wk;
    50	#endif /* CONFIG_THERMAL_ASYNC_RESUME */
    51	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

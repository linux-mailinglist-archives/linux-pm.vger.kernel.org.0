Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6635A3FEC
	for <lists+linux-pm@lfdr.de>; Mon, 29 Aug 2022 00:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbiH1WQk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 28 Aug 2022 18:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiH1WQj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 28 Aug 2022 18:16:39 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCDD02F3B3;
        Sun, 28 Aug 2022 15:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661724997; x=1693260997;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CocVa54v2hio1a8ErBXXDR0NegYDmrQDvFgX9fY3UsA=;
  b=djpQGGF11+PRo06KsJkp+wK9ODjjLRsF1WcZDCOm1/c6pnYiu/t7mhVh
   wsK8+9HayTh1rkdJL/qr6TxDH5Qri5yPDNtE9Nup4ZcRrYdUUsf/kHYiX
   VbHMg0390mVLxsLT1a1wBXZpPi6hSdQxPlUiyiL+kWr1ZBimImSoWrju4
   mMWhfaL99h3p9kM9UWPtiWW+9p8RhnRLClfupsnDYxnGfbbC6SHzlGKo8
   YmJ7yGiDA/4nVqlDyIyzfdg5T3xTZdq0YDzr4zEcV5Xp/syOHsM/bx7Lq
   2To1uPhvscFY3KudTCjJRW/kwZoda/er+KsIlTGILtejrt5SJbxyEP5On
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10453"; a="293515547"
X-IronPort-AV: E=Sophos;i="5.93,271,1654585200"; 
   d="scan'208";a="293515547"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2022 15:16:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,271,1654585200"; 
   d="scan'208";a="679431204"
Received: from lkp-server01.sh.intel.com (HELO fc16deae1c42) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 28 Aug 2022 15:16:35 -0700
Received: from kbuild by fc16deae1c42 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oSQa3-0001ff-0L;
        Sun, 28 Aug 2022 22:16:35 +0000
Date:   Mon, 29 Aug 2022 06:15:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arvid Norlander <lkml@vorpal.se>,
        platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Sebastian Reichel <sre@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Azael Avalos <coproscefalo@gmail.com>,
        Arvid Norlander <lkml@vorpal.se>
Subject: Re: [PATCH 2/3] platform/x86: Battery charge mode in toshiba_acpi
 (sysfs)
Message-ID: <202208290605.gE9IGbxE-lkp@intel.com>
References: <20220828192920.805253-3-lkml@vorpal.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220828192920.805253-3-lkml@vorpal.se>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Arvid,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on 1c23f9e627a7b412978b4e852793c5e3c3efc555]

url:    https://github.com/intel-lab-lkp/linux/commits/Arvid-Norlander/platform-x86-Battery-charge-mode-in-toshiba_acpi/20220829-033110
base:   1c23f9e627a7b412978b4e852793c5e3c3efc555
config: x86_64-randconfig-a014-20220829 (https://download.01.org/0day-ci/archive/20220829/202208290605.gE9IGbxE-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/a85fa4a6b19ae082f6018a07da93db965fb5ba11
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Arvid-Norlander/platform-x86-Battery-charge-mode-in-toshiba_acpi/20220829-033110
        git checkout a85fa4a6b19ae082f6018a07da93db965fb5ba11
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/platform/x86/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/platform/x86/toshiba_acpi.c:2992:6: warning: variable 'status' set but not used [-Wunused-but-set-variable]
           int status;
               ^
   1 warning generated.


vim +/status +2992 drivers/platform/x86/toshiba_acpi.c

  2984	
  2985	
  2986	/* ACPI battery hooking */
  2987	static ssize_t charge_control_end_threshold_show(struct device *device,
  2988							 struct device_attribute *attr,
  2989							 char *buf)
  2990	{
  2991		int state;
> 2992		int status;
  2993	
  2994		if (toshiba_acpi == NULL) {
  2995			pr_err("Toshiba ACPI object invalid\n");
  2996			return -ENODEV;
  2997		}
  2998	
  2999		status = toshiba_battery_charge_mode_get(toshiba_acpi, &state);
  3000		if (state == 1)
  3001			return sprintf(buf, "80\n");
  3002		else
  3003			return sprintf(buf, "100\n");
  3004	}
  3005	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

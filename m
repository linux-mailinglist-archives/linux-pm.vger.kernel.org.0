Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3035A4010
	for <lists+linux-pm@lfdr.de>; Mon, 29 Aug 2022 00:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbiH1Wgl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 28 Aug 2022 18:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiH1Wgj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 28 Aug 2022 18:36:39 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49DF230F7C;
        Sun, 28 Aug 2022 15:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661726199; x=1693262199;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3YjRnOShrfEs/utJqB20n6tCIlbrtTVNh4e8A4S9ZII=;
  b=YGkES/nYECfXTUs00lW1xpxAsXd0UfJdtwTnxIkP43zHOWc6i3N6W/N3
   tLFYOzmeSANH6W/AM3nkv286UyM0zHSVpoliE2r3o+E0Jj2sSOrqk1yk0
   LnmODYYHQZmk+k1HJB0biK6QuLh4Yrc6PcwgwSj5sZXKiDCCO2L/tr2Np
   qkRpRbaov7kTE0XKh/vz0M1o30LLgbyupj4YUBqaoVkHKheRuPb//FMJn
   PtoH9g4miFjY6IciEBJetBes9dlXKZQV5EQBZbd1DFrqs2VPFCZxVk6dM
   sa1zrTEJMEXtvTjsb9Fz3maND85grXcMQXpOASHylP46PT7xEBxuhVvBz
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10453"; a="292353639"
X-IronPort-AV: E=Sophos;i="5.93,271,1654585200"; 
   d="scan'208";a="292353639"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2022 15:36:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,271,1654585200"; 
   d="scan'208";a="644223397"
Received: from lkp-server01.sh.intel.com (HELO fc16deae1c42) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 28 Aug 2022 15:36:37 -0700
Received: from kbuild by fc16deae1c42 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oSQtQ-0001hF-1O;
        Sun, 28 Aug 2022 22:36:36 +0000
Date:   Mon, 29 Aug 2022 06:36:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arvid Norlander <lkml@vorpal.se>,
        platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Sebastian Reichel <sre@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Azael Avalos <coproscefalo@gmail.com>,
        Arvid Norlander <lkml@vorpal.se>
Subject: Re: [PATCH 2/3] platform/x86: Battery charge mode in toshiba_acpi
 (sysfs)
Message-ID: <202208290628.Er7oPvnk-lkp@intel.com>
References: <20220828192920.805253-3-lkml@vorpal.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220828192920.805253-3-lkml@vorpal.se>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
config: x86_64-randconfig-a002-20220829 (https://download.01.org/0day-ci/archive/20220829/202208290628.Er7oPvnk-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/a85fa4a6b19ae082f6018a07da93db965fb5ba11
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Arvid-Norlander/platform-x86-Battery-charge-mode-in-toshiba_acpi/20220829-033110
        git checkout a85fa4a6b19ae082f6018a07da93db965fb5ba11
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/platform/x86/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/platform/x86/toshiba_acpi.c: In function 'charge_control_end_threshold_show':
>> drivers/platform/x86/toshiba_acpi.c:2992:13: warning: variable 'status' set but not used [-Wunused-but-set-variable]
    2992 |         int status;
         |             ^~~~~~


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

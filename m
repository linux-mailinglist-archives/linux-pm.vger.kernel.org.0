Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8E85533EC
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jun 2022 15:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbiFUNoJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Jun 2022 09:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351315AbiFUNoI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Jun 2022 09:44:08 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 450CC245AE
        for <linux-pm@vger.kernel.org>; Tue, 21 Jun 2022 06:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655819047; x=1687355047;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9dSekwQqCfDA8BJtDMzg9DHmAGTfHg0I7RjcFIpduZY=;
  b=Zldo3K/L7KSRM+jTGQmFyZaAhIrY+g6Cpf6ueHHuAEF70ZqIY6HQuaF0
   OSHeOxCRjU5HQNor5mtYBzv6hz87eP+Pt1Dg7vMkyU7Zps0vRkCZLIfUK
   KLWkD0aF+flFRm9gw2nlDNcCMhalgxiBDePF6zSGyXauo8TSzaO2aCU8P
   VfdcLR18pR6LUeAVoZM86Ta1UQai/RpTnDFbvZxz5LnyjbuyMr6WdeDBg
   hA+CMxHejj/jhWN2CLO/Jlzz7KwvVsmNPrpiOwb5y7nL4xDb0+Q+Qy0Vz
   tjgqs4gNTBpaUsIteT6bOX8uRqMnXUdAwIotZEnmvpwllMoYj+RMbjiYH
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10384"; a="259942011"
X-IronPort-AV: E=Sophos;i="5.92,209,1650956400"; 
   d="scan'208";a="259942011"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 06:44:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,209,1650956400"; 
   d="scan'208";a="591655381"
Received: from lkp-server02.sh.intel.com (HELO 08b4593be841) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 21 Jun 2022 06:44:05 -0700
Received: from kbuild by 08b4593be841 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o3eAm-00002H-Tp;
        Tue, 21 Jun 2022 13:44:04 +0000
Date:   Tue, 21 Jun 2022 21:43:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Liang He <windhl@126.com>, sre@kernel.org, linux-pm@vger.kernel.org
Cc:     kbuild-all@lists.01.org
Subject: Re: [PATCH] power/supply/olpc_battery: Hold the reference returned
 by of_find_compatible_node
Message-ID: <202206212112.5idCYSI1-lkp@intel.com>
References: <20220621072408.4080461-1-windhl@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621072408.4080461-1-windhl@126.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Liang,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on sre-power-supply/for-next]
[also build test WARNING on linus/master v5.19-rc3 next-20220621]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Liang-He/power-supply-olpc_battery-Hold-the-reference-returned-by-of_find_compatible_node/20220621-152751
base:   https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git for-next
config: i386-randconfig-m021 (https://download.01.org/0day-ci/archive/20220621/202206212112.5idCYSI1-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/911b0892099263f0acd11bd5ae75509f9ac677db
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Liang-He/power-supply-olpc_battery-Hold-the-reference-returned-by-of_find_compatible_node/20220621-152751
        git checkout 911b0892099263f0acd11bd5ae75509f9ac677db
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/power/supply/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/power/supply/olpc_battery.c: In function 'olpc_battery_probe':
   drivers/power/supply/olpc_battery.c:653:67: error: expected ';' before 'if'
     653 |         np = of_find_compatible_node(NULL, NULL, "olpc,xo1.75-ec")
         |                                                                   ^
         |                                                                   ;
     654 |         if (np) {
         |         ~~                                                         
>> drivers/power/supply/olpc_battery.c:639:17: warning: unused variable 'status' [-Wunused-variable]
     639 |         uint8_t status;
         |                 ^~~~~~
   drivers/power/supply/olpc_battery.c:638:29: warning: variable 'np' set but not used [-Wunused-but-set-variable]
     638 |         struct device_node *np;
         |                             ^~


vim +/status +639 drivers/power/supply/olpc_battery.c

cae659af87288a drivers/power/olpc_battery.c        Daniel Drake        2011-08-10  632  
c8afa6406e60ae drivers/power/olpc_battery.c        Bill Pemberton      2012-11-19  633  static int olpc_battery_probe(struct platform_device *pdev)
fb972873a76722 drivers/power/olpc_battery.c        David Woodhouse     2007-05-04  634  {
31e220877981d0 drivers/power/supply/olpc_battery.c Lubomir Rintel      2019-04-18  635  	struct power_supply_config bat_psy_cfg = {};
31e220877981d0 drivers/power/supply/olpc_battery.c Lubomir Rintel      2019-04-18  636  	struct power_supply_config ac_psy_cfg = {};
33554d818a9562 drivers/power/supply/olpc_battery.c Lubomir Rintel      2019-04-18  637  	struct olpc_battery_data *data;
911b0892099263 drivers/power/supply/olpc_battery.c Liang He            2022-06-21  638  	struct device_node *np;
fb972873a76722 drivers/power/olpc_battery.c        David Woodhouse     2007-05-04 @639  	uint8_t status;
8ecefda2226203 drivers/power/supply/olpc_battery.c Lubomir Rintel      2019-04-18  640  	uint8_t ecver;
33554d818a9562 drivers/power/supply/olpc_battery.c Lubomir Rintel      2019-04-18  641  	int ret;
33554d818a9562 drivers/power/supply/olpc_battery.c Lubomir Rintel      2019-04-18  642  
33554d818a9562 drivers/power/supply/olpc_battery.c Lubomir Rintel      2019-04-18  643  	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
33554d818a9562 drivers/power/supply/olpc_battery.c Lubomir Rintel      2019-04-18  644  	if (!data)
33554d818a9562 drivers/power/supply/olpc_battery.c Lubomir Rintel      2019-04-18  645  		return -ENOMEM;
33554d818a9562 drivers/power/supply/olpc_battery.c Lubomir Rintel      2019-04-18  646  	platform_set_drvdata(pdev, data);
fb972873a76722 drivers/power/olpc_battery.c        David Woodhouse     2007-05-04  647  
8ecefda2226203 drivers/power/supply/olpc_battery.c Lubomir Rintel      2019-04-18  648  	/* See if the EC is already there and get the EC revision */
8ecefda2226203 drivers/power/supply/olpc_battery.c Lubomir Rintel      2019-04-18  649  	ret = olpc_ec_cmd(EC_FIRMWARE_REV, NULL, 0, &ecver, 1);
8ecefda2226203 drivers/power/supply/olpc_battery.c Lubomir Rintel      2019-04-18  650  	if (ret)
8ecefda2226203 drivers/power/supply/olpc_battery.c Lubomir Rintel      2019-04-18  651  		return ret;
8ecefda2226203 drivers/power/supply/olpc_battery.c Lubomir Rintel      2019-04-18  652  
911b0892099263 drivers/power/supply/olpc_battery.c Liang He            2022-06-21  653  	np = of_find_compatible_node(NULL, NULL, "olpc,xo1.75-ec")
911b0892099263 drivers/power/supply/olpc_battery.c Liang He            2022-06-21  654  	if (np) {
911b0892099263 drivers/power/supply/olpc_battery.c Liang He            2022-06-21  655  		of_node_put(np);
76311b9a329554 drivers/power/supply/olpc_battery.c Lubomir Rintel      2019-04-18  656  		/* XO 1.75 */
76311b9a329554 drivers/power/supply/olpc_battery.c Lubomir Rintel      2019-04-18  657  		data->new_proto = true;
76311b9a329554 drivers/power/supply/olpc_battery.c Lubomir Rintel      2019-04-18  658  		data->little_endian = true;
76311b9a329554 drivers/power/supply/olpc_battery.c Lubomir Rintel      2019-04-18  659  	} else if (ecver > 0x44) {
8ecefda2226203 drivers/power/supply/olpc_battery.c Lubomir Rintel      2019-04-18  660  		/* XO 1 or 1.5 with a new EC firmware. */
8ecefda2226203 drivers/power/supply/olpc_battery.c Lubomir Rintel      2019-04-18  661  		data->new_proto = true;
8ecefda2226203 drivers/power/supply/olpc_battery.c Lubomir Rintel      2019-04-18  662  	} else if (ecver < 0x44) {
484d6d50cca394 drivers/power/olpc_battery.c        Andres Salomon      2008-05-02  663  		/*
8ecefda2226203 drivers/power/supply/olpc_battery.c Lubomir Rintel      2019-04-18  664  		 * We've seen a number of EC protocol changes; this driver
8ecefda2226203 drivers/power/supply/olpc_battery.c Lubomir Rintel      2019-04-18  665  		 * requires the latest EC protocol, supported by 0x44 and above.
484d6d50cca394 drivers/power/olpc_battery.c        Andres Salomon      2008-05-02  666  		 */
484d6d50cca394 drivers/power/olpc_battery.c        Andres Salomon      2008-05-02  667  		printk(KERN_NOTICE "OLPC EC version 0x%02x too old for "
8ecefda2226203 drivers/power/supply/olpc_battery.c Lubomir Rintel      2019-04-18  668  			"battery driver.\n", ecver);
fb972873a76722 drivers/power/olpc_battery.c        David Woodhouse     2007-05-04  669  		return -ENXIO;
fb972873a76722 drivers/power/olpc_battery.c        David Woodhouse     2007-05-04  670  	}
fb972873a76722 drivers/power/olpc_battery.c        David Woodhouse     2007-05-04  671  
fb972873a76722 drivers/power/olpc_battery.c        David Woodhouse     2007-05-04  672  	ret = olpc_ec_cmd(EC_BAT_STATUS, NULL, 0, &status, 1);
fb972873a76722 drivers/power/olpc_battery.c        David Woodhouse     2007-05-04  673  	if (ret)
fb972873a76722 drivers/power/olpc_battery.c        David Woodhouse     2007-05-04  674  		return ret;
fb972873a76722 drivers/power/olpc_battery.c        David Woodhouse     2007-05-04  675  
fb972873a76722 drivers/power/olpc_battery.c        David Woodhouse     2007-05-04  676  	/* Ignore the status. It doesn't actually matter */
fb972873a76722 drivers/power/olpc_battery.c        David Woodhouse     2007-05-04  677  
31e220877981d0 drivers/power/supply/olpc_battery.c Lubomir Rintel      2019-04-18  678  	ac_psy_cfg.of_node = pdev->dev.of_node;
31e220877981d0 drivers/power/supply/olpc_battery.c Lubomir Rintel      2019-04-18  679  	ac_psy_cfg.drv_data = data;
33554d818a9562 drivers/power/supply/olpc_battery.c Lubomir Rintel      2019-04-18  680  
31e220877981d0 drivers/power/supply/olpc_battery.c Lubomir Rintel      2019-04-18  681  	data->olpc_ac = devm_power_supply_register(&pdev->dev, &olpc_ac_desc,
31e220877981d0 drivers/power/supply/olpc_battery.c Lubomir Rintel      2019-04-18  682  								&ac_psy_cfg);
33554d818a9562 drivers/power/supply/olpc_battery.c Lubomir Rintel      2019-04-18  683  	if (IS_ERR(data->olpc_ac))
33554d818a9562 drivers/power/supply/olpc_battery.c Lubomir Rintel      2019-04-18  684  		return PTR_ERR(data->olpc_ac);
33554d818a9562 drivers/power/supply/olpc_battery.c Lubomir Rintel      2019-04-18  685  
f7a228eaf4f8aa drivers/power/supply/olpc_battery.c Lubomir Rintel      2019-04-18  686  	if (of_device_is_compatible(pdev->dev.of_node, "olpc,xo1.5-battery")) {
f7a228eaf4f8aa drivers/power/supply/olpc_battery.c Lubomir Rintel      2019-04-18  687  		/* XO-1.5 */
297d716f6260cc drivers/power/olpc_battery.c        Krzysztof Kozlowski 2015-03-12  688  		olpc_bat_desc.properties = olpc_xo15_bat_props;
297d716f6260cc drivers/power/olpc_battery.c        Krzysztof Kozlowski 2015-03-12  689  		olpc_bat_desc.num_properties = ARRAY_SIZE(olpc_xo15_bat_props);
f7a228eaf4f8aa drivers/power/supply/olpc_battery.c Lubomir Rintel      2019-04-18  690  	} else {
f7a228eaf4f8aa drivers/power/supply/olpc_battery.c Lubomir Rintel      2019-04-18  691  		/* XO-1 */
297d716f6260cc drivers/power/olpc_battery.c        Krzysztof Kozlowski 2015-03-12  692  		olpc_bat_desc.properties = olpc_xo1_bat_props;
297d716f6260cc drivers/power/olpc_battery.c        Krzysztof Kozlowski 2015-03-12  693  		olpc_bat_desc.num_properties = ARRAY_SIZE(olpc_xo1_bat_props);
c566d299f91bdb drivers/power/olpc_battery.c        Daniel Drake        2010-12-29  694  	}
fb972873a76722 drivers/power/olpc_battery.c        David Woodhouse     2007-05-04  695  
31e220877981d0 drivers/power/supply/olpc_battery.c Lubomir Rintel      2019-04-18  696  	bat_psy_cfg.of_node = pdev->dev.of_node;
31e220877981d0 drivers/power/supply/olpc_battery.c Lubomir Rintel      2019-04-18  697  	bat_psy_cfg.drv_data = data;
31e220877981d0 drivers/power/supply/olpc_battery.c Lubomir Rintel      2019-04-18  698  	bat_psy_cfg.attr_grp = olpc_bat_sysfs_groups;
31e220877981d0 drivers/power/supply/olpc_battery.c Lubomir Rintel      2019-04-18  699  
31e220877981d0 drivers/power/supply/olpc_battery.c Lubomir Rintel      2019-04-18  700  	data->olpc_bat = devm_power_supply_register(&pdev->dev, &olpc_bat_desc,
31e220877981d0 drivers/power/supply/olpc_battery.c Lubomir Rintel      2019-04-18  701  								&bat_psy_cfg);
b0280d05804ae8 drivers/power/supply/olpc_battery.c Lubomir Rintel      2019-04-18  702  	if (IS_ERR(data->olpc_bat))
b0280d05804ae8 drivers/power/supply/olpc_battery.c Lubomir Rintel      2019-04-18  703  		return PTR_ERR(data->olpc_bat);
fb972873a76722 drivers/power/olpc_battery.c        David Woodhouse     2007-05-04  704  
cae659af87288a drivers/power/olpc_battery.c        Daniel Drake        2011-08-10  705  	if (olpc_ec_wakeup_available()) {
33554d818a9562 drivers/power/supply/olpc_battery.c Lubomir Rintel      2019-04-18  706  		device_set_wakeup_capable(&data->olpc_ac->dev, true);
33554d818a9562 drivers/power/supply/olpc_battery.c Lubomir Rintel      2019-04-18  707  		device_set_wakeup_capable(&data->olpc_bat->dev, true);
cae659af87288a drivers/power/olpc_battery.c        Daniel Drake        2011-08-10  708  	}
cae659af87288a drivers/power/olpc_battery.c        Daniel Drake        2011-08-10  709  
c3503fd0255824 drivers/power/olpc_battery.c        Daniel Drake        2011-08-10  710  	return 0;
fb972873a76722 drivers/power/olpc_battery.c        David Woodhouse     2007-05-04  711  }
fb972873a76722 drivers/power/olpc_battery.c        David Woodhouse     2007-05-04  712  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

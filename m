Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01CA42CC1DC
	for <lists+linux-pm@lfdr.de>; Wed,  2 Dec 2020 17:16:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbgLBQPv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Dec 2020 11:15:51 -0500
Received: from mga05.intel.com ([192.55.52.43]:15629 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726507AbgLBQPv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 2 Dec 2020 11:15:51 -0500
IronPort-SDR: doPNPjdhNANTLuea34+o1WPTkDeVhUgQ3QImmxbYfyUF6E5TxYTUmGgITswtmiCwt610qnzJeh
 iTqc/LwBGFLQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9823"; a="257752091"
X-IronPort-AV: E=Sophos;i="5.78,387,1599548400"; 
   d="gz'50?scan'50,208,50";a="257752091"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2020 08:14:54 -0800
IronPort-SDR: q5kMkSEaz1gKt5MOyIuPPwbT82M408K7bG+nPz32kgJ5yV0/HlPJ0ogS+VIwuhzq30vZyxTn3F
 uy2XC+eM3Pvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,387,1599548400"; 
   d="gz'50?scan'50,208,50";a="368055302"
Received: from lkp-server01.sh.intel.com (HELO 54133fc185c3) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 02 Dec 2020 08:14:52 -0800
Received: from kbuild by 54133fc185c3 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kkUmJ-0000CY-HD; Wed, 02 Dec 2020 16:14:51 +0000
Date:   Thu, 3 Dec 2020 00:14:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rui.zhang@intel.com
Cc:     kbuild-all@lists.01.org, amitk@kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/4] thermal/core: Rename passive_delay and polling_delay
 with units
Message-ID: <202012030002.dYIZuGJB-lkp@intel.com>
References: <20201202120657.1969-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline
In-Reply-To: <20201202120657.1969-1-daniel.lezcano@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Daniel,

I love your patch! Yet something to improve:

[auto build test ERROR on linux/master]
[also build test ERROR on linus/master v5.10-rc6 next-20201201]
[cannot apply to thermal/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Daniel-Lezcano/thermal-core-Rename-passive_delay-and-polling_delay-with-units/20201202-201150
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 09162bc32c880a791c6c0668ce0745cf7958f576
config: nios2-randconfig-r021-20201202 (attached as .config)
compiler: nios2-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/ade78f158731d79d859533d4370cc2a1294be32e
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Daniel-Lezcano/thermal-core-Rename-passive_delay-and-polling_delay-with-units/20201202-201150
        git checkout ade78f158731d79d859533d4370cc2a1294be32e
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=nios2 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/thermal/thermal_of.c: In function 'thermal_of_build_thermal_zone':
>> drivers/thermal/thermal_of.c:868:6: error: 'struct __thermal_zone' has no member named 'passive_delay_ms'; did you mean 'passive_delay'?
     868 |  tz->passive_delay_ms = prop;
         |      ^~~~~~~~~~~~~~~~
         |      passive_delay
>> drivers/thermal/thermal_of.c:875:6: error: 'struct __thermal_zone' has no member named 'polling_delay_ms'; did you mean 'polling_delay'?
     875 |  tz->polling_delay_ms = prop;
         |      ^~~~~~~~~~~~~~~~
         |      polling_delay
   drivers/thermal/thermal_of.c: In function 'of_parse_thermal_zones':
   drivers/thermal/thermal_of.c:1088:15: error: 'struct __thermal_zone' has no member named 'passive_delay_ms'; did you mean 'passive_delay'?
    1088 |           tz->passive_delay_ms,
         |               ^~~~~~~~~~~~~~~~
         |               passive_delay
   drivers/thermal/thermal_of.c:1089:15: error: 'struct __thermal_zone' has no member named 'polling_delay_ms'; did you mean 'polling_delay'?
    1089 |           tz->polling_delay_ms);
         |               ^~~~~~~~~~~~~~~~
         |               polling_delay
--
   drivers/thermal/da9062-thermal.c: In function 'da9062_thermal_poll_on':
>> drivers/thermal/da9062-thermal.c:98:43: error: 'struct thermal_zone_device' has no member named 'passive_delay'; did you mean 'passive_delay_ms'?
      98 |   delay = msecs_to_jiffies(thermal->zone->passive_delay);
         |                                           ^~~~~~~~~~~~~
         |                                           passive_delay_ms
   In file included from include/linux/printk.h:409,
                    from include/linux/kernel.h:16,
                    from include/linux/interrupt.h:6,
                    from drivers/thermal/da9062-thermal.c:22:
   drivers/thermal/da9062-thermal.c: In function 'da9062_thermal_probe':
   drivers/thermal/da9062-thermal.c:248:18: error: 'struct thermal_zone_device' has no member named 'passive_delay'; did you mean 'passive_delay_ms'?
     248 |   thermal->zone->passive_delay);
         |                  ^~~~~~~~~~~~~
   include/linux/dynamic_debug.h:129:15: note: in definition of macro '__dynamic_func_call'
     129 |   func(&id, ##__VA_ARGS__);  \
         |               ^~~~~~~~~~~
   include/linux/dynamic_debug.h:161:2: note: in expansion of macro '_dynamic_func_call'
     161 |  _dynamic_func_call(fmt,__dynamic_dev_dbg,   \
         |  ^~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:123:2: note: in expansion of macro 'dynamic_dev_dbg'
     123 |  dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |  ^~~~~~~~~~~~~~~
   drivers/thermal/da9062-thermal.c:246:2: note: in expansion of macro 'dev_dbg'
     246 |  dev_dbg(&pdev->dev,
         |  ^~~~~~~

vim +868 drivers/thermal/thermal_of.c

   831	
   832	/**
   833	 * thermal_of_build_thermal_zone - parse and fill one thermal zone data
   834	 * @np: DT node containing a thermal zone node
   835	 *
   836	 * This function parses a thermal zone type of node represented by
   837	 * @np parameter and fills the read data into a __thermal_zone data structure
   838	 * and return this pointer.
   839	 *
   840	 * TODO: Missing properties to parse: thermal-sensor-names
   841	 *
   842	 * Return: On success returns a valid struct __thermal_zone,
   843	 * otherwise, it returns a corresponding ERR_PTR(). Caller must
   844	 * check the return value with help of IS_ERR() helper.
   845	 */
   846	static struct __thermal_zone
   847	__init *thermal_of_build_thermal_zone(struct device_node *np)
   848	{
   849		struct device_node *child = NULL, *gchild;
   850		struct __thermal_zone *tz;
   851		int ret, i;
   852		u32 prop, coef[2];
   853	
   854		if (!np) {
   855			pr_err("no thermal zone np\n");
   856			return ERR_PTR(-EINVAL);
   857		}
   858	
   859		tz = kzalloc(sizeof(*tz), GFP_KERNEL);
   860		if (!tz)
   861			return ERR_PTR(-ENOMEM);
   862	
   863		ret = of_property_read_u32(np, "polling-delay-passive", &prop);
   864		if (ret < 0) {
   865			pr_err("%pOFn: missing polling-delay-passive property\n", np);
   866			goto free_tz;
   867		}
 > 868		tz->passive_delay_ms = prop;
   869	
   870		ret = of_property_read_u32(np, "polling-delay", &prop);
   871		if (ret < 0) {
   872			pr_err("%pOFn: missing polling-delay property\n", np);
   873			goto free_tz;
   874		}
 > 875		tz->polling_delay_ms = prop;
   876	
   877		/*
   878		 * REVIST: for now, the thermal framework supports only
   879		 * one sensor per thermal zone. Thus, we are considering
   880		 * only the first two values as slope and offset.
   881		 */
   882		ret = of_property_read_u32_array(np, "coefficients", coef, 2);
   883		if (ret == 0) {
   884			tz->slope = coef[0];
   885			tz->offset = coef[1];
   886		} else {
   887			tz->slope = 1;
   888			tz->offset = 0;
   889		}
   890	
   891		/* trips */
   892		child = of_get_child_by_name(np, "trips");
   893	
   894		/* No trips provided */
   895		if (!child)
   896			goto finish;
   897	
   898		tz->ntrips = of_get_child_count(child);
   899		if (tz->ntrips == 0) /* must have at least one child */
   900			goto finish;
   901	
   902		tz->trips = kcalloc(tz->ntrips, sizeof(*tz->trips), GFP_KERNEL);
   903		if (!tz->trips) {
   904			ret = -ENOMEM;
   905			goto free_tz;
   906		}
   907	
   908		i = 0;
   909		for_each_child_of_node(child, gchild) {
   910			ret = thermal_of_populate_trip(gchild, &tz->trips[i++]);
   911			if (ret)
   912				goto free_trips;
   913		}
   914	
   915		of_node_put(child);
   916	
   917		/* cooling-maps */
   918		child = of_get_child_by_name(np, "cooling-maps");
   919	
   920		/* cooling-maps not provided */
   921		if (!child)
   922			goto finish;
   923	
   924		tz->num_tbps = of_get_child_count(child);
   925		if (tz->num_tbps == 0)
   926			goto finish;
   927	
   928		tz->tbps = kcalloc(tz->num_tbps, sizeof(*tz->tbps), GFP_KERNEL);
   929		if (!tz->tbps) {
   930			ret = -ENOMEM;
   931			goto free_trips;
   932		}
   933	
   934		i = 0;
   935		for_each_child_of_node(child, gchild) {
   936			ret = thermal_of_populate_bind_params(gchild, &tz->tbps[i++],
   937							      tz->trips, tz->ntrips);
   938			if (ret)
   939				goto free_tbps;
   940		}
   941	
   942	finish:
   943		of_node_put(child);
   944	
   945		return tz;
   946	
   947	free_tbps:
   948		for (i = i - 1; i >= 0; i--) {
   949			struct __thermal_bind_params *tbp = tz->tbps + i;
   950			int j;
   951	
   952			for (j = 0; j < tbp->count; j++)
   953				of_node_put(tbp->tcbp[j].cooling_device);
   954	
   955			kfree(tbp->tcbp);
   956		}
   957	
   958		kfree(tz->tbps);
   959	free_trips:
   960		for (i = 0; i < tz->ntrips; i++)
   961			of_node_put(tz->trips[i].np);
   962		kfree(tz->trips);
   963		of_node_put(gchild);
   964	free_tz:
   965		kfree(tz);
   966		of_node_put(child);
   967	
   968		return ERR_PTR(ret);
   969	}
   970	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--CE+1k2dSO48ffgeK
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
RAVvoSVTUEupuEzk2FtakXO78X/tXcv9h6UBAA==

--CE+1k2dSO48ffgeK--

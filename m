Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 994E854D185
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jun 2022 21:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344979AbiFOTZd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jun 2022 15:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbiFOTZd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jun 2022 15:25:33 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CFE138780;
        Wed, 15 Jun 2022 12:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655321132; x=1686857132;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=905LNegFOW2Um8P9BhrIgjmYf09bgpnjZEvFsBQqfkM=;
  b=gwusj9sZpsIpz+tNBp32Qu3Ncx3DhvzXEFSfLeVDlk+/SALsm4pTlFr3
   /Gf3raRXrxJJu+x4fvg40siFTVDdsMAkZiQLcbPFTa9tnQn3lTugqA3fr
   snb+vMSsCI9xRWd81KcX1Oim0+Barxe5J+gcSlefCGXs7wvWKQSdxE52X
   fxd7NOkssGYoqFi8mZkTXMAUUbWucCPDmunt6N/oOePBsIdz/iamPoeS0
   OTAhy8+SevWZSzELiJJ5qtAjRCoRJ+ysf1sFZrfxM7eApdzng9A61ozmQ
   +29hdFcJ0Ek6563z1sfm0NvHmHAHU3SrsoqXaeXFikL59h7FBR1EgK89w
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10379"; a="262104554"
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="262104554"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 12:25:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="727566773"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 15 Jun 2022 12:25:27 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o1Ydq-000N85-W6;
        Wed, 15 Jun 2022 19:25:26 +0000
Date:   Thu, 16 Jun 2022 03:24:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Anson Huang <Anson.Huang@nxp.com>
Cc:     kbuild-all@lists.01.org,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 2/9] thermal: thermal: Export OF trip helper function
Message-ID: <202206160331.en1dbvYm-lkp@intel.com>
References: <20220615094804.388280-3-francesco.dolcini@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615094804.388280-3-francesco.dolcini@toradex.com>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Francesco,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on robh/for-next]
[also build test ERROR on rafael-pm/thermal krzk/for-next krzk-mem-ctrl/for-next v5.19-rc2 next-20220615]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Francesco-Dolcini/imx-thermal-Allow-trip-point-configuration-from-DT/20220615-175857
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20220616/202206160331.en1dbvYm-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/e68c5a0d2b91a47a9df63a6309c0ed9e905fc20a
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Francesco-Dolcini/imx-thermal-Allow-trip-point-configuration-from-DT/20220615-175857
        git checkout e68c5a0d2b91a47a9df63a6309c0ed9e905fc20a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/thermal/thermal_core.c:27:
   drivers/thermal/thermal_core.h: In function 'thermal_of_populate_trip':
>> drivers/thermal/thermal_core.h:179:17: error: 'ENOTSUP' undeclared (first use in this function); did you mean 'ENOTSUPP'?
     179 |         return -ENOTSUP;
         |                 ^~~~~~~
         |                 ENOTSUPP
   drivers/thermal/thermal_core.h:179:17: note: each undeclared identifier is reported only once for each function it appears in


vim +179 drivers/thermal/thermal_core.h

   150	
   151	/* device tree support */
   152	#ifdef CONFIG_THERMAL_OF
   153	int of_parse_thermal_zones(void);
   154	int of_thermal_get_ntrips(struct thermal_zone_device *);
   155	bool of_thermal_is_trip_valid(struct thermal_zone_device *, int);
   156	const struct thermal_trip *
   157	of_thermal_get_trip_points(struct thermal_zone_device *);
   158	int thermal_of_populate_trip(struct device_node *np,
   159				     struct thermal_trip *trip);
   160	#else
   161	static inline int of_parse_thermal_zones(void) { return 0; }
   162	static inline int of_thermal_get_ntrips(struct thermal_zone_device *tz)
   163	{
   164		return 0;
   165	}
   166	static inline bool of_thermal_is_trip_valid(struct thermal_zone_device *tz,
   167						    int trip)
   168	{
   169		return false;
   170	}
   171	static inline const struct thermal_trip *
   172	of_thermal_get_trip_points(struct thermal_zone_device *tz)
   173	{
   174		return NULL;
   175	}
   176	static inline int thermal_of_populate_trip(struct device_node *np,
   177						   struct thermal_trip *trip)
   178	{
 > 179		return -ENOTSUP;
   180	}
   181	#endif
   182	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

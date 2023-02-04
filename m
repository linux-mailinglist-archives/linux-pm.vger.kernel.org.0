Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4EE68A846
	for <lists+linux-pm@lfdr.de>; Sat,  4 Feb 2023 05:50:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233009AbjBDEuj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Feb 2023 23:50:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbjBDEui (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Feb 2023 23:50:38 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C9B6187F;
        Fri,  3 Feb 2023 20:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675486236; x=1707022236;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eqgGciLsAYrfeY4BTuA+7hyygKm5BHIi0UdbiRPqWrw=;
  b=QelTXUSMJDBJ7XHbdO6+cHv4GcBO+ogb7OZQXBAwq2DCqNKH83s26FoW
   EYe3YhsFcuqFuJgsLezvx0CiPkZx283vS7DqrNU8LMAh22ibtzRfDz7VC
   awdEcUNte0UZeLwluOVAoBR8S8qv04/rgcMH8yG6sG18zjX1+YnkZgfOy
   eMfRfJeusTB3sQqxrECO9faqm9rtCQj8DfRM2wq+1rmsloVYEiIJpbei2
   EPfItpGrSbfI9rART0FEQ4Ij1Y0l2Z0yHJ7cHaJMwMoKkUX3KCVjOPngj
   sjXYaOkhJ/6CpzWadmhcBInv6l+tX3I3exdZ0YJ3tNRQw9ITOl1PMNMdq
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10610"; a="327553180"
X-IronPort-AV: E=Sophos;i="5.97,272,1669104000"; 
   d="scan'208";a="327553180"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2023 20:50:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10610"; a="839822123"
X-IronPort-AV: E=Sophos;i="5.97,272,1669104000"; 
   d="scan'208";a="839822123"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 03 Feb 2023 20:50:32 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pOAVT-00013J-2X;
        Sat, 04 Feb 2023 04:50:31 +0000
Date:   Sat, 4 Feb 2023 12:49:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sascha Hauer <s.hauer@pengutronix.de>, linux-pm@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, kernel@pegutronix.de,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 18/18] dt-bindings: devfreq: event: convert Rockchip DFI
 binding to yaml
Message-ID: <202302041211.DPhrQayE-lkp@intel.com>
References: <20230203125012.3804008-19-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230203125012.3804008-19-s.hauer@pengutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Sascha,

I love your patch! Perhaps something to improve:

[auto build test WARNING on rockchip/for-next]
[also build test WARNING on arm/for-next arm/fixes arm64/for-next/core clk/clk-next kvmarm/next shawnguo/for-next soc/for-next xilinx-xlnx/master linus/master v6.2-rc6 next-20230203]
[cannot apply to chanwoo/devfreq-testing]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sascha-Hauer/PM-devfreq-rockchip-dfi-Embed-desc-into-private-data-struct/20230203-205252
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git for-next
patch link:    https://lore.kernel.org/r/20230203125012.3804008-19-s.hauer%40pengutronix.de
patch subject: [PATCH 18/18] dt-bindings: devfreq: event: convert Rockchip DFI binding to yaml
reproduce:
        # https://github.com/intel-lab-lkp/linux/commit/b6385ff60bdb4b1b2895d87a7f294fde81f10ee9
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Sascha-Hauer/PM-devfreq-rockchip-dfi-Embed-desc-into-private-data-struct/20230203-205252
        git checkout b6385ff60bdb4b1b2895d87a7f294fde81f10ee9
        make menuconfig
        # enable CONFIG_COMPILE_TEST, CONFIG_WARN_MISSING_DOCUMENTS, CONFIG_WARN_ABI_ERRORS
        make htmldocs

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> Warning: Documentation/devicetree/bindings/memory-controllers/rockchip,rk3399-dmc.yaml references a file that doesn't exist: Documentation/devicetree/bindings/devfreq/event/rockchip-dfi.txt

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

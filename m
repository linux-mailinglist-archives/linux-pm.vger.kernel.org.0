Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12FA26B22DE
	for <lists+linux-pm@lfdr.de>; Thu,  9 Mar 2023 12:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbjCIL0q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Mar 2023 06:26:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbjCIL0a (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Mar 2023 06:26:30 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B66E38A6;
        Thu,  9 Mar 2023 03:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678361067; x=1709897067;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=w7OI7hQEHg8ClJhsFM0nUYms3kQOe6dSXnURui+ubBs=;
  b=F1hBIi0d/eDUHoY0pRq5LW1ABlzEuWNolCJouuc8Qg7VuJCuYIg2RUDk
   y5tZh0PbZunV/kHpOW0mSx5i6AQSP5OV2aa5cU5NsDYr8weBxwfi2rPRo
   Plcp1iOMcufSy7vdZt8Ge4VVpHIR+8pbXCKOOj4ORMGE1awThCEGy6ZS+
   u8llRHcJ6+2nZj9TgeVB0Z4q0ekr88JUNQ4Leh41MCmH5Clin6Mmi+htW
   zAYoLXsW6B9prJ1H7kswHp/9FpKnfZhptYp02Wkti8ThnbhUhwpPPpbuj
   84MSb2H9fnDaPtByhOl5EedltG+zh0jt2DWL2BImENis6v2JC/nz9G2Gw
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="320249019"
X-IronPort-AV: E=Sophos;i="5.98,246,1673942400"; 
   d="scan'208";a="320249019"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 03:24:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="820569396"
X-IronPort-AV: E=Sophos;i="5.98,246,1673942400"; 
   d="scan'208";a="820569396"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 09 Mar 2023 03:24:23 -0800
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1paENi-0002uZ-0p;
        Thu, 09 Mar 2023 11:24:22 +0000
Date:   Thu, 9 Mar 2023 19:24:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>
Subject: Re: [PATCH v2 2/6] thermal: qcom: tsens-v0_1: Fix mdm9607 slope
 values
Message-ID: <202303091900.XYo6NJrL-lkp@intel.com>
References: <20230308131041.124482-3-stephan.gerhold@kernkonzept.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230308131041.124482-3-stephan.gerhold@kernkonzept.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Stephan,

I love your patch! Perhaps something to improve:

[auto build test WARNING on rafael-pm/thermal]
[also build test WARNING on linus/master v6.3-rc1 next-20230309]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Stephan-Gerhold/thermal-qcom-tsens-Drop-unused-legacy-structs/20230308-214702
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal
patch link:    https://lore.kernel.org/r/20230308131041.124482-3-stephan.gerhold%40kernkonzept.com
patch subject: [PATCH v2 2/6] thermal: qcom: tsens-v0_1: Fix mdm9607 slope values
config: arm-defconfig (https://download.01.org/0day-ci/archive/20230309/202303091900.XYo6NJrL-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 67409911353323ca5edf2049ef0df54132fa1ca7)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/intel-lab-lkp/linux/commit/3794cf582a2a9b64fabba0c34ec4a1f87571247a
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Stephan-Gerhold/thermal-qcom-tsens-Drop-unused-legacy-structs/20230308-214702
        git checkout 3794cf582a2a9b64fabba0c34ec4a1f87571247a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/thermal/qcom/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303091900.XYo6NJrL-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/thermal/qcom/tsens-v0_1.c:284:31: warning: unused variable 'ops_v0_1' [-Wunused-const-variable]
   static const struct tsens_ops ops_v0_1 = {
                                 ^
   1 warning generated.


vim +/ops_v0_1 +284 drivers/thermal/qcom/tsens-v0_1.c

c19970548edc35 Amit Kucheria    2019-03-20  283  
51d78b8b1beba2 Dmitry Baryshkov 2023-01-01 @284  static const struct tsens_ops ops_v0_1 = {
51d78b8b1beba2 Dmitry Baryshkov 2023-01-01  285  	.init		= init_common,
51d78b8b1beba2 Dmitry Baryshkov 2023-01-01  286  	.calibrate	= tsens_calibrate_common,
51d78b8b1beba2 Dmitry Baryshkov 2023-01-01  287  	.get_temp	= get_temp_common,
51d78b8b1beba2 Dmitry Baryshkov 2023-01-01  288  };
51d78b8b1beba2 Dmitry Baryshkov 2023-01-01  289  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

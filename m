Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70C76481513
	for <lists+linux-pm@lfdr.de>; Wed, 29 Dec 2021 17:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237278AbhL2Q2O (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Dec 2021 11:28:14 -0500
Received: from mga06.intel.com ([134.134.136.31]:40748 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229608AbhL2Q2O (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 29 Dec 2021 11:28:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640795294; x=1672331294;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EYZ4trChjOVZMO8gA3yIhWOsh+UYAlG8vyDOfLAeORk=;
  b=JfIWmYxYKFcih9p8aRdjdiscQ1RtPgnKaGoeO1BSx2AQH7RxtGLqkOEF
   cv/1Yo5BXxkrWF/YxAYgAJmLtUais1fFgSv9qBXpxpk1fExQsR5EwRle3
   I4MiCwWLvW6qgILq6MyzQBsbLi/P+v7e23wdHG4X9jogxXVV1X/XGZnhy
   BbDzio+Q6RxQMArTHGmDp5jm5MQ3OriHlxavacXv2KkJKSerSK20apuDw
   gZhLP/wmgresobeCHFHQq7xDO9nYUcDt7XOyJIWWMn0w/kUlgtzfqaoI1
   zL4wMl8J4NihhSVlNfxSIQjpD9IOIXS9teOhG59+rNKnKF8/2i+hsDRIV
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10211"; a="302291595"
X-IronPort-AV: E=Sophos;i="5.88,245,1635231600"; 
   d="scan'208";a="302291595"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2021 08:28:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,245,1635231600"; 
   d="scan'208";a="619078840"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 29 Dec 2021 08:28:11 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n2boA-0009Ce-DR; Wed, 29 Dec 2021 16:28:10 +0000
Date:   Thu, 30 Dec 2021 00:27:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Li-hao Kuo <lhjeff911@gmail.com>, rafael@kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        robh+dt@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, wells.lu@sunplus.com,
        Li-hao Kuo <lhjeff911@gmail.com>
Subject: Re: [PATCH v2 1/2] THERMAL: Add THERMAL driver for Sunplus SP7021
Message-ID: <202112300008.jdRkNNeV-lkp@intel.com>
References: <a5b37169978e9b82c33718289066287dfd1b9c00.1640235724.git.lhjeff911@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5b37169978e9b82c33718289066287dfd1b9c00.1640235724.git.lhjeff911@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Li-hao,

I love your patch! Perhaps something to improve:

[auto build test WARNING on rafael-pm/thermal]
[also build test WARNING on linus/master v5.16-rc7 next-20211224]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Li-hao-Kuo/Add-THERMAL-control-driver-for-Sunplus-SP7021-SoC/20211223-130720
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20211230/202112300008.jdRkNNeV-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/99e97d44b9115aad59fc953c2945c7cbda1d57bb
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Li-hao-Kuo/Add-THERMAL-control-driver-for-Sunplus-SP7021-SoC/20211223-130720
        git checkout 99e97d44b9115aad59fc953c2945c7cbda1d57bb
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sh SHELL=/bin/bash drivers/thermal/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/thermal/sunplus_thermal.c:44:7: warning: no previous prototype for 'sp7021_otp_coef_read' [-Wmissing-prototypes]
      44 | char *sp7021_otp_coef_read(struct device *dev, ssize_t *len)
         |       ^~~~~~~~~~~~~~~~~~~~


vim +/sp7021_otp_coef_read +44 drivers/thermal/sunplus_thermal.c

    43	
  > 44	char *sp7021_otp_coef_read(struct device *dev, ssize_t *len)
    45	{
    46		char *ret = NULL;
    47		struct nvmem_cell *c = nvmem_cell_get(dev, "therm_calib");
    48	
    49		if (IS_ERR_OR_NULL(c)) {
    50			dev_err(dev, "OTP read failure:%ld", PTR_ERR(c));
    51			return NULL;
    52		}
    53		ret = nvmem_cell_read(c, len);
    54		nvmem_cell_put(c);
    55		dev_dbg(dev, "%d bytes read from OTP", *len);
    56		return ret;
    57	}
    58	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

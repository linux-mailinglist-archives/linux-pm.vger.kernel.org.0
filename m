Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6D3FFFBEC
	for <lists+linux-pm@lfdr.de>; Sun, 17 Nov 2019 23:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbfKQWXJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 17 Nov 2019 17:23:09 -0500
Received: from mga14.intel.com ([192.55.52.115]:26044 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726128AbfKQWXJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 17 Nov 2019 17:23:09 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Nov 2019 14:23:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,317,1569308400"; 
   d="scan'208";a="195947889"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 17 Nov 2019 14:23:07 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iWSwk-0005wk-I1; Mon, 18 Nov 2019 06:23:06 +0800
Date:   Mon, 18 Nov 2019 06:22:55 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Dong Aisheng <aisheng.dong@nxp.com>
Cc:     kbuild-all@lists.01.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, dongas86@gmail.com,
        kernel@pengutronix.de, linux-imx@nxp.com,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/1] firmware: imx: scu-pd: do not power off console
 domain
Message-ID: <201911180631.ArCyBnqH%lkp@intel.com>
References: <1573995924-14752-1-git-send-email-aisheng.dong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573995924-14752-1-git-send-email-aisheng.dong@nxp.com>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Dong,

I love your patch! Perhaps something to improve:

[auto build test WARNING on shawnguo/for-next]
[also build test WARNING on v5.4-rc7 next-20191115]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Dong-Aisheng/firmware-imx-scu-pd-do-not-power-off-console-domain/20191117-211100
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git for-next
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-32-g233d4e1-dirty
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/firmware/imx/scu-pd.c:88:5: sparse: sparse: symbol 'imx_con_rsrc' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation

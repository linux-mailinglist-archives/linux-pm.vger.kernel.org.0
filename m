Return-Path: <linux-pm+bounces-729-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9977C806636
	for <lists+linux-pm@lfdr.de>; Wed,  6 Dec 2023 05:34:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44EF41F20C16
	for <lists+linux-pm@lfdr.de>; Wed,  6 Dec 2023 04:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDCB2F9E6;
	Wed,  6 Dec 2023 04:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y5LOseMX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C8A718D;
	Tue,  5 Dec 2023 20:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701837280; x=1733373280;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=I4YIdo4r6+RuqAhQdmGrQgweel6rL1bH9e4OqtOU62s=;
  b=Y5LOseMX36mZ92AAqzM3VBuq0zqm62cQdPRQk+0m52fOZd2bkpF2hwqh
   6zdVXtdDyxE6l51Qw/75zZTdDpST0+ez+KyNE5v/cWT6jTr1DhKND8Q7d
   mvclXItmuE/R8tkRFuYfavN+5eL1uLpwfIOUqyR7VyJ5HPYZl37O7p490
   EtYDaDoihdtTBKw+GOt3jxJ3z/iMDTyCON0JSxLkCp+rUwgHuyxTzyoWK
   6OUy/oOuxHrwAaAGAd2Hrn3eXq+XjvslkB8f+ssV2VQoszqFuW+7LpQX7
   4+PZiGIP+ylPdKEvYBYWC27jVMjmd9DvrnTyOI+2cfckxRQUzxQEcRkvN
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="379023572"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="379023572"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 20:34:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="944514533"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="944514533"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 05 Dec 2023 20:34:35 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rAjcH-000AGK-1y;
	Wed, 06 Dec 2023 04:34:33 +0000
Date: Wed, 6 Dec 2023 12:34:03 +0800
From: kernel test robot <lkp@intel.com>
To: Biju Das <biju.das.jz@bp.renesas.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Biju Das <biju.das.jz@bp.renesas.com>,
	Support Opensource <support.opensource@diasemi.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 04/11] dt-bindings: thermal: Convert da906{1,2}
 thermal to json-schema
Message-ID: <202312061242.lKDoAY9g-lkp@intel.com>
References: <20231202192536.266885-5-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231202192536.266885-5-biju.das.jz@bp.renesas.com>

Hi Biju,

kernel test robot noticed the following build warnings:

[auto build test WARNING on lee-mfd/for-mfd-next]
[also build test WARNING on robh/for-next rafael-pm/thermal groeck-staging/hwmon-next linus/master v6.7-rc4 next-20231205]
[cannot apply to dtor-input/next dtor-input/for-linus lee-mfd/for-mfd-fixes]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Biju-Das/dt-bindings-watchdog-dlg-da9062-watchdog-Document-DA9063-watchdog/20231203-042557
base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git for-mfd-next
patch link:    https://lore.kernel.org/r/20231202192536.266885-5-biju.das.jz%40bp.renesas.com
patch subject: [PATCH v2 04/11] dt-bindings: thermal: Convert da906{1,2} thermal to json-schema
reproduce: (https://download.01.org/0day-ci/archive/20231206/202312061242.lKDoAY9g-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312061242.lKDoAY9g-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/thermal/da90??-thermal.txt

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


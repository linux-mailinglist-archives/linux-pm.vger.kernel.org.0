Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D44DDE0E1
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2019 00:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbfJTWVN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 20 Oct 2019 18:21:13 -0400
Received: from mga11.intel.com ([192.55.52.93]:56363 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726537AbfJTWVN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 20 Oct 2019 18:21:13 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Oct 2019 15:21:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,320,1566889200"; 
   d="scan'208";a="203188658"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Oct 2019 15:21:11 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iMJZX-0006Md-59; Mon, 21 Oct 2019 06:21:11 +0800
Date:   Mon, 21 Oct 2019 06:20:51 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     kbuild-all@lists.01.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [power-supply:for-next 18/29]
 drivers/power/supply/cpcap-charger.c:481:5: sparse: sparse: symbol
 'cpcap_charger_voltage_to_regval' was not declared. Should it be static?
Message-ID: <201910210600.WlHJI3rO%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git for-next
head:   722f20d707b77bc7e3d241a3600b46b995474087
commit: d4ee021c410f72bf2aacc61069ad6305120d2127 [18/29] power: supply: cpcap-charger: Limit voltage to 4.2V for battery
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-dirty
        git checkout d4ee021c410f72bf2aacc61069ad6305120d2127
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/power/supply/cpcap-charger.c:481:5: sparse: sparse: symbol 'cpcap_charger_voltage_to_regval' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

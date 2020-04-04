Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D65F19E2F8
	for <lists+linux-pm@lfdr.de>; Sat,  4 Apr 2020 07:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725730AbgDDFOh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 4 Apr 2020 01:14:37 -0400
Received: from mga07.intel.com ([134.134.136.100]:20416 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbgDDFOh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 4 Apr 2020 01:14:37 -0400
IronPort-SDR: sNg7+XhwNe7+VMbYDOncI814nOTz8lk4c5mBZ77AYxvD2Lw3W6Lgb5AycpNEUMORaUprk8TT/O
 LJLK1oPTa79A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2020 22:14:36 -0700
IronPort-SDR: WsrgfXpQrVQnchJaZq+bi7mBvZ3kcbN+sfxIuXKBCrgtlsXmYOxUjrr4L5qiwFvTUMqURrunEj
 aBRVQCF/7+cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,342,1580803200"; 
   d="scan'208";a="360723667"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 03 Apr 2020 22:14:34 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jKb8b-000A3Q-Ph; Sat, 04 Apr 2020 13:14:33 +0800
Date:   Sat, 4 Apr 2020 13:14:03 +0800
From:   kbuild test robot <lkp@intel.com>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     kbuild-all@lists.01.org, Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 05/14] power: supply: bq25890: fix ADC mode configuration
Message-ID: <202004041339.5x3xwKVj%lkp@intel.com>
References: <a1275df1b8de5112d81e4f0b57f34af34a4a0942.1585838678.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a1275df1b8de5112d81e4f0b57f34af34a4a0942.1585838678.git.mirq-linux@rere.qmqm.pl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi "Michał,

I love your patch! Perhaps something to improve:

[auto build test WARNING on power-supply/for-next]
[also build test WARNING on linus/master v5.6 next-20200403]
[cannot apply to linux/master]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Micha-Miros-aw/power-supply-bq25890-fix-and-extend/20200404-010738
base:   https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git for-next
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-188-g79f7ac98-dirty
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

   drivers/power/supply/bq25890_charger.c:381:14: sparse: sparse: undefined identifier 'POWER_SUPPLY_PROP_INPUT_VOLTAGE_NOW'
   drivers/power/supply/bq25890_charger.c:382:14: sparse: sparse: undefined identifier 'POWER_SUPPLY_PROP_OUTPUT_VOLTAGE_NOW'
>> drivers/power/supply/bq25890_charger.c:381:14: sparse: sparse: incompatible types for 'case' statement
   drivers/power/supply/bq25890_charger.c:382:14: sparse: sparse: incompatible types for 'case' statement
   drivers/power/supply/bq25890_charger.c:686:23: sparse: sparse: incorrect type in initializer (different modifiers) @@    expected unsigned int enum power_supply_property *properties @@    got unsignunsigned int enum power_supply_property *properties @@
   drivers/power/supply/bq25890_charger.c:686:23: sparse:    expected unsigned int enum power_supply_property *properties
   drivers/power/supply/bq25890_charger.c:686:23: sparse:    got unsigned int enum power_supply_property const *
   drivers/power/supply/bq25890_charger.c:381:14: sparse: sparse: Expected constant expression in case statement
   drivers/power/supply/bq25890_charger.c:382:14: sparse: sparse: Expected constant expression in case statement

vim +/case +381 drivers/power/supply/bq25890_charger.c

   377	
   378	static bool bq25890_is_adc_property(enum power_supply_property psp)
   379	{
   380		switch (psp) {
 > 381		case POWER_SUPPLY_PROP_INPUT_VOLTAGE_NOW:
   382		case POWER_SUPPLY_PROP_OUTPUT_VOLTAGE_NOW:
   383		case POWER_SUPPLY_PROP_VOLTAGE_NOW:
   384		case POWER_SUPPLY_PROP_CURRENT_NOW:
   385			return true;
   386	
   387		default:
   388			return false;
   389		}
   390	}
   391	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

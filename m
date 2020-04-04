Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA31419E28F
	for <lists+linux-pm@lfdr.de>; Sat,  4 Apr 2020 05:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgDDDmd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Apr 2020 23:42:33 -0400
Received: from mga17.intel.com ([192.55.52.151]:34405 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726254AbgDDDmc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 3 Apr 2020 23:42:32 -0400
IronPort-SDR: dtTkQjel8BR1IisXZncZBk7vQiFbfDJZeKBGzVtMeLowmGoJ6DpQdi+GEfOpmGYEGRH7VY8opa
 DVgun0XxuwUg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2020 20:42:32 -0700
IronPort-SDR: eQ4pMiG3vrAyt3GlXMyRLzuUgeo2Qnpn6FIq+amfFYpxNUUXdeBVeK9kyxENP23oia6JtQZT87
 tuufOSX84G6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,342,1580803200"; 
   d="scan'208";a="296159522"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Apr 2020 20:42:31 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jKZhW-0007iz-Az; Sat, 04 Apr 2020 11:42:30 +0800
Date:   Sat, 4 Apr 2020 11:41:35 +0800
From:   kbuild test robot <lkp@intel.com>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     kbuild-all@lists.01.org, Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 03/14] power: supply: bq25890: make property table const
Message-ID: <202004041132.2chDDZzP%lkp@intel.com>
References: <3d647e5c2f69c0cef461ef19004ec40b14e799ca.1585838678.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3d647e5c2f69c0cef461ef19004ec40b14e799ca.1585838678.git.mirq-linux@rere.qmqm.pl>
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

>> drivers/power/supply/bq25890_charger.c:692:23: sparse: sparse: incorrect type in initializer (different modifiers) @@    expected unsigned int enum power_supply_property *properties @@    got unsignunsigned int enum power_supply_property *properties @@
>> drivers/power/supply/bq25890_charger.c:692:23: sparse:    expected unsigned int enum power_supply_property *properties
>> drivers/power/supply/bq25890_charger.c:692:23: sparse:    got unsigned int enum power_supply_property const *

vim +692 drivers/power/supply/bq25890_charger.c

4aeae9cb0dad11 drivers/power/bq25890_charger.c Laurentiu Palcu 2015-05-19  688  
4aeae9cb0dad11 drivers/power/bq25890_charger.c Laurentiu Palcu 2015-05-19  689  static const struct power_supply_desc bq25890_power_supply_desc = {
4aeae9cb0dad11 drivers/power/bq25890_charger.c Laurentiu Palcu 2015-05-19  690  	.name = "bq25890-charger",
4aeae9cb0dad11 drivers/power/bq25890_charger.c Laurentiu Palcu 2015-05-19  691  	.type = POWER_SUPPLY_TYPE_USB,
4aeae9cb0dad11 drivers/power/bq25890_charger.c Laurentiu Palcu 2015-05-19 @692  	.properties = bq25890_power_supply_props,
4aeae9cb0dad11 drivers/power/bq25890_charger.c Laurentiu Palcu 2015-05-19  693  	.num_properties = ARRAY_SIZE(bq25890_power_supply_props),
4aeae9cb0dad11 drivers/power/bq25890_charger.c Laurentiu Palcu 2015-05-19  694  	.get_property = bq25890_power_supply_get_property,
4aeae9cb0dad11 drivers/power/bq25890_charger.c Laurentiu Palcu 2015-05-19  695  };
4aeae9cb0dad11 drivers/power/bq25890_charger.c Laurentiu Palcu 2015-05-19  696  

:::::: The code at line 692 was first introduced by commit
:::::: 4aeae9cb0dad117f055add68c48decaf489aecf3 power_supply: Add support for TI BQ25890 charger chip

:::::: TO: Laurentiu Palcu <laurentiu.palcu@intel.com>
:::::: CC: Sebastian Reichel <sre@kernel.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

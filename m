Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D55C19DEDF
	for <lists+linux-pm@lfdr.de>; Fri,  3 Apr 2020 21:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbgDCTws (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Apr 2020 15:52:48 -0400
Received: from mga12.intel.com ([192.55.52.136]:14670 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727627AbgDCTws (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 3 Apr 2020 15:52:48 -0400
IronPort-SDR: YUti5XVWD6XWeIp+pe4ISIK464RGkkqYpiywJSphpot9eb12p1k678iOhq1cQI4/V8IjhGGWEA
 GbpUdQduMB9w==
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2020 12:52:38 -0700
IronPort-SDR: Jc08KwZEgX1pKrwIuF8pXiwGS6dGD7lyUIfB3ndbsCYiwZ1Uc1hX685bAYmKrULNEEVxV3+Y/p
 sfbsoKLAoveA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,340,1580803200"; 
   d="gz'50?scan'50,208,50";a="238982539"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 03 Apr 2020 12:52:35 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jKSMk-0009A7-CB; Sat, 04 Apr 2020 03:52:34 +0800
Date:   Sat, 4 Apr 2020 03:52:09 +0800
From:   kbuild test robot <lkp@intel.com>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     kbuild-all@lists.01.org, Andrey Smirnov <andrew.smirnov@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/7] power: supply: core: allow to constify property lists
Message-ID: <202004040338.tb2sI7Ug%lkp@intel.com>
References: <edb51336ad361f8dad6d9745e47823da6a94a204.1585837575.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="bg08WKrSYDhXBjb5"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <edb51336ad361f8dad6d9745e47823da6a94a204.1585837575.git.mirq-linux@rere.qmqm.pl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi "Michał,

I love your patch! Yet something to improve:

[auto build test ERROR on power-supply/for-next]
[also build test ERROR on hwmon/hwmon-next linus/master v5.6 next-20200403]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Micha-Miros-aw/power-supply-core-extensions-and-fixes/20200404-004822
base:   https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git for-next
config: sh-allmodconfig (attached as .config)
compiler: sh4-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=9.3.0 make.cross ARCH=sh 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   drivers/power/supply/generic-adc-battery.c: In function 'gab_probe':
   drivers/power/supply/generic-adc-battery.c:280:17: warning: passing argument 1 of 'memcpy' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     280 |  memcpy(psy_desc->properties, gab_props, sizeof(gab_props));
         |         ~~~~~~~~^~~~~~~~~~~~
   In file included from arch/sh/include/asm/string.h:3,
                    from include/linux/string.h:20,
                    from include/linux/bitmap.h:9,
                    from include/linux/cpumask.h:12,
                    from include/linux/interrupt.h:8,
                    from drivers/power/supply/generic-adc-battery.c:12:
   arch/sh/include/asm/string_32.h:119:14: note: expected 'void *' but argument is of type 'const enum power_supply_property *'
     119 | extern void *memcpy(void *__to, __const__ void *__from, size_t __n);
         |              ^~~~~~
>> drivers/power/supply/generic-adc-battery.c:302:35: error: assignment of read-only location '*(psy_desc->properties + (sizetype)((unsigned int)index++ * 4))'
     302 |     psy_desc->properties[index++] =
         |                                   ^
--
   drivers/power/supply/charger-manager.c: In function 'cm_init_thermal_data':
>> drivers/power/supply/charger-manager.c:1436:72: error: assignment of read-only location '*(cm->charger_psy_desc.properties + (sizetype)(cm->charger_psy_desc.num_properties * 4))'
    1436 |   cm->charger_psy_desc.properties[cm->charger_psy_desc.num_properties] =
         |                                                                        ^
   drivers/power/supply/charger-manager.c:1449:72: error: assignment of read-only location '*(cm->charger_psy_desc.properties + (sizetype)(cm->charger_psy_desc.num_properties * 4))'
    1449 |   cm->charger_psy_desc.properties[cm->charger_psy_desc.num_properties] =
         |                                                                        ^
   drivers/power/supply/charger-manager.c: In function 'charger_manager_probe':
>> drivers/power/supply/charger-manager.c:1728:29: warning: passing argument 1 of 'memcpy' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
    1728 |  memcpy(cm->charger_psy_desc.properties, default_charger_props,
         |         ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~
   In file included from arch/sh/include/asm/string.h:3,
                    from include/linux/string.h:20,
                    from include/linux/bitmap.h:9,
                    from include/linux/cpumask.h:12,
                    from include/linux/mm_types_task.h:14,
                    from include/linux/mm_types.h:5,
                    from include/asm-generic/fixmap.h:19,
                    from arch/sh/include/asm/fixmap.h:96,
                    from arch/sh/include/asm/pgtable.h:22,
                    from arch/sh/include/asm/io.h:20,
                    from include/linux/io.h:13,
                    from drivers/power/supply/charger-manager.c:15:
   arch/sh/include/asm/string_32.h:119:14: note: expected 'void *' but argument is of type 'const enum power_supply_property *'
     119 | extern void *memcpy(void *__to, __const__ void *__from, size_t __n);
         |              ^~~~~~
   drivers/power/supply/charger-manager.c:1742:72: error: assignment of read-only location '*(cm->charger_psy_desc.properties + (sizetype)(cm->charger_psy_desc.num_properties * 4))'
    1742 |   cm->charger_psy_desc.properties[cm->charger_psy_desc.num_properties] =
         |                                                                        ^
   drivers/power/supply/charger-manager.c:1749:72: error: assignment of read-only location '*(cm->charger_psy_desc.properties + (sizetype)(cm->charger_psy_desc.num_properties * 4))'
    1749 |   cm->charger_psy_desc.properties[cm->charger_psy_desc.num_properties] =
         |                                                                        ^

vim +302 drivers/power/supply/generic-adc-battery.c

e60fea794e6ecb drivers/power/generic-adc-battery.c        anish kumar          2012-09-21  237  
c8afa6406e60ae drivers/power/generic-adc-battery.c        Bill Pemberton       2012-11-19  238  static int gab_probe(struct platform_device *pdev)
e60fea794e6ecb drivers/power/generic-adc-battery.c        anish kumar          2012-09-21  239  {
e60fea794e6ecb drivers/power/generic-adc-battery.c        anish kumar          2012-09-21  240  	struct gab *adc_bat;
297d716f6260cc drivers/power/generic-adc-battery.c        Krzysztof Kozlowski  2015-03-12  241  	struct power_supply_desc *psy_desc;
297d716f6260cc drivers/power/generic-adc-battery.c        Krzysztof Kozlowski  2015-03-12  242  	struct power_supply_config psy_cfg = {};
e60fea794e6ecb drivers/power/generic-adc-battery.c        anish kumar          2012-09-21  243  	struct gab_platform_data *pdata = pdev->dev.platform_data;
e60fea794e6ecb drivers/power/generic-adc-battery.c        anish kumar          2012-09-21  244  	int ret = 0;
e60fea794e6ecb drivers/power/generic-adc-battery.c        anish kumar          2012-09-21  245  	int chan;
932d47448c3caa drivers/power/supply/generic-adc-battery.c H. Nikolaus Schaller 2018-06-26  246  	int index = ARRAY_SIZE(gab_props);
a427503edaaed9 drivers/power/supply/generic-adc-battery.c H. Nikolaus Schaller 2018-06-26  247  	bool any = false;
e60fea794e6ecb drivers/power/generic-adc-battery.c        anish kumar          2012-09-21  248  
e60fea794e6ecb drivers/power/generic-adc-battery.c        anish kumar          2012-09-21  249  	adc_bat = devm_kzalloc(&pdev->dev, sizeof(*adc_bat), GFP_KERNEL);
e60fea794e6ecb drivers/power/generic-adc-battery.c        anish kumar          2012-09-21  250  	if (!adc_bat) {
e60fea794e6ecb drivers/power/generic-adc-battery.c        anish kumar          2012-09-21  251  		dev_err(&pdev->dev, "failed to allocate memory\n");
e60fea794e6ecb drivers/power/generic-adc-battery.c        anish kumar          2012-09-21  252  		return -ENOMEM;
e60fea794e6ecb drivers/power/generic-adc-battery.c        anish kumar          2012-09-21  253  	}
e60fea794e6ecb drivers/power/generic-adc-battery.c        anish kumar          2012-09-21  254  
297d716f6260cc drivers/power/generic-adc-battery.c        Krzysztof Kozlowski  2015-03-12  255  	psy_cfg.drv_data = adc_bat;
297d716f6260cc drivers/power/generic-adc-battery.c        Krzysztof Kozlowski  2015-03-12  256  	psy_desc = &adc_bat->psy_desc;
297d716f6260cc drivers/power/generic-adc-battery.c        Krzysztof Kozlowski  2015-03-12  257  	psy_desc->name = pdata->battery_info.name;
e60fea794e6ecb drivers/power/generic-adc-battery.c        anish kumar          2012-09-21  258  
e60fea794e6ecb drivers/power/generic-adc-battery.c        anish kumar          2012-09-21  259  	/* bootup default values for the battery */
e60fea794e6ecb drivers/power/generic-adc-battery.c        anish kumar          2012-09-21  260  	adc_bat->cable_plugged = false;
e60fea794e6ecb drivers/power/generic-adc-battery.c        anish kumar          2012-09-21  261  	adc_bat->status = POWER_SUPPLY_STATUS_DISCHARGING;
297d716f6260cc drivers/power/generic-adc-battery.c        Krzysztof Kozlowski  2015-03-12  262  	psy_desc->type = POWER_SUPPLY_TYPE_BATTERY;
297d716f6260cc drivers/power/generic-adc-battery.c        Krzysztof Kozlowski  2015-03-12  263  	psy_desc->get_property = gab_get_property;
297d716f6260cc drivers/power/generic-adc-battery.c        Krzysztof Kozlowski  2015-03-12  264  	psy_desc->external_power_changed = gab_ext_power_changed;
e60fea794e6ecb drivers/power/generic-adc-battery.c        anish kumar          2012-09-21  265  	adc_bat->pdata = pdata;
e60fea794e6ecb drivers/power/generic-adc-battery.c        anish kumar          2012-09-21  266  
e60fea794e6ecb drivers/power/generic-adc-battery.c        anish kumar          2012-09-21  267  	/*
e60fea794e6ecb drivers/power/generic-adc-battery.c        anish kumar          2012-09-21  268  	 * copying the static properties and allocating extra memory for holding
e60fea794e6ecb drivers/power/generic-adc-battery.c        anish kumar          2012-09-21  269  	 * the extra configurable properties received from platform data.
e60fea794e6ecb drivers/power/generic-adc-battery.c        anish kumar          2012-09-21  270  	 */
297d716f6260cc drivers/power/generic-adc-battery.c        Krzysztof Kozlowski  2015-03-12  271  	psy_desc->properties = kcalloc(ARRAY_SIZE(gab_props) +
e60fea794e6ecb drivers/power/generic-adc-battery.c        anish kumar          2012-09-21  272  					ARRAY_SIZE(gab_chan_name),
297d716f6260cc drivers/power/generic-adc-battery.c        Krzysztof Kozlowski  2015-03-12  273  					sizeof(*psy_desc->properties),
297d716f6260cc drivers/power/generic-adc-battery.c        Krzysztof Kozlowski  2015-03-12  274  					GFP_KERNEL);
297d716f6260cc drivers/power/generic-adc-battery.c        Krzysztof Kozlowski  2015-03-12  275  	if (!psy_desc->properties) {
e60fea794e6ecb drivers/power/generic-adc-battery.c        anish kumar          2012-09-21  276  		ret = -ENOMEM;
e60fea794e6ecb drivers/power/generic-adc-battery.c        anish kumar          2012-09-21  277  		goto first_mem_fail;
e60fea794e6ecb drivers/power/generic-adc-battery.c        anish kumar          2012-09-21  278  	}
e60fea794e6ecb drivers/power/generic-adc-battery.c        anish kumar          2012-09-21  279  
297d716f6260cc drivers/power/generic-adc-battery.c        Krzysztof Kozlowski  2015-03-12  280  	memcpy(psy_desc->properties, gab_props, sizeof(gab_props));
e60fea794e6ecb drivers/power/generic-adc-battery.c        anish kumar          2012-09-21  281  
e60fea794e6ecb drivers/power/generic-adc-battery.c        anish kumar          2012-09-21  282  	/*
e60fea794e6ecb drivers/power/generic-adc-battery.c        anish kumar          2012-09-21  283  	 * getting channel from iio and copying the battery properties
e60fea794e6ecb drivers/power/generic-adc-battery.c        anish kumar          2012-09-21  284  	 * based on the channel supported by consumer device.
e60fea794e6ecb drivers/power/generic-adc-battery.c        anish kumar          2012-09-21  285  	 */
e60fea794e6ecb drivers/power/generic-adc-battery.c        anish kumar          2012-09-21  286  	for (chan = 0; chan < ARRAY_SIZE(gab_chan_name); chan++) {
5aa57f0a655276 drivers/power/generic-adc-battery.c        Guenter Roeck        2013-02-04  287  		adc_bat->channel[chan] = iio_channel_get(&pdev->dev,
e60fea794e6ecb drivers/power/generic-adc-battery.c        anish kumar          2012-09-21  288  							 gab_chan_name[chan]);
e60fea794e6ecb drivers/power/generic-adc-battery.c        anish kumar          2012-09-21  289  		if (IS_ERR(adc_bat->channel[chan])) {
e60fea794e6ecb drivers/power/generic-adc-battery.c        anish kumar          2012-09-21  290  			ret = PTR_ERR(adc_bat->channel[chan]);
64d26f225fefe0 drivers/power/generic-adc-battery.c        Dan Carpenter        2013-02-14  291  			adc_bat->channel[chan] = NULL;
e60fea794e6ecb drivers/power/generic-adc-battery.c        anish kumar          2012-09-21  292  		} else {
e60fea794e6ecb drivers/power/generic-adc-battery.c        anish kumar          2012-09-21  293  			/* copying properties for supported channels only */
a427503edaaed9 drivers/power/supply/generic-adc-battery.c H. Nikolaus Schaller 2018-06-26  294  			int index2;
a427503edaaed9 drivers/power/supply/generic-adc-battery.c H. Nikolaus Schaller 2018-06-26  295  
a427503edaaed9 drivers/power/supply/generic-adc-battery.c H. Nikolaus Schaller 2018-06-26  296  			for (index2 = 0; index2 < index; index2++) {
a427503edaaed9 drivers/power/supply/generic-adc-battery.c H. Nikolaus Schaller 2018-06-26  297  				if (psy_desc->properties[index2] ==
a427503edaaed9 drivers/power/supply/generic-adc-battery.c H. Nikolaus Schaller 2018-06-26  298  				    gab_dyn_props[chan])
a427503edaaed9 drivers/power/supply/generic-adc-battery.c H. Nikolaus Schaller 2018-06-26  299  					break;	/* already known */
a427503edaaed9 drivers/power/supply/generic-adc-battery.c H. Nikolaus Schaller 2018-06-26  300  			}
a427503edaaed9 drivers/power/supply/generic-adc-battery.c H. Nikolaus Schaller 2018-06-26  301  			if (index2 == index)	/* really new */
a427503edaaed9 drivers/power/supply/generic-adc-battery.c H. Nikolaus Schaller 2018-06-26 @302  				psy_desc->properties[index++] =
a427503edaaed9 drivers/power/supply/generic-adc-battery.c H. Nikolaus Schaller 2018-06-26  303  					gab_dyn_props[chan];
a427503edaaed9 drivers/power/supply/generic-adc-battery.c H. Nikolaus Schaller 2018-06-26  304  			any = true;
e60fea794e6ecb drivers/power/generic-adc-battery.c        anish kumar          2012-09-21  305  		}
e60fea794e6ecb drivers/power/generic-adc-battery.c        anish kumar          2012-09-21  306  	}
e60fea794e6ecb drivers/power/generic-adc-battery.c        anish kumar          2012-09-21  307  
e60fea794e6ecb drivers/power/generic-adc-battery.c        anish kumar          2012-09-21  308  	/* none of the channels are supported so let's bail out */
a427503edaaed9 drivers/power/supply/generic-adc-battery.c H. Nikolaus Schaller 2018-06-26  309  	if (!any) {
d211c6e82435df drivers/power/generic-adc-battery.c        Axel Lin             2013-05-25  310  		ret = -ENODEV;
e60fea794e6ecb drivers/power/generic-adc-battery.c        anish kumar          2012-09-21  311  		goto second_mem_fail;
d211c6e82435df drivers/power/generic-adc-battery.c        Axel Lin             2013-05-25  312  	}
e60fea794e6ecb drivers/power/generic-adc-battery.c        anish kumar          2012-09-21  313  
e60fea794e6ecb drivers/power/generic-adc-battery.c        anish kumar          2012-09-21  314  	/*
e60fea794e6ecb drivers/power/generic-adc-battery.c        anish kumar          2012-09-21  315  	 * Total number of properties is equal to static properties
e60fea794e6ecb drivers/power/generic-adc-battery.c        anish kumar          2012-09-21  316  	 * plus the dynamic properties.Some properties may not be set
e60fea794e6ecb drivers/power/generic-adc-battery.c        anish kumar          2012-09-21  317  	 * as come channels may be not be supported by the device.So
e60fea794e6ecb drivers/power/generic-adc-battery.c        anish kumar          2012-09-21  318  	 * we need to take care of that.
e60fea794e6ecb drivers/power/generic-adc-battery.c        anish kumar          2012-09-21  319  	 */
932d47448c3caa drivers/power/supply/generic-adc-battery.c H. Nikolaus Schaller 2018-06-26  320  	psy_desc->num_properties = index;
e60fea794e6ecb drivers/power/generic-adc-battery.c        anish kumar          2012-09-21  321  
297d716f6260cc drivers/power/generic-adc-battery.c        Krzysztof Kozlowski  2015-03-12  322  	adc_bat->psy = power_supply_register(&pdev->dev, psy_desc, &psy_cfg);
297d716f6260cc drivers/power/generic-adc-battery.c        Krzysztof Kozlowski  2015-03-12  323  	if (IS_ERR(adc_bat->psy)) {
297d716f6260cc drivers/power/generic-adc-battery.c        Krzysztof Kozlowski  2015-03-12  324  		ret = PTR_ERR(adc_bat->psy);
e60fea794e6ecb drivers/power/generic-adc-battery.c        anish kumar          2012-09-21  325  		goto err_reg_fail;
297d716f6260cc drivers/power/generic-adc-battery.c        Krzysztof Kozlowski  2015-03-12  326  	}
e60fea794e6ecb drivers/power/generic-adc-battery.c        anish kumar          2012-09-21  327  
e60fea794e6ecb drivers/power/generic-adc-battery.c        anish kumar          2012-09-21  328  	INIT_DELAYED_WORK(&adc_bat->bat_work, gab_work);
e60fea794e6ecb drivers/power/generic-adc-battery.c        anish kumar          2012-09-21  329  
e60fea794e6ecb drivers/power/generic-adc-battery.c        anish kumar          2012-09-21  330  	if (gpio_is_valid(pdata->gpio_charge_finished)) {
e60fea794e6ecb drivers/power/generic-adc-battery.c        anish kumar          2012-09-21  331  		int irq;
e60fea794e6ecb drivers/power/generic-adc-battery.c        anish kumar          2012-09-21  332  		ret = gpio_request(pdata->gpio_charge_finished, "charged");
e60fea794e6ecb drivers/power/generic-adc-battery.c        anish kumar          2012-09-21  333  		if (ret)
e60fea794e6ecb drivers/power/generic-adc-battery.c        anish kumar          2012-09-21  334  			goto gpio_req_fail;
e60fea794e6ecb drivers/power/generic-adc-battery.c        anish kumar          2012-09-21  335  
e60fea794e6ecb drivers/power/generic-adc-battery.c        anish kumar          2012-09-21  336  		irq = gpio_to_irq(pdata->gpio_charge_finished);
e60fea794e6ecb drivers/power/generic-adc-battery.c        anish kumar          2012-09-21  337  		ret = request_any_context_irq(irq, gab_charged,
e60fea794e6ecb drivers/power/generic-adc-battery.c        anish kumar          2012-09-21  338  				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
e60fea794e6ecb drivers/power/generic-adc-battery.c        anish kumar          2012-09-21  339  				"battery charged", adc_bat);
a5af092245a339 drivers/power/generic-adc-battery.c        Axel Lin             2012-11-16  340  		if (ret < 0)
e60fea794e6ecb drivers/power/generic-adc-battery.c        anish kumar          2012-09-21  341  			goto err_gpio;
e60fea794e6ecb drivers/power/generic-adc-battery.c        anish kumar          2012-09-21  342  	}
e60fea794e6ecb drivers/power/generic-adc-battery.c        anish kumar          2012-09-21  343  
e60fea794e6ecb drivers/power/generic-adc-battery.c        anish kumar          2012-09-21  344  	platform_set_drvdata(pdev, adc_bat);
e60fea794e6ecb drivers/power/generic-adc-battery.c        anish kumar          2012-09-21  345  
e60fea794e6ecb drivers/power/generic-adc-battery.c        anish kumar          2012-09-21  346  	/* Schedule timer to check current status */
e60fea794e6ecb drivers/power/generic-adc-battery.c        anish kumar          2012-09-21  347  	schedule_delayed_work(&adc_bat->bat_work,
e60fea794e6ecb drivers/power/generic-adc-battery.c        anish kumar          2012-09-21  348  			msecs_to_jiffies(0));
e60fea794e6ecb drivers/power/generic-adc-battery.c        anish kumar          2012-09-21  349  	return 0;
e60fea794e6ecb drivers/power/generic-adc-battery.c        anish kumar          2012-09-21  350  
e60fea794e6ecb drivers/power/generic-adc-battery.c        anish kumar          2012-09-21  351  err_gpio:
e60fea794e6ecb drivers/power/generic-adc-battery.c        anish kumar          2012-09-21  352  	gpio_free(pdata->gpio_charge_finished);
e60fea794e6ecb drivers/power/generic-adc-battery.c        anish kumar          2012-09-21  353  gpio_req_fail:
297d716f6260cc drivers/power/generic-adc-battery.c        Krzysztof Kozlowski  2015-03-12  354  	power_supply_unregister(adc_bat->psy);
e60fea794e6ecb drivers/power/generic-adc-battery.c        anish kumar          2012-09-21  355  err_reg_fail:
64d26f225fefe0 drivers/power/generic-adc-battery.c        Dan Carpenter        2013-02-14  356  	for (chan = 0; chan < ARRAY_SIZE(gab_chan_name); chan++) {
64d26f225fefe0 drivers/power/generic-adc-battery.c        Dan Carpenter        2013-02-14  357  		if (adc_bat->channel[chan])
e60fea794e6ecb drivers/power/generic-adc-battery.c        anish kumar          2012-09-21  358  			iio_channel_release(adc_bat->channel[chan]);
64d26f225fefe0 drivers/power/generic-adc-battery.c        Dan Carpenter        2013-02-14  359  	}
e60fea794e6ecb drivers/power/generic-adc-battery.c        anish kumar          2012-09-21  360  second_mem_fail:
297d716f6260cc drivers/power/generic-adc-battery.c        Krzysztof Kozlowski  2015-03-12  361  	kfree(psy_desc->properties);
e60fea794e6ecb drivers/power/generic-adc-battery.c        anish kumar          2012-09-21  362  first_mem_fail:
e60fea794e6ecb drivers/power/generic-adc-battery.c        anish kumar          2012-09-21  363  	return ret;
e60fea794e6ecb drivers/power/generic-adc-battery.c        anish kumar          2012-09-21  364  }
e60fea794e6ecb drivers/power/generic-adc-battery.c        anish kumar          2012-09-21  365  

:::::: The code at line 302 was first introduced by commit
:::::: a427503edaaed9b75ed9746a654cece7e93e60a8 power: generic-adc-battery: check for duplicate properties copied from iio channels

:::::: TO: H. Nikolaus Schaller <hns@goldelico.com>
:::::: CC: Sebastian Reichel <sre@kernel.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--bg08WKrSYDhXBjb5
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
6mEDAA==

--bg08WKrSYDhXBjb5--

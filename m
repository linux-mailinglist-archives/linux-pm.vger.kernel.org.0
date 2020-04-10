Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0D001A4B54
	for <lists+linux-pm@lfdr.de>; Fri, 10 Apr 2020 22:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbgDJUl5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Apr 2020 16:41:57 -0400
Received: from mga06.intel.com ([134.134.136.31]:5824 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726762AbgDJUl5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 10 Apr 2020 16:41:57 -0400
IronPort-SDR: c9dxKjnD2CMld4lX8KiCFrK38KiUYJVKnvzMdZGy4agktiAJ3sPiXFk9SMeGd7W9WmU0ooahbZ
 2W0T9RX5/zsw==
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2020 13:41:53 -0700
IronPort-SDR: QFYE/6r9Mqfbhh1tL/zAGLmdb2IPISNuSyhVjjOSkludCqrQ3IRlx2uPouLo9LlLN/JmJWVPCg
 Vh2ruNVDUUlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,368,1580803200"; 
   d="gz'50?scan'50,208,50";a="362541755"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 10 Apr 2020 13:41:51 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jN0TG-000ANE-B8; Sat, 11 Apr 2020 04:41:50 +0800
Date:   Sat, 11 Apr 2020 04:41:03 +0800
From:   kbuild test robot <lkp@intel.com>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     kbuild-all@lists.01.org, Andrey Smirnov <andrew.smirnov@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 2/8] power: supply: core: allow to constify property
 lists
Message-ID: <202004110455.UVrX0yu5%lkp@intel.com>
References: <edb51336ad361f8dad6d9745e47823da6a94a204.1585929579.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <edb51336ad361f8dad6d9745e47823da6a94a204.1585929579.git.mirq-linux@rere.qmqm.pl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi "Michał,

I love your patch! Yet something to improve:

[auto build test ERROR on power-supply/for-next]
[also build test ERROR on hwmon/hwmon-next linus/master v5.6 next-20200410]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Micha-Miros-aw/power-supply-core-extensions-and-fixes/20200405-033553
base:   https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git for-next
config: nds32-randconfig-a001-20200410 (attached as .config)
compiler: nds32le-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=9.3.0 make.cross ARCH=nds32 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/power/supply/generic-adc-battery.c: In function 'gab_probe':
   drivers/power/supply/generic-adc-battery.c:280:17: warning: passing argument 1 of 'memcpy' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     280 |  memcpy(psy_desc->properties, gab_props, sizeof(gab_props));
         |         ~~~~~~~~^~~~~~~~~~~~
   In file included from include/linux/string.h:20,
                    from include/linux/bitmap.h:9,
                    from include/linux/cpumask.h:12,
                    from include/linux/interrupt.h:8,
                    from drivers/power/supply/generic-adc-battery.c:12:
   arch/nds32/include/asm/string.h:8:14: note: expected 'void *' but argument is of type 'const enum power_supply_property *'
       8 | extern void *memcpy(void *, const void *, __kernel_size_t);
         |              ^~~~~~
>> drivers/power/supply/generic-adc-battery.c:302:35: error: assignment of read-only location '*(psy_desc->properties + (sizetype)((unsigned int)index++ * 4))'
     302 |     psy_desc->properties[index++] =
         |                                   ^

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

--Nq2Wo0NMKNjxTN9z
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--Nq2Wo0NMKNjxTN9z--

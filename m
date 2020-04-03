Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CFC319DE74
	for <lists+linux-pm@lfdr.de>; Fri,  3 Apr 2020 21:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbgDCTQZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Apr 2020 15:16:25 -0400
Received: from mga04.intel.com ([192.55.52.120]:22240 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728296AbgDCTQZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 3 Apr 2020 15:16:25 -0400
IronPort-SDR: vLxY0uUGZnbTOUdY/aKJPq+GXrcbNj12h9ppd+sXeVwpAp9WHnYu6mV+mrgO4tsvHic8gYqOng
 5CYqQWaWZ6hg==
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2020 12:16:20 -0700
IronPort-SDR: v4p1/yckgnCtjHZwH/EiBBxQLe7YESr0t58dJROvvy6rTYNhOhOMqP3ps4e/lshtGRtNbAP7Gd
 9bkS8g7dIk5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,340,1580803200"; 
   d="gz'50?scan'50,208,50";a="296071568"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Apr 2020 12:16:17 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jKRnd-000Dnl-2U; Sat, 04 Apr 2020 03:16:17 +0800
Date:   Sat, 4 Apr 2020 03:16:02 +0800
From:   kbuild test robot <lkp@intel.com>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     kbuild-all@lists.01.org, Andrey Smirnov <andrew.smirnov@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/7] power: supply: core: allow to constify property lists
Message-ID: <202004040317.DFlq8x22%lkp@intel.com>
References: <edb51336ad361f8dad6d9745e47823da6a94a204.1585837575.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <edb51336ad361f8dad6d9745e47823da6a94a204.1585837575.git.mirq-linux@rere.qmqm.pl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--zhXaljGHf11kAtnf
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
config: s390-randconfig-a001-20200403 (attached as .config)
compiler: s390-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=9.3.0 make.cross ARCH=s390 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   drivers/power/supply/generic-adc-battery.c: In function 'gab_probe':
>> drivers/power/supply/generic-adc-battery.c:280:17: warning: passing argument 1 of 'memcpy' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     280 |  memcpy(psy_desc->properties, gab_props, sizeof(gab_props));
         |         ~~~~~~~~^~~~~~~~~~~~
   In file included from include/linux/bitmap.h:9,
                    from include/linux/cpumask.h:12,
                    from include/linux/interrupt.h:8,
                    from drivers/power/supply/generic-adc-battery.c:12:
   include/linux/string.h:369:37: note: expected 'void *' but argument is of type 'const enum power_supply_property *'
     369 | __FORTIFY_INLINE void *memcpy(void *p, const void *q, __kernel_size_t size)
         |                               ~~~~~~^
>> drivers/power/supply/generic-adc-battery.c:302:35: error: assignment of read-only location '*(psy_desc->properties + (sizetype)((long unsigned int)index++ * 4))'
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
297d716f6260cc drivers/power/generic-adc-battery.c        Krzysztof Kozlowski  2015-03-12 @280  	memcpy(psy_desc->properties, gab_props, sizeof(gab_props));
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

--zhXaljGHf11kAtnf
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--zhXaljGHf11kAtnf--

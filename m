Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCCFE1A4BCC
	for <lists+linux-pm@lfdr.de>; Sat, 11 Apr 2020 00:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgDJWPD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Apr 2020 18:15:03 -0400
Received: from mga12.intel.com ([192.55.52.136]:44262 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726582AbgDJWPD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 10 Apr 2020 18:15:03 -0400
IronPort-SDR: sjEPH4RU9iBrFwhzr8u+2/5lzyR0ROz7vTIWHGTaCjOrGzmOWiFH3Zgxvsc4QriDMTUg4YfyeQ
 wHjXutxwWu9w==
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2020 15:14:52 -0700
IronPort-SDR: 4Vcqt3IsXaokeidSR9kQaS2WyFJIoXtAdZqwYlflaClVmzc4+DHnIl5v+/NUmVjG/LRdXanlmr
 8zdXKt6zHztw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,368,1580803200"; 
   d="gz'50?scan'50,208,50";a="244675381"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 10 Apr 2020 15:14:49 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jN1vF-000AHA-6J; Sat, 11 Apr 2020 06:14:49 +0800
Date:   Sat, 11 Apr 2020 06:14:19 +0800
From:   kbuild test robot <lkp@intel.com>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     kbuild-all@lists.01.org, Andrey Smirnov <andrew.smirnov@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 2/8] power: supply: core: allow to constify property
 lists
Message-ID: <202004110656.PJbDvmP6%lkp@intel.com>
References: <edb51336ad361f8dad6d9745e47823da6a94a204.1585929579.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="AqsLC8rIMeq19msA"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <edb51336ad361f8dad6d9745e47823da6a94a204.1585929579.git.mirq-linux@rere.qmqm.pl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--AqsLC8rIMeq19msA
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
config: x86_64-randconfig-a003-20200410 (attached as .config)
compiler: gcc-4.9 (Ubuntu 4.9.3-13ubuntu2) 4.9.3
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/power/supply/generic-adc-battery.c: In function 'gab_probe':
   drivers/power/supply/generic-adc-battery.c:280:9: warning: passing argument 1 of 'memcpy' discards 'const' qualifier from pointer target type
     memcpy(psy_desc->properties, gab_props, sizeof(gab_props));
            ^
   In file included from arch/x86/include/asm/string.h:5:0,
                    from include/linux/string.h:20,
                    from include/linux/bitmap.h:9,
                    from include/linux/cpumask.h:12,
                    from include/linux/interrupt.h:8,
                    from drivers/power/supply/generic-adc-battery.c:12:
   arch/x86/include/asm/string_64.h:14:14: note: expected 'void *' but argument is of type 'const enum power_supply_property *'
    extern void *memcpy(void *to, const void *from, size_t len);
                 ^
>> drivers/power/supply/generic-adc-battery.c:302:35: error: assignment of read-only location '*(psy_desc->properties + (sizetype)((long unsigned int)index++ * 4ul))'
        psy_desc->properties[index++] =
                                      ^

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

--AqsLC8rIMeq19msA
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
DIzwAQA=

--AqsLC8rIMeq19msA--

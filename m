Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE606353701
	for <lists+linux-pm@lfdr.de>; Sun,  4 Apr 2021 07:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbhDDF5J (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 4 Apr 2021 01:57:09 -0400
Received: from mga05.intel.com ([192.55.52.43]:60798 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229562AbhDDF5I (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 4 Apr 2021 01:57:08 -0400
IronPort-SDR: QALqmUAmGbHZ6Pe5pbpLhxxtxoQl5AWOtbao0taawDlQXFiJtoWtTRrBXC9Rc0JtcK24TbVOuv
 TD6CDQ+pAppw==
X-IronPort-AV: E=McAfee;i="6000,8403,9943"; a="277887559"
X-IronPort-AV: E=Sophos;i="5.81,303,1610438400"; 
   d="gz'50?scan'50,208,50";a="277887559"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2021 22:57:03 -0700
IronPort-SDR: g/h0ZlJ9wlsNCx3dYHwyR61pEhtarnLRGDKH2YgA/W62PmIUW6380aQ6FBN/T95hdCo8cZZfgV
 GX2PBOYudvMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,303,1610438400"; 
   d="gz'50?scan'50,208,50";a="529064044"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 03 Apr 2021 22:56:59 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lSvko-0008CB-Mz; Sun, 04 Apr 2021 05:56:58 +0000
Date:   Sun, 4 Apr 2021 13:56:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     zhuguangqing83@gmail.com, Amit Kucheria <amitk@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guangqing Zhu <zhuguangqing83@gmail.com>
Subject: Re: [PATCH] thermal/drivers/tsens: fix missing put_device error
Message-ID: <202104041357.jFfP7CQQ-lkp@intel.com>
References: <20210404043219.11334-1-zhuguangqing83@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
In-Reply-To: <20210404043219.11334-1-zhuguangqing83@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v5.12-rc5 next-20210401]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/zhuguangqing83-gmail-com/thermal-drivers-tsens-fix-missing-put_device-error/20210404-123439
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 2023a53bdf41b7646b1d384b6816af06309f73a5
config: arm64-randconfig-r004-20210404 (attached as .config)
compiler: aarch64-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/8c940b4ee5ee1d96be026eee71f0c682262f94e4
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review zhuguangqing83-gmail-com/thermal-drivers-tsens-fix-missing-put_device-error/20210404-123439
        git checkout 8c940b4ee5ee1d96be026eee71f0c682262f94e4
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=arm64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   drivers/thermal/qcom/tsens.c: In function 'init_common':
>> drivers/thermal/qcom/tsens.c:856:12: error: invalid storage class for function 'tsens_get_temp'
     856 | static int tsens_get_temp(void *data, int *temp)
         |            ^~~~~~~~~~~~~~
>> drivers/thermal/qcom/tsens.c:856:1: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
     856 | static int tsens_get_temp(void *data, int *temp)
         | ^~~~~~
>> drivers/thermal/qcom/tsens.c:864:12: error: invalid storage class for function 'tsens_get_trend'
     864 | static int tsens_get_trend(void *data, int trip, enum thermal_trend *trend)
         |            ^~~~~~~~~~~~~~~
>> drivers/thermal/qcom/tsens.c:875:28: error: invalid storage class for function 'tsens_suspend'
     875 | static int  __maybe_unused tsens_suspend(struct device *dev)
         |                            ^~~~~~~~~~~~~
>> drivers/thermal/qcom/tsens.c:885:27: error: invalid storage class for function 'tsens_resume'
     885 | static int __maybe_unused tsens_resume(struct device *dev)
         |                           ^~~~~~~~~~~~
   In file included from include/linux/device.h:25,
                    from include/linux/of_platform.h:9,
                    from drivers/thermal/qcom/tsens.c:14:
>> drivers/thermal/qcom/tsens.c:895:40: error: initializer element is not constant
     895 | static SIMPLE_DEV_PM_OPS(tsens_pm_ops, tsens_suspend, tsens_resume);
         |                                        ^~~~~~~~~~~~~
   include/linux/pm.h:306:13: note: in definition of macro 'SET_SYSTEM_SLEEP_PM_OPS'
     306 |  .suspend = suspend_fn, \
         |             ^~~~~~~~~~
   drivers/thermal/qcom/tsens.c:895:8: note: in expansion of macro 'SIMPLE_DEV_PM_OPS'
     895 | static SIMPLE_DEV_PM_OPS(tsens_pm_ops, tsens_suspend, tsens_resume);
         |        ^~~~~~~~~~~~~~~~~
   drivers/thermal/qcom/tsens.c:895:40: note: (near initialization for 'tsens_pm_ops.suspend')
     895 | static SIMPLE_DEV_PM_OPS(tsens_pm_ops, tsens_suspend, tsens_resume);
         |                                        ^~~~~~~~~~~~~
   include/linux/pm.h:306:13: note: in definition of macro 'SET_SYSTEM_SLEEP_PM_OPS'
     306 |  .suspend = suspend_fn, \
         |             ^~~~~~~~~~
   drivers/thermal/qcom/tsens.c:895:8: note: in expansion of macro 'SIMPLE_DEV_PM_OPS'
     895 | static SIMPLE_DEV_PM_OPS(tsens_pm_ops, tsens_suspend, tsens_resume);
         |        ^~~~~~~~~~~~~~~~~
   drivers/thermal/qcom/tsens.c:895:55: error: initializer element is not constant
     895 | static SIMPLE_DEV_PM_OPS(tsens_pm_ops, tsens_suspend, tsens_resume);
         |                                                       ^~~~~~~~~~~~
   include/linux/pm.h:307:12: note: in definition of macro 'SET_SYSTEM_SLEEP_PM_OPS'
     307 |  .resume = resume_fn, \
         |            ^~~~~~~~~
   drivers/thermal/qcom/tsens.c:895:8: note: in expansion of macro 'SIMPLE_DEV_PM_OPS'
     895 | static SIMPLE_DEV_PM_OPS(tsens_pm_ops, tsens_suspend, tsens_resume);
         |        ^~~~~~~~~~~~~~~~~
   drivers/thermal/qcom/tsens.c:895:55: note: (near initialization for 'tsens_pm_ops.resume')
     895 | static SIMPLE_DEV_PM_OPS(tsens_pm_ops, tsens_suspend, tsens_resume);
         |                                                       ^~~~~~~~~~~~
   include/linux/pm.h:307:12: note: in definition of macro 'SET_SYSTEM_SLEEP_PM_OPS'
     307 |  .resume = resume_fn, \
         |            ^~~~~~~~~
   drivers/thermal/qcom/tsens.c:895:8: note: in expansion of macro 'SIMPLE_DEV_PM_OPS'
     895 | static SIMPLE_DEV_PM_OPS(tsens_pm_ops, tsens_suspend, tsens_resume);
         |        ^~~~~~~~~~~~~~~~~
>> drivers/thermal/qcom/tsens.c:895:40: error: initializer element is not constant
     895 | static SIMPLE_DEV_PM_OPS(tsens_pm_ops, tsens_suspend, tsens_resume);
         |                                        ^~~~~~~~~~~~~
   include/linux/pm.h:308:12: note: in definition of macro 'SET_SYSTEM_SLEEP_PM_OPS'
     308 |  .freeze = suspend_fn, \
         |            ^~~~~~~~~~
   drivers/thermal/qcom/tsens.c:895:8: note: in expansion of macro 'SIMPLE_DEV_PM_OPS'
     895 | static SIMPLE_DEV_PM_OPS(tsens_pm_ops, tsens_suspend, tsens_resume);
         |        ^~~~~~~~~~~~~~~~~
   drivers/thermal/qcom/tsens.c:895:40: note: (near initialization for 'tsens_pm_ops.freeze')
     895 | static SIMPLE_DEV_PM_OPS(tsens_pm_ops, tsens_suspend, tsens_resume);
         |                                        ^~~~~~~~~~~~~
   include/linux/pm.h:308:12: note: in definition of macro 'SET_SYSTEM_SLEEP_PM_OPS'
     308 |  .freeze = suspend_fn, \
         |            ^~~~~~~~~~
   drivers/thermal/qcom/tsens.c:895:8: note: in expansion of macro 'SIMPLE_DEV_PM_OPS'
     895 | static SIMPLE_DEV_PM_OPS(tsens_pm_ops, tsens_suspend, tsens_resume);
         |        ^~~~~~~~~~~~~~~~~
   drivers/thermal/qcom/tsens.c:895:55: error: initializer element is not constant
     895 | static SIMPLE_DEV_PM_OPS(tsens_pm_ops, tsens_suspend, tsens_resume);
         |                                                       ^~~~~~~~~~~~
   include/linux/pm.h:309:10: note: in definition of macro 'SET_SYSTEM_SLEEP_PM_OPS'
     309 |  .thaw = resume_fn, \
         |          ^~~~~~~~~
   drivers/thermal/qcom/tsens.c:895:8: note: in expansion of macro 'SIMPLE_DEV_PM_OPS'
     895 | static SIMPLE_DEV_PM_OPS(tsens_pm_ops, tsens_suspend, tsens_resume);
         |        ^~~~~~~~~~~~~~~~~
   drivers/thermal/qcom/tsens.c:895:55: note: (near initialization for 'tsens_pm_ops.thaw')
     895 | static SIMPLE_DEV_PM_OPS(tsens_pm_ops, tsens_suspend, tsens_resume);
         |                                                       ^~~~~~~~~~~~
   include/linux/pm.h:309:10: note: in definition of macro 'SET_SYSTEM_SLEEP_PM_OPS'
     309 |  .thaw = resume_fn, \
         |          ^~~~~~~~~
   drivers/thermal/qcom/tsens.c:895:8: note: in expansion of macro 'SIMPLE_DEV_PM_OPS'
     895 | static SIMPLE_DEV_PM_OPS(tsens_pm_ops, tsens_suspend, tsens_resume);
         |        ^~~~~~~~~~~~~~~~~
>> drivers/thermal/qcom/tsens.c:895:40: error: initializer element is not constant
     895 | static SIMPLE_DEV_PM_OPS(tsens_pm_ops, tsens_suspend, tsens_resume);
         |                                        ^~~~~~~~~~~~~
   include/linux/pm.h:310:14: note: in definition of macro 'SET_SYSTEM_SLEEP_PM_OPS'
     310 |  .poweroff = suspend_fn, \
         |              ^~~~~~~~~~
   drivers/thermal/qcom/tsens.c:895:8: note: in expansion of macro 'SIMPLE_DEV_PM_OPS'
     895 | static SIMPLE_DEV_PM_OPS(tsens_pm_ops, tsens_suspend, tsens_resume);
         |        ^~~~~~~~~~~~~~~~~
   drivers/thermal/qcom/tsens.c:895:40: note: (near initialization for 'tsens_pm_ops.poweroff')
     895 | static SIMPLE_DEV_PM_OPS(tsens_pm_ops, tsens_suspend, tsens_resume);
         |                                        ^~~~~~~~~~~~~
   include/linux/pm.h:310:14: note: in definition of macro 'SET_SYSTEM_SLEEP_PM_OPS'
     310 |  .poweroff = suspend_fn, \
         |              ^~~~~~~~~~
   drivers/thermal/qcom/tsens.c:895:8: note: in expansion of macro 'SIMPLE_DEV_PM_OPS'
     895 | static SIMPLE_DEV_PM_OPS(tsens_pm_ops, tsens_suspend, tsens_resume);
         |        ^~~~~~~~~~~~~~~~~
   drivers/thermal/qcom/tsens.c:895:55: error: initializer element is not constant
     895 | static SIMPLE_DEV_PM_OPS(tsens_pm_ops, tsens_suspend, tsens_resume);
         |                                                       ^~~~~~~~~~~~
   include/linux/pm.h:311:13: note: in definition of macro 'SET_SYSTEM_SLEEP_PM_OPS'
     311 |  .restore = resume_fn,
         |             ^~~~~~~~~
   drivers/thermal/qcom/tsens.c:895:8: note: in expansion of macro 'SIMPLE_DEV_PM_OPS'
     895 | static SIMPLE_DEV_PM_OPS(tsens_pm_ops, tsens_suspend, tsens_resume);
         |        ^~~~~~~~~~~~~~~~~
   drivers/thermal/qcom/tsens.c:895:55: note: (near initialization for 'tsens_pm_ops.restore')
     895 | static SIMPLE_DEV_PM_OPS(tsens_pm_ops, tsens_suspend, tsens_resume);
         |                                                       ^~~~~~~~~~~~
   include/linux/pm.h:311:13: note: in definition of macro 'SET_SYSTEM_SLEEP_PM_OPS'
     311 |  .restore = resume_fn,
         |             ^~~~~~~~~
   drivers/thermal/qcom/tsens.c:895:8: note: in expansion of macro 'SIMPLE_DEV_PM_OPS'
     895 | static SIMPLE_DEV_PM_OPS(tsens_pm_ops, tsens_suspend, tsens_resume);
         |        ^~~~~~~~~~~~~~~~~
   drivers/thermal/qcom/tsens.c:925:14: error: initializer element is not constant
     925 |  .get_temp = tsens_get_temp,
         |              ^~~~~~~~~~~~~~
   drivers/thermal/qcom/tsens.c:925:14: note: (near initialization for 'tsens_of_ops.get_temp')
   drivers/thermal/qcom/tsens.c:926:15: error: initializer element is not constant
     926 |  .get_trend = tsens_get_trend,
         |               ^~~~~~~~~~~~~~~
   drivers/thermal/qcom/tsens.c:926:15: note: (near initialization for 'tsens_of_ops.get_trend')
   drivers/thermal/qcom/tsens.c:924:1: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
     924 | static const struct thermal_zone_of_device_ops tsens_of_ops = {
         | ^~~~~~
>> drivers/thermal/qcom/tsens.c:930:12: error: invalid storage class for function 'tsens_register_irq'
     930 | static int tsens_register_irq(struct tsens_priv *priv, char *irqname,
         |            ^~~~~~~~~~~~~~~~~~
>> drivers/thermal/qcom/tsens.c:962:12: error: invalid storage class for function 'tsens_register'
     962 | static int tsens_register(struct tsens_priv *priv)
         |            ^~~~~~~~~~~~~~
>> drivers/thermal/qcom/tsens.c:990:12: error: invalid storage class for function 'tsens_probe'
     990 | static int tsens_probe(struct platform_device *pdev)
         |            ^~~~~~~~~~~
>> drivers/thermal/qcom/tsens.c:1064:12: error: invalid storage class for function 'tsens_remove'
    1064 | static int tsens_remove(struct platform_device *pdev)
         |            ^~~~~~~~~~~~
   drivers/thermal/qcom/tsens.c:1077:11: error: initializer element is not constant
    1077 |  .probe = tsens_probe,
         |           ^~~~~~~~~~~
   drivers/thermal/qcom/tsens.c:1077:11: note: (near initialization for 'tsens_driver.probe')
   drivers/thermal/qcom/tsens.c:1078:12: error: initializer element is not constant
    1078 |  .remove = tsens_remove,
         |            ^~~~~~~~~~~~
   drivers/thermal/qcom/tsens.c:1078:12: note: (near initialization for 'tsens_driver.remove')
   In file included from include/linux/device.h:32,
                    from include/linux/of_platform.h:9,
                    from drivers/thermal/qcom/tsens.c:14:
>> drivers/thermal/qcom/tsens.c:1085:24: error: invalid storage class for function 'tsens_driver_init'
    1085 | module_platform_driver(tsens_driver);
         |                        ^~~~~~~~~~~~
   include/linux/device/driver.h:259:19: note: in definition of macro 'module_driver'
     259 | static int __init __driver##_init(void) \
         |                   ^~~~~~~~
   drivers/thermal/qcom/tsens.c:1085:1: note: in expansion of macro 'module_platform_driver'
    1085 | module_platform_driver(tsens_driver);
         | ^~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/export.h:43,
                    from include/linux/linkage.h:7,
                    from include/linux/fs.h:5,
                    from include/linux/debugfs.h:15,
                    from drivers/thermal/qcom/tsens.c:7:
>> include/linux/compiler.h:226:46: error: initializer element is not constant
     226 |   __UNIQUE_ID(__PASTE(__addressable_,sym)) = (void *)&sym;
         |                                              ^
   include/linux/init.h:236:2: note: in expansion of macro '__ADDRESSABLE'
     236 |  __ADDRESSABLE(fn)
         |  ^~~~~~~~~~~~~
   include/linux/init.h:241:2: note: in expansion of macro '__define_initcall_stub'
     241 |  __define_initcall_stub(__stub, fn)   \
         |  ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/init.h:253:2: note: in expansion of macro '____define_initcall'
     253 |  ____define_initcall(fn,     \
         |  ^~~~~~~~~~~~~~~~~~~
   include/linux/init.h:259:2: note: in expansion of macro '__unique_initcall'
     259 |  __unique_initcall(fn, id, __sec, __initcall_id(fn))
         |  ^~~~~~~~~~~~~~~~~
   include/linux/init.h:261:35: note: in expansion of macro '___define_initcall'
     261 | #define __define_initcall(fn, id) ___define_initcall(fn, id, .initcall##id)
         |                                   ^~~~~~~~~~~~~~~~~~
   include/linux/init.h:290:30: note: in expansion of macro '__define_initcall'
     290 | #define device_initcall(fn)  __define_initcall(fn, 6)
         |                              ^~~~~~~~~~~~~~~~~
   include/linux/init.h:295:24: note: in expansion of macro 'device_initcall'
     295 | #define __initcall(fn) device_initcall(fn)
         |                        ^~~~~~~~~~~~~~~
   include/linux/module.h:86:24: note: in expansion of macro '__initcall'
      86 | #define module_init(x) __initcall(x);
         |                        ^~~~~~~~~~
   include/linux/device/driver.h:263:1: note: in expansion of macro 'module_init'
     263 | module_init(__driver##_init); \
         | ^~~~~~~~~~~
   include/linux/platform_device.h:257:2: note: in expansion of macro 'module_driver'
     257 |  module_driver(__platform_driver, platform_driver_register, \
         |  ^~~~~~~~~~~~~
   drivers/thermal/qcom/tsens.c:1085:1: note: in expansion of macro 'module_platform_driver'
    1085 | module_platform_driver(tsens_driver);
         | ^~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/device.h:32,
                    from include/linux/of_platform.h:9,
                    from drivers/thermal/qcom/tsens.c:14:
>> drivers/thermal/qcom/tsens.c:1085:24: error: invalid storage class for function 'tsens_driver_exit'
    1085 | module_platform_driver(tsens_driver);
         |                        ^~~~~~~~~~~~
   include/linux/device/driver.h:264:20: note: in definition of macro 'module_driver'
     264 | static void __exit __driver##_exit(void) \
         |                    ^~~~~~~~
   drivers/thermal/qcom/tsens.c:1085:1: note: in expansion of macro 'module_platform_driver'
    1085 | module_platform_driver(tsens_driver);
         | ^~~~~~~~~~~~~~~~~~~~~~
>> include/linux/device/driver.h:264:1: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
     264 | static void __exit __driver##_exit(void) \
         | ^~~~~~
   include/linux/platform_device.h:257:2: note: in expansion of macro 'module_driver'
     257 |  module_driver(__platform_driver, platform_driver_register, \
         |  ^~~~~~~~~~~~~
   drivers/thermal/qcom/tsens.c:1085:1: note: in expansion of macro 'module_platform_driver'
    1085 | module_platform_driver(tsens_driver);
         | ^~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/printk.h:6,
                    from include/linux/kernel.h:16,
                    from include/linux/list.h:9,
                    from include/linux/wait.h:7,
                    from include/linux/wait_bit.h:8,
                    from include/linux/fs.h:6,
                    from include/linux/debugfs.h:15,
                    from drivers/thermal/qcom/tsens.c:7:
   drivers/thermal/qcom/tsens.c:1085:24: error: initializer element is not constant
    1085 | module_platform_driver(tsens_driver);
         |                        ^~~~~~~~~~~~
   include/linux/init.h:298:50: note: in definition of macro '__exitcall'
     298 |  static exitcall_t __exitcall_##fn __exit_call = fn
         |                                                  ^~
   include/linux/device/driver.h:268:1: note: in expansion of macro 'module_exit'
     268 | module_exit(__driver##_exit);
         | ^~~~~~~~~~~
   include/linux/platform_device.h:257:2: note: in expansion of macro 'module_driver'
     257 |  module_driver(__platform_driver, platform_driver_register, \
         |  ^~~~~~~~~~~~~
   drivers/thermal/qcom/tsens.c:1085:1: note: in expansion of macro 'module_platform_driver'
    1085 | module_platform_driver(tsens_driver);
         | ^~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/module.h:21,
                    from drivers/thermal/qcom/tsens.c:10:
>> include/linux/moduleparam.h:24:2: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
      24 |  static const char __UNIQUE_ID(name)[]      \
         |  ^~~~~~
   include/linux/module.h:160:32: note: in expansion of macro '__MODULE_INFO'
     160 | #define MODULE_INFO(tag, info) __MODULE_INFO(tag, tag, info)
         |                                ^~~~~~~~~~~~~
   include/linux/module.h:177:21: note: in expansion of macro 'MODULE_INFO'
     177 | #define MODULE_FILE MODULE_INFO(file, KBUILD_MODFILE);
         |                     ^~~~~~~~~~~
   include/linux/module.h:224:34: note: in expansion of macro 'MODULE_FILE'
     224 | #define MODULE_LICENSE(_license) MODULE_FILE MODULE_INFO(license, _license)
         |                                  ^~~~~~~~~~~
   drivers/thermal/qcom/tsens.c:1087:1: note: in expansion of macro 'MODULE_LICENSE'
    1087 | MODULE_LICENSE("GPL v2");
         | ^~~~~~~~~~~~~~
>> drivers/thermal/qcom/tsens.c:1089:1: error: expected declaration or statement at end of input
    1089 | MODULE_ALIAS("platform:qcom-tsens");
         | ^~~~~~~~~~~~
   drivers/thermal/qcom/tsens.c:1089:1: error: control reaches end of non-void function [-Werror=return-type]
    1089 | MODULE_ALIAS("platform:qcom-tsens");
         | ^~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/tsens_get_temp +856 drivers/thermal/qcom/tsens.c

a7ff82976122eb Amit Kucheria              2020-04-29   855  
9066073c6c2799 Rajendra Nayak             2016-05-05  @856  static int tsens_get_temp(void *data, int *temp)
9066073c6c2799 Rajendra Nayak             2016-05-05   857  {
8b71bce407b3f1 Amit Kucheria              2019-11-01   858  	struct tsens_sensor *s = data;
69b628ac71f07d Amit Kucheria              2019-03-20   859  	struct tsens_priv *priv = s->priv;
9066073c6c2799 Rajendra Nayak             2016-05-05   860  
8b71bce407b3f1 Amit Kucheria              2019-11-01   861  	return priv->ops->get_temp(s, temp);
9066073c6c2799 Rajendra Nayak             2016-05-05   862  }
9066073c6c2799 Rajendra Nayak             2016-05-05   863  
2cbcd2eab01b28 Amit Kucheria              2019-03-20  @864  static int tsens_get_trend(void *data, int trip, enum thermal_trend *trend)
9066073c6c2799 Rajendra Nayak             2016-05-05   865  {
8b71bce407b3f1 Amit Kucheria              2019-11-01   866  	struct tsens_sensor *s = data;
69b628ac71f07d Amit Kucheria              2019-03-20   867  	struct tsens_priv *priv = s->priv;
9066073c6c2799 Rajendra Nayak             2016-05-05   868  
69b628ac71f07d Amit Kucheria              2019-03-20   869  	if (priv->ops->get_trend)
8b71bce407b3f1 Amit Kucheria              2019-11-01   870  		return priv->ops->get_trend(s, trend);
9066073c6c2799 Rajendra Nayak             2016-05-05   871  
9066073c6c2799 Rajendra Nayak             2016-05-05   872  	return -ENOTSUPP;
9066073c6c2799 Rajendra Nayak             2016-05-05   873  }
9066073c6c2799 Rajendra Nayak             2016-05-05   874  
5b97469a55872a Arnd Bergmann              2016-07-04  @875  static int  __maybe_unused tsens_suspend(struct device *dev)
9066073c6c2799 Rajendra Nayak             2016-05-05   876  {
69b628ac71f07d Amit Kucheria              2019-03-20   877  	struct tsens_priv *priv = dev_get_drvdata(dev);
9066073c6c2799 Rajendra Nayak             2016-05-05   878  
69b628ac71f07d Amit Kucheria              2019-03-20   879  	if (priv->ops && priv->ops->suspend)
69b628ac71f07d Amit Kucheria              2019-03-20   880  		return priv->ops->suspend(priv);
9066073c6c2799 Rajendra Nayak             2016-05-05   881  
9066073c6c2799 Rajendra Nayak             2016-05-05   882  	return 0;
9066073c6c2799 Rajendra Nayak             2016-05-05   883  }
9066073c6c2799 Rajendra Nayak             2016-05-05   884  
5b97469a55872a Arnd Bergmann              2016-07-04  @885  static int __maybe_unused tsens_resume(struct device *dev)
9066073c6c2799 Rajendra Nayak             2016-05-05   886  {
69b628ac71f07d Amit Kucheria              2019-03-20   887  	struct tsens_priv *priv = dev_get_drvdata(dev);
9066073c6c2799 Rajendra Nayak             2016-05-05   888  
69b628ac71f07d Amit Kucheria              2019-03-20   889  	if (priv->ops && priv->ops->resume)
69b628ac71f07d Amit Kucheria              2019-03-20   890  		return priv->ops->resume(priv);
9066073c6c2799 Rajendra Nayak             2016-05-05   891  
9066073c6c2799 Rajendra Nayak             2016-05-05   892  	return 0;
9066073c6c2799 Rajendra Nayak             2016-05-05   893  }
9066073c6c2799 Rajendra Nayak             2016-05-05   894  
9066073c6c2799 Rajendra Nayak             2016-05-05  @895  static SIMPLE_DEV_PM_OPS(tsens_pm_ops, tsens_suspend, tsens_resume);
9066073c6c2799 Rajendra Nayak             2016-05-05   896  
9066073c6c2799 Rajendra Nayak             2016-05-05   897  static const struct of_device_id tsens_table[] = {
9066073c6c2799 Rajendra Nayak             2016-05-05   898  	{
9066073c6c2799 Rajendra Nayak             2016-05-05   899  		.compatible = "qcom,msm8916-tsens",
840a5bd3ed3fdd Rajendra Nayak             2016-05-05   900  		.data = &data_8916,
332bc8ebab2c0d Shawn Guo                  2020-06-29   901  	}, {
332bc8ebab2c0d Shawn Guo                  2020-06-29   902  		.compatible = "qcom,msm8939-tsens",
332bc8ebab2c0d Shawn Guo                  2020-06-29   903  		.data = &data_8939,
9066073c6c2799 Rajendra Nayak             2016-05-05   904  	}, {
9066073c6c2799 Rajendra Nayak             2016-05-05   905  		.compatible = "qcom,msm8974-tsens",
5e6703bd2d8354 Rajendra Nayak             2016-05-05   906  		.data = &data_8974,
0e580290170dfb AngeloGioacchino Del Regno 2019-10-05   907  	}, {
0e580290170dfb AngeloGioacchino Del Regno 2019-10-05   908  		.compatible = "qcom,msm8976-tsens",
0e580290170dfb AngeloGioacchino Del Regno 2019-10-05   909  		.data = &data_8976,
d059c739aacfbd Rajendra Nayak             2016-05-05   910  	}, {
d059c739aacfbd Rajendra Nayak             2016-05-05   911  		.compatible = "qcom,msm8996-tsens",
d059c739aacfbd Rajendra Nayak             2016-05-05   912  		.data = &data_8996,
e8c24c6f5d1c7a Amit Kucheria              2019-03-20   913  	}, {
e8c24c6f5d1c7a Amit Kucheria              2019-03-20   914  		.compatible = "qcom,tsens-v1",
e8c24c6f5d1c7a Amit Kucheria              2019-03-20   915  		.data = &data_tsens_v1,
191dc74bad60e1 Amit Kucheria              2018-07-18   916  	}, {
191dc74bad60e1 Amit Kucheria              2018-07-18   917  		.compatible = "qcom,tsens-v2",
191dc74bad60e1 Amit Kucheria              2018-07-18   918  		.data = &data_tsens_v2,
9066073c6c2799 Rajendra Nayak             2016-05-05   919  	},
9066073c6c2799 Rajendra Nayak             2016-05-05   920  	{}
9066073c6c2799 Rajendra Nayak             2016-05-05   921  };
9066073c6c2799 Rajendra Nayak             2016-05-05   922  MODULE_DEVICE_TABLE(of, tsens_table);
9066073c6c2799 Rajendra Nayak             2016-05-05   923  
9066073c6c2799 Rajendra Nayak             2016-05-05  @924  static const struct thermal_zone_of_device_ops tsens_of_ops = {
9066073c6c2799 Rajendra Nayak             2016-05-05  @925  	.get_temp = tsens_get_temp,
9066073c6c2799 Rajendra Nayak             2016-05-05  @926  	.get_trend = tsens_get_trend,
634e11d5b450a9 Amit Kucheria              2019-11-01   927  	.set_trips = tsens_set_trips,
9066073c6c2799 Rajendra Nayak             2016-05-05   928  };
9066073c6c2799 Rajendra Nayak             2016-05-05   929  
79125e03dbfc71 Amit Kucheria              2020-03-12  @930  static int tsens_register_irq(struct tsens_priv *priv, char *irqname,
79125e03dbfc71 Amit Kucheria              2020-03-12   931  			      irq_handler_t thread_fn)
9066073c6c2799 Rajendra Nayak             2016-05-05   932  {
634e11d5b450a9 Amit Kucheria              2019-11-01   933  	struct platform_device *pdev;
79125e03dbfc71 Amit Kucheria              2020-03-12   934  	int ret, irq;
634e11d5b450a9 Amit Kucheria              2019-11-01   935  
634e11d5b450a9 Amit Kucheria              2019-11-01   936  	pdev = of_find_device_by_node(priv->dev->of_node);
634e11d5b450a9 Amit Kucheria              2019-11-01   937  	if (!pdev)
634e11d5b450a9 Amit Kucheria              2019-11-01   938  		return -ENODEV;
634e11d5b450a9 Amit Kucheria              2019-11-01   939  
79125e03dbfc71 Amit Kucheria              2020-03-12   940  	irq = platform_get_irq_byname(pdev, irqname);
634e11d5b450a9 Amit Kucheria              2019-11-01   941  	if (irq < 0) {
634e11d5b450a9 Amit Kucheria              2019-11-01   942  		ret = irq;
344fa0bad69322 Amit Kucheria              2019-12-12   943  		/* For old DTs with no IRQ defined */
344fa0bad69322 Amit Kucheria              2019-12-12   944  		if (irq == -ENXIO)
344fa0bad69322 Amit Kucheria              2019-12-12   945  			ret = 0;
79125e03dbfc71 Amit Kucheria              2020-03-12   946  	} else {
634e11d5b450a9 Amit Kucheria              2019-11-01   947  		ret = devm_request_threaded_irq(&pdev->dev, irq,
79125e03dbfc71 Amit Kucheria              2020-03-12   948  						NULL, thread_fn,
8d3a6d4f433701 Amit Kucheria              2020-03-12   949  						IRQF_ONESHOT,
634e11d5b450a9 Amit Kucheria              2019-11-01   950  						dev_name(&pdev->dev), priv);
79125e03dbfc71 Amit Kucheria              2020-03-12   951  		if (ret)
79125e03dbfc71 Amit Kucheria              2020-03-12   952  			dev_err(&pdev->dev, "%s: failed to get irq\n",
79125e03dbfc71 Amit Kucheria              2020-03-12   953  				__func__);
79125e03dbfc71 Amit Kucheria              2020-03-12   954  		else
634e11d5b450a9 Amit Kucheria              2019-11-01   955  			enable_irq_wake(irq);
79125e03dbfc71 Amit Kucheria              2020-03-12   956  	}
634e11d5b450a9 Amit Kucheria              2019-11-01   957  
634e11d5b450a9 Amit Kucheria              2019-11-01   958  	put_device(&pdev->dev);
634e11d5b450a9 Amit Kucheria              2019-11-01   959  	return ret;
9066073c6c2799 Rajendra Nayak             2016-05-05   960  }
9066073c6c2799 Rajendra Nayak             2016-05-05   961  
79125e03dbfc71 Amit Kucheria              2020-03-12  @962  static int tsens_register(struct tsens_priv *priv)
79125e03dbfc71 Amit Kucheria              2020-03-12   963  {
79125e03dbfc71 Amit Kucheria              2020-03-12   964  	int i, ret;
79125e03dbfc71 Amit Kucheria              2020-03-12   965  	struct thermal_zone_device *tzd;
79125e03dbfc71 Amit Kucheria              2020-03-12   966  
79125e03dbfc71 Amit Kucheria              2020-03-12   967  	for (i = 0;  i < priv->num_sensors; i++) {
79125e03dbfc71 Amit Kucheria              2020-03-12   968  		priv->sensor[i].priv = priv;
79125e03dbfc71 Amit Kucheria              2020-03-12   969  		tzd = devm_thermal_zone_of_sensor_register(priv->dev, priv->sensor[i].hw_id,
79125e03dbfc71 Amit Kucheria              2020-03-12   970  							   &priv->sensor[i],
79125e03dbfc71 Amit Kucheria              2020-03-12   971  							   &tsens_of_ops);
79125e03dbfc71 Amit Kucheria              2020-03-12   972  		if (IS_ERR(tzd))
79125e03dbfc71 Amit Kucheria              2020-03-12   973  			continue;
79125e03dbfc71 Amit Kucheria              2020-03-12   974  		priv->sensor[i].tzd = tzd;
79125e03dbfc71 Amit Kucheria              2020-03-12   975  		if (priv->ops->enable)
79125e03dbfc71 Amit Kucheria              2020-03-12   976  			priv->ops->enable(priv, i);
79125e03dbfc71 Amit Kucheria              2020-03-12   977  	}
79125e03dbfc71 Amit Kucheria              2020-03-12   978  
79125e03dbfc71 Amit Kucheria              2020-03-12   979  	ret = tsens_register_irq(priv, "uplow", tsens_irq_thread);
79125e03dbfc71 Amit Kucheria              2020-03-12   980  	if (ret < 0)
79125e03dbfc71 Amit Kucheria              2020-03-12   981  		return ret;
79125e03dbfc71 Amit Kucheria              2020-03-12   982  
79125e03dbfc71 Amit Kucheria              2020-03-12   983  	if (priv->feat->crit_int)
79125e03dbfc71 Amit Kucheria              2020-03-12   984  		ret = tsens_register_irq(priv, "critical",
79125e03dbfc71 Amit Kucheria              2020-03-12   985  					 tsens_critical_irq_thread);
79125e03dbfc71 Amit Kucheria              2020-03-12   986  
79125e03dbfc71 Amit Kucheria              2020-03-12   987  	return ret;
79125e03dbfc71 Amit Kucheria              2020-03-12   988  }
79125e03dbfc71 Amit Kucheria              2020-03-12   989  
9066073c6c2799 Rajendra Nayak             2016-05-05  @990  static int tsens_probe(struct platform_device *pdev)
9066073c6c2799 Rajendra Nayak             2016-05-05   991  {
9066073c6c2799 Rajendra Nayak             2016-05-05   992  	int ret, i;
9066073c6c2799 Rajendra Nayak             2016-05-05   993  	struct device *dev;
9066073c6c2799 Rajendra Nayak             2016-05-05   994  	struct device_node *np;
69b628ac71f07d Amit Kucheria              2019-03-20   995  	struct tsens_priv *priv;
3c040ce087a2e8 Amit Kucheria              2019-03-20   996  	const struct tsens_plat_data *data;
9066073c6c2799 Rajendra Nayak             2016-05-05   997  	const struct of_device_id *id;
6d7c70d1cd6526 Bjorn Andersson            2018-05-07   998  	u32 num_sensors;
9066073c6c2799 Rajendra Nayak             2016-05-05   999  
9066073c6c2799 Rajendra Nayak             2016-05-05  1000  	if (pdev->dev.of_node)
9066073c6c2799 Rajendra Nayak             2016-05-05  1001  		dev = &pdev->dev;
9066073c6c2799 Rajendra Nayak             2016-05-05  1002  	else
9066073c6c2799 Rajendra Nayak             2016-05-05  1003  		dev = pdev->dev.parent;
9066073c6c2799 Rajendra Nayak             2016-05-05  1004  
9066073c6c2799 Rajendra Nayak             2016-05-05  1005  	np = dev->of_node;
9066073c6c2799 Rajendra Nayak             2016-05-05  1006  
9066073c6c2799 Rajendra Nayak             2016-05-05  1007  	id = of_match_node(tsens_table, np);
20d4fd84bf524a Rajendra Nayak             2016-05-05  1008  	if (id)
9066073c6c2799 Rajendra Nayak             2016-05-05  1009  		data = id->data;
20d4fd84bf524a Rajendra Nayak             2016-05-05  1010  	else
20d4fd84bf524a Rajendra Nayak             2016-05-05  1011  		data = &data_8960;
9066073c6c2799 Rajendra Nayak             2016-05-05  1012  
6d7c70d1cd6526 Bjorn Andersson            2018-05-07  1013  	num_sensors = data->num_sensors;
6d7c70d1cd6526 Bjorn Andersson            2018-05-07  1014  
6d7c70d1cd6526 Bjorn Andersson            2018-05-07  1015  	if (np)
6d7c70d1cd6526 Bjorn Andersson            2018-05-07  1016  		of_property_read_u32(np, "#qcom,sensors", &num_sensors);
6d7c70d1cd6526 Bjorn Andersson            2018-05-07  1017  
6d7c70d1cd6526 Bjorn Andersson            2018-05-07  1018  	if (num_sensors <= 0) {
3795ad5e266908 Amit Kucheria              2019-11-01  1019  		dev_err(dev, "%s: invalid number of sensors\n", __func__);
9066073c6c2799 Rajendra Nayak             2016-05-05  1020  		return -EINVAL;
9066073c6c2799 Rajendra Nayak             2016-05-05  1021  	}
9066073c6c2799 Rajendra Nayak             2016-05-05  1022  
69b628ac71f07d Amit Kucheria              2019-03-20  1023  	priv = devm_kzalloc(dev,
69b628ac71f07d Amit Kucheria              2019-03-20  1024  			     struct_size(priv, sensor, num_sensors),
0ed2dd03b94b7b Kees Cook                  2018-05-08  1025  			     GFP_KERNEL);
69b628ac71f07d Amit Kucheria              2019-03-20  1026  	if (!priv)
9066073c6c2799 Rajendra Nayak             2016-05-05  1027  		return -ENOMEM;
9066073c6c2799 Rajendra Nayak             2016-05-05  1028  
69b628ac71f07d Amit Kucheria              2019-03-20  1029  	priv->dev = dev;
69b628ac71f07d Amit Kucheria              2019-03-20  1030  	priv->num_sensors = num_sensors;
69b628ac71f07d Amit Kucheria              2019-03-20  1031  	priv->ops = data->ops;
69b628ac71f07d Amit Kucheria              2019-03-20  1032  	for (i = 0;  i < priv->num_sensors; i++) {
9066073c6c2799 Rajendra Nayak             2016-05-05  1033  		if (data->hw_ids)
69b628ac71f07d Amit Kucheria              2019-03-20  1034  			priv->sensor[i].hw_id = data->hw_ids[i];
9066073c6c2799 Rajendra Nayak             2016-05-05  1035  		else
69b628ac71f07d Amit Kucheria              2019-03-20  1036  			priv->sensor[i].hw_id = i;
9066073c6c2799 Rajendra Nayak             2016-05-05  1037  	}
c19970548edc35 Amit Kucheria              2019-03-20  1038  	priv->feat = data->feat;
c19970548edc35 Amit Kucheria              2019-03-20  1039  	priv->fields = data->fields;
9066073c6c2799 Rajendra Nayak             2016-05-05  1040  
0e9c0bc7308240 Amit Kucheria              2019-11-01  1041  	platform_set_drvdata(pdev, priv);
0e9c0bc7308240 Amit Kucheria              2019-11-01  1042  
69b628ac71f07d Amit Kucheria              2019-03-20  1043  	if (!priv->ops || !priv->ops->init || !priv->ops->get_temp)
9066073c6c2799 Rajendra Nayak             2016-05-05  1044  		return -EINVAL;
9066073c6c2799 Rajendra Nayak             2016-05-05  1045  
69b628ac71f07d Amit Kucheria              2019-03-20  1046  	ret = priv->ops->init(priv);
9066073c6c2799 Rajendra Nayak             2016-05-05  1047  	if (ret < 0) {
3795ad5e266908 Amit Kucheria              2019-11-01  1048  		dev_err(dev, "%s: init failed\n", __func__);
9066073c6c2799 Rajendra Nayak             2016-05-05  1049  		return ret;
9066073c6c2799 Rajendra Nayak             2016-05-05  1050  	}
9066073c6c2799 Rajendra Nayak             2016-05-05  1051  
69b628ac71f07d Amit Kucheria              2019-03-20  1052  	if (priv->ops->calibrate) {
69b628ac71f07d Amit Kucheria              2019-03-20  1053  		ret = priv->ops->calibrate(priv);
9066073c6c2799 Rajendra Nayak             2016-05-05  1054  		if (ret < 0) {
fc7d18cf6a923c Amit Kucheria              2019-03-20  1055  			if (ret != -EPROBE_DEFER)
3795ad5e266908 Amit Kucheria              2019-11-01  1056  				dev_err(dev, "%s: calibration failed\n", __func__);
9066073c6c2799 Rajendra Nayak             2016-05-05  1057  			return ret;
9066073c6c2799 Rajendra Nayak             2016-05-05  1058  		}
9066073c6c2799 Rajendra Nayak             2016-05-05  1059  	}
9066073c6c2799 Rajendra Nayak             2016-05-05  1060  
0e9c0bc7308240 Amit Kucheria              2019-11-01  1061  	return tsens_register(priv);
9066073c6c2799 Rajendra Nayak             2016-05-05  1062  }
9066073c6c2799 Rajendra Nayak             2016-05-05  1063  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--ikeVEW9yuYc//A+q
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
bQIA

--ikeVEW9yuYc//A+q--

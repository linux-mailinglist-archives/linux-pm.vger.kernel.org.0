Return-Path: <linux-pm+bounces-11635-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B6A94090E
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 09:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 609C41F24179
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 07:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580B181723;
	Tue, 30 Jul 2024 07:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I5SZ0Dea"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C92F374C3
	for <linux-pm@vger.kernel.org>; Tue, 30 Jul 2024 07:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722323250; cv=none; b=s6YyMf3Jndx9KI8tkjJdQw+oiiXmhA53k9JYCaJabqNz7yWrps6K5vwmNocwAxOEAmI/EgMGiP/mDXr9vyqgiNtdENxB3q6EVZQQrSvoqFqXDiIE7NNNVkIt0oXZ4YbWpIxDnZ3S4Sr+AMN/bub5GK3KE+WURxk84ql3hnE2PXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722323250; c=relaxed/simple;
	bh=gwmTSGvOxo+bGvT7/nYBCha+FFmwP2BNbHvCdza6hPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BK3knbAngf8DkP4+rFE66XJ9Hs0Uh7Ii2VGXl8WZvHqOgqEG/u6ZTChKqHWZOKV+gOvG/mNUr8iLFGj8wDvauAq6+xtwhNH1qoxUU1fjEjauu8XIGCvt7dYcuylj0WI5tXU9MqUlyYbJJulKeJht19Yb/q4Qgwup4/NnwOWFjy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I5SZ0Dea; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722323248; x=1753859248;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gwmTSGvOxo+bGvT7/nYBCha+FFmwP2BNbHvCdza6hPQ=;
  b=I5SZ0DeaaxCZkD6OXUfu/i7tY9wv1BgQ4T5yAjZuqNG2t3VlRLZtONym
   HUo4lXLix3o5b8D3KjyJqr9m9zC2UR0lvf+3l67i3yW26VAsR71mi0nUy
   kRiqeLuYMkpG2WQiHGyaInVfYAh53flwpWK91SdMsI1nGUfpUabJ8R/C7
   h9UUMco5Xf6CaCLtr+GWNMZ2ET/ceq7oGHEBqJCPLoth7KRRSCzmS5ELD
   6Mjlw5/T5ZjXYWXgrtDBVnw0itFXvHOBO1q4GENReKO41HaB0evbjN51O
   lmtoLUkZSZxfZ7HRWDmPYA/aIHS8OwlOLrVFl7NIhjzgKwUhr031SBblq
   w==;
X-CSE-ConnectionGUID: gLx11rwhTNasaRK7cFQisA==
X-CSE-MsgGUID: 2aWCNDzJQNKiZXqg6JzBQg==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="30705865"
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="30705865"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2024 00:07:28 -0700
X-CSE-ConnectionGUID: DBmIUztCQgyB10UQJmjrTw==
X-CSE-MsgGUID: c/8qpMKQSTCkM+4V8V8jkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="54483710"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 30 Jul 2024 00:07:26 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sYgx9-000sao-2L;
	Tue, 30 Jul 2024 07:07:23 +0000
Date: Tue, 30 Jul 2024 15:06:45 +0800
From: kernel test robot <lkp@intel.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>, rafael@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-pm@vger.kernel.org,
	lukasz.luba@arm.com, quic_manafm@quicinc.com
Subject: Re: [PATCH v1 2/7] thermal/core: Add thresholds support
Message-ID: <202407301457.cOikpFah-lkp@intel.com>
References: <20240729150259.1089814-3-daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729150259.1089814-3-daniel.lezcano@linaro.org>

Hi Daniel,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/thermal]
[also build test WARNING on linus/master v6.11-rc1 next-20240729]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Lezcano/thermal-core-Encapsulate-more-handle_thermal_trip/20240730-005842
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal
patch link:    https://lore.kernel.org/r/20240729150259.1089814-3-daniel.lezcano%40linaro.org
patch subject: [PATCH v1 2/7] thermal/core: Add thresholds support
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20240730/202407301457.cOikpFah-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240730/202407301457.cOikpFah-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407301457.cOikpFah-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/thermal/thermal_thresholds.c: In function 'thermal_thresholds_init':
   drivers/thermal/thermal_thresholds.c:22:22: error: implicit declaration of function 'kmalloc'; did you mean 'mm_alloc'? [-Werror=implicit-function-declaration]
      22 |         thresholds = kmalloc(sizeof(*thresholds), GFP_KERNEL);
         |                      ^~~~~~~
         |                      mm_alloc
>> drivers/thermal/thermal_thresholds.c:22:20: warning: assignment to 'struct thresholds *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
      22 |         thresholds = kmalloc(sizeof(*thresholds), GFP_KERNEL);
         |                    ^
   drivers/thermal/thermal_thresholds.c: In function 'thermal_thresholds_exit':
   drivers/thermal/thermal_thresholds.c:35:9: error: implicit declaration of function 'kfree' [-Werror=implicit-function-declaration]
      35 |         kfree(tz->thresholds);
         |         ^~~~~
   drivers/thermal/thermal_thresholds.c: In function 'thermal_thresholds_add':
>> drivers/thermal/thermal_thresholds.c:185:19: warning: assignment to 'struct threshold *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     185 |                 t = kmalloc(sizeof(*t), GFP_KERNEL);
         |                   ^
   cc1: some warnings being treated as errors


vim +22 drivers/thermal/thermal_thresholds.c

    17	
    18	int thermal_thresholds_init(struct thermal_zone_device *tz)
    19	{
    20		struct thresholds *thresholds;
    21	
  > 22		thresholds = kmalloc(sizeof(*thresholds), GFP_KERNEL);
    23		if (!thresholds)
    24			return -ENOMEM;
    25	
    26		INIT_LIST_HEAD(&thresholds->list);
    27		tz->thresholds = thresholds;
    28	
    29		return 0;
    30	}
    31	
    32	void thermal_thresholds_exit(struct thermal_zone_device *tz)
    33	{
    34		thermal_thresholds_flush(tz);
    35		kfree(tz->thresholds);
    36		tz->thresholds = NULL;
    37	}
    38	
    39	static int __thermal_thresholds_cmp(void *data,
    40					    const struct list_head *l1,
    41					    const struct list_head *l2)
    42	{
    43		struct threshold *t1 = container_of(l1, struct threshold, list);
    44		struct threshold *t2 = container_of(l2, struct threshold, list);
    45	
    46		return t1->temperature - t2->temperature;
    47	}
    48	
    49	static struct threshold *__thermal_thresholds_find(const struct thresholds *thresholds, int temperature)
    50	{
    51		struct threshold *t;
    52	
    53		list_for_each_entry(t, &thresholds->list, list)
    54			if (t->temperature == temperature)
    55				return t;
    56	
    57		return NULL;
    58	}
    59	
    60	static bool __thermal_threshold_is_crossed(struct threshold *threshold, int temperature,
    61						   int last_temperature, int direction,
    62						   int *low, int *high)
    63	{
    64		if (temperature > threshold->temperature && threshold->temperature > *low &&
    65		    (THERMAL_THRESHOLD_WAY_DOWN & threshold->direction))
    66			*low = threshold->temperature;
    67	
    68		if (temperature < threshold->temperature && threshold->temperature < *high &&
    69		    (THERMAL_THRESHOLD_WAY_UP & threshold->direction))
    70			*high = threshold->temperature;
    71	
    72		if (temperature < threshold->temperature &&
    73		    last_temperature >= threshold->temperature &&
    74		    (threshold->direction & direction))
    75			return true;
    76	
    77		if (temperature >= threshold->temperature &&
    78		    last_temperature < threshold->temperature &&
    79		    (threshold->direction & direction))
    80			return true;
    81	
    82		return false;
    83	}
    84	
    85	static bool thermal_thresholds_handle_raising(struct thresholds *thresholds, int temperature,
    86						      int last_temperature, int *low, int *high)
    87	{
    88		struct threshold *t;
    89	
    90		list_for_each_entry(t, &thresholds->list, list) {
    91			if (__thermal_threshold_is_crossed(t, temperature, last_temperature,
    92							   THERMAL_THRESHOLD_WAY_UP, low, high))
    93				return true;
    94		}
    95	
    96		return false;
    97	}
    98	
    99	static bool thermal_thresholds_handle_dropping(struct thresholds *thresholds, int temperature,
   100						       int last_temperature, int *low, int *high)
   101	{
   102		struct threshold *t;
   103	
   104		list_for_each_entry_reverse(t, &thresholds->list, list) {
   105			if (__thermal_threshold_is_crossed(t, temperature, last_temperature,
   106							   THERMAL_THRESHOLD_WAY_DOWN, low, high))
   107				return true;
   108		}
   109	
   110		return false;
   111	}
   112	
   113	void thermal_thresholds_flush(struct thermal_zone_device *tz)
   114	{
   115		struct thresholds *thresholds = tz->thresholds;
   116		struct threshold *entry, *tmp;
   117	
   118		lockdep_assert_held(&tz->lock);
   119	
   120		list_for_each_entry_safe(entry, tmp, &thresholds->list, list) {
   121			list_del(&entry->list);
   122			kfree(entry);
   123		}
   124	
   125		__thermal_zone_device_update(tz, THERMAL_THRESHOLD_FLUSHED);
   126	}
   127	
   128	int thermal_thresholds_handle(struct thermal_zone_device *tz, int *low, int *high)
   129	{
   130		struct thresholds *thresholds = tz->thresholds;
   131	
   132		int temperature = tz->temperature;
   133		int last_temperature = tz->last_temperature;
   134		bool notify;
   135	
   136		lockdep_assert_held(&tz->lock);
   137	
   138		/*
   139		 * We need a second update in order to detect a threshold being crossed
   140		 */
   141		if (last_temperature == THERMAL_TEMP_INVALID)
   142			return 0;
   143	
   144		/*
   145		 * The temperature is stable, so obviously we can not have
   146		 * crossed a threshold.
   147		 */
   148		if (last_temperature == temperature)
   149			return 0;
   150	
   151		/*
   152		 * Since last update the temperature:
   153		 * - increased : thresholds are crossed the way up
   154		 * - decreased : thresholds are crossed the way down
   155		 */
   156		if (temperature > last_temperature)
   157			notify = thermal_thresholds_handle_raising(thresholds, temperature,
   158								   last_temperature, low, high);
   159		else
   160			notify = thermal_thresholds_handle_dropping(thresholds, temperature,
   161								    last_temperature, low, high);
   162	
   163		if (notify)
   164			pr_debug("A threshold has been crossed the way %s, with a temperature=%d, last_temperature=%d\n",
   165				 temperature > last_temperature ? "up" : "down", temperature, last_temperature);
   166	
   167		return 0;
   168	}
   169	
   170	int thermal_thresholds_add(struct thermal_zone_device *tz, int temperature, int direction)
   171	{
   172		struct thresholds *thresholds = tz->thresholds;
   173		struct threshold *t;
   174	
   175		lockdep_assert_held(&tz->lock);
   176	
   177		t = __thermal_thresholds_find(thresholds, temperature);
   178		if (t) {
   179			if (t->direction == direction)
   180				return -EEXIST;
   181	
   182			t->direction |= direction;
   183		} else {
   184	
 > 185			t = kmalloc(sizeof(*t), GFP_KERNEL);
   186			if (!t)
   187				return -ENOMEM;
   188	
   189			INIT_LIST_HEAD(&t->list);
   190			t->temperature = temperature;
   191			t->direction = direction;
   192			list_add(&t->list, &thresholds->list);
   193			list_sort(NULL, &thresholds->list, __thermal_thresholds_cmp);
   194		}
   195	
   196		__thermal_zone_device_update(tz, THERMAL_THRESHOLD_ADDED);
   197	
   198		return 0;
   199	}
   200	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


Return-Path: <linux-pm+bounces-30662-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0FC7B0109E
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 03:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D49C76290B
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 01:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1467478F5E;
	Fri, 11 Jul 2025 01:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hk5LPoak"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6CF3A1B6;
	Fri, 11 Jul 2025 01:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752196470; cv=none; b=X160wizdm0WKeBN31AIIocrAUITMnTE0yBTvAbKM//YuJFp3Q7ofsoPd2vnRHIlMVNPqb3B+uSLNxsY9+hlJ8SgCOET9QcTavbeIh5WD9E/JDE80qgCurm2jr4GRke+lM8QEqBuFv3LnlVXJJxlxizvEnk7txXg87PZ+c01+Bsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752196470; c=relaxed/simple;
	bh=q6bgf8nbsmbq7qhLfWYwY4RarY9tPzXyKzdsj2l6iwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IK+BsP4ND4THcviBqYLtb6lrbrbsrT3Lh6/KZXYkjqRgP0/gwLlrKeMxR7BWOQKm8SODBrm9vFs1MnTfYgtOcPJ3LgCDe8oF6eS8fopYVJ4JnIg0T8sKJe02P218a18DaI7v5GP6NHKve7PzqtDyvrRdwZ5BbfWE5KyqbULRLq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hk5LPoak; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752196470; x=1783732470;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=q6bgf8nbsmbq7qhLfWYwY4RarY9tPzXyKzdsj2l6iwc=;
  b=Hk5LPoakMlkmpE14oYdFseGUdBDqgQW63ZL2saQ4beQBYiLCZor9bApz
   JLYjGLZmgqAk2B5PL13n0q+eeAhZii6Kl5kfwB8utEyDutu/zWFc4U8p7
   6nYy5WcOBMug+KAvxZ6gUoo0kxeqvXkDLno23G2Cyuhv5yGWHUqSG2PZ/
   si1AndnvEmCFLxJqowP9nNIFLOm1np/xghKlF5HlvJJiTGt4IAKvZ/95S
   TGAmCakSEyhU/3VprPcJOJC4D7D+MNhrVwCEY6GinzdAVa8RWak2VrKyC
   05RprWdWqTc2VwvR9I9QuijHBxPK6sKfPmZc72LzWSYKv+1KerUeMpcVq
   A==;
X-CSE-ConnectionGUID: RKwtS/ikQkKNI9Qp+DKBkQ==
X-CSE-MsgGUID: kQMygUXoSp6EVbB+yscw1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="65940544"
X-IronPort-AV: E=Sophos;i="6.16,302,1744095600"; 
   d="scan'208";a="65940544"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 18:14:29 -0700
X-CSE-ConnectionGUID: vsVsUFYdRBmlwmDGaNYNHA==
X-CSE-MsgGUID: b/jQH0PhRbS5yqpTSE21Qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,302,1744095600"; 
   d="scan'208";a="187242746"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 10 Jul 2025 18:14:21 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ua2LC-0005h9-0j;
	Fri, 11 Jul 2025 01:14:18 +0000
Date: Fri, 11 Jul 2025 09:14:05 +0800
From: kernel test robot <lkp@intel.com>
To: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Yan <andy.yan@rock-chips.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
	Konrad Dybcio <konradybcio@kernel.org>,
	cros-qcom-dts-watchers@chromium.org, Vinod Koul <vkoul@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Elliot Berman <elliotb317@gmail.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Stephen Boyd <swboyd@chromium.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	Andre Draszik <andre.draszik@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	linux-samsung-soc@vger.kernel.org, Wei Xu <xuwei5@hisilicon.com>
Subject: Re: [PATCH v10 01/10] power: reset: reboot-mode: Add device tree
 node-based registration
Message-ID: <202507110849.ahNmViin-lkp@intel.com>
References: <20250710-arm-psci-system_reset2-vendor-reboots-v10-1-b2d3b882be85@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710-arm-psci-system_reset2-vendor-reboots-v10-1-b2d3b882be85@oss.qualcomm.com>

Hi Shivendra,

kernel test robot noticed the following build errors:

[auto build test ERROR on 58ba80c4740212c29a1cf9b48f588e60a7612209]

url:    https://github.com/intel-lab-lkp/linux/commits/Shivendra-Pratap/power-reset-reboot-mode-Add-device-tree-node-based-registration/20250710-172104
base:   58ba80c4740212c29a1cf9b48f588e60a7612209
patch link:    https://lore.kernel.org/r/20250710-arm-psci-system_reset2-vendor-reboots-v10-1-b2d3b882be85%40oss.qualcomm.com
patch subject: [PATCH v10 01/10] power: reset: reboot-mode: Add device tree node-based registration
config: i386-buildonly-randconfig-006-20250711 (https://download.01.org/0day-ci/archive/20250711/202507110849.ahNmViin-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250711/202507110849.ahNmViin-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507110849.ahNmViin-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

>> drivers/power/reset/reboot-mode.c:15:9: warning: 'pr_fmt' macro redefined [-Wmacro-redefined]
      15 | #define pr_fmt(fmt)     "reboot-mode: " fmt
         |         ^
   include/linux/printk.h:397:9: note: previous definition is here
     397 | #define pr_fmt(fmt) fmt
         |         ^
>> drivers/power/reset/reboot-mode.c:86:10: error: call to undeclared function 'kzalloc'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      86 |                 info = kzalloc(sizeof(*info), GFP_KERNEL);
         |                        ^
>> drivers/power/reset/reboot-mode.c:86:8: error: incompatible integer to pointer conversion assigning to 'struct mode_info *' from 'int' [-Wint-conversion]
      86 |                 info = kzalloc(sizeof(*info), GFP_KERNEL);
         |                      ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/power/reset/reboot-mode.c:94:4: error: call to undeclared function 'kfree'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      94 |                         kfree(info);
         |                         ^
   drivers/power/reset/reboot-mode.c:139:3: error: call to undeclared function 'kfree'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     139 |                 kfree(info);
         |                 ^
   1 warning and 4 errors generated.


vim +/kzalloc +86 drivers/power/reset/reboot-mode.c

    13	
    14	#define PREFIX "mode-"
  > 15	#define pr_fmt(fmt)	"reboot-mode: " fmt
    16	
    17	struct mode_info {
    18		const char *mode;
    19		u32 magic;
    20		struct list_head list;
    21	};
    22	
    23	static unsigned int get_reboot_mode_magic(struct reboot_mode_driver *reboot,
    24						  const char *cmd)
    25	{
    26		const char *normal = "normal";
    27		struct mode_info *info;
    28		char cmd_[110];
    29	
    30		if (!cmd)
    31			cmd = normal;
    32	
    33		list_for_each_entry(info, &reboot->head, list)
    34			if (!strcmp(info->mode, cmd))
    35				return info->magic;
    36	
    37		/* try to match again, replacing characters impossible in DT */
    38		if (strscpy(cmd_, cmd, sizeof(cmd_)) == -E2BIG)
    39			return 0;
    40	
    41		strreplace(cmd_, ' ', '-');
    42		strreplace(cmd_, ',', '-');
    43		strreplace(cmd_, '/', '-');
    44	
    45		list_for_each_entry(info, &reboot->head, list)
    46			if (!strcmp(info->mode, cmd_))
    47				return info->magic;
    48	
    49		return 0;
    50	}
    51	
    52	static int reboot_mode_notify(struct notifier_block *this,
    53				      unsigned long mode, void *cmd)
    54	{
    55		struct reboot_mode_driver *reboot;
    56		unsigned int magic;
    57	
    58		reboot = container_of(this, struct reboot_mode_driver, reboot_notifier);
    59		magic = get_reboot_mode_magic(reboot, cmd);
    60		if (magic)
    61			reboot->write(reboot, magic);
    62	
    63		return NOTIFY_DONE;
    64	}
    65	
    66	/**
    67	 * reboot_mode_register - register a reboot mode driver
    68	 * @reboot: reboot mode driver
    69	 * @np: Pointer to device tree node
    70	 *
    71	 * Returns: 0 on success or a negative error code on failure.
    72	 */
    73	int reboot_mode_register(struct reboot_mode_driver *reboot, struct device_node *np)
    74	{
    75		struct mode_info *info;
    76		struct property *prop;
    77		size_t len = strlen(PREFIX);
    78		int ret;
    79	
    80		INIT_LIST_HEAD(&reboot->head);
    81	
    82		for_each_property_of_node(np, prop) {
    83			if (strncmp(prop->name, PREFIX, len))
    84				continue;
    85	
  > 86			info = kzalloc(sizeof(*info), GFP_KERNEL);
    87			if (!info) {
    88				ret = -ENOMEM;
    89				goto error;
    90			}
    91	
    92			if (of_property_read_u32(np, prop->name, &info->magic)) {
    93				pr_err("reboot mode %s without magic number\n", info->mode);
  > 94				kfree(info);
    95				continue;
    96			}
    97	
    98			info->mode = kstrdup_const(prop->name + len, GFP_KERNEL);
    99			if (!info->mode) {
   100				ret =  -ENOMEM;
   101				goto error;
   102			} else if (info->mode[0] == '\0') {
   103				kfree_const(info->mode);
   104				ret = -EINVAL;
   105				pr_err("invalid mode name(%s): too short!\n", prop->name);
   106				goto error;
   107			}
   108	
   109			list_add_tail(&info->list, &reboot->head);
   110		}
   111	
   112		reboot->reboot_notifier.notifier_call = reboot_mode_notify;
   113		register_reboot_notifier(&reboot->reboot_notifier);
   114	
   115		return 0;
   116	
   117	error:
   118		list_for_each_entry(info, &reboot->head, list)
   119			kfree_const(info->mode);
   120	
   121		return ret;
   122	}
   123	EXPORT_SYMBOL_GPL(reboot_mode_register);
   124	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


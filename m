Return-Path: <linux-pm+bounces-42633-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0O8sDsU4kGkuXgEAu9opvQ
	(envelope-from <linux-pm+bounces-42633-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sat, 14 Feb 2026 09:56:37 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B36313B810
	for <lists+linux-pm@lfdr.de>; Sat, 14 Feb 2026 09:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1059D300A76F
	for <lists+linux-pm@lfdr.de>; Sat, 14 Feb 2026 08:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F78A32694C;
	Sat, 14 Feb 2026 08:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q663OU/0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765163218BA;
	Sat, 14 Feb 2026 08:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771059392; cv=none; b=R05HtPWO0GvLmQnULRbJkv3Lm372BbkcJwRWgaaoI2I2Vocc36KvJO54vbuzp1WhS9JO3SfgsExiq5A0lnfiAX1hsLpQH6rCmvKciYxcEAK+4HxV4yToIv769neTEaETVIlf89NuCMeRKcOjq5Y/7Zyru/M3+VhRB8y39ForXMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771059392; c=relaxed/simple;
	bh=FmU6sN6VTvK2lk9nkffJpXX9j+KGsN9TIxoBy1pLkF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JrweolYTVbeaHDleuJ9M4YIps7c39Cp9NrYSttIA6NerhXg/wiwBaB4nhM915dV326JTHVMs7+Jsz2ECgnD83AI/nCHwGC8uT1NuJ9sn3H1TTf/vzeDYIuGrL0k8DBXyOJY18BE/YekfELlDwyRgXniR59Q1U4sYGUztalYWOxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q663OU/0; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771059387; x=1802595387;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FmU6sN6VTvK2lk9nkffJpXX9j+KGsN9TIxoBy1pLkF0=;
  b=Q663OU/0kclcSCrHbC+Z7f+IatB68YiepEW42MHDErrv42kUTCpdd3Fn
   gHDivvz02HUbPiUUsEuKvQXTW9Qgurd+MwwOovwxVviJ49T42DNPpmu0j
   ZemN1yLrRoudb6iqPFVtePp6EtiDQn07K8WXFlF9uYFHcngQPMjT6iHk0
   qL93mwAy6V7BLjk0Srd57reY1n4RbRpaRJKAUHu9LeGlw2GBd6J5c37mv
   peBuB2tyK2E4UKkGkiew4n5zTuK5oG0aWZQbdlEYWjas5z5h/EgnnVfeT
   VvsCjK07uR/wC3c2R7IOeD7j6YEJQSJvQKY1cM7WBIhKTHwoCAvzQ36Yk
   g==;
X-CSE-ConnectionGUID: bOXwc9I6SnCPGJKwFeEeuA==
X-CSE-MsgGUID: /GxuXnI2Tnqk+RGypmdszw==
X-IronPort-AV: E=McAfee;i="6800,10657,11700"; a="71428986"
X-IronPort-AV: E=Sophos;i="6.21,290,1763452800"; 
   d="scan'208";a="71428986"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2026 00:56:26 -0800
X-CSE-ConnectionGUID: N824LeOqToGHpVGW64sH6Q==
X-CSE-MsgGUID: Qhwja1+kR8SCKwHr/L7Utg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,290,1763452800"; 
   d="scan'208";a="218110063"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 14 Feb 2026 00:56:20 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vrBRp-00000000wPI-1UDK;
	Sat, 14 Feb 2026 08:56:17 +0000
Date: Sat, 14 Feb 2026 16:56:15 +0800
From: kernel test robot <lkp@intel.com>
To: Amit Sunil Dhamne via B4 Relay <devnull+amitsd.google.com@kernel.org>,
	Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>,
	Lee Jones <lee@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Badhri Jagan Sridharan <badhri@google.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Peter Griffin <peter.griffin@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Mark Brown <broonie@kernel.org>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	RD Babiera <rdbabiera@google.com>, Kyle Tso <kyletso@google.com>,
	Amit Sunil Dhamne <amitsd@google.com>
Subject: Re: [PATCH v6 5/6] power: supply: max77759: add charger driver
Message-ID: <202602141606.igFDFWAJ-lkp@intel.com>
References: <20260214-max77759-charger-v6-5-28c09bda74b4@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260214-max77759-charger-v6-5-28c09bda74b4@google.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42633-lists,linux-pm=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,linaro.org,linuxfoundation.org,google.com,linux.intel.com,samsung.com,fi.rohmeurope.com,gmail.com,linux-foundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pm,amitsd.google.com,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: 8B36313B810
X-Rspamd-Action: no action

Hi Amit,

kernel test robot noticed the following build errors:

[auto build test ERROR on 8dfce8991b95d8625d0a1d2896e42f93b9d7f68d]

url:    https://github.com/intel-lab-lkp/linux/commits/Amit-Sunil-Dhamne-via-B4-Relay/dt-bindings-mfd-maxim-max77759-reference-power-supply-schema-and-add-regulator-property/20260214-111637
base:   8dfce8991b95d8625d0a1d2896e42f93b9d7f68d
patch link:    https://lore.kernel.org/r/20260214-max77759-charger-v6-5-28c09bda74b4%40google.com
patch subject: [PATCH v6 5/6] power: supply: max77759: add charger driver
config: powerpc64-randconfig-001-20260214 (https://download.01.org/0day-ci/archive/20260214/202602141606.igFDFWAJ-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 9b8addffa70cee5b2acc5454712d9cf78ce45710)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260214/202602141606.igFDFWAJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602141606.igFDFWAJ-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/power/supply/max77759_charger.c:623:4: error: cannot jump from this goto statement to its label
     623 |                         goto err;
         |                         ^
   drivers/power/supply/max77759_charger.c:631:2: note: jump bypasses initialization of variable with __attribute__((cleanup))
     631 |         guard(mutex)(&chg->retry_lock);
         |         ^
   include/linux/cleanup.h:414:15: note: expanded from macro 'guard'
     414 |         CLASS(_name, __UNIQUE_ID(guard))
         |                      ^
   include/linux/compiler.h:168:2: note: expanded from macro '__UNIQUE_ID'
     168 |         __PASTE(__UNIQUE_ID_,                                   \
         |         ^
   include/linux/compiler_types.h:16:23: note: expanded from macro '__PASTE'
      16 | #define __PASTE(a, b) ___PASTE(a, b)
         |                       ^
   include/linux/compiler_types.h:15:24: note: expanded from macro '___PASTE'
      15 | #define ___PASTE(a, b) a##b
         |                        ^
   <scratch space>:18:1: note: expanded from here
      18 | __UNIQUE_ID_guard_461
         | ^
   drivers/power/supply/max77759_charger.c:615:3: error: cannot jump from this goto statement to its label
     615 |                 goto err;
         |                 ^
   drivers/power/supply/max77759_charger.c:631:2: note: jump bypasses initialization of variable with __attribute__((cleanup))
     631 |         guard(mutex)(&chg->retry_lock);
         |         ^
   include/linux/cleanup.h:414:15: note: expanded from macro 'guard'
     414 |         CLASS(_name, __UNIQUE_ID(guard))
         |                      ^
   include/linux/compiler.h:168:2: note: expanded from macro '__UNIQUE_ID'
     168 |         __PASTE(__UNIQUE_ID_,                                   \
         |         ^
   include/linux/compiler_types.h:16:23: note: expanded from macro '__PASTE'
      16 | #define __PASTE(a, b) ___PASTE(a, b)
         |                       ^
   include/linux/compiler_types.h:15:24: note: expanded from macro '___PASTE'
      15 | #define ___PASTE(a, b) a##b
         |                        ^
   <scratch space>:18:1: note: expanded from here
      18 | __UNIQUE_ID_guard_461
         | ^
   drivers/power/supply/max77759_charger.c:606:3: error: cannot jump from this goto statement to its label
     606 |                 goto err;
         |                 ^
   drivers/power/supply/max77759_charger.c:631:2: note: jump bypasses initialization of variable with __attribute__((cleanup))
     631 |         guard(mutex)(&chg->retry_lock);
         |         ^
   include/linux/cleanup.h:414:15: note: expanded from macro 'guard'
     414 |         CLASS(_name, __UNIQUE_ID(guard))
         |                      ^
   include/linux/compiler.h:168:2: note: expanded from macro '__UNIQUE_ID'
     168 |         __PASTE(__UNIQUE_ID_,                                   \
         |         ^
   include/linux/compiler_types.h:16:23: note: expanded from macro '__PASTE'
      16 | #define __PASTE(a, b) ___PASTE(a, b)
         |                       ^
   include/linux/compiler_types.h:15:24: note: expanded from macro '___PASTE'
      15 | #define ___PASTE(a, b) a##b
         |                        ^
   <scratch space>:18:1: note: expanded from here
      18 | __UNIQUE_ID_guard_461
         | ^
   3 errors generated.


vim +623 drivers/power/supply/max77759_charger.c

   591	
   592	static void psy_work_item(struct work_struct *work)
   593	{
   594		struct max77759_charger *chg =
   595			container_of(work, struct max77759_charger, psy_work.work);
   596		union power_supply_propval current_limit, online;
   597		int ret;
   598	
   599		ret = power_supply_get_property(chg->tcpm_psy,
   600						POWER_SUPPLY_PROP_CURRENT_MAX,
   601						&current_limit);
   602		if (ret) {
   603			dev_err(chg->dev,
   604				"Failed to get CURRENT_MAX psy property, ret=%d",
   605				ret);
   606			goto err;
   607		}
   608	
   609		ret = power_supply_get_property(chg->tcpm_psy, POWER_SUPPLY_PROP_ONLINE,
   610						&online);
   611		if (ret) {
   612			dev_err(chg->dev,
   613				"Failed to get ONLINE psy property, ret=%d",
   614				ret);
   615			goto err;
   616		}
   617	
   618		if (online.intval && current_limit.intval) {
   619			ret = set_input_current_limit(chg, current_limit.intval);
   620			if (ret) {
   621				dev_err(chg->dev,
   622					"Unable to set current limit, ret=%d", ret);
 > 623				goto err;
   624			}
   625	
   626			charger_set_mode(chg, MAX77759_CHGR_MODE_CHG_BUCK_ON);
   627		} else {
   628			charger_set_mode(chg, MAX77759_CHGR_MODE_OFF);
   629		}
   630	
   631		guard(mutex)(&chg->retry_lock);
   632	
   633		if (chg->psy_work_retry_cnt)
   634			dev_dbg(chg->dev, "chg psy_work succeeded after %u tries",
   635				chg->psy_work_retry_cnt);
   636		chg->psy_work_retry_cnt = 0;
   637		return;
   638	
   639	err:
   640		charger_set_mode(chg, MAX77759_CHGR_MODE_OFF);
   641		guard(mutex)(&chg->retry_lock);
   642	
   643		if (chg->psy_work_retry_cnt >= MAX_NUM_RETRIES) {
   644			dev_err(chg->dev, "chg psy work failed, giving up");
   645			return;
   646		}
   647	
   648		++chg->psy_work_retry_cnt;
   649		dev_dbg(chg->dev, "Retrying %u/%u chg psy_work",
   650			chg->psy_work_retry_cnt, MAX_NUM_RETRIES);
   651		schedule_delayed_work(&chg->psy_work,
   652				      msecs_to_jiffies(PSY_WORK_RETRY_DELAY_MS));
   653	}
   654	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


Return-Path: <linux-pm+bounces-41640-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJmcE/13emmE6wEAu9opvQ
	(envelope-from <linux-pm+bounces-41640-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 21:56:29 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E51AA8DFB
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 21:56:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D9753014C10
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 20:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389D437649B;
	Wed, 28 Jan 2026 20:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I6NQOWhG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1A318027;
	Wed, 28 Jan 2026 20:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769633513; cv=none; b=CIfCAwV+r21P9KhB7cUsqnSTMyvkInrCPgNgaoiaOakT9S4y/kiFuzKqwTGcGbXmJzRAXcrvmvr0YvpCulyRGfj50/Bpu7tR+Q2myRZX37oxO+vhNF8hDewBzG5sNEu7uPYJfZ6fDP+RQDA7iqAp/PS9kR0I/UhfEKTvNiamHWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769633513; c=relaxed/simple;
	bh=ha8O6xBwkZSEe2x4SwRua9ejKFac6uo5R6gUfiFhrL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rR77NEKSak6/hjuCcWkDdlJ04OpqOw4dn5ptt2+TlSfTBzyexqUYrFmFKVPGw6VKVmyjjoB2KIS/FlXyWfG1NYe+28P0MGLDFZsRovtCDSXzsyPGG4DIBljR0cMukz8i5fzJcUNGOuz1oly//nCHIFuSmQVcUlKKh8kRZoR8hwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I6NQOWhG; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769633512; x=1801169512;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ha8O6xBwkZSEe2x4SwRua9ejKFac6uo5R6gUfiFhrL0=;
  b=I6NQOWhGeAkK+895bW3tbBrhhF2YTnCE/kS+S/MpUoXivlOZugZijLv4
   29Gr8Yr/ktom6jdU9T2g2u35ByoH8GSFeSDzHFyDio6UvR98e7xSsslwS
   9eKS2haefkPYsQfyjyH689m43nkGrOQ9OJr0t6hbTuxXMlNNQ4a2Pa1M+
   Pf/44EckXFy07lFlEGpdKq1LwBHkoSJVMTpmwCxNne07IEytx1X96Fnh5
   Vuriz90MBdduX8NHdkZuIYGeEj+SeCJHrjwEiwMfxg0C9+QvFojabRrM3
   mRmHAr2L/rcG/kQ27F+46m/8mjoyAKLFYJ6tAD6562bBWPRm51tu4wpNM
   w==;
X-CSE-ConnectionGUID: sKtiKRU8SkWIOryzL7/HTA==
X-CSE-MsgGUID: 5eWT0QOGR5ikcBRE68r5JA==
X-IronPort-AV: E=McAfee;i="6800,10657,11685"; a="74707655"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="74707655"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 12:51:48 -0800
X-CSE-ConnectionGUID: ycrchlomTX6zgh1lpCciQw==
X-CSE-MsgGUID: Zz6Zga9YSyWrIn4dTFUbww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="207971392"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 28 Jan 2026 12:51:41 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vlCVm-00000000anM-33eF;
	Wed, 28 Jan 2026 20:51:38 +0000
Date: Thu, 29 Jan 2026 04:51:33 +0800
From: kernel test robot <lkp@intel.com>
To: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>, jic23@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	agross@kernel.org, andersson@kernel.org, lumag@kernel.org,
	dmitry.baryshkov@oss.qualcomm.com, konradybcio@kernel.org,
	daniel.lezcano@linaro.org, sboyd@kernel.org, amitk@kernel.org,
	thara.gopinath@gmail.com, lee@kernel.org, rafael@kernel.org,
	subbaraman.narayanamurthy@oss.qualcomm.com,
	david.collins@oss.qualcomm.com, anjelique.melendez@oss.qualcomm.com,
	kamal.wadhwa@oss.qualcomm.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	rui.zhang@intel.com, lukasz.luba@arm.com,
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, cros-qcom-dts-watchers@chromium.org,
	jishnu.prakash@oss.qualcomm.com, quic_kotarake@quicinc.com,
	neil.armstrong@linaro.org
Subject: Re: [PATCH V9 4/4] thermal: qcom: add support for PMIC5 Gen3 ADC
 thermal monitoring
Message-ID: <202601290438.IXYMj3d2-lkp@intel.com>
References: <20260128112420.695518-5-jishnu.prakash@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128112420.695518-5-jishnu.prakash@oss.qualcomm.com>
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
	RCPT_COUNT_TWELVE(0.00)[33];
	URIBL_MULTI_FAIL(0.00)[intel.com:server fail,sea.lore.kernel.org:server fail,01.org:server fail];
	TAGGED_FROM(0.00)[bounces-41640-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,kernel.org,linaro.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[01.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: 8E51AA8DFB
X-Rspamd-Action: no action

Hi Jishnu,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 63804fed149a6750ffd28610c5c1c98cce6bd377]

url:    https://github.com/intel-lab-lkp/linux/commits/Jishnu-Prakash/dt-bindings-iio-adc-Split-out-QCOM-VADC-channel-properties/20260128-193116
base:   63804fed149a6750ffd28610c5c1c98cce6bd377
patch link:    https://lore.kernel.org/r/20260128112420.695518-5-jishnu.prakash%40oss.qualcomm.com
patch subject: [PATCH V9 4/4] thermal: qcom: add support for PMIC5 Gen3 ADC thermal monitoring
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20260129/202601290438.IXYMj3d2-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260129/202601290438.IXYMj3d2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601290438.IXYMj3d2-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c:180:9: warning: variable 'upper_set' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
     180 |                                 if (ret)
         |                                     ^~~
   drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c:188:9: note: uninitialized use occurs here
     188 |                 if (!(upper_set || lower_set))
         |                       ^~~~~~~~~
   drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c:180:5: note: remove the 'if' if its condition is always false
     180 |                                 if (ret)
         |                                 ^~~~~~~~
     181 |                                         break;
         |                                         ~~~~~
   drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c:171:17: note: initialize the variable 'upper_set' to silence this warning
     171 |                 bool upper_set, lower_set;
         |                               ^
         |                                = 0
   1 warning generated.


vim +180 drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c

   159	
   160	static void tm_handler_work(struct work_struct *work)
   161	{
   162		struct adc_tm5_gen3_chip *adc_tm5 = container_of(work, struct adc_tm5_gen3_chip,
   163								 tm_handler_work);
   164		int sdam_index = -1;
   165		u8 tm_status[2] = { };
   166		u8 buf[16] = { };
   167	
   168		for (int i = 0; i < adc_tm5->nchannels; i++) {
   169			struct adc_tm5_gen3_channel_props *chan_prop = &adc_tm5->chan_props[i];
   170			int offset = chan_prop->tm_chan_index;
   171			bool upper_set, lower_set;
   172			int ret, temp;
   173			u16 code;
   174	
   175			scoped_guard(adc5_gen3, adc_tm5) {
   176				if (chan_prop->sdam_index != sdam_index) {
   177					sdam_index = chan_prop->sdam_index;
   178					ret = adc5_gen3_tm_status_check(adc_tm5, sdam_index,
   179									tm_status, buf);
 > 180					if (ret)
   181						break;
   182				}
   183	
   184				upper_set = ((tm_status[0] & BIT(offset)) && chan_prop->high_thr_en);
   185				lower_set = ((tm_status[1] & BIT(offset)) && chan_prop->low_thr_en);
   186			}
   187	
   188			if (!(upper_set || lower_set))
   189				continue;
   190	
   191			code = get_unaligned_le16(&buf[2 * offset]);
   192			dev_dbg(adc_tm5->dev, "ADC_TM threshold code:%#x\n", code);
   193	
   194			ret = adc5_gen3_therm_code_to_temp(adc_tm5->dev,
   195							   &chan_prop->common_props,
   196							   code, &temp);
   197			if (ret) {
   198				dev_err(adc_tm5->dev,
   199					"Invalid temperature reading, ret = %d, code=%#x\n",
   200					ret, code);
   201				continue;
   202			}
   203	
   204			chan_prop->last_temp = temp;
   205			chan_prop->last_temp_set = true;
   206			thermal_zone_device_update(chan_prop->tzd, THERMAL_TRIP_VIOLATED);
   207		}
   208	}
   209	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


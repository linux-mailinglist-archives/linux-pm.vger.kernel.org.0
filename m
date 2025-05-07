Return-Path: <linux-pm+bounces-26772-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C82BAAD581
	for <lists+linux-pm@lfdr.de>; Wed,  7 May 2025 07:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 241937A3862
	for <lists+linux-pm@lfdr.de>; Wed,  7 May 2025 05:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A49C202C2B;
	Wed,  7 May 2025 05:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jXwqnIC0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AB11FDE3D;
	Wed,  7 May 2025 05:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746596996; cv=none; b=W0/Hd8Z5fN8xMOZOnSG6drYaWa3SGXZ0ns/rKMyiAWv3mOX80c0ezEnlBWUKbmDy11/9SbmicATmjiwYzcgoTFni24p+qwWS5TmOo2ibFolzMoEqR5lUI0g0XXvsjpsShXLMP1u4RsE+01UIpduK61ijMCknTdkYv22P0pXKJ1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746596996; c=relaxed/simple;
	bh=gMWKuqiccB/vdz3+zeg5KDOgnOnUHr7QCke6tYWkzNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TqwUSADVvC4x9jFHoB5okG118ghZvHrmrg0l3l3VdZAu7dOTSnXmkD8xdzyGS0CbwRlU2Tler3qDO38GeABEW+v9/eLij+VaTgaTRbjXXCf9ev07XSuC0IWMGMCwhw8A/cAF5dYEXhloVpVEB82+Y/WJFNgN/OvvKTsQn4ixd8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jXwqnIC0; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746596995; x=1778132995;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gMWKuqiccB/vdz3+zeg5KDOgnOnUHr7QCke6tYWkzNo=;
  b=jXwqnIC0wApU3zanhUvbLY4fTgQ0TDXwaqh/Eyw1NZELALRY0IDSkLBe
   hUGYvY2skOvCQx7JJb6cbXxix7//BJhnRqDnILMhWUYvMUJmx1vD4G0+r
   6TtFm8FlOCyJtQ/kULkSz9F4pF7i49wpmZRjs0iMsaXbcvbmWfXPL67Vs
   tf1CLpuY1y/6y9rMXcAuUOudOb/pg9tlx2zvZx5FIaim7H+veNaKaxOUM
   hvT6WAJxcmaWBa2dMZNvLU7Ri5Lju4wr7ZHJRucXGGjkKo/3dRPOCmV5C
   WUu0raPBw6Ug/THsffUzckGWHXQBAraLjXl8i4FAn7kePgRbpkvpRT0QU
   g==;
X-CSE-ConnectionGUID: kNBOOjn7T+msxKcJRZe8kw==
X-CSE-MsgGUID: mWI2RPv+QGO0XTlA4REeQg==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="52120539"
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; 
   d="scan'208";a="52120539"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 22:49:54 -0700
X-CSE-ConnectionGUID: Dng6zhbARaqwORnXV3pdkg==
X-CSE-MsgGUID: o/PsYAEDSKS8dWxiGvu4sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; 
   d="scan'208";a="140580415"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 06 May 2025 22:49:49 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uCXf8-00077Q-1d;
	Wed, 07 May 2025 05:49:46 +0000
Date: Wed, 7 May 2025 13:49:03 +0800
From: kernel test robot <lkp@intel.com>
To: Praveen Talari <quic_ptalari@quicinc.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, psodagud@quicinc.com, djaggi@quicinc.com,
	quic_msavaliy@quicinc.com, quic_vtanuku@quicinc.com,
	quic_arandive@quicinc.com, quic_mnaresh@quicinc.com,
	quic_shazhuss@quicinc.com
Subject: Re: [PATCH v3 4/9] soc: qcom: geni-se: Enable QUPs on SA8255p
 Qualcomm platforms
Message-ID: <202505071326.jjvv4tTv-lkp@intel.com>
References: <20250502031018.1292-5-quic_ptalari@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250502031018.1292-5-quic_ptalari@quicinc.com>

Hi Praveen,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 3e039dcc9c1320c0d33ddd51c372dcc91d3ea3c7]

url:    https://github.com/intel-lab-lkp/linux/commits/Praveen-Talari/opp-add-new-helper-API-dev_pm_opp_set_level/20250502-111540
base:   3e039dcc9c1320c0d33ddd51c372dcc91d3ea3c7
patch link:    https://lore.kernel.org/r/20250502031018.1292-5-quic_ptalari%40quicinc.com
patch subject: [PATCH v3 4/9] soc: qcom: geni-se: Enable QUPs on SA8255p Qualcomm platforms
config: arc-randconfig-002-20250502 (https://download.01.org/0day-ci/archive/20250507/202505071326.jjvv4tTv-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 12.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250507/202505071326.jjvv4tTv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505071326.jjvv4tTv-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/soc/qcom/qcom-geni-se.c:109 struct member 'geni_se_rsc_init' not described in 'geni_se_desc'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


Return-Path: <linux-pm+bounces-27783-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 565E1AC7576
	for <lists+linux-pm@lfdr.de>; Thu, 29 May 2025 03:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F4DC4A68DE
	for <lists+linux-pm@lfdr.de>; Thu, 29 May 2025 01:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E79E219301;
	Thu, 29 May 2025 01:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xp0Z4Bec"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22D821CC54;
	Thu, 29 May 2025 01:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748483190; cv=none; b=F/L3ngT2qzVMO9Tpca2A56NpjE1ssl8Y/ScC+iOCM90fQE94bP9DP/Nz1cbi3Y144Hvz2U2cix9ABPLUWdrsMPTSslZ5a3dCYU84s8gPovAnGnldUNQd0jydJ1odK99Ekq8PXnK2sXm6eTk9EcGR9Favh32C5pA5dBzRms0nAFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748483190; c=relaxed/simple;
	bh=wffocwkHPCAJ8i51ohkJWseF7GJ2jZKI/kVRt/RI6r8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qby2O6dR17uaWKoQXJ5olGM6yVCthEfPhAvObzAvjT6oxM7Jitt3OMrQvrIekGQmIsdELnnODnjtn4TD/EvzG+yJEOPxjB+S3F3Pk0GMsjKoCnAZys7pRhjg6u/WbE8cMvOIFChJUOPN7NT5DUdmGs4sdAhoswvFwYw7AuI5Zs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xp0Z4Bec; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748483188; x=1780019188;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wffocwkHPCAJ8i51ohkJWseF7GJ2jZKI/kVRt/RI6r8=;
  b=Xp0Z4Bec3QNt8JtOOdCSFBFxl63rp/yBLIBY2IJ1n01SdMVc7NGDr1CU
   O0YZuEZsvCXsuiYd9amT4dBP3Ln2l+nzP4blVn99YSffXnUrcmgz+ZxIY
   KW3VzWoAEVoDWp3irSsvMBz//Sn8VjTihaTklaxsS8wTSYqPaRob035Wk
   ALCwVzrZJufbC1U0hSlzWP8KcoQ8g2nBP5h5kHbYdqbkTLM3SECwBqJJx
   PqLbgi3h8LnFyPIns32WVe3BwixRz9Hl41zzESnFB9B2WdpmL5J7z03Tj
   UqhTAQPOmGmui0o11KJWdJok0k0Nb7A8C/qpab23RpcIJ4w7alGUcbNJB
   g==;
X-CSE-ConnectionGUID: WRFnPRXHT0S8YGl/2n4RDQ==
X-CSE-MsgGUID: 2X2ykKlpQPKhC9D18AQLHA==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="54336238"
X-IronPort-AV: E=Sophos;i="6.15,322,1739865600"; 
   d="scan'208";a="54336238"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 18:46:27 -0700
X-CSE-ConnectionGUID: OoiBJyxpS8+jApZdAl8ItQ==
X-CSE-MsgGUID: QParBWCcRHCAboPKy+vw7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,322,1739865600"; 
   d="scan'208";a="148270367"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 28 May 2025 18:45:13 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uKSKV-000WDU-0b;
	Thu, 29 May 2025 01:45:11 +0000
Date: Thu, 29 May 2025 09:44:14 +0800
From: kernel test robot <lkp@intel.com>
To: Samuel Kayode via B4 Relay <devnull+samuel.kayode.savoirfairelinux.com@kernel.org>,
	Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sebastian Reichel <sre@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Samuel Kayode <samuel.kayode@savoirfairelinux.com>,
	eballetbo@gmail.com, abelvesa@linux.com, b38343@freescale.com,
	yibin.gong@nxp.com, Abel Vesa <abelvesa@kernel.org>
Subject: Re: [PATCH v3 3/6] regulator: pf1550: add support for regulator
Message-ID: <202505290947.V64gMrRB-lkp@intel.com>
References: <20250527-pf1550-v3-3-45f69453cd51@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250527-pf1550-v3-3-45f69453cd51@savoirfairelinux.com>

Hi Samuel,

kernel test robot noticed the following build errors:

[auto build test ERROR on 0a4b866d08c6adaea2f4592d31edac6deeb4dcbd]

url:    https://github.com/intel-lab-lkp/linux/commits/Samuel-Kayode-via-B4-Relay/dt-bindings-mfd-add-pf1550/20250528-062840
base:   0a4b866d08c6adaea2f4592d31edac6deeb4dcbd
patch link:    https://lore.kernel.org/r/20250527-pf1550-v3-3-45f69453cd51%40savoirfairelinux.com
patch subject: [PATCH v3 3/6] regulator: pf1550: add support for regulator
config: i386-randconfig-017-20250529 (https://download.01.org/0day-ci/archive/20250529/202505290947.V64gMrRB-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250529/202505290947.V64gMrRB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505290947.V64gMrRB-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "pf1550_read_otp" [drivers/regulator/pf1550-regulator.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


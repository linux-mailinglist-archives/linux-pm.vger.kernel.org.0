Return-Path: <linux-pm+bounces-28722-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C6CADA191
	for <lists+linux-pm@lfdr.de>; Sun, 15 Jun 2025 12:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F90B3ADC22
	for <lists+linux-pm@lfdr.de>; Sun, 15 Jun 2025 10:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD698262FFD;
	Sun, 15 Jun 2025 10:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mYifg02c"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382A51805E;
	Sun, 15 Jun 2025 10:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749984772; cv=none; b=UBNPHiNFxPNMQYva+O39EfBLwMAn13fuvvlcgBzR1Yp5cXurhocuhAZd+Joh+cAghqQ+Td2gE2ZeQQAebA7d2nYRuHtSN2hwF9Ko6g0uNrpR2S2pkIx7AeBw6+Bz28UZMUCX3TPWmQVQsa1znlIAVJqtrvDzsL3hSbp6M9qPeNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749984772; c=relaxed/simple;
	bh=ejtojejYEkKUTk6N+o9TY6ArccN85B9ukz5YklvHMeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZWRe86yBx/1lre0YF8u1oBSVhp+TEUlQ0E1gZa4NNRWQ8rdCyuV9llXBv0Z3no57JlBVahY8tol560WR55YG8ShFbQBn58nrVz5MSCYhiECBOuCEKi/pieCQ9bcYq3poZluWh1F4IeP+PJPLy2MNn2UGsFe67D3nAH+bpAZmApQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mYifg02c; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749984771; x=1781520771;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ejtojejYEkKUTk6N+o9TY6ArccN85B9ukz5YklvHMeQ=;
  b=mYifg02cFkKBD54QkypMJSZIQgEYmvZAJqJz0LHjLzarQQaRyUwN8o6P
   XzfRaEOxUBZN9E9uelfoJQ3O9+GCR7CWXusaUDW4gD7N3gdLuhHpCZzIg
   L+fc0yOx/GxB94o1Lebt42Swxhke6aJJs0f6iIs1296X+vkkb8UGCEbvT
   UYxhukaMMAtV1+Esv0IYTs1EI9cwy7PXV+QjkHi+jl6DaiAksNd8UpqmJ
   1P9HlBMsGBRo4it8amm24hVyD4Rj079FhfTFxd9OM+aDD5CRYiqLQVtYq
   vqTlKALvYJsnrJpqSmdnmISz0RtV8ec6fHs9nGU5T73yt8zeoGfd2SdrY
   Q==;
X-CSE-ConnectionGUID: +U1C+7uYThqRUfjN+g8pRQ==
X-CSE-MsgGUID: r8soisfiQb+NHpGLZ5NAHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11464"; a="52285339"
X-IronPort-AV: E=Sophos;i="6.16,239,1744095600"; 
   d="scan'208";a="52285339"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2025 03:52:50 -0700
X-CSE-ConnectionGUID: iPnqe7lDTyWwtmi51DmowQ==
X-CSE-MsgGUID: KOTMKZ52R2ij4S+CeEoraw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,239,1744095600"; 
   d="scan'208";a="149129847"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 15 Jun 2025 03:52:45 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uQkyg-000EFw-0j;
	Sun, 15 Jun 2025 10:52:42 +0000
Date: Sun, 15 Jun 2025 18:51:47 +0800
From: kernel test robot <lkp@intel.com>
To: Michal Wilczynski <m.wilczynski@samsung.com>,
	Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Frank Binns <frank.binns@imgtec.com>,
	Matt Coster <matt.coster@imgtec.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Paul Gazzillo <paul@pgazz.com>,
	Necip Fazil Yildiran <fazilyildiran@gmail.com>,
	oe-kbuild-all@lists.linux.dev, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v4 8/8] drm/imagination: Enable PowerVR driver for RISC-V
Message-ID: <202506151839.IKkZs0Z0-lkp@intel.com>
References: <20250614-apr_14_for_sending-v4-8-8e3945c819cd@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250614-apr_14_for_sending-v4-8-8e3945c819cd@samsung.com>

Hi Michal,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 4774cfe3543abb8ee98089f535e28ebfd45b975a]

url:    https://github.com/intel-lab-lkp/linux/commits/Michal-Wilczynski/power-sequencing-Add-T-HEAD-TH1520-GPU-power-sequencer-driver/20250615-021142
base:   4774cfe3543abb8ee98089f535e28ebfd45b975a
patch link:    https://lore.kernel.org/r/20250614-apr_14_for_sending-v4-8-8e3945c819cd%40samsung.com
patch subject: [PATCH v4 8/8] drm/imagination: Enable PowerVR driver for RISC-V
config: riscv-kismet-CONFIG_DRM_GEM_SHMEM_HELPER-CONFIG_DRM_POWERVR-0-0 (https://download.01.org/0day-ci/archive/20250615/202506151839.IKkZs0Z0-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20250615/202506151839.IKkZs0Z0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506151839.IKkZs0Z0-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for DRM_GEM_SHMEM_HELPER when selected by DRM_POWERVR
   WARNING: unmet direct dependencies detected for DRM_GEM_SHMEM_HELPER
     Depends on [n]: HAS_IOMEM [=y] && DRM [=y] && MMU [=n]
     Selected by [y]:
     - DRM_POWERVR [=y] && HAS_IOMEM [=y] && (ARM64 || RISCV [=y]) && DRM [=y] && PM [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


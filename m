Return-Path: <linux-pm+bounces-28794-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C326ADAB81
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 11:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9CB07A7CCA
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 09:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C94126E16E;
	Mon, 16 Jun 2025 09:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="NJjjWtui"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C835720CCC9
	for <linux-pm@vger.kernel.org>; Mon, 16 Jun 2025 09:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750064995; cv=none; b=lD8tiUprtqp4J4vV5pi1JHOcy/EEGoY9TtlmpMQ2oFrn7GOR4bvwal3rFQaD7v5SwCspS2rW4q9vjWDmnsIFSuHRGI7T7bT27d5CRhbIDpYOI6lsXsn/qUncCtjr5xzJqkb9m+EMUyuyZCpF/QJf84k8k4gIbt2GsxY2v+9p3pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750064995; c=relaxed/simple;
	bh=3rrLsFGRkgwqakiZkwY9lo4QrXlqLwVthtdYujqyOVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=VvheefZfMxnMJuNlcf8N+X76HbLimR2u3TWSCkc26inGUmi9oP+hSRYdpfF9B1mxeKszuh8rsqcak9kqxCC7ytwXcoG6IpIPyoZvLsTa1ISHvV3W0tEK0Pg1+GERDEt+Rpt4WIMZbZigll72sGJnS5W3d93t28PSycO2HGBeG6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=NJjjWtui; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250616090945euoutp02fc674bf3a224858f4be8f556e56fd27f~JetTt4-CZ1989619896euoutp02e
	for <linux-pm@vger.kernel.org>; Mon, 16 Jun 2025 09:09:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250616090945euoutp02fc674bf3a224858f4be8f556e56fd27f~JetTt4-CZ1989619896euoutp02e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1750064985;
	bh=Z0yVDNlBuUeI2U5G9pnG88sUo+3LU8vld6YvrIkhECY=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=NJjjWtuiH8rQP1rLO+Qn29ldm7aH/ChlGrzo5voO7FGEzkE4eRwYtrAghrMJ1qEdP
	 pYXMDPXEvc2SPnERO/SvJoRqMWNMp9pPt5+Fk5/14cuWB2tFCkCnyX/0IA0ziX3vRw
	 E3glhShhovdXx4zJ4e/ZUFX1+Bhtz2spsF/SNLmQ=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250616090944eucas1p1ffc6fcf91024df239946d55f78cd73ab~JetTDE54A2755827558eucas1p16;
	Mon, 16 Jun 2025 09:09:44 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250616090943eusmtip1582353473f82f3f625b89a1041e9e149~JetR4HUmp2738727387eusmtip1M;
	Mon, 16 Jun 2025 09:09:43 +0000 (GMT)
Message-ID: <9765c970-55cc-4413-9fd0-5e0cdfa900fa@samsung.com>
Date: Mon, 16 Jun 2025 11:09:42 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 8/8] drm/imagination: Enable PowerVR driver for
 RISC-V
To: kernel test robot <lkp@intel.com>, Drew Fustini <drew@pdp7.com>, Guo Ren
	<guoren@kernel.org>, Fu Wei <wefu@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Philipp Zabel
	<p.zabel@pengutronix.de>, Frank Binns <frank.binns@imgtec.com>, Matt Coster
	<matt.coster@imgtec.com>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>, Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>, Ulf Hansson <ulf.hansson@linaro.org>, Marek
	Szyprowski <m.szyprowski@samsung.com>
Cc: Paul Gazzillo <paul@pgazz.com>, Necip Fazil Yildiran
	<fazilyildiran@gmail.com>, oe-kbuild-all@lists.linux.dev,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <202506151839.IKkZs0Z0-lkp@intel.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20250616090944eucas1p1ffc6fcf91024df239946d55f78cd73ab
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250615105256eucas1p21dba29a1450757d9201b2a9c7f0e34e8
X-EPHeader: CA
X-CMS-RootMailID: 20250615105256eucas1p21dba29a1450757d9201b2a9c7f0e34e8
References: <20250614-apr_14_for_sending-v4-8-8e3945c819cd@samsung.com>
	<CGME20250615105256eucas1p21dba29a1450757d9201b2a9c7f0e34e8@eucas1p2.samsung.com>
	<202506151839.IKkZs0Z0-lkp@intel.com>



On 6/15/25 12:51, kernel test robot wrote:
> Hi Michal,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on 4774cfe3543abb8ee98089f535e28ebfd45b975a]
> 
> url:    https://protect2.fireeye.com/v1/url?k=6c3bc994-0cd954c9-6c3a42db-000babd9f1ba-30c2378fa012fc4a&q=1&e=c39c960c-4d5f-44d7-aed7-0097394dfc81&u=https%3A%2F%2Fgithub.com%2Fintel-lab-lkp%2Flinux%2Fcommits%2FMichal-Wilczynski%2Fpower-sequencing-Add-T-HEAD-TH1520-GPU-power-sequencer-driver%2F20250615-021142
> base:   4774cfe3543abb8ee98089f535e28ebfd45b975a
> patch link:    https://lore.kernel.org/r/20250614-apr_14_for_sending-v4-8-8e3945c819cd%40samsung.com
> patch subject: [PATCH v4 8/8] drm/imagination: Enable PowerVR driver for RISC-V
> config: riscv-kismet-CONFIG_DRM_GEM_SHMEM_HELPER-CONFIG_DRM_POWERVR-0-0 (https://download.01.org/0day-ci/archive/20250615/202506151839.IKkZs0Z0-lkp@intel.com/config)
> reproduce: (https://download.01.org/0day-ci/archive/20250615/202506151839.IKkZs0Z0-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202506151839.IKkZs0Z0-lkp@intel.com/
> 
> kismet warnings: (new ones prefixed by >>)
>>> kismet: WARNING: unmet direct dependencies detected for DRM_GEM_SHMEM_HELPER when selected by DRM_POWERVR
>    WARNING: unmet direct dependencies detected for DRM_GEM_SHMEM_HELPER
>      Depends on [n]: HAS_IOMEM [=y] && DRM [=y] && MMU [=n]

I believe this is triggered because RISC-V can be compiled without MMU
support, while MMU support is mandatory for ARM64.

Would an acceptable fix be to require an explicit dependency on the MMU,
like so?

depends on (ARM64 || RISCV) && MMU

>      Selected by [y]:
>      - DRM_POWERVR [=y] && HAS_IOMEM [=y] && (ARM64 || RISCV [=y]) && DRM [=y] && PM [=y]
> 

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>


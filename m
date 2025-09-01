Return-Path: <linux-pm+bounces-33558-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47EA3B3E1A9
	for <lists+linux-pm@lfdr.de>; Mon,  1 Sep 2025 13:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1675E16255B
	for <lists+linux-pm@lfdr.de>; Mon,  1 Sep 2025 11:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1EC313E04;
	Mon,  1 Sep 2025 11:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b="tBCPJPoX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com [91.207.212.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6866B311C36;
	Mon,  1 Sep 2025 11:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756726492; cv=none; b=e1tLhnf++zil8LxGm04Vs4lKx9IZ6xD8h6/DrMpFYpWQT7z18oeZnUtDZUXNdhksorEAN9tQxis6rfWp68Cal+fck1m5xpwnrS1qHT92D+JWjlFHQrN1eOB6xYWRRcEW1jmwHyWuCKNZKLta4iRGdnRPh2j2fiSuPCJ0VRSlGlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756726492; c=relaxed/simple;
	bh=0EJNdtu8nyDG2IwtIGaxakRKpSqhc7ICFEwLsxeLihI=;
	h=From:To:CC:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=Y/Ir6jf+RMtU3cyU7EGNfD3/nMs6NCrhdLiZFLXXyzBNxyf/Rzasqzuh8MxJN7OwXNpuIY1n/TwoFtN0bZyN93l9H8wyEtho65dGaNsJUeojEv0EgKQtywlNJDZA7+SZ95FpTpxYD+prv4c0F5jPnxvv5buvGCuaFFtJZVlkZc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com; spf=pass smtp.mailfrom=imgtec.com; dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b=tBCPJPoX; arc=none smtp.client-ip=91.207.212.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=imgtec.com
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
	by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 581ApSHi2099410;
	Mon, 1 Sep 2025 12:13:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=dk201812; bh=t
	AFEklxgsmVWSK/QKd8QoRpUQX6Iez4Vk2aeQzBVMZM=; b=tBCPJPoXg/b9Anwmt
	FcW+Hj7snDC1F3fWqCcnfInrA5R3ui0B2LCeDfyySeDDR7kQcV+xZRa8p2Mh0NCm
	9lsKQRDmTGTkuo/+VLHfnZBgI7cAzGwYj/24Jumw+A+/LIIKrEXGmaVeYameEZu/
	pEAb5ertMAapQ+l4syswTmP2qo0ecIDRUHrU4Nu7pvG9acvYXN0Ob4asi6de7MDC
	/I8D3Dr5IVXgJeGzstRrS2gg+c3++JflcOby5/EGIEugS5t1QS7Ph4xBh0qhhruy
	qu+lAU/ysnshlZ4t6E6BLjHaI8kUPbe+6mGQrAehmBYttv9pwmom0XmBBspE1Rx2
	c95DQ==
Received: from hhmail05.hh.imgtec.org (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
	by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 48uqjpsq2k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 01 Sep 2025 12:13:33 +0100 (BST)
Received: from
 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa
 (172.25.8.78) by HHMAIL05.hh.imgtec.org (10.100.10.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.57; Mon, 1 Sep 2025 12:13:32 +0100
From: Matt Coster <matt.coster@imgtec.com>
To: Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Philipp Zabel
	<p.zabel@pengutronix.de>,
        Frank Binns <frank.binns@imgtec.com>,
        "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard
	<mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Paul Walmsley
	<paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou
	<aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
        Ulf Hansson
	<ulf.hansson@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "Drew
 Fustini" <fustini@kernel.org>,
        Michal Wilczynski <m.wilczynski@samsung.com>
CC: <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>,
        Bartosz Golaszewski
	<bartosz.golaszewski@linaro.org>
In-Reply-To: <20250822-apr_14_for_sending-v13-0-af656f7cc6c3@samsung.com>
References: <CGME20250821222019eucas1p1d429a24720a0fa07928a5e8b364b728a@eucas1p1.samsung.com>
 <20250822-apr_14_for_sending-v13-0-af656f7cc6c3@samsung.com>
Subject: Re: (subset) [PATCH v13 0/4] Add TH1520 GPU support with power
 sequencing
Message-ID: <175672521205.30950.2944854121832397083.b4-ty@imgtec.com>
Date: Mon, 1 Sep 2025 12:13:32 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-EXCLAIMER-MD-CONFIG: 15a78312-3e47-46eb-9010-2e54d84a9631
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAxMDExOSBTYWx0ZWRfX0r3PDOJ35OAn
 8WU46pj//wREe7b09TNlb6UbD5ABvOgswiwkQWqd1+reRHoD96EPWz9r8jJF7y9aCzqq3Tcvibv
 v4Vs1oqbS+RbcaGB5v+WB8enIF4POvgaqpn9a6T+OzReVirnyQSWyslL1QhPGYb00KrRyQihvEe
 C88jUxxlb4b7MjSf50FwYr6HvzaCXotwzHZWTzzutGApkIrDX+8Jh+z3qDqWvAieMio33pgG+A3
 UtFzL6lH/w1KOGEjsih5ZI0wY/WluGjPBHwXK68DRt0USqGv+OQRwjoULPtrSslD6r4v67oFJX+
 WoC20St4TQ8vgaxUoYOFIawfh854MB0/aAkEwbAw9qB1wBu51wtLvc8NVZK3Ls=
X-Authority-Analysis: v=2.4 cv=VL3dn8PX c=1 sm=1 tr=0 ts=68b57fdd cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=frXF02aS0WsA:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=r_1tXGB3AAAA:8
 a=Iq_RHiLCETW0UDbuoI8A:9 a=QEXdDO2ut3YA:10 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-ORIG-GUID: HHQ6d2eOQoef4UfDWeIyZTD88_rHX_E9
X-Proofpoint-GUID: HHQ6d2eOQoef4UfDWeIyZTD88_rHX_E9


On Fri, 22 Aug 2025 00:20:14 +0200, Michal Wilczynski wrote:
> This patch series introduces support for the Imagination IMG BXM-4-64
> GPU found on the T-HEAD TH1520 SoC. A key aspect of this support is
> managing the GPU's complex power-up and power-down sequence, which
> involves multiple clocks and resets.
> 
> The TH1520 GPU requires a specific sequence to be followed for its
> clocks and resets to ensure correct operation. Initial discussions and
> an earlier version of this series explored managing this via the generic
> power domain (genpd) framework. However, following further discussions
> with kernel maintainers [1], the approach has been reworked to utilize
> the dedicated power sequencing (pwrseq) framework.
> 
> [...]

Applied, thanks!

[1/4] drm/imagination: Use pwrseq for TH1520 GPU power management
      commit: e38e8391f30b41c5a24bb46dc6ef4161921e782d
[2/4] dt-bindings: gpu: img,powervr-rogue: Add TH1520 GPU support
      commit: 337ebfda8a4f2627bf52e200cacf6f3a2f5ccf48
[4/4] drm/imagination: Enable PowerVR driver for RISC-V
      commit: 6b53cf48d9339c75fa51927b0a67d8a6751066bd

Best regards,
-- 
Matt Coster <matt.coster@imgtec.com>



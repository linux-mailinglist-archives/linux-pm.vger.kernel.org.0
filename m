Return-Path: <linux-pm+bounces-28046-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45178ACCCE2
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jun 2025 20:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1395C173AB7
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jun 2025 18:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE789288C32;
	Tue,  3 Jun 2025 18:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="X9e2hQff"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C8D288C1E
	for <linux-pm@vger.kernel.org>; Tue,  3 Jun 2025 18:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748975186; cv=none; b=AQ2MzaE3rcaE2WpmxDDo4VxqATwEsqV4JwhRN4G8rf1E8XAT1D1abHzvU+3Gh4JaSZOutASZHrJTnPmvQQpopF5OQq2zAiyEm3QfK0zA4mg9KJKnYji0TTgBPP2Ea4MctmoAr735FTyb1W/GvcOOAJiS0MzFT4wpqLElnVkIYXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748975186; c=relaxed/simple;
	bh=oe6xJ8BnfZaumhjQk1NyeDNFhfsFblmvprmbedJHhvo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=XMF7RRK8D1VUBNFn0kE78r+vQnQZA0rQ9wBk1/TXCYXpXh608mYWXA3ymI9IBhm3uq/W7Wthn9P5NaSlmLm8LdORQ+qPqFyv1l6G2FjZun2V3LlYa+mXmhKodsaoSQa5ovFDuAldBQjtzKNde3tbshANxFkohJeLakkqMkWGK7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=X9e2hQff; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250603182623euoutp029f070bc746dabaad831e96882ec943a7~Fm6nCkAFW0560205602euoutp02T
	for <linux-pm@vger.kernel.org>; Tue,  3 Jun 2025 18:26:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250603182623euoutp029f070bc746dabaad831e96882ec943a7~Fm6nCkAFW0560205602euoutp02T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1748975183;
	bh=HsAkslRZ/mz8R7VriYKhtD3qm8Kb4EqG51Yi+AM4RuA=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=X9e2hQffXHlcBs3dfvPvkQrLggEYJTsmAe+8+QAKfAamU06ubnEV3bIyL+D4ltPox
	 G4DGPvC1TvwssjozwyIWtxDrvwoOZnLmXqA2zBrImFqWErLhwCm1c8+tlnMXkSp8Jl
	 dK/QZHYAI/ksP+kLCq2xD1j916KCBl/QXiJHhxe4=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250603182622eucas1p20957d890c72a4bb63dc75d022c0ff0a5~Fm6mRz4zH1760017600eucas1p2B;
	Tue,  3 Jun 2025 18:26:22 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250603182621eusmtip2f45e802a2c7fce8fbe1d6462a0bb7a75~Fm6lQK_r50715807158eusmtip2Q;
	Tue,  3 Jun 2025 18:26:21 +0000 (GMT)
Message-ID: <a9233f51-6f2d-42a2-ad70-20e3f2890683@samsung.com>
Date: Tue, 3 Jun 2025 20:26:21 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/8] riscv: dts: thead: th1520: Add missing reset
 controller header include
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>, Fu Wei
	<wefu@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Bartosz
	Golaszewski <brgl@bgdev.pl>, Philipp Zabel <p.zabel@pengutronix.de>, Frank
	Binns <frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
	<mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Paul Walmsley
	<paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Ulf Hansson
	<ulf.hansson@linaro.org>, Marek Szyprowski <m.szyprowski@samsung.com>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <20250603-tactful-valiant-mackerel-bfb6be@kuoka>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20250603182622eucas1p20957d890c72a4bb63dc75d022c0ff0a5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250529222407eucas1p233be883d7e84e5a000e4d44b37cf7265
X-EPHeader: CA
X-CMS-RootMailID: 20250529222407eucas1p233be883d7e84e5a000e4d44b37cf7265
References: <20250530-apr_14_for_sending-v3-0-83d5744d997c@samsung.com>
	<CGME20250529222407eucas1p233be883d7e84e5a000e4d44b37cf7265@eucas1p2.samsung.com>
	<20250530-apr_14_for_sending-v3-5-83d5744d997c@samsung.com>
	<20250603-tactful-valiant-mackerel-bfb6be@kuoka>



On 6/3/25 15:20, Krzysztof Kozlowski wrote:
> On Fri, May 30, 2025 at 12:23:52AM GMT, Michal Wilczynski wrote:
>> TH1520_RESET_ID_GPU_CLKGEN and TH1520_RESET_ID_GPU are required for GPU
>> power sequencing to work.  To make these symbols available, add the
>> necessary include for the T-HEAD TH1520 reset controller bindings.
> 
> How would it compile/build without it? If there are no users, then do
> not add unused header just to add it.

The patch 7 in the series need it, so I've added the header.

> 
> Best regards,
> Krzysztof
> 
> 

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>


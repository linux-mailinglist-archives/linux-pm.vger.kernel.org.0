Return-Path: <linux-pm+bounces-28651-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 338B4AD886B
	for <lists+linux-pm@lfdr.de>; Fri, 13 Jun 2025 11:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD2D516F1B5
	for <lists+linux-pm@lfdr.de>; Fri, 13 Jun 2025 09:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B20291C2F;
	Fri, 13 Jun 2025 09:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="KeXXtrQr"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDC81C84B9
	for <linux-pm@vger.kernel.org>; Fri, 13 Jun 2025 09:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749808184; cv=none; b=czQybZQKjdpZ4WAvEOE7BfMds++tmEvtyWa4GWj2qKnYQevDPwCuHqsFd0oN3y8umQKgkl9yg6s52P0+n18lSbA1uqYuMVfStZ25/Rl9d3aRtJ7RGsr52RqeibuvY8y+3nFnqBMjF5s4Cq9bKtzsBPaHyHUbIFkqAznV5B4Drs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749808184; c=relaxed/simple;
	bh=E9g4iKJ+yCKvXWA3cSjWNe7gwUJseaOGz0cRtZ/FmX0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:In-Reply-To:
	 Content-Type:References; b=Hpzd0kUlBPxWMG+atYakJb19+aFkYIemVtHZNsiKzmHnklrmavvzEa9tvGu7evFBnjmXJjC/enQwBH9HKgnPORQCo0qm2TzPfy4mrqWvOD9ruklwf6hL7S/DB2O1SUlwn1lUEuo9lcQKYjQHiZczRXGvuJmyZGxP6QgcWyEmGKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=KeXXtrQr; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250613094940euoutp018796f35552839e8e9b1702241a856e71~IkUTUXUu41980019800euoutp01V
	for <linux-pm@vger.kernel.org>; Fri, 13 Jun 2025 09:49:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250613094940euoutp018796f35552839e8e9b1702241a856e71~IkUTUXUu41980019800euoutp01V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1749808180;
	bh=kh1WI/bcozY1n6lzmehL+B2GaHGpJodSvRw79/7fyDs=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=KeXXtrQrpOo9k9DvNiYd5/p0RN5OETv7UZnLk2u/rgXrUymIm52y9w85Yr7XC/g/t
	 ol8m6jQ7WrEMV/OQwyzA/v6GLEdTz9UB5OCdWztyv53RRzBRZfI8K3/IbkePmcs9Ki
	 WK165kGbRXZvrbmDLUIR30Nzoczywx3Q9x0rfURw=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250613094939eucas1p223e7a49c4cdbbfbeb66f81b1c4d38a64~IkUS23hRn0145001450eucas1p26;
	Fri, 13 Jun 2025 09:49:39 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250613094938eusmtip1d772fb1eb26491c3a808b58eca12daed~IkURy2A162383923839eusmtip1j;
	Fri, 13 Jun 2025 09:49:38 +0000 (GMT)
Message-ID: <44090712-0635-47bf-b73d-d9b16ec446a4@samsung.com>
Date: Fri, 13 Jun 2025 11:49:38 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/8] drm/imagination: Use pwrseq for TH1520 GPU power
 management
From: Michal Wilczynski <m.wilczynski@samsung.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Bartosz Golaszewski
	<brgl@bgdev.pl>, Matt Coster <matt.coster@imgtec.com>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>
Cc: Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>, Fu Wei
	<wefu@redhat.com>, Rob Herring <robh@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Frank Binns
	<frank.binns@imgtec.com>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>, Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>, Ulf Hansson <ulf.hansson@linaro.org>, Marek
	Szyprowski <m.szyprowski@samsung.com>, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Language: en-US
In-Reply-To: <e5d3d3b3-7ada-476f-9558-328d3d316088@samsung.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20250613094939eucas1p223e7a49c4cdbbfbeb66f81b1c4d38a64
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250529222405eucas1p18ed1254bf1b2d78468734656fec537e1
X-EPHeader: CA
X-CMS-RootMailID: 20250529222405eucas1p18ed1254bf1b2d78468734656fec537e1
References: <20250530-apr_14_for_sending-v3-0-83d5744d997c@samsung.com>
	<CGME20250529222405eucas1p18ed1254bf1b2d78468734656fec537e1@eucas1p1.samsung.com>
	<20250530-apr_14_for_sending-v3-3-83d5744d997c@samsung.com>
	<20250603-whispering-jaybird-of-thunder-f87867@kuoka>
	<d42a8c49-7ad2-49ef-bd9c-1e3d9981b58e@samsung.com>
	<e5a0bee2-ff74-47cf-ad2c-0c78b57ae6cf@kernel.org>
	<a6a29e58-8613-47f0-9e5c-d125da7ddb49@samsung.com>
	<cc4dbf7c-e023-403c-88be-4691f97a0ff0@kernel.org>
	<c7774790-07c3-469d-a994-9e84108ad21d@samsung.com>
	<CAMRc=Mexq9ThfG6jZUbs3wYDA9UZN-+pHnX_Y-7WO4ubXvEuCw@mail.gmail.com>
	<ad6981eb-f53a-4a7b-90bd-2e2705bd0297@samsung.com>
	<59cc6827-1602-402a-9279-96ad6285cff4@kernel.org>
	<e5d3d3b3-7ada-476f-9558-328d3d316088@samsung.com>



On 6/13/25 10:25, Michal Wilczynski wrote:
> 
> 
> On 6/13/25 08:44, Krzysztof Kozlowski wrote:
>> On 11/06/2025 14:01, Michal Wilczynski wrote:
>>>
>>> However, this leads me back to a fundamental issue with the
>>> consumer side implementation in the generic pvr_device.c driver. The
>>> current fallback code is:
>>>
>>> /*
>>>  * If the error is -EPROBE_DEFER, it's because the
>>>  * optional sequencer provider is not present
>>>  * and it's safe to fall back on manual power-up.
>>>  */
>>> if (pwrseq_err == -EPROBE_DEFER)
>>>         pvr_dev->pwrseq = NULL;
>>>
>>> As Krzysztof noted, simply ignoring -EPROBE_DEFER is not ideal. But if I
>>> change this to a standard deferred probe, the pvr_device.c driver will
>>
>> Why? You have specific compatible for executing such quirks only for
>> given platform.

I realized now that you may have meant the "thead,th1520-gpu" compatible,
not the "thead,th1520" SoC compatible.

In any case, the whole reason for using the pwrseq framework is to avoid
polluting the generic driver with SoC specific logic and instead offload
that responsibility to a pwrseq provider. Therefore, I can't simply add
a check like if (compatible == "thead,th1520-gpu") to the generic driver
to decide whether to get a power sequencer. This entire matching
responsibility was intended to be offloaded to the pwrseq framework.

> 
> This is due to how the pwrseq API works; it constructs a bus on which
> provider devices may appear at any time. With the current API, there is
> no way to express that a provider for a specific target will never
> appear. ('gpu-power' is the generic target name, and of course, more
> specific binding is handled in the provider's .match callback - based on
> the compatible and the node phandle like discussed previously).
> 
> For all other supported SoCs, no such provider will ever appear on the
> bus, and the current pwrseq API doesn't allow a generic consumer to know
> this.
> 
> However, your suggestion of handling this with a platform specific
> driver is a good path forward. It would still require a minimal addition
> to the pwrseq API to work. For example, a new SoC specific driver for
> "thead,th1520" could call a new function like
> pwrseq_enable_optional_target("gpu-power") during its probe. This would
> signal to the pwrseq core that this target is expected on the platform.
> Therefore, when the Imagination driver later calls pwrseq_get() on a
> TH1520, it would correctly result in either a match or a deferral.
> 
> On all other platforms, this optional target would not be enabled. The
> pwrseq_get() call would then immediately return -ENODEV instead of
> deferring, which solves the problem and allows the other supported SoCs
> to probe correctly.
> 
> I wonder whether Bartosz would be okay with such an addition.
> 
>>
>>> break on all other supported SoCs. It would wait indefinitely for a
>>> pwrseq-thead-gpu provider that will never appear on those platforms.
>>>
>>
>>
>>
>> Best regards,
>> Krzysztof
>>
> 
> Best regards,

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>


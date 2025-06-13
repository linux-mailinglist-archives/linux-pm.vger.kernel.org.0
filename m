Return-Path: <linux-pm+bounces-28635-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91259AD858C
	for <lists+linux-pm@lfdr.de>; Fri, 13 Jun 2025 10:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04E7C7B137B
	for <lists+linux-pm@lfdr.de>; Fri, 13 Jun 2025 08:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4352727F3;
	Fri, 13 Jun 2025 08:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="hQTSVmz3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D732727EE
	for <linux-pm@vger.kernel.org>; Fri, 13 Jun 2025 08:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749803149; cv=none; b=ol4Qtxh561pA5SZlU1pkw4q+rFf1M4z44K8b/PlRLnovwnc7YcOmnnsdjYoqmg/DXO/XKsmJl4XLdai4GAh7dfQcNgwrX5ybQbA9Tnpz92nBrk1kc8CYnc+aI3jODz73uHPOzBSZ1FktTNsI9taXgOHR6WPnn2T/N2NF9w0muZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749803149; c=relaxed/simple;
	bh=cX3yW1RHLGbcArCJf9n6aJS1EPQDINCtfh+k5tXO+9U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=L6NjwuGFcGtMXGwvIq+cMQrwLi2JhdumCp6PnmbTXs9RDBRMXvwu8BdRI67IKu/EqpQOGTPc3hj8ZbVREQOaQcID3+BpRhgCTCbezBcFFvBHwXUu+2E7NfErafaS4d5A1HzqE6kQkpOHs5AvNAc6T6OqeRonpJxUww3B33mlJEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=hQTSVmz3; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250613082540euoutp0147c291618d86a32b80a425a06512041f~IjK9zFauC1828918289euoutp01b
	for <linux-pm@vger.kernel.org>; Fri, 13 Jun 2025 08:25:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250613082540euoutp0147c291618d86a32b80a425a06512041f~IjK9zFauC1828918289euoutp01b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1749803140;
	bh=I8IkmX2ltxLIkn/+l8073UC2Q+m47Csc2VhEngKEE7U=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=hQTSVmz3gpTinUPWOUdrn22NBzGwzqG9vLblhR6fqYlgPSJdOhjspCRG2jRa516Uw
	 0O2rtvOD54U2FdOREeIqa8IHz0nM5Ton4y2y7sB4XdAcrq2xrO2d7Ejthw5XftV4cq
	 ukCDeWAMy8dvO08ZUAiCgYZFkzfapAkyVDY8MdxQ=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250613082539eucas1p2b5a99e3e2413e78710bd36303e839cf8~IjK9Fl0ni1345813458eucas1p27;
	Fri, 13 Jun 2025 08:25:39 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250613082538eusmtip2583bf59103d68afb613b87f12210c74b~IjK8C5sOg0843108431eusmtip2D;
	Fri, 13 Jun 2025 08:25:38 +0000 (GMT)
Message-ID: <e5d3d3b3-7ada-476f-9558-328d3d316088@samsung.com>
Date: Fri, 13 Jun 2025 10:25:38 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/8] drm/imagination: Use pwrseq for TH1520 GPU power
 management
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
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <59cc6827-1602-402a-9279-96ad6285cff4@kernel.org>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20250613082539eucas1p2b5a99e3e2413e78710bd36303e839cf8
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



On 6/13/25 08:44, Krzysztof Kozlowski wrote:
> On 11/06/2025 14:01, Michal Wilczynski wrote:
>>
>> However, this leads me back to a fundamental issue with the
>> consumer side implementation in the generic pvr_device.c driver. The
>> current fallback code is:
>>
>> /*
>>  * If the error is -EPROBE_DEFER, it's because the
>>  * optional sequencer provider is not present
>>  * and it's safe to fall back on manual power-up.
>>  */
>> if (pwrseq_err == -EPROBE_DEFER)
>>         pvr_dev->pwrseq = NULL;
>>
>> As Krzysztof noted, simply ignoring -EPROBE_DEFER is not ideal. But if I
>> change this to a standard deferred probe, the pvr_device.c driver will
> 
> Why? You have specific compatible for executing such quirks only for
> given platform.

This is due to how the pwrseq API works; it constructs a bus on which
provider devices may appear at any time. With the current API, there is
no way to express that a provider for a specific target will never
appear. ('gpu-power' is the generic target name, and of course, more
specific binding is handled in the provider's .match callback - based on
the compatible and the node phandle like discussed previously).

For all other supported SoCs, no such provider will ever appear on the
bus, and the current pwrseq API doesn't allow a generic consumer to know
this.

However, your suggestion of handling this with a platform specific
driver is a good path forward. It would still require a minimal addition
to the pwrseq API to work. For example, a new SoC specific driver for
"thead,th1520" could call a new function like
pwrseq_enable_optional_target("gpu-power") during its probe. This would
signal to the pwrseq core that this target is expected on the platform.
Therefore, when the Imagination driver later calls pwrseq_get() on a
TH1520, it would correctly result in either a match or a deferral.

On all other platforms, this optional target would not be enabled. The
pwrseq_get() call would then immediately return -ENODEV instead of
deferring, which solves the problem and allows the other supported SoCs
to probe correctly.

I wonder whether Bartosz would be okay with such an addition.

> 
>> break on all other supported SoCs. It would wait indefinitely for a
>> pwrseq-thead-gpu provider that will never appear on those platforms.
>>
> 
> 
> 
> Best regards,
> Krzysztof
> 

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>


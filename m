Return-Path: <linux-pm+bounces-29510-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8414AE8529
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 15:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 446D23BCF1C
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 13:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4C1262FDE;
	Wed, 25 Jun 2025 13:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="HQu6sHKv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F2145945
	for <linux-pm@vger.kernel.org>; Wed, 25 Jun 2025 13:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750859373; cv=none; b=oETGK+Ku6AThK62w3XXbqeKBMLZZMift+cEnD9tqQzNw1vWPi2hVcOgAnXq5rw2YHXhBW/qIgp7bAR+0TgA7Qigs1lbg0F0mNmbjys/2NzTTU7dPk1baNN4mtXHz70Eg/lE+udAUOOaBbt+SVhIJXh/zadRwHYBE4j4pOnRZx3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750859373; c=relaxed/simple;
	bh=Ez3h2hcedkCPo5tU5X3TK6D6K7FlG6mpkgJxcG02l30=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=WNzq6pXyskugkueKfScPmC5P9IGnk8yGjewGgvT179h90/65z70kleM2r8B5Nb3DxoHQIemXTBPyiMYhfVRzBIkSB3pa93VH6/ZOfjkMWyGgpIBH96fMUQMiemWYmxtZa+8bxUlJ1vSC+me3OSbI/eptPDUFuQfGYsJVSXJ/VRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=HQu6sHKv; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250625134929euoutp0110d3cbf2baf30874b3def37580a948f6~MTVH0ncZe2162221622euoutp01o
	for <linux-pm@vger.kernel.org>; Wed, 25 Jun 2025 13:49:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250625134929euoutp0110d3cbf2baf30874b3def37580a948f6~MTVH0ncZe2162221622euoutp01o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1750859369;
	bh=jet5Z3oHYs+Jf13HfgUgZVZFfowNJyNZZd5QLwXLsCI=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=HQu6sHKvhjbMr5lVaeA2ReHrbImqud2jLsnzmbuml9ACbzaa475kFfb4bRZhxtkjP
	 wfTM9ksJ1g/EW7ECpOw0oD8J4CkvTPk35uwYRm2pD5qresCgjM2Ah9dhritgHugYhV
	 7hcnLuPtoyD8WqwSCzTGcorGSLk89uvlduamNDPk=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250625134928eucas1p20116c6f28849c9efd79be3d1c9f83e6d~MTVG8cjqV2648326483eucas1p2s;
	Wed, 25 Jun 2025 13:49:28 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250625134927eusmtip15bc8d3e11211e663cc281314615c3b89~MTVF7n4xZ1371313713eusmtip1E;
	Wed, 25 Jun 2025 13:49:27 +0000 (GMT)
Message-ID: <4e2e770a-0b94-4c73-a98d-ce14c3e3c364@samsung.com>
Date: Wed, 25 Jun 2025 15:49:27 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/8] drm/imagination: Use pwrseq for TH1520 GPU power
 management
To: Matt Coster <Matt.Coster@imgtec.com>
Cc: Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>, Fu Wei
	<wefu@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Bartosz
	Golaszewski <brgl@bgdev.pl>, Philipp Zabel <p.zabel@pengutronix.de>, Frank
	Binns <Frank.Binns@imgtec.com>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>, Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>, Ulf Hansson <ulf.hansson@linaro.org>, Marek
	Szyprowski <m.szyprowski@samsung.com>, Bartosz Golaszewski
	<bartosz.golaszewski@linaro.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <a265a20e-8908-40d8-b4e0-2c8b8f773742@imgtec.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20250625134928eucas1p20116c6f28849c9efd79be3d1c9f83e6d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250623114433eucas1p1659c22d6696f3eb51d4169eee80b7cb2
X-EPHeader: CA
X-CMS-RootMailID: 20250623114433eucas1p1659c22d6696f3eb51d4169eee80b7cb2
References: <20250623-apr_14_for_sending-v6-0-6583ce0f6c25@samsung.com>
	<CGME20250623114433eucas1p1659c22d6696f3eb51d4169eee80b7cb2@eucas1p1.samsung.com>
	<20250623-apr_14_for_sending-v6-4-6583ce0f6c25@samsung.com>
	<a265a20e-8908-40d8-b4e0-2c8b8f773742@imgtec.com>



On 6/24/25 15:53, Matt Coster wrote:
> On 23/06/2025 12:42, Michal Wilczynski wrote:
>> Update the Imagination PVR DRM driver to leverage the pwrseq framework
>> for managing the power sequence of the GPU on the T-HEAD TH1520 SoC.
>>
>> To cleanly handle the TH1520's specific power requirements in the
>> generic driver, this patch implements the "driver match data" pattern.
>> The pvr_soc_data struct, associated with a compatible string in the
>> of_device_id table, now holds pointers to platform-specific power_on and
>> power_off functions.
>>
>> At probe time, the driver inspects the assigned power_on function
>> pointer. If it points to the pwrseq variant, the driver calls
>> devm_pwrseq_get("gpu-power"), requiring a valid sequencer and deferring
>> probe on failure. Otherwise, it falls back to its standard manual reset
>> initialization.
>>
>> The runtime PM callbacks, pvr_power_device_resume() and
>> pvr_power_device_suspend(), call the power_on and power_off function
>> pointers. Helper functions for both manual and pwrseq-based sequences
>> are introduced to support this.
> 
> Hi Michal,
> 
> My apologies for not responding to previous revisions of this series. In
> general, my main earlier complaints were already addressed by others and
> the series generally looks good to me.
> 
> Just a few notes from me in this and subsequent patches.
> 
>>

Thanks for the feedback.

I will send an updated revision based on the linux-next and skip patches
that have already been applied to Ulf's and Bartosz's trees.

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>


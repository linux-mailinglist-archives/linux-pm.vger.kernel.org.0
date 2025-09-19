Return-Path: <linux-pm+bounces-35016-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E90AAB87DBE
	for <lists+linux-pm@lfdr.de>; Fri, 19 Sep 2025 06:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D84C11C8267D
	for <lists+linux-pm@lfdr.de>; Fri, 19 Sep 2025 04:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7AF26E16A;
	Fri, 19 Sep 2025 04:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b1kfQhR2"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5D310957;
	Fri, 19 Sep 2025 04:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758256141; cv=none; b=W21esT2hQozHbsplVE0LbGfbvKuL3FWu3XE9MZ1ITyyhBvPGTxJNRJoKHEvqMkQnN+yn76Qs/IMua1A5GV0hJSDf8mupksGWhzLsbibGq9hMB0plDFlHSP0fxCmfx3xJYAG2X2Edir9+tu7U+X/9mJeJ+yw+1D8S8PnoVbqsx+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758256141; c=relaxed/simple;
	bh=BPmNRDunTtPkrxCpxbQ/GYyrPJg/8IsQ3qWIqttlIo8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SEjTDErP/WKE8q/w4MSuBerL1r5xrcghpyq9amjBzQpCM5G1cMyZv2xPRlT0SWeVPK2AypEycht2eeHmBxTOH87cdbsPEqamMcl8f/BZhmLC1M1N5SlzVrqyVqj69iI8PaHsDKkTL5JdB57nxCGWld0i0y6kQv0dIQdqwhBvRjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b1kfQhR2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EC7BC4CEF0;
	Fri, 19 Sep 2025 04:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758256141;
	bh=BPmNRDunTtPkrxCpxbQ/GYyrPJg/8IsQ3qWIqttlIo8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=b1kfQhR287O7htaKiXuIZMmrxDm/ASTPAwE4Bb/3Zho/A2vZ/2MJzN/k/2YZF7IRd
	 WA41uB53cxwSE7r5aAjuoxiUGlSG/g7qCJ2TcTR8N9/PqJa6omkHLOvlHR4RwGLpwi
	 fJJtKutSm0kjypZvURtd7e6lj6MbibZOP2sIX3s38hDGk4FOCaTDdhv1xIrkqw8VjU
	 VJtCGGxk2qzH1PR3cz2Ct3WVMK0rdaefBU5hypwLWUgz8HhPv3QqymA8tbxS96N9r4
	 ps/ai0d1EMVECAH3WQVBOAbqlZOxPeqDIASj5SCB8ZMmz/AqKoH61ZkTK7CBDKBTt4
	 16J4FKOikaJpA==
Message-ID: <c210de74-6eb5-40a4-b87d-a4a5c3123e65@kernel.org>
Date: Fri, 19 Sep 2025 13:28:54 +0900
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/10] dt-bindings: gpu: mali-valhall-csf: add
 mediatek,mt8196-mali variant
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, MyungJoo Ham <myungjoo.ham@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>, Jassi Brar <jassisinghbrar@gmail.com>,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Chia-I Wu <olvaffe@gmail.com>, Chen-Yu Tsai <wenst@chromium.org>,
 kernel@collabora.com, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-pm@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20250917-mt8196-gpufreq-v3-0-c4ede4b4399e@collabora.com>
 <20250917-mt8196-gpufreq-v3-1-c4ede4b4399e@collabora.com>
 <20250918-festive-chowchow-of-joy-5a51de@kuoka>
 <5749727.31r3eYUQgx@workhorse>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <5749727.31r3eYUQgx@workhorse>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/09/2025 23:01, Nicolas Frattaroli wrote:
> On Thursday, 18 September 2025 02:30:09 Central European Summer Time Krzysztof Kozlowski wrote:
>> On Wed, Sep 17, 2025 at 02:22:32PM +0200, Nicolas Frattaroli wrote:
>>> The Mali-based GPU on the MediaTek MT8196 SoC uses a separate MCU to
>>> control the power and frequency of the GPU.
>>>
>>> It lets us omit the OPP tables from the device tree, as those can now be
>>> enumerated at runtime from the MCU. It also means the mali GPU node
>>> described in this binding does not have any clocks in this case, as all
>>> clock control is delegated to the MCU.
>>>
>>> Add the mediatek,mt8196-mali compatible, and a performance-domains
>>> property which points to the MCU's device tree node in this case. It's
>>> required on mt8196 devices.
>>>
>>> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
>>> ---
>>>  .../bindings/gpu/arm,mali-valhall-csf.yaml         | 32 ++++++++++++++++++++--
>>>  1 file changed, 30 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
>>> index 7ad5a3ffc5f5c753322eda9e74cc65de89d11c73..ccab2dd0ea852187e3ab75923e19739622b2b3b8 100644
>>> --- a/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
>>> +++ b/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
>>> @@ -38,7 +38,6 @@ properties:
>>>        - const: gpu
>>>  
>>>    clocks:
>>> -    minItems: 1
>>
>> I don't understand why.
>>
>> Best regards,
>> Krzysztof
>>
>>
> 
> I am executing a Convex hull algorithm on the 3D space of "dt-bindings
> maintainer opinions" to get a convex hull of acceptable dt-bindings
> choices where two different choices are functionally equivalent.
> 
> With this additional opinion on the krzk axis, I now know that having
> the base properties accurate for the general case is not required if
> the per-compatible case sets the property to false anyway.
> 
> I hope no two opinions are collinear, as this would surely be my
> undoing.
> 
> You get to pick which axis (X, Y, Z) you are. Right-hand rule, of
> course.


This piece of code is wrong and I could not deduce the reason. That's
why I asked why you need that change. If you intend to waste my time, I
will don't bother with this, but code is still wrong.

Best regards,
Krzysztof


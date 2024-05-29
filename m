Return-Path: <linux-pm+bounces-8358-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7BC8D35FB
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2024 14:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14D11287F68
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2024 12:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2568180A83;
	Wed, 29 May 2024 12:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="YZhTN61t"
X-Original-To: linux-pm@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DB97317C;
	Wed, 29 May 2024 12:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716984377; cv=none; b=RP9E/14aCt3EjpRD8wyK+4aEZmdHcWt/ffhRJboHLlGdBiw4Ft+1MWY7jazKXc8TKgzFMC6CkbkjhukYygmydbLBAbuvQlyfjA7BiT3APFgxz/M4cSPOjLhP9/YmXKwEOViiE75x8Gj/GoyCqODwlTbXy5QNvqyT+NM6ppVY9sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716984377; c=relaxed/simple;
	bh=Kam7GlrgaXVFK23XrEQCDs7nyWMWsFNSiXp7twV37rk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wlt3prJ1YVURHP8zKMfmOlJnhwOC7YXciWSDsf03bJWYpiXlCPeAxpRogs0iTwq8DIwhhldqSZVuFz69uoqT6wLwZKyIiC79sS6+Gj0qPpxmJuw4n6luklc+p0PKv53sFNPbYJ6WV0x2kjRCdPfL7TVljltI5nR9+siH50Wt2lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=YZhTN61t; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1716984373;
	bh=Kam7GlrgaXVFK23XrEQCDs7nyWMWsFNSiXp7twV37rk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YZhTN61tKJzQX2QRKsKJdg0qMXjNOgIKplP84ePEYUqM/Vzyo+YLquJ3+JKPqGczB
	 HoulKRjZSwvmt5Rz3qazylvOEk+kXQns6p/icwwKZuURhfchSdXTFW/PcayaDFCI17
	 EBj0vvpfOFsZz/g6VIB9d4otAOk1mJ3396Q+lpP+IIA8Mf4XawXWH08ozY9fT1VJRI
	 jGiPhijsyo0ij+lC9ZnVS886LAYZz5XScl1pVAYGZYjt7tl5FXycHU0S/DXlJ3OIhe
	 GmFCVOShbR4r5lIwoiRrV1wKkYRWmKVEebiTtNsGaXTGt9Uj0HFuf4dugAZGkEGYa2
	 a8ReS6O0g27Bw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E2C45378216D;
	Wed, 29 May 2024 12:06:12 +0000 (UTC)
Message-ID: <ad047631-16b8-42ce-8a8d-1429e6af4517@collabora.com>
Date: Wed, 29 May 2024 14:06:12 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/6] arm64: dts: mediatek: mt8186: add default thermal
 zones
To: Julien Panis <jpanis@baylibre.com>, Chen-Yu Tsai <wenst@chromium.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Nicolas Pitre <npitre@baylibre.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>
References: <20240529-mtk-thermal-mt818x-dtsi-v6-0-0c71478a9c37@baylibre.com>
 <20240529-mtk-thermal-mt818x-dtsi-v6-4-0c71478a9c37@baylibre.com>
 <75826085-fd59-466a-b1de-b4c323c801c1@collabora.com>
 <CAGXv+5FPG4ob3mTU0Utm8Wgk0_ZLw=NLPbfFerWh4OUeAz7UHw@mail.gmail.com>
 <808db317-4cee-426b-a840-013a5e03098d@baylibre.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <808db317-4cee-426b-a840-013a5e03098d@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 29/05/24 11:12, Julien Panis ha scritto:
> On 5/29/24 10:33, Chen-Yu Tsai wrote:
>> On Wed, May 29, 2024 at 4:17 PM AngeloGioacchino Del Regno
>> <angelogioacchino.delregno@collabora.com> wrote:
>>> Il 29/05/24 07:57, Julien Panis ha scritto:
>>>> From: Nicolas Pitre <npitre@baylibre.com>
>>>>
>>>> Inspired by the vendor kernel but adapted to the upstream thermal
>>>> driver version.
>>>>
>>>> Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
>>>> Signed-off-by: Julien Panis <jpanis@baylibre.com>
>>> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> I'm getting some crazy readings which would cause the machine to
>> immediately shutdown during boot. Anyone else see this? Or maybe
>> my device has bad calibration data?
>>
>> gpu_thermal-virtual-0
>> Adapter: Virtual device
>> temp1:       +229.7 C
>>
>> nna_thermal-virtual-0
>> Adapter: Virtual device
>> temp1:       +229.7 C
>>
>> cpu_big0_thermal-virtual-0
>> Adapter: Virtual device
>> temp1:         -7.2 C
>>
>> cpu_little2_thermal-virtual-0
>> Adapter: Virtual device
>> temp1:       +157.2 C
>>
>> cpu_little0_thermal-virtual-0
>> Adapter: Virtual device
>> temp1:       -277.1 C
>>
>> adsp_thermal-virtual-0
>> Adapter: Virtual device
>> temp1:       +229.7 C
>>
>> cpu_big1_thermal-virtual-0
>> Adapter: Virtual device
>> temp1:       +229.7 C
>>
>> cam_thermal-virtual-0
>> Adapter: Virtual device
>> temp1:        +45.4 C
>>
>> cpu_little1_thermal-virtual-0
>> Adapter: Virtual device
>> temp1:       -241.8 C
> 
> It's likely that your device has bad calibration data indeed. We observed the same
> behavior on the mt8186 device we used (a Corsola) and finally realized that the
> golden temperature was 0 (device not properly calibrated).
> 
> To make a comparison, we run chromiumos v5.15 and dmesg output was:
> 'This sample is not calibrated, fake !!'
> Additional debugging revealed that the golden temp was actually 0. As a result,
> chromiumos v5.15 does not use the calibration data. It uses some default values
> instead. That's why you can observe good temperatures with chromiumos v5.15
> even with a device that is not calibrated.
> 
> This feature is not implemented in the driver upstream, so you need a device
> properly calibrated to get good temperatures with it. When we forced this
> driver using the default values used by chromiumos v5.15 instead of real calib
> data (temporarily, just for testing), the temperatures were good.
> 
> Please make sure your device is properly calibrated: 0 < golden temp < 62.
> 

Wait wait wait wait.

What's up with that calibration data stuff?

If there's any device that cannot use the calibration data, we need a way to
recognize whether the provided data (read from efuse, of course) is valid,
otherwise we're creating an important regression here.

"This device is unlucky" is not a good reason to have this kind of regression.

Since - as far as I understand - downstream can recognize that, upstream should
do the same.
I'd be okay with refusing to even probe this driver on such devices for the
moment being, as those are things that could be eventually handled on a second
part series, even though I would prefer a kind of on-the-fly calibration or
anyway something that would still make the unlucky ones to actually have good
readings *right now*.

Though, the fact that you assert that you observed this behavior on one of your
devices and *still decided to send that upstream* is, in my opinion, unacceptable.

Regards,
Angelo


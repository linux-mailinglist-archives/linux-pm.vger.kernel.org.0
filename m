Return-Path: <linux-pm+bounces-18132-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 051B99D99BC
	for <lists+linux-pm@lfdr.de>; Tue, 26 Nov 2024 15:38:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B80616481D
	for <lists+linux-pm@lfdr.de>; Tue, 26 Nov 2024 14:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1B01D5ABD;
	Tue, 26 Nov 2024 14:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="TR/uIIj4"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72EEBE46;
	Tue, 26 Nov 2024 14:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732631904; cv=none; b=RDb9HLhA1GsBDOapGG2aOfES9hpiKUjtDqOPpxfmMYbvrfD/EW+pGnaFecFMT4FJ2uq8OT2MGkWgBrM8no3AzHIuAHvDKdcgJnbAw4D8jl8NA+k0VBMIiilPft/BWHBUQrxWKxhEcQHV6VQk8dC4JDyFE4XITe3zS5fMKwlKzPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732631904; c=relaxed/simple;
	bh=8Q1AcMcf5bN33C57m/nCjesoaMvJRbyawLtQBBaJQHc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GKMtd4YIEoN6GxzCdOfQ2r9BwyoKzG+HJ4lCcffHQ16HPH3CNRe7yA270JJ7fkJqk8fs3cO7wHyOAi4mv/I6SgQy46223zUtL2ta7p0PpsxI2a6PfrwpULIci2TLMJNlW79AmHkH1fz9D4v3BacEFApsCbGlFRH2zsMMnDzj2WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=TR/uIIj4; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1732631900;
	bh=8Q1AcMcf5bN33C57m/nCjesoaMvJRbyawLtQBBaJQHc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TR/uIIj4aPO+RBacPBM9FcapHcX41FEZgrbEqtTwAyzqURqx5F0iiOiD9uuIqsmG6
	 NTYBhC+nKWwFN88ypAKZL24CCPVsJhisICghwQRXAHOkK07XD9LQMFyhINBDaY2V6h
	 Vr0bkuhyZwoL0Ffc9CULQUD/oGilB8cT7hEKFrq9ueMMRgjdjqt5M7WOPRlo5KXBzR
	 LOGnSGHDFrFW2Ko6oLeHyKJSGDrzeUxr+YoyTFLzDM/e3Pjwxxkj1DXIEHNOej4fAN
	 1ETAeDTpKvJ5+0qMYwSS7Qpo66S2rNwhr7y/zcQQ9CeM38jdzvxJ+EwMXZ0NUG6j/E
	 2mOiLI+5Bm03A==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id DEB1E17E36C7;
	Tue, 26 Nov 2024 15:38:19 +0100 (CET)
Message-ID: <142b0767-6033-4cf4-9a90-11592c8786df@collabora.com>
Date: Tue, 26 Nov 2024 15:38:19 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] thermal/drivers/mediatek/lvts: Disable monitor mode
 during suspend
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Matthias Brugger
 <matthias.bgg@gmail.com>, Alexandre Mergnat <amergnat@baylibre.com>,
 Balsam CHIHI <bchihi@baylibre.com>, kernel@collabora.com,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Hsin-Te Yuan <yuanhsinte@chromium.org>, Chen-Yu Tsai <wenst@chromium.org>,
 =?UTF-8?Q?Bernhard_Rosenkr=C3=A4nzer?= <bero@baylibre.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, stable@vger.kernel.org
References: <20241125-mt8192-lvts-filtered-suspend-fix-v1-0-42e3c0528c6c@collabora.com>
 <20241125-mt8192-lvts-filtered-suspend-fix-v1-1-42e3c0528c6c@collabora.com>
 <600f9d78-bdc8-4133-bb43-06d798bcd543@collabora.com>
 <e3e9020b-f3d5-42bb-bf1e-6aa8da2d1708@notapiano>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <e3e9020b-f3d5-42bb-bf1e-6aa8da2d1708@notapiano>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 26/11/24 14:19, Nícolas F. R. A. Prado ha scritto:
> On Tue, Nov 26, 2024 at 10:43:55AM +0100, AngeloGioacchino Del Regno wrote:
>> Il 25/11/24 22:20, Nícolas F. R. A. Prado ha scritto:
>>> When configured in filtered mode, the LVTS thermal controller will
>>> monitor the temperature from the sensors and trigger an interrupt once a
>>> thermal threshold is crossed.
>>>
>>> Currently this is true even during suspend and resume. The problem with
>>> that is that when enabling the internal clock of the LVTS controller in
>>> lvts_ctrl_set_enable() during resume, the temperature reading can glitch
>>> and appear much higher than the real one, resulting in a spurious
>>> interrupt getting generated.
>>>
>>> Disable the temperature monitoring and give some time for the signals to
>>> stabilize during suspend in order to prevent such spurious interrupts.
>>>
>>> Cc: stable@vger.kernel.org
>>> Reported-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
>>> Closes: https://lore.kernel.org/all/20241108-lvts-v1-1-eee339c6ca20@chromium.org/
>>> Fixes: 8137bb90600d ("thermal/drivers/mediatek/lvts_thermal: Add suspend and resume")
>>> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
>>> ---
>>>    drivers/thermal/mediatek/lvts_thermal.c | 36 +++++++++++++++++++++++++++++++--
>>>    1 file changed, 34 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
>>> index 1997e91bb3be94a3059db619238aa5787edc7675..a92ff2325c40704adc537af6995b34f93c3b0650 100644
>>> --- a/drivers/thermal/mediatek/lvts_thermal.c
>>> +++ b/drivers/thermal/mediatek/lvts_thermal.c
>>> @@ -860,6 +860,32 @@ static int lvts_ctrl_init(struct device *dev, struct lvts_domain *lvts_td,
>>>    	return 0;
>>>    }
>>> +static void lvts_ctrl_monitor_enable(struct device *dev, struct lvts_ctrl *lvts_ctrl, bool enable)
>>> +{
>>> +	/*
>>> +	 * Bitmaps to enable each sensor on filtered mode in the MONCTL0
>>> +	 * register.
>>> +	 */
>>> +	u32 sensor_filt_bitmap[] = { BIT(0), BIT(1), BIT(2), BIT(3) };
>>> +	u32 sensor_map = 0;
>>> +	int i;
>>> +
>>> +	if (lvts_ctrl->mode != LVTS_MSR_FILTERED_MODE)
>>> +		return;
>>> +
>>
>> That's easier and shorter:
>>
>> static void lvts_ctrl_monitor_enable( .... )
>> {
>> 	/* Bitmap to enable each sensor on filtered mode in the MONCTL0 register */
>> 	const u32 sensor_map = GENMASK(3, 0);
>>
>> 	if (lvts_ctrl->mode != LVTS_MSR_FILTERED_MODE)
>> 		return;
>>
>> 	/* Bits 0-3: Sensing points - Bit 9: Single point access flow */
>> 	if (enable)
>> 		writel(sensor_map | BIT(9), LVTS_MONCTL0(lvts_ctrl->base));
> 
> Wait, no, here you're enabling all the sensors in the controller. We only want
> to enable ones that are valid, otherwise we might get garbage data and irqs from
> sensors that aren't actually there. That's why I use the
> lvts_for_each_valid_sensor() helper in this patch.
> 

Whoa, my brain actually missed the lvts_for_each_valid_sensor()!

Okay no, then you're right - sorry for the bad example! In that case, though, I
still have one more comment.

You can constify sensor_filt_bitmap, and since the values never go higher than
BIT(3), you should also be able to spare some memory by turning that into a u8:

	const u8 sensor_filt_bitmap[] = { BIT(0), BIT(1), BIT(2), BIT(3) };

...and then I assume that there's no way valid sensors could ever read from an
index that is more than 4 (so, I assume that there's no way the loop tries to
read out of the array upper boundary).

In which case - after at least constifying the sensor_filt_bitmap array, for v2
feel free to add my

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

...and sorry again for the initial miss :-)

Cheers,
Angelo



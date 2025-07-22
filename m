Return-Path: <linux-pm+bounces-31274-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA2CB0D74E
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jul 2025 12:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 693297A6214
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jul 2025 10:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D909F28A1F3;
	Tue, 22 Jul 2025 10:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="VbF9q9TM"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37CE19DF62;
	Tue, 22 Jul 2025 10:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753180063; cv=none; b=RFCalp/v4WRXFSLxImmJ0hWZ8xMWvPmH6u6VTR29Y2K0rgV4SfBdIZtbt1ys0dzi8kmWcBGFG5RqokwURcnBlxkBdy7rlV03YDp99MOAAgggZbaZ4R9RrMblicmpKfgN9wV1OH4qxrx4iRdHOnaOsFxyEYfIQnfEPtk3DHCX+G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753180063; c=relaxed/simple;
	bh=9lvqZk5oEPRo1rY1fpzcNNUqnPMnD9A+snxT1q84jkE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ATFADbsPYEdT5zyQ4DdUMw35+HuhLIVNvHQIzhOvXnmtL0KRZjM1ZeVa17ysVxDRpfO3IXIzJK2XhvmJYTzrgaZhh25RL0sJTGto8TOrb4dHT43Q44lWUGmRxGCuSWE0lqFHHaQM1Ok9x4dC0pWv14BDD8vnZhtEWZxECQhHQd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=VbF9q9TM; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1753180059;
	bh=9lvqZk5oEPRo1rY1fpzcNNUqnPMnD9A+snxT1q84jkE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VbF9q9TM9iU5hikHWxzeBS6I11iDTIJOgU24E63elkGQegue9c0JhTAJ64AMaQX91
	 LfvBCXWbCmcQ6rTHckq5/Ld2LjTmbe5O1xUuFFYuRKNPcJNHE3ZCTQr4R4oe13qFk2
	 m/jl1fSN6S4AMSwjUZCIHefXhHByPwoss4CSd/zKWxdHZalC4vravkj+OgSE+8ivrU
	 o0sCRzh90Wsg0wrJ/W5PPBuOYIB/awoXdlHIHXhZIrmFgM+ep1IlCf1+zCKe+b/9ZK
	 dAH/Nvdfdth3BURdamdHwCG+Ze+mkU/0p2zEnS3gMd7bC9K3tV/4EgufCeWCLOaot8
	 SbYbUbwvRHngQ==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:bd9c:eae9:88b0:783c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 804F217E0B72;
	Tue, 22 Jul 2025 12:27:38 +0200 (CEST)
From: Laura Nao <laura.nao@collabora.com>
To: wenst@chromium.org
Cc: andrew-ct.chen@mediatek.com,
	angelogioacchino.delregno@collabora.com,
	arnd@arndb.de,
	bchihi@baylibre.com,
	colin.i.king@gmail.com,
	conor+dt@kernel.org,
	daniel.lezcano@linaro.org,
	devicetree@vger.kernel.org,
	kernel@collabora.com,
	krzk+dt@kernel.org,
	lala.lin@mediatek.com,
	laura.nao@collabora.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-pm@vger.kernel.org,
	lukasz.luba@arm.com,
	matthias.bgg@gmail.com,
	nfraprado@collabora.com,
	rafael@kernel.org,
	robh@kernel.org,
	rui.zhang@intel.com,
	srini@kernel.org,
	u.kleine-koenig@baylibre.com
Subject: Re: [PATCH 5/9] thermal/drivers/mediatek/lvts: Add lvts_temp_to_raw variant for positive temp_factor
Date: Tue, 22 Jul 2025 12:26:53 +0200
Message-Id: <20250722102653.30851-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <CAGXv+5F9NwJ7uGFPWZM-Dywbbk4f6aiYS5M4m6_VFETVGEwr9A@mail.gmail.com>
References: <CAGXv+5F9NwJ7uGFPWZM-Dywbbk4f6aiYS5M4m6_VFETVGEwr9A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/21/25 13:12, Chen-Yu Tsai wrote:
> On Mon, Jul 21, 2025 at 4:31 PM Laura Nao <laura.nao@collabora.com> wrote:
>>
>> The current lvts_temp_to_raw() implementation assumes a negative
>> temperature-to-raw slope (temp_factor), which holds for the SoCs
>> currently supported by the driver. However, this assumption breaks on
>> MT8196/MT6991, where the slope is positive.
>
> I don't think that's really a problem. The formula is:
>
>     temp = (raw * factor) >> 14 + golden
>
> If we move the terms around we get
>
>     ((temp - golden) << 14) / factor = raw
>
> Or
>
>     raw = ((golden - temp) << 14) / -factor
>
>
> The calculations should work regardless of whether the factor is positive
> or negative, as long as the intermediate and final values are within
> the range of s64.
>
>> Add a variant of the function that inverts the calculation logic
>> accordingly. This ensures accurate raw value generation for temperature
>> thresholds,avoiding spurious thermal interrupts or unintended hardware
>> resets on MT8196/MT6991.
>>
>> Signed-off-by: Laura Nao <laura.nao@collabora.com>
>> ---
>>  drivers/thermal/mediatek/lvts_thermal.c | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
>> index db83137c7537..3c34956e37c1 100644
>> --- a/drivers/thermal/mediatek/lvts_thermal.c
>> +++ b/drivers/thermal/mediatek/lvts_thermal.c
>> @@ -296,6 +296,18 @@ static u32 lvts_temp_to_raw(int temperature, int temp_factor)
>>         return div_s64(raw_temp, -temp_factor);
>>  }
>>
>> +static u32 lvts_temp_to_raw_v2(int temperature, int temp_factor)
>> +{
>> +       u32 raw_temp;
>> +
>> +       if (temp_factor == 0)
>> +               return temperature;
>> +
>> +       raw_temp = temperature - golden_temp_offset;
>> +
>> +       return div_s64((s64)temp_factor << 14, raw_temp);
>> +}
>
> Here you have
>
>     raw = (factor << 14) / (temp - golden)
>
> which, barring integer arithmetic limitations, is actually the
> multiplicative inverse of the original version.
>
> So I think the commit message is misleading. It's not negative or
> positive that matters, but that the hardware expects the
> multiplicative inverse in this version.
>
> (or the downstream code is just botched.)
>

Right - the positive temp_factor on MT8196 is one distinction from older 
SoCs, and I initially assumed that was the reason a different conversion 
formula was needed. That assumption was partly based on the original 
lvts_temp_to_raw() implementation, which assigns 
((s64)(golden_temp_offset - temperature) << 14) to a u32, losing the 
sign when golden_temp_offset is negative. However, even correcting that 
to preserve the sign doesn't make the function work on MT8196 as it 
still requires using the multiplicative inverse form of the formula. 

I'll reword the commit message to clarify this.

Thanks!

Laura

> ChenYu
>
>> +
>>  static int lvts_get_temp(struct thermal_zone_device *tz, int *temp)
>>  {
>>         struct lvts_sensor *lvts_sensor = thermal_zone_device_priv(tz);
>> --
>> 2.39.5
>>
>>



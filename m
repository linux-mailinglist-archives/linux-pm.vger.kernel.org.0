Return-Path: <linux-pm+bounces-37968-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB43C5908E
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 18:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 00C7A4F63CF
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 16:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06C735A950;
	Thu, 13 Nov 2025 16:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="FXGx0vo5"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADD835A15E;
	Thu, 13 Nov 2025 16:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763050868; cv=none; b=IIxo5puebYFQkIv30DUM6WhzR4ITYviLQLPsl0JQRInXxvfK1QEZrncjEkw6oQUjGsVNi4+PoA2zmYYPmhXCABzBGYXORrlQUAyzGh6x7SyRz/At/rMUG0OIa+xpabP5N6fH2hJUe2hQ8l1RP89syrMszb5zG3JcJh9xk81yipg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763050868; c=relaxed/simple;
	bh=eBWGYbEPMSvsTZJWmtZWO1t79PMxcV429zFLf0WhYQw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kc6VD4UzMlKMjP4yw9RCxm/ZmFhi+SxLikIJmiCnSyxvgDPgzJb9P1arVq03t65PKCz0QMVOPAu8McGs/AFS3uO0QRnC/GvBcHqXNiDQGGKkf2qea5PLAj6QK+yKv9Hic20mWtNion0FD7k2MOS3tPTGUIcG9oELcJY0u3qdKnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=FXGx0vo5; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1763050864;
	bh=eBWGYbEPMSvsTZJWmtZWO1t79PMxcV429zFLf0WhYQw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FXGx0vo55dQWrQLSZ6T5FwniDgYI8sm4cMlr4ZHSh0vV2u9jFCJsdEcRIbc7Tqdhr
	 w/P4ldsvV+lsw6AGnXfWLgVu6XnFxaQ+J11rJiHgM8vE6bmEJs+AsfaIZUoYvZR8nh
	 T5c7GcM+bDwbbNxRvnwst2Dr0au4OntLx9K99s3uAMbmEuJt67dgU8iyTogu4ch3MD
	 xyYEPdMW+4+e4UgU7z0ppYQvxdtIv3Sx1eHwZFWIBZrSOv8GCYEIkyvJBVlS+ISK7F
	 uip+yMNGWz97aCboHz61ru3EoKCProh9B/a0t23QVRJyGwwYGsEqVNkAbiuhI5c4Wx
	 T2IyvBkxMAO/g==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:9cb8:f653:99e7:c419])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 97DB117E1341;
	Thu, 13 Nov 2025 17:21:03 +0100 (CET)
From: Laura Nao <laura.nao@collabora.com>
To: daniel.lezcano@linaro.org
Cc: andrew-ct.chen@mediatek.com,
	angelogioacchino.delregno@collabora.com,
	arnd@arndb.de,
	bchihi@baylibre.com,
	colin.i.king@gmail.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	frank-w@public-files.de,
	fshao@chromium.org,
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
Subject: Re: [PATCH RESEND v3 4/9] thermal: mediatek: lvts: Add platform ops to support alternative conversion logic
Date: Thu, 13 Nov 2025 17:20:53 +0100
Message-Id: <20251113162053.281093-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <1e0545da-5d24-4ca4-863d-0d5671902d0b@linaro.org>
References: <1e0545da-5d24-4ca4-863d-0d5671902d0b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Daniel,

On 11/10/25 14:06, Daniel Lezcano wrote:
> On 10/16/25 16:21, Laura Nao wrote:
>> Introduce lvts_platform_ops struct to support SoC-specific versions of
>> lvts_raw_to_temp() and lvts_temp_to_raw() conversion functions.
>>
>> This is in preparation for supporting SoCs like MT8196/MT6991, which
>> require a different lvts_temp_to_raw() implementation.
>>
>> Reviewed-by: Fei Shao <fshao@chromium.org>
>> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> Signed-off-by: Laura Nao <laura.nao@collabora.com>
>> ---
>>   drivers/thermal/mediatek/lvts_thermal.c | 27 ++++++++++++++++++++++---
>>   1 file changed, 24 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
>> index 4ef549386add..df1c0f059ad0 100644
>> --- a/drivers/thermal/mediatek/lvts_thermal.c
>> +++ b/drivers/thermal/mediatek/lvts_thermal.c
>> @@ -125,8 +125,14 @@ struct lvts_ctrl_data {
>>               continue; \
>>           else
>>   +struct lvts_platform_ops {
>> +    int (*lvts_raw_to_temp)(u32 raw_temp, int temp_factor);
>> +    u32 (*lvts_temp_to_raw)(int temperature, int temp_factor);
>> +};
>> +
>>   struct lvts_data {
>>       const struct lvts_ctrl_data *lvts_ctrl;
>> +    const struct lvts_platform_ops *ops;
>>       const u32 *conn_cmd;
>>       const u32 *init_cmd;
>>       int num_cal_offsets;
>> @@ -300,6 +306,7 @@ static int lvts_get_temp(struct thermal_zone_device *tz, int *temp)
>>       struct lvts_ctrl *lvts_ctrl = container_of(lvts_sensor, struct lvts_ctrl,
>>                              sensors[lvts_sensor->id]);
>>       const struct lvts_data *lvts_data = lvts_ctrl->lvts_data;
>> +    const struct lvts_platform_ops *ops = lvts_data->ops;
>>       void __iomem *msr = lvts_sensor->msr;
>>       u32 value;
>>       int rc;
>> @@ -332,7 +339,7 @@ static int lvts_get_temp(struct thermal_zone_device *tz, int *temp)
>>       if (rc)
>>           return -EAGAIN;
>>   -    *temp = lvts_raw_to_temp(value & 0xFFFF, lvts_data->temp_factor);
>> +    *temp = ops->lvts_raw_to_temp(value & 0xFFFF, lvts_data->temp_factor); 
>
> Don't do this in each functions. It does not help for the readability.
>
> May be something like:
>
> int lvts_raw_to_temp(u32 raw_temp, const struct lvts_ctrl_data)
> {
>     return data->ops->lvts_temp_to_raw(raw_temp, data->temp_factor);
> }
>
> or
>
> int lvts_raw_to_temp(u32 raw_temp, const struct lvts_ctrl_data)
> {
>     int temperature;
>
>     if (data->ops->lvts_temp_to_raw)
>         return data->ops->lvts_temp_to_raw(raw_temp, data->temp_factor);
>
>     temperature = ((s64)(raw_temp & 0xFFFF) * temp_factor) >> 14;
>         temperature += golden_temp_offset;
>
>         return temperature;
> }
>
> ... and get rid of all the lvts_platform_ops_v1
>
> (btw _v1 is confusing, it suggests there multiple versions of the same SoC)
>

Right, the first option looks more efficient. Since temp_offset is 
already part of lvts_data, the function would look like:

int lvts_raw_to_temp(u32 raw_temp, const struct lvts_data *lvts_data)
{
	return lvts_data->ops->lvts_raw_to_temp(raw_temp, lvts_data->temp_factor);
}

and the same pattern applies for temp_to_raw().

This change will require renaming the existing 
lvts_raw_to_temp()/lvts_temp_to_raw()/lvts_temp_to_raw_v2() 
implementations. I agree the current _v1 and _v2 suffixes aren’t very 
descriptive. Since lvts_temp_to_raw_v2() version is only used by MT8196,
it could be renamed to lvts_temp_to_raw_mt8196(), with the corresponding 
platform ops defined as lvts_platform_ops_mt8196. The base 
lvts_raw_to_temp()/lvts_temp_to_raw() are shared across the other SoCs,
so they could be renamed after the first supported platform (mt7988) and 
reused for all SoCs that share the same logic.

I'll send out a v4 with the proposed changes.

Thanks,

Laura

> [ ... ]
>



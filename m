Return-Path: <linux-pm+bounces-37967-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA8FC5910A
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 18:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1B34F4F0027
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 16:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D073596FC;
	Thu, 13 Nov 2025 16:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="L08N9R9H"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DEF3570C4;
	Thu, 13 Nov 2025 16:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763050753; cv=none; b=ZvLzWfCOswDFvfo7RefBcGQ3+khOhdSytBw52PH/SW81u1kBfS/UQZyERFqLmL4Q6B/UhdBYEq711wnZ/Sd0kbU+MIa7IhOIo/d6lU+dfPLPDeaNEMRVzSWn1HBcWR4ytza9Z0eu9ThjujkXlMrYTPiZEeWGCQ3ER/Ztj74KtnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763050753; c=relaxed/simple;
	bh=ZbbaaHUsQVLypoOUIIZkHe7iZlm+xeNap25LcZ0bsIk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kCp8b5QcevgzbQEEFQU7Ng+OKMvhRZe0RepumU84W8CrhaNVDnZUhKtoYILtJ4TMPncGktq+/BVYe45IUWStF1Z+RO5kF7L/35K/OIT1ZFJPdKjaI5JXZ5ynIhw6cPMnkXcn5zHdxbNrOWM4p6jroycmLgabMLKFv41JTiDidQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=L08N9R9H; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1763050749;
	bh=ZbbaaHUsQVLypoOUIIZkHe7iZlm+xeNap25LcZ0bsIk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L08N9R9H05FYgeI9He5wHagRWiiNK1wBzRiAIi1E0bwjHP0B2EawoC/wrhPwCN6Y5
	 jhuQHRwtEgVNqhy1K8RlbKaA6mevZjcmqSfVk09V1KBpkYqzapV1YnScBMrbOIYjOX
	 VO4RxYBGG1jvY89tItdFBj+QnC0NoujI7MTpkhy770bdBzoC53sQLi2f8D6yMnAv+L
	 XslBpTDc5Z4swz4lXyOEr3alCOFf9ZUXdjRUlAQxuWVXekfL64byL9cFcYkfNoWBly
	 iuaXggnvrQNWwSLGZXDdPxCELz6+ayfY5Rg8wYmCTxE7/qW4zGxeSh5vSq1nYDiIdg
	 60E/apd/bqVHA==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:9cb8:f653:99e7:c419])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B644117E00B0;
	Thu, 13 Nov 2025 17:19:07 +0100 (CET)
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
	u.kleine-koenig@baylibre.com,
	wenst@chromium.org
Subject: Re: [PATCH RESEND v3 3/9] thermal/drivers/mediatek/lvts: Guard against zero temp_factor in lvts_raw_to_temp
Date: Thu, 13 Nov 2025 17:18:59 +0100
Message-Id: <20251113161859.280743-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <84b9fd00-ce75-43bf-a53b-48818628f7e2@linaro.org>
References: <84b9fd00-ce75-43bf-a53b-48818628f7e2@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Daniel,

On 11/10/25 13:42, Daniel Lezcano wrote:
> On 10/16/25 16:21, Laura Nao wrote:
>> Add a guard against zero temp_factor in lvts_raw_to_temp() to prevent
>> division by zero and ensure safe conversion. 
>
> Is the temp_factor something else than a ro data statically initialized by the lvts_data structure ?
>
> It is pointless to handle the case where the temp_factor is zero. If we read the temperature the kernel crashes immediately (which means it was not tested).
>
> The temp_factor is an internal value of the driver. If the temp_factor is zero, the driver is buggy and should be fixed.
>
>

That’s right - if temp_factor is zero, that indicates broken platform 
data. I propose failing the probe instead of adding a runtime guard, 
since this condition should never happen in a valid configuration. This 
way, we make the developer aware of the issue early and avoid a kernel 
crash at runtime.

I'll send out a v4 to drop the "if (temp_factor == 0)" checks and 
replace the warning with an error:

if (!lvts_data->temp_factor)
	return dev_err_probe(dev, -EINVAL, "temp_factor should never be zero; check platform data.\n");

Best,

Laura

>> Fixes: 6725a29321e4 ("thermal/drivers/mediatek/lvts_thermal: Make coeff configurable")
>> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
>> Reviewed-by: Fei Shao <fshao@chromium.org>
>> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> Signed-off-by: Laura Nao <laura.nao@collabora.com>
>> ---
>>   drivers/thermal/mediatek/lvts_thermal.c | 12 +++++++++---
>>   1 file changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
>> index 1c54d0b75b1a..4ef549386add 100644
>> --- a/drivers/thermal/mediatek/lvts_thermal.c
>> +++ b/drivers/thermal/mediatek/lvts_thermal.c
>> @@ -284,11 +284,14 @@ static int lvts_raw_to_temp(u32 raw_temp, int temp_factor)
>>     static u32 lvts_temp_to_raw(int temperature, int temp_factor)
>>   {
>> -    u32 raw_temp = ((s64)(golden_temp_offset - temperature)) << 14;
>> +    u32 raw_temp;
>>   -    raw_temp = div_s64(raw_temp, -temp_factor);
>> +    if (temp_factor == 0)
>> +        return temperature;
>>   -    return raw_temp;
>> +    raw_temp = ((s64)(golden_temp_offset - temperature)) << 14;
>> +
>> +    return div_s64(raw_temp, -temp_factor);
>>   }
>>     static int lvts_get_temp(struct thermal_zone_device *tz, int *temp)
>> @@ -1346,6 +1349,9 @@ static int lvts_probe(struct platform_device *pdev)
>>       if (irq < 0)
>>           return irq;
>>   +    if (!lvts_data->temp_factor)
>> +        dev_warn(dev, "temp_factor should never be zero; check platform data.\n");
>> +
>>       golden_temp_offset = lvts_data->temp_offset;
>>         ret = lvts_domain_init(dev, lvts_td, lvts_data); 
> If
>
>
>
>
>



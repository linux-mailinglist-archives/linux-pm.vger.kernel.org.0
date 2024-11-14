Return-Path: <linux-pm+bounces-17558-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C13B9C8799
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2024 11:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2793D1F222FD
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2024 10:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D3A1F9A97;
	Thu, 14 Nov 2024 10:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="KmBePFOb"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E741F76D5;
	Thu, 14 Nov 2024 10:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731580115; cv=none; b=uhGd6zr0EcWsXfUDcvSSk0GLu+guIaHUH+CPsp0HuQXPKRTCRmcbE3cRZ593S9No8RsRZ67Jlmwet5an4EeQP6PQW6NF66UqkS+y/l8AWTtQn28/DWshFejfiwuiELDX19cTXZ21tNHVsVniQTK2g2kg5O/qY3elweGaKEC+OJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731580115; c=relaxed/simple;
	bh=jwgoRarckGp4IApZV/vwQhGXTbYx/T8btKhE/KN4R5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EaJGIIFpK4yHYErltgaZoUxJMKkM1sS7vAEpiEoQFtHmrBs8O7l+HbrloyG0n8BfiG4PUsU5tB8nD+U2ZiJUNwNb9X2fxGZ/KTR5t6POZvdh7JnTVw6p2tq3DoDSquWrCxX4A3pP5CL3Q38c09Ntb8wybfVe6K4CL9imlXZiNmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=KmBePFOb; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1731580111;
	bh=jwgoRarckGp4IApZV/vwQhGXTbYx/T8btKhE/KN4R5c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KmBePFObGzJgBODqO4RvBUcOJ3Ht5iDtLOxqgfoEDG5hoURFynp5E3MajsZ2TC7ps
	 rN03pIh0Ij7fD/1jernHXeJUZdHyjrc7zVGnvzrfw/TSxtYZEjvlhpKxJPgS+1J9Xq
	 4ILH3JweUJkbhrTeWaYhubsFiiIssUIEbrVzEr3EqRW5oBoftdrhDyBAisqQt3QwD+
	 rR18lOY1T3VHCa7B0H2qLA52bDaNm556QDJJqfQEVjb9n2gdTjjtXaPztTqYbDq0jv
	 tTEFuz0oUf1kqUc1KEKdOnN12bsFKS1WoRsTNeiczLV00cjjIR3VHZB6qEGD/X98A1
	 KlS0yuWkQtyBw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B1A1F17E35E0;
	Thu, 14 Nov 2024 11:28:30 +0100 (CET)
Message-ID: <6583e7a8-f4dd-4670-83dc-73ad4c5f208f@collabora.com>
Date: Thu, 14 Nov 2024 11:28:30 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal/drivers/mediatek/lvts_thermal: Switch to
 IMMEDIATE_MODE
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
 Hsin-Te Yuan <yuanhsinte@chromium.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Matthias Brugger
 <matthias.bgg@gmail.com>, =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?=
 <nfraprado@collabora.com>, Chen-Yu Tsai <wenst@chromium.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20241108-lvts-v1-1-eee339c6ca20@chromium.org>
 <02bbfb8c-817c-447a-92b9-bd03d76b66b1@linaro.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <02bbfb8c-817c-447a-92b9-bd03d76b66b1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 14/11/24 09:13, Daniel Lezcano ha scritto:
> On 08/11/2024 07:46, Hsin-Te Yuan wrote:
>> Currently, MT8192 cannot suspend with FILTERED_MODE. Switch to
>> IMMEDIATE_MODE will fix this.
> 
> Given the comments and the different changes related to the filtered and immediate 
> modes, I won't apply the patch until this is clearly sorted out.
> 

Thanks - indeed do not apply this for now.

If this has been broken for a year, one or two more weeks ain't gonna be a
show stopper, as long as we can come to a proper fix during that time, instead
of yet another compromise.

Anyway....

We discussed about that internally and we do suspect that there might be some
interrupt that is getting erroneously enabled, never handled, and constantly
firing because.. well, it was never handled, so... :-)

Nicolas is looking into this issue, and I really hope that we can come to a
conclusion that will make us switch back all of the SoCs to filtered mode
instead, as there indeed are some advantages in using that.

Cheers,
Angelo

>> Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
>> ---
>>   drivers/thermal/mediatek/lvts_thermal.c | 3 ---
>>   1 file changed, 3 deletions(-)
>>
>> diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/ 
>> lvts_thermal.c
>> index 
>> 1997e91bb3be94a3059db619238aa5787edc7675..daad52f14fc03d0c4131f2ffdf3eb6b49a4a43d0 100644
>> --- a/drivers/thermal/mediatek/lvts_thermal.c
>> +++ b/drivers/thermal/mediatek/lvts_thermal.c
>> @@ -1541,7 +1541,6 @@ static const struct lvts_ctrl_data 
>> mt8192_lvts_mcu_data_ctrl[] = {
>>           },
>>           VALID_SENSOR_MAP(1, 1, 0, 0),
>>           .offset = 0x0,
>> -        .mode = LVTS_MSR_FILTERED_MODE,
>>       },
>>       {
>>           .lvts_sensor = {
>> @@ -1552,7 +1551,6 @@ static const struct lvts_ctrl_data 
>> mt8192_lvts_mcu_data_ctrl[] = {
>>           },
>>           VALID_SENSOR_MAP(1, 1, 0, 0),
>>           .offset = 0x100,
>> -        .mode = LVTS_MSR_FILTERED_MODE,
>>       },
>>       {
>>           .lvts_sensor = {
>> @@ -1567,7 +1565,6 @@ static const struct lvts_ctrl_data 
>> mt8192_lvts_mcu_data_ctrl[] = {
>>           },
>>           VALID_SENSOR_MAP(1, 1, 1, 1),
>>           .offset = 0x200,
>> -        .mode = LVTS_MSR_FILTERED_MODE,
>>       }
>>   };
>>
>> ---
>> base-commit: 906bd684e4b1e517dd424a354744c5b0aebef8af
>> change-id: 20241108-lvts-f7beb36efc59
>>
>> Best regards,
> 
> 




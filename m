Return-Path: <linux-pm+bounces-31262-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D088B0D663
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jul 2025 11:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA2AE3B8E36
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jul 2025 09:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F86B2BF007;
	Tue, 22 Jul 2025 09:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="bOqivjtb"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A43F28C873;
	Tue, 22 Jul 2025 09:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753178321; cv=none; b=gbD0LfexgfGOaE8mkWqrmKKA3N0CB/+PVwe5vSjl/tw9/Q2xvOYjCRIkoNyIPajBEaMFf2d89dfHjH8+ZNF+p6ywkk5VfCyNxqOzpa6TfV4V1SqiXbpx3vK6TZzD1knY9wvpGe+uxLz1PWKQ+Qp3N7iK2s3i+XrLvmfurg3TQNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753178321; c=relaxed/simple;
	bh=2YDS8ULpwtubaxcIFjQWUJJwv1dOYUJ8pgeIv2TxAEE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DV9NGR4qRY3hkRO5G5m9cIZIWTBNENFkDiF4ceYwaSSyWAnQE3BSLp7viTdaX/HtzbUGcs3rDAi2Ks9uzco1Qw2Ur4iN5LCWcC7sLeaFsK77PJw01udmPlervmDnIzZQKNEF2AAPCahG6pnvQ4izNMXmDy0kHthFRqiHeOlceJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=bOqivjtb; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1753178317;
	bh=2YDS8ULpwtubaxcIFjQWUJJwv1dOYUJ8pgeIv2TxAEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bOqivjtbSPvFJU/luuT3nC2wdJoPQbFutJLxUorFDE0xn/p/JubZ4ViWojQlqL/MZ
	 7ITo4F4fHJC5XYll5zEjTUOWA1Vd+7AovoPNXpBp09d2z+LicgilB8z1rd4FJOK0dA
	 hrj+akHr8FzXjPnP9AYU1OUeBiVujbJBPGOezZmarQ7b1AsSb1W9J+hMMaJhMx4pOk
	 bQ/ddwSNgA+pE8mQ79+WrSeDT7/tzUGKUwiXECcrv93gVyyxzJSro8NlD+4EVU9WLB
	 tTCyHqYxyxX/+C1ulM6IUgk73dhhEx0Vqea+CC8MaXy/3AzA/3czJrzKShCeJPYtwV
	 QeAi0TKhgHWLw==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:bd9c:eae9:88b0:783c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id DC33D17E07FB;
	Tue, 22 Jul 2025 11:58:35 +0200 (CEST)
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
Subject: Re: [PATCH 3/9] thermal/drivers/mediatek/lvts: Guard against zero temp_factor in lvts_raw_to_temp
Date: Tue, 22 Jul 2025 11:57:52 +0200
Message-Id: <20250722095752.28245-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <CAGXv+5F51DiCHi_QPeDKOGCwvgM6HpmRjEjSgS8-mh=Fg1Fr5g@mail.gmail.com>
References: <CAGXv+5F51DiCHi_QPeDKOGCwvgM6HpmRjEjSgS8-mh=Fg1Fr5g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/21/25 12:08, Chen-Yu Tsai wrote:
> On Mon, Jul 21, 2025 at 4:26 PM Laura Nao <laura.nao@collabora.com> wrote:
>>
>> Add a guard against zero temp_factor in lvts_raw_to_temp() to prevent
>> division by zero and ensure safe conversion.
>>
>> Fixes: 6725a29321e4 ("thermal/drivers/mediatek/lvts_thermal: Make coeff configurable")
>> Signed-off-by: Laura Nao <laura.nao@collabora.com>
>
> Code wise,
>
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
>
> However I assume this would only happen with bad platform data? The
> factor should _never_ be zero. Maybe also issue a warning in the probe
> function?
>

Yes, this should only occur with incorrect platform data. Adding a
warning in the probe function sounds like a good idea to catch 
any misconfiguration early. I’ll include that in the next revision.

Thanks,

Laura

> ChenYu
>
>> ---
>>  drivers/thermal/mediatek/lvts_thermal.c | 9 ++++++---
>>  1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
>> index 8d5259b9d03b..b80c2929ae74 100644
>> --- a/drivers/thermal/mediatek/lvts_thermal.c
>> +++ b/drivers/thermal/mediatek/lvts_thermal.c
>> @@ -280,11 +280,14 @@ static int lvts_raw_to_temp(u32 raw_temp, int temp_factor)
>>
>>  static u32 lvts_temp_to_raw(int temperature, int temp_factor)
>>  {
>> -       u32 raw_temp = ((s64)(golden_temp_offset - temperature)) << 14;
>> +       u32 raw_temp;
>>
>> -       raw_temp = div_s64(raw_temp, -temp_factor);
>> +       if (temp_factor == 0)
>> +               return temperature;
>>
>> -       return raw_temp;
>> +       raw_temp = ((s64)(golden_temp_offset - temperature)) << 14;
>> +
>> +       return div_s64(raw_temp, -temp_factor);
>>  }
>>
>>  static int lvts_get_temp(struct thermal_zone_device *tz, int *temp)
>> --
>> 2.39.5
>>
>>



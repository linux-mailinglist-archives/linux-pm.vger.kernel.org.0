Return-Path: <linux-pm+bounces-38554-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79DE8C84A3C
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 12:09:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39D313A867D
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 11:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A8B3148DC;
	Tue, 25 Nov 2025 11:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="cBP91YTm"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F7130FF13;
	Tue, 25 Nov 2025 11:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764068943; cv=none; b=KRuy8uz49wpjYdAlsS+ecqOW7NAmW13+UJl/4v4XD3iGLYMy86RVYsIwSMSftNC2/zEgCOaL3FMFEXkXe6GeMiB0KG2r1KFL6Dj9Fl85xYR//ZAS3qCptbLq10PSjT4iv4jV9MLD6Y8hvckgmViGbUSsDpJTQzIlHlG0F+lpSp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764068943; c=relaxed/simple;
	bh=Ncc5CuNSCRB/UuJ5dRZNzT+XwsBAJ0RKRhvqese24KI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zet5AxhhpUfDx55LWETvBX35z8Bh4ceA/I4+/NjhDKRGRD+kACH9weWEwFLpjwhLc1k2D9/pS7swhwODp5Js7AdYmc2FaHNvydV0s6TPl0sbl6suTPUr8hkMwYsKiEuYWn11uy7eTiGyGALohLVtk8vsI0WVUXYhloNaGfdw1hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=cBP91YTm; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1764068939;
	bh=Ncc5CuNSCRB/UuJ5dRZNzT+XwsBAJ0RKRhvqese24KI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cBP91YTm3gUBT/0LvNQm69Cfb4fVet+PX86t57DJqyUtxyTZ4a2u+tCpDmHOXB+Tb
	 174vbUE/dw7ex+0Oum1XLHsL+QGlcncPNMCtxvqY75/7DOkds4dmglPP14Jkf9rvAe
	 KX9pfxlIaUSN4xZQjIU1F3fsqcDICDbwF7wDxbKYOPpbxIxmnzSdsXilUCxVS0Ywhf
	 U0SBTN3M5oCu1SFmbRWQdNa4DFO/xyHV7a6fnMOHRRlq6O+guJA1rm9r9FKkfw4AP8
	 li4Tta4VXB1ZG8DuxgI4wuXQ7t1haLBcIUUDhpUEBJnPdIecJmTFu7+9/BzYcmQC8+
	 hWM6+pEd9v5/Q==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:657b:ae76:a0f8:4811])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id BF03917E0AC3;
	Tue, 25 Nov 2025 12:08:57 +0100 (CET)
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
Subject: Re: [PATCH v4 3/9] thermal/drivers/mediatek/lvts: Fail probe if temp_factor is zero
Date: Tue, 25 Nov 2025 12:08:48 +0100
Message-Id: <20251125110848.23483-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <190003b6-2931-406a-a8f6-ec8909c65162@linaro.org>
References: <190003b6-2931-406a-a8f6-ec8909c65162@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 11/24/25 18:56, Daniel Lezcano wrote:
> On 11/21/25 12:16, Laura Nao wrote:
>> temp_factor is used in lvts_temp_to_raw() and lvts_raw_to_temp(). If
>> platform data is incorrect and temp_factor is zero, it could cause a
>> division by zero. Fail the probe early to prevent a kernel crash.
>>
>> Signed-off-by: Laura Nao <laura.nao@collabora.com>
>> ---
>>   drivers/thermal/mediatek/lvts_thermal.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
>> index 1c54d0b75b1a..b49441d82ffd 100644
>> --- a/drivers/thermal/mediatek/lvts_thermal.c
>> +++ b/drivers/thermal/mediatek/lvts_thermal.c
>> @@ -1346,6 +1346,11 @@ static int lvts_probe(struct platform_device *pdev)
>>       if (irq < 0)
>>           return irq;
>>   +    if (!lvts_data->temp_factor)
>> +        return dev_err_probe(
>> +            dev, -EINVAL,
>> +            "temp_factor should never be zero; check platform data.\n");
>> + 
>
> From my POV, this is not really useful. The temp_factor is set for each version statically in the code. The scope is limited to the driver, IOW it is not a parameter other subsystems passes to the driver.
>
> If it is NULL, then shame on the submitter who did not test the driver before sending ;)
>

Ack - I'll drop the patch in the next revision.

Thanks,

Laura


Return-Path: <linux-pm+bounces-38072-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 76879C5E966
	for <lists+linux-pm@lfdr.de>; Fri, 14 Nov 2025 18:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 03784366DD1
	for <lists+linux-pm@lfdr.de>; Fri, 14 Nov 2025 17:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422453358D5;
	Fri, 14 Nov 2025 17:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="oHHmuatK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mxout4.routing.net (mxout4.routing.net [134.0.28.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F67328B60;
	Fri, 14 Nov 2025 17:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763140381; cv=none; b=pMgm6C3zlWW4URTevGgGvkLF0tUt1S/nhe4Kntf9hH7aK6XqUkTFZZs2PFnin4wOPH687blZR+O+XGeMoTGIKqt0Xe0nn/+3PZW08K/rleDyFwy+HsXND0rFBfguia63ToKTkdRkEEcMdLiGWg0vzEjj7JdF8MLfW8jLO3vnz7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763140381; c=relaxed/simple;
	bh=6+t5damWptQvd4mAFUsqidFxcjEtQFVQMl5/CasN7Iw=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Wb+FISOlugGeyQ6E0Zib2tmUJ4nkSl63qhpAQukCgSip1XAohNEYdtHMUr/ynnvgxJR49D5gz8TzznMGnXfsHcI02MJn01bbpkkEARkZmyP+tyylFFnudkN/pPPwCYslLcaXr6tgq2gEfIAFV32QiVjhwXAEdCT3Nhj7Z6ZkW4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=oHHmuatK; arc=none smtp.client-ip=134.0.28.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbox1.masterlogin.de (unknown [192.168.10.88])
	by mxout4.routing.net (Postfix) with ESMTP id 250D1100387;
	Fri, 14 Nov 2025 17:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=routing; t=1763140370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zCRjBZyNz8BCs2Fp1Icrt4MQbgBntpN/nGDy1hv7Aqs=;
	b=oHHmuatKdvbjzw6oIV6h4eEaFhABMPYVxxahaWcYo3BF/Ez64tF/Xi0iQoiHQzdGNJ6ySh
	Kiab7PBvcmXymQSq3ROG9FP4nVUd9feOFDzsUIFQvEe6X7aahLcpGPOtJnd2feD4l+t8xc
	mG48oPbRNKzhVITJDdHToxk0B66Pr+0=
Received: from webmail.hosting.de (unknown [134.0.26.148])
	by mxbox1.masterlogin.de (Postfix) with ESMTPSA id 2601A40131;
	Fri, 14 Nov 2025 17:12:49 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 14 Nov 2025 18:12:49 +0100
From: "Frank Wunderlich (linux)" <linux@fw-web.de>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Daniel Golle <daniel@makrotopia.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano
 <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Lukasz Luba
 <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Mason Chang <mason-cw.chang@mediatek.com>, Frank
 Wunderlich <frank-w@public-files.de>, =?UTF-8?Q?N=C3=ADcolas_F=2E_R=2E?=
 =?UTF-8?Q?_A=2E_Prado?= <nfraprado@collabora.com>, =?UTF-8?Q?Uwe_Klein?=
 =?UTF-8?Q?e-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, Balsam CHIHI
 <bchihi@baylibre.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v1 1/5] dt-bindings: thermal: mediatek: make interrupt
 only required for current SoCs
In-Reply-To: <7a8bf2e9-5033-4588-923c-53ad23c12924@collabora.com>
References: <20251026122143.71100-1-linux@fw-web.de>
 <20251026122143.71100-2-linux@fw-web.de>
 <7a8bf2e9-5033-4588-923c-53ad23c12924@collabora.com>
Message-ID: <e31fcd9e9e5bb6e615eab98f73532dce@fw-web.de>
X-Sender: linux@fw-web.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Mail-ID: 55044b9e-28b6-4f7d-8091-aa83c7055f8b

Hi,

i got respoonse from MTK...

Am 2025-10-27 11:43, schrieb AngeloGioacchino Del Regno:
> Il 26/10/25 13:21, Frank Wunderlich ha scritto:
>> From: Frank Wunderlich <frank-w@public-files.de>
>> 
>> Upcoming MT7987 does not have a IRQ we have to make interrupt-property 
>> only
>> required for current supported SoCs.
> 
> Hmm. Thermal sensor IP with no interrupt? Looks really strange.
> 
> This is odd, because LVTS always has multiple interrupts, and if this 
> doesn't
> actually feature any, it really feels like the hardware is broken 
> somehow.
> 
> MediaTek, can you please confirm whether the LVTS IP in MT7987 is 
> really
> like that, or can you please give the right interrupt number to Frank?
> 

the reason why the interrupt is disabled on MT7988/87 is because the 
original designer only
intended for customers to use HW reset, and did not plan for customers 
to use high/low offset
interrupts. However, in theory, this function can work.

see this part of driver-patch (3/5 "Add no-irq-mode for mt7987")

handling is divided into two cases: one is high/low offset, and the 
other is HW reset.

-	writel(0, LVTS_MONINT(lvts_ctrl->base));
-
+	if (lvts_data->irq_enable) {
+		writel(0, LVTS_MONINT(lvts_ctrl->base));
+	} else {
+		writel(BIT(16), LVTS_PROTCTL(lvts_ctrl->base));
+		writel(lvts_ctrl->hw_reset_raw_temp, LVTS_PROTTC(lvts_ctrl->base));
+	}


HW Reset:
In BL2, we set the thermal_ctl_en (bit 16) of WDT_REQ_MODE (0x1001C030) 
to 1 so that the WDT
can receive the HW reset signal from LVTS.
We also set thermal_ctl_irq (bit 16) of WDT_REQ_IRQ_EN (0x1001C034) to 1 
so that when the WDT
receives the LVTS HW reset signal, it will directly reset the IC.
LVTSMONCTRL, LVTSPROTCTL, and LVTSPROTTC are used to control the HW 
reset strategy and temperature.

High/Low Offset:
Since multiple sensors share the high/low offset settings, the high/low 
offset temperature will be
set when we echo the temperature to thermal_zoneX/trip_point_X (call 
lvts_set_trips function).
Whenever any sensor's temperature is higher or lower than the high/low 
offset, it will trigger an
IRQ (call lvts_irq_handle).

Currently we are discussing a way to verify this function works in 
hardware and then we can add
IRQ for mt7987 (which is same as on mt7988 where i did not know till now 
that IRQ is not known as
working - just ported driver + dts and checked temperature output and 
thermal-trip handling
regarding to fan). And if it works we could drop patches for 
no-irq-mode.

> Thanks,
> Angelo

regards Frank


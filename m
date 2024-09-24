Return-Path: <linux-pm+bounces-14610-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B267F984417
	for <lists+linux-pm@lfdr.de>; Tue, 24 Sep 2024 13:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7095D28528E
	for <lists+linux-pm@lfdr.de>; Tue, 24 Sep 2024 11:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D681A4E84;
	Tue, 24 Sep 2024 11:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="DNY0fCI6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD3A19E98A;
	Tue, 24 Sep 2024 11:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727175645; cv=none; b=Lv0WiftMOWahKGLCIMA4YG4HxMTQZCVfNtt5xJdeCmLsPC7TcRy/bYOhXBB55fdCXbI6/XsyiLQf5NK4x9EmhzjuLB62MKyeoLNks/Vr24mZKqogCLS2pIWv8cqedWQnR5kffN+3tU4LBodWqzsOF6mPo8jKB6k100Zgq7TPxho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727175645; c=relaxed/simple;
	bh=fKljBB8vjhbKVE8igCkY1BV6u8AAnWAYArgPU7cDWtU=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=EEyVog39HED2tySglI99keE0NWkoi1FNRuOtsfTNyqr7Y4OU/gYSOO3l9WAGVmd0uXGLHwO9S723odmxJozCtICfXcERsDazZgi5Zr9d9Uwk2mwTWepserPaaK2f7jCXF1tvXt8NTlzHdS7V378f2yHsRaUjGL3rQLrVhltt9BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=DNY0fCI6; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1727175618; x=1727780418; i=markus.elfring@web.de;
	bh=SHN5rcl8R4Y8nZWRTekdD4lrRJs2FAipZesYRLL973g=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=DNY0fCI659T5NOuhLT+oynS8TejA4KPrOhRvmDnQS8T/1izL/zzoOFo3y2kTmevd
	 FeeNlLY0bm4RSwf+3jqgorSs+zybC9yGcoluSyJgzS574vUr1qxmErxSNSv+U2wVO
	 g2p2uxClthvZ/gvHbI7grUEWy4R6rQcvNvwD917oYJPqubigWGcA2GMBPeANUusZH
	 OzwwvzUPkruy+WoLMeHhNCAQcjMlfhCrZRFc9VkHEzkTyRF/V+icu/Zgo2ybmMKjR
	 a7qdfIYgPPnpDEWkwD+j8jS0TJ0/8Jgs3KwHrexO50ZBR8X/xLqAzU7Kg/Ls/ygqV
	 nwE7qcj/tbw/uz0xTQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MzTLI-1rxljO3gcC-00wm8V; Tue, 24
 Sep 2024 13:00:18 +0200
Message-ID: <d3eb142b-eabf-4176-8a5c-0d589060abe8@web.de>
Date: Tue, 24 Sep 2024 13:00:16 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-pm@vger.kernel.org,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] power: supply: 88pm860x: Use common error handling code in
 set_charging_fsm()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xQU91hY0DNMzmdfuXSOeB2c157fJz2tP7gHn2+en5sEXrrNbvt7
 CUW4iK9J3b8FL7kVmYE4/kAx1Lq5csZQ4ISr0As7OujHnK6g3C4JUCHmDPP6x8MH74QtAWg
 kJn2hQGYDdGjtMJ/1yIAo0BjzeXq42ykOlObPP3HxFidwoWKmlGYJteOGyVkb6KGDYUwIUD
 oQMKY4QsJ7YyiXSVk8cBA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:6eELnGGIuME=;lvUhYnwOwRjIibRR771y8JFFRFt
 wRyZsJdLHemhL850fGX8qnbHgBJ3ctPiO8yFrDgY/C3yDcYyEyip/jPMX4lhmeHDY43wFFTpb
 swn11OoYKWgwdMf1SX2dYsyPj4gm0UT9qWx8Y4ogxny7r4qg0gkEO63x6yKiM144YuAzrTJGg
 CNRwGWsAmACcNGTv+0T8y0eGOcmUO+YZK1O91A0AdHmLJB8ESmqxTRvhoSbWUCkfkYzFOVOcV
 f0oyjzj+XXOGu29YPBoMusXjLF8kjSopvjN6wMq3PVm+P6qn0Gid7Wvb3d3yioIKic5utZXV5
 mb++z9Ypnu11zUJnmDfoXw3bnRJ2SJ8vK+Fx2K8shcGqNe9wm/TLYhjicjb8n2dHsmf6SwH6L
 5wc2N01kTerFl03NhCijiuxhgPGBhryr/wR1ZOeB68Iurt1invNhlegewWJ0y9/a98YxcR4xt
 QGy0LuVEjVqeXZipeGN7pZLqmZJpGucVHtRQiVk+Zw2cVSOcxXW2U17VOWJuCcxNr2WQ8yr1D
 lehxSGNkuecEmEKxYMFcKjzH3C5GvDYeOq8CSNZ/eiveBXcmoyYR1eRkR3Cn+Rrb2KeabxRNh
 IQ+f5VZ4YmT5Usp27e03zJPbGcGQdL/Xzt8RZGWgv4OWgp/7nx2U0bUcRHR2qayfSPlABmJzN
 9HsChAZC7IdszDnTzYZWI+2hTiIRj0ogQLPs0mjJ+vxREnqx9TNdlOE4fsV26DVuEr981zsZm
 +tORg2vXfMB8L5TCP6PWuP32o3kjtlcSZPzc1vXRa0fQPhPnkdyA3eoKt/fn/UBTy9pmCFOAW
 aVBV0SfIECIKWQmAh1J1jqpQ==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 24 Sep 2024 12:50:09 +0200

Add a jump target so that a bit of exception handling can be better reused
at the end of this function implementation.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/power/supply/88pm860x_charger.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/power/supply/88pm860x_charger.c b/drivers/power/suppl=
y/88pm860x_charger.c
index 2b9fcb7e71d7..4fdf62a7245e 100644
=2D-- a/drivers/power/supply/88pm860x_charger.c
+++ b/drivers/power/supply/88pm860x_charger.c
@@ -295,17 +295,15 @@ static int set_charging_fsm(struct pm860x_charger_in=
fo *info)
 		return -EINVAL;
 	ret =3D power_supply_get_property(psy, POWER_SUPPLY_PROP_VOLTAGE_NOW,
 			&data);
-	if (ret) {
-		power_supply_put(psy);
-		return ret;
-	}
+	if (ret)
+		goto put_supply;
+
 	vbatt =3D data.intval / 1000;

 	ret =3D power_supply_get_property(psy, POWER_SUPPLY_PROP_PRESENT, &data)=
;
-	if (ret) {
-		power_supply_put(psy);
-		return ret;
-	}
+	if (ret)
+		goto put_supply;
+
 	power_supply_put(psy);

 	mutex_lock(&info->lock);
@@ -391,6 +389,10 @@ static int set_charging_fsm(struct pm860x_charger_inf=
o *info)
 	mutex_unlock(&info->lock);

 	return 0;
+
+put_supply:
+	power_supply_put(psy);
+	return ret;
 }

 static irqreturn_t pm860x_charger_handler(int irq, void *data)
=2D-
2.46.1



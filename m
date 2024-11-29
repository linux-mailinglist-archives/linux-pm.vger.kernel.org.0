Return-Path: <linux-pm+bounces-18226-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4237B9DC120
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2024 10:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E292FB218AD
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2024 09:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6559917DE16;
	Fri, 29 Nov 2024 09:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MPWNZOHG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9726F16B75C;
	Fri, 29 Nov 2024 09:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732871412; cv=none; b=AvBEG2XmxitU+oOlYs9FLZqFBvwup/50vVdh/tCzh7pEMiGTzeaXJPxUWjD3RuUjmgZcIL6WZeRGn6RS9zPjMHcyGSkCYSTA2wlxMGLr9dk3ZhKujhuDp76PAHzcceqXI4Lc8lRlsrXmAtb/MsFXExBYqWvkoEusClljPWVInnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732871412; c=relaxed/simple;
	bh=/EeD7LqHcTZ3/1Ng4iRA0q/Q9oTbn7vVY0BQy1PKauQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JAvM0BsvAtxsJcvc2pDQDgdynnClZjUw+LvN70AH5i5WvdZkw0rwyDsm50LomdM2FepKvXPZ2IhLaMdMZwQanQcC6/pio7moyuEvkZgqRzSgifwfHck1UMgl4mgcexLSbCUB9sFTkq6wDwadfpEzP2/tnC1C7bNbHa3KjXpCasg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MPWNZOHG; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5d0bdeb0419so111111a12.1;
        Fri, 29 Nov 2024 01:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732871409; x=1733476209; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RwPuXDf5OOwhnI0ZOOII5GNLjUS47fPFuHS4/Stj1TM=;
        b=MPWNZOHGJ/ooq6hTPN6H0yXUdPY8c6NnORMrjY09E0uv1yL0KAsR6S8mEYDmHMa1fI
         TgN79wDyl6T7jgORf/A2uR1FnsC6eaCUET4RI1Uy7Lhf5ezQiV4fqCZ0/QfpylLvla+N
         VUozjqnPKrixe3v8ym5hLKx9P6sKjLDz7CgZTEsyAHpMT5Oz92eHUDV0Ere9qJZxRiSI
         BRrk9ffLT45DJEs3nxW2g91W3MmIqcXL8ms7O5giH0ib5I1J1R1RMzJNCDb36qjodlo9
         ry6vAzrgaKN39nQwNd/92OQ4PY4/zAVNXH7J6/fupIHHM11ONJ6gSCbfbtAbHec5Al9q
         XOYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732871409; x=1733476209;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RwPuXDf5OOwhnI0ZOOII5GNLjUS47fPFuHS4/Stj1TM=;
        b=h3ohexKeHhy9XGUOUmbTgpelw/cldFM2POSKHwOmg/waXcQfvyoRZj3MtiiEJSgR/h
         rXZ7ocAPcV7XIkSQtUVZ/yU2yVelNALCLpPMEm0TaKYiG6WxG5J0w9rj8/IGlngdLWkR
         AsoISBXpMywnL0V0Xa89EBZHS+XA0v0r0nck40/YupUDmQlDlwFNHshfMV0Fzc5JtcxF
         fmA3aU4E4GJXY4DIh8QMDy9weAOfQqH0WlbC4xGqtPKuoMWHV8Ad4NKv8dM/2vKgW1e2
         sHyuRfcZtMsJCjJ8K5C0JKWF28KV4Bx4qC2LalJOoC/zuTMMSKzEyj/9oEJuBuOCfHd1
         8hLg==
X-Forwarded-Encrypted: i=1; AJvYcCWXBnN+ZMNwkyohGKX1LRxYMYx+Y+JyTBf3PbGuQ85GtwIvEL1rADSS7SLdsU6T7RZGCdYj8hLZIVrW/4nzyw==@vger.kernel.org, AJvYcCWxZCD69Gsz2ul6coNpOruwr7M7ULUryQ3D8u5LnSbfCVLyW72I9uvE/yza9OLZ4IBNRq6nOmvYi05wZAzA@vger.kernel.org, AJvYcCXU5GUdZ3m1JbbCdnKsqg8qKpzL12pyT29XGOski0xZkJyMnNCjDrhb/ox0f8oD+5TT4p0FgKOemsaE@vger.kernel.org, AJvYcCXWb9l64bJXZpt872szTMoYiozv0C61cZNIghBuFC1WhZRmessma+dg2jS+ucz1p6XUHG/Sx6dK6H9PV2xDK0Yy6qE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy66YvhfuxU3eWujgAPXIzKco2Y+tvF0athy7MFcjQvpQFCtLWJ
	moaKTbY2HQhU86kpYDc9RPFdR9Si2Fr8hBdLrAGap8dgPr2f96lg
X-Gm-Gg: ASbGncuCwVT65DI5DtRIzBcffptFcv3wdumhBYUZXeHVRXS0kxgS4AwSVOm+OfMeIaV
	TRuF6O83okYA5avzZ2z4XbZoRwyRwLofxbHE1lQkL75dtCdxFCT6vimEl96hhrjwro76U+uNa3u
	gHm3PXsL2vlxbu/7UP909BuXqqZ5DFar37gi3eiy6BeU7NWEZ4wKxQfQY5eBW9CHta+geEloJRX
	/iroYeq17Dfk6VBc+FTT1xv8x/wZ4TlXiGuc3V19Clj619K
X-Google-Smtp-Source: AGHT+IGaSoNpYyEkF4MY0uin/iFl40YkpVFgMNLIjAQotNHq5x5X5IuG35tfQL+bge3PzeB+YGebeQ==
X-Received: by 2002:a17:906:23ea:b0:aa5:451c:ce26 with SMTP id a640c23a62f3a-aa581074c05mr802310266b.51.1732871408811;
        Fri, 29 Nov 2024 01:10:08 -0800 (PST)
Received: from [127.0.1.1] ([46.53.242.72])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-aa5999032c1sm152775766b.133.2024.11.29.01.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 01:10:08 -0800 (PST)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Fri, 29 Nov 2024 12:09:53 +0300
Subject: [PATCH v4 1/2] power: supply: max17042: make interrupt shared
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241108-b4-max17042-v4-1-87c6d99b3d3d@gmail.com>
References: <20241108-b4-max17042-v4-0-87c6d99b3d3d@gmail.com>
In-Reply-To: <20241108-b4-max17042-v4-0-87c6d99b3d3d@gmail.com>
To: Hans de Goede <hdegoede@redhat.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
 Purism Kernel Team <kernel@puri.sm>, Sebastian Reichel <sre@kernel.org>, 
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-msm@vger.kernel.org, Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732871405; l=1055;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=/EeD7LqHcTZ3/1Ng4iRA0q/Q9oTbn7vVY0BQy1PKauQ=;
 b=EvyHOgNK4AahgKG5DWBHSPPcVTYoTJaiheiGNKsbrhG7AOhn0QFFuOhoAyU4v55mKxKIL2oN9
 y0QTQM7oOgEAjn27raPOcOvSbj+ijsZ35rDRl/DiAFJeZ6tqZoApkdx
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

Fuelgauge blocks often are incorporated in bigger chip,
which may use only 1 line for interrupts. Make interrupt
shared.

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
 drivers/power/supply/max17042_battery.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index 496c3e1f2ee6..99bf6915aa23 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -1103,14 +1103,7 @@ static int max17042_probe(struct i2c_client *client)
 	}
 
 	if (client->irq) {
-		unsigned int flags = IRQF_ONESHOT;
-
-		/*
-		 * On ACPI systems the IRQ may be handled by ACPI-event code,
-		 * so we need to share (if the ACPI code is willing to share).
-		 */
-		if (acpi_id)
-			flags |= IRQF_SHARED | IRQF_PROBE_SHARED;
+		unsigned int flags = IRQF_ONESHOT | IRQF_SHARED | IRQF_PROBE_SHARED;
 
 		ret = devm_request_threaded_irq(&client->dev, client->irq,
 						NULL,

-- 
2.39.5



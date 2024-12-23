Return-Path: <linux-pm+bounces-19684-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B771E9FAEE4
	for <lists+linux-pm@lfdr.de>; Mon, 23 Dec 2024 14:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5592F7A1C94
	for <lists+linux-pm@lfdr.de>; Mon, 23 Dec 2024 13:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972BF1AF0B0;
	Mon, 23 Dec 2024 13:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kHadZMEE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE7E8BEA;
	Mon, 23 Dec 2024 13:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734960675; cv=none; b=j2Uw3z/Ooi268RoJpC/KHEtm+mf31nabm5o26xlEW3+uoWdTmAOd2T3kM4dQ45jrkX2OFJCa7wRAVEsB2MbmZ9Yehp8EZAiIdl0JXBh2YCh9KTfbd2WZTHZjfv40p9NBwViuahxcfZeqHCH/iiYYgf+FDO7qdVEU++DWgPc3KqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734960675; c=relaxed/simple;
	bh=/EeD7LqHcTZ3/1Ng4iRA0q/Q9oTbn7vVY0BQy1PKauQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GnNTkk8kmxAeTaZL6qzHARBsZc1MqH+K/REuyoqjViTMHEtUqBbyNoqk2Ln5x9p1ELFC4XEcXMmYMoiGHgu0jrreqvS6lciSGWzeyIGfRMiN1BsRqQ6nWLFFSV3stZg2zDtgro37Y39skeuZulk/KjdYosGkaiNbOE8Z12T4Ydo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kHadZMEE; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aa679ad4265so936859466b.0;
        Mon, 23 Dec 2024 05:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734960672; x=1735565472; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RwPuXDf5OOwhnI0ZOOII5GNLjUS47fPFuHS4/Stj1TM=;
        b=kHadZMEEVZsqnDWfP/qdMXLWyLDD3JtOoSmSA0n7y3m5bOFtwA0dc+LZTNfCORIl21
         gQZtn49vDW679r4dsWVuU+tg6SZ+/qPFal2SidmWhyK8X3FA6A4v7mAq/TGtzDkTMSy2
         Wqxl//fweDk+PFrk4F2Qv9xFm7leTS9xaVUlE0alykLoav3wEYnlYmZoqSLMTacZAj+N
         XYb/bvvEf4i192ehfFDNO1OUKrMIVk0eyJTsjQNSLZuTRXc5D1vkyyY/frffoU0UQPCk
         x/mKSn6r3AeWC47ZM5xHbeMTMftB7e8Q6aHXHo7P4W4mjxtUpP9i6Xff7Y3YnItQTffM
         ScZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734960672; x=1735565472;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RwPuXDf5OOwhnI0ZOOII5GNLjUS47fPFuHS4/Stj1TM=;
        b=gxrG/FWf+a6hSy3ryEr4W+5tGyqkEJ6vjEOXxNuojQBHGE162G9KDGdzgeq7SIG/B3
         RdqyzwMHpdxi0QlXN7Khl0gazeNu4UDJ3YuA5V1yeQg46aPeGqE9Yx1GJJJibYDDrgrK
         YtSK8Ycz2v+ZpUGOTcX9OOAnVvhQFEIJO41tnE1MjZYfRVS8UtAhZhsVJuxdYIz3mdWj
         3HdjWNT0wmeq6pkWNLapi2/tV8z6ENYU6/J35Pa3XNizxkyzG4Qy3QZ7O3WLuCw9/O3r
         FQYNbYsXhSDy+mzsB9ynVUPyZvNCqtGScLUSzeacUD2B3LeaQS5Eh0PL4R9Y8a7F9WkD
         2ynA==
X-Forwarded-Encrypted: i=1; AJvYcCUMZbJcCqZFvuPa4UZhAsM8ndjxmbdOZgad+agP1rcs78rvR7JGPvWGzdEhmvGiF+gnu8Rx9J7AgGq1TDkU@vger.kernel.org, AJvYcCUtg03EwRZ3SJmrm2uXr3wHv0lJBQCftBmKtbxdA9I8TIK9QrFlLb0LFDJunrxx8OprS5bYpk7CGqz3@vger.kernel.org, AJvYcCXOPnMFSw4fEHF+5knowEZ2+GysQqSc0ofUC0QzHUVR+hJnCpFJK7m06t6WW/38PCiUkvlro2X8G5zHTx9RCf30eyA=@vger.kernel.org, AJvYcCXtQ2Xic2imys8yErwxiX8piUOetMDpRb5jD+YCr2UC8GqOaRwh3ijJJ3YR4HRZM2KvaI4PEAu4wGWrQipD6A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv9DPCZjzwodfuowGrSWaH6rUP/vtTzXQ5bBli5wWTxjApJzX4
	A+F81PnBGIgZgXnekPp5T6TKJ/lB2tX/zHvKm1k4xiY8xB5VNZ+5
X-Gm-Gg: ASbGncveYtIPjNw7OjbFTJuo+IRYbf4IaY3t5ZM5uXjupwCS7fMQayvBvRU0ANPIf11
	atTFo91ZnPGGHYHliQLYiB/XSE2TwSNxpprqBTvL3vKl+HOSQkNQ9t8xNO0BhAUpLvu/IsnjO4w
	i8x9y6EKzJ0ZQx70WzZlm4WRVmcozU3m2It0jvDs3u270MyHEXrUJ4VLcXHlImfi06CXaKT+Vko
	oBRGjAx/ih0gRKbLol/mj4WEziUlZy2RbnCxtiqIEHU7+lLTjd/qb08n3q4yG6NyhA+s2wT+KKQ
	ZeHKBLeR1FYeaFuFal1R1rVb1A==
X-Google-Smtp-Source: AGHT+IEAjOSElAIIGrGWGIQMWdMK2o7RI6v/y07lVKjYb6AqUZp1yJSKckWfo1Bm53K/zjmZVsKLjg==
X-Received: by 2002:a17:907:3faa:b0:aa6:9540:570f with SMTP id a640c23a62f3a-aac081579eemr1553450066b.18.1734960671961;
        Mon, 23 Dec 2024 05:31:11 -0800 (PST)
Received: from [127.0.1.1] (nat6-minsk-pool-46-53-210-232.telecom.by. [46.53.210.232])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-aac0e895502sm523749966b.63.2024.12.23.05.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 05:31:11 -0800 (PST)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Mon, 23 Dec 2024 16:30:39 +0300
Subject: [PATCH v5 1/2] power: supply: max17042: make interrupt shared
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241223-b4-max17042-v5-1-e4e409723bce@gmail.com>
References: <20241223-b4-max17042-v5-0-e4e409723bce@gmail.com>
In-Reply-To: <20241223-b4-max17042-v5-0-e4e409723bce@gmail.com>
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
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734960669; l=1055;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=/EeD7LqHcTZ3/1Ng4iRA0q/Q9oTbn7vVY0BQy1PKauQ=;
 b=ltc3kA6HcpduIZKYmVftqNij2lf7rbl9PER+OdeUoULkpB6JPpKkulYdc4j7/w7rYHRt1LhYp
 zt4lvjE87Z+B8qqX5eyIYMrKZZuAMRSM/NZnPIuV9vCF2JBkS3lLuE7
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



Return-Path: <linux-pm+bounces-22007-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB35A33DA7
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2025 12:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA39B1668CC
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2025 11:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C3121D3DF;
	Thu, 13 Feb 2025 11:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ctHLYeM1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E1321D3C5
	for <linux-pm@vger.kernel.org>; Thu, 13 Feb 2025 11:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739445518; cv=none; b=LRIZ10DJf5NkLJ2CCfUgDJvttmYHbmXU9ynQYKf55dwOJW93w54RgwIyoIu5GFeZXH49rUOiwTRxhG+4SZI/f6/2jduHfMmv+wYiCDtEw1+hAUW00WMu/EgQYXjpmBB6fkVUch5l2Cb0yecj7pepfKX2nqDjkQ/lTGn4+2v3DMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739445518; c=relaxed/simple;
	bh=yZykid4Tnvw6uTxZTfPXzibToPkb2UoxKH9qc3uHcNo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=dEX+8tsNu56UXZ1XCltNHuAyRjaphqIAbkE/TQEYHW2qmj3vYT4CvtSwoHZ3VExQ6rZaE4STVnPTWBr5/aSXfe/JBbe6umv9e+1foy9y5fQxBVwfpxosj1fXcwTYfh3gohQnwDketUxZ86+uQplrcRJSoJJRAlGA9sg2gkQDuw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ctHLYeM1; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5de849a0b6cso1332339a12.2
        for <linux-pm@vger.kernel.org>; Thu, 13 Feb 2025 03:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739445514; x=1740050314; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hcwZpuTU02sMJrS+Mjy6fqoBX8jKwW0TxWQW8Ahv3FY=;
        b=ctHLYeM1IfEkck3J3Cxo6hb6m9Siv2hYx9JCDXSnCzVT2barqfiz2NkOTh5nOUrGRj
         /QDcxe5yroQxerUUKt2ruc1Tm7VWG34mEvowk6GHu/sFNOUW+HiE1J7WwEgJye/8FUC4
         U7OuJ/gMWyLGHcoHNDEar45unT8hFTEUU2FiJfzpJ0cOGVV5ZE9osjyBtqjdaN9we4Oq
         lRHDaOVc0zsDGemru95jMv07M//qxqgatAsA7R437xf5UTENksmSeQ/FopyvfhMfBdQ4
         98/ub44F9MBv9MlyT5jN5gpy9Qz6+VvHG7eVHwZSi2ayRPJs/JKoO/gPtIX67AgvQURb
         6HUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739445514; x=1740050314;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hcwZpuTU02sMJrS+Mjy6fqoBX8jKwW0TxWQW8Ahv3FY=;
        b=ayBFRJuxLAAiRRVU0Zu3r1+lFOVFl+qQ6flZUJ4YqlIyJL+T9d11Gfpvk2PupYZoUv
         ylFa6QClcg1lwFlYGk8nJL56B20rLQBsEqkjKHZ2bG9b24KDxZs2t/z5F4Nj1+FR7DWA
         oFiuJLx9rVyPJJlZE7qVS1QgjNk/zOz/L+L/oDE5sGEJyAJ86i7FEaqIAlYhC3F5D28M
         CWA6g44PZvJgxqYILzeAsMENTKmlKeglqifrtR2lXFF07dr1PXoi5AH/bdrE3kP3yDVm
         5gfXeZIo7hSmKm3Xycarj5vZQ9Vd1A81de6pQZ88MPue0irSxyMO0wlLTB114DjB8fmy
         FhqA==
X-Gm-Message-State: AOJu0Yyb4vRtzFo6znsHrjmZW6j2MsT7j08NaGI4hA0E3f7+T8N4QS4C
	1VfLyeSQE0EmuQlZULAVb7MzsQLkihvrMmJ6hfuu38MgJpxQgIS9WP9iXHvs+gE=
X-Gm-Gg: ASbGncsu7+j2Qog984X2B5KvpsRY2B40xLA6MUwxGbfCVEenBAcjd08NWCf3EkerdfP
	13/cMAZVQhi7sjoHHQtuC8KiF9HVovXWlcDlwFvOntG86qZiFClEZWmvzxyjb0JWWpbJaSFRC2M
	/u+yzts5IkPW1WXXrRvWgho/M73YY6f+isHSGDZaIzRP/Fv7N4tL+Jfn2JtG7Zlh7n4AwmuVcLA
	BZt4WwW3iXBuzgerUBEDn85JeeFMv4v5ZXikrSiREA3A/ekw8lYyf866x+UgnEJxJYt94oKw9Bt
	G3ZPhVMuhI4HaeeaYsccCT9XiEEO/XNb0WY06holUVmakqPolhpdkk5ZGDpL5/AJuc4UtLkX9Lo
	=
X-Google-Smtp-Source: AGHT+IFqhBKKdWnQWpVYsZu06h2i4EkJM5xC3kZZLUKj1tfy2dbaEBJKgl9UFEL/OvS6Ziz5q2en9A==
X-Received: by 2002:a17:906:730f:b0:aae:fd36:f511 with SMTP id a640c23a62f3a-aba501a9d85mr265032166b.47.1739445513994;
        Thu, 13 Feb 2025 03:18:33 -0800 (PST)
Received: from puffmais.c.googlers.com (30.171.91.34.bc.googleusercontent.com. [34.91.171.30])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba532832dcsm110618866b.85.2025.02.13.03.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 03:18:33 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Thu, 13 Feb 2025 11:18:30 +0000
Subject: [PATCH] power: supply: max1720x: fix a comment typo
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250213-max1720x-typo-v1-1-9c88611cac34@linaro.org>
X-B4-Tracking: v=1; b=H4sIAAXVrWcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDI0Nj3dzECkNzI4MK3ZLKgnxdEyPT1MQUg2QzY+NkJaCegqLUtMwKsHn
 RsbW1APaP83ZfAAAA
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.13.0

mesaurment -> measurement

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/power/supply/max1720x_battery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/max1720x_battery.c b/drivers/power/supply/max1720x_battery.c
index 11580e414713..2c9aea4f5d7f 100644
--- a/drivers/power/supply/max1720x_battery.c
+++ b/drivers/power/supply/max1720x_battery.c
@@ -302,7 +302,7 @@ static int max172xx_temperature_to_ps(unsigned int reg)
 /*
  * Calculating current registers resolution:
  *
- * RSense stored in 10^-5 Ohm, so mesaurment voltage must be
+ * RSense stored in 10^-5 Ohm, so measurement voltage must be
  * in 10^-11 Volts for get current in uA.
  * 16 bit current reg fullscale +/-51.2mV is 102400 uV.
  * So: 102400 / 65535 * 10^5 = 156252

---
base-commit: 808eb958781e4ebb6e9c0962af2e856767e20f45
change-id: 20250213-max1720x-typo-425ead0c633c

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>



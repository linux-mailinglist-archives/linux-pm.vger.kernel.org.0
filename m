Return-Path: <linux-pm+bounces-27755-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A38AC71AA
	for <lists+linux-pm@lfdr.de>; Wed, 28 May 2025 21:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2551E7B3BF2
	for <lists+linux-pm@lfdr.de>; Wed, 28 May 2025 19:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B011F220680;
	Wed, 28 May 2025 19:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cGXmlB+L"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE05321CFEC
	for <linux-pm@vger.kernel.org>; Wed, 28 May 2025 19:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748461488; cv=none; b=q70NmJsZ5RlRcSu/Ii9+/omjLkjvX3h8Qu4suwNW5jWYmzYkdCIrUzvTz40lSR+YRyUZSWCTHAS0MSPoltQis964md4gSV4b4CeXGnqXe0xK2kS1f9faJIhlRYhsYFOvlC9EPaFnEwv4N/nGrNc2AjDhVVj6PdB2FdnFLmHnv+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748461488; c=relaxed/simple;
	bh=guCDaDwTAp4TXvy9+7jlbNrAYwY+fXtO0BITgGPtVMo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lfoEpBT6SEK1mqoA0IkZmnMj1sWccYieJBeok8NvwhsML8dvD5s7RrTH0ikXhs5M0ov1w8n23i7Sc0D+2VS16vx89aMQasjtK2aIpIk6j916Sdv3DceIKoh80LanvkMA1l6Ya4N6A4Z1Rpw8kBj7LWkJvOtZ5Nc6FI40TzCy/LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cGXmlB+L; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a4e749d7b2so34968f8f.0
        for <linux-pm@vger.kernel.org>; Wed, 28 May 2025 12:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748461485; x=1749066285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wb4t5KvlRTeDQRXTmMQslstrXgIdlyfTjd5qJWgFhow=;
        b=cGXmlB+LUeR+4icJcxUEr+Pf22yDa6cSZhBAHDzTnBAroVisduQjCN6M9sqcLZi5H0
         SS+JWMR6Eg+rrRvVldPGb0R6zMtvf2i2VGZhNCq6fMcFZzyelzGyAWG2rai3aCnsKI4/
         N/Z7gnsllEAI2IGNSxLH2QpgJbf0qsqUt88tGPCxnX+NQVMq2VKMg2qkJwvIVf9vgM1X
         Cgfz138W4dD7eFKUZ1/lzrw+LjzrF5ZgadRZRD+vgefKgchQ4hByrt2MCWO9ozXNSMpW
         UUA9+K7T9BXshoFhts7Rc8rMo6WErTHb9ejBY5O0mwPzOgmxNz7QRUa51yAjZYNQcAG2
         R5/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748461485; x=1749066285;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wb4t5KvlRTeDQRXTmMQslstrXgIdlyfTjd5qJWgFhow=;
        b=JkPOnsOkn+faWqtREtECPLrbcXfNLhV4TbaYQk9PSf8deES0aRVvd0m0rpl1CWS5FP
         vTyTsx2KigXyLf3qbZaLgB6aqKKtCK1fs74shDkwz5yp7fQl5/l4O2IajBd746QBjbij
         5sOPlSJiZ7ypzbI6JA7APa6Lzxyc9lMeIL6C68FbfUJeZRWG72SOCLckO5ApP735UcAG
         aKi2h+DHPlnjGs7eV9hGh/ISPRLHGwB0km/umIZkDb72oM/rD/1MonFFAMTkCvBN+IQL
         VlG99Ks9SUz5RfTcUlfjGhNiuUl5M/AC7npplJ6fZL1w3zi9VEhSJ5ZrstOEJY9mvoL/
         hnDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvpUwgcg70dFoqgTC93n322PJ4aHDVRlmNb+0Fn/ajnc11z9UuRzgzKn4Nq+0pLNZrCcMRZ/yP7w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx3+DUV5VM7lQcjLbF9XfjgtQPwXbqyNhFoPKXhc4jnXaJ9F33
	CEvSLKvnUpS3RpGDnvouRmlVh/KLbJ7dLlpFuDzo9+NFl8Kb+i5wLF0JzfkD97hod/Y=
X-Gm-Gg: ASbGncsrluz/YSQxN4pmiFFFLwfTJWkB5hW2vaD/yU40qc/CiMmDKfLgEZ3PnZKhT6C
	hgCy7Hi6GrWV6YxIikq0H3BrmcfW1if0s+0tyV6nR+iYAcLCvYpR/6dfdNDfqR+Sgtwj6KtjXhO
	5ryQc9B1ElE+9BLjn1lk/kB/ottRIWy822ngdAbKVvCrfnJOgH1sWSROxJMyTNhrIRGI463PV+H
	cTaZEYbPoQxXSvRYHadMh/29+qgabZI8NTr3ElfPk+7hRq2o2NDGCfkPjL50X9/tKSmWyJvabfb
	BS4PToyFyv8yAgSxUUsL619NziErC1k3jVdQKn6YnDVpnu/cIITr0JQmkHjeVg==
X-Google-Smtp-Source: AGHT+IGGyQ+6VoVABu/JgeAidWofJb6abV8qb3IPBudU9m+KRT04wz0+r5MgwYctRkx3xTDJI6M54Q==
X-Received: by 2002:a05:6000:1a8f:b0:3a3:7ba5:a225 with SMTP id ffacd0b85a97d-3a4e85d3136mr1236688f8f.0.1748461485201;
        Wed, 28 May 2025 12:44:45 -0700 (PDT)
Received: from kuoka.. ([178.197.223.125])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450cfc15b6csm382385e9.20.2025.05.28.12.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 12:44:44 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] power: supply: bq256xx_charger: Constify reg_default array
Date: Wed, 28 May 2025 21:44:40 +0200
Message-ID: <20250528194439.567263-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1528; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=guCDaDwTAp4TXvy9+7jlbNrAYwY+fXtO0BITgGPtVMo=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoN2enhClD2OVj5IBfWD5bxolqLlH8r1bnMziAF
 o3pQF3MDduJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaDdnpwAKCRDBN2bmhouD
 1wpuD/4uLzs7ngmmWApjO8tMzYwJpGwcwr6aThW0ELvD47Ocu7snGrFe466Y0vLjo9stRQIUpcZ
 SZfJLv2smNDZ2zfcdf1CQntivRA8bdpUnWoLmf8FnlaXnjlMT8Kk3pFKBPNrhShQSQWAUv+PxzD
 r7rHp62LgGjKFthtygXlsLgTFXRLHxm7R6FxXmzuqEDKvjAH9kIy8/+4YfuATHUjYqEQz3ykqqX
 eqOccE1oBEz01FK8huiqV8EJDBR5p/hnmF0i6KtKBwWLhs2YpdxkpFbJdGlcSPyT7cS2N1EKlmF
 QlbKMG8g4UL/e4z7gyXcs7rNPIuwwETn9s6jwhLWCg6uVUyWjM3h/e3K8scPkT0f9z6Tekx8kPw
 o4vX7S8UMsVzjRaCp8Jl5hIG3gskmUX6xPBbh9QsWpdIRuGQKaIqjvfvnrMOL8WLCPjdGlAoHyQ
 31jp/9P8ogsooFYGRunqiAXlxWlXp0PA159NEqD3I3jBeaYWMEDNFChjtWZYm/2u3qrwcEtDCBp
 7H6lE/yBBllwoF1NggdR7Idul21b3Ps3hyTd/TlhaOeTzMg+fOoiRMWNgswfRWQReLz0iP33Z17
 CEaD2oMTEgnOFA9DPxHWuD39xZh8RujGmCTf9qXM9AspCz7iUSv/RB3q5S/5iiWBfPuDoTyycgI c9akbGPi5Ko2Ceg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

Static 'struct reg_default' array is not modified so can be changed to
const for more safety.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/power/supply/bq256xx_charger.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/bq256xx_charger.c b/drivers/power/supply/bq256xx_charger.c
index 9f9b6019f8e1..ae14162f017a 100644
--- a/drivers/power/supply/bq256xx_charger.c
+++ b/drivers/power/supply/bq256xx_charger.c
@@ -387,7 +387,7 @@ static void bq256xx_usb_work(struct work_struct *data)
 	}
 }
 
-static struct reg_default bq2560x_reg_defs[] = {
+static const struct reg_default bq2560x_reg_defs[] = {
 	{BQ256XX_INPUT_CURRENT_LIMIT, 0x17},
 	{BQ256XX_CHARGER_CONTROL_0, 0x1a},
 	{BQ256XX_CHARGE_CURRENT_LIMIT, 0xa2},
@@ -398,7 +398,7 @@ static struct reg_default bq2560x_reg_defs[] = {
 	{BQ256XX_CHARGER_CONTROL_3, 0x4c},
 };
 
-static struct reg_default bq25611d_reg_defs[] = {
+static const struct reg_default bq25611d_reg_defs[] = {
 	{BQ256XX_INPUT_CURRENT_LIMIT, 0x17},
 	{BQ256XX_CHARGER_CONTROL_0, 0x1a},
 	{BQ256XX_CHARGE_CURRENT_LIMIT, 0x91},
@@ -411,7 +411,7 @@ static struct reg_default bq25611d_reg_defs[] = {
 	{BQ256XX_CHARGER_CONTROL_4, 0x75},
 };
 
-static struct reg_default bq25618_619_reg_defs[] = {
+static const struct reg_default bq25618_619_reg_defs[] = {
 	{BQ256XX_INPUT_CURRENT_LIMIT, 0x17},
 	{BQ256XX_CHARGER_CONTROL_0, 0x1a},
 	{BQ256XX_CHARGE_CURRENT_LIMIT, 0x91},
-- 
2.45.2



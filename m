Return-Path: <linux-pm+bounces-37555-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B37BC3D30F
	for <lists+linux-pm@lfdr.de>; Thu, 06 Nov 2025 20:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5D8884EAA78
	for <lists+linux-pm@lfdr.de>; Thu,  6 Nov 2025 19:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3933C357A48;
	Thu,  6 Nov 2025 19:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HOQcjxqy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4DE3587AC
	for <linux-pm@vger.kernel.org>; Thu,  6 Nov 2025 19:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762456115; cv=none; b=pd7xO2P96F/4Q2jw7YtuJeRKBxxzTPZElf01Dsc1BkQNG7MZP8Q9DDLIOEb/Lagh/2XPLxZaRXaE+bIFEnE58VusIkphzCvsLtnUQgsSyXyHwoIhZc0JA3MUWNMJettWiZzna8q+OmxY9/j7MzxgptQF50oBabuykQUU5Htw8m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762456115; c=relaxed/simple;
	bh=HOTpv8E7M3Z9++7bQRRNeja2y7FI7o/hDZwnKU6ywmQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=thgKxUnJwQvAkbrID5xoT+u+rRnVRuSOcOeB+NyeFDXJW71lO7YM+lF768X/wb6vBE7Q7CanBM+Oer7fXnm0FMF50x5SR5+iMeyzZBG3WmvrAMtLvMq4bPwJ/eSO1acjG5C2jnfZ4Xynjq7QgclS7Jnyrgr0pb+f6KIPKE754RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HOQcjxqy; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-64075080480so219833a12.0
        for <linux-pm@vger.kernel.org>; Thu, 06 Nov 2025 11:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762456111; x=1763060911; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nB+3RSbUxVhm7JIM+0TQGTITyXpP2tjxIcWVIQgzWAo=;
        b=HOQcjxqyPBFpDpHC3zRue0430y1YTGs5wbn6UZXyuBTrgjvDIa7COjQH7sHehjhXod
         sjV+IlwZwMjWUZ3EGpylAed0WQfaX/h+9Qm8YimayPNyEmGBjztgIgxG6oD31UvR1/sW
         t1ZH1/VAICFZm1D95LcYLOuwVk3uWcoEymv27u9ct8t+mWqCDuEavDAE7TPKjcR3NrYt
         oypYrMi+RZqOG5ZRh1q3Le1zJeFYuSZornmuf7GD+oS80u5P39QoOd0eEL/1YwgjXjkz
         pY9K0SCB3Qp/8ylfI9/uAlluHvmiSy1xkNSoXLMCcY8Punlcz/9V9AU4gZT5Rh0dex/w
         Il5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762456111; x=1763060911;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nB+3RSbUxVhm7JIM+0TQGTITyXpP2tjxIcWVIQgzWAo=;
        b=chLzBbqaKwwunnAv+dJEbF8iEx0mOnQ2iURwaBtbyv4eebtlrqXexUEf+xvwzXyUyA
         iJDU3EjpUyG1Lnxx2sAqxsRGiMTC6pJR04L5cjJ1wsjR/9uIXZyM1SO67qhw30liNIao
         VTy/5jiwEFhvW9Ma1ot73jyNVxoqNNBKwMft/azaKe1RjAOsuqBcDRdm7lVukanPEXMt
         PrzojRgJhM0JRPp4D1ROHGRPVmP27I5IRvnlh6Cr5QZGM4MDn0D3nW9iizrk3Mjw1KbO
         vmQB+30HU+sigfDUgjNmH+JHN8vt8GZtKP8sqlVn1qOw0Z2mkCZR0uOAWerLoDOCbi1m
         SKRw==
X-Forwarded-Encrypted: i=1; AJvYcCVFp4DLQwliAmmC1Yrj7rwJRpCXRa1kWroa3i8Z8SFKaf80yKH1U22K7e9KQK0KWUHhtcdl8uTSHQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzFNsXN0MA6HHBKn+N4YqQBl8ZrGacdWfpNICnQgVpxt7Jzv1zn
	r0VLWx82JqSn53jk8oGF49rk0tUmoRKPFE8g4skpv55m51EphUoq/f0H77O1Gl2KMR0=
X-Gm-Gg: ASbGncsYwSdN8yn5YzyK5jTazcUp8a4D4kuFrvhMd+UN5eAqbe83Z40KRGFHcd9O9C0
	J1vnfbcfVrFNizBX7yGcerb/PxzZyLN3EKgfF3NyW+Sip9xUHGHKEZUt33Oj1MIPF8gZrQsH1zL
	pOC27wvFHWwqi3Ogs6KZ89IOl22a8ZBjZhtBtTtWdeewrqwHnhDw9K/9xRZq3BDldlX9A6Vf09E
	K6dypaDFX+lJwJouu70hwDi4ME7VoC9bI+jWV8QMil6tDBISTkOS/plqYAYxkxwFU5SQER4uqHc
	Xf7kORj/GWfxofNXNYpq83WDzzPp0SSAbOiW4Ov07bvG2c5W8n35JyUfct0VwxPM+rE8k6I9fSD
	F0jgu36L9xxi1ZSODJ//C5xKM+y+eOfQ2i+9LPLtLhPH/kz0O6b2y4F9Vm8lnoxTU9Ft7qtFuIt
	cDC4xv9dzsUEa9fUjP
X-Google-Smtp-Source: AGHT+IEGmqq9cm1Rvzfb24khZSYsFQ/PTegAXxlroACoBA1TR3Jjri85Sv8tMmwxWc3nu0kMo6BtTg==
X-Received: by 2002:a05:6402:3586:b0:640:be87:a86b with SMTP id 4fb4d7f45d1cf-6413f20751dmr291297a12.5.1762456111545;
        Thu, 06 Nov 2025 11:08:31 -0800 (PST)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bfa2510esm26739566b.72.2025.11.06.11.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 11:08:31 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 06 Nov 2025 20:07:17 +0100
Subject: [PATCH 10/13] powercap: dtpm: Simplify with
 of_machine_get_match_data()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-b4-of-match-matchine-data-v1-10-d780ea1780c2@linaro.org>
References: <20251106-b4-of-match-matchine-data-v1-0-d780ea1780c2@linaro.org>
In-Reply-To: <20251106-b4-of-match-matchine-data-v1-0-d780ea1780c2@linaro.org>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Yangtao Li <tiny.windzz@gmail.com>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Maximilian Luz <luzmaximilian@gmail.com>, Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-arm-msm@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
 linux-tegra@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1300;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=HOTpv8E7M3Z9++7bQRRNeja2y7FI7o/hDZwnKU6ywmQ=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpDPIRDZSYvV0FBFCASolVOhNlK7njoQDy3PwX0
 i7RMv6QCVOJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaQzyEQAKCRDBN2bmhouD
 1wd5EACGaqsvVT3xObFDDX807YvuxJRMQZS0dyrF8dltJn/jHXr9MltK8ElySvuXxUPZVbULgd0
 le0nPfD5i+yDCZwLJWBEAZq8oTf6EHNCE3WgynJjTo4kFUGMXzSETGrx/kmGFxkBzQv1Dn39yxb
 vUWKEup8cvAG18aKjCULWPJ7aNkhz6kU0nHgpW66/doZbnzb6CqiEueH27bTlRCitUr3ep1Kuq5
 SuDr6N94nufPMfsdLhwTd12vj3PdSThfGyhNgaKf9HLXQn05wbhCI3BD7PoA0K89LaVpaOKa2rn
 DZxbnalo2fZ8Oeos8raJNEBXaIbomLAyUdLv4PNNcFRy2eScnYQ8W8RuChNnG/zq8i+qI5cFQaP
 6X3kIJ6Px5Emth9Y+nirUwVywykg7EijzEb2b5GTNElBqh1LyEz720BQvwNlJ7Wc09JThLyN+KT
 EpvtiQ/eUGsgDiS+iXiZ1Yv/bLr4x9nMh0SgD6IUrlAT3mrTozJV+Eibc2x/RSg9qpdQy0Cz2cb
 A/VqfFcyYGpOANT8Fz/xAH8Og2Qg7+WtHSgi4sTC07vITCQ5A/jtvoYERkc7BKZr6xmk4CRHmJm
 n4/r1xT3V8o33Zg5qyS5iv71pA04d89pkTmBVszpfDNqJgwVj9nH4c5hEyjkB4B2cxUd4vfgw1M
 WFbv0ljiRR0CwPA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Replace open-coded getting root OF node, matching against it and getting
the match data with new of_machine_get_match_data() helper.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Depends on the first OF patch.
---
 drivers/powercap/dtpm.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/powercap/dtpm.c b/drivers/powercap/dtpm.c
index f390665743c4..129d55bc705c 100644
--- a/drivers/powercap/dtpm.c
+++ b/drivers/powercap/dtpm.c
@@ -548,9 +548,7 @@ static int dtpm_for_each_child(const struct dtpm_node *hierarchy,
  */
 int dtpm_create_hierarchy(struct of_device_id *dtpm_match_table)
 {
-	const struct of_device_id *match;
 	const struct dtpm_node *hierarchy;
-	struct device_node *np;
 	int i, ret;
 
 	mutex_lock(&dtpm_lock);
@@ -567,19 +565,7 @@ int dtpm_create_hierarchy(struct of_device_id *dtpm_match_table)
 		goto out_pct;
 	}
 
-	ret = -ENODEV;
-	np = of_find_node_by_path("/");
-	if (!np)
-		goto out_err;
-
-	match = of_match_node(dtpm_match_table, np);
-
-	of_node_put(np);
-
-	if (!match)
-		goto out_err;
-
-	hierarchy = match->data;
+	hierarchy = of_machine_get_match_data(dtpm_match_table);
 	if (!hierarchy) {
 		ret = -EFAULT;
 		goto out_err;

-- 
2.48.1



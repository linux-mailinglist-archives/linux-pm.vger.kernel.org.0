Return-Path: <linux-pm+bounces-25609-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D6DA91597
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 09:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C204C17EAD8
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 07:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41EB21D3DC;
	Thu, 17 Apr 2025 07:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NqPwu8O1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF2E21C19E
	for <linux-pm@vger.kernel.org>; Thu, 17 Apr 2025 07:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744876004; cv=none; b=cailWnyN0rxOftIJMvLZ5TNUA3jfoeJWwGpO7WUvwjWNVxBC+lAvE2tg+MhXFMvg965/A/4TbydNqyeKd/BOV/bcjOdzNfxq15Jmu2AN1aEX8ZjfPbOWHAUCghKSMhVAiQqWWKMz2MYxH5vEAZqCzs4pBrlbPZPoYjaTU5nJ0q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744876004; c=relaxed/simple;
	bh=tMQzWzBnniAx5rk+EeqFSOn4cd/MzHon/bXFCu4cUe8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tIdQjAacXOcjEiPi0F5FDPQds2hWlGsOoclx2NMP+kIAMRaBSW0FS+IIt22bpCD150jXAQcGCnoP1105Gw4fjlutKxOr8G7Py3EWFm1Eyb6gZlFOFXak64pVBzsB0YyGdGBUBoiDi3a6cy0u1swN5O3TswvcG/mGwxIx0xQjq/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NqPwu8O1; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3913290f754so83898f8f.1
        for <linux-pm@vger.kernel.org>; Thu, 17 Apr 2025 00:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744876000; x=1745480800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UqFJhe3fk5yFBKlXHJgDCuqjovr9ww4TiQotyaOjXdU=;
        b=NqPwu8O1ltH0PYNIj5UGuiy+t7C0b5BBvFsPnVmcr56t5KTAISMi3x5a5o5kybTLuR
         Dom+NU6wRfyaBFmvmZPsEzdHbFZi4Mmg4F04l0kvfbirjcpJOOF1mffqBPxKBiDTIlPO
         y11s5yiuS6I29+tztgKCLM5SkXypD6fB+B8m+MeVJCfBlM7kGYnneZzTjGWv3ZzNGn98
         cV7PfT9mf8c18Gg/WdPJG4wzMi+sHeR37MRzwq+kfPtSwz/G2/mvUbBSfPoEX7vezRVv
         Q+kMEIa0wF1iLqV/w2cSb+rJOAUazNqtbp7Bii2zeYzq+OOKFHTMpsOdsp9LO90Vzs13
         o4vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744876000; x=1745480800;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UqFJhe3fk5yFBKlXHJgDCuqjovr9ww4TiQotyaOjXdU=;
        b=eJGqvReYtwvmoeydv9w/Gz99CYVpdn+V5NN1rayz0zSeFBX67HrgLnEf0OGsxxYk8I
         mJy+wqZIDbifIuwzxhq9lsvoV3r8VH+f9x2lzwilMDmzuZi8r2qmyUrWM+MmhhTYkFC+
         ymmgosGJ77A8CgzikD53IooOw4CCBHX0PEh75fHp/F7HIgjtcVIcLIwQVikxYG1V3SDL
         VBdWJerRK3Gl7kAmtp8Mr52n3RO5AEtWpxLoSEIVM4tRkYbVlfc0jtx6aKV1RNt8r4lc
         55cBN/EYZ7wEBzmDnA1jWXvvC0ZiKs8RIp+/UcddbWYvkGD9GaJ66yR3fuFSUgEnjZGf
         kbDw==
X-Forwarded-Encrypted: i=1; AJvYcCUy8fJBGX9j1o5wTlQHSxAOa+TUMGWOvYXCjfnaJ3LEMpj5cVfcEvyIMU/SFLTdm/3cUp7CxhTLCQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjca3FJVbhDOlKwNHsIfBnqcVJXp6ChRPBj7u8cSNZGBftKp6m
	2Q57dr4+5AWGwcYiU6LyCgMZcuOpNoPwrj8BR4jY4AnCc/+yXUvGj3XzROZspm0=
X-Gm-Gg: ASbGncvGtvz/lpjPjKzy59Z1uYLJ84JFp54NlOTQZUMb19Eg9LCaARziLXQrs8vUJB0
	XHweKL3ed3mkF58FIAtk9zRjzsLyNcDNedJpCBxjKL+ATgW+CIxENvDC8Vq9RJQ+SoLdnAYr9B3
	fEPMEds5n5+bKhshoDueC0SkO84rIPWiC+xfKbLhDu2iTxHhXfXSIt/J6yeM5i5cVW2oUXmacSF
	RQlPuirzR57YOyEsyOSz1hIK/R7rqw1LTKQDEd4utAOPKr1jN/YRqsRghYiwIpGWbFO3AtGID6j
	pljzpVa7CrPe9/YKaacAivznOciqkejUlQQj85PUKkBoYrAKD4IDRj8sBK0EqAh2dp92vMSSggG
	1ftYd+0tefjcxjKpS
X-Google-Smtp-Source: AGHT+IGUHnidkuDlHE8kYyTwUeGcsum4lorsxEkRuIAHsC4LRbi3ea/WsFZ1fQruK2QZL3pK0Ycwkw==
X-Received: by 2002:a05:600c:4f53:b0:439:930a:58a6 with SMTP id 5b1f17b1804b1-44061ece26emr6534575e9.8.1744876000074;
        Thu, 17 Apr 2025 00:46:40 -0700 (PDT)
Received: from kuoka.. (46.150.74.144.lvv.nat.volia.net. [46.150.74.144])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4405b53f29fsm42835765e9.37.2025.04.17.00.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 00:46:39 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] thermal: hisi: Do not enable by default during compile testing
Date: Thu, 17 Apr 2025 09:46:37 +0200
Message-ID: <20250417074638.81329-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enabling the compile test should not cause automatic enabling of all
drivers, but only allow to choose to compile them.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

For longer rationale:
https://lore.kernel.org/all/191543a8-2e2e-4ac4-9b2b-d253820a0c9f@app.fastmail.com/
---
 drivers/thermal/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index d3f9686e26e7..510c2b821546 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -257,7 +257,7 @@ config HISI_THERMAL
 	depends on ARCH_HISI || COMPILE_TEST
 	depends on HAS_IOMEM
 	depends on OF
-	default y
+	default ARCH_HISI
 	help
 	  Enable this to plug hisilicon's thermal sensor driver into the Linux
 	  thermal framework. cpufreq is used as the cooling device to throttle
-- 
2.45.2



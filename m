Return-Path: <linux-pm+bounces-24864-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D328A7D03D
	for <lists+linux-pm@lfdr.de>; Sun,  6 Apr 2025 22:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 501517A34EB
	for <lists+linux-pm@lfdr.de>; Sun,  6 Apr 2025 20:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2735C1A7262;
	Sun,  6 Apr 2025 20:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C1g2Iqka"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416F919DF48
	for <linux-pm@vger.kernel.org>; Sun,  6 Apr 2025 20:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743971257; cv=none; b=lmoKpee72+AJPsimg+SIZqA1ikOvLdnUaYjPnr0iIHU0jdjHVde5mTLJTqtYa+7w7gllKCrFos5DglUtkqywVjMhSJ5rfSQr2x2Uan8ngFd3NdnNd0ZSzQAoYcI6L6tJF6REn4F7XYyR+Z8xkGLlUv9f+I2NNAe+5kp6CbnnIqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743971257; c=relaxed/simple;
	bh=2trunEferEiekSmXIbrvzSG43Kp36B1WcqzsiY1pYL0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YOXEDdS50qtjmpIywDTDt3P9znJH2pOeWJ0VzMvb0S+VKtHlEWl0q1nlCtyB/vNvLeOk4AAFmxHgRESzZAfPMdbrMk3csr6nC0zrQckG778R7wFoWoTzl8h1KZGqPtrTYT5zqv+GINOOhAQc7d5TQ6zWFHawgdoqMcjbykdK/Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C1g2Iqka; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3913290f754so448042f8f.1
        for <linux-pm@vger.kernel.org>; Sun, 06 Apr 2025 13:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743971254; x=1744576054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+eeXc831jTE7R3MUTxvHjz8t/oVP2t92OuvIkna8W9M=;
        b=C1g2IqkagIiWlTmspCU0t3MlTgpv+m3xtPybyXYYY0U8/yqEAePsmCvohjYPhE0k8i
         ySzOADRcZ0GY55if2xiWLOtFPTxrH63DeREXSwcRwAExCf5kmnvel2qj5H2m2eX4lDhq
         2Wv3yBambRhYdKuBc43NsHKOI6hypi73UCFRkdqOFHW+g15b6qYNKEYmXUcRRNKL9tQ1
         Hc1btS6Ll6/T1nS3G/V6iK6rKK6wI3z2Geo2j4WebgKuYtXfZgXnN3CSTiHNnYWMg31x
         pmsLrdgNufBEttqnNC7cN9N+VyFQxfKRYGLOLNZwcgqpibDZVktenmQ5qWW9LazMAA9z
         3pYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743971254; x=1744576054;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+eeXc831jTE7R3MUTxvHjz8t/oVP2t92OuvIkna8W9M=;
        b=T8TZqBI0Xtsossn7tOrX02GHS6SLK6vkc68iWLsetKZH0PsSisRaa+LtPD2DcYtR3i
         zxgFy/3JLNVYAKl6gO1xQymbTIWfHljI/+KdN344K5YLlGhUQjathJoc3aJfBroqUQVI
         wu0ivbt1B4axBClouiiJ7YNTiIyFJMCID6IYlRsoAl30nvJ0pa6mG5tmBNcWytaSfKcP
         rxo9hrSsBbsIluZe8Xf1zDRFpE5/f5GiUoOuuTdevFUfVu88xc9xb+GTVD4LSJqVscSh
         Eo509/jwNHHQXiCkJ3XepSnPOUJKcXTEC+GB/li2R+CSuvZcj6CDls1mQVwEkW4uthDC
         MNXg==
X-Forwarded-Encrypted: i=1; AJvYcCWleK3PB54pLxs0BWxnaSyppmCH+GXdW4rECrUmcxWx7NZ6btMr7rmXRNUvtw3gyYpidzkPTBxhJw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq3sYCrfqwgTFd3GqW+gfjMajuDfqKjcMOkunYgW4g60ggXQK5
	r//zkBHx5p9mI5tN7BfwJXnGcombZgnebAo/EIAsxo63msxoYKVKcGInC/lXZczYbFuv0+3qdOd
	B
X-Gm-Gg: ASbGncvanHpDMXq/AmVEhv8H/ayugy/HLGyQtEIYQlOcaSqjsO4/dbGSOWKclkOTJ5/
	c9v79bIQ6zy7HZugqkJ6xS8gLf1rGV4qsVV6mJE0RnbYWHmNi5kdskvieGlSH0a83LAdp+at9bX
	dMv7eglKrpbonV3mF6gPolYqaMf2lHg353gDQWrJcsvlyBlznUnMizudg9jpdAxgmULqWnHzBDn
	wwA5DKZSiy/LvtTjPalsw9pdsJLZmJ3Ozdwzl1mMRvxMzwS12TjJWMK4Ufm7lDXANmPXDqm1ZPL
	q+dcZGgV/7LSe+sWunFpWMG1XelDfd6kHVZjfOGF+elT6hxAbKCSIQ==
X-Google-Smtp-Source: AGHT+IFoPbEvAK3UvI53U2L+ZD0sPGTteZiiWX2CiOJzo0vzUR9TlCHv4Yl0XzwNrZIEdAf11Yyewg==
X-Received: by 2002:a05:600c:3592:b0:439:9ec5:dfa with SMTP id 5b1f17b1804b1-43ecfa18f83mr33929465e9.7.1743971253632;
        Sun, 06 Apr 2025 13:27:33 -0700 (PDT)
Received: from shite.. ([178.197.198.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec1663053sm112207355e9.15.2025.04.06.13.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Apr 2025 13:27:33 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] power: supply: collie: Fix wakeup source leaks on device unbind
Date: Sun,  6 Apr 2025 22:27:29 +0200
Message-ID: <20250406202730.55096-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Device can be unbound, so driver must also release memory for the wakeup
source.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/power/supply/collie_battery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/supply/collie_battery.c b/drivers/power/supply/collie_battery.c
index 68390bd1004f..3daf7befc0bf 100644
--- a/drivers/power/supply/collie_battery.c
+++ b/drivers/power/supply/collie_battery.c
@@ -440,6 +440,7 @@ static int collie_bat_probe(struct ucb1x00_dev *dev)
 
 static void collie_bat_remove(struct ucb1x00_dev *dev)
 {
+	device_init_wakeup(&ucb->dev, 0);
 	free_irq(gpiod_to_irq(collie_bat_main.gpio_full), &collie_bat_main);
 	power_supply_unregister(collie_bat_bu.psy);
 	power_supply_unregister(collie_bat_main.psy);
-- 
2.45.2



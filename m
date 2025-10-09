Return-Path: <linux-pm+bounces-35875-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2DBBCA95A
	for <lists+linux-pm@lfdr.de>; Thu, 09 Oct 2025 20:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9568B4FB7C9
	for <lists+linux-pm@lfdr.de>; Thu,  9 Oct 2025 18:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6D524A049;
	Thu,  9 Oct 2025 18:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+5Plnch"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B122B1BFE00
	for <linux-pm@vger.kernel.org>; Thu,  9 Oct 2025 18:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760035070; cv=none; b=hyOcS6k3NBjt1eZvv137c3z0p1HIaUyfh632TiGmNq0o4WuxAGkEgZA6WQIxwt6aPDpNEJ9p99r3k2+yY8F/cArbH+plaN3QcYoeZBohpYAdtf0Sa6Wt8rj+p89C9vXdhlLC63EB/Xir8nUXd/F2CMN1Z9GpGiYwUfzCVlw7ThA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760035070; c=relaxed/simple;
	bh=PDh+AfzjhV3uXacrn4srFE3snwuuql5OJ6C9U1sJEIU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XiWvwZo7QFsTCyHD/Bg7QPIrB/rtFA5x/rhDSDQO4UqqFD7IMKf7MtJWY5qK60fgtmnwHTyb9u1jlZxaQ+RiU6sAjHlQAg+hbrwn6ivf3+kHMzJW5qhBfwZtfzZ1UUELbXK3EsW6JQ6fzdoYlAyrbfMYmiMhIUF0Pccn6nNnbLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P+5Plnch; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7811a02316bso931977b3a.3
        for <linux-pm@vger.kernel.org>; Thu, 09 Oct 2025 11:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760035068; x=1760639868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OLBmvaasF2LSEi3ZR2o1HrWy9QPsvaaeIfrmaMHo1Zw=;
        b=P+5Plnch7cVC+pPy69mOpbxpSzHv8M5Rs6v2W6y4vraAELZ7GgTy6e4KSz5vxIKC/5
         xAy5mPJHupbFRXaSpatn2erlcs5sd+xZz/66dDKyMJaFFPvuyBui4qFjlBQwWvGBIpfj
         HHh9EZTKOXJK9jpSaGymNh2aKt2dzRZKLHVGrcNr/K2u6vDBZ+EdBmuZ/tZ3Na1XMAd6
         WCOLgmw5hRedVVg24iVa28YD8nfeuAc8K30VjhOFKSlyH+eu7AsvSgnJCjDuxlLPwHeN
         pkWa0tBhRrUMtziCHloR/qtrv2eo+GQVXLZUMw3TaTg7RXrV+c46M9zx1hyi+w7BKsI+
         UTRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760035068; x=1760639868;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OLBmvaasF2LSEi3ZR2o1HrWy9QPsvaaeIfrmaMHo1Zw=;
        b=SGsuZYUq4iL/NmKIG6LlZ3zmBQIWF3cuLIu/YOOABFW6/VpY3dfiPRPwbI+M1xUcA6
         I0Fl5KcnJ9ov8sKt4XWHy8OSyHIRELO3LnTX0o6qJF+5Ch41n1EBRVvqoc8FFQmAUGNO
         jTRfdT2XYdT85dtn00t53aRTggHI+/1rtq3C3KRKjw2lYyAQGvVGhW7IvrRHhdMHAXtN
         sbGA/oJXxMXK6l0GN5UMXFIQDj6hAnUBKH2P7JkxPqbmuS8wjSe1RQna9LgMUCEm6AeQ
         DiKucbd9Jwt9V66HxIFK5FhB2HXpiALQuiRdEcLLjVOqhaGWf0sQyWaldhLxOzPNMla7
         srgQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7VnYF/jzn2zjx69npKhASSzOSawgDlPWNGKaQQPvZ/Tya7yqvkhePl5DMlk+90thk/zMqJGFRBg==@vger.kernel.org
X-Gm-Message-State: AOJu0YythafIf1ADpPtkIT8Dxs0nooVgJMJAvcuWGuHiNfRLNqHGxe5f
	RBzrCvGBjCan0clvQ1kuqEybHkclUX4qPbWSU8/SJZuYV+ihnusE8zA=
X-Gm-Gg: ASbGncvCCiTqYAZt3e3zH6uzYZv3T+IP4KJWz0UC+DCAj4SLWndExIkJXhA0hdxjTdY
	9SiLoXbgqdxXxe6gTM7RVLyfnE/pCebjc0S0/aoNbaQ73lqW9gD6yBVPiSqDBA9c9I3B0nVVjCl
	+YyqpZ5c4TRWGHb880yWDgLmuD0T7DhJlJRvKP26ZVO7XSZ0ncQ8sONibKKsrnTRUTg6oy9CZ1i
	8Ewq8DfmGYUt3EVbCwTqE8AsNXaMFX91HFkmX/1R01KOhGQADcYO85ukTCVJErHtTWEtqalv957
	D7dB+rs7ZknKUb0ZQEgYBU4lBdQHApmzSudP/s1nnvuryeZW8WZ+fE7dy2R8JSZxCFpp7XIWyLu
	YuGWPkgmf8+4Tb0wI8uZHMUxy7f9G17cHUmokXsydnplhoVipBgE1dEdKnswsVtAz0A+cdEQwht
	2M/9bUNNNbAg==
X-Google-Smtp-Source: AGHT+IHufRCD1gspY8glmM8lax7BUG8ynHHaY9o6yM1T8DIIM/vktiuj0NUkBXjxADybbCWs5+RgFg==
X-Received: by 2002:a05:6a00:1894:b0:776:130f:e1a1 with SMTP id d2e1a72fcca58-79385709579mr9273576b3a.5.1760035067817;
        Thu, 09 Oct 2025 11:37:47 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009.. ([171.78.199.202])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d0c3a38sm411630b3a.41.2025.10.09.11.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 11:37:47 -0700 (PDT)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: 
Cc: atharvatiwarilinuxdev@gmail.com,
	Sven Peter <sven@kernel.org>,
	Janne Grunau <j@jannau.net>,
	Neal Gompa <neal@gompa.dev>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Sebastian Reichel <sre@kernel.org>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH] macsmc: check for missing SMC to avoid crash
Date: Fri, 10 Oct 2025 00:07:32 +0530
Message-ID: <20251009183735.1288-1-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Users might manually install these drivers
without the core SMC device, causing
a NULL deref. Add a guard and return -ENODEV.

Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
---
 drivers/gpio/gpio-macsmc.c          | 3 +++
 drivers/power/reset/macsmc-reboot.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/gpio/gpio-macsmc.c b/drivers/gpio/gpio-macsmc.c
index 30ef258e7655..7048b45953bb 100644
--- a/drivers/gpio/gpio-macsmc.c
+++ b/drivers/gpio/gpio-macsmc.c
@@ -238,6 +238,9 @@ static int macsmc_gpio_probe(struct platform_device *pdev)
 	smc_key key;
 	int ret;
 
+	if (!smc)
+		return -ENODEV;
+
 	smcgp = devm_kzalloc(&pdev->dev, sizeof(*smcgp), GFP_KERNEL);
 	if (!smcgp)
 		return -ENOMEM;
diff --git a/drivers/power/reset/macsmc-reboot.c b/drivers/power/reset/macsmc-reboot.c
index e9702acdd366..739f94e4ed7e 100644
--- a/drivers/power/reset/macsmc-reboot.c
+++ b/drivers/power/reset/macsmc-reboot.c
@@ -205,6 +205,9 @@ static int macsmc_reboot_probe(struct platform_device *pdev)
 	struct macsmc_reboot *reboot;
 	int ret, i;
 
+	if (!smc)
+		return -ENODEV;
+
 	reboot = devm_kzalloc(&pdev->dev, sizeof(*reboot), GFP_KERNEL);
 	if (!reboot)
 		return -ENOMEM;
-- 
2.43.0



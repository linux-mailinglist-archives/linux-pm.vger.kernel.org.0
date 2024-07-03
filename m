Return-Path: <linux-pm+bounces-10496-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9964D925568
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 10:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C89C71C22938
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 08:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DEF713A24A;
	Wed,  3 Jul 2024 08:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qkVlAguq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994A4139CE2
	for <linux-pm@vger.kernel.org>; Wed,  3 Jul 2024 08:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719995508; cv=none; b=QVfM8tGdFSPoVcNGvSzViWB9ZoH2xKORqVrwdt4Q/aBXpx7ZkWzfUw8qxHzJ2tmdB4QIPtLLoTVtdFWWPz7bKkzuLBJMQc2aZVN/qUvTwFdnWZhZPbZdPXV513rAyRlNq94aflHPe5KpXWOPVi2gcjRg4DEZAUhYqATBefZ2nHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719995508; c=relaxed/simple;
	bh=MfodZhw6wqwm+KdOAVJKhOoBroy/mireXwrflb4wKDY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EHkwOgPhzMv8Vrq5xPUNsW9wM0W29irZSYfFKDbPBaRBCWR++OeQVJR+4dkla06zNbGsev4mzPzSrTX6GcG7FAw5qMnu+C7ToIUrIO+og6G+0UNJygSqc1obq1WfkzkX/Fy+egYYxLAtjrKclhXEvV5xyrd8h3RpAO2zLQPwWG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qkVlAguq; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3678aa359b7so206831f8f.1
        for <linux-pm@vger.kernel.org>; Wed, 03 Jul 2024 01:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719995505; x=1720600305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3VP4MnQr+WACum1CwdOlIRBuXxMYcYWr2PcT/gMfoII=;
        b=qkVlAguqZLglVV/vFa5mWMJ6ZVGpnHFTNxol0P85oZVZ9nhdAqYCOa6bClv/zYuEFI
         51EneSDhe083aRb3r3YvG16UeempTvBsKwzOb/N4EAmDn2lY9rw188AKosf2FGNkzrLi
         QCM9treTk1mkWSKrWCspJrINAdYH0p1S2xerbO/Vqb4rl27kVyAOP/jgf5FhWirRS1aD
         huA3AP8PI2Uxf+BSlY3zY0BSuClUB5IV6RNTecvZeesMXt9AYU/+OO2nR0V5qws3TjHQ
         IDb6nQKupMd8XuOT79FYHvrlHQL+eSzaYDap0PTWiuLYXR3M6hHZ/M7Yo3Y3P3jDJC5T
         RejQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719995505; x=1720600305;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3VP4MnQr+WACum1CwdOlIRBuXxMYcYWr2PcT/gMfoII=;
        b=eXdl9l7n/xlJkizKFGy8opJJODxzDw/xcKJBYLPPL/5FE4a5cjUXhBwGLx8mIAVtT1
         RXQQTpubaVE7ZIc0QBStjDYtZVkjs+kOA9H6yBLduaOJiq0hfBwiyvpZUuCyi9pXk8VP
         LghtFuyDMEPyE5N98kn4NCdzrGiy6vT/P2uKb3Ok4mRVthDsJSP3CX6tqHjKKNokBJG4
         mFRnu2jodTYGKMMB0daD/Nb0O12QaSjDNOeWKq383gRTHhz5BAMsFA80Iliq6bw9cP8h
         GwWOg00TwXfilL8U3ImIuCExRDCJykKUtgSuExVhAwi46s/He22bgJpMHb5wB/OdHQuI
         1kJA==
X-Forwarded-Encrypted: i=1; AJvYcCUYSNPnS8/2BPDzngiokfuhjtz75UeqZFwm/F0PJkW2GgqDbVQ8jXzXg9oOL6h/9YZOWxYW9IqlQnauZp+I4Hj9hOwCzDDlVVY=
X-Gm-Message-State: AOJu0YyagPozd6iMsFLO70PdHZXW40uN5NHqNnEIOozDErdD+R2v3bGs
	/nQyTLdRTS6TeND2tCVeG9T3LHhS8C1rnEFgUDEHwDOTgZh+eqlhjrZ5WZCgunIde7knRZVlZwG
	B4yQ=
X-Google-Smtp-Source: AGHT+IFBH1voc5J1DwfojucvG/DINJYJJJCW/Z+FlXFubjtsCO7GvpB0u97oe/2U7GBzryGD2ZWhVw==
X-Received: by 2002:a05:6000:e89:b0:362:b906:11f2 with SMTP id ffacd0b85a97d-367947f87fcmr848774f8f.34.1719995505166;
        Wed, 03 Jul 2024 01:31:45 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256af5b677sm226141665e9.18.2024.07.03.01.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 01:31:44 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] thermal: constify 'type' in devm_thermal_of_cooling_device_register()
Date: Wed,  3 Jul 2024 10:31:41 +0200
Message-ID: <20240703083141.96013-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'type' string passed to thermal_of_cooling_device_register() is a
'const char *', so make the same in the devm interface.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/thermal/thermal_core.c | 2 +-
 include/linux/thermal.h        | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 3fb55060646e..4ea27dd25477 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1132,7 +1132,7 @@ static void thermal_cooling_device_release(struct device *dev, void *res)
 struct thermal_cooling_device *
 devm_thermal_of_cooling_device_register(struct device *dev,
 				struct device_node *np,
-				char *type, void *devdata,
+				const char *type, void *devdata,
 				const struct thermal_cooling_device_ops *ops)
 {
 	struct thermal_cooling_device **ptr, *tcd;
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index f1155c0439c4..f732dab20368 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -261,7 +261,7 @@ thermal_of_cooling_device_register(struct device_node *np, const char *, void *,
 struct thermal_cooling_device *
 devm_thermal_of_cooling_device_register(struct device *dev,
 				struct device_node *np,
-				char *type, void *devdata,
+				const char *type, void *devdata,
 				const struct thermal_cooling_device_ops *ops);
 void thermal_cooling_device_update(struct thermal_cooling_device *);
 void thermal_cooling_device_unregister(struct thermal_cooling_device *);
@@ -305,7 +305,7 @@ thermal_of_cooling_device_register(struct device_node *np,
 static inline struct thermal_cooling_device *
 devm_thermal_of_cooling_device_register(struct device *dev,
 				struct device_node *np,
-				char *type, void *devdata,
+				const char *type, void *devdata,
 				const struct thermal_cooling_device_ops *ops)
 {
 	return ERR_PTR(-ENODEV);
-- 
2.43.0



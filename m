Return-Path: <linux-pm+bounces-24805-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7444BA7BCC8
	for <lists+linux-pm@lfdr.de>; Fri,  4 Apr 2025 14:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB1A03B52CF
	for <lists+linux-pm@lfdr.de>; Fri,  4 Apr 2025 12:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E22F1DB363;
	Fri,  4 Apr 2025 12:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ltm12TlY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7DF1DED42
	for <linux-pm@vger.kernel.org>; Fri,  4 Apr 2025 12:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743770406; cv=none; b=XZzXF8MH9k1lJdXqEtSJQfz8UVo7BH4LISe3geB8gcFXndO+esILQo9RyRavXTh0rOy7bJcAUp54LjBDdWVyABueiHjcESQi/lDZFLO5ImWiEIN0TFvd57j8ZVA5RZRfuDld8V9MzalNb2HElAvTpLNsnG3P9MDvVR4pK+zopqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743770406; c=relaxed/simple;
	bh=ow9gqO7eFp2FYxDOYnJaH2KbWRrtLsiqWzo5C4iyYoI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p357GN0itEufx4Izo6tJTZ1eRi2b7LtJuFrQsH9E2chp+J3GhCZBXgqsCtGV8N/rzkU+7jKenF/MNGznxNQSIg2DijSnRj+oMa0Zh0gVjubmvYUGp2ZuyM5l+7sZfn3WjjFWC1X6b+xWXGX2TaZXBM0shwf/GJxdYr2FGxCAPI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ltm12TlY; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3978ef9a778so171638f8f.0
        for <linux-pm@vger.kernel.org>; Fri, 04 Apr 2025 05:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743770403; x=1744375203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LXiYIvn+BUcCubjmRBFccQD3FCRydhDd1RRaxLlQdJw=;
        b=Ltm12TlYpzccwVKpicknmdaKFqEO7K55kTae4hNgQmWePKlAxfhZNPiB1WLLT3NU5i
         GZ+xnupH1ASjkxhOrCRn/FsJTlL7NFXGPVzULqIJLhHGJaTgx3WOT705thE3n941QR8Q
         Xpmog16qgg+IRIJpb/x2UDSIJ322aMWvhUq5NADrEZYGhv7j5yNY3LlSyP2GtRfE8YTG
         VeVRXGqzDPixLi/KUNZEmdz/5OIPZYjpU+pz1JNnfjCWMeb4lCEzqlQ5tBAKiWjodXXo
         6fZeXIy5PSDvW/y0Kuxtwi6Q2xtDl8QQddx3Jlgk81OHwzDPUCfRcThRWJrT52ouOi2q
         9y6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743770403; x=1744375203;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LXiYIvn+BUcCubjmRBFccQD3FCRydhDd1RRaxLlQdJw=;
        b=XHwFd1GDMoHQCqd7y8raMgq2m3v9TiT4qtz8nQSKqfO8OelDQL7S+/Cx1eVEi9rZH6
         VfFJc2GANLpdN4UByHs2/JbFkod/3QniYtrHAIOIbxJlBasryKq/qzFf7sBhf6JkEeTd
         yHRTEWczaNzRfr8v8FnWelvSWQIZ+1ZceR7BawRtb8lf9X/SYMtNOJszgJ0DWY7aAqTV
         es2eG/LR2jnR+fQ42cfOSwO1KjhIv/qxItZaALppPeP9c4VcK7GyxgI1bUBvJsnT3XSt
         z7x8rfyANTNIxVAvuEkRBlRZJY7atm+iIpKmQDt/sD7GQnCiNfgFNDBP1CExOnoeySyK
         wGTw==
X-Forwarded-Encrypted: i=1; AJvYcCWNOOYFl8VJ4PahFTcV2843cShqPFrLpxg8ITp6qggGGSNXcNXI6ovMV+2D4o9skkX1d7TlCw3pBQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3pFfrRPJeCF+bAkrJcVFpjFpiQouwakKRKN3Lq/N3f8iZER0b
	wS7hJ2fusE3/AXztEwtMxyu5i/n7et1YxVnAoI4WFhOdT5SnMRlRBkjk+wMFV+HK8fRSEC5ZfHl
	t
X-Gm-Gg: ASbGncuThaH5MEUvFLTHwkBO2bihzwy6W+6eKHmxj3Dgfq30EYHVdtKXzPldKbkpZCT
	j3GBjRpVuOBOlVH0UEa/a2dpWg8uUR8hMFHsyCM7YgojtlPRGaOs0q6cjn1kt4baWomidVVIjKT
	i0qluzoKFneraZBHshr5/LUXH8M+wNZQP73GuZZ/T+/pBk8Ft/R1JF4MRvWjUK3H2aPTICw1Qx5
	hQZl9W2FgkoY6iI6Cfw5bOZT0T3dbhI67/TyttXOo7+hLpPltzoU1a7kel/qtB9iYhyuN2Se01M
	CGYBG45c4PJgZ4cZWA0ojHUVZIAjmIQYVRPDaG8goGCapoG17xFnNA==
X-Google-Smtp-Source: AGHT+IE5wWt/yUGgqvhavSp6KwjTdVBZAE3cjP4dZHsK7r6/lTQwPIXiPHRLMZ4AJ3sKwHjJHHtgPw==
X-Received: by 2002:a05:6000:4022:b0:39c:30f1:beaa with SMTP id ffacd0b85a97d-39cb37a8010mr866634f8f.7.1743770403153;
        Fri, 04 Apr 2025 05:40:03 -0700 (PDT)
Received: from shite.. ([178.197.198.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c30226dfesm4308954f8f.97.2025.04.04.05.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 05:40:02 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] cpuidle: at91: Do not enable ARM_AT91_CPUIDLE by default during compile testing
Date: Fri,  4 Apr 2025 14:39:59 +0200
Message-ID: <20250404123959.362684-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enabling the compile test should not cause automatic enabling of all
drivers.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/cpuidle/Kconfig.arm | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
index a1ee475d180d..4d095f435b86 100644
--- a/drivers/cpuidle/Kconfig.arm
+++ b/drivers/cpuidle/Kconfig.arm
@@ -89,7 +89,7 @@ config ARM_U8500_CPUIDLE
 
 config ARM_AT91_CPUIDLE
 	bool "Cpu Idle Driver for the AT91 processors"
-	default y
+	default ARCH_AT91
 	depends on (ARCH_AT91 || COMPILE_TEST) && !ARM64
 	help
 	  Select this to enable cpuidle for AT91 processors.
-- 
2.45.2



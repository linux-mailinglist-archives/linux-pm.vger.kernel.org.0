Return-Path: <linux-pm+bounces-14293-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 315CD979549
	for <lists+linux-pm@lfdr.de>; Sun, 15 Sep 2024 10:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 643871C212B5
	for <lists+linux-pm@lfdr.de>; Sun, 15 Sep 2024 08:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E22381AD;
	Sun, 15 Sep 2024 08:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GuKF0fB7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC47247A73;
	Sun, 15 Sep 2024 08:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726387694; cv=none; b=WwvK4fypVXTPikOC3FaGZhDJvQiprr1yUMSxlYa7nUK39dFyfhmBd+Ma1SETNUnbqr5URHxv6jfphZhRQQ2vFA5eh2HU/TWuzJ6UF8eRkiGEB+zrRnRkk0K6Mk3DY/Soox8uGXZZGVd8KdTK9gP1XysuD6SpNlg/tr9sMwk642k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726387694; c=relaxed/simple;
	bh=D9QNipp2Cu8jdxZF2ATT6QNQY1AaJfGlXa9a8v3AUeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K5mLYeOf1H0zidEEOrw8s6TFZJ2y8qehpHxNSqS8fJCBNrM7EtMAYDHEYcPnkMOotZlcPIdNhdWvRxzVBnnYyeOB12B1oUWdjAwHhp/ZGCxrtd0vp7DipgYgqmi4yECotDJsCgtwMn1h2iIh2SM21xdzsO/ZpRd7FcUkaPGg9to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GuKF0fB7; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20696938f86so28433985ad.3;
        Sun, 15 Sep 2024 01:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726387692; x=1726992492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yMfm635R2ZedUv0K9CBomURZ5/GwgVeWzLysAHmmerM=;
        b=GuKF0fB78Dulv5kg0EeiIPcp72vf0vQds6QnZ98epGcDYZioraZtlY9+mlAUIsdbjl
         jRavfFcXh+0fZmde9M0ofvLRvHzJVM5vdSTV9VeXjb4jwU3pnJ8Mwk1DOfRYQsA7GhYw
         3wfOn8sEMxwmkvzxDEllKnwzZnUcs3Zqg0LY/t4hoL5gxCMXYq+VwU+MSTVtfIyg/DxL
         TV9PuUYrSQMhpvWc0fbR2HVIvGPKxSa+x2phf3BcAzkbmB4xlUi0xK02Q72+ec520qew
         CXiFJKMBMJFuE2Bhbl+LfL/or0LjDDTZt67aZAFssGDuiiI4VMxD4HuvU3jr+moBiP3P
         H35A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726387692; x=1726992492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yMfm635R2ZedUv0K9CBomURZ5/GwgVeWzLysAHmmerM=;
        b=V7FA02/4o0FGbNkA6/NzJ4K+mIZYxcC7TcKDYUrLA5dx22VRpDYfu0tjreSBznrw0y
         n0DvbRC/0l6OqICbiOLse/sQpCV/mbtrqy4+uIbrRcP53ko4aA8bUgjmmZsb+X4Dn5/j
         sSR7EIfhY/aJDNT6PAJjz3UGFIYUXGSNfkYqWl20Tp2gUWvY7mJW0aOSiUCKuOVeN/qm
         51H14KIqXsuuvNe2j+WZ96H9D1pv/hmWUBgisdznhUUGlmB6G0IVjjc0Gz1XD61EPCWW
         F11Z+zvj9OmFOLFUgtgOF1iaF1z61QdmT+diFiKh7mhoqx3Y/ky08RtqX56mgJ8zXHdV
         2bbA==
X-Forwarded-Encrypted: i=1; AJvYcCV2FAo1xSgdo5G8ze/kzVWbh/wz63srMxaenSeTNXvdtUyA74kmos/gBVL+AdR947XUbgyOQnFF+VQ=@vger.kernel.org, AJvYcCVdpPqpCQekproSr4411sXcxlnjr8z8Jald+vSiR/bTyrz1XLwEt+uMc3LJwczzDvyROw+idKRfoUU8XRj/@vger.kernel.org, AJvYcCX/seeJ3Yv92tA51Zoino4apo3DmtJ+iG20XK7pMGh9X8LJ4V5mMjf3Oeyfn5oIGpgb4FbO4LpBtz4+iQ==@vger.kernel.org, AJvYcCXCX+Il0GkgGVUSisB0bq/yFEw+0YqVAPhrHtQ7diROSc4TIfL4V4W99RyTzl4wcksDBa39XN394Hpgnipu62Q=@vger.kernel.org, AJvYcCXlrBG69aqmRYsnkxlsejRdIbN00ZJazsSk/dvwG+5pscGTSsA5JvVRZT9oTUlhvUU+3wMdWu4+FPsl@vger.kernel.org
X-Gm-Message-State: AOJu0YxYUTQc6HT5Qy4aiDLSHQLeYe88azyyZQwen8UqRibmTyXqBQbH
	ctzZC8tOeFSNl4WW/HU7ztxJHWpNQkgibne2ntniXDz7ACFt43Gf
X-Google-Smtp-Source: AGHT+IE/qszh+sXon9hFkSl0gzu7I4zOgWGsTfpxsj9vDQNvhH4nPsnn+vWNd3I1POQPX7CS1BPQRg==
X-Received: by 2002:a17:903:2302:b0:207:6e8:1d84 with SMTP id d9443c01a7336-2076e415244mr193313555ad.42.1726387691965;
        Sun, 15 Sep 2024 01:08:11 -0700 (PDT)
Received: from localhost.localdomain ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-207945db012sm18248865ad.19.2024.09.15.01.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2024 01:08:11 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
To: Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Mark Kettenis <kettenis@openbsd.org>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-watchdog@vger.kernel.org
Cc: Nick Chan <towinchenmi@gmail.com>,
	Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>,
	Konrad Dybcio <konradybcio@kernel.org>
Subject: [PATCH v3 01/20] dt-bindings: arm: cpus: Add Apple A7-A11 CPU cores
Date: Sun, 15 Sep 2024 15:58:46 +0800
Message-ID: <20240915080733.3565-2-towinchenmi@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240915080733.3565-1-towinchenmi@gmail.com>
References: <20240915080733.3565-1-towinchenmi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the following CPU cores:

- apple,cyclone: A7 cores
- apple,typhoon: A8 cores
- apple,twister: A9 cores
- apple,hurricane-zephyr: A10 logical cores
- apple,monsoon: A11 performance cores
- apple,mistral: A11 efficiency cores

In the Apple A10, there are physical performance-efficiency cores that
forms logical cores to software depending on the current p-state, and
only one type of core may be active at one time.

This follows the existing newest-first order.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 Documentation/devicetree/bindings/arm/cpus.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
index f308ff6c3532..3959e022079f 100644
--- a/Documentation/devicetree/bindings/arm/cpus.yaml
+++ b/Documentation/devicetree/bindings/arm/cpus.yaml
@@ -89,6 +89,12 @@ properties:
       - apple,blizzard
       - apple,icestorm
       - apple,firestorm
+      - apple,mistral
+      - apple,monsoon
+      - apple,hurricane-zephyr
+      - apple,twister
+      - apple,typhoon
+      - apple,cyclone
       - arm,arm710t
       - arm,arm720t
       - arm,arm740t
-- 
2.46.0



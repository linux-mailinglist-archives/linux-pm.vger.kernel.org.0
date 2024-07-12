Return-Path: <linux-pm+bounces-11048-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C623B92FCD2
	for <lists+linux-pm@lfdr.de>; Fri, 12 Jul 2024 16:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53539B2262A
	for <lists+linux-pm@lfdr.de>; Fri, 12 Jul 2024 14:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E2C171E66;
	Fri, 12 Jul 2024 14:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="DOQoBHpE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2731428E5
	for <linux-pm@vger.kernel.org>; Fri, 12 Jul 2024 14:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720795557; cv=none; b=HKnIcBhFNnSlQb+2y9kplQhtzdoMOCT2Q0+EMD5Nk2rv+0XWx/hsVbxzYo7haX5/bx8SnV3IMos0b7XPxFXZ6whvjR+RWrpvaTPz6KdWbjZRHVlALrkG8OJIfdo0s81qaQ3zQOWwv1b4KN7fgvKqDtcW/9WZQPxf2LP0BJri+5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720795557; c=relaxed/simple;
	bh=23GKNyE9PLGr6YAiYTbtJm8q7GT6UoIX+SmnMPRgnhM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rXRwXNOxmYvze7eJT5eeGM0gR/HGe8Hxr+oLzREf3WjvRnkvYH2f10sj9xHoRQVpuA2/d/jTIgyeQQ8BGiHw2f+nQq+jj0U7Kvn4wArcmIJuuh4JlVfXGw76kHczAYe/E9mFILOlTDqkH4Z4Tn2JHtml1Gt05cEOzhbOQwJuRnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=DOQoBHpE; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4266ea6a488so16704805e9.1
        for <linux-pm@vger.kernel.org>; Fri, 12 Jul 2024 07:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1720795553; x=1721400353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r7DJWJIBnnLN7/m2qPdHFhTG1iO/GpmbvrntFpTu3ic=;
        b=DOQoBHpEX5SP4KiB0pKAbKTrkLhOfxC5SeKlk7mWT1zTgv20XVMeCC6go4O4oSBqm6
         uLSGbyS7fzmsf6vW62jy72UovOV+ORXq2wiQxgwaVZZtEO/q8L8+/6UDGAOPTKZYtOzS
         N8E6r4bYeCddarkfPBAi1JK4WQtExdxECHmHx1oKF+uumcOqSucH7/FubZtlgVvyoEnD
         4tqaUW010/xVnPMYWtD5la1sOYdVaX8OQ04O1P/pF0mgjy9Y+IASOqCGKFf+w5Xn5e8Z
         /sCb3q1pXM7xi9/XIUj8iRAEo9ZBceiwMm3PhP5n3ctXchmQmUmLz1sjyQhtG62jKxLU
         imdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720795553; x=1721400353;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r7DJWJIBnnLN7/m2qPdHFhTG1iO/GpmbvrntFpTu3ic=;
        b=k78yDGLtFpRDhQaFX7Ucxazb1bU2gJHH9Ebj6eYRDAMMCqB7LW/IylLmBzyZ1O0mXC
         2UYKWXMqJtKj1PXxs7RuvucpM/G83/N2jx21mjXFmhaOPNr7VWeDvm+VbM2LLldlQZeK
         rbY46Orc3BJCevzBHt9c7ZT3hT++v2nXVsYwB3aIX650n+zWJkBa2ZFFxBUUUFIzxwGZ
         8dxmtd61OtPfuRdNQVghREtr+8mbJ2Qy26sUjT3x7GvLZxo6x4LkpTat88G3UACNB0KG
         dBoMWOlHycpjDPR7S7tec+MYFMwc0cnFISd5eaT6UETL/kqGi3dJgzcDHz0MdYy4HbuZ
         tPyQ==
X-Gm-Message-State: AOJu0YzY8OwmG6cA8r5NE/ULUtVMecip+dB/lSzoaqlTIwDCdgxCwvWI
	DRdsXQwyRzexjD9XCyLfQFou34BruPGwKbivsXovC81sDWbG6rthyPzmkzRN4WY=
X-Google-Smtp-Source: AGHT+IE/Bg/DxrK0231HQRehavFFx39v8TMrRX01cM7LMiVJJoDkf8F0um2u6yjqf0Pd+5Vl6oos9Q==
X-Received: by 2002:adf:eac9:0:b0:367:9511:b612 with SMTP id ffacd0b85a97d-367ceadc704mr9958447f8f.61.1720795553543;
        Fri, 12 Jul 2024 07:45:53 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:ac5f:fcfa:c856:a4d9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cdfab106sm10362309f8f.103.2024.07.12.07.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 07:45:53 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Dan Carpenter <dan.carpenter@linaro.org>,
	Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] power: sequencing: fix NULL-pointer dereference in error path
Date: Fri, 12 Jul 2024 16:45:46 +0200
Message-ID: <20240712144546.222119-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

We may call pwrseq_target_free() on a target without the final unit
assigned yet. In this case pwrseq_unit_put() will dereference
a NULL-pointer. Add a check to the latter function.

Fixes: 249ebf3f65f8 ("power: sequencing: implement the pwrseq core")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/linux-pm/62a3531e-9927-40f8-b587-254a2dfa47ef@stanley.mountain/
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/power/sequencing/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/power/sequencing/core.c b/drivers/power/sequencing/core.c
index 9c32b07a55e7..fe07100e4b33 100644
--- a/drivers/power/sequencing/core.c
+++ b/drivers/power/sequencing/core.c
@@ -119,7 +119,8 @@ static void pwrseq_unit_release(struct kref *ref);
 
 static void pwrseq_unit_put(struct pwrseq_unit *unit)
 {
-	kref_put(&unit->ref, pwrseq_unit_release);
+	if (unit)
+		kref_put(&unit->ref, pwrseq_unit_release);
 }
 
 /**
-- 
2.43.0



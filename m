Return-Path: <linux-pm+bounces-9255-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F8B909D8A
	for <lists+linux-pm@lfdr.de>; Sun, 16 Jun 2024 14:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 221C8281874
	for <lists+linux-pm@lfdr.de>; Sun, 16 Jun 2024 12:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E4D188CBA;
	Sun, 16 Jun 2024 12:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XEUtCrbx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95ED127715;
	Sun, 16 Jun 2024 12:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718541634; cv=none; b=aSzO+IUCdkXyAOqtnXDMLSfYgrS863Y62dzeC+zNQ5dc6Kwvp4AyiHnqo+9wbWeDWjqWcR8l5EMGopCDbNdH7wlispagWE+2cFvwAfKJpUOxeTPvhO0ToTqIc47fs8PavunhML5zmkcKiWxFNod0qpTY0ssMc/sanAHElNVl3lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718541634; c=relaxed/simple;
	bh=kh4SBs1iuR/dmF7U1ialUAeofMOP69AtRiRWSMbELjU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dqmZi1c5YFMQPfuPoOI8HitvARTLBz1cohsgq8QTawcXkHNbsNhe4uum3xKEd2jiMEGPZ3nt3Rrl2jw52ftcekjcKHDUkJeHin+mWOwaG/9weYPkNJjpI/a3TEQatG92zIkeZQHCTybXIJUOVVApyhogS5L8dLEtNsudmeI4kL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XEUtCrbx; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-6e54287a719so2498450a12.1;
        Sun, 16 Jun 2024 05:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718541633; x=1719146433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Th4pKF9/s3dW+P9pOVJw7H9YUblUSYJN89otavOb0J0=;
        b=XEUtCrbx+IZK/5qDiJQTmFNjBJEp+JhJm983GgWDTuz0vwtHfEnFFMZeDkGmb/CHIO
         sXkwTtqbI0CnJsJTu9C6niLAt5y8Hclh/Aq1h0qtrX8434cDAhftCYvujS6vCiVzh71o
         tbnMBioyjz58ZMeyIVg4zNN2eNwBCX64GOpObaKpGheGxBxvjPwoPcZplU2ljq8zapYz
         hYGgss93L35wsqn0hbyZN2u4Ttnm4Q6qGvQImCkVTQznVy/auSaRuaUwRZsVtFX0kV9V
         x65VmADV3yawbltMhsoKbyRtSFT6a2/7aBeQrQLAnSF39ztgIOgn6WCyIedc8cf8ZzIF
         oEfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718541633; x=1719146433;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Th4pKF9/s3dW+P9pOVJw7H9YUblUSYJN89otavOb0J0=;
        b=sep3aldhWGrwkfue0VtkyIlO6Gjli+mQx4RF7wxJV8Nqi2K8M1dzPJJzyzwz3P9pL+
         /7LlaCaeySWJ0MGaH5omD/ugW2hkCrif2QwuUj7kPuy0kwhGTNA19LJdeDcg8nfNdl+A
         w0N0z/K+BmCrouXbVS1R0HD+z9FbooA6zyrmK8BcWKTFFCcmpjyPXsNNmHvDljIqJKWH
         O2eeO1yLHsFe0voo+r/8uItufJ8LO/HzgBM6LdMctNJzaEaWuKK1ZWmuLV8tPObZFXMi
         f613P1QHZf7TRDutkHyZ0bishxcKisYWYLkR+oZ/AgMoupYQkjmaqSm0bbDjYw2bZROi
         2bBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUqnNMOTx7tVAmyoJdGk7vfz+CU/hIfqyAudNxcLBT6hddHOMw0z7tLfPVTihkpdlizvrqkJ7H1N3xTxvOnTxk5+9f8u/3zilkw/IhEovPYGputYDMIZRsJ5NXuxs2SIy4jVt+tdc=
X-Gm-Message-State: AOJu0YyPJlKvmnoO7LIhi2JWeDNYtR2m75k3ZtMn7KOsWytBMwYzjLEY
	0VMe7kQclUBmmChIJh6SDL5RYbNQl6vrIt1pjjaqL4mFrdM8hYgh
X-Google-Smtp-Source: AGHT+IEln221nC0t3ihwuX9d9h3phGrIzOLbo3gL6MpW4guUSW1GHvuYlEu0NHq980CGjaLnbZVU0w==
X-Received: by 2002:a05:6a20:3d83:b0:1b5:d063:3396 with SMTP id adf61e73a8af0-1bae82c1a2bmr7305738637.59.1718541632647;
        Sun, 16 Jun 2024 05:40:32 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c009:5e72:16f8:1e08:52e3:fc76])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c4a75cdec7sm9570730a91.3.2024.06.16.05.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jun 2024 05:40:32 -0700 (PDT)
From: Atul Kumar Pant <atulpant.linux@gmail.com>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org
Cc: Atul Kumar Pant <atulpant.linux@gmail.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] cpuidle: governors: Fixes a typo in a comment
Date: Sun, 16 Jun 2024 18:10:25 +0530
Message-Id: <20240616124025.16477-1-atulpant.linux@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Atul Kumar Pant <atulpant.linux@gmail.com>
---
 drivers/cpuidle/governors/teo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/governors/teo.c
index 7244f71c5..95831d2a5 100644
--- a/drivers/cpuidle/governors/teo.c
+++ b/drivers/cpuidle/governors/teo.c
@@ -592,7 +592,7 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 	cpu_data->sleep_length_ns = duration_ns;
 
 	/*
-	 * If the closest expected timer is before the terget residency of the
+	 * If the closest expected timer is before the target residency of the
 	 * candidate state, a shallower one needs to be found.
 	 */
 	if (drv->states[idx].target_residency_ns > duration_ns) {
-- 
2.25.1



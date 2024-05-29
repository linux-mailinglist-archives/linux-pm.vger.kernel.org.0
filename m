Return-Path: <linux-pm+bounces-8381-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3646A8D386A
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2024 15:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB221B27924
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2024 13:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1CB1CAA2;
	Wed, 29 May 2024 13:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XuSJbFjw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B351C6A0;
	Wed, 29 May 2024 13:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716990785; cv=none; b=bWaL6dAjOAdtwZM61nANb3w4IkqmsaD5F+OiJcfTf91IN7xHpvA5nPZL7ESOC1HzYsEpbTiKsK2rPLNU4b6NgswTXXc6JX3CVDPNIMVE8soxcX1raJ1oU7kuwaU4S+uBNAJbZrfK5TtDosLU2VeqFGiDIpaujmeAhlxpv4cBMfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716990785; c=relaxed/simple;
	bh=MeITpEwUXih4cKm/2q1Fo2pjThG6jQN8OoV/4+Cv+IQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ej4RHS0Nf2ZZ8VNKCgmpHnAjeMdC32MRMhqyYYeVXdk87eBptLP1gohfMsvFj2j/2pzPEJB+sroFUTGfpbGaNmrFNyq5JKwZm/30F+3AuV79o45huq13eJ4H6B8kCwof66IiBmoa0OKJJ3Ef3+Q+RMSlt0XLuUChgKi7XyEzILw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XuSJbFjw; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-681953ad4f2so1625277a12.2;
        Wed, 29 May 2024 06:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716990784; x=1717595584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HYcaquZqfIygBp+Hz1qQPQQ7rOnstZmIu5jK+NQIEkE=;
        b=XuSJbFjwMRgbicOwWAIw0JRypGjX3F5l1P9ObWEqJs3InNbcYEzK2cvqP3+iP9A/ft
         DjLgbMKl7jySO0YTxnaqRGiBFR0szi+8MmHjxAi0yKpeH+r9bAs2tO9crHAvNpw63Lvx
         kFyxhbj0rH3Vp9WbWgLXxCyLSxEVUBLLbGmSFQ1giQtcUeybF0CBmfzIqszm986Jz0Sf
         uBKB3W1Pmddpul0GX8aqanSLAuFjv06zxVYi+vXe9Tft6h3un9/2ovfyCAmBKt3bO/kw
         ayBXZsgramLj+Pe2WcmdFlWERP+/XaCu7bEPM/GEDrkK+MNwUuGtE/IaPfpoT0T6LRhS
         wJvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716990784; x=1717595584;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HYcaquZqfIygBp+Hz1qQPQQ7rOnstZmIu5jK+NQIEkE=;
        b=UL5j1Qe/3frROgx/FhkxGS+oRxwrUhnUXqYwdxuH/xWgLXKQGQNujGtp65TZJGf3Oa
         TPwb/jFs7HvRzZAt7aZITP5N3X0TDX2yDGKC2Kjsq7ajngSgnmUkKT8bfbH6DCpfO5vy
         jw781p6TNaRa3TmHsomRDTvWOqjht4h5axfRXRFXeD5TaIv56fL5ioZAws4Uipgv/okC
         Sz2uQWGliJGwvz9L/09oASdMejq81UTp+qUbc5ILJUh1U1xpsp6GInD6L9cBP9/WQr1c
         ZL0dckm/QXs+yJOhI5i5PncMbAy9n8+VG73gTWtUdpNByMPyAUmCZ7An//el0nRuxpj/
         67AA==
X-Forwarded-Encrypted: i=1; AJvYcCVcBkMI4l2yGwOVtkRWLjVknHCMbGyAFdKUW9RlWrjoZTSjkPbhrvYb8JIuEjluFig5hSlMockuqzGQecD8ktCJ3L4Nq0g4eNUxaa4LV3IkZCS8mH1sCUeoEpFbPVqbWbtVCkFjPBM=
X-Gm-Message-State: AOJu0Yyh1jxPAO/DPiQfAQyxuaxUxWy5cNeK/hZ3IyJct3emjHR22jSF
	2xSLk5yPG3wKfoT7hbFz2A0ag3UGWxe0mQMbyEJrqDT76x2S/veh
X-Google-Smtp-Source: AGHT+IH0WFmsVE6mCRqRMqG+ExFQPwO76qjoaiGYyZKkxoTh3+r57ZLSyAeGpmI1GTPxce/BHcYmyQ==
X-Received: by 2002:a05:6a21:3995:b0:1b2:15ae:fad7 with SMTP id adf61e73a8af0-1b215aefd07mr16478425637.59.1716990783764;
        Wed, 29 May 2024 06:53:03 -0700 (PDT)
Received: from liu-System-Product-Name.hitronhub.home (123-192-80-75.dynamic.kbronet.com.tw. [123.192.80.75])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-701e30ef392sm2202868b3a.126.2024.05.29.06.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 06:53:03 -0700 (PDT)
From: Chia-Hao Liu <a0921444212@gmail.com>
To: lukasz.luba@arm.com
Cc: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	rui.zhang@intel.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chia-Hao Liu <a0921444212@gmail.com>
Subject: [PATCH 2/2] drivers: thermal: fix zero weighted request power
Date: Wed, 29 May 2024 21:52:47 +0800
Message-Id: <20240529135247.12737-1-a0921444212@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the product of weight and req_power is less than 1024,
the `frac_to_int()` macro causes the weighted_req_power to
become zero, it will cause granted_power to be zero.
To address issue, I add a check:
If the weight is less than 1024, frac_to_int() is not applied
to avoid setting the weighted_req_power to zero.

Signed-off-by: Chia-Hao Liu <a0921444212@gmail.com>
---
 drivers/thermal/gov_power_allocator.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index 336b48745..c878cbb62 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -434,10 +434,10 @@ static void allocate_power(struct thermal_zone_device *tz, int control_temp)
 		else
 			weight = instance->weight;
         
-        if (weight < 1024) 
-		    pa->weighted_req_power = weight * pa->req_power;
+		if (weight < 1024)
+			pa->weighted_req_power = weight * pa->req_power;
 		else
-            pa->weighted_req_power = frac_to_int(weight * pa->req_power);
+			pa->weighted_req_power = frac_to_int(weight * pa->req_power);
 
 		ret = cdev->ops->state2power(cdev, instance->lower,
 					     &pa->max_power);
-- 
2.34.1



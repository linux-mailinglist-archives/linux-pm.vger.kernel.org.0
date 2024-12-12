Return-Path: <linux-pm+bounces-19131-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A2A9EE754
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 14:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51C0318873B2
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 13:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE8B212F9E;
	Thu, 12 Dec 2024 13:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HtXPo7dn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED7B1EEE6
	for <linux-pm@vger.kernel.org>; Thu, 12 Dec 2024 13:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734008709; cv=none; b=iDSygxF0fcyyLgdxzT49cvD6OTYEdwOILYMDQCOWHoUwbgF047gngWFgLBJ991gmhjt6zrn/jydCkUaV+cjq9+nRNLfjLO6IWa1xm4xAaN/3XAqa7kme1oTidPSOv5m6QalPHFszxncYFY0/E1doRQVcUpLAHgziXINsRTmaneI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734008709; c=relaxed/simple;
	bh=rYnq0aqrIJMTKPo4hjf0/GkvxY/WiG4bL7Y/9E+s1jk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g0u3UuDq9Kx0Q4SdHBeIybyeaOFI8zHWEfB2wmkCW0eL/aC4VGoCmZ5zU2wf1QCknv0tWyIDVKoTAYHdUPffKWMNuTWarD9UJwQ8uXuho+KhdLNDDuxYgaPVIeATeAqAfvcwD0dOeBCyp/znO+tkr+BUppTqnd3O+L9rvTB/BnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HtXPo7dn; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21669fd5c7cso4809785ad.3
        for <linux-pm@vger.kernel.org>; Thu, 12 Dec 2024 05:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734008708; x=1734613508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BpGyFRxnTe3o19mkxTCsqcozZChRiTdOOydr9QyF298=;
        b=HtXPo7dnOxU8kK2M/Y2YXPrisDnu1IXawn1xhCig8iQi1aCbeQDpJSvwjjo12GAf0K
         gNDakvbxeToeqsKA7uOuQtVE1/RLPbAg+3iimx8KajQc+PxKK26wigL6obl7j7s2FJSi
         4wjogxeCIyYGUWSVFJqvQoWCvthbWWsqIcCzyOlpYQyT7lQ/5TxddyrZXhflaEyhCWCL
         N7du+f72ZllnwicW5Mh9C4MH8qBrqgwXDXc0Xi7i7Jbsuhv40iQ9kfa7TgVpHhrNcBEo
         v7B5uVqmF5Z+1HogvUih7/lWWyfqsP6VQbJjNWvMOxBlpqk+bp1F7IJMjxcehGbTg7s7
         2z+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734008708; x=1734613508;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BpGyFRxnTe3o19mkxTCsqcozZChRiTdOOydr9QyF298=;
        b=jJ+6Fnplrx9JkqilYDPi6bTE8m8PRuiVsk8IHgC/lIHK2rIDT3cH1FtN1/oMNdopKV
         8lx8wRNd3LNG6BDcb+LcevOBcr8iuvqjB01/Y6dDabFke+94YDFS4LN1ha7Vv2aEwFq0
         FcUdwjl2AcL+aciZ9dW0bjkJT+dvrCS0F5lunY9TFrm77Gygdao+MqMhdbRTylGB2Mqo
         GzleMe9aqjFQAkr+U9aqCfRSWtMOvhmuUrnPmVe1MSBLyT41wTUWf7d3jAj96Slj5EyO
         vzHVLft47I1RDls2k9c9efW/6pvMm02Zc3n4TwY5Co0VlbosJr4QCoFveoRrn8203XcA
         3NvA==
X-Gm-Message-State: AOJu0YwbNUu5l/7NWdGPGSGUMQoE+POWZXhjX1lrSvX5F0QuudoLbM6I
	oCjDhP2WGKYKTKdsmFcC1QpiravZTaAMKdixLW5fSVY30+icA5NsCi4dCw==
X-Gm-Gg: ASbGncsUu3shhA7yL0cYBmkeaDGLAhl/ZmlQroBhMIPKv8KUrdR8KRbRjg5gvdKoJMS
	OxirZ1u94YYB8oC3hTlub/u06z/YJ+t42d/lHdMAJYItO6x3I9R4bdLMBmggqOHGiWdT4POgx3f
	A1I6YOg34oE9LAV3d5CPmWJ0EV6xefRv/QM2BQhCanhDhzLOJMBv/549uB4cu4Xt+pxAzRfJks0
	3dTL/XEt+nZsOZpt9eCHFcA3rq5leQ6cd2mHjgSqShss+dxgbkI/3rmQcnYU92r3Az5mUs=
X-Google-Smtp-Source: AGHT+IFBQDyUXZszJP3ptKndtfi+bsOwCtWevUJIKxcKAWmeYps+JdHs8r8oVw657weH3Du8YuTlLA==
X-Received: by 2002:a17:902:f608:b0:216:554a:2127 with SMTP id d9443c01a7336-2178aec111fmr62922115ad.41.1734008707516;
        Thu, 12 Dec 2024 05:05:07 -0800 (PST)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:1176:b16b:e3e7:580d])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd484640aasm6403429a12.22.2024.12.12.05.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 05:05:06 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: sre@kernel.org
Cc: linux-pm@vger.kernel.org,
	Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] power: reset: gpio-poweroff: Clarify the warning message
Date: Thu, 12 Dec 2024 10:04:56 -0300
Message-Id: <20241212130456.580197-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When gpio-poweroff fails, a WARN_ON() is triggered without
an explanation to the user about the failure.

Add some comments explaining that the attempt to poweroff the system
via gpio-poweroff failed and convert it to a WARN() message with a
bit of context to provide some hint to the user.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 drivers/power/reset/gpio-poweroff.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/power/reset/gpio-poweroff.c b/drivers/power/reset/gpio-poweroff.c
index 52cfeee2cb28..3eaae352ffb9 100644
--- a/drivers/power/reset/gpio-poweroff.c
+++ b/drivers/power/reset/gpio-poweroff.c
@@ -44,7 +44,13 @@ static int gpio_poweroff_do_poweroff(struct sys_off_data *data)
 	/* give it some time */
 	mdelay(gpio_poweroff->timeout_ms);
 
-	WARN_ON(1);
+	/*
+	 * If code reaches this point, it means that gpio-poweroff has failed
+	 * to actually power off the system.
+	 * Warn the user that the attempt to poweroff via gpio-poweroff
+	 * has gone wrong.
+	 */
+	WARN(1, "Failed to poweroff via gpio-poweroff mechanism\n");
 
 	return NOTIFY_DONE;
 }
-- 
2.34.1



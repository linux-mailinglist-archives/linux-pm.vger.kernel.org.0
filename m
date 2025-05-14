Return-Path: <linux-pm+bounces-27164-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E32C1AB7816
	for <lists+linux-pm@lfdr.de>; Wed, 14 May 2025 23:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 198737A65EA
	for <lists+linux-pm@lfdr.de>; Wed, 14 May 2025 21:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134BE221271;
	Wed, 14 May 2025 21:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PsQKDuuN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459EE170A0B;
	Wed, 14 May 2025 21:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747258801; cv=none; b=RSHPS8qlkZ11X4l52SyN8vxCy4WRFPSxHxOHVwY3W0MEaSSq8mDeeNcrxb6ZyJCxrzTV0yzuAvf9v7qokILQU0LuHjcaQVla+B3b0iD2aEUe/9vrZJGrjZXbcb+8qbGxz9AMz20WuqHMjyuyDca/rRtHdwVoxuPgsxuKYXdNzHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747258801; c=relaxed/simple;
	bh=IURAvQtt/axKYIqZpx8RM2/Z378J6+PcqELHyaH1Z3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CgdZzCcUEOt8qnrshBJ0kmiAURFBRgEYfUlGOtfwyEnM/pQ74+hDwnJhq8l0JD5dkhusak0bIg7wBCSOCfXm0a9LrqsdPTHcAEjH+LMCkzyQTFEjKbCXkVDKDdOBieYdhJosRv2vseJkMC5w6G2WNUm70PHsh3V8XWHZZ+6i6As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PsQKDuuN; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43cfe574976so1870055e9.1;
        Wed, 14 May 2025 14:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747258797; x=1747863597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6DVUkLd2+oHlU9eD7Q1RFXSgVfC01U9SYfc51OE9qKo=;
        b=PsQKDuuN7RAI2EZJvpFEInGbpfvagQNjlgJxQd+muutVn5EJUIPAPmto0h2VinIt5J
         YJYABT4tcYDO8KIQsEwsDoJlZA66kYtZfym9YaQJSgdMGE5ybHJjytqO0abmTMOw+i8D
         39L2y7AXs54q7fmG3rPaUloP/H0Ji1Q7pTtazIhhshwB8b/MfhXQhbtEapT9KrXmnJZe
         cvpFlJOSjjjHExVLZ5zTj9Lt47Dc2A66poTH8Qg4DtjPIVa6TMcsFaWa8caO5yV6FzqI
         ygTtYQe1OjvL061tvbVXBNUgkKioL4dX3gTvJtuI4h8j3mjbdD/5P0V2geC/kINmwPwa
         UDNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747258797; x=1747863597;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6DVUkLd2+oHlU9eD7Q1RFXSgVfC01U9SYfc51OE9qKo=;
        b=EGZWDH80QgfsxfSnvb0zLvAPFHW/czxEAsK0VceSp8nFLQWAIJ4y3uvbX6b9Re8Kt3
         H9SfZNA1s7fXNDsyf87w8My3FKzJUGZPPwH1OMo5sIAIf3wvtNTH2Mh1d/QFcjUFCnJN
         nRQsPh+ecIFxYZV1KfdTwRbAYgsLshaAvR9+CSAZncMtMv8RbbYFoeS8Z3ypCj9UVwCP
         j+xhXu57vwyL4fw5nFPSqvBQY8fw3DjIAyMoRoie+t5lDeJPZojLMYMixZe/VrUXGUDM
         fURtSpigPgtrVxlnNdec56fpACYdwSq40YxfOGXjgdvAP1PfBxZZKRw/iNPJZS5v8eNA
         rPlw==
X-Forwarded-Encrypted: i=1; AJvYcCW1Wl1XPcMoeeRqJ6/dwdyKKT+mHsaO53qCvsskHTxE7K3DW/D+wS8ID5HSa8XyCWNvi0Zw5+NiroyFcGY=@vger.kernel.org, AJvYcCWxXf4iynbkpk2FrCnGNhICSb5Z0TI2TyASVp/YVeMgXsoNqkDi0lSHJ4TuYUh4Mi8fRQI4IfgCOwI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxDpXxaPQHlr+aGtCjGMNsYY0vVfewp78ldzdnhNDrfQK+5Kb+
	ldVcUoe+xfE2Mpna0eNuLyviWdd09IHqpj+3NthVlO/KdOXlLVPm
X-Gm-Gg: ASbGncuUTF/1cCQ4Aavp/m/bHL+MsMwBF7CZraCyNS0/i4pWh0MRJeav2XPQG7niMsk
	Yeol/IAfr2B3DEJ+HgwdNmigkD8O9BU9GN0KgAzDD7KdyVQlUgTqg2ookFOy+jeVYhwFMkLXGAM
	teu7p5hiLos8685CmAJGgc2189uSD78dW6QLOAolzgNfYyPrV7Z4vLmDjb+GZac8HsK0HUJCeqq
	RtPovWhFWw4u+XyjRe27mFy8DFeHdN4X/JRMynHv2PeZqGtxkcmldPObN12qYh30ElLTSq7v5dC
	zuTPBVamgNPvDJ74PoWrCLmwbZFhwIwv15puH++rVAaopgolSkXxwDVTyc982cg0Ut1ZbMCHRlq
	g/s1Lo8RakwoPH4rJgAkD
X-Google-Smtp-Source: AGHT+IEetmnOgRCTSfIMvsWozvfB/jVXgNt0sQB1k2wskyHJG++w/QiJlg5bnKijUGzqM0dtGaqWyg==
X-Received: by 2002:a05:600c:5305:b0:43d:fa58:81d3 with SMTP id 5b1f17b1804b1-442f84cce76mr9357555e9.32.1747258797224;
        Wed, 14 May 2025 14:39:57 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-442f397b680sm45963285e9.40.2025.05.14.14.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 14:39:56 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>,
	ALOK TIWARI <alok.a.tiwari@oracle.com>
Subject: [PATCH] thermal: airoha: Fix spelling mistake
Date: Wed, 14 May 2025 23:39:12 +0200
Message-ID: <20250514213919.2321490-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix various spelling mistake in airoha_thermal_setup_monitor() and
define.

Reported-by: ALOK TIWARI <alok.a.tiwari@oracle.com>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/thermal/airoha_thermal.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/airoha_thermal.c b/drivers/thermal/airoha_thermal.c
index 45116cdaee65..9a7a702a17de 100644
--- a/drivers/thermal/airoha_thermal.c
+++ b/drivers/thermal/airoha_thermal.c
@@ -155,7 +155,7 @@
  * Can operate in:
  * - 1 sample
  * - 2 sample and make average of them
- * - 4,6,10,16 sample, drop max and min and make avgerage of them
+ * - 4,6,10,16 sample, drop max and min and make average of them
  */
 #define   EN7581_MSRCTL_1SAMPLE			0x0
 #define   EN7581_MSRCTL_AVG2SAMPLE		0x1
@@ -365,12 +365,12 @@ static void airoha_thermal_setup_monitor(struct airoha_thermal_priv *priv)
 	/*
 	 * Configure ADC valid reading addr
 	 * The AHB temp monitor system doesn't have direct access to the
-	 * thermal sensor. It does instead work by providing all kind of
-	 * address to configure how to access and setup an ADC for the
+	 * thermal sensor. It does instead work by providing various
+	 * addresses to configure how to access and setup an ADC for the
 	 * sensor. EN7581 supports only one sensor hence the
 	 * implementation is greatly simplified but the AHB supports
-	 * up to 4 different sensor from the same ADC that can be
-	 * switched by tuning the ADC mux or wiriting address.
+	 * up to 4 different sensors from the same ADC that can be
+	 * switched by tuning the ADC mux or writing address.
 	 *
 	 * We set valid instead of volt as we don't enable valid/volt
 	 * split reading and AHB read valid addr in such case.
-- 
2.48.1



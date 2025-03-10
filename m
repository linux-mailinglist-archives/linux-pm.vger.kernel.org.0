Return-Path: <linux-pm+bounces-23767-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59223A597B0
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 15:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25D933AB6FA
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 14:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD8F22D4FA;
	Mon, 10 Mar 2025 14:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gccDq3OB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F5E22D4E3;
	Mon, 10 Mar 2025 14:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741617318; cv=none; b=KhyUCcd/SsmvsRCMF05c9kLpVxYjpT9+06r9+T+k2xf7OFCW5p/sVcXCbtno2XJVpjOEuFjgVnhn8J5YFpOYs1Hef5CZ1iAZPihRXNVxY1S/kk1iqwRxoUOn1WYQ4rTx+v2qsObmTdRgXdbfUEceIQ1/HspeDHFRAjHC8sMaK3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741617318; c=relaxed/simple;
	bh=iFY0Z0lqufvrCBh7TuqQgZceY43vwZRtfNHs9cRGMzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bw3tWobYB8g8N5B7ubVnxCiug07zWLXSDECn/meA0X308oXI1NuTk79eMPOd0KpFdVqyqx9BXcV9JrJ6t89G8oa5kXQCxN7L0nbDWICByPpayKVElAQGWHg6ojz4EiG9A321GmdNVhcx4lT9L2jEg7aw56kbPXZ0uRci5FrA/UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gccDq3OB; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2239aa5da08so67682805ad.3;
        Mon, 10 Mar 2025 07:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741617316; x=1742222116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IS1K9x+4Zn/shvVhPm7Zn9q2gjfD6cEoR0irdxrqpfI=;
        b=gccDq3OBUXRS0ElF/xdWDeGlVqJfO/lMtVfbwMYKQK+RjAQrArDOEeei/jSIx9fKZO
         HkgRBMi31sWg1MKKzM49Yuej/iCxlnrA8+Zx8SM0fV/MZ9rymfHdQwDise2ZdSGV+Ocx
         iplFyus1XGbkoX/OKAkTGs4ZFWmq6IsyAHMuU91WXN+6w0OoLCrDRIZn9/8SARzBUkv8
         tCDSlSbiAqhQCPHjW57/+kT4qpCrSB3SFF+CuJ74CBOaLgJqPfM4S1RfmiFkzqmqCRuc
         TUoVdTP631QRpRwaPxTrH0FEuNO2eqfRztpfWLykWZQ0dBCQkD1T5Wd6HmhQ4/gbbJRK
         9/3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741617316; x=1742222116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IS1K9x+4Zn/shvVhPm7Zn9q2gjfD6cEoR0irdxrqpfI=;
        b=uaPKaTnAEAd4eDtlmXMurg5d+QodYlC+Q4jCVzf1Q5la3hzQoj17n+o1CrfVNLw8cX
         E1BcIb06GSog7rz9f4oQEIVr0I7A2L2bCm+pLoK6Pb99JkDm0e6UdJYuUrVbuxWjYMir
         dy/psPtpuEYF4yCVi/FHUvkklBIL9c7yMKCp0JqluPiiJWMgX3K7CgzuM+xMzScyiywK
         FFp6WX/tnB08ZCh6h7sKXtUwjZBse1fef7Hwm+G4lKvWAcNZopfgAFYcJ1CGN0neTML8
         oUHbxp1bn+k2sA+FcN1K0u8r00UggWeulnT60eqqXcn80rsNgeWemfXF2z15JkG0vjy5
         57Mw==
X-Forwarded-Encrypted: i=1; AJvYcCUd4uRJPbJlQYpFZpkQHUkm2y7gDcRe+f3uZDAQRmJClhUQGBbLEJeIF32x0fcpthCDAGht1nHJmYyh/S9I54w2UO4=@vger.kernel.org, AJvYcCUt6/EC1mc+yAk7SXFVCDccvSwSfxmYkONPPJHHxMnYFJH7wH/96K6kDsjcLG5F9WU9RZw7nBdn8Yw=@vger.kernel.org, AJvYcCViyBf+D+0AW7eWsPDko7UqQxNd2Yw9aoY98SGX2wTR5twx0PFvv78yXsiQHLigvLtsXB6XeD9CRZZIGRE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhR+yj9hoCCjMmlqR2FQYgJntKiikIqG2wGugVr03ACgxlz1r6
	s3lW7kSho4xRGnAinivpvitZpTHqgR6z+XZr0C1KfhIU+xMP0C+F
X-Gm-Gg: ASbGncsXjlG7jD3o4N1Xs9LjnWZdBQSnFTAjeIbGX6nVKQ2UCZ+viC6kRAIQPmcT6LZ
	g+kJM4dK365HQosmo9vMSGnh891FtJML+i1u8SkmQmxbv/4ywr9jDDgfB0GQnvHmvv2JJbBsrHD
	RPlZoK5wMMC5avzDDAuse4OjCrBPK7F8Eh+E3on5StTQ53zbgj+3NN0Jux8QBnrCVZCxSiyjkcR
	cIX0Qaqm6kp+i3POgK0j/2YvGjh9Yo7nFE+BWXoCZA/s5zUsPW70V9+dFTanFzLj/enYNdJMUtp
	IdJbWRJ2MUWhrUl1KBdWyltCC1LRNteX1ASyJQBzi0y+IGkc2K7R+dwDlUvo65Hq+1DOAg==
X-Google-Smtp-Source: AGHT+IFRMb8MSt+/SKP7XgvmW56LuHP+OiQQ8mAEyZvr5wqugDw0pMOjRJfiVrvAK9l7JjHXCjXQqQ==
X-Received: by 2002:a05:6a00:2e17:b0:736:9f20:a175 with SMTP id d2e1a72fcca58-736aa9c1b4cmr20983288b3a.2.1741617314745;
        Mon, 10 Mar 2025 07:35:14 -0700 (PDT)
Received: from localhost.localdomain ([103.221.69.50])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af281096763sm7785900a12.30.2025.03.10.07.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 07:35:14 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	linux-pm@vger.kernel.org (open list:SAMSUNG THERMAL DRIVER),
	linux-samsung-soc@vger.kernel.org (open list:SAMSUNG THERMAL DRIVER),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES),
	linux-kernel@vger.kernel.org (open list)
Cc: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH v4 2/4] drivers/thermal/exymos: Remove redundant IS_ERR() checks for clk_sec clock
Date: Mon, 10 Mar 2025 20:04:43 +0530
Message-ID: <20250310143450.8276-3-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310143450.8276-1-linux.amoon@gmail.com>
References: <20250310143450.8276-1-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove unnecessary IS_ERR() checks for the clk_sec clock,
the clk_enable() and clk_disable() functions can handle NULL clock
pointers, so the additional checks are redundant and have been removed
to simplify the code.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v4: drop IE_ERR() for clk_unprepare() as its handle in earlier code.
v3: improve the commit message.
---
 drivers/thermal/samsung/exynos_tmu.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 3657920de0004..ac3b9d2c900ca 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -258,8 +258,7 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
 
 	mutex_lock(&data->lock);
 	clk_enable(data->clk);
-	if (!IS_ERR(data->clk_sec))
-		clk_enable(data->clk_sec);
+	clk_enable(data->clk_sec);
 
 	status = readb(data->base + EXYNOS_TMU_REG_STATUS);
 	if (!status) {
@@ -269,8 +268,7 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
 		data->tmu_clear_irqs(data);
 	}
 
-	if (!IS_ERR(data->clk_sec))
-		clk_disable(data->clk_sec);
+	clk_disable(data->clk_sec);
 	clk_disable(data->clk);
 	mutex_unlock(&data->lock);
 
-- 
2.48.1



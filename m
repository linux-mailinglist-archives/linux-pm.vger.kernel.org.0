Return-Path: <linux-pm+bounces-25011-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23244A8252B
	for <lists+linux-pm@lfdr.de>; Wed,  9 Apr 2025 14:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07BBE19E734B
	for <lists+linux-pm@lfdr.de>; Wed,  9 Apr 2025 12:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866A525E835;
	Wed,  9 Apr 2025 12:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BjJ83Oz8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691828C0E;
	Wed,  9 Apr 2025 12:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744202759; cv=none; b=TpC2duCkxxZs7usOFmE2HIelgqqTvz08CZcu8PThrlX3r+gyVB67mHHSm8aUHhMMxkwgBbaa19S4zwm7MV72gcGfw0alW80/yazDK3ZQvqxTcZ/8w9YPNt6Lurv4G7wPb2v+1WKOjKxqOtvTe+VBgqXnKtlzIJR636nPkSS5FhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744202759; c=relaxed/simple;
	bh=0idBfCTzKenTxIiSwgSu/KdenyNnfTy6Efd7dSG2ssA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NlKqr2MePCpyGuR3WH9G5jkncjRFBcz7ju8X+pxANmv6scfBCnpkUkV1JR0sxay801hQ8TOYPO8tM4SIsl8CtaDgKUylw9tEI6VQweV/P4jO/hZl3Iabl2N6O6H2PFjc0HIE55gHZL8iRWmzDAdT8D31LaKXNUCVRZQQ5uLKq4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BjJ83Oz8; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-22622ddcc35so89568425ad.2;
        Wed, 09 Apr 2025 05:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744202757; x=1744807557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hW0uMB23s6rTN+79K6wuOhxoVdGvng8abYobjgd2dY0=;
        b=BjJ83Oz8BW2E9H9/aqSV9qosXwrohG46AN8Hf8XhILQrGYgZqf98bJpnEHXheIEyYq
         +ElMOdGC9llXhSmTbTofgGbGtdSzqmpVYR2UKYq4XmzvG0ADoZ5crpF8i2/dDlkOecH8
         QWE4F2hnFOFaXh8Zk2crpZ9yVZPccS5UGHu2X90OO9zGhegoywM7lBIozmbP7uEJthpD
         Xd+QBy3+314iC3rF/79STldRwyX/3A5bndSkdy3V97dYY6nR1R39nxflkDJb3EEm09T0
         H0S2tAItfvfrQz/hEZQZMAaoFrqA3hs+3NFNv9dyAr8ocbQe17wp5w3QKlwQybuSAyTm
         DPvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744202757; x=1744807557;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hW0uMB23s6rTN+79K6wuOhxoVdGvng8abYobjgd2dY0=;
        b=NKP6Iqk/zt/U61OqjF2ds4LomkopQ6cLpmmVUwdvvVqV09mPxGxo50lhexNz0wi1U4
         WyYs94puNHWUYx1cDKFixxIRgYwkG/lGiXHpwWlUbMKc/kpf+R2xrrUEKn1zh4LHJKF4
         4DJRW3Dw54dkfFermwamgK/VRVg/+5uJw3vtLmYNSKvhCyszDhoWkjiHw+kQ8+0y6y6M
         ewrGeJ0bnEcwisCXVbuc8sCiX7KOXcPJVSqE5kIm6c7ga+/D+dmggRQmdMaVZ6df0Gcj
         NzP9sXukBvGhPKpxDGMeluJPOZm+ooDGwbrpvqDZpnfdgaSaULMMEs514qt1Fb4gyp1F
         7nDw==
X-Forwarded-Encrypted: i=1; AJvYcCVnEM19ea1U2zy6mlnHV3YcHpXwOn5ow61kOgpZttDkN+UcQYgHhibB1ZF9Yctr2QRqKgDk8z/E4SmCivA=@vger.kernel.org, AJvYcCW/r7K6A0PBq/Ho4LUTiPih+slZKrmV3QXcpunNZkiqxffpdDbmjz/KbUwA3+uuKaVNvx5DmxVbaUM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5kzS89wyL3hjTOS7pB4tVANmK3zFEDrVc+ojn+rFIx5UrMXhl
	X/XmA6WT7mkny3KrzdH9qNslA281MBiNLF+mhOfAhan6W26bKU6QVNhd4GW//pvgcg==
X-Gm-Gg: ASbGncuzcvSnKpn/Lg9Yc+Xt/ogdUGrBfZvMvgAe1Jvv87CP3lfB0a1HLwpzlNTtmGA
	7oM37FipkzOZbcI849edKn2PvL0c/1b2jx73Th2Csb499kwuTY7GOQ/4JhmEG8VhG/RvCUgSco4
	BSuf8Vi6MXfyyiPHcFoEeg6IhUUFXChqh/xz76zIYzPRT1b12Pbx6pkr6QZ5Mn4qHW8xWDtGSKE
	5FGrgIIilYQafbC/hBG6lqkwniCFZKtmkcFm1qm6vkKnn7b7P2EK/9g+/BB2qT/NOaVzZkVnJpR
	gEb+R95N5Z2GGd6DQbkFTyO45TtRyFjDbAC9IX3SxDtKNWIK6LZY53j8XtQKfw/4mI8=
X-Google-Smtp-Source: AGHT+IGmBiCflS+dqQ9MaoOZ8ceeMEIKcTocd1UAk+LlHaQn3WAQwStGaWQzSH4vbgk2NAKmvL6ilg==
X-Received: by 2002:a17:902:ecce:b0:220:d078:eb33 with SMTP id d9443c01a7336-22ac2a1df21mr41865715ad.36.1744202756563;
        Wed, 09 Apr 2025 05:45:56 -0700 (PDT)
Received: from henry.localdomain ([111.202.148.133])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7c971e4sm10531465ad.136.2025.04.09.05.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 05:45:56 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: sven@svenpeter.dev,
	j@jannau.net,
	alyssa@rosenzweig.io,
	neal@gompa.dev,
	rafael@kernel.org,
	viresh.kumar@linaro.org
Cc: asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>
Subject: [PATCH v2 2/2] cpufreq: scpi: Fix null-ptr-deref in scpi_cpufreq_get_rate()
Date: Wed,  9 Apr 2025 20:45:42 +0800
Message-Id: <20250409124542.47166-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cpufreq_cpu_get_raw() can return NULL when the target CPU is not present
in the policy->cpus mask. scpi_cpufreq_get_rate() does not check for
this case, which results in a NULL pointer dereference.

Fixes: 343a8d17fa8d ("cpufreq: scpi: remove arm_big_little dependency")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
V1 -> V2: Use `if (unlikely(!policy))` instead of `if (!policy)`

 drivers/cpufreq/scpi-cpufreq.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/scpi-cpufreq.c b/drivers/cpufreq/scpi-cpufreq.c
index 17cda84f00df..dcbb0ae7dd47 100644
--- a/drivers/cpufreq/scpi-cpufreq.c
+++ b/drivers/cpufreq/scpi-cpufreq.c
@@ -29,9 +29,16 @@ static struct scpi_ops *scpi_ops;
 
 static unsigned int scpi_cpufreq_get_rate(unsigned int cpu)
 {
-	struct cpufreq_policy *policy = cpufreq_cpu_get_raw(cpu);
-	struct scpi_data *priv = policy->driver_data;
-	unsigned long rate = clk_get_rate(priv->clk);
+	struct cpufreq_policy *policy;
+	struct scpi_data *priv;
+	unsigned long rate;
+
+	policy = cpufreq_cpu_get_raw(cpu);
+	if (unlikely(!policy))
+		return 0;
+
+	priv = policy->driver_data;
+	rate = clk_get_rate(priv->clk);
 
 	return rate / 1000;
 }
-- 
2.34.1



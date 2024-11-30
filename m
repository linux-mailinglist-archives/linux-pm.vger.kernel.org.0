Return-Path: <linux-pm+bounces-18268-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5ADE9DF0A3
	for <lists+linux-pm@lfdr.de>; Sat, 30 Nov 2024 14:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2575428194B
	for <lists+linux-pm@lfdr.de>; Sat, 30 Nov 2024 13:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1CA19ABC2;
	Sat, 30 Nov 2024 13:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="gq1uEDTA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEE817741
	for <linux-pm@vger.kernel.org>; Sat, 30 Nov 2024 13:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732975108; cv=none; b=orlwpHcpRi6owAyJPDxNEVnWofkTRSKRGjqb57UohKJ6r2zCib2YiWA4uJoQle1fetoDqqBTlcDdj8Jnvrr1leV07HRudIp52vmLa9aguHLQ7uLDJ6oLYh1BDx9wKiswwFsu9bpuZ22jRJLa8mtPJDKChXHSIx84MdvnwOrHb9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732975108; c=relaxed/simple;
	bh=uZqTpKr93naOghYTr0iK9IfYdelZY2f/4l+5kxDMpfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=p13CraC2S7SNyH9DnFeOQ9xp6hzQDeJFZ+2sF3z3BEpgTNBrhLb7d4LboWrPzIyXq95/rjPnmFszHzDF2XehUbCQIq0FAv8LsT7sReiQSaaDy1/XMz5C6gen7W/xZPBozsADU0bDDsO2drn4nEZvSr3REjuNCgjCj8/swCYBkgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=gq1uEDTA; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-434acf1f9abso24956845e9.2
        for <linux-pm@vger.kernel.org>; Sat, 30 Nov 2024 05:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732975103; x=1733579903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OSHwRqHVpOIG2JrOXS69Jq4ftU8zIW/MyIo0a+5/w9E=;
        b=gq1uEDTA9Nub4xDl29wT/ADroBWz4lM0AgNyqgR6J6Jz5LWdUmKYca+Y+ghb5BBwpX
         LYvfRjjwLdVbQUIjdLctBHjZwMXyxCvWuU2+cuk0+95m06HwBL2Q4SZ8rzJApdKysKP2
         nBMPvhM8SaQzbjI7YOXZEkQpg2i5gU8vGxHghgG/kHKdaqAYqtflqWDSDikTes1juE/X
         4cBajcTE0cpKZi1KqyXBKMua606L2loMG7stMQjYwUbrUNKRj9CojBdlXk6YjHWxKKCY
         /nstedRMbr8IgRK1Z5rGfrNqx1mXKshtu9p2/eendKlkV1vE7JXtkRhDMTFHIyhu3uE7
         zRwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732975103; x=1733579903;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OSHwRqHVpOIG2JrOXS69Jq4ftU8zIW/MyIo0a+5/w9E=;
        b=LIVRb5BxeqC6VTcD3ORv1kJ6Fza2LbOUPExTWzh8qFASPnEroOgJUr2EI5W85KVac9
         WwQHyP+XcgieUpbbtx4B6B3Hn38LNkd0APyY6rEJThr0qN+aAIlYWp47AATK3noeZrqi
         lbopA+Fk7vasOm1yp2ek6Qr/teyHKNc1AZ4tkGcg2Sz6CJ9ne5h8D9NGA6/rixd9lnez
         g5Ley4ibZXq8bY4f0XqdmodYp9bPNQQyuqgaiG/3rW0LLEkZG7rLb8CYN2X0FZQU7MnU
         4ski/6EgQiQRioGXe1ygGNksFKSRvhOHJ+NZ1Iqh9CAetdDQBd15FYTSaGZIzDX3nL1R
         2MvA==
X-Forwarded-Encrypted: i=1; AJvYcCWtauBNv/XVribzAkjC5dRptOOUfcgeuLs29keaRArgUt2MAQchq03X1xBYUPhj0VNp+uXtkbr5Uw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxfqV0IJmWa8sVxT7f7XLmKIgTSpuJfIySkQ8AiNm6IKrh/keP6
	LVnv11UBv4PL/hRPDZlzTVjws1F0W7yTKbKWu2IVPC/TpZ/IeRC9fGR8xtF4MrM=
X-Gm-Gg: ASbGncuUfRuvVtt4PRNLWn0R+JJDgCg/X9dVMj+dLOzW2bm/p5OeBSplwsPC9rz86Kc
	ktzt3RspyQJqKjc59sRb1y8L8YZVXek/ixThuM4+nsGT7MQ7slUXDlytW2mWRyRAZsycBf0jvDl
	O7y9LUgTwRo4HL0vAEb1hYFhd/O2I2Vkz4LtqEkY7c48AMq9eWDWgRDMbSXoXOELThe2xKAUc5q
	wAqq+BRnYSgViiENEzw3V+TqtbrErWafUmxsIYXLU3QN8IVphkUvEo=
X-Google-Smtp-Source: AGHT+IHHBe7d5htoj70/kfSxdm+kZQjM0tjaIphEphbFBlZoaGAn1iAgRxGbS4k2FdQNlTMpb9szHA==
X-Received: by 2002:a05:600c:1e2a:b0:434:a8ef:442f with SMTP id 5b1f17b1804b1-434a9e0b47amr130603305e9.32.1732975102930;
        Sat, 30 Nov 2024 05:58:22 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd2db59sm7209061f8f.11.2024.11.30.05.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2024 05:58:21 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Chanwoo Choi <cw00.choi@samsung.com>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-sunxi@lists.linux.dev
Subject: [PATCH] devfreq: Switch back to struct platform_driver::remove()
Date: Sat, 30 Nov 2024 14:58:11 +0100
Message-ID: <20241130135813.895628-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4431; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=uZqTpKr93naOghYTr0iK9IfYdelZY2f/4l+5kxDMpfQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnSxn2/gYVC8rkX/fl3aGkXakkNgP43aHdtARV8 OWxfSCpITGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ0sZ9gAKCRCPgPtYfRL+ TtpSB/4zIRpdyNmt2fGjIAeqqboAJR/YHNuFmvrjp8Drq7BhxBmFEjklrLsdnM1D8xJ5bFpqfMt 3g3BmsnnVn5Ievf+Rgcjdad0fazJd8PkmhOKtpmlxhQBHOGgdt3gIMLDcreOU0uSgchS/gRERs6 OQW82e3EqDHrAE6Vc+3Qi61FU/ZlMF1nqYl1+99RsW8bvRLfXVqfnDpu8ICue/NpESiicBfveka TqbEyaEcVjC3oB+UloPneKYxzreyyW/95x403cjGd3zjLiW0e/ZY3NfQI/fj6v+QVkJWdTBa697 6PLuqyWiHcdrpQA+5R1YdF54B/MbB273AjfAkpjaeAGRTtZx
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

After commit 0edb555a65d1 ("platform: Make platform_driver::remove()
return void") .remove() is (again) the right callback to implement for
platform drivers.

Convert all platform drivers below drivers/devfreq to use .remove(),
with the eventual goal to drop struct platform_driver::remove_new(). As
.remove() and .remove_new() have the same prototypes, conversion is done
by just changing the structure member name in the driver initializer.

While touching these drivers, make the alignment of the touched
initializers consistent.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
Hello,

this is based on Friday's next, feel free to drop changes that result in
a conflict when you come around to apply this. I'll care for the fallout
at a later time then. (Having said that, if you use b4 am -3 and git am
-3, there should be hardly any conflict.)

This is merge window material.

Best regards
Uwe

 drivers/devfreq/event/exynos-nocp.c | 6 +++---
 drivers/devfreq/event/exynos-ppmu.c | 6 +++---
 drivers/devfreq/mtk-cci-devfreq.c   | 4 ++--
 drivers/devfreq/rk3399_dmc.c        | 8 ++++----
 drivers/devfreq/sun8i-a33-mbus.c    | 2 +-
 5 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/devfreq/event/exynos-nocp.c b/drivers/devfreq/event/exynos-nocp.c
index 5edc522f715c..9480a92fc265 100644
--- a/drivers/devfreq/event/exynos-nocp.c
+++ b/drivers/devfreq/event/exynos-nocp.c
@@ -283,10 +283,10 @@ static void exynos_nocp_remove(struct platform_device *pdev)
 }
 
 static struct platform_driver exynos_nocp_driver = {
-	.probe	= exynos_nocp_probe,
-	.remove_new = exynos_nocp_remove,
+	.probe = exynos_nocp_probe,
+	.remove = exynos_nocp_remove,
 	.driver = {
-		.name	= "exynos-nocp",
+		.name = "exynos-nocp",
 		.of_match_table = exynos_nocp_id_match,
 	},
 };
diff --git a/drivers/devfreq/event/exynos-ppmu.c b/drivers/devfreq/event/exynos-ppmu.c
index 7002df20a49e..a738e6145612 100644
--- a/drivers/devfreq/event/exynos-ppmu.c
+++ b/drivers/devfreq/event/exynos-ppmu.c
@@ -700,10 +700,10 @@ static void exynos_ppmu_remove(struct platform_device *pdev)
 }
 
 static struct platform_driver exynos_ppmu_driver = {
-	.probe	= exynos_ppmu_probe,
-	.remove_new = exynos_ppmu_remove,
+	.probe = exynos_ppmu_probe,
+	.remove = exynos_ppmu_remove,
 	.driver = {
-		.name	= "exynos-ppmu",
+		.name = "exynos-ppmu",
 		.of_match_table = exynos_ppmu_id_match,
 	},
 };
diff --git a/drivers/devfreq/mtk-cci-devfreq.c b/drivers/devfreq/mtk-cci-devfreq.c
index 7ad5225b0381..3938878b2279 100644
--- a/drivers/devfreq/mtk-cci-devfreq.c
+++ b/drivers/devfreq/mtk-cci-devfreq.c
@@ -429,8 +429,8 @@ static const struct of_device_id mtk_ccifreq_machines[] = {
 MODULE_DEVICE_TABLE(of, mtk_ccifreq_machines);
 
 static struct platform_driver mtk_ccifreq_platdrv = {
-	.probe	= mtk_ccifreq_probe,
-	.remove_new = mtk_ccifreq_remove,
+	.probe = mtk_ccifreq_probe,
+	.remove = mtk_ccifreq_remove,
 	.driver = {
 		.name = "mtk-ccifreq",
 		.of_match_table = mtk_ccifreq_machines,
diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
index d405cee92c25..158e4bbd08cc 100644
--- a/drivers/devfreq/rk3399_dmc.c
+++ b/drivers/devfreq/rk3399_dmc.c
@@ -473,11 +473,11 @@ static const struct of_device_id rk3399dmc_devfreq_of_match[] = {
 MODULE_DEVICE_TABLE(of, rk3399dmc_devfreq_of_match);
 
 static struct platform_driver rk3399_dmcfreq_driver = {
-	.probe	= rk3399_dmcfreq_probe,
-	.remove_new = rk3399_dmcfreq_remove,
+	.probe = rk3399_dmcfreq_probe,
+	.remove = rk3399_dmcfreq_remove,
 	.driver = {
-		.name	= "rk3399-dmc-freq",
-		.pm	= &rk3399_dmcfreq_pm,
+		.name = "rk3399-dmc-freq",
+		.pm = &rk3399_dmcfreq_pm,
 		.of_match_table = rk3399dmc_devfreq_of_match,
 	},
 };
diff --git a/drivers/devfreq/sun8i-a33-mbus.c b/drivers/devfreq/sun8i-a33-mbus.c
index bcf654f4ff96..a405bab1a63e 100644
--- a/drivers/devfreq/sun8i-a33-mbus.c
+++ b/drivers/devfreq/sun8i-a33-mbus.c
@@ -495,7 +495,7 @@ static SIMPLE_DEV_PM_OPS(sun8i_a33_mbus_pm_ops,
 
 static struct platform_driver sun8i_a33_mbus_driver = {
 	.probe	= sun8i_a33_mbus_probe,
-	.remove_new = sun8i_a33_mbus_remove,
+	.remove	= sun8i_a33_mbus_remove,
 	.driver	= {
 		.name		= "sun8i-a33-mbus",
 		.of_match_table	= sun8i_a33_mbus_of_match,

base-commit: f486c8aa16b8172f63bddc70116a0c897a7f3f02
-- 
2.45.2



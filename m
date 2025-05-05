Return-Path: <linux-pm+bounces-26632-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F9AAA8BA1
	for <lists+linux-pm@lfdr.de>; Mon,  5 May 2025 07:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBCED17182C
	for <lists+linux-pm@lfdr.de>; Mon,  5 May 2025 05:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E8A19F115;
	Mon,  5 May 2025 05:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KfPU20/b"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A3D78F26;
	Mon,  5 May 2025 05:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746422708; cv=none; b=anpcoTbXc1zu9Udjc36tFGNiu4YE3UrwC520bmIpNet7zSGMjEGQKappZKXU6ENgJ1gHRsxOrSFDJpcAtvuNFihSbugaFHqwDn+VnShIph7/jYhD1hCaNKl3DFTWkbuIu7uxB8umbEdup55rLRD5xBT2Q1krMBXWlIYDew7LqDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746422708; c=relaxed/simple;
	bh=gqLQSv5UjOL9/2FaltDUuXflgvx0PDLFqookN2zeQ0U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YalTSj0tH83xG+oX+SOC18TVqIfv03KZA9FAAAjeT008FXYIU0z4i2Op3WB0xaRBeStJZitFHYiRPlNmLJeOcnzqlDMTvhm3npJD/J20B+IDbiVUApPvO4f8R/03bKajmzyGrTr/Jo89dSwDi8ep0UK+BJvO5vUXXyP8Rf4U+48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KfPU20/b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB3A5C4CEE4;
	Mon,  5 May 2025 05:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746422707;
	bh=gqLQSv5UjOL9/2FaltDUuXflgvx0PDLFqookN2zeQ0U=;
	h=From:To:Cc:Subject:Date:From;
	b=KfPU20/bIFUy43MnrFC1/6MQmcMePl0M4g8tf2tB09i+iI6iLslBvqfHGWAyCOfy+
	 NnFSdwLwmqwfEIIVEHDmvvy/MtvTiYKtdKgOsfFo0Bi/XQ2r0Z+mJ2T5k8yPIJPUNV
	 CGEeLokoNqcv5cyXTqQIaJ4EUO2DecXmHjy+AQ6CLajDaMr8QMxTDxVlh1hVUg89o/
	 YNZXJdiuXNJvUQW7v0opmcFFkfus6+6IWLYd29xpcAYquSsk+MaS7CE4MmtN1R3bLL
	 Jr3xs3Cv/jBrQBmmfhJKYTllogvriNA/p9Ufg9KDrzusfibir9v/hooEhaRGH6q1Fg
	 sZAr+s+Nmx9Dw==
From: Arnd Bergmann <arnd@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chen-Yu Tsai <wenst@chromium.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Julien Panis <jpanis@baylibre.com>,
	=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>,
	Nicolas Pitre <npitre@baylibre.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH] thermal/drivers/mediatek/lvts: remove unused lvts_debugfs_exit
Date: Mon,  5 May 2025 07:24:52 +0200
Message-Id: <20250505052502.1812867-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

When debugfs is disabled, the function has no reference any more:

drivers/thermal/mediatek/lvts_thermal.c:266:13: error: 'lvts_debugfs_exit' defined but not used [-Werror=unused-function]
  266 | static void lvts_debugfs_exit(struct lvts_domain *lvts_td) { }
      |             ^~~~~~~~~~~~~~~~~

Fixes: ef280c17a840 ("thermal/drivers/mediatek/lvts: Fix debugfs unregister on failure")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/thermal/mediatek/lvts_thermal.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index c0be4ca55c7b..985925147ac0 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -263,8 +263,6 @@ static inline int lvts_debugfs_init(struct device *dev,
 	return 0;
 }
 
-static void lvts_debugfs_exit(struct lvts_domain *lvts_td) { }
-
 #endif
 
 static int lvts_raw_to_temp(u32 raw_temp, int temp_factor)
-- 
2.39.5



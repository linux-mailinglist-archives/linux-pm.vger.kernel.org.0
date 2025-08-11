Return-Path: <linux-pm+bounces-32168-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D610B21072
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 17:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 281D750049B
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 15:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96CA52E2F0F;
	Mon, 11 Aug 2025 15:22:21 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.gtsys.com.hk (web.xit.com.hk [111.91.236.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A96C149C51;
	Mon, 11 Aug 2025 15:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.91.236.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754925741; cv=none; b=DfrBeIk/hHy9kcvKGhchZfWO/xpkkxidkCEKm/6EbmFolhDGacWmA+2YTszU3DDfUPKsxkAZ/T6DiSNMa0Sztxa9LSkg7Tqi5R3rzQm3dEOJnXR9Xjl4R0Ni6gQNxr74CNeIznOJU9AGySTl+/A5bj8Fa3AB0Uhaia9h1tOek8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754925741; c=relaxed/simple;
	bh=PWKgU5MlTJfhJtoWgGGBHKaa3+fJfjRO/1SAuA6K5Ls=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PFbLUKsD5KZt8C+jBTvsk/25m51gYNVlY/l7lWlSJ74uOnucO5d7uAYeAGuSZ9hBvhFXBeCdRKOgLTJ/cmzSpWGM8OKZj6mnLoZ9oPC0BiIMNn5z4DYUXtmewvVc7c+apxNO9MiJxCDWo71Ki53Y7zxguLs4eWgYGfyK5rbXJGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gtsys.com.hk; spf=pass smtp.mailfrom=gtsys.com.hk; arc=none smtp.client-ip=111.91.236.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gtsys.com.hk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gtsys.com.hk
Received: from localhost (localhost [127.0.0.1])
	by mail.gtsys.com.hk (Postfix) with ESMTP id 18AF0255;
	Mon, 11 Aug 2025 23:22:17 +0800 (HKT)
X-Virus-Scanned: Debian amavis at gtsys.com.hk
Received: from mail.gtsys.com.hk ([127.0.0.1])
 by localhost (mail.gtsys.com.hk [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kRrGwmauwPPM; Mon, 11 Aug 2025 23:22:16 +0800 (HKT)
Received: from gtsnode.virtual.gtsys.com.hk (gtsnode.virtual.gtsys.com.hk [10.128.4.2])
	by mail.gtsys.com.hk (Postfix) with ESMTP id E2B04EA;
	Mon, 11 Aug 2025 23:22:16 +0800 (HKT)
Received: from eliteXTrixie.gtsys.com.hk (ip-037-201-119-101.um10.pools.vodafone-ip.de [37.201.119.101])
	by gtsnode.virtual.gtsys.com.hk (Postfix) with ESMTPSA id 883A81FC30;
	Mon, 11 Aug 2025 23:22:16 +0800 (HKT)
Received: by eliteXTrixie.gtsys.com.hk (Postfix, from userid 1000)
	id 235711818BF; Mon, 11 Aug 2025 17:22:11 +0200 (CEST)
From: chris.ruehl@gtsys.com.hk
To: sre@kernel.org
Cc: linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ruehlchr@gmail.com,
	Christopher Ruehl <chris.ruehl@gtsys.com.hk>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v1] power: supply: qcom_battmgr: add OOI chemistry
Date: Mon, 11 Aug 2025 17:22:09 +0200
Message-ID: <20250811152209.37131-1-chris.ruehl@gtsys.com.hk>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christopher Ruehl <chris.ruehl@gtsys.com.hk>

The ASUS S15 xElite model report the Li-ion battery with an OOI, hence this
update the detection and return the appropriate type.

Signed-off-by: Christopher Ruehl <chris.ruehl@gtsys.com.hk>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

---
Changes v1:
 - Update subject to match other changes in this driver
---
 drivers/power/supply/qcom_battmgr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
index 99808ea9851f..fdb2d1b883fc 100644
--- a/drivers/power/supply/qcom_battmgr.c
+++ b/drivers/power/supply/qcom_battmgr.c
@@ -982,7 +982,8 @@ static void qcom_battmgr_sc8280xp_strcpy(char *dest, const char *src)
 
 static unsigned int qcom_battmgr_sc8280xp_parse_technology(const char *chemistry)
 {
-	if (!strncmp(chemistry, "LIO", BATTMGR_CHEMISTRY_LEN))
+	if ((!strncmp(chemistry, "LIO", BATTMGR_CHEMISTRY_LEN)) ||
+	    (!strncmp(chemistry, "OOI", BATTMGR_CHEMISTRY_LEN)))
 		return POWER_SUPPLY_TECHNOLOGY_LION;
 	if (!strncmp(chemistry, "LIP", BATTMGR_CHEMISTRY_LEN))
 		return POWER_SUPPLY_TECHNOLOGY_LIPO;
-- 
2.47.2



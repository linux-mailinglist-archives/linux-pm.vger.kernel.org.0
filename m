Return-Path: <linux-pm+bounces-32163-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89338B20742
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 13:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4238E166CA6
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 11:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154592BE7AF;
	Mon, 11 Aug 2025 11:16:25 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.gtsys.com.hk (web.xit.com.hk [111.91.236.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBEF2853EE;
	Mon, 11 Aug 2025 11:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.91.236.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754910985; cv=none; b=OYPfvmTu4SseT7Luf73siFjyfvzP3Y4uvx74LipSJyafOLtAoLlt2T8h4IfIc4GZh6jMHWT7c57oxdf/TJ3ts4X+ivOFN9XrSw0ngwcbrZBECG91UEWEfGqJYW0Nfk4e7NsgywIiQYAMttDqA9Qm+zEZYXfXjRh3FDO2MX0WNT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754910985; c=relaxed/simple;
	bh=Dbp6K90SUZ83coRTqn/eE+wL5+w3/USE9tm88PaZEQY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qZMqVb3ZcjnpR/qH3vh+DDZ5rNeHyETbC1wxfve1sYu/sdXgXsEhYAvRVxyDPO+vqneYSZf60zqMg235R8yohsxktKuPXY7lhn5+t2Ydops7KkHNwD6BmI274ORFCI9rzgdNRS+6spQALddS6xzQVF18Xksrwn+8jzj85jugchQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gtsys.com.hk; spf=pass smtp.mailfrom=gtsys.com.hk; arc=none smtp.client-ip=111.91.236.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gtsys.com.hk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gtsys.com.hk
Received: from localhost (localhost [127.0.0.1])
	by mail.gtsys.com.hk (Postfix) with ESMTP id D4829119;
	Mon, 11 Aug 2025 19:10:35 +0800 (HKT)
X-Virus-Scanned: Debian amavis at gtsys.com.hk
Received: from mail.gtsys.com.hk ([127.0.0.1])
 by localhost (mail.gtsys.com.hk [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OQ_2cDe-TGlk; Mon, 11 Aug 2025 19:10:35 +0800 (HKT)
Received: from gtsnode.virtual.gtsys.com.hk (gtsnode.virtual.gtsys.com.hk [10.128.4.2])
	by mail.gtsys.com.hk (Postfix) with ESMTP id AE29A36;
	Mon, 11 Aug 2025 19:10:35 +0800 (HKT)
Received: from eliteXTrixie.gtsys.com.hk (ip-037-201-119-101.um10.pools.vodafone-ip.de [37.201.119.101])
	by gtsnode.virtual.gtsys.com.hk (Postfix) with ESMTPSA id 56B561FC30;
	Mon, 11 Aug 2025 19:10:35 +0800 (HKT)
Received: by eliteXTrixie.gtsys.com.hk (Postfix, from userid 1000)
	id 8305A1818BF; Mon, 11 Aug 2025 13:10:31 +0200 (CEST)
From: chris.ruehl@gtsys.com.hk
To: sre@kernel.org
Cc: linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ruehlchr@gmail.com,
	Christopher Ruehl <chris.ruehl@gtsys.com.hk>
Subject: [PATCH] msm: arm: qcom battery manager add OOI chemistry
Date: Mon, 11 Aug 2025 13:10:26 +0200
Message-ID: <20250811111026.24292-1-chris.ruehl@gtsys.com.hk>
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



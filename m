Return-Path: <linux-pm+bounces-32583-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B7DB2B196
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 21:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9633520516
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 19:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A38277032;
	Mon, 18 Aug 2025 19:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="X8pqcuQ/"
X-Original-To: linux-pm@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31E225485F;
	Mon, 18 Aug 2025 19:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755545204; cv=none; b=ntCmzjfyGSACWBtxhuUDVTWBbMQmCHCC+eXTDvaIw7qP/mHVlXQemfeTOGDbTj7Ew4F360HblCrp7wOI4uJR4P8TgR2posnq8MqG2Qq40vSjQMEpUqh90plYfu1PoercoYrdOexyy51gmcIo1OUs0yDgwtTMGI2iGn4E1z/UjqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755545204; c=relaxed/simple;
	bh=oK5JvcFSaN1TyJd7K80UpjNFRv/JIpUuvFuQza7IXW0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W3erDDKomOAYNoqR7aHRN/z032j2aw8vGqTaPbRc9xvEPxCoE7XRpHUrjyTA4q5aBzKY+sD8RuL7IyN0BLaNIMdMUl2Vb+NNfYTmwrWq7CUx/rNIvRer6u2/zgEvZ4hXkQPYixLj15RmSXXBK6uE3NnhtevzQOYdCzW2Z4/mKPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=X8pqcuQ/; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57IJQXuk3147282;
	Mon, 18 Aug 2025 14:26:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755545193;
	bh=c0AbO84hZjW14Lbl5aei9qWkHXX8f1YDrWxIY9FYFGQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=X8pqcuQ/ugEyTyfesAmTyosbJdqjoo2nFd+3AIK8OPXWyhm9riVCN1Qm/9a3+xigZ
	 G61KYB6BgJVvUjqL1cX1uXptmVoaZeMP2rsMyl7g6sPXBJw4CB04OML4JHG+sqGcHi
	 wSCCVTUC7WBEnnLUH/sha1uhfFiSw1F99xX9+CQc=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57IJQXeb4032550
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 18 Aug 2025 14:26:33 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 18
 Aug 2025 14:26:33 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 18 Aug 2025 14:26:33 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57IJQWxW1525949;
	Mon, 18 Aug 2025 14:26:32 -0500
From: Judith Mendez <jm@ti.com>
To: Judith Mendez <jm@ti.com>, Nishanth Menon <nm@ti.com>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        "Rafael J
 . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, Bryan
 Brattlof <bb@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: [PATCH 1/3] cpufreq: ti: Support more speed grades on AM62Px SoC
Date: Mon, 18 Aug 2025 14:26:30 -0500
Message-ID: <20250818192632.2982223-2-jm@ti.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250818192632.2982223-1-jm@ti.com>
References: <20250818192632.2982223-1-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

As the AM62Px SoC family matures more speed grades are being defined.
Add support for speed grades U and T which both support all currently
established OPPs.

Signed-off-by: Judith Mendez <jm@ti.com>
---
 drivers/cpufreq/ti-cpufreq.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
index 5a5147277cd0..f7be09dc63e3 100644
--- a/drivers/cpufreq/ti-cpufreq.c
+++ b/drivers/cpufreq/ti-cpufreq.c
@@ -72,7 +72,9 @@ enum {
 
 #define AM62P5_EFUSE_O_MPU_OPP			15
 #define AM62P5_EFUSE_S_MPU_OPP			19
+#define AM62P5_EFUSE_T_MPU_OPP			20
 #define AM62P5_EFUSE_U_MPU_OPP			21
+#define AM62P5_EFUSE_V_MPU_OPP			22
 
 #define AM62P5_SUPPORT_O_MPU_OPP		BIT(0)
 #define AM62P5_SUPPORT_U_MPU_OPP		BIT(2)
@@ -153,7 +155,9 @@ static unsigned long am62p5_efuse_xlate(struct ti_cpufreq_data *opp_data,
 	unsigned long calculated_efuse = AM62P5_SUPPORT_O_MPU_OPP;
 
 	switch (efuse) {
+	case AM62P5_EFUSE_V_MPU_OPP:
 	case AM62P5_EFUSE_U_MPU_OPP:
+	case AM62P5_EFUSE_T_MPU_OPP:
 	case AM62P5_EFUSE_S_MPU_OPP:
 		calculated_efuse |= AM62P5_SUPPORT_U_MPU_OPP;
 		fallthrough;
-- 
2.49.0



Return-Path: <linux-pm+bounces-31659-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CEBFAB16BB2
	for <lists+linux-pm@lfdr.de>; Thu, 31 Jul 2025 07:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F85F1AA575F
	for <lists+linux-pm@lfdr.de>; Thu, 31 Jul 2025 05:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3735E246775;
	Thu, 31 Jul 2025 05:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="EB8FyFJS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C27244683;
	Thu, 31 Jul 2025 05:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753940874; cv=none; b=fMV+XVrs4PKUjSSc8ws+tH5eo5mLM8VJlgbX8qAZdAOIh49zR6vRg5bh4NTHOSTOCWxIPqNw5KlGUbVfZMD6bT3x2ebMysX29jM11C1+9Jaf7/1xlZDsGUJR5AXIfE8G9Sd2N5c6UxJi3kFp23a5stgrS1OH8aG2jt2zQ61WQjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753940874; c=relaxed/simple;
	bh=DkySQ9C6S2kjZcTV+DRFTNGRLwaEe/YY6YKOlioQj/4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZZu75H6MZMStyZtid+OXA+f/WW0n4vaTfOeqRr0svYpOUAlzkU8TVSx4k6fIwDTz7tz/z6WRg120TQsZLeSICmcSE7SJ5wEtMf+FNTOegIIJ7y4ZkDwwyy1KoJlYrFTSGmzTtX9WGiZ5N01sPwRQGBJDkkrloaGqyewHbJdCd0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=EB8FyFJS; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1753940868;
	bh=x6e4i3YoKlDiQe2/JuPqV82fMICTL+9U6m2WYDkZjpo=; l=2264;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=EB8FyFJSiyrobSwbmts0uuiMVftYu5+e7m93o+FkowrZPBR+XUN0vVjA7pkWguxxR
	 pTe4KRvlbr3la6PkH4jF4NamRuKq+Dhm+JlXzN04t+5bMIj46lVpNiWxnIoPAjoH3n
	 axfe0RF1OHMgBSMtWdSpQNJSaLYiMdATq2vcqWykyOcMisjlS+7kECgcWvBHyJdipF
	 j4JedCnQLSn5hsak1tYJX7o/dD979ByRhUehkyyBM/UVa0E5Xlp9GRfN1svcC1NTqN
	 l2OfGfFkLwrskPDiCi55mUylZrfKnbzcCAYiJp3CSLp8wwKs4POJCuYkFm7c+79DL1
	 j4K/BfwpuTiJw==
Received: from 192.168.10.47
	by mg.richtek.com with MailGates ESMTPS Server V6.0(244590:0:AUTH_RELAY)
	(envelope-from <cy_huang@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Thu, 31 Jul 2025 13:47:38 +0800 (CST)
Received: from ex3.rt.l (192.168.10.46) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 31 Jul
 2025 13:47:38 +0800
Received: from git-send.richtek.com (192.168.10.154) by ex3.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1544.11 via Frontend
 Transport; Thu, 31 Jul 2025 13:47:37 +0800
From: <cy_huang@richtek.com>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
CC: Conor Dooley <conor+dt@kernel.org>, ChiYuan Huang <cy_huang@richtek.com>,
	<devicetree@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/3] Documentation: power: rt9756: Document exported sysfs entries
Date: Thu, 31 Jul 2025 13:48:18 +0800
Message-ID: <49a89b9da1f903b0326d3f448849183e62c64dc3.1753940508.git.cy_huang@richtek.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1753940508.git.cy_huang@richtek.com>
References: <cover.1753940508.git.cy_huang@richtek.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: ChiYuan Huang <cy_huang@richtek.com>

Document the settings exported by rt9756 charger driver through sysfs
entries:

- watchdog_timer
- battery_voltage
- battery_current
- operation_mode

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
 .../ABI/testing/sysfs-class-power-rt9756      | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-power-rt9756

diff --git a/Documentation/ABI/testing/sysfs-class-power-rt9756 b/Documentation/ABI/testing/sysfs-class-power-rt9756
new file mode 100644
index 000000000000..2d0f7ef1b855
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-power-rt9756
@@ -0,0 +1,52 @@
+What:		/sys/class/power_supply/rt9756-*/watchdog_timer
+Date:		Aug 2025
+KernelVersion:	6.17
+Contact:	ChiYuan Huang <cy_huang@richtek.com>
+Description:
+		This entry shows and sets the watchdog timer when rt9756 charger
+		operates in charging mode. When the timer expires, the device
+		will disable the charging. To prevent the timer expires, any
+		host communication can make the timer restarted.
+
+		Access: Read, Write
+
+		Valid values:
+		- 500, 1000, 5000, 30000, 40000, 80000, 128000 or 255000 (milliseconds),
+		- 0: disabled
+
+What:		/sys/class/power_supply/rt9756-*/battery_voltage
+Date:		Aug 2025
+KernelVersion:	6.17
+Contact:	ChiYuan Huang <cy_huang@richtek.com>
+Description:
+		Reports the current BAT voltage.
+
+		Access: Read-Only
+
+		Valid values: Represented in microvolts
+
+What:		/sys/class/power_supply/rt9756-*/battery_current
+Date:		Aug 2025
+KernelVersion:	6.17
+Contact:	ChiYuan Huang <cy_huang@richtek.com>
+Description:
+		Reports the current BAT current.
+
+		Access: Read-Only
+
+		Valid values: Represented in microamps
+
+What:		/sys/class/power_supply/rt9756-*/operation_mode
+Date:		Aug 2025
+KernelVersion:	6.17
+Contact:	ChiYuan Huang <cy_huang@richtek.com>
+Description:
+		This entry shows and set the operation mode when rt9756 charger
+		operates in charging phase. If 'bypass' mode is used, internal
+		path will connect vbus directly to vbat. Else, default 'div2'
+		mode for the switch-cap charging.
+
+		Access: Read, Write
+
+		Valid values:
+		- 'bypass' or 'div2'
-- 
2.34.1



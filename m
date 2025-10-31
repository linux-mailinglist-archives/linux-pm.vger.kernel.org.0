Return-Path: <linux-pm+bounces-37161-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B3EC23853
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 08:18:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8A0F04E55F2
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 07:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D89329365;
	Fri, 31 Oct 2025 07:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="2iLh78A1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB8A45038;
	Fri, 31 Oct 2025 07:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761895114; cv=none; b=CzXIfpaGZGkEFiCaBdXbiNeUbFgipzQ95c7S5f6z99revzAUuDq4o83FqcU60mgGPOKdAh8/nDRG+CNCegl+0JrKKJ55tMhKUW6p/Pjhcf1NfOsp6qxNg3vNjqDK0wOB7mdw13RkUISZfaJEMCCa65JEIYPnwnQ4dVu4tmLEudI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761895114; c=relaxed/simple;
	bh=vZmH4j1iRBHdyP/11gWs1D7OulzeT5LPIZQzEfM5xtY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lwhhfq/WpBA7k6Ay98xi1/692VOIydosv4P0eq499+1+KxaLTWCgo04k6oYUvGIxkFgig1MjT0wIzvSptrvwgLHxJzW8YP+inMDpVJqrz0roIbfN4JWMxBG3+Y/Rke6wahCaVx8yo7EGJpwjYuJyX5ZrcGRrZVo3gd+fr8vn47A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=2iLh78A1; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1761895103;
	bh=SBAaGqZMQDv2mThH8h5PuvqVwOb0ebtKCEAGSC2lmyQ=; l=1765;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=2iLh78A1ZwXrpsX6RCU4pII2g/PSTKFfqRYiNeozJ8AeP8WeGOffgj+UovDDfX18N
	 W0rPvHfdso1K2+7WW1WtTs6CqAQuuDMKr4kBz+8pTYon24hHcVAK5pD7cwuERmFSZt
	 rrI+23A+oo88hSoa8VZObWszWetPoJKu/Udji1SBxdsY8gyWSY/nx2uFGfrJpEr/DQ
	 Q3pFkcPYPiapQRPxjPzOAVsnyVL11T1+poiWfbek91l3gv3q0cOVWu8nvV/lIuY4PG
	 NkqfY481tE2mlLbhCY92/nd4gthTd96Im0d+AWfe/KJfgTu3V/ynL/ySDxn+K89tya
	 g+bU+MBBYJ+7w==
Received: from 192.168.10.46
	by mg.richtek.com with MailGates ESMTPS Server V6.0(3436931:0:AUTH_RELAY)
	(envelope-from <cy_huang@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Fri, 31 Oct 2025 15:18:09 +0800 (CST)
Received: from ex4.rt.l (192.168.10.47) by ex3.rt.l (192.168.10.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.26; Fri, 31 Oct
 2025 15:18:08 +0800
Received: from git-send.richtek.com (192.168.10.154) by ex4.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1748.26 via Frontend
 Transport; Fri, 31 Oct 2025 15:18:08 +0800
From: <cy_huang@richtek.com>
To: Sebastian Reichel <sre@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>
CC: ob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "ChiYuan
 Huang" <cy_huang@richtek.com>, <devicetree@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 3/3] Documentation: power: rt9756: Document exported sysfs entries
Date: Fri, 31 Oct 2025 15:19:35 +0800
Message-ID: <5138d4aa760d6ff81a5296cdf010a447056abce4.1761894605.git.cy_huang@richtek.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1761894605.git.cy_huang@richtek.com>
References: <cover.1761894605.git.cy_huang@richtek.com>
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
- operation_mode

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
V3
- Remove customized description for battery voltage and current
---
 .../ABI/testing/sysfs-class-power-rt9756      | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-power-rt9756

diff --git a/Documentation/ABI/testing/sysfs-class-power-rt9756 b/Documentation/ABI/testing/sysfs-class-power-rt9756
new file mode 100644
index 000000000000..c4d6c2b4715d
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-power-rt9756
@@ -0,0 +1,30 @@
+What:		/sys/class/power_supply/rt9756-*/watchdog_timer
+Date:		Dec 2025
+KernelVersion:	6.19
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
+What:		/sys/class/power_supply/rt9756-*/operation_mode
+Date:		Dec 2025
+KernelVersion:	6.19
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



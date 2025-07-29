Return-Path: <linux-pm+bounces-31532-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 816C3B14728
	for <lists+linux-pm@lfdr.de>; Tue, 29 Jul 2025 06:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7E6117F792
	for <lists+linux-pm@lfdr.de>; Tue, 29 Jul 2025 04:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D962230BDB;
	Tue, 29 Jul 2025 04:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="BhWVday4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A392165E2;
	Tue, 29 Jul 2025 04:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753762905; cv=none; b=t9H+2JM6IRvllzOhaAoTB+/EYOuDyWMwOAQQCw3DMmk2Fc3ih00GLlNwwF9H+P1CTUoiNe+0tPEXRxNa/l3IP5pzVHJa0kR//0bLAkiZNd3iA61f08w0+skxzjXLbDV7yun6RqJ3Dq6dUcgWfgvBS5rAFrDWn8X3qzAvVPIEznI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753762905; c=relaxed/simple;
	bh=DkySQ9C6S2kjZcTV+DRFTNGRLwaEe/YY6YKOlioQj/4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fmlc5vokqm/9SOdu42D4RBjzePQe3HgkxNJgX72sP+eg3hEItRilIBWmg7L6sMzVE+Lmdkf1vb9F8PrA0dIdqo0LQLBzwqxsnZUFbXy8CYB97nXl0HAjfYzjyWI0NneLAcgTW0AxcIyozI7Nl+INpFi/fR9S5yfbD2/c3gZd39Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=BhWVday4; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1753762892;
	bh=x6e4i3YoKlDiQe2/JuPqV82fMICTL+9U6m2WYDkZjpo=; l=2264;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=BhWVday4Z0ed/aycNj5/iQ21AK3c4KAFp8MkmGru1SdB2gqoCtbsxV1khXEJKQPTA
	 gj/nrt56VwTruY3TUPf05uB6u/JtyYcCgwyALfDkQNpw+H2eV4VrHNEawbsSE93xey
	 N8S4eLkRoVQafaES+Vmg3TBj1OaT+q+MvDZmOt4OJWKs88OJ48h20mao2QnNNeA8iC
	 uvzc6CLM2nih/oM0p/5IoDkLFw3/S7+RyLWrNF7h+SXjF45DO61l2qLaYQRY30HO0W
	 k5g1QX9ZsdUY5v4UjOLXanZHAfshbbvZSsnOhCo+AuVgm7jSv0L1d226diZsEjcMcJ
	 PVcCBkiYrIQ6w==
Received: from 192.168.10.47
	by mg.richtek.com with MailGates ESMTPS Server V6.0(244577:0:AUTH_RELAY)
	(envelope-from <cy_huang@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Tue, 29 Jul 2025 12:21:18 +0800 (CST)
Received: from ex3.rt.l (192.168.10.46) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 29 Jul
 2025 12:21:18 +0800
Received: from git-send.richtek.com (192.168.10.154) by ex3.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1544.11 via Frontend
 Transport; Tue, 29 Jul 2025 12:21:18 +0800
From: <cy_huang@richtek.com>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
CC: Conor Dooley <conor+dt@kernel.org>, ChiYuan Huang <cy_huang@richtek.com>,
	<devicetree@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] Documentation: power: rt9756: Document exported sysfs entries
Date: Tue, 29 Jul 2025 12:21:56 +0800
Message-ID: <0440825afccf3234997eded18b8a10f1f95638c0.1753759794.git.cy_huang@richtek.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1753759794.git.cy_huang@richtek.com>
References: <cover.1753759794.git.cy_huang@richtek.com>
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



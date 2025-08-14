Return-Path: <linux-pm+bounces-32377-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ABBBB25D90
	for <lists+linux-pm@lfdr.de>; Thu, 14 Aug 2025 09:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22A4B58516B
	for <lists+linux-pm@lfdr.de>; Thu, 14 Aug 2025 07:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BEBA277011;
	Thu, 14 Aug 2025 07:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="stogpr7V"
X-Original-To: linux-pm@vger.kernel.org
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6714526C398;
	Thu, 14 Aug 2025 07:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755156633; cv=none; b=h187jAin3oFa/FRSuunEDLss7euCcH8M3XqKbZeLQXPdZUf8pHEZPmHFiAFVv/rkSmUuFrKKPodTPkQC0tJcwDplMEasNMJCdOXGal4g07/ojxUfBz6ovbDs9YR+J3nRz99yAAd0hRdz3Rp3RCxOkDNlykC1w0UY7z4TLfCCEuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755156633; c=relaxed/simple;
	bh=DkySQ9C6S2kjZcTV+DRFTNGRLwaEe/YY6YKOlioQj/4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p1PYnMw+iMyiNatfP2nhpNb8heSqgFjZb4LML0XrKe3xKnHNZsQ/evp6S5ovAKDBjYA3k03hz3a0bf0vfb06L0H3HM+M1wuxZonrTL6OeFtVYE+pQLZUIXOYBuF6vLnS51w/wInamoD7RGtOz40U9Q83dYzwIZyPH/vZRPJgYVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=stogpr7V; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1755156627;
	bh=x6e4i3YoKlDiQe2/JuPqV82fMICTL+9U6m2WYDkZjpo=; l=2264;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=stogpr7V5+s86LPBnv+mtcDQhWLvdk+gu6uV95mJEJMDfQNKS1j8Fjfh6LKWw9XYe
	 tZ1RvTTS2u6CvwfReUYKXkk2Ug2AXb9NYSdO9kgHa8LHzI7yyCrB7jvferWnKUNYss
	 olJ/m5mSZenL5Tpbji+cTugQRJ86tSA5D8h23cPa5FdtyfuL9xjxWF2Q7bQUI3elm2
	 AiiH2KiPu0syQuTa2c7Dx6ZfZlSfmuC42oPj/LF4MMfbZSig41hojcG0o+pP/HOnaZ
	 IP9NaBNnSuodH61dTz84j0aX6vHuyVK9kQL88Gs8gDYAcGyngeACKCmPszuoc2A2gx
	 0JiEtGr5ilVPg==
Received: from 192.168.10.46
	by mg.richtek.com with MailGates ESMTPS Server V6.0(817463:0:AUTH_RELAY)
	(envelope-from <cy_huang@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Thu, 14 Aug 2025 15:30:19 +0800 (CST)
Received: from ex4.rt.l (192.168.10.47) by ex3.rt.l (192.168.10.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 14 Aug
 2025 15:30:19 +0800
Received: from git-send.richtek.com (192.168.10.154) by ex4.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1544.11 via Frontend
 Transport; Thu, 14 Aug 2025 15:30:19 +0800
From: <cy_huang@richtek.com>
To: Sebastian Reichel <sre@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>
CC: Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	"ChiYuan Huang" <cy_huang@richtek.com>, <devicetree@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH RESEND v2 3/3] Documentation: power: rt9756: Document exported sysfs entries
Date: Thu, 14 Aug 2025 15:31:08 +0800
Message-ID: <33c2cd77282b78e9b29e59959f27a52d86593ebf.1755154950.git.cy_huang@richtek.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1755154950.git.cy_huang@richtek.com>
References: <cover.1755154950.git.cy_huang@richtek.com>
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



Return-Path: <linux-pm+bounces-37140-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D40FC2216D
	for <lists+linux-pm@lfdr.de>; Thu, 30 Oct 2025 20:55:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C55651A6608A
	for <lists+linux-pm@lfdr.de>; Thu, 30 Oct 2025 19:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2EC3148AD;
	Thu, 30 Oct 2025 19:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H5JZGt50"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9141A243946;
	Thu, 30 Oct 2025 19:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761853960; cv=none; b=BwUC8iSfrfbP20UCYRBv528m0GXTmVfwmpTwFyQrVdUocLU+E6Akqrey3woHXHquhwYtCt10CKvT8g/njUTMxzFF0OTvGDWXkKHtR0r60kcTuzTaL2fCpY1qJkHUzto8cPob1YQjfw8+jgCwLhGHpnCNq4YaO2374R+cn8omWOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761853960; c=relaxed/simple;
	bh=4HgBipmxXhhcehiRlZMF9JboY2r196/ISN/o9pU8e4U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d9+M7RIiB1EIo3Ejd+TWk8+jZtFzLMc+gN9JpKWcel6IF7Cm7+yZ6BAdTJDhJJUEkk3OGEC9F+AbFyKfhtYDPX14b4k2zPYnGrfHRslMoV+JrBXIxHmZ69UfVEhX0YrYYp2HPuPFu7KLlkQGlHGMt9oU6D6+m+VcVvlyIdNMpPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H5JZGt50; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E93FDC4CEF8;
	Thu, 30 Oct 2025 19:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761853960;
	bh=4HgBipmxXhhcehiRlZMF9JboY2r196/ISN/o9pU8e4U=;
	h=From:To:Cc:Subject:Date:From;
	b=H5JZGt50+ojeqazuWXanXi5S58Xofr2W6JQC9zcJQCtsmTqaNTDSiY0rqVLlM2/6P
	 cH94rgGc/GlS6pIY6tQGNIwvhtDSRPJlCtygzfKRH7GU9x9drXlryAH9ZLrFQtCCzI
	 mMOa6yJkNcWm/TI1LGlNAju4ffSFcv7PodDAgcHn61n2cy5BUJOsGxOb1Jk6AzfUgw
	 G4vx0FLwUHXnHGZN4IjVWd96xhc5vQ1vRo8gwo0vrDggGIxv04wKTOyFsaPRx02hmf
	 ghXbyDyTmTaGreTMsn4XN16eCBOG944xXesfCh80CYC9b+UNwGrI+V6zzE0r/PGMvY
	 9UM7n+rZbK7+Q==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: thermal: Drop db8500-thermal.txt
Date: Thu, 30 Oct 2025 14:52:33 -0500
Message-ID: <20251030195234.439141-1-robh@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The binding is already defined in mfd/stericsson,db8500-prcmu.yaml and none
of 'the tripN.*' properties appear to be in use.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/thermal/db8500-thermal.txt       | 44 -------------------
 1 file changed, 44 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/thermal/db8500-thermal.txt

diff --git a/Documentation/devicetree/bindings/thermal/db8500-thermal.txt b/Documentation/devicetree/bindings/thermal/db8500-thermal.txt
deleted file mode 100644
index 2e1c06fad81f..000000000000
--- a/Documentation/devicetree/bindings/thermal/db8500-thermal.txt
+++ /dev/null
@@ -1,44 +0,0 @@
-* ST-Ericsson DB8500 Thermal
-
-** Thermal node properties:
-
-- compatible : "stericsson,db8500-thermal";
-- reg : address range of the thermal sensor registers;
-- interrupts : interrupts generated from PRCMU;
-- interrupt-names : "IRQ_HOTMON_LOW" and "IRQ_HOTMON_HIGH";
-- num-trips : number of total trip points, this is required, set it 0 if none,
-  if greater than 0, the following properties must be defined;
-- tripN-temp : temperature of trip point N, should be in ascending order;
-- tripN-type : type of trip point N, should be one of "active" "passive" "hot"
-  "critical";
-- tripN-cdev-num : number of the cooling devices which can be bound to trip
-  point N, this is required if trip point N is defined, set it 0 if none,
-  otherwise the following cooling device names must be defined;
-- tripN-cdev-nameM : name of the No. M cooling device of trip point N;
-
-Usually the num-trips and tripN-*** are separated in board related dts files.
-
-Example:
-thermal@801573c0 {
-	compatible = "stericsson,db8500-thermal";
-	reg = <0x801573c0 0x40>;
-	interrupts = <21 0x4>, <22 0x4>;
-	interrupt-names = "IRQ_HOTMON_LOW", "IRQ_HOTMON_HIGH";
-
-	num-trips = <3>;
-
-	trip0-temp = <75000>;
-	trip0-type = "active";
-	trip0-cdev-num = <1>;
-	trip0-cdev-name0 = "thermal-cpufreq-0";
-
-	trip1-temp = <80000>;
-	trip1-type = "active";
-	trip1-cdev-num = <2>;
-	trip1-cdev-name0 = "thermal-cpufreq-0";
-	trip1-cdev-name1 = "thermal-fan";
-
-	trip2-temp = <85000>;
-	trip2-type = "critical";
-	trip2-cdev-num = <0>;
-}
-- 
2.51.0



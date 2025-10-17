Return-Path: <linux-pm+bounces-36343-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DEABE7DAE
	for <lists+linux-pm@lfdr.de>; Fri, 17 Oct 2025 11:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B83CE355405
	for <lists+linux-pm@lfdr.de>; Fri, 17 Oct 2025 09:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102E62D6630;
	Fri, 17 Oct 2025 09:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="KjDu7KZY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-m1973198.qiye.163.com (mail-m1973198.qiye.163.com [220.197.31.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550E42D5412;
	Fri, 17 Oct 2025 09:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760694241; cv=none; b=UICJULN70P80boSaXW+NaRkZpe1yZmlpKkPzJmH0Jz5NfDziiMzNm7ZWZPXNt53R7Vr3jG6TZNdRove2rZZPzUZYjYn9LPA4D5qtkQVv6veK25UtoCzj2lPvoZGeofCdpGz+IpwhLpLs47+TiziLQz4flWwqfH0wgHCJFTT+XEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760694241; c=relaxed/simple;
	bh=dFGA4DHWgQLENizJk+LxFqdjUnXVAweKR66WB2g1Xnk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bnLU8T9HuBHOcAlNU1Bt/+lBMlGOQxv+yQK53aCGYMQp/Iq0JKgL6W0XZlZjWqcqhPDsc0+5Y8DGYsLCqrW6Ii8CFuToGqU9VRV9dqs9AHeHUxBOofbrfg7QLB1r9aOxT4FKphVqiVl1GSAQpyywrNnoPUi4H8niFSahnU5Ebxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=KjDu7KZY; arc=none smtp.client-ip=220.197.31.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from xf.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 264523289;
	Fri, 17 Oct 2025 17:38:45 +0800 (GMT+08:00)
From: Finley Xiao <finley.xiao@rock-chips.com>
To: heiko@sntech.de
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ulf.hansson@linaro.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	zhangqing@rock-chips.com,
	sugar.zhang@rock-chips.com,
	huangtao@rock-chips.com,
	Finley Xiao <finley.xiao@rock-chips.com>
Subject: [PATCH v4 1/2] dt-bindings: power: rockchip: Add support for RV1126B
Date: Fri, 17 Oct 2025 17:38:33 +0800
Message-ID: <20251017093834.331998-2-finley.xiao@rock-chips.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251017093834.331998-1-finley.xiao@rock-chips.com>
References: <20251017093834.331998-1-finley.xiao@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a99f189367303a9kunmbe68a2b91699a1
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGR5MQlYZTRpISk9OTEIfH0hWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=KjDu7KZYwvMMvehYa6i+/DrL2bAKCzaRo22MYugb1yMAheEVkvGXYZAFGdd4rltmi0dsMAODKtp1XwsedAp0s5M+NWPW2RaCXZddt0a8C4BOxaa8EQIrwunDGZRPPG2h3LLifAF35f+6TlkLX59OWx8SgnOvhGa3+HEcZU81sXg=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=lFTsqZOJG3tTxh/WHpsWEhcE4BuXs5luqR1m915IRaI=;
	h=date:mime-version:subject:message-id:from;

Add power domain IDs for RV1126B SoC.
Add a new compatible because register fields have changed.

Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
---

Changes in v4:
- rename to rockchip,rv1126b-power-controller.h

Changes in v3:
- modify the patch format

Changes in v2:
- update the commit message
- update the license
- rename AISP to AIISP

 .../power/rockchip,power-controller.yaml        |  2 ++
 .../power/rockchip,rv1126b-power-controller.h   | 17 +++++++++++++++++
 2 files changed, 19 insertions(+)
 create mode 100644 include/dt-bindings/power/rockchip,rv1126b-power-controller.h

diff --git a/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml b/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
index a884e49c995f..b41db576f95d 100644
--- a/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
+++ b/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
@@ -46,6 +46,7 @@ properties:
       - rockchip,rk3576-power-controller
       - rockchip,rk3588-power-controller
       - rockchip,rv1126-power-controller
+      - rockchip,rv1126b-power-controller
 
   "#power-domain-cells":
     const: 1
@@ -126,6 +127,7 @@ $defs:
           "include/dt-bindings/power/rk3568-power.h"
           "include/dt-bindings/power/rk3588-power.h"
           "include/dt-bindings/power/rockchip,rv1126-power.h"
+          "include/dt-bindings/power/rockchip,rv1126b-power-controller.h"
 
       clocks:
         minItems: 1
diff --git a/include/dt-bindings/power/rockchip,rv1126b-power-controller.h b/include/dt-bindings/power/rockchip,rv1126b-power-controller.h
new file mode 100644
index 000000000000..48ea87a4423c
--- /dev/null
+++ b/include/dt-bindings/power/rockchip,rv1126b-power-controller.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
+/*
+ * Copyright (c) 2024 Rockchip Electronics Co., Ltd.
+ * Author: Finley Xiao <finley.xiao@rock-chips.com>
+ */
+
+#ifndef __DT_BINDINGS_POWER_RV1126B_POWER_CONTROLLER_H__
+#define __DT_BINDINGS_POWER_RV1126B_POWER_CONTROLLER_H__
+
+/* VD_NPU */
+#define RV1126B_PD_NPU		0
+
+/* VD_LOGIC */
+#define RV1126B_PD_VDO		1
+#define RV1126B_PD_AIISP	2
+
+#endif
-- 
2.43.0



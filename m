Return-Path: <linux-pm+bounces-36323-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4C6BE6384
	for <lists+linux-pm@lfdr.de>; Fri, 17 Oct 2025 05:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A45984FC151
	for <lists+linux-pm@lfdr.de>; Fri, 17 Oct 2025 03:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9AE2BE05F;
	Fri, 17 Oct 2025 03:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="jAO7b3bm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-m1973175.qiye.163.com (mail-m1973175.qiye.163.com [220.197.31.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC27A29DB8F;
	Fri, 17 Oct 2025 03:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760672296; cv=none; b=uBhb3mYYezimWJoWtf9amk/OGfQlyyzHqVBvgPZhgzkeKT3Pg1kSmHuiZAwdiuTB5nkHLq+xLbWEgZ1/ApoHEygvWSKf8q+6ZdECJPhXqxenRvm7Ef8Efl/G9GX2Rfg6FvtqVFgB7wElyRXUJBSXrNRlSdsvq0tflTiKibuJfr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760672296; c=relaxed/simple;
	bh=S+gxdJK20Tr+LSpgLnCqjoTFk7koEX59mJS3ttzXrRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rA4U2LBXVVT3i445bCCbhciiR/YpAco2DW56/Bu6jHWAIi+ghQi5vq5LqUXzepAUuvsn+x56jm33Tn52ekBTsh7eJuXOb4WpOJftpe9/NsBPeQGqIzC3INoJZJGn36PnspUF4w7rg/4EauEyr1a0ZvrdsrJpf1KqpVfWIrYBjeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=jAO7b3bm; arc=none smtp.client-ip=220.197.31.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from xf.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2638429cb;
	Fri, 17 Oct 2025 11:38:00 +0800 (GMT+08:00)
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
	Finley Xiao <finley.xiao@rock-chips.com>
Subject: [PATCH v2 1/2] dt-bindings: power: rockchip: Add support for RV1126B
Date: Fri, 17 Oct 2025 11:14:24 +0800
Message-ID: <20251017031425.310946-2-finley.xiao@rock-chips.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251017031425.310946-1-finley.xiao@rock-chips.com>
References: <20251017031425.310946-1-finley.xiao@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a99f03eee1303a9kunm1150bbeadf328
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkpLHVZDThlCQx5DSBlIS0NWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=jAO7b3bmrqxviNpkZtwN17kNLEp0BFxUdFsP3x5PHjWylhgoKHwa/O2YVcujAlws32a0L5PBIqPOLALBTW+EDZGgP8RxhEwoRhA1u/1kyKij2/TCuB01zKtm1iObjlNiwqiwELJXI2CJkV1HABHd8Q5iA9bW/3hOmDUhEtx3l7s=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=P/9fnC/2O6saU02SSiuS88NA/O5UcCLC92SVbjjmKy0=;
	h=date:mime-version:subject:message-id:from;

Add power domain IDs for RV1126B SoC.
Add a new compatible because register fields have changed.

Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>

Changes in v2:
- update the commit message
- update the license
- rename AISP to AIISP

---
 .../power/rockchip,power-controller.yaml        |  2 ++
 .../dt-bindings/power/rockchip,rv1126b-power.h  | 17 +++++++++++++++++
 2 files changed, 19 insertions(+)
 create mode 100644 include/dt-bindings/power/rockchip,rv1126b-power.h

diff --git a/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml b/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
index a884e49c995f..f9db602de258 100644
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
+          "include/dt-bindings/power/rockchip,rv1126b-power.h"
 
       clocks:
         minItems: 1
diff --git a/include/dt-bindings/power/rockchip,rv1126b-power.h b/include/dt-bindings/power/rockchip,rv1126b-power.h
new file mode 100644
index 000000000000..beb692bd8e72
--- /dev/null
+++ b/include/dt-bindings/power/rockchip,rv1126b-power.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
+/*
+ * Copyright (c) 2024 Rockchip Electronics Co., Ltd.
+ * Author: Finley Xiao <finley.xiao@rock-chips.com>
+ */
+
+#ifndef __DT_BINDINGS_POWER_RV1126B_POWER_H__
+#define __DT_BINDINGS_POWER_RV1126B_POWER_H__
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



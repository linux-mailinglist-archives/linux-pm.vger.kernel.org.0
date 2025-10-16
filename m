Return-Path: <linux-pm+bounces-36258-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ACC2BE3C2F
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 15:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5472B586F9B
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 13:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E0233CE8B;
	Thu, 16 Oct 2025 13:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="I9vI8nQc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-m49251.qiye.163.com (mail-m49251.qiye.163.com [45.254.49.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23788339B2A;
	Thu, 16 Oct 2025 13:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760622116; cv=none; b=Sy1zVaAC4ZcT//IJ4R5x0x+rllSAb2ph9HtgNEY8I34cPpm60vccwvzbewX8HpUDvKhgIqikohZqbjiD+nd72IKZoMVuRJ5MyNA6/viTpdrNzas9RGHMjJ6Bbqwn7JvEcFDu4blMFd3u+99M8s3qxhyVdfvuzLjHeYHWw95goYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760622116; c=relaxed/simple;
	bh=/tD2SrZkdDztlGnKpdt61sUtLG7HGExNANGUwBvMCSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eoKMBZITWefI72XsPU9GDZ+jYmFz05ro62qc7DIcPlVhqsi6FDUE5tUOFw+RJzaeM5bqZ7r1Xs2Cy2K9yFnzZ3U/2epYQh9l4cvd2nWSkx7qrDUT+sMm8E1kD6qJZ7FCMk6MLhHeiaBEQVzpsCU9Bh5c+4CJuWXe2XZ2Nw/5LkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=I9vI8nQc; arc=none smtp.client-ip=45.254.49.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from xf.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 26283fe38;
	Thu, 16 Oct 2025 21:41:47 +0800 (GMT+08:00)
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
	finley.xiao@rock-chips.com,
	zhangqing@rock-chips.com,
	sugar.zhang@rock-chips.com,
	huangtao@rock-chips.com
Subject: [PATCH v1 1/2] dt-bindings: power: rockchip: Add support for RV1126B
Date: Thu, 16 Oct 2025 21:41:02 +0800
Message-ID: <20251016134103.294636-2-finley.xiao@rock-chips.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251016134103.294636-1-finley.xiao@rock-chips.com>
References: <20251016134103.294636-1-finley.xiao@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a99ed4159e403a9kunm0a0c6b9d28655
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQklJHVYYGhpKGBpNT08ZSk1WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=I9vI8nQczWQy3DP95bfgsPAay2QjLm0Psn+mKGGRSoFPjubpTPXz7RpluqFeD+iB3cZrzHn3IHvvujyor7k5geUxta5GJOU5pmtleOWqfJzRKefytNIWRZPvp7XafwH5YMJ4HTkZjDy7kynCGMG5AOOLm5u39v8k+nMSQCJjCok=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=nv98wqplN2+zIis/g/iKLtF3JuIQw/bcfzKqgmtzFSw=;
	h=date:mime-version:subject:message-id:from;

Add the compatible string and power domain IDs for RV1126B SoC.

signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
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
index 000000000000..0a418f16e4ea
--- /dev/null
+++ b/include/dt-bindings/power/rockchip,rv1126b-power.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
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
+#define RV1126B_PD_AISP		2
+
+#endif
-- 
2.43.0



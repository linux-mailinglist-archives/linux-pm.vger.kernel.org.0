Return-Path: <linux-pm+bounces-12241-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 623529525AC
	for <lists+linux-pm@lfdr.de>; Thu, 15 Aug 2024 00:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12C4D1F23D48
	for <lists+linux-pm@lfdr.de>; Wed, 14 Aug 2024 22:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF77C14B943;
	Wed, 14 Aug 2024 22:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b="L2WDxHTS"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BA450269;
	Wed, 14 Aug 2024 22:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723674451; cv=pass; b=OL2aUJ8N7m/5dCLcPfzmOZm9Gh58YQA4UhMYPEeVhtI/KeTOUmiIMtc/BzpXBFPFOWAxamPeDq9a3L6LLkcit77rjhLmh++PyYbuQnxXlZSsmHW1Mo9YjVw45XdDuPXuxddK+yqQrmqvMDbQzgRQrk7bUNFyH+eYBSDtRJOcHLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723674451; c=relaxed/simple;
	bh=/KyD1vr0ZtdlGZmeo+eiTh+hiuDv5tRD7fybenxLNis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nb7KRt4ICYbZbyTj3s1MpqthRFYV1o72+biHMF99osUv1Vo0VnGhx/CmNJBcE/7ZTQAxuubOfVH0cdra5IDqqP+srzt1CZdgReTIrifhParZ8tHBFNUfSK5nD6EGdY7DVzreG4bNHnd0C3N3Td75tM5BhJsFHOEyPT5iDD03/Mo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b=L2WDxHTS; arc=pass smtp.client-ip=136.143.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: detlev.casanova@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1723674422; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=mfx93T741fEjtPvM/XY6JEMfqbh/b4dSy3OvqsihugBO8gFpOYuUJ+GqX6FH8ixfIZlPyKrgt2jaxmIMuHhx7A129iwrLHHhkX3U8+7hE1nZD+sqbsxPwKDnoeSipgrfG+/FTkxAvtfCVq31r40vIrCaqyNgYmM8l1zWkTgSB4k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1723674422; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=jtk6kXHLiWSb3fabpSTdzCrxBw81ky2Jbh/22xPfH74=; 
	b=BNrByHHUjJ/MIRKKJnu4Hh66f+z/U5eLYv2l9oZRutvJcKKC+iEbslcSUX2vMqS3+RnMW4df02okb3vUV+Sz/HcyiGi40AUi7Z9iJLM9q0IK4Z9G/Thl0VOho/nybi5AfwimOPSKRTE+gl93kFgYxjAgSn/C6JULikE6eFO4VTA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=detlev.casanova@collabora.com;
	dmarc=pass header.from=<detlev.casanova@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723674422;
	s=zohomail; d=collabora.com; i=detlev.casanova@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=jtk6kXHLiWSb3fabpSTdzCrxBw81ky2Jbh/22xPfH74=;
	b=L2WDxHTSM0Uh3td0K1yE9nV4mTOKV5kVDOvMZ41DoLM8E4599XtCCsIkrzTBieTt
	TakR+bkENl254HQB/Uy+jk9rhYbz3Q9ia1TYKIRu3LjkNGFQgcBJphDtMHnixhDJsh9
	M6U6F9TdOtG7vh1lzzAZx5SV9lkdGzICg+s6H8io=
Received: by mx.zohomail.com with SMTPS id 1723674420081557.4306191685197;
	Wed, 14 Aug 2024 15:27:00 -0700 (PDT)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Finley Xiao <finley.xiao@rock-chips.com>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Jagan Teki <jagan@edgeble.ai>,
	Elaine Zhang <zhangqing@rock-chips.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-pm@vger.kernel.org,
	kernel@collabora.com,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v4 1/2] dt-bindings: power: Add support for RK3576 SoC
Date: Wed, 14 Aug 2024 18:26:41 -0400
Message-ID: <20240814222824.3170-2-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240814222824.3170-1-detlev.casanova@collabora.com>
References: <20240814222824.3170-1-detlev.casanova@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

From: Finley Xiao <finley.xiao@rock-chips.com>

Define power domain IDs as described in the TRM and add compatible for
rockchip,rk3576-power-controller

Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
Co-Developed-by: Detlev Casanova <detlev.casanova@collabora.com>
Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../power/rockchip,power-controller.yaml      |  1 +
 .../dt-bindings/power/rockchip,rk3576-power.h | 30 +++++++++++++++++++
 2 files changed, 31 insertions(+)
 create mode 100644 include/dt-bindings/power/rockchip,rk3576-power.h

diff --git a/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml b/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
index 0d5e999a58f1b..650dc0aae6f51 100644
--- a/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
+++ b/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
@@ -41,6 +41,7 @@ properties:
       - rockchip,rk3368-power-controller
       - rockchip,rk3399-power-controller
       - rockchip,rk3568-power-controller
+      - rockchip,rk3576-power-controller
       - rockchip,rk3588-power-controller
       - rockchip,rv1126-power-controller
 
diff --git a/include/dt-bindings/power/rockchip,rk3576-power.h b/include/dt-bindings/power/rockchip,rk3576-power.h
new file mode 100644
index 0000000000000..324a056aa8512
--- /dev/null
+++ b/include/dt-bindings/power/rockchip,rk3576-power.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
+#ifndef __DT_BINDINGS_POWER_RK3576_POWER_H__
+#define __DT_BINDINGS_POWER_RK3576_POWER_H__
+
+/* VD_NPU */
+#define RK3576_PD_NPU		0
+#define RK3576_PD_NPUTOP	1
+#define RK3576_PD_NPU0		2
+#define RK3576_PD_NPU1		3
+
+/* VD_GPU */
+#define RK3576_PD_GPU		4
+
+/* VD_LOGIC */
+#define RK3576_PD_NVM		5
+#define RK3576_PD_SDGMAC	6
+#define RK3576_PD_USB		7
+#define RK3576_PD_PHP		8
+#define RK3576_PD_SUBPHP	9
+#define RK3576_PD_AUDIO		10
+#define RK3576_PD_VEPU0		11
+#define RK3576_PD_VEPU1		12
+#define RK3576_PD_VPU		13
+#define RK3576_PD_VDEC		14
+#define RK3576_PD_VI		15
+#define RK3576_PD_VO0		16
+#define RK3576_PD_VO1		17
+#define RK3576_PD_VOP		18
+
+#endif
-- 
2.46.0



Return-Path: <linux-pm+bounces-12043-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA0994D0AD
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2024 14:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA1891F233F2
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2024 12:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4EF194A4B;
	Fri,  9 Aug 2024 12:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b="ATtkHeaQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA141E49B;
	Fri,  9 Aug 2024 12:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723208317; cv=pass; b=LuyaNR2PKQ8+efBKt1YG8sszSG9rLJ2Gnv7WtLABhXDFQ7DSZdsyRbH6lOwZT1wbwFyznC3jiRw3IiYcoxTbUuBRrfZ/MiFw/9p2mgigBLUjAlQAv/S+3oVXwNe0UxAxWJb8Hr433TrRaG3IXbjM/TrSTXJLhQN5gh+WL2n/dEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723208317; c=relaxed/simple;
	bh=TmXhq8Z9zdF+EcftMWkcPqg6cC8NKV7O84Q2Ne4BGxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nbg/yWMhQKgDhvhN5V5xbGTWNkKosvy4/yzvpg+AU8UxPY0N3y0EfQbhaRw3QmtDzaiXGxxIi0TyndtjAIa0VREGDIO4mVVzCr7DnhAJAaVVN4N9tquPBf7FHp+yCfxtER/sbr7W1j2e8ZCqqAVNCRaSUBqA/zD8Y1hs0ccu2Ko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b=ATtkHeaQ; arc=pass smtp.client-ip=136.143.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: detlev.casanova@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1723208295; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Dni0RNT2cRBAXccLJlOFCbjkkuGgSZ3leA2jTTdtkCvdB5VCv8+HIp/e6SAZvXrdeRJHJMrj4FF0vPDp0Vy+0E+GGSrvmIsOpz6ALwji4IhxXCkB9phq+CO1QsGsqT6d3ulK3eKK1UVqBjN5qmo0ODdtOm7TrfRmxs96vkJf5gM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1723208295; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=RyCepvyWzhp8Bg9hhu049ivfAGgOO+ujHi0U3uQVpzQ=; 
	b=N6nC2MNN2lwyXFyHlTiq+kD1eq1gdKZxCaizzF98jIIp48YRM1Gy+uYcOTpPpWnDCuD7eSBrC120UjIm0nkRe2QKoPJ4ZpDOANbzldu9sSrd1fuWTSukzSx4nz4n/vzteCKstaj+z+nYnM82L7O9OdfxROGKlmzcwNLCIxVZy4U=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=detlev.casanova@collabora.com;
	dmarc=pass header.from=<detlev.casanova@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723208295;
	s=zohomail; d=collabora.com; i=detlev.casanova@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=RyCepvyWzhp8Bg9hhu049ivfAGgOO+ujHi0U3uQVpzQ=;
	b=ATtkHeaQ4022HrnPvYITO0+xV8AkOlaT+q58GDEkCgiXhzcxFsjy6ElQl0i60oJV
	3A88F1FnHHYP22w97TqnSUauZ1an8AkIHLQuNqcTCrCa+TBdRJ5gmXDSTrlcGwrrLE7
	BNPznd7U6lnO/gQgB5PRbeGdRtmls3l4UL13nWDM=
Received: by mx.zohomail.com with SMTPS id 17232082904921014.7498633269371;
	Fri, 9 Aug 2024 05:58:10 -0700 (PDT)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Finley Xiao <finley.xiao@rock-chips.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Jagan Teki <jagan@edgeble.ai>,
	Elaine Zhang <zhangqing@rock-chips.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-pm@vger.kernel.org,
	kernel@collabora.com
Subject: [PATCH v3 1/2] dt-bindings: power: Add support for RK3576 SoC
Date: Fri,  9 Aug 2024 08:58:04 -0400
Message-ID: <20240809125925.4295-2-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240809125925.4295-1-detlev.casanova@collabora.com>
References: <20240809125925.4295-1-detlev.casanova@collabora.com>
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
[reword, add yaml]
Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
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



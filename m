Return-Path: <linux-pm+bounces-27288-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D67F6ABB227
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 00:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D50B173E76
	for <lists+linux-pm@lfdr.de>; Sun, 18 May 2025 22:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A29B20C030;
	Sun, 18 May 2025 22:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="uLw8naKT"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC4A7DA6A
	for <linux-pm@vger.kernel.org>; Sun, 18 May 2025 22:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747606698; cv=none; b=BBBMBwa5WR92jne0Vqb6ZYTyBqruRgGgKW8w2MZ5JSn56+r1grw0mY1+0epMO3DVH7VCWj4uK/MbJJeGO7FXOShfbRnxIVI2RGYio85q+oJwYUdP4m4FHA/eV2yymLOzFsivzSLSsByWCN0P8+/iVhe243B3o80Xscz76Wfr/kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747606698; c=relaxed/simple;
	bh=BWMwPlEuQ7mQzejKJ9C0StufR7/RSJC0y2TuNdLpLjU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NUaTbJWTCM0RpNxH0szleVhp9eFe+n1sgj2KtxzbXz9pTE+ldbGFriDig4KqOSw5TB/Twv0UGQr28HAIl3d0NR5DEzd4RCrqBwrTF2y7D4XnSDimRAii+w7/owwPnnTpRPBm8KBj7gmfFE4FH1Wtia+1QT/JW7kTP5sT/Svrhjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=uLw8naKT; arc=none smtp.client-ip=121.127.44.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1747606694; bh=ASi1sp/JbXHU8LqWjIYUcHi05JGXzMPUEeRdSNWaNOk=;
 b=uLw8naKTT+VCuzt/IwsCfLVZKDpWERVvj+ME4RgXm/U2bW/ubogMK45WkotlHRQxS2ktvoi4a
 ZVb6U6xBLBeEeg3wdPlImWL7FmTgLX63Hgw+OQMel4tTDolJpeFTt5HC63bLubaKPb5WeUrv8R5
 s8yZKz3IE3FkKmxs6+Ynqq1OVK4vabHM5VHkx4mfee98+Zd4rL0cIRRCdM+RdG/mKjUw9tSdCXU
 NFg6Er8GGUKXRh8Am5n0LxtvJsj5M8b3PJp8xEcTDv1zWHpUbBx9JXFuTOxMF0WLD7ZROUXaAzg
 BnUaFGBsT/Xm9lLIj7W4+oK8t0UESLhIiUmw1PK79gzg==
X-Forward-Email-ID: 682a5a1678cae75fbd8d467a
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.0.3
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Heiko Stuebner <heiko@sntech.de>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Elaine Zhang <zhangqing@rock-chips.com>
Cc: Yao Zi <ziyao@disroot.org>,
	Chukun Pan <amadeus@jmu.edu.cn>,
	linux-rockchip@lists.infradead.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Jonas Karlman <jonas@kwiboo.se>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/9] dt-bindings: power: rockchip: Add support for RK3528
Date: Sun, 18 May 2025 22:06:48 +0000
Message-ID: <20250518220707.669515-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250518220707.669515-1-jonas@kwiboo.se>
References: <20250518220707.669515-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the compatible string and power domains for RK3528 SoC.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 .../power/rockchip,power-controller.yaml      |  1 +
 .../dt-bindings/power/rockchip,rk3528-power.h | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)
 create mode 100644 include/dt-bindings/power/rockchip,rk3528-power.h

diff --git a/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml b/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
index f494b7710c09..a884e49c995f 100644
--- a/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
+++ b/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
@@ -40,6 +40,7 @@ properties:
       - rockchip,rk3366-power-controller
       - rockchip,rk3368-power-controller
       - rockchip,rk3399-power-controller
+      - rockchip,rk3528-power-controller
       - rockchip,rk3562-power-controller
       - rockchip,rk3568-power-controller
       - rockchip,rk3576-power-controller
diff --git a/include/dt-bindings/power/rockchip,rk3528-power.h b/include/dt-bindings/power/rockchip,rk3528-power.h
new file mode 100644
index 000000000000..318923cdaaf6
--- /dev/null
+++ b/include/dt-bindings/power/rockchip,rk3528-power.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
+#ifndef __DT_BINDINGS_POWER_RK3528_POWER_H__
+#define __DT_BINDINGS_POWER_RK3528_POWER_H__
+
+#define RK3528_PD_PMU		0
+#define RK3528_PD_BUS		1
+#define RK3528_PD_DDR		2
+#define RK3528_PD_MSCH		3
+
+/* VD_GPU */
+#define RK3528_PD_GPU		4
+
+/* VD_LOGIC */
+#define RK3528_PD_RKVDEC	5
+#define RK3528_PD_RKVENC	6
+#define RK3528_PD_VO		7
+#define RK3528_PD_VPU		8
+
+#endif
-- 
2.49.0



Return-Path: <linux-pm+bounces-11840-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF70494602D
	for <lists+linux-pm@lfdr.de>; Fri,  2 Aug 2024 17:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 892BE285AEC
	for <lists+linux-pm@lfdr.de>; Fri,  2 Aug 2024 15:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2341537C1;
	Fri,  2 Aug 2024 15:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="4/XKt9/D"
X-Original-To: linux-pm@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C747F3DAC19;
	Fri,  2 Aug 2024 15:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722611825; cv=none; b=Ew8hyozb/7JU3pENbc/WOIr2hjGsanGab7qgU8gLwC5TDk7Yi2poaHkHq0wk7ZkWh7aW4tbHePaLKUoBiMgnLkXRUcD3XpC3ALvYmRUdXVaecTneOw9pA7TJ5HREyXBmbYana9DCbZWmSE8yFgKOsNE6l+AApOyKy8gS5l70nDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722611825; c=relaxed/simple;
	bh=SWExRS/PWMp0B84ThEjdBRFIqsEtJzpNyT9yDX/hd6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=repi4ijBRib67CzrPWbAanvlR9Cbrc2Gc2UNpwQhF1isGMHTUMTEYI1e8snq9efdyl8bvtrbcKWtVyv+unE+HhX50Gyu0SWsnVlsfEvPGIYwjKZl5ljS0KX/El1EdtvYJp555A7uFStR+kKIhRmcd+KVnPkQIHz2oQ7CjSrmWEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=4/XKt9/D; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1722611822;
	bh=SWExRS/PWMp0B84ThEjdBRFIqsEtJzpNyT9yDX/hd6g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=4/XKt9/DyzMnnw5NzYTep6fTUXpqIOMUMu+ZY9AZnAcx7axqbsC+ABsZVllm1LDo4
	 1ev13kqLDw6L2I2aj17HdPSz5OMFba7aJm4no9ayJ1tWFJD2del/XIHmsa+CiEbS1Y
	 BUMlDad6OwgUy4dGXVJVJ+S3rRaxUPAsebyNulSIaPdXilUg5INf4ri9MIACATxbmu
	 uue4ye5XNFIQP61CLqF1Nb89IDdXHe313IBRdvBxJwxBNGSyY2g58aYl/7Y+SmBf35
	 Rywo03HHw/xDC4wUhO90VqDO/c9MZBCtCrBFBFTdxJmUQnQSiFPkBTT7Pd5VZ0Z0Hj
	 S2+HQkenUSULw==
Received: from trenzalore.hitronhub.home (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: detlev)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id DED83378221A;
	Fri,  2 Aug 2024 15:16:59 +0000 (UTC)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Finley Xiao <finley.xiao@rock-chips.com>,
	Jagan Teki <jagan@edgeble.ai>,
	Elaine Zhang <zhangqing@rock-chips.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-pm@vger.kernel.org
Subject: [PATCH 2/3] dt-bindings: Add power-domain header for RK3576 SoCs
Date: Fri,  2 Aug 2024 11:14:59 -0400
Message-ID: <20240802151647.294307-3-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240802151647.294307-1-detlev.casanova@collabora.com>
References: <20240802151647.294307-1-detlev.casanova@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Finley Xiao <finley.xiao@rock-chips.com>

Define power domain IDs as described in the TRM.

Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
[reword]
Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
---
 include/dt-bindings/power/rk3576-power.h | 30 ++++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 include/dt-bindings/power/rk3576-power.h

diff --git a/include/dt-bindings/power/rk3576-power.h b/include/dt-bindings/power/rk3576-power.h
new file mode 100644
index 0000000000000..cb33a32c1aed9
--- /dev/null
+++ b/include/dt-bindings/power/rk3576-power.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
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



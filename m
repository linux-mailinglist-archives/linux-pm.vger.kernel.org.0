Return-Path: <linux-pm+bounces-10110-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD7B91A5A1
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 13:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BEA0282C54
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 11:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9EA314D6FC;
	Thu, 27 Jun 2024 11:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uEhmHgv6"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAC814882B;
	Thu, 27 Jun 2024 11:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719488875; cv=none; b=tBVz5hcPWCkehFdzPl1PFxOCrIXG6n3qMUU6FUdB/c/QkS3dBGgn9VQ6Nl3DAUaVwirF03Ox/eZaIPtZX6AtNpPWvNeqiy0E0ERkMlvTVWVbumgE7mJCL5/aDuLVu8gWlZbOG5aeZjbM1j0FjMWZSyBBJ5mZpDPZIWTG+CAYH5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719488875; c=relaxed/simple;
	bh=Ai1qsjDV8TVB8n60kMviqZ3G0IrZICdk1tqlzmLNIcQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YJRYQszfb5zPSh8Eqx7deivKhv7YWnizDGQmOe6LG8Ly+pQPaCRDa6z8lxdZMv7mKTdNWka7nxlsQMytDfey7U8mVEYZ5dH1QTnXMgF6wMXI3Fouj407dftJAWJQt83vRdFgOJUZwl8Q3jvWosZo5LHCAL9b5CIF2eM68ivd9uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uEhmHgv6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 20334C32789;
	Thu, 27 Jun 2024 11:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719488875;
	bh=Ai1qsjDV8TVB8n60kMviqZ3G0IrZICdk1tqlzmLNIcQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=uEhmHgv6/P24cuQWYsbs/RGcxh0yhvXBD9/OJakAugtujrmn5yVC8h6IbNM+XlJOt
	 95dZyKutL+TlhivysdyXBA7nSGCczddyb3coq3QJ0Z2aE5H+TJvbqIWl7D0xx4kbBl
	 M+TGt4Xb6MfsKbdnRhjN8nwnbjJzZJdSE050fOKVSb8MTz8nhIHPr3ZeMYVlJLCxkl
	 Bw4up29DhZDCB5rZE2A1LzUFA/pprm38Vkpg/sSFOLKM5+3PjjZzKP3qSLYoPGW/IO
	 uK58xuQXiCL7m5YioUxQD87R8jAJLlbhLk8Eki8dOWS1jxq7mrSBNHDKJOEvcyHFb/
	 noKFv63HFk5pw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02CB1C30653;
	Thu, 27 Jun 2024 11:47:55 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Thu, 27 Jun 2024 19:47:51 +0800
Subject: [PATCH 1/3] dt-bindings: power: add Amlogic A5 power domains
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240627-a5_secpower-v1-1-1f47dde1270c@amlogic.com>
References: <20240627-a5_secpower-v1-0-1f47dde1270c@amlogic.com>
In-Reply-To: <20240627-a5_secpower-v1-0-1f47dde1270c@amlogic.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Jianxin Pan <jianxin.pan@amlogic.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Xianwei Zhao <xianwei.zhao@amlogic.com>, 
 Hongyu Chen <hongyu.chen1@amlogic.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719488872; l=1760;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=Txc3iSqLPbJi5Rszcezcb/g0/wY8paHucg8OqrKhoA4=;
 b=zuduol9Qa4JxnPSke443YVNvHYmL2hfXZ5bF3i+i0yMOzt3NZdwSLoIOjJhdk35/+t7kbV7xr
 uOlQNcygpQUCvxGKP754w1v61IbP0+gK0mzC4SGWbFobhHoVATK5R76
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=o4fDH8ZXL6xQg5h17eNzRljf6pwZHWWjqcOSsj3dW24=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20231208 with
 auth_id=107
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

Add devicetree binding document and related header file for
Amlogic A5 secure power domains.

Signed-off-by: Hongyu Chen <hongyu.chen1@amlogic.com>
Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 .../bindings/power/amlogic,meson-sec-pwrc.yaml      |  1 +
 include/dt-bindings/power/amlogic,a5-pwrc.h         | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml b/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml
index 59915f9d4860..15d74138baa3 100644
--- a/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml
+++ b/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml
@@ -21,6 +21,7 @@ properties:
       - amlogic,meson-a1-pwrc
       - amlogic,meson-s4-pwrc
       - amlogic,a4-pwrc
+      - amlogic,a5-pwrc
       - amlogic,c3-pwrc
       - amlogic,t7-pwrc
 
diff --git a/include/dt-bindings/power/amlogic,a5-pwrc.h b/include/dt-bindings/power/amlogic,a5-pwrc.h
new file mode 100644
index 000000000000..3a6f53eb959f
--- /dev/null
+++ b/include/dt-bindings/power/amlogic,a5-pwrc.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
+/*
+ * Copyright (C) 2024 Amlogic, Inc. All rights reserved
+ */
+
+#ifndef _DT_BINDINGS_AMLOGIC_A5_POWER_H
+#define _DT_BINDINGS_AMLOGIC_A5_POWER_H
+
+#define PWRC_A5_NNA_ID			0
+#define PWRC_A5_AUDIO_ID		1
+#define PWRC_A5_SDIOA_ID		2
+#define PWRC_A5_EMMC_ID			3
+#define PWRC_A5_USB_COMB_ID		4
+#define PWRC_A5_ETH_ID			5
+#define PWRC_A5_RSA_ID			6
+#define PWRC_A5_AUDIO_PDM_ID		7
+#define PWRC_A5_DMC_ID			8
+#define PWRC_A5_SYS_WRAP_ID		9
+#define PWRC_A5_DSPA_ID			10
+
+#endif

-- 
2.37.1




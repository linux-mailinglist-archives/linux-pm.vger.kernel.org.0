Return-Path: <linux-pm+bounces-8227-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7FD08D1669
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 10:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 709AD1F21B81
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 08:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF0813C83E;
	Tue, 28 May 2024 08:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RLfKoV4G"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E9271B4C;
	Tue, 28 May 2024 08:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716885572; cv=none; b=ViyEPgWrlXlwA36JvLPamyUbjHZ4nl65/MNjv+VA5iCWfn/vUvTNRAQZb6MtY+QsAZhSSowsEsDlo08eL+LBE1/UM0uiZzTq8pKOX1LtLmb+y0bvI29TCcibODvXwvjYfQTf5YKuuwlManY5eBJANg9zjOAdLI/so7NafMi6vr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716885572; c=relaxed/simple;
	bh=Dy2THCFbsLq2DkMOQsSH+bQnrboFNI6ntqt8fIhFvT8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hGG216OiSOwFxBeyqtrX1WRNA30VTuZA+IOSQGmaU+lgjicvuIjvubUBxri9kRPtBCgR18+5engXCbSjXWdg+RVUQK6H1UYWbW0kvoLRh7uOW9IcsKBuLYvh2SNUuFH6MyF9FqVh4uvfYO02nznCzQfqksNvuORRrdHK1YtpnKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RLfKoV4G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 46AABC4AF08;
	Tue, 28 May 2024 08:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716885572;
	bh=Dy2THCFbsLq2DkMOQsSH+bQnrboFNI6ntqt8fIhFvT8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=RLfKoV4GF0NBgr9yn86EPh0qrdIf3uigBN4yLQyaPJkcEAOOHErkGPwSvSR9l7ktK
	 +z5OzEgQRD9RTYU61E3sdOJV/NtR2vxrEdsLZr47cbXihV08QBJesDJnq04Pbv8qen
	 0/P5P8N9yi790n2f80JzEC+zVeUj5S325pFPf5rcg/iTxEDarbAgKrvBKxlRc5uNpt
	 kH4yAeEYVtykuccoe8jq1pE7zhRW5gxBkpLIBmGrJoNilCZ3QzJYht9zExK0ZDgMnW
	 aDONbJ9Absj6kYUUEzyesn/hOT8f3WBaNaK+Xs3loY9yswVTwQyrq7Hk7LU2AGEkWM
	 f3Zi7Cl9ptjSg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A07C27C44;
	Tue, 28 May 2024 08:39:32 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Tue, 28 May 2024 16:39:28 +0800
Subject: [PATCH 1/3] dt-bindings: power: add Amlogic A4 power domains
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240528-a4_secpowerdomain-v1-1-2a9d7df9b128@amlogic.com>
References: <20240528-a4_secpowerdomain-v1-0-2a9d7df9b128@amlogic.com>
In-Reply-To: <20240528-a4_secpowerdomain-v1-0-2a9d7df9b128@amlogic.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Jianxin Pan <jianxin.pan@amlogic.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716885570; l=1750;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=RgSjH36Qe2U+EgCLbgQ34YnSw/n5HAn5hYl8u+yR7yg=;
 b=0fO2oQhlkgQwkWydhbu+RcPN78HB4L/zQ19HTV6D8l8yETaxV2MPvQUb4RleDjl3sHKwKXzqX
 1WjcP+vIKYRAeHouzTEy4/UeFCiddZ5A1ZlqqpHBnr731DojYlwNg2W
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=o4fDH8ZXL6xQg5h17eNzRljf6pwZHWWjqcOSsj3dW24=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20231208 with
 auth_id=107
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

Add devicetree binding document and related header file for
Amlogic A4 secure power domains.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 .../bindings/power/amlogic,meson-sec-pwrc.yaml      |  1 +
 include/dt-bindings/power/amlogic,a4-pwrc.h         | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml b/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml
index dab3d92bc273..59915f9d4860 100644
--- a/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml
+++ b/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml
@@ -20,6 +20,7 @@ properties:
     enum:
       - amlogic,meson-a1-pwrc
       - amlogic,meson-s4-pwrc
+      - amlogic,a4-pwrc
       - amlogic,c3-pwrc
       - amlogic,t7-pwrc
 
diff --git a/include/dt-bindings/power/amlogic,a4-pwrc.h b/include/dt-bindings/power/amlogic,a4-pwrc.h
new file mode 100644
index 000000000000..bd2f9c558d22
--- /dev/null
+++ b/include/dt-bindings/power/amlogic,a4-pwrc.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
+/*
+ * Copyright (C) 2024 Amlogic, Inc. All rights reserved
+ */
+#ifndef _DT_BINDINGS_AMLOGIC_A4_POWER_H
+#define _DT_BINDINGS_AMLOGIC_A4_POWER_H
+
+#define PWRC_A4_AUDIO_ID				0
+#define PWRC_A4_SDIOA_ID				1
+#define PWRC_A4_EMMC_ID					2
+#define PWRC_A4_USB_COMB_ID				3
+#define PWRC_A4_ETH_ID					4
+#define PWRC_A4_VOUT_ID					5
+#define PWRC_A4_AUDIO_PDM_ID				6
+#define PWRC_A4_DMC_ID					7
+#define PWRC_A4_SYS_WRAP_ID				8
+#define PWRC_A4_AO_I2C_S_ID				9
+#define PWRC_A4_AO_UART_ID				10
+#define PWRC_A4_AO_IR_ID				11
+
+#endif

-- 
2.37.1




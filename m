Return-Path: <linux-pm+bounces-8324-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1758D2B46
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2024 05:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E55E91C215A4
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2024 03:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429DD15B122;
	Wed, 29 May 2024 03:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C0LaGsDP"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08979D2FE;
	Wed, 29 May 2024 03:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716952237; cv=none; b=YD11KssB6BZlLx0QZu4zmO+uvNVhZx9bLRvdeSIur+1xYFAosnIZAaQvpaV1tLw6zYZphmUYCqv8/wzRntZkTzzmODfIoHiASl6x+Aq4Z/cnOk9ftWDDtjbJi9sXbTzC8qt4PpuOEpbD/bUDZJ+cETrtspbIXUMKUwez9nt7nQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716952237; c=relaxed/simple;
	bh=R2PBY/msQ742b9lRMEFHyiEIA4TM8B0XBOvPygj5t68=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AcOlo6Ehlq+9v0zAQ7BUs839MlrMIIlKOQ3mX/bSNHQkeRVWK8rbFsYoKsnWM6MgcM0KbPTttAHAT1xkLCTU6GY09o5gIqkEYzWY1wANogGKkb2EQLbrvm16XxFEBdxjopRDIJ8jLUP0TGOTX2tsvWIHFJdUpQBonMV+Z9HB4pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C0LaGsDP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8AB44C32782;
	Wed, 29 May 2024 03:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716952236;
	bh=R2PBY/msQ742b9lRMEFHyiEIA4TM8B0XBOvPygj5t68=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=C0LaGsDP9HUdITKn6KszeovQbqAGdxWVOX7Xf2Qd6rxxhFaHMUm6RpOOF9tiUMwWc
	 6FqNAWaJJOqWZmkKL52lLVZnPvwFLXQDch1zFJlLUhH7F67gUmJrQxT5efxd3FdXJ5
	 PUzzPFrTM77nsNoZ3tlGGzjAIZmKBUEeFjWQK9PLyOdRQnKRP5MGfh44d06GIvJ3gR
	 gq5bhshp1V9neWfSuD538L3NOOJm/HzihYK1sx/fmoKIyw51AIdPj6vEQDFfkdkpKN
	 6Pk3TxOSe1PQJuKaWM0tfbABdSwsE1vrVfPYrJcgepYfr2JjOfcrfmy3Ufku3F8tO9
	 0bcdAATHbRE1g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C2DC27C44;
	Wed, 29 May 2024 03:10:36 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Wed, 29 May 2024 11:10:33 +0800
Subject: [PATCH v2 1/3] dt-bindings: power: add Amlogic A4 power domains
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240529-a4_secpowerdomain-v2-1-47502fc0eaf3@amlogic.com>
References: <20240529-a4_secpowerdomain-v2-0-47502fc0eaf3@amlogic.com>
In-Reply-To: <20240529-a4_secpowerdomain-v2-0-47502fc0eaf3@amlogic.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Jianxin Pan <jianxin.pan@amlogic.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Xianwei Zhao <xianwei.zhao@amlogic.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716952234; l=1814;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=nfoMiDo//9rMUrKLRoJnW/ImrBs0OKdTcKzaSwdwK/A=;
 b=EtJ0yNZ3A1Spomz+78Y0P6EEhnhU5/ot/KOLV8zTv/nUvVE9+/visaaV8Uw1+3LuqMh4xMzoX
 zh4d9vRrKuaCkc3UUDj6u8OH7gQlkEjf4Nkzc9l1I0F36kMD4rpnqBg
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=o4fDH8ZXL6xQg5h17eNzRljf6pwZHWWjqcOSsj3dW24=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20231208 with
 auth_id=107
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

Add devicetree binding document and related header file for
Amlogic A4 secure power domains.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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




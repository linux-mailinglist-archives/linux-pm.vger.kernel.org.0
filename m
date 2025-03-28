Return-Path: <linux-pm+bounces-24578-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE54A74D80
	for <lists+linux-pm@lfdr.de>; Fri, 28 Mar 2025 16:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6287D3BC143
	for <lists+linux-pm@lfdr.de>; Fri, 28 Mar 2025 15:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09031CAA89;
	Fri, 28 Mar 2025 15:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IH398ePK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EC71CAA70
	for <linux-pm@vger.kernel.org>; Fri, 28 Mar 2025 15:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743174925; cv=none; b=hCfNxPSB80j6yTnN9XOb5/0jq4/grSJl2Abn9JobLy82AI4XrwWj0n0N0nYAw42wpvR4N/gkCALOZTN0moBU79NvuGjws5QozeD8ogSHvoQjIueVTh54+1IXz/O/OE7JwVLgUOvQQJGK6Sdi5dM0G2nhWamz0GV8AlqQFbpohek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743174925; c=relaxed/simple;
	bh=3IHdPt3ilrvQl1EBzfBDUJ1zVOOCJvrWeRswwbDNyTA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iXVHhSscVKOm7JtJs4pTLDLJehGXDpeJUkLUnHVBmbSCVjobJCszutEjun9M3rD0AilFOO9Qej+GgxzX3hBVRkyTIdzi8aEVLiEMAIq9gHsKzu0vlTCdYqcuczQTMDl8pEk7hyaAjcVX/+dgOhP9figobtdJjBFibkeMVHD2Y3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IH398ePK; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5e6167d0536so520566a12.1
        for <linux-pm@vger.kernel.org>; Fri, 28 Mar 2025 08:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743174922; x=1743779722; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rZ/A5NQVl/i0LPvXyGUfZOVhC0YHLCb1cbCkUXx5q1Y=;
        b=IH398ePKiwLnuh3h26ii9r7jxNDP2xXDTEGPpQOj42EwtTGH9tTwsbTCQqeYYVMpUy
         xEncPRM7eeGr7+GoYK9anAJRCoviaa8j8wpRcW3an/5JOrPqX44GItY+54NMQqV83oh0
         GJRgi0mWIM+t13ORyBg4a499lqGkhI7BBTLTGhxQBqP1CVyogWY2DfnK5wFe2Tv3gu9E
         4nFngFgzdxywxJ3lA1JldAtoS3Sm25SPqdQJkNvjI3btHdhLFzSpgXrGEITL/SEk04uv
         VnmHShLcX5bzZTmkchj/xl3ka5738eR3DFj04FA4+brtKoZiMaGxrisYN1D5Cn2gJUaH
         zHgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743174922; x=1743779722;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rZ/A5NQVl/i0LPvXyGUfZOVhC0YHLCb1cbCkUXx5q1Y=;
        b=qmCUpLfkMPXExvD89LXmsuC/jiVPP/0J3lSV74k53j4hTLERrbVIcdPrxcOqo8FHzb
         VL3K+t19IV1h0dAKa7ENCcfJ6ZAifBQbF6q4LPWOiV11aSsAbzhiYrKB4QepT183Mv8p
         m8rNCXDGolWar9qDsWzh5hUrqU5nkzpA3xtFl/3sbb+tJm5zPIqmMPHcjK7/+0YpfjJ/
         4+xPK8tvtxIf+zU66U+srX75WXiJf6I6r0lOXaKaRxyZYhY/a+ZqhwJYGnN3yejCyY5D
         0nrVueVwkBFNanwTIb5TqDWODTviocrST12NA7putdD3UzCiOL2X5A908fZeM9wwJFPX
         0L+Q==
X-Forwarded-Encrypted: i=1; AJvYcCV9MaLefWdNUdeGA+uR+E6j2bu6xMQFje04wVlXJzDsvfRQuWU0EdJ2RTpdZFJS650zONlT1UiL7w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwtX1Qauh0JJ8xpTYRb9pX+lB7WZ7ZqWea5EvPTW54lHumNXKYt
	X5PDI2Nlw2STmpY7wzg5gajsVbMGY0hG4iaQXmFoOY/vir3MsEmjugVDQqloZofX/9JeNWusP76
	1vx4=
X-Gm-Gg: ASbGncu5C/WAiR88sbpM9g+0y5rP8jPejPWs3qkP+8trmMt/49ldK30gTCbfDEVgNjE
	JkaoZYCrbyUsGO2RcUzNw5AWq89T6dv/Fx0pt+ZXgWJYovKybBJWbF6ZSNFFD+8Ew85JK8c8yWL
	ZN9E+N9MZDuDXqBjLjyUulycOSPh8swVhE0evrZiTvx0K4Eq7FZ7thvO0R6Z5DQ4GIjrB62DSOI
	V2ZDeZhNKASwsSkPgBdqSWxDusck2e8OJLGB6gXliLxEcaw17lv1W1tELKFgH7qScOhZpaCENC7
	8quHxyz7DKNFcayqQglpcnAb6PuEBudjKBar+TnTTGyQ12IyUGibuzx8FP+oxDtuItMBPjegdWn
	d+5hg6sXDsN8ISDNBxoiBDWltCajN
X-Google-Smtp-Source: AGHT+IF/SAGXajaIJE2fIq4KovdnKXhHLZoUZ8JDIQJu039BLgAJUBx5iZLh2HzQlSqeRVtqSuVgwg==
X-Received: by 2002:a17:907:96a5:b0:ac3:8626:607 with SMTP id a640c23a62f3a-ac6fb122244mr749440766b.38.1743174921576;
        Fri, 28 Mar 2025 08:15:21 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac71927b742sm178789266b.65.2025.03.28.08.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 08:15:21 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Fri, 28 Mar 2025 15:15:19 +0000
Subject: [PATCH v4 1/3] dt-bindings: power: reset: google,gs101-reboot: add
 Google GS101 specific reset
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250328-syscon-reboot-reset-mode-v4-1-77ba57703ace@linaro.org>
References: <20250328-syscon-reboot-reset-mode-v4-0-77ba57703ace@linaro.org>
In-Reply-To: <20250328-syscon-reboot-reset-mode-v4-0-77ba57703ace@linaro.org>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

GS101 supports a couple different reset types via certain registers in
the SYSCON register map.

Add a binding for this.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 .../bindings/power/reset/google,gs101-reboot.yaml  | 32 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 33 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/reset/google,gs101-reboot.yaml b/Documentation/devicetree/bindings/power/reset/google,gs101-reboot.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..cbd0a1d9b45af0cb994d616c56b96440c43ab971
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/reset/google,gs101-reboot.yaml
@@ -0,0 +1,32 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/reset/google,gs101-reboot.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Google GS101 syscon-mapped reset
+
+maintainers:
+  - André Draszik <andre.draszik@linaro.org>
+
+description:
+  GS101 supports a couple different reset types via certain registers in the
+  SYSCON register map. This map is retrieved from the parental dt-node. So the
+  gs101-reboot node should be represented as a sub-node of such a node.
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - const: google,gs101-reboot
+
+  priority:
+    default: 192
+
+required:
+  - compatible
+
+additionalProperties: false
+
+allOf:
+  - $ref: restart-handler.yaml#
diff --git a/MAINTAINERS b/MAINTAINERS
index 322ee00547f6e494a96d2495092f72148da22bd0..e27f5e672bc5a04777afd098355898654654659d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10080,6 +10080,7 @@ L:	linux-samsung-soc@vger.kernel.org
 S:	Maintained
 C:	irc://irc.oftc.net/pixel6-kernel-dev
 F:	Documentation/devicetree/bindings/clock/google,gs101-clock.yaml
+F:	Documentation/devicetree/bindings/power/reset/google,gs101-reboot.yaml
 F:	arch/arm64/boot/dts/exynos/google/
 F:	drivers/clk/samsung/clk-gs101.c
 F:	drivers/phy/samsung/phy-gs101-ufs.c

-- 
2.49.0.472.ge94155a9ec-goog



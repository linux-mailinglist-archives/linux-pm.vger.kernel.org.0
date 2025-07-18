Return-Path: <linux-pm+bounces-31046-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2745AB09B81
	for <lists+linux-pm@lfdr.de>; Fri, 18 Jul 2025 08:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 219B87BC472
	for <lists+linux-pm@lfdr.de>; Fri, 18 Jul 2025 06:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53BBD1FDE22;
	Fri, 18 Jul 2025 06:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YtQQVS/B"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2E71EDA03;
	Fri, 18 Jul 2025 06:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752820663; cv=none; b=kYGlzoY+YOvkpZ4tQRMo8p2II+qXiZxAwaesQ27wcP6EqFk4BN5MGj1sDrYq32jtVuwOAnsrlMtNi29D/2MvKxxRHOQtrVbgCJHk6MBLIZmleXXAFyJYNDP1SJ5VlJ+b3O60TbVCeG1JKnzw3s7vrSc42kccAr0hkQl2i0yE+0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752820663; c=relaxed/simple;
	bh=B1nEStj0+V6pHpYPik8DbbNYwrpA6YOZBXo8D/XPxu0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TW8bcBBsDgbeGh7hBlv/ZUs6N3rfbQTiwZF2mRz+AGbEOzAFg7B9Q31cyTHNhmzHLJEM0Ur4dajBc7Sv5xaiuClXIBOFM7Ow1+kxpvfbxf4oeWrZBSnIfFDD4V7wh9/bc+prxsz4OAFagUXkGXK04x5imxaqyo350a4HQ2QdhcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YtQQVS/B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9CFC4C4CEF1;
	Fri, 18 Jul 2025 06:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752820662;
	bh=B1nEStj0+V6pHpYPik8DbbNYwrpA6YOZBXo8D/XPxu0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=YtQQVS/BzrykY3H/cp2lg0p+1AfWPfffaHya0Cf6TsGBeSqlG/RqDlysYrD5WOqO+
	 gLNBbTCwaijMD/babk6iPvGVdxBdG7BPFP2BufXf/ny+YJMBmZk4juthhfsKqc8Xvu
	 5zqe+UQDjyyvYM1QlB9VYKOmjNTM140ZwOMMu9z0flUt04hLKfSRdH3V7HFtDfify2
	 uwBMeoPYM9ZAeS7IoSQ/xOOpg4abDZR8KAlCGQkxTSgrCsKpzcg4PM3JlokL1V7r0a
	 lf4S3ZAN35h84kmOzRQXwkSoxp54ea9pXGTCY7aa1Uq/TuTbvShuWSOpKSZcqoR/Gw
	 wycuuz7fYKq2w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A042C83F1A;
	Fri, 18 Jul 2025 06:37:42 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Fri, 18 Jul 2025 14:37:41 +0800
Subject: [PATCH 1/3] dt-bindings: thermal: amlogic: Add compatible string
 for C3
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250718-c3-thermal-v1-1-674f9a991690@amlogic.com>
References: <20250718-c3-thermal-v1-0-674f9a991690@amlogic.com>
In-Reply-To: <20250718-c3-thermal-v1-0-674f9a991690@amlogic.com>
To: Guillaume La Roque <glaroque@baylibre.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-pm@vger.kernel.org, linux-amlogic@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>, 
 Liming Xue <liming.xue@amlogic.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752820661; l=908;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=m70FS+G7MWgfpyXfqF/GcZI0oweMwKZErmLTKjbvs28=;
 b=jQEBxT6KzSsfZPc7EiS43IuLrjjutZFmEj5PLSOauRyZSFDl29n1k0oACNtSGEWNkiRyKb0OH
 EgxLAOKTAYqD9OUrtKAr8ZvUD1osLlLp2J+2YpAaXQVqL0LYm5VUYM3
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=o4fDH8ZXL6xQg5h17eNzRljf6pwZHWWjqcOSsj3dW24=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20231208 with
 auth_id=107
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

Add the compatible properties for Amlogic C3 SoC family.
C3 family supports only one thermal node - CPU thermal
sensor.

Signed-off-by: Liming Xue <liming.xue@amlogic.com>
Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml b/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
index 70b273271754..095b92aa5ace 100644
--- a/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
@@ -22,6 +22,7 @@ properties:
               - amlogic,g12a-ddr-thermal
           - const: amlogic,g12a-thermal
       - const: amlogic,a1-cpu-thermal
+      - const: amlogic,c3-cpu-thermal
 
   reg:
     maxItems: 1

-- 
2.37.1




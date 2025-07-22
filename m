Return-Path: <linux-pm+bounces-31278-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E94B0D824
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jul 2025 13:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDE9C3A5A8E
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jul 2025 11:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238A42E093E;
	Tue, 22 Jul 2025 11:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fMDuRiiD"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECACB288524;
	Tue, 22 Jul 2025 11:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753183590; cv=none; b=qwbxeXkLCaI5JwnoWyhYTd5IHJX9OcILfvZTlqzcbX9NT4ajsRdAzlCCKBolvWoRt5xjoE0kOV2xVe8RAfcBFvq3CYngRALmWNop8BVrn7fFhn7u4R9eY1i6kA5cVXbeJ3uFdGajVpPG2+yMnyvT2hU61up22vfcEDdjVnOibIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753183590; c=relaxed/simple;
	bh=YRA1hYrEORFOB7GQuzTQX4VTQhnY9esTD7J0wHpqIjg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MULoCRE6w/E6jQLrNjMxOWgB3TAONPxKuyDlJwmE88C4BEdgeJVZNsZERQ36il4OAYIUT1pnxyc4omyZAHrPm7+BPWPyoalATbgr8qtN3RrOZ6YOHRz5yErcyWqjIYrhhwdMQqOY0djThAZJhGJ4NOAl4MN9cqtpzJ2kXSHRfQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fMDuRiiD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9351AC4CEF4;
	Tue, 22 Jul 2025 11:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753183589;
	bh=YRA1hYrEORFOB7GQuzTQX4VTQhnY9esTD7J0wHpqIjg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=fMDuRiiDGlEukblcq+Qoss2+dwTvSbp68Ai0QD2ZMx3d1k2uH2NHhoSkCaJWWD+Ys
	 EDw1L90A9QfaunFIXb+LlTd3f/Q3sXWgopqjgu4IngkLeV1L0WNnttQaymjzRheil0
	 6n5MU2Xb80XxVzC/G+ZswxE1eWP+GvrkBiJG4i1L/m2JRREGkQEsac6Q3XuPRzRXSU
	 xNgsmfXYR/tIyV9q47W1rH/HVsiA505r6uULUM9hZUr2oF6sxgOBcfeba8dH48/MeA
	 1ikiJgNdQuHiYYVzy/krJu8gFKFnXW/o19jR8pESpv7YYCZEhOiZFDmOoymAYWn7z2
	 /eEJ8r8m/rSVQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 843D7C83F27;
	Tue, 22 Jul 2025 11:26:29 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Tue, 22 Jul 2025 19:26:27 +0800
Subject: [PATCH v2 1/3] dt-bindings: thermal: amlogic: Add compatible
 string for C3
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250722-c3-thermal-v2-1-b2231b4be79e@amlogic.com>
References: <20250722-c3-thermal-v2-0-b2231b4be79e@amlogic.com>
In-Reply-To: <20250722-c3-thermal-v2-0-b2231b4be79e@amlogic.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753183587; l=1117;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=F245QN28IAzyYVKe5LdflpfqaXIiAZXvhwVaz2WE8mk=;
 b=q+REDs12RZEfw/hMQsKiHAKbppF7thzkQndT/LP7EhRcH5t87fMSM1iDpgzs5MsZeD8FmYgmc
 K4d+gMdl/vnDxBp1OybqgW5ji0qQu7ttbckZPAsqLorPzjHq0G3M111
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
 Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml b/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
index 70b273271754..27ddb67c7743 100644
--- a/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
@@ -16,12 +16,14 @@ $ref: thermal-sensor.yaml#
 properties:
   compatible:
     oneOf:
+      - enum:
+          - amlogic,a1-cpu-thermal
+          - amlogic,c3-cpu-thermal
       - items:
           - enum:
               - amlogic,g12a-cpu-thermal
               - amlogic,g12a-ddr-thermal
           - const: amlogic,g12a-thermal
-      - const: amlogic,a1-cpu-thermal
 
   reg:
     maxItems: 1

-- 
2.37.1




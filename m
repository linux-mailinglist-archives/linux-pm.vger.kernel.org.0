Return-Path: <linux-pm+bounces-34078-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FFB3B476FB
	for <lists+linux-pm@lfdr.de>; Sat,  6 Sep 2025 22:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCC21583DF7
	for <lists+linux-pm@lfdr.de>; Sat,  6 Sep 2025 20:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7E529ACDD;
	Sat,  6 Sep 2025 20:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kuCj0CVc"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA587286439;
	Sat,  6 Sep 2025 20:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757189856; cv=none; b=JVKdi43sBFRjU/86/2ZIIdvQiUhHdbaL81JfZIO8qSpJthBxLmT9d8FWdg2a2Biqf1SIXdMC018qbX6aO+FyNny51KQezXILMs8gXwH1LUrVPj14mJkAjl8TRpR1k0lte46ANqxDzl4csu90fmG+7QU+ijN4EudavCI94wy2jBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757189856; c=relaxed/simple;
	bh=8i2BWgCaaCWJIvg/06T6RDvE8Cwt2BXpXDMpawGm74k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RG/oErzJaoijg1zaMTBC4GJcAcsVcURksO2jpRnspnKuZzw0Oq3X37UMBSMsOYWqsmTIXp36mNRMCVYmK3/uX/RWvWu4RnXMuKmez1FERtpuLYz+ypyntPu+fYlHSG9dIR6/T95W/9YrqIpF4DXg689wO76FXk/6WwiK2G5MCak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kuCj0CVc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 77679C4CEF8;
	Sat,  6 Sep 2025 20:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757189855;
	bh=8i2BWgCaaCWJIvg/06T6RDvE8Cwt2BXpXDMpawGm74k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=kuCj0CVcLlREf/E0zXX4GQfTIXUdUnnvMNpyQs2T3QW4inVvs1pc5R21wKuGy8gBB
	 1m8CsxgJvLT20MYS4dL3at5s+HVdTogIfM9TrL4qjLIlCSb9dz6WGuooQhxTHVF0Wl
	 KBMiW5+x3FidV1ySVBDAS+55aIIcBktmLKz6WhGtNrUoTfgEUnLnTqN2YTmMmQb0lP
	 fhgo1Ff3jw44Ca+t180OK/bRoXeezvZ5gyVVgokuK/5kiJtZzhehCQvd5iYh352dQs
	 B2htRZ1kkGQbXcHyfsn45/7ERFXks1N88EGF5yVbXelvQFTGrtlnATNjEKUp5GhWeo
	 5O090LlZS88bw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F23FCA1012;
	Sat,  6 Sep 2025 20:17:35 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Sat, 06 Sep 2025 15:16:51 -0500
Subject: [PATCH v3 1/9] dt-bindings: devfreq: tegra30-actmon: Add Tegra124
 fallback for Tegra210
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250906-t210-actmon-v3-1-1403365d571e@gmail.com>
References: <20250906-t210-actmon-v3-0-1403365d571e@gmail.com>
In-Reply-To: <20250906-t210-actmon-v3-0-1403365d571e@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 MyungJoo Ham <myungjoo.ham@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Dmitry Osipenko <digetx@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, 
 Aaron Kling <webgeek1234@gmail.com>, Chanwoo Choi <cw00c.choi@samsung.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757189854; l=1317;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=Yja3M+BrtWErPH3UuVdCmx3ZLaQHPY9CfAi2XYCgd9s=;
 b=u/t7WCZ0BXsJqSC+o9rUlL3KPvNTjQf5d95jBEEs6hC/qt0eqRUKa3YdEv1sUE1njITK7Prv1
 ycbcosSFFxZDoS70d2+d0s6vqCB05MUdlUwZ1qZ9mH8wyuxr4L5OBLH
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com

From: Aaron Kling <webgeek1234@gmail.com>

The Tegra210 actmon is compatible with the existing Tegra124 driver.
Describe the compatibles as such.

Acked-by: Chanwoo Choi <cw00c.choi@samsung.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
 .../devicetree/bindings/devfreq/nvidia,tegra30-actmon.yaml  | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/devfreq/nvidia,tegra30-actmon.yaml b/Documentation/devicetree/bindings/devfreq/nvidia,tegra30-actmon.yaml
index e3379d1067283e36d1bee303187c0205b410f610..ea1dc86bc31f635f91a0e36f908f5c0c4f9a804c 100644
--- a/Documentation/devicetree/bindings/devfreq/nvidia,tegra30-actmon.yaml
+++ b/Documentation/devicetree/bindings/devfreq/nvidia,tegra30-actmon.yaml
@@ -19,11 +19,14 @@ description: |
 
 properties:
   compatible:
-    enum:
-      - nvidia,tegra30-actmon
-      - nvidia,tegra114-actmon
-      - nvidia,tegra124-actmon
-      - nvidia,tegra210-actmon
+    oneOf:
+      - enum:
+          - nvidia,tegra30-actmon
+          - nvidia,tegra114-actmon
+          - nvidia,tegra124-actmon
+      - items:
+          - const: nvidia,tegra210-actmon
+          - const: nvidia,tegra124-actmon
 
   reg:
     maxItems: 1

-- 
2.50.1




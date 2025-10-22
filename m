Return-Path: <linux-pm+bounces-36618-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 154FEBF9C9A
	for <lists+linux-pm@lfdr.de>; Wed, 22 Oct 2025 05:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8DF619C5DDC
	for <lists+linux-pm@lfdr.de>; Wed, 22 Oct 2025 03:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10FD224AF9;
	Wed, 22 Oct 2025 03:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WbsbtsmM"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833391D5CF2;
	Wed, 22 Oct 2025 03:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761102586; cv=none; b=HDo9cvl+FtB9GjpmRxDeyh8cdPA7eHhIb6XnDn10GR6gwAVUmtUGSMb0IMea65hz9LYH2ivC/R9A/l0Vv3On3PPmel4YkeSZP+w0TyrQUA33L24BRxS9jrCyvqX9/fW0wtnpG9gs+j5Rfdgi9R83rFnHN3CyVHUtJV5rBrpxi2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761102586; c=relaxed/simple;
	bh=3dG02UCUztaBPWNbNKvRv4U+aD1d2E0+ME3Sd2LNTCk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=KGK3ic12nbygxutXZepzKoNQ8PnNfIWZ+7M2QEmZ1BFyWW/oOt2yQX9id48VhFUe7ELh1T4aYOS4IfcOAl1o/X/j/jNzUx7Qm0u6pMzIYm0huTHV60wpcNVyv+eifRQie529vUQEp4DWwY6fq716QKxmFOw2ec9D1gr5kXXFQdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WbsbtsmM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0BB03C4CEE7;
	Wed, 22 Oct 2025 03:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761102586;
	bh=3dG02UCUztaBPWNbNKvRv4U+aD1d2E0+ME3Sd2LNTCk=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=WbsbtsmMVbDFA/G7qdobLssa9uUHasLdy/n7E49tpEzGv9WvX6zTpsmS7/OPkVYXq
	 CyxyEwnSCfwt1UDpJDO1KHZjPArAYxjnCMTlv0ogPOMqVwzxMt8kZcbSA+4vYzXz9v
	 Rw1AlMmREeVBeA0Q6AZHraAOpOXDzDeH+a61+pMawejU82oyzT/E5/Fc4kUC1mcnfq
	 XVfYaelmglXfnxUnFqdt4KDtopNUULz6KnB6QUyvPHOnIeGxqWoYpYK983F6cJOVMQ
	 wYbtQWJw6wi9DPYBOCeFWhn+OkbQwkINptXtng5Y61yVtfsnI1FTCwU1tJ7FvILoZ0
	 2UjvKP3sqC2PQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB28ACCD1B9;
	Wed, 22 Oct 2025 03:09:45 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Tue, 21 Oct 2025 22:09:26 -0500
Subject: [PATCH v5] dt-bindings: devfreq: tegra30-actmon: Add Tegra124
 fallback for Tegra210
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-t210-actmon-p1-v5-1-1bc8f9221917@gmail.com>
X-B4-Tracking: v=1; b=H4sIAOVK+GgC/x3MPQqAMAxA4atIZgNJsIJeRRz8iZrBKq2IULy7x
 fEb3ksQNZhGaIsEQW+LdvgMVxYwbYNfFW3OBiFxTMJ4CRMO07UfHk9GXWRsuK6I3Aw5OoMu9vz
 Drn/fDx9QEj9gAAAA
X-Change-ID: 20251021-t210-actmon-p1-ef2b9164005d
To: MyungJoo Ham <myungjoo.ham@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Dmitry Osipenko <digetx@gmail.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Chanwoo Choi <cw00c.choi@samsung.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Aaron Kling <webgeek1234@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761102585; l=2361;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=mg8XT9vcS48SE8URDi3TR+Wy+mQQFKQFXQRT3zUHsb0=;
 b=mZx+g9VaQ/AsA+KvIG57AVILTDDkK1rY9Hsjnu4uds6noRNEOI4n7Ahs955iTc0FLF1yOPed9
 Oe1DAewlGE2BjBWI2ikc0sssC7WV59ThWK0tx3j8IyvZ+X4tsBVmUKR
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
Changes in v5:
- Split series
- Link to v4: https://lore.kernel.org/r/20250923-t210-actmon-v4-0-442d1eb6377c@gmail.com

Changes in v4:
- Various cleanups in patch 5 as requested by review
- Fix a couple typos in patch 4
- Link to v3: https://lore.kernel.org/r/20250906-t210-actmon-v3-0-1403365d571e@gmail.com

Changes in v3:
- In patch 5, don't fail mc probe if opp tables are missing
- Add more mc bindings to patch 1
- Add patch to use tegra210-mc bindings in the mc driver
- Re-order series to align patches within a subsystem to each other
- Link to v2: https://lore.kernel.org/r/20250903-t210-actmon-v2-0-e0d534d4f8ea@gmail.com

Changes in v2:
- Assume 64-bit dram bus width in patch 4
- Add dt-bindings patch to document the new properties on the
  tegra210-emc node.
- Link to v1: https://lore.kernel.org/r/20250828-t210-actmon-v1-0-aeb19ec1f244@gmail.com
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

---
base-commit: 211ddde0823f1442e4ad052a2f30f050145ccada
change-id: 20251021-t210-actmon-p1-ef2b9164005d

Best regards,
-- 
Aaron Kling <webgeek1234@gmail.com>




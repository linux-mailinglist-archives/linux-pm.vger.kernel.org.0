Return-Path: <linux-pm+bounces-33765-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D928B42A37
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 21:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AE7F7AF303
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 19:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A776D36998D;
	Wed,  3 Sep 2025 19:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A3O2adY+"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A67F302756;
	Wed,  3 Sep 2025 19:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756929082; cv=none; b=ZEpzqvLZXN9B/I4RMcs8v+BJqpQy5FzQXICIEwSaZMstRQFeMe5F0lvzI3h3hLYOagC9D6UcPmeWKa2pEDSDgfODdxHUhP20IKZM9kYVTkXljvjQMkar8fGMxaRW8dGO3dGXRI+XYc7KT9U2HvocsGBPESMjkmuBOudv6JsAXL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756929082; c=relaxed/simple;
	bh=ymSdo6RSeSpn1mQcVF+5RG9uQcYNVf6CbBfZnF/VV3E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nwMbxQHhHesVl1rmNP77ydqwZbyPqQwSl/i6NlXqoAp0L6tW7abKgXPnpEwCQck6UcgKs/hvEx/8k32xBO7pPLX52AyAEF3IgdggrazB7X4PD1hn6dKbmYmSbSjJzqGw9PJYwO9fiRL2OcnYBxZRZOhaHpiNgXuPKQikY5wLqoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A3O2adY+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 008C2C4CEF1;
	Wed,  3 Sep 2025 19:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756929082;
	bh=ymSdo6RSeSpn1mQcVF+5RG9uQcYNVf6CbBfZnF/VV3E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=A3O2adY+bxYp8ZYy2hcCgFCxyPEMJzMV2iVm63EuT6h2/xJolYXfMH3R41pLXXlGs
	 jV6ARzStWmyBt+9V6wsIi/AcfoRjchbZJ97Fc6xf5ZaYeX+Jt5MOGWFKooBwaeYbsT
	 jntqQfgLbvcFofUkrKsBZvB0PzDEzlL2nZKF/pv69NT8HoWCBPPv+dclGmGJTH0Dfb
	 wXNyG7hhqpy7XrJGFJD2ERq7AUFie/Xb7mYRWJ2QQRKwV892291q1BV2CAzupFaHKb
	 9asHa9R332pB/WDtWscocyrA34Grb8YjzxF0wy6yYT3fBArNkgOlc5g6clPVoBozsl
	 DAICf72VLykhw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E30A1CA1015;
	Wed,  3 Sep 2025 19:51:21 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Wed, 03 Sep 2025 14:50:08 -0500
Subject: [PATCH v2 2/8] dt-bindings: devfreq: tegra30-actmon: Add Tegra124
 fallback for Tegra210
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-t210-actmon-v2-2-e0d534d4f8ea@gmail.com>
References: <20250903-t210-actmon-v2-0-e0d534d4f8ea@gmail.com>
In-Reply-To: <20250903-t210-actmon-v2-0-e0d534d4f8ea@gmail.com>
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
 Aaron Kling <webgeek1234@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756929080; l=1201;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=xdS30eId+rCA7n/+A0teGQz4FyQXYRBMZykKI3Thnc0=;
 b=Mfq5tSzd+j2FvPyNwhUIkTI/PvaRw7O8B4wo2p+Aw9v1Yu8h6kgspGVtqQIOf6sobt1uTkJ2J
 ruq7/jed9gGD3uoKIrbH/NPY/vdjdJ7a0v0k3jQAdTCXuN3LjwKfYcV
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com

From: Aaron Kling <webgeek1234@gmail.com>

The Tegra210 actmon is compatible with the existing Tegra124 driver.
Describe the compatibles as such.

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




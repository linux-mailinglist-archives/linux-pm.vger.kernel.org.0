Return-Path: <linux-pm+bounces-33359-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A575B3B1D9
	for <lists+linux-pm@lfdr.de>; Fri, 29 Aug 2025 06:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F1897C62A7
	for <lists+linux-pm@lfdr.de>; Fri, 29 Aug 2025 04:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9A7224AED;
	Fri, 29 Aug 2025 04:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rfbJ99j6"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349BD1D54C2;
	Fri, 29 Aug 2025 04:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756440093; cv=none; b=Gf8mhvzXZ818q8l8hSpcECFIf3pMXxOHyJa3IgzvSprXxq1rtN2U8RE5o7X6wV6hjYy8Kk9PRePzPB5msI29NgqbOSS4OSeDYAYaxpx2kzcnfeXqiIdKi0zWv9GL9ebpKG4yLt+5eN0/789adaRLCN3WGDEt3YYvbn+9P2bhu8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756440093; c=relaxed/simple;
	bh=ymSdo6RSeSpn1mQcVF+5RG9uQcYNVf6CbBfZnF/VV3E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TmCiazm24FoF5Apz8odZWEWfA0bJZC4GZciZDhOJyaRtfhiXhBctQud11/DzyI0wTYQKJF4Ko3uqo2Jq3kX/OYeHwxUgwIm+v6FlAdo0gUfQEm4g/kfPLfLrOW561vHFhRHz0MiTS3oAETFDngxA0yFn0Q3AMa2yiad6pl20S3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rfbJ99j6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D0376C4AF09;
	Fri, 29 Aug 2025 04:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756440092;
	bh=ymSdo6RSeSpn1mQcVF+5RG9uQcYNVf6CbBfZnF/VV3E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=rfbJ99j6byBO6kYlyGv9Yxl9ptxDuyAJN8Xxt//bysyhQXL+xe2BkciIwOBDcOW9t
	 Z98z2thtxUOAcbGBYU//G60khgNE7c5MX2cQrUi8xZ0bv4apvygilLRPFXZoJsP5fl
	 nkj4xiMXIfkJ/7KZ6+WY3JNTmKgleOy5yC+hSi98OQEB26fKrK1wnbl0NfAkcwr8Q7
	 OO8UYtAVRILL5L5y572eHLnJMBvsbV2Bx1DiH3La1VTmsLfWiKrzBRVY+A16wZCzDZ
	 XGC2cl9Fvbt4efpSlkQ7SRpkD9bNdYOLSkhA85stuiK+Hht5bar+TrWECTJ8RwYloG
	 +dR/bR2KOR2sw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B72B5CA0FF6;
	Fri, 29 Aug 2025 04:01:32 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Thu, 28 Aug 2025 23:01:28 -0500
Subject: [PATCH RFC 2/7] dt-bindings: devfreq: tegra30-actmon: Add Tegra124
 fallback for Tegra210
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250828-t210-actmon-v1-2-aeb19ec1f244@gmail.com>
References: <20250828-t210-actmon-v1-0-aeb19ec1f244@gmail.com>
In-Reply-To: <20250828-t210-actmon-v1-0-aeb19ec1f244@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756440091; l=1201;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=xdS30eId+rCA7n/+A0teGQz4FyQXYRBMZykKI3Thnc0=;
 b=le1xPjyR2IjuslnY/xk/I/O7UVIb+SG4NPzl6vbYXPDWzVScmeTwpeGX2LUD/A64jDSFssEpn
 oOOMOG4fWM/B2mtjCxSlDCnE1YhxPo6Cf1p2xNfYdu8MW4N6M3Nd8Gf
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




Return-Path: <linux-pm+bounces-39638-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B4847CC5300
	for <lists+linux-pm@lfdr.de>; Tue, 16 Dec 2025 22:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0402303E662
	for <lists+linux-pm@lfdr.de>; Tue, 16 Dec 2025 21:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE9230C610;
	Tue, 16 Dec 2025 21:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fd0CFsHY"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EA529BD94;
	Tue, 16 Dec 2025 21:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765919762; cv=none; b=FnrEqFqfqvGdnVTLIIFBmpjn0vRPMI3rIxuaFrE2C3qUqj/x1MQzqFVdw7T9yB2xkr3ZPjp+WTgLbx1imJ9vEKrVFwj2C2JHbKnhEegGX8Rl8g/UcvrKwgtZwESBxMfjmhAHxdjbGUjQRPl33SGDQCnXrJChnEjtzdhVgPrV0PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765919762; c=relaxed/simple;
	bh=B0P6AuGnRE6rzhPj3QzG9g7Oh+eHUJx//mScbtwLrGM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kPYdJuCP4mi0pU7EGMdKxdHYHEbdmQHikrXZtOPjiNV5YTUWqaEYXkw5+YU+dNpPMIGudtHHSxgUryGMLrx2VFe0NfNvHIvO6CmJaAJGHqLi6xz8fgRASKkKoZz6N2R5LwHC2hpJEqcAbYbZZDM0pRTfhkvbQ2KhwY3gLaWiRpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fd0CFsHY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60EA5C4CEF1;
	Tue, 16 Dec 2025 21:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765919761;
	bh=B0P6AuGnRE6rzhPj3QzG9g7Oh+eHUJx//mScbtwLrGM=;
	h=From:To:Cc:Subject:Date:From;
	b=fd0CFsHYxzDsLX9+xxj8nIvhL7EfxcK0scW6/3reymDRXGq18paIqOBaI5dD3Qrka
	 1bFP7BvMs7TW8KRkrXVAs5fVWGsiwQ4Q9swJYwehBM0ZtW4KeJMMY5TKpumUQGcsaV
	 9dQX4VZkCJr/+KtLKAYkx6PU4KKHzRFha1qduOZmter4AHUERcVnbB+pZlrTK2tVAj
	 nu/rR5MhlZ19IPHuDYTRRdFHdLDpEtukUwsHuV6WsZFwAEqxmLxXl1dVKi6gAkA2GV
	 yDbZnDCd/dr8wD9z2SV2igCozXvtPyVDUsAN0kmsXvFfFiB95aQbjP2ICp+3rdXr9M
	 jUwRwWuYnKQOQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Sebastian Reichel <sre@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: power: syscon-poweroff: Allow "reg" property
Date: Tue, 16 Dec 2025 15:15:55 -0600
Message-ID: <20251216211556.3047726-1-robh@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar to "syscon-reset", allow using the standard "reg" property
rather than "offset".

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../devicetree/bindings/power/reset/syscon-poweroff.yaml  | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/power/reset/syscon-poweroff.yaml b/Documentation/devicetree/bindings/power/reset/syscon-poweroff.yaml
index d342b113fca2..b5e92b500764 100644
--- a/Documentation/devicetree/bindings/power/reset/syscon-poweroff.yaml
+++ b/Documentation/devicetree/bindings/power/reset/syscon-poweroff.yaml
@@ -23,6 +23,9 @@ properties:
   compatible:
     const: syscon-poweroff
 
+  reg:
+    maxItems: 1
+
   mask:
     $ref: /schemas/types.yaml#/definitions/uint32
     description: Update only the register bits defined by the mask (32 bit).
@@ -44,7 +47,10 @@ properties:
 
 required:
   - compatible
-  - offset
+
+anyOf:
+  - required: [offset]
+  - required: [reg]
 
 additionalProperties: false
 
-- 
2.51.0



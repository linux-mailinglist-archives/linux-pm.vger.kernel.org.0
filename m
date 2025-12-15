Return-Path: <linux-pm+bounces-39602-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BE6C4CBFFAC
	for <lists+linux-pm@lfdr.de>; Mon, 15 Dec 2025 22:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85C2230A0519
	for <lists+linux-pm@lfdr.de>; Mon, 15 Dec 2025 21:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366F432B9AE;
	Mon, 15 Dec 2025 21:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TXz6efCC"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A32D32939B;
	Mon, 15 Dec 2025 21:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765834018; cv=none; b=TrDKHLT1F/+L6wNYtOcKA+KGSfpDLQMAyTS+QYm7v/XSxRSBGlO7/r1XfNtw5f4KFHh1jELCzgjT9zckYWZMcfnTzB2NzXsP2e/TLUS9lViFoRZCUetccBJ2jxSX7IPQC5PTdi2i8nmvys7OqK6fvkEG2I9B9pvM/ULYBoZCGOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765834018; c=relaxed/simple;
	bh=jab4HBdaQwIrhCMrskwOpPqWU+dDwSxlPYq8MZYCFQU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c5OvhZMs8266z8NEGIF2pg439V+8LoetCS4OzhwtCgRZiwCi5zubsnIYM61/bAPs1e5RgTwBINRqWzrMVaLzzFcrlhtmlOx406DkjuZ02n0HwsEjBuh4AArGjFDHYTkpnskevu1R/183JMpo+fCpV7HbEXpAsKu6oj4Y2A5gwoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TXz6efCC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68A3CC116B1;
	Mon, 15 Dec 2025 21:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765834017;
	bh=jab4HBdaQwIrhCMrskwOpPqWU+dDwSxlPYq8MZYCFQU=;
	h=From:To:Cc:Subject:Date:From;
	b=TXz6efCC9/4KgKik04Oyg6IgeBLeWxPlJZktSRz3b7LulxEYOOrsVkoAFFokdY0ty
	 f2icBlR1CqM21aCldHYBPP/6hIC8F6sjchfl/jLcA4OVKE9WEy7arRFnTKFyz0D/h/
	 po4F2DotcERkfzcTRNutPg0WkaEm8D+0ZVzmPJInqa5gjfaugpmY8Ti6yzZwaMrFpH
	 b7eywyyvWhM+uxvCpyi1W3Kq4+LoitG24lgtiQWfh3TF2nx1FXrztAEsJIKp7Mv2eV
	 ELDGmiUdUIlMTh0bNUmtls4s8jywwoO3aFTcG/Lq7QfuJyZ6T5SIiTKhHboHuX3amR
	 5WKZnbYDLEx9g==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Sebastian Reichel <sre@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: reset: syscon-reboot: Allow both 'reg' and 'offset'
Date: Mon, 15 Dec 2025 15:26:47 -0600
Message-ID: <20251215212648.3320333-1-robh@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For compatibility, it is necessary to support both 'reg' and 'offset' at
the same time.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../devicetree/bindings/power/reset/syscon-reboot.yaml          | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/power/reset/syscon-reboot.yaml b/Documentation/devicetree/bindings/power/reset/syscon-reboot.yaml
index ccd555870094..b1c0bcb1e25d 100644
--- a/Documentation/devicetree/bindings/power/reset/syscon-reboot.yaml
+++ b/Documentation/devicetree/bindings/power/reset/syscon-reboot.yaml
@@ -79,7 +79,7 @@ allOf:
         required:
           - value
 
-      oneOf:
+      anyOf:
         - required: [offset]
         - required: [reg]
 
-- 
2.51.0



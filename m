Return-Path: <linux-pm+bounces-38408-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A8BC7DE0A
	for <lists+linux-pm@lfdr.de>; Sun, 23 Nov 2025 09:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35CE63A9C9B
	for <lists+linux-pm@lfdr.de>; Sun, 23 Nov 2025 08:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C8D2C1580;
	Sun, 23 Nov 2025 08:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k4iKB3oN"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C207827FD74;
	Sun, 23 Nov 2025 08:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763886984; cv=none; b=dK75xy4ctKjAAaWoxr3/uM68VyqGQX2u731Yjd/TishXAvAqbLXvdu+5sFkswTigoQ+mhzvR+SvpOsgDPa9wh+oaoGDhL6aWRiVTFNL7qOX0VDOKMdwM4zlTwfOb/1px1Qh9pH3tgf5FZy+M9SuVX26jbNfRmysD2jLYZ1OwUe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763886984; c=relaxed/simple;
	bh=xwynRUzExlilQidqzDcuAEaxh+WE2LV+Vnfe/saj5Lc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O7O26OEq+o6iyCiglaRdbwoM0QtyN/QWruyfG7Bv4NRTTYw4itFbBTVnIdr9nrZiLZsQGPrSYXJISB5cTHyoOpeQCIO84eWXZbsDPEJI0YD2y5gxCoGwHvkAa2du6O0fq1KEOCmUGU8l1WeH6uOVtBz61V78TVQz/R6r/yQcWCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k4iKB3oN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 60A5CC16AAE;
	Sun, 23 Nov 2025 08:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763886984;
	bh=xwynRUzExlilQidqzDcuAEaxh+WE2LV+Vnfe/saj5Lc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=k4iKB3oN5fOEL369rVx86C3CoZmNft0LMRQRM7SrCy8TKUl9y13i/I/BZZXaXPDk5
	 ijAYq3x4admrQ5+oJCs+7BDo3hsE0Yomq3e2TiByycVOJWtGISTMobWgypI2+EFQzA
	 R3ZfXMrCkMhMVjP0Tv0hJP/8BkFiE8CT+UJsH6HKPPmAiExKGe49dRe8Y4pJu9Y5iW
	 lr3+j3RYo7iT7H0jjSfmMs6UnvDeUKAqs3/C559CDOqcPIMaMFEOktqo1X37Cz+iqV
	 GhRaCmBv9tbZwRfayjk3gwntC8y7hZq5X0tZ6qjBv/VrjAwZt/o81NzAwKCFv8/53t
	 GVB77+X7+8feA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D82CCFD313;
	Sun, 23 Nov 2025 08:36:24 +0000 (UTC)
From: Amit Sunil Dhamne via B4 Relay <devnull+amitsd.google.com@kernel.org>
Date: Sun, 23 Nov 2025 08:35:48 +0000
Subject: [PATCH 1/6] dt-bindings: power: supply: Add Maxim MAX77759 charger
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251123-max77759-charger-v1-1-6b2e4b8f7f54@google.com>
References: <20251123-max77759-charger-v1-0-6b2e4b8f7f54@google.com>
In-Reply-To: <20251123-max77759-charger-v1-0-6b2e4b8f7f54@google.com>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Lee Jones <lee@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Badhri Jagan Sridharan <badhri@google.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-usb@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 RD Babiera <rdbabiera@google.com>, Kyle Tso <kyletso@google.com>, 
 Amit Sunil Dhamne <amitsd@google.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763886983; l=1642;
 i=amitsd@google.com; s=20241031; h=from:subject:message-id;
 bh=7bFNW9hXhJq5LkheOx7QT7tuIMKAsDDQ1dSnkeZc7ig=;
 b=1aO4U9DUYtJHenszVku1+O2T8S0nKCzm7caOTnUbbR7qLLHyk8/pXvsmaDh9xS/wwoHBFtI1i
 5FyzzbHT56JAG1hlMR9W/gfQN/Zrra9GnRBfHBL0jK6C45CtkvlFvmg
X-Developer-Key: i=amitsd@google.com; a=ed25519;
 pk=wD+XZSST4dmnNZf62/lqJpLm7fiyT8iv462zmQ3H6bI=
X-Endpoint-Received: by B4 Relay for amitsd@google.com/20241031 with
 auth_id=262
X-Original-From: Amit Sunil Dhamne <amitsd@google.com>
Reply-To: amitsd@google.com

From: Amit Sunil Dhamne <amitsd@google.com>

Add bindings for Maxim max77759 charger device.

Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
---
 .../power/supply/maxim,max77759-charger.yaml       | 36 ++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max77759-charger.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max77759-charger.yaml
new file mode 100644
index 000000000000..71f866419774
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/maxim,max77759-charger.yaml
@@ -0,0 +1,36 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/maxim,max77759-charger.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim Integrated MAX77759 Battery charger
+
+maintainers:
+  - Amit Sunil Dhamne <amitsd@google.com>
+
+description: |
+  This module is part of the MAX77759 PMIC. For additional information, see
+  Documentation/devicetree/bindings/mfd/maxim,max77759.yaml.
+
+  The Maxim MAX77759 is a dual input switch mode battery charger for portable
+  applications. It supports wired and wireless charging and can operate in buck
+  and boost mode.
+
+allOf:
+  - $ref: power-supply.yaml#
+
+properties:
+  compatible:
+    const: maxim,max77759-charger
+
+  usb-otg-vbus-regulator:
+    type: object
+    description: Provides Boost for sourcing VBUS.
+    $ref: /schemas/regulator/regulator.yaml#
+    unevaluatedProperties: false
+
+required:
+  - compatible
+
+unevaluatedProperties: false

-- 
2.52.0.rc2.455.g230fcf2819-goog




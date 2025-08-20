Return-Path: <linux-pm+bounces-32733-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 28440B2E41E
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 19:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6DB054E4113
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 17:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C161125C70D;
	Wed, 20 Aug 2025 17:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="nvSufX4v"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D94224C068;
	Wed, 20 Aug 2025 17:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755711666; cv=none; b=oAeA0dCIuTFN8BS+gto9JVl0CWNoD4geZfCn6pak1jOQ9CN/wGLf7JQ9RlnbOmutZTlvEUAleEyv5rhMIQugwOJw9H+rKjZSAKaNcEqSFruRkYawXXD4A3KKZbePwNRCISuaaboTOA6eEFrq+uaiTLREIntaTirhr+nuIxGrCXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755711666; c=relaxed/simple;
	bh=Au5yTrQB84jFwkCOgmGw2+Tw7pL8gxb6s+o7q0BYyIc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mrF+Rvu5rTWBDLCQdJZAhMWooT4A4gpNox6Ad5ploU0Zi8+N03whw1KCJqIKk8GZsGH2L9b2aC01/mzpLSATvFfXUeZMWWb3jdBOWS1Yjyx6U7C7IOsuf2+qlVOWvtlcqKGPb6wInlF0GMyIOmM7tG7X+xA4fch1iFEMxbdodS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=nvSufX4v; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1755711657;
	bh=Au5yTrQB84jFwkCOgmGw2+Tw7pL8gxb6s+o7q0BYyIc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nvSufX4vy+v80iEyytN0KD/6uKu97HIsWogtYGGwHTcXUEBDb7y/4YpJkDMEXUQaB
	 d+NIzo1Z6WEExpx9Njm/DVw4hGAte7HrHYCe51U+2t7wH7aJoe4qvqFFmI0OoVzVRy
	 PizVGSW0dSTqyvC1DbSar2vTAdfvCCFIzueiT1Lu4OoIfCUVdk7nNK/OaEdbsnGaiq
	 4BSoMK2GwUhkvhfMyTcqrQppXn6NAVpsG7LkjOiCIepynPkfHJVYBYyLJ6ILQSq7Nw
	 iDFxcNcPVNTj+B2b9baokTDYK45vrs/cFLGsFrO+b0s4OGVyQWgDv0DcZCE+fb7d23
	 s8LjyCmFftbdw==
Received: from jupiter.universe (dyndsl-091-248-213-114.ewe-ip-backbone.de [91.248.213.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E632817E086B;
	Wed, 20 Aug 2025 19:40:56 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
	id A68AE48004E; Wed, 20 Aug 2025 19:40:56 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Wed, 20 Aug 2025 19:40:49 +0200
Subject: [PATCH v2 3/3] dt-bindings: thermal: rockchip: tighten grf
 requirements
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-thermal-rockchip-grf-warning-v2-3-c7e2d35017b8@kernel.org>
References: <20250820-thermal-rockchip-grf-warning-v2-0-c7e2d35017b8@kernel.org>
In-Reply-To: <20250820-thermal-rockchip-grf-warning-v2-0-c7e2d35017b8@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Heiko Stuebner <heiko@sntech.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, 
 Diederik de Haas <didi.debian@cknow.org>, linux-pm@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 kernel@collabora.com, Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1270; i=sre@kernel.org;
 h=from:subject:message-id; bh=Au5yTrQB84jFwkCOgmGw2+Tw7pL8gxb6s+o7q0BYyIc=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGimCKhlGYYCe/U2tChbQRkiLHhxGSQ6BpBxa
 WOuv5ACEVPMEokCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJopgioAAoJENju1/PI
 O/qaM+sP/2Nn0diaMf83Q0cmf1E57OtX4JtDr8KsLopYMbzIygSUE/y+C2k2HaGN/oHpW8+feyD
 lUZoaaLnjUrf00HmIWJZwgvWRzwuOjkm0M+e+N0MWJfZVjDoYQ1ROkqQ76yKOGk8XyNxO/THwze
 T3xoZZHZrmeTzdopWbt5UGoqoy0tyD5S96w3R0eSIGEaXrAxPoTMH+9Q7wx60YNrVHQbsHO3S26
 UMDo1NUOqpFNBeX6SARmZey2cak/yWjt0jNER6eCXZJJPmocwXhpBSO2JX+9ouGmIt9N/qEQSh0
 l7f44DzCaRNOjYsfJx2E4e7EkQ35VQY9jdvybQ7Yu9dc8SFiNDJyT4YZ3zQbeXcENVpgxj8LdlN
 vKgfAnvWNjzFEnbf+MiFOOJH1C6oO2VlxRWVtoiIf+qOfA1exal5+ImohIBEtK+WHlDyE2wg8Kz
 HycDZwMDTm6GPMI65Cgcvn/JgBVPDQWVOX9B0eDErChUxwI6Ls4bDJeyv/YrnWKZqNmz4iroEtD
 qI5Ghzp44gJdFi4W+x3Z6mlDq0vprB06MDgRMEa58+L1eIbq+LTcOLkI3s+JdqPQd+NZ1iHSWrR
 +c0vP416yo52o09HMPJD6AAXeZhpzIl5WFP5E9zKNGwqvVfqfTjQ88Dt/+P1L4+gJOHEpb3R8E9
 D/tf6TQDQez0tL2uz1t4qkg==
X-Developer-Key: i=sre@kernel.org; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

Instead of having an optional rockchip,grf property, forbid using it on
platforms without registers in a GRF being needed for thermal monitoring
and make it mandatory on the platforms actually needing it.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 .../devicetree/bindings/thermal/rockchip-thermal.yaml     | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml b/Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml
index 573f447cc26ed7100638277598b0e745d436fd01..9fa5c4c49d76e3a689f31797875124e7fb30d3df 100644
--- a/Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml
@@ -119,6 +119,21 @@ required:
   - resets
 
 allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - rockchip,px30-tsadc
+              - rockchip,rk3366-tsadc
+              - rockchip,rk3399-tsadc
+              - rockchip,rk3568-tsadc
+    then:
+      required:
+        - rockchip,grf
+    else:
+      properties:
+        rockchip,grf: false
   - if:
       not:
         properties:

-- 
2.50.1



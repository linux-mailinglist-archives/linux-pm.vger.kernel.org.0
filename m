Return-Path: <linux-pm+bounces-22571-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F1F8A3E488
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 20:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCAE41885575
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 19:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9C92698A8;
	Thu, 20 Feb 2025 18:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="FalHM5N7"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB142690EC;
	Thu, 20 Feb 2025 18:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740077925; cv=none; b=m+rxUlwtE2g2HjigdvGSfsIYqwBcCpFTlDg0fc92v3xSiogs6wTAnjL45ifisDmzezv+fHnYPpOhm2oIzW7bHq5qZVeoCTiA7269JrWgYHycCYspcEK3QAkBFjntKWEyEjdwIDkPvevncG3b7qaxMNZKs4KgcEf22/EedwsPikM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740077925; c=relaxed/simple;
	bh=gNnZPfQXVKbdkjA8KmghaCar55X1o4WqguMKY2lNPdA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BsnQPHbmkP7l+tBhbnPmzzlCGX1XN+e/ATuAMHYsDQJrGBPXmq6q2QAlWwGnF8y8QBCDPcMC06yoHjnbiGixGZYTJMDqfE/DSlAqhMaZZ2+Owvka9J97kInZIfcqrC41Y4Q0Kj6ffUMPsU8ODcmgQ8lmQl8Gztf+1GcwHT9SDKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=FalHM5N7; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740077913;
	bh=gNnZPfQXVKbdkjA8KmghaCar55X1o4WqguMKY2lNPdA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FalHM5N7yj1ph+ic2Rt+KPGx9VMJcPPptj8SV/2nbRdMjq2qq4hxeCK123RBU5cAQ
	 N8yD2i+MQkIYKg+Z2CG2vWyOvybzmaMrzntH4V6ai5zPBRSAA3Chgqr9uM4t+5acWX
	 nMlK2wuElp5ThP0pzWPgnXfxeQsmZMwuxl/Az5VI/TXOU708MdZZkiLrP2kTVYFAGB
	 MWWR6PusEozyuaO7kSHnq/vdG5sPr+ZAB4WUG1wkVL5kduQuAofOiUGhBo2ZERvghf
	 RyywJrkbswOwpua08JMoAaBj8+EEq1/+kobdfQI9E5b7fYAJE3CSlXy7+EbCzaKqOt
	 8rg9iHPaP6dgg==
Received: from jupiter.universe (dyndsl-091-248-085-196.ewe-ip-backbone.de [91.248.85.196])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id BB17017E1573;
	Thu, 20 Feb 2025 19:58:33 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 11E0D48003D; Thu, 20 Feb 2025 19:58:33 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Thu, 20 Feb 2025 19:58:09 +0100
Subject: [PATCH v6 6/8] dt-bindings: power: rockchip: add regulator support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250220-rk3588-gpu-pwr-domain-regulator-v6-6-a4f9c24e5b81@kernel.org>
References: <20250220-rk3588-gpu-pwr-domain-regulator-v6-0-a4f9c24e5b81@kernel.org>
In-Reply-To: <20250220-rk3588-gpu-pwr-domain-regulator-v6-0-a4f9c24e5b81@kernel.org>
To: Mark Brown <broonie@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
 Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, 
 Elaine Zhang <zhangqing@rock-chips.com>, 
 =?utf-8?q?Adri=C3=A1n_Mart=C3=ADnez_Larumbe?= <adrian.larumbe@collabora.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Peter Geis <pgwipeout@gmail.com>, Tomeu Vizoso <tomeu@tomeuvizoso.net>, 
 Vignesh Raman <vignesh.raman@collabora.com>, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 devicetree@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1565; i=sre@kernel.org;
 h=from:subject:message-id; bh=gNnZPfQXVKbdkjA8KmghaCar55X1o4WqguMKY2lNPdA=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGe3e1jhrocIPKlDYN5gJd0DLM1HYnT+lpJjI
 B6f+HIyiXGbl4kCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJnt3tYAAoJENju1/PI
 O/qahK0QAJ+gRjWLsQBmQ8CDRKD/2gFPon5Mi78UX6H0qkbavrw5m5e9T4UGw4JYnke3jZrZk9w
 V1cv5zigz6nZ1Inc+dTMzNEGTW5MXr2su0Mf70vi2Hjc+Xju+ON3KK8F9iVBC1cpsMV/Qke9AMs
 OyUbg7/yjiXjs3TbpHIFQVK7k6nXt7bfvCZLKvQV0ujjLyVcdQlzGeA1kg3TrQXPXFrrPlAnnu2
 SH7u/8jtSIWczcWxf69MUDV/KwQIm7LmrCRnc1NLFEVJApYA//hPKaBumo2jxb7+7ipKAXv0FNr
 G6/VgzopETqgbKXNGsxALJ17X9el6Cvd0rzsuqRy1PrDzICQymdu0eWge73OLeoSy6xAu1Oc7b6
 3ZnwI7fy4hJuC+m8j3ObpE7qR4jn/HE16W0LqRjOZUrjmKyT+ZQ9BJkHOoRdzDEFJhnDa2EHZ+k
 ALw0b43wZr6pnL3w2SG2McoH7Hu+uoRRKT59qNIPmgjTuOgBfJhznNfJrw6a53vEzu8LuJxOPIK
 BWB3BqlGFMrYVh0e8tAZTxt9D4ej664MSPAjx84m+8B5qPE/PmGOzqE1qrVSMKrCrFd/QPo0J+h
 /wQAA56O3GPVOS0rCUClfpSmqf0zvTvHwKChKn1U4Xa6r7ogUdW43E1+b7cGFCCQ3CEN/xQH/gu
 Jo9/kvrHL6rxaFLGBlaQ3bg==
X-Developer-Key: i=sre@kernel.org; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

Add optional support for a voltage supply required to enable a
power domain. The binding follows the way it is handled by the
Mediatek binding to keep things consistent.

This will initially be used by the RK3588 GPU power domain, which
fails to be enabled when the GPU regulator is not enabled. It is
not limited to that platform, since older generations have similar
requirements. They worked around this by marking the regulators
as always-on instead of describing the dependency.

Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Tested-by: Heiko Stuebner <heiko@sntech.de>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 Documentation/devicetree/bindings/power/rockchip,power-controller.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml b/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
index 650dc0aae6f518578f57e8ec4335bc8251b736a7..ebab98987e492d64fff9977848fd8942ed96c4b9 100644
--- a/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
+++ b/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
@@ -132,6 +132,9 @@ $defs:
           A number of phandles to clocks that need to be enabled
           while power domain switches state.
 
+      domain-supply:
+        description: domain regulator supply.
+
       pm_qos:
         $ref: /schemas/types.yaml#/definitions/phandle-array
         items:

-- 
2.47.2



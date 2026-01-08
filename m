Return-Path: <linux-pm+bounces-40433-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2130AD02043
	for <lists+linux-pm@lfdr.de>; Thu, 08 Jan 2026 11:07:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B92230AB480
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jan 2026 09:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D200C37F8AC;
	Thu,  8 Jan 2026 08:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="WRwvQoOl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0857337F11D
	for <linux-pm@vger.kernel.org>; Thu,  8 Jan 2026 08:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767862728; cv=none; b=BuSUHxptzXYW20TxqzjrHeYBpkHkVQuVvwiaXYNfrIIBJ5E7h7k8IspQurHNFLBAPh2JTuGiTh7k5btxa5dORvQ27DeWYTulvyWw79pvH6758huTVnnk2gWrqt7aP0NbyUms8PwBzreN/rOb5tIFFziekwMISyctPK8XHebLdyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767862728; c=relaxed/simple;
	bh=g6bPLC0uhgJGfGzdr7jciYO1TYQnfhcR7gx4FwvNLV0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rHEoZZ/DTJlHWkzSndGVVReU+KhapZIKCUYyHsFC5rZD+kRm8s7XBiUz30VEkRHCHv3AZ6EVZxqwKCa47JxPLZAkCan5LhlcfspVgK4jTDHypW1yNwSasXO2TatncgzpKSmLtYwQQ3U0sesd7jmUg49jYrQFPMIi12cJ+kiCbug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=WRwvQoOl; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2ae53df0be7so3786018eec.1
        for <linux-pm@vger.kernel.org>; Thu, 08 Jan 2026 00:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1767862720; x=1768467520; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OPMKY7Ve7//uye45o8kcyRKc3naps5DDhGu7uTz/qYs=;
        b=WRwvQoOlSBPKAnSmbospln+srPGi8OdXfmt+UX42zam33NA29NOmRIGR3x2nAfiWRp
         xCdbjmTUpJtn7RUn9oUPkTQZea7xVpUifZ5F7ymYrSE1vZY98Ux/ej8ou9RoH/sFpsG6
         z8lh8GHzWPP3ZZID67LdlkfoSn6FPaOsSFHf25BS3rbA7sL3EEXisb8uGhnldxE2/OPO
         6T/Dwba/IpRRGhxG3Tvxh/64dOv5euUbmdwQkG9VW52J0d00vaAx3kRuuTyIVAYRdW3S
         Ig1lbN/jMeMjwcuWhdEmyqsUU8xueOhCMXpEbr7gpakoDmnkdCsYAmAt1QJrSYka1UKX
         R6ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767862720; x=1768467520;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OPMKY7Ve7//uye45o8kcyRKc3naps5DDhGu7uTz/qYs=;
        b=wqYPIC4eU6LudM2+WdwFzi2QbAEiv0dVGXvRCqlsbVwoLYwPiId5107RB0xehMPSP3
         C0FIMgkOzOiVbw5dxBiPoQ4q0JIiVHqqoEtaribSmhep53eE0+t0t29KSIxvxf2j6AKa
         Y5m5MPFkE06U5TKuqy8Vk/Ibs6kt869A13QX+Wp+jP23CcwuN+HA/x0v/KoYuelf8K6Q
         ULTdEgKYo5RtS1fhWzsCvQ36vCVj/WCTWo7MUteJ0L1TAJuOGWIMiCoOS6lM/xG3tQmp
         yzIymHHHpgMB7ZlH8lwC4qJoBBQ+S1zQao34Lqd4EyKhVKCUARei5MwbRjENqc0dnA5q
         eAlA==
X-Forwarded-Encrypted: i=1; AJvYcCVP2i+wGVDqHFJZTJya500Cpp2PFrqI4W7w0SF/ESSlLZ7DECW4wQKCEVi8wC8Yk5NWrhrkV3l//g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzL+fyI/RssMdTVzj//VnNUfod9JI6m+C4YAcu1boVz8lKGxJIh
	KX0O7Jo2Ibc9U/NpWywxjeQErvukVowGuOyvMl4yTVkHs5GijU+z+S5fo45Jh4PxRrI=
X-Gm-Gg: AY/fxX4K3356G9PtlNCte+A5noGGjvsmeqRvOH+NzRxT8CU1vRJ6HDQY8yEC2uWSZVH
	34nD2J+csqlk2s8HppGoip65fAy3e9AReaUm9mhAbkNURjf5/wmNapCS4yXhFkfewfnq+fZ9SPt
	M0UJUKRKRTbMa008RjSjQ0skhvilxhoS0MuRVFEGrDhv9PJEhn2L9Qo66CO2dchHEShwsYkTfVL
	LLpiAzw/lvNCa3uN3kauXloWsPefMb1qgSdvKuOTGhFnFLZ31aRMHElERlD3aHpzl/tiMxmcmg6
	voTR2xA+mzoKnH6OdzenZxSfkZhgtkImf5j9PN912gbQUEkdc6RKgZ2fLASNtxIR5e5QdZ4R8ck
	kMGhPZqCvUr4BQfu8v7tXiJkFxUYhoABWhrJxR738WO05LNT4lEX45P7UzC+Xq9InWkq5SZSCyX
	A0L66CYFR8D1ognG/BNcqDlVc=
X-Google-Smtp-Source: AGHT+IGeM165oEvyVrh+jJ+fHeTSLxMLf2ir5ZaGZt7O8WdBQ16xZQI4McJDAnPHI+CXjXuTmYlcRg==
X-Received: by 2002:a05:7300:b09c:b0:2b0:4e86:8163 with SMTP id 5a478bee46e88-2b17d240aeamr3454843eec.13.1767862719638;
        Thu, 08 Jan 2026 00:58:39 -0800 (PST)
Received: from sw07.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b170675076sm8833634eec.2.2026.01.08.00.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 00:58:39 -0800 (PST)
From: Nick Hu <nick.hu@sifive.com>
Date: Thu, 08 Jan 2026 00:58:25 -0800
Subject: [PATCH v4 2/3] dt-bindings: power: Add SiFive Domain Management
 controllers
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260108-sifive-pd-drivers-v4-2-2a523d7d51a0@sifive.com>
References: <20260108-sifive-pd-drivers-v4-0-2a523d7d51a0@sifive.com>
In-Reply-To: <20260108-sifive-pd-drivers-v4-0-2a523d7d51a0@sifive.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Anup Patel <anup@brainfault.org>, 
 Samuel Holland <samuel.holland@sifive.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Cyan Yang <cyan.yang@sifive.com>, 
 Nick Hu <nick.hu@sifive.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-riscv@lists.infradead.org, devicetree@vger.kernel.org
X-Mailer: b4 0.14.3

SiFive Domain Management controller includes the following components
- SiFive Tile Management Controller
- SiFive Cluster Management Controller
- SiFive Core Complex Management Controller

These controllers control the clock and power domain of the
corresponding domain.

Add `- {}` for the first entry [1][2]. Once the SoCs are ready, we will
add the SoC compatible string at that time.

Links:
- [1] https://lore.kernel.org/lkml/20250311195953.GA14239-robh@kernel.org/
- [2] https://lore.kernel.org/lkml/CAKddAkAzDGL-7MbroRqQnZzPXOquUMKNuGGppqB-d_XZXbcvBA@mail.gmail.com/T/#t

Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Nick Hu <nick.hu@sifive.com>
---
 .../devicetree/bindings/power/sifive,tmc.yaml      | 58 ++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/sifive,tmc.yaml b/Documentation/devicetree/bindings/power/sifive,tmc.yaml
new file mode 100644
index 000000000000..4ab2b94785f4
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/sifive,tmc.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/sifive,tmc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SiFive Domain Management Controller
+
+maintainers:
+  - Cyan Yang <cyan.yang@sifive.com>
+  - Nick Hu <nick.hu@sifive.com>
+  - Samuel Holland <samuel.holland@sifive.com>
+
+description: |
+  SiFive Domain Management Controllers includes the following components
+    - Tile Management Controller (TMC)
+    - Cluster Management Controller (CMC)
+    - Subsystem Management Controller (SMC)
+  These controllers manage both the clock and power domains of the
+  associated components. They support the SiFive Quiet Interface Protocol
+  (SQIP) starting from Version 1. The control method differs from Version
+  0, making them incompatible.
+
+allOf:
+  - $ref: power-domain.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - {} # Leave a empty for future SoC specific compatible string
+          - const: sifive,cmc2
+      - items:
+          - {} # Leave a empty for future SoC specific compatible string
+          - const: sifive,smc0
+      - items:
+          - {} # Leave a empty for future SoC specific compatible string
+          - const: sifive,smc1
+      - items:
+          - {} # Leave a empty for future SoC specific compatible string
+          - const: sifive,tmc0
+      - items:
+          - {} # Leave a empty for future SoC specific compatible string
+          - const: sifive,tmc1
+
+  reg:
+    maxItems: 1
+
+  "#power-domain-cells":
+    const: 0
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+# The example will be added once the SoCs are ready

-- 
2.43.7



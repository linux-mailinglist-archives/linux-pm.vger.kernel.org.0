Return-Path: <linux-pm+bounces-28703-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D12EAD9852
	for <lists+linux-pm@lfdr.de>; Sat, 14 Jun 2025 00:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA03C3BB459
	for <lists+linux-pm@lfdr.de>; Fri, 13 Jun 2025 22:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529CB28ECE5;
	Fri, 13 Jun 2025 22:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rGnx12tt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5986028E59C
	for <linux-pm@vger.kernel.org>; Fri, 13 Jun 2025 22:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749854396; cv=none; b=fIzrMNIybSq9OIAd+QSdCRKNJEvU/4IuTZ/FBgS/1Z6E0VkoxuimpHtH9DQJPcS2gHKzgedxbt6Tj10bTC47hchI1pQrqxrQU7bvsqFH07PXVtj+DaAGnWIWLSdSraqT09RVWvobmqZRQbtK/3FZzmnGJ7tznambmwSXNsV9vpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749854396; c=relaxed/simple;
	bh=rOfEkuVXnVCi6qVtn+094x5dIM7Nv0xxNwE+TQyA8T8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HdGXoflF/PttV6FzUqIA8Gywrf4Ou3JGBl+lwWIUe2PJeaQW1Tz/VvXXhUF+RX59X+WT5KeNP6CZigAMS0inLvurjf+TUhMDhR0wj7fUQMUqEDWOEFBrtMsSH0yM5cwP5KY9246VmVNiKhQEaQJFyO3166yagDeDxZmcnqiR2LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=rGnx12tt; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-747e41d5469so2887027b3a.3
        for <linux-pm@vger.kernel.org>; Fri, 13 Jun 2025 15:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749854393; x=1750459193; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LtUsYHqMkAgU1Tr2B+Zd1LaoMvlrf2GnVyOYzZROnVM=;
        b=rGnx12tt4gcyY7Ff+HM6loz8z6h30mv0oliFIrA+wxmpWAKQYEnaaNGnLo/IA0VeuM
         LocfNijEP9zCT5ZX8Xmnk9dJruBnOoP/gAUFoc7cd3d9uopH7z9TuBn525G5AdabTdox
         +5zkn8zwAWD0ySMW4BCDT02rnppAF9mti2o+BgSewjqL2dJWFQVg2CIZOLRXCj/yTYVr
         ZsicmibYOlB08d812voI8XJGBM4RSJpHgYL3JtgxN4aSjhk7i+G+Dv6zsc14au5tY29T
         KVkDhT6MX0xsuKmTSABw/9l5juXw9yOD/ym4U75Vy+2S8fINgUWd4Cl95bPFuY/7n8O0
         Aj/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749854393; x=1750459193;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LtUsYHqMkAgU1Tr2B+Zd1LaoMvlrf2GnVyOYzZROnVM=;
        b=WiwJRVkxP5i/33G8nkghxO6OkIXHkrNk20FO4cvxkGdyEeuKdWutZLKZ98UXvp8CQX
         3AJcrSVcF2tLha/beKInbTiHKnFb2n6TLeMz92f3q1M/CdlbVUAAsMGYM3PqyikGMwHA
         6REjXZc4yhOeAEXsQvV/srTvvxrZQod0V4ekGbAHa7zWpAkYB4d48nHvYiF5RrgHY/8M
         pWIp6K7YIan9HWnZ87J77s7q2fMqiIgyoNoZB7f7lvQhu/TsD3aQSXdZGlsBbalEcNi4
         VPRVhVMHZzkZbGQqiolurWNYUCeud/GMPudH2vQxJNnRsxZoyMTcvKKZf1d0SysqvdMs
         tSvw==
X-Forwarded-Encrypted: i=1; AJvYcCW11FpfxPLK2YGaUAJG7y6NJ3pbyWPnVI9iF1B9ItvNpRBROUOMFntPGlRDLSiF/5safxePfZ0tMA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyV8v1F6chNUPI1Vn/BymTV0MxTP7msL/htOadXyVQXq7o9oZk4
	5L1vPGkn/7l2p5fMNGuwFeTtxWySiejAxGcAReXHO3syrwBUTJdyt4BWl9PP590Eet8=
X-Gm-Gg: ASbGncuHU6UNeK8Gds+UD4fOrkgBS+cVmhRtNSSSPXLXjOYgiYbgLYAcztTZCBQqauf
	ZjxHW5MIe3q/4JPj4Ig2Tw53UxvN2OOGkGTUA0xIR99wufGs2N0NEJyTRxFvdZ5SBl8fusb/FHl
	k4jsxbstcag+7gVajgrW0F1FGcl36F3BLKURahqaxoGpu8CNkltWn1reOEhla9tS88N3B+g1pj0
	tGrLSDtASu2zgGTqk2wu5zEPlKxLA5jXEoT1rlTcvQlI+jKcAxxbidMDn8dtqFTWVkJlDqZbDLq
	vwi+0764Qx5+3hOELWB2fvEVuBQRPs5Xkpvjl6GjtwjQG8orwI+BWE+Reiqv
X-Google-Smtp-Source: AGHT+IHwgXzvtcCfNs2PzbcdRX2JJJWU53h7s6+ODm5XPIRNW6YQXViE+5wj8dwzo9GkGd1M8snpTQ==
X-Received: by 2002:a05:6a00:3a19:b0:746:2ae9:fc3d with SMTP id d2e1a72fcca58-7489cffb6bbmr1286927b3a.23.1749854392677;
        Fri, 13 Jun 2025 15:39:52 -0700 (PDT)
Received: from localhost ([97.126.182.119])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7488ffed07csm2204285b3a.33.2025.06.13.15.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 15:39:52 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
Date: Fri, 13 Jun 2025 15:39:27 -0700
Subject: [PATCH RFC v3 1/2] dt-bindings: power: add nexus map for
 power-domains
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250613-pmdomain-hierarchy-onecell-v3-1-5c770676fce7@baylibre.com>
References: <20250613-pmdomain-hierarchy-onecell-v3-0-5c770676fce7@baylibre.com>
In-Reply-To: <20250613-pmdomain-hierarchy-onecell-v3-0-5c770676fce7@baylibre.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-pm@vger.kernel.org, 
 arm-scmi@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=openpgp-sha256; l=2322; i=khilman@baylibre.com;
 h=from:subject:message-id; bh=rOfEkuVXnVCi6qVtn+094x5dIM7Nv0xxNwE+TQyA8T8=;
 b=owEBbQKS/ZANAwAIAVk3GJrT+8ZlAcsmYgBoTKi2YFfPwzOne8TB+pfX6MflvESNcRmgasHDJ
 m/48L3gLmuJAjMEAAEIAB0WIQR7h0YOFpJ/qfW/8QxZNxia0/vGZQUCaEyotgAKCRBZNxia0/vG
 ZUuLD/9Omp9x1pOdoz1bKUFWXqHqVaUJImyfp1fesi1byvEyjNbxkjcmARgzQwozYcklnBBD9g7
 lar8FMiob6wHupciVPM+YRVXiBVJs7h+NgOf2FAxZbyrJ7WcgvOF4qQe14qYvna1XuGdZUbCE2o
 07FaJOADzekI/ueEq8+8JUenleeRM/LSyD+Qd1QM4WlnId3qAaQt1PnUI2ZQksnVEKnUMm5TajX
 h63yXL+olU1T/6wKKQkwu57FPheyL4gAQSJLREx17wX8DbKmOSpzfaN3w7Dmgxp8DQ94Evibf5i
 K0n01CyajMuSAoCdJmI3vIFiIl4rz/hTT8VeqvX8YFU6uJBdDNPF1q3nypSJg+k7zK3fpzDYEeE
 MN4VuN7RhCc8Q1XMR+O7Ir3DWHrrFsEYGhm0kl8HOHrX2ZskEd/HVkiqVE+fTzf0XvB9HNki697
 C5yftQfWfc1VZ989Q1zkDZqhnzxQ8qW7hY85igNf8+V7meerHPFcgSTBeuoe9d/CnF4q6aoACAr
 Ikfrg3pcCCMJ95oLu8IfoK0d/+bCwU2c0ClsytDHG8gLfAugJ3eKOhvbr69NTjaUcHtwlUu5/yK
 /uhGIkq38q7QZa5EyRiUhVq11i+3NnWZh0CU0N86Lg13h+77sBpuQkFfcgtyyVk2RgCyvI4PgaU
 tngkuKK6x9Wh44w==
X-Developer-Key: i=khilman@baylibre.com; a=openpgp;
 fpr=7B87460E16927FA9F5BFF10C5937189AD3FBC665

Add support for nexus map `power-domain-map` to be able to support
hierarchical power domains for providers with #power-domain-cells > 0.

Suggested-by: Rob Herring <robh@kernel.org>
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
 Documentation/devicetree/bindings/power/power-domain.yaml | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/power-domain.yaml b/Documentation/devicetree/bindings/power/power-domain.yaml
index 8fdb529d560b..9f099d326aee 100644
--- a/Documentation/devicetree/bindings/power/power-domain.yaml
+++ b/Documentation/devicetree/bindings/power/power-domain.yaml
@@ -68,6 +68,15 @@ properties:
       by the given provider should be subdomains of the domain specified
       by this binding.
 
+  power-domains-map:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description:
+      Nexus node mapping property that establishes parent-child relationships
+      for PM domains using the format defined in the Device Tree specification
+      section 2.5.1. Each map entry consists of child domain specifier,
+      parent phandle, and optional parent specifier arguments. This property
+      is only supported for onecell providers (#power-domain-cells = 1).
+
 required:
   - "#power-domain-cells"
 
@@ -133,3 +142,29 @@ examples:
             min-residency-us = <7000>;
         };
     };
+
+  - |
+    // Example using power-domains-map for Nexus mapping
+    main_pd: power-controller@12370000 {
+        compatible = "foo,power-controller";
+        reg = <0x12370000 0x1000>;
+        #power-domain-cells = <0>;
+    };
+
+    wkup_pd: power-controller@12380000 {
+        compatible = "foo,power-controller";
+        reg = <0x12380000 0x1000>;
+        #power-domain-cells = <0>;
+    };
+
+    scmi_pds protocol@11 {
+        compatible = "arm,scmi-power-domain";
+        reg = <0x11>;
+        #power-domain-cells = <1>;
+        power-domains-map = <15 &main_pd>,
+                            <19 &wkup_pd>;
+    };
+
+    // In this example using Nexus node mapping:
+    // - Child domain 15 (scmi_pds 15) becomes a subdomain of main_pd
+    // - Child domain 19 (scmi_pds 19) becomes a subdomain of wkup_pd

-- 
2.49.0



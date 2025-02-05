Return-Path: <linux-pm+bounces-21394-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05582A28ACD
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 13:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4781C3A5F87
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 12:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1467F130A54;
	Wed,  5 Feb 2025 12:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="motEBDFO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F52E86329;
	Wed,  5 Feb 2025 12:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738759960; cv=none; b=NvgSLBwUe+v8Bi16Pp7iNxCUvWI5ZDv6Tt0tqUAubk8xXC7jb4vIvtL8JQmL6suAzOMlJ9LkJtQczefuVIiQBLV1b3o5e35fh61ym2EmtU50sxlVvJU5kaZRAhmO9+zsOnLUjtTDYM+ek10MVL/R6j9EwQI7sF8q/XpxY4vRrVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738759960; c=relaxed/simple;
	bh=eOka4RycAnAHpLURzUuXOSzeKrLS2SoFDR7DtVsCCbI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pN77SlN10pOWGNnDRjYWTwlt/owU0qLeXJRn962EB12LCdwOdBo3/rQ8kJE3cenLpGpQgY9KPMX2d6wTJwI1050bMlyScxNTfZ4WyIqJZzodcFso5+T3EEJKukN9nb/NgbksUjrEI2GarChHuy1P6HRWSpMF3JOtYp0ZaP+d0EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=motEBDFO; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5dce3763140so521456a12.3;
        Wed, 05 Feb 2025 04:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738759957; x=1739364757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aZ+VTE5k0sR1ZK3QqyyvU9VyA3FsM9Zod0FdH9bBQvk=;
        b=motEBDFO/UeAcdSgWbN9MFANjH8r4pD+B/amcoeUj+ovMM2MeJaWGY6K2gUgNIbRg8
         LLpVzvhsu0PMKPOy+gqb2H1uiDU59SM4DRpPrGufuU3F6lSRa29uOnV/WFPsEqIvOge3
         ADqdlAWFrVi7BkeGQaRV+d6T1VqaPVOVT3Gr5cyVsFXrGIWIl4QVbKgkvO3da3yXQHKn
         ygWdDhIMe8h39a6Hnwe8+qrCgqQUk13JV6+ybdouTT9L3/HIfrHwVCqiTESmgysLss39
         /Lk1w4pQlYnBTul4yJgv+FWx5hcsLUkc20JsqMus4HOyALb4LLRVnb3c+OOX5cEPMGfB
         oyAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738759957; x=1739364757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aZ+VTE5k0sR1ZK3QqyyvU9VyA3FsM9Zod0FdH9bBQvk=;
        b=UHEip7cpIlmVAHRHwh+cd9d4G0OpttlL/+5sGjqvb0/zVWQTdigidiWhUhnYh46XoS
         epBmotrvPx2S8cwxgTxzoClxZYmvKFdvp4bMVn2eYZ1A6/PsdO0FVk0B1gHVr5qIlcA2
         eYBlYASNvBtAvVWv3lCyYJU1sJtlUr6uDyvKc3L7HIuqBih7ehGnGaf2wKocaVKsE6c4
         gHeCXlGCg05jaL/HmjBdwVqYDlg67i9iCslaH2S2WEUS1ulTq5So02NfqDtlze5UZ0ze
         tt5Z8OtjN16tTqQh97Th0HV8DM/o5prLZ/18HUjJXs36B+ATd91uPL7yOaszg6r2Mb3A
         l2LQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCxIP2Kc+flwd5rN+TDmAldTY+7F7gUzQJoDWtrsYMcm5vWZ1SwduXkel9zy/5gGp0KyB0BQN8vIU=@vger.kernel.org, AJvYcCUNPm2Iecn4PVAIl9/woRm7XWg5DiRLLzZtLchsYkiI0P2Mck6hGc97VL2azn/BK3EuwEW7xdwHxNfu@vger.kernel.org, AJvYcCWBdOHSEpP0VXGn2p3V5agrDCO4uuywP+tQNXpv0yawqh/naUHKJUHpcboM3r4SjLm+wmvN4LO3SrS0@vger.kernel.org, AJvYcCWU6+oyH0eyhShsVhNAON/0YkN0Rzpa+5KmemS0m/p9wHRwWcSxnG2+I1Hj+brSP2lUhXVNkpyjIPXbW1qz@vger.kernel.org, AJvYcCXGZoXhv1lpDt/kfGWIAMlsLmbSe58H6c8Rxt8824l47ZZw9R1N316IJ65UbGtkxqfgNl5eFKxi7jTDOA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwR4/9kv3nvakAB9P+Iqv3eRJfBCmDF7OYAt2iX1g0068aRPJJ1
	ywwxpnVfI/K7ZTgKCc6zoZpJQDr7+39oXIJ7LsFzEFDax2HyY7G8
X-Gm-Gg: ASbGnctrNU142GY25ffGqg3lmAUKRhPHNJ0GJWRrsBlVEQ1O/U6VqVN/ntEUQMVjB7y
	AocukR1bEl+EUFdN9+hLs8aUXrZmeYoYJ8/oo6mRGagiurqxQDNlpnnsey+uXO3Pxf4ogD3aQtJ
	ZMzLIuqxYKbf1zq6yb3jT5CeMiXQgVJatqQQhynbEQaPQlyMQY+VECqkzdSzif8eTvbDdS0xtmg
	oLmED7hjph/pNzSEepldy7W1hO/wKVEki9fHxINxFYbfkQ1xoQkBlb4Dlw+is+dma8gILPSduLs
	zpin2a4NG1sjddwefGhTdAoB4zJFvLzWdZSrlamook01SA==
X-Google-Smtp-Source: AGHT+IGRhSv9Imhm+auTjNV2o2DuhUhkhyLQG8J8I3Ur0Zu+jneuDXHk2hYm/9qI5G8NhBI2TZOWSA==
X-Received: by 2002:a05:6402:278e:b0:5dc:c869:da4f with SMTP id 4fb4d7f45d1cf-5dcdb7645cfmr2783894a12.24.1738759957120;
        Wed, 05 Feb 2025 04:52:37 -0800 (PST)
Received: from localhost.localdomain (185.174.17.62.zt.hu. [185.174.17.62])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dc724055e5sm11559997a12.45.2025.02.05.04.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 04:52:36 -0800 (PST)
From: Andras Szemzo <szemzo.andras@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Maxime Ripard <mripard@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v2 05/10] dt-bindings: power: add V853 ppu bindings
Date: Wed,  5 Feb 2025 13:52:20 +0100
Message-Id: <20250205125225.1152849-6-szemzo.andras@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250205125225.1152849-1-szemzo.andras@gmail.com>
References: <20250205125225.1152849-1-szemzo.andras@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document V853 PPU compatible.

Signed-off-by: Andras Szemzo <szemzo.andras@gmail.com>
---
 .../bindings/power/allwinner,sun20i-d1-ppu.yaml        |  1 +
 include/dt-bindings/power/allwinner,sun8i-v853-ppu.h   | 10 ++++++++++
 2 files changed, 11 insertions(+)
 create mode 100644 include/dt-bindings/power/allwinner,sun8i-v853-ppu.h

diff --git a/Documentation/devicetree/bindings/power/allwinner,sun20i-d1-ppu.yaml b/Documentation/devicetree/bindings/power/allwinner,sun20i-d1-ppu.yaml
index 46e2647a5d72..f578be6a3bc8 100644
--- a/Documentation/devicetree/bindings/power/allwinner,sun20i-d1-ppu.yaml
+++ b/Documentation/devicetree/bindings/power/allwinner,sun20i-d1-ppu.yaml
@@ -17,6 +17,7 @@ properties:
   compatible:
     enum:
       - allwinner,sun20i-d1-ppu
+      - allwinner,sun8i-v853-ppu
 
   reg:
     maxItems: 1
diff --git a/include/dt-bindings/power/allwinner,sun8i-v853-ppu.h b/include/dt-bindings/power/allwinner,sun8i-v853-ppu.h
new file mode 100644
index 000000000000..b1c18a490613
--- /dev/null
+++ b/include/dt-bindings/power/allwinner,sun8i-v853-ppu.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+
+#ifndef _DT_BINDINGS_POWER_SUN8I_V853_PPU_H_
+#define _DT_BINDINGS_POWER_SUN8I_V853_PPU_H_
+
+#define PD_RISCV		0
+#define PD_NPU			1
+#define PD_VE			2
+
+#endif
-- 
2.39.5



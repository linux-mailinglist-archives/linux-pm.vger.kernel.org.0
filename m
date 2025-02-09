Return-Path: <linux-pm+bounces-21608-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 710F7A2E118
	for <lists+linux-pm@lfdr.de>; Sun,  9 Feb 2025 23:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9E783A594A
	for <lists+linux-pm@lfdr.de>; Sun,  9 Feb 2025 22:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB941EF09B;
	Sun,  9 Feb 2025 22:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RDnjKhI+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147DF241130;
	Sun,  9 Feb 2025 22:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739138834; cv=none; b=E9o+KLG5RXtqNbq14vaBppuvb6VvvptIA1l4otEbvx6V2R3QDmrApxXJngObV6ze6ApGdTujFirbTHRgXzfbfqYek57cBbHEHpjtS+iv8Nm7wSenizgsXT7vksgawN1641El4hEaHFktP/7OwigLsw/nuXrB2C0zTHSOrvmbf80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739138834; c=relaxed/simple;
	bh=7ZAGvUrrjx83yvWVf8ubIKKZh58Hvm4b115PNTRbOXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=edLgR/Nhl16cYXcR1e8RXpokCKQSL7KB9EPDNdyJ+5oYceCE316cBQgZl2mSfFsHV8giycIlk72sk/lFb5T3Hi5uI6hOiT1aQnIBgQCjFtU2fyLAvwjC6p4y1qNpgC0N4Htm3Ka7MvpRH8DWpzDZuPteA0eE2NE8wi+En9bpBVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RDnjKhI+; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4361815b96cso24577795e9.1;
        Sun, 09 Feb 2025 14:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739138831; x=1739743631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dVSwUzYyCuH/0EmC09Tuh6m4O6FbPIf1eRFL1KmeQ8U=;
        b=RDnjKhI+K6X3f7YvNWh5TsXc4WJkasR1QApigKyPmQQxTVJGIczvGFqamgU7ew8dLB
         JLflrYl7B3KtrXT26nol0tGMBDOkk6jUr2EuPgohNrkBV9uEgorkwXopgBRlhwWv7bwz
         h4IqLQIIgotLTLwXkg2B20/B4wjg5pSoTnHsJax2BeyqqWBPdn5HLD4b0ew5RcFd3sRD
         FACxCRw0iSYKqAaj/p2FYeRKFKjCW/rQAYGRC9593BTFCFaGV/wHr/SDvrTkL5Ygsgl7
         rIS6RqSQWz1lMw+UDiUpg8CXAlVvPHu6ScXHCOAz1hJeZWpUktsj7/r8IQGmR9otkhRD
         o07A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739138831; x=1739743631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dVSwUzYyCuH/0EmC09Tuh6m4O6FbPIf1eRFL1KmeQ8U=;
        b=CE3ZHL6V7UfkFpBqFWH2AexC7vlvJqELU+GZCI3FZz0Uz2FlYRkkgaxGjIqi1Ce0pR
         Z/GqOpBfiHIFP3NuH4mhp8/bSjLj1Q7V+nTar3iOSvtzJQeu5OEI+X+Xg3NW9FlXmHn+
         KR5LV1JVLPqFQMYIBmT3suNsI0b9Rk7xJlV5wDcUDt4TTkh0twHxEKmBYtZFcTYnrsxQ
         z715wHH2YD3UqxmlkAKInvgmaG8boERpcCIhapWQHsngJrEv45OJyV2MjXOf7YSm1ZvS
         N0jOm8ifE9+8NNQ7IiixaEzKsM1JwbD8dSaCjtinJHA6lce6atPi+ct7ZFMW870wtPyD
         HG9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUfG5wbxwtIDHOHdeFzakXIvHhADepdrYEt9XORP3EhOQto3jbSPhPKw6kJHukXL4mbFGnAOhCOLLc=@vger.kernel.org, AJvYcCW6yPxup/WJsAne7xSG+a3XBTadzOrSYK1PJPL8QjfMoAcgXKv/7tjws+MovDmO5L3R9M90NANeASiS@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg7IPA5t9JUDXd2WRTPGjsgflTj796SKt+yh9btYmEkSdT4r1o
	UAJAio6W1cHqqf6n8ELC8DXNjYqpPAsKgThpE73SnVQLz40Rq5zU
X-Gm-Gg: ASbGncuVIzHwfv1oHK7Y13AgtUK5KIov1A2jTZVwAYNeSGruCJFwt0PO85jU+x7mP3b
	bYkCKBpds8I2fUe9RngxZID4Qj+OjWnP0tDV1CGe677tGOVL1zItK5ov8vBTOR+V7ynhPboPhOU
	9hg8L4MJH9ONhbBudaIdglWDUvxiN8oXLQGUVqxi19srkUYhM8sfvi7m9N4I7vCGZA6yGh+Dxye
	aiXgF0IbO+XdWBoCauDsWlIhh6all6n7PZCm8XYae0sKU39DxC4v9uJJPZd3V1jrhNJuKXYbNAI
	59w0i/14NObvtgqNN6nTJxIDo5wv
X-Google-Smtp-Source: AGHT+IH5vVna5qsuNt4fQZwckiVpOEaiuCCrF2lXcmMmNlYOm+Z+9AtnNGM3IMnM6VxBlfyTkVsF/Q==
X-Received: by 2002:a05:600c:8705:b0:439:41dd:c061 with SMTP id 5b1f17b1804b1-43941ddc2a4mr22063795e9.31.1739138831167;
        Sun, 09 Feb 2025 14:07:11 -0800 (PST)
Received: from giga-mm.. ([2a02:1210:861b:6f00:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dbf2ed900sm10386544f8f.53.2025.02.09.14.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2025 14:07:10 -0800 (PST)
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: soc@lists.linux.dev
Cc: Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	linux-pm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	Haylen Chu <heylenay@outlook.com>,
	linux-arm-kernel@lists.infradead.org,
	Sebastian Reichel <sre@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lee Jones <lee@kernel.org>
Subject: [PATCH 07/10] dt-bindings: reset: sophgo: Add CV18xx reset controller
Date: Sun,  9 Feb 2025 23:06:32 +0100
Message-ID: <20250209220646.1090868-8-alexander.sverdlin@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250209220646.1090868-1-alexander.sverdlin@gmail.com>
References: <20250209220646.1090868-1-alexander.sverdlin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add DT bindings for CV18xx reset controller. The power/reboot driver is
going to use only 4 bits from two different MMIO regions which can be
potentially used by other subsystems/drivers, therefore the resources
are not being claimed directly by the device/driver, but via syscons
instead.

Link: https://github.com/sophgo/sophgo-doc/releases/download/sg2000-trm-v1.01/sg2000_trm_en.pdf
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
---
 .../bindings/reset/sophgo,cv1800-reset.yaml   | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/sophgo,cv1800-reset.yaml

diff --git a/Documentation/devicetree/bindings/reset/sophgo,cv1800-reset.yaml b/Documentation/devicetree/bindings/reset/sophgo,cv1800-reset.yaml
new file mode 100644
index 000000000000..4f058f99df5f
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/sophgo,cv1800-reset.yaml
@@ -0,0 +1,38 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/reset/sophgo,cv1800-reset.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cvitek CV18xx/Sophgo SG2000 Reset Controller
+
+maintainers:
+  - Alexander Sverdlin <alexander.sverdlin@gmail.com>
+
+properties:
+  compatible:
+    const: sophgo,cv1800-reset
+
+  sophgo,rtcsys-ctrl:
+    description: phandle of the "RTCSYS_CTRL" syscon block
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  sophgo,rtcsys-core:
+    description: phandle of the "RTCSYS_CORE" syscon block
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+required:
+  - compatible
+  - sophgo,rtcsys-ctrl
+  - sophgo,rtcsys-core
+
+additionalProperties: false
+
+examples:
+  - |
+    soc-reset {
+        compatible = "sophgo,cv1800-reset";
+        sophgo,rtcsys-ctrl = <&rtcsys_ctrl>;
+        sophgo,rtcsys-core = <&rtcsys_core>;
+    };
+...
-- 
2.48.1



Return-Path: <linux-pm+bounces-22028-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5FE5A34D87
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2025 19:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3A523A938D
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2025 18:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF46A245020;
	Thu, 13 Feb 2025 18:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PBuoGVsZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE00624292A;
	Thu, 13 Feb 2025 18:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739470941; cv=none; b=BRTjljJS3v8zfIi5AeAEWaIbt3dSIDN4NonYVuDJXtYJA2ygqyOgetfR7DFn1iUGP+1d/W9MxV30EOVNDG+gUt98o1r7xTeuIIygBKLXwceAnHp6ynZhsCVJI8Ml2ifNXZvOcs74H0I6RpnRExPNT56mm5KfSnfKmqVcqVnpQZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739470941; c=relaxed/simple;
	bh=gJc7Eh64m1cr93UEKrUYMK8tISR4Tg83dlJHpzbCplI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H+q9BEU1CdBjsTfhN2ZEmbKYaWsJfI9G+26sK1h9tHvVR4eSj+U2hwtP1j8q1s2ZcSIPNA0aurI5A4Ee4cpAOkhGt/wFXAik8yS49JP6PhxUYP1lzq02rytAIX2tDnOWIhdNJKQ4aFwB/oWyGJ5nb3UTQPUgkJyWXy4Aa1UaGRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PBuoGVsZ; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5de3c29ebaeso1484414a12.3;
        Thu, 13 Feb 2025 10:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739470937; x=1740075737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KrgHxkjNu9X/Q1hrHUQlLJCmY0Xg+cCRCTLN/OZ/kLg=;
        b=PBuoGVsZm3dR1fjK+MH0dHhrZWFKKzxZghg4xC4+HrKnYy2W2HG9IqBv7q5EYFlpMb
         +/75nXDB0gIu/eaDWX4QtfJOWoeVY2ltS+MsgYLnU9sWo24BFgKixCxrteMpjaWNR+9B
         Dpm9Ca7db87iFsp3knVoF2694bsv42uRDEmU3uCX89U51MLpMq686JW/QKp/auzwkgEb
         KwWyEZZcEBuLy5Amip+ocjf0bBUPrLUas1vBBZs+IIFstx+uDnJ6seZCiNxbo+j+L+wK
         WmR27RqHUmEbatIsn4sdUcYYSvd4PEFol2rDpNxAN0mXR0dUXxEt85aMJY3+zT9bECq/
         G6iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739470937; x=1740075737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KrgHxkjNu9X/Q1hrHUQlLJCmY0Xg+cCRCTLN/OZ/kLg=;
        b=rjiuvMj6/vYzZXHJb4lU00+Tn61x6TlI/GNSAeNiXoBQ1I1ffDQEDckLMsffpLiRr0
         B5m5GV/Yb1P56FfSowJB01Nfpz5wmRQf9yhs2g1WgPxOTcqxXAu98XLflZyS3QWb9630
         lzAl7V6d5yfCVfczlfL4eu1mrxavI0MjQLOwn8iCBQFoBgvd4F1W4Vi7tq5ZSthM3Ddl
         g31931wyeBQuwCsBm4JtVgD2mZ/I0FEn/sCR+WRQQjXVXEo+XF/JGvTngGbh6ot+2abX
         xMo0XAQIKpQ3hZwqDKVJxcBsqQU7IpKxGo8xJWpa6+VxJA9oyCbXqkSYSy6QOdeQLD4b
         Zw6A==
X-Forwarded-Encrypted: i=1; AJvYcCWcbqKZmbaOwRtxBBI3QE7DFur86n+sIwisBgyZur+/BzFR/QhHx6zuyhs9fgSOLto8ihAZCfsAtao5@vger.kernel.org, AJvYcCXo4y1WR36OnWOr57gAKXG0m4r4bZfOpY6smO2nkokJ+ynLayJiRuH0hEGA1GSV1mltJ0oFXQfXh7I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzknX7Yv5cSzWcFzkg3fcEDnuzQUsZHjs6JsKmYdQ1WwBcrRGrk
	/bXSZ6ePKpwi7fSdwiRQDV9FDWokjTXiQ2NCTUUZ8F8pJY+0LTIm
X-Gm-Gg: ASbGncv3yd6TY1fky9lM6IcKSVesHzCaqczGs9bXrEYlbETEp/AEqla2WFldiRRQUr7
	5y1lL4zXjciRBj24LbrN1ztkjkkcCdZs8qn3QkLfvYh7dgdUloYpVoPyoPYx9iUJLiBOeWKszYr
	N7FY1bICBTycz9o9KOLbJTDpXGwJ4SN2IztlgNdBEv096z/oRPzSO31vEcrhnTuv8KaO41qKqx3
	tECMkw0tO/mXFJas+oVPHLlRJKs867FoIXVP+OX6I7BF763I50DM8yc/3rK2iG4ExXGjrsGCHVa
	+qZK/5TkjAurpMnyQ7/HIKCjxjnH
X-Google-Smtp-Source: AGHT+IH/Yi/EFpYPwVBoMo0zkp4iN2ezmFezqDq4NFl+9G7EivdIfhPrP4/hFUgDkeiAuMIpUimZSw==
X-Received: by 2002:a05:6402:358c:b0:5db:f5bc:f696 with SMTP id 4fb4d7f45d1cf-5deadd751bdmr7502320a12.5.1739470937100;
        Thu, 13 Feb 2025 10:22:17 -0800 (PST)
Received: from giga-mm.. ([2a02:1210:861b:6f00:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece270a66sm1559230a12.52.2025.02.13.10.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 10:22:16 -0800 (PST)
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: soc@lists.linux.dev
Cc: Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Chao Wei <chao.wei@sophgo.com>,
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
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v4 2/7] dt-bindings: soc: sophgo: Move SoCs/boards from riscv into soc, add SG2000
Date: Thu, 13 Feb 2025 19:22:03 +0100
Message-ID: <20250213182210.2098718-3-alexander.sverdlin@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213182210.2098718-1-alexander.sverdlin@gmail.com>
References: <20250213182210.2098718-1-alexander.sverdlin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move sophgo.yaml from riscv into soc/sophgo so that it can be shared for
all SoCs containing ARM cores as well. This already applies to SG2002.

Add SG2000 SoC, Milk-V Duo Module 01 and Milk-V Module 01 EVB.

Reviewed-by: Chen Wang <unicorn_wang@outlook.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
---
Changelog:
v4:
v3:
v2:
- patch introduced

 .../devicetree/bindings/{riscv => soc/sophgo}/sophgo.yaml  | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)
 rename Documentation/devicetree/bindings/{riscv => soc/sophgo}/sophgo.yaml (80%)

diff --git a/Documentation/devicetree/bindings/riscv/sophgo.yaml b/Documentation/devicetree/bindings/soc/sophgo/sophgo.yaml
similarity index 80%
rename from Documentation/devicetree/bindings/riscv/sophgo.yaml
rename to Documentation/devicetree/bindings/soc/sophgo/sophgo.yaml
index a14cb10ff3f0..5d73d0ccc547 100644
--- a/Documentation/devicetree/bindings/riscv/sophgo.yaml
+++ b/Documentation/devicetree/bindings/soc/sophgo/sophgo.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/riscv/sophgo.yaml#
+$id: http://devicetree.org/schemas/soc/sophgo/sophgo.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Sophgo SoC-based boards
@@ -26,6 +26,11 @@ properties:
           - enum:
               - sophgo,huashan-pi
           - const: sophgo,cv1812h
+      - items:
+          - enum:
+              - milkv,duo-module-01-evb
+          - const: milkv,duo-module-01
+          - const: sophgo,sg2000
       - items:
           - enum:
               - sipeed,licheerv-nano-b
-- 
2.48.1



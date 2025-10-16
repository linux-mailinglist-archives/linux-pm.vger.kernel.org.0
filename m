Return-Path: <linux-pm+bounces-36280-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4E3BE463C
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 17:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16242542A2F
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 15:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C9A350D44;
	Thu, 16 Oct 2025 15:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qxd8D/ID"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C3F34F47A
	for <linux-pm@vger.kernel.org>; Thu, 16 Oct 2025 15:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760630328; cv=none; b=DlYta0tkC+HEDE2Qd3EkAxi0oQRI/T2RAZtBW97+8M95zV8rArvZ+nnCBRclc1dGPRLQdP90O75doOoQdSqUZZ578dIIizy/QTXIuU0icAhJL+uEKRi3xlPc7VvXauEoKPHETjTFM8Gom/id0vkIAodKAAEKZWVorN47jUc27po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760630328; c=relaxed/simple;
	bh=wrIYG3Nz5u06Jww4oYJhqOv0hyk+YRHCWFWVoDPnx30=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a7G1jacAeOSBXKvTdKOhShVp/LmbLg/PF0g4vnRyU84x1LzP4j5qczP0BXWBsgPVA5AoumAGCv5DExBvvq3jLvP2xh+dYQU88mPHvEhELEwUm91sQdXRahg/1FHdJNVmJyHAuUnupv/wcXatpECbGaBhk6yRZqCstClGn/azUa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Qxd8D/ID; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b3d80891c6cso379087966b.1
        for <linux-pm@vger.kernel.org>; Thu, 16 Oct 2025 08:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760630324; x=1761235124; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+EZqCABiIEnd0Y9dNLKHtIhbcAbjGjEboA5l9h/vQsc=;
        b=Qxd8D/IDhfolUnz1Lc0tfc6fhnSEqzVHXye5rlrzSnJaLjIyoB4CIuRRnsgbbgZ8yE
         3z5hJKWC9Z/qYLB3Y3nZc2i2HsE4PK7IMuts/ff7eFES64jxbS7PEnVUFaeauwabUDHv
         fJtuveJOFII2WmAMBJukAD2OtFaxxJOItsGbvyN+NeNlvx5f4I9Nv1IC8YUxPphYAu23
         9488NaG1kU4BZtM3E+nYT7pwkLNH1FMcRsOHZ6PwXGs4TWqBrlTFzzPG+uld6/Pvo+GP
         PNzfTP2VM01VznCGC/vypaUanUjSh7DjJNWGwVumSuEBrZJi/rBnw0DDWCVZrVZFtpVe
         bJSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760630324; x=1761235124;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+EZqCABiIEnd0Y9dNLKHtIhbcAbjGjEboA5l9h/vQsc=;
        b=auNpWI6+PM76kI/HSCLheCTRUCqVh9Dgt2oEQL30V21Q7vQ6gyt6WZZZWM+qVLuh/u
         4wZGgLheE8wMXwE53Zq+sBn4kxfc6x+kscUUFMa0DTxzoGURTxd8i2pkISVnGbODnXZP
         10L8UqTmX7MTf5DUd3U2UFShBZZG9baixNIxYiCs90uYGXUuRCoc2b86zrNIyEP6lDIC
         MKCQsiugGiU+k5b0N8O2IYGV3zIwQ+7J/lttw1lX9kuF/Ifi7aC0J6YUg+9lzr0Vhzt3
         2jDQ6Rsq3Y/RSgxY9I35wHwcehkvTkWfvv7m59rTciXr63HYUzocMbj19gAWn0oTesQR
         oiGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWo9dNgxBW9T2MMrf2nKpt5vZEgndCrDSHQ/vAQzBlCwEhQ1nShc4CbB6mTPRDGQZoewQsNxBdrwg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyiGsaD1BQXdd5arLG4d3iGfPHYeaxKY0ZKFSdhuXS8Krab0mXe
	5RAnIlS9UUnUteJJmhKEnBnXja9+NKp9R9mQZaeqQR9TxUSsCoWd4Op1pAmEQDtNTiQ=
X-Gm-Gg: ASbGncsh0f0kUWzDCTp1FRVx/koP6EeX8IrNgUgkpijVsM8f8zKcBjwcbKH5OELcMm0
	s97ukvYIZCM0I8C4tBdy7/U9AIFX6Cwfd31+sh9YIG1QYoVBZ4Shd1J1pqZoIWsNMDwqEAaUueC
	PcvBGTO3pD4Ja/nuGCY5L/9k+RETKWNRqcEpwWFrXeo1dIDcyEJIND8Q4cClek7j3x+BFZUGeFg
	5pm4tSSXRl78V86Cnb0UT5t4mGH31Q0S+XhpCPoa3NlgDVmBQsFiwKdlquMA24sdcNM+RNYCDE/
	YO1xFvOXNJzACh2jjvQeiYuZ/5BfmuqZTTXjBihFhUAIidp9UJ1fkbRsPeXogsaS2mpbEf7T63H
	oN40Ci9W9CzOYEBk726VdU5e/PBQK555YDhFOl7Ab+hzGWoqmh5Vu1KQ3vGD8b532N999mvMwkK
	d7tVv6EnWK2GiaD9PmzdJg6K6T2Cc/f2uoX0HsVsLwJViXnX85Ah1sWvY1BFBR
X-Google-Smtp-Source: AGHT+IFH5MBvT1BbvZNO7LnK4pIDcpdPVfm9z0TGyk/r6VaVSo4jUiDBCHuy36yU9LuWlmcxA0MaVA==
X-Received: by 2002:a17:907:d27:b0:b38:49a6:5839 with SMTP id a640c23a62f3a-b645d20f122mr99022466b.11.1760630323679;
        Thu, 16 Oct 2025 08:58:43 -0700 (PDT)
Received: from puffmais2.c.googlers.com (254.48.34.34.bc.googleusercontent.com. [34.34.48.254])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5ccccb4811sm549021666b.56.2025.10.16.08.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 08:58:43 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Thu, 16 Oct 2025 16:58:34 +0100
Subject: [PATCH v3 01/10] dt-bindings: power: samsung: add google,gs101-pd
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251016-gs101-pd-v3-1-7b30797396e7@linaro.org>
References: <20251016-gs101-pd-v3-0-7b30797396e7@linaro.org>
In-Reply-To: <20251016-gs101-pd-v3-0-7b30797396e7@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

Add support for the Google gs101 version of the Exynos power domains. A
new compatible is needed because register fields have changed.

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 Documentation/devicetree/bindings/power/pd-samsung.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/power/pd-samsung.yaml b/Documentation/devicetree/bindings/power/pd-samsung.yaml
index 9c2c51133457112ca0098c043e123f0a02fa1291..c35c9cb0115d79e5c36142da2c2a5dd30cd2ad47 100644
--- a/Documentation/devicetree/bindings/power/pd-samsung.yaml
+++ b/Documentation/devicetree/bindings/power/pd-samsung.yaml
@@ -19,6 +19,7 @@ allOf:
 properties:
   compatible:
     enum:
+      - google,gs101-pd
       - samsung,exynos4210-pd
       - samsung,exynos5433-pd
 

-- 
2.51.0.788.g6d19910ace-goog



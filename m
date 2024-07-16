Return-Path: <linux-pm+bounces-11159-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC5793279F
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2024 15:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B1E728567A
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2024 13:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E4C19ADA4;
	Tue, 16 Jul 2024 13:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PZQU9Rc1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2505175573
	for <linux-pm@vger.kernel.org>; Tue, 16 Jul 2024 13:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721137147; cv=none; b=O0hohhTBsOQzPT94FUOtVrR6n5C1UDJZN1EocOzUy0Luc4eWv8iSrA9lJwM9JYUsIUG7u7GRzbF0RAsaGESSQ2Acc0KNwjphQI5F/w8e9cQauDEjMuuOFQCUlrm1pNoYzQTkupR8drOo9BOxIFbPcABftmdRY79l/it5jwgEwBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721137147; c=relaxed/simple;
	bh=X7bklE2GsqthkplIQvZDv5rg3XCkY1GEHEuOa1Ws1NY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Yn0hgJ3eyC9RBM6jnPRRitJLvufpd82Y7mariKq5LUsyXMH2u2+3xFw1QKp3QeCXMnVtYSS9eX3bz55JIv9ZFEDKQ/CFsGHJ6TKyQtkLsrjhCi1aOS45N+h+NtITNMFbgRQarB/GPFjxuGxDyJY/RccbKwTRHjaRQ2zG9oruCb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PZQU9Rc1; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-36799fb93baso3327837f8f.0
        for <linux-pm@vger.kernel.org>; Tue, 16 Jul 2024 06:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721137144; x=1721741944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hoRw9TcQOEMBdmZxq6Nd1FUggtL3OxOdKdUjU7Ar674=;
        b=PZQU9Rc1uamUErcSkYo19qR9o9/Qg+Fl+7O1SBqoh+4cT234bFkHAWfW9/3P9NCfG6
         CyKIFlw6jJ8JgtrXoNeYdgNzUeu0wclCpvkTi4BpyFy2nk6zJ7pQClwJmah1juz8g2Xf
         vCVYNQr1tuhi4/5Q+eBwJUAMUoQ3p780kMURErG7+VciGybWg2hfmhi3f02TlbNtL9d2
         zBUr0hqiWHnNfOpZ6jaoioBy2KBvm8vuCz3bVOk/gx4Mui7mnb6ykjAFK5cvR8+FiusK
         rUli2JRfz+CfagRELvymZ1cP6MiSRrT5zrTFLNuI32eSduncjaPYK20c1UvKh8C8NACm
         fJqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721137144; x=1721741944;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hoRw9TcQOEMBdmZxq6Nd1FUggtL3OxOdKdUjU7Ar674=;
        b=LUvM3wE+wbk9z2n8fvD+FaqppKFMNf5YVpgJ0P9Cnv3qVOps40rrpq7m5Ou81hzYhd
         D3hA9x4ogXB+XT3SUo3YomhRuqWUY95H9dZ9bMjWCTtY7aTKM2N5PX/PRg8g1JB9hNUL
         LBDI7eO1YxvdWc4eyliO6wcyX1HqurXHZyj717lOnsv/8yiqTJg320473TgwyyCZpIV8
         a5fAO1IYtOH6ruPGiF1htsdpnDpi7dJMOYJ9qYqo3o5m6SlSB4Q4AXS8Z6AhH56CdWQc
         io3lYbxk7IrHyH2ls9HVrwMboLS9GT9haw8qlfLgpwGTSzl/LzI0Hw3n40XN0ZC30s0c
         iWMA==
X-Forwarded-Encrypted: i=1; AJvYcCWkc4Un1TnOy8EPfmMO3ZOeBrpAOAmDw6i9H8U8lwuclk+3wQ1/JFXtq9mmecSxa4oZs4AOqPxBvzDmQjEtiotwv3eB5pRUB3Y=
X-Gm-Message-State: AOJu0YwCJFpXwV58dDVEuqzIDeY9ceXUEbbOOFsoAHpeQoANDaH/XTCN
	jf8/OJSKh0SOpnayhqGSD9RlGVN/PhfNWF2mV4f8EWKAPhDcOOHTp5QspN5h/m8=
X-Google-Smtp-Source: AGHT+IGXs0HjAx3DBf4LWEbRloC7TAHjz/hinusld4TqeGA/WwEle1cNhCho1exyWsBz602KmeEFJA==
X-Received: by 2002:a5d:6143:0:b0:367:9877:750e with SMTP id ffacd0b85a97d-3682609b526mr1426499f8f.25.1721137144212;
        Tue, 16 Jul 2024 06:39:04 -0700 (PDT)
Received: from rayyan-pc.broadband ([2a0a:ef40:ee7:2401:197d:e048:a80f:bc44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680dabf0e4sm9106564f8f.33.2024.07.16.06.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 06:39:03 -0700 (PDT)
From: Rayyan Ansari <rayyan.ansari@linaro.org>
To: devicetree@vger.kernel.org
Cc: Rayyan Ansari <rayyan.ansari@linaro.org>,
	Amit Kucheria <amitk@kernel.org>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: thermal: qcom-tsens: Document ipq6018 temperature sensor
Date: Tue, 16 Jul 2024 14:38:02 +0100
Message-ID: <20240716133803.82907-1-rayyan.ansari@linaro.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the ipq6018 temperature sensor, which is used in ipq6018.dtsi
and is compatible with the ipq8074 temperature sensor.

Signed-off-by: Rayyan Ansari <rayyan.ansari@linaro.org>
---
 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index 99d9c526c0b6..d6f333a7bcd1 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -76,6 +76,7 @@ properties:
       - description: v2 of TSENS with combined interrupt
         items:
           - enum:
+              - qcom,ipq6018-tsens
               - qcom,ipq9574-tsens
           - const: qcom,ipq8074-tsens
 
-- 
2.45.2



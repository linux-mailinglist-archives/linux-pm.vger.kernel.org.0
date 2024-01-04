Return-Path: <linux-pm+bounces-1824-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59660824202
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jan 2024 13:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61F331C210E7
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jan 2024 12:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921242136E;
	Thu,  4 Jan 2024 12:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WWdBu06O"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4724E219E8;
	Thu,  4 Jan 2024 12:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d4c77effe9so419695ad.0;
        Thu, 04 Jan 2024 04:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704372605; x=1704977405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/9MytnKXy6VUbepQQQq3LMvOhLoxpcNzLzoYfwIfbJ4=;
        b=WWdBu06O50xuXUq4uocvFL0xDN7Wz8BefazDY1aYDZBcu5aRijz+xBL2qi469aD3K1
         XRxYELzIYbW1ZXY4hn/IV6Ru4dpWSIUF6nUec2bea/44S8m8dpPqNt/J+slkhbaxZN5v
         VSfMHCChtp8oKm9XFEs9T6HzQgxLD4/+Kp8I6141HYe6w/KrdCrtyIguj509fEye4vto
         mHUYqSu/720GSh1aWJCB/QBwYGfT8i7a0G8v9Nr0YO6473JAjYaJFK5lFQ6wuC4q54rP
         9e5TGrgR2f6UpOxwcdChstd7ixG8I3Vf4oxr3xlnXPmSEHd1/wVumMHm8vmgFTFyBgb2
         nkfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704372605; x=1704977405;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/9MytnKXy6VUbepQQQq3LMvOhLoxpcNzLzoYfwIfbJ4=;
        b=gSH1K33qIgTh29/ZhlF8hggsVWCVWoxbOhNdJmyNv5qPZqWtuXp98T6DGtW12+GolV
         3BpL86xUKfVMCeAqINjIqjp23oT3kBXxPz3WRk4sFd0Nt/PaiTm5Bn2ns8ZMGWd7ZULo
         8F+MSzZIOHk/zkVlEurOnJl0DlR3Ewqki7EcwdQN5VesGuObiHI8KE+DwuVAqw4YKyLC
         QXbZYraCTYslIVaPqb4NrougP7eLQ7qkfTGZ/ZyiGc2DrNPyA0i7z04ZoiiNDKaLZJdF
         BCZfYcKfStmUUvcJ7GRt4mRVY047IMMbDWtl4HtRBPwnOmZJIBgFgLPJQs27Qxyckdbc
         9NGg==
X-Gm-Message-State: AOJu0Yy8ekJ8RIE3q4cxABlaeSt81RxvAFTqxw8emM1AkEoU7FJ0TMq0
	BYCOuxEs8mQ9DP9sM4one3Y=
X-Google-Smtp-Source: AGHT+IEg5OFJG0S7RHO+vGgSKUxk8zLrgU3NE2gefe4MDNbH+XxqlynXdqAOantob0MB5crda/uprA==
X-Received: by 2002:a05:6a21:3384:b0:196:1899:d756 with SMTP id yy4-20020a056a21338400b001961899d756mr1010755pzb.2.1704372605233;
        Thu, 04 Jan 2024 04:50:05 -0800 (PST)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:5a8e:132d:4dac:265a])
        by smtp.gmail.com with ESMTPSA id v24-20020a17090331d800b001d4cac52e73sm4490082ple.131.2024.01.04.04.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 04:50:04 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: daniel.lezcano@linaro.org
Cc: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	Fabio Estevam <festevam@denx.de>
Subject: [PATCH v4] dt-bindings: thermal: qoriq-thermal: Adjust fsl,tmu-range min/maxItems
Date: Thu,  4 Jan 2024 09:49:52 -0300
Message-Id: <20240104124952.1975160-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fabio Estevam <festevam@denx.de>

The number of fsl,tmu-range entries vary among the several NXP SoCs.

- lx2160a has two fsl,tmu-range entries  (fsl,qoriq-tmu compatible)
- imx8mq has four fsl,tmu-range entries. (fsl,imx8mq-tmu compatible)
- imx93 has seven fsl,tmu-range entries. (fsl,qoriq-tmu compatible)

Change minItems and maxItems accordingly.

This fixes the following schema warning:

imx93-11x11-evk.dtb: tmu@44482000: fsl,tmu-range: 'oneOf' conditional failed, one must be fixed:
        [2147483866, 2147483881, 2147483906, 2147483946, 2147484006, 2147484071, 2147484086] is too long

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
Changes since v3:
- Rebased against next-20240104.
- Do as suggested by Rob:
"So short term, I'd just leave things such that they don't warn or just
drop the conditional."

 Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml b/Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml
index 145744027234..d155d6799da6 100644
--- a/Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml
@@ -33,7 +33,8 @@ properties:
     description: |
       The values to be programmed into TTRnCR, as specified by the SoC
       reference manual. The first cell is TTR0CR, the second is TTR1CR, etc.
-    maxItems: 4
+    minItems: 2
+    maxItems: 7
 
   fsl,tmu-calibration:
     $ref: /schemas/types.yaml#/definitions/uint32-matrix
-- 
2.34.1



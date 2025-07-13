Return-Path: <linux-pm+bounces-30739-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B044AB02F5D
	for <lists+linux-pm@lfdr.de>; Sun, 13 Jul 2025 10:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94A85189CCD5
	for <lists+linux-pm@lfdr.de>; Sun, 13 Jul 2025 08:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348BC1EDA02;
	Sun, 13 Jul 2025 08:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="fVzT5wL9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247B31E98EF
	for <linux-pm@vger.kernel.org>; Sun, 13 Jul 2025 08:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752393967; cv=none; b=pTpDr3lR6aJfB6rzv1G9e8x0dwIh7vC0az8sGWqsE2spayG21ZGP/mwnc7GocfgTeXZGy+SaXe+wtPF1yfiiGgt5QXj1lZfYhPnm/3Q5fY70XPrBmSHVDxVL2FM7XSvOp8zMa/82McPviriXNoEiJ9yzj1B8AUJtFv2qcUi+y8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752393967; c=relaxed/simple;
	bh=VI60lC4ZmfORZyuxHBRWFEsQsFQCradJNwP6TkMJAbg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eFfZ8G55bAGF5ADVBp9fTdVHP4xkXB6KnD62uxjj1aWhYNQeenVWltl9YpP3xgekC+cCB7T5fWm9gu2QHrYAkJzd+T0vglnVqnkIGbcekmPa+uRzFClMP02h7l7e4mWTilUw7jENPuZm1tuJrzmLneRj/x8Wu1EefsKHEBnQ7Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=fVzT5wL9; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a57ae5cb17so1952619f8f.0
        for <linux-pm@vger.kernel.org>; Sun, 13 Jul 2025 01:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1752393963; x=1752998763; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=te4MJTBpVgJuhtRjxJH2s+xCNlwZ781R0MdiUCdRknI=;
        b=fVzT5wL9nacXW/zSdVnPdDbwPO56ZOrrEUVOpNbIAb1f7W1u2/y2rWwm8bEANvkoxp
         ozKpvIlwiIZ3WDVOOaZftzntoOQcYVO+BxYocNbPHLzFNo87Z7baIwvuLutQ29cq1CdI
         xZE/PnHpaqHl4HJZyY99lA4aO46wIJyRAvO5X7okujkVvV7TeZOGZsn2irG1Bkr7jJ2I
         FwvM+PpZiuHXcZ7rv/XYmi/2aI0xd5ekluMPu+EUSKl6sM+3E7+LpRJ9YM9MG914dduD
         0P3QH25ryNPcyxK7NyZOOQq0mWLywPEMIG0CwEYP4SgPSe6VKzQ0gc6TghnP61zNSw6Z
         zWqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752393963; x=1752998763;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=te4MJTBpVgJuhtRjxJH2s+xCNlwZ781R0MdiUCdRknI=;
        b=p/Kht8RByUx9VVMkF9PvjfMFygF5ww9740xUMgarQI5vcu33F4562p+4c3AsmRHOP/
         RGvn9pDd+9llqfQUUjbUnILGZN2CVGdbD/phDgOw1FKAsWRu0fslivY33ZFE+xfuUlri
         6LCmKsnwyclZdyIgLXiby4zbVyB8OCkrMdx6qbThIMGilqKdx75ICgDHbc1+Xn+2EwXz
         PttWD2pZNiykcdO2b63nNqh5VHVigR0Fwr7zeMiZ6SZPc7iteIrN50sR2ebsPR45I7iU
         L6lXhYJWflCpB6LY4QV/TcvZ4Q075Fpjc6PiePARDoa00RzlbHQOLZL8eOZxm/55i/E/
         TZfg==
X-Forwarded-Encrypted: i=1; AJvYcCVoqAcTtTPJsY/VwGCOAW+WWXM/rJa1Eum3UXrdz7/mdob16cw0VTLCUd7yWLFGHScW1PAfiwJZzw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzF8M7jhANFZv6EDkTAutb1gsfaFCpmZsZAzXMA7vqPifd9Ggid
	58YQT+fYEJRPMKlreA+hsgXFiVlxdhaQ1gk5MZp1d1CZL3qWAhCpDtqWsk/QCNTSRpc=
X-Gm-Gg: ASbGncvH1naIQEuoSpeF+NQP9saYrnm0HElb4oBWAosG7qWz58uQsG/jwV60m99Geay
	3/k69akEMdtjKRoU73H4Dfl0nYYnV0Stt7+VVoiL7JispinMAepidWuqr9Jprm2tw04iHfEoVV6
	B1x3JeXxHDVHxoFoAkHNLJyfrwy87sDuY6NGZqtWP4ZusibG+75FdCU9BlL2exefTRhxMxrGa1D
	+jtpYYmqVq6RiStWvzDAKz6dLCPlm36+5844BqJjp9k9AdNxQRUUheXPTHfSYXgtF/MyKgdzNW2
	HhoLuCHouY7Sv4P8uWaKSmHjfuifg9J8BvkpmU2R21XrehKxm/jPIpNaj6IfZtX1u7sh6lVRhSO
	WSKxCuaX5QpLEItj270cmO49OBRQ0S4aXZRa09Yau1Xb2fDo=
X-Google-Smtp-Source: AGHT+IG58Q0+c/JdRpYP9OwThz11aodR+FjCZWHpjNmU/o1HqomzxkC9Hl2w1xFzYfqgnbsp0pIfUg==
X-Received: by 2002:a5d:5f41:0:b0:3aa:c9a8:a387 with SMTP id ffacd0b85a97d-3b5f181bf12mr8730107f8f.0.1752393963493;
        Sun, 13 Jul 2025 01:06:03 -0700 (PDT)
Received: from [192.168.224.50] ([213.208.155.167])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc22a8sm9386608f8f.34.2025.07.13.01.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 01:06:03 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Sun, 13 Jul 2025 10:05:23 +0200
Subject: [PATCH v2 01/15] dt-bindings: arm-smmu: document the support on
 Milos
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250713-sm7635-fp6-initial-v2-1-e8f9a789505b@fairphone.com>
References: <20250713-sm7635-fp6-initial-v2-0-e8f9a789505b@fairphone.com>
In-Reply-To: <20250713-sm7635-fp6-initial-v2-0-e8f9a789505b@fairphone.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>, Vinod Koul <vkoul@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Robert Marko <robimarko@gmail.com>, 
 Das Srinagesh <quic_gurus@quicinc.com>, 
 Thomas Gleixner <tglx@linutronix.de>, Jassi Brar <jassisinghbrar@gmail.com>, 
 Amit Kucheria <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org, 
 linux-mmc@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752393945; l=1456;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=VI60lC4ZmfORZyuxHBRWFEsQsFQCradJNwP6TkMJAbg=;
 b=ysFcsREoBvX5mgay6H6zBC7kn964wfsE1peB4S1deXzOSQgOF/awLFfvR6VFGhwUAq6oh+c+L
 jGE9XkkTsEYCtwhnmfdvMrCBbHaWxNcEmIJjlZVGZSlmOWt5qi/15fU
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Add compatible for smmu representing support on the Milos SoC.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 7b9d5507d6ccd6b845a57eeae59fe80ba75cc652..66d5a5ff78fa5dbb86db72db754c23b8cc8f188a 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -35,6 +35,7 @@ properties:
       - description: Qcom SoCs implementing "qcom,smmu-500" and "arm,mmu-500"
         items:
           - enum:
+              - qcom,milos-smmu-500
               - qcom,qcm2290-smmu-500
               - qcom,qcs615-smmu-500
               - qcom,qcs8300-smmu-500
@@ -88,6 +89,7 @@ properties:
       - description: Qcom Adreno GPUs implementing "qcom,smmu-500" and "arm,mmu-500"
         items:
           - enum:
+              - qcom,milos-smmu-500
               - qcom,qcm2290-smmu-500
               - qcom,qcs615-smmu-500
               - qcom,qcs8300-smmu-500
@@ -534,6 +536,7 @@ allOf:
         compatible:
           items:
             - enum:
+                - qcom,milos-smmu-500
                 - qcom,sar2130p-smmu-500
                 - qcom,sm8550-smmu-500
                 - qcom,sm8650-smmu-500

-- 
2.50.1



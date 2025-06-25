Return-Path: <linux-pm+bounces-29474-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6679FAE7CF6
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 11:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A58E3BC0CA
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 09:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF482DFA4E;
	Wed, 25 Jun 2025 09:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="GZgjw9su"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4F12DECD8
	for <linux-pm@vger.kernel.org>; Wed, 25 Jun 2025 09:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750843394; cv=none; b=L7S5FRdwnzHS7ftM0s8sMEVOiK0z01S5LICXAeCq8C9A31V9sc5v0u7s9STtA4tH1RStefo6oalzlXEt3aeL7MZ1Q42UVPakT2uMyJ1WRleBaHmyMz/ECdPZz0bVlxlymp95nkhpv0lX+PByTU94LsRxLeE+WFRs7sb0E5sPDyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750843394; c=relaxed/simple;
	bh=eQWT5rynZ1PMaMurlFu0xtL6k2P+7npo9dOzB+6rBOg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C8DeVJQQCvi0/H6RLxGdmFNOU/4k7SAqE2o2UIjweW3bdzwU5IZ+GyAyE971x6IxGHcFsnGWnexs2o+HZ2Mplktnya/NqCXcxwBFiOhySw1zWlEC6eS7FLiL16BKXOyiICBCZwUzNAQ0h+etLB+N7sevCNmdtMeN0FOSJ6ApBFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=GZgjw9su; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-60bfcada295so3751849a12.1
        for <linux-pm@vger.kernel.org>; Wed, 25 Jun 2025 02:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1750843389; x=1751448189; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DgqZI7oI1+Rtsh8AHih668v9LL7u8KNYlhdavj5r3Pw=;
        b=GZgjw9suSVLTabJ9F7qRKHA0qOqRKhuHZpCQPymMtDT7WRYpM3iqp314KdtrHhMcen
         VU0V1meOabxlhUQmEeaeqiYab9ecYmepVQ3+4O5qxoFhi5WTBsI8qdCEYnAbrH1M6kFk
         8Rw/sf2aeq5vW8n9CJkdaGv+fjizW/nC9iE75Fgh/nMyyhg1bdW7UKeWW8RGBS0b+aex
         NTXvqFfDcKl2UvCB6U0Oi9q4Gs0e4b4yPA42uS7dCwXJ8q3g4NPcuHykXz11dIwEGQ+V
         uNtwDDdiN8TwdCktMdgtKz9Sy+raWkEpjrlckVY7Etq3miO4NIGOORO07lkLUBc+7uwO
         Kq5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750843389; x=1751448189;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DgqZI7oI1+Rtsh8AHih668v9LL7u8KNYlhdavj5r3Pw=;
        b=GUpuze5F/3T1R1huYmvq2urvdhr8OXnErQogeGS+P2UEeo1okIDEULLeWiHMR7ZUbY
         D3pJ54FC1ZSKQT25dZJl3190bEOl5Di5vnDaFnCl6zF2EkkX8WLL3NacvdtWq8pbBW5M
         s7q5JWD45ArwXYdsJwNLQGEoVWY0rXMPwfo6b5bWdb7BnTtDPOdh8N+xQT+KUvAlP4fC
         ZD6/OdNy9XmlHaHZQbF5bo4yCqCMQcAmW1pwv+bmly8NItyTBYmP391vZ7GiKAyO/RaU
         SCAVHCcFIQUKmKluQUZoWMF5sSauq/Nn6XjQ6mnTO8i3NBKnGw6+IMc5EjGFETWZYlzM
         gEDQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5TaBuzNOKjcVLaMvwGB0Vvra/O3BmlPxOEgeQ59HPMa1k5ZrfSEIsMb6ANADGTZ24gZgPM7aCLw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyAu65HmbkWdu6RnXXgA2bFyjwYBwfNyGwyupPLc+1oVDhZyP8q
	ouUuZyOluTPU1Ac6fR+8JZO5GR/H0ExWLQMLDYUFWu1us9JpxWdbOg3GJgZ5qw2FgUg=
X-Gm-Gg: ASbGnctQyfFxw8aL9dT6IIT8R7H7bkeLvPeoh2z3xRv4Hg0iGHQ0d0l6WLYCrd2Lbwt
	tN2cLW1NKJxmaxRS+ipjO3GP6kWBdRotJLBbebZKajyfR/cANP9PLlFf1uhxgKlFdH/htPmmF+V
	FCpentZn7mAxqOQImRv8DVL7Irdqokg5EKu3sLlwWJ22277qcI4WQzVG29xg/2BAsmIYgySnq4b
	EozCW5gvGLqCNDoKGBcO74aYdnqAi9B7xEx6MUge3i8OUDyIqYAU2Q/Jsby/zybrUlcGu7XLWQK
	jlo6+N89WkmHPhCD0p46C5B4vl540Z0TlAlIwPVCnaeitRAOpIQS0ArQxq296wJskaNsuYgCsEx
	QmnIhTqCVDFgrFQu8s5AJWV5sEbpuqrya
X-Google-Smtp-Source: AGHT+IEbu2f/7cXyJsOb3QqXP0wh8TgrbA5ZDl76nci0eiAzw3s+R0MtL3pVIqORzpzq/cBkmMRAoQ==
X-Received: by 2002:a17:907:6088:b0:ae0:a597:2959 with SMTP id a640c23a62f3a-ae0bed8e8acmr247450866b.32.1750843389413;
        Wed, 25 Jun 2025 02:23:09 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0aaa0a854sm270277766b.68.2025.06.25.02.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 02:23:09 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 25 Jun 2025 11:22:56 +0200
Subject: [PATCH 01/14] dt-bindings: arm-smmu: document the support on
 SM7635
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-sm7635-fp6-initial-v1-1-d9cd322eac1b@fairphone.com>
References: <20250625-sm7635-fp6-initial-v1-0-d9cd322eac1b@fairphone.com>
In-Reply-To: <20250625-sm7635-fp6-initial-v1-0-d9cd322eac1b@fairphone.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750843387; l=1465;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=eQWT5rynZ1PMaMurlFu0xtL6k2P+7npo9dOzB+6rBOg=;
 b=gDsmUgdZBFiEdwrYEbZ8pi64XslJKaJrZmQirkFpqMll05JV6aPCYeaepteR65EJtYCQZk9aa
 7x2FpL//Q9vClR/bmMVFhIADOJuoW9AUJVzbXxYdMo+K4lm7WiiCaKO
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Add compatible for smmu representing support on SM7635.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 7b9d5507d6ccd6b845a57eeae59fe80ba75cc652..8545dd8e886b265caa333188c031f19a44d7fa6b 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -55,6 +55,7 @@ properties:
               - qcom,sm6125-smmu-500
               - qcom,sm6350-smmu-500
               - qcom,sm6375-smmu-500
+              - qcom,sm7635-smmu-500
               - qcom,sm8150-smmu-500
               - qcom,sm8250-smmu-500
               - qcom,sm8350-smmu-500
@@ -99,6 +100,7 @@ properties:
               - qcom,sc8280xp-smmu-500
               - qcom,sm6115-smmu-500
               - qcom,sm6125-smmu-500
+              - qcom,sm7635-smmu-500
               - qcom,sm8150-smmu-500
               - qcom,sm8250-smmu-500
               - qcom,sm8350-smmu-500
@@ -535,6 +537,7 @@ allOf:
           items:
             - enum:
                 - qcom,sar2130p-smmu-500
+                - qcom,sm7635-smmu-500
                 - qcom,sm8550-smmu-500
                 - qcom,sm8650-smmu-500
                 - qcom,x1e80100-smmu-500

-- 
2.50.0



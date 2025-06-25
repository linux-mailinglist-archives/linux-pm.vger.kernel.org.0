Return-Path: <linux-pm+bounces-29481-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7CD1AE7D42
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 11:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D31831BC4B56
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 09:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9EF2F1993;
	Wed, 25 Jun 2025 09:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="HYD4IESh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21ED2BDC06
	for <linux-pm@vger.kernel.org>; Wed, 25 Jun 2025 09:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750843405; cv=none; b=EPUk1DOgk0yTcAN4fsHYeNwHMSsKOkL+2xzXUcm/7zEiV7IeeB5ij75V3xful8mPlZSh8Km7y+9nc7zNhj4TF9SBLQSkSHqx+nn5mYjtQQ1k/n7TKWSUTg7B0j5F6znkEcx5jrdgm82WBCKCtUzvJiFPm28vh/QYHXvtN4C6Jc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750843405; c=relaxed/simple;
	bh=QF6zOzPisaNRx6UkDEnfUjzHboUeRh3pRf3riJuZ07g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UY/nkpEiWM7e1JOA8dpWK+OG68hFGRtjdhJhqFwk7onH+v5dPTPiM0H252VYvqY6uto8H2S05aZdrSVVs1A+3npI01FILhVt6gowrQLWZ5ehH/vIF+XQwCqG/8FR8V0h5HPDMspyepsfChifNR/AlchAlCM0o2XkREH1QuGoGB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=HYD4IESh; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ad883afdf0cso258092666b.0
        for <linux-pm@vger.kernel.org>; Wed, 25 Jun 2025 02:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1750843397; x=1751448197; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TKX5DuiO7AzJ1dwZVvAVxWI3Xdt99v9P0wOhJICwjbk=;
        b=HYD4IEShHoQpvDNTs152PK6mR+CeuIQtSDtKwG3rH4iRxgf94me2R5Bpgc32eCob89
         oCw13RiGt/cemoVe9GbZcquzjkPsBjf5Oz4VjFPsYiFY1PoIL5pkNgqaKNtZG06+4yXP
         dtqTmpWZY1jIa/Y1Q2mNZP4aySEDx8gS5+Y1/oLPm+YhL5IHyxVojqCA5tSF7CP9vlNC
         upBJWgRdptSLEvO00MytS05ZFyDkRBVMkn/REbqSCghJpimjo/v0SacoythuwpuVTck4
         QIe8Pg7wIMDRTHDxb4g2sE3cU0H0WncYO6/No6tPyq3jLHwn2epx61gvH1pJmXXQZbjR
         hdJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750843397; x=1751448197;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TKX5DuiO7AzJ1dwZVvAVxWI3Xdt99v9P0wOhJICwjbk=;
        b=FBT/LKlUjLNviw0qEci78BPOtMU6geimc7RwR1W6VpbYoLOltBLViGAjnBVv0R908c
         B5PSr6byKPfrlD61FDP9/a2PTOCQDkeHz8pHGbZQBNVlbw2g/saw57xUzyYzeZ/NsBTh
         VI79FlKGiARVydZJ1aBtv7Xm9JPrkzfTcDqnkWFiDdbiNMfkO9XfrbyBC4T46Btuxuzc
         SyOAMj2uhgejzcKR3a/ftHAwUz6o4dlwU24CKxEAuYkl4iC5oDO17EGRIdTydcwQ2mgn
         /WUh0MjoXyvrEps+RnXW6lO3kPmWJmN/OdmRi6nBh+M746wrMmrtBfODl57uXxGUzgv9
         JuRA==
X-Forwarded-Encrypted: i=1; AJvYcCUCF816y7zo/zbjqJudYmk7p0LICqyD5p4S1LtG4K3eQF8qF5XzKhcPHUKULOhChhJusc7snzfIOg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzd6ldX/mfi5AWdockZ3vd65BP218VlJcpAYyS3SmlG19o1aEh
	iIMtNWR9H7ksB4vilNLbKDwRZ3ZPM33wcmlY3vKzSu7IDARrsI1W8lLQazVVyCSRdv4=
X-Gm-Gg: ASbGncscSpCbNnOLdrg7bDdLoNfR7C+3ZxGuivcxq8999LRDlaGknfwQzfPFnZbODUp
	mQg4piIzaOrpiz1Fqd6UWLhpL3w+uw5CUsucKi/i1lSD6bgxGZA0Shr1qbcbA69hovrXK+GIebR
	8J+LFJZFnDpCKHS8OTDCSyUkCWS3auCNIxyJ+NDAnkTL95Fx8rkDPbVOpqEhlwo4pCjCV5UxGUe
	DefCX9oGE92NAC+BpDwslQBcrQOLDDV9pYPSABcqUAPwjQ+njz+VUm0EqyvcyeqsRTpVAqr3fxt
	icycjPEVOVXcmyk9NEpuEEg4nDE8z7+YDAJeQGI3utwIywDW575aBLbpwNW01jmwXTcN1Prok1k
	RnJsiqhcrWP8zT+8dHV2fnZE3DJodFGY+u69iT5gzJU0=
X-Google-Smtp-Source: AGHT+IGiDFBoDucTPjUqqaMImeHSSI/9lZCbdCTgquH7Z0S3KEgQQwP7r3gJyT916kpPzaeBdGItbw==
X-Received: by 2002:a17:907:9808:b0:ae0:bf55:5c48 with SMTP id a640c23a62f3a-ae0bf55634bmr217592466b.7.1750843396185;
        Wed, 25 Jun 2025 02:23:16 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0aaa0a854sm270277766b.68.2025.06.25.02.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 02:23:15 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 25 Jun 2025 11:23:03 +0200
Subject: [PATCH 08/14] dt-bindings: thermal: qcom-tsens: document the
 SM7635 Temperature Sensor
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-sm7635-fp6-initial-v1-8-d9cd322eac1b@fairphone.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750843387; l=884;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=QF6zOzPisaNRx6UkDEnfUjzHboUeRh3pRf3riJuZ07g=;
 b=u4p3k6p/2j42YHb4XwcyOL+Rq/CqQjib4+cSu01z968A3xXWkhEPGtNDUd9b2G12MuzVho+Uv
 4c01+k5CLJPAHJpvg+Bz4qlPQ4Hme44CNKKgFxwQ8y5DARbiLPoZmDF
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Document the Temperature Sensor (TSENS) on the SM7635 Platform.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index 0e653bbe9884953b58c4d8569b8d096db47fd54f..76b3d4ab5a793a9bd675e52a348ca2d62077cf58 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -65,6 +65,7 @@ properties:
               - qcom,sm6115-tsens
               - qcom,sm6350-tsens
               - qcom,sm6375-tsens
+              - qcom,sm7635-tsens
               - qcom,sm8150-tsens
               - qcom,sm8250-tsens
               - qcom,sm8350-tsens

-- 
2.50.0



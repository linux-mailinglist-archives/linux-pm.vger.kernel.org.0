Return-Path: <linux-pm+bounces-33967-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5BFFB454ED
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 12:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 813F53BF4D2
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 10:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F2A307481;
	Fri,  5 Sep 2025 10:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="ZcwfmPxg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5542301484
	for <linux-pm@vger.kernel.org>; Fri,  5 Sep 2025 10:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757068866; cv=none; b=R5BbjZCP8tj9QbbeL844iCPfQQxDAc15gQ+1XyctrYT8nhdj5YSbkofiqGSf1t6RTTBUnoRD7yhgcXMd4hQM1pl0cKQlpcdWz2f2pn+3HFJBdzsZIm7hq7s/e/hYuwpMqd3YJujQ+Z0+Hm+iAG9tEYZrI3pH0Psp0/tO/cRzla4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757068866; c=relaxed/simple;
	bh=UimigBuUtMxs7F8gG6umklkndUZUFsafBa5o33+qqu4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dkS/PM0AkjZfyLmjpfA/ueUKk+btC9DMyZL9Lp1mb7rv7mGPWkWeimDCzdePneqpIJ6HhZdfeM+vxcp8JHATaBWP+ZyIym0wWH5OyZfamNlCjoEYA3SqhoPKYTKe6yTNxg0jB6nphucxZ1s7RS8BDpPSs0ryZLak+VyGz5SRl1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=ZcwfmPxg; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3df3be0e098so1078443f8f.1
        for <linux-pm@vger.kernel.org>; Fri, 05 Sep 2025 03:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1757068862; x=1757673662; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4h7YaMzyJCzszrOQdboJaFyzXH8sFl3aopVTcpiY4P0=;
        b=ZcwfmPxg1kS7c4snlPFJGd3LpftrF0U4jOpMYyjkvXjXUhoB7GO4x7mwEedpHIGaac
         FcjWCBH80WKu9FwZ+ucf4GqwMtp5K++vVKguT8RLEaE5lrcY02Xmq/Bh7eS6yUM2t4Vc
         8aI+x+wV+lQZr8Nh1JBC60cITCIdfri5tpxAncb8erHY0IrYQAM33WlTwd9GzZPU4LPJ
         oM/n+gmfXBQNn/+7lOPnrvXOuU/a9ynpC8ZHeXOAD+HS5PMiLr9X0bVa+K+U/jCrBd2r
         Gh0j+uZCPbHi0gPt2zOuFVFPfECUufWbLy6lDfshjqzeUMlZLQu37VW7yUA4KC9AD4du
         MEwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757068862; x=1757673662;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4h7YaMzyJCzszrOQdboJaFyzXH8sFl3aopVTcpiY4P0=;
        b=p8TnpVBX2Qvd0Ptcm+/jBQf9GqYFVRbhLdDV/RwGw0Hyg5vuFakvYkYMBXLbnm+vAt
         LC2j3MSX2LoKqSNKImdaVEA0e3wKIvTFuu/3+bD6BXJ9/Q4BCLlJQYWjZJ9z+CPephe8
         SeSboFDH0oViReC+Lpf2ugYmzW797xMIE2HfeN9gbXxLk7HmIFkS/oYcqqd+hspG1eAN
         uroT2bw0tWGZAq0RKqDGpjP9xn9GEt7SATL//vAwnc4B83gkyGZP+eXFIEprP/fqbmzu
         j6J9zcw9s9kQRoQnPcc0iCGcKtkdHyTfSWPoXrXxzhvbjZ80S+MYntRuesmk4qLsXFOI
         pYpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYHheCsg+VCCwqJnLqy99yvlhtHtUfLm+OIwc+ZysDUpIR4V/acVGwwl7isyBfnHP3mmp4E2WMIA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzBG0oJe7daDMdXIF53vWJUFXsr1UTT5ijoWit1eUPEY2KNEJDN
	pJMr0JXfxqFLFriYvkRLtM/8APZSrdpA7y1/QcPy5GW3oPxBKP4UMZ8dhsXr8F7hJv8=
X-Gm-Gg: ASbGncui8QivbftNzB5F42ATf4qTLtumN2vjHv3w+H6fDI7U4ObUj8uF2BoCkNXOppV
	y2kDADWC24m1se37zKYog0gyfiXS+9PqZnCZGlO5NGcnIqg4xorQDVnHHrI8gbwNPfk0Lw8TH4B
	EjHb/reaFgRXHMh8AHmvh1I/ULwBd8Q1hghIBDOVRa2tdPs0Vzl+r9sWpMogpoUL5Y5nZfPdeje
	RfnZOU5wzp6JE3t2zJ3Hk53Bdv2K3Z88fvCw6coda2Cyr08Ro6NlrCmfOa7q+dzGNbFyohe96Wz
	NkbWJb96kXvJPbuGs1KkGzjLQ4zhTk+31TDWIrvOUZR51xOpZsuaRLtZqZ+b1vCCSwQF71U1ZsZ
	Z2rT9cgnL1BIJMWa53cfPOjvLM8s9aLT3IqYrM27t4M+z6A71KL5MTtO/vo3aIqNdBJyYd6XPfK
	Bti4u1aRVQOJiWMsE/kCxPQDoMQINOow==
X-Google-Smtp-Source: AGHT+IGtbARUvUaTJ4NIeSDeweSSytYiW6yHSoPrHxfTOVtady6hveXqNdHAZNNKJxa9x3TrxVsf3A==
X-Received: by 2002:a05:6000:24c7:b0:3e0:152a:87b6 with SMTP id ffacd0b85a97d-3e0152a8a00mr6371616f8f.25.1757068862097;
        Fri, 05 Sep 2025 03:41:02 -0700 (PDT)
Received: from [172.18.170.139] (ip-185-104-138-158.ptr.icomera.net. [185.104.138.158])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d6cf485eb7sm20990738f8f.3.2025.09.05.03.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 03:41:01 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 05 Sep 2025 12:40:32 +0200
Subject: [PATCH v3 1/7] dt-bindings: cpufreq: qcom-hw: document Milos
 CPUFREQ Hardware
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250905-sm7635-fp6-initial-v3-1-0117c2eff1b7@fairphone.com>
References: <20250905-sm7635-fp6-initial-v3-0-0117c2eff1b7@fairphone.com>
In-Reply-To: <20250905-sm7635-fp6-initial-v3-0-0117c2eff1b7@fairphone.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>, Vinod Koul <vkoul@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-crypto@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757068857; l=1212;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=UimigBuUtMxs7F8gG6umklkndUZUFsafBa5o33+qqu4=;
 b=DY1pFCOuq1avbn5t7ZPvcE56wWF7XIf1yrr3163XBBi/yD3M7RGi5JrUxggImZlz8IomMu7gf
 B9cbK5HaeebCOw3btr4WhZILE7SRIK7H7piwrfjlehWfycKYwf+7HoW
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Document the CPUFREQ Hardware on the Milos SoC.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
index 2d42fc3d8ef811368c990977173f41b26535e0c8..22eeaef14f557d615b06ec13e71daf86018fcdc9 100644
--- a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
@@ -35,6 +35,7 @@ properties:
       - description: v2 of CPUFREQ HW (EPSS)
         items:
           - enum:
+              - qcom,milos-cpufreq-epss
               - qcom,qcs8300-cpufreq-epss
               - qcom,qdu1000-cpufreq-epss
               - qcom,sa8255p-cpufreq-epss
@@ -169,6 +170,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,milos-cpufreq-epss
               - qcom,qcs8300-cpufreq-epss
               - qcom,sc7280-cpufreq-epss
               - qcom,sm8250-cpufreq-epss

-- 
2.51.0



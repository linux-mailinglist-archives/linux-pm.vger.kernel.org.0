Return-Path: <linux-pm+bounces-30740-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A9EB02F66
	for <lists+linux-pm@lfdr.de>; Sun, 13 Jul 2025 10:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C39F1A6014E
	for <lists+linux-pm@lfdr.de>; Sun, 13 Jul 2025 08:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8BF1F4612;
	Sun, 13 Jul 2025 08:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="dNQVvhcd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEF41E5714
	for <linux-pm@vger.kernel.org>; Sun, 13 Jul 2025 08:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752393977; cv=none; b=K1mlM8KXOmf2Go3tyMXZpQIXyy2DgehsGlpPShD/MOVjKj9Te3djdSBDOvhF4CHOXCEdu/BpHw+FrhHAYcC3L9dZ2cWVWdfM1Fnc+FnWe9q5EujLBqAMGELsZcDNMQFDo0rcpHYyjLBeJV7EYRrsjZu6+fJyMs+ET7D0tIF+hxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752393977; c=relaxed/simple;
	bh=nbSwp5ROysMSTLKLxq6Pg7q3VCWJ3MFGpodgkXirdrk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZRHAWFmigfgkyHRagwNa5dRYmIPuckBziCuqwz9+c8EvTfqQux9LA0jDrUBhzarg6jdGKCsTvJkklNlCZANxfVW1ItQYrDt+yq453Ceqoqw1dLa2YvBMwjrnCjIHyY/blwkPI+aGdv+IFmnLvLWMxpRTMlkzDL9pXjvhUrEdKj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=dNQVvhcd; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a548a73ff2so2929762f8f.0
        for <linux-pm@vger.kernel.org>; Sun, 13 Jul 2025 01:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1752393973; x=1752998773; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qjkVBqGocvldr3+5pDfPNG/mAD5wl5azsqsATuuDVzU=;
        b=dNQVvhcdTYxNi3jJkFCbONfvWJSR48ZWbzFhlfnHutB0yhV4nnuzWie5e9/sSx5gO4
         yRG98lDnyRgOVGpWyF49y0eafQ8YTyw8E40wm9stpMKN8weoLvkpKXqpFz7H8Oazydx2
         DYFaBGHuk+Vr71FCru6Zp0xdhW38gA9jxQT2j/Frer0BceEoAhMs+GWZEcOyWLsHLUfJ
         4dpCPhiTvE8JS7IsNDu6rEkJc3INlzYLHte04NsgINqP4pYa1y5yZkC1q1UZS7ctiLEb
         efbK1ULXRMtX1b5pnvZLqv3tArnOhhIVhxUSFkvUFfZdGPrZ6cAZ7wlA6eimmirKibc5
         ZDsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752393973; x=1752998773;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qjkVBqGocvldr3+5pDfPNG/mAD5wl5azsqsATuuDVzU=;
        b=s+71dTgLB09NVf6BBDaBYAJb5Uq6vc0IGk3IHiVd8XUMmgRAlR3p+lQFiy6kcQdRsX
         RjUqlsvJgahnBVW/qWA76OSmja2YlsiQxnKj9/Yk8iQj2H/npuAkD40cYwhPlNaH4lmM
         ngZDR92qumWPU8y8lTuo+F7HdW/IKCn/BYARn58l8g9m/s42RhlOgg6PtruTUUhRD2uT
         9LMoHnx6PER1mXo3kajBDxJ0n1hUFEop5hOmANJugWQ/9lBNMslTU2KeMCYc89xDsEB9
         0f6/G1mXCldX1ywl7uB8eQORyRgSyedSLMUhI5mb83/foeZiC+Bxu3R0eLsM6fApGKBP
         Myug==
X-Forwarded-Encrypted: i=1; AJvYcCU6XWQX4c5oN6XrnduyzJ6StC6dgLyfGEU6HKJNxPAwAIwP1TXRUqYY0OZOP/oktFJYAonNyAsSMg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzaLVicZNkYQB7PgkuHjdLrDFV8iFeUHQrkUzZ+lvQ3QhILZvHg
	CV0/vgiwh9f0Rm6fCG4BJL1J/XkB3vGbK4Ykja0LFIs5BfuFjtK+EhnXsX+p+BcMlRc=
X-Gm-Gg: ASbGncsi3qKRaRRSd83rXesRAntixxzivt6ZWr5uV2Mp5ylew9gbGihb8cjBAF1taeC
	K7F9PR78gQ28sBYBDONtlLBhMYghHJTHX8J3s3AwRqHKgL72SQqYRMavInVwl+EKq8I6QbsIh+Q
	+P3v8wN4RM7PxPRPTbK73CnqpCxmD4CdL8D4eNZtTYEla9F0cuClj80x12ymPqBDiWYY/8GygwN
	RcR6FCtRyleAST7r5F+xd4CfM0v7wOZRsbgSTpuUIXxX3kCxoDEaha9f6dy6RjXAcN481n3kRD9
	1sF2zTpQBNazlWR+oCGzZ3/M5Q4mBHvN8kB5tMDrALZoutVVeWlUm9FMMmCaFUljWBKkx7uIRwm
	kVRZxFdize38Fs+IKXBRUdBDePiNYDJldQPKd
X-Google-Smtp-Source: AGHT+IE7aiBW0y1UJWTkFw2jo19wh2kKOFls92CeELkcuzfmOFh/b4a0X3Mbc9B6RVDds+HgM7Z+rg==
X-Received: by 2002:a05:6000:4613:b0:3a5:2923:8006 with SMTP id ffacd0b85a97d-3b5f186ed15mr7662034f8f.25.1752393973014;
        Sun, 13 Jul 2025 01:06:13 -0700 (PDT)
Received: from [192.168.224.50] ([213.208.155.167])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc22a8sm9386608f8f.34.2025.07.13.01.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 01:06:12 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Sun, 13 Jul 2025 10:05:24 +0200
Subject: [PATCH v2 02/15] dt-bindings: cpufreq: qcom-hw: document Milos
 CPUFREQ Hardware
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250713-sm7635-fp6-initial-v2-2-e8f9a789505b@fairphone.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752393945; l=1165;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=nbSwp5ROysMSTLKLxq6Pg7q3VCWJ3MFGpodgkXirdrk=;
 b=URo7Ywj7eQLjWeGSKpTNmv79uc7iAPWio/PyLw17wxDECtuAiz2Bu3PfwHvwHO3pZ1RhCb5ag
 VyL+DFxfUJDDy0DR7snG/iq810fQKBhCUA6IIAt4osJpIsLJpCqxh/T
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Document the CPUFREQ Hardware on the Milos SoC.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
index e0242bed33420a39b8a8cff4229ba9eee994ca30..4fcadba87fbb90f960201aa0763f1a22c0f0f9b5 100644
--- a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
@@ -34,6 +34,7 @@ properties:
       - description: v2 of CPUFREQ HW (EPSS)
         items:
           - enum:
+              - qcom,milos-cpufreq-epss
               - qcom,qcs8300-cpufreq-epss
               - qcom,qdu1000-cpufreq-epss
               - qcom,sa8255p-cpufreq-epss
@@ -167,6 +168,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,milos-cpufreq-epss
               - qcom,qcs8300-cpufreq-epss
               - qcom,sc7280-cpufreq-epss
               - qcom,sm8250-cpufreq-epss

-- 
2.50.1



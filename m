Return-Path: <linux-pm+bounces-29485-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 082DDAE7D11
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 11:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F44B7A98C7
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 09:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456C92F2731;
	Wed, 25 Jun 2025 09:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="av86R8yv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9872DECDE
	for <linux-pm@vger.kernel.org>; Wed, 25 Jun 2025 09:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750843410; cv=none; b=XXLOkNpIDMSgjragCmTsZy5nn13HZbY7H0IqMH5kGvggJoOMEj2CIbG9ihTaAB/XBXWXQrCq+oQNeLz5QVbMyncT23HrZ2p+0jVyi6eaOfJP4gG+skXaSlMehj0P+cheDEPMqOy6syZuib2q/guev7iWJVkA1uO+eQcBYjWPJzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750843410; c=relaxed/simple;
	bh=lSbZQMNS3mZ2Qhlodk3BCi0I8+R0Xssr2JSReaIqHv4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mzGc4SylClUGn/qA2RkeW61686hKMWYOAEVHpLOXjkDypyNA9Skv7qQi26rPB8xAYejV/suAOECTdyuNngoVgq6kwykHcYfldxmo92cdv4is9It4homs2b/MeIYVThaHidPlKKr17bfDJir2s3trPECGSDApQqFcJC773NFuMVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=av86R8yv; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6084dfb4cd5so1235109a12.0
        for <linux-pm@vger.kernel.org>; Wed, 25 Jun 2025 02:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1750843402; x=1751448202; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nlprjCXzNhYiu8119hAJidFX3Tj0Nj5OLp/Tir9pgMI=;
        b=av86R8yvptx9KLSMo40dYEQvwzrpVi2kRrZRWjZll06aOluwXC4GhtmpEXJ8t7HOXe
         e7WRdcLfnfownve0Cx5nNRDtBrqHXjoitLVLGsfUoimndoT/jNzeuQKUa04WifDLHQci
         gXUjPHI0ti9vhSmsEf1ucIP/RhKEuEM86LzzteYzSSpi+KmvohRj/0ncyUA2CJIxO7hk
         +EyhA11QwI88xrt+YFKWvRxQarPKFf4olPe/dIldn2eyOZpuFmCqIYH182bMQGRuWDrR
         mXu5hyGsMy97k8aK1+cNjVMCUuSImAqxUzvkknlLYBr4v6IUjBmfioh42UvqjKzN7Tjn
         4psw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750843402; x=1751448202;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nlprjCXzNhYiu8119hAJidFX3Tj0Nj5OLp/Tir9pgMI=;
        b=gzlPkvUIwvW9JdNGuaJCegFBznCUa/4jrfKcC+Ef5A6J+u0LNtJlr56gLxZREOwuNx
         i84dqh5/nRgXiXUSGkJIBBc8PqV32oQpbIf8oko9LxpMQozBR3Ak0VofGBMTWteFIFrl
         xisfMHuW0xNh5mNl91Fa0Q0Sat5cXpVyMXbIsIAuCc/iyhzzNsvt9ryWffO6fYIxjKG8
         7cd8AF/kyu80U6bODrPZmo/Mkk84iyqnaRh7tYca74Y+K1skqZhfD5Ebd865mww4WE0O
         vSbyxWQZsGGgEHLz0QNA/BTXynVwiJVbpEy5PjN8deDApk5dh/MKM8BCcBs5yIgIMGEy
         1wxA==
X-Forwarded-Encrypted: i=1; AJvYcCVeo02EqUe82xYp+LXmqy5pcP/diEeXrUoecpSLvqqXQOg99I14D05JKhp7KnrG/RUrSZHhyOG9mg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn4gy4gbrXA1ku+6G26hT1vsPHuUBCyYBfOJoN6PtfGrTRm0E/
	x2Y18dLP6bQymX9i24k8517lwegJAHLKkGsMXAORQcmYYLLv/nvt+Ljdwj1jL6IbZuA=
X-Gm-Gg: ASbGncsw5vGXBxizgVz+lnFoVLCHeiy1WRW21snFyH4HuMEotrx7yTSSda1Onqnnap+
	Jdf1xUU9+ojnENMsJ8nZxK0xbnHE/ktIgWNCJ8weTIvF04jJOEFC/yy+SHdFz+/io+zDjBxbQl4
	F7rPOn0gf71T+8h4McRuhUtSUOxqVBWT2+F7CxcUv8xLjiSZkrUMdVpPINKJamKTBYPtstHvIiF
	NhqixlI5+MQYcIEzPdhjgzptplEXOiTj6or5vj+bk06z8tnStm41hIoiUaImuMFxIjnu6TRSeFn
	K+9G81RElndbm2r/Aa32QagadG3dl9a0VzAaCUOrLIvJ7eLATgLRRJM4yWtU0WZ39VAOCoxosgG
	VILPBRepgoCziHZ4EGn3hQNqNb2ztuQPt
X-Google-Smtp-Source: AGHT+IFMjj0Y3e5vRaQHZvxh7fHnevj/9XdkbDfc1cM5LOi08SBv192uCl1KLf+bmxAA3PmbEJU5qQ==
X-Received: by 2002:a17:907:608e:b0:ad8:91e4:a92b with SMTP id a640c23a62f3a-ae0c08724d9mr179615566b.30.1750843401578;
        Wed, 25 Jun 2025 02:23:21 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0aaa0a854sm270277766b.68.2025.06.25.02.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 02:23:21 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 25 Jun 2025 11:23:07 +0200
Subject: [PATCH 12/14] dt-bindings: arm: qcom: Add SM7635 and The Fairphone
 (Gen. 6)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-sm7635-fp6-initial-v1-12-d9cd322eac1b@fairphone.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750843387; l=996;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=lSbZQMNS3mZ2Qhlodk3BCi0I8+R0Xssr2JSReaIqHv4=;
 b=yilPxLb4+1BOE1rCFDSywXfKUexVB1szD3ZMpoPtxgrPy4d6BGvUtVW9enhV9rLTafFlsiUdc
 CU20Ge/ADStBELDiO8FCnFwU5QmqC34bwJqV2yiobXy45sPeekuAPH0
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Document the SM7635-based The Fairphone (Gen. 6) smartphone.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 56f78f0f3803fedcb6422efd6adec3bbc81c2e03..bb89f81437d4ae12ac9fa447377d6b48e3bfa581 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -93,6 +93,7 @@ description: |
         sm7150
         sm7225
         sm7325
+        sm7635
         sm8150
         sm8250
         sm8350
@@ -1056,6 +1057,11 @@ properties:
               - nothing,spacewar
           - const: qcom,sm7325
 
+      - items:
+          - enum:
+              - fairphone,fp6
+          - const: qcom,sm7635
+
       - items:
           - enum:
               - microsoft,surface-duo

-- 
2.50.0



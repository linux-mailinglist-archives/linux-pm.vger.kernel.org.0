Return-Path: <linux-pm+bounces-29476-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2F1AE7D2C
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 11:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0E87189383A
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 09:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7182E11C0;
	Wed, 25 Jun 2025 09:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="zHQ7NemL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A96A2DFA47
	for <linux-pm@vger.kernel.org>; Wed, 25 Jun 2025 09:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750843397; cv=none; b=IQpxXbyJEK2fdDMcpHTsS3y7v5fa4/KP+X6olrolKiEUb2lh3+3ggzg/XZcIvvSowZb2Y/E2zfVnaZGHa5TSGARkGBM/nvMtBc5tfSq3xvCuBhOlyqO01iLuHJORTHbh3VN0eMNjy7Q7bgva8r3XcIhPomlKFw4F+TJnk0hdonA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750843397; c=relaxed/simple;
	bh=ARurSlf9cAaTHf8riWzBxjObIWFoiMC+3sc1W+uG3PE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aEH7muMBJdqexg78BLE93BmjiRLLJUZFdvQ8QJyH7Gmke5DKZr4hdR3ruQQ8XX+Hmlr0m+DP1Ssa9lqw8i9RipdyDDB/bSVmYn5W5I6jzIxtyaTZPxkGVoo9v3yftpqEO7UDURI0YFd3aRhOTl6larmZog5RkRCgVW0RUTaopD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=zHQ7NemL; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ae04d3d63e6so844082166b.2
        for <linux-pm@vger.kernel.org>; Wed, 25 Jun 2025 02:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1750843391; x=1751448191; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vRCR5w6mxJl9kOE01aENY7pdoYD3D3UcZSaG9WSr1E8=;
        b=zHQ7NemLGprK16IYwX4KDdsaSR1xoql0BkQUEhOLjEFNqiJH2ehH9NJlelatqKtuqc
         n6KsdMZTxbi2WG6p/NkpmYRBGlHZGRGxndfK+FJJDi2YtRYYSN0Agh7xpu907WUWrmKc
         r6UC1flFHILWAmczFc2zDniHpQnw62H7mbVXqMsyA0AO59PElkOtND66Mk1ler8MPaM2
         PyLKFqe+zdo2guN+xISaaNupg8eFbhUzYnTC3rEd/ain5ys57ei5eYb3jwu2B+TIfj4N
         Df8mymFd/f+1u/BpYY3RgGyGNW29lnruzX/HX/OFo9JdwYoJliEVyZSmk0Zqoh7SSUhj
         RvEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750843391; x=1751448191;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vRCR5w6mxJl9kOE01aENY7pdoYD3D3UcZSaG9WSr1E8=;
        b=GWB6EF3mK0uP7b1IRA6NiKvakm5LY4pEJpomXXFb3l5WsCGQctisCUVe71184HMdRq
         jUUsxd68yNj+9IXViYPc1yFWQccS1wSPWbpKE6qhBkHIYTSvJk7pLFgD08D2jlfIKjP5
         Krs5Hrvhv9Q1g6GIBiovjNNt3lHHFBCOZqYP9QbJNRJBU9Ma5+V86UbTFOs07TZQhqMr
         6NowLdAY50LmpEvzxHZjtZjEvSRkge7xd5nk30JC01SyiGc5a5zV8cot4HL7pBXbItuN
         xOP6NqQXpuC/2pSey3rLWBgmDyB9rB3DIe1MUmkAyXqLOg9fvZrChykXfzgmgPsc74iM
         Li6w==
X-Forwarded-Encrypted: i=1; AJvYcCViYwUay10CzAGdWSMZoNm/qUw6Rtv4vsjbSmr1YyZlPY7TsT1MHVZY45HEx34JUwX+gMx+fJ7/EQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzoYsfLQ67itn59DU+qv61sTp7aSsj/ePS6v9r60XGHrCMrTRB1
	3W7zhExW0ZOWtDHGfVScnvvbTCEfmrAaf3YZC5x94PJMN3zQ9d1Ewckf0mpjfQzwR3I=
X-Gm-Gg: ASbGncsiukqQlyFjflsSB+z2gEphXOGuKYaoGq3brkb3VjqrKpzBduDBtyPR3jgmFMA
	Jjela4HWDUwNOkwq/DYjtWCWhXCsvEGJ2AdAdsEBBs49iaecLnPAnG41aA6BuMOylIpSTKdEVsp
	piRclqZHygRX/ZHMNiDzpwK7TjDCHltgMjUBI2dwBuIf9dGygCvRYLRCo2LLWFttRCIteokfCs2
	UUI2n0Cb0x8ek/hjfltGqGSY91MS5Q3C7sYP/XjENi0qUy2LZZwjM2JNKb/38XROd6N7f7+lTQw
	OTUrLf3hLiOz1T/QDoLZTbG1FxKsX+6DH8/GRrU093D1Unmtk2+n43E5/kMYAR6J88qrKQO9aKb
	J70lCfYIeNvX9zdlNPiscW85rF3BZGPTd
X-Google-Smtp-Source: AGHT+IFCI10YnV57Cjp2sR+UxOV3FgvVKAqwit3yxRvSArMNgi+VmBiwj5MjTcE7iiy2oz3pOZCWRA==
X-Received: by 2002:a17:906:7953:b0:ae0:66e8:9dd9 with SMTP id a640c23a62f3a-ae0be90cffdmr205488666b.8.1750843391467;
        Wed, 25 Jun 2025 02:23:11 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0aaa0a854sm270277766b.68.2025.06.25.02.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 02:23:11 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 25 Jun 2025 11:22:58 +0200
Subject: [PATCH 03/14] dt-bindings: crypto: qcom,prng: document SM7635
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-sm7635-fp6-initial-v1-3-d9cd322eac1b@fairphone.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750843387; l=870;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=ARurSlf9cAaTHf8riWzBxjObIWFoiMC+3sc1W+uG3PE=;
 b=s58rpWvVx4KEw/gWNPIbo8A+oAxUDMuwW9s3oTq9LY5OoYgLguK+Onhp3DmRNdPW9BsH3qKmf
 59mx2TZBcoYBb+w1bKOg/GL7crYXeJ4Hl7R0nL42pqDOwmT/DDnmfr5
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Document SM7635 compatible for the True Random Number Generator.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/crypto/qcom,prng.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/crypto/qcom,prng.yaml b/Documentation/devicetree/bindings/crypto/qcom,prng.yaml
index ed7e16bd11d33c16d0adf02c38419dbaee87ac48..c34a4267a0d5292e89f61c766c08e7071bd2ff09 100644
--- a/Documentation/devicetree/bindings/crypto/qcom,prng.yaml
+++ b/Documentation/devicetree/bindings/crypto/qcom,prng.yaml
@@ -25,6 +25,7 @@ properties:
               - qcom,sa8255p-trng
               - qcom,sa8775p-trng
               - qcom,sc7280-trng
+              - qcom,sm7635-trng
               - qcom,sm8450-trng
               - qcom,sm8550-trng
               - qcom,sm8650-trng

-- 
2.50.0



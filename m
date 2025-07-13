Return-Path: <linux-pm+bounces-30745-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D974B02F8A
	for <lists+linux-pm@lfdr.de>; Sun, 13 Jul 2025 10:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A460B1763E6
	for <lists+linux-pm@lfdr.de>; Sun, 13 Jul 2025 08:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850471F4C98;
	Sun, 13 Jul 2025 08:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="Q1PNwP8A"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B21A1EA7E1
	for <linux-pm@vger.kernel.org>; Sun, 13 Jul 2025 08:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752394027; cv=none; b=n9/0DpwbJpW/wsDdYZown91lfiTOLuBMOIMmN+bqukqNW79Y/9BaoEF5KaWSfpShl0FeaHrw2CcIpOrhHEYHdBKd8ertJcmqBeqDkuV9tr+dPetFGOcq4A+aSW+ADgSd8eDRqMF9f8fl7pvSkiPL7BkpVzuydvMcRHvuCHKN518=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752394027; c=relaxed/simple;
	bh=psKgizPd8idK+9Xng1zZOiGE+n8ZxAcQQoK6CGGlaAM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q+sINdPNhDqwos2HRuNEfB64A78e5DTL9ukTcYkbMwdoq/0IGE7cK4rgl3XUz+HFN920gfiIifrbE5DFUmZYRunTXcMN5L0eO/Rjpmd0T0n9nrjx0WQk5AqUx3HIiiazbdHkPfx87+3wyu9UMRThZ4UMsAFgkA+bBdN35hgJopI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=Q1PNwP8A; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-454f428038eso18833255e9.2
        for <linux-pm@vger.kernel.org>; Sun, 13 Jul 2025 01:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1752394024; x=1752998824; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6lM8usxsSz+hgDvjepavl+3hVj5I731y8p/a4jtJD7g=;
        b=Q1PNwP8AFHY3h5FTQVJQoXXLObhKXKjrdBmRnqFLzpcn3mYZm3EQd4e3cpwKBWrIO/
         sK7GHZE3Ho3nM5mfLj9VvDKQriNFkg4fzFf7QlmdDE/HE7uKzvUXEHRDvmER1l6k2QJt
         dvXUg6WjsFpoZ5gky1pM1H9euwV3ksCPnfs8K1q25HDZY5DRWekJGLiDF6qbVkPFJ6gZ
         AgvSlAL7IlqCtFS1ys9LkJy45rD+DAhGpswHJUYgzQwuy8b6ZEf9lKEJ1LDnARmay+FQ
         PZSzYJ4S6Y+RznIM3SVnAYZmDuup/ZJKu+aDqSLDSVnVIJlG41ymN74uTsaZBQOWX5jj
         o6LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752394024; x=1752998824;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6lM8usxsSz+hgDvjepavl+3hVj5I731y8p/a4jtJD7g=;
        b=gWQ42u4ArtuhdfllhlXquj52FtijhSq4r3Tb2nXB1R/NKl/wxE/0/MikbGmtWrWXRE
         Jg+P98Ht+tcyYqPmCpbTAiTCUsij2LdBNnKonjNPBlFgT8hwhRAx0l9yZfKg4gh7wXhf
         XTFLLf2WfXc+nAgd612mOp2UUukhDHNdui98lC2g0JhchchdnyVsyY2FLoJMhQX4hjxm
         Nc28aB9B8odoQJ4qqo+aIPUl+9fymoth8uk/7KLvgWK/pMS5CteE+3O4DW4ZxjSFmNdd
         f1IhVnB7KNzZaaAB2Wf3LpE5eLixQvq4f0cAzJ+FOMTJdgneuxNAfr0iZlJvwqVgU+Ku
         mAyA==
X-Forwarded-Encrypted: i=1; AJvYcCX9487Ic9SvB/2rE/wp7Gl9Zax4CgZqHMYK5aygcQnCwda3f2RVrkEU12zkNDFXUxaG8jLc4pVMNA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzB9Y/8+PXS2FxiW6VFLgO9bEPG/3rk0opfTvCgr6iw6W5JsR+k
	p6tOAnmG9HIc/cXMXvbn6Ep5/GPtO430SfxCfoFfSImt8EM3cK9rer4ixvu333gdAqo=
X-Gm-Gg: ASbGnct8mnsNcoBxwwmZdM5pJvvzgc7xct6AU86IcvPy6naqPfN9cZfKMJqtOdk82vF
	Bks8/+14wBQxbucSnr8iQ5COOC1SWZ9zOCXi6TvBmDn+bYp5sdNoYbyyDE7bAQAAULqaRke++Sn
	ENx6ijqHVgw0wEnBgQuDzziEWSrRtSdvB0ZGlZKSXuVKf+4jL4odQAu1LqP2n1NEOFmFUdN4oxy
	DXVwmw42a9RKLr00lKLT65NzbVNxY0oUGGzCxZbN9ioSEV7ayUVnkL92pK8O+eEbMgrvKlurG3g
	b/7DUj7mGEJ2GG58npVTOP+dlls9ghG6aUk2D3rJKKfvqFapAP30h+YR9mjMDU8EWwCBwj/28dW
	q1cvDqSr+iN+5zgb+Is1qvY3/z9WAEuY3j4mN
X-Google-Smtp-Source: AGHT+IG3pwvpc6BxS1YVZvmLXezCAzje9Y6cdBA2Ax5A0e9Me5Q1M68h5GqdQnaD8/2y2jlQ5aoTTQ==
X-Received: by 2002:a05:600c:1c95:b0:453:86cc:739c with SMTP id 5b1f17b1804b1-454ec14a50bmr77388375e9.1.1752394023657;
        Sun, 13 Jul 2025 01:07:03 -0700 (PDT)
Received: from [192.168.224.50] ([213.208.155.167])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc22a8sm9386608f8f.34.2025.07.13.01.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 01:07:03 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Sun, 13 Jul 2025 10:05:29 +0200
Subject: [PATCH v2 07/15] dt-bindings: soc: qcom,aoss-qmp: document the
 Milos Always-On Subsystem side channel
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250713-sm7635-fp6-initial-v2-7-e8f9a789505b@fairphone.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752393945; l=838;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=psKgizPd8idK+9Xng1zZOiGE+n8ZxAcQQoK6CGGlaAM=;
 b=OPdqk8kzOonRIU/FvMHf4OTch/jvk1/7G0B29tz1FcPCzLFyfw2MFYAPDwPtuFr0E3EKR2CfP
 Ni3Mb/Ur7LsDyQ+nsHsg5e6NHg8v4v7jXauIS2CrOl7e6VQ6BFwELcm
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Document the Always-On Subsystem side channel on the Milos SoC.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.yaml
index 41fbbe059d80cebb214317df8ae15b86573546bc..d11bb623d08c0877cbef8e8ce4795974188b2fbb 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.yaml
@@ -25,6 +25,7 @@ properties:
   compatible:
     items:
       - enum:
+          - qcom,milos-aoss-qmp
           - qcom,qcs615-aoss-qmp
           - qcom,qcs8300-aoss-qmp
           - qcom,qdu1000-aoss-qmp

-- 
2.50.1



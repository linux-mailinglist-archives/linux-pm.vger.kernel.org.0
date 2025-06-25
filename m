Return-Path: <linux-pm+bounces-29478-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B37C2AE7CF1
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 11:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9CC116B2A5
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 09:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9182EE289;
	Wed, 25 Jun 2025 09:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="SALde4YR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A1F2DECD8
	for <linux-pm@vger.kernel.org>; Wed, 25 Jun 2025 09:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750843400; cv=none; b=RUroe2Ze2X7Sn20uSl6tiQTiu0C+MvHvXKUDnLgFpQO18DrGSmOCZrYOZ4eFCZ+9TAhy/bKZfLhJZzdh+hdrifJQcvLV64frYM/bLfvEwE8WNGC32Xrlj2xfTcQ2g4ng86toLjKpFmlKv/yDZXMiljWJeZpGv7NfMoIpeTU3uoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750843400; c=relaxed/simple;
	bh=kMLBa8XpPsXDlevy1KezXuXVxIBGJ+gP0d2yYQ8HaFg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iDsrX9hRbgnStMrL5zZj5nf1ac69SuhHKgLV4zBaSZ3Oeq8WGXJ4b9HUPFXdotnxYHOMjUvTG5KvhqxBK3+NwiQxIsGD9mYWDENqRMl+/1x29lgf0oEhgZUBqB+Itmnir6qtl+xFWeFCtXBJlpTsKemx5ldZX/1aN1Wlb5/+G6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=SALde4YR; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-605b9488c28so11108893a12.2
        for <linux-pm@vger.kernel.org>; Wed, 25 Jun 2025 02:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1750843393; x=1751448193; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UOHLr8D9V4NN9mFAr1BTUycpg0tsYamgkXBgt1W/9eI=;
        b=SALde4YRCJjksmuc6U8y+xUk9jyb2O/Ii0opn4gsCd6/TCvaIJzKRlprrvC8XAb4Dh
         lLLqcrU6IdVaB7uKOgnQCoz6tLsOErtEotkc5+92GRKVUYmRtJ8UvB6jw3kKF4sHO855
         EF1qkh3M/wcp25k6AbZLNoE4DzpKyUDdQ968CBjuDhV1TLQChy3EMlQBqblE3L5wekPi
         tmuz8wAMnfVwwXSsq+vLczJjZNYWOUYhtWCYyruEU+3Ao6xitWLT9wDpv3L0iWvYFhDF
         gB/FFzSc5GWOlq25Y6ZarYNLQXG7N8fZHinVT0wSeD/chjzZqY+KeDnzN9VSFAHRNv9j
         nn1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750843393; x=1751448193;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UOHLr8D9V4NN9mFAr1BTUycpg0tsYamgkXBgt1W/9eI=;
        b=cL+F51t9l7efNMI2ckSGNGCVI/qMSNMQNeontO8gHr3UP0VJU/wVDHnebhsUyaTj/j
         KS7J5+0jBOAAs1AqVnzgPbT5h3AIlMD0Z5YWU5VNBk1UGr99XOH5RZQdQFuCQg8IvpSP
         26m4ZPwMlf95FqVLm9iR8dw2AUmBMZ6/CaOcfsxib02yg0LLb6CCCE++LJs+uwAm8C7z
         cmXJbVHnroF1SWBlx3qf9kIv3yJZNhI3ibsO7+McNuWSg5h3iBj4c/ovZNpL6psD6Z9k
         fDQlDd8N3Ljb2tshm3ipm+g2v2P8aLCEWuMXP/DBPl39nYEuVWmLSlIN+qbxN5gnJADO
         ffrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWg4bYVhIbuncxPX2x1i5/XDwFOcfHiMElOWzlqtn0Ug8pdgR8irW1dbOvV5tFjczuqdrmHRAEv/Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyPSLKyzwh9zCuQJY88Rqgla8YLM1LhTvouibeI5OVAr0Jd1Dmh
	IR7WQsJXMblb/I363/w1+RU6Zu/v4Kww6y24bGBwsrTlfNKGYRzAEUUwYwF+fTF/YTI=
X-Gm-Gg: ASbGncv3rdWSm3p3mqlk5fysZfM7Rt3VVqp46/tzSXM6EL2RCUYdw/JK7kMDefu8X2k
	Ee0THtfc3yvNQQ7EXY/v/kuRk4NEJzZuzO1EFxk3J2bUx5+VZrjvk3pvwxpbEBy+qjhdHKKoWjx
	YDkDwEjV57sV8Knumo3sukwWlJ6VvPMJEIHYiy2i3OS05AjlQzaiasaMu4DpgXLcrNWLzSHXwBs
	hhwgjb6QGTi2LluISiLJEpIuXkYkUe/LKvg/bv5MhkGqvwatsLNU5dvKRh75VxjATG6m8mAw4Kl
	YK23xcgVQ6tM/xWmlapGL+6FXPXg1CuYiPczjwosTq7r74jRqBfJh6LiYjFzzVSZUwtmpRnJKpX
	RC3oUoRG/5gjOxXv17VIOOmuOiZk1vlwV
X-Google-Smtp-Source: AGHT+IHB94tY24lAu3oQO4eGRW4BZuV+A/oDZCQK+b5Z9Mh+mG0nksh62lt/+F3W7DxAhvn4P2IzDA==
X-Received: by 2002:a17:906:d0c5:b0:ad2:417b:2ab5 with SMTP id a640c23a62f3a-ae0beba2300mr176480866b.60.1750843393322;
        Wed, 25 Jun 2025 02:23:13 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0aaa0a854sm270277766b.68.2025.06.25.02.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 02:23:13 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 25 Jun 2025 11:23:00 +0200
Subject: [PATCH 05/14] dt-bindings: qcom,pdc: document the SM7635 Power
 Domain Controller
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-sm7635-fp6-initial-v1-5-d9cd322eac1b@fairphone.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750843387; l=893;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=kMLBa8XpPsXDlevy1KezXuXVxIBGJ+gP0d2yYQ8HaFg=;
 b=mdr+a+luUjX7AFv2DO5FQDsLMYgOBVUahwjTho7Ooy7Ze3zZt8tNJoSuRat0p8SJ/e1grPELu
 6pVuw/hE3yPB2VtbzJkUjC9SFW/NHJPRSwLMfmGq3pXJPW/wvwZrJgp
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Document the Power Domain Controller on the SM7635 Platform.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
index f06b40f88778929579ef9b3b3206f075e140ba96..e809f50734bc3136a8915a12a1a1cba2bdb62890 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
@@ -43,6 +43,7 @@ properties:
           - qcom,sdx75-pdc
           - qcom,sm4450-pdc
           - qcom,sm6350-pdc
+          - qcom,sm7635-pdc
           - qcom,sm8150-pdc
           - qcom,sm8250-pdc
           - qcom,sm8350-pdc

-- 
2.50.0



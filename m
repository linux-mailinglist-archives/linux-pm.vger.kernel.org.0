Return-Path: <linux-pm+bounces-29483-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D9AAE7D2D
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 11:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 903596A20FF
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 09:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BED02E3377;
	Wed, 25 Jun 2025 09:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="niQJ8xYS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78B12EE5FD
	for <linux-pm@vger.kernel.org>; Wed, 25 Jun 2025 09:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750843408; cv=none; b=fslV5a4r9q944Af2O5MY7V4UMkv8SG4bgmj0NkK3K1vwkNc1POlnKZXkSO2inZi8G1KawV188fmvgWZjmVQkeRjNn53Jux2fYukAeZQDfEVChvAuV5KzE5VChIob9dwYXmMlpwtQIWn88PAXMSqExq9uaRb7IMrXcTpYXlyzm6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750843408; c=relaxed/simple;
	bh=9mNvIjwX0GVg9+8QJn8ze4jldqNBVe9LJDYJHk6E7+Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tJ/EKiSxQPi2BCQEA9mJhnV8YIk1nFyH3URxgtINc9lKhcOauPDpn631V8YZagEsqqvH/ZNGu7VYJ6xffGC9O19CxJ7hlSpDVx4hMT6DTtg2VX+7LhPR/JRVhRiJ7+xFtkTU6fnuW/BwMxBZUCDdzq8yVcWjy2onoD+c/bVlIt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=niQJ8xYS; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-adfb562266cso270210766b.0
        for <linux-pm@vger.kernel.org>; Wed, 25 Jun 2025 02:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1750843399; x=1751448199; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w3nipzKoLXU+khkgMT/iFK8MpGbKtAwTRvPNEeh+QTo=;
        b=niQJ8xYSkVwf+6xQsuuqZR5H6ES5aY8g9hs1GIGBhSdSVk4r07+N7nxdeoBrSIQEiQ
         a/KLk4+xMFs/rNSTKcrzTqgzhYoOwCh2jzVvKpYBQxRQOxZad1ZDGSCxE0FLSqaR9sFA
         E2Key73LclGtxtjAJfaNAX6BjxvMOKy6iCSkDqUjQR+QTbCdAsPMFITOGyJ8wC3418Xz
         SOgig9vE0ZMCGpNyMyE2Hwtg7BhUvr2sjuUI4zOD3zTnNHRD3fTpR8RKrvFxY65VUlTR
         60WRWGHawqTHZ0viLDD3LwzrcRb0qT1hQQWcpx4zit7kfq1+Hi27FsYYh5OM3obNT0bW
         UP1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750843399; x=1751448199;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w3nipzKoLXU+khkgMT/iFK8MpGbKtAwTRvPNEeh+QTo=;
        b=Yv7zY1Lqx1+I38HEl3IFmOGK9dctY9de5F0UhFFrMFf5NwORwMV90s2IYj/i39iFLX
         OrLFjSWuLGq/RsNNtrX04lLsG8u042zAvKr5SnoKTt5bLJmBgZLRiE6KxyBC1ecM2f6+
         rmW3QOCB0rsMIU4aFGec5+nIBDFMOjm5N39RKl3bCI6KRLYvhgnaQTQt00LEjxj3NMdC
         ITGR92FERVG44geyMNZ1aiPdIgip+Cl8+7K8Ynsa3LZiXzJrjt09k90CNfg55MjYOKbi
         oRDnCl08Iih4rH9YYXPuoXR/1IE6V5UBbRvtSlSLJ8RppLDQj5DU0BzHQRQsPpPzImn6
         j9cw==
X-Forwarded-Encrypted: i=1; AJvYcCWjfaxl5CoQ7a01LAIqpIfwckoXxEv1LZeYjPIUWeHmzjXBfkU4qgBcPLhOhCIKiOLyIKTWOXbSag==@vger.kernel.org
X-Gm-Message-State: AOJu0YxUJpapOoqBMyRvS95tMADofTmdfy0A+LFKlYh9MojcsCe7IOEF
	i4ldIAzK6/M9sN7Gpqefrm18I+VHBP8HPW3f9myHxsPAZ9MdprptJsnDYpq5bXzQIOQ=
X-Gm-Gg: ASbGncvZ+k6yinJc08V0KzetDOmsUk8kAPIazaGvCy1lVYlricnctBLSiatZZlFy8X/
	HmpmFkWOIfUc143ZBgnGe66b45q32S9Uvy6dd6I18vGaLI8ZAbagW80XbWu6AAUu7YJgnis4Hlr
	Fl1zqLIWGeI4kCIYovVcSx0TaUpugI5SJTl842u0udRsbWKYrdXlj64jaINzzKVkRPSDzkZITaV
	jPohzRlukpTR8L0/lyZJi54ukBct6YqGLbnt3YuEeifc5nIIqJ7NA2/EUVUjGzKbcs0mtQiYKvs
	iN+i/YTnobPSS+SMD8DzpQdZskNhPCzZdZtmZRXH0FslTqdeI9Pgm5ndhmytv2VM9VGF/OPNLNT
	EmvmchvsmWpaC6mXcSZ3dCFbQyRN4lqJJ
X-Google-Smtp-Source: AGHT+IGVifY90ul/kd9o3o6inz9kogKyytkNR1Mkk0jMmIxV8Ntq/CDmQ5WF/k7Z2pC/kCZPojhuLA==
X-Received: by 2002:a17:907:1c0a:b0:ae0:ca8e:5561 with SMTP id a640c23a62f3a-ae0ca8e5732mr22602266b.13.1750843398619;
        Wed, 25 Jun 2025 02:23:18 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0aaa0a854sm270277766b.68.2025.06.25.02.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 02:23:18 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 25 Jun 2025 11:23:05 +0200
Subject: [PATCH 10/14] dt-bindings: mmc: sdhci-msm: document the SM7635
 SDHCI Controller
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-sm7635-fp6-initial-v1-10-d9cd322eac1b@fairphone.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750843387; l=849;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=9mNvIjwX0GVg9+8QJn8ze4jldqNBVe9LJDYJHk6E7+Y=;
 b=ffd4klj28huseDrq2t0Ois6nd1kBF/j9T3yy2ZWpgFwV8hBk7iSpc/UKSVR/3ZIG3wkyYCYpY
 +TzW/dweg55BSVxNB51nndNlAVdd6s43fdl8zY73JdwEi8CKF8/opnC
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Document the SDHCI Controller on the SM7635 Platform.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
index 2b2cbce2458b70b96b98c042109b10ead26e2291..bde69ee1554642b8c2ed74b1fa0f68b421d7d64e 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
@@ -61,6 +61,7 @@ properties:
               - qcom,sm6350-sdhci
               - qcom,sm6375-sdhci
               - qcom,sm7150-sdhci
+              - qcom,sm7635-sdhci
               - qcom,sm8150-sdhci
               - qcom,sm8250-sdhci
               - qcom,sm8350-sdhci

-- 
2.50.0



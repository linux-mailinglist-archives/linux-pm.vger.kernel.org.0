Return-Path: <linux-pm+bounces-30748-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF636B02FA5
	for <lists+linux-pm@lfdr.de>; Sun, 13 Jul 2025 10:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 200B71A6086C
	for <lists+linux-pm@lfdr.de>; Sun, 13 Jul 2025 08:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33102222AA;
	Sun, 13 Jul 2025 08:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="zd6OKtlv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21871E9B29
	for <linux-pm@vger.kernel.org>; Sun, 13 Jul 2025 08:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752394056; cv=none; b=gzuN45QnkbagT6j0rRUduicNauROFjCwQoRC0Jq5ArpJxZRiSrzDkIdGNBvNpw+UHB5NJWRPtbye/Qseqxm+01SgEhqfNpaAkmnByhoru1SJ+7NHxiMLfmTY6eMqe2/CsppQvLViv3FKXC7MPjSiRBL3L945TfxisQS8ueQ0UZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752394056; c=relaxed/simple;
	bh=aDMmuhwLGm8e9aVoqg3PeCCwJAaRLrTPedtNvgdSwWY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pTGw7YfCCzvc3zlkSPqSsyfusXLzJ6K4PCFRCpX53uJT7jlsuvp65bZ1d9KyrMZRzwz/VwVgyBcLbDQOcZB2Ir6gezmwyQizCI4+ug+5RAWB2yHkULFs0bAw5JoUZI1iECwGozn6LkZAFMfwTGdC7WMXpIaZfbWjDUymxRNZSuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=zd6OKtlv; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a5257748e1so2390877f8f.2
        for <linux-pm@vger.kernel.org>; Sun, 13 Jul 2025 01:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1752394052; x=1752998852; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9/c/J3A9ASq/x8Yj1Xu/txbcuuFB9UfWNR/sa9FS0As=;
        b=zd6OKtlvvCClUwllW0CO64sKlzsP6TbpD1VGG6auzuAmCJEVoreA3lWokdtjNOUL/E
         MYk1bTMuV6bZtow/wxvLKKu+V6LUDJkwEXmw09v9RwBnL/l1HdNxvCq6JXNQC2p9pkRp
         bbnjlAUchvCzHC7kbb5iKNWT5VPsvQU/hCEpc21hHLwSlu5MBl9iko75YGMQ6cA6uv69
         SbihEP40qDhrNYAKFmh6w9eHvgXjTsoQ2gl7f0g3NJ9vfpRf2bSsUD/kuSbm/lv0p/SS
         VzroI0RjSw2wMHm9IqFnI/GcQrEWetSUXWBCAwsav2yCU+CbHurxRFiU2iebpD3KRlU7
         BddQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752394052; x=1752998852;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9/c/J3A9ASq/x8Yj1Xu/txbcuuFB9UfWNR/sa9FS0As=;
        b=bOK+0ZAYS+xoXx5YXwXXnd+p68wdDqZqp5xHRuJd6PBwGVnQvt9SmoVNb19tmfHfAZ
         RGLypj1ijgpP4dYcT/juxwP7LTmes20Hp3ZMkkI4mlELXGBmU3nG1P5RUhv2P9iPiYAA
         cQqCqcWk7BFcXz1seNslispe/WiVzRBY/8UEbpMixQaM8jmK1Xc6quIBIZZd7WCfmTSq
         THrPZ5zDEeqz22YWc4JHkmXVrGKx20MQQ+mwfXgRSetK0Prb+huMPBlXZm9XQbuk711T
         3b9zbTZdCEqPkQGFdnI4SBW50ivVMJQl2Ml3sdy/fP6b+fBmYHzie1pKQQiPyYfWpWAl
         LQGA==
X-Forwarded-Encrypted: i=1; AJvYcCUASyuJ4R0rNU6SvJfdKyy77+ptNxjCM989qqgHktfjulMxiz+nYAopsd5LgQGijp9q/aRGKYe0Ww==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9z6QaFIvscPVffAh1aahs6Nky+iYF7vUSqevnUlzaRVL3cKEk
	hCKirQ/PZVC8oCDhJOmSiBuQlt4GdW37TWROxd5YWcKcFh+fj81RQa1lLzNJfyFIfco=
X-Gm-Gg: ASbGncsnPuwEO4pUCDQ5PCYq7qC55V8UzqJI/V3yulo2rlp8+Wg+sSJ0Bu6g5Rh+OeU
	me/lTHu32luIl++fwAo/+9DeUY/jlmZTLgKiVpZsIIuBpFNHC9Rmtihx6tEl3XVu+MIDkh8S2fw
	V7nSDiQ2dmB4U8HGOCqfuqDuEs3eWuTPDqOpP+cInKFsSnbecc7nC0JEjHV3NecTwCZkIdT6IRP
	h61XsGHHdB+v4DIYRidZgUQ4lUVIb6O2PRuk1uA3G3nDA2FdweKOtWFvO+nBBt3U16pZwga6LG9
	7WZ779VLA9mYuTCbDWwUxwbANVFf3MNOZ/1OOxnqQrrlSBC8PALd1VV0BOPMNb/s+8fPeYWqm9J
	d6ZGPvEKFHoR4CwmMHFF+M6CaN4n0RM7odQ9e
X-Google-Smtp-Source: AGHT+IHfutuWB7rD4cm9MzDFG+4cnjfzK3xIdEUacutPo2JmbTjuiRMzIjn8M5NoivS2vTb1Jp+CSw==
X-Received: by 2002:a05:6000:470c:b0:3a4:d994:be7d with SMTP id ffacd0b85a97d-3b5f2dd470dmr6368310f8f.23.1752394052404;
        Sun, 13 Jul 2025 01:07:32 -0700 (PDT)
Received: from [192.168.224.50] ([213.208.155.167])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc22a8sm9386608f8f.34.2025.07.13.01.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 01:07:32 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Sun, 13 Jul 2025 10:05:32 +0200
Subject: [PATCH v2 10/15] dt-bindings: mmc: sdhci-msm: document the Milos
 SDHCI Controller
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250713-sm7635-fp6-initial-v2-10-e8f9a789505b@fairphone.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752393945; l=846;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=aDMmuhwLGm8e9aVoqg3PeCCwJAaRLrTPedtNvgdSwWY=;
 b=QyvoywS+ViPILVHSWP4Oe4jmXijRzJRl4R/Cid8Kttmp8MEimcvZbZ2reSR7fMW32bxl68sjl
 rIaZtlOjefZAQM2+cVveN692VtVF73WT6QgLclxD9GL7msUjQM+72/5
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Document the SDHCI Controller on the Milos SoC.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
index 2b2cbce2458b70b96b98c042109b10ead26e2291..6f3fee4929ea827fd75e59f31527f96b79b2cca8 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
@@ -42,6 +42,7 @@ properties:
               - qcom,ipq5424-sdhci
               - qcom,ipq6018-sdhci
               - qcom,ipq9574-sdhci
+              - qcom,milos-sdhci
               - qcom,qcm2290-sdhci
               - qcom,qcs404-sdhci
               - qcom,qcs615-sdhci

-- 
2.50.1



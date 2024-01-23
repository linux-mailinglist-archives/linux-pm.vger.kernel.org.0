Return-Path: <linux-pm+bounces-2566-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2671F839104
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jan 2024 15:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C937F28E802
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jan 2024 14:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB107604A0;
	Tue, 23 Jan 2024 14:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FoHgnanV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F206060262
	for <linux-pm@vger.kernel.org>; Tue, 23 Jan 2024 14:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706019229; cv=none; b=RVi2mcVqwIXKFIpBECP/64jawM73GTphIj1cIo0asA5sv6KZRaqlRTC1LCyBMOPyRl7Of5CAv+83aJjQ/ICyUputihr5bl6WSUsvGzO2UZzDehjPwn8d6GFEk5e6rHW7Rf6ygBSBXXqoyfBTxV/p6AnNoL6+4B6MBt8dNmiz+lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706019229; c=relaxed/simple;
	bh=oMxlIYU8lOKLFt0TEL5h53mUDoaj/hO9QDpO+Y17nsg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=COn/nHkfqzr4XdQWK3ZsHs57WLk/+pSZt+FVPrB6L8P5LunG0YmbWOdWcha7PETz8Hr0HMWvzye5Kx7aodWNxhtM8oAso8661Lum+tbXzi67jroEB4GUBTaTwBSvtX7Py+Nd6ulvjiv55xIe4W+xN/Y7nOWvhykG2SK86q8G+Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FoHgnanV; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3387ef9fc62so4085965f8f.2
        for <linux-pm@vger.kernel.org>; Tue, 23 Jan 2024 06:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706019226; x=1706624026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qG0lQDgeayG/ZAaWGjl028iUARha7B2YZJgs2y6qJ/U=;
        b=FoHgnanVMCi7WgzrN0QbOc6FZbvnblhqMDAzq4gZj2nxoTFiy007yz6PW19fhQWAgy
         cyh1jUVBWT70mhAQWq/MV35jJLTQSLnsnrwjA1Si/yYtYJ0S/VVzYkl5UEexMygbhpGf
         2SgVM/wZOl9ShMADe2aAOFair88GbwVTrWKaQNQXLjjVYhQl6f/d8u4+QyHMKxjS1Vj5
         4C2WTI/ziQmI+lPlbqsbtHQ7AJWKPn64FUGc4VBDNESdR5ZtvIx9CrbheyNg4Cj4xoBO
         k+qwqJob9/4JrkknnHcc4hlbrvyo3VfZAh7rTucRdO/hCj2fAcIS3dL1pr1J87uwwaXd
         2ccA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706019226; x=1706624026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qG0lQDgeayG/ZAaWGjl028iUARha7B2YZJgs2y6qJ/U=;
        b=RQMNiX98GOtPU/Se65at5DurMlYTExtQwgZMOvEcWpr9QATnMLEQPcvWFlLRCeT7BQ
         QkhBShx6ZItRtg086I5NyghDAQLTx9JbZBP6EwrAnBJ0rPhgR2FatV0MBynqFmG/4xk0
         HcTs9z9ULImMHv8wfH5HR3j/cL8/wBSlUmGCawtQ1bJbNCFNHMJulyp8AmhWGA/5+FzD
         hH/fAvY+33E5RYBqY1XYT42xN5Q1XN5BVZK1JDkZvJQN3T6g3X2mMMqPXLPhlDJ4kIfZ
         9e4nY9O/+13xvnGOIT9w7/4knJVc8AIK8d2XCdJWI7MWzzIfe87sxzbLTHB5eGoQN754
         nvgA==
X-Gm-Message-State: AOJu0YzrhLlFojr8B1clkEchtIceACRml0IqqYL0Ig9TYNXv6WVJamo3
	pvmffsyaL6IxnooR5wGPsvWH+itNiZBn3XmWI3JCSqXcYYr78iDG2njUAETThXA=
X-Google-Smtp-Source: AGHT+IHqKV7UxmdKdHe6zjaK7RBNZnRE3p6gqEa/c3ykA6FNDvoSpVZjiP8ZtDmiAEKBeFc7P6DV7A==
X-Received: by 2002:a05:6000:100a:b0:337:c81e:cdb0 with SMTP id a10-20020a056000100a00b00337c81ecdb0mr2955862wrx.104.1706019226510;
        Tue, 23 Jan 2024 06:13:46 -0800 (PST)
Received: from krzk-bin.. ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id r8-20020adfe688000000b00337d97338b0sm12132298wrm.76.2024.01.23.06.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 06:13:46 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-arm-msm@vger.kernel.org,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Sean Anderson <sean.anderson@seco.com>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH v4 5/6] ASoC: dt-bindings: qcom,wsa8840: Add reset-gpios for shared line
Date: Tue, 23 Jan 2024 15:13:10 +0100
Message-Id: <20240123141311.220505-6-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240123141311.220505-1-krzysztof.kozlowski@linaro.org>
References: <20240123141311.220505-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On newer Qualcomm platforms, like X1E80100-CRD, the WSA884x speakers
share SD_N GPIOs between two speakers, thus a coordinated assertion is
needed.  Linux supports handling shared GPIO lines through "reset-gpios"
property, thus allow specifying either powerdown or reset GPIOs (these
are the same).

Cc: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Sean Anderson <sean.anderson@seco.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

If previous patches are fine, then this commit is independent and could
be taken via ASoC.
---
 .../devicetree/bindings/sound/qcom,wsa8840.yaml       | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/qcom,wsa8840.yaml b/Documentation/devicetree/bindings/sound/qcom,wsa8840.yaml
index d717017b0fdb..22798d22d981 100644
--- a/Documentation/devicetree/bindings/sound/qcom,wsa8840.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,wsa8840.yaml
@@ -28,6 +28,10 @@ properties:
     description: Powerdown/Shutdown line to use (pin SD_N)
     maxItems: 1
 
+  reset-gpios:
+    description: Powerdown/Shutdown line to use (pin SD_N)
+    maxItems: 1
+
   '#sound-dai-cells':
     const: 0
 
@@ -37,11 +41,16 @@ properties:
 required:
   - compatible
   - reg
-  - powerdown-gpios
   - '#sound-dai-cells'
   - vdd-1p8-supply
   - vdd-io-supply
 
+oneOf:
+  - required:
+      - powerdown-gpios
+  - required:
+      - reset-gpios
+
 unevaluatedProperties: false
 
 examples:
-- 
2.34.1



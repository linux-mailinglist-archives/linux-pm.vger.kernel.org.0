Return-Path: <linux-pm+bounces-20830-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C13BA19F74
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 08:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7F237A66C5
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 07:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88CF720101E;
	Thu, 23 Jan 2025 07:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZQ5KMTHU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148DB2F2A;
	Thu, 23 Jan 2025 07:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737618912; cv=none; b=ruv7rL6VYm9aM83PJe3A9r3gdgso2ImSoTxnxBxM1RUSCSReWrpTr9XAT+eWpHn/PGyHsGmqN94vcNDAWoP6qjcJp7ItuS/KER7Cq7lcPSDjj7s8bQ1+EhkVnNuPUrxQvkV1vn/j0ergf28xmB1+4CLGrogBWK59JChWRGeHD2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737618912; c=relaxed/simple;
	bh=8NoWRzP4qG9zzO0MS5fIRyHfvNlYSS2dL9XxxmE87Ck=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KHQkGq7JpIBOB6KaZ0Y3ItAsVxn9F3ipx+TS6iZSA9pBd+bDbOtRh9VBNYDv63rTvvirPU2n4h4gGRmaoqYbUC/+AByfyliALNKmrTF70zMJ6O/5cj7iE3DD25xqnVPpguPamHk/PPZuFlvhT+it18Pw1TFbPLoFw7qhRCQw/2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZQ5KMTHU; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2ef748105deso921645a91.1;
        Wed, 22 Jan 2025 23:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737618910; x=1738223710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xRp5CBhPMxzufEjk9azD6SyDttl6LU7ag5HNsBe1+xA=;
        b=ZQ5KMTHU2XIuHUf8K2/ho0DTPp31KAwlQUPGsgvZnP14rJVVP/CRg7qBKnbdbg34tZ
         0YuTYHs7XEnitAms60JnKtGlqo+aLwkijW8kceEtcb+/1esSozqYoyCsGybYPMptrEkG
         gPI0Xpxza5RotYPyKxPxpu8Smulth7/VTrFmcwEPJYvBc0cApLFjVp6jKYxAnrOsbD4k
         MN0CCl2byu9S8n4ovwmrpp0UWdLCDQUbkrXjhatpRP5aVMkHKmZC79Npr3emSfsZitzx
         vo6upa3K1eTjdLNNRuF+r9UF+pv2TVS+loEHltzBUUMqXbECfrCobPEBbf/V5obCt1uC
         yu9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737618910; x=1738223710;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xRp5CBhPMxzufEjk9azD6SyDttl6LU7ag5HNsBe1+xA=;
        b=dpkOseQ+Qdg1Spt3taAlvgQIl1xnJv+y5tsRLRbykUarXmhF7rNdZMcacwhZ23HTjR
         07nD/hDQrz9ARtbkccPWvoIGP1kQeoWAp5/er1/HQH6TOlnRrLwhwSY6jKf0+5ZKYQKw
         hLNoFlaVuHfneoXkic7Wg7eW7EtXJKuK17O0NrLHotTGEBrmLKw8he7IAT63vcbjpq0s
         SOxoxhgFrxoy1yKG6OSmOrJ6BAwE32TPbtmTxobXbJJhr687ApIldNTi+n5h6SlZWNY7
         A5MW4w1kiA/EoO36WSxFSu0QMGiK9xMRJm6G3JAJ/Pm8BRNSqWp0djyrsyupP6bASKfg
         0lZA==
X-Forwarded-Encrypted: i=1; AJvYcCVeQJ40866qJ47wyD7YH/M/KESqx+yRPbhdtslECziaFVnY3x2Z359bbrGx6Ha7j/wsKEG88CHK/1I=@vger.kernel.org, AJvYcCWfTcM0zcHZ43PEb7rUSaEzwRIXEZo2EdATlIpXerFXK9IVrIq5hfM+HikzmkjSkVezT+IJN3PNd94UaFkz@vger.kernel.org, AJvYcCXoSaRTWaf8GmxelR4Vrom3B/Ied8bzINXc8dC/FIM1LMnRVZ//DAMFOACCm/xBLlQERpBWe3z6tQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxnOQntYiM0NNg5rV0DuXWyr85saOucfv8FhvAQQCcZxEyzujoD
	hCv9O2LdxvFBPPzfdh40ZLpmJxnQ1hZGEWcD5CH1R/je91HgqkZG
X-Gm-Gg: ASbGncvvFiHTS+VVfr/zlpRHaekrsM7ll8bGQSt/y0dxLvUKnrHt6K+yKwtLUfljEXK
	AZSYz5HUTeY/npTseJa70FaB4Vpy2gErh1HXWJkgMSEDeIrlVFpNsDPcfyVPmtKmuEGGW64SWMv
	p1HTNLb+KbRMD14OL13FxvXjDd3Fm22TeWLEGP/xoJakvhG92qqSknXVOYD9pJS5scptdiH7KX8
	nQDnKb8G8Aox7Zh71x3bt95r4sbFTUN2S3Bw1NcwdlY9TI0IT/U6+HHsvQjMQF1w3E6WKSrJvLY
	bB8d+oMtCzc=
X-Google-Smtp-Source: AGHT+IH5a1uZ6R8BHzUEUJWuugPyK5QOM/E7bx4Ds/bwSkjYLPzhV2WX09cBDNQfEL1Ldq9Nlt+d+w==
X-Received: by 2002:a05:6a00:3006:b0:728:e1f9:b680 with SMTP id d2e1a72fcca58-72daf9df7e2mr34655239b3a.6.1737618910201;
        Wed, 22 Jan 2025 23:55:10 -0800 (PST)
Received: from phytium-Ubuntu.. ([218.76.62.144])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dab848321sm12477217b3a.76.2025.01.22.23.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 23:55:09 -0800 (PST)
From: zuoqian <zuoqian113@gmail.com>
To: sudeep.holla@arm.com,
	rafael@kernel.org,
	viresh.kumar@linaro.org
Cc: cristian.marussi@arm.com,
	arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zuoqian <zuoqian113@gmail.com>
Subject: [PATCH] cpufreq: scpi: compare against frequency instead of rate
Date: Thu, 23 Jan 2025 07:53:20 +0000
Message-ID: <20250123075321.4442-1-zuoqian113@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The CPU rate from clk_get_rate() may not be divisible by 1000
(e.g., 133333333). But the rate calculated from frequency is always
divisible by 1000 (e.g., 133333000).
Comparing the rate causes a warning during CPU scaling:
"cpufreq: __target_index: Failed to change cpu frequency: -5".
When we choose to compare frequency here, the issue does not occur.

Signed-off-by: zuoqian <zuoqian113@gmail.com>
---
 drivers/cpufreq/scpi-cpufreq.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/scpi-cpufreq.c b/drivers/cpufreq/scpi-cpufreq.c
index cd89c1b9832c..3bff4bb5ab4a 100644
--- a/drivers/cpufreq/scpi-cpufreq.c
+++ b/drivers/cpufreq/scpi-cpufreq.c
@@ -39,8 +39,9 @@ static unsigned int scpi_cpufreq_get_rate(unsigned int cpu)
 static int
 scpi_cpufreq_set_target(struct cpufreq_policy *policy, unsigned int index)
 {
-	u64 rate = policy->freq_table[index].frequency * 1000;
+	unsigned long freq = policy->freq_table[index].frequency;
 	struct scpi_data *priv = policy->driver_data;
+	u64 rate = freq * 1000;
 	int ret;
 
 	ret = clk_set_rate(priv->clk, rate);
@@ -48,7 +49,7 @@ scpi_cpufreq_set_target(struct cpufreq_policy *policy, unsigned int index)
 	if (ret)
 		return ret;
 
-	if (clk_get_rate(priv->clk) != rate)
+	if (clk_get_rate(priv->clk) / 1000 != freq)
 		return -EIO;
 
 	return 0;
-- 
2.43.0



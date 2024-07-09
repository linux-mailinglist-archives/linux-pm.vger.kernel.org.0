Return-Path: <linux-pm+bounces-10850-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 750DA92B55A
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2024 12:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2980F28544B
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2024 10:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E25156862;
	Tue,  9 Jul 2024 10:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Utosi57A"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3674114290;
	Tue,  9 Jul 2024 10:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720521083; cv=none; b=n4PGw55AbDkPIOV3YVknsMlmiagOqRxkBbxnFU0DBqsjKmP7xNEjViVTiiAKFR7q2g+xULl3FYV1n5t4k5x7u5LB45FySBBPrhG36UYKnAzi6u+MMfSwPdhijX4u/HlEspo20VB2RBFlAxdpleFJXmVWnEBpx08f+K/pPKofW0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720521083; c=relaxed/simple;
	bh=IRg1OdfxSxvXT1sq0n2M0MkhmzQBEWJ5offR5cOD+xw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WsJKIdCtGAS342KcTqKQ43y1q8xXZDutqQ8oBPkMHHpJ9ddk+Wm7JqzMLpEbLs15N1vk/P/ZK9HSfZJuDG7KrWgjOwxqvpH3LJusbl9ftZE7kB8V9KPCxDzjCWNMytIC45mlfuN2h+vqYaxa1NbZWO3RSCEHtnW1OvtTPM+LE1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Utosi57A; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52ea79e689eso5567677e87.1;
        Tue, 09 Jul 2024 03:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720521080; x=1721125880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w6GqqCFWFVTzkawZoBGDseEtBHPCa6na2iuHXJweLRs=;
        b=Utosi57ASdh/93WMCYJ/v08Y2XIj7lDGQLNGNDiDC/0awKja4Tjbimes2XxYM8GEq6
         neMSPju/MR5vdANj+wA3aHmwBpezxPsWHE/14m6pYF4QdJI+fXsEND3O3WqMIqq/RP52
         iANcVIz96i7DwQeqyhUJEhb8mg2nHig/OcG/OG7DwIfYGTgbe/ifa80QlfvHckWncF0v
         blDs02lyTgH+RINsjVK4HO1PZvjRHl7dbTcB8OU2EAWNFj7y9TvA70XXsHzO25t+2Vck
         Y3tZYwp8c+T5CCnuwlR8MpGTDsHVHssJapQ0wrtMoyr4fs5t4TI5nqiF8gru9ZhJ3zzQ
         xhvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720521080; x=1721125880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w6GqqCFWFVTzkawZoBGDseEtBHPCa6na2iuHXJweLRs=;
        b=JXs4Y3omZL/E3kU9N4y1BsUvj/fqyNip0duprQew7vaBTxzzJ9AQt+VTMGFi1JXDit
         tdApwALPnz/7ZEXhkdYMNZgXEMX1JlkHWavyisHA6T+Mf88ojqefPhnybt0mjTs87HRa
         7OHLy8RxrODrFkd7PBw6qaAgv/zb7Ezjuj5j10D62N8/6hWcW609VhJ/cM7quLdAs4+f
         vK8VM+YiauLaXCOFAzL80MP52o5sdq4M2P+3CvSOVta1l7il88GUQdYbeFfbnhXNKy/M
         iKMIPpkxnTzvxiAfhHzEhr0xcmCcv3xmdg/BdQaeSkFuxrkEygQrrqFTGMQQW4ulXAXj
         apRA==
X-Forwarded-Encrypted: i=1; AJvYcCVwAAIDHRzmeHbbuW4WuXJNKAUGBWNBO3G/7xUKZFaxrVZWsyjrGkxsHbEeGzMAgaH4f1OBFJ1RSs3eseDXGAZPJKYfHOh7Qj0TjXm/2fkipAoiw7RpHtuNb+RGJz21QWZzWvmCm1madiAutAJboH4K6qAVUqAwT9tq/4x//dzBvsyWCZV0rOqFEJW4utNGiY4hw+LSauOSjNq9Nz1GeqXB4A==
X-Gm-Message-State: AOJu0YxrlHZXkdCM+lJgckjxN4bVdND30kCWlw56GTBT2AdtKVqLqP7j
	838N2p6SEDqOg1XoR0uw9WH+TWzz6aE6bYXSclXKUKqqV8MwriCWVAjiwQ==
X-Google-Smtp-Source: AGHT+IHNkKfUSdXCGlilZFvgDQC33w3QMEso9bmgiypnwGcf8IaQ/Yyqgm0tu3R9m6lHWR07V8Cf5g==
X-Received: by 2002:ac2:57cc:0:b0:52c:db0e:6c4a with SMTP id 2adb3069b0e04-52eb9991ec4mr1399274e87.2.1720521078765;
        Tue, 09 Jul 2024 03:31:18 -0700 (PDT)
Received: from localhost.localdomain (bza125.neoplus.adsl.tpnet.pl. [83.30.46.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a6bcc21sm66528166b.16.2024.07.09.03.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 03:31:18 -0700 (PDT)
From: Adam Skladowski <a39.skl@gmail.com>
To: 
Cc: phone-devel@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht,
	Adam Skladowski <a39.skl@gmail.com>,
	Georgi Djakov <djakov@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Vladimir Lypak <vladimir.lypak@gmail.com>,
	Rajendra Nayak <quic_rjendra@quicinc.com>,
	Rohit Agarwal <quic_rohiagar@quicinc.com>,
	Danila Tikhonov <danila@jiaxyga.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
	Andrew Halaney <ahalaney@redhat.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Barnabas Czeman <barnabas.czeman@mainlining.org>,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Abel Vesa <abel.vesa@linaro.org>
Subject: [PATCH v3 8/9] interconnect: qcom: msm8953: Add ab_coeff
Date: Tue,  9 Jul 2024 12:22:53 +0200
Message-ID: <20240709102728.15349-9-a39.skl@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240709102728.15349-1-a39.skl@gmail.com>
References: <20240709102728.15349-1-a39.skl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BIMC and SNOC-MM on downstream feature
qcom,util-fact which translates to ab_coeff, add it.

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 drivers/interconnect/qcom/msm8953.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/interconnect/qcom/msm8953.c b/drivers/interconnect/qcom/msm8953.c
index 9e8867c07692..62f8c0774b3e 100644
--- a/drivers/interconnect/qcom/msm8953.c
+++ b/drivers/interconnect/qcom/msm8953.c
@@ -1169,6 +1169,7 @@ static const struct qcom_icc_desc msm8953_bimc = {
 	.nodes = msm8953_bimc_nodes,
 	.num_nodes = ARRAY_SIZE(msm8953_bimc_nodes),
 	.qos_offset = 0x8000,
+	.ab_coeff = 153,
 	.regmap_cfg = &msm8953_bimc_regmap_config
 };
 
@@ -1295,6 +1296,7 @@ static const struct qcom_icc_desc msm8953_snoc_mm = {
 	.nodes = msm8953_snoc_mm_nodes,
 	.num_nodes = ARRAY_SIZE(msm8953_snoc_mm_nodes),
 	.qos_offset = 0x7000,
+	.ab_coeff = 153,
 	.regmap_cfg = &msm8953_snoc_regmap_config,
 };
 
-- 
2.45.2



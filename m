Return-Path: <linux-pm+bounces-5732-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 429EC892D71
	for <lists+linux-pm@lfdr.de>; Sat, 30 Mar 2024 22:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC298B21C84
	for <lists+linux-pm@lfdr.de>; Sat, 30 Mar 2024 21:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924664645B;
	Sat, 30 Mar 2024 21:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EuK11uYg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE85143AC2
	for <linux-pm@vger.kernel.org>; Sat, 30 Mar 2024 21:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711833042; cv=none; b=ly+D/QP6hwHD4ZYH67CdxtP9tK9+sY0u7tVIRC5C0NTPzCe2QXkL8R8uP5Wa+9G8qXR/oTThgUBI6Mz9gFx5datOwQMbt/yOQGkjnWqVVsFtyF80F0P+WNSsQns/B3zaAPIp26MCw/R/zfskjKKpm8WSto1oMD6JMcX7ZCjAB5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711833042; c=relaxed/simple;
	bh=/4yQxoR3DV9yvkLWH5V8H39qrAkzGcPAl4uH956qFcQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NaOAmtAu3ncdR9vZrxQkQhjyS2IsAXFUaJeob4num+FnfSS/TkWvYsKtYraDpv/O6N5KK75BCyxdrDviFCvT4v8dWbKcq6KgRqcMYxutFb4/qXYGDQX9E+UCTpp9xkrfiT/RyVR8JTIoPEd2wkyAi+IO8Z21gkVZb9DtQwZZ4pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EuK11uYg; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-41551500a7eso9263195e9.2
        for <linux-pm@vger.kernel.org>; Sat, 30 Mar 2024 14:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711833039; x=1712437839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=61v4scjVgIk2ToFnkXS2oeqx/czO/u3CzUzarujt/iQ=;
        b=EuK11uYg2xMVqXhNGntIbfC9q8LcHUe1FkvyowcuCkBRpYY9fizfrZBPmOHpwpq6JT
         youB6G1Azf4HbWTz6qs/jCr2ERT0dGTfcjq80tgPXt4ZTuRLE0HSLZcYvxkw4pFbpH+F
         iNYEKUhOJIwT5kT4W35vWMn3mSoU2i2su++VHxpjWsyAI2XnbTpvHq0pmtqDMhPQULRE
         IJ725Iok2kpIZ0uRzAs9McDhgnpdO2Aez7eUpsjzdt0KJMVtqhg+7ja47tc9DMd5SmWb
         EtMoEXRCOIUN3KIxGwiokW3Tpyr7yEngB0k/ebCRXAhHzZm7KE8Rh7lD4GAZcEnsHuh8
         PDKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711833039; x=1712437839;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=61v4scjVgIk2ToFnkXS2oeqx/czO/u3CzUzarujt/iQ=;
        b=n3T8fDdigRpyCCuG/799UNK3EIuvjW1n21hZ70GNmsdCKPhBrH9UwwIVH+IuZJfTzO
         TujI3zPNBB0tRBXPfnyhzBf0C+mvAWtaiez2mERn5maXiU0CCuHP6rdrECSDDFtvdN2N
         9Tf6/Uf0aQX/JrSoiNaIptvNUU9xKSM7pH1CA1EM1lzhk9HkGHVNt/w53gVTpK59bf2X
         jL1wS/ZBo9B+Ns2zWS2Oxkd3v85Ei3+oALrxue3fwJml2ZOJ5l+TiQgSEk+E7XTGr29v
         rVa1Z+p5WiU1pqGNdM6126pz3gSsQJ7vfbS0VBRrAyK91WgJyrWjAGiuvVlArPbaHfBb
         RstQ==
X-Forwarded-Encrypted: i=1; AJvYcCX64zi5qWh2/OzJyzfzk/Y7UdlTDJfdVULdQFt1Tr4lpYpckAmbsZNeLzHsXsgkQ1oP9MrX4RTrsK304tO9ym7cFXAcPPH0hI4=
X-Gm-Message-State: AOJu0Yyh7VeVih/t0FyuCBycOgPyj/llJwA13wzGLuAuMPeSwrWmvGtv
	33JzERg8HtCg+8FYh73j9ZKS6pz+sqIgVj1JF+z3+TVH/IER/xUDXIDsMKaCnZU=
X-Google-Smtp-Source: AGHT+IGvC5puYahyLfoRxaBZa5kEc2+uWb+/xISXFXurHNo+cizr9pJb/P/tTe/zgahZkVnF1kYg5g==
X-Received: by 2002:a05:600c:4e8b:b0:414:f60:5d6a with SMTP id f11-20020a05600c4e8b00b004140f605d6amr4142782wmq.0.1711833039552;
        Sat, 30 Mar 2024 14:10:39 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id ay8-20020a05600c1e0800b0041559c59ee3sm2758210wmb.12.2024.03.30.14.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Mar 2024 14:10:39 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] pmdomain: mediatek: scpsys: drop driver owner assignment
Date: Sat, 30 Mar 2024 22:10:36 +0100
Message-Id: <20240330211036.100956-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Core in platform_driver_register() already sets the .owner, so driver
does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/pmdomain/mediatek/mtk-scpsys.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pmdomain/mediatek/mtk-scpsys.c b/drivers/pmdomain/mediatek/mtk-scpsys.c
index 59a7a8c261ed..1a80c1537a43 100644
--- a/drivers/pmdomain/mediatek/mtk-scpsys.c
+++ b/drivers/pmdomain/mediatek/mtk-scpsys.c
@@ -1138,7 +1138,6 @@ static struct platform_driver scpsys_drv = {
 	.driver = {
 		.name = "mtk-scpsys",
 		.suppress_bind_attrs = true,
-		.owner = THIS_MODULE,
 		.of_match_table = of_scpsys_match_tbl,
 	},
 };
-- 
2.34.1



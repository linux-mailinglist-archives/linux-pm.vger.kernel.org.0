Return-Path: <linux-pm+bounces-12339-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 016D6954701
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 12:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 840C21F22CF8
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 10:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94764198853;
	Fri, 16 Aug 2024 10:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XJP8UUWA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE3717BEB7
	for <linux-pm@vger.kernel.org>; Fri, 16 Aug 2024 10:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723805688; cv=none; b=sCDwHNqh60AV+06L2bNOCQceObPpJdhaGTNeLUfeAzfhl9vcqDGvLHe3RfA+ULPOds71MRZR4VdkxMOoJZhqGT0cSx7THv27J26JDgA/ge/pSR/HWe7CQAuY5D4UVHb7fuKE2dmQUUswtCM0oADtseli2Cn7yNEcSW8lgvyr/mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723805688; c=relaxed/simple;
	bh=2UwlDFsvx0FENZTR3WL94gVz3cLqUmxrINSyGxA/NxI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=J2MC5rxmBb5JL18KPFM7QmY8bf4odoWZ7n9omNmpoftJLca2RNan9swuOLi0cV2DZQkJXO/ssDmqY+YlcZlthJXMXN5b4UIsz3vSoDUOlrrxQXE8LRC/TiHmVOyikDIl1VL/YZ5R2vodRSdCwFfkNExD+6TAQSLYJQINEp9vmMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XJP8UUWA; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4281d812d3eso18462125e9.3
        for <linux-pm@vger.kernel.org>; Fri, 16 Aug 2024 03:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723805685; x=1724410485; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tYPp0NsTOxhLjR9Ww3ZqtUjI7/iF6gTBv/X0BXKx08s=;
        b=XJP8UUWADXaoLUikqjPKxwzSixzW0SAsfSdjKvhHP2dfpEVEqR65+JuibPbvBEItMv
         MssnsJ0w0P8GHKScKffjLz1kNl4zzbvjd37e7AriViwjhI66r6f6L0Om3QE2wchajpT6
         i/ArypEYMFXl25aT8od47qaj174bm4x7DRdnT0lOGVoLFeVt4jGnkqcLELM8CcRBX+9g
         OwBuJILJl7/IAQk/gDBm5EKbb37Eajy/B1nkNKyGv9qugZWeo0fj2nB89wzN1UbEFN8E
         eKRerl0k8daXqtN+zj3TRyuMuFk5Y1GOYq36MUwbiL0bXIXWuJATWRpkd00DGGXpacwM
         OGBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723805685; x=1724410485;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tYPp0NsTOxhLjR9Ww3ZqtUjI7/iF6gTBv/X0BXKx08s=;
        b=HqpGEa5EPtz/vvYOFeP2ejUtIug+u7aCRqaB6a4cz16WWCvYL+EMZAaGgr+jc0uiJt
         DDiD+tGUUCoE4Jqn5lmIAyw0b06NtF6ooghbHxI3tRFLzAtOYGMasjYsbvjnBKt2nfKc
         MfC/u9GZ1SO7OxR6KjDoshfi8A/wzzgQF+28LDfTcyODrmORsc+n0LY6D8e7q7ZNMGCq
         oMmMLSlfieueQZ1AZTyUwJjCH4VqCmu7AB6KNuVYimyLDCRCfKOcHClJ2ZOVCw04NZtn
         fJtmdfbmBX8m2iegaYF2dwkbL4cXI2vH+Ro2kIHThHIfOO0ry3EfasU/FkFONa5Gzbn3
         hoVw==
X-Forwarded-Encrypted: i=1; AJvYcCXdoCllRWG+E8mBiG162AtC3zg+sldDcDFhIlNvk4ipkwCRx8DG8L5tIj9Chbyppu41Mn1tyTrBnvnePp3noXrefuVgdo05aYc=
X-Gm-Message-State: AOJu0Ywv6/VdrlOUb4HCWL/6CJ3l2Zp7Nfo/HoI68l6Gd4leoZa4mM6v
	0zGTjb25mVDY5A0/1FNOyFkW4LEmT7FH/3z8Cf4B6EtoO1DK9Dvki6GgIj8YVr8=
X-Google-Smtp-Source: AGHT+IHHvawl5XEfEGL+I6Vq39YTQapEbBWFGCGvUkRJ46B0XFDy0y8IVU67kRwXPNSR2rjsEPylrA==
X-Received: by 2002:a5d:5592:0:b0:368:4910:8f43 with SMTP id ffacd0b85a97d-3719431561emr1605829f8f.3.1723805684861;
        Fri, 16 Aug 2024 03:54:44 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ed7945cesm19461935e9.40.2024.08.16.03.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 03:54:44 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 00/13] memory: simplify with scoped/cleanup.h for device
 nodes
Date: Fri, 16 Aug 2024 12:54:24 +0200
Message-Id: <20240816-cleanup-h-of-node-put-memory-v2-0-9eed0ee16b78@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOAvv2YC/42NQQ6CMBBFr0Jm7Zi2SgVX3sOwqHQKk0BLWiAaw
 t2tnMDle/l5f4NEkSnBvdgg0sqJg8+gTgW0vfEdIdvMoIS6ikoqbAcyfpmwx+DQB0s4LTOONIb
 4QWu1JfmqVS1vkBNTJMfvI/9sMvec5rw73lb5s3+GV4kCS6FLU7mLllY9BvYmhnOIHTT7vn8Bt
 jdD6skAAAA=
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Lukasz Luba <lukasz.luba@arm.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Santosh Shilimkar <ssantosh@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, linux-tegra@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2028;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=2UwlDFsvx0FENZTR3WL94gVz3cLqUmxrINSyGxA/NxI=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmvy/kBBEqhpXjMi8XcGTKE6afT4vE1o4FulDg7
 ujMEz51mUOJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZr8v5AAKCRDBN2bmhouD
 13OgD/9Lao5pfe/Gv4e/sGD9rnGL0Qq9TO3361aYYrL3qW/oHUal1cCVeioK8fpPY1cjlnPkrJP
 wPr86G2hVX9eXMeCqkVR/btO/AMLqD1UyoZm96Chr/n4wDstwJSYlpOiMBugsFQS9wjpQmyRtRG
 JhJCc5TZMVUbkDQIHdnf63dXnACBKmZbQ0vf05z37T4TUbS2fhVizHcfdVCPvmpi81KqfpZ+Brk
 0pjnfQP3/AwPwCJvAnCK+Ww8w7RhqwblPscpq4FkzILrIAsmQpkWQe9XaVbXfoIICXo2HqU6FvB
 8vgDjAhIfJGX2aSLx2V//vwwUr46mxv52jfT9/wp3WA8ROHttQXJpuMkJZ0cmvvwytm6omt/wAQ
 iqqMA4+fBetSJlZCmQo03dNlCFpOZzHNQ0io/S8I0ATFF7UsZfmquheffuxHVmrq2fzUHYU/U94
 i55XKETUwW84kNWHIlVWiRzSUuO1Ixve62gmEGn8R2TESeXG+/gsIzijXhl3+fyEMLm+Qlo9zlA
 xMxPsl/vBLEZD3TBbi87+gtmwS+zujDEuOKeQk3iKabX3qi0NZIVHNQaup7oRNiyp07B7VbkHxm
 8lJsfKFWWVvzZwV0f91GuFjn+dsdhK7eHcYDFUlVQDFL5dNhgRo51OKT4/HvzmBPYgvPb6ny3m4
 LUM1YTR6ADFfZAA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Changes in v2:
- Add tags
- Wrap lines before of_parse_phandle() (Jonathan)
- Few new patches (see individual changelogs)
- Link to v1: https://lore.kernel.org/r/20240812-cleanup-h-of-node-put-memory-v1-0-5065a8f361d2@linaro.org

Make code a bit simpler and smaller by using cleanup.h when handling
device nodes.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (13):
      memory: atmel-ebi: use scoped device node handling to simplify error paths
      memory: atmel-ebi: simplify with scoped for each OF child loop
      memory: samsung: exynos5422-dmc: simplify dmc->dev usage
      memory: samsung: exynos5422-dmc: use scoped device node handling to simplify error paths
      memory: stm32-fmc2-ebi: simplify with scoped for each OF child loop
      memory: stm32-fmc2-ebi: simplify with dev_err_probe()
      memory: tegra-mc: simplify with scoped for each OF child loop
      memory: tegra124-emc: simplify with scoped for each OF child loop
      memory: tegra20-emc: simplify with scoped for each OF child loop
      memory: tegra30-emc: simplify with scoped for each OF child loop
      memory: ti-aemif: simplify with dev_err_probe()
      memory: ti-aemif: simplify with devm_clk_get_enabled()
      memory: ti-aemif: simplify with scoped for each OF child loop

 drivers/memory/atmel-ebi.c              | 35 +++++--------
 drivers/memory/samsung/exynos5422-dmc.c | 90 +++++++++++++++------------------
 drivers/memory/stm32-fmc2-ebi.c         | 23 +++------
 drivers/memory/tegra/mc.c               | 11 ++--
 drivers/memory/tegra/tegra124-emc.c     |  7 +--
 drivers/memory/tegra/tegra20-emc.c      |  7 +--
 drivers/memory/tegra/tegra30-emc.c      |  7 +--
 drivers/memory/ti-aemif.c               | 48 +++++-------------
 8 files changed, 80 insertions(+), 148 deletions(-)
---
base-commit: cf4d89333014d387065aa296160aaec5cec04cc5
change-id: 20240812-cleanup-h-of-node-put-memory-dd6de1b92917

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>



Return-Path: <linux-pm+bounces-1189-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A87813A0F
	for <lists+linux-pm@lfdr.de>; Thu, 14 Dec 2023 19:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 062571C20BAD
	for <lists+linux-pm@lfdr.de>; Thu, 14 Dec 2023 18:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A2B60B81;
	Thu, 14 Dec 2023 18:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YdVCRKG8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E064D112
	for <linux-pm@vger.kernel.org>; Thu, 14 Dec 2023 10:36:48 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-50bf2d9b3fdso11469855e87.3
        for <linux-pm@vger.kernel.org>; Thu, 14 Dec 2023 10:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702579007; x=1703183807; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E2agBAQIISiGm5BjQKQDZLX7+yyTNUH3OxJ2AW1m180=;
        b=YdVCRKG899iNweKUAeh3gBh7CoD2htMTRTawc6xAaDRYh1ZI6H4s9zvHdThihTpcSb
         CwgUF1/DAVgd8lgNazxq1fa6C8iNQI95X6cyZkSm5cKxuZALTNraqQtgma2nXPPqr1U6
         GYr1vYB9Xz03IvaQjlZdV8x/IYFVH/wtmLD3NRTFTBfRqkzsLputmcjbGkzf8POaCESx
         3nLk6x+g53/rFbtBY781C+tpNPCilkzyO3reXLfyL5aCyJS16xniQ78ITApjDuxWhAIS
         WYgGQxQQuVe4/uYgiUGB267wQ3uGKDeLBpdxA0AKbAxeqtBcyAWzGd0KU39ix+qok6ko
         CDKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702579007; x=1703183807;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E2agBAQIISiGm5BjQKQDZLX7+yyTNUH3OxJ2AW1m180=;
        b=F4U37WG3IAjaEgdDoc6gNEe4OpBF/QO0STi3LBDa4hpYukpH+gpwn4s5wB9BlRwzT/
         HKbcAdMHsiq8kdSejKj2Q9QNL4yXiQMHbMvDKdcnXEqB1YGddlwLTedWOX3gA6n8p7M+
         x9figagEjTuCqCMdwvhrVnWlRy7W4JEcvD3cJEnU3srPRoqVuTaxVayoaji1zXxhnPv8
         7vPN49OJa1yL1iPqj65Jgt0GFUg+oD3txJ52zNBaQbLky7Y83KIrGcntytiKXwoaeb5z
         01MUKvuh1seJxVuUhI7uLnRgh7L8TLQgDqTaRFIZ49+HZnDfFA2QM2J0vvgo+zwwbTcs
         pSQQ==
X-Gm-Message-State: AOJu0YyRNXJBj4IE4zOEARnzYN2jjt3a2nV6FtxyuNf3jqwG7ur3y0mY
	ernFHtrEoocgrJuvA+5CuFGEINgEDx853YzoDMLUxg==
X-Google-Smtp-Source: AGHT+IGQMIUz/OELOVckBLP40+nDk50xRpbqd8QsbgXNin9cwtwb49ZEcf8JzeGg38O4QPZGSyTpiw==
X-Received: by 2002:a05:6512:4db:b0:50b:ed58:584c with SMTP id w27-20020a05651204db00b0050bed58584cmr4541681lfq.124.1702579007106;
        Thu, 14 Dec 2023 10:36:47 -0800 (PST)
Received: from [127.0.1.1] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id k11-20020ac24f0b000000b0050ab2d4d7cbsm1943828lfr.19.2023.12.14.10.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 10:36:46 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Thu, 14 Dec 2023 19:36:41 +0100
Subject: [PATCH] interconnect: qcom: sm6115: Fix up includes
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231214-topic-6115iccfix-v1-1-9ad999683a7d@linaro.org>
X-B4-Tracking: v=1; b=H4sIADhLe2UC/x2MQQqAMAzAviI9W7BzCvMr4kFr1V5UNhFh+HeLx
 wSSDEmiSoKuyBDl1qTHbkBlAbyN+yqoszG4ytXkyON1nMrYEjXKvOiD7eIbCqEKkxBYdkYx/S/
 74X0/kqmUOmIAAAA=
To: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Georgi Djakov <djakov@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.13-dev-0438c
X-Spam-Level: *

Remove some unnecessary includes and get rid of the abusive of_platform
in favor of the correct headers.

Reported-by: Rob Herring <robh+dt@kernel.org>
Reported-by: Georgi Djakov <djakov@kernel.org>
Fixes: 2eab57b131bd ("interconnect: qcom: Add SM6115 interconnect provider driver")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/sm6115.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/interconnect/qcom/sm6115.c b/drivers/interconnect/qcom/sm6115.c
index c49a83c87739..88b67634aa2f 100644
--- a/drivers/interconnect/qcom/sm6115.c
+++ b/drivers/interconnect/qcom/sm6115.c
@@ -6,16 +6,12 @@
  */
 
 #include <dt-bindings/interconnect/qcom,sm6115.h>
-#include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/interconnect-provider.h>
-#include <linux/io.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
-#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
-#include <linux/slab.h>
 
 #include "icc-rpm.h"
 

---
base-commit: 11651f8cb2e88372d4ed523d909514dc9a613ea3
change-id: 20231214-topic-6115iccfix-6f4519909be1

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>



Return-Path: <linux-pm+bounces-1299-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DEFF8176C7
	for <lists+linux-pm@lfdr.de>; Mon, 18 Dec 2023 17:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0653282670
	for <lists+linux-pm@lfdr.de>; Mon, 18 Dec 2023 16:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5E171469;
	Mon, 18 Dec 2023 16:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q7zJpdoY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286BE5D75D
	for <linux-pm@vger.kernel.org>; Mon, 18 Dec 2023 16:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a22f59c6aeaso393070366b.2
        for <linux-pm@vger.kernel.org>; Mon, 18 Dec 2023 08:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702915351; x=1703520151; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sxy5gxd9WgX/1XXZmcDuoy9fxNWpJ2waJT/hDOrUyLQ=;
        b=Q7zJpdoYCjuikLscqUvzEXbL7sRdGSxdTV0XBiNPa7ac4sn0zpd8kat/F/RHDUzKW/
         l0fjAQAGD8VaiMj8ztygs19LHdGuQloW9nZAwNuJIBInxgNSAoJJLLD84z6tnxbN3bCd
         PJsQqOxeuPGIfXUm6auqLxTd6Qd9c4ztDI7w0hdqW7s4tjMJee7Npts58C340DohD2EV
         /YRs1fDYAlhD7TydlI9KXT3Ehz3mxREntRz0c6VXKtvCwZOW9rjsBDsstcEd20HNyxij
         4L3Z6wNDxvyq3KkngPSha6//G/SU4Yz1d/XO/lYur4vpSarQ1Ll1Eg7Txvhl1BsjVdSx
         yLAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702915351; x=1703520151;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sxy5gxd9WgX/1XXZmcDuoy9fxNWpJ2waJT/hDOrUyLQ=;
        b=h3DjttCIopMG/21+6Z2EsleoAgUYI5wDQ46Jc9K9mACt51Zmu5CbZYJXnOWqgjkMP6
         dX3reqMtaV0ULaQQ+uUA2iEcF+bN3y07ebAORQFPl3Iuz54lmbobPjYHwyOGk3CXBRfm
         XE5TlhR1L3YnK+RWBZBXDxzhVq8viTvcIuhjWR9xb2bnAhkxO/dLRqy5HrsKb3ztpQe+
         XoVA3og58X3BlUOtlIhqqdjMm5EdV0ZUbz7KH4D3QAhQ8/FJZ7VmumgnJ8Tqwjrg5BsJ
         XGzfyUtJ+UN8eIlhb29f4ITMEm5YjOtYMpAV+gVfsh/NFy6iTQiiynYnsprt3aYiiGx1
         olMg==
X-Gm-Message-State: AOJu0YxYiyajnBJhSp4gB41/voyT7Cjo7kkqn4lE5SaG6+RulM9zLWxD
	UPR6Q1yMmfnHAZPOsUl4l7AuUQ==
X-Google-Smtp-Source: AGHT+IHJ6MZS2cN8lT0WcCi3rQBgJZ1sxp49j/86r1zoFSRgnH9Y8segI9yzqQhF+3KkiWJxZGXHtQ==
X-Received: by 2002:a17:907:1a55:b0:a23:357b:5ace with SMTP id mf21-20020a1709071a5500b00a23357b5acemr1284144ejc.19.1702915351393;
        Mon, 18 Dec 2023 08:02:31 -0800 (PST)
Received: from [10.167.154.1] (178235179137.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.137])
        by smtp.gmail.com with ESMTPSA id ts7-20020a170907c5c700b00a1dd58874b8sm14260693ejc.119.2023.12.18.08.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 08:02:31 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Mon, 18 Dec 2023 17:02:08 +0100
Subject: [PATCH 07/12] clk: qcom: gpucc-sm8550: Update GPU PLL settings
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231218-topic-8550_fixes-v1-7-ce1272d77540@linaro.org>
References: <20231218-topic-8550_fixes-v1-0-ce1272d77540@linaro.org>
In-Reply-To: <20231218-topic-8550_fixes-v1-0-ce1272d77540@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Georgi Djakov <djakov@kernel.org>, Abel Vesa <abel.vesa@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Taniya Das <quic_tdas@quicinc.com>, 
 Jagadeesh Kona <quic_jkona@quicinc.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702915332; l=976;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=q/YWhe5rzcUAmIFXqSmcshP5410IbnXzatBPzE34Z1U=;
 b=ls2LT4NdvgbEWszZcqguVQIutVml18NyUafbddPc5km0Vmg6JEz8pXhPg5v3vdlrhMV2bzNZ/
 1scuV2kyQ2EBMTI8FvVLZ+iqp4nvlng2slRNpPC6i/8ziBxfIL8satV
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

The settings in the driver seem to have been taken from an older
release. Update them to match the latest values.

Fixes: bfae40744b33 ("clk: qcom: gpucc-sm8550: Add support for graphics clock controller")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/clk/qcom/gpucc-sm8550.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/qcom/gpucc-sm8550.c b/drivers/clk/qcom/gpucc-sm8550.c
index 420dcb27b47d..2fa8673424d7 100644
--- a/drivers/clk/qcom/gpucc-sm8550.c
+++ b/drivers/clk/qcom/gpucc-sm8550.c
@@ -35,12 +35,12 @@ enum {
 };
 
 static const struct pll_vco lucid_ole_vco[] = {
-	{ 249600000, 2300000000, 0 },
+	{ 249600000, 2000000000, 0 },
 };
 
 static const struct alpha_pll_config gpu_cc_pll0_config = {
-	.l = 0x0d,
-	.alpha = 0x0,
+	.l = 0x1e,
+	.alpha = 0xbaaa,
 	.config_ctl_val = 0x20485699,
 	.config_ctl_hi_val = 0x00182261,
 	.config_ctl_hi1_val = 0x82aa299c,

-- 
2.43.0



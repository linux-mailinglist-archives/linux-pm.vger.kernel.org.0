Return-Path: <linux-pm+bounces-1302-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B3D18176D6
	for <lists+linux-pm@lfdr.de>; Mon, 18 Dec 2023 17:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19751283A8E
	for <lists+linux-pm@lfdr.de>; Mon, 18 Dec 2023 16:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199B173479;
	Mon, 18 Dec 2023 16:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jdTY6RjT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B3D72042
	for <linux-pm@vger.kernel.org>; Mon, 18 Dec 2023 16:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-553032f17cfso2405754a12.0
        for <linux-pm@vger.kernel.org>; Mon, 18 Dec 2023 08:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702915356; x=1703520156; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Lr4/3tTtpC0alkBdqQYjbL4EKBHF7J4Yz0/1JYgEAE=;
        b=jdTY6RjThlBQtv9E08EZFnofWPWgetFsWJSyoKs3YOpq/jCxBWtJ5lKAjvJuY1ZDRO
         3Au4tDyL6yjysBY9WhDPrFG1d3yg3tnmLVDQwYFekziVagenRM1WgSe8+OlOo0UwBjas
         ZK5X7r3+TITJ7v8S57h3jeaqo0cuKStBUaUuc9OmmD2YSxtm+WPW0F/UhgX6gJqRf2xB
         VyInpPSeE1uY+zVSLwzoPVQPH3NJUHjJvzA6qnadP37dimgSxwg1+8cTYYLW7PqoIStN
         5D4blLrO8YKpZhHBwlUrbYxJM335Y0sKgzn4O1I9CB1xEL5rXn1u9GIslKyLjep9AsXp
         sVxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702915356; x=1703520156;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Lr4/3tTtpC0alkBdqQYjbL4EKBHF7J4Yz0/1JYgEAE=;
        b=QYsDFk/qwCjfsRI4CB5eoz50dtEFjypVn+jwJqwLnN6tDYN2ETmWQUExQR59ltiaxA
         ImIy+niLqTJ+VHqjsIdQpokmGChwr67kVTt5TY8G7g7e7B8AjK/849CmecCB0eQ8UnHV
         Zb9Sk2JzNxYT/6SbF4UfA5CO/we6zTjF9atXMy0i2JgdOWIhPwuP+wlmPQHmSRtH0vYo
         tvBHSv9T7oQ38x0IowGRrfY6WIw4kWMPRlhNqFcvJYNO53B4XOkFA+gI2bsCbUOp0kcM
         ezwaAVWV50GwCStNdLpX5crJfJwil0f5K9ekldzM+T2VGoSOvy5GseQYIJqeUe2f9H4U
         arDQ==
X-Gm-Message-State: AOJu0YyJYUs0TBUq/frmE2QIJqK++tKJxoGSS5/T+WW92W3HwemnfOqP
	dVMDqJFuLmTNtyiG0jvk7QAn5g==
X-Google-Smtp-Source: AGHT+IFWH9gBYMv4BN//69QHcLFPlkr31TmGuhi3zUoMx4/hQzAxGzdzksTbClDwmhXy2r5Gqc30WQ==
X-Received: by 2002:a17:906:738b:b0:a23:53f8:c956 with SMTP id f11-20020a170906738b00b00a2353f8c956mr1064827ejl.42.1702915356251;
        Mon, 18 Dec 2023 08:02:36 -0800 (PST)
Received: from [10.167.154.1] (178235179137.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.137])
        by smtp.gmail.com with ESMTPSA id ts7-20020a170907c5c700b00a1dd58874b8sm14260693ejc.119.2023.12.18.08.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 08:02:35 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Mon, 18 Dec 2023 17:02:10 +0100
Subject: [PATCH 09/12] clk: qcom: dispcc-sm8550: Use the correct PLL
 configuration function
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231218-topic-8550_fixes-v1-9-ce1272d77540@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702915332; l=1105;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=BezfhwpPbu2OXB/cs1cE9HqGLwlCqC3inKfbOziVm0c=;
 b=lFwlgq/K3vI5bmFpk3rOzJs15h2tiwVlS/Qhbp0zr3302E4+6rk62164CD/vcWTej6KDxsuRc
 NkjQvQgPr8UCQCrnXyN2VgSMEFYQttKkre1M2BcsJXZ/gUoaYd9Mqwm
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

To ensure that all fields (particularly CAL_L and CAL_L_RINGOSC) are
filled properly, use the correct prepare function for OLE PLLs.

Fixes: 90114ca11476 ("clk: qcom: add SM8550 DISPCC driver")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/clk/qcom/dispcc-sm8550.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/dispcc-sm8550.c b/drivers/clk/qcom/dispcc-sm8550.c
index 0b8f0904b339..f96d8b81fd9a 100644
--- a/drivers/clk/qcom/dispcc-sm8550.c
+++ b/drivers/clk/qcom/dispcc-sm8550.c
@@ -1774,8 +1774,8 @@ static int disp_cc_sm8550_probe(struct platform_device *pdev)
 		goto err_put_rpm;
 	}
 
-	clk_lucid_evo_pll_configure(&disp_cc_pll0, regmap, &disp_cc_pll0_config);
-	clk_lucid_evo_pll_configure(&disp_cc_pll1, regmap, &disp_cc_pll1_config);
+	clk_lucid_ole_pll_configure(&disp_cc_pll0, regmap, &disp_cc_pll0_config);
+	clk_lucid_ole_pll_configure(&disp_cc_pll1, regmap, &disp_cc_pll1_config);
 
 	/* Enable clock gating for MDP clocks */
 	regmap_update_bits(regmap, DISP_CC_MISC_CMD, 0x10, 0x10);

-- 
2.43.0



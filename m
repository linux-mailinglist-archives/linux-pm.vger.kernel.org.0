Return-Path: <linux-pm+bounces-2433-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9062835D2C
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jan 2024 09:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C8621F21392
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jan 2024 08:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831EC3C495;
	Mon, 22 Jan 2024 08:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eYbE4gQ8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C988339FC4
	for <linux-pm@vger.kernel.org>; Mon, 22 Jan 2024 08:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705913251; cv=none; b=nOVV4YBOoRGaUmOpAeLFwWR+Vwme8mLgylNYwKG9xsBmHS9+Or5EFUFyDTIqifXJRqCL1p5VzTS3BNkRk9M0wgfz96fR1zHiIYljQxzZ6/SxOzKwEqog0KQ91/MUUU361UwLMn2WSJ4JQdcn1xNwPSTMEtzZzbd356avgEJKRDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705913251; c=relaxed/simple;
	bh=xVzk6PcGz8JGRaQpKhkaEOsaJx+PBVqpDgR2m0MxeLk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f1Mqkk8+Yr2MmScPp8a1WSseGZY12QS4FKhSlzDqPukxhFmC0rXXBNqn/v92LagVNNNvsAXawyR9OwVDnij98+X0aZr0+PgIL9b7UZxoLFWbJ7oOzacQ0EVeoxRMDiNZ3/OfLWjIJX/3FzQPY++tkiaAizskHIHClZ4FoLhtVEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eYbE4gQ8; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-50e7e55c0f6so3006042e87.0
        for <linux-pm@vger.kernel.org>; Mon, 22 Jan 2024 00:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705913248; x=1706518048; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OVJFY1Gxb1ISOb6T1YpgtOq7AUto91S3jCAoBzpivuk=;
        b=eYbE4gQ8Ca3gplIKySq8aNLbws3D/hpNMbjU5vTlN5+msw1xEfMhfqSgwx26mStjvN
         tgPcOl/4JLxr3X5jAsPvYuDCwAARJwpqXzQgW3OpkYhwABXeipNSjixflVf7zwO/qI9m
         /qETkmVvv1DPZj8Ozaxr9ppcznOP/DlZLXSjIZ5mq7kiFR4H1qPJY8My1aJNy5TmMTgh
         8R4nZa+uW5nqXFMMPELUL/NILoyAqrn60q+XPJglQaN5QCSYgiC+8WWuULDiYvUek0GQ
         h8w+oxlllbmsb0zoET+BLU+bwYOocheryNnrQkMqcE7JyiulN7WrbWOdmZhky3OX5nYP
         wfFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705913248; x=1706518048;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OVJFY1Gxb1ISOb6T1YpgtOq7AUto91S3jCAoBzpivuk=;
        b=k0aDICeZF0ZrJx1B6kto/Kpgkt1to/D+FVi8ajTMlA5ZHjq3ECTwlmB9L7Dy0gnnYS
         TuIqg2aPeyNY6QvqoNy9Ai1YkQ2+ay/JsMpH7TzRk+n70nfYGRhdz8rK3T7+Qb9rq0vQ
         h/Nh3/haZi36ajcTxIJAZdklhDBNauXN0HsjhD+yiu7vDN6drZfHVsX6DAYwRFpaPPcx
         spwMo18ZNXP2a/2ahs8BEJ8DY94dGI6ftssQiUR3/u02LcF2wLYYFmgq+bl7ltuGRSyV
         MKV7ts7rheNzpdzw2hwrNGMDLBtJ2dee8WpAZT3ZXJY6Qtwe2pCcGWhdf849AE4rABaE
         QeMw==
X-Gm-Message-State: AOJu0Yxc7fzqhJwq9g0pqRSR2LjSd2Y2TOT2/MHj934YLjZdKUQMz3bB
	ildlyHoK731ZzUOB1z8Sf1KNHy3Sq4iMKpNRdiq77jOkCIFHbq0h6//FlPd+RVo=
X-Google-Smtp-Source: AGHT+IH/KI+Kzl2B3+hffoLruNLFgjK0bHIZu/vI347YVryY+UTXpJWkfMGIUuje6yIVTDrMg4X3Dg==
X-Received: by 2002:ac2:4c8e:0:b0:50e:e8f0:2298 with SMTP id d14-20020ac24c8e000000b0050ee8f02298mr542781lfl.267.1705913247775;
        Mon, 22 Jan 2024 00:47:27 -0800 (PST)
Received: from [127.0.1.1] ([79.115.23.25])
        by smtp.gmail.com with ESMTPSA id b21-20020a17090630d500b00a2c4c23cd12sm13075462ejb.217.2024.01.22.00.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 00:47:27 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Mon, 22 Jan 2024 10:47:04 +0200
Subject: [PATCH v4 4/5] clk: qcom: Use HW_CTRL_TRIGGER flag to switch video
 GDSC to HW mode
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240122-gdsc-hwctrl-v4-4-9061e8a7aa07@linaro.org>
References: <20240122-gdsc-hwctrl-v4-0-9061e8a7aa07@linaro.org>
In-Reply-To: <20240122-gdsc-hwctrl-v4-0-9061e8a7aa07@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
 Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Bjorn Andersson <andersson@kernel.org>, Andy Gross <agross@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, 
 Vikash Garodia <quic_vgarodia@quicinc.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Taniya Das <quic_tdas@quicinc.com>, Jagadeesh Kona <quic_jkona@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-media@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1921; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=6YCTgAGeGVs43KDgKfImSE+xArUbcRShc9pkDKKCCac=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlriuThQApLjd1pjc0SdaYfQW02n40AeD/XJR+z
 EpLTRfM6lSJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZa4rkwAKCRAbX0TJAJUV
 VuO0D/9bQL9I/1mXOi9y2EWRygpuPvCo8p5viVHdlpIlMLffd033I+1m1se6bQFzuE3XqUHRnG6
 N61rhS/f7QSFl1jIDuLx7vpPG7K8woM/Hv9pLQtwKiXL4eF+kriPmghr4n3rwQcHWL34LE7Rx7E
 VkcFcGMU39MW1hlDQcZJ7/QDLr+hYzci2WOa1hEwBGDSuNH2PlS/KpgHp6PCoENc1mOECqUEfXt
 pwArCw2vNk3isDW2nSjRFzlPWi7PuHsu+tVDlCfdo/BJ8jlhdWYIkZYHKtkDYAgvqbr4wWk9eq7
 BPDmuaheBI1tzurdSqotPdLvp8MT4L0w5tqXkeGtAcEzIK3r5v56lv/e+l71QVdGR8eMJTx43UY
 gi6FQsVEDCiCoCuG3H2FEi9bqHmrUjuAUsUCf5lF6j6LILX4vjxQIrwNUqh8s4N18kJFqtNUUgu
 rskjr98Kj2YI8FbEB4OTAxSVeov9u5uhAgmwLLYNhMRv1/uqI/lr5vnFRaoc+2iAhopnduwESy0
 hSNJfrOu/ClI1dK2aMkP9QpN+/CEvuUxRq385IWt0mgnUuAH8q1YzbeMbTxVBwzFsQF8xvWVNFd
 BGU3F0ZIvXeHHkWqPYAezxuHN797gpX5V1nfW3T9uRmjlRZ85cL4uiMwHmpVU/U52Rzebq93bek
 5V7vYbPOWxgsl1A==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

From: Jagadeesh Kona <quic_jkona@quicinc.com>

The current HW_CTRL flag switches the video GDSC to HW control mode as
part of GDSC enable itself, and HW can disable the GDSC right after the
GDSC is moved to HW mode. This can lead to subsequent video clock enable
failures that are dependent on the GDSC if GDSC is collapsed by HW. Also,
while few video hardware registers are being programmed by TZ, GDSC
should be in non collapsed state which can be achieved by keeping
it in SW mode.

Use HW_CTRL_TRIGGER flag instead which allows consumer drivers to switch
the video GDSC to HW/SW control modes at runtime using
dev_pm_genpd_set_hwmode API as per the requirement.

Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/clk/qcom/videocc-sc7280.c | 2 +-
 drivers/clk/qcom/videocc-sm8250.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/qcom/videocc-sc7280.c b/drivers/clk/qcom/videocc-sc7280.c
index 615695d82319..3d07b1e95986 100644
--- a/drivers/clk/qcom/videocc-sc7280.c
+++ b/drivers/clk/qcom/videocc-sc7280.c
@@ -236,7 +236,7 @@ static struct gdsc mvs0_gdsc = {
 		.name = "mvs0_gdsc",
 	},
 	.pwrsts = PWRSTS_OFF_ON,
-	.flags = HW_CTRL | RETAIN_FF_ENABLE,
+	.flags = HW_CTRL_TRIGGER | RETAIN_FF_ENABLE,
 };
 
 static struct gdsc mvsc_gdsc = {
diff --git a/drivers/clk/qcom/videocc-sm8250.c b/drivers/clk/qcom/videocc-sm8250.c
index ad46c4014a40..c1b73d852f1c 100644
--- a/drivers/clk/qcom/videocc-sm8250.c
+++ b/drivers/clk/qcom/videocc-sm8250.c
@@ -293,7 +293,7 @@ static struct gdsc mvs0_gdsc = {
 	.pd = {
 		.name = "mvs0_gdsc",
 	},
-	.flags = HW_CTRL,
+	.flags = HW_CTRL_TRIGGER,
 	.pwrsts = PWRSTS_OFF_ON,
 };
 
@@ -302,7 +302,7 @@ static struct gdsc mvs1_gdsc = {
 	.pd = {
 		.name = "mvs1_gdsc",
 	},
-	.flags = HW_CTRL,
+	.flags = HW_CTRL_TRIGGER,
 	.pwrsts = PWRSTS_OFF_ON,
 };
 

-- 
2.34.1



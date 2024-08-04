Return-Path: <linux-pm+bounces-11889-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1EA0946C83
	for <lists+linux-pm@lfdr.de>; Sun,  4 Aug 2024 07:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F0781C21557
	for <lists+linux-pm@lfdr.de>; Sun,  4 Aug 2024 05:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE30E55898;
	Sun,  4 Aug 2024 05:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qeZ2+f0f"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C09647F53
	for <linux-pm@vger.kernel.org>; Sun,  4 Aug 2024 05:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722750039; cv=none; b=IbPfGdO/w0c+0bcjdwlgI2KSJRz5dpVpoVOIPukiti7b4Oh4MgX/UlWnd3347MuOOJWw3zAYHpw5dhy7w2flRbU17IxPaMKcmPDSpnPJ3ZVcQxLmmFmRRf+5cykyZMQZnofj1qYYKvmHw8ufFAx3cA5TlSist8eLPTCbj4WmtrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722750039; c=relaxed/simple;
	bh=7W77DHzgi+hLXIXlbdxA6fq9mb4+K6aSLuzwwza3sX8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NvphbyM4//vjGxb3vABtHY64ztQv36V6r2TSE/l0Hibc1iKvkZfRIXaJU285S44YjA02yLk6VC5BQ5CRbN/J4z/8dIL2pcb1AaOgZncU4yIj1tJsdi1giKGKWuQUAccOerRaDF/s1lN4X1NzpzHDTcUG7/y3iEftcZjncr4Dp0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qeZ2+f0f; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52efdf02d13so15563707e87.2
        for <linux-pm@vger.kernel.org>; Sat, 03 Aug 2024 22:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722750036; x=1723354836; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XXeR89FVIJZ1QYlIHMei/0fKATGUZGncxK0+auVBf0M=;
        b=qeZ2+f0fXMt7i0RjEU+X1AJuVC+Xy1/PJGXxy+VOmWjAxaqCoiDvEaLpdypRih/ss8
         BNzuwA+0ghCFVA99lvSAogEW+DyTfg5rFgAJqyiZMx+Dz8TdvddhJGoAG4UXp7th12vG
         PMfHs6lX24aSagYEvqgFweOYYeRZTKo7QcvWufAYiYLSM3CfvERw2A0N04H5XqsWDYMA
         70Zvi2TtdL25acjgbEI9UT9McpKKFtQ8kokVqtU2LTT+i/9G72rD5gExHwfvF4fCcbdM
         W71a8XJ/aUuGU3Mpor9hjfh7jarGiCy1GUuPW5ADWDngsCuji4cXb/xg93h9nvEazOrp
         ejJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722750036; x=1723354836;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XXeR89FVIJZ1QYlIHMei/0fKATGUZGncxK0+auVBf0M=;
        b=om3b8VEGAHVD+MSrUFxEIy9r0bBC5Jdi+4z5b3GPK3dPE5UsrJxk6v9DQBmW14Boyf
         SjABVhcJsPiOnkjdbePMaWxPquxECfw8rXibZS6Q1kXn0cdiBnmwO4DX5xQK27HcjhQm
         AWsutPc3Kqj4S8sdPFRWSM0zgDweZibFwH92J5QBnWEARNLBmVCYHuyIJDdWGRlAIiVq
         dH0KQp7U4B4quk4WXIwL4s1AVszll2ilcJWOC8Oish0kxuBa0ZcXAlZqzKlAt66XtlQL
         p4TSNgJtdTC1aQeXq8IcoR8d3u94bxDJzUJRDXvzxMBIAzB7pWlNoZ38tI0AaSarLEIl
         Av5Q==
X-Forwarded-Encrypted: i=1; AJvYcCV+8FlBDhoQV9KoGbYerGxla3wTf2A4iSNz/BQLsP5p7Auj25SSRE9h6Ym76obVPe0makTcBUkkpNzlOeetgel+lL1/S3hlHVo=
X-Gm-Message-State: AOJu0YzqidQEPZMdjsugz7KBwueHPYZICgFYQkIu/Nq+p3DaaB0HPxlk
	xRNYvTiz320peykHSzDq1IKbG0N2KnDtIYkr7YOEntFr4f3QyyDYRcoRK60exqE=
X-Google-Smtp-Source: AGHT+IEzUJcr2/eYzNRxco80M9GSQYJGQHfmdybo4///4ibYBJxjdyGj5/rEDh0x2sR8bPV+/8p/Qw==
X-Received: by 2002:a05:6512:ba3:b0:52c:df8e:a367 with SMTP id 2adb3069b0e04-530bb3bbfd1mr6797281e87.53.1722750036270;
        Sat, 03 Aug 2024 22:40:36 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9bc3bd7sm292248466b.34.2024.08.03.22.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Aug 2024 22:40:35 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 04 Aug 2024 08:40:15 +0300
Subject: [PATCH 11/11] arm64: defconfig: build CONFIG_REGULATOR_QCOM_REFGEN
 as module
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240804-sm8350-fixes-v1-11-1149dd8399fe@linaro.org>
References: <20240804-sm8350-fixes-v1-0-1149dd8399fe@linaro.org>
In-Reply-To: <20240804-sm8350-fixes-v1-0-1149dd8399fe@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Jonathan Marek <jonathan@marek.ca>, 
 Robert Foss <rfoss@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Georgi Djakov <djakov@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Mike Tipton <quic_mdtipton@quicinc.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=769;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=7W77DHzgi+hLXIXlbdxA6fq9mb4+K6aSLuzwwza3sX8=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmrxQ/eMRA4Offoaww9Ngbll18r3n+dpMYOd4zk
 1LX05cPA76JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZq8UPwAKCRCLPIo+Aiko
 1fvWB/0R2sNi/9ToQYvmH1y02gU7itzPPtSuSYTjQe3wK3HxfagVOQ+PRhSPWQVs0A7TkiFTAHF
 2zh+KOHutngVNaCrW4/J1z9Ht75Z9yBk+oNzuoS7RHXtc3eXoyfBT3NXaRX5+sCBTlSGF5VX2ee
 njIFhdPDBBM4U2DdRC/bt8XEiT3OvUf89NWxoRJG87uH2jrv+mkWUiTMejKzpM9GynjmEJMI/+j
 XqromIoKcDYND0GkXZcw/4iuOoU2bOmcX7CJq5vbAX8NN2LmJCIJ2PGlyYQKzLBy1U01AXPK2KV
 6+EDFfDZfRvpa9dICunQw3XJDPHE1krN5s3aTxCHpt7law+D
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Enable CONFIG_REGULATOR_QCOM_REFGEN and build it as a module. It is an
internal supply used by the DSI on SM8350-based platforms (e.g. on the
SM8350 HDK device).

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 7d32fca64996..20e07ceaf239 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -785,6 +785,7 @@ CONFIG_REGULATOR_PCA9450=y
 CONFIG_REGULATOR_PF8X00=y
 CONFIG_REGULATOR_PFUZE100=y
 CONFIG_REGULATOR_PWM=y
+CONFIG_REGULATOR_QCOM_REFGEN=m
 CONFIG_REGULATOR_QCOM_RPMH=y
 CONFIG_REGULATOR_QCOM_SMD_RPM=y
 CONFIG_REGULATOR_QCOM_SPMI=y

-- 
2.39.2



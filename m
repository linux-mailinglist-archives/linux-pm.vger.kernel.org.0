Return-Path: <linux-pm+bounces-15897-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C66A89A2B6E
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2024 19:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAB011C2578A
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2024 17:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED951E008B;
	Thu, 17 Oct 2024 17:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZE2ZVD21"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF571DFE11
	for <linux-pm@vger.kernel.org>; Thu, 17 Oct 2024 17:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729187569; cv=none; b=fFMbq04ytG6o6HfHEbtCgfAOXsrh3I263S2qah0ZaDnRCLj985qqGEW2kXjKD3OKxYZ5sBs04l2Xn927rTHsXgO69TJ27fHJ32qq88hjrJcNBx8hnrhz6wyUfPYdFFOSxH09rnbFybjBTiv+R20jYn/JEjqJsVFHHmguZ8D7haU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729187569; c=relaxed/simple;
	bh=E6sSET5NTanEf8su5V13W3kLbMh4cgFTxZO6VeLZC/s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i1254NPFxYK2XX2fjPM2KyfvQUR6g0JvTEDQ+CD2PuQSzhejouP0Xo0mJNSWEdb79YIC1oD14M4ya2QfFKK5zjmI7FqWPM3lCE4qNoN68mxjrIe8t044IOERs+OnZ6ce7m8TdNCV/wNWY8WpFUtLb3YWWpnev2VTG1/KbrMmNOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZE2ZVD21; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-539f72c913aso1591658e87.1
        for <linux-pm@vger.kernel.org>; Thu, 17 Oct 2024 10:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729187565; x=1729792365; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GGopXLJTzCLfhqUsTpJkqnxqFQeGkxJFucKx0VxQEO4=;
        b=ZE2ZVD21dWI6T2bK0f2+G2oa03al2DvKIw4Lx1fIJjnpUf/wUCCgGL+yZdufrKVd5U
         oBTOtFehedBX2hNwJiEA5d/RreDC/HabH6y5IIpdyrfgJUAQAwU5/kqJhxMUVNl6bZ2q
         C20AheVX1JOZNYWYYmvAitL1crhszGqxy8/+6oqMwXLf/VPXalR07WRpxZMkTak99hFU
         EAYlyNCjaglBUnHM3JnZBhBRwKavwpBG15gxzovyCPel3aF0qGlKhr8uq0TIknxRKlfU
         nCdh5l/tA2ILJ1XEOY8SHzJYo/vNRYAPxhJILJdjcy0iU+J1cKY+RqAgrTFsb/MsGyL7
         lF2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729187565; x=1729792365;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GGopXLJTzCLfhqUsTpJkqnxqFQeGkxJFucKx0VxQEO4=;
        b=EHomyPusDcLpgxHu0YN6KHkvmrCsQxPfFEqxFitZl0xmHkbD3XHmq2iSivvLBWvQlJ
         OLj6EtFULq4yUc5da6r0LH9PrDWKY+I39CrxjwktF2PD6RKSU/kG20pDQplVL4yM44KU
         JaZ+q/57gNTDwd0wsUu6Hh8BOTPrlsfDMQ6SlLuFBfFZh8+3I0yh5U/iLQ/bqcjMy5rk
         MazJvBo3W8Xdq6mEJTmiNla9qHhE16oNLYShvSgU1UAL45q94iS7MGjB9VFul9xV/zR8
         tVVp8FZuiWfublyEMcRfi6vNfSYHa06TErzEgo02ndlxj2b8TEe/G4m7wk/DI+QtnRNH
         kCgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVATkoW2N6p33lFEQ0MmH2/7CmNrcxhKhTddKl1kTpoPJpLNamZCgAO2VJiMXBoIMj4lOPd9MGkZQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyhUOPc+/ynQl6kSnITaA7GopG77Qgn6zMsCRpPwpQKmLDxSYp6
	9D5UpTvOajQsFV+HW/uRasWIkVYRFfIDVaHddUr2sjIBlrmNzlvOaEWcfjOmlS0=
X-Google-Smtp-Source: AGHT+IH6+buk6yaAI9YJVrIAMsjfJtRGGoRZPI/6YbiUBaiUNOpD2lVTXPHL+siqaaTkG8jrqrmyAg==
X-Received: by 2002:a05:6512:3d17:b0:539:948a:aadb with SMTP id 2adb3069b0e04-53a03f81a5emr6415982e87.42.1729187565363;
        Thu, 17 Oct 2024 10:52:45 -0700 (PDT)
Received: from [127.0.1.1] (2001-14ba-a0c3-3a00-70b-e6fc-b322-6a1b.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:70b:e6fc:b322:6a1b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a00013f8bsm829557e87.286.2024.10.17.10.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 10:52:44 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 17 Oct 2024 20:52:36 +0300
Subject: [PATCH 2/2] pmdomain: qcom: rpmhpd: add support for SAR2130P
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241017-sar2130p-rpmhpd-v1-2-f4bf7f6fd12e@linaro.org>
References: <20241017-sar2130p-rpmhpd-v1-0-f4bf7f6fd12e@linaro.org>
In-Reply-To: <20241017-sar2130p-rpmhpd-v1-0-f4bf7f6fd12e@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1921;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=E6sSET5NTanEf8su5V13W3kLbMh4cgFTxZO6VeLZC/s=;
 b=owEBbQKS/ZANAwAKARTbcu2+gGW4AcsmYgBnEU7oMWrzR66N2bIKoRCxtF+Wfk3UJKHC+yMm0
 Nf2dyxqYqSJAjMEAAEKAB0WIQRdB85SOKWMgfgVe+4U23LtvoBluAUCZxFO6AAKCRAU23LtvoBl
 uOjvD/kBIY5uaOVx3oJnoec9/FanLeD3f5mDWUw1vZHIEhA/irTrfLYtoxNeUzw/zJV+oEALKV5
 NFVRSEUPLRGZwa5Fqjay1oiroZOLhOzUpeTaioGv6iU3WdYUHcNxVlFzXYY/cMr7cb90M26TD26
 fX1+/O/AwTRPCwfxyc/iwSFkz9Bajev4EXTwloe0eeVx+8CUlDuTg3HONFAIawH+QmvLWj5he42
 yiXWzB/4c1OPUVneGX/JBOGxl6f6B9RoVPI1wZvU3FX4R1ZMzn3k57ofITH5iQ0b4g8SrzokKXl
 uN2OMUTZkZFJorxCMk0S9FSu610TCxD0nKQOMTm8QvwQn7M7EIgxZ4bHNnEbX1ru7kKSpef5wop
 hpEJwe7C+vgH7yliVtK4jgCxwFcm71oaZtn49t/K6cq8JOr2+g7R7rSz6fZOJv7220fUXx60Kvq
 S+0tUnjXV1YoFOa+LQq2Yo8MnAn1/vTXZXJ+Rg37LL2Ovi8Qubj28m4WTuOzxttdIn+GoxKpQIC
 PQQELMoWowEaAf65JHb6dqW8tX/vIodP9Rzrk6ftV1lpDan9QWmv2QiHqcMxwnwxjP0/m8DKOxC
 2CnP7hJ5G7a1DEmG/IjFfMdAQPzz3h/Mh1b6GYxdk5YUsMQigp1GUGh0cxTb2YXBaepmtzq9R6E
 p+CmCqzR+k/o+RQ==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Define power domains as supported by the RPMh on the SAR2130P platform.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/pmdomain/qcom/rpmhpd.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/pmdomain/qcom/rpmhpd.c b/drivers/pmdomain/qcom/rpmhpd.c
index 731feab9f17ddae699815332d193e9a298fff0e1..5c5f9542c3925045cc90872e81cae3e6c2936212 100644
--- a/drivers/pmdomain/qcom/rpmhpd.c
+++ b/drivers/pmdomain/qcom/rpmhpd.c
@@ -259,6 +259,30 @@ static const struct rpmhpd_desc sa8775p_desc = {
 	.num_pds = ARRAY_SIZE(sa8775p_rpmhpds),
 };
 
+/* SAR2130P RPMH powerdomains */
+static struct rpmhpd *sar2130p_rpmhpds[] = {
+	[RPMHPD_CX] = &cx,
+	[RPMHPD_CX_AO] = &cx_ao,
+	[RPMHPD_EBI] = &ebi,
+	[RPMHPD_GFX] = &gfx,
+	[RPMHPD_LCX] = &lcx,
+	[RPMHPD_LMX] = &lmx,
+	[RPMHPD_MMCX] = &mmcx_w_cx_parent,
+	[RPMHPD_MMCX_AO] = &mmcx_ao_w_cx_parent,
+	[RPMHPD_MSS] = &mss,
+	[RPMHPD_MX] = &mx,
+	[RPMHPD_MX_AO] = &mx_ao,
+	[RPMHPD_MXC] = &mxc,
+	[RPMHPD_MXC_AO] = &mxc_ao,
+	[RPMHPD_NSP] = &nsp,
+	[RPMHPD_QPHY] = &qphy,
+};
+
+static const struct rpmhpd_desc sar2130p_desc = {
+	.rpmhpds = sar2130p_rpmhpds,
+	.num_pds = ARRAY_SIZE(sar2130p_rpmhpds),
+};
+
 /* SDM670 RPMH powerdomains */
 static struct rpmhpd *sdm670_rpmhpds[] = {
 	[SDM670_CX] = &cx_w_mx_parent,
@@ -665,6 +689,7 @@ static const struct of_device_id rpmhpd_match_table[] = {
 	{ .compatible = "qcom,sa8155p-rpmhpd", .data = &sa8155p_desc },
 	{ .compatible = "qcom,sa8540p-rpmhpd", .data = &sa8540p_desc },
 	{ .compatible = "qcom,sa8775p-rpmhpd", .data = &sa8775p_desc },
+	{ .compatible = "qcom,sar2130p-rpmhpd", .data = &sar2130p_desc},
 	{ .compatible = "qcom,sc7180-rpmhpd", .data = &sc7180_desc },
 	{ .compatible = "qcom,sc7280-rpmhpd", .data = &sc7280_desc },
 	{ .compatible = "qcom,sc8180x-rpmhpd", .data = &sc8180x_desc },

-- 
2.39.5



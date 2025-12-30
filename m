Return-Path: <linux-pm+bounces-40070-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 04926CEAE7F
	for <lists+linux-pm@lfdr.de>; Wed, 31 Dec 2025 00:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C8C83077996
	for <lists+linux-pm@lfdr.de>; Tue, 30 Dec 2025 23:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D272EA173;
	Tue, 30 Dec 2025 23:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DgvFeT/L";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dERdLtyY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DFB3002B9
	for <linux-pm@vger.kernel.org>; Tue, 30 Dec 2025 23:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767137785; cv=none; b=hiQ23MEkpRfyUmuKQlJ/UjxZa6jH+KE7hbkpdPr4sgBe/yEwQvGKCNCUXsuydUR7OKbbqKQuiGpVTsaWEjKa5ILtiR3pCeWfB2zMIHMEyJlXdxVTD+HwMcn3oslL7WGgDT1rhZzhkV0P9j1EMoglGtonI41iB3bXjQYdmH2kseI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767137785; c=relaxed/simple;
	bh=G5Z4yR6nEsG1t9E48mwIwJpb2fx2CuxEMAwYvVJCpKM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JQR70GfdIuIl0HZLlwQ4ZKZBOkyTU8kOZpy2342zqajBh7FHMte7Xakgx/Sb4fg4gPe4L0ZrkJv3QyQUQ9F9MetaPVOthP5k94ET/+y7+83g3zi3iGaeC/L6j6EqUs/ptrlDt8skTtUEkSI84WWdJxSBLCZKQZmKtob1lOlhh50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DgvFeT/L; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dERdLtyY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BUBckjM2671365
	for <linux-pm@vger.kernel.org>; Tue, 30 Dec 2025 23:36:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	M+J6odUgaa8iwTvncGdMwjsDOYue6NOpQi6sZNGxf7o=; b=DgvFeT/LbKpAbaOJ
	6pJL0julzqo9F5xShPc/sPjnNl6mQU+meQIux5oud1XPM38IrvDErvwTUBYOK97/
	FOqpZal5hMHfcSYMc43GdFQ1BUVVW7ba1pDXwPfFRxidheChhL8IemJYRXQVz/E9
	5SWom50wRnFtyn84TqATGvIj0zrQmz5b3gFgFZWGG+P+1KuXmfFmp7uJrD1qc9Nl
	rWJEn80lAYBpds9ZIVnJ1dLtP2WfrRzFEezT2Nrr9uNYJSZBLyeHMS18T0Shhe/x
	kLLWYkFW1Yf5aBmdB4Ba9QBVYOUHi0+rmFCbnWmkRMSz9UYTU3DxM8ww3nboD6k9
	IIb7hQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bc4fctp6v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 30 Dec 2025 23:36:14 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ee16731ceaso201806221cf.2
        for <linux-pm@vger.kernel.org>; Tue, 30 Dec 2025 15:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767137773; x=1767742573; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M+J6odUgaa8iwTvncGdMwjsDOYue6NOpQi6sZNGxf7o=;
        b=dERdLtyYJnoY/av+Yjk48EUJFKT3Gw9B+ga4y90isjeqFzmFNG0QCOpy99GkslhpUs
         3kbHOqFRmijInZIguhEC6AcClW0YAyOQiX1uNknrF8coWDOMN6l8vDIRO+3b/k1TFnCD
         /FXX4PEpijTkoyWprfr8JmCnhM3MjZDipSH5haQi2NIBKAmz5V21VYvOWjDjJCvT+8lo
         1ShDQ3SqnghbklJRzqIJaPOKLBug0hkfzCjZ1Owuc2T2mE5aYFGy8iVj3v715lTnUvbz
         mn2ykNU3g9xfw8PpKaY2WrQy8oOAokasz10IH28qX+36F0k+ybIzeFoDjMLlaIT2AApI
         YBgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767137773; x=1767742573;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=M+J6odUgaa8iwTvncGdMwjsDOYue6NOpQi6sZNGxf7o=;
        b=HJAFcZqrFKoflQ/uSPICKreNN4lx1oSjtqU4mW+/GeFk2TzhT1wRL1kx2Lg6Ij7Rks
         NWuU9BQ33UqPmqRy+nd/EJv+oHEZTms8AYZdBDZ1MRMMFFVyKs/Yg+tBC9FXbRfBdgYC
         jcBtVz18xZpD49OlWmGdTdTXwYuuBpRE2YEiXwYG8msnYoG7XPtXxzqn7IeZwylLoEZr
         m7gpCi+zz3UNb9tByZnzDhaCWpL/qvDvseVVxmyu2xTQ/0KjXYWLxzHtlIRfEsVadxdL
         bpqXMpTXdcnQJGzAVWGPrpRAYZ+DL6gfyuOQHjKu52juAwQSHKLpC86POxTPYmtTL1gk
         6/Bw==
X-Forwarded-Encrypted: i=1; AJvYcCW8nn6glaT6HyzuC6MW3XK4YjiMYWvhm0XguelX61/n8EphAWyx31UAFT2bGK1jnK9R/8Qkx8EEfw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1/9VrCVSoJ/EH+t2NKVUbf6gcBTFuyYwBu7UEsUKzHewZQcwo
	hIMCsLhp+6/mW3wZyPve2GALVMtua0gxAS5KCKR6YyVLSkLpe8vwW559YFOQL9tLHe/xV9yMx4I
	0DvIb9BvhMfqm9/N2z8Yf27xekrrzShTvYnfC5WJ2NMz5p/ZnRQw88V4uqLpWhg==
X-Gm-Gg: AY/fxX6u2fodnFIZWRFFSh9eq8eQ0Dp/+Ep0NXsB0ZfdI44gkcbyoxOiNDyEMircI1q
	/auEM9zYvyfjGqbn6/NQPd8jCi+/vPFBZRJ/DDhhXgzDxEoWr+Y88gGCfMh7BrUDAOMY2bTGwgT
	8g4+kuY1F5wi/BLMHGZwxQBiqFU0R3k9gqOgYmUK5L/DEC+zkVR5AzpWkf5GDSyGxfppDbOWO4N
	D6kfJGXZHXgwVNnTtdBtNy2L2iZhioZBm53LToLGcSUHWIDrfnfErmImRSQFd77+SzwMwr2C6Nf
	UjJ5HXbURnECgZtJbJ+zF/t+2uRNySWMYbeYBl55IgJ8xgkxGeIIQ+AUMdWryFgXXxCMn4uR30F
	gT/rcYf9pDJajoi8ehtVvG7jYsYckC/VME71dluAqobh9YeFO73YWnf1E3WSwCoy9CPF2SP5jFn
	jJ6AR8JRLqW1Vf/5zhzRCS0n0=
X-Received: by 2002:ac8:46c8:0:b0:4f4:c7c0:bd15 with SMTP id d75a77b69052e-4f4c7c0c07bmr350486941cf.12.1767137773507;
        Tue, 30 Dec 2025 15:36:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHt+XoYSbSJNRXHtMXQNgN0f/XiydU8U/JTEU2GP7wJMRDcjK6UqRn6PIVza81M2IRsxDEozw==
X-Received: by 2002:ac8:46c8:0:b0:4f4:c7c0:bd15 with SMTP id d75a77b69052e-4f4c7c0c07bmr350486631cf.12.1767137773096;
        Tue, 30 Dec 2025 15:36:13 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59a18620337sm10349574e87.86.2025.12.30.15.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 15:36:12 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 31 Dec 2025 01:35:55 +0200
Subject: [PATCH 05/14] power: sequencing: qcom-wcn: add support for WCN39xx
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251231-wcn3990-pwrctl-v1-5-1ff4d6028ad5@oss.qualcomm.com>
References: <20251231-wcn3990-pwrctl-v1-0-1ff4d6028ad5@oss.qualcomm.com>
In-Reply-To: <20251231-wcn3990-pwrctl-v1-0-1ff4d6028ad5@oss.qualcomm.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-pm@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=8160;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=G5Z4yR6nEsG1t9E48mwIwJpb2fx2CuxEMAwYvVJCpKM=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ2ZI4pMOE1aXJRkm0xhOXLnBtuXhofJsj6deTGt0rvqou
 ynUW4p1MhqzMDByMciKKbL4FLRMjdmUHPZhx9R6mEGsTCBTGLg4BWAimjLs/7QvHi2x29XYuu7P
 xelC2x5FthbuFb3BkNgXkNkwNYTXZu2s0stSKRs0v01X2Tp9t8qfS3pdPs+2Hpv44f8fb78ob1+
 uqF358VaiTPW++62ezZffIV+Y4C9QH7S0kMV1WdHbLPZHD0We7Ew8W/ia+c8UnyCp/tsXuG8qfk
 rcHB5sUtXZcOn13qPC/SkWQW1etl4MP8Xt23W/rmmPtFaqitsQc8e3Ye3JvX3Vdx5JyZx43njNv
 OvC+hsmIU++TSgUyU54O2eumYvmoUWPJ0Rnu71jXn1RReu3jc1v9antHLZZatwHgytffgs/vqtL
 /4vsv7/pLw4bx39K1zRa/U3N/KHUjWWWphH+NYUSTY0mAA==
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: GF6jiBY6w52oL5G7kkkkuGvnmxhI9vBF
X-Proofpoint-ORIG-GUID: GF6jiBY6w52oL5G7kkkkuGvnmxhI9vBF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMwMDIxMSBTYWx0ZWRfX+QdjQ3wM8lzJ
 j4muambpQUl72XgK3TmrYSx4e81vZ9tPY5X8abRS/Kz7OalJIaSlhBsbDG6VjA3NnE+JSMnr2DM
 HQxfTeQceRsrv+yY/LZtYbYDlKmHP69BuoHyYooz2Jzkb0lHawalbZkn4IFQZe+IOGLwZxIsB6B
 Cvb3lDzvUL5K7B9tL/8HNjhbTakqrD/Je+GbFODGSwbrhe12HMK7Xh1i/4QGJB8uK7ARZBbq7/t
 d3jxy20oO5LIHeIWLFURyDDlpxsYOjXwk/aDk/RCZxn/FOOkRvC/a4Q9z9AAyjHdvzOLbfXMkKg
 zOrjM4UM83xZlzvnU1wFMjuD9hREyamw1YlB3KMufayzhK5D5s3duDtt5OvOLJ/p6pq9y07xVKy
 BKfRgJdtNjdn2CQZr3kinAG3cPE4Xmicvwvc4chT9X61Kx/Qu4380tz2Z6Pv5LixQ5B+OJHf2dS
 nV7lbiqWyZo4Jgrlfkg==
X-Authority-Analysis: v=2.4 cv=foHRpV4f c=1 sm=1 tr=0 ts=695461f1 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=I1O4o1mkfA9rNPu_QXcA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-30_04,2025-12-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512300211

The WCN39xx family of WiFi/BT chips incorporates a simple PMU, spreading
voltages over internal rails. Implement power sequencing support for
this generation of WCN chips. Unlike later devices, they don't have
separate enable GPIO lines, letting the chip figure out the necessary
parts on its own.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/power/sequencing/pwrseq-qcom-wcn.c | 130 +++++++++++++++++++++++++++--
 1 file changed, 125 insertions(+), 5 deletions(-)

diff --git a/drivers/power/sequencing/pwrseq-qcom-wcn.c b/drivers/power/sequencing/pwrseq-qcom-wcn.c
index 663d9a537065..ed81d0c90a2d 100644
--- a/drivers/power/sequencing/pwrseq-qcom-wcn.c
+++ b/drivers/power/sequencing/pwrseq-qcom-wcn.c
@@ -23,6 +23,8 @@ struct pwrseq_qcom_wcn_pdata {
 	unsigned int pwup_delay_ms;
 	unsigned int gpio_enable_delay_ms;
 	const struct pwrseq_target_data **targets;
+	bool has_vddio; /* separate VDD IO regulator */
+	int (*match)(struct pwrseq_device *pwrseq, struct device *dev);
 };
 
 struct pwrseq_qcom_wcn_ctx {
@@ -30,6 +32,7 @@ struct pwrseq_qcom_wcn_ctx {
 	struct device_node *of_node;
 	const struct pwrseq_qcom_wcn_pdata *pdata;
 	struct regulator_bulk_data *regs;
+	struct regulator *vddio;
 	struct gpio_desc *bt_gpio;
 	struct gpio_desc *wlan_gpio;
 	struct gpio_desc *xo_clk_gpio;
@@ -52,6 +55,26 @@ static void pwrseq_qcom_wcn_ensure_gpio_delay(struct pwrseq_qcom_wcn_ctx *ctx)
 		msleep(ctx->pdata->gpio_enable_delay_ms - diff_msecs);
 }
 
+static int pwrseq_qcom_wcn_vddio_enable(struct pwrseq_device *pwrseq)
+{
+	struct pwrseq_qcom_wcn_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
+
+	return regulator_enable(ctx->vddio);
+}
+
+static int pwrseq_qcom_wcn_vddio_disable(struct pwrseq_device *pwrseq)
+{
+	struct pwrseq_qcom_wcn_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
+
+	return regulator_disable(ctx->vddio);
+}
+
+static const struct pwrseq_unit_data pwrseq_qcom_wcn_vddio_unit_data = {
+	.name = "vddio-enable",
+	.enable = pwrseq_qcom_wcn_vddio_enable,
+	.disable = pwrseq_qcom_wcn_vddio_disable,
+};
+
 static int pwrseq_qcom_wcn_vregs_enable(struct pwrseq_device *pwrseq)
 {
 	struct pwrseq_qcom_wcn_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
@@ -94,6 +117,19 @@ static const struct pwrseq_unit_data pwrseq_qcom_wcn_clk_unit_data = {
 	.disable = pwrseq_qcom_wcn_clk_disable,
 };
 
+static const struct pwrseq_unit_data *pwrseq_qcom_wcn3990_unit_deps[] = {
+	&pwrseq_qcom_wcn_vddio_unit_data,
+	&pwrseq_qcom_wcn_vregs_unit_data,
+	NULL,
+};
+
+static const struct pwrseq_unit_data pwrseq_qcom_wcn3990_unit_data = {
+	.name = "clock-enable",
+	.deps = pwrseq_qcom_wcn3990_unit_deps,
+	.enable = pwrseq_qcom_wcn_clk_enable,
+	.disable = pwrseq_qcom_wcn_clk_disable,
+};
+
 static const struct pwrseq_unit_data *pwrseq_qcom_wcn_unit_deps[] = {
 	&pwrseq_qcom_wcn_vregs_unit_data,
 	&pwrseq_qcom_wcn_clk_unit_data,
@@ -229,6 +265,17 @@ static const struct pwrseq_target_data pwrseq_qcom_wcn_wlan_target_data = {
 	.post_enable = pwrseq_qcom_wcn_pwup_delay,
 };
 
+/* There are no separate BT and WLAN enablement pins */
+static const struct pwrseq_target_data pwrseq_qcom_wcn3990_bt_target_data = {
+	.name = "bluetooth",
+	.unit = &pwrseq_qcom_wcn3990_unit_data,
+};
+
+static const struct pwrseq_target_data pwrseq_qcom_wcn3990_wlan_target_data = {
+	.name = "wlan",
+	.unit = &pwrseq_qcom_wcn3990_unit_data,
+};
+
 static const struct pwrseq_target_data pwrseq_qcom_wcn6855_bt_target_data = {
 	.name = "bluetooth",
 	.unit = &pwrseq_qcom_wcn6855_bt_unit_data,
@@ -247,6 +294,12 @@ static const struct pwrseq_target_data *pwrseq_qcom_wcn_targets[] = {
 	NULL
 };
 
+static const struct pwrseq_target_data *pwrseq_qcom_wcn3990_targets[] = {
+	&pwrseq_qcom_wcn3990_bt_target_data,
+	&pwrseq_qcom_wcn3990_wlan_target_data,
+	NULL
+};
+
 static const struct pwrseq_target_data *pwrseq_qcom_wcn6855_targets[] = {
 	&pwrseq_qcom_wcn6855_bt_target_data,
 	&pwrseq_qcom_wcn6855_wlan_target_data,
@@ -272,6 +325,26 @@ static const struct pwrseq_qcom_wcn_pdata pwrseq_qca6390_of_data = {
 	.targets = pwrseq_qcom_wcn_targets,
 };
 
+static const char *const pwrseq_wcn3990_vregs[] = {
+	/* vddio is handled separately */
+	"vddxo",
+	"vddrfa1p3",
+	"vddch0",
+	"vddch1",
+};
+
+static int pwrseq_qcom_wcn3990_match(struct pwrseq_device *pwrseq,
+				     struct device *dev);
+
+static const struct pwrseq_qcom_wcn_pdata pwrseq_wcn3990_of_data = {
+	.vregs = pwrseq_wcn3990_vregs,
+	.num_vregs = ARRAY_SIZE(pwrseq_wcn3990_vregs),
+	.pwup_delay_ms = 50,
+	.targets = pwrseq_qcom_wcn3990_targets,
+	.has_vddio = true,
+	.match = pwrseq_qcom_wcn3990_match,
+};
+
 static const char *const pwrseq_wcn6750_vregs[] = {
 	"vddaon",
 	"vddasd",
@@ -328,8 +401,9 @@ static const struct pwrseq_qcom_wcn_pdata pwrseq_wcn7850_of_data = {
 	.targets = pwrseq_qcom_wcn_targets,
 };
 
-static int pwrseq_qcom_wcn_match(struct pwrseq_device *pwrseq,
-				 struct device *dev)
+static int pwrseq_qcom_wcn_match_regulator(struct pwrseq_device *pwrseq,
+					   struct device *dev,
+					   const char *name)
 {
 	struct pwrseq_qcom_wcn_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
 	struct device_node *dev_node = dev->of_node;
@@ -340,11 +414,11 @@ static int pwrseq_qcom_wcn_match(struct pwrseq_device *pwrseq,
 	 * 'vddaon-supply' property and whether it leads us to the right
 	 * device.
 	 */
-	if (!of_property_present(dev_node, "vddaon-supply"))
+	if (!of_property_present(dev_node, name))
 		return PWRSEQ_NO_MATCH;
 
 	struct device_node *reg_node __free(device_node) =
-			of_parse_phandle(dev_node, "vddaon-supply", 0);
+			of_parse_phandle(dev_node, name, 0);
 	if (!reg_node)
 		return PWRSEQ_NO_MATCH;
 
@@ -360,6 +434,26 @@ static int pwrseq_qcom_wcn_match(struct pwrseq_device *pwrseq,
 	return PWRSEQ_MATCH_OK;
 }
 
+static int pwrseq_qcom_wcn_match(struct pwrseq_device *pwrseq,
+				 struct device *dev)
+{
+	return pwrseq_qcom_wcn_match_regulator(pwrseq, dev, "vddaon-supply");
+}
+
+static int pwrseq_qcom_wcn3990_match(struct pwrseq_device *pwrseq,
+				     struct device *dev)
+{
+	int ret;
+
+	/* BT device */
+	ret = pwrseq_qcom_wcn_match_regulator(pwrseq, dev, "vddio-supply");
+	if (ret == PWRSEQ_MATCH_OK)
+		return ret;
+
+	/* WiFi device match */
+	return pwrseq_qcom_wcn_match_regulator(pwrseq, dev, "vdd-1.8-xo-supply");
+}
+
 static int pwrseq_qcom_wcn_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -391,6 +485,12 @@ static int pwrseq_qcom_wcn_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, ret,
 				     "Failed to get all regulators\n");
 
+	if (ctx->pdata->has_vddio) {
+		ctx->vddio = devm_regulator_get(dev, "vddio");
+		if (IS_ERR(ctx->vddio))
+			return dev_err_probe(dev, ret, "Failed to get VDDIO\n");
+	}
+
 	ctx->bt_gpio = devm_gpiod_get_optional(dev, "bt-enable", GPIOD_OUT_LOW);
 	if (IS_ERR(ctx->bt_gpio))
 		return dev_err_probe(dev, PTR_ERR(ctx->bt_gpio),
@@ -432,7 +532,7 @@ static int pwrseq_qcom_wcn_probe(struct platform_device *pdev)
 	config.parent = dev;
 	config.owner = THIS_MODULE;
 	config.drvdata = ctx;
-	config.match = pwrseq_qcom_wcn_match;
+	config.match = ctx->pdata->match ? : pwrseq_qcom_wcn_match;
 	config.targets = ctx->pdata->targets;
 
 	ctx->pwrseq = devm_pwrseq_device_register(dev, &config);
@@ -444,6 +544,26 @@ static int pwrseq_qcom_wcn_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id pwrseq_qcom_wcn_of_match[] = {
+	{
+		.compatible = "qcom,wcn3950-pmu",
+		.data = &pwrseq_wcn3990_of_data,
+	},
+	{
+		.compatible = "qcom,wcn3988-pmu",
+		.data = &pwrseq_wcn3990_of_data,
+	},
+	{
+		.compatible = "qcom,wcn3990-pmu",
+		.data = &pwrseq_wcn3990_of_data,
+	},
+	{
+		.compatible = "qcom,wcn3991-pmu",
+		.data = &pwrseq_wcn3990_of_data,
+	},
+	{
+		.compatible = "qcom,wcn3998-pmu",
+		.data = &pwrseq_wcn3990_of_data,
+	},
 	{
 		.compatible = "qcom,qca6390-pmu",
 		.data = &pwrseq_qca6390_of_data,

-- 
2.47.3



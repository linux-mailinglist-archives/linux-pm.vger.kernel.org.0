Return-Path: <linux-pm+bounces-37448-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6B0C3558E
	for <lists+linux-pm@lfdr.de>; Wed, 05 Nov 2025 12:27:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B276466929
	for <lists+linux-pm@lfdr.de>; Wed,  5 Nov 2025 11:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD6230FF2F;
	Wed,  5 Nov 2025 11:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kmE1gds5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1ED5304BB7
	for <linux-pm@vger.kernel.org>; Wed,  5 Nov 2025 11:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762341716; cv=none; b=kklnkADlBYOjuzk4HwzVRRu/sOqEWukVcKsWWaolv8Hx6UObMe/cBpJ9KyYxStAHBd/+FeXWM8VTExUh0B6Hb5eZ8OL/HGS3beLzUC913SHPdA53CsAci4Pcex0Yv31JBd/K+Mzzh1agjGFgBFmdsN5zz4kymVxoTisd05f5QgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762341716; c=relaxed/simple;
	bh=FNrJaRSuWPP0+80IFUuNsbxE+kHLaf+ZpsE+hL238yU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HB81MejsqfFGkQkOl37HYzhrbG+VkmQAKAr5NfL0Lq7G3TK+WmrXI5F7D78/HXTf4aaSFGBJLkqRNw1aRVI5wNNAbN8klmhgWsMVCXizTa+zfopmpqLoQhr8JhGgF56hiDDmVIerh8vPHIc/obx19wVjwUH2g3JZe8DTwxlwec4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kmE1gds5; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47754b9b050so13337805e9.2
        for <linux-pm@vger.kernel.org>; Wed, 05 Nov 2025 03:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762341713; x=1762946513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5pLNnnbL3rHvQzwwY3VC7rigAYhAoNQuK8omShAyWoA=;
        b=kmE1gds5txHh3bcNv0X1XBtAy4gzQQpwtP0cGffTbcwD5CbOS63QOQ5nYIS+U3yoAw
         KQLq/6aHkaQcVHhexaT1Yn+2aRIcdUw1DqEDfzFajcrX12dBEXnViXLP+lZgn4rs/OCd
         30mz6d9uWZHnku+OslvwivGSRL51VkpTA9ueg7XeGF7IAnxu3HNuQMxbEcdw9esC9rkk
         nK5XRHxh33naDn3AKG2KP6afo4JkOd7JqnwbSyK9qG+rUAoHn/4fVkKywNEq8rIRGDhW
         sflsgf9w1frh6NQkoFF3lKHsPj3e9A3Ojntz9OBPCs1N/CEYhEGuOticmoUFHyKUbvjV
         u0dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762341713; x=1762946513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5pLNnnbL3rHvQzwwY3VC7rigAYhAoNQuK8omShAyWoA=;
        b=wp2jp6AWQ9WH7Wj4Q5E8korSA0kt5rCVihcoHPjJt/q4kiqSxX9kZp4iUAtpIeKPlR
         WQ1dKPFDc8kvlwdaAQ0qM9evVSsBq87zYgQK/LsttRRiRLN8xIsWrkTgQ01w55bJZOCT
         P+vny+4IonL4FFOgPWt6HTW4F6a1sFPPMoPtqmvdBYWCL+9mNB7OMkt1pWo7zWC4GLag
         Rd/RhmZKtUits88wNlIk0oj19lochvifkGUUXQy4ukWryM3DoHMeiTM4t5xWO9+If+wV
         e1x5KshyqVmSOrpSMkyqumQ0N45wKQml6/rNoF0wHdBKTB76AHuKuQRzroBjh03ai2KL
         mvww==
X-Forwarded-Encrypted: i=1; AJvYcCXxhOAJnIxPD/aeFComH5ikIPrsaCmhBmBKTKGOlVCWDKdjmZl46XWmqy3D3RlnryoyPnvz2jt/rA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywyq1tbWk4I11X1jufMIO1fWkUpNckdNrG+E8JY0ep67dhJIWlx
	QBngY5jwgxRE5c08SAq+5zUJdVO2ipoV0ePAHuR73pCAI+e73bwmHgvCHxJ/Pw==
X-Gm-Gg: ASbGncsi458IbCkWM7WDi7mE6Tyzq77Xgtjvj9OYv74LpuDWG2tsZWdWh5fiD9wAUyb
	npjSf6NkxPKsZLjEtjYwbLTT3UlfWM0zOhtOiqL3F0d18pnizovHW7ej0BXPMqaK5ytzLEtBfuk
	o86QSayoJAqJrTPmqDbj8Pf/gNoghN1MuxaL69vHYKP32/lf0FTeG+IyCymM15uWnma58PTljWC
	yNvl6Ln9NdlNYZBwER7I4gMg3FA55pHJX35zVqo9bnuIpF6DQIvIK1BjWw3mRZziPIk/o0Xuwdi
	zhNmmFie9QtwYavHXSu/M8cIdLVxeubrwW5RB2ibyfa3FZWm8NtHQ+N6qJxuRTt1FEFZMGBxnC3
	bA68joFjnWTCOBh8GRZItdDI/axoQBb/qns8/FfPOWBLklsQ0EE2LGuZ5NV8DQjohcd+l8xfsS6
	pPrwz62OWSeqkb/VwPef8OmfEwTg00Iw==
X-Google-Smtp-Source: AGHT+IHIgIQLMjyfsUy/DCWrg95x6zDlVpO8mQEr6nvagaJBa/yhqQLKmWsXV6I9BNH25BymBpPrSw==
X-Received: by 2002:a05:600c:348f:b0:46f:b43a:aee1 with SMTP id 5b1f17b1804b1-4775ce2c7eemr18402505e9.38.1762341712907;
        Wed, 05 Nov 2025 03:21:52 -0800 (PST)
Received: from Ansuel-XPS24 (93-34-90-37.ip49.fastwebnet.it. [93.34.90.37])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-429dc200878sm9829851f8f.45.2025.11.05.03.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 03:21:52 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Ilia Lin <ilia.lin@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: [PATCH v4 1/1] cpufreq: qcom-nvmem: add compatible fallback for ipq806x for no SMEM
Date: Wed,  5 Nov 2025 12:21:34 +0100
Message-ID: <20251105112136.371376-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251105112136.371376-1-ansuelsmth@gmail.com>
References: <20251105112136.371376-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On some IPQ806x SoC SMEM might be not initialized by SBL. This is the
case for some Google devices (the OnHub family) that can't make use of
SMEM to detect the SoC ID (and socinfo can't be used either as it does
depends on SMEM presence).

To handle these specific case, check if the SMEM is not initialized (by
checking if the qcom_smem_get_soc_id returns -ENODEV) and fallback to
OF machine compatible checking to identify the SoC variant.

Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/cpufreq/qcom-cpufreq-nvmem.c | 35 ++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index 3a8ed723a23e..be44a8965e3a 100644
--- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
+++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
@@ -252,13 +252,22 @@ static int qcom_cpufreq_krait_name_version(struct device *cpu_dev,
 	return ret;
 }
 
+static const struct of_device_id qcom_cpufreq_ipq806x_match_list[] = {
+	{ .compatible = "qcom,ipq8062", .data = (const void *)QCOM_ID_IPQ8062 },
+	{ .compatible = "qcom,ipq8064", .data = (const void *)QCOM_ID_IPQ8064 },
+	{ .compatible = "qcom,ipq8065", .data = (const void *)QCOM_ID_IPQ8065 },
+	{ .compatible = "qcom,ipq8066", .data = (const void *)QCOM_ID_IPQ8066 },
+	{ .compatible = "qcom,ipq8068", .data = (const void *)QCOM_ID_IPQ8068 },
+	{ .compatible = "qcom,ipq8069", .data = (const void *)QCOM_ID_IPQ8069 },
+};
+
 static int qcom_cpufreq_ipq8064_name_version(struct device *cpu_dev,
 					     struct nvmem_cell *speedbin_nvmem,
 					     char **pvs_name,
 					     struct qcom_cpufreq_drv *drv)
 {
+	int msm_id = -1, ret = 0;
 	int speed = 0, pvs = 0;
-	int msm_id, ret = 0;
 	u8 *speedbin;
 	size_t len;
 
@@ -275,8 +284,30 @@ static int qcom_cpufreq_ipq8064_name_version(struct device *cpu_dev,
 	get_krait_bin_format_a(cpu_dev, &speed, &pvs, speedbin);
 
 	ret = qcom_smem_get_soc_id(&msm_id);
-	if (ret)
+	if (ret == -ENODEV) {
+		const struct of_device_id *match;
+		struct device_node *root;
+
+		root = of_find_node_by_path("/");
+		if (!root) {
+			ret = -ENODEV;
+			goto exit;
+		}
+
+		/* Fallback to compatible match with no SMEM initialized */
+		match = of_match_node(qcom_cpufreq_ipq806x_match_list, root);
+		of_node_put(root);
+		if (!match) {
+			ret = -ENODEV;
+			goto exit;
+		}
+
+		/* We found a matching device, get the msm_id from the data entry */
+		msm_id = (int)(uintptr_t)match->data;
+		ret = 0;
+	} else if (ret) {
 		goto exit;
+	}
 
 	switch (msm_id) {
 	case QCOM_ID_IPQ8062:
-- 
2.51.0



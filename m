Return-Path: <linux-pm+bounces-37368-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8AEC316A0
	for <lists+linux-pm@lfdr.de>; Tue, 04 Nov 2025 15:07:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BCCF44EF632
	for <lists+linux-pm@lfdr.de>; Tue,  4 Nov 2025 14:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8CE32C95C;
	Tue,  4 Nov 2025 14:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YptXjI4a"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EE332BF5D
	for <linux-pm@vger.kernel.org>; Tue,  4 Nov 2025 14:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762265209; cv=none; b=a1uO+mbPyqd+obz3tqjZjSQmAmk4yk8iYLWxinCnUJAdBCiooEbQAA4nUwgoFCxGaYxNd1Fu5OBx/PdgtmF/IhV40Y8S3IQnWAnb/j1V30IKeRJRg6sFeOPewVo/Q0DXpzFOrKUtuZG3/PBhw9tzZzSYMFGLVlxHDDKY8hv8HuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762265209; c=relaxed/simple;
	bh=J7o+qvVj/pTXaFpXaAcj2Tg3Jq+K/NDPOk446ICszDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e5f0IeiEmk1P01CtSMOypwg7P6P75IP/xFzUaEqDs6XJoYHSVec4JRa6uApxFUHFGW8Y2DlYNT2i1/jNraWMKfzi2P/7rIH1IA27G6WnbnXPmv+tZQc3aneoSl0BngBRM9urq6+3ae/fUrHSQPirorCuy7UmQqMHdWE+XpIZgCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YptXjI4a; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47118259fd8so41649355e9.3
        for <linux-pm@vger.kernel.org>; Tue, 04 Nov 2025 06:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762265206; x=1762870006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B0YVoVEFCaf8aeEHsaoJ6V5EGSx1RgPZYK2i+8/mRSY=;
        b=YptXjI4adkOTCyiRqXG3uqUAAMK98so0pcxjH7BsYWb4FzmqRhOgFmu12Pf5xqm2tx
         g5O/gmF/bXw3NLLlOyCeR4eYskUi5RmIiPmeMWllZ8O1hWaQqwenKtRQkZ6fJwqQzWpe
         aoRVg8H+r1w5EFWRdSPeQPqZ/pEYsQpj9tz+L5w84EGm89HaFKiJqCd7TS5QtP1Ofqzj
         tTX7W+f54GdCu/HDrtYg1C/28HzeJzWy1GH2GBe/Tbw9J5aEd2JLz8FbNS24MzzWIUYA
         WXFMCYV1mQH2nYAqg9O+7HZGXwLKVXSxSVzGramPI0RK4YH05QM3xqan3/ms2fCLsL+t
         SgOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762265206; x=1762870006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B0YVoVEFCaf8aeEHsaoJ6V5EGSx1RgPZYK2i+8/mRSY=;
        b=lbfC30Vb/Lgw5HT6aVS4xwQLvHz7syDwWY/tOL4031Pf0Bn1NocBksmxZgvfsqEcm1
         P2KgB9agMiWTMB1onljj6dYLeJMrfOtnvIuij7ca+dxQc+kJ4iZ1IoXzUu5IK08fRDcn
         mDmSaA7AhMq2524FblbyAky6srKK27886KiDBFZTEJ/Er8SiYYv2XxyuIjGIinRyNFWr
         B92fvEpoH+QmSDbqzBsvMukMJ4+le7pvGdhgwYo51yxkhc8p4dhXMdTAFqp5L80zpibA
         wSpFbwbt6Tf5x3f17Oo/Gq6ohOU7F8/3ZhDQf//XC52SH1IL2v/1O3ZkoPqT4dgTrRKU
         1e9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUMXJMQ26QaTfO2TzCanbi7lDWlZKYex3sNAroiNJNmh5NZCDs28Bd0gGxitqcTF057NeYqrMh28A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzxOcMYPqxnzS9ljshnLivA48xB3qSmHb0fMsPSYrBH2ULRIBwj
	stdD1L4aNLvHiKJF51FC4X656iwco1jpmO7tqA8XPoaqDI0zfxOtEnqGy5j5/w==
X-Gm-Gg: ASbGncvPb6WN+MN2/5pmTrFUpzwpO9XGMo44jDID6rR528aCWpQgLw47dGZqrFSMVin
	D/CaR4iU59P5IuuzE+0OEmM3uEc/iDboVu3fRBztV31DoWJVbgr8OjBqHt53wQ3+bt1OIPBPx+Q
	yHvtfoqpRgw/Y5gUUTGkuxRLvfPhexH3pG4N6mqX08PvmQ+cV4l4eGImxukCdpaMgJLB1gmO6gW
	SyKc+/Fllr4GwIFY3Z7bGbG0ehT+lp7UDtSBkw4ssUDGs5GIs5WAEc1vn8I+M0duWvJt85btYPH
	0ubmcpUQWFLRlohOYyFJJV0aJfhvMyhbGcBpGo/Yqi8pDSd+ykDWl/NxMDK21ydKWHp8DBgD5uS
	ljactMTgui9mEvGjyTFyWe5V1ka9j8WEw8PejfNjJVYwAatBhz7unqMhwmD7D0ioQU8VTCqbuab
	l3F1hoFX/S+ykdttcALDNXe6cnroEjxQ==
X-Google-Smtp-Source: AGHT+IHysG3/qeAR1noZEqq9C4WhUroWJnqAclS/5AWKKIu7XUXyFIQ1hIfpstDAPpN5e6K90GHyhQ==
X-Received: by 2002:a05:600c:5020:b0:471:700:f281 with SMTP id 5b1f17b1804b1-477308a15a7mr136413305e9.25.1762265205897;
        Tue, 04 Nov 2025 06:06:45 -0800 (PST)
Received: from Ansuel-XPS24 (93-34-90-37.ip49.fastwebnet.it. [93.34.90.37])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-47754adcd08sm52511205e9.5.2025.11.04.06.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 06:06:45 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Ilia Lin <ilia.lin@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v3 1/1] cpufreq: qcom-nvmem: add compatible fallback for ipq806x for no SMEM
Date: Tue,  4 Nov 2025 15:06:30 +0100
Message-ID: <20251104140635.25965-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251104140635.25965-1-ansuelsmth@gmail.com>
References: <20251104140635.25965-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On some IPQ806x SoC SMEM might be not initialized by SBL. This is the
case for some Google devices (the OnHub family) that can't make use of
SMEM to detect the SoC ID.

To handle these specific case, check if the SMEM is not initialized (by
checking if the qcom_smem_get_soc_id returns -ENODEV) and fallback to
OF machine compatible checking to identify the SoC variant.

Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/cpufreq/qcom-cpufreq-nvmem.c | 35 ++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index 3a8ed723a23e..17c79955ff2f 100644
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
+		msm_id = (int)match->data;
+		ret = 0;
+	} else if (ret) {
 		goto exit;
+	}
 
 	switch (msm_id) {
 	case QCOM_ID_IPQ8062:
-- 
2.51.0



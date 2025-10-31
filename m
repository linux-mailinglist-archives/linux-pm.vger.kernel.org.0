Return-Path: <linux-pm+bounces-37186-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BAADC25303
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 14:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25A851A612B6
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 13:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB17634BA3F;
	Fri, 31 Oct 2025 13:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M8U+3tRc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A8634B418
	for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2025 13:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761916131; cv=none; b=M2gOPBZc/1N7AHE+YRhkBT14mJs1kx+RDTKETceh0ioZlBKLmmsd37gwFHwyFwh80/TY14GccgSB2Wu5CIt1w4mXWKptLyitnAYFpEhvDyfhGxpih6xh7SV1HKkpuHbIlyKFfimmI3Xmu8L39vxcKkmv+DoChnD1T0NwuGVQeQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761916131; c=relaxed/simple;
	bh=5T4we+04phvY12zd5z7NmT493Cbo+MC2XthOf+wVqB4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iTBYJem+XgVqrPVw6OSmEjTdLcoynR5svFWGqz7yk5meHTx1Qeg/6rnTnI6ho1bnMJpay/rupmJrOnA/aWJoDAP5pG2ZxOQeN3C5x6eq6kb58ctqUS3JpD1hCAyZ5NXQKHP7wueGKwBSLGWhFWOprj6exr7/MvgBKP8PHJOcMa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M8U+3tRc; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-426fc536b5dso1426364f8f.3
        for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2025 06:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761916128; x=1762520928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WlG3BHDYyP9oSQCZSrzDbxflKU5lSaGhHgoKQjGdBiQ=;
        b=M8U+3tRcWLvS5/krGTnFAjtk3+c9AFYqrpDXbxS/bw0RGwvA8GNBXg12gtijGNJwhc
         08dytg14s93Pybkl6AmVeDTPNUTOPqIVVKspSkMYZWTjuBnbWTv5v+1JFxLwqD/T/QBU
         1R2c5zO7kgs1IqXbMDSL+p9pddvhaBKNATQ5cwx/+9CRNyUHZGBPoL2iN33KZLFfpyVj
         X6czZVu2CIfJyNCfMzPttdsKgK+FHMELTMBpFS5FhJlOd4IOm0yDq7ptU7ViaT/FKU+i
         a67tFmkHVt0mGlHV+p6X8C3U3wiVPBfT9amWQfhLbTV2lcKyQc2N8+lXBO2Zj0tBzEit
         l9CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761916128; x=1762520928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WlG3BHDYyP9oSQCZSrzDbxflKU5lSaGhHgoKQjGdBiQ=;
        b=H/KhUD5+xqPp8SfcAputQQHSDPlFF8RgMarMtihr9Ws/crxYmXpxVWpj5TfTH6SYRE
         DPxsZalFn5N7wN4L2RVoE3i55jNqv7SYATkXt5BEdWjYmC/bNq8EuIv3deNPbWFo7oh6
         JQb/7l765alWSnG+5PIcpiCBAPv2dauQrai1gGgSJ0liUpNxaMrjRLMa0XUqrJygj3yN
         72zmoGJjxnLNaKYV3iulK1cd2XLa0ncdTZ3hrcighf+8u2oOyHc3GgFx+2Bm+/wj9Zh8
         0dpdM75pUyeg46U61jfitljSJmQgk0QDJ8FM6jN0JRJGG+08nX4WEcg+mbVGJLH/BkuW
         nbrg==
X-Forwarded-Encrypted: i=1; AJvYcCXPv0L/ml8t5Dl8v+lQi22LykpFQDKWo1Aiuwh36itC5ixVn+X03T3KBmSDCIc/EpALZ3wo/+ft0w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxQQLgaYp4ei6K//nx0Ri/5TLB8gB22rlhaLWLBtJfax00fXccX
	x67RnWYPNcBXESkwtv3/Gmi9YZJRAu23cwC1lBnYzBB9yKyFL5EJLhnM
X-Gm-Gg: ASbGncv/oEI7V/6baNkBxwDloDx503cI5F+8w8OUPxQg7/WBSw88H68N8J5gXGCEedi
	bBndm7kolClOHQOd7ypq/sZKWjjhjA9qdOBLGB4/sYwxKQQMynoKI0QxvAb7u5qJTau/VxAyJVo
	ePIZwH7OYY8TfrEhUCRAWafBCFLJnz1BqzPjcoyXBfk1T2FURhFIxD519nUTTuGatjrIsS54iJ0
	lbWTU4svwpa6h4TrVDxeiJ+OY6BuGPcXHBjKBc9aZ6gLJkEy6rurRh/EOgC9f8YTyb+m2hYohQb
	yMPJjVKs2gORKjvoHmQMTdBRlYFUo59Uq1548pFaarqfFSm95QNkniY2AtMAD/uODeXj74JGDBb
	iK3647YiSNgMVKiSbwEhFY8gp8b1ZAFwZcPMKiXrsoGmL//H9R7SHHLPerUkhx+t2bX9XnPHHy3
	275oW+dEvubq9WkPzLyCmMqETtcMdRwA==
X-Google-Smtp-Source: AGHT+IH8raCMnV70Ei/zEAHR7NrPRko7JMAHoJpdiWkA2AmfdFMM4hloOB2l6vAj+ebL2RRZr6OFhA==
X-Received: by 2002:a05:6000:1aca:b0:3e9:ad34:2b2e with SMTP id ffacd0b85a97d-429bd6a9412mr3217291f8f.46.1761916127667;
        Fri, 31 Oct 2025 06:08:47 -0700 (PDT)
Received: from Ansuel-XPS24 (93-34-90-37.ip49.fastwebnet.it. [93.34.90.37])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-477289adc18sm98339815e9.6.2025.10.31.06.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 06:08:47 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Ilia Lin <ilia.lin@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Raag Jadav <raag.jadav@intel.com>,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] cpufreq: qcom-nvmem: add compatible fallback for ipq806x for no SMEM
Date: Fri, 31 Oct 2025 14:08:34 +0100
Message-ID: <20251031130835.7953-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251031130835.7953-1-ansuelsmth@gmail.com>
References: <20251031130835.7953-1-ansuelsmth@gmail.com>
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

Notice that the checking order is important as the machine compatible
are normally defined with the specific one following the generic SoC
(for example compatible = "qcom,ipq8065", "qcom,ipq8064").

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/cpufreq/qcom-cpufreq-nvmem.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index 3a8ed723a23e..5a9bd780a4f3 100644
--- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
+++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
@@ -257,8 +257,8 @@ static int qcom_cpufreq_ipq8064_name_version(struct device *cpu_dev,
 					     char **pvs_name,
 					     struct qcom_cpufreq_drv *drv)
 {
+	int msm_id = -1, ret = 0;
 	int speed = 0, pvs = 0;
-	int msm_id, ret = 0;
 	u8 *speedbin;
 	size_t len;
 
@@ -275,8 +275,21 @@ static int qcom_cpufreq_ipq8064_name_version(struct device *cpu_dev,
 	get_krait_bin_format_a(cpu_dev, &speed, &pvs, speedbin);
 
 	ret = qcom_smem_get_soc_id(&msm_id);
-	if (ret)
+	if (ret == -ENODEV) {
+		/* Fallback to compatible match with no SMEM initialized */
+		ret = 0;
+		if (of_machine_is_compatible("qcom,ipq8062"))
+			msm_id = QCOM_ID_IPQ8062;
+		else if (of_machine_is_compatible("qcom,ipq8065") ||
+			 of_machine_is_compatible("qcom,ipq8069"))
+			msm_id = QCOM_ID_IPQ8065;
+		else if (of_machine_is_compatible("qcom,ipq8064") ||
+			 of_machine_is_compatible("qcom,ipq8066") ||
+			 of_machine_is_compatible("qcom,ipq8068"))
+			msm_id = QCOM_ID_IPQ8064;
+	} else if (ret) {
 		goto exit;
+	}
 
 	switch (msm_id) {
 	case QCOM_ID_IPQ8062:
-- 
2.51.0



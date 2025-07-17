Return-Path: <linux-pm+bounces-31013-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37592B08EB9
	for <lists+linux-pm@lfdr.de>; Thu, 17 Jul 2025 16:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4477F7BBD39
	for <lists+linux-pm@lfdr.de>; Thu, 17 Jul 2025 14:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A035C2F7CE9;
	Thu, 17 Jul 2025 14:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ScNdyLux"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4952F7CE1
	for <linux-pm@vger.kernel.org>; Thu, 17 Jul 2025 14:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752760905; cv=none; b=dvqggX8rjQe7UcAAhl9LeVcyN/Wq973S5dQdxUL1UvDgphjCbILYR6souVUl9DOKnfY8t6+uOHqQxfUAjNxzIVUOPeJp5n+EYleMX5ET0yqbQkVTBl5BWzxSzDFFZJtAlIrfBVb4DiaEkz5utP76MgEwGmMpFH6uCZODgFY8rwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752760905; c=relaxed/simple;
	bh=jlhIkx6diq9WlRmojrtBq8F4olsP5GXgTjT8OL+KpEA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FDyAPj8h03ZEAvzG796X5ScDCzZ4UG7bu54IKgNOJCjmRdPYFh8jfGqowVBMRmOPrT1Od8xJf7L3JLmBh+8pnWPRxCrH8yLhoUAOqUERN97a4idIaRQzSANr1TKGhDcYT3nWH7ZignESWYDIJ7Qz3bn2YseOF3cnRWTFwAz1k6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ScNdyLux; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HBGXFG022439
	for <linux-pm@vger.kernel.org>; Thu, 17 Jul 2025 14:01:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9xig2HXHx1to3G55gqdUrKeettuTHUX6qKmlk40XTRM=; b=ScNdyLuxbmGAmpdM
	sG93gdqNLlQp7MmCogYHk0kSg9xPyiuyTIGPN44LCoMtT84ubJ2vNOk/+rfkb8f9
	ezjNNe7/nKXqAGo0aw6lPKR319ZyV7CJxAXPqJHPZ4ZaMUmheNSuk+3IehWSPT6Y
	M5fp00NWMj4An3wBEi6QM9I/qC1Yva8bWD46KHcUkJ3BDF/JQeyAvISgwHkDr69+
	kLg8f5ENrM8vJqEaYNilodMuDv9SUfFqbkUbPq32/gf7caJftAsoFT0CUrrdITjx
	xk8Sq3L4NuaooZeYA9VwQNwMnGHENwnWJ+dk+71TWL2EWw/osB+4/CMJwLcgITfj
	hHPfQA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47wqsy7u61-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 17 Jul 2025 14:01:43 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-748e6457567so1384347b3a.1
        for <linux-pm@vger.kernel.org>; Thu, 17 Jul 2025 07:01:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752760902; x=1753365702;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9xig2HXHx1to3G55gqdUrKeettuTHUX6qKmlk40XTRM=;
        b=cYkNRlNVIJNERT4rXQbGbf0FHGS+Y6FoLALwhCNz3nCrAGLssTPAN7tM1Y8QMOcK+Y
         qCIvUZc3X3VsIuJNGupRa3lyf0pePA5Ejc+PnG8cO0cHvDLFqgOvXWZf47RW/x5FHESn
         THNkClVsmpJWzT4zzLfj8FDgkQTtplas1I69s6leXphRrjOdYT59ll+wp/3yBrCOLJj1
         1BLWb3peAci6lTt0ixgaJRxviBUjiKiYMugByA0xR88fr2vYYw88kMQBaIHrGVtC5W0a
         AmQcBEY8Cbz7HLG1hRIJgd//9ssa1HhW+qTKDtzzUSZbaIYs8tv39b2dy0EFmthQ3Fr9
         yemA==
X-Gm-Message-State: AOJu0YzsPiL0bzM5xW2SPqrSd+j8dmalDccurYTyikExVRREO4lpamnM
	bEg3fWjgtXkW1WA9XllvkmQEma+KrP8uDNL+EPhRuP9jtcMnLvoS05zTDAEdpZ/jRo5rbXYeuUl
	YKlbeG5KTAO/R0IFuQUtnEIUx6MGL+Y4nRfV9oqY8vE30cC4uEH0NzXFWRh4ovw==
X-Gm-Gg: ASbGncs8Alzm6sVAsCZExkULi1/U74TZVkL06ImqJpUS7O6Cvp3Um8GkGAPSdSbF8UH
	mrt+UFoT+vWqybOp/9KTTXkMGFVHV1YJiiExL6nbepChiThi1GT4Jl59dIrhlPkh3tUbuIpYzRy
	tkPw0iVV1RPKVyze1CR4TPQg5aEaPnPJ0c2uMKNmfyYgQAE05IfvavaO2xrIt2pAkWaHt3Zmf9r
	trssvBb60mJQDg8N5FVuO30jGSlMDfkRiCsqTSpRMptmmFQPG61g2AqZy1jraJFMb6Vis2o5nLU
	lI88XDnjs7CEvz3GeiMCy5fMsDo+WUOt30Kvkkh80MBZJXAp/VOG4N0r+/lV8RJayVTR3d1YOr0
	=
X-Received: by 2002:a05:6a00:9445:b0:736:4e14:8ec5 with SMTP id d2e1a72fcca58-758380738a0mr4957673b3a.11.1752760901662;
        Thu, 17 Jul 2025 07:01:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4xyAX6GCHnhDHyeS91ZUNXI9BnUzD+Nm9EIHYAe96nb/taBHl9/Onvn9mLeuEMU7u8nwmkA==
X-Received: by 2002:a05:6a00:9445:b0:736:4e14:8ec5 with SMTP id d2e1a72fcca58-758380738a0mr4957591b3a.11.1752760900999;
        Thu, 17 Jul 2025 07:01:40 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7507a64b57dsm10311986b3a.14.2025.07.17.07.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 07:01:40 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Thu, 17 Jul 2025 19:31:16 +0530
Subject: [PATCH 1/3] opp: Add bw_factor support to adjust bandwidth
 dynamically
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250717-opp_pcie-v1-1-dde6f452571b@oss.qualcomm.com>
References: <20250717-opp_pcie-v1-0-dde6f452571b@oss.qualcomm.com>
In-Reply-To: <20250717-opp_pcie-v1-0-dde6f452571b@oss.qualcomm.com>
To: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752760888; l=5030;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=jlhIkx6diq9WlRmojrtBq8F4olsP5GXgTjT8OL+KpEA=;
 b=5uEe6o72g+JGjtsw48Rq1U6YmW/Kid72G3Sf6e7D19WkLLo8wVq/qYnZwwFbd4wbuewEvcLIn
 xBUqCgEkUZWA24PPKj5eY8E6NjeUNuFzWpk0YEiwpwW853T4ZriLRSI
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDEyMyBTYWx0ZWRfXwZE2Bapegh+Q
 M8m/bE0aP5bghcJ0vhM0W9uEXj85vM6dqOC1tPv/RqIHcBQCRayPnGmzJTgGmvQ8qXvZk2LoiZt
 5EXeBZS4bHT2Vs3WzfHC3eSfnBSxd4EJOLqdSH7HRRo3A8DLpDLcpoomyqg7a0X874onekWTpsz
 30NQS44fbuQ9d3hTb7+fh+7gGWl5SWI2hu4DllFuNbrt3VI5u2t68vMFNPqt2NvX0JjCH7FAwis
 aCuLW4xX4D050wx4PeRytzwux0eaGwH6xXHmcNhgdrpq4LFQ82jswUIeK92n3NPHp7cVEPJg2OM
 E90/y24nB3oFIzaoQ9lwRYVLbhx/dMsQTyj7Z07PjD4xuD2kOVzIxNS5KP9KaHRKAJh2ICeqY3S
 Ug0fYT6tV4WSBXpFr6BK6s3v7Vmyiso1AtQgrd1vhZcc+MDHQXWj700jtO1RStdo+eY0V8T8
X-Proofpoint-GUID: yT5IejgDNP0Zbw9KdTbLaSCuDB-K5KYP
X-Proofpoint-ORIG-GUID: yT5IejgDNP0Zbw9KdTbLaSCuDB-K5KYP
X-Authority-Analysis: v=2.4 cv=McZsu4/f c=1 sm=1 tr=0 ts=68790247 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=fQ16MQn1BotIw16Uv_wA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-17_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxlogscore=999 impostorscore=0 mlxscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1011 suspectscore=0
 spamscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507170123

The existing OPP table in the device tree for PCIe is shared across
different link configurations such as data rates 8GT/s x2 and 16GT/s x1.
These configurations often operate at the same frequency, allowing them
to reuse the same OPP entries. However, 8GT/s and 16 GT/s may have
different characteristics beyond frequency—such as RPMh votes in QCOM
case, which cannot be represented accurately when sharing a single OPP.

To avoid conflicts and duplication in the device tree, we now define only
one set of OPP entries per table and introduce a new mechanism to adjust
bandwidth dynamically using a `bw_factor`.

The `bw_factor` is a multiplier applied to the average and peak bandwidth
values of an OPP entry. This allows PCIe drivers to modify the effective
bandwidth at runtime based on the actual link width without needing
separate OPP entries for each configuration.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/opp/core.c     | 37 +++++++++++++++++++++++++++++++++++--
 drivers/opp/opp.h      |  2 ++
 include/linux/pm_opp.h |  7 +++++++
 3 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index edbd60501cf00dfd1957f7d19b228d1c61bbbdcc..bd618fd1a36fa9c252408beb35ac2e39bfb17ee5 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1060,8 +1060,8 @@ static int _set_opp_bw(const struct opp_table *opp_table,
 			avg = 0;
 			peak = 0;
 		} else {
-			avg = opp->bandwidth[i].avg;
-			peak = opp->bandwidth[i].peak;
+			avg = opp->bandwidth[i].avg * opp_table->bw_factor;
+			peak = opp->bandwidth[i].peak * opp_table->bw_factor;
 		}
 		ret = icc_set_bw(opp_table->paths[i], avg, peak);
 		if (ret) {
@@ -1461,6 +1461,7 @@ static struct opp_table *_allocate_opp_table(struct device *dev, int index)
 			 __func__, ret);
 	}
 
+	opp_table->bw_factor = 1;
 	BLOCKING_INIT_NOTIFIER_HEAD(&opp_table->head);
 	INIT_LIST_HEAD(&opp_table->opp_list);
 	kref_init(&opp_table->kref);
@@ -2815,6 +2816,38 @@ static int _opp_set_availability(struct device *dev, unsigned long freq,
 	return 0;
 }
 
+/**
+ * dev_pm_opp_set_bw_factor() - helper to change the bw factor
+ * @dev:		device for which we do this operation
+ * @bw_factor:		bw factor which multiples the supplied bw
+ *
+ * Return: -EINVAL for bad pointers, -ENOMEM if no memory available for the
+ * copy operation, returns 0 if no modifcation was done OR modification was
+ * successful.
+ */
+int dev_pm_opp_set_bw_factor(struct device *dev, u8 bw_factor)
+{
+	struct opp_table *opp_table __free(put_opp_table);
+	int r;
+
+	/* Find the opp_table */
+	opp_table = _find_opp_table(dev);
+	if (IS_ERR(opp_table)) {
+		r = PTR_ERR(opp_table);
+		dev_warn(dev, "%s: Device OPP not found (%d)\n", __func__, r);
+		return r;
+	}
+
+	if (opp_table->bw_factor == bw_factor)
+		return 0;
+
+	scoped_guard(mutex, &opp_table->lock)
+		opp_table->bw_factor = bw_factor;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_set_bw_factor);
+
 /**
  * dev_pm_opp_adjust_voltage() - helper to change the voltage of an OPP
  * @dev:		device for which we do this operation
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index 9eba63e01a9e7650cf2e49515b70ba73f72210fc..f52d8582b705f1dcf8b5c8279716d38acb273a6c 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -192,6 +192,7 @@ enum opp_table_access {
  * property).
  * @paths: Interconnect path handles
  * @path_count: Number of interconnect paths
+ * @bw_factor: Multiplier to the supplied bw
  * @enabled: Set to true if the device's resources are enabled/configured.
  * @is_genpd: Marks if the OPP table belongs to a genpd.
  * @dentry:	debugfs dentry pointer of the real device directory (not links).
@@ -240,6 +241,7 @@ struct opp_table {
 	int regulator_count;
 	struct icc_path **paths;
 	unsigned int path_count;
+	u8 bw_factor;
 	bool enabled;
 	bool is_genpd;
 
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index cf477beae4bbede88223566df5f43d85adc5a816..4b090fd7391975ab3fa9a94e939325de946cadfa 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -170,6 +170,8 @@ int dev_pm_opp_add_dynamic(struct device *dev, struct dev_pm_opp_data *opp);
 void dev_pm_opp_remove(struct device *dev, unsigned long freq);
 void dev_pm_opp_remove_all_dynamic(struct device *dev);
 
+int dev_pm_opp_set_bw_factor(struct device *dev, u8 bw_factor);
+
 int dev_pm_opp_adjust_voltage(struct device *dev, unsigned long freq,
 			      unsigned long u_volt, unsigned long u_volt_min,
 			      unsigned long u_volt_max);
@@ -371,6 +373,11 @@ static inline void dev_pm_opp_remove_all_dynamic(struct device *dev)
 {
 }
 
+static inline int dev_pm_opp_set_bw_factor(struct device *dev, u8 bw_factor)
+{
+	return 0;
+}
+
 static inline int
 dev_pm_opp_adjust_voltage(struct device *dev, unsigned long freq,
 			  unsigned long u_volt, unsigned long u_volt_min,

-- 
2.34.1



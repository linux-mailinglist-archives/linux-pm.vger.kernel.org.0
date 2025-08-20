Return-Path: <linux-pm+bounces-32682-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DDA2B2D680
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 10:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF8933A89E4
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 08:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC08A2D9795;
	Wed, 20 Aug 2025 08:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hlYyZTWg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD2B2D978C
	for <linux-pm@vger.kernel.org>; Wed, 20 Aug 2025 08:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755678546; cv=none; b=kWQOO1oIM6eMrrOBTW4cSv9Tp6p6EXLbAGejMuK+PkOzk1dydR9+htin87uVW7arjLJscDil08LYG45BjTF26OUERzConCFnNg6qm6Ef4yA9SmGGiAJ+Qz/KasI2VF4oJCklyjVjTB/1gmfpe/SAH2SGMiiSBg249heIaPbwqhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755678546; c=relaxed/simple;
	bh=EhY4xuCpMEih/URp87duQiIBPS0DHeaRqdF08n/fKgU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JT1rnM175uNLUnVkvODkL1SDexKVei/CmTosLKL6tSGTFVI8c7IkE142c5ouNXOiFHp+KM8MqIfVtGhEfzWAMIVwWZsP8OFvGg8kjBIWLZgzeQSIyHgJw4Uw95K0gT1RybEjGHD3uC0gmsS1EHMQbwPGSYEQrEX37/u4IQc3G+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hlYyZTWg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57K1oUZP010404
	for <linux-pm@vger.kernel.org>; Wed, 20 Aug 2025 08:29:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	B8QMJ9vpF0zlLWqRcis22pXoAYapEZg+2UYOajBm5j4=; b=hlYyZTWgKQbBrnIY
	aYZRzEBxDg7/5N2DlZRq28sgUZEy4V5XiJKfg0RxIZQI8ZmGHXilBgshcUFHhfs8
	8VelqPPmx8itW3ZKVfCwUTRHXzcN+c4pt8vhAFCl8cPHq1yuDJx6CWOY1wKdwzdy
	/WdLH2K+yxdNR0R3sg8q6oMiw8MTJw7Rcw3BJE2yyBagSckqyqiCCgheGVrDZ/bF
	tTUjhS6m6oU955Li8iuo6Y7bUAFBySBYFNDgDBrrDm5Uc0n16YcV+xTn/GJHePKU
	CK4UxtLvGQ90xchskXMQ5/xLMWZlqCCD0fVoKDUxAabHBSgr4btfY2o7BUCx42ik
	aFI0Uw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n528rym6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 20 Aug 2025 08:29:03 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b4731a95babso3743527a12.0
        for <linux-pm@vger.kernel.org>; Wed, 20 Aug 2025 01:29:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755678542; x=1756283342;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B8QMJ9vpF0zlLWqRcis22pXoAYapEZg+2UYOajBm5j4=;
        b=J8YVQunR4vnnuIYd4w9symwFt+Zzy1JFiWpY/oJdG/aLvHPiAk1yG1Nle6Ka2TpRgn
         zaxVK60jNHurTb3DC6kg/H9g5nG/rpy4OtOl5s5Sk07UAj43rWkAGOErmtsWEMxzkETE
         9RI5zT5GJzSF41iF7N0I/xRvpSWNShFZtgl9UJZFoMlwwsdRTk144q7/MWj+LV3V+4sf
         VCf8E76pyl48ioS7BC4BmyP7woBJrIlYfrEqsvNwCH/qNuM1mqNa9BrxjpxFUYXWgUPI
         h2PTiTm9NG7HvG7Egf4JSwC4N5xeRu7qPuKN5d44OyBY5XYeFWDrZnrWiPUVEVbC9wrp
         PqHA==
X-Gm-Message-State: AOJu0YzbqUa7pnBppzTWqkm8baGDMX7cQ5WcTwNfRWYqw5cFBwR9+Co/
	vNJx8mR0F1gQydnOP2bsTnBFfKm7p/3v0vCL3aZTExh+BB1bmCD6KF3Ih6WDSQ6PjnV9A4bauyD
	fGmI+UvlTb+Me1KNpsHMksimzMBzERfPDylDAcv5cZ2TcNsowEa098agvVDkqew==
X-Gm-Gg: ASbGncsUkVOYWiJB7EVDO3JjbsP7Htwk5btE8yA9iiJFJmcjpBDsqSTfDi1onft++cp
	HAiYlMYB35VF9TneamoxRLivNCKcuSNOjHhFb88TBVDzn2hNfRRZuOF+/vjO/ogYjm+w7PMbE/g
	7XEXd6h2M91vrZxGNDrsr1HCfd7hHlfTd3eAZD9peaY6JVzJEgo71X0uo/W7cX5cR2PanyEDjh9
	tl0sfg6obbbAVx9vgkaIp9oqKavH7GKTNGAF1gWQ8xguMaxRDkA9VWLD7aehDVJ+HuqAny0EZPg
	bb5VHqvI/M5Uw+rVv8jF3nfbi9OBCpdEcyvDEiPvq22C88cB430+2kfgxoD430PPi/dpk5yGRx4
	=
X-Received: by 2002:a17:903:41ca:b0:234:1163:ff99 with SMTP id d9443c01a7336-245ef2588ebmr31909835ad.43.1755678541648;
        Wed, 20 Aug 2025 01:29:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbx7fYvpZPIFT5sJ2Mt+iC9p5jnxfxvgdPBTlz4tSTL4HOYUE3N1nRxKwMFIvDBpuOLZ8YwQ==
X-Received: by 2002:a17:903:41ca:b0:234:1163:ff99 with SMTP id d9443c01a7336-245ef2588ebmr31909445ad.43.1755678541147;
        Wed, 20 Aug 2025 01:29:01 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed53e779sm19037735ad.160.2025.08.20.01.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 01:29:00 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Wed, 20 Aug 2025 13:58:47 +0530
Subject: [PATCH v4 1/7] OPP: Add support to find OPP for a set of keys
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-opp_pcie-v4-1-273b8944eed0@oss.qualcomm.com>
References: <20250820-opp_pcie-v4-0-273b8944eed0@oss.qualcomm.com>
In-Reply-To: <20250820-opp_pcie-v4-0-273b8944eed0@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755678529; l=7390;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=EhY4xuCpMEih/URp87duQiIBPS0DHeaRqdF08n/fKgU=;
 b=2dHOB34fD3FM1XRFbvrFZui4HXg7KF3A/yjzatOHxOz3uegFFYzt6cIRvsbaV9VaKV9FRiVNa
 jnvM2zx3Xi8Bwx+o6bbtDYCL7iuXsjVi2sy7XYzwXXcxc9oWKvzMqC8
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=I4c8hNgg c=1 sm=1 tr=0 ts=68a5874f cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=76l3OPsZB85xAofE:21 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8
 a=_oSDH_OZDe2PRR-3SxkA:9 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: 8_nUct_pdPmBkHnGuWrt3BPlh70qQRV9
X-Proofpoint-ORIG-GUID: 8_nUct_pdPmBkHnGuWrt3BPlh70qQRV9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX3LF2mlhh9CSq
 LhsqutzedviWpqsMMHIdJ+H57qq13ACo9R1SM8YZnphXMbNLLv2rXFHGe5U39V2vWYZN5OP8Dvm
 8Fpj9YW5Lm7apx7fqoeC4Ta9IfVb1/S5Q+5o4H80tpj//WjYizJtT+OKQjMO/nCMwv+xQ5TqU/M
 atAqlrOy7Xjrbmla7RAwDygutDAPleDGnwVwD2jL2hMq/+AyJm/nHbUiv3VF4xZE67+lPN9afNN
 G6qjVdcv4eDdO8K5FqkOyMkdk9pGlfeuMQLiIdfGmnWTDqIuWAraIbod3U9grj2ONdRksdlgJJh
 lbaEv+wFNiZQHFl7Qh1v2fTjUBtB5MVW4Vy2NiBHwflayCZBmcf9KrHfWcNaGskrboiSCvB4rYB
 ga2S6a8yVxWqdjPmyJoEDW7mOL7/tA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_03,2025-08-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 malwarescore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 impostorscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

Some clients, such as PCIe, may operate at the same clock frequency
across different data rates by varying link width. In such cases,
frequency alone is not sufficient to uniquely identify an OPP.
To support these scenarios, introduce a new API
dev_pm_opp_find_key_exact() that allows OPP lookup with different
set of keys like freq, level & bandwidth.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/opp/core.c     | 97 ++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pm_opp.h | 30 ++++++++++++++++
 2 files changed, 127 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index edbd60501cf00dfd1957f7d19b228d1c61bbbdcc..a36c3daac39cd0bdd2a1f7e9bad5b92f0c756153 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -476,6 +476,15 @@ static unsigned long _read_bw(struct dev_pm_opp *opp, int index)
 	return opp->bandwidth[index].peak;
 }
 
+static unsigned long _read_opp_key(struct dev_pm_opp *opp, int index, struct dev_pm_opp_key *key)
+{
+	key->bw = opp->bandwidth ? opp->bandwidth[index].peak : 0;
+	key->freq = opp->rates[index];
+	key->level = opp->level;
+
+	return true;
+}
+
 /* Generic comparison helpers */
 static bool _compare_exact(struct dev_pm_opp **opp, struct dev_pm_opp *temp_opp,
 			   unsigned long opp_key, unsigned long key)
@@ -509,6 +518,21 @@ static bool _compare_floor(struct dev_pm_opp **opp, struct dev_pm_opp *temp_opp,
 	return false;
 }
 
+static bool _compare_opp_key_exact(struct dev_pm_opp **opp, struct dev_pm_opp *temp_opp,
+				   struct dev_pm_opp_key opp_key, struct dev_pm_opp_key key)
+{
+	bool level_match = (key.level == OPP_LEVEL_UNSET || opp_key.level == key.level);
+	bool freq_match = (key.freq == 0 || opp_key.freq == key.freq);
+	bool bw_match = (key.bw == 0 || opp_key.bw == key.bw);
+
+	if (freq_match && level_match && bw_match) {
+		*opp = temp_opp;
+		return true;
+	}
+
+	return false;
+}
+
 /* Generic key finding helpers */
 static struct dev_pm_opp *_opp_table_find_key(struct opp_table *opp_table,
 		unsigned long *key, int index, bool available,
@@ -541,6 +565,38 @@ static struct dev_pm_opp *_opp_table_find_key(struct opp_table *opp_table,
 	return opp;
 }
 
+static struct dev_pm_opp *_opp_table_find_opp_key(struct opp_table *opp_table,
+		struct dev_pm_opp_key *key, bool available,
+		unsigned long (*read)(struct dev_pm_opp *opp, int index,
+				      struct dev_pm_opp_key *key),
+		bool (*compare)(struct dev_pm_opp **opp, struct dev_pm_opp *temp_opp,
+				struct dev_pm_opp_key opp_key, struct dev_pm_opp_key key),
+		bool (*assert)(struct opp_table *opp_table, unsigned int index))
+{
+	struct dev_pm_opp *temp_opp, *opp = ERR_PTR(-ERANGE);
+	struct dev_pm_opp_key temp_key;
+
+	/* Assert that the requirement is met */
+	if (!assert(opp_table, 0))
+		return ERR_PTR(-EINVAL);
+
+	guard(mutex)(&opp_table->lock);
+
+	list_for_each_entry(temp_opp, &opp_table->opp_list, node) {
+		if (temp_opp->available == available) {
+			read(temp_opp, 0, &temp_key);
+			if (compare(&opp, temp_opp, temp_key, *key)) {
+				/* Increment the reference count of OPP */
+				*key = temp_key;
+				dev_pm_opp_get(opp);
+				break;
+			}
+		}
+	}
+
+	return opp;
+}
+
 static struct dev_pm_opp *
 _find_key(struct device *dev, unsigned long *key, int index, bool available,
 	  unsigned long (*read)(struct dev_pm_opp *opp, int index),
@@ -632,6 +688,47 @@ struct dev_pm_opp *dev_pm_opp_find_freq_exact(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_exact);
 
+/**
+ * dev_pm_opp_find_key_exact() - Search for an exact OPP key
+ * @dev:                Device for which the OPP is being searched
+ * @key:                OPP key to match
+ * @available:          true/false - match for available OPP
+ *
+ * Search for an exact match the OPP key in the OPP table.
+ *
+ * Return: matching *opp, else returns ERR_PTR in case of error and should
+ * be using IS_ERR. Error return values can be:
+ * EINVAL:      for bad pointer
+ * ERANGE:      no match found for search
+ * ENODEV:      if device not found in list of registered devices
+ *
+ * Note: 'available' is a modifier for the search. If 'available'=true,
+ * then the match is for exact matching key and is available in the stored
+ * OPP table. If false, the match is for exact key which is not available.
+ *
+ * This provides a mechanism to enable an OPP which is not available currently
+ * or the opposite as well.
+ *
+ * The callers are required to call dev_pm_opp_put() for the returned OPP after
+ * use.
+ */
+struct dev_pm_opp *dev_pm_opp_find_key_exact(struct device *dev,
+					     struct dev_pm_opp_key key,
+					     bool available)
+{
+	struct opp_table *opp_table __free(put_opp_table) = _find_opp_table(dev);
+
+	if (IS_ERR(opp_table)) {
+		dev_err(dev, "%s: OPP table not found (%ld)\n", __func__,
+			PTR_ERR(opp_table));
+		return ERR_CAST(opp_table);
+	}
+
+	return _opp_table_find_opp_key(opp_table, &key, available, _read_opp_key,
+				       _compare_opp_key_exact, assert_single_clk);
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_find_key_exact);
+
 /**
  * dev_pm_opp_find_freq_exact_indexed() - Search for an exact freq for the
  *					 clock corresponding to the index
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index cf477beae4bbede88223566df5f43d85adc5a816..5d244bf974891d55b5e21ca9459c147c7223b9b0 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -98,6 +98,25 @@ struct dev_pm_opp_data {
 	unsigned long u_volt;
 };
 
+/**
+ * struct dev_pm_opp_key - Key used to identify OPP entries
+ * @freq:       Frequency in Hz. Use 0 if frequency is not to be matched.
+ * @level:      Performance level associated with the OPP entry.
+ *              Use OPP_LEVEL_UNSET if level is not to be matched.
+ * @bw:         Bandwidth associated with the OPP entry.
+ *              Use 0 if bandwidth is not to be matched.
+ *
+ * This structure is used to uniquely identify an OPP entry based on
+ * frequency, performance level, and bandwidth. Each field can be
+ * selectively ignored during matching by setting it to its respective
+ * NOP value.
+ */
+struct dev_pm_opp_key {
+	unsigned long freq;
+	unsigned int level;
+	u32 bw;
+};
+
 #if defined(CONFIG_PM_OPP)
 
 struct opp_table *dev_pm_opp_get_opp_table(struct device *dev);
@@ -131,6 +150,10 @@ struct dev_pm_opp *dev_pm_opp_find_freq_exact(struct device *dev,
 					      unsigned long freq,
 					      bool available);
 
+struct dev_pm_opp *dev_pm_opp_find_key_exact(struct device *dev,
+					     struct dev_pm_opp_key key,
+					     bool available);
+
 struct dev_pm_opp *
 dev_pm_opp_find_freq_exact_indexed(struct device *dev, unsigned long freq,
 				   u32 index, bool available);
@@ -289,6 +312,13 @@ static inline struct dev_pm_opp *dev_pm_opp_find_freq_exact(struct device *dev,
 	return ERR_PTR(-EOPNOTSUPP);
 }
 
+static inline struct dev_pm_opp *dev_pm_opp_find_key_exact(struct device *dev,
+							   struct dev_pm_opp_key key,
+							   bool available)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
 static inline struct dev_pm_opp *
 dev_pm_opp_find_freq_exact_indexed(struct device *dev, unsigned long freq,
 				   u32 index, bool available)

-- 
2.34.1



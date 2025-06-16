Return-Path: <linux-pm+bounces-28745-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FFEADA505
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 02:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E36323AFF94
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 00:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2531EE032;
	Mon, 16 Jun 2025 00:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GLJrBjPn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23991E22E9
	for <linux-pm@vger.kernel.org>; Mon, 16 Jun 2025 00:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750033747; cv=none; b=fyUEmNQXKjYGuZSAX3aKaE4igw/S/w4tnuZDrfJAAE+0J9kfDX9NTOKxK0Gl37B3DmYf+WQAQ5DTi77OhrZwyFv5x02Eguny/efwr2ckCwZPz+mqey+h3Hvtt37Y9/o9TXoYstfIFVEJljnI82UucOSoe3Lmvsy9boYnlOuyhcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750033747; c=relaxed/simple;
	bh=jSiWKBNRRuNeE9ajNG2k/hjhPYupU+fLbukGoH5SCuU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TMP2Qw4fqB0rFShPX2G0KM8lvp4VhPZuUodmeIcewDuh5s0GeTAv7E44JN+v9HtZcEDWnMFRC7X5xGaVSGrCtzyDbn8SYszLrYwvE/Nm5b52ViVT5AzcfsVJzPg9WBJSiqb7OjvqLC7VXTMi+4Bbqf5fUG7HaVKqaW6E9CcbYtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GLJrBjPn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55FKKdAF005881
	for <linux-pm@vger.kernel.org>; Mon, 16 Jun 2025 00:29:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4mhlqAdvRvr1hJNuk7oixzhHCMRkue6w6eMW0TTaTXg=; b=GLJrBjPn/jECLl4w
	5/7GfW0UBMRBIQXkYURSJYuVHtF+0x9lS0L2dPwnb/rzDO+pEXE8qp6fxwag9ROD
	RuihrRkcUZyDmi0vJHg6mMOvoxOK+z10OqqIBSFT/B+xQ1PvXjWApuoil8T6U2Me
	lQoCsurOA889rnYTttP7HpLznSZZVCQ6ueSgkXOweuwPTlXTnOTik9Qhue7XzCoS
	JOSUDuTuPSk1MVbH0a7s+sLqJD+NbhhvTjY/RdaOhVzASxjTb7tCXfF1+I2gGy52
	BNiCSws20pCRKjTOKrar0kG+iEBq+vxcEPcOdlEtDrO7b190VMHf2G4jakU8srqM
	8LYRpw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4791hfam8e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 16 Jun 2025 00:29:02 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7d3d3f71813so80439485a.1
        for <linux-pm@vger.kernel.org>; Sun, 15 Jun 2025 17:29:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750033741; x=1750638541;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4mhlqAdvRvr1hJNuk7oixzhHCMRkue6w6eMW0TTaTXg=;
        b=EqnlTN3eg/o9uL19yWkkL198LQjD1cKRsQXuh+lGzdmEHvh1yqkHpXze48gboq9z+r
         o3s8eKxrBgG2y8FTyQ0DS+0OmwADox+7FFadni+cjr4B54JIVEAmMohgztwvv8k2reHy
         yXCKJ12LRWwIYoRMLsz1uF7StrdGHWi21SjBOo4CUGg18MNCoLbYuYfote+72hhSMkwQ
         5J3kNtM5RSBkrOGfe6zTLP/b6ZWGPGgs0qsaIlnnTigSFi5LbEQzCvVDOmOm8rHQ/aob
         JE0JNbpoIRvHYis7WkKlMSaEGObkBX/k1GY5fAvkYQg0yJQ9uTqBbIOtWBdeAXfBRWlA
         IvHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcjBgYmftFd9fztEfT98+lOIMVeTloOCFkeF/MydBUIRORK3uG3X+vjHVTvRD99ZZcmQQ8XN5NDw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyX+Q3VTm75/hIXE53Sf3QVU1L8rv1iJadiunUEgzYA4gYno0gE
	98X9sOCn/zyzxUcnqFxaoas8GZMzGZI76l71X5wKQ82+EHK3zy3nKSOS3FrxR5NwawezoeVzvAv
	FTzcPm6+ZNfwkD/ybVm36WkV8RP9s+JZonN27ppklEfBefmuemnL6uZ/JOyYKPg==
X-Gm-Gg: ASbGnctJ2LUdRdO7xP+SzoSgqQR6qtGYBkJ7hz6kSsN38+p8wShh/fmPgQxU0J+xc0u
	GmWOROqcK/m8FSP6K3in+ojuWMtP7rJweVlYuLWujkIb4QDvbqq5Mfsj9pUduGfTsMbu497FMhy
	y/cITtTFGosp1mI732GaBUGd2aWLajugQxmQ1QU03MAwXhsjHhGsLBTrD+ET3gn1Fnk0P5rvx2k
	bhd3AOllg7djyp0YGzLjEHp9wvDj+7wW+H0h153qAzBixOduhVIEFcQ8S6fOACVUwCLWgNZQhfq
	BAfXh6rXoUMOQ3sisLI5IOtUfZEB/uYsmTWz04aCiSVJlwh2BkcKv6YzB9KDSvh8Sqg1WIOuwRN
	7GjT2MfDNoItNR1fl26QuJbvqM0tLS1VHNrQ=
X-Received: by 2002:a05:6214:d65:b0:6fa:99a5:7cbc with SMTP id 6a1803df08f44-6fb4762f7cbmr142419306d6.7.1750033740702;
        Sun, 15 Jun 2025 17:29:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6Z9RUXtBxHX+izKRG4rGVfxGi1LmkqCm1kdOR/NJ6/uTqD/UGRQiwGDlNqsfCaw5UtDfF6A==
X-Received: by 2002:a05:6214:d65:b0:6fa:99a5:7cbc with SMTP id 6a1803df08f44-6fb4762f7cbmr142418746d6.7.1750033739923;
        Sun, 15 Jun 2025 17:28:59 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553ac136104sm1334990e87.77.2025.06.15.17.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jun 2025 17:28:57 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 16 Jun 2025 03:28:21 +0300
Subject: [PATCH 09/28] interconnect: qcom: sm8250: convert to dynamic IDs
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250616-rework-icc-v1-9-bc1326294d71@oss.qualcomm.com>
References: <20250616-rework-icc-v1-0-bc1326294d71@oss.qualcomm.com>
In-Reply-To: <20250616-rework-icc-v1-0-bc1326294d71@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=54064;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=jSiWKBNRRuNeE9ajNG2k/hjhPYupU+fLbukGoH5SCuU=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBoT2Ui5dCm0/h4+edjE7f0HH9t5Li8OWHFDJvDw
 xZlpZYu//+JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaE9lIgAKCRCLPIo+Aiko
 1VlJCACsX+9E0LCf8wA5jg0sgUNUvumGuUSyWaOahXS/C0mRIYLyfZrkc2kRMBzK49uCHvt62Xc
 3+0UDYZymR/I4RONr5tbnb8AlfZ5V7v5wWOP7T0/PQqkG51AsbHLOSEc8cfTuJ747XdPSMOsje6
 cC7JRYAAERnm5uSJmX9Xwxz1QaZ24BrU426MOGug5xpIKxi4PEjH93bBDkpwLQKE0VY1/Mw+cJ2
 cXwHRhTN+JXRZq/8yWOSXYxPAVOiCCbEQNZJ0IKWkFI2FqifYfWDpCKuEkSxexJ7b3/bA+jjv8Z
 IjVoTAojtUYQJTY6V7SimZDTKdKO0Q3Z4hbo6iKmtpT/vB0F
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDAwMSBTYWx0ZWRfXwWITyzFmck6w
 UfuE2odYyhyjrn9DW8LnmO2s4z//I9OzE3yTrBnsvm7+aHpAoIOmwGrCC3Ee2TF8O42Npf3a4+4
 DDFOUdrjPRpRxMU0LbKmPMpZRB1jZ10UCKr+4J0q//LRZCGHXsht+JIPQZZxTGJJGNSf9Jm7hxU
 QRxGtzLw5CwLSRaQWAZZOjH0pwscxHOwYaf6G6ZD1GmpaEJDaO+PoYqcm6VlnCO38X8R8jN70Ag
 TIsm8JQ5XFbiz150zOBa4wbjkNvxQbd/golUlphmp4Xrw2oU5DK3aSDN+A8J/w4SVJ7TOsh/Uli
 6PLBN+3WyttVhNxF+kZI/3+LaqDFWDP8r/6QvrzFZ3TaOZG7ykL6ajOO/R81zdCckNZ+BJ7Flw4
 s1ebuoRFJ31Z3fk78U3YOpuyysJ9DqVRkHhSzILCCtN7uYYly7DeQFUVw8/Wf0a83J2xk7bq
X-Authority-Analysis: v=2.4 cv=VvEjA/2n c=1 sm=1 tr=0 ts=684f654e cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=ZcoDVatzCXcLvNUMJK0A:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: s2iwKXALQ4PbHGoYewEp6-UUlvU8KAGk
X-Proofpoint-ORIG-GUID: s2iwKXALQ4PbHGoYewEp6-UUlvU8KAGk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-15_10,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxscore=0 lowpriorityscore=0 spamscore=0 mlxlogscore=999
 malwarescore=0 impostorscore=0 clxscore=1015 bulkscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506160001

Stop using fixed and IDs and covert the platform to use dynamic IDs for
the interconnect. This gives more flexibility and also allows us to drop
the .num_links member, saving from possible errors related to it being
not set or set incorrectly.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/interconnect/qcom/sm8250.c | 894 ++++++++++++++++++-------------------
 drivers/interconnect/qcom/sm8250.h | 168 -------
 2 files changed, 436 insertions(+), 626 deletions(-)

diff --git a/drivers/interconnect/qcom/sm8250.c b/drivers/interconnect/qcom/sm8250.c
index cd7a37ecb9b55e40e9a90a9b649ae8cced1d1bb3..d75b2c717f07f90a3dad7424d77dcb7c6598b7d3 100644
--- a/drivers/interconnect/qcom/sm8250.c
+++ b/drivers/interconnect/qcom/sm8250.c
@@ -14,1385 +14,1363 @@
 
 #include "bcm-voter.h"
 #include "icc-rpmh.h"
-#include "sm8250.h"
+
+static struct qcom_icc_node qhm_a1noc_cfg;
+static struct qcom_icc_node qhm_qspi;
+static struct qcom_icc_node qhm_qup1;
+static struct qcom_icc_node qhm_qup2;
+static struct qcom_icc_node qhm_tsif;
+static struct qcom_icc_node xm_pcie3_modem;
+static struct qcom_icc_node xm_sdc4;
+static struct qcom_icc_node xm_ufs_mem;
+static struct qcom_icc_node xm_usb3_0;
+static struct qcom_icc_node xm_usb3_1;
+static struct qcom_icc_node qhm_a2noc_cfg;
+static struct qcom_icc_node qhm_qdss_bam;
+static struct qcom_icc_node qhm_qup0;
+static struct qcom_icc_node qnm_cnoc;
+static struct qcom_icc_node qxm_crypto;
+static struct qcom_icc_node qxm_ipa;
+static struct qcom_icc_node xm_pcie3_0;
+static struct qcom_icc_node xm_pcie3_1;
+static struct qcom_icc_node xm_qdss_etr;
+static struct qcom_icc_node xm_sdc2;
+static struct qcom_icc_node xm_ufs_card;
+static struct qcom_icc_node qnm_npu;
+static struct qcom_icc_node qnm_snoc;
+static struct qcom_icc_node xm_qdss_dap;
+static struct qcom_icc_node qhm_cnoc_dc_noc;
+static struct qcom_icc_node alm_gpu_tcu;
+static struct qcom_icc_node alm_sys_tcu;
+static struct qcom_icc_node chm_apps;
+static struct qcom_icc_node qhm_gemnoc_cfg;
+static struct qcom_icc_node qnm_cmpnoc;
+static struct qcom_icc_node qnm_gpu;
+static struct qcom_icc_node qnm_mnoc_hf;
+static struct qcom_icc_node qnm_mnoc_sf;
+static struct qcom_icc_node qnm_pcie;
+static struct qcom_icc_node qnm_snoc_gc;
+static struct qcom_icc_node qnm_snoc_sf;
+static struct qcom_icc_node llcc_mc;
+static struct qcom_icc_node qhm_mnoc_cfg;
+static struct qcom_icc_node qnm_camnoc_hf;
+static struct qcom_icc_node qnm_camnoc_icp;
+static struct qcom_icc_node qnm_camnoc_sf;
+static struct qcom_icc_node qnm_video0;
+static struct qcom_icc_node qnm_video1;
+static struct qcom_icc_node qnm_video_cvp;
+static struct qcom_icc_node qxm_mdp0;
+static struct qcom_icc_node qxm_mdp1;
+static struct qcom_icc_node qxm_rot;
+static struct qcom_icc_node amm_npu_sys;
+static struct qcom_icc_node amm_npu_sys_cdp_w;
+static struct qcom_icc_node qhm_cfg;
+static struct qcom_icc_node qhm_snoc_cfg;
+static struct qcom_icc_node qnm_aggre1_noc;
+static struct qcom_icc_node qnm_aggre2_noc;
+static struct qcom_icc_node qnm_gemnoc;
+static struct qcom_icc_node qnm_gemnoc_pcie;
+static struct qcom_icc_node qxm_pimem;
+static struct qcom_icc_node xm_gic;
+static struct qcom_icc_node qns_a1noc_snoc;
+static struct qcom_icc_node qns_pcie_modem_mem_noc;
+static struct qcom_icc_node srvc_aggre1_noc;
+static struct qcom_icc_node qns_a2noc_snoc;
+static struct qcom_icc_node qns_pcie_mem_noc;
+static struct qcom_icc_node srvc_aggre2_noc;
+static struct qcom_icc_node qns_cdsp_mem_noc;
+static struct qcom_icc_node qhs_a1_noc_cfg;
+static struct qcom_icc_node qhs_a2_noc_cfg;
+static struct qcom_icc_node qhs_ahb2phy0;
+static struct qcom_icc_node qhs_ahb2phy1;
+static struct qcom_icc_node qhs_aoss;
+static struct qcom_icc_node qhs_camera_cfg;
+static struct qcom_icc_node qhs_clk_ctl;
+static struct qcom_icc_node qhs_compute_dsp;
+static struct qcom_icc_node qhs_cpr_cx;
+static struct qcom_icc_node qhs_cpr_mmcx;
+static struct qcom_icc_node qhs_cpr_mx;
+static struct qcom_icc_node qhs_crypto0_cfg;
+static struct qcom_icc_node qhs_cx_rdpm;
+static struct qcom_icc_node qhs_dcc_cfg;
+static struct qcom_icc_node qhs_ddrss_cfg;
+static struct qcom_icc_node qhs_display_cfg;
+static struct qcom_icc_node qhs_gpuss_cfg;
+static struct qcom_icc_node qhs_imem_cfg;
+static struct qcom_icc_node qhs_ipa;
+static struct qcom_icc_node qhs_ipc_router;
+static struct qcom_icc_node qhs_lpass_cfg;
+static struct qcom_icc_node qhs_mnoc_cfg;
+static struct qcom_icc_node qhs_npu_cfg;
+static struct qcom_icc_node qhs_pcie0_cfg;
+static struct qcom_icc_node qhs_pcie1_cfg;
+static struct qcom_icc_node qhs_pcie_modem_cfg;
+static struct qcom_icc_node qhs_pdm;
+static struct qcom_icc_node qhs_pimem_cfg;
+static struct qcom_icc_node qhs_prng;
+static struct qcom_icc_node qhs_qdss_cfg;
+static struct qcom_icc_node qhs_qspi;
+static struct qcom_icc_node qhs_qup0;
+static struct qcom_icc_node qhs_qup1;
+static struct qcom_icc_node qhs_qup2;
+static struct qcom_icc_node qhs_sdc2;
+static struct qcom_icc_node qhs_sdc4;
+static struct qcom_icc_node qhs_snoc_cfg;
+static struct qcom_icc_node qhs_tcsr;
+static struct qcom_icc_node qhs_tlmm0;
+static struct qcom_icc_node qhs_tlmm1;
+static struct qcom_icc_node qhs_tlmm2;
+static struct qcom_icc_node qhs_tsif;
+static struct qcom_icc_node qhs_ufs_card_cfg;
+static struct qcom_icc_node qhs_ufs_mem_cfg;
+static struct qcom_icc_node qhs_usb3_0;
+static struct qcom_icc_node qhs_usb3_1;
+static struct qcom_icc_node qhs_venus_cfg;
+static struct qcom_icc_node qhs_vsense_ctrl_cfg;
+static struct qcom_icc_node qns_cnoc_a2noc;
+static struct qcom_icc_node srvc_cnoc;
+static struct qcom_icc_node qhs_llcc;
+static struct qcom_icc_node qhs_memnoc;
+static struct qcom_icc_node qns_gem_noc_snoc;
+static struct qcom_icc_node qns_llcc;
+static struct qcom_icc_node qns_sys_pcie;
+static struct qcom_icc_node srvc_even_gemnoc;
+static struct qcom_icc_node srvc_odd_gemnoc;
+static struct qcom_icc_node srvc_sys_gemnoc;
+static struct qcom_icc_node ebi;
+static struct qcom_icc_node qns_mem_noc_hf;
+static struct qcom_icc_node qns_mem_noc_sf;
+static struct qcom_icc_node srvc_mnoc;
+static struct qcom_icc_node qhs_cal_dp0;
+static struct qcom_icc_node qhs_cal_dp1;
+static struct qcom_icc_node qhs_cp;
+static struct qcom_icc_node qhs_dma_bwmon;
+static struct qcom_icc_node qhs_dpm;
+static struct qcom_icc_node qhs_isense;
+static struct qcom_icc_node qhs_llm;
+static struct qcom_icc_node qhs_tcm;
+static struct qcom_icc_node qns_npu_sys;
+static struct qcom_icc_node srvc_noc;
+static struct qcom_icc_node qhs_apss;
+static struct qcom_icc_node qns_cnoc;
+static struct qcom_icc_node qns_gemnoc_gc;
+static struct qcom_icc_node qns_gemnoc_sf;
+static struct qcom_icc_node qxs_imem;
+static struct qcom_icc_node qxs_pimem;
+static struct qcom_icc_node srvc_snoc;
+static struct qcom_icc_node xs_pcie_0;
+static struct qcom_icc_node xs_pcie_1;
+static struct qcom_icc_node xs_pcie_modem;
+static struct qcom_icc_node xs_qdss_stm;
+static struct qcom_icc_node xs_sys_tcu_cfg;
+static struct qcom_icc_node qup0_core_master;
+static struct qcom_icc_node qup1_core_master;
+static struct qcom_icc_node qup2_core_master;
+static struct qcom_icc_node qup0_core_slave;
+static struct qcom_icc_node qup1_core_slave;
+static struct qcom_icc_node qup2_core_slave;
 
 static struct qcom_icc_node qhm_a1noc_cfg = {
 	.name = "qhm_a1noc_cfg",
-	.id = SM8250_MASTER_A1NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM8250_SLAVE_SERVICE_A1NOC },
+	.link_nodes = { &srvc_aggre1_noc, NULL },
 };
 
 static struct qcom_icc_node qhm_qspi = {
 	.name = "qhm_qspi",
-	.id = SM8250_MASTER_QSPI_0,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM8250_A1NOC_SNOC_SLV },
+	.link_nodes = { &qns_a1noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qhm_qup1 = {
 	.name = "qhm_qup1",
-	.id = SM8250_MASTER_QUP_1,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM8250_A1NOC_SNOC_SLV },
+	.link_nodes = { &qns_a1noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qhm_qup2 = {
 	.name = "qhm_qup2",
-	.id = SM8250_MASTER_QUP_2,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM8250_A1NOC_SNOC_SLV },
+	.link_nodes = { &qns_a1noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qhm_tsif = {
 	.name = "qhm_tsif",
-	.id = SM8250_MASTER_TSIF,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM8250_A1NOC_SNOC_SLV },
+	.link_nodes = { &qns_a1noc_snoc, NULL },
 };
 
 static struct qcom_icc_node xm_pcie3_modem = {
 	.name = "xm_pcie3_modem",
-	.id = SM8250_MASTER_PCIE_2,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM8250_SLAVE_ANOC_PCIE_GEM_NOC_1 },
+	.link_nodes = { &qns_pcie_modem_mem_noc, NULL },
 };
 
 static struct qcom_icc_node xm_sdc4 = {
 	.name = "xm_sdc4",
-	.id = SM8250_MASTER_SDCC_4,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM8250_A1NOC_SNOC_SLV },
+	.link_nodes = { &qns_a1noc_snoc, NULL },
 };
 
 static struct qcom_icc_node xm_ufs_mem = {
 	.name = "xm_ufs_mem",
-	.id = SM8250_MASTER_UFS_MEM,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM8250_A1NOC_SNOC_SLV },
+	.link_nodes = { &qns_a1noc_snoc, NULL },
 };
 
 static struct qcom_icc_node xm_usb3_0 = {
 	.name = "xm_usb3_0",
-	.id = SM8250_MASTER_USB3,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM8250_A1NOC_SNOC_SLV },
+	.link_nodes = { &qns_a1noc_snoc, NULL },
 };
 
 static struct qcom_icc_node xm_usb3_1 = {
 	.name = "xm_usb3_1",
-	.id = SM8250_MASTER_USB3_1,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM8250_A1NOC_SNOC_SLV },
+	.link_nodes = { &qns_a1noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qhm_a2noc_cfg = {
 	.name = "qhm_a2noc_cfg",
-	.id = SM8250_MASTER_A2NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM8250_SLAVE_SERVICE_A2NOC },
+	.link_nodes = { &srvc_aggre2_noc, NULL },
 };
 
 static struct qcom_icc_node qhm_qdss_bam = {
 	.name = "qhm_qdss_bam",
-	.id = SM8250_MASTER_QDSS_BAM,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM8250_A2NOC_SNOC_SLV },
+	.link_nodes = { &qns_a2noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qhm_qup0 = {
 	.name = "qhm_qup0",
-	.id = SM8250_MASTER_QUP_0,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM8250_A2NOC_SNOC_SLV },
+	.link_nodes = { &qns_a2noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qnm_cnoc = {
 	.name = "qnm_cnoc",
-	.id = SM8250_MASTER_CNOC_A2NOC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM8250_A2NOC_SNOC_SLV },
+	.link_nodes = { &qns_a2noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qxm_crypto = {
 	.name = "qxm_crypto",
-	.id = SM8250_MASTER_CRYPTO_CORE_0,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM8250_A2NOC_SNOC_SLV },
+	.link_nodes = { &qns_a2noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qxm_ipa = {
 	.name = "qxm_ipa",
-	.id = SM8250_MASTER_IPA,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM8250_A2NOC_SNOC_SLV },
+	.link_nodes = { &qns_a2noc_snoc, NULL },
 };
 
 static struct qcom_icc_node xm_pcie3_0 = {
 	.name = "xm_pcie3_0",
-	.id = SM8250_MASTER_PCIE,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM8250_SLAVE_ANOC_PCIE_GEM_NOC },
+	.link_nodes = { &qns_pcie_mem_noc, NULL },
 };
 
 static struct qcom_icc_node xm_pcie3_1 = {
 	.name = "xm_pcie3_1",
-	.id = SM8250_MASTER_PCIE_1,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM8250_SLAVE_ANOC_PCIE_GEM_NOC },
+	.link_nodes = { &qns_pcie_mem_noc, NULL },
 };
 
 static struct qcom_icc_node xm_qdss_etr = {
 	.name = "xm_qdss_etr",
-	.id = SM8250_MASTER_QDSS_ETR,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM8250_A2NOC_SNOC_SLV },
+	.link_nodes = { &qns_a2noc_snoc, NULL },
 };
 
 static struct qcom_icc_node xm_sdc2 = {
 	.name = "xm_sdc2",
-	.id = SM8250_MASTER_SDCC_2,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM8250_A2NOC_SNOC_SLV },
+	.link_nodes = { &qns_a2noc_snoc, NULL },
 };
 
 static struct qcom_icc_node xm_ufs_card = {
 	.name = "xm_ufs_card",
-	.id = SM8250_MASTER_UFS_CARD,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM8250_A2NOC_SNOC_SLV },
+	.link_nodes = { &qns_a2noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qnm_npu = {
 	.name = "qnm_npu",
-	.id = SM8250_MASTER_NPU,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM8250_SLAVE_CDSP_MEM_NOC },
+	.link_nodes = { &qns_cdsp_mem_noc, NULL },
 };
 
 static struct qcom_icc_node qnm_snoc = {
 	.name = "qnm_snoc",
-	.id = SM8250_SNOC_CNOC_MAS,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 49,
-	.links = { SM8250_SLAVE_CDSP_CFG,
-		   SM8250_SLAVE_CAMERA_CFG,
-		   SM8250_SLAVE_TLMM_SOUTH,
-		   SM8250_SLAVE_TLMM_NORTH,
-		   SM8250_SLAVE_SDCC_4,
-		   SM8250_SLAVE_TLMM_WEST,
-		   SM8250_SLAVE_SDCC_2,
-		   SM8250_SLAVE_CNOC_MNOC_CFG,
-		   SM8250_SLAVE_UFS_MEM_CFG,
-		   SM8250_SLAVE_SNOC_CFG,
-		   SM8250_SLAVE_PDM,
-		   SM8250_SLAVE_CX_RDPM,
-		   SM8250_SLAVE_PCIE_1_CFG,
-		   SM8250_SLAVE_A2NOC_CFG,
-		   SM8250_SLAVE_QDSS_CFG,
-		   SM8250_SLAVE_DISPLAY_CFG,
-		   SM8250_SLAVE_PCIE_2_CFG,
-		   SM8250_SLAVE_TCSR,
-		   SM8250_SLAVE_DCC_CFG,
-		   SM8250_SLAVE_CNOC_DDRSS,
-		   SM8250_SLAVE_IPC_ROUTER_CFG,
-		   SM8250_SLAVE_PCIE_0_CFG,
-		   SM8250_SLAVE_RBCPR_MMCX_CFG,
-		   SM8250_SLAVE_NPU_CFG,
-		   SM8250_SLAVE_AHB2PHY_SOUTH,
-		   SM8250_SLAVE_AHB2PHY_NORTH,
-		   SM8250_SLAVE_GRAPHICS_3D_CFG,
-		   SM8250_SLAVE_VENUS_CFG,
-		   SM8250_SLAVE_TSIF,
-		   SM8250_SLAVE_IPA_CFG,
-		   SM8250_SLAVE_IMEM_CFG,
-		   SM8250_SLAVE_USB3,
-		   SM8250_SLAVE_SERVICE_CNOC,
-		   SM8250_SLAVE_UFS_CARD_CFG,
-		   SM8250_SLAVE_USB3_1,
-		   SM8250_SLAVE_LPASS,
-		   SM8250_SLAVE_RBCPR_CX_CFG,
-		   SM8250_SLAVE_A1NOC_CFG,
-		   SM8250_SLAVE_AOSS,
-		   SM8250_SLAVE_PRNG,
-		   SM8250_SLAVE_VSENSE_CTRL_CFG,
-		   SM8250_SLAVE_QSPI_0,
-		   SM8250_SLAVE_CRYPTO_0_CFG,
-		   SM8250_SLAVE_PIMEM_CFG,
-		   SM8250_SLAVE_RBCPR_MX_CFG,
-		   SM8250_SLAVE_QUP_0,
-		   SM8250_SLAVE_QUP_1,
-		   SM8250_SLAVE_QUP_2,
-		   SM8250_SLAVE_CLK_CTL
-	},
+	.link_nodes = { &qhs_compute_dsp,
+			&qhs_camera_cfg,
+			&qhs_tlmm1,
+			&qhs_tlmm0,
+			&qhs_sdc4,
+			&qhs_tlmm2,
+			&qhs_sdc2,
+			&qhs_mnoc_cfg,
+			&qhs_ufs_mem_cfg,
+			&qhs_snoc_cfg,
+			&qhs_pdm,
+			&qhs_cx_rdpm,
+			&qhs_pcie1_cfg,
+			&qhs_a2_noc_cfg,
+			&qhs_qdss_cfg,
+			&qhs_display_cfg,
+			&qhs_pcie_modem_cfg,
+			&qhs_tcsr,
+			&qhs_dcc_cfg,
+			&qhs_ddrss_cfg,
+			&qhs_ipc_router,
+			&qhs_pcie0_cfg,
+			&qhs_cpr_mmcx,
+			&qhs_npu_cfg,
+			&qhs_ahb2phy0,
+			&qhs_ahb2phy1,
+			&qhs_gpuss_cfg,
+			&qhs_venus_cfg,
+			&qhs_tsif,
+			&qhs_ipa,
+			&qhs_imem_cfg,
+			&qhs_usb3_0,
+			&srvc_cnoc,
+			&qhs_ufs_card_cfg,
+			&qhs_usb3_1,
+			&qhs_lpass_cfg,
+			&qhs_cpr_cx,
+			&qhs_a1_noc_cfg,
+			&qhs_aoss,
+			&qhs_prng,
+			&qhs_vsense_ctrl_cfg,
+			&qhs_qspi,
+			&qhs_crypto0_cfg,
+			&qhs_pimem_cfg,
+			&qhs_cpr_mx,
+			&qhs_qup0,
+			&qhs_qup1,
+			&qhs_qup2,
+			&qhs_clk_ctl, NULL },
 };
 
 static struct qcom_icc_node xm_qdss_dap = {
 	.name = "xm_qdss_dap",
-	.id = SM8250_MASTER_QDSS_DAP,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 50,
-	.links = { SM8250_SLAVE_CDSP_CFG,
-		   SM8250_SLAVE_CAMERA_CFG,
-		   SM8250_SLAVE_TLMM_SOUTH,
-		   SM8250_SLAVE_TLMM_NORTH,
-		   SM8250_SLAVE_SDCC_4,
-		   SM8250_SLAVE_TLMM_WEST,
-		   SM8250_SLAVE_SDCC_2,
-		   SM8250_SLAVE_CNOC_MNOC_CFG,
-		   SM8250_SLAVE_UFS_MEM_CFG,
-		   SM8250_SLAVE_SNOC_CFG,
-		   SM8250_SLAVE_PDM,
-		   SM8250_SLAVE_CX_RDPM,
-		   SM8250_SLAVE_PCIE_1_CFG,
-		   SM8250_SLAVE_A2NOC_CFG,
-		   SM8250_SLAVE_QDSS_CFG,
-		   SM8250_SLAVE_DISPLAY_CFG,
-		   SM8250_SLAVE_PCIE_2_CFG,
-		   SM8250_SLAVE_TCSR,
-		   SM8250_SLAVE_DCC_CFG,
-		   SM8250_SLAVE_CNOC_DDRSS,
-		   SM8250_SLAVE_IPC_ROUTER_CFG,
-		   SM8250_SLAVE_CNOC_A2NOC,
-		   SM8250_SLAVE_PCIE_0_CFG,
-		   SM8250_SLAVE_RBCPR_MMCX_CFG,
-		   SM8250_SLAVE_NPU_CFG,
-		   SM8250_SLAVE_AHB2PHY_SOUTH,
-		   SM8250_SLAVE_AHB2PHY_NORTH,
-		   SM8250_SLAVE_GRAPHICS_3D_CFG,
-		   SM8250_SLAVE_VENUS_CFG,
-		   SM8250_SLAVE_TSIF,
-		   SM8250_SLAVE_IPA_CFG,
-		   SM8250_SLAVE_IMEM_CFG,
-		   SM8250_SLAVE_USB3,
-		   SM8250_SLAVE_SERVICE_CNOC,
-		   SM8250_SLAVE_UFS_CARD_CFG,
-		   SM8250_SLAVE_USB3_1,
-		   SM8250_SLAVE_LPASS,
-		   SM8250_SLAVE_RBCPR_CX_CFG,
-		   SM8250_SLAVE_A1NOC_CFG,
-		   SM8250_SLAVE_AOSS,
-		   SM8250_SLAVE_PRNG,
-		   SM8250_SLAVE_VSENSE_CTRL_CFG,
-		   SM8250_SLAVE_QSPI_0,
-		   SM8250_SLAVE_CRYPTO_0_CFG,
-		   SM8250_SLAVE_PIMEM_CFG,
-		   SM8250_SLAVE_RBCPR_MX_CFG,
-		   SM8250_SLAVE_QUP_0,
-		   SM8250_SLAVE_QUP_1,
-		   SM8250_SLAVE_QUP_2,
-		   SM8250_SLAVE_CLK_CTL
-	},
+	.link_nodes = { &qhs_compute_dsp,
+			&qhs_camera_cfg,
+			&qhs_tlmm1,
+			&qhs_tlmm0,
+			&qhs_sdc4,
+			&qhs_tlmm2,
+			&qhs_sdc2,
+			&qhs_mnoc_cfg,
+			&qhs_ufs_mem_cfg,
+			&qhs_snoc_cfg,
+			&qhs_pdm,
+			&qhs_cx_rdpm,
+			&qhs_pcie1_cfg,
+			&qhs_a2_noc_cfg,
+			&qhs_qdss_cfg,
+			&qhs_display_cfg,
+			&qhs_pcie_modem_cfg,
+			&qhs_tcsr,
+			&qhs_dcc_cfg,
+			&qhs_ddrss_cfg,
+			&qhs_ipc_router,
+			&qns_cnoc_a2noc,
+			&qhs_pcie0_cfg,
+			&qhs_cpr_mmcx,
+			&qhs_npu_cfg,
+			&qhs_ahb2phy0,
+			&qhs_ahb2phy1,
+			&qhs_gpuss_cfg,
+			&qhs_venus_cfg,
+			&qhs_tsif,
+			&qhs_ipa,
+			&qhs_imem_cfg,
+			&qhs_usb3_0,
+			&srvc_cnoc,
+			&qhs_ufs_card_cfg,
+			&qhs_usb3_1,
+			&qhs_lpass_cfg,
+			&qhs_cpr_cx,
+			&qhs_a1_noc_cfg,
+			&qhs_aoss,
+			&qhs_prng,
+			&qhs_vsense_ctrl_cfg,
+			&qhs_qspi,
+			&qhs_crypto0_cfg,
+			&qhs_pimem_cfg,
+			&qhs_cpr_mx,
+			&qhs_qup0,
+			&qhs_qup1,
+			&qhs_qup2,
+			&qhs_clk_ctl, NULL },
 };
 
 static struct qcom_icc_node qhm_cnoc_dc_noc = {
 	.name = "qhm_cnoc_dc_noc",
-	.id = SM8250_MASTER_CNOC_DC_NOC,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 2,
-	.links = { SM8250_SLAVE_GEM_NOC_CFG,
-		   SM8250_SLAVE_LLCC_CFG
-	},
+	.link_nodes = { &qhs_memnoc,
+			&qhs_llcc, NULL },
 };
 
 static struct qcom_icc_node alm_gpu_tcu = {
 	.name = "alm_gpu_tcu",
-	.id = SM8250_MASTER_GPU_TCU,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 2,
-	.links = { SM8250_SLAVE_LLCC,
-		   SM8250_SLAVE_GEM_NOC_SNOC
-	},
+	.link_nodes = { &qns_llcc,
+			&qns_gem_noc_snoc, NULL },
 };
 
 static struct qcom_icc_node alm_sys_tcu = {
 	.name = "alm_sys_tcu",
-	.id = SM8250_MASTER_SYS_TCU,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 2,
-	.links = { SM8250_SLAVE_LLCC,
-		   SM8250_SLAVE_GEM_NOC_SNOC
-	},
+	.link_nodes = { &qns_llcc,
+			&qns_gem_noc_snoc, NULL },
 };
 
 static struct qcom_icc_node chm_apps = {
 	.name = "chm_apps",
-	.id = SM8250_MASTER_AMPSS_M0,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 3,
-	.links = { SM8250_SLAVE_LLCC,
-		   SM8250_SLAVE_GEM_NOC_SNOC,
-		   SM8250_SLAVE_MEM_NOC_PCIE_SNOC
-	},
+	.link_nodes = { &qns_llcc,
+			&qns_gem_noc_snoc,
+			&qns_sys_pcie, NULL },
 };
 
 static struct qcom_icc_node qhm_gemnoc_cfg = {
 	.name = "qhm_gemnoc_cfg",
-	.id = SM8250_MASTER_GEM_NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 3,
-	.links = { SM8250_SLAVE_SERVICE_GEM_NOC_2,
-		   SM8250_SLAVE_SERVICE_GEM_NOC_1,
-		   SM8250_SLAVE_SERVICE_GEM_NOC
-	},
+	.link_nodes = { &srvc_odd_gemnoc,
+			&srvc_even_gemnoc,
+			&srvc_sys_gemnoc, NULL },
 };
 
 static struct qcom_icc_node qnm_cmpnoc = {
 	.name = "qnm_cmpnoc",
-	.id = SM8250_MASTER_COMPUTE_NOC,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 2,
-	.links = { SM8250_SLAVE_LLCC,
-		   SM8250_SLAVE_GEM_NOC_SNOC
-	},
+	.link_nodes = { &qns_llcc,
+			&qns_gem_noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qnm_gpu = {
 	.name = "qnm_gpu",
-	.id = SM8250_MASTER_GRAPHICS_3D,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 2,
-	.links = { SM8250_SLAVE_LLCC,
-		   SM8250_SLAVE_GEM_NOC_SNOC },
+	.link_nodes = { &qns_llcc,
+			&qns_gem_noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qnm_mnoc_hf = {
 	.name = "qnm_mnoc_hf",
-	.id = SM8250_MASTER_MNOC_HF_MEM_NOC,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM8250_SLAVE_LLCC },
+	.link_nodes = { &qns_llcc, NULL },
 };
 
 static struct qcom_icc_node qnm_mnoc_sf = {
 	.name = "qnm_mnoc_sf",
-	.id = SM8250_MASTER_MNOC_SF_MEM_NOC,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 2,
-	.links = { SM8250_SLAVE_LLCC,
-		   SM8250_SLAVE_GEM_NOC_SNOC
-	},
+	.link_nodes = { &qns_llcc,
+			&qns_gem_noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qnm_pcie = {
 	.name = "qnm_pcie",
-	.id = SM8250_MASTER_ANOC_PCIE_GEM_NOC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 2,
-	.links = { SM8250_SLAVE_LLCC,
-		   SM8250_SLAVE_GEM_NOC_SNOC
-	},
+	.link_nodes = { &qns_llcc,
+			&qns_gem_noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qnm_snoc_gc = {
 	.name = "qnm_snoc_gc",
-	.id = SM8250_MASTER_SNOC_GC_MEM_NOC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM8250_SLAVE_LLCC },
+	.link_nodes = { &qns_llcc, NULL },
 };
 
 static struct qcom_icc_node qnm_snoc_sf = {
 	.name = "qnm_snoc_sf",
-	.id = SM8250_MASTER_SNOC_SF_MEM_NOC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 3,
-	.links = { SM8250_SLAVE_LLCC,
-		   SM8250_SLAVE_GEM_NOC_SNOC,
-		   SM8250_SLAVE_MEM_NOC_PCIE_SNOC
-	},
+	.link_nodes = { &qns_llcc,
+			&qns_gem_noc_snoc,
+			&qns_sys_pcie, NULL },
 };
 
 static struct qcom_icc_node llcc_mc = {
 	.name = "llcc_mc",
-	.id = SM8250_MASTER_LLCC,
 	.channels = 4,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM8250_SLAVE_EBI_CH0 },
+	.link_nodes = { &ebi, NULL },
 };
 
 static struct qcom_icc_node qhm_mnoc_cfg = {
 	.name = "qhm_mnoc_cfg",
-	.id = SM8250_MASTER_CNOC_MNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM8250_SLAVE_SERVICE_MNOC },
+	.link_nodes = { &srvc_mnoc, NULL },
 };
 
 static struct qcom_icc_node qnm_camnoc_hf = {
 	.name = "qnm_camnoc_hf",
-	.id = SM8250_MASTER_CAMNOC_HF,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM8250_SLAVE_MNOC_HF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_hf, NULL },
 };
 
 static struct qcom_icc_node qnm_camnoc_icp = {
 	.name = "qnm_camnoc_icp",
-	.id = SM8250_MASTER_CAMNOC_ICP,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM8250_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_sf, NULL },
 };
 
 static struct qcom_icc_node qnm_camnoc_sf = {
 	.name = "qnm_camnoc_sf",
-	.id = SM8250_MASTER_CAMNOC_SF,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM8250_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_sf, NULL },
 };
 
 static struct qcom_icc_node qnm_video0 = {
 	.name = "qnm_video0",
-	.id = SM8250_MASTER_VIDEO_P0,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM8250_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_sf, NULL },
 };
 
 static struct qcom_icc_node qnm_video1 = {
 	.name = "qnm_video1",
-	.id = SM8250_MASTER_VIDEO_P1,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM8250_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_sf, NULL },
 };
 
 static struct qcom_icc_node qnm_video_cvp = {
 	.name = "qnm_video_cvp",
-	.id = SM8250_MASTER_VIDEO_PROC,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM8250_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_sf, NULL },
 };
 
 static struct qcom_icc_node qxm_mdp0 = {
 	.name = "qxm_mdp0",
-	.id = SM8250_MASTER_MDP_PORT0,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM8250_SLAVE_MNOC_HF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_hf, NULL },
 };
 
 static struct qcom_icc_node qxm_mdp1 = {
 	.name = "qxm_mdp1",
-	.id = SM8250_MASTER_MDP_PORT1,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM8250_SLAVE_MNOC_HF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_hf, NULL },
 };
 
 static struct qcom_icc_node qxm_rot = {
 	.name = "qxm_rot",
-	.id = SM8250_MASTER_ROTATOR,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM8250_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_sf, NULL },
 };
 
 static struct qcom_icc_node amm_npu_sys = {
 	.name = "amm_npu_sys",
-	.id = SM8250_MASTER_NPU_SYS,
 	.channels = 4,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM8250_SLAVE_NPU_COMPUTE_NOC },
+	.link_nodes = { &qns_npu_sys, NULL },
 };
 
 static struct qcom_icc_node amm_npu_sys_cdp_w = {
 	.name = "amm_npu_sys_cdp_w",
-	.id = SM8250_MASTER_NPU_CDP,
 	.channels = 2,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { SM8250_SLAVE_NPU_COMPUTE_NOC },
+	.link_nodes = { &qns_npu_sys, NULL },
 };
 
 static struct qcom_icc_node qhm_cfg = {
 	.name = "qhm_cfg",
-	.id = SM8250_MASTER_NPU_NOC_CFG,
-	.channels = 1,
-	.buswidth = 4,
-	.num_links = 9,
-	.links = { SM8250_SLAVE_SERVICE_NPU_NOC,
-		   SM8250_SLAVE_ISENSE_CFG,
-		   SM8250_SLAVE_NPU_LLM_CFG,
-		   SM8250_SLAVE_NPU_INT_DMA_BWMON_CFG,
-		   SM8250_SLAVE_NPU_CP,
-		   SM8250_SLAVE_NPU_TCM,
-		   SM8250_SLAVE_NPU_CAL_DP0,
-		   SM8250_SLAVE_NPU_CAL_DP1,
-		   SM8250_SLAVE_NPU_DPM
-	},
+	.channels = 1,
+	.buswidth = 4,
+	.link_nodes = { &srvc_noc,
+			&qhs_isense,
+			&qhs_llm,
+			&qhs_dma_bwmon,
+			&qhs_cp,
+			&qhs_tcm,
+			&qhs_cal_dp0,
+			&qhs_cal_dp1,
+			&qhs_dpm, NULL },
 };
 
 static struct qcom_icc_node qhm_snoc_cfg = {
 	.name = "qhm_snoc_cfg",
-	.id = SM8250_MASTER_SNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM8250_SLAVE_SERVICE_SNOC },
+	.link_nodes = { &srvc_snoc, NULL },
 };
 
 static struct qcom_icc_node qnm_aggre1_noc = {
 	.name = "qnm_aggre1_noc",
-	.id = SM8250_A1NOC_SNOC_MAS,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { SM8250_SLAVE_SNOC_GEM_NOC_SF },
+	.link_nodes = { &qns_gemnoc_sf, NULL },
 };
 
 static struct qcom_icc_node qnm_aggre2_noc = {
 	.name = "qnm_aggre2_noc",
-	.id = SM8250_A2NOC_SNOC_MAS,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { SM8250_SLAVE_SNOC_GEM_NOC_SF },
+	.link_nodes = { &qns_gemnoc_sf, NULL },
 };
 
 static struct qcom_icc_node qnm_gemnoc = {
 	.name = "qnm_gemnoc",
-	.id = SM8250_MASTER_GEM_NOC_SNOC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 6,
-	.links = { SM8250_SLAVE_PIMEM,
-		   SM8250_SLAVE_OCIMEM,
-		   SM8250_SLAVE_APPSS,
-		   SM8250_SNOC_CNOC_SLV,
-		   SM8250_SLAVE_TCU,
-		   SM8250_SLAVE_QDSS_STM
-	},
+	.link_nodes = { &qxs_pimem,
+			&qxs_imem,
+			&qhs_apss,
+			&qns_cnoc,
+			&xs_sys_tcu_cfg,
+			&xs_qdss_stm, NULL },
 };
 
 static struct qcom_icc_node qnm_gemnoc_pcie = {
 	.name = "qnm_gemnoc_pcie",
-	.id = SM8250_MASTER_GEM_NOC_PCIE_SNOC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 3,
-	.links = { SM8250_SLAVE_PCIE_2,
-		   SM8250_SLAVE_PCIE_0,
-		   SM8250_SLAVE_PCIE_1
-	},
+	.link_nodes = { &xs_pcie_modem,
+			&xs_pcie_0,
+			&xs_pcie_1, NULL },
 };
 
 static struct qcom_icc_node qxm_pimem = {
 	.name = "qxm_pimem",
-	.id = SM8250_MASTER_PIMEM,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM8250_SLAVE_SNOC_GEM_NOC_GC },
+	.link_nodes = { &qns_gemnoc_gc, NULL },
 };
 
 static struct qcom_icc_node xm_gic = {
 	.name = "xm_gic",
-	.id = SM8250_MASTER_GIC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM8250_SLAVE_SNOC_GEM_NOC_GC },
+	.link_nodes = { &qns_gemnoc_gc, NULL },
 };
 
 static struct qcom_icc_node qns_a1noc_snoc = {
 	.name = "qns_a1noc_snoc",
-	.id = SM8250_A1NOC_SNOC_SLV,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { SM8250_A1NOC_SNOC_MAS },
+	.link_nodes = { &qnm_aggre1_noc, NULL },
 };
 
 static struct qcom_icc_node qns_pcie_modem_mem_noc = {
 	.name = "qns_pcie_modem_mem_noc",
-	.id = SM8250_SLAVE_ANOC_PCIE_GEM_NOC_1,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { SM8250_MASTER_ANOC_PCIE_GEM_NOC },
+	.link_nodes = { &qnm_pcie, NULL },
 };
 
 static struct qcom_icc_node srvc_aggre1_noc = {
 	.name = "srvc_aggre1_noc",
-	.id = SM8250_SLAVE_SERVICE_A1NOC,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_a2noc_snoc = {
 	.name = "qns_a2noc_snoc",
-	.id = SM8250_A2NOC_SNOC_SLV,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { SM8250_A2NOC_SNOC_MAS },
+	.link_nodes = { &qnm_aggre2_noc, NULL },
 };
 
 static struct qcom_icc_node qns_pcie_mem_noc = {
 	.name = "qns_pcie_mem_noc",
-	.id = SM8250_SLAVE_ANOC_PCIE_GEM_NOC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { SM8250_MASTER_ANOC_PCIE_GEM_NOC },
+	.link_nodes = { &qnm_pcie, NULL },
 };
 
 static struct qcom_icc_node srvc_aggre2_noc = {
 	.name = "srvc_aggre2_noc",
-	.id = SM8250_SLAVE_SERVICE_A2NOC,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_cdsp_mem_noc = {
 	.name = "qns_cdsp_mem_noc",
-	.id = SM8250_SLAVE_CDSP_MEM_NOC,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM8250_MASTER_COMPUTE_NOC },
+	.link_nodes = { &qnm_cmpnoc, NULL },
 };
 
 static struct qcom_icc_node qhs_a1_noc_cfg = {
 	.name = "qhs_a1_noc_cfg",
-	.id = SM8250_SLAVE_A1NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM8250_MASTER_A1NOC_CFG },
+	.link_nodes = { &qhm_a1noc_cfg, NULL },
 };
 
 static struct qcom_icc_node qhs_a2_noc_cfg = {
 	.name = "qhs_a2_noc_cfg",
-	.id = SM8250_SLAVE_A2NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM8250_MASTER_A2NOC_CFG },
+	.link_nodes = { &qhm_a2noc_cfg, NULL },
 };
 
 static struct qcom_icc_node qhs_ahb2phy0 = {
 	.name = "qhs_ahb2phy0",
-	.id = SM8250_SLAVE_AHB2PHY_SOUTH,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_ahb2phy1 = {
 	.name = "qhs_ahb2phy1",
-	.id = SM8250_SLAVE_AHB2PHY_NORTH,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_aoss = {
 	.name = "qhs_aoss",
-	.id = SM8250_SLAVE_AOSS,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_camera_cfg = {
 	.name = "qhs_camera_cfg",
-	.id = SM8250_SLAVE_CAMERA_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_clk_ctl = {
 	.name = "qhs_clk_ctl",
-	.id = SM8250_SLAVE_CLK_CTL,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_compute_dsp = {
 	.name = "qhs_compute_dsp",
-	.id = SM8250_SLAVE_CDSP_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_cpr_cx = {
 	.name = "qhs_cpr_cx",
-	.id = SM8250_SLAVE_RBCPR_CX_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_cpr_mmcx = {
 	.name = "qhs_cpr_mmcx",
-	.id = SM8250_SLAVE_RBCPR_MMCX_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_cpr_mx = {
 	.name = "qhs_cpr_mx",
-	.id = SM8250_SLAVE_RBCPR_MX_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_crypto0_cfg = {
 	.name = "qhs_crypto0_cfg",
-	.id = SM8250_SLAVE_CRYPTO_0_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_cx_rdpm = {
 	.name = "qhs_cx_rdpm",
-	.id = SM8250_SLAVE_CX_RDPM,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_dcc_cfg = {
 	.name = "qhs_dcc_cfg",
-	.id = SM8250_SLAVE_DCC_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_ddrss_cfg = {
 	.name = "qhs_ddrss_cfg",
-	.id = SM8250_SLAVE_CNOC_DDRSS,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM8250_MASTER_CNOC_DC_NOC },
+	.link_nodes = { &qhm_cnoc_dc_noc, NULL },
 };
 
 static struct qcom_icc_node qhs_display_cfg = {
 	.name = "qhs_display_cfg",
-	.id = SM8250_SLAVE_DISPLAY_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_gpuss_cfg = {
 	.name = "qhs_gpuss_cfg",
-	.id = SM8250_SLAVE_GRAPHICS_3D_CFG,
 	.channels = 1,
 	.buswidth = 8,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_imem_cfg = {
 	.name = "qhs_imem_cfg",
-	.id = SM8250_SLAVE_IMEM_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_ipa = {
 	.name = "qhs_ipa",
-	.id = SM8250_SLAVE_IPA_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_ipc_router = {
 	.name = "qhs_ipc_router",
-	.id = SM8250_SLAVE_IPC_ROUTER_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_lpass_cfg = {
 	.name = "qhs_lpass_cfg",
-	.id = SM8250_SLAVE_LPASS,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_mnoc_cfg = {
 	.name = "qhs_mnoc_cfg",
-	.id = SM8250_SLAVE_CNOC_MNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM8250_MASTER_CNOC_MNOC_CFG },
+	.link_nodes = { &qhm_mnoc_cfg, NULL },
 };
 
 static struct qcom_icc_node qhs_npu_cfg = {
 	.name = "qhs_npu_cfg",
-	.id = SM8250_SLAVE_NPU_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM8250_MASTER_NPU_NOC_CFG },
+	.link_nodes = { &qhm_cfg, NULL },
 };
 
 static struct qcom_icc_node qhs_pcie0_cfg = {
 	.name = "qhs_pcie0_cfg",
-	.id = SM8250_SLAVE_PCIE_0_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_pcie1_cfg = {
 	.name = "qhs_pcie1_cfg",
-	.id = SM8250_SLAVE_PCIE_1_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_pcie_modem_cfg = {
 	.name = "qhs_pcie_modem_cfg",
-	.id = SM8250_SLAVE_PCIE_2_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_pdm = {
 	.name = "qhs_pdm",
-	.id = SM8250_SLAVE_PDM,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_pimem_cfg = {
 	.name = "qhs_pimem_cfg",
-	.id = SM8250_SLAVE_PIMEM_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_prng = {
 	.name = "qhs_prng",
-	.id = SM8250_SLAVE_PRNG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_qdss_cfg = {
 	.name = "qhs_qdss_cfg",
-	.id = SM8250_SLAVE_QDSS_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_qspi = {
 	.name = "qhs_qspi",
-	.id = SM8250_SLAVE_QSPI_0,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_qup0 = {
 	.name = "qhs_qup0",
-	.id = SM8250_SLAVE_QUP_0,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_qup1 = {
 	.name = "qhs_qup1",
-	.id = SM8250_SLAVE_QUP_1,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_qup2 = {
 	.name = "qhs_qup2",
-	.id = SM8250_SLAVE_QUP_2,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_sdc2 = {
 	.name = "qhs_sdc2",
-	.id = SM8250_SLAVE_SDCC_2,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_sdc4 = {
 	.name = "qhs_sdc4",
-	.id = SM8250_SLAVE_SDCC_4,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_snoc_cfg = {
 	.name = "qhs_snoc_cfg",
-	.id = SM8250_SLAVE_SNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM8250_MASTER_SNOC_CFG },
+	.link_nodes = { &qhm_snoc_cfg, NULL },
 };
 
 static struct qcom_icc_node qhs_tcsr = {
 	.name = "qhs_tcsr",
-	.id = SM8250_SLAVE_TCSR,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_tlmm0 = {
 	.name = "qhs_tlmm0",
-	.id = SM8250_SLAVE_TLMM_NORTH,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_tlmm1 = {
 	.name = "qhs_tlmm1",
-	.id = SM8250_SLAVE_TLMM_SOUTH,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_tlmm2 = {
 	.name = "qhs_tlmm2",
-	.id = SM8250_SLAVE_TLMM_WEST,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_tsif = {
 	.name = "qhs_tsif",
-	.id = SM8250_SLAVE_TSIF,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_ufs_card_cfg = {
 	.name = "qhs_ufs_card_cfg",
-	.id = SM8250_SLAVE_UFS_CARD_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_ufs_mem_cfg = {
 	.name = "qhs_ufs_mem_cfg",
-	.id = SM8250_SLAVE_UFS_MEM_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_usb3_0 = {
 	.name = "qhs_usb3_0",
-	.id = SM8250_SLAVE_USB3,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_usb3_1 = {
 	.name = "qhs_usb3_1",
-	.id = SM8250_SLAVE_USB3_1,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_venus_cfg = {
 	.name = "qhs_venus_cfg",
-	.id = SM8250_SLAVE_VENUS_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_vsense_ctrl_cfg = {
 	.name = "qhs_vsense_ctrl_cfg",
-	.id = SM8250_SLAVE_VSENSE_CTRL_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_cnoc_a2noc = {
 	.name = "qns_cnoc_a2noc",
-	.id = SM8250_SLAVE_CNOC_A2NOC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM8250_MASTER_CNOC_A2NOC },
+	.link_nodes = { &qnm_cnoc, NULL },
 };
 
 static struct qcom_icc_node srvc_cnoc = {
 	.name = "srvc_cnoc",
-	.id = SM8250_SLAVE_SERVICE_CNOC,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_llcc = {
 	.name = "qhs_llcc",
-	.id = SM8250_SLAVE_LLCC_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_memnoc = {
 	.name = "qhs_memnoc",
-	.id = SM8250_SLAVE_GEM_NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM8250_MASTER_GEM_NOC_CFG },
+	.link_nodes = { &qhm_gemnoc_cfg, NULL },
 };
 
 static struct qcom_icc_node qns_gem_noc_snoc = {
 	.name = "qns_gem_noc_snoc",
-	.id = SM8250_SLAVE_GEM_NOC_SNOC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { SM8250_MASTER_GEM_NOC_SNOC },
+	.link_nodes = { &qnm_gemnoc, NULL },
 };
 
 static struct qcom_icc_node qns_llcc = {
 	.name = "qns_llcc",
-	.id = SM8250_SLAVE_LLCC,
 	.channels = 4,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { SM8250_MASTER_LLCC },
+	.link_nodes = { &llcc_mc, NULL },
 };
 
 static struct qcom_icc_node qns_sys_pcie = {
 	.name = "qns_sys_pcie",
-	.id = SM8250_SLAVE_MEM_NOC_PCIE_SNOC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM8250_MASTER_GEM_NOC_PCIE_SNOC },
+	.link_nodes = { &qnm_gemnoc_pcie, NULL },
 };
 
 static struct qcom_icc_node srvc_even_gemnoc = {
 	.name = "srvc_even_gemnoc",
-	.id = SM8250_SLAVE_SERVICE_GEM_NOC_1,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node srvc_odd_gemnoc = {
 	.name = "srvc_odd_gemnoc",
-	.id = SM8250_SLAVE_SERVICE_GEM_NOC_2,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node srvc_sys_gemnoc = {
 	.name = "srvc_sys_gemnoc",
-	.id = SM8250_SLAVE_SERVICE_GEM_NOC,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node ebi = {
 	.name = "ebi",
-	.id = SM8250_SLAVE_EBI_CH0,
 	.channels = 4,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_mem_noc_hf = {
 	.name = "qns_mem_noc_hf",
-	.id = SM8250_SLAVE_MNOC_HF_MEM_NOC,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM8250_MASTER_MNOC_HF_MEM_NOC },
+	.link_nodes = { &qnm_mnoc_hf, NULL },
 };
 
 static struct qcom_icc_node qns_mem_noc_sf = {
 	.name = "qns_mem_noc_sf",
-	.id = SM8250_SLAVE_MNOC_SF_MEM_NOC,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SM8250_MASTER_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qnm_mnoc_sf, NULL },
 };
 
 static struct qcom_icc_node srvc_mnoc = {
 	.name = "srvc_mnoc",
-	.id = SM8250_SLAVE_SERVICE_MNOC,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_cal_dp0 = {
 	.name = "qhs_cal_dp0",
-	.id = SM8250_SLAVE_NPU_CAL_DP0,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_cal_dp1 = {
 	.name = "qhs_cal_dp1",
-	.id = SM8250_SLAVE_NPU_CAL_DP1,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_cp = {
 	.name = "qhs_cp",
-	.id = SM8250_SLAVE_NPU_CP,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_dma_bwmon = {
 	.name = "qhs_dma_bwmon",
-	.id = SM8250_SLAVE_NPU_INT_DMA_BWMON_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_dpm = {
 	.name = "qhs_dpm",
-	.id = SM8250_SLAVE_NPU_DPM,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_isense = {
 	.name = "qhs_isense",
-	.id = SM8250_SLAVE_ISENSE_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_llm = {
 	.name = "qhs_llm",
-	.id = SM8250_SLAVE_NPU_LLM_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_tcm = {
 	.name = "qhs_tcm",
-	.id = SM8250_SLAVE_NPU_TCM,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_npu_sys = {
 	.name = "qns_npu_sys",
-	.id = SM8250_SLAVE_NPU_COMPUTE_NOC,
 	.channels = 2,
 	.buswidth = 32,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node srvc_noc = {
 	.name = "srvc_noc",
-	.id = SM8250_SLAVE_SERVICE_NPU_NOC,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_apss = {
 	.name = "qhs_apss",
-	.id = SM8250_SLAVE_APPSS,
 	.channels = 1,
 	.buswidth = 8,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_cnoc = {
 	.name = "qns_cnoc",
-	.id = SM8250_SNOC_CNOC_SLV,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM8250_SNOC_CNOC_MAS },
+	.link_nodes = { &qnm_snoc, NULL },
 };
 
 static struct qcom_icc_node qns_gemnoc_gc = {
 	.name = "qns_gemnoc_gc",
-	.id = SM8250_SLAVE_SNOC_GEM_NOC_GC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SM8250_MASTER_SNOC_GC_MEM_NOC },
+	.link_nodes = { &qnm_snoc_gc, NULL },
 };
 
 static struct qcom_icc_node qns_gemnoc_sf = {
 	.name = "qns_gemnoc_sf",
-	.id = SM8250_SLAVE_SNOC_GEM_NOC_SF,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { SM8250_MASTER_SNOC_SF_MEM_NOC },
+	.link_nodes = { &qnm_snoc_sf, NULL },
 };
 
 static struct qcom_icc_node qxs_imem = {
 	.name = "qxs_imem",
-	.id = SM8250_SLAVE_OCIMEM,
 	.channels = 1,
 	.buswidth = 8,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qxs_pimem = {
 	.name = "qxs_pimem",
-	.id = SM8250_SLAVE_PIMEM,
 	.channels = 1,
 	.buswidth = 8,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node srvc_snoc = {
 	.name = "srvc_snoc",
-	.id = SM8250_SLAVE_SERVICE_SNOC,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node xs_pcie_0 = {
 	.name = "xs_pcie_0",
-	.id = SM8250_SLAVE_PCIE_0,
 	.channels = 1,
 	.buswidth = 8,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node xs_pcie_1 = {
 	.name = "xs_pcie_1",
-	.id = SM8250_SLAVE_PCIE_1,
 	.channels = 1,
 	.buswidth = 8,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node xs_pcie_modem = {
 	.name = "xs_pcie_modem",
-	.id = SM8250_SLAVE_PCIE_2,
 	.channels = 1,
 	.buswidth = 8,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node xs_qdss_stm = {
 	.name = "xs_qdss_stm",
-	.id = SM8250_SLAVE_QDSS_STM,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node xs_sys_tcu_cfg = {
 	.name = "xs_sys_tcu_cfg",
-	.id = SM8250_SLAVE_TCU,
 	.channels = 1,
 	.buswidth = 8,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qup0_core_master = {
 	.name = "qup0_core_master",
-	.id = SM8250_MASTER_QUP_CORE_0,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM8250_SLAVE_QUP_CORE_0 },
+	.link_nodes = { &qup0_core_slave, NULL },
 };
 
 static struct qcom_icc_node qup1_core_master = {
 	.name = "qup1_core_master",
-	.id = SM8250_MASTER_QUP_CORE_1,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM8250_SLAVE_QUP_CORE_1 },
+	.link_nodes = { &qup1_core_slave, NULL },
 };
 
 static struct qcom_icc_node qup2_core_master = {
 	.name = "qup2_core_master",
-	.id = SM8250_MASTER_QUP_CORE_2,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SM8250_SLAVE_QUP_CORE_2 },
+	.link_nodes = { &qup2_core_slave, NULL },
 };
 
 static struct qcom_icc_node qup0_core_slave = {
 	.name = "qup0_core_slave",
-	.id = SM8250_SLAVE_QUP_CORE_0,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qup1_core_slave = {
 	.name = "qup1_core_slave",
-	.id = SM8250_SLAVE_QUP_CORE_1,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qup2_core_slave = {
 	.name = "qup2_core_slave",
-	.id = SM8250_SLAVE_QUP_CORE_2,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_bcm bcm_acv = {
diff --git a/drivers/interconnect/qcom/sm8250.h b/drivers/interconnect/qcom/sm8250.h
deleted file mode 100644
index 032665093c5bfe83e9dc6b444fc07fcf790e9993..0000000000000000000000000000000000000000
--- a/drivers/interconnect/qcom/sm8250.h
+++ /dev/null
@@ -1,168 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Qualcomm #define SM8250 interconnect IDs
- *
- * Copyright (c) 2020, The Linux Foundation. All rights reserved.
- */
-
-#ifndef __DRIVERS_INTERCONNECT_QCOM_SM8250_H
-#define __DRIVERS_INTERCONNECT_QCOM_SM8250_H
-
-#define SM8250_A1NOC_SNOC_MAS			0
-#define SM8250_A1NOC_SNOC_SLV			1
-#define SM8250_A2NOC_SNOC_MAS			2
-#define SM8250_A2NOC_SNOC_SLV			3
-#define SM8250_MASTER_A1NOC_CFG			4
-#define SM8250_MASTER_A2NOC_CFG			5
-#define SM8250_MASTER_AMPSS_M0			6
-#define SM8250_MASTER_ANOC_PCIE_GEM_NOC		7
-#define SM8250_MASTER_CAMNOC_HF			8
-#define SM8250_MASTER_CAMNOC_ICP		9
-#define SM8250_MASTER_CAMNOC_SF			10
-#define SM8250_MASTER_CNOC_A2NOC		11
-#define SM8250_MASTER_CNOC_DC_NOC		12
-#define SM8250_MASTER_CNOC_MNOC_CFG		13
-#define SM8250_MASTER_COMPUTE_NOC		14
-#define SM8250_MASTER_CRYPTO_CORE_0		15
-#define SM8250_MASTER_GEM_NOC_CFG		16
-#define SM8250_MASTER_GEM_NOC_PCIE_SNOC		17
-#define SM8250_MASTER_GEM_NOC_SNOC		18
-#define SM8250_MASTER_GIC			19
-#define SM8250_MASTER_GPU_TCU			20
-#define SM8250_MASTER_GRAPHICS_3D		21
-#define SM8250_MASTER_IPA			22
-/* 23 was used by MASTER_IPA_CORE, now represented as RPMh clock */
-#define SM8250_MASTER_LLCC			24
-#define SM8250_MASTER_MDP_PORT0			25
-#define SM8250_MASTER_MDP_PORT1			26
-#define SM8250_MASTER_MNOC_HF_MEM_NOC		27
-#define SM8250_MASTER_MNOC_SF_MEM_NOC		28
-#define SM8250_MASTER_NPU			29
-#define SM8250_MASTER_NPU_CDP			30
-#define SM8250_MASTER_NPU_NOC_CFG		31
-#define SM8250_MASTER_NPU_SYS			32
-#define SM8250_MASTER_PCIE			33
-#define SM8250_MASTER_PCIE_1			34
-#define SM8250_MASTER_PCIE_2			35
-#define SM8250_MASTER_PIMEM			36
-#define SM8250_MASTER_QDSS_BAM			37
-#define SM8250_MASTER_QDSS_DAP			38
-#define SM8250_MASTER_QDSS_ETR			39
-#define SM8250_MASTER_QSPI_0			40
-#define SM8250_MASTER_QUP_0			41
-#define SM8250_MASTER_QUP_1			42
-#define SM8250_MASTER_QUP_2			43
-#define SM8250_MASTER_ROTATOR			44
-#define SM8250_MASTER_SDCC_2			45
-#define SM8250_MASTER_SDCC_4			46
-#define SM8250_MASTER_SNOC_CFG			47
-#define SM8250_MASTER_SNOC_GC_MEM_NOC		48
-#define SM8250_MASTER_SNOC_SF_MEM_NOC		49
-#define SM8250_MASTER_SYS_TCU			50
-#define SM8250_MASTER_TSIF			51
-#define SM8250_MASTER_UFS_CARD			52
-#define SM8250_MASTER_UFS_MEM			53
-#define SM8250_MASTER_USB3			54
-#define SM8250_MASTER_USB3_1			55
-#define SM8250_MASTER_VIDEO_P0			56
-#define SM8250_MASTER_VIDEO_P1			57
-#define SM8250_MASTER_VIDEO_PROC		58
-#define SM8250_SLAVE_A1NOC_CFG			59
-#define SM8250_SLAVE_A2NOC_CFG			60
-#define SM8250_SLAVE_AHB2PHY_NORTH		61
-#define SM8250_SLAVE_AHB2PHY_SOUTH		62
-#define SM8250_SLAVE_ANOC_PCIE_GEM_NOC		63
-#define SM8250_SLAVE_ANOC_PCIE_GEM_NOC_1	64
-#define SM8250_SLAVE_AOSS			65
-#define SM8250_SLAVE_APPSS			66
-#define SM8250_SLAVE_CAMERA_CFG			67
-#define SM8250_SLAVE_CDSP_CFG			68
-#define SM8250_SLAVE_CDSP_MEM_NOC		69
-#define SM8250_SLAVE_CLK_CTL			70
-#define SM8250_SLAVE_CNOC_A2NOC			71
-#define SM8250_SLAVE_CNOC_DDRSS			72
-#define SM8250_SLAVE_CNOC_MNOC_CFG		73
-#define SM8250_SLAVE_CRYPTO_0_CFG		74
-#define SM8250_SLAVE_CX_RDPM			75
-#define SM8250_SLAVE_DCC_CFG			76
-#define SM8250_SLAVE_DISPLAY_CFG		77
-#define SM8250_SLAVE_EBI_CH0			78
-#define SM8250_SLAVE_GEM_NOC_CFG		79
-#define SM8250_SLAVE_GEM_NOC_SNOC		80
-#define SM8250_SLAVE_GRAPHICS_3D_CFG		81
-#define SM8250_SLAVE_IMEM_CFG			82
-#define SM8250_SLAVE_IPA_CFG			83
-/* 84 was used by SLAVE_IPA_CORE, now represented as RPMh clock */
-#define SM8250_SLAVE_IPC_ROUTER_CFG		85
-#define SM8250_SLAVE_ISENSE_CFG			86
-#define SM8250_SLAVE_LLCC			87
-#define SM8250_SLAVE_LLCC_CFG			88
-#define SM8250_SLAVE_LPASS			89
-#define SM8250_SLAVE_MEM_NOC_PCIE_SNOC		90
-#define SM8250_SLAVE_MNOC_HF_MEM_NOC		91
-#define SM8250_SLAVE_MNOC_SF_MEM_NOC		92
-#define SM8250_SLAVE_NPU_CAL_DP0		93
-#define SM8250_SLAVE_NPU_CAL_DP1		94
-#define SM8250_SLAVE_NPU_CFG			95
-#define SM8250_SLAVE_NPU_COMPUTE_NOC		96
-#define SM8250_SLAVE_NPU_CP			97
-#define SM8250_SLAVE_NPU_DPM			98
-#define SM8250_SLAVE_NPU_INT_DMA_BWMON_CFG	99
-#define SM8250_SLAVE_NPU_LLM_CFG		100
-#define SM8250_SLAVE_NPU_TCM			101
-#define SM8250_SLAVE_OCIMEM			102
-#define SM8250_SLAVE_PCIE_0			103
-#define SM8250_SLAVE_PCIE_0_CFG			104
-#define SM8250_SLAVE_PCIE_1			105
-#define SM8250_SLAVE_PCIE_1_CFG			106
-#define SM8250_SLAVE_PCIE_2			107
-#define SM8250_SLAVE_PCIE_2_CFG			108
-#define SM8250_SLAVE_PDM			109
-#define SM8250_SLAVE_PIMEM			110
-#define SM8250_SLAVE_PIMEM_CFG			111
-#define SM8250_SLAVE_PRNG			112
-#define SM8250_SLAVE_QDSS_CFG			113
-#define SM8250_SLAVE_QDSS_STM			114
-#define SM8250_SLAVE_QSPI_0			115
-#define SM8250_SLAVE_QUP_0			116
-#define SM8250_SLAVE_QUP_1			117
-#define SM8250_SLAVE_QUP_2			118
-#define SM8250_SLAVE_RBCPR_CX_CFG		119
-#define SM8250_SLAVE_RBCPR_MMCX_CFG		120
-#define SM8250_SLAVE_RBCPR_MX_CFG		121
-#define SM8250_SLAVE_SDCC_2			122
-#define SM8250_SLAVE_SDCC_4			123
-#define SM8250_SLAVE_SERVICE_A1NOC		124
-#define SM8250_SLAVE_SERVICE_A2NOC		125
-#define SM8250_SLAVE_SERVICE_CNOC		126
-#define SM8250_SLAVE_SERVICE_GEM_NOC		127
-#define SM8250_SLAVE_SERVICE_GEM_NOC_1		128
-#define SM8250_SLAVE_SERVICE_GEM_NOC_2		129
-#define SM8250_SLAVE_SERVICE_MNOC		130
-#define SM8250_SLAVE_SERVICE_NPU_NOC		131
-#define SM8250_SLAVE_SERVICE_SNOC		132
-#define SM8250_SLAVE_SNOC_CFG			133
-#define SM8250_SLAVE_SNOC_GEM_NOC_GC		134
-#define SM8250_SLAVE_SNOC_GEM_NOC_SF		135
-#define SM8250_SLAVE_TCSR			136
-#define SM8250_SLAVE_TCU			137
-#define SM8250_SLAVE_TLMM_NORTH			138
-#define SM8250_SLAVE_TLMM_SOUTH			139
-#define SM8250_SLAVE_TLMM_WEST			140
-#define SM8250_SLAVE_TSIF			141
-#define SM8250_SLAVE_UFS_CARD_CFG		142
-#define SM8250_SLAVE_UFS_MEM_CFG		143
-#define SM8250_SLAVE_USB3			144
-#define SM8250_SLAVE_USB3_1			145
-#define SM8250_SLAVE_VENUS_CFG			146
-#define SM8250_SLAVE_VSENSE_CTRL_CFG		147
-#define SM8250_SNOC_CNOC_MAS			148
-#define SM8250_SNOC_CNOC_SLV			149
-#define SM8250_MASTER_QUP_CORE_0		150
-#define SM8250_MASTER_QUP_CORE_1		151
-#define SM8250_MASTER_QUP_CORE_2		152
-#define SM8250_SLAVE_QUP_CORE_0			153
-#define SM8250_SLAVE_QUP_CORE_1			154
-#define SM8250_SLAVE_QUP_CORE_2			155
-
-#endif

-- 
2.39.5



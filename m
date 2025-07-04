Return-Path: <linux-pm+bounces-30160-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B731AF98B0
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jul 2025 18:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D2B31C487B2
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jul 2025 16:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E81327A2E;
	Fri,  4 Jul 2025 16:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VTxbnVnn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76E5326A71
	for <linux-pm@vger.kernel.org>; Fri,  4 Jul 2025 16:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751646963; cv=none; b=oZC5uxxBqEDqtRqnk6tJvoAHu8RM4IO3dfm9kjMcfUj45Ggti89At29zqytr0G7lGQJMa85G3U2NDPWGtoFAvmvKDA2DZ2pw1vaU4U9SyTU31qgepMxKtjoWWTWYvq5ZUkppqGlMtGt2HUzuLlK4heCgzSGH/QJa/uDm8w+4aSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751646963; c=relaxed/simple;
	bh=052QvKID8PkJO3rI0JEUf8uAYKxy6gLFl4+zoGjSK7o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WZXMD5Smixdo736jsti/sFRmuS4eiBe60ms6GUmVmTYpdMSZ9lPGRx6RikCg/cSToRD6MYSqUBeB451oD6aNXxHbOCecOVuT4TInjpPpRUSGg4T7Z+3aMN3ODY9wqXFcGXlhx3NnUZStb5VGEWtjz5SqaLVG1K+J5up3vnTQ1sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VTxbnVnn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 564CjKAN007047
	for <linux-pm@vger.kernel.org>; Fri, 4 Jul 2025 16:35:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	udPCS+zy82BZuQ8f2TUu8c85DdhUNi4s6ooghX5kENo=; b=VTxbnVnnRwONhc6f
	l5KIItPOxLs1E6Fm0swllWjU74gJg/zhjCh4jBzFcpZgheNVCpS8kn+WD7I+0zj0
	WSbx/i7Wuz3XcQmSFmFdfkr1uzl07WnVnH/vhS7zk0JKhSWp9Iq4F3A0wyi1mz/9
	RJUfKPNziBC97Ysr9rM7ibRkF1TuSSzoX+APV+LMcAHF2qqjFUzG4ZfpahLtUXGx
	rKCyeNNvW6Vv3il169lVPKHMrEFyUgQ5OE51kgxNnHBh5NhKAQigsQWGQm+5KL+O
	r1EXwtE5rnDHRxvBWoHyaeq/gO+KfkWznTXi0y/g6IIcEHnsDOJv+NjGe9mELZmq
	eJKUbQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47kn5js1j9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 04 Jul 2025 16:35:55 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c5e2872e57so165640885a.0
        for <linux-pm@vger.kernel.org>; Fri, 04 Jul 2025 09:35:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751646954; x=1752251754;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=udPCS+zy82BZuQ8f2TUu8c85DdhUNi4s6ooghX5kENo=;
        b=SNUjdyOzHdFwQGdeJJAmQP5UnsbEX3dKjDbhp1q9wHNFKjUUopSHI/Gt9Gyjj+SQcA
         exIvEfkptPYXSajJ5e4cysCd/2x3bst8NUPXSEyRBHG7TMFMjf9srFImN+2aPULHQSdu
         TNtBMheAU/XD74kbJ73jumE0xejMqo2qYTasp/Fk/Xim+tpKE4AmPEhGa4cYF55SLkRj
         OsuJLngsOdi1zl9Kv4KjubNJtKZWVLXrGVF+3zAKlk36RxY9ZMwh4aajQoURzy/HHVVB
         nuuMboHxpTDcrvP/48S+4eK+pUTjpDw8EcZXQnaOEkMcGw6vjWRTCWgq85bHuSlwnkyo
         dCDg==
X-Forwarded-Encrypted: i=1; AJvYcCXnDX42Oksr6XRIEf2TuDuR2VZNk08CdfGASsMh4oJmuEK7jt7hzR/S0+U7mlsofW7RiZNKyd1eFg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxHGtIHtLQJuMdmeLeDF4qgLTfAJ6aKU+5+3yW4sNGQCtH2RGrT
	j5p/Gwdb5EKimshfZd5298F3e3AexrNLibA4rUx17zvfHYH65dSGwq92JdMLMGwKQpJEq2cZ9NB
	CUd9ghHU0b30pbgt+3OyYlgbeKNprwSfkBJ69cLIqpqmysHEpuMChAKGGnNjSZA==
X-Gm-Gg: ASbGncuQno7LOrnZwCXsI95csYHHX3cDplfnwM+25CZKVMyarfT5ZjmUNJt22/qscCr
	X2lnmOu3HBs3TnJuxtiODNN6q2Z8AP4iYS4ZDczsaXXrwtDYn2obMZDp2NWq8nMNAcHM8TqqW9e
	Q85UXc1MF/e9IFsfS06O3cJ0UumsOF6uleqg72a8R3ljtZCJwYREwpbQADoxULaTcFU4jw/7JNI
	nykmIF0z5AyOC5GWQIEErNbjpT4zO2whihwZQGM5i4ACRCgdLIf1697YknmQZUYeA/+j7sayZYG
	ibod6jQ2Ivm9KklCgnSjKg1UlpBEGAFNHGOQJ8lKpq2ncmWhnuJpfHSOn1mEtJY4UBhHJ8rNn/X
	7HU/QMFXRrqnaaHvWCEimdEVsgxR7Hn8Y2nM=
X-Received: by 2002:a05:620a:404b:b0:7d5:c736:ac26 with SMTP id af79cd13be357-7d5df103002mr377846485a.8.1751646953644;
        Fri, 04 Jul 2025 09:35:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVqdpYT236Ua4wGIg0pY+ZSRbheomQFvMBpd8KS9yEpwUX0OpaULb5RPfV5P1xa31UqD6zfw==
X-Received: by 2002:a05:620a:404b:b0:7d5:c736:ac26 with SMTP id af79cd13be357-7d5df103002mr377840785a.8.1751646952877;
        Fri, 04 Jul 2025 09:35:52 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-556383d33f3sm298321e87.68.2025.07.04.09.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 09:35:51 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 04 Jul 2025 19:35:28 +0300
Subject: [PATCH v2 16/28] interconnect: qcom: sdm670: convert to dynamic
 IDs
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250704-rework-icc-v2-16-875fac996ef5@oss.qualcomm.com>
References: <20250704-rework-icc-v2-0-875fac996ef5@oss.qualcomm.com>
In-Reply-To: <20250704-rework-icc-v2-0-875fac996ef5@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=42358;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=052QvKID8PkJO3rI0JEUf8uAYKxy6gLFl4+zoGjSK7o=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBoaALHxty7/MHD9MJnjwZVoDJFdNtVjXHM/5c+Q
 SWujreL3ASJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaGgCxwAKCRCLPIo+Aiko
 1UxnCACAQ98jfLBJBtREB1YW7vmrUGJ8hjPdJ++G7aeaaFjmBnTr0zyWfE+/wyQx5ewsHM/4CB4
 VXvKzr9s4ceQkec7t9p5Uu8saYsZA5gcvyJRqzLTg4GGZstScvIs38oCqsds7/oOGdUKihSe1kp
 69q7Ik1Acd07PoPb2pOziXTbgeCYLvw/z+za+UhciUJNtMmyY99svWnGipSzPVgYE59yvpqtGvh
 wXuZpgh6IVS0ZipMHewkL95sYgt/bAvxBq2+3+wwOYxWaYCca8f1OsyQfXAOB++iHxNNvzA4aMm
 mehZT0Rle+1t+UOzsTbH351vCRi6ChOKdPn2dmg+AUl2mocK
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=KtJN2XWN c=1 sm=1 tr=0 ts=686802eb cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=z_qZSkvlcatX74QHaN4A:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: 6JXEeYvCGAq69BP5lPMTgFdFrwm1_03X
X-Proofpoint-GUID: 6JXEeYvCGAq69BP5lPMTgFdFrwm1_03X
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA0MDEyNiBTYWx0ZWRfX0c5GgF7VxeEQ
 04yF96QP5im7gGle6Uve3RL2g3nWSKrH+4PRgC6yVYBxUt+7zYCSDeSzVrt/LnGcga4yBkjwjn5
 DjaFrcgUvmiSnsHWMMVvN/0PZkPf1ANq6Dz9lPLD3gSVHciuZ4U2NeBuwCcE5VjFwTvXAoK2C4C
 MFO0yZn84SbeW9CL3Vt6fBO5sNK0nTdmAOiej7OVPKnrLKx3RKZRYSvqwgPokUMshdwkeLbM/Wz
 rWN7okaiVnRXg+esJ86NdbytFdqMIKdwfAHxV0/vcVN/9cO2SgA5Z7BDEqw80bOtdP778MV4Mbc
 Aina5cltyXBY5BdwWSFGUYS7bCRs8vrXZf/vT7CqmHJufykNEKXJxVLtRdXjV8t7Gxza/8R9za0
 QPTR48mm7CD4hElbkqZiwTvgPepjaHeLZCjKVOEi5mOUmn+yCE3jvtEEew8v8Bjv47Kkg2Zg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_06,2025-07-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 mlxscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 clxscore=1015 mlxlogscore=934 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507040126

Stop using fixed and IDs and covert the platform to use dynamic IDs for
the interconnect. This gives more flexibility and also allows us to drop
the .num_links member, saving from possible errors related to it being
not set or set incorrectly.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/interconnect/qcom/sdm670.c | 646 ++++++++++++++++++-------------------
 drivers/interconnect/qcom/sdm670.h | 128 --------
 2 files changed, 311 insertions(+), 463 deletions(-)

diff --git a/drivers/interconnect/qcom/sdm670.c b/drivers/interconnect/qcom/sdm670.c
index 7a61e2472319b0f6a2a3dee5df014640345e3e79..d1aa6e3532821659d06373c4082cc6bd77e420ab 100644
--- a/drivers/interconnect/qcom/sdm670.c
+++ b/drivers/interconnect/qcom/sdm670.c
@@ -13,1036 +13,1004 @@
 
 #include "bcm-voter.h"
 #include "icc-rpmh.h"
-#include "sdm670.h"
+
+static struct qcom_icc_node qhm_a1noc_cfg;
+static struct qcom_icc_node qhm_qup1;
+static struct qcom_icc_node qhm_tsif;
+static struct qcom_icc_node xm_emmc;
+static struct qcom_icc_node xm_sdc2;
+static struct qcom_icc_node xm_sdc4;
+static struct qcom_icc_node xm_ufs_mem;
+static struct qcom_icc_node qhm_a2noc_cfg;
+static struct qcom_icc_node qhm_qdss_bam;
+static struct qcom_icc_node qhm_qup2;
+static struct qcom_icc_node qnm_cnoc;
+static struct qcom_icc_node qxm_crypto;
+static struct qcom_icc_node qxm_ipa;
+static struct qcom_icc_node xm_qdss_etr;
+static struct qcom_icc_node xm_usb3_0;
+static struct qcom_icc_node qxm_camnoc_hf0_uncomp;
+static struct qcom_icc_node qxm_camnoc_hf1_uncomp;
+static struct qcom_icc_node qxm_camnoc_sf_uncomp;
+static struct qcom_icc_node qhm_spdm;
+static struct qcom_icc_node qnm_snoc;
+static struct qcom_icc_node qhm_cnoc;
+static struct qcom_icc_node acm_l3;
+static struct qcom_icc_node pm_gnoc_cfg;
+static struct qcom_icc_node llcc_mc;
+static struct qcom_icc_node acm_tcu;
+static struct qcom_icc_node qhm_memnoc_cfg;
+static struct qcom_icc_node qnm_apps;
+static struct qcom_icc_node qnm_mnoc_hf;
+static struct qcom_icc_node qnm_mnoc_sf;
+static struct qcom_icc_node qnm_snoc_gc;
+static struct qcom_icc_node qnm_snoc_sf;
+static struct qcom_icc_node qxm_gpu;
+static struct qcom_icc_node qhm_mnoc_cfg;
+static struct qcom_icc_node qxm_camnoc_hf0;
+static struct qcom_icc_node qxm_camnoc_hf1;
+static struct qcom_icc_node qxm_camnoc_sf;
+static struct qcom_icc_node qxm_mdp0;
+static struct qcom_icc_node qxm_mdp1;
+static struct qcom_icc_node qxm_rot;
+static struct qcom_icc_node qxm_venus0;
+static struct qcom_icc_node qxm_venus1;
+static struct qcom_icc_node qxm_venus_arm9;
+static struct qcom_icc_node qhm_snoc_cfg;
+static struct qcom_icc_node qnm_aggre1_noc;
+static struct qcom_icc_node qnm_aggre2_noc;
+static struct qcom_icc_node qnm_gladiator_sodv;
+static struct qcom_icc_node qnm_memnoc;
+static struct qcom_icc_node qxm_pimem;
+static struct qcom_icc_node xm_gic;
+static struct qcom_icc_node qns_a1noc_snoc;
+static struct qcom_icc_node srvc_aggre1_noc;
+static struct qcom_icc_node qns_a2noc_snoc;
+static struct qcom_icc_node srvc_aggre2_noc;
+static struct qcom_icc_node qns_camnoc_uncomp;
+static struct qcom_icc_node qhs_a1_noc_cfg;
+static struct qcom_icc_node qhs_a2_noc_cfg;
+static struct qcom_icc_node qhs_aop;
+static struct qcom_icc_node qhs_aoss;
+static struct qcom_icc_node qhs_camera_cfg;
+static struct qcom_icc_node qhs_clk_ctl;
+static struct qcom_icc_node qhs_compute_dsp_cfg;
+static struct qcom_icc_node qhs_cpr_cx;
+static struct qcom_icc_node qhs_crypto0_cfg;
+static struct qcom_icc_node qhs_dcc_cfg;
+static struct qcom_icc_node qhs_ddrss_cfg;
+static struct qcom_icc_node qhs_display_cfg;
+static struct qcom_icc_node qhs_emmc_cfg;
+static struct qcom_icc_node qhs_glm;
+static struct qcom_icc_node qhs_gpuss_cfg;
+static struct qcom_icc_node qhs_imem_cfg;
+static struct qcom_icc_node qhs_ipa;
+static struct qcom_icc_node qhs_mnoc_cfg;
+static struct qcom_icc_node qhs_pdm;
+static struct qcom_icc_node qhs_phy_refgen_south;
+static struct qcom_icc_node qhs_pimem_cfg;
+static struct qcom_icc_node qhs_prng;
+static struct qcom_icc_node qhs_qdss_cfg;
+static struct qcom_icc_node qhs_qupv3_north;
+static struct qcom_icc_node qhs_qupv3_south;
+static struct qcom_icc_node qhs_sdc2;
+static struct qcom_icc_node qhs_sdc4;
+static struct qcom_icc_node qhs_snoc_cfg;
+static struct qcom_icc_node qhs_spdm;
+static struct qcom_icc_node qhs_tcsr;
+static struct qcom_icc_node qhs_tlmm_north;
+static struct qcom_icc_node qhs_tlmm_south;
+static struct qcom_icc_node qhs_tsif;
+static struct qcom_icc_node qhs_ufs_mem_cfg;
+static struct qcom_icc_node qhs_usb3_0;
+static struct qcom_icc_node qhs_venus_cfg;
+static struct qcom_icc_node qhs_vsense_ctrl_cfg;
+static struct qcom_icc_node qns_cnoc_a2noc;
+static struct qcom_icc_node srvc_cnoc;
+static struct qcom_icc_node qhs_llcc;
+static struct qcom_icc_node qhs_memnoc;
+static struct qcom_icc_node qns_gladiator_sodv;
+static struct qcom_icc_node qns_gnoc_memnoc;
+static struct qcom_icc_node srvc_gnoc;
+static struct qcom_icc_node ebi;
+static struct qcom_icc_node qhs_mdsp_ms_mpu_cfg;
+static struct qcom_icc_node qns_apps_io;
+static struct qcom_icc_node qns_llcc;
+static struct qcom_icc_node qns_memnoc_snoc;
+static struct qcom_icc_node srvc_memnoc;
+static struct qcom_icc_node qns2_mem_noc;
+static struct qcom_icc_node qns_mem_noc_hf;
+static struct qcom_icc_node srvc_mnoc;
+static struct qcom_icc_node qhs_apss;
+static struct qcom_icc_node qns_cnoc;
+static struct qcom_icc_node qns_memnoc_gc;
+static struct qcom_icc_node qns_memnoc_sf;
+static struct qcom_icc_node qxs_imem;
+static struct qcom_icc_node qxs_pimem;
+static struct qcom_icc_node srvc_snoc;
+static struct qcom_icc_node xs_qdss_stm;
+static struct qcom_icc_node xs_sys_tcu_cfg;
 
 static struct qcom_icc_node qhm_a1noc_cfg = {
 	.name = "qhm_a1noc_cfg",
-	.id = SDM670_MASTER_A1NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SDM670_SLAVE_SERVICE_A1NOC },
+	.link_nodes = { &srvc_aggre1_noc, NULL },
 };
 
 static struct qcom_icc_node qhm_qup1 = {
 	.name = "qhm_qup1",
-	.id = SDM670_MASTER_BLSP_1,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SDM670_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qhm_tsif = {
 	.name = "qhm_tsif",
-	.id = SDM670_MASTER_TSIF,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SDM670_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc, NULL },
 };
 
 static struct qcom_icc_node xm_emmc = {
 	.name = "xm_emmc",
-	.id = SDM670_MASTER_EMMC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SDM670_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc, NULL },
 };
 
 static struct qcom_icc_node xm_sdc2 = {
 	.name = "xm_sdc2",
-	.id = SDM670_MASTER_SDCC_2,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SDM670_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc, NULL },
 };
 
 static struct qcom_icc_node xm_sdc4 = {
 	.name = "xm_sdc4",
-	.id = SDM670_MASTER_SDCC_4,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SDM670_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc, NULL },
 };
 
 static struct qcom_icc_node xm_ufs_mem = {
 	.name = "xm_ufs_mem",
-	.id = SDM670_MASTER_UFS_MEM,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SDM670_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qhm_a2noc_cfg = {
 	.name = "qhm_a2noc_cfg",
-	.id = SDM670_MASTER_A2NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SDM670_SLAVE_SERVICE_A2NOC },
+	.link_nodes = { &srvc_aggre2_noc, NULL },
 };
 
 static struct qcom_icc_node qhm_qdss_bam = {
 	.name = "qhm_qdss_bam",
-	.id = SDM670_MASTER_QDSS_BAM,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SDM670_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qhm_qup2 = {
 	.name = "qhm_qup2",
-	.id = SDM670_MASTER_BLSP_2,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SDM670_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qnm_cnoc = {
 	.name = "qnm_cnoc",
-	.id = SDM670_MASTER_CNOC_A2NOC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SDM670_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qxm_crypto = {
 	.name = "qxm_crypto",
-	.id = SDM670_MASTER_CRYPTO_CORE_0,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SDM670_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qxm_ipa = {
 	.name = "qxm_ipa",
-	.id = SDM670_MASTER_IPA,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SDM670_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc, NULL },
 };
 
 static struct qcom_icc_node xm_qdss_etr = {
 	.name = "xm_qdss_etr",
-	.id = SDM670_MASTER_QDSS_ETR,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SDM670_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc, NULL },
 };
 
 static struct qcom_icc_node xm_usb3_0 = {
 	.name = "xm_usb3_0",
-	.id = SDM670_MASTER_USB3,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SDM670_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc, NULL },
 };
 
 static struct qcom_icc_node qxm_camnoc_hf0_uncomp = {
 	.name = "qxm_camnoc_hf0_uncomp",
-	.id = SDM670_MASTER_CAMNOC_HF0_UNCOMP,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SDM670_SLAVE_CAMNOC_UNCOMP },
+	.link_nodes = { &qns_camnoc_uncomp, NULL },
 };
 
 static struct qcom_icc_node qxm_camnoc_hf1_uncomp = {
 	.name = "qxm_camnoc_hf1_uncomp",
-	.id = SDM670_MASTER_CAMNOC_HF1_UNCOMP,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SDM670_SLAVE_CAMNOC_UNCOMP },
+	.link_nodes = { &qns_camnoc_uncomp, NULL },
 };
 
 static struct qcom_icc_node qxm_camnoc_sf_uncomp = {
 	.name = "qxm_camnoc_sf_uncomp",
-	.id = SDM670_MASTER_CAMNOC_SF_UNCOMP,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SDM670_SLAVE_CAMNOC_UNCOMP },
+	.link_nodes = { &qns_camnoc_uncomp, NULL },
 };
 
 static struct qcom_icc_node qhm_spdm = {
 	.name = "qhm_spdm",
-	.id = SDM670_MASTER_SPDM,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SDM670_SLAVE_CNOC_A2NOC },
+	.link_nodes = { &qns_cnoc_a2noc, NULL },
 };
 
 static struct qcom_icc_node qnm_snoc = {
 	.name = "qnm_snoc",
-	.id = SDM670_MASTER_SNOC_CNOC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 38,
-	.links = { SDM670_SLAVE_TLMM_SOUTH,
-		   SDM670_SLAVE_CAMERA_CFG,
-		   SDM670_SLAVE_SDCC_4,
-		   SDM670_SLAVE_SDCC_2,
-		   SDM670_SLAVE_CNOC_MNOC_CFG,
-		   SDM670_SLAVE_UFS_MEM_CFG,
-		   SDM670_SLAVE_GLM,
-		   SDM670_SLAVE_PDM,
-		   SDM670_SLAVE_A2NOC_CFG,
-		   SDM670_SLAVE_QDSS_CFG,
-		   SDM670_SLAVE_DISPLAY_CFG,
-		   SDM670_SLAVE_TCSR,
-		   SDM670_SLAVE_DCC_CFG,
-		   SDM670_SLAVE_CNOC_DDRSS,
-		   SDM670_SLAVE_SNOC_CFG,
-		   SDM670_SLAVE_SOUTH_PHY_CFG,
-		   SDM670_SLAVE_GRAPHICS_3D_CFG,
-		   SDM670_SLAVE_VENUS_CFG,
-		   SDM670_SLAVE_TSIF,
-		   SDM670_SLAVE_CDSP_CFG,
-		   SDM670_SLAVE_AOP,
-		   SDM670_SLAVE_BLSP_2,
-		   SDM670_SLAVE_SERVICE_CNOC,
-		   SDM670_SLAVE_USB3,
-		   SDM670_SLAVE_IPA_CFG,
-		   SDM670_SLAVE_RBCPR_CX_CFG,
-		   SDM670_SLAVE_A1NOC_CFG,
-		   SDM670_SLAVE_AOSS,
-		   SDM670_SLAVE_PRNG,
-		   SDM670_SLAVE_VSENSE_CTRL_CFG,
-		   SDM670_SLAVE_EMMC_CFG,
-		   SDM670_SLAVE_BLSP_1,
-		   SDM670_SLAVE_SPDM_WRAPPER,
-		   SDM670_SLAVE_CRYPTO_0_CFG,
-		   SDM670_SLAVE_PIMEM_CFG,
-		   SDM670_SLAVE_TLMM_NORTH,
-		   SDM670_SLAVE_CLK_CTL,
-		   SDM670_SLAVE_IMEM_CFG
-	},
+	.link_nodes = { &qhs_tlmm_south,
+			&qhs_camera_cfg,
+			&qhs_sdc4,
+			&qhs_sdc2,
+			&qhs_mnoc_cfg,
+			&qhs_ufs_mem_cfg,
+			&qhs_glm,
+			&qhs_pdm,
+			&qhs_a2_noc_cfg,
+			&qhs_qdss_cfg,
+			&qhs_display_cfg,
+			&qhs_tcsr,
+			&qhs_dcc_cfg,
+			&qhs_ddrss_cfg,
+			&qhs_snoc_cfg,
+			&qhs_phy_refgen_south,
+			&qhs_gpuss_cfg,
+			&qhs_venus_cfg,
+			&qhs_tsif,
+			&qhs_compute_dsp_cfg,
+			&qhs_aop,
+			&qhs_qupv3_north,
+			&srvc_cnoc,
+			&qhs_usb3_0,
+			&qhs_ipa,
+			&qhs_cpr_cx,
+			&qhs_a1_noc_cfg,
+			&qhs_aoss,
+			&qhs_prng,
+			&qhs_vsense_ctrl_cfg,
+			&qhs_emmc_cfg,
+			&qhs_qupv3_south,
+			&qhs_spdm,
+			&qhs_crypto0_cfg,
+			&qhs_pimem_cfg,
+			&qhs_tlmm_north,
+			&qhs_clk_ctl,
+			&qhs_imem_cfg, NULL },
 };
 
 static struct qcom_icc_node qhm_cnoc = {
 	.name = "qhm_cnoc",
-	.id = SDM670_MASTER_CNOC_DC_NOC,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 2,
-	.links = { SDM670_SLAVE_MEM_NOC_CFG,
-		   SDM670_SLAVE_LLCC_CFG
-	},
+	.link_nodes = { &qhs_memnoc,
+			&qhs_llcc, NULL },
 };
 
 static struct qcom_icc_node acm_l3 = {
 	.name = "acm_l3",
-	.id = SDM670_MASTER_AMPSS_M0,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 3,
-	.links = { SDM670_SLAVE_SERVICE_GNOC,
-		   SDM670_SLAVE_GNOC_SNOC,
-		   SDM670_SLAVE_GNOC_MEM_NOC
-	},
+	.link_nodes = { &srvc_gnoc,
+			&qns_gladiator_sodv,
+			&qns_gnoc_memnoc, NULL },
 };
 
 static struct qcom_icc_node pm_gnoc_cfg = {
 	.name = "pm_gnoc_cfg",
-	.id = SDM670_MASTER_GNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SDM670_SLAVE_SERVICE_GNOC },
+	.link_nodes = { &srvc_gnoc, NULL },
 };
 
 static struct qcom_icc_node llcc_mc = {
 	.name = "llcc_mc",
-	.id = SDM670_MASTER_LLCC,
 	.channels = 2,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SDM670_SLAVE_EBI_CH0 },
+	.link_nodes = { &ebi, NULL },
 };
 
 static struct qcom_icc_node acm_tcu = {
 	.name = "acm_tcu",
-	.id = SDM670_MASTER_TCU_0,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 3,
-	.links = { SDM670_SLAVE_MEM_NOC_GNOC,
-		   SDM670_SLAVE_LLCC,
-		   SDM670_SLAVE_MEM_NOC_SNOC
-	},
+	.link_nodes = { &qns_apps_io,
+			&qns_llcc,
+			&qns_memnoc_snoc, NULL },
 };
 
 static struct qcom_icc_node qhm_memnoc_cfg = {
 	.name = "qhm_memnoc_cfg",
-	.id = SDM670_MASTER_MEM_NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 2,
-	.links = { SDM670_SLAVE_SERVICE_MEM_NOC,
-		   SDM670_SLAVE_MSS_PROC_MS_MPU_CFG
-	},
+	.link_nodes = { &srvc_memnoc,
+			&qhs_mdsp_ms_mpu_cfg, NULL },
 };
 
 static struct qcom_icc_node qnm_apps = {
 	.name = "qnm_apps",
-	.id = SDM670_MASTER_GNOC_MEM_NOC,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SDM670_SLAVE_LLCC },
+	.link_nodes = { &qns_llcc, NULL },
 };
 
 static struct qcom_icc_node qnm_mnoc_hf = {
 	.name = "qnm_mnoc_hf",
-	.id = SDM670_MASTER_MNOC_HF_MEM_NOC,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SDM670_SLAVE_LLCC },
+	.link_nodes = { &qns_llcc, NULL },
 };
 
 static struct qcom_icc_node qnm_mnoc_sf = {
 	.name = "qnm_mnoc_sf",
-	.id = SDM670_MASTER_MNOC_SF_MEM_NOC,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 3,
-	.links = { SDM670_SLAVE_MEM_NOC_GNOC,
-		   SDM670_SLAVE_LLCC,
-		   SDM670_SLAVE_MEM_NOC_SNOC
-	},
+	.link_nodes = { &qns_apps_io,
+			&qns_llcc,
+			&qns_memnoc_snoc, NULL },
 };
 
 static struct qcom_icc_node qnm_snoc_gc = {
 	.name = "qnm_snoc_gc",
-	.id = SDM670_MASTER_SNOC_GC_MEM_NOC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SDM670_SLAVE_LLCC },
+	.link_nodes = { &qns_llcc, NULL },
 };
 
 static struct qcom_icc_node qnm_snoc_sf = {
 	.name = "qnm_snoc_sf",
-	.id = SDM670_MASTER_SNOC_SF_MEM_NOC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 2,
-	.links = { SDM670_SLAVE_MEM_NOC_GNOC,
-		   SDM670_SLAVE_LLCC
-	},
+	.link_nodes = { &qns_apps_io,
+			&qns_llcc, NULL },
 };
 
 static struct qcom_icc_node qxm_gpu = {
 	.name = "qxm_gpu",
-	.id = SDM670_MASTER_GRAPHICS_3D,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 3,
-	.links = { SDM670_SLAVE_MEM_NOC_GNOC,
-		   SDM670_SLAVE_LLCC,
-		   SDM670_SLAVE_MEM_NOC_SNOC
-	},
+	.link_nodes = { &qns_apps_io,
+			&qns_llcc,
+			&qns_memnoc_snoc, NULL },
 };
 
 static struct qcom_icc_node qhm_mnoc_cfg = {
 	.name = "qhm_mnoc_cfg",
-	.id = SDM670_MASTER_CNOC_MNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SDM670_SLAVE_SERVICE_MNOC },
+	.link_nodes = { &srvc_mnoc, NULL },
 };
 
 static struct qcom_icc_node qxm_camnoc_hf0 = {
 	.name = "qxm_camnoc_hf0",
-	.id = SDM670_MASTER_CAMNOC_HF0,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SDM670_SLAVE_MNOC_HF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_hf, NULL },
 };
 
 static struct qcom_icc_node qxm_camnoc_hf1 = {
 	.name = "qxm_camnoc_hf1",
-	.id = SDM670_MASTER_CAMNOC_HF1,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SDM670_SLAVE_MNOC_HF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_hf, NULL },
 };
 
 static struct qcom_icc_node qxm_camnoc_sf = {
 	.name = "qxm_camnoc_sf",
-	.id = SDM670_MASTER_CAMNOC_SF,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SDM670_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns2_mem_noc, NULL },
 };
 
 static struct qcom_icc_node qxm_mdp0 = {
 	.name = "qxm_mdp0",
-	.id = SDM670_MASTER_MDP_PORT0,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SDM670_SLAVE_MNOC_HF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_hf, NULL },
 };
 
 static struct qcom_icc_node qxm_mdp1 = {
 	.name = "qxm_mdp1",
-	.id = SDM670_MASTER_MDP_PORT1,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SDM670_SLAVE_MNOC_HF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_hf, NULL },
 };
 
 static struct qcom_icc_node qxm_rot = {
 	.name = "qxm_rot",
-	.id = SDM670_MASTER_ROTATOR,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SDM670_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns2_mem_noc, NULL },
 };
 
 static struct qcom_icc_node qxm_venus0 = {
 	.name = "qxm_venus0",
-	.id = SDM670_MASTER_VIDEO_P0,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SDM670_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns2_mem_noc, NULL },
 };
 
 static struct qcom_icc_node qxm_venus1 = {
 	.name = "qxm_venus1",
-	.id = SDM670_MASTER_VIDEO_P1,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SDM670_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns2_mem_noc, NULL },
 };
 
 static struct qcom_icc_node qxm_venus_arm9 = {
 	.name = "qxm_venus_arm9",
-	.id = SDM670_MASTER_VIDEO_PROC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SDM670_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns2_mem_noc, NULL },
 };
 
 static struct qcom_icc_node qhm_snoc_cfg = {
 	.name = "qhm_snoc_cfg",
-	.id = SDM670_MASTER_SNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SDM670_SLAVE_SERVICE_SNOC },
+	.link_nodes = { &srvc_snoc, NULL },
 };
 
 static struct qcom_icc_node qnm_aggre1_noc = {
 	.name = "qnm_aggre1_noc",
-	.id = SDM670_MASTER_A1NOC_SNOC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 6,
-	.links = { SDM670_SLAVE_PIMEM,
-		   SDM670_SLAVE_SNOC_MEM_NOC_SF,
-		   SDM670_SLAVE_OCIMEM,
-		   SDM670_SLAVE_APPSS,
-		   SDM670_SLAVE_SNOC_CNOC,
-		   SDM670_SLAVE_QDSS_STM
-	},
+	.link_nodes = { &qxs_pimem,
+			&qns_memnoc_sf,
+			&qxs_imem,
+			&qhs_apss,
+			&qns_cnoc,
+			&xs_qdss_stm, NULL },
 };
 
 static struct qcom_icc_node qnm_aggre2_noc = {
 	.name = "qnm_aggre2_noc",
-	.id = SDM670_MASTER_A2NOC_SNOC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 7,
-	.links = { SDM670_SLAVE_PIMEM,
-		   SDM670_SLAVE_SNOC_MEM_NOC_SF,
-		   SDM670_SLAVE_OCIMEM,
-		   SDM670_SLAVE_APPSS,
-		   SDM670_SLAVE_SNOC_CNOC,
-		   SDM670_SLAVE_TCU,
-		   SDM670_SLAVE_QDSS_STM
-	},
+	.link_nodes = { &qxs_pimem,
+			&qns_memnoc_sf,
+			&qxs_imem,
+			&qhs_apss,
+			&qns_cnoc,
+			&xs_sys_tcu_cfg,
+			&xs_qdss_stm, NULL },
 };
 
 static struct qcom_icc_node qnm_gladiator_sodv = {
 	.name = "qnm_gladiator_sodv",
-	.id = SDM670_MASTER_GNOC_SNOC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 6,
-	.links = { SDM670_SLAVE_PIMEM,
-		   SDM670_SLAVE_OCIMEM,
-		   SDM670_SLAVE_APPSS,
-		   SDM670_SLAVE_SNOC_CNOC,
-		   SDM670_SLAVE_TCU,
-		   SDM670_SLAVE_QDSS_STM
-	},
+	.link_nodes = { &qxs_pimem,
+			&qxs_imem,
+			&qhs_apss,
+			&qns_cnoc,
+			&xs_sys_tcu_cfg,
+			&xs_qdss_stm, NULL },
 };
 
 static struct qcom_icc_node qnm_memnoc = {
 	.name = "qnm_memnoc",
-	.id = SDM670_MASTER_MEM_NOC_SNOC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 5,
-	.links = { SDM670_SLAVE_OCIMEM,
-		   SDM670_SLAVE_APPSS,
-		   SDM670_SLAVE_PIMEM,
-		   SDM670_SLAVE_SNOC_CNOC,
-		   SDM670_SLAVE_QDSS_STM
-	},
+	.link_nodes = { &qxs_imem,
+			&qhs_apss,
+			&qxs_pimem,
+			&qns_cnoc,
+			&xs_qdss_stm, NULL },
 };
 
 static struct qcom_icc_node qxm_pimem = {
 	.name = "qxm_pimem",
-	.id = SDM670_MASTER_PIMEM,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 2,
-	.links = { SDM670_SLAVE_OCIMEM,
-		   SDM670_SLAVE_SNOC_MEM_NOC_GC
-	},
+	.link_nodes = { &qxs_imem,
+			&qns_memnoc_gc, NULL },
 };
 
 static struct qcom_icc_node xm_gic = {
 	.name = "xm_gic",
-	.id = SDM670_MASTER_GIC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 2,
-	.links = { SDM670_SLAVE_OCIMEM,
-		   SDM670_SLAVE_SNOC_MEM_NOC_GC
-	},
+	.link_nodes = { &qxs_imem,
+			&qns_memnoc_gc, NULL },
 };
 
 static struct qcom_icc_node qns_a1noc_snoc = {
 	.name = "qns_a1noc_snoc",
-	.id = SDM670_SLAVE_A1NOC_SNOC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { SDM670_MASTER_A1NOC_SNOC },
+	.link_nodes = { &qnm_aggre1_noc, NULL },
 };
 
 static struct qcom_icc_node srvc_aggre1_noc = {
 	.name = "srvc_aggre1_noc",
-	.id = SDM670_SLAVE_SERVICE_A1NOC,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_a2noc_snoc = {
 	.name = "qns_a2noc_snoc",
-	.id = SDM670_SLAVE_A2NOC_SNOC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { SDM670_MASTER_A2NOC_SNOC },
+	.link_nodes = { &qnm_aggre2_noc, NULL },
 };
 
 static struct qcom_icc_node srvc_aggre2_noc = {
 	.name = "srvc_aggre2_noc",
-	.id = SDM670_SLAVE_SERVICE_A2NOC,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_camnoc_uncomp = {
 	.name = "qns_camnoc_uncomp",
-	.id = SDM670_SLAVE_CAMNOC_UNCOMP,
 	.channels = 1,
 	.buswidth = 32,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_a1_noc_cfg = {
 	.name = "qhs_a1_noc_cfg",
-	.id = SDM670_SLAVE_A1NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SDM670_MASTER_A1NOC_CFG },
+	.link_nodes = { &qhm_a1noc_cfg, NULL },
 };
 
 static struct qcom_icc_node qhs_a2_noc_cfg = {
 	.name = "qhs_a2_noc_cfg",
-	.id = SDM670_SLAVE_A2NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SDM670_MASTER_A2NOC_CFG },
+	.link_nodes = { &qhm_a2noc_cfg, NULL },
 };
 
 static struct qcom_icc_node qhs_aop = {
 	.name = "qhs_aop",
-	.id = SDM670_SLAVE_AOP,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_aoss = {
 	.name = "qhs_aoss",
-	.id = SDM670_SLAVE_AOSS,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_camera_cfg = {
 	.name = "qhs_camera_cfg",
-	.id = SDM670_SLAVE_CAMERA_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_clk_ctl = {
 	.name = "qhs_clk_ctl",
-	.id = SDM670_SLAVE_CLK_CTL,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_compute_dsp_cfg = {
 	.name = "qhs_compute_dsp_cfg",
-	.id = SDM670_SLAVE_CDSP_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_cpr_cx = {
 	.name = "qhs_cpr_cx",
-	.id = SDM670_SLAVE_RBCPR_CX_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_crypto0_cfg = {
 	.name = "qhs_crypto0_cfg",
-	.id = SDM670_SLAVE_CRYPTO_0_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_dcc_cfg = {
 	.name = "qhs_dcc_cfg",
-	.id = SDM670_SLAVE_DCC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SDM670_MASTER_CNOC_DC_NOC },
+	.link_nodes = { &qhm_cnoc, NULL },
 };
 
 static struct qcom_icc_node qhs_ddrss_cfg = {
 	.name = "qhs_ddrss_cfg",
-	.id = SDM670_SLAVE_CNOC_DDRSS,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_display_cfg = {
 	.name = "qhs_display_cfg",
-	.id = SDM670_SLAVE_DISPLAY_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_emmc_cfg = {
 	.name = "qhs_emmc_cfg",
-	.id = SDM670_SLAVE_EMMC_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_glm = {
 	.name = "qhs_glm",
-	.id = SDM670_SLAVE_GLM,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_gpuss_cfg = {
 	.name = "qhs_gpuss_cfg",
-	.id = SDM670_SLAVE_GRAPHICS_3D_CFG,
 	.channels = 1,
 	.buswidth = 8,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_imem_cfg = {
 	.name = "qhs_imem_cfg",
-	.id = SDM670_SLAVE_IMEM_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_ipa = {
 	.name = "qhs_ipa",
-	.id = SDM670_SLAVE_IPA_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_mnoc_cfg = {
 	.name = "qhs_mnoc_cfg",
-	.id = SDM670_SLAVE_CNOC_MNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SDM670_MASTER_CNOC_MNOC_CFG },
+	.link_nodes = { &qhm_mnoc_cfg, NULL },
 };
 
 static struct qcom_icc_node qhs_pdm = {
 	.name = "qhs_pdm",
-	.id = SDM670_SLAVE_PDM,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_phy_refgen_south = {
 	.name = "qhs_phy_refgen_south",
-	.id = SDM670_SLAVE_SOUTH_PHY_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_pimem_cfg = {
 	.name = "qhs_pimem_cfg",
-	.id = SDM670_SLAVE_PIMEM_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_prng = {
 	.name = "qhs_prng",
-	.id = SDM670_SLAVE_PRNG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_qdss_cfg = {
 	.name = "qhs_qdss_cfg",
-	.id = SDM670_SLAVE_QDSS_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_qupv3_north = {
 	.name = "qhs_qupv3_north",
-	.id = SDM670_SLAVE_BLSP_2,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_qupv3_south = {
 	.name = "qhs_qupv3_south",
-	.id = SDM670_SLAVE_BLSP_1,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_sdc2 = {
 	.name = "qhs_sdc2",
-	.id = SDM670_SLAVE_SDCC_2,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_sdc4 = {
 	.name = "qhs_sdc4",
-	.id = SDM670_SLAVE_SDCC_4,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_snoc_cfg = {
 	.name = "qhs_snoc_cfg",
-	.id = SDM670_SLAVE_SNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SDM670_MASTER_SNOC_CFG },
+	.link_nodes = { &qhm_snoc_cfg, NULL },
 };
 
 static struct qcom_icc_node qhs_spdm = {
 	.name = "qhs_spdm",
-	.id = SDM670_SLAVE_SPDM_WRAPPER,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_tcsr = {
 	.name = "qhs_tcsr",
-	.id = SDM670_SLAVE_TCSR,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_tlmm_north = {
 	.name = "qhs_tlmm_north",
-	.id = SDM670_SLAVE_TLMM_NORTH,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_tlmm_south = {
 	.name = "qhs_tlmm_south",
-	.id = SDM670_SLAVE_TLMM_SOUTH,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_tsif = {
 	.name = "qhs_tsif",
-	.id = SDM670_SLAVE_TSIF,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_ufs_mem_cfg = {
 	.name = "qhs_ufs_mem_cfg",
-	.id = SDM670_SLAVE_UFS_MEM_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_usb3_0 = {
 	.name = "qhs_usb3_0",
-	.id = SDM670_SLAVE_USB3,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_venus_cfg = {
 	.name = "qhs_venus_cfg",
-	.id = SDM670_SLAVE_VENUS_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_vsense_ctrl_cfg = {
 	.name = "qhs_vsense_ctrl_cfg",
-	.id = SDM670_SLAVE_VSENSE_CTRL_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_cnoc_a2noc = {
 	.name = "qns_cnoc_a2noc",
-	.id = SDM670_SLAVE_CNOC_A2NOC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SDM670_MASTER_CNOC_A2NOC },
+	.link_nodes = { &qnm_cnoc, NULL },
 };
 
 static struct qcom_icc_node srvc_cnoc = {
 	.name = "srvc_cnoc",
-	.id = SDM670_SLAVE_SERVICE_CNOC,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_llcc = {
 	.name = "qhs_llcc",
-	.id = SDM670_SLAVE_LLCC_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_memnoc = {
 	.name = "qhs_memnoc",
-	.id = SDM670_SLAVE_MEM_NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SDM670_MASTER_MEM_NOC_CFG },
+	.link_nodes = { &qhm_memnoc_cfg, NULL },
 };
 
 static struct qcom_icc_node qns_gladiator_sodv = {
 	.name = "qns_gladiator_sodv",
-	.id = SDM670_SLAVE_GNOC_SNOC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SDM670_MASTER_GNOC_SNOC },
+	.link_nodes = { &qnm_gladiator_sodv, NULL },
 };
 
 static struct qcom_icc_node qns_gnoc_memnoc = {
 	.name = "qns_gnoc_memnoc",
-	.id = SDM670_SLAVE_GNOC_MEM_NOC,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SDM670_MASTER_GNOC_MEM_NOC },
+	.link_nodes = { &qnm_apps, NULL },
 };
 
 static struct qcom_icc_node srvc_gnoc = {
 	.name = "srvc_gnoc",
-	.id = SDM670_SLAVE_SERVICE_GNOC,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node ebi = {
 	.name = "ebi",
-	.id = SDM670_SLAVE_EBI_CH0,
 	.channels = 2,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_mdsp_ms_mpu_cfg = {
 	.name = "qhs_mdsp_ms_mpu_cfg",
-	.id = SDM670_SLAVE_MSS_PROC_MS_MPU_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_apps_io = {
 	.name = "qns_apps_io",
-	.id = SDM670_SLAVE_MEM_NOC_GNOC,
 	.channels = 1,
 	.buswidth = 32,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_llcc = {
 	.name = "qns_llcc",
-	.id = SDM670_SLAVE_LLCC,
 	.channels = 2,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { SDM670_MASTER_LLCC },
+	.link_nodes = { &llcc_mc, NULL },
 };
 
 static struct qcom_icc_node qns_memnoc_snoc = {
 	.name = "qns_memnoc_snoc",
-	.id = SDM670_SLAVE_MEM_NOC_SNOC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SDM670_MASTER_MEM_NOC_SNOC },
+	.link_nodes = { &qnm_memnoc, NULL },
 };
 
 static struct qcom_icc_node srvc_memnoc = {
 	.name = "srvc_memnoc",
-	.id = SDM670_SLAVE_SERVICE_MEM_NOC,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns2_mem_noc = {
 	.name = "qns2_mem_noc",
-	.id = SDM670_SLAVE_MNOC_SF_MEM_NOC,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SDM670_MASTER_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qnm_mnoc_sf, NULL },
 };
 
 static struct qcom_icc_node qns_mem_noc_hf = {
 	.name = "qns_mem_noc_hf",
-	.id = SDM670_SLAVE_MNOC_HF_MEM_NOC,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 1,
-	.links = { SDM670_MASTER_MNOC_HF_MEM_NOC },
+	.link_nodes = { &qnm_mnoc_hf, NULL },
 };
 
 static struct qcom_icc_node srvc_mnoc = {
 	.name = "srvc_mnoc",
-	.id = SDM670_SLAVE_SERVICE_MNOC,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_apss = {
 	.name = "qhs_apss",
-	.id = SDM670_SLAVE_APPSS,
 	.channels = 1,
 	.buswidth = 8,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_cnoc = {
 	.name = "qns_cnoc",
-	.id = SDM670_SLAVE_SNOC_CNOC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SDM670_MASTER_SNOC_CNOC },
+	.link_nodes = { &qnm_snoc, NULL },
 };
 
 static struct qcom_icc_node qns_memnoc_gc = {
 	.name = "qns_memnoc_gc",
-	.id = SDM670_SLAVE_SNOC_MEM_NOC_GC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SDM670_MASTER_SNOC_GC_MEM_NOC },
+	.link_nodes = { &qnm_snoc_gc, NULL },
 };
 
 static struct qcom_icc_node qns_memnoc_sf = {
 	.name = "qns_memnoc_sf",
-	.id = SDM670_SLAVE_SNOC_MEM_NOC_SF,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { SDM670_MASTER_SNOC_SF_MEM_NOC },
+	.link_nodes = { &qnm_snoc_sf, NULL },
 };
 
 static struct qcom_icc_node qxs_imem = {
 	.name = "qxs_imem",
-	.id = SDM670_SLAVE_OCIMEM,
 	.channels = 1,
 	.buswidth = 8,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qxs_pimem = {
 	.name = "qxs_pimem",
-	.id = SDM670_SLAVE_PIMEM,
 	.channels = 1,
 	.buswidth = 8,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node srvc_snoc = {
 	.name = "srvc_snoc",
-	.id = SDM670_SLAVE_SERVICE_SNOC,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node xs_qdss_stm = {
 	.name = "xs_qdss_stm",
-	.id = SDM670_SLAVE_QDSS_STM,
 	.channels = 1,
 	.buswidth = 4,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node xs_sys_tcu_cfg = {
 	.name = "xs_sys_tcu_cfg",
-	.id = SDM670_SLAVE_TCU,
 	.channels = 1,
 	.buswidth = 8,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_bcm bcm_acv = {
@@ -1254,6 +1222,7 @@ static struct qcom_icc_node * const aggre1_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sdm670_aggre1_noc = {
+	.alloc_dyn_id = true,
 	.nodes = aggre1_noc_nodes,
 	.num_nodes = ARRAY_SIZE(aggre1_noc_nodes),
 	.bcms = aggre1_noc_bcms,
@@ -1280,6 +1249,7 @@ static struct qcom_icc_node * const aggre2_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sdm670_aggre2_noc = {
+	.alloc_dyn_id = true,
 	.nodes = aggre2_noc_nodes,
 	.num_nodes = ARRAY_SIZE(aggre2_noc_nodes),
 	.bcms = aggre2_noc_bcms,
@@ -1335,6 +1305,7 @@ static struct qcom_icc_node * const config_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sdm670_config_noc = {
+	.alloc_dyn_id = true,
 	.nodes = config_noc_nodes,
 	.num_nodes = ARRAY_SIZE(config_noc_nodes),
 	.bcms = config_noc_bcms,
@@ -1351,6 +1322,7 @@ static struct qcom_icc_node * const dc_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sdm670_dc_noc = {
+	.alloc_dyn_id = true,
 	.nodes = dc_noc_nodes,
 	.num_nodes = ARRAY_SIZE(dc_noc_nodes),
 	.bcms = dc_noc_bcms,
@@ -1369,6 +1341,7 @@ static struct qcom_icc_node * const gladiator_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sdm670_gladiator_noc = {
+	.alloc_dyn_id = true,
 	.nodes = gladiator_noc_nodes,
 	.num_nodes = ARRAY_SIZE(gladiator_noc_nodes),
 	.bcms = gladiator_noc_bcms,
@@ -1404,6 +1377,7 @@ static struct qcom_icc_node * const mem_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sdm670_mem_noc = {
+	.alloc_dyn_id = true,
 	.nodes = mem_noc_nodes,
 	.num_nodes = ARRAY_SIZE(mem_noc_nodes),
 	.bcms = mem_noc_bcms,
@@ -1434,6 +1408,7 @@ static struct qcom_icc_node * const mmss_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sdm670_mmss_noc = {
+	.alloc_dyn_id = true,
 	.nodes = mmss_noc_nodes,
 	.num_nodes = ARRAY_SIZE(mmss_noc_nodes),
 	.bcms = mmss_noc_bcms,
@@ -1478,6 +1453,7 @@ static struct qcom_icc_node * const system_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sdm670_system_noc = {
+	.alloc_dyn_id = true,
 	.nodes = system_noc_nodes,
 	.num_nodes = ARRAY_SIZE(system_noc_nodes),
 	.bcms = system_noc_bcms,
diff --git a/drivers/interconnect/qcom/sdm670.h b/drivers/interconnect/qcom/sdm670.h
deleted file mode 100644
index 14155f244c43e87c98037f35f895913666f66a41..0000000000000000000000000000000000000000
--- a/drivers/interconnect/qcom/sdm670.h
+++ /dev/null
@@ -1,128 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Qualcomm #define SDM670 interconnect IDs
- *
- * Copyright (c) 2020, The Linux Foundation. All rights reserved.
- */
-
-#ifndef __DRIVERS_INTERCONNECT_QCOM_SDM670_H
-#define __DRIVERS_INTERCONNECT_QCOM_SDM670_H
-
-#define SDM670_MASTER_A1NOC_CFG			0
-#define SDM670_MASTER_A1NOC_SNOC		1
-#define SDM670_MASTER_A2NOC_CFG			2
-#define SDM670_MASTER_A2NOC_SNOC		3
-#define SDM670_MASTER_AMPSS_M0			4
-#define SDM670_MASTER_BLSP_1			5
-#define SDM670_MASTER_BLSP_2			6
-#define SDM670_MASTER_CAMNOC_HF0		7
-#define SDM670_MASTER_CAMNOC_HF0_UNCOMP		8
-#define SDM670_MASTER_CAMNOC_HF1		9
-#define SDM670_MASTER_CAMNOC_HF1_UNCOMP		10
-#define SDM670_MASTER_CAMNOC_SF			11
-#define SDM670_MASTER_CAMNOC_SF_UNCOMP		12
-#define SDM670_MASTER_CNOC_A2NOC		13
-#define SDM670_MASTER_CNOC_DC_NOC		14
-#define SDM670_MASTER_CNOC_MNOC_CFG		15
-#define SDM670_MASTER_CRYPTO_CORE_0		16
-#define SDM670_MASTER_EMMC			17
-#define SDM670_MASTER_GIC			18
-#define SDM670_MASTER_GNOC_CFG			19
-#define SDM670_MASTER_GNOC_MEM_NOC		20
-#define SDM670_MASTER_GNOC_SNOC			21
-#define SDM670_MASTER_GRAPHICS_3D		22
-#define SDM670_MASTER_IPA			23
-#define SDM670_MASTER_LLCC			24
-#define SDM670_MASTER_MDP_PORT0			25
-#define SDM670_MASTER_MDP_PORT1			26
-#define SDM670_MASTER_MEM_NOC_CFG		27
-#define SDM670_MASTER_MEM_NOC_SNOC		28
-#define SDM670_MASTER_MNOC_HF_MEM_NOC		29
-#define SDM670_MASTER_MNOC_SF_MEM_NOC		30
-#define SDM670_MASTER_PIMEM			31
-#define SDM670_MASTER_QDSS_BAM			32
-#define SDM670_MASTER_QDSS_ETR			33
-#define SDM670_MASTER_ROTATOR			34
-#define SDM670_MASTER_SDCC_2			35
-#define SDM670_MASTER_SDCC_4			36
-#define SDM670_MASTER_SNOC_CFG			37
-#define SDM670_MASTER_SNOC_CNOC			38
-#define SDM670_MASTER_SNOC_GC_MEM_NOC		39
-#define SDM670_MASTER_SNOC_SF_MEM_NOC		40
-#define SDM670_MASTER_SPDM			41
-#define SDM670_MASTER_TCU_0			42
-#define SDM670_MASTER_TSIF			43
-#define SDM670_MASTER_UFS_MEM			44
-#define SDM670_MASTER_USB3			45
-#define SDM670_MASTER_VIDEO_P0			46
-#define SDM670_MASTER_VIDEO_P1			47
-#define SDM670_MASTER_VIDEO_PROC		48
-#define SDM670_SLAVE_A1NOC_CFG			49
-#define SDM670_SLAVE_A1NOC_SNOC			50
-#define SDM670_SLAVE_A2NOC_CFG			51
-#define SDM670_SLAVE_A2NOC_SNOC			52
-#define SDM670_SLAVE_AOP			53
-#define SDM670_SLAVE_AOSS			54
-#define SDM670_SLAVE_APPSS			55
-#define SDM670_SLAVE_BLSP_1			56
-#define SDM670_SLAVE_BLSP_2			57
-#define SDM670_SLAVE_CAMERA_CFG			58
-#define SDM670_SLAVE_CAMNOC_UNCOMP		59
-#define SDM670_SLAVE_CDSP_CFG			60
-#define SDM670_SLAVE_CLK_CTL			61
-#define SDM670_SLAVE_CNOC_A2NOC			62
-#define SDM670_SLAVE_CNOC_DDRSS			63
-#define SDM670_SLAVE_CNOC_MNOC_CFG		64
-#define SDM670_SLAVE_CRYPTO_0_CFG		65
-#define SDM670_SLAVE_DCC_CFG			66
-#define SDM670_SLAVE_DISPLAY_CFG		67
-#define SDM670_SLAVE_EBI_CH0			68
-#define SDM670_SLAVE_EMMC_CFG			69
-#define SDM670_SLAVE_GLM			70
-#define SDM670_SLAVE_GNOC_MEM_NOC		71
-#define SDM670_SLAVE_GNOC_SNOC			72
-#define SDM670_SLAVE_GRAPHICS_3D_CFG		73
-#define SDM670_SLAVE_IMEM_CFG			74
-#define SDM670_SLAVE_IPA_CFG			75
-#define SDM670_SLAVE_LLCC			76
-#define SDM670_SLAVE_LLCC_CFG			77
-#define SDM670_SLAVE_MEM_NOC_CFG		78
-#define SDM670_SLAVE_MEM_NOC_GNOC		79
-#define SDM670_SLAVE_MEM_NOC_SNOC		80
-#define SDM670_SLAVE_MNOC_HF_MEM_NOC		81
-#define SDM670_SLAVE_MNOC_SF_MEM_NOC		82
-#define SDM670_SLAVE_MSS_PROC_MS_MPU_CFG	83
-#define SDM670_SLAVE_OCIMEM			84
-#define SDM670_SLAVE_PDM			85
-#define SDM670_SLAVE_PIMEM			86
-#define SDM670_SLAVE_PIMEM_CFG			87
-#define SDM670_SLAVE_PRNG			88
-#define SDM670_SLAVE_QDSS_CFG			89
-#define SDM670_SLAVE_QDSS_STM			90
-#define SDM670_SLAVE_RBCPR_CX_CFG		91
-#define SDM670_SLAVE_SDCC_2			92
-#define SDM670_SLAVE_SDCC_4			93
-#define SDM670_SLAVE_SERVICE_A1NOC		94
-#define SDM670_SLAVE_SERVICE_A2NOC		95
-#define SDM670_SLAVE_SERVICE_CNOC		96
-#define SDM670_SLAVE_SERVICE_GNOC		97
-#define SDM670_SLAVE_SERVICE_MEM_NOC		98
-#define SDM670_SLAVE_SERVICE_MNOC		99
-#define SDM670_SLAVE_SERVICE_SNOC		100
-#define SDM670_SLAVE_SNOC_CFG			101
-#define SDM670_SLAVE_SNOC_CNOC			102
-#define SDM670_SLAVE_SNOC_MEM_NOC_GC		103
-#define SDM670_SLAVE_SNOC_MEM_NOC_SF		104
-#define SDM670_SLAVE_SOUTH_PHY_CFG		105
-#define SDM670_SLAVE_SPDM_WRAPPER		106
-#define SDM670_SLAVE_TCSR			107
-#define SDM670_SLAVE_TCU			108
-#define SDM670_SLAVE_TLMM_NORTH			109
-#define SDM670_SLAVE_TLMM_SOUTH			110
-#define SDM670_SLAVE_TSIF			111
-#define SDM670_SLAVE_UFS_MEM_CFG		112
-#define SDM670_SLAVE_USB3			113
-#define SDM670_SLAVE_VENUS_CFG			114
-#define SDM670_SLAVE_VSENSE_CTRL_CFG		115
-
-#endif

-- 
2.39.5



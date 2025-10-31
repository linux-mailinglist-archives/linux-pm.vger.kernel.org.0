Return-Path: <linux-pm+bounces-37208-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 094E2C25AB8
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 15:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C9D6463A9E
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 14:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FDB628D8FD;
	Fri, 31 Oct 2025 14:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="j+xDz0Yr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CaQ82j3n"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B84A279794
	for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2025 14:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761921955; cv=none; b=HkjOfNSJYMTky65RnK6gtBwJFrjLy2ww3BFdI5+7gXeBQNXHRRsfJWsMBl7BY+SvZTvxsyDbBzEDDL/yQEOzIy3hh4N4V7rRiiVMtLO0WoxJwk0tXh70yfpin4ISvYMAbiGQcrWUH95bzLGqSM5Ls+qtwvxkCt4ah3S8/PbcO5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761921955; c=relaxed/simple;
	bh=z639qJWLeIYRIzEkt7xKSyyACfK+Zys71ziIterzQm4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bOXwNSyskU7fc5GxYzzSQd7sRJ0b3hZIlvWLCbLLPJj8j5Ns3PM/ZLMPm0/MS5wDwMTxROlRl4DoNzP480qD6a8CzMvjJtlAwErrHjYfzKPxLzU5BmZnBgfA43T+d66ZQPmUYdcye9+Ws7C8HZNhF4L8oZQ6pSAsy4d3Yjs03lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=j+xDz0Yr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CaQ82j3n; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59VB0LvW102769
	for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2025 14:45:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9a7WZt81SOSklbzPkGTzdxzt5ob0en1rzvcu8rAtV8k=; b=j+xDz0YrBvy7Gc9N
	bltxYqQILHOotkQN6NIHHZcWw2c81RKnWjb1L0t4vjggEoh3jscNpfkumq5g7zOf
	vVZbSi8Qz+fSiVon+1Wt0A1kTMhTjEhWDM961nbujCJMxPzVVh6Z+YsPhsUxvnSh
	LgGa3CeNvI9sFo5ivzAPMgFOgjCAKXdcOZ+7ojqzVvOUvxcnjDKxyTgnN3E9Asny
	EI/li8XmdDU7LsRhPpFGP5Pjp2CcwPDLWXsMSa50Cu76FEiixHGO8IaOPVz78ENO
	SBHMbYNl+tKTyJqHRuAK3gmP+Jx/Hs0weSZIu/mRSgRfCKN/HAuoQnCAMOAo3ogB
	ypAQJg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a4ahdkfyh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2025 14:45:46 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4e8984d8833so102338151cf.0
        for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2025 07:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761921945; x=1762526745; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9a7WZt81SOSklbzPkGTzdxzt5ob0en1rzvcu8rAtV8k=;
        b=CaQ82j3n1HHgZ5p0KKMoU4Jw76462UjmVf6DVeIdT5UCFIAWHOXS76YuRyZvkZOSs4
         QDZHtYiiH3EGkcTa/17uuQKRjTvr6UUBDoNQjkvHCfEtR2wOCRwuaySOURBvBlXzQmIh
         0UillWTuL6qb0ib98SSPhmxIWIoRPTRmPBxHLosTyTFcaU3S7evcup3SstD37fdBQ5/8
         eojmLsBXhQ+6WpWG6j/TdL5CXbSFed9J1pzww2DCQZhTOjcI8S5tMDN0n7M/HtVIw83O
         fGN1lS0bNYfE7S2o+4xE96OIiHYiFRyUYLEkgFPc3ddkb/gVMHkSLObQmsS9REhT2Mdv
         1yAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761921945; x=1762526745;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9a7WZt81SOSklbzPkGTzdxzt5ob0en1rzvcu8rAtV8k=;
        b=xOTjs04EKApobLCDe2tXEeDx+tinRtqwe0CG+DUdE23O79xJZm7LeLH4WqCKYKKqdh
         zShiWbquFt+0rHrclqGcXMndl9/9fYld1PkHhbuNSK9Q/zQLUtqOuzmeTTbaEhek8SDz
         vvGDngwFqpXK8RrLUVpHuTROn2QsFVjvmU8KpGCVWcuZ+ovQmbHcpRUA7PISCjNPqvBo
         RctgZS4q4UI/kNOHgZ/NjJQ9VM2KiQLU1ViZtE4YEAKQIsjOY/Xeb9+PDo2/d3JxTMza
         xN/7Ba5TLfr51L5mmuSEORU2udwvJKxdHYXnL4JJxA9daBdq2gQ26g+co7tZJ6mtp07P
         dDqQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1GZ1AcPp99HW4xCpZf4jg1xg0jnUzFFBZJuQlyFTnkLqQ9ahjsnnUDMNxdsTkvQ9kblkaXyGI8A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzQVu4Yz9XFhVNAHmmxPq30i+mlTjAtQk/EUZHoqTo8fNN6CE32
	EgR3j/iK0q+J9qqs0MwxalM4Ii3obk6SUecgNTcwsQb784DNQIUSL021MlUuc1y6OTIq82Uzrqf
	cNNKzW1N8qQWo305LTxeoGjaXVRlYlZJE9Qz3ClsbhTIHk8FS1WyGEFGXFHzrpw==
X-Gm-Gg: ASbGncsbJ8GQL3eFLKXkZOa8y1hcktju3IIagiZjtcs9HzmRqUngLigitnkfKkECW89
	3fsL8bJEyJzfcTZA2BEkvYJiO3mO2ZZcNaiQaWiX+QlQce62mCC7HgBfo53n3nMioEDhOqno/EP
	Jt5dnzYHMM+TYtHf63Ou1m0lFXomy3YZdEiYMG0ar5QOEbGzaXdjH7J7c2sxgrRG5FP51N1opaV
	26Ikt0sybnGw6/EqbjIEc6uh2P/molwr3Q2xPM44S5x2c5dsRitiSxGYWp6Phgj7fftjUa9w2vq
	e1CAzEVuTtLUQaImMeAk172fg6+uIB1SNlaQrrBbz7X58VkaDWJwczxGFoemT0dkqFcQ7acGN4e
	euk5f4ggvKKR90bT+kfKVBp1LC30vq7w6gtgQ3NN1X1CEw4juFIBiRNXN9GQL7Ql2WOowVilQFN
	4tP7Vm23YhxmZq
X-Received: by 2002:ac8:7d0c:0:b0:4eb:a291:fbf7 with SMTP id d75a77b69052e-4ed30f87a77mr43966431cf.49.1761921944565;
        Fri, 31 Oct 2025 07:45:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtZ/Hjw91S6B/wS64CLEK7+WYK6p94xu6xa3l4aFakjf3TV5DLMIhAXmT/hizDBPzEeYdqeA==
X-Received: by 2002:ac8:7d0c:0:b0:4eb:a291:fbf7 with SMTP id d75a77b69052e-4ed30f87a77mr43965891cf.49.1761921943826;
        Fri, 31 Oct 2025 07:45:43 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5941f5bc218sm541405e87.93.2025.10.31.07.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 07:45:42 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 31 Oct 2025 16:45:25 +0200
Subject: [PATCH v3 09/25] interconnect: qcom: qcs8300: convert to dynamic
 IDs
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-rework-icc-v3-9-0575304c9624@oss.qualcomm.com>
References: <20251031-rework-icc-v3-0-0575304c9624@oss.qualcomm.com>
In-Reply-To: <20251031-rework-icc-v3-0-0575304c9624@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=60087;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=z639qJWLeIYRIzEkt7xKSyyACfK+Zys71ziIterzQm4=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpBMuDQB0hLuvvLxPEnRp+GAo0t61hRNUF9ZUCC
 Np5GBLyO7eJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaQTLgwAKCRCLPIo+Aiko
 1aiGCACbd9/7PB2Wo1xWmoemNzCEhLoLM/sAmjpx4NFQBdTzDJOCbKZ4RYHi5poa+WA4fmT7fwU
 /FdKKKITAE4rmYYkEWxND+5Y+c5LTrbhLXoG+Fvrti8wv906pzultrqmHFrVuzza0qYiSkZDRO6
 MUf/FFEZ9Z9IXocv2EPvXTih6OeCOXaaft77wW7WvahNhVArw4kr9Op0HZdq3Sjl/x99w36/zqn
 Ob0Kt6YJQovUjLdEXIVKgcnSJgzM445T/yA5InvSKT11s5Y5qKxcGKqU4n/QoyCnO/zZLlapeK5
 fTCd4IZAbSySNvhl4CIiIGajRZ+AYASxNCe0qKtoOVQYkYP/
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDEzMyBTYWx0ZWRfX0d9wHuAGSOk9
 giDRpVATnMnsvtliu+Buv9DG0GH+p7fVeIArskgBXl2h7kUzwZF2Jox5eo6cTwDBJNzeG3utdKG
 tcwwCDwnx6DaaTWwe2DhYL2m/30+UocW8CKIL4GkN1BJhV1pzMIA8QITIOBLm5RbaqL+UPKNqNk
 NI9HJXaS3YHDj4DvjtmgBr47x2kVcua5QPlSx06VcrkMiNNxg68jl0D0IfbILbcDpzULLHvXGjt
 UTKldrJMQ30W3EvtJjANONlEY63snKUY81qo1X05V0RNqomz6b6Q6oPRC1HEged4C+4TmVMXP9s
 CXlFADAhw36gc5DKzU+X1/E9YzCdEGiaqAnH1LMmpnZpsK4M4NajPSnDbISsQNlVoIjzHXvkjJB
 oWYh1NueVqIyz95jQOoqhe/5fS0u8Q==
X-Proofpoint-GUID: XOP54zUTNhF-ssU5KFJgb1Jney1s_Lab
X-Authority-Analysis: v=2.4 cv=TsnrRTXh c=1 sm=1 tr=0 ts=6904cb9a cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=ZcX7BFObjaVFzTCdnnkA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: XOP54zUTNhF-ssU5KFJgb1Jney1s_Lab
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_04,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 spamscore=0 bulkscore=0 phishscore=0 suspectscore=0 adultscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2510310133

Stop using fixed and IDs and covert the platform to use dynamic IDs for
the interconnect. This gives more flexibility and also allows us to drop
the .num_links member, saving from possible errors related to it being
not set or set incorrectly.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/interconnect/qcom/qcs8300.c | 684 ++++++++++++++++--------------------
 drivers/interconnect/qcom/qcs8300.h | 177 ----------
 2 files changed, 305 insertions(+), 556 deletions(-)

diff --git a/drivers/interconnect/qcom/qcs8300.c b/drivers/interconnect/qcom/qcs8300.c
index e7a1b2fc69babe15b914da8d3a3769bfed110179..077f4beb4bd1ae0e508c0683296f0a38cecc0471 100644
--- a/drivers/interconnect/qcom/qcs8300.c
+++ b/drivers/interconnect/qcom/qcs8300.c
@@ -13,1465 +13,1378 @@
 
 #include "bcm-voter.h"
 #include "icc-rpmh.h"
-#include "qcs8300.h"
+
+static struct qcom_icc_node qxm_qup3;
+static struct qcom_icc_node xm_emac_0;
+static struct qcom_icc_node xm_sdc1;
+static struct qcom_icc_node xm_ufs_mem;
+static struct qcom_icc_node xm_usb2_2;
+static struct qcom_icc_node xm_usb3_0;
+static struct qcom_icc_node qhm_qdss_bam;
+static struct qcom_icc_node qhm_qup0;
+static struct qcom_icc_node qhm_qup1;
+static struct qcom_icc_node qnm_cnoc_datapath;
+static struct qcom_icc_node qxm_crypto_0;
+static struct qcom_icc_node qxm_crypto_1;
+static struct qcom_icc_node qxm_ipa;
+static struct qcom_icc_node xm_qdss_etr_0;
+static struct qcom_icc_node xm_qdss_etr_1;
+static struct qcom_icc_node qup0_core_master;
+static struct qcom_icc_node qup1_core_master;
+static struct qcom_icc_node qup3_core_master;
+static struct qcom_icc_node qnm_gemnoc_cnoc;
+static struct qcom_icc_node qnm_gemnoc_pcie;
+static struct qcom_icc_node qnm_cnoc_dc_noc;
+static struct qcom_icc_node alm_gpu_tcu;
+static struct qcom_icc_node alm_pcie_tcu;
+static struct qcom_icc_node alm_sys_tcu;
+static struct qcom_icc_node chm_apps;
+static struct qcom_icc_node qnm_cmpnoc0;
+static struct qcom_icc_node qnm_gemnoc_cfg;
+static struct qcom_icc_node qnm_gpdsp_sail;
+static struct qcom_icc_node qnm_gpu;
+static struct qcom_icc_node qnm_mnoc_hf;
+static struct qcom_icc_node qnm_mnoc_sf;
+static struct qcom_icc_node qnm_pcie;
+static struct qcom_icc_node qnm_snoc_gc;
+static struct qcom_icc_node qnm_snoc_sf;
+static struct qcom_icc_node qnm_sailss_md0;
+static struct qcom_icc_node qxm_dsp0;
+static struct qcom_icc_node qhm_config_noc;
+static struct qcom_icc_node qxm_lpass_dsp;
+static struct qcom_icc_node llcc_mc;
+static struct qcom_icc_node qnm_camnoc_hf;
+static struct qcom_icc_node qnm_camnoc_icp;
+static struct qcom_icc_node qnm_camnoc_sf;
+static struct qcom_icc_node qnm_mdp0_0;
+static struct qcom_icc_node qnm_mdp0_1;
+static struct qcom_icc_node qnm_mnoc_hf_cfg;
+static struct qcom_icc_node qnm_mnoc_sf_cfg;
+static struct qcom_icc_node qnm_video0;
+static struct qcom_icc_node qnm_video_cvp;
+static struct qcom_icc_node qnm_video_v_cpu;
+static struct qcom_icc_node qhm_nsp_noc_config;
+static struct qcom_icc_node qxm_nsp;
+static struct qcom_icc_node xm_pcie3_0;
+static struct qcom_icc_node xm_pcie3_1;
+static struct qcom_icc_node qhm_gic;
+static struct qcom_icc_node qnm_aggre1_noc;
+static struct qcom_icc_node qnm_aggre2_noc;
+static struct qcom_icc_node qnm_lpass_noc;
+static struct qcom_icc_node qnm_snoc_cfg;
+static struct qcom_icc_node qxm_pimem;
+static struct qcom_icc_node xm_gic;
+static struct qcom_icc_node qns_a1noc_snoc;
+static struct qcom_icc_node qns_a2noc_snoc;
+static struct qcom_icc_node qup0_core_slave;
+static struct qcom_icc_node qup1_core_slave;
+static struct qcom_icc_node qup3_core_slave;
+static struct qcom_icc_node qhs_ahb2phy2;
+static struct qcom_icc_node qhs_ahb2phy3;
+static struct qcom_icc_node qhs_anoc_throttle_cfg;
+static struct qcom_icc_node qhs_aoss;
+static struct qcom_icc_node qhs_apss;
+static struct qcom_icc_node qhs_boot_rom;
+static struct qcom_icc_node qhs_camera_cfg;
+static struct qcom_icc_node qhs_camera_nrt_throttle_cfg;
+static struct qcom_icc_node qhs_camera_rt_throttle_cfg;
+static struct qcom_icc_node qhs_clk_ctl;
+static struct qcom_icc_node qhs_compute0_cfg;
+static struct qcom_icc_node qhs_cpr_cx;
+static struct qcom_icc_node qhs_cpr_mmcx;
+static struct qcom_icc_node qhs_cpr_mx;
+static struct qcom_icc_node qhs_cpr_nspcx;
+static struct qcom_icc_node qhs_cpr_nsphmx;
+static struct qcom_icc_node qhs_crypto0_cfg;
+static struct qcom_icc_node qhs_cx_rdpm;
+static struct qcom_icc_node qhs_display0_cfg;
+static struct qcom_icc_node qhs_display0_rt_throttle_cfg;
+static struct qcom_icc_node qhs_emac0_cfg;
+static struct qcom_icc_node qhs_gp_dsp0_cfg;
+static struct qcom_icc_node qhs_gpdsp0_throttle_cfg;
+static struct qcom_icc_node qhs_gpu_tcu_throttle_cfg;
+static struct qcom_icc_node qhs_gpuss_cfg;
+static struct qcom_icc_node qhs_hwkm;
+static struct qcom_icc_node qhs_imem_cfg;
+static struct qcom_icc_node qhs_ipa;
+static struct qcom_icc_node qhs_ipc_router;
+static struct qcom_icc_node qhs_lpass_cfg;
+static struct qcom_icc_node qhs_lpass_throttle_cfg;
+static struct qcom_icc_node qhs_mx_rdpm;
+static struct qcom_icc_node qhs_mxc_rdpm;
+static struct qcom_icc_node qhs_pcie0_cfg;
+static struct qcom_icc_node qhs_pcie1_cfg;
+static struct qcom_icc_node qhs_pcie_tcu_throttle_cfg;
+static struct qcom_icc_node qhs_pcie_throttle_cfg;
+static struct qcom_icc_node qhs_pdm;
+static struct qcom_icc_node qhs_pimem_cfg;
+static struct qcom_icc_node qhs_pke_wrapper_cfg;
+static struct qcom_icc_node qhs_qdss_cfg;
+static struct qcom_icc_node qhs_qm_cfg;
+static struct qcom_icc_node qhs_qm_mpu_cfg;
+static struct qcom_icc_node qhs_qup0;
+static struct qcom_icc_node qhs_qup1;
+static struct qcom_icc_node qhs_qup3;
+static struct qcom_icc_node qhs_sail_throttle_cfg;
+static struct qcom_icc_node qhs_sdc1;
+static struct qcom_icc_node qhs_security;
+static struct qcom_icc_node qhs_snoc_throttle_cfg;
+static struct qcom_icc_node qhs_tcsr;
+static struct qcom_icc_node qhs_tlmm;
+static struct qcom_icc_node qhs_tsc_cfg;
+static struct qcom_icc_node qhs_ufs_mem_cfg;
+static struct qcom_icc_node qhs_usb2_0;
+static struct qcom_icc_node qhs_usb3_0;
+static struct qcom_icc_node qhs_venus_cfg;
+static struct qcom_icc_node qhs_venus_cvp_throttle_cfg;
+static struct qcom_icc_node qhs_venus_v_cpu_throttle_cfg;
+static struct qcom_icc_node qhs_venus_vcodec_throttle_cfg;
+static struct qcom_icc_node qns_ddrss_cfg;
+static struct qcom_icc_node qns_gpdsp_noc_cfg;
+static struct qcom_icc_node qns_mnoc_hf_cfg;
+static struct qcom_icc_node qns_mnoc_sf_cfg;
+static struct qcom_icc_node qns_pcie_anoc_cfg;
+static struct qcom_icc_node qns_snoc_cfg;
+static struct qcom_icc_node qxs_boot_imem;
+static struct qcom_icc_node qxs_imem;
+static struct qcom_icc_node qxs_pimem;
+static struct qcom_icc_node xs_pcie_0;
+static struct qcom_icc_node xs_pcie_1;
+static struct qcom_icc_node xs_qdss_stm;
+static struct qcom_icc_node xs_sys_tcu_cfg;
+static struct qcom_icc_node qhs_llcc;
+static struct qcom_icc_node qns_gemnoc;
+static struct qcom_icc_node qns_gem_noc_cnoc;
+static struct qcom_icc_node qns_llcc;
+static struct qcom_icc_node qns_pcie;
+static struct qcom_icc_node srvc_even_gemnoc;
+static struct qcom_icc_node srvc_odd_gemnoc;
+static struct qcom_icc_node srvc_sys_gemnoc;
+static struct qcom_icc_node srvc_sys_gemnoc_2;
+static struct qcom_icc_node qns_gp_dsp_sail_noc;
+static struct qcom_icc_node qhs_lpass_core;
+static struct qcom_icc_node qhs_lpass_lpi;
+static struct qcom_icc_node qhs_lpass_mpu;
+static struct qcom_icc_node qhs_lpass_top;
+static struct qcom_icc_node qns_sysnoc;
+static struct qcom_icc_node srvc_niu_aml_noc;
+static struct qcom_icc_node srvc_niu_lpass_agnoc;
+static struct qcom_icc_node ebi;
+static struct qcom_icc_node qns_mem_noc_hf;
+static struct qcom_icc_node qns_mem_noc_sf;
+static struct qcom_icc_node srvc_mnoc_hf;
+static struct qcom_icc_node srvc_mnoc_sf;
+static struct qcom_icc_node qns_hcp;
+static struct qcom_icc_node qns_nsp_gemnoc;
+static struct qcom_icc_node service_nsp_noc;
+static struct qcom_icc_node qns_pcie_mem_noc;
+static struct qcom_icc_node qns_gemnoc_gc;
+static struct qcom_icc_node qns_gemnoc_sf;
+static struct qcom_icc_node srvc_snoc;
 
 static struct qcom_icc_node qxm_qup3 = {
 	.name = "qxm_qup3",
-	.id = QCS8300_MASTER_QUP_3,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { QCS8300_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc },
 };
 
 static struct qcom_icc_node xm_emac_0 = {
 	.name = "xm_emac_0",
-	.id = QCS8300_MASTER_EMAC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { QCS8300_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc },
 };
 
 static struct qcom_icc_node xm_sdc1 = {
 	.name = "xm_sdc1",
-	.id = QCS8300_MASTER_SDC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { QCS8300_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc },
 };
 
 static struct qcom_icc_node xm_ufs_mem = {
 	.name = "xm_ufs_mem",
-	.id = QCS8300_MASTER_UFS_MEM,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { QCS8300_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc },
 };
 
 static struct qcom_icc_node xm_usb2_2 = {
 	.name = "xm_usb2_2",
-	.id = QCS8300_MASTER_USB2,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { QCS8300_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc },
 };
 
 static struct qcom_icc_node xm_usb3_0 = {
 	.name = "xm_usb3_0",
-	.id = QCS8300_MASTER_USB3_0,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { QCS8300_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc },
 };
 
 static struct qcom_icc_node qhm_qdss_bam = {
 	.name = "qhm_qdss_bam",
-	.id = QCS8300_MASTER_QDSS_BAM,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { QCS8300_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc },
 };
 
 static struct qcom_icc_node qhm_qup0 = {
 	.name = "qhm_qup0",
-	.id = QCS8300_MASTER_QUP_0,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { QCS8300_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc },
 };
 
 static struct qcom_icc_node qhm_qup1 = {
 	.name = "qhm_qup1",
-	.id = QCS8300_MASTER_QUP_1,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { QCS8300_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc },
 };
 
 static struct qcom_icc_node qnm_cnoc_datapath = {
 	.name = "qnm_cnoc_datapath",
-	.id = QCS8300_MASTER_CNOC_A2NOC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { QCS8300_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc },
 };
 
 static struct qcom_icc_node qxm_crypto_0 = {
 	.name = "qxm_crypto_0",
-	.id = QCS8300_MASTER_CRYPTO_CORE0,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { QCS8300_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc },
 };
 
 static struct qcom_icc_node qxm_crypto_1 = {
 	.name = "qxm_crypto_1",
-	.id = QCS8300_MASTER_CRYPTO_CORE1,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { QCS8300_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc },
 };
 
 static struct qcom_icc_node qxm_ipa = {
 	.name = "qxm_ipa",
-	.id = QCS8300_MASTER_IPA,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { QCS8300_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc },
 };
 
 static struct qcom_icc_node xm_qdss_etr_0 = {
 	.name = "xm_qdss_etr_0",
-	.id = QCS8300_MASTER_QDSS_ETR_0,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { QCS8300_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc },
 };
 
 static struct qcom_icc_node xm_qdss_etr_1 = {
 	.name = "xm_qdss_etr_1",
-	.id = QCS8300_MASTER_QDSS_ETR_1,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { QCS8300_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc },
 };
 
 static struct qcom_icc_node qup0_core_master = {
 	.name = "qup0_core_master",
-	.id = QCS8300_MASTER_QUP_CORE_0,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { QCS8300_SLAVE_QUP_CORE_0 },
+	.link_nodes = { &qup0_core_slave },
 };
 
 static struct qcom_icc_node qup1_core_master = {
 	.name = "qup1_core_master",
-	.id = QCS8300_MASTER_QUP_CORE_1,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { QCS8300_SLAVE_QUP_CORE_1 },
+	.link_nodes = { &qup1_core_slave },
 };
 
 static struct qcom_icc_node qup3_core_master = {
 	.name = "qup3_core_master",
-	.id = QCS8300_MASTER_QUP_CORE_3,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { QCS8300_SLAVE_QUP_CORE_3 },
+	.link_nodes = { &qup3_core_slave },
 };
 
 static struct qcom_icc_node qnm_gemnoc_cnoc = {
 	.name = "qnm_gemnoc_cnoc",
-	.id = QCS8300_MASTER_GEM_NOC_CNOC,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 71,
-	.links = { QCS8300_SLAVE_AHB2PHY_2, QCS8300_SLAVE_AHB2PHY_3,
-			   QCS8300_SLAVE_ANOC_THROTTLE_CFG, QCS8300_SLAVE_AOSS,
-			   QCS8300_SLAVE_APPSS, QCS8300_SLAVE_BOOT_ROM,
-			   QCS8300_SLAVE_CAMERA_CFG, QCS8300_SLAVE_CAMERA_NRT_THROTTLE_CFG,
-			   QCS8300_SLAVE_CAMERA_RT_THROTTLE_CFG, QCS8300_SLAVE_CLK_CTL,
-			   QCS8300_SLAVE_CDSP_CFG, QCS8300_SLAVE_RBCPR_CX_CFG,
-			   QCS8300_SLAVE_RBCPR_MMCX_CFG, QCS8300_SLAVE_RBCPR_MX_CFG,
-			   QCS8300_SLAVE_CPR_NSPCX, QCS8300_SLAVE_CPR_NSPHMX,
-			   QCS8300_SLAVE_CRYPTO_0_CFG, QCS8300_SLAVE_CX_RDPM,
-			   QCS8300_SLAVE_DISPLAY_CFG, QCS8300_SLAVE_DISPLAY_RT_THROTTLE_CFG,
-			   QCS8300_SLAVE_EMAC_CFG, QCS8300_SLAVE_GP_DSP0_CFG,
-			   QCS8300_SLAVE_GPDSP0_THROTTLE_CFG, QCS8300_SLAVE_GPU_TCU_THROTTLE_CFG,
-			   QCS8300_SLAVE_GFX3D_CFG, QCS8300_SLAVE_HWKM,
-			   QCS8300_SLAVE_IMEM_CFG, QCS8300_SLAVE_IPA_CFG,
-			   QCS8300_SLAVE_IPC_ROUTER_CFG, QCS8300_SLAVE_LPASS,
-			   QCS8300_SLAVE_LPASS_THROTTLE_CFG, QCS8300_SLAVE_MX_RDPM,
-			   QCS8300_SLAVE_MXC_RDPM, QCS8300_SLAVE_PCIE_0_CFG,
-			   QCS8300_SLAVE_PCIE_1_CFG, QCS8300_SLAVE_PCIE_TCU_THROTTLE_CFG,
-			   QCS8300_SLAVE_PCIE_THROTTLE_CFG, QCS8300_SLAVE_PDM,
-			   QCS8300_SLAVE_PIMEM_CFG, QCS8300_SLAVE_PKA_WRAPPER_CFG,
-			   QCS8300_SLAVE_QDSS_CFG, QCS8300_SLAVE_QM_CFG,
-			   QCS8300_SLAVE_QM_MPU_CFG, QCS8300_SLAVE_QUP_0,
-			   QCS8300_SLAVE_QUP_1, QCS8300_SLAVE_QUP_3,
-			   QCS8300_SLAVE_SAIL_THROTTLE_CFG, QCS8300_SLAVE_SDC1,
-			   QCS8300_SLAVE_SECURITY, QCS8300_SLAVE_SNOC_THROTTLE_CFG,
-			   QCS8300_SLAVE_TCSR, QCS8300_SLAVE_TLMM,
-			   QCS8300_SLAVE_TSC_CFG, QCS8300_SLAVE_UFS_MEM_CFG,
-			   QCS8300_SLAVE_USB2, QCS8300_SLAVE_USB3_0,
-			   QCS8300_SLAVE_VENUS_CFG, QCS8300_SLAVE_VENUS_CVP_THROTTLE_CFG,
-			   QCS8300_SLAVE_VENUS_V_CPU_THROTTLE_CFG,
-			   QCS8300_SLAVE_VENUS_VCODEC_THROTTLE_CFG,
-			   QCS8300_SLAVE_DDRSS_CFG, QCS8300_SLAVE_GPDSP_NOC_CFG,
-			   QCS8300_SLAVE_CNOC_MNOC_HF_CFG, QCS8300_SLAVE_CNOC_MNOC_SF_CFG,
-			   QCS8300_SLAVE_PCIE_ANOC_CFG, QCS8300_SLAVE_SNOC_CFG,
-			   QCS8300_SLAVE_BOOT_IMEM, QCS8300_SLAVE_IMEM,
-			   QCS8300_SLAVE_PIMEM, QCS8300_SLAVE_QDSS_STM,
-			   QCS8300_SLAVE_TCU },
+	.link_nodes = { &qhs_ahb2phy2, &qhs_ahb2phy3,
+			&qhs_anoc_throttle_cfg, &qhs_aoss,
+			&qhs_apss, &qhs_boot_rom,
+			&qhs_camera_cfg, &qhs_camera_nrt_throttle_cfg,
+			&qhs_camera_rt_throttle_cfg, &qhs_clk_ctl,
+			&qhs_compute0_cfg, &qhs_cpr_cx,
+			&qhs_cpr_mmcx, &qhs_cpr_mx,
+			&qhs_cpr_nspcx, &qhs_cpr_nsphmx,
+			&qhs_crypto0_cfg, &qhs_cx_rdpm,
+			&qhs_display0_cfg, &qhs_display0_rt_throttle_cfg,
+			&qhs_emac0_cfg, &qhs_gp_dsp0_cfg,
+			&qhs_gpdsp0_throttle_cfg, &qhs_gpu_tcu_throttle_cfg,
+			&qhs_gpuss_cfg, &qhs_hwkm,
+			&qhs_imem_cfg, &qhs_ipa,
+			&qhs_ipc_router, &qhs_lpass_cfg,
+			&qhs_lpass_throttle_cfg, &qhs_mx_rdpm,
+			&qhs_mxc_rdpm, &qhs_pcie0_cfg,
+			&qhs_pcie1_cfg, &qhs_pcie_tcu_throttle_cfg,
+			&qhs_pcie_throttle_cfg, &qhs_pdm,
+			&qhs_pimem_cfg, &qhs_pke_wrapper_cfg,
+			&qhs_qdss_cfg, &qhs_qm_cfg,
+			&qhs_qm_mpu_cfg, &qhs_qup0,
+			&qhs_qup1, &qhs_qup3,
+			&qhs_sail_throttle_cfg, &qhs_sdc1,
+			&qhs_security, &qhs_snoc_throttle_cfg,
+			&qhs_tcsr, &qhs_tlmm,
+			&qhs_tsc_cfg, &qhs_ufs_mem_cfg,
+			&qhs_usb2_0, &qhs_usb3_0,
+			&qhs_venus_cfg, &qhs_venus_cvp_throttle_cfg,
+			&qhs_venus_v_cpu_throttle_cfg,
+			&qhs_venus_vcodec_throttle_cfg,
+			&qns_ddrss_cfg, &qns_gpdsp_noc_cfg,
+			&qns_mnoc_hf_cfg, &qns_mnoc_sf_cfg,
+			&qns_pcie_anoc_cfg, &qns_snoc_cfg,
+			&qxs_boot_imem, &qxs_imem,
+			&qxs_pimem, &xs_qdss_stm,
+			&xs_sys_tcu_cfg },
 };
 
 static struct qcom_icc_node qnm_gemnoc_pcie = {
 	.name = "qnm_gemnoc_pcie",
-	.id = QCS8300_MASTER_GEM_NOC_PCIE_SNOC,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 2,
-	.links = { QCS8300_SLAVE_PCIE_0, QCS8300_SLAVE_PCIE_1 },
+	.link_nodes = { &xs_pcie_0, &xs_pcie_1 },
 };
 
 static struct qcom_icc_node qnm_cnoc_dc_noc = {
 	.name = "qnm_cnoc_dc_noc",
-	.id = QCS8300_MASTER_CNOC_DC_NOC,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 2,
-	.links = { QCS8300_SLAVE_LLCC_CFG, QCS8300_SLAVE_GEM_NOC_CFG },
+	.link_nodes = { &qhs_llcc, &qns_gemnoc },
 };
 
 static struct qcom_icc_node alm_gpu_tcu = {
 	.name = "alm_gpu_tcu",
-	.id = QCS8300_MASTER_GPU_TCU,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 2,
-	.links = { QCS8300_SLAVE_GEM_NOC_CNOC, QCS8300_SLAVE_LLCC },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc },
 };
 
 static struct qcom_icc_node alm_pcie_tcu = {
 	.name = "alm_pcie_tcu",
-	.id = QCS8300_MASTER_PCIE_TCU,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 2,
-	.links = { QCS8300_SLAVE_GEM_NOC_CNOC, QCS8300_SLAVE_LLCC },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc },
 };
 
 static struct qcom_icc_node alm_sys_tcu = {
 	.name = "alm_sys_tcu",
-	.id = QCS8300_MASTER_SYS_TCU,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 2,
-	.links = { QCS8300_SLAVE_GEM_NOC_CNOC, QCS8300_SLAVE_LLCC },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc },
 };
 
 static struct qcom_icc_node chm_apps = {
 	.name = "chm_apps",
-	.id = QCS8300_MASTER_APPSS_PROC,
 	.channels = 4,
 	.buswidth = 32,
 	.num_links = 3,
-	.links = { QCS8300_SLAVE_GEM_NOC_CNOC, QCS8300_SLAVE_LLCC,
-			   QCS8300_SLAVE_GEM_NOC_PCIE_CNOC },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc,
+			&qns_pcie },
 };
 
 static struct qcom_icc_node qnm_cmpnoc0 = {
 	.name = "qnm_cmpnoc0",
-	.id = QCS8300_MASTER_COMPUTE_NOC,
 	.channels = 2,
 	.buswidth = 32,
 	.num_links = 2,
-	.links = { QCS8300_SLAVE_GEM_NOC_CNOC, QCS8300_SLAVE_LLCC },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc },
 };
 
 static struct qcom_icc_node qnm_gemnoc_cfg = {
 	.name = "qnm_gemnoc_cfg",
-	.id = QCS8300_MASTER_GEM_NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 4,
-	.links = { QCS8300_SLAVE_SERVICE_GEM_NOC_1, QCS8300_SLAVE_SERVICE_GEM_NOC_2,
-		   QCS8300_SLAVE_SERVICE_GEM_NOC, QCS8300_SLAVE_SERVICE_GEM_NOC2 },
+	.link_nodes = { &srvc_even_gemnoc, &srvc_odd_gemnoc,
+			&srvc_sys_gemnoc, &srvc_sys_gemnoc_2 },
 };
 
 static struct qcom_icc_node qnm_gpdsp_sail = {
 	.name = "qnm_gpdsp_sail",
-	.id = QCS8300_MASTER_GPDSP_SAIL,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 2,
-	.links = { QCS8300_SLAVE_GEM_NOC_CNOC, QCS8300_SLAVE_LLCC },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc },
 };
 
 static struct qcom_icc_node qnm_gpu = {
 	.name = "qnm_gpu",
-	.id = QCS8300_MASTER_GFX3D,
 	.channels = 2,
 	.buswidth = 32,
 	.num_links = 2,
-	.links = { QCS8300_SLAVE_GEM_NOC_CNOC, QCS8300_SLAVE_LLCC },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc },
 };
 
 static struct qcom_icc_node qnm_mnoc_hf = {
 	.name = "qnm_mnoc_hf",
-	.id = QCS8300_MASTER_MNOC_HF_MEM_NOC,
 	.channels = 2,
 	.buswidth = 32,
 	.num_links = 2,
-	.links = { QCS8300_SLAVE_LLCC, QCS8300_SLAVE_GEM_NOC_PCIE_CNOC },
+	.link_nodes = { &qns_llcc, &qns_pcie },
 };
 
 static struct qcom_icc_node qnm_mnoc_sf = {
 	.name = "qnm_mnoc_sf",
-	.id = QCS8300_MASTER_MNOC_SF_MEM_NOC,
 	.channels = 2,
 	.buswidth = 32,
 	.num_links = 3,
-	.links = { QCS8300_SLAVE_GEM_NOC_CNOC, QCS8300_SLAVE_LLCC,
-		   QCS8300_SLAVE_GEM_NOC_PCIE_CNOC },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc,
+			&qns_pcie },
 };
 
 static struct qcom_icc_node qnm_pcie = {
 	.name = "qnm_pcie",
-	.id = QCS8300_MASTER_ANOC_PCIE_GEM_NOC,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 2,
-	.links = { QCS8300_SLAVE_GEM_NOC_CNOC, QCS8300_SLAVE_LLCC },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc },
 };
 
 static struct qcom_icc_node qnm_snoc_gc = {
 	.name = "qnm_snoc_gc",
-	.id = QCS8300_MASTER_SNOC_GC_MEM_NOC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { QCS8300_SLAVE_LLCC },
+	.link_nodes = { &qns_llcc },
 };
 
 static struct qcom_icc_node qnm_snoc_sf = {
 	.name = "qnm_snoc_sf",
-	.id = QCS8300_MASTER_SNOC_SF_MEM_NOC,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 3,
-	.links = { QCS8300_SLAVE_GEM_NOC_CNOC, QCS8300_SLAVE_LLCC,
-		   QCS8300_SLAVE_GEM_NOC_PCIE_CNOC },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc,
+			&qns_pcie },
 };
 
 static struct qcom_icc_node qnm_sailss_md0 = {
 	.name = "qnm_sailss_md0",
-	.id = QCS8300_MASTER_SAILSS_MD0,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { QCS8300_SLAVE_GP_DSP_SAIL_NOC },
+	.link_nodes = { &qns_gp_dsp_sail_noc },
 };
 
 static struct qcom_icc_node qxm_dsp0 = {
 	.name = "qxm_dsp0",
-	.id = QCS8300_MASTER_DSP0,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { QCS8300_SLAVE_GP_DSP_SAIL_NOC },
+	.link_nodes = { &qns_gp_dsp_sail_noc },
 };
 
 static struct qcom_icc_node qhm_config_noc = {
 	.name = "qhm_config_noc",
-	.id = QCS8300_MASTER_CNOC_LPASS_AG_NOC,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 6,
-	.links = { QCS8300_SLAVE_LPASS_CORE_CFG, QCS8300_SLAVE_LPASS_LPI_CFG,
-		   QCS8300_SLAVE_LPASS_MPU_CFG, QCS8300_SLAVE_LPASS_TOP_CFG,
-		   QCS8300_SLAVE_SERVICES_LPASS_AML_NOC, QCS8300_SLAVE_SERVICE_LPASS_AG_NOC },
+	.link_nodes = { &qhs_lpass_core, &qhs_lpass_lpi,
+			&qhs_lpass_mpu, &qhs_lpass_top,
+			&srvc_niu_aml_noc, &srvc_niu_lpass_agnoc },
 };
 
 static struct qcom_icc_node qxm_lpass_dsp = {
 	.name = "qxm_lpass_dsp",
-	.id = QCS8300_MASTER_LPASS_PROC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 4,
-	.links = { QCS8300_SLAVE_LPASS_TOP_CFG, QCS8300_SLAVE_LPASS_SNOC,
-		   QCS8300_SLAVE_SERVICES_LPASS_AML_NOC, QCS8300_SLAVE_SERVICE_LPASS_AG_NOC },
+	.link_nodes = { &qhs_lpass_top, &qns_sysnoc,
+			&srvc_niu_aml_noc, &srvc_niu_lpass_agnoc },
 };
 
 static struct qcom_icc_node llcc_mc = {
 	.name = "llcc_mc",
-	.id = QCS8300_MASTER_LLCC,
 	.channels = 8,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { QCS8300_SLAVE_EBI1 },
+	.link_nodes = { &ebi },
 };
 
 static struct qcom_icc_node qnm_camnoc_hf = {
 	.name = "qnm_camnoc_hf",
-	.id = QCS8300_MASTER_CAMNOC_HF,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { QCS8300_SLAVE_MNOC_HF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_hf },
 };
 
 static struct qcom_icc_node qnm_camnoc_icp = {
 	.name = "qnm_camnoc_icp",
-	.id = QCS8300_MASTER_CAMNOC_ICP,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { QCS8300_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_sf },
 };
 
 static struct qcom_icc_node qnm_camnoc_sf = {
 	.name = "qnm_camnoc_sf",
-	.id = QCS8300_MASTER_CAMNOC_SF,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { QCS8300_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_sf },
 };
 
 static struct qcom_icc_node qnm_mdp0_0 = {
 	.name = "qnm_mdp0_0",
-	.id = QCS8300_MASTER_MDP0,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { QCS8300_SLAVE_MNOC_HF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_hf },
 };
 
 static struct qcom_icc_node qnm_mdp0_1 = {
 	.name = "qnm_mdp0_1",
-	.id = QCS8300_MASTER_MDP1,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { QCS8300_SLAVE_MNOC_HF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_hf },
 };
 
 static struct qcom_icc_node qnm_mnoc_hf_cfg = {
 	.name = "qnm_mnoc_hf_cfg",
-	.id = QCS8300_MASTER_CNOC_MNOC_HF_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { QCS8300_SLAVE_SERVICE_MNOC_HF },
+	.link_nodes = { &srvc_mnoc_hf },
 };
 
 static struct qcom_icc_node qnm_mnoc_sf_cfg = {
 	.name = "qnm_mnoc_sf_cfg",
-	.id = QCS8300_MASTER_CNOC_MNOC_SF_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { QCS8300_SLAVE_SERVICE_MNOC_SF },
+	.link_nodes = { &srvc_mnoc_sf },
 };
 
 static struct qcom_icc_node qnm_video0 = {
 	.name = "qnm_video0",
-	.id = QCS8300_MASTER_VIDEO_P0,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { QCS8300_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_sf },
 };
 
 static struct qcom_icc_node qnm_video_cvp = {
 	.name = "qnm_video_cvp",
-	.id = QCS8300_MASTER_VIDEO_PROC,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { QCS8300_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_sf },
 };
 
 static struct qcom_icc_node qnm_video_v_cpu = {
 	.name = "qnm_video_v_cpu",
-	.id = QCS8300_MASTER_VIDEO_V_PROC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { QCS8300_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_sf },
 };
 
 static struct qcom_icc_node qhm_nsp_noc_config = {
 	.name = "qhm_nsp_noc_config",
-	.id = QCS8300_MASTER_CDSP_NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { QCS8300_SLAVE_SERVICE_NSP_NOC },
+	.link_nodes = { &service_nsp_noc },
 };
 
 static struct qcom_icc_node qxm_nsp = {
 	.name = "qxm_nsp",
-	.id = QCS8300_MASTER_CDSP_PROC,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 2,
-	.links = { QCS8300_SLAVE_HCP_A, QCS8300_SLAVE_CDSP_MEM_NOC },
+	.num_links = 1,
+	.link_nodes = { &qns_hcp, &qns_nsp_gemnoc },
 };
 
 static struct qcom_icc_node xm_pcie3_0 = {
 	.name = "xm_pcie3_0",
-	.id = QCS8300_MASTER_PCIE_0,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { QCS8300_SLAVE_ANOC_PCIE_GEM_NOC },
+	.link_nodes = { &qns_pcie_mem_noc },
 };
 
 static struct qcom_icc_node xm_pcie3_1 = {
 	.name = "xm_pcie3_1",
-	.id = QCS8300_MASTER_PCIE_1,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { QCS8300_SLAVE_ANOC_PCIE_GEM_NOC },
+	.link_nodes = { &qns_pcie_mem_noc },
 };
 
 static struct qcom_icc_node qhm_gic = {
 	.name = "qhm_gic",
-	.id = QCS8300_MASTER_GIC_AHB,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { QCS8300_SLAVE_SNOC_GEM_NOC_SF },
+	.link_nodes = { &qns_gemnoc_sf },
 };
 
 static struct qcom_icc_node qnm_aggre1_noc = {
 	.name = "qnm_aggre1_noc",
-	.id = QCS8300_MASTER_A1NOC_SNOC,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { QCS8300_SLAVE_SNOC_GEM_NOC_SF },
+	.link_nodes = { &qns_gemnoc_sf },
 };
 
 static struct qcom_icc_node qnm_aggre2_noc = {
 	.name = "qnm_aggre2_noc",
-	.id = QCS8300_MASTER_A2NOC_SNOC,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { QCS8300_SLAVE_SNOC_GEM_NOC_SF },
+	.link_nodes = { &qns_gemnoc_sf },
 };
 
 static struct qcom_icc_node qnm_lpass_noc = {
 	.name = "qnm_lpass_noc",
-	.id = QCS8300_MASTER_LPASS_ANOC,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { QCS8300_SLAVE_SNOC_GEM_NOC_SF },
+	.link_nodes = { &qns_gemnoc_sf },
 };
 
 static struct qcom_icc_node qnm_snoc_cfg = {
 	.name = "qnm_snoc_cfg",
-	.id = QCS8300_MASTER_SNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { QCS8300_SLAVE_SERVICE_SNOC },
+	.link_nodes = { &srvc_snoc },
 };
 
 static struct qcom_icc_node qxm_pimem = {
 	.name = "qxm_pimem",
-	.id = QCS8300_MASTER_PIMEM,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { QCS8300_SLAVE_SNOC_GEM_NOC_GC },
+	.link_nodes = { &qns_gemnoc_gc },
 };
 
 static struct qcom_icc_node xm_gic = {
 	.name = "xm_gic",
-	.id = QCS8300_MASTER_GIC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { QCS8300_SLAVE_SNOC_GEM_NOC_GC },
+	.link_nodes = { &qns_gemnoc_gc },
 };
 
 static struct qcom_icc_node qns_a1noc_snoc = {
 	.name = "qns_a1noc_snoc",
-	.id = QCS8300_SLAVE_A1NOC_SNOC,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { QCS8300_MASTER_A1NOC_SNOC },
+	.link_nodes = { &qnm_aggre1_noc },
 };
 
 static struct qcom_icc_node qns_a2noc_snoc = {
 	.name = "qns_a2noc_snoc",
-	.id = QCS8300_SLAVE_A2NOC_SNOC,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { QCS8300_MASTER_A2NOC_SNOC },
+	.link_nodes = { &qnm_aggre2_noc },
 };
 
 static struct qcom_icc_node qup0_core_slave = {
 	.name = "qup0_core_slave",
-	.id = QCS8300_SLAVE_QUP_CORE_0,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qup1_core_slave = {
 	.name = "qup1_core_slave",
-	.id = QCS8300_SLAVE_QUP_CORE_1,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qup3_core_slave = {
 	.name = "qup3_core_slave",
-	.id = QCS8300_SLAVE_QUP_CORE_3,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_ahb2phy2 = {
 	.name = "qhs_ahb2phy2",
-	.id = QCS8300_SLAVE_AHB2PHY_2,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_ahb2phy3 = {
 	.name = "qhs_ahb2phy3",
-	.id = QCS8300_SLAVE_AHB2PHY_3,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_anoc_throttle_cfg = {
 	.name = "qhs_anoc_throttle_cfg",
-	.id = QCS8300_SLAVE_ANOC_THROTTLE_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_aoss = {
 	.name = "qhs_aoss",
-	.id = QCS8300_SLAVE_AOSS,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_apss = {
 	.name = "qhs_apss",
-	.id = QCS8300_SLAVE_APPSS,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_boot_rom = {
 	.name = "qhs_boot_rom",
-	.id = QCS8300_SLAVE_BOOT_ROM,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_camera_cfg = {
 	.name = "qhs_camera_cfg",
-	.id = QCS8300_SLAVE_CAMERA_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_camera_nrt_throttle_cfg = {
 	.name = "qhs_camera_nrt_throttle_cfg",
-	.id = QCS8300_SLAVE_CAMERA_NRT_THROTTLE_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_camera_rt_throttle_cfg = {
 	.name = "qhs_camera_rt_throttle_cfg",
-	.id = QCS8300_SLAVE_CAMERA_RT_THROTTLE_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_clk_ctl = {
 	.name = "qhs_clk_ctl",
-	.id = QCS8300_SLAVE_CLK_CTL,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_compute0_cfg = {
 	.name = "qhs_compute0_cfg",
-	.id = QCS8300_SLAVE_CDSP_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { QCS8300_MASTER_CDSP_NOC_CFG },
+	.link_nodes = { &qhm_nsp_noc_config },
 };
 
 static struct qcom_icc_node qhs_cpr_cx = {
 	.name = "qhs_cpr_cx",
-	.id = QCS8300_SLAVE_RBCPR_CX_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_cpr_mmcx = {
 	.name = "qhs_cpr_mmcx",
-	.id = QCS8300_SLAVE_RBCPR_MMCX_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_cpr_mx = {
 	.name = "qhs_cpr_mx",
-	.id = QCS8300_SLAVE_RBCPR_MX_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_cpr_nspcx = {
 	.name = "qhs_cpr_nspcx",
-	.id = QCS8300_SLAVE_CPR_NSPCX,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_cpr_nsphmx = {
 	.name = "qhs_cpr_nsphmx",
-	.id = QCS8300_SLAVE_CPR_NSPHMX,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_crypto0_cfg = {
 	.name = "qhs_crypto0_cfg",
-	.id = QCS8300_SLAVE_CRYPTO_0_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_cx_rdpm = {
 	.name = "qhs_cx_rdpm",
-	.id = QCS8300_SLAVE_CX_RDPM,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_display0_cfg = {
 	.name = "qhs_display0_cfg",
-	.id = QCS8300_SLAVE_DISPLAY_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_display0_rt_throttle_cfg = {
 	.name = "qhs_display0_rt_throttle_cfg",
-	.id = QCS8300_SLAVE_DISPLAY_RT_THROTTLE_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_emac0_cfg = {
 	.name = "qhs_emac0_cfg",
-	.id = QCS8300_SLAVE_EMAC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_gp_dsp0_cfg = {
 	.name = "qhs_gp_dsp0_cfg",
-	.id = QCS8300_SLAVE_GP_DSP0_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_gpdsp0_throttle_cfg = {
 	.name = "qhs_gpdsp0_throttle_cfg",
-	.id = QCS8300_SLAVE_GPDSP0_THROTTLE_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_gpu_tcu_throttle_cfg = {
 	.name = "qhs_gpu_tcu_throttle_cfg",
-	.id = QCS8300_SLAVE_GPU_TCU_THROTTLE_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_gpuss_cfg = {
 	.name = "qhs_gpuss_cfg",
-	.id = QCS8300_SLAVE_GFX3D_CFG,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_hwkm = {
 	.name = "qhs_hwkm",
-	.id = QCS8300_SLAVE_HWKM,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_imem_cfg = {
 	.name = "qhs_imem_cfg",
-	.id = QCS8300_SLAVE_IMEM_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_ipa = {
 	.name = "qhs_ipa",
-	.id = QCS8300_SLAVE_IPA_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_ipc_router = {
 	.name = "qhs_ipc_router",
-	.id = QCS8300_SLAVE_IPC_ROUTER_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_lpass_cfg = {
 	.name = "qhs_lpass_cfg",
-	.id = QCS8300_SLAVE_LPASS,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { QCS8300_MASTER_CNOC_LPASS_AG_NOC },
+	.link_nodes = { &qhm_config_noc },
 };
 
 static struct qcom_icc_node qhs_lpass_throttle_cfg = {
 	.name = "qhs_lpass_throttle_cfg",
-	.id = QCS8300_SLAVE_LPASS_THROTTLE_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_mx_rdpm = {
 	.name = "qhs_mx_rdpm",
-	.id = QCS8300_SLAVE_MX_RDPM,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_mxc_rdpm = {
 	.name = "qhs_mxc_rdpm",
-	.id = QCS8300_SLAVE_MXC_RDPM,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_pcie0_cfg = {
 	.name = "qhs_pcie0_cfg",
-	.id = QCS8300_SLAVE_PCIE_0_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_pcie1_cfg = {
 	.name = "qhs_pcie1_cfg",
-	.id = QCS8300_SLAVE_PCIE_1_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_pcie_tcu_throttle_cfg = {
 	.name = "qhs_pcie_tcu_throttle_cfg",
-	.id = QCS8300_SLAVE_PCIE_TCU_THROTTLE_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_pcie_throttle_cfg = {
 	.name = "qhs_pcie_throttle_cfg",
-	.id = QCS8300_SLAVE_PCIE_THROTTLE_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_pdm = {
 	.name = "qhs_pdm",
-	.id = QCS8300_SLAVE_PDM,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_pimem_cfg = {
 	.name = "qhs_pimem_cfg",
-	.id = QCS8300_SLAVE_PIMEM_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_pke_wrapper_cfg = {
 	.name = "qhs_pke_wrapper_cfg",
-	.id = QCS8300_SLAVE_PKA_WRAPPER_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_qdss_cfg = {
 	.name = "qhs_qdss_cfg",
-	.id = QCS8300_SLAVE_QDSS_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_qm_cfg = {
 	.name = "qhs_qm_cfg",
-	.id = QCS8300_SLAVE_QM_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_qm_mpu_cfg = {
 	.name = "qhs_qm_mpu_cfg",
-	.id = QCS8300_SLAVE_QM_MPU_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_qup0 = {
 	.name = "qhs_qup0",
-	.id = QCS8300_SLAVE_QUP_0,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_qup1 = {
 	.name = "qhs_qup1",
-	.id = QCS8300_SLAVE_QUP_1,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_qup3 = {
 	.name = "qhs_qup3",
-	.id = QCS8300_SLAVE_QUP_3,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_sail_throttle_cfg = {
 	.name = "qhs_sail_throttle_cfg",
-	.id = QCS8300_SLAVE_SAIL_THROTTLE_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_sdc1 = {
 	.name = "qhs_sdc1",
-	.id = QCS8300_SLAVE_SDC1,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_security = {
 	.name = "qhs_security",
-	.id = QCS8300_SLAVE_SECURITY,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_snoc_throttle_cfg = {
 	.name = "qhs_snoc_throttle_cfg",
-	.id = QCS8300_SLAVE_SNOC_THROTTLE_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_tcsr = {
 	.name = "qhs_tcsr",
-	.id = QCS8300_SLAVE_TCSR,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_tlmm = {
 	.name = "qhs_tlmm",
-	.id = QCS8300_SLAVE_TLMM,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_tsc_cfg = {
 	.name = "qhs_tsc_cfg",
-	.id = QCS8300_SLAVE_TSC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_ufs_mem_cfg = {
 	.name = "qhs_ufs_mem_cfg",
-	.id = QCS8300_SLAVE_UFS_MEM_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_usb2_0 = {
 	.name = "qhs_usb2_0",
-	.id = QCS8300_SLAVE_USB2,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_usb3_0 = {
 	.name = "qhs_usb3_0",
-	.id = QCS8300_SLAVE_USB3_0,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_venus_cfg = {
 	.name = "qhs_venus_cfg",
-	.id = QCS8300_SLAVE_VENUS_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_venus_cvp_throttle_cfg = {
 	.name = "qhs_venus_cvp_throttle_cfg",
-	.id = QCS8300_SLAVE_VENUS_CVP_THROTTLE_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_venus_v_cpu_throttle_cfg = {
 	.name = "qhs_venus_v_cpu_throttle_cfg",
-	.id = QCS8300_SLAVE_VENUS_V_CPU_THROTTLE_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_venus_vcodec_throttle_cfg = {
 	.name = "qhs_venus_vcodec_throttle_cfg",
-	.id = QCS8300_SLAVE_VENUS_VCODEC_THROTTLE_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qns_ddrss_cfg = {
 	.name = "qns_ddrss_cfg",
-	.id = QCS8300_SLAVE_DDRSS_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { QCS8300_MASTER_CNOC_DC_NOC },
+	.link_nodes = { &qnm_cnoc_dc_noc },
 };
 
 static struct qcom_icc_node qns_gpdsp_noc_cfg = {
 	.name = "qns_gpdsp_noc_cfg",
-	.id = QCS8300_SLAVE_GPDSP_NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qns_mnoc_hf_cfg = {
 	.name = "qns_mnoc_hf_cfg",
-	.id = QCS8300_SLAVE_CNOC_MNOC_HF_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { QCS8300_MASTER_CNOC_MNOC_HF_CFG },
+	.link_nodes = { &qnm_mnoc_hf_cfg },
 };
 
 static struct qcom_icc_node qns_mnoc_sf_cfg = {
 	.name = "qns_mnoc_sf_cfg",
-	.id = QCS8300_SLAVE_CNOC_MNOC_SF_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { QCS8300_MASTER_CNOC_MNOC_SF_CFG },
+	.link_nodes = { &qnm_mnoc_sf_cfg },
 };
 
 static struct qcom_icc_node qns_pcie_anoc_cfg = {
 	.name = "qns_pcie_anoc_cfg",
-	.id = QCS8300_SLAVE_PCIE_ANOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qns_snoc_cfg = {
 	.name = "qns_snoc_cfg",
-	.id = QCS8300_SLAVE_SNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { QCS8300_MASTER_SNOC_CFG },
+	.link_nodes = { &qnm_snoc_cfg },
 };
 
 static struct qcom_icc_node qxs_boot_imem = {
 	.name = "qxs_boot_imem",
-	.id = QCS8300_SLAVE_BOOT_IMEM,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qxs_imem = {
 	.name = "qxs_imem",
-	.id = QCS8300_SLAVE_IMEM,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qxs_pimem = {
 	.name = "qxs_pimem",
-	.id = QCS8300_SLAVE_PIMEM,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node xs_pcie_0 = {
 	.name = "xs_pcie_0",
-	.id = QCS8300_SLAVE_PCIE_0,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node xs_pcie_1 = {
 	.name = "xs_pcie_1",
-	.id = QCS8300_SLAVE_PCIE_1,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node xs_qdss_stm = {
 	.name = "xs_qdss_stm",
-	.id = QCS8300_SLAVE_QDSS_STM,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node xs_sys_tcu_cfg = {
 	.name = "xs_sys_tcu_cfg",
-	.id = QCS8300_SLAVE_TCU,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_llcc = {
 	.name = "qhs_llcc",
-	.id = QCS8300_SLAVE_LLCC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qns_gemnoc = {
 	.name = "qns_gemnoc",
-	.id = QCS8300_SLAVE_GEM_NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { QCS8300_MASTER_GEM_NOC_CFG },
+	.link_nodes = { &qnm_gemnoc_cfg },
 };
 
 static struct qcom_icc_node qns_gem_noc_cnoc = {
 	.name = "qns_gem_noc_cnoc",
-	.id = QCS8300_SLAVE_GEM_NOC_CNOC,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { QCS8300_MASTER_GEM_NOC_CNOC },
+	.link_nodes = { &qnm_gemnoc_cnoc },
 };
 
 static struct qcom_icc_node qns_llcc = {
 	.name = "qns_llcc",
-	.id = QCS8300_SLAVE_LLCC,
 	.channels = 4,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { QCS8300_MASTER_LLCC },
+	.link_nodes = { &llcc_mc },
 };
 
 static struct qcom_icc_node qns_pcie = {
 	.name = "qns_pcie",
-	.id = QCS8300_SLAVE_GEM_NOC_PCIE_CNOC,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { QCS8300_MASTER_GEM_NOC_PCIE_SNOC },
+	.link_nodes = { &qnm_gemnoc_pcie },
 };
 
 static struct qcom_icc_node srvc_even_gemnoc = {
 	.name = "srvc_even_gemnoc",
-	.id = QCS8300_SLAVE_SERVICE_GEM_NOC_1,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node srvc_odd_gemnoc = {
 	.name = "srvc_odd_gemnoc",
-	.id = QCS8300_SLAVE_SERVICE_GEM_NOC_2,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node srvc_sys_gemnoc = {
 	.name = "srvc_sys_gemnoc",
-	.id = QCS8300_SLAVE_SERVICE_GEM_NOC,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node srvc_sys_gemnoc_2 = {
 	.name = "srvc_sys_gemnoc_2",
-	.id = QCS8300_SLAVE_SERVICE_GEM_NOC2,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qns_gp_dsp_sail_noc = {
 	.name = "qns_gp_dsp_sail_noc",
-	.id = QCS8300_SLAVE_GP_DSP_SAIL_NOC,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { QCS8300_MASTER_GPDSP_SAIL },
+	.link_nodes = { &qnm_gpdsp_sail },
 };
 
 static struct qcom_icc_node qhs_lpass_core = {
 	.name = "qhs_lpass_core",
-	.id = QCS8300_SLAVE_LPASS_CORE_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_lpass_lpi = {
 	.name = "qhs_lpass_lpi",
-	.id = QCS8300_SLAVE_LPASS_LPI_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_lpass_mpu = {
 	.name = "qhs_lpass_mpu",
-	.id = QCS8300_SLAVE_LPASS_MPU_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_lpass_top = {
 	.name = "qhs_lpass_top",
-	.id = QCS8300_SLAVE_LPASS_TOP_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qns_sysnoc = {
 	.name = "qns_sysnoc",
-	.id = QCS8300_SLAVE_LPASS_SNOC,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { QCS8300_MASTER_LPASS_ANOC },
+	.link_nodes = { &qnm_lpass_noc },
 };
 
 static struct qcom_icc_node srvc_niu_aml_noc = {
 	.name = "srvc_niu_aml_noc",
-	.id = QCS8300_SLAVE_SERVICES_LPASS_AML_NOC,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node srvc_niu_lpass_agnoc = {
 	.name = "srvc_niu_lpass_agnoc",
-	.id = QCS8300_SLAVE_SERVICE_LPASS_AG_NOC,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node ebi = {
 	.name = "ebi",
-	.id = QCS8300_SLAVE_EBI1,
 	.channels = 8,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qns_mem_noc_hf = {
 	.name = "qns_mem_noc_hf",
-	.id = QCS8300_SLAVE_MNOC_HF_MEM_NOC,
 	.channels = 2,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { QCS8300_MASTER_MNOC_HF_MEM_NOC },
+	.link_nodes = { &qnm_mnoc_hf },
 };
 
 static struct qcom_icc_node qns_mem_noc_sf = {
 	.name = "qns_mem_noc_sf",
-	.id = QCS8300_SLAVE_MNOC_SF_MEM_NOC,
 	.channels = 2,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { QCS8300_MASTER_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qnm_mnoc_sf },
 };
 
 static struct qcom_icc_node srvc_mnoc_hf = {
 	.name = "srvc_mnoc_hf",
-	.id = QCS8300_SLAVE_SERVICE_MNOC_HF,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node srvc_mnoc_sf = {
 	.name = "srvc_mnoc_sf",
-	.id = QCS8300_SLAVE_SERVICE_MNOC_SF,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qns_hcp = {
 	.name = "qns_hcp",
-	.id = QCS8300_SLAVE_HCP_A,
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qns_nsp_gemnoc = {
 	.name = "qns_nsp_gemnoc",
-	.id = QCS8300_SLAVE_CDSP_MEM_NOC,
 	.channels = 2,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { QCS8300_MASTER_COMPUTE_NOC },
+	.link_nodes = { &qnm_cmpnoc0 },
 };
 
 static struct qcom_icc_node service_nsp_noc = {
 	.name = "service_nsp_noc",
-	.id = QCS8300_SLAVE_SERVICE_NSP_NOC,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qns_pcie_mem_noc = {
 	.name = "qns_pcie_mem_noc",
-	.id = QCS8300_SLAVE_ANOC_PCIE_GEM_NOC,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { QCS8300_MASTER_ANOC_PCIE_GEM_NOC },
+	.link_nodes = { &qnm_pcie },
 };
 
 static struct qcom_icc_node qns_gemnoc_gc = {
 	.name = "qns_gemnoc_gc",
-	.id = QCS8300_SLAVE_SNOC_GEM_NOC_GC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { QCS8300_MASTER_SNOC_GC_MEM_NOC },
+	.link_nodes = { &qnm_snoc_gc },
 };
 
 static struct qcom_icc_node qns_gemnoc_sf = {
 	.name = "qns_gemnoc_sf",
-	.id = QCS8300_SLAVE_SNOC_GEM_NOC_SF,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { QCS8300_MASTER_SNOC_SF_MEM_NOC },
+	.link_nodes = { &qnm_snoc_sf },
 };
 
 static struct qcom_icc_node srvc_snoc = {
 	.name = "srvc_snoc",
-	.id = QCS8300_SLAVE_SERVICE_SNOC,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_bcm bcm_acv = {
@@ -1687,6 +1600,7 @@ static struct qcom_icc_node * const aggre1_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc qcs8300_aggre1_noc = {
+	.alloc_dyn_id = true,
 	.nodes = aggre1_noc_nodes,
 	.num_nodes = ARRAY_SIZE(aggre1_noc_nodes),
 	.bcms = aggre1_noc_bcms,
@@ -1712,6 +1626,7 @@ static struct qcom_icc_node * const aggre2_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc qcs8300_aggre2_noc = {
+	.alloc_dyn_id = true,
 	.nodes = aggre2_noc_nodes,
 	.num_nodes = ARRAY_SIZE(aggre2_noc_nodes),
 	.bcms = aggre2_noc_bcms,
@@ -1734,6 +1649,7 @@ static struct qcom_icc_node * const clk_virt_nodes[] = {
 };
 
 static const struct qcom_icc_desc qcs8300_clk_virt = {
+	.alloc_dyn_id = true,
 	.nodes = clk_virt_nodes,
 	.num_nodes = ARRAY_SIZE(clk_virt_nodes),
 	.bcms = clk_virt_bcms,
@@ -1828,6 +1744,7 @@ static struct qcom_icc_node * const config_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc qcs8300_config_noc = {
+	.alloc_dyn_id = true,
 	.nodes = config_noc_nodes,
 	.num_nodes = ARRAY_SIZE(config_noc_nodes),
 	.bcms = config_noc_bcms,
@@ -1841,6 +1758,7 @@ static struct qcom_icc_node * const dc_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc qcs8300_dc_noc = {
+	.alloc_dyn_id = true,
 	.nodes = dc_noc_nodes,
 	.num_nodes = ARRAY_SIZE(dc_noc_nodes),
 };
@@ -1874,6 +1792,7 @@ static struct qcom_icc_node * const gem_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc qcs8300_gem_noc = {
+	.alloc_dyn_id = true,
 	.nodes = gem_noc_nodes,
 	.num_nodes = ARRAY_SIZE(gem_noc_nodes),
 	.bcms = gem_noc_bcms,
@@ -1891,6 +1810,7 @@ static struct qcom_icc_node * const gpdsp_anoc_nodes[] = {
 };
 
 static const struct qcom_icc_desc qcs8300_gpdsp_anoc = {
+	.alloc_dyn_id = true,
 	.nodes = gpdsp_anoc_nodes,
 	.num_nodes = ARRAY_SIZE(gpdsp_anoc_nodes),
 	.bcms = gpdsp_anoc_bcms,
@@ -1914,6 +1834,7 @@ static struct qcom_icc_node * const lpass_ag_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc qcs8300_lpass_ag_noc = {
+	.alloc_dyn_id = true,
 	.nodes = lpass_ag_noc_nodes,
 	.num_nodes = ARRAY_SIZE(lpass_ag_noc_nodes),
 	.bcms = lpass_ag_noc_bcms,
@@ -1931,6 +1852,7 @@ static struct qcom_icc_node * const mc_virt_nodes[] = {
 };
 
 static const struct qcom_icc_desc qcs8300_mc_virt = {
+	.alloc_dyn_id = true,
 	.nodes = mc_virt_nodes,
 	.num_nodes = ARRAY_SIZE(mc_virt_nodes),
 	.bcms = mc_virt_bcms,
@@ -1960,6 +1882,7 @@ static struct qcom_icc_node * const mmss_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc qcs8300_mmss_noc = {
+	.alloc_dyn_id = true,
 	.nodes = mmss_noc_nodes,
 	.num_nodes = ARRAY_SIZE(mmss_noc_nodes),
 	.bcms = mmss_noc_bcms,
@@ -1980,6 +1903,7 @@ static struct qcom_icc_node * const nspa_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc qcs8300_nspa_noc = {
+	.alloc_dyn_id = true,
 	.nodes = nspa_noc_nodes,
 	.num_nodes = ARRAY_SIZE(nspa_noc_nodes),
 	.bcms = nspa_noc_bcms,
@@ -1997,6 +1921,7 @@ static struct qcom_icc_node * const pcie_anoc_nodes[] = {
 };
 
 static const struct qcom_icc_desc qcs8300_pcie_anoc = {
+	.alloc_dyn_id = true,
 	.nodes = pcie_anoc_nodes,
 	.num_nodes = ARRAY_SIZE(pcie_anoc_nodes),
 	.bcms = pcie_anoc_bcms,
@@ -2025,6 +1950,7 @@ static struct qcom_icc_node * const system_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc qcs8300_system_noc = {
+	.alloc_dyn_id = true,
 	.nodes = system_noc_nodes,
 	.num_nodes = ARRAY_SIZE(system_noc_nodes),
 	.bcms = system_noc_bcms,
diff --git a/drivers/interconnect/qcom/qcs8300.h b/drivers/interconnect/qcom/qcs8300.h
deleted file mode 100644
index 6b9e2b424c2ad0401f72d5fb8cfb7e0f48a1db85..0000000000000000000000000000000000000000
--- a/drivers/interconnect/qcom/qcs8300.h
+++ /dev/null
@@ -1,177 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights reserved.
- */
-
-#ifndef __DRIVERS_INTERCONNECT_QCOM_QCS8300_H
-#define __DRIVERS_INTERCONNECT_QCOM_QCS8300_H
-
-#define QCS8300_MASTER_GPU_TCU				0
-#define QCS8300_MASTER_PCIE_TCU				1
-#define QCS8300_MASTER_SYS_TCU				2
-#define QCS8300_MASTER_APPSS_PROC			3
-#define QCS8300_MASTER_LLCC				4
-#define QCS8300_MASTER_CNOC_LPASS_AG_NOC		5
-#define QCS8300_MASTER_GIC_AHB				6
-#define QCS8300_MASTER_CDSP_NOC_CFG			7
-#define QCS8300_MASTER_QDSS_BAM				8
-#define QCS8300_MASTER_QUP_0				9
-#define QCS8300_MASTER_QUP_1				10
-#define QCS8300_MASTER_A1NOC_SNOC			11
-#define QCS8300_MASTER_A2NOC_SNOC			12
-#define QCS8300_MASTER_CAMNOC_HF			13
-#define QCS8300_MASTER_CAMNOC_ICP			14
-#define QCS8300_MASTER_CAMNOC_SF			15
-#define QCS8300_MASTER_COMPUTE_NOC			16
-#define QCS8300_MASTER_CNOC_A2NOC			17
-#define QCS8300_MASTER_CNOC_DC_NOC			18
-#define QCS8300_MASTER_GEM_NOC_CFG			19
-#define QCS8300_MASTER_GEM_NOC_CNOC			20
-#define QCS8300_MASTER_GEM_NOC_PCIE_SNOC		21
-#define QCS8300_MASTER_GPDSP_SAIL			22
-#define QCS8300_MASTER_GFX3D				23
-#define QCS8300_MASTER_LPASS_ANOC			24
-#define QCS8300_MASTER_MDP0				25
-#define QCS8300_MASTER_MDP1				26
-#define QCS8300_MASTER_MNOC_HF_MEM_NOC			27
-#define QCS8300_MASTER_CNOC_MNOC_HF_CFG			28
-#define QCS8300_MASTER_MNOC_SF_MEM_NOC			29
-#define QCS8300_MASTER_CNOC_MNOC_SF_CFG			30
-#define QCS8300_MASTER_ANOC_PCIE_GEM_NOC		31
-#define QCS8300_MASTER_SAILSS_MD0			32
-#define QCS8300_MASTER_SNOC_CFG				33
-#define QCS8300_MASTER_SNOC_GC_MEM_NOC			34
-#define QCS8300_MASTER_SNOC_SF_MEM_NOC			35
-#define QCS8300_MASTER_VIDEO_P0				36
-#define QCS8300_MASTER_VIDEO_PROC			37
-#define QCS8300_MASTER_VIDEO_V_PROC			38
-#define QCS8300_MASTER_QUP_CORE_0			39
-#define QCS8300_MASTER_QUP_CORE_1			40
-#define QCS8300_MASTER_QUP_CORE_3			41
-#define QCS8300_MASTER_CRYPTO_CORE0			42
-#define QCS8300_MASTER_CRYPTO_CORE1			43
-#define QCS8300_MASTER_DSP0				44
-#define QCS8300_MASTER_IPA				45
-#define QCS8300_MASTER_LPASS_PROC			46
-#define QCS8300_MASTER_CDSP_PROC			47
-#define QCS8300_MASTER_PIMEM				48
-#define QCS8300_MASTER_QUP_3				49
-#define QCS8300_MASTER_EMAC				50
-#define QCS8300_MASTER_GIC				51
-#define QCS8300_MASTER_PCIE_0				52
-#define QCS8300_MASTER_PCIE_1				53
-#define QCS8300_MASTER_QDSS_ETR_0			54
-#define QCS8300_MASTER_QDSS_ETR_1			55
-#define QCS8300_MASTER_SDC				56
-#define QCS8300_MASTER_UFS_MEM				57
-#define QCS8300_MASTER_USB2				58
-#define QCS8300_MASTER_USB3_0				59
-#define QCS8300_SLAVE_EBI1				60
-#define QCS8300_SLAVE_AHB2PHY_2				61
-#define QCS8300_SLAVE_AHB2PHY_3				62
-#define QCS8300_SLAVE_ANOC_THROTTLE_CFG			63
-#define QCS8300_SLAVE_AOSS				64
-#define QCS8300_SLAVE_APPSS				65
-#define QCS8300_SLAVE_BOOT_ROM				66
-#define QCS8300_SLAVE_CAMERA_CFG			67
-#define QCS8300_SLAVE_CAMERA_NRT_THROTTLE_CFG		68
-#define QCS8300_SLAVE_CAMERA_RT_THROTTLE_CFG		69
-#define QCS8300_SLAVE_CLK_CTL				70
-#define QCS8300_SLAVE_CDSP_CFG				71
-#define QCS8300_SLAVE_RBCPR_CX_CFG			72
-#define QCS8300_SLAVE_RBCPR_MMCX_CFG			73
-#define QCS8300_SLAVE_RBCPR_MX_CFG			74
-#define QCS8300_SLAVE_CPR_NSPCX				75
-#define QCS8300_SLAVE_CPR_NSPHMX			76
-#define QCS8300_SLAVE_CRYPTO_0_CFG			77
-#define QCS8300_SLAVE_CX_RDPM				78
-#define QCS8300_SLAVE_DISPLAY_CFG			79
-#define QCS8300_SLAVE_DISPLAY_RT_THROTTLE_CFG		80
-#define QCS8300_SLAVE_EMAC_CFG				81
-#define QCS8300_SLAVE_GP_DSP0_CFG			82
-#define QCS8300_SLAVE_GPDSP0_THROTTLE_CFG		83
-#define QCS8300_SLAVE_GPU_TCU_THROTTLE_CFG		84
-#define QCS8300_SLAVE_GFX3D_CFG				85
-#define QCS8300_SLAVE_HWKM				86
-#define QCS8300_SLAVE_IMEM_CFG				87
-#define QCS8300_SLAVE_IPA_CFG				88
-#define QCS8300_SLAVE_IPC_ROUTER_CFG			89
-#define QCS8300_SLAVE_LLCC_CFG				90
-#define QCS8300_SLAVE_LPASS				91
-#define QCS8300_SLAVE_LPASS_CORE_CFG			92
-#define QCS8300_SLAVE_LPASS_LPI_CFG			93
-#define QCS8300_SLAVE_LPASS_MPU_CFG			94
-#define QCS8300_SLAVE_LPASS_THROTTLE_CFG		95
-#define QCS8300_SLAVE_LPASS_TOP_CFG			96
-#define QCS8300_SLAVE_MX_RDPM				97
-#define QCS8300_SLAVE_MXC_RDPM				98
-#define QCS8300_SLAVE_PCIE_0_CFG			99
-#define QCS8300_SLAVE_PCIE_1_CFG			100
-#define QCS8300_SLAVE_PCIE_TCU_THROTTLE_CFG		101
-#define QCS8300_SLAVE_PCIE_THROTTLE_CFG			102
-#define QCS8300_SLAVE_PDM				103
-#define QCS8300_SLAVE_PIMEM_CFG				104
-#define QCS8300_SLAVE_PKA_WRAPPER_CFG			105
-#define QCS8300_SLAVE_QDSS_CFG				106
-#define QCS8300_SLAVE_QM_CFG				107
-#define QCS8300_SLAVE_QM_MPU_CFG			108
-#define QCS8300_SLAVE_QUP_0				109
-#define QCS8300_SLAVE_QUP_1				110
-#define QCS8300_SLAVE_QUP_3				111
-#define QCS8300_SLAVE_SAIL_THROTTLE_CFG			112
-#define QCS8300_SLAVE_SDC1				113
-#define QCS8300_SLAVE_SECURITY				114
-#define QCS8300_SLAVE_SNOC_THROTTLE_CFG			115
-#define QCS8300_SLAVE_TCSR				116
-#define QCS8300_SLAVE_TLMM				117
-#define QCS8300_SLAVE_TSC_CFG				118
-#define QCS8300_SLAVE_UFS_MEM_CFG			119
-#define QCS8300_SLAVE_USB2				120
-#define QCS8300_SLAVE_USB3_0				121
-#define QCS8300_SLAVE_VENUS_CFG				122
-#define QCS8300_SLAVE_VENUS_CVP_THROTTLE_CFG		123
-#define QCS8300_SLAVE_VENUS_V_CPU_THROTTLE_CFG		124
-#define QCS8300_SLAVE_VENUS_VCODEC_THROTTLE_CFG		125
-#define QCS8300_SLAVE_A1NOC_SNOC			126
-#define QCS8300_SLAVE_A2NOC_SNOC			127
-#define QCS8300_SLAVE_DDRSS_CFG				128
-#define QCS8300_SLAVE_GEM_NOC_CNOC			129
-#define QCS8300_SLAVE_GEM_NOC_CFG			130
-#define QCS8300_SLAVE_SNOC_GEM_NOC_GC			131
-#define QCS8300_SLAVE_SNOC_GEM_NOC_SF			132
-#define QCS8300_SLAVE_GP_DSP_SAIL_NOC			133
-#define QCS8300_SLAVE_GPDSP_NOC_CFG			134
-#define QCS8300_SLAVE_HCP_A				135
-#define QCS8300_SLAVE_LLCC				136
-#define QCS8300_SLAVE_MNOC_HF_MEM_NOC			137
-#define QCS8300_SLAVE_MNOC_SF_MEM_NOC			138
-#define QCS8300_SLAVE_CNOC_MNOC_HF_CFG			139
-#define QCS8300_SLAVE_CNOC_MNOC_SF_CFG			140
-#define QCS8300_SLAVE_CDSP_MEM_NOC			141
-#define QCS8300_SLAVE_GEM_NOC_PCIE_CNOC			142
-#define QCS8300_SLAVE_PCIE_ANOC_CFG			143
-#define QCS8300_SLAVE_ANOC_PCIE_GEM_NOC			144
-#define QCS8300_SLAVE_SNOC_CFG				145
-#define QCS8300_SLAVE_LPASS_SNOC			146
-#define QCS8300_SLAVE_QUP_CORE_0			147
-#define QCS8300_SLAVE_QUP_CORE_1			148
-#define QCS8300_SLAVE_QUP_CORE_3			149
-#define QCS8300_SLAVE_BOOT_IMEM				150
-#define QCS8300_SLAVE_IMEM				151
-#define QCS8300_SLAVE_PIMEM				152
-#define QCS8300_SLAVE_SERVICE_NSP_NOC			153
-#define QCS8300_SLAVE_SERVICE_GEM_NOC_1			154
-#define QCS8300_SLAVE_SERVICE_MNOC_HF			155
-#define QCS8300_SLAVE_SERVICE_MNOC_SF			156
-#define QCS8300_SLAVE_SERVICES_LPASS_AML_NOC		157
-#define QCS8300_SLAVE_SERVICE_LPASS_AG_NOC		158
-#define QCS8300_SLAVE_SERVICE_GEM_NOC_2			159
-#define QCS8300_SLAVE_SERVICE_SNOC			160
-#define QCS8300_SLAVE_SERVICE_GEM_NOC			161
-#define QCS8300_SLAVE_SERVICE_GEM_NOC2			162
-#define QCS8300_SLAVE_PCIE_0				163
-#define QCS8300_SLAVE_PCIE_1				164
-#define QCS8300_SLAVE_QDSS_STM				165
-#define QCS8300_SLAVE_TCU				166
-
-#endif

-- 
2.47.3



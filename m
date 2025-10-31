Return-Path: <linux-pm+bounces-37215-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62190C25B6F
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 15:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C58A1B24A21
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 14:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E362C1587;
	Fri, 31 Oct 2025 14:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PQRz/43v";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="W0byhzD7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3A029C338
	for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2025 14:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761921970; cv=none; b=dUnQoRDecz2GiRdnwOChkZ606OvAb6jhMW60uc2KS/lDw6M2a19BIZ7sVg/QvkoYSHxDMIB0yDnVUO4tVJakbhVYlulVelZY+lf0EzaB6stTa2BmHE1eoUpL1XY2cAGR8M8p4iT3xCoNIUH6dmxjkZQ0XAD1W2AMGVH7T5QKjkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761921970; c=relaxed/simple;
	bh=VzvWQjsnoixPD84YQ0P4IR46CzAE3btH/40kV6J27aI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mq2B8uPViXz47u5qLbJNEh02MV5CI3UupBMedXG/T35DGFN7CdiOpQPwJ1dbtkiaJTkNonEX+akF/tEyViI8CW8zfhgF0qMvhjOtAoGBNuU7tuv5GeNYjYBtdefbT8fwGjKtyhY2u5JyMF4AxYQu2o8MJD3UDE/8wF25q/wlEzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PQRz/43v; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=W0byhzD7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59VBo2xn102648
	for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2025 14:45:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cma7rs/s1mwwsGWfLdGqPIs3a2SH4v8FsDv6o7iYfbg=; b=PQRz/43vDD0+IvLX
	fFiZHJsFi2DsYNqZf/vrCc3McxstN/KTW2oz8zUyWMIk+49r8zaAh83jG+Jtc1ag
	u/UVvhFHsjW6W7o66ljloyr6jum36KD4pLjSdxKBJs1Vr5VreY18ZGkDLrubrBCC
	xYHaS6cwW/v/iCq92/hSrHe6tvyeSic72OJ4xwzeTfF4KLnHQmQTa1+abHiJkRYs
	Jx3qeKhIawvtetvAGKjfH4j0IFIqBKy0BIMj25U0q9j2w7Eu7nqG1mVdsS8zu49/
	G7Ef0xNpih+J5khPukyrxduJr1cu0M3q3ZtdkwddcF44BR9iknD8N7AzEqlga+yJ
	57X+pw==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a4ahdkg0f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2025 14:45:57 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-5d4123439bfso4055498137.1
        for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2025 07:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761921957; x=1762526757; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cma7rs/s1mwwsGWfLdGqPIs3a2SH4v8FsDv6o7iYfbg=;
        b=W0byhzD7QMMKe06SfnMyrAi7M0RFM+gUw2MM8JyRq1ouSgsGTKfQK3yPL3t0N1/O/j
         4eFwzWcb23uS9Zxcx+86bpvDAHNyHtuSAUXO1edeUhAPyU8oW25kgR1/9V6Hii34WjsX
         aOrVEOQ516b14SFnDBpdR7m26Jx2fXAwuY8ihdV0Jhe/ARzf2rcvsOHhvINhPQzx8wJT
         /WLXP6mHD36IPPzuxosYGu3KQ+Mo+KXltIiLugn2NebCFmfuhIhf7PKL8ek9oSInZSz3
         5JaIFHIVPPVV0fmGhM69QjL1NDOvgXddEUPOKooW/iekX65J4A9XnXiDr9cBMHJ4+maa
         mHTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761921957; x=1762526757;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cma7rs/s1mwwsGWfLdGqPIs3a2SH4v8FsDv6o7iYfbg=;
        b=t8+nMX7s5RXbbab67p27d+8qkjgxp3H+Uxb1jdHUpiulskczH1XIcpppq8oT9IXCXO
         szSJIZ4tYDvW3dGLvc9OBGoYtCilOQKlCU1pNEzODqfkYzmlRTRnVZ2mlr6sMRUs8n/e
         VdXa/fAllioPzvDyww4DLvGvppdMHmNwCb+lsJCY3VAQDpcz18NFXoClR8qzWfiCD8IN
         0F47GtN4I64QiicHUUOqUsoOkrRz0OKNXtXpeig+hsg2ra/si1P9rXgtW+wP/tpQfTDb
         aMHTveuX0EFRQPUDX+f8IIU8GEOLjjAJAZqohmYeewhOEbHejHqF5rTXr5cDqr22nsB8
         TFKA==
X-Forwarded-Encrypted: i=1; AJvYcCWKZKtr+pjL2qfBFfWDYl90DX9W5WFDLb6AwW1ebUahnIHisYUloWk7mgP0Gl4qXwNMKwkIbS8gkg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz835wIh8R/PDPWrkwH+8L9BJ3Dvea7LG+IxAiluaQ6Sa5ZbF5d
	3ddweXZ+11Uhi8uiiICHDj30Npp0hlcww0MEXjNQ5opewXJHAM7G1Ydf1Z0aENOxLPfRmi2lVL8
	9yg46gskG82FfFDHsLCjWd9LoYwygYMRk80Ohi/Hda1PLHL0o9cGL1n0VlYMoKw==
X-Gm-Gg: ASbGncteAp41A8yhBUZkilk0B/1uanNsA7xuz6l8NY//qsDIdmROKIHBOEXhDCYcSLP
	j04DMAB0yYBqWmHBVzY4F1ZSZ5Z9Ik0a0iOQVXFCyHS7fZLp5M/kVs6wcMD6JwMUl7I+56FA0Uc
	ILSocWzstQHNAsxlaSILuSXALlU54Ojn5Yi5CnbJmgZrG6+vhcg7BOZWSHjlfeSqQgHhvjZZ/Ed
	pzCb8PPR18Qmk8A4mgxogPHSrSQQ/wGzXv7ifFYbWsfuf1OHjsqwJuMw2/iqelfRqyRNJJiidAD
	d/cfvO39trzok1OUePUKykofbnQeW5EpGyL9Bl37SVRjsROJ4ezoNMUZMJLrElHkkJTlHTSon+v
	SHH1wBXlRHsfchOiX4dE0+a2fAYqWFgp7O9MvbJRwZjb0ylUQB717Ch+Yj5jDBSnP55vMy9Xyvl
	ZsL2XyFJA9VeLS
X-Received: by 2002:a05:6102:2927:b0:5db:53a9:d524 with SMTP id ada2fe7eead31-5dbb133ccb6mr1173629137.35.1761921955687;
        Fri, 31 Oct 2025 07:45:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIiSHAI+knT5C52Yhfi/nCb3xfkHRGXAdSOKirP5Y/Qi+4RokYKlnc/x6qodzNa7kL/keHVw==
X-Received: by 2002:a05:6102:2927:b0:5db:53a9:d524 with SMTP id ada2fe7eead31-5dbb133ccb6mr1173596137.35.1761921955015;
        Fri, 31 Oct 2025 07:45:55 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5941f5bc218sm541405e87.93.2025.10.31.07.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 07:45:54 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 31 Oct 2025 16:45:33 +0200
Subject: [PATCH v3 17/25] interconnect: qcom: sm6350: convert to dynamic
 IDs
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-rework-icc-v3-17-0575304c9624@oss.qualcomm.com>
References: <20251031-rework-icc-v3-0-0575304c9624@oss.qualcomm.com>
In-Reply-To: <20251031-rework-icc-v3-0-0575304c9624@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=46070;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=VzvWQjsnoixPD84YQ0P4IR46CzAE3btH/40kV6J27aI=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpBMuGb3wuWkjskYJVME0/DQHPcwbGqLsxnV2mZ
 lGfZzS53amJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaQTLhgAKCRCLPIo+Aiko
 1eByB/9CgNfnn09EGKsXUndJ+5vulApMVHFUyuz0wsqLuVAXUyMoHNL9yN83nowUYQPGMMvxjlz
 M6kWkSN8dzBPU9nwu7MLZKd+paE1fDsNIC7wG74gkAeJ+pdElsIbReMT0W1euVXL9pYiKe1BsaA
 xmu2DsOmyYAkTU0grjFq6iKrMG/dtpsfma8/uThUsiXLdeD8mIQrWjvI4LX1efywLd+fEtRDymL
 RvIwvi0s9K3oCR8SCYXx/z6zcRs8w2r3p5d+UXkIBLbySTWx5qlMvFh0JN+DNvU/pc3P19burt2
 UIBZL5BVEIdGITYyb+9iM3Twj32A+hY9r3EbIlWp7J1w4c0v
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDEzMyBTYWx0ZWRfX1sgAMxGJr1eH
 A9s1su0Z4dr9RMzx0r2RvvAXbWA5vzWtWQ2Jf6zYBShPeX63vYaPvV59Mw+pzyabByFjC3+5hGy
 9F7OwtCg6dCS/Q1AyF/3sW0YHpVpZkGoWFBqxnStNfB3yhzNJ+DShA5B5vLgC9tNmNX+XF60s/Q
 +RNB0cGYHxAsxMD6lPN2ClhwrXTsL7leA3dEzfgeRwOJakLLR2n1PL+liV3CjrK0rln1I52nGW8
 ho8IEuLV4+AieVyJkmmqQHSQaSg8t1oKUwBuBhS02SJmu0+O6N1bXoCGfFZ4pLdV7wy96vSaUCq
 GVx13aMBJRedWgkAg7pKcxOidZSADoejc6c526IoP8cV1/v9JXBXy3gZ/e40UbPMLPr8pwiOFB6
 FJRq7bKRCRaZ5pUMowsw3IVvUUi9yQ==
X-Proofpoint-GUID: rKPhu4OhQDhFczjuA8nMGxM6VQMF5Y9z
X-Authority-Analysis: v=2.4 cv=TsnrRTXh c=1 sm=1 tr=0 ts=6904cba5 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=6H0WHjuAAAAA:8 a=INSRBlnYp9SWR3S25a0A:9 a=QEXdDO2ut3YA:10
 a=gYDTvv6II1OnSo0itH1n:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-ORIG-GUID: rKPhu4OhQDhFczjuA8nMGxM6VQMF5Y9z
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
 drivers/interconnect/qcom/sm6350.c | 639 ++++++++++++++++++-------------------
 drivers/interconnect/qcom/sm6350.h | 139 --------
 2 files changed, 317 insertions(+), 461 deletions(-)

diff --git a/drivers/interconnect/qcom/sm6350.c b/drivers/interconnect/qcom/sm6350.c
index f41d7e19ba269cba7cc07b0136a6d1fcccd8af4d..df2511dbfa96ba7454612ea0fcdf4a8f5fc39540 100644
--- a/drivers/interconnect/qcom/sm6350.c
+++ b/drivers/interconnect/qcom/sm6350.c
@@ -13,1151 +13,1136 @@
 
 #include "bcm-voter.h"
 #include "icc-rpmh.h"
-#include "sm6350.h"
+
+static struct qcom_icc_node qhm_a1noc_cfg;
+static struct qcom_icc_node qhm_qup_0;
+static struct qcom_icc_node xm_emmc;
+static struct qcom_icc_node xm_ufs_mem;
+static struct qcom_icc_node qhm_a2noc_cfg;
+static struct qcom_icc_node qhm_qdss_bam;
+static struct qcom_icc_node qhm_qup_1;
+static struct qcom_icc_node qxm_crypto;
+static struct qcom_icc_node qxm_ipa;
+static struct qcom_icc_node xm_qdss_etr;
+static struct qcom_icc_node xm_sdc2;
+static struct qcom_icc_node xm_usb3_0;
+static struct qcom_icc_node qxm_camnoc_hf0_uncomp;
+static struct qcom_icc_node qxm_camnoc_icp_uncomp;
+static struct qcom_icc_node qxm_camnoc_sf_uncomp;
+static struct qcom_icc_node qup0_core_master;
+static struct qcom_icc_node qup1_core_master;
+static struct qcom_icc_node qnm_npu;
+static struct qcom_icc_node qxm_npu_dsp;
+static struct qcom_icc_node qnm_snoc;
+static struct qcom_icc_node xm_qdss_dap;
+static struct qcom_icc_node qhm_cnoc_dc_noc;
+static struct qcom_icc_node acm_apps;
+static struct qcom_icc_node acm_sys_tcu;
+static struct qcom_icc_node qhm_gemnoc_cfg;
+static struct qcom_icc_node qnm_cmpnoc;
+static struct qcom_icc_node qnm_mnoc_hf;
+static struct qcom_icc_node qnm_mnoc_sf;
+static struct qcom_icc_node qnm_snoc_gc;
+static struct qcom_icc_node qnm_snoc_sf;
+static struct qcom_icc_node qxm_gpu;
+static struct qcom_icc_node llcc_mc;
+static struct qcom_icc_node qhm_mnoc_cfg;
+static struct qcom_icc_node qnm_video0;
+static struct qcom_icc_node qnm_video_cvp;
+static struct qcom_icc_node qxm_camnoc_hf;
+static struct qcom_icc_node qxm_camnoc_icp;
+static struct qcom_icc_node qxm_camnoc_sf;
+static struct qcom_icc_node qxm_mdp0;
+static struct qcom_icc_node amm_npu_sys;
+static struct qcom_icc_node qhm_npu_cfg;
+static struct qcom_icc_node qhm_snoc_cfg;
+static struct qcom_icc_node qnm_aggre1_noc;
+static struct qcom_icc_node qnm_aggre2_noc;
+static struct qcom_icc_node qnm_gemnoc;
+static struct qcom_icc_node qxm_pimem;
+static struct qcom_icc_node xm_gic;
+static struct qcom_icc_node qns_a1noc_snoc;
+static struct qcom_icc_node srvc_aggre1_noc;
+static struct qcom_icc_node qns_a2noc_snoc;
+static struct qcom_icc_node srvc_aggre2_noc;
+static struct qcom_icc_node qns_camnoc_uncomp;
+static struct qcom_icc_node qup0_core_slave;
+static struct qcom_icc_node qup1_core_slave;
+static struct qcom_icc_node qns_cdsp_gemnoc;
+static struct qcom_icc_node qhs_a1_noc_cfg;
+static struct qcom_icc_node qhs_a2_noc_cfg;
+static struct qcom_icc_node qhs_ahb2phy0;
+static struct qcom_icc_node qhs_ahb2phy2;
+static struct qcom_icc_node qhs_aoss;
+static struct qcom_icc_node qhs_boot_rom;
+static struct qcom_icc_node qhs_camera_cfg;
+static struct qcom_icc_node qhs_camera_nrt_thrott_cfg;
+static struct qcom_icc_node qhs_camera_rt_throttle_cfg;
+static struct qcom_icc_node qhs_clk_ctl;
+static struct qcom_icc_node qhs_cpr_cx;
+static struct qcom_icc_node qhs_cpr_mx;
+static struct qcom_icc_node qhs_crypto0_cfg;
+static struct qcom_icc_node qhs_dcc_cfg;
+static struct qcom_icc_node qhs_ddrss_cfg;
+static struct qcom_icc_node qhs_display_cfg;
+static struct qcom_icc_node qhs_display_throttle_cfg;
+static struct qcom_icc_node qhs_emmc_cfg;
+static struct qcom_icc_node qhs_glm;
+static struct qcom_icc_node qhs_gpuss_cfg;
+static struct qcom_icc_node qhs_imem_cfg;
+static struct qcom_icc_node qhs_ipa;
+static struct qcom_icc_node qhs_mnoc_cfg;
+static struct qcom_icc_node qhs_mss_cfg;
+static struct qcom_icc_node qhs_npu_cfg;
+static struct qcom_icc_node qhs_pdm;
+static struct qcom_icc_node qhs_pimem_cfg;
+static struct qcom_icc_node qhs_prng;
+static struct qcom_icc_node qhs_qdss_cfg;
+static struct qcom_icc_node qhs_qm_cfg;
+static struct qcom_icc_node qhs_qm_mpu_cfg;
+static struct qcom_icc_node qhs_qup0;
+static struct qcom_icc_node qhs_qup1;
+static struct qcom_icc_node qhs_sdc2;
+static struct qcom_icc_node qhs_security;
+static struct qcom_icc_node qhs_snoc_cfg;
+static struct qcom_icc_node qhs_tcsr;
+static struct qcom_icc_node qhs_ufs_mem_cfg;
+static struct qcom_icc_node qhs_usb3_0;
+static struct qcom_icc_node qhs_venus_cfg;
+static struct qcom_icc_node qhs_venus_throttle_cfg;
+static struct qcom_icc_node qhs_vsense_ctrl_cfg;
+static struct qcom_icc_node srvc_cnoc;
+static struct qcom_icc_node qhs_gemnoc;
+static struct qcom_icc_node qhs_llcc;
+static struct qcom_icc_node qhs_mcdma_ms_mpu_cfg;
+static struct qcom_icc_node qhs_mdsp_ms_mpu_cfg;
+static struct qcom_icc_node qns_gem_noc_snoc;
+static struct qcom_icc_node qns_llcc;
+static struct qcom_icc_node srvc_gemnoc;
+static struct qcom_icc_node ebi;
+static struct qcom_icc_node qns_mem_noc_hf;
+static struct qcom_icc_node qns_mem_noc_sf;
+static struct qcom_icc_node srvc_mnoc;
+static struct qcom_icc_node qhs_cal_dp0;
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
+static struct qcom_icc_node xs_qdss_stm;
+static struct qcom_icc_node xs_sys_tcu_cfg;
 
 static struct qcom_icc_node qhm_a1noc_cfg = {
 	.name = "qhm_a1noc_cfg",
-	.id = SM6350_MASTER_A1NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SM6350_SLAVE_SERVICE_A1NOC },
+	.link_nodes = { &srvc_aggre1_noc },
 };
 
 static struct qcom_icc_node qhm_qup_0 = {
 	.name = "qhm_qup_0",
-	.id = SM6350_MASTER_QUP_0,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SM6350_A1NOC_SNOC_SLV },
+	.link_nodes = { &qns_a1noc_snoc },
 };
 
 static struct qcom_icc_node xm_emmc = {
 	.name = "xm_emmc",
-	.id = SM6350_MASTER_EMMC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SM6350_A1NOC_SNOC_SLV },
+	.link_nodes = { &qns_a1noc_snoc },
 };
 
 static struct qcom_icc_node xm_ufs_mem = {
 	.name = "xm_ufs_mem",
-	.id = SM6350_MASTER_UFS_MEM,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SM6350_A1NOC_SNOC_SLV },
+	.link_nodes = { &qns_a1noc_snoc },
 };
 
 static struct qcom_icc_node qhm_a2noc_cfg = {
 	.name = "qhm_a2noc_cfg",
-	.id = SM6350_MASTER_A2NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SM6350_SLAVE_SERVICE_A2NOC },
+	.link_nodes = { &srvc_aggre2_noc },
 };
 
 static struct qcom_icc_node qhm_qdss_bam = {
 	.name = "qhm_qdss_bam",
-	.id = SM6350_MASTER_QDSS_BAM,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SM6350_A2NOC_SNOC_SLV },
+	.link_nodes = { &qns_a2noc_snoc },
 };
 
 static struct qcom_icc_node qhm_qup_1 = {
 	.name = "qhm_qup_1",
-	.id = SM6350_MASTER_QUP_1,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SM6350_A2NOC_SNOC_SLV },
+	.link_nodes = { &qns_a2noc_snoc },
 };
 
 static struct qcom_icc_node qxm_crypto = {
 	.name = "qxm_crypto",
-	.id = SM6350_MASTER_CRYPTO_CORE_0,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SM6350_A2NOC_SNOC_SLV },
+	.link_nodes = { &qns_a2noc_snoc },
 };
 
 static struct qcom_icc_node qxm_ipa = {
 	.name = "qxm_ipa",
-	.id = SM6350_MASTER_IPA,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SM6350_A2NOC_SNOC_SLV },
+	.link_nodes = { &qns_a2noc_snoc },
 };
 
 static struct qcom_icc_node xm_qdss_etr = {
 	.name = "xm_qdss_etr",
-	.id = SM6350_MASTER_QDSS_ETR,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SM6350_A2NOC_SNOC_SLV },
+	.link_nodes = { &qns_a2noc_snoc },
 };
 
 static struct qcom_icc_node xm_sdc2 = {
 	.name = "xm_sdc2",
-	.id = SM6350_MASTER_SDCC_2,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SM6350_A2NOC_SNOC_SLV },
+	.link_nodes = { &qns_a2noc_snoc },
 };
 
 static struct qcom_icc_node xm_usb3_0 = {
 	.name = "xm_usb3_0",
-	.id = SM6350_MASTER_USB3,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SM6350_A2NOC_SNOC_SLV },
+	.link_nodes = { &qns_a2noc_snoc },
 };
 
 static struct qcom_icc_node qxm_camnoc_hf0_uncomp = {
 	.name = "qxm_camnoc_hf0_uncomp",
-	.id = SM6350_MASTER_CAMNOC_HF0_UNCOMP,
 	.channels = 2,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SM6350_SLAVE_CAMNOC_UNCOMP },
+	.link_nodes = { &qns_camnoc_uncomp },
 };
 
 static struct qcom_icc_node qxm_camnoc_icp_uncomp = {
 	.name = "qxm_camnoc_icp_uncomp",
-	.id = SM6350_MASTER_CAMNOC_ICP_UNCOMP,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SM6350_SLAVE_CAMNOC_UNCOMP },
+	.link_nodes = { &qns_camnoc_uncomp },
 };
 
 static struct qcom_icc_node qxm_camnoc_sf_uncomp = {
 	.name = "qxm_camnoc_sf_uncomp",
-	.id = SM6350_MASTER_CAMNOC_SF_UNCOMP,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SM6350_SLAVE_CAMNOC_UNCOMP },
+	.link_nodes = { &qns_camnoc_uncomp },
 };
 
 static struct qcom_icc_node qup0_core_master = {
 	.name = "qup0_core_master",
-	.id = SM6350_MASTER_QUP_CORE_0,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SM6350_SLAVE_QUP_CORE_0 },
+	.link_nodes = { &qup0_core_slave },
 };
 
 static struct qcom_icc_node qup1_core_master = {
 	.name = "qup1_core_master",
-	.id = SM6350_MASTER_QUP_CORE_1,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SM6350_SLAVE_QUP_CORE_1 },
+	.link_nodes = { &qup1_core_slave },
 };
 
 static struct qcom_icc_node qnm_npu = {
 	.name = "qnm_npu",
-	.id = SM6350_MASTER_NPU,
 	.channels = 2,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SM6350_SLAVE_CDSP_GEM_NOC },
+	.link_nodes = { &qns_cdsp_gemnoc },
 };
 
 static struct qcom_icc_node qxm_npu_dsp = {
 	.name = "qxm_npu_dsp",
-	.id = SM6350_MASTER_NPU_PROC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SM6350_SLAVE_CDSP_GEM_NOC },
+	.link_nodes = { &qns_cdsp_gemnoc },
 };
 
 static struct qcom_icc_node qnm_snoc = {
 	.name = "qnm_snoc",
-	.id = SM6350_SNOC_CNOC_MAS,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 42,
-	.links = { SM6350_SLAVE_CAMERA_CFG,
-		   SM6350_SLAVE_SDCC_2,
-		   SM6350_SLAVE_CNOC_MNOC_CFG,
-		   SM6350_SLAVE_UFS_MEM_CFG,
-		   SM6350_SLAVE_QM_CFG,
-		   SM6350_SLAVE_SNOC_CFG,
-		   SM6350_SLAVE_QM_MPU_CFG,
-		   SM6350_SLAVE_GLM,
-		   SM6350_SLAVE_PDM,
-		   SM6350_SLAVE_CAMERA_NRT_THROTTLE_CFG,
-		   SM6350_SLAVE_A2NOC_CFG,
-		   SM6350_SLAVE_QDSS_CFG,
-		   SM6350_SLAVE_VSENSE_CTRL_CFG,
-		   SM6350_SLAVE_CAMERA_RT_THROTTLE_CFG,
-		   SM6350_SLAVE_DISPLAY_CFG,
-		   SM6350_SLAVE_TCSR,
-		   SM6350_SLAVE_DCC_CFG,
-		   SM6350_SLAVE_CNOC_DDRSS,
-		   SM6350_SLAVE_DISPLAY_THROTTLE_CFG,
-		   SM6350_SLAVE_NPU_CFG,
-		   SM6350_SLAVE_AHB2PHY,
-		   SM6350_SLAVE_GRAPHICS_3D_CFG,
-		   SM6350_SLAVE_BOOT_ROM,
-		   SM6350_SLAVE_VENUS_CFG,
-		   SM6350_SLAVE_IPA_CFG,
-		   SM6350_SLAVE_SECURITY,
-		   SM6350_SLAVE_IMEM_CFG,
-		   SM6350_SLAVE_CNOC_MSS,
-		   SM6350_SLAVE_SERVICE_CNOC,
-		   SM6350_SLAVE_USB3,
-		   SM6350_SLAVE_VENUS_THROTTLE_CFG,
-		   SM6350_SLAVE_RBCPR_CX_CFG,
-		   SM6350_SLAVE_A1NOC_CFG,
-		   SM6350_SLAVE_AOSS,
-		   SM6350_SLAVE_PRNG,
-		   SM6350_SLAVE_EMMC_CFG,
-		   SM6350_SLAVE_CRYPTO_0_CFG,
-		   SM6350_SLAVE_PIMEM_CFG,
-		   SM6350_SLAVE_RBCPR_MX_CFG,
-		   SM6350_SLAVE_QUP_0,
-		   SM6350_SLAVE_QUP_1,
-		   SM6350_SLAVE_CLK_CTL
-	},
+	.link_nodes = { &qhs_camera_cfg,
+			&qhs_sdc2,
+			&qhs_mnoc_cfg,
+			&qhs_ufs_mem_cfg,
+			&qhs_qm_cfg,
+			&qhs_snoc_cfg,
+			&qhs_qm_mpu_cfg,
+			&qhs_glm,
+			&qhs_pdm,
+			&qhs_camera_nrt_thrott_cfg,
+			&qhs_a2_noc_cfg,
+			&qhs_qdss_cfg,
+			&qhs_vsense_ctrl_cfg,
+			&qhs_camera_rt_throttle_cfg,
+			&qhs_display_cfg,
+			&qhs_tcsr,
+			&qhs_dcc_cfg,
+			&qhs_ddrss_cfg,
+			&qhs_display_throttle_cfg,
+			&qhs_npu_cfg,
+			&qhs_ahb2phy0,
+			&qhs_gpuss_cfg,
+			&qhs_boot_rom,
+			&qhs_venus_cfg,
+			&qhs_ipa,
+			&qhs_security,
+			&qhs_imem_cfg,
+			&qhs_mss_cfg,
+			&srvc_cnoc,
+			&qhs_usb3_0,
+			&qhs_venus_throttle_cfg,
+			&qhs_cpr_cx,
+			&qhs_a1_noc_cfg,
+			&qhs_aoss,
+			&qhs_prng,
+			&qhs_emmc_cfg,
+			&qhs_crypto0_cfg,
+			&qhs_pimem_cfg,
+			&qhs_cpr_mx,
+			&qhs_qup0,
+			&qhs_qup1,
+			&qhs_clk_ctl },
 };
 
 static struct qcom_icc_node xm_qdss_dap = {
 	.name = "xm_qdss_dap",
-	.id = SM6350_MASTER_QDSS_DAP,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 42,
-	.links = { SM6350_SLAVE_CAMERA_CFG,
-		   SM6350_SLAVE_SDCC_2,
-		   SM6350_SLAVE_CNOC_MNOC_CFG,
-		   SM6350_SLAVE_UFS_MEM_CFG,
-		   SM6350_SLAVE_QM_CFG,
-		   SM6350_SLAVE_SNOC_CFG,
-		   SM6350_SLAVE_QM_MPU_CFG,
-		   SM6350_SLAVE_GLM,
-		   SM6350_SLAVE_PDM,
-		   SM6350_SLAVE_CAMERA_NRT_THROTTLE_CFG,
-		   SM6350_SLAVE_A2NOC_CFG,
-		   SM6350_SLAVE_QDSS_CFG,
-		   SM6350_SLAVE_VSENSE_CTRL_CFG,
-		   SM6350_SLAVE_CAMERA_RT_THROTTLE_CFG,
-		   SM6350_SLAVE_DISPLAY_CFG,
-		   SM6350_SLAVE_TCSR,
-		   SM6350_SLAVE_DCC_CFG,
-		   SM6350_SLAVE_CNOC_DDRSS,
-		   SM6350_SLAVE_DISPLAY_THROTTLE_CFG,
-		   SM6350_SLAVE_NPU_CFG,
-		   SM6350_SLAVE_AHB2PHY,
-		   SM6350_SLAVE_GRAPHICS_3D_CFG,
-		   SM6350_SLAVE_BOOT_ROM,
-		   SM6350_SLAVE_VENUS_CFG,
-		   SM6350_SLAVE_IPA_CFG,
-		   SM6350_SLAVE_SECURITY,
-		   SM6350_SLAVE_IMEM_CFG,
-		   SM6350_SLAVE_CNOC_MSS,
-		   SM6350_SLAVE_SERVICE_CNOC,
-		   SM6350_SLAVE_USB3,
-		   SM6350_SLAVE_VENUS_THROTTLE_CFG,
-		   SM6350_SLAVE_RBCPR_CX_CFG,
-		   SM6350_SLAVE_A1NOC_CFG,
-		   SM6350_SLAVE_AOSS,
-		   SM6350_SLAVE_PRNG,
-		   SM6350_SLAVE_EMMC_CFG,
-		   SM6350_SLAVE_CRYPTO_0_CFG,
-		   SM6350_SLAVE_PIMEM_CFG,
-		   SM6350_SLAVE_RBCPR_MX_CFG,
-		   SM6350_SLAVE_QUP_0,
-		   SM6350_SLAVE_QUP_1,
-		   SM6350_SLAVE_CLK_CTL
-	},
+	.link_nodes = { &qhs_camera_cfg,
+			&qhs_sdc2,
+			&qhs_mnoc_cfg,
+			&qhs_ufs_mem_cfg,
+			&qhs_qm_cfg,
+			&qhs_snoc_cfg,
+			&qhs_qm_mpu_cfg,
+			&qhs_glm,
+			&qhs_pdm,
+			&qhs_camera_nrt_thrott_cfg,
+			&qhs_a2_noc_cfg,
+			&qhs_qdss_cfg,
+			&qhs_vsense_ctrl_cfg,
+			&qhs_camera_rt_throttle_cfg,
+			&qhs_display_cfg,
+			&qhs_tcsr,
+			&qhs_dcc_cfg,
+			&qhs_ddrss_cfg,
+			&qhs_display_throttle_cfg,
+			&qhs_npu_cfg,
+			&qhs_ahb2phy0,
+			&qhs_gpuss_cfg,
+			&qhs_boot_rom,
+			&qhs_venus_cfg,
+			&qhs_ipa,
+			&qhs_security,
+			&qhs_imem_cfg,
+			&qhs_mss_cfg,
+			&srvc_cnoc,
+			&qhs_usb3_0,
+			&qhs_venus_throttle_cfg,
+			&qhs_cpr_cx,
+			&qhs_a1_noc_cfg,
+			&qhs_aoss,
+			&qhs_prng,
+			&qhs_emmc_cfg,
+			&qhs_crypto0_cfg,
+			&qhs_pimem_cfg,
+			&qhs_cpr_mx,
+			&qhs_qup0,
+			&qhs_qup1,
+			&qhs_clk_ctl },
 };
 
 static struct qcom_icc_node qhm_cnoc_dc_noc = {
 	.name = "qhm_cnoc_dc_noc",
-	.id = SM6350_MASTER_CNOC_DC_NOC,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 2,
-	.links = { SM6350_SLAVE_LLCC_CFG,
-		   SM6350_SLAVE_GEM_NOC_CFG
-	},
+	.link_nodes = { &qhs_llcc,
+			&qhs_gemnoc },
 };
 
 static struct qcom_icc_node acm_apps = {
 	.name = "acm_apps",
-	.id = SM6350_MASTER_AMPSS_M0,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 2,
-	.links = { SM6350_SLAVE_LLCC,
-		   SM6350_SLAVE_GEM_NOC_SNOC
-	},
+	.link_nodes = { &qns_llcc,
+			&qns_gem_noc_snoc },
 };
 
 static struct qcom_icc_node acm_sys_tcu = {
 	.name = "acm_sys_tcu",
-	.id = SM6350_MASTER_SYS_TCU,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 2,
-	.links = { SM6350_SLAVE_LLCC,
-		   SM6350_SLAVE_GEM_NOC_SNOC
-	},
+	.link_nodes = { &qns_llcc,
+			&qns_gem_noc_snoc },
 };
 
 static struct qcom_icc_node qhm_gemnoc_cfg = {
 	.name = "qhm_gemnoc_cfg",
-	.id = SM6350_MASTER_GEM_NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 3,
-	.links = { SM6350_SLAVE_MCDMA_MS_MPU_CFG,
-		   SM6350_SLAVE_SERVICE_GEM_NOC,
-		   SM6350_SLAVE_MSS_PROC_MS_MPU_CFG
-	},
+	.link_nodes = { &qhs_mcdma_ms_mpu_cfg,
+			&srvc_gemnoc,
+			&qhs_mdsp_ms_mpu_cfg },
 };
 
 static struct qcom_icc_node qnm_cmpnoc = {
 	.name = "qnm_cmpnoc",
-	.id = SM6350_MASTER_COMPUTE_NOC,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 2,
-	.links = { SM6350_SLAVE_LLCC,
-		   SM6350_SLAVE_GEM_NOC_SNOC
-	},
+	.link_nodes = { &qns_llcc,
+			&qns_gem_noc_snoc },
 };
 
 static struct qcom_icc_node qnm_mnoc_hf = {
 	.name = "qnm_mnoc_hf",
-	.id = SM6350_MASTER_MNOC_HF_MEM_NOC,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 2,
-	.links = { SM6350_SLAVE_LLCC,
-		   SM6350_SLAVE_GEM_NOC_SNOC
-	},
+	.link_nodes = { &qns_llcc,
+			&qns_gem_noc_snoc },
 };
 
 static struct qcom_icc_node qnm_mnoc_sf = {
 	.name = "qnm_mnoc_sf",
-	.id = SM6350_MASTER_MNOC_SF_MEM_NOC,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 2,
-	.links = { SM6350_SLAVE_LLCC,
-		   SM6350_SLAVE_GEM_NOC_SNOC
-	},
+	.link_nodes = { &qns_llcc,
+			&qns_gem_noc_snoc },
 };
 
 static struct qcom_icc_node qnm_snoc_gc = {
 	.name = "qnm_snoc_gc",
-	.id = SM6350_MASTER_SNOC_GC_MEM_NOC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SM6350_SLAVE_LLCC },
+	.link_nodes = { &qns_llcc },
 };
 
 static struct qcom_icc_node qnm_snoc_sf = {
 	.name = "qnm_snoc_sf",
-	.id = SM6350_MASTER_SNOC_SF_MEM_NOC,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { SM6350_SLAVE_LLCC },
+	.link_nodes = { &qns_llcc },
 };
 
 static struct qcom_icc_node qxm_gpu = {
 	.name = "qxm_gpu",
-	.id = SM6350_MASTER_GRAPHICS_3D,
 	.channels = 2,
 	.buswidth = 32,
 	.num_links = 2,
-	.links = { SM6350_SLAVE_LLCC,
-		   SM6350_SLAVE_GEM_NOC_SNOC
-	},
+	.link_nodes = { &qns_llcc,
+			&qns_gem_noc_snoc },
 };
 
 static struct qcom_icc_node llcc_mc = {
 	.name = "llcc_mc",
-	.id = SM6350_MASTER_LLCC,
 	.channels = 2,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SM6350_SLAVE_EBI_CH0 },
+	.link_nodes = { &ebi },
 };
 
 static struct qcom_icc_node qhm_mnoc_cfg = {
 	.name = "qhm_mnoc_cfg",
-	.id = SM6350_MASTER_CNOC_MNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SM6350_SLAVE_SERVICE_MNOC },
+	.link_nodes = { &srvc_mnoc },
 };
 
 static struct qcom_icc_node qnm_video0 = {
 	.name = "qnm_video0",
-	.id = SM6350_MASTER_VIDEO_P0,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SM6350_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_sf },
 };
 
 static struct qcom_icc_node qnm_video_cvp = {
 	.name = "qnm_video_cvp",
-	.id = SM6350_MASTER_VIDEO_PROC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SM6350_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_sf },
 };
 
 static struct qcom_icc_node qxm_camnoc_hf = {
 	.name = "qxm_camnoc_hf",
-	.id = SM6350_MASTER_CAMNOC_HF,
 	.channels = 2,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SM6350_SLAVE_MNOC_HF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_hf },
 };
 
 static struct qcom_icc_node qxm_camnoc_icp = {
 	.name = "qxm_camnoc_icp",
-	.id = SM6350_MASTER_CAMNOC_ICP,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SM6350_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_sf },
 };
 
 static struct qcom_icc_node qxm_camnoc_sf = {
 	.name = "qxm_camnoc_sf",
-	.id = SM6350_MASTER_CAMNOC_SF,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SM6350_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_sf },
 };
 
 static struct qcom_icc_node qxm_mdp0 = {
 	.name = "qxm_mdp0",
-	.id = SM6350_MASTER_MDP_PORT0,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SM6350_SLAVE_MNOC_HF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_hf },
 };
 
 static struct qcom_icc_node amm_npu_sys = {
 	.name = "amm_npu_sys",
-	.id = SM6350_MASTER_NPU_SYS,
 	.channels = 2,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SM6350_SLAVE_NPU_COMPUTE_NOC },
+	.link_nodes = { &qns_npu_sys },
 };
 
 static struct qcom_icc_node qhm_npu_cfg = {
 	.name = "qhm_npu_cfg",
-	.id = SM6350_MASTER_NPU_NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 8,
-	.links = { SM6350_SLAVE_SERVICE_NPU_NOC,
-		   SM6350_SLAVE_ISENSE_CFG,
-		   SM6350_SLAVE_NPU_LLM_CFG,
-		   SM6350_SLAVE_NPU_INT_DMA_BWMON_CFG,
-		   SM6350_SLAVE_NPU_CP,
-		   SM6350_SLAVE_NPU_TCM,
-		   SM6350_SLAVE_NPU_CAL_DP0,
-		   SM6350_SLAVE_NPU_DPM
-	},
+	.link_nodes = { &srvc_noc,
+			&qhs_isense,
+			&qhs_llm,
+			&qhs_dma_bwmon,
+			&qhs_cp,
+			&qhs_tcm,
+			&qhs_cal_dp0,
+			&qhs_dpm },
 };
 
 static struct qcom_icc_node qhm_snoc_cfg = {
 	.name = "qhm_snoc_cfg",
-	.id = SM6350_MASTER_SNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SM6350_SLAVE_SERVICE_SNOC },
+	.link_nodes = { &srvc_snoc },
 };
 
 static struct qcom_icc_node qnm_aggre1_noc = {
 	.name = "qnm_aggre1_noc",
-	.id = SM6350_A1NOC_SNOC_MAS,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 6,
-	.links = { SM6350_SLAVE_SNOC_GEM_NOC_SF,
-		   SM6350_SLAVE_PIMEM,
-		   SM6350_SLAVE_OCIMEM,
-		   SM6350_SLAVE_APPSS,
-		   SM6350_SNOC_CNOC_SLV,
-		   SM6350_SLAVE_QDSS_STM
-	},
+	.link_nodes = { &qns_gemnoc_sf,
+			&qxs_pimem,
+			&qxs_imem,
+			&qhs_apss,
+			&qns_cnoc,
+			&xs_qdss_stm },
 };
 
 static struct qcom_icc_node qnm_aggre2_noc = {
 	.name = "qnm_aggre2_noc",
-	.id = SM6350_A2NOC_SNOC_MAS,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 7,
-	.links = { SM6350_SLAVE_SNOC_GEM_NOC_SF,
-		   SM6350_SLAVE_PIMEM,
-		   SM6350_SLAVE_OCIMEM,
-		   SM6350_SLAVE_APPSS,
-		   SM6350_SNOC_CNOC_SLV,
-		   SM6350_SLAVE_TCU,
-		   SM6350_SLAVE_QDSS_STM
-	},
+	.link_nodes = { &qns_gemnoc_sf,
+			&qxs_pimem,
+			&qxs_imem,
+			&qhs_apss,
+			&qns_cnoc,
+			&xs_sys_tcu_cfg,
+			&xs_qdss_stm },
 };
 
 static struct qcom_icc_node qnm_gemnoc = {
 	.name = "qnm_gemnoc",
-	.id = SM6350_MASTER_GEM_NOC_SNOC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 6,
-	.links = { SM6350_SLAVE_PIMEM,
-		   SM6350_SLAVE_OCIMEM,
-		   SM6350_SLAVE_APPSS,
-		   SM6350_SNOC_CNOC_SLV,
-		   SM6350_SLAVE_TCU,
-		   SM6350_SLAVE_QDSS_STM
-	},
+	.link_nodes = { &qxs_pimem,
+			&qxs_imem,
+			&qhs_apss,
+			&qns_cnoc,
+			&xs_sys_tcu_cfg,
+			&xs_qdss_stm },
 };
 
 static struct qcom_icc_node qxm_pimem = {
 	.name = "qxm_pimem",
-	.id = SM6350_MASTER_PIMEM,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 2,
-	.links = { SM6350_SLAVE_SNOC_GEM_NOC_GC,
-		   SM6350_SLAVE_OCIMEM
-	},
+	.link_nodes = { &qns_gemnoc_gc,
+			&qxs_imem },
 };
 
 static struct qcom_icc_node xm_gic = {
 	.name = "xm_gic",
-	.id = SM6350_MASTER_GIC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SM6350_SLAVE_SNOC_GEM_NOC_GC },
+	.link_nodes = { &qns_gemnoc_gc },
 };
 
 static struct qcom_icc_node qns_a1noc_snoc = {
 	.name = "qns_a1noc_snoc",
-	.id = SM6350_A1NOC_SNOC_SLV,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { SM6350_A1NOC_SNOC_MAS },
+	.link_nodes = { &qnm_aggre1_noc },
 };
 
 static struct qcom_icc_node srvc_aggre1_noc = {
 	.name = "srvc_aggre1_noc",
-	.id = SM6350_SLAVE_SERVICE_A1NOC,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qns_a2noc_snoc = {
 	.name = "qns_a2noc_snoc",
-	.id = SM6350_A2NOC_SNOC_SLV,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { SM6350_A2NOC_SNOC_MAS },
+	.link_nodes = { &qnm_aggre2_noc },
 };
 
 static struct qcom_icc_node srvc_aggre2_noc = {
 	.name = "srvc_aggre2_noc",
-	.id = SM6350_SLAVE_SERVICE_A2NOC,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qns_camnoc_uncomp = {
 	.name = "qns_camnoc_uncomp",
-	.id = SM6350_SLAVE_CAMNOC_UNCOMP,
 	.channels = 1,
 	.buswidth = 32,
 };
 
 static struct qcom_icc_node qup0_core_slave = {
 	.name = "qup0_core_slave",
-	.id = SM6350_SLAVE_QUP_CORE_0,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qup1_core_slave = {
 	.name = "qup1_core_slave",
-	.id = SM6350_SLAVE_QUP_CORE_1,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qns_cdsp_gemnoc = {
 	.name = "qns_cdsp_gemnoc",
-	.id = SM6350_SLAVE_CDSP_GEM_NOC,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SM6350_MASTER_COMPUTE_NOC },
+	.link_nodes = { &qnm_cmpnoc },
 };
 
 static struct qcom_icc_node qhs_a1_noc_cfg = {
 	.name = "qhs_a1_noc_cfg",
-	.id = SM6350_SLAVE_A1NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SM6350_MASTER_A1NOC_CFG },
+	.link_nodes = { &qhm_a1noc_cfg },
 };
 
 static struct qcom_icc_node qhs_a2_noc_cfg = {
 	.name = "qhs_a2_noc_cfg",
-	.id = SM6350_SLAVE_A2NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SM6350_MASTER_A2NOC_CFG },
+	.link_nodes = { &qhm_a2noc_cfg },
 };
 
 static struct qcom_icc_node qhs_ahb2phy0 = {
 	.name = "qhs_ahb2phy0",
-	.id = SM6350_SLAVE_AHB2PHY,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_ahb2phy2 = {
 	.name = "qhs_ahb2phy2",
-	.id = SM6350_SLAVE_AHB2PHY_2,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_aoss = {
 	.name = "qhs_aoss",
-	.id = SM6350_SLAVE_AOSS,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_boot_rom = {
 	.name = "qhs_boot_rom",
-	.id = SM6350_SLAVE_BOOT_ROM,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_camera_cfg = {
 	.name = "qhs_camera_cfg",
-	.id = SM6350_SLAVE_CAMERA_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_camera_nrt_thrott_cfg = {
 	.name = "qhs_camera_nrt_thrott_cfg",
-	.id = SM6350_SLAVE_CAMERA_NRT_THROTTLE_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_camera_rt_throttle_cfg = {
 	.name = "qhs_camera_rt_throttle_cfg",
-	.id = SM6350_SLAVE_CAMERA_RT_THROTTLE_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_clk_ctl = {
 	.name = "qhs_clk_ctl",
-	.id = SM6350_SLAVE_CLK_CTL,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_cpr_cx = {
 	.name = "qhs_cpr_cx",
-	.id = SM6350_SLAVE_RBCPR_CX_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_cpr_mx = {
 	.name = "qhs_cpr_mx",
-	.id = SM6350_SLAVE_RBCPR_MX_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_crypto0_cfg = {
 	.name = "qhs_crypto0_cfg",
-	.id = SM6350_SLAVE_CRYPTO_0_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_dcc_cfg = {
 	.name = "qhs_dcc_cfg",
-	.id = SM6350_SLAVE_DCC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_ddrss_cfg = {
 	.name = "qhs_ddrss_cfg",
-	.id = SM6350_SLAVE_CNOC_DDRSS,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SM6350_MASTER_CNOC_DC_NOC },
+	.link_nodes = { &qhm_cnoc_dc_noc },
 };
 
 static struct qcom_icc_node qhs_display_cfg = {
 	.name = "qhs_display_cfg",
-	.id = SM6350_SLAVE_DISPLAY_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_display_throttle_cfg = {
 	.name = "qhs_display_throttle_cfg",
-	.id = SM6350_SLAVE_DISPLAY_THROTTLE_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_emmc_cfg = {
 	.name = "qhs_emmc_cfg",
-	.id = SM6350_SLAVE_EMMC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_glm = {
 	.name = "qhs_glm",
-	.id = SM6350_SLAVE_GLM,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_gpuss_cfg = {
 	.name = "qhs_gpuss_cfg",
-	.id = SM6350_SLAVE_GRAPHICS_3D_CFG,
 	.channels = 1,
 	.buswidth = 8,
 };
 
 static struct qcom_icc_node qhs_imem_cfg = {
 	.name = "qhs_imem_cfg",
-	.id = SM6350_SLAVE_IMEM_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_ipa = {
 	.name = "qhs_ipa",
-	.id = SM6350_SLAVE_IPA_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_mnoc_cfg = {
 	.name = "qhs_mnoc_cfg",
-	.id = SM6350_SLAVE_CNOC_MNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SM6350_MASTER_CNOC_MNOC_CFG },
+	.link_nodes = { &qhm_mnoc_cfg },
 };
 
 static struct qcom_icc_node qhs_mss_cfg = {
 	.name = "qhs_mss_cfg",
-	.id = SM6350_SLAVE_CNOC_MSS,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_npu_cfg = {
 	.name = "qhs_npu_cfg",
-	.id = SM6350_SLAVE_NPU_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SM6350_MASTER_NPU_NOC_CFG },
+	.link_nodes = { &qhm_npu_cfg },
 };
 
 static struct qcom_icc_node qhs_pdm = {
 	.name = "qhs_pdm",
-	.id = SM6350_SLAVE_PDM,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_pimem_cfg = {
 	.name = "qhs_pimem_cfg",
-	.id = SM6350_SLAVE_PIMEM_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_prng = {
 	.name = "qhs_prng",
-	.id = SM6350_SLAVE_PRNG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_qdss_cfg = {
 	.name = "qhs_qdss_cfg",
-	.id = SM6350_SLAVE_QDSS_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_qm_cfg = {
 	.name = "qhs_qm_cfg",
-	.id = SM6350_SLAVE_QM_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_qm_mpu_cfg = {
 	.name = "qhs_qm_mpu_cfg",
-	.id = SM6350_SLAVE_QM_MPU_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_qup0 = {
 	.name = "qhs_qup0",
-	.id = SM6350_SLAVE_QUP_0,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_qup1 = {
 	.name = "qhs_qup1",
-	.id = SM6350_SLAVE_QUP_1,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_sdc2 = {
 	.name = "qhs_sdc2",
-	.id = SM6350_SLAVE_SDCC_2,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_security = {
 	.name = "qhs_security",
-	.id = SM6350_SLAVE_SECURITY,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_snoc_cfg = {
 	.name = "qhs_snoc_cfg",
-	.id = SM6350_SLAVE_SNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SM6350_MASTER_SNOC_CFG },
+	.link_nodes = { &qhm_snoc_cfg },
 };
 
 static struct qcom_icc_node qhs_tcsr = {
 	.name = "qhs_tcsr",
-	.id = SM6350_SLAVE_TCSR,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_ufs_mem_cfg = {
 	.name = "qhs_ufs_mem_cfg",
-	.id = SM6350_SLAVE_UFS_MEM_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_usb3_0 = {
 	.name = "qhs_usb3_0",
-	.id = SM6350_SLAVE_USB3,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_venus_cfg = {
 	.name = "qhs_venus_cfg",
-	.id = SM6350_SLAVE_VENUS_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_venus_throttle_cfg = {
 	.name = "qhs_venus_throttle_cfg",
-	.id = SM6350_SLAVE_VENUS_THROTTLE_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_vsense_ctrl_cfg = {
 	.name = "qhs_vsense_ctrl_cfg",
-	.id = SM6350_SLAVE_VSENSE_CTRL_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node srvc_cnoc = {
 	.name = "srvc_cnoc",
-	.id = SM6350_SLAVE_SERVICE_CNOC,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_gemnoc = {
 	.name = "qhs_gemnoc",
-	.id = SM6350_SLAVE_GEM_NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SM6350_MASTER_GEM_NOC_CFG },
+	.link_nodes = { &qhm_gemnoc_cfg },
 };
 
 static struct qcom_icc_node qhs_llcc = {
 	.name = "qhs_llcc",
-	.id = SM6350_SLAVE_LLCC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_mcdma_ms_mpu_cfg = {
 	.name = "qhs_mcdma_ms_mpu_cfg",
-	.id = SM6350_SLAVE_MCDMA_MS_MPU_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_mdsp_ms_mpu_cfg = {
 	.name = "qhs_mdsp_ms_mpu_cfg",
-	.id = SM6350_SLAVE_MSS_PROC_MS_MPU_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qns_gem_noc_snoc = {
 	.name = "qns_gem_noc_snoc",
-	.id = SM6350_SLAVE_GEM_NOC_SNOC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SM6350_MASTER_GEM_NOC_SNOC },
+	.link_nodes = { &qnm_gemnoc },
 };
 
 static struct qcom_icc_node qns_llcc = {
 	.name = "qns_llcc",
-	.id = SM6350_SLAVE_LLCC,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { SM6350_MASTER_LLCC },
+	.link_nodes = { &llcc_mc },
 };
 
 static struct qcom_icc_node srvc_gemnoc = {
 	.name = "srvc_gemnoc",
-	.id = SM6350_SLAVE_SERVICE_GEM_NOC,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node ebi = {
 	.name = "ebi",
-	.id = SM6350_SLAVE_EBI_CH0,
 	.channels = 2,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qns_mem_noc_hf = {
 	.name = "qns_mem_noc_hf",
-	.id = SM6350_SLAVE_MNOC_HF_MEM_NOC,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SM6350_MASTER_MNOC_HF_MEM_NOC },
+	.link_nodes = { &qnm_mnoc_hf },
 };
 
 static struct qcom_icc_node qns_mem_noc_sf = {
 	.name = "qns_mem_noc_sf",
-	.id = SM6350_SLAVE_MNOC_SF_MEM_NOC,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SM6350_MASTER_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qnm_mnoc_sf },
 };
 
 static struct qcom_icc_node srvc_mnoc = {
 	.name = "srvc_mnoc",
-	.id = SM6350_SLAVE_SERVICE_MNOC,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_cal_dp0 = {
 	.name = "qhs_cal_dp0",
-	.id = SM6350_SLAVE_NPU_CAL_DP0,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_cp = {
 	.name = "qhs_cp",
-	.id = SM6350_SLAVE_NPU_CP,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_dma_bwmon = {
 	.name = "qhs_dma_bwmon",
-	.id = SM6350_SLAVE_NPU_INT_DMA_BWMON_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_dpm = {
 	.name = "qhs_dpm",
-	.id = SM6350_SLAVE_NPU_DPM,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_isense = {
 	.name = "qhs_isense",
-	.id = SM6350_SLAVE_ISENSE_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_llm = {
 	.name = "qhs_llm",
-	.id = SM6350_SLAVE_NPU_LLM_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_tcm = {
 	.name = "qhs_tcm",
-	.id = SM6350_SLAVE_NPU_TCM,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qns_npu_sys = {
 	.name = "qns_npu_sys",
-	.id = SM6350_SLAVE_NPU_COMPUTE_NOC,
 	.channels = 2,
 	.buswidth = 32,
 };
 
 static struct qcom_icc_node srvc_noc = {
 	.name = "srvc_noc",
-	.id = SM6350_SLAVE_SERVICE_NPU_NOC,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_apss = {
 	.name = "qhs_apss",
-	.id = SM6350_SLAVE_APPSS,
 	.channels = 1,
 	.buswidth = 8,
 };
 
 static struct qcom_icc_node qns_cnoc = {
 	.name = "qns_cnoc",
-	.id = SM6350_SNOC_CNOC_SLV,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SM6350_SNOC_CNOC_MAS },
+	.link_nodes = { &qnm_snoc },
 };
 
 static struct qcom_icc_node qns_gemnoc_gc = {
 	.name = "qns_gemnoc_gc",
-	.id = SM6350_SLAVE_SNOC_GEM_NOC_GC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SM6350_MASTER_SNOC_GC_MEM_NOC },
+	.link_nodes = { &qnm_snoc_gc },
 };
 
 static struct qcom_icc_node qns_gemnoc_sf = {
 	.name = "qns_gemnoc_sf",
-	.id = SM6350_SLAVE_SNOC_GEM_NOC_SF,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { SM6350_MASTER_SNOC_SF_MEM_NOC },
+	.link_nodes = { &qnm_snoc_sf },
 };
 
 static struct qcom_icc_node qxs_imem = {
 	.name = "qxs_imem",
-	.id = SM6350_SLAVE_OCIMEM,
 	.channels = 1,
 	.buswidth = 8,
 };
 
 static struct qcom_icc_node qxs_pimem = {
 	.name = "qxs_pimem",
-	.id = SM6350_SLAVE_PIMEM,
 	.channels = 1,
 	.buswidth = 8,
 };
 
 static struct qcom_icc_node srvc_snoc = {
 	.name = "srvc_snoc",
-	.id = SM6350_SLAVE_SERVICE_SNOC,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node xs_qdss_stm = {
 	.name = "xs_qdss_stm",
-	.id = SM6350_SLAVE_QDSS_STM,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node xs_sys_tcu_cfg = {
 	.name = "xs_sys_tcu_cfg",
-	.id = SM6350_SLAVE_TCU,
 	.channels = 1,
 	.buswidth = 8,
 };
@@ -1404,6 +1389,7 @@ static struct qcom_icc_node * const aggre1_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm6350_aggre1_noc = {
+	.alloc_dyn_id = true,
 	.nodes = aggre1_noc_nodes,
 	.num_nodes = ARRAY_SIZE(aggre1_noc_nodes),
 	.bcms = aggre1_noc_bcms,
@@ -1429,6 +1415,7 @@ static struct qcom_icc_node * const aggre2_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm6350_aggre2_noc = {
+	.alloc_dyn_id = true,
 	.nodes = aggre2_noc_nodes,
 	.num_nodes = ARRAY_SIZE(aggre2_noc_nodes),
 	.bcms = aggre2_noc_bcms,
@@ -1456,6 +1443,7 @@ static struct qcom_icc_node * const clk_virt_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm6350_clk_virt = {
+	.alloc_dyn_id = true,
 	.nodes = clk_virt_nodes,
 	.num_nodes = ARRAY_SIZE(clk_virt_nodes),
 	.bcms = clk_virt_bcms,
@@ -1475,6 +1463,7 @@ static struct qcom_icc_node * const compute_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm6350_compute_noc = {
+	.alloc_dyn_id = true,
 	.nodes = compute_noc_nodes,
 	.num_nodes = ARRAY_SIZE(compute_noc_nodes),
 	.bcms = compute_noc_bcms,
@@ -1535,6 +1524,7 @@ static struct qcom_icc_node * const config_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm6350_config_noc = {
+	.alloc_dyn_id = true,
 	.nodes = config_noc_nodes,
 	.num_nodes = ARRAY_SIZE(config_noc_nodes),
 	.bcms = config_noc_bcms,
@@ -1551,6 +1541,7 @@ static struct qcom_icc_node * const dc_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm6350_dc_noc = {
+	.alloc_dyn_id = true,
 	.nodes = dc_noc_nodes,
 	.num_nodes = ARRAY_SIZE(dc_noc_nodes),
 	.bcms = dc_noc_bcms,
@@ -1582,6 +1573,7 @@ static struct qcom_icc_node * const gem_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm6350_gem_noc = {
+	.alloc_dyn_id = true,
 	.nodes = gem_noc_nodes,
 	.num_nodes = ARRAY_SIZE(gem_noc_nodes),
 	.bcms = gem_noc_bcms,
@@ -1609,6 +1601,7 @@ static struct qcom_icc_node * const mmss_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm6350_mmss_noc = {
+	.alloc_dyn_id = true,
 	.nodes = mmss_noc_nodes,
 	.num_nodes = ARRAY_SIZE(mmss_noc_nodes),
 	.bcms = mmss_noc_bcms,
@@ -1633,6 +1626,7 @@ static struct qcom_icc_node * const npu_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm6350_npu_noc = {
+	.alloc_dyn_id = true,
 	.nodes = npu_noc_nodes,
 	.num_nodes = ARRAY_SIZE(npu_noc_nodes),
 	.bcms = npu_noc_bcms,
@@ -1669,6 +1663,7 @@ static struct qcom_icc_node * const system_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm6350_system_noc = {
+	.alloc_dyn_id = true,
 	.nodes = system_noc_nodes,
 	.num_nodes = ARRAY_SIZE(system_noc_nodes),
 	.bcms = system_noc_bcms,
diff --git a/drivers/interconnect/qcom/sm6350.h b/drivers/interconnect/qcom/sm6350.h
deleted file mode 100644
index 43cf2930c88a5ae1bc36600ab2b3661a4d11ca71..0000000000000000000000000000000000000000
--- a/drivers/interconnect/qcom/sm6350.h
+++ /dev/null
@@ -1,139 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Qualcomm #define SM6350 interconnect IDs
- *
- * Copyright (C) 2022 Luca Weiss <luca.weiss@fairphone.com>
- */
-
-#ifndef __DRIVERS_INTERCONNECT_QCOM_SM6350_H
-#define __DRIVERS_INTERCONNECT_QCOM_SM6350_H
-
-#define SM6350_A1NOC_SNOC_MAS			0
-#define SM6350_A1NOC_SNOC_SLV			1
-#define SM6350_A2NOC_SNOC_MAS			2
-#define SM6350_A2NOC_SNOC_SLV			3
-#define SM6350_MASTER_A1NOC_CFG			4
-#define SM6350_MASTER_A2NOC_CFG			5
-#define SM6350_MASTER_AMPSS_M0			6
-#define SM6350_MASTER_CAMNOC_HF			7
-#define SM6350_MASTER_CAMNOC_HF0_UNCOMP		8
-#define SM6350_MASTER_CAMNOC_ICP		9
-#define SM6350_MASTER_CAMNOC_ICP_UNCOMP		10
-#define SM6350_MASTER_CAMNOC_SF			11
-#define SM6350_MASTER_CAMNOC_SF_UNCOMP		12
-#define SM6350_MASTER_CNOC_DC_NOC		13
-#define SM6350_MASTER_CNOC_MNOC_CFG		14
-#define SM6350_MASTER_COMPUTE_NOC		15
-#define SM6350_MASTER_CRYPTO_CORE_0		16
-#define SM6350_MASTER_EMMC			17
-#define SM6350_MASTER_GEM_NOC_CFG		18
-#define SM6350_MASTER_GEM_NOC_SNOC		19
-#define SM6350_MASTER_GIC			20
-#define SM6350_MASTER_GRAPHICS_3D		21
-#define SM6350_MASTER_IPA			22
-#define SM6350_MASTER_LLCC			23
-#define SM6350_MASTER_MDP_PORT0			24
-#define SM6350_MASTER_MNOC_HF_MEM_NOC		25
-#define SM6350_MASTER_MNOC_SF_MEM_NOC		26
-#define SM6350_MASTER_NPU			27
-#define SM6350_MASTER_NPU_NOC_CFG		28
-#define SM6350_MASTER_NPU_PROC			29
-#define SM6350_MASTER_NPU_SYS			30
-#define SM6350_MASTER_PIMEM			31
-#define SM6350_MASTER_QDSS_BAM			32
-#define SM6350_MASTER_QDSS_DAP			33
-#define SM6350_MASTER_QDSS_ETR			34
-#define SM6350_MASTER_QUP_0			35
-#define SM6350_MASTER_QUP_1			36
-#define SM6350_MASTER_QUP_CORE_0		37
-#define SM6350_MASTER_QUP_CORE_1		38
-#define SM6350_MASTER_SDCC_2			39
-#define SM6350_MASTER_SNOC_CFG			40
-#define SM6350_MASTER_SNOC_GC_MEM_NOC		41
-#define SM6350_MASTER_SNOC_SF_MEM_NOC		42
-#define SM6350_MASTER_SYS_TCU			43
-#define SM6350_MASTER_UFS_MEM			44
-#define SM6350_MASTER_USB3			45
-#define SM6350_MASTER_VIDEO_P0			46
-#define SM6350_MASTER_VIDEO_PROC		47
-#define SM6350_SLAVE_A1NOC_CFG			48
-#define SM6350_SLAVE_A2NOC_CFG			49
-#define SM6350_SLAVE_AHB2PHY			50
-#define SM6350_SLAVE_AHB2PHY_2			51
-#define SM6350_SLAVE_AOSS			52
-#define SM6350_SLAVE_APPSS			53
-#define SM6350_SLAVE_BOOT_ROM			54
-#define SM6350_SLAVE_CAMERA_CFG			55
-#define SM6350_SLAVE_CAMERA_NRT_THROTTLE_CFG	56
-#define SM6350_SLAVE_CAMERA_RT_THROTTLE_CFG	57
-#define SM6350_SLAVE_CAMNOC_UNCOMP		58
-#define SM6350_SLAVE_CDSP_GEM_NOC		59
-#define SM6350_SLAVE_CLK_CTL			60
-#define SM6350_SLAVE_CNOC_DDRSS			61
-#define SM6350_SLAVE_CNOC_MNOC_CFG		62
-#define SM6350_SLAVE_CNOC_MSS			63
-#define SM6350_SLAVE_CRYPTO_0_CFG		64
-#define SM6350_SLAVE_DCC_CFG			65
-#define SM6350_SLAVE_DISPLAY_CFG		66
-#define SM6350_SLAVE_DISPLAY_THROTTLE_CFG	67
-#define SM6350_SLAVE_EBI_CH0			68
-#define SM6350_SLAVE_EMMC_CFG			69
-#define SM6350_SLAVE_GEM_NOC_CFG		70
-#define SM6350_SLAVE_GEM_NOC_SNOC		71
-#define SM6350_SLAVE_GLM			72
-#define SM6350_SLAVE_GRAPHICS_3D_CFG		73
-#define SM6350_SLAVE_IMEM_CFG			74
-#define SM6350_SLAVE_IPA_CFG			75
-#define SM6350_SLAVE_ISENSE_CFG			76
-#define SM6350_SLAVE_LLCC			77
-#define SM6350_SLAVE_LLCC_CFG			78
-#define SM6350_SLAVE_MCDMA_MS_MPU_CFG		79
-#define SM6350_SLAVE_MNOC_HF_MEM_NOC		80
-#define SM6350_SLAVE_MNOC_SF_MEM_NOC		81
-#define SM6350_SLAVE_MSS_PROC_MS_MPU_CFG	82
-#define SM6350_SLAVE_NPU_CAL_DP0		83
-#define SM6350_SLAVE_NPU_CFG			84
-#define SM6350_SLAVE_NPU_COMPUTE_NOC		85
-#define SM6350_SLAVE_NPU_CP			86
-#define SM6350_SLAVE_NPU_DPM			87
-#define SM6350_SLAVE_NPU_INT_DMA_BWMON_CFG	88
-#define SM6350_SLAVE_NPU_LLM_CFG		89
-#define SM6350_SLAVE_NPU_TCM			90
-#define SM6350_SLAVE_OCIMEM			91
-#define SM6350_SLAVE_PDM			92
-#define SM6350_SLAVE_PIMEM			93
-#define SM6350_SLAVE_PIMEM_CFG			94
-#define SM6350_SLAVE_PRNG			95
-#define SM6350_SLAVE_QDSS_CFG			96
-#define SM6350_SLAVE_QDSS_STM			97
-#define SM6350_SLAVE_QM_CFG			98
-#define SM6350_SLAVE_QM_MPU_CFG			99
-#define SM6350_SLAVE_QUP_0			100
-#define SM6350_SLAVE_QUP_1			101
-#define SM6350_SLAVE_QUP_CORE_0			102
-#define SM6350_SLAVE_QUP_CORE_1			103
-#define SM6350_SLAVE_RBCPR_CX_CFG		104
-#define SM6350_SLAVE_RBCPR_MX_CFG		105
-#define SM6350_SLAVE_SDCC_2			106
-#define SM6350_SLAVE_SECURITY			107
-#define SM6350_SLAVE_SERVICE_A1NOC		108
-#define SM6350_SLAVE_SERVICE_A2NOC		109
-#define SM6350_SLAVE_SERVICE_CNOC		110
-#define SM6350_SLAVE_SERVICE_GEM_NOC		111
-#define SM6350_SLAVE_SERVICE_MNOC		112
-#define SM6350_SLAVE_SERVICE_NPU_NOC		113
-#define SM6350_SLAVE_SERVICE_SNOC		114
-#define SM6350_SLAVE_SNOC_CFG			115
-#define SM6350_SLAVE_SNOC_GEM_NOC_GC		116
-#define SM6350_SLAVE_SNOC_GEM_NOC_SF		117
-#define SM6350_SLAVE_TCSR			118
-#define SM6350_SLAVE_TCU			119
-#define SM6350_SLAVE_UFS_MEM_CFG		120
-#define SM6350_SLAVE_USB3			121
-#define SM6350_SLAVE_VENUS_CFG			122
-#define SM6350_SLAVE_VENUS_THROTTLE_CFG		123
-#define SM6350_SLAVE_VSENSE_CTRL_CFG		124
-#define SM6350_SNOC_CNOC_MAS			125
-#define SM6350_SNOC_CNOC_SLV			126
-
-#endif

-- 
2.47.3



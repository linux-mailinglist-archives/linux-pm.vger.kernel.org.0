Return-Path: <linux-pm+bounces-37221-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D1DC25B8A
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 15:58:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48334188B6D6
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 14:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D6D1E1E0B;
	Fri, 31 Oct 2025 14:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gxM7EUDe";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="A2D9jPyb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949CF2D6407
	for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2025 14:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761921982; cv=none; b=WkDX+fQSWVa5CcFP5Bkgk3d3NOWcn8zqlvyJ7FpONXd2Nm+1x4LTh+kE/HxlU8TEMOrPQm4Yi8rKJgr/0M96fgDLVroNh2ml+O0Lo2EyN4pbruEO00anyVFFCn+UhQhGDIUcAZ9gqiukOtmTM28UL5GDoO6abJ3juIkkBhUoYtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761921982; c=relaxed/simple;
	bh=tQ++6nDj4HeuunICqWYTQqMx8RpfcrnrXgZ5lZWbUcw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WXfjHbGfcrlUh4cBzQOEHnbBKrf3sSB9p8pBnVX71ROwLqpYUk9VXnT7thd58+De5i7TfvOzvgKUuc07PIx9S7p/iwN8IFOd3T3fU+8gDsgQ7GoSEtPtmF4fJ0O2+rYPejmTwFp9AbcCD12KREmN9bk06HnKjrAxigDMBfEnUDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gxM7EUDe; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=A2D9jPyb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59V9jYWb2471646
	for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2025 14:46:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EzUU/Jgnbbdc87r2SVxNRjdreEVy/VO9sPQQnNuivwI=; b=gxM7EUDeHPELBE80
	mTaFPvh/k8xstPW9dSURZYwbazeotT6z644nu/9d1dXn3UqWX/usLD9osTjynNVE
	IMMeMaouJyv6oclYV8GclsKT2Mqle9ECLHx7AlIKIh+R1NsviuWwykxwQ6/8hOuu
	v9aVIZZlbslqLvZfIKJ0NVoVnHEssy5HNniH6Qv1X6ceUwgESFmJONDhEKwNUe7A
	5/yxQzBMfQoqXCJbY7JT2LFST4PoIUTbIWHQATDtUAzdQ/dd/OqBmSfPNOMGaIUd
	9xL2M6IPCsXYw+vZ5O9nLeQ6XJYg/vSi11sukjuPl/rDNlfX1zypXK04HTwKTulf
	VZLBdA==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a4trv0rvs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2025 14:46:08 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-5db9a7aaf6fso928364137.3
        for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2025 07:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761921967; x=1762526767; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EzUU/Jgnbbdc87r2SVxNRjdreEVy/VO9sPQQnNuivwI=;
        b=A2D9jPybIkPa0z5xPHLS7fx9fkgQeCgT+2uUZJLJG8Kn8fqC64W4J7ls0IbSdAInlh
         h5ADf5wNBH4m0qU6HYZxUoPND0jsXvCxItSNnc92VBqseXrNMCHPYeYFcdtxPhXDsoas
         0FAj8UVgaTUO7Zh5wCyXzl5m2rTDOHH/n5XC3pzoT80mF46Oix+GONQFej5Mn8ic8HtW
         I+QBsuM0TxfbOsj1pKZSMh1QAYeeue3zZ2lZG9GQgT/7WTi2nfu3MmTlBzX+MQ9Y02gk
         TUrAA6ppYXuOSNJj56kwWwIJp35wI427UF+fSHNyeCG/qmHYNkepl7JPmREf5a0fBHx2
         peDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761921967; x=1762526767;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EzUU/Jgnbbdc87r2SVxNRjdreEVy/VO9sPQQnNuivwI=;
        b=DSHZzcgad/kP5snRVNk8cJAYVDeZv+qQK1gJbRddjK2KYfUV7y9swq8GSeuXUG5AZ+
         ReCgju8TDCieVIVnTGW5DCWwxWI8R+FS3drOZUtcCO0QKwCRSvwEQ7+PbLKiiFbGCR34
         SNCAxCfjRr99BziYi8uiiGULWpQ/KaKNiVHqbYFM0n9tJTVLTG9ahT0MpUJPZCaQnzWv
         HuEAwex8DydbLFxfpoPsB5RJwe4ExoyJ+S8js9pXRlV5MeWVZD8yVPN1sdNQCLoy3Rky
         Olq4mH2myLTTHzqxZVJ/ok/U2inE6aRaM+C5pxgQYh1KdyI4Uj2R92VU8QMkJDE2OKI5
         n0BQ==
X-Forwarded-Encrypted: i=1; AJvYcCUekCA3fL+Hh9mKHbp+x50tbY58qdAF8dvIjj4/TlxbdgyWy4RmxwurQp0R1uGiVDxvPydwq2Pfug==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyoy4bUk7oeN+e+z43eVJJsaOMvPNo6FT2jpcXIfmjxbsz7nPO8
	eqsFmFCed14Ab1r5i1FpxUs87b5GQv6WAslRLNLkpijpKUoyjRs5IhUrhP0Yo2PWolUQAr4jMDZ
	6tw3HFD5Sr9mnI8wqo7GVcTKE79IlQXcRxkqDth9LZeHgqeymFQhIR5vRePOCOg==
X-Gm-Gg: ASbGncteIomct3I6JYnfvKYh7KI3/e+oMCgrjZgJ/OZTjKHnA66JmDXxRLL3JEQjS8H
	JlKX1EH0SQT8dq0VcRpDrI1D7zipvmyxBUNvlIK0xY5zXVz2dxTIsC63IPgAp/2P8QIHQtYFDTD
	hvLKGYThELQAoEmh++MtBKy4IPBb+frIOyWT85rAODHFDINzWndOlwvrfaUlyY0egXGo1CSjp8i
	nBzEI8aFhzcl668EehyxHLaIFJf2DcNF4v2TGA7NzQ3H8H5n8JaC7NP/YvDWGXAwcI8ewxKtzTi
	gJFtlVeW9wPy9w4zRs9Qabi+X2WO22Bw1iOQsST7PsfLApMGx5uomgHsXYs1HQtD/XVAigvDNwC
	erKDk/5/Kn32Dy9biN+DHRKWTiDeELE058xuzZLmTt6OrylAw+7LaD/yW+fqeNoEmy/43ZHZLrC
	90vjTXfjFb95v6
X-Received: by 2002:a05:6102:a4c:b0:51f:66fc:53b8 with SMTP id ada2fe7eead31-5dbb12ef1c2mr1083678137.25.1761921966841;
        Fri, 31 Oct 2025 07:46:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOb9yYF0EkMUfOzZgH8eCvtxCzjRNv+ye/RyLd5UsmMUhttBpfFcE1j4vxk3oOHxzwnYLRnQ==
X-Received: by 2002:a05:6102:a4c:b0:51f:66fc:53b8 with SMTP id ada2fe7eead31-5dbb12ef1c2mr1083644137.25.1761921964701;
        Fri, 31 Oct 2025 07:46:04 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5941f5bc218sm541405e87.93.2025.10.31.07.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 07:46:03 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 31 Oct 2025 16:45:39 +0200
Subject: [PATCH v3 23/25] interconnect: qcom: sm8650: convert to dynamic
 IDs
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-rework-icc-v3-23-0575304c9624@oss.qualcomm.com>
References: <20251031-rework-icc-v3-0-0575304c9624@oss.qualcomm.com>
In-Reply-To: <20251031-rework-icc-v3-0-0575304c9624@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=52959;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=tQ++6nDj4HeuunICqWYTQqMx8RpfcrnrXgZ5lZWbUcw=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpBMuI7TdZCpDntZmE7SYF6ru3xYoNM3GpQAeSP
 E+ufBRrjLqJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaQTLiAAKCRCLPIo+Aiko
 1eV1B/9RwpL+OTpIG95dXr5sdsDYe0dzdVgq8NjMzl3nDt0tdRFWd6wx5OYOUOT3SE7aGX63D9m
 lR13mNVZYVayW9hkctYzEPQeheJcqDcBiGLiPSkrmKOQaM9Ktpb+B2UbzXdPiXmg7EDr+ws+VRu
 ayOzEDKgQObwYpZi6UApQYUPPxFSqf7ObnA9doaVYZd6MUEW8oDPG1yiPOmoDVO8Xiwy3SVYAJi
 +qZDpcOzjZZzxW49QiGI9xgvAVoKDaILBu+mi+zlzlpdsHnXWxQLJn0kxs5fGmFftOYmdzgeqdH
 RIlE+ZAlIn7/cMF592E+/H4bR+vpIF7ExLtFiquUnje/I+qx
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: cZrSZXiPUJTNf3fc_ioJofQelKMNv-cn
X-Proofpoint-GUID: cZrSZXiPUJTNf3fc_ioJofQelKMNv-cn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDEzMyBTYWx0ZWRfX7O1DJLdNG9Dh
 ZPfjM6pozy8pIH2Hww1jEUKMoweJ2fYTOAnSIB6NPm3aTvxLL8RmFm4SdYtAgR95g4Rx8kWZt2P
 qtha4HtOLms2E/c+zSMzy8qRSuIj2Efip4akmsRFdv97+YV+yo1yxK2rwffwEW+I7d7hGm5m8/d
 Z5qf/pZbBCSmuOLRI2zbaZxqNSHioUQ98dkUuIVlvfRbE5FNLdIVCe8n4qosB42yMcmFLi/tA7R
 8F9Z7u1oAaVKSE007pfXXN3QOZpUdPiEx+0QMVxheO27gkFw/88BqsVSnRgxvfdN6fGYviWJAGO
 c4AWHJq8UVQzsqzHsbKzllwWZcEad4PIaMsbnxDPTVF6Tb0K1GrPW0CrtXPNBk8GermoP5qKeQ2
 33a1FFQH9HbdEaJBebTRf7VXFMlpKA==
X-Authority-Analysis: v=2.4 cv=XoP3+FF9 c=1 sm=1 tr=0 ts=6904cbb0 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=LHEHHV_lcRqWWSNTS_kA:9 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_04,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 phishscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510310133

Stop using fixed and IDs and covert the platform to use dynamic IDs for
the interconnect. This gives more flexibility and also allows us to drop
the .num_links member, saving from possible errors related to it being
not set or set incorrectly.

Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on QRD8650
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/interconnect/qcom/sm8650.c | 541 +++++++++++++++++--------------------
 drivers/interconnect/qcom/sm8650.h | 144 ----------
 2 files changed, 247 insertions(+), 438 deletions(-)

diff --git a/drivers/interconnect/qcom/sm8650.c b/drivers/interconnect/qcom/sm8650.c
index b7c321f4e4b51cbcb138e906e561325393e3e14e..629ff30e7ee70567beb4c9bd21b9b91f53b39526 100644
--- a/drivers/interconnect/qcom/sm8650.c
+++ b/drivers/interconnect/qcom/sm8650.c
@@ -15,8 +15,138 @@
 #include "bcm-voter.h"
 #include "icc-common.h"
 #include "icc-rpmh.h"
-#include "sm8650.h"
 
+static struct qcom_icc_node qhm_qspi;
+static struct qcom_icc_node qhm_qup1;
+static struct qcom_icc_node qxm_qup02;
+static struct qcom_icc_node xm_sdc4;
+static struct qcom_icc_node xm_ufs_mem;
+static struct qcom_icc_node xm_usb3_0;
+static struct qcom_icc_node qhm_qdss_bam;
+static struct qcom_icc_node qhm_qup2;
+static struct qcom_icc_node qxm_crypto;
+static struct qcom_icc_node qxm_ipa;
+static struct qcom_icc_node qxm_sp;
+static struct qcom_icc_node xm_qdss_etr_0;
+static struct qcom_icc_node xm_qdss_etr_1;
+static struct qcom_icc_node xm_sdc2;
+static struct qcom_icc_node qup0_core_master;
+static struct qcom_icc_node qup1_core_master;
+static struct qcom_icc_node qup2_core_master;
+static struct qcom_icc_node qsm_cfg;
+static struct qcom_icc_node qnm_gemnoc_cnoc;
+static struct qcom_icc_node qnm_gemnoc_pcie;
+static struct qcom_icc_node alm_gpu_tcu;
+static struct qcom_icc_node alm_sys_tcu;
+static struct qcom_icc_node alm_ubwc_p_tcu;
+static struct qcom_icc_node chm_apps;
+static struct qcom_icc_node qnm_gpu;
+static struct qcom_icc_node qnm_lpass_gemnoc;
+static struct qcom_icc_node qnm_mdsp;
+static struct qcom_icc_node qnm_mnoc_hf;
+static struct qcom_icc_node qnm_mnoc_sf;
+static struct qcom_icc_node qnm_nsp_gemnoc;
+static struct qcom_icc_node qnm_pcie;
+static struct qcom_icc_node qnm_snoc_sf;
+static struct qcom_icc_node qnm_ubwc_p;
+static struct qcom_icc_node xm_gic;
+static struct qcom_icc_node qnm_lpiaon_noc;
+static struct qcom_icc_node qnm_lpass_lpinoc;
+static struct qcom_icc_node qxm_lpinoc_dsp_axim;
+static struct qcom_icc_node llcc_mc;
+static struct qcom_icc_node qnm_camnoc_hf;
+static struct qcom_icc_node qnm_camnoc_icp;
+static struct qcom_icc_node qnm_camnoc_sf;
+static struct qcom_icc_node qnm_mdp;
+static struct qcom_icc_node qnm_vapss_hcp;
+static struct qcom_icc_node qnm_video;
+static struct qcom_icc_node qnm_video_cv_cpu;
+static struct qcom_icc_node qnm_video_cvp;
+static struct qcom_icc_node qnm_video_v_cpu;
+static struct qcom_icc_node qsm_mnoc_cfg;
+static struct qcom_icc_node qnm_nsp;
+static struct qcom_icc_node qsm_pcie_anoc_cfg;
+static struct qcom_icc_node xm_pcie3_0;
+static struct qcom_icc_node xm_pcie3_1;
+static struct qcom_icc_node qnm_aggre1_noc;
+static struct qcom_icc_node qnm_aggre2_noc;
+static struct qcom_icc_node qnm_apss_noc;
+static struct qcom_icc_node qns_a1noc_snoc;
+static struct qcom_icc_node qns_a2noc_snoc;
+static struct qcom_icc_node qup0_core_slave;
+static struct qcom_icc_node qup1_core_slave;
+static struct qcom_icc_node qup2_core_slave;
+static struct qcom_icc_node qhs_ahb2phy0;
+static struct qcom_icc_node qhs_ahb2phy1;
+static struct qcom_icc_node qhs_camera_cfg;
+static struct qcom_icc_node qhs_clk_ctl;
+static struct qcom_icc_node qhs_cpr_cx;
+static struct qcom_icc_node qhs_cpr_hmx;
+static struct qcom_icc_node qhs_cpr_mmcx;
+static struct qcom_icc_node qhs_cpr_mxa;
+static struct qcom_icc_node qhs_cpr_mxc;
+static struct qcom_icc_node qhs_cpr_nspcx;
+static struct qcom_icc_node qhs_crypto0_cfg;
+static struct qcom_icc_node qhs_cx_rdpm;
+static struct qcom_icc_node qhs_display_cfg;
+static struct qcom_icc_node qhs_gpuss_cfg;
+static struct qcom_icc_node qhs_i2c;
+static struct qcom_icc_node qhs_i3c_ibi0_cfg;
+static struct qcom_icc_node qhs_i3c_ibi1_cfg;
+static struct qcom_icc_node qhs_imem_cfg;
+static struct qcom_icc_node qhs_mss_cfg;
+static struct qcom_icc_node qhs_mx_2_rdpm;
+static struct qcom_icc_node qhs_mx_rdpm;
+static struct qcom_icc_node qhs_pcie0_cfg;
+static struct qcom_icc_node qhs_pcie1_cfg;
+static struct qcom_icc_node qhs_pcie_rscc;
+static struct qcom_icc_node qhs_pdm;
+static struct qcom_icc_node qhs_prng;
+static struct qcom_icc_node qhs_qdss_cfg;
+static struct qcom_icc_node qhs_qspi;
+static struct qcom_icc_node qhs_qup02;
+static struct qcom_icc_node qhs_qup1;
+static struct qcom_icc_node qhs_qup2;
+static struct qcom_icc_node qhs_sdc2;
+static struct qcom_icc_node qhs_sdc4;
+static struct qcom_icc_node qhs_spss_cfg;
+static struct qcom_icc_node qhs_tcsr;
+static struct qcom_icc_node qhs_tlmm;
+static struct qcom_icc_node qhs_ufs_mem_cfg;
+static struct qcom_icc_node qhs_usb3_0;
+static struct qcom_icc_node qhs_venus_cfg;
+static struct qcom_icc_node qhs_vsense_ctrl_cfg;
+static struct qcom_icc_node qss_mnoc_cfg;
+static struct qcom_icc_node qss_nsp_qtb_cfg;
+static struct qcom_icc_node qss_pcie_anoc_cfg;
+static struct qcom_icc_node srvc_cnoc_cfg;
+static struct qcom_icc_node xs_qdss_stm;
+static struct qcom_icc_node xs_sys_tcu_cfg;
+static struct qcom_icc_node qhs_aoss;
+static struct qcom_icc_node qhs_ipa;
+static struct qcom_icc_node qhs_ipc_router;
+static struct qcom_icc_node qhs_tme_cfg;
+static struct qcom_icc_node qss_apss;
+static struct qcom_icc_node qss_cfg;
+static struct qcom_icc_node qss_ddrss_cfg;
+static struct qcom_icc_node qxs_imem;
+static struct qcom_icc_node srvc_cnoc_main;
+static struct qcom_icc_node xs_pcie_0;
+static struct qcom_icc_node xs_pcie_1;
+static struct qcom_icc_node qns_gem_noc_cnoc;
+static struct qcom_icc_node qns_llcc;
+static struct qcom_icc_node qns_pcie;
+static struct qcom_icc_node qns_lpass_ag_noc_gemnoc;
+static struct qcom_icc_node qns_lpass_aggnoc;
+static struct qcom_icc_node qns_lpi_aon_noc;
+static struct qcom_icc_node ebi;
+static struct qcom_icc_node qns_mem_noc_hf;
+static struct qcom_icc_node qns_mem_noc_sf;
+static struct qcom_icc_node srvc_mnoc;
+static struct qcom_icc_node qns_nsp_gemnoc;
+static struct qcom_icc_node qns_pcie_mem_noc;
+static struct qcom_icc_node srvc_pcie_aggre_noc;
+static struct qcom_icc_node qns_gemnoc_sf;
 static const struct regmap_config icc_regmap_config = {
 	.reg_bits = 32,
 	.reg_stride = 4,
@@ -34,12 +164,11 @@ static struct qcom_icc_qosbox qhm_qspi_qos = {
 
 static struct qcom_icc_node qhm_qspi = {
 	.name = "qhm_qspi",
-	.id = SM8650_MASTER_QSPI_0,
 	.channels = 1,
 	.buswidth = 4,
 	.qosbox = &qhm_qspi_qos,
 	.num_links = 1,
-	.links = { SM8650_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc },
 };
 
 static struct qcom_icc_qosbox qhm_qup1_qos = {
@@ -52,21 +181,19 @@ static struct qcom_icc_qosbox qhm_qup1_qos = {
 
 static struct qcom_icc_node qhm_qup1 = {
 	.name = "qhm_qup1",
-	.id = SM8650_MASTER_QUP_1,
 	.channels = 1,
 	.buswidth = 4,
 	.qosbox = &qhm_qup1_qos,
 	.num_links = 1,
-	.links = { SM8650_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc },
 };
 
 static struct qcom_icc_node qxm_qup02 = {
 	.name = "qxm_qup02",
-	.id = SM8650_MASTER_QUP_3,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SM8650_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc },
 };
 
 static struct qcom_icc_qosbox xm_sdc4_qos = {
@@ -79,12 +206,11 @@ static struct qcom_icc_qosbox xm_sdc4_qos = {
 
 static struct qcom_icc_node xm_sdc4 = {
 	.name = "xm_sdc4",
-	.id = SM8650_MASTER_SDCC_4,
 	.channels = 1,
 	.buswidth = 8,
 	.qosbox = &xm_sdc4_qos,
 	.num_links = 1,
-	.links = { SM8650_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc },
 };
 
 static struct qcom_icc_qosbox xm_ufs_mem_qos = {
@@ -97,12 +223,11 @@ static struct qcom_icc_qosbox xm_ufs_mem_qos = {
 
 static struct qcom_icc_node xm_ufs_mem = {
 	.name = "xm_ufs_mem",
-	.id = SM8650_MASTER_UFS_MEM,
 	.channels = 1,
 	.buswidth = 16,
 	.qosbox = &xm_ufs_mem_qos,
 	.num_links = 1,
-	.links = { SM8650_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc },
 };
 
 static struct qcom_icc_qosbox xm_usb3_0_qos = {
@@ -115,12 +240,11 @@ static struct qcom_icc_qosbox xm_usb3_0_qos = {
 
 static struct qcom_icc_node xm_usb3_0 = {
 	.name = "xm_usb3_0",
-	.id = SM8650_MASTER_USB3_0,
 	.channels = 1,
 	.buswidth = 8,
 	.qosbox = &xm_usb3_0_qos,
 	.num_links = 1,
-	.links = { SM8650_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc },
 };
 
 static struct qcom_icc_qosbox qhm_qdss_bam_qos = {
@@ -133,12 +257,11 @@ static struct qcom_icc_qosbox qhm_qdss_bam_qos = {
 
 static struct qcom_icc_node qhm_qdss_bam = {
 	.name = "qhm_qdss_bam",
-	.id = SM8650_MASTER_QDSS_BAM,
 	.channels = 1,
 	.buswidth = 4,
 	.qosbox = &qhm_qdss_bam_qos,
 	.num_links = 1,
-	.links = { SM8650_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc },
 };
 
 static struct qcom_icc_qosbox qhm_qup2_qos = {
@@ -151,12 +274,11 @@ static struct qcom_icc_qosbox qhm_qup2_qos = {
 
 static struct qcom_icc_node qhm_qup2 = {
 	.name = "qhm_qup2",
-	.id = SM8650_MASTER_QUP_2,
 	.channels = 1,
 	.buswidth = 4,
 	.qosbox = &qhm_qup2_qos,
 	.num_links = 1,
-	.links = { SM8650_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc },
 };
 
 static struct qcom_icc_qosbox qxm_crypto_qos = {
@@ -169,12 +291,11 @@ static struct qcom_icc_qosbox qxm_crypto_qos = {
 
 static struct qcom_icc_node qxm_crypto = {
 	.name = "qxm_crypto",
-	.id = SM8650_MASTER_CRYPTO,
 	.channels = 1,
 	.buswidth = 8,
 	.qosbox = &qxm_crypto_qos,
 	.num_links = 1,
-	.links = { SM8650_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc },
 };
 
 static struct qcom_icc_qosbox qxm_ipa_qos = {
@@ -187,21 +308,19 @@ static struct qcom_icc_qosbox qxm_ipa_qos = {
 
 static struct qcom_icc_node qxm_ipa = {
 	.name = "qxm_ipa",
-	.id = SM8650_MASTER_IPA,
 	.channels = 1,
 	.buswidth = 8,
 	.qosbox = &qxm_ipa_qos,
 	.num_links = 1,
-	.links = { SM8650_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc },
 };
 
 static struct qcom_icc_node qxm_sp = {
 	.name = "qxm_sp",
-	.id = SM8650_MASTER_SP,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SM8650_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc },
 };
 
 static struct qcom_icc_qosbox xm_qdss_etr_0_qos = {
@@ -214,12 +333,11 @@ static struct qcom_icc_qosbox xm_qdss_etr_0_qos = {
 
 static struct qcom_icc_node xm_qdss_etr_0 = {
 	.name = "xm_qdss_etr_0",
-	.id = SM8650_MASTER_QDSS_ETR,
 	.channels = 1,
 	.buswidth = 8,
 	.qosbox = &xm_qdss_etr_0_qos,
 	.num_links = 1,
-	.links = { SM8650_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc },
 };
 
 static struct qcom_icc_qosbox xm_qdss_etr_1_qos = {
@@ -232,12 +350,11 @@ static struct qcom_icc_qosbox xm_qdss_etr_1_qos = {
 
 static struct qcom_icc_node xm_qdss_etr_1 = {
 	.name = "xm_qdss_etr_1",
-	.id = SM8650_MASTER_QDSS_ETR_1,
 	.channels = 1,
 	.buswidth = 8,
 	.qosbox = &xm_qdss_etr_1_qos,
 	.num_links = 1,
-	.links = { SM8650_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc },
 };
 
 static struct qcom_icc_qosbox xm_sdc2_qos = {
@@ -250,92 +367,85 @@ static struct qcom_icc_qosbox xm_sdc2_qos = {
 
 static struct qcom_icc_node xm_sdc2 = {
 	.name = "xm_sdc2",
-	.id = SM8650_MASTER_SDCC_2,
 	.channels = 1,
 	.buswidth = 8,
 	.qosbox = &xm_sdc2_qos,
 	.num_links = 1,
-	.links = { SM8650_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc },
 };
 
 static struct qcom_icc_node qup0_core_master = {
 	.name = "qup0_core_master",
-	.id = SM8650_MASTER_QUP_CORE_0,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SM8650_SLAVE_QUP_CORE_0 },
+	.link_nodes = { &qup0_core_slave },
 };
 
 static struct qcom_icc_node qup1_core_master = {
 	.name = "qup1_core_master",
-	.id = SM8650_MASTER_QUP_CORE_1,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SM8650_SLAVE_QUP_CORE_1 },
+	.link_nodes = { &qup1_core_slave },
 };
 
 static struct qcom_icc_node qup2_core_master = {
 	.name = "qup2_core_master",
-	.id = SM8650_MASTER_QUP_CORE_2,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SM8650_SLAVE_QUP_CORE_2 },
+	.link_nodes = { &qup2_core_slave },
 };
 
 static struct qcom_icc_node qsm_cfg = {
 	.name = "qsm_cfg",
-	.id = SM8650_MASTER_CNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 46,
-	.links = { SM8650_SLAVE_AHB2PHY_SOUTH, SM8650_SLAVE_AHB2PHY_NORTH,
-		   SM8650_SLAVE_CAMERA_CFG, SM8650_SLAVE_CLK_CTL,
-		   SM8650_SLAVE_RBCPR_CX_CFG, SM8650_SLAVE_CPR_HMX,
-		   SM8650_SLAVE_RBCPR_MMCX_CFG, SM8650_SLAVE_RBCPR_MXA_CFG,
-		   SM8650_SLAVE_RBCPR_MXC_CFG, SM8650_SLAVE_CPR_NSPCX,
-		   SM8650_SLAVE_CRYPTO_0_CFG, SM8650_SLAVE_CX_RDPM,
-		   SM8650_SLAVE_DISPLAY_CFG, SM8650_SLAVE_GFX3D_CFG,
-		   SM8650_SLAVE_I2C, SM8650_SLAVE_I3C_IBI0_CFG,
-		   SM8650_SLAVE_I3C_IBI1_CFG, SM8650_SLAVE_IMEM_CFG,
-		   SM8650_SLAVE_CNOC_MSS, SM8650_SLAVE_MX_2_RDPM,
-		   SM8650_SLAVE_MX_RDPM, SM8650_SLAVE_PCIE_0_CFG,
-		   SM8650_SLAVE_PCIE_1_CFG, SM8650_SLAVE_PCIE_RSCC,
-		   SM8650_SLAVE_PDM, SM8650_SLAVE_PRNG,
-		   SM8650_SLAVE_QDSS_CFG, SM8650_SLAVE_QSPI_0,
-		   SM8650_SLAVE_QUP_3, SM8650_SLAVE_QUP_1,
-		   SM8650_SLAVE_QUP_2, SM8650_SLAVE_SDCC_2,
-		   SM8650_SLAVE_SDCC_4, SM8650_SLAVE_SPSS_CFG,
-		   SM8650_SLAVE_TCSR, SM8650_SLAVE_TLMM,
-		   SM8650_SLAVE_UFS_MEM_CFG, SM8650_SLAVE_USB3_0,
-		   SM8650_SLAVE_VENUS_CFG, SM8650_SLAVE_VSENSE_CTRL_CFG,
-		   SM8650_SLAVE_CNOC_MNOC_CFG, SM8650_SLAVE_NSP_QTB_CFG,
-		   SM8650_SLAVE_PCIE_ANOC_CFG, SM8650_SLAVE_SERVICE_CNOC_CFG,
-		   SM8650_SLAVE_QDSS_STM, SM8650_SLAVE_TCU },
+	.link_nodes = { &qhs_ahb2phy0, &qhs_ahb2phy1,
+			&qhs_camera_cfg, &qhs_clk_ctl,
+			&qhs_cpr_cx, &qhs_cpr_hmx,
+			&qhs_cpr_mmcx, &qhs_cpr_mxa,
+			&qhs_cpr_mxc, &qhs_cpr_nspcx,
+			&qhs_crypto0_cfg, &qhs_cx_rdpm,
+			&qhs_display_cfg, &qhs_gpuss_cfg,
+			&qhs_i2c, &qhs_i3c_ibi0_cfg,
+			&qhs_i3c_ibi1_cfg, &qhs_imem_cfg,
+			&qhs_mss_cfg, &qhs_mx_2_rdpm,
+			&qhs_mx_rdpm, &qhs_pcie0_cfg,
+			&qhs_pcie1_cfg, &qhs_pcie_rscc,
+			&qhs_pdm, &qhs_prng,
+			&qhs_qdss_cfg, &qhs_qspi,
+			&qhs_qup02, &qhs_qup1,
+			&qhs_qup2, &qhs_sdc2,
+			&qhs_sdc4, &qhs_spss_cfg,
+			&qhs_tcsr, &qhs_tlmm,
+			&qhs_ufs_mem_cfg, &qhs_usb3_0,
+			&qhs_venus_cfg, &qhs_vsense_ctrl_cfg,
+			&qss_mnoc_cfg, &qss_nsp_qtb_cfg,
+			&qss_pcie_anoc_cfg, &srvc_cnoc_cfg,
+			&xs_qdss_stm, &xs_sys_tcu_cfg },
 };
 
 static struct qcom_icc_node qnm_gemnoc_cnoc = {
 	.name = "qnm_gemnoc_cnoc",
-	.id = SM8650_MASTER_GEM_NOC_CNOC,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 9,
-	.links = { SM8650_SLAVE_AOSS, SM8650_SLAVE_IPA_CFG,
-		   SM8650_SLAVE_IPC_ROUTER_CFG, SM8650_SLAVE_TME_CFG,
-		   SM8650_SLAVE_APPSS, SM8650_SLAVE_CNOC_CFG,
-		   SM8650_SLAVE_DDRSS_CFG, SM8650_SLAVE_IMEM,
-		   SM8650_SLAVE_SERVICE_CNOC },
+	.link_nodes = { &qhs_aoss, &qhs_ipa,
+			&qhs_ipc_router, &qhs_tme_cfg,
+			&qss_apss, &qss_cfg,
+			&qss_ddrss_cfg, &qxs_imem,
+			&srvc_cnoc_main },
 };
 
 static struct qcom_icc_node qnm_gemnoc_pcie = {
 	.name = "qnm_gemnoc_pcie",
-	.id = SM8650_MASTER_GEM_NOC_PCIE_SNOC,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 2,
-	.links = { SM8650_SLAVE_PCIE_0, SM8650_SLAVE_PCIE_1 },
+	.link_nodes = { &xs_pcie_0, &xs_pcie_1 },
 };
 
 static struct qcom_icc_qosbox alm_gpu_tcu_qos = {
@@ -348,12 +458,11 @@ static struct qcom_icc_qosbox alm_gpu_tcu_qos = {
 
 static struct qcom_icc_node alm_gpu_tcu = {
 	.name = "alm_gpu_tcu",
-	.id = SM8650_MASTER_GPU_TCU,
 	.channels = 1,
 	.buswidth = 8,
 	.qosbox = &alm_gpu_tcu_qos,
 	.num_links = 2,
-	.links = { SM8650_SLAVE_GEM_NOC_CNOC, SM8650_SLAVE_LLCC },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc },
 };
 
 static struct qcom_icc_qosbox alm_sys_tcu_qos = {
@@ -366,12 +475,11 @@ static struct qcom_icc_qosbox alm_sys_tcu_qos = {
 
 static struct qcom_icc_node alm_sys_tcu = {
 	.name = "alm_sys_tcu",
-	.id = SM8650_MASTER_SYS_TCU,
 	.channels = 1,
 	.buswidth = 8,
 	.qosbox = &alm_sys_tcu_qos,
 	.num_links = 2,
-	.links = { SM8650_SLAVE_GEM_NOC_CNOC, SM8650_SLAVE_LLCC },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc },
 };
 
 static struct qcom_icc_qosbox alm_ubwc_p_tcu_qos = {
@@ -384,22 +492,20 @@ static struct qcom_icc_qosbox alm_ubwc_p_tcu_qos = {
 
 static struct qcom_icc_node alm_ubwc_p_tcu = {
 	.name = "alm_ubwc_p_tcu",
-	.id = SM8650_MASTER_UBWC_P_TCU,
 	.channels = 1,
 	.buswidth = 8,
 	.qosbox = &alm_ubwc_p_tcu_qos,
 	.num_links = 2,
-	.links = { SM8650_SLAVE_GEM_NOC_CNOC, SM8650_SLAVE_LLCC },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc },
 };
 
 static struct qcom_icc_node chm_apps = {
 	.name = "chm_apps",
-	.id = SM8650_MASTER_APPSS_PROC,
 	.channels = 3,
 	.buswidth = 32,
 	.num_links = 3,
-	.links = { SM8650_SLAVE_GEM_NOC_CNOC, SM8650_SLAVE_LLCC,
-		   SM8650_SLAVE_MEM_NOC_PCIE_SNOC },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc,
+			&qns_pcie },
 };
 
 static struct qcom_icc_qosbox qnm_gpu_qos = {
@@ -412,12 +518,11 @@ static struct qcom_icc_qosbox qnm_gpu_qos = {
 
 static struct qcom_icc_node qnm_gpu = {
 	.name = "qnm_gpu",
-	.id = SM8650_MASTER_GFX3D,
 	.channels = 2,
 	.buswidth = 32,
 	.qosbox = &qnm_gpu_qos,
 	.num_links = 2,
-	.links = { SM8650_SLAVE_GEM_NOC_CNOC, SM8650_SLAVE_LLCC },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc },
 };
 
 static struct qcom_icc_qosbox qnm_lpass_gemnoc_qos = {
@@ -430,23 +535,21 @@ static struct qcom_icc_qosbox qnm_lpass_gemnoc_qos = {
 
 static struct qcom_icc_node qnm_lpass_gemnoc = {
 	.name = "qnm_lpass_gemnoc",
-	.id = SM8650_MASTER_LPASS_GEM_NOC,
 	.channels = 1,
 	.buswidth = 16,
 	.qosbox = &qnm_lpass_gemnoc_qos,
 	.num_links = 3,
-	.links = { SM8650_SLAVE_GEM_NOC_CNOC, SM8650_SLAVE_LLCC,
-		   SM8650_SLAVE_MEM_NOC_PCIE_SNOC },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc,
+			&qns_pcie },
 };
 
 static struct qcom_icc_node qnm_mdsp = {
 	.name = "qnm_mdsp",
-	.id = SM8650_MASTER_MSS_PROC,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 3,
-	.links = { SM8650_SLAVE_GEM_NOC_CNOC, SM8650_SLAVE_LLCC,
-		   SM8650_SLAVE_MEM_NOC_PCIE_SNOC },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc,
+			&qns_pcie },
 };
 
 static struct qcom_icc_qosbox qnm_mnoc_hf_qos = {
@@ -459,12 +562,11 @@ static struct qcom_icc_qosbox qnm_mnoc_hf_qos = {
 
 static struct qcom_icc_node qnm_mnoc_hf = {
 	.name = "qnm_mnoc_hf",
-	.id = SM8650_MASTER_MNOC_HF_MEM_NOC,
 	.channels = 2,
 	.buswidth = 32,
 	.qosbox = &qnm_mnoc_hf_qos,
 	.num_links = 2,
-	.links = { SM8650_SLAVE_GEM_NOC_CNOC, SM8650_SLAVE_LLCC },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc },
 };
 
 static struct qcom_icc_qosbox qnm_mnoc_sf_qos = {
@@ -477,12 +579,11 @@ static struct qcom_icc_qosbox qnm_mnoc_sf_qos = {
 
 static struct qcom_icc_node qnm_mnoc_sf = {
 	.name = "qnm_mnoc_sf",
-	.id = SM8650_MASTER_MNOC_SF_MEM_NOC,
 	.channels = 2,
 	.buswidth = 32,
 	.qosbox = &qnm_mnoc_sf_qos,
 	.num_links = 2,
-	.links = { SM8650_SLAVE_GEM_NOC_CNOC, SM8650_SLAVE_LLCC },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc },
 };
 
 static struct qcom_icc_qosbox qnm_nsp_gemnoc_qos = {
@@ -495,13 +596,12 @@ static struct qcom_icc_qosbox qnm_nsp_gemnoc_qos = {
 
 static struct qcom_icc_node qnm_nsp_gemnoc = {
 	.name = "qnm_nsp_gemnoc",
-	.id = SM8650_MASTER_COMPUTE_NOC,
 	.channels = 2,
 	.buswidth = 32,
 	.qosbox = &qnm_nsp_gemnoc_qos,
 	.num_links = 3,
-	.links = { SM8650_SLAVE_GEM_NOC_CNOC, SM8650_SLAVE_LLCC,
-		   SM8650_SLAVE_MEM_NOC_PCIE_SNOC },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc,
+			&qns_pcie },
 };
 
 static struct qcom_icc_qosbox qnm_pcie_qos = {
@@ -514,12 +614,11 @@ static struct qcom_icc_qosbox qnm_pcie_qos = {
 
 static struct qcom_icc_node qnm_pcie = {
 	.name = "qnm_pcie",
-	.id = SM8650_MASTER_ANOC_PCIE_GEM_NOC,
 	.channels = 1,
 	.buswidth = 16,
 	.qosbox = &qnm_pcie_qos,
 	.num_links = 2,
-	.links = { SM8650_SLAVE_GEM_NOC_CNOC, SM8650_SLAVE_LLCC },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc },
 };
 
 static struct qcom_icc_qosbox qnm_snoc_sf_qos = {
@@ -532,13 +631,12 @@ static struct qcom_icc_qosbox qnm_snoc_sf_qos = {
 
 static struct qcom_icc_node qnm_snoc_sf = {
 	.name = "qnm_snoc_sf",
-	.id = SM8650_MASTER_SNOC_SF_MEM_NOC,
 	.channels = 1,
 	.buswidth = 16,
 	.qosbox = &qnm_snoc_sf_qos,
 	.num_links = 3,
-	.links = { SM8650_SLAVE_GEM_NOC_CNOC, SM8650_SLAVE_LLCC,
-		   SM8650_SLAVE_MEM_NOC_PCIE_SNOC },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc,
+			&qns_pcie },
 };
 
 static struct qcom_icc_qosbox qnm_ubwc_p_qos = {
@@ -551,12 +649,11 @@ static struct qcom_icc_qosbox qnm_ubwc_p_qos = {
 
 static struct qcom_icc_node qnm_ubwc_p = {
 	.name = "qnm_ubwc_p",
-	.id = SM8650_MASTER_UBWC_P,
 	.channels = 1,
 	.buswidth = 32,
 	.qosbox = &qnm_ubwc_p_qos,
 	.num_links = 1,
-	.links = { SM8650_SLAVE_LLCC },
+	.link_nodes = { &qns_llcc },
 };
 
 static struct qcom_icc_qosbox xm_gic_qos = {
@@ -569,48 +666,43 @@ static struct qcom_icc_qosbox xm_gic_qos = {
 
 static struct qcom_icc_node xm_gic = {
 	.name = "xm_gic",
-	.id = SM8650_MASTER_GIC,
 	.channels = 1,
 	.buswidth = 8,
 	.qosbox = &xm_gic_qos,
 	.num_links = 1,
-	.links = { SM8650_SLAVE_LLCC },
+	.link_nodes = { &qns_llcc },
 };
 
 static struct qcom_icc_node qnm_lpiaon_noc = {
 	.name = "qnm_lpiaon_noc",
-	.id = SM8650_MASTER_LPIAON_NOC,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { SM8650_SLAVE_LPASS_GEM_NOC },
+	.link_nodes = { &qns_lpass_ag_noc_gemnoc },
 };
 
 static struct qcom_icc_node qnm_lpass_lpinoc = {
 	.name = "qnm_lpass_lpinoc",
-	.id = SM8650_MASTER_LPASS_LPINOC,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { SM8650_SLAVE_LPIAON_NOC_LPASS_AG_NOC },
+	.link_nodes = { &qns_lpass_aggnoc },
 };
 
 static struct qcom_icc_node qxm_lpinoc_dsp_axim = {
 	.name = "qxm_lpinoc_dsp_axim",
-	.id = SM8650_MASTER_LPASS_PROC,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { SM8650_SLAVE_LPICX_NOC_LPIAON_NOC },
+	.link_nodes = { &qns_lpi_aon_noc },
 };
 
 static struct qcom_icc_node llcc_mc = {
 	.name = "llcc_mc",
-	.id = SM8650_MASTER_LLCC,
 	.channels = 4,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SM8650_SLAVE_EBI1 },
+	.link_nodes = { &ebi },
 };
 
 static struct qcom_icc_qosbox qnm_camnoc_hf_qos = {
@@ -623,12 +715,11 @@ static struct qcom_icc_qosbox qnm_camnoc_hf_qos = {
 
 static struct qcom_icc_node qnm_camnoc_hf = {
 	.name = "qnm_camnoc_hf",
-	.id = SM8650_MASTER_CAMNOC_HF,
 	.channels = 2,
 	.buswidth = 32,
 	.qosbox = &qnm_camnoc_hf_qos,
 	.num_links = 1,
-	.links = { SM8650_SLAVE_MNOC_HF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_hf },
 };
 
 static struct qcom_icc_qosbox qnm_camnoc_icp_qos = {
@@ -641,12 +732,11 @@ static struct qcom_icc_qosbox qnm_camnoc_icp_qos = {
 
 static struct qcom_icc_node qnm_camnoc_icp = {
 	.name = "qnm_camnoc_icp",
-	.id = SM8650_MASTER_CAMNOC_ICP,
 	.channels = 1,
 	.buswidth = 8,
 	.qosbox = &qnm_camnoc_icp_qos,
 	.num_links = 1,
-	.links = { SM8650_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_sf },
 };
 
 static struct qcom_icc_qosbox qnm_camnoc_sf_qos = {
@@ -659,12 +749,11 @@ static struct qcom_icc_qosbox qnm_camnoc_sf_qos = {
 
 static struct qcom_icc_node qnm_camnoc_sf = {
 	.name = "qnm_camnoc_sf",
-	.id = SM8650_MASTER_CAMNOC_SF,
 	.channels = 2,
 	.buswidth = 32,
 	.qosbox = &qnm_camnoc_sf_qos,
 	.num_links = 1,
-	.links = { SM8650_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_sf },
 };
 
 static struct qcom_icc_qosbox qnm_mdp_qos = {
@@ -677,21 +766,19 @@ static struct qcom_icc_qosbox qnm_mdp_qos = {
 
 static struct qcom_icc_node qnm_mdp = {
 	.name = "qnm_mdp",
-	.id = SM8650_MASTER_MDP,
 	.channels = 2,
 	.buswidth = 32,
 	.qosbox = &qnm_mdp_qos,
 	.num_links = 1,
-	.links = { SM8650_SLAVE_MNOC_HF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_hf },
 };
 
 static struct qcom_icc_node qnm_vapss_hcp = {
 	.name = "qnm_vapss_hcp",
-	.id = SM8650_MASTER_CDSP_HCP,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SM8650_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_sf },
 };
 
 static struct qcom_icc_qosbox qnm_video_qos = {
@@ -704,12 +791,11 @@ static struct qcom_icc_qosbox qnm_video_qos = {
 
 static struct qcom_icc_node qnm_video = {
 	.name = "qnm_video",
-	.id = SM8650_MASTER_VIDEO,
 	.channels = 2,
 	.buswidth = 32,
 	.qosbox = &qnm_video_qos,
 	.num_links = 1,
-	.links = { SM8650_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_sf },
 };
 
 static struct qcom_icc_qosbox qnm_video_cv_cpu_qos = {
@@ -722,12 +808,11 @@ static struct qcom_icc_qosbox qnm_video_cv_cpu_qos = {
 
 static struct qcom_icc_node qnm_video_cv_cpu = {
 	.name = "qnm_video_cv_cpu",
-	.id = SM8650_MASTER_VIDEO_CV_PROC,
 	.channels = 1,
 	.buswidth = 8,
 	.qosbox = &qnm_video_cv_cpu_qos,
 	.num_links = 1,
-	.links = { SM8650_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_sf },
 };
 
 static struct qcom_icc_qosbox qnm_video_cvp_qos = {
@@ -740,12 +825,11 @@ static struct qcom_icc_qosbox qnm_video_cvp_qos = {
 
 static struct qcom_icc_node qnm_video_cvp = {
 	.name = "qnm_video_cvp",
-	.id = SM8650_MASTER_VIDEO_PROC,
 	.channels = 2,
 	.buswidth = 32,
 	.qosbox = &qnm_video_cvp_qos,
 	.num_links = 1,
-	.links = { SM8650_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_sf },
 };
 
 static struct qcom_icc_qosbox qnm_video_v_cpu_qos = {
@@ -758,39 +842,35 @@ static struct qcom_icc_qosbox qnm_video_v_cpu_qos = {
 
 static struct qcom_icc_node qnm_video_v_cpu = {
 	.name = "qnm_video_v_cpu",
-	.id = SM8650_MASTER_VIDEO_V_PROC,
 	.channels = 1,
 	.buswidth = 8,
 	.qosbox = &qnm_video_v_cpu_qos,
 	.num_links = 1,
-	.links = { SM8650_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_sf },
 };
 
 static struct qcom_icc_node qsm_mnoc_cfg = {
 	.name = "qsm_mnoc_cfg",
-	.id = SM8650_MASTER_CNOC_MNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SM8650_SLAVE_SERVICE_MNOC },
+	.link_nodes = { &srvc_mnoc },
 };
 
 static struct qcom_icc_node qnm_nsp = {
 	.name = "qnm_nsp",
-	.id = SM8650_MASTER_CDSP_PROC,
 	.channels = 2,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SM8650_SLAVE_CDSP_MEM_NOC },
+	.link_nodes = { &qns_nsp_gemnoc },
 };
 
 static struct qcom_icc_node qsm_pcie_anoc_cfg = {
 	.name = "qsm_pcie_anoc_cfg",
-	.id = SM8650_MASTER_PCIE_ANOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SM8650_SLAVE_SERVICE_PCIE_ANOC },
+	.link_nodes = { &srvc_pcie_aggre_noc },
 };
 
 static struct qcom_icc_qosbox xm_pcie3_0_qos = {
@@ -803,12 +883,11 @@ static struct qcom_icc_qosbox xm_pcie3_0_qos = {
 
 static struct qcom_icc_node xm_pcie3_0 = {
 	.name = "xm_pcie3_0",
-	.id = SM8650_MASTER_PCIE_0,
 	.channels = 1,
 	.buswidth = 8,
 	.qosbox = &xm_pcie3_0_qos,
 	.num_links = 1,
-	.links = { SM8650_SLAVE_ANOC_PCIE_GEM_NOC },
+	.link_nodes = { &qns_pcie_mem_noc },
 };
 
 static struct qcom_icc_qosbox xm_pcie3_1_qos = {
@@ -821,30 +900,27 @@ static struct qcom_icc_qosbox xm_pcie3_1_qos = {
 
 static struct qcom_icc_node xm_pcie3_1 = {
 	.name = "xm_pcie3_1",
-	.id = SM8650_MASTER_PCIE_1,
 	.channels = 1,
 	.buswidth = 16,
 	.qosbox = &xm_pcie3_1_qos,
 	.num_links = 1,
-	.links = { SM8650_SLAVE_ANOC_PCIE_GEM_NOC },
+	.link_nodes = { &qns_pcie_mem_noc },
 };
 
 static struct qcom_icc_node qnm_aggre1_noc = {
 	.name = "qnm_aggre1_noc",
-	.id = SM8650_MASTER_A1NOC_SNOC,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { SM8650_SLAVE_SNOC_GEM_NOC_SF },
+	.link_nodes = { &qns_gemnoc_sf },
 };
 
 static struct qcom_icc_node qnm_aggre2_noc = {
 	.name = "qnm_aggre2_noc",
-	.id = SM8650_MASTER_A2NOC_SNOC,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { SM8650_SLAVE_SNOC_GEM_NOC_SF },
+	.link_nodes = { &qns_gemnoc_sf },
 };
 
 static struct qcom_icc_qosbox qnm_apss_noc_qos = {
@@ -857,636 +933,499 @@ static struct qcom_icc_qosbox qnm_apss_noc_qos = {
 
 static struct qcom_icc_node qnm_apss_noc = {
 	.name = "qnm_apss_noc",
-	.id = SM8650_MASTER_APSS_NOC,
 	.channels = 1,
 	.buswidth = 4,
 	.qosbox = &qnm_apss_noc_qos,
 	.num_links = 1,
-	.links = { SM8650_SLAVE_SNOC_GEM_NOC_SF },
+	.link_nodes = { &qns_gemnoc_sf },
 };
 
 static struct qcom_icc_node qns_a1noc_snoc = {
 	.name = "qns_a1noc_snoc",
-	.id = SM8650_SLAVE_A1NOC_SNOC,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { SM8650_MASTER_A1NOC_SNOC },
+	.link_nodes = { &qnm_aggre1_noc },
 };
 
 static struct qcom_icc_node qns_a2noc_snoc = {
 	.name = "qns_a2noc_snoc",
-	.id = SM8650_SLAVE_A2NOC_SNOC,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { SM8650_MASTER_A2NOC_SNOC },
+	.link_nodes = { &qnm_aggre2_noc },
 };
 
 static struct qcom_icc_node qup0_core_slave = {
 	.name = "qup0_core_slave",
-	.id = SM8650_SLAVE_QUP_CORE_0,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qup1_core_slave = {
 	.name = "qup1_core_slave",
-	.id = SM8650_SLAVE_QUP_CORE_1,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qup2_core_slave = {
 	.name = "qup2_core_slave",
-	.id = SM8650_SLAVE_QUP_CORE_2,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_ahb2phy0 = {
 	.name = "qhs_ahb2phy0",
-	.id = SM8650_SLAVE_AHB2PHY_SOUTH,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_ahb2phy1 = {
 	.name = "qhs_ahb2phy1",
-	.id = SM8650_SLAVE_AHB2PHY_NORTH,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_camera_cfg = {
 	.name = "qhs_camera_cfg",
-	.id = SM8650_SLAVE_CAMERA_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_clk_ctl = {
 	.name = "qhs_clk_ctl",
-	.id = SM8650_SLAVE_CLK_CTL,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_cpr_cx = {
 	.name = "qhs_cpr_cx",
-	.id = SM8650_SLAVE_RBCPR_CX_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_cpr_hmx = {
 	.name = "qhs_cpr_hmx",
-	.id = SM8650_SLAVE_CPR_HMX,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_cpr_mmcx = {
 	.name = "qhs_cpr_mmcx",
-	.id = SM8650_SLAVE_RBCPR_MMCX_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_cpr_mxa = {
 	.name = "qhs_cpr_mxa",
-	.id = SM8650_SLAVE_RBCPR_MXA_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_cpr_mxc = {
 	.name = "qhs_cpr_mxc",
-	.id = SM8650_SLAVE_RBCPR_MXC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_cpr_nspcx = {
 	.name = "qhs_cpr_nspcx",
-	.id = SM8650_SLAVE_CPR_NSPCX,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_crypto0_cfg = {
 	.name = "qhs_crypto0_cfg",
-	.id = SM8650_SLAVE_CRYPTO_0_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_cx_rdpm = {
 	.name = "qhs_cx_rdpm",
-	.id = SM8650_SLAVE_CX_RDPM,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_display_cfg = {
 	.name = "qhs_display_cfg",
-	.id = SM8650_SLAVE_DISPLAY_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_gpuss_cfg = {
 	.name = "qhs_gpuss_cfg",
-	.id = SM8650_SLAVE_GFX3D_CFG,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_i2c = {
 	.name = "qhs_i2c",
-	.id = SM8650_SLAVE_I2C,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_i3c_ibi0_cfg = {
 	.name = "qhs_i3c_ibi0_cfg",
-	.id = SM8650_SLAVE_I3C_IBI0_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_i3c_ibi1_cfg = {
 	.name = "qhs_i3c_ibi1_cfg",
-	.id = SM8650_SLAVE_I3C_IBI1_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_imem_cfg = {
 	.name = "qhs_imem_cfg",
-	.id = SM8650_SLAVE_IMEM_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_mss_cfg = {
 	.name = "qhs_mss_cfg",
-	.id = SM8650_SLAVE_CNOC_MSS,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_mx_2_rdpm = {
 	.name = "qhs_mx_2_rdpm",
-	.id = SM8650_SLAVE_MX_2_RDPM,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_mx_rdpm = {
 	.name = "qhs_mx_rdpm",
-	.id = SM8650_SLAVE_MX_RDPM,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_pcie0_cfg = {
 	.name = "qhs_pcie0_cfg",
-	.id = SM8650_SLAVE_PCIE_0_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_pcie1_cfg = {
 	.name = "qhs_pcie1_cfg",
-	.id = SM8650_SLAVE_PCIE_1_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_pcie_rscc = {
 	.name = "qhs_pcie_rscc",
-	.id = SM8650_SLAVE_PCIE_RSCC,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_pdm = {
 	.name = "qhs_pdm",
-	.id = SM8650_SLAVE_PDM,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_prng = {
 	.name = "qhs_prng",
-	.id = SM8650_SLAVE_PRNG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_qdss_cfg = {
 	.name = "qhs_qdss_cfg",
-	.id = SM8650_SLAVE_QDSS_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_qspi = {
 	.name = "qhs_qspi",
-	.id = SM8650_SLAVE_QSPI_0,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_qup02 = {
 	.name = "qhs_qup02",
-	.id = SM8650_SLAVE_QUP_3,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_qup1 = {
 	.name = "qhs_qup1",
-	.id = SM8650_SLAVE_QUP_1,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_qup2 = {
 	.name = "qhs_qup2",
-	.id = SM8650_SLAVE_QUP_2,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_sdc2 = {
 	.name = "qhs_sdc2",
-	.id = SM8650_SLAVE_SDCC_2,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_sdc4 = {
 	.name = "qhs_sdc4",
-	.id = SM8650_SLAVE_SDCC_4,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_spss_cfg = {
 	.name = "qhs_spss_cfg",
-	.id = SM8650_SLAVE_SPSS_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_tcsr = {
 	.name = "qhs_tcsr",
-	.id = SM8650_SLAVE_TCSR,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_tlmm = {
 	.name = "qhs_tlmm",
-	.id = SM8650_SLAVE_TLMM,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_ufs_mem_cfg = {
 	.name = "qhs_ufs_mem_cfg",
-	.id = SM8650_SLAVE_UFS_MEM_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_usb3_0 = {
 	.name = "qhs_usb3_0",
-	.id = SM8650_SLAVE_USB3_0,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_venus_cfg = {
 	.name = "qhs_venus_cfg",
-	.id = SM8650_SLAVE_VENUS_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_vsense_ctrl_cfg = {
 	.name = "qhs_vsense_ctrl_cfg",
-	.id = SM8650_SLAVE_VSENSE_CTRL_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qss_mnoc_cfg = {
 	.name = "qss_mnoc_cfg",
-	.id = SM8650_SLAVE_CNOC_MNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SM8650_MASTER_CNOC_MNOC_CFG },
+	.link_nodes = { &qsm_mnoc_cfg },
 };
 
 static struct qcom_icc_node qss_nsp_qtb_cfg = {
 	.name = "qss_nsp_qtb_cfg",
-	.id = SM8650_SLAVE_NSP_QTB_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qss_pcie_anoc_cfg = {
 	.name = "qss_pcie_anoc_cfg",
-	.id = SM8650_SLAVE_PCIE_ANOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SM8650_MASTER_PCIE_ANOC_CFG },
+	.link_nodes = { &qsm_pcie_anoc_cfg },
 };
 
 static struct qcom_icc_node srvc_cnoc_cfg = {
 	.name = "srvc_cnoc_cfg",
-	.id = SM8650_SLAVE_SERVICE_CNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node xs_qdss_stm = {
 	.name = "xs_qdss_stm",
-	.id = SM8650_SLAVE_QDSS_STM,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node xs_sys_tcu_cfg = {
 	.name = "xs_sys_tcu_cfg",
-	.id = SM8650_SLAVE_TCU,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_aoss = {
 	.name = "qhs_aoss",
-	.id = SM8650_SLAVE_AOSS,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_ipa = {
 	.name = "qhs_ipa",
-	.id = SM8650_SLAVE_IPA_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_ipc_router = {
 	.name = "qhs_ipc_router",
-	.id = SM8650_SLAVE_IPC_ROUTER_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_tme_cfg = {
 	.name = "qhs_tme_cfg",
-	.id = SM8650_SLAVE_TME_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qss_apss = {
 	.name = "qss_apss",
-	.id = SM8650_SLAVE_APPSS,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qss_cfg = {
 	.name = "qss_cfg",
-	.id = SM8650_SLAVE_CNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SM8650_MASTER_CNOC_CFG },
+	.link_nodes = { &qsm_cfg },
 };
 
 static struct qcom_icc_node qss_ddrss_cfg = {
 	.name = "qss_ddrss_cfg",
-	.id = SM8650_SLAVE_DDRSS_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qxs_imem = {
 	.name = "qxs_imem",
-	.id = SM8650_SLAVE_IMEM,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node srvc_cnoc_main = {
 	.name = "srvc_cnoc_main",
-	.id = SM8650_SLAVE_SERVICE_CNOC,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node xs_pcie_0 = {
 	.name = "xs_pcie_0",
-	.id = SM8650_SLAVE_PCIE_0,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node xs_pcie_1 = {
 	.name = "xs_pcie_1",
-	.id = SM8650_SLAVE_PCIE_1,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qns_gem_noc_cnoc = {
 	.name = "qns_gem_noc_cnoc",
-	.id = SM8650_SLAVE_GEM_NOC_CNOC,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { SM8650_MASTER_GEM_NOC_CNOC },
+	.link_nodes = { &qnm_gemnoc_cnoc },
 };
 
 static struct qcom_icc_node qns_llcc = {
 	.name = "qns_llcc",
-	.id = SM8650_SLAVE_LLCC,
 	.channels = 4,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { SM8650_MASTER_LLCC },
+	.link_nodes = { &llcc_mc },
 };
 
 static struct qcom_icc_node qns_pcie = {
 	.name = "qns_pcie",
-	.id = SM8650_SLAVE_MEM_NOC_PCIE_SNOC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SM8650_MASTER_GEM_NOC_PCIE_SNOC },
+	.link_nodes = { &qnm_gemnoc_pcie },
 };
 
 static struct qcom_icc_node qns_lpass_ag_noc_gemnoc = {
 	.name = "qns_lpass_ag_noc_gemnoc",
-	.id = SM8650_SLAVE_LPASS_GEM_NOC,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { SM8650_MASTER_LPASS_GEM_NOC },
+	.link_nodes = { &qnm_lpass_gemnoc },
 };
 
 static struct qcom_icc_node qns_lpass_aggnoc = {
 	.name = "qns_lpass_aggnoc",
-	.id = SM8650_SLAVE_LPIAON_NOC_LPASS_AG_NOC,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { SM8650_MASTER_LPIAON_NOC },
+	.link_nodes = { &qnm_lpiaon_noc },
 };
 
 static struct qcom_icc_node qns_lpi_aon_noc = {
 	.name = "qns_lpi_aon_noc",
-	.id = SM8650_SLAVE_LPICX_NOC_LPIAON_NOC,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { SM8650_MASTER_LPASS_LPINOC },
+	.link_nodes = { &qnm_lpass_lpinoc },
 };
 
 static struct qcom_icc_node ebi = {
 	.name = "ebi",
-	.id = SM8650_SLAVE_EBI1,
 	.channels = 4,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qns_mem_noc_hf = {
 	.name = "qns_mem_noc_hf",
-	.id = SM8650_SLAVE_MNOC_HF_MEM_NOC,
 	.channels = 2,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SM8650_MASTER_MNOC_HF_MEM_NOC },
+	.link_nodes = { &qnm_mnoc_hf },
 };
 
 static struct qcom_icc_node qns_mem_noc_sf = {
 	.name = "qns_mem_noc_sf",
-	.id = SM8650_SLAVE_MNOC_SF_MEM_NOC,
 	.channels = 2,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SM8650_MASTER_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qnm_mnoc_sf },
 };
 
 static struct qcom_icc_node srvc_mnoc = {
 	.name = "srvc_mnoc",
-	.id = SM8650_SLAVE_SERVICE_MNOC,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qns_nsp_gemnoc = {
 	.name = "qns_nsp_gemnoc",
-	.id = SM8650_SLAVE_CDSP_MEM_NOC,
 	.channels = 2,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SM8650_MASTER_COMPUTE_NOC },
+	.link_nodes = { &qnm_nsp_gemnoc },
 };
 
 static struct qcom_icc_node qns_pcie_mem_noc = {
 	.name = "qns_pcie_mem_noc",
-	.id = SM8650_SLAVE_ANOC_PCIE_GEM_NOC,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { SM8650_MASTER_ANOC_PCIE_GEM_NOC },
+	.link_nodes = { &qnm_pcie },
 };
 
 static struct qcom_icc_node srvc_pcie_aggre_noc = {
 	.name = "srvc_pcie_aggre_noc",
-	.id = SM8650_SLAVE_SERVICE_PCIE_ANOC,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qns_gemnoc_sf = {
 	.name = "qns_gemnoc_sf",
-	.id = SM8650_SLAVE_SNOC_GEM_NOC_SF,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { SM8650_MASTER_SNOC_SF_MEM_NOC },
+	.link_nodes = { &qnm_snoc_sf },
 };
 
 static struct qcom_icc_bcm bcm_acv = {
@@ -1656,6 +1595,7 @@ static struct qcom_icc_node * const aggre1_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8650_aggre1_noc = {
+	.alloc_dyn_id = true,
 	.config = &icc_regmap_config,
 	.nodes = aggre1_noc_nodes,
 	.num_nodes = ARRAY_SIZE(aggre1_noc_nodes),
@@ -1678,6 +1618,7 @@ static struct qcom_icc_node * const aggre2_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8650_aggre2_noc = {
+	.alloc_dyn_id = true,
 	.config = &icc_regmap_config,
 	.nodes = aggre2_noc_nodes,
 	.num_nodes = ARRAY_SIZE(aggre2_noc_nodes),
@@ -1701,6 +1642,7 @@ static struct qcom_icc_node * const clk_virt_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8650_clk_virt = {
+	.alloc_dyn_id = true,
 	.nodes = clk_virt_nodes,
 	.num_nodes = ARRAY_SIZE(clk_virt_nodes),
 	.bcms = clk_virt_bcms,
@@ -1762,6 +1704,7 @@ static struct qcom_icc_node * const config_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8650_config_noc = {
+	.alloc_dyn_id = true,
 	.config = &icc_regmap_config,
 	.nodes = config_noc_nodes,
 	.num_nodes = ARRAY_SIZE(config_noc_nodes),
@@ -1790,6 +1733,7 @@ static struct qcom_icc_node * const cnoc_main_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8650_cnoc_main = {
+	.alloc_dyn_id = true,
 	.config = &icc_regmap_config,
 	.nodes = cnoc_main_nodes,
 	.num_nodes = ARRAY_SIZE(cnoc_main_nodes),
@@ -1823,6 +1767,7 @@ static struct qcom_icc_node * const gem_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8650_gem_noc = {
+	.alloc_dyn_id = true,
 	.config = &icc_regmap_config,
 	.nodes = gem_noc_nodes,
 	.num_nodes = ARRAY_SIZE(gem_noc_nodes),
@@ -1836,6 +1781,7 @@ static struct qcom_icc_node * const lpass_ag_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8650_lpass_ag_noc = {
+	.alloc_dyn_id = true,
 	.config = &icc_regmap_config,
 	.nodes = lpass_ag_noc_nodes,
 	.num_nodes = ARRAY_SIZE(lpass_ag_noc_nodes),
@@ -1851,6 +1797,7 @@ static struct qcom_icc_node * const lpass_lpiaon_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8650_lpass_lpiaon_noc = {
+	.alloc_dyn_id = true,
 	.config = &icc_regmap_config,
 	.nodes = lpass_lpiaon_noc_nodes,
 	.num_nodes = ARRAY_SIZE(lpass_lpiaon_noc_nodes),
@@ -1864,6 +1811,7 @@ static struct qcom_icc_node * const lpass_lpicx_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8650_lpass_lpicx_noc = {
+	.alloc_dyn_id = true,
 	.config = &icc_regmap_config,
 	.nodes = lpass_lpicx_noc_nodes,
 	.num_nodes = ARRAY_SIZE(lpass_lpicx_noc_nodes),
@@ -1880,6 +1828,7 @@ static struct qcom_icc_node * const mc_virt_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8650_mc_virt = {
+	.alloc_dyn_id = true,
 	.nodes = mc_virt_nodes,
 	.num_nodes = ARRAY_SIZE(mc_virt_nodes),
 	.bcms = mc_virt_bcms,
@@ -1908,6 +1857,7 @@ static struct qcom_icc_node * const mmss_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8650_mmss_noc = {
+	.alloc_dyn_id = true,
 	.config = &icc_regmap_config,
 	.nodes = mmss_noc_nodes,
 	.num_nodes = ARRAY_SIZE(mmss_noc_nodes),
@@ -1925,6 +1875,7 @@ static struct qcom_icc_node * const nsp_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8650_nsp_noc = {
+	.alloc_dyn_id = true,
 	.config = &icc_regmap_config,
 	.nodes = nsp_noc_nodes,
 	.num_nodes = ARRAY_SIZE(nsp_noc_nodes),
@@ -1945,6 +1896,7 @@ static struct qcom_icc_node * const pcie_anoc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8650_pcie_anoc = {
+	.alloc_dyn_id = true,
 	.config = &icc_regmap_config,
 	.nodes = pcie_anoc_nodes,
 	.num_nodes = ARRAY_SIZE(pcie_anoc_nodes),
@@ -1966,6 +1918,7 @@ static struct qcom_icc_node * const system_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sm8650_system_noc = {
+	.alloc_dyn_id = true,
 	.config = &icc_regmap_config,
 	.nodes = system_noc_nodes,
 	.num_nodes = ARRAY_SIZE(system_noc_nodes),
diff --git a/drivers/interconnect/qcom/sm8650.h b/drivers/interconnect/qcom/sm8650.h
deleted file mode 100644
index b6610225b38acce12c47046769bb0460a1ae4229..0000000000000000000000000000000000000000
--- a/drivers/interconnect/qcom/sm8650.h
+++ /dev/null
@@ -1,144 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * SM8650 interconnect IDs
- *
- * Copyright (c) 2020-2021, The Linux Foundation. All rights reserved.
- * Copyright (c) 2023, Linaro Limited
- */
-
-#ifndef __DRIVERS_INTERCONNECT_QCOM_SM8650_H
-#define __DRIVERS_INTERCONNECT_QCOM_SM8650_H
-
-#define SM8650_MASTER_A1NOC_SNOC		0
-#define SM8650_MASTER_A2NOC_SNOC		1
-#define SM8650_MASTER_ANOC_PCIE_GEM_NOC		2
-#define SM8650_MASTER_APPSS_PROC		3
-#define SM8650_MASTER_CAMNOC_HF			4
-#define SM8650_MASTER_CAMNOC_ICP		5
-#define SM8650_MASTER_CAMNOC_SF			6
-#define SM8650_MASTER_CDSP_HCP			7
-#define SM8650_MASTER_CDSP_PROC			8
-#define SM8650_MASTER_CNOC_CFG			9
-#define SM8650_MASTER_CNOC_MNOC_CFG		10
-#define SM8650_MASTER_COMPUTE_NOC		11
-#define SM8650_MASTER_CRYPTO			12
-#define SM8650_MASTER_GEM_NOC_CNOC		13
-#define SM8650_MASTER_GEM_NOC_PCIE_SNOC		14
-#define SM8650_MASTER_GFX3D			15
-#define SM8650_MASTER_GIC			16
-#define SM8650_MASTER_GPU_TCU			17
-#define SM8650_MASTER_IPA			18
-#define SM8650_MASTER_LLCC			19
-#define SM8650_MASTER_LPASS_GEM_NOC		20
-#define SM8650_MASTER_LPASS_LPINOC		21
-#define SM8650_MASTER_LPASS_PROC		22
-#define SM8650_MASTER_LPIAON_NOC		23
-#define SM8650_MASTER_MDP			24
-#define SM8650_MASTER_MNOC_HF_MEM_NOC		25
-#define SM8650_MASTER_MNOC_SF_MEM_NOC		26
-#define SM8650_MASTER_MSS_PROC			27
-#define SM8650_MASTER_PCIE_0			28
-#define SM8650_MASTER_PCIE_1			29
-#define SM8650_MASTER_PCIE_ANOC_CFG		30
-#define SM8650_MASTER_QDSS_BAM			31
-#define SM8650_MASTER_QDSS_ETR			32
-#define SM8650_MASTER_QDSS_ETR_1		33
-#define SM8650_MASTER_QSPI_0			34
-#define SM8650_MASTER_QUP_1			35
-#define SM8650_MASTER_QUP_2			36
-#define SM8650_MASTER_QUP_3			37
-#define SM8650_MASTER_QUP_CORE_0		38
-#define SM8650_MASTER_QUP_CORE_1		39
-#define SM8650_MASTER_QUP_CORE_2		40
-#define SM8650_MASTER_SDCC_2			41
-#define SM8650_MASTER_SDCC_4			42
-#define SM8650_MASTER_SNOC_SF_MEM_NOC		43
-#define SM8650_MASTER_SP			44
-#define SM8650_MASTER_SYS_TCU			45
-#define SM8650_MASTER_UBWC_P			46
-#define SM8650_MASTER_UBWC_P_TCU		47
-#define SM8650_MASTER_UFS_MEM			48
-#define SM8650_MASTER_USB3_0			49
-#define SM8650_MASTER_VIDEO			50
-#define SM8650_MASTER_VIDEO_CV_PROC		51
-#define SM8650_MASTER_VIDEO_PROC		52
-#define SM8650_MASTER_VIDEO_V_PROC		53
-#define SM8650_SLAVE_A1NOC_SNOC			54
-#define SM8650_SLAVE_A2NOC_SNOC			55
-#define SM8650_SLAVE_AHB2PHY_NORTH		56
-#define SM8650_SLAVE_AHB2PHY_SOUTH		57
-#define SM8650_SLAVE_ANOC_PCIE_GEM_NOC		58
-#define SM8650_SLAVE_AOSS			59
-#define SM8650_SLAVE_APPSS			60
-#define SM8650_SLAVE_CAMERA_CFG			61
-#define SM8650_SLAVE_CDSP_MEM_NOC		62
-#define SM8650_SLAVE_CLK_CTL			63
-#define SM8650_SLAVE_CNOC_CFG			64
-#define SM8650_SLAVE_CNOC_MNOC_CFG		65
-#define SM8650_SLAVE_CNOC_MSS			66
-#define SM8650_SLAVE_CPR_HMX			67
-#define SM8650_SLAVE_CPR_NSPCX			68
-#define SM8650_SLAVE_CRYPTO_0_CFG		69
-#define SM8650_SLAVE_CX_RDPM			70
-#define SM8650_SLAVE_DDRSS_CFG			71
-#define SM8650_SLAVE_DISPLAY_CFG		72
-#define SM8650_SLAVE_EBI1			73
-#define SM8650_SLAVE_GEM_NOC_CNOC		74
-#define SM8650_SLAVE_GFX3D_CFG			75
-#define SM8650_SLAVE_I2C			76
-#define SM8650_SLAVE_I3C_IBI0_CFG		77
-#define SM8650_SLAVE_I3C_IBI1_CFG		78
-#define SM8650_SLAVE_IMEM			79
-#define SM8650_SLAVE_IMEM_CFG			80
-#define SM8650_SLAVE_IPA_CFG			81
-#define SM8650_SLAVE_IPC_ROUTER_CFG		82
-#define SM8650_SLAVE_LLCC			83
-#define SM8650_SLAVE_LPASS_GEM_NOC		84
-#define SM8650_SLAVE_LPIAON_NOC_LPASS_AG_NOC	85
-#define SM8650_SLAVE_LPICX_NOC_LPIAON_NOC	86
-#define SM8650_SLAVE_MEM_NOC_PCIE_SNOC		87
-#define SM8650_SLAVE_MNOC_HF_MEM_NOC		88
-#define SM8650_SLAVE_MNOC_SF_MEM_NOC		89
-#define SM8650_SLAVE_MX_2_RDPM			90
-#define SM8650_SLAVE_MX_RDPM			91
-#define SM8650_SLAVE_NSP_QTB_CFG		92
-#define SM8650_SLAVE_PCIE_0			93
-#define SM8650_SLAVE_PCIE_1			94
-#define SM8650_SLAVE_PCIE_0_CFG			95
-#define SM8650_SLAVE_PCIE_1_CFG			96
-#define SM8650_SLAVE_PCIE_ANOC_CFG		97
-#define SM8650_SLAVE_PCIE_RSCC			98
-#define SM8650_SLAVE_PDM			99
-#define SM8650_SLAVE_PRNG			100
-#define SM8650_SLAVE_QDSS_CFG			101
-#define SM8650_SLAVE_QDSS_STM			102
-#define SM8650_SLAVE_QSPI_0			103
-#define SM8650_SLAVE_QUP_1			104
-#define SM8650_SLAVE_QUP_2			105
-#define SM8650_SLAVE_QUP_3			106
-#define SM8650_SLAVE_QUP_CORE_0			107
-#define SM8650_SLAVE_QUP_CORE_1			108
-#define SM8650_SLAVE_QUP_CORE_2			109
-#define SM8650_SLAVE_RBCPR_CX_CFG		110
-#define SM8650_SLAVE_RBCPR_MMCX_CFG		111
-#define SM8650_SLAVE_RBCPR_MXA_CFG		112
-#define SM8650_SLAVE_RBCPR_MXC_CFG		113
-#define SM8650_SLAVE_SDCC_2			114
-#define SM8650_SLAVE_SDCC_4			115
-#define SM8650_SLAVE_SERVICE_CNOC		116
-#define SM8650_SLAVE_SERVICE_CNOC_CFG		117
-#define SM8650_SLAVE_SERVICE_MNOC		118
-#define SM8650_SLAVE_SERVICE_PCIE_ANOC		119
-#define SM8650_SLAVE_SNOC_GEM_NOC_SF		120
-#define SM8650_SLAVE_SPSS_CFG			121
-#define SM8650_SLAVE_TCSR			122
-#define SM8650_SLAVE_TCU			123
-#define SM8650_SLAVE_TLMM			124
-#define SM8650_SLAVE_TME_CFG			125
-#define SM8650_SLAVE_UFS_MEM_CFG		126
-#define SM8650_SLAVE_USB3_0			127
-#define SM8650_SLAVE_VENUS_CFG			128
-#define SM8650_SLAVE_VSENSE_CTRL_CFG		129
-#define SM8650_MASTER_APSS_NOC			130
-
-#endif

-- 
2.47.3



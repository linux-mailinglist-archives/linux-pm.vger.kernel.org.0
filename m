Return-Path: <linux-pm+bounces-37205-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11CCCC25B3D
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 15:54:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E1C81B20DBA
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 14:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07FDB28466C;
	Fri, 31 Oct 2025 14:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KSDxYmYI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Olj15jne"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B072927281D
	for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2025 14:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761921951; cv=none; b=I9kI5ZlXEdKWADjAv+qQiDc6VWaokdCOWlvANh64jnVDq7EqB+kkdz+RdVumFuiwhyyZNjhXuuwwMorp0vIRM0ge/DYVthlxfl/rNr2eQcqN38yy19Wudj7Dng9E9yz0Ghs/NEz613rBy1a90fIhKHdpcuAzS6qf4fJT8g256ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761921951; c=relaxed/simple;
	bh=yfiBJ4yrKTfv0Z7+0OdjN5ZdQsDtq+BWzv0v7HOaojc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C1lSYkzBRBR6xjlvsD9Dcf3gYQfpjyMqZROkTW3g+K5P9S1SVt/wrQeo0AhIlnwAhiahFWsYYg4tLLcl7itkJ/2S5rfUMU6/DA8fRx1l9mLtm5D6DoS5MkVkrcqhdmnT/DKxg416ehSjr4Mc4z1unYvg7X/eTsnhNLRGOKhhIuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KSDxYmYI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Olj15jne; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59VAS3wN102861
	for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2025 14:45:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hJ1NMLQtSCKW9TSbUQkc3lMuQh/DooZ94okIrs18HgI=; b=KSDxYmYIW8bqiVAk
	ud1o6cFO0/g5A61dWENd5wifS9i7mtqQ/nEz7sNqlXe3w5OJfu/SMXM5IBqeYZ4F
	i4X0zH1JLzuLAXC8srlmCT4KYoRY+MPzBlJvi480UIXLVC4Vuqmw/lSKRrWVnnLO
	BTj2K9mWx4DnJYGiMqacO+ly2GxnWXaHSyy/xTHEmG2by1VtFrfYglWqgy+qJlD+
	zCKFCsWEzALmG4P4mJekNXecLnew92qW5/s7e1QqjnK3+FLoFjCTx59nJsy5iSub
	wPfme41CcjbChonmuRR7+fHiUYj/ZetH3ERq9HXRgcNMu0xqT/wPjx9rosgf+tGK
	OpRhCg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a4ahdkfy9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2025 14:45:44 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4e8984d8833so102336981cf.0
        for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2025 07:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761921943; x=1762526743; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hJ1NMLQtSCKW9TSbUQkc3lMuQh/DooZ94okIrs18HgI=;
        b=Olj15jne8MxmQTPompjJrgmTjuIsme+JmsIkvzGFiVScIA/AR1U54dZbWp/JOVo7D5
         MC7dP769Yq8C+Ylv+6b1G1mYq91mICcvCElqX0UHv28HiL6QiyMcZKqisXOj07uKmXKF
         144awEU0nIoLSrSR+LkRhoGOBVNYmIoOQ4O1tw+fFWaa2qjF5YZbA1niWoWqxRgF6beY
         pU+gqUOYenWz0cGW2tKn2bf8hNvKpsJQss72m3RLCb2Zfq7UpY4v0+WMOhB8EwPnZesd
         7iRNo7UjxmC7Sdl7xwd/TNyhMNJUPsMWf+UFnqHguR+MiN4mUs6G7JghWT+6kjemvajy
         h09A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761921943; x=1762526743;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hJ1NMLQtSCKW9TSbUQkc3lMuQh/DooZ94okIrs18HgI=;
        b=eKOl6nkvfgXL7Vy5ddTRiMi3C6uA3FxmqaMxJdJ5HDDwjUFc/TZcFo/NkB2l2lvYGO
         CCHzWvcDGQVHDL+M7UHuaW+MUsnfF9Bm42jNn3LYuDRGkMUjnfHCsHz65+d14WLsUput
         vn9+Td3OQ3DdvuYbmM5PUZVc2K35RbZ3brnto3XvQPelSgmGudJeiz4oQNMfo7zFUD7M
         VzNjilnepZA5NHot34Rx1zd7+OI17haPt6iEeTYWCWf/qSIW1vLn7xa8ZbXBKblC1G0j
         H6Mtr0UmJQ3fNgZn5Kt4yvFx30br6yjlhw6wXZCegTlZI2a/OzLiXvjRpTJYlEl9QkaA
         IjHw==
X-Forwarded-Encrypted: i=1; AJvYcCXG/z9ywx1BRGQfwDWLFxtZagF3zt0/ROL30pDF5Oik8+lQy5WODsOnjdloE4XvshXSX3fGQzU/1A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7etfR/h037aI2ioFH1tajsdLylTwPZNo86MDiOq8/BVVLi/Z8
	0ebDdA0Nm/0JyNwlvb/usJSWg9j+ukRK+nt1/xvlGNo9tc1G/jKhxFRh0+KkE6pjPUB9ym9mm+U
	yVKadCgiCA5a4B3rSGaucQElx3AwWnbfZt4pDT8WE9VG6xeU36e2fyvCFEO50VQ==
X-Gm-Gg: ASbGnctSA07pyw7HQANVUgNON0FXNjwYpc+8IM/oNLeGUr2RR6pZ0xLdDCsxiE85yzd
	EWM28g1UawolEqz4XLmFZfRRVKX5wHk7ufPAnYkBChnN7ed2Aj3uj20zQxI1ZETcsfF10z5XDK/
	FQbv3fQPM+8W8TkgRJIMlqlQNszJpzctjjTHXVekwTZga5vfO0lpSR55UvwKu55ThkUKjNcPcqV
	aaTnnDQWsAnx5icJXg10pXOEIw+3lf4wQr0pDBneRqKJJmtkC8qNR4GT+9wydqAa/sERCg6uBK7
	cWa/I1ajhqodFYYMFYvmqv2wgBUd2T3SOCG46DjSgA8ig61oD3Z2Iwxat9XsNHJxIdSr6mEIt4Q
	/qoV1KTXmg+uVLmBYk4b+TuuGO9pqqkjlgTY+bhn96Gi2d7aknIBu6A93bUH3BjBRJCf961hCGJ
	ND1wGRmga56cH9
X-Received: by 2002:ac8:5a95:0:b0:4ed:c7f:c744 with SMTP id d75a77b69052e-4ed30f87a6cmr45582581cf.42.1761921942938;
        Fri, 31 Oct 2025 07:45:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGZCAir71GozMZ6vdK9NRp4urBOWCQiOoybSbxiKaEirGbiL9EgGv6RZYhSPDLEPT0UbfIXg==
X-Received: by 2002:ac8:5a95:0:b0:4ed:c7f:c744 with SMTP id d75a77b69052e-4ed30f87a6cmr45581831cf.42.1761921942159;
        Fri, 31 Oct 2025 07:45:42 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5941f5bc218sm541405e87.93.2025.10.31.07.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 07:45:41 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 31 Oct 2025 16:45:24 +0200
Subject: [PATCH v3 08/25] interconnect: qcom: qcs615: convert to dynamic
 IDs
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-rework-icc-v3-8-0575304c9624@oss.qualcomm.com>
References: <20251031-rework-icc-v3-0-0575304c9624@oss.qualcomm.com>
In-Reply-To: <20251031-rework-icc-v3-0-0575304c9624@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=42421;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=yfiBJ4yrKTfv0Z7+0OdjN5ZdQsDtq+BWzv0v7HOaojc=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpBMuDljI4wCDdWCgvNhGXQrV7LiCByNd+pt7Jc
 g8H70uAQZqJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaQTLgwAKCRCLPIo+Aiko
 1aG9CACPozmB5d2hZbAmxeA8HaUhWT5FB30aBLwdXBOk883w/mpE/10zvWkMdxCcE6qOVwITUOB
 JoKcmV8DapfNGHJsp5Wh9m7NtCMm3hSm4XszmOx/8+g43GmTpMYsd4Abn5rdcov+ZWWjkjtUXwG
 hSijGIz5l88zWgDMXcX/TvRnOeWnyHLLJxKJ1cY3bMB6fcL0StioXXsZTWWEJ78/EDgGA3FAAR+
 t0EniDKdTaKFpM3iexCZNvythYv0/5xoN03l1uKFyC4Bgazpj7HRJJJg7uvYVw6J1+sHr+NcQBX
 pBSnmT+jikozZQtdFKgwY7nKx6vMBFkSKTxVdaCbJrYGH9MC
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDEzMyBTYWx0ZWRfX99JlbgzZxOaO
 Idx/XTEQj/GhVywCTNPnOuZFwPksG+mT8wm3iqNXHgxnBxfxQS3/pNCtE8y2p+9oUzBdbpJ9ySZ
 OluythxpgQDF6DPIKFe8yrkeegGyWzOIAYERKdcFDI2rW6hVgrdFgNvncsoM6QhcXVu+dnHgqA5
 UrPY8A1TJoUv30QOw7dYKstWlvZvgv/+pcetpXaJDCC2l6usCNGaBAaolpFyzlV5/4QWx0UXMDN
 R4IeTD4d7NioflynH6qXWetLjkxbuMZWkSkaAqiWuVuqFgljSpYSKchH20NQGTRdNuKqp/+KpZj
 brMtoqsE3XrAZpP6M/WlBu/37WZtvn0bdASge7k+Wog5A9CqfrNIVxDPqEFKFqOIaco1NSPmHKw
 LWmxJ2i8fGTkheBtF0dhIBRIbezELg==
X-Proofpoint-GUID: 2-rS_rsc0lhc7Pp8ssIy6YX4t0XXc_cP
X-Authority-Analysis: v=2.4 cv=TsnrRTXh c=1 sm=1 tr=0 ts=6904cb98 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=BQa14g1XHAziQ78bQWcA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: 2-rS_rsc0lhc7Pp8ssIy6YX4t0XXc_cP
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
 drivers/interconnect/qcom/qcs615.c | 519 +++++++++++++++++--------------------
 drivers/interconnect/qcom/qcs615.h | 128 ---------
 2 files changed, 239 insertions(+), 408 deletions(-)

diff --git a/drivers/interconnect/qcom/qcs615.c b/drivers/interconnect/qcom/qcs615.c
index 0549cfcbac64e4284ae5df1de3683985fffdcac8..fb0f623c0e645dce540afb9857c6f11a24a70cd8 100644
--- a/drivers/interconnect/qcom/qcs615.c
+++ b/drivers/interconnect/qcom/qcs615.c
@@ -13,1041 +13,992 @@
 
 #include "bcm-voter.h"
 #include "icc-rpmh.h"
-#include "qcs615.h"
+
+static struct qcom_icc_node qhm_a1noc_cfg;
+static struct qcom_icc_node qhm_qdss_bam;
+static struct qcom_icc_node qhm_qspi;
+static struct qcom_icc_node qhm_qup0;
+static struct qcom_icc_node qhm_qup1;
+static struct qcom_icc_node qnm_cnoc;
+static struct qcom_icc_node qxm_crypto;
+static struct qcom_icc_node qxm_ipa;
+static struct qcom_icc_node xm_emac_avb;
+static struct qcom_icc_node xm_pcie;
+static struct qcom_icc_node xm_qdss_etr;
+static struct qcom_icc_node xm_sdc1;
+static struct qcom_icc_node xm_sdc2;
+static struct qcom_icc_node xm_ufs_mem;
+static struct qcom_icc_node xm_usb2;
+static struct qcom_icc_node xm_usb3_0;
+static struct qcom_icc_node qxm_camnoc_hf0_uncomp;
+static struct qcom_icc_node qxm_camnoc_hf1_uncomp;
+static struct qcom_icc_node qxm_camnoc_sf_uncomp;
+static struct qcom_icc_node qhm_spdm;
+static struct qcom_icc_node qnm_snoc;
+static struct qcom_icc_node xm_qdss_dap;
+static struct qcom_icc_node qhm_cnoc;
+static struct qcom_icc_node acm_apps;
+static struct qcom_icc_node acm_gpu_tcu;
+static struct qcom_icc_node acm_sys_tcu;
+static struct qcom_icc_node qhm_gemnoc_cfg;
+static struct qcom_icc_node qnm_gpu;
+static struct qcom_icc_node qnm_mnoc_hf;
+static struct qcom_icc_node qnm_mnoc_sf;
+static struct qcom_icc_node qnm_snoc_gc;
+static struct qcom_icc_node qnm_snoc_sf;
+static struct qcom_icc_node llcc_mc;
+static struct qcom_icc_node qhm_mnoc_cfg;
+static struct qcom_icc_node qxm_camnoc_hf0;
+static struct qcom_icc_node qxm_camnoc_hf1;
+static struct qcom_icc_node qxm_camnoc_sf;
+static struct qcom_icc_node qxm_mdp0;
+static struct qcom_icc_node qxm_rot;
+static struct qcom_icc_node qxm_venus0;
+static struct qcom_icc_node qxm_venus_arm9;
+static struct qcom_icc_node qhm_snoc_cfg;
+static struct qcom_icc_node qnm_aggre1_noc;
+static struct qcom_icc_node qnm_gemnoc;
+static struct qcom_icc_node qnm_gemnoc_pcie;
+static struct qcom_icc_node qnm_lpass_anoc;
+static struct qcom_icc_node qnm_pcie_anoc;
+static struct qcom_icc_node qxm_pimem;
+static struct qcom_icc_node xm_gic;
+static struct qcom_icc_node qns_a1noc_snoc;
+static struct qcom_icc_node qns_lpass_snoc;
+static struct qcom_icc_node qns_pcie_snoc;
+static struct qcom_icc_node srvc_aggre2_noc;
+static struct qcom_icc_node qns_camnoc_uncomp;
+static struct qcom_icc_node qhs_a1_noc_cfg;
+static struct qcom_icc_node qhs_ahb2phy_east;
+static struct qcom_icc_node qhs_ahb2phy_west;
+static struct qcom_icc_node qhs_aop;
+static struct qcom_icc_node qhs_aoss;
+static struct qcom_icc_node qhs_camera_cfg;
+static struct qcom_icc_node qhs_clk_ctl;
+static struct qcom_icc_node qhs_cpr_cx;
+static struct qcom_icc_node qhs_cpr_mx;
+static struct qcom_icc_node qhs_crypto0_cfg;
+static struct qcom_icc_node qhs_ddrss_cfg;
+static struct qcom_icc_node qhs_display_cfg;
+static struct qcom_icc_node qhs_emac_avb_cfg;
+static struct qcom_icc_node qhs_glm;
+static struct qcom_icc_node qhs_gpuss_cfg;
+static struct qcom_icc_node qhs_imem_cfg;
+static struct qcom_icc_node qhs_ipa;
+static struct qcom_icc_node qhs_mnoc_cfg;
+static struct qcom_icc_node qhs_pcie_config;
+static struct qcom_icc_node qhs_pimem_cfg;
+static struct qcom_icc_node qhs_prng;
+static struct qcom_icc_node qhs_qdss_cfg;
+static struct qcom_icc_node qhs_qspi;
+static struct qcom_icc_node qhs_qup0;
+static struct qcom_icc_node qhs_qup1;
+static struct qcom_icc_node qhs_sdc1;
+static struct qcom_icc_node qhs_sdc2;
+static struct qcom_icc_node qhs_snoc_cfg;
+static struct qcom_icc_node qhs_spdm;
+static struct qcom_icc_node qhs_tcsr;
+static struct qcom_icc_node qhs_tlmm_east;
+static struct qcom_icc_node qhs_tlmm_south;
+static struct qcom_icc_node qhs_tlmm_west;
+static struct qcom_icc_node qhs_ufs_mem_cfg;
+static struct qcom_icc_node qhs_usb2;
+static struct qcom_icc_node qhs_usb3;
+static struct qcom_icc_node qhs_venus_cfg;
+static struct qcom_icc_node qhs_vsense_ctrl_cfg;
+static struct qcom_icc_node qns_cnoc_a2noc;
+static struct qcom_icc_node srvc_cnoc;
+static struct qcom_icc_node qhs_dc_noc_gemnoc;
+static struct qcom_icc_node qhs_llcc;
+static struct qcom_icc_node qhs_mdsp_ms_mpu_cfg;
+static struct qcom_icc_node qns_gem_noc_snoc;
+static struct qcom_icc_node qns_llcc;
+static struct qcom_icc_node qns_sys_pcie;
+static struct qcom_icc_node srvc_gemnoc;
+static struct qcom_icc_node ebi;
+static struct qcom_icc_node qns2_mem_noc;
+static struct qcom_icc_node qns_mem_noc_hf;
+static struct qcom_icc_node srvc_mnoc;
+static struct qcom_icc_node qhs_apss;
+static struct qcom_icc_node qns_cnoc;
+static struct qcom_icc_node qns_gemnoc_sf;
+static struct qcom_icc_node qns_memnoc_gc;
+static struct qcom_icc_node qxs_imem;
+static struct qcom_icc_node qxs_pimem;
+static struct qcom_icc_node srvc_snoc;
+static struct qcom_icc_node xs_pcie;
+static struct qcom_icc_node xs_qdss_stm;
+static struct qcom_icc_node xs_sys_tcu_cfg;
 
 static struct qcom_icc_node qhm_a1noc_cfg = {
 	.name = "qhm_a1noc_cfg",
-	.id = QCS615_MASTER_A1NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { QCS615_SLAVE_SERVICE_A2NOC },
+	.link_nodes = { &srvc_aggre2_noc },
 };
 
 static struct qcom_icc_node qhm_qdss_bam = {
 	.name = "qhm_qdss_bam",
-	.id = QCS615_MASTER_QDSS_BAM,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { QCS615_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc },
 };
 
 static struct qcom_icc_node qhm_qspi = {
 	.name = "qhm_qspi",
-	.id = QCS615_MASTER_QSPI,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { QCS615_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc },
 };
 
 static struct qcom_icc_node qhm_qup0 = {
 	.name = "qhm_qup0",
-	.id = QCS615_MASTER_QUP_0,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { QCS615_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc },
 };
 
 static struct qcom_icc_node qhm_qup1 = {
 	.name = "qhm_qup1",
-	.id = QCS615_MASTER_BLSP_1,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { QCS615_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc },
 };
 
 static struct qcom_icc_node qnm_cnoc = {
 	.name = "qnm_cnoc",
-	.id = QCS615_MASTER_CNOC_A2NOC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { QCS615_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc },
 };
 
 static struct qcom_icc_node qxm_crypto = {
 	.name = "qxm_crypto",
-	.id = QCS615_MASTER_CRYPTO,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { QCS615_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc },
 };
 
 static struct qcom_icc_node qxm_ipa = {
 	.name = "qxm_ipa",
-	.id = QCS615_MASTER_IPA,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { QCS615_SLAVE_LPASS_SNOC },
+	.link_nodes = { &qns_lpass_snoc },
 };
 
 static struct qcom_icc_node xm_emac_avb = {
 	.name = "xm_emac_avb",
-	.id = QCS615_MASTER_EMAC_EVB,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { QCS615_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc },
 };
 
 static struct qcom_icc_node xm_pcie = {
 	.name = "xm_pcie",
-	.id = QCS615_MASTER_PCIE,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { QCS615_SLAVE_ANOC_PCIE_SNOC },
+	.link_nodes = { &qns_pcie_snoc },
 };
 
 static struct qcom_icc_node xm_qdss_etr = {
 	.name = "xm_qdss_etr",
-	.id = QCS615_MASTER_QDSS_ETR,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { QCS615_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc },
 };
 
 static struct qcom_icc_node xm_sdc1 = {
 	.name = "xm_sdc1",
-	.id = QCS615_MASTER_SDCC_1,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { QCS615_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc },
 };
 
 static struct qcom_icc_node xm_sdc2 = {
 	.name = "xm_sdc2",
-	.id = QCS615_MASTER_SDCC_2,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { QCS615_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc },
 };
 
 static struct qcom_icc_node xm_ufs_mem = {
 	.name = "xm_ufs_mem",
-	.id = QCS615_MASTER_UFS_MEM,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { QCS615_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc },
 };
 
 static struct qcom_icc_node xm_usb2 = {
 	.name = "xm_usb2",
-	.id = QCS615_MASTER_USB2,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { QCS615_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc },
 };
 
 static struct qcom_icc_node xm_usb3_0 = {
 	.name = "xm_usb3_0",
-	.id = QCS615_MASTER_USB3_0,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { QCS615_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc },
 };
 
 static struct qcom_icc_node qxm_camnoc_hf0_uncomp = {
 	.name = "qxm_camnoc_hf0_uncomp",
-	.id = QCS615_MASTER_CAMNOC_HF0_UNCOMP,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { QCS615_SLAVE_CAMNOC_UNCOMP },
+	.link_nodes = { &qns_camnoc_uncomp },
 };
 
 static struct qcom_icc_node qxm_camnoc_hf1_uncomp = {
 	.name = "qxm_camnoc_hf1_uncomp",
-	.id = QCS615_MASTER_CAMNOC_HF1_UNCOMP,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { QCS615_SLAVE_CAMNOC_UNCOMP },
+	.link_nodes = { &qns_camnoc_uncomp },
 };
 
 static struct qcom_icc_node qxm_camnoc_sf_uncomp = {
 	.name = "qxm_camnoc_sf_uncomp",
-	.id = QCS615_MASTER_CAMNOC_SF_UNCOMP,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { QCS615_SLAVE_CAMNOC_UNCOMP },
+	.link_nodes = { &qns_camnoc_uncomp },
 };
 
 static struct qcom_icc_node qhm_spdm = {
 	.name = "qhm_spdm",
-	.id = QCS615_MASTER_SPDM,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { QCS615_SLAVE_CNOC_A2NOC },
+	.link_nodes = { &qns_cnoc_a2noc },
 };
 
 static struct qcom_icc_node qnm_snoc = {
 	.name = "qnm_snoc",
-	.id = QCS615_MASTER_SNOC_CNOC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 39,
-	.links = { QCS615_SLAVE_A1NOC_CFG, QCS615_SLAVE_AHB2PHY_EAST,
-		   QCS615_SLAVE_AHB2PHY_WEST, QCS615_SLAVE_AOP,
-		   QCS615_SLAVE_AOSS, QCS615_SLAVE_CAMERA_CFG,
-		   QCS615_SLAVE_CLK_CTL, QCS615_SLAVE_RBCPR_CX_CFG,
-		   QCS615_SLAVE_RBCPR_MX_CFG, QCS615_SLAVE_CRYPTO_0_CFG,
-		   QCS615_SLAVE_CNOC_DDRSS, QCS615_SLAVE_DISPLAY_CFG,
-		   QCS615_SLAVE_EMAC_AVB_CFG, QCS615_SLAVE_GLM,
-		   QCS615_SLAVE_GFX3D_CFG, QCS615_SLAVE_IMEM_CFG,
-		   QCS615_SLAVE_IPA_CFG, QCS615_SLAVE_CNOC_MNOC_CFG,
-		   QCS615_SLAVE_PCIE_CFG, QCS615_SLAVE_PIMEM_CFG,
-		   QCS615_SLAVE_PRNG, QCS615_SLAVE_QDSS_CFG,
-		   QCS615_SLAVE_QSPI, QCS615_SLAVE_QUP_0,
-		   QCS615_SLAVE_QUP_1, QCS615_SLAVE_SDCC_1,
-		   QCS615_SLAVE_SDCC_2, QCS615_SLAVE_SNOC_CFG,
-		   QCS615_SLAVE_SPDM_WRAPPER, QCS615_SLAVE_TCSR,
-		   QCS615_SLAVE_TLMM_EAST, QCS615_SLAVE_TLMM_SOUTH,
-		   QCS615_SLAVE_TLMM_WEST, QCS615_SLAVE_UFS_MEM_CFG,
-		   QCS615_SLAVE_USB2, QCS615_SLAVE_USB3,
-		   QCS615_SLAVE_VENUS_CFG, QCS615_SLAVE_VSENSE_CTRL_CFG,
-		   QCS615_SLAVE_SERVICE_CNOC },
+	.link_nodes = { &qhs_a1_noc_cfg, &qhs_ahb2phy_east,
+			&qhs_ahb2phy_west, &qhs_aop,
+			&qhs_aoss, &qhs_camera_cfg,
+			&qhs_clk_ctl, &qhs_cpr_cx,
+			&qhs_cpr_mx, &qhs_crypto0_cfg,
+			&qhs_ddrss_cfg, &qhs_display_cfg,
+			&qhs_emac_avb_cfg, &qhs_glm,
+			&qhs_gpuss_cfg, &qhs_imem_cfg,
+			&qhs_ipa, &qhs_mnoc_cfg,
+			&qhs_pcie_config, &qhs_pimem_cfg,
+			&qhs_prng, &qhs_qdss_cfg,
+			&qhs_qspi, &qhs_qup0,
+			&qhs_qup1, &qhs_sdc1,
+			&qhs_sdc2, &qhs_snoc_cfg,
+			&qhs_spdm, &qhs_tcsr,
+			&qhs_tlmm_east, &qhs_tlmm_south,
+			&qhs_tlmm_west, &qhs_ufs_mem_cfg,
+			&qhs_usb2, &qhs_usb3,
+			&qhs_venus_cfg, &qhs_vsense_ctrl_cfg,
+			&srvc_cnoc },
 };
 
 static struct qcom_icc_node xm_qdss_dap = {
 	.name = "xm_qdss_dap",
-	.id = QCS615_MASTER_QDSS_DAP,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 40,
-	.links = { QCS615_SLAVE_A1NOC_CFG, QCS615_SLAVE_AHB2PHY_EAST,
-		   QCS615_SLAVE_AHB2PHY_WEST, QCS615_SLAVE_AOP,
-		   QCS615_SLAVE_AOSS, QCS615_SLAVE_CAMERA_CFG,
-		   QCS615_SLAVE_CLK_CTL, QCS615_SLAVE_RBCPR_CX_CFG,
-		   QCS615_SLAVE_RBCPR_MX_CFG, QCS615_SLAVE_CRYPTO_0_CFG,
-		   QCS615_SLAVE_CNOC_DDRSS, QCS615_SLAVE_DISPLAY_CFG,
-		   QCS615_SLAVE_EMAC_AVB_CFG, QCS615_SLAVE_GLM,
-		   QCS615_SLAVE_GFX3D_CFG, QCS615_SLAVE_IMEM_CFG,
-		   QCS615_SLAVE_IPA_CFG, QCS615_SLAVE_CNOC_MNOC_CFG,
-		   QCS615_SLAVE_PCIE_CFG, QCS615_SLAVE_PIMEM_CFG,
-		   QCS615_SLAVE_PRNG, QCS615_SLAVE_QDSS_CFG,
-		   QCS615_SLAVE_QSPI, QCS615_SLAVE_QUP_0,
-		   QCS615_SLAVE_QUP_1, QCS615_SLAVE_SDCC_1,
-		   QCS615_SLAVE_SDCC_2, QCS615_SLAVE_SNOC_CFG,
-		   QCS615_SLAVE_SPDM_WRAPPER, QCS615_SLAVE_TCSR,
-		   QCS615_SLAVE_TLMM_EAST, QCS615_SLAVE_TLMM_SOUTH,
-		   QCS615_SLAVE_TLMM_WEST, QCS615_SLAVE_UFS_MEM_CFG,
-		   QCS615_SLAVE_USB2, QCS615_SLAVE_USB3,
-		   QCS615_SLAVE_VENUS_CFG, QCS615_SLAVE_VSENSE_CTRL_CFG,
-		   QCS615_SLAVE_CNOC_A2NOC, QCS615_SLAVE_SERVICE_CNOC },
+	.link_nodes = { &qhs_a1_noc_cfg, &qhs_ahb2phy_east,
+			&qhs_ahb2phy_west, &qhs_aop,
+			&qhs_aoss, &qhs_camera_cfg,
+			&qhs_clk_ctl, &qhs_cpr_cx,
+			&qhs_cpr_mx, &qhs_crypto0_cfg,
+			&qhs_ddrss_cfg, &qhs_display_cfg,
+			&qhs_emac_avb_cfg, &qhs_glm,
+			&qhs_gpuss_cfg, &qhs_imem_cfg,
+			&qhs_ipa, &qhs_mnoc_cfg,
+			&qhs_pcie_config, &qhs_pimem_cfg,
+			&qhs_prng, &qhs_qdss_cfg,
+			&qhs_qspi, &qhs_qup0,
+			&qhs_qup1, &qhs_sdc1,
+			&qhs_sdc2, &qhs_snoc_cfg,
+			&qhs_spdm, &qhs_tcsr,
+			&qhs_tlmm_east, &qhs_tlmm_south,
+			&qhs_tlmm_west, &qhs_ufs_mem_cfg,
+			&qhs_usb2, &qhs_usb3,
+			&qhs_venus_cfg, &qhs_vsense_ctrl_cfg,
+			&qns_cnoc_a2noc, &srvc_cnoc },
 };
 
 static struct qcom_icc_node qhm_cnoc = {
 	.name = "qhm_cnoc",
-	.id = QCS615_MASTER_CNOC_DC_NOC,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 2,
-	.links = { QCS615_SLAVE_DC_NOC_GEMNOC, QCS615_SLAVE_LLCC_CFG },
+	.link_nodes = { &qhs_dc_noc_gemnoc, &qhs_llcc },
 };
 
 static struct qcom_icc_node acm_apps = {
 	.name = "acm_apps",
-	.id = QCS615_MASTER_APPSS_PROC,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 3,
-	.links = { QCS615_SLAVE_GEM_NOC_SNOC, QCS615_SLAVE_LLCC,
-		   QCS615_SLAVE_MEM_NOC_PCIE_SNOC },
+	.link_nodes = { &qns_gem_noc_snoc, &qns_llcc,
+			&qns_sys_pcie },
 };
 
 static struct qcom_icc_node acm_gpu_tcu = {
 	.name = "acm_gpu_tcu",
-	.id = QCS615_MASTER_GPU_TCU,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 2,
-	.links = { QCS615_SLAVE_GEM_NOC_SNOC, QCS615_SLAVE_LLCC },
+	.link_nodes = { &qns_gem_noc_snoc, &qns_llcc },
 };
 
 static struct qcom_icc_node acm_sys_tcu = {
 	.name = "acm_sys_tcu",
-	.id = QCS615_MASTER_SYS_TCU,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 2,
-	.links = { QCS615_SLAVE_GEM_NOC_SNOC, QCS615_SLAVE_LLCC },
+	.link_nodes = { &qns_gem_noc_snoc, &qns_llcc },
 };
 
 static struct qcom_icc_node qhm_gemnoc_cfg = {
 	.name = "qhm_gemnoc_cfg",
-	.id = QCS615_MASTER_GEM_NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 2,
-	.links = { QCS615_SLAVE_MSS_PROC_MS_MPU_CFG, QCS615_SLAVE_SERVICE_GEM_NOC },
+	.link_nodes = { &qhs_mdsp_ms_mpu_cfg, &srvc_gemnoc },
 };
 
 static struct qcom_icc_node qnm_gpu = {
 	.name = "qnm_gpu",
-	.id = QCS615_MASTER_GFX3D,
 	.channels = 2,
 	.buswidth = 32,
 	.num_links = 2,
-	.links = { QCS615_SLAVE_GEM_NOC_SNOC, QCS615_SLAVE_LLCC },
+	.link_nodes = { &qns_gem_noc_snoc, &qns_llcc },
 };
 
 static struct qcom_icc_node qnm_mnoc_hf = {
 	.name = "qnm_mnoc_hf",
-	.id = QCS615_MASTER_MNOC_HF_MEM_NOC,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { QCS615_SLAVE_LLCC },
+	.link_nodes = { &qns_llcc },
 };
 
 static struct qcom_icc_node qnm_mnoc_sf = {
 	.name = "qnm_mnoc_sf",
-	.id = QCS615_MASTER_MNOC_SF_MEM_NOC,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 2,
-	.links = { QCS615_SLAVE_GEM_NOC_SNOC, QCS615_SLAVE_LLCC },
+	.link_nodes = { &qns_gem_noc_snoc, &qns_llcc },
 };
 
 static struct qcom_icc_node qnm_snoc_gc = {
 	.name = "qnm_snoc_gc",
-	.id = QCS615_MASTER_SNOC_GC_MEM_NOC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { QCS615_SLAVE_LLCC },
+	.link_nodes = { &qns_llcc },
 };
 
 static struct qcom_icc_node qnm_snoc_sf = {
 	.name = "qnm_snoc_sf",
-	.id = QCS615_MASTER_SNOC_SF_MEM_NOC,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { QCS615_SLAVE_LLCC },
+	.link_nodes = { &qns_llcc },
 };
 
 static struct qcom_icc_node llcc_mc = {
 	.name = "llcc_mc",
-	.id = QCS615_MASTER_LLCC,
 	.channels = 2,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { QCS615_SLAVE_EBI1 },
+	.link_nodes = { &ebi },
 };
 
 static struct qcom_icc_node qhm_mnoc_cfg = {
 	.name = "qhm_mnoc_cfg",
-	.id = QCS615_MASTER_CNOC_MNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { QCS615_SLAVE_SERVICE_MNOC },
+	.link_nodes = { &srvc_mnoc },
 };
 
 static struct qcom_icc_node qxm_camnoc_hf0 = {
 	.name = "qxm_camnoc_hf0",
-	.id = QCS615_MASTER_CAMNOC_HF0,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { QCS615_SLAVE_MNOC_HF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_hf },
 };
 
 static struct qcom_icc_node qxm_camnoc_hf1 = {
 	.name = "qxm_camnoc_hf1",
-	.id = QCS615_MASTER_CAMNOC_HF1,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { QCS615_SLAVE_MNOC_HF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_hf },
 };
 
 static struct qcom_icc_node qxm_camnoc_sf = {
 	.name = "qxm_camnoc_sf",
-	.id = QCS615_MASTER_CAMNOC_SF,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { QCS615_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns2_mem_noc },
 };
 
 static struct qcom_icc_node qxm_mdp0 = {
 	.name = "qxm_mdp0",
-	.id = QCS615_MASTER_MDP0,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { QCS615_SLAVE_MNOC_HF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_hf },
 };
 
 static struct qcom_icc_node qxm_rot = {
 	.name = "qxm_rot",
-	.id = QCS615_MASTER_ROTATOR,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { QCS615_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns2_mem_noc },
 };
 
 static struct qcom_icc_node qxm_venus0 = {
 	.name = "qxm_venus0",
-	.id = QCS615_MASTER_VIDEO_P0,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { QCS615_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns2_mem_noc },
 };
 
 static struct qcom_icc_node qxm_venus_arm9 = {
 	.name = "qxm_venus_arm9",
-	.id = QCS615_MASTER_VIDEO_PROC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { QCS615_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns2_mem_noc },
 };
 
 static struct qcom_icc_node qhm_snoc_cfg = {
 	.name = "qhm_snoc_cfg",
-	.id = QCS615_MASTER_SNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { QCS615_SLAVE_SERVICE_SNOC },
+	.link_nodes = { &srvc_snoc },
 };
 
 static struct qcom_icc_node qnm_aggre1_noc = {
 	.name = "qnm_aggre1_noc",
-	.id = QCS615_MASTER_A1NOC_SNOC,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 8,
-	.links = { QCS615_SLAVE_APPSS, QCS615_SLAVE_SNOC_CNOC,
-		   QCS615_SLAVE_SNOC_GEM_NOC_SF, QCS615_SLAVE_IMEM,
-		   QCS615_SLAVE_PIMEM, QCS615_SLAVE_PCIE_0,
-		   QCS615_SLAVE_QDSS_STM, QCS615_SLAVE_TCU },
+	.link_nodes = { &qhs_apss, &qns_cnoc,
+			&qns_gemnoc_sf, &qxs_imem,
+			&qxs_pimem, &xs_pcie,
+			&xs_qdss_stm, &xs_sys_tcu_cfg },
 };
 
 static struct qcom_icc_node qnm_gemnoc = {
 	.name = "qnm_gemnoc",
-	.id = QCS615_MASTER_GEM_NOC_SNOC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 6,
-	.links = { QCS615_SLAVE_APPSS, QCS615_SLAVE_SNOC_CNOC,
-		   QCS615_SLAVE_IMEM, QCS615_SLAVE_PIMEM,
-		   QCS615_SLAVE_QDSS_STM, QCS615_SLAVE_TCU },
+	.link_nodes = { &qhs_apss, &qns_cnoc,
+			&qxs_imem, &qxs_pimem,
+			&xs_qdss_stm, &xs_sys_tcu_cfg },
 };
 
 static struct qcom_icc_node qnm_gemnoc_pcie = {
 	.name = "qnm_gemnoc_pcie",
-	.id = QCS615_MASTER_GEM_NOC_PCIE_SNOC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { QCS615_SLAVE_PCIE_0 },
+	.link_nodes = { &xs_pcie },
 };
 
 static struct qcom_icc_node qnm_lpass_anoc = {
 	.name = "qnm_lpass_anoc",
-	.id = QCS615_MASTER_LPASS_ANOC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 7,
-	.links = { QCS615_SLAVE_APPSS, QCS615_SLAVE_SNOC_CNOC,
-		   QCS615_SLAVE_SNOC_GEM_NOC_SF, QCS615_SLAVE_IMEM,
-		   QCS615_SLAVE_PIMEM, QCS615_SLAVE_PCIE_0,
-		   QCS615_SLAVE_QDSS_STM },
+	.link_nodes = { &qhs_apss, &qns_cnoc,
+			&qns_gemnoc_sf, &qxs_imem,
+			&qxs_pimem, &xs_pcie,
+			&xs_qdss_stm },
 };
 
 static struct qcom_icc_node qnm_pcie_anoc = {
 	.name = "qnm_pcie_anoc",
-	.id = QCS615_MASTER_ANOC_PCIE_SNOC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 5,
-	.links = { QCS615_SLAVE_APPSS, QCS615_SLAVE_SNOC_CNOC,
-		   QCS615_SLAVE_SNOC_GEM_NOC_SF, QCS615_SLAVE_IMEM,
-		   QCS615_SLAVE_QDSS_STM },
+	.link_nodes = { &qhs_apss, &qns_cnoc,
+			&qns_gemnoc_sf, &qxs_imem,
+			&xs_qdss_stm },
 };
 
 static struct qcom_icc_node qxm_pimem = {
 	.name = "qxm_pimem",
-	.id = QCS615_MASTER_PIMEM,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 2,
-	.links = { QCS615_SLAVE_SNOC_MEM_NOC_GC, QCS615_SLAVE_IMEM },
+	.link_nodes = { &qns_memnoc_gc, &qxs_imem },
 };
 
 static struct qcom_icc_node xm_gic = {
 	.name = "xm_gic",
-	.id = QCS615_MASTER_GIC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 2,
-	.links = { QCS615_SLAVE_SNOC_MEM_NOC_GC, QCS615_SLAVE_IMEM },
+	.link_nodes = { &qns_memnoc_gc, &qxs_imem },
 };
 
 static struct qcom_icc_node qns_a1noc_snoc = {
 	.name = "qns_a1noc_snoc",
-	.id = QCS615_SLAVE_A1NOC_SNOC,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { QCS615_MASTER_A1NOC_SNOC },
+	.link_nodes = { &qnm_aggre1_noc },
 };
 
 static struct qcom_icc_node qns_lpass_snoc = {
 	.name = "qns_lpass_snoc",
-	.id = QCS615_SLAVE_LPASS_SNOC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { QCS615_MASTER_LPASS_ANOC },
+	.link_nodes = { &qnm_lpass_anoc },
 };
 
 static struct qcom_icc_node qns_pcie_snoc = {
 	.name = "qns_pcie_snoc",
-	.id = QCS615_SLAVE_ANOC_PCIE_SNOC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { QCS615_MASTER_ANOC_PCIE_SNOC },
+	.link_nodes = { &qnm_pcie_anoc },
 };
 
 static struct qcom_icc_node srvc_aggre2_noc = {
 	.name = "srvc_aggre2_noc",
-	.id = QCS615_SLAVE_SERVICE_A2NOC,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qns_camnoc_uncomp = {
 	.name = "qns_camnoc_uncomp",
-	.id = QCS615_SLAVE_CAMNOC_UNCOMP,
 	.channels = 1,
 	.buswidth = 32,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_a1_noc_cfg = {
 	.name = "qhs_a1_noc_cfg",
-	.id = QCS615_SLAVE_A1NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { QCS615_MASTER_A1NOC_CFG },
+	.link_nodes = { &qhm_a1noc_cfg },
 };
 
 static struct qcom_icc_node qhs_ahb2phy_east = {
 	.name = "qhs_ahb2phy_east",
-	.id = QCS615_SLAVE_AHB2PHY_EAST,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_ahb2phy_west = {
 	.name = "qhs_ahb2phy_west",
-	.id = QCS615_SLAVE_AHB2PHY_WEST,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_aop = {
 	.name = "qhs_aop",
-	.id = QCS615_SLAVE_AOP,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_aoss = {
 	.name = "qhs_aoss",
-	.id = QCS615_SLAVE_AOSS,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_camera_cfg = {
 	.name = "qhs_camera_cfg",
-	.id = QCS615_SLAVE_CAMERA_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_clk_ctl = {
 	.name = "qhs_clk_ctl",
-	.id = QCS615_SLAVE_CLK_CTL,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_cpr_cx = {
 	.name = "qhs_cpr_cx",
-	.id = QCS615_SLAVE_RBCPR_CX_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_cpr_mx = {
 	.name = "qhs_cpr_mx",
-	.id = QCS615_SLAVE_RBCPR_MX_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_crypto0_cfg = {
 	.name = "qhs_crypto0_cfg",
-	.id = QCS615_SLAVE_CRYPTO_0_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_ddrss_cfg = {
 	.name = "qhs_ddrss_cfg",
-	.id = QCS615_SLAVE_CNOC_DDRSS,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { QCS615_MASTER_CNOC_DC_NOC },
+	.link_nodes = { &qhm_cnoc },
 };
 
 static struct qcom_icc_node qhs_display_cfg = {
 	.name = "qhs_display_cfg",
-	.id = QCS615_SLAVE_DISPLAY_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_emac_avb_cfg = {
 	.name = "qhs_emac_avb_cfg",
-	.id = QCS615_SLAVE_EMAC_AVB_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_glm = {
 	.name = "qhs_glm",
-	.id = QCS615_SLAVE_GLM,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_gpuss_cfg = {
 	.name = "qhs_gpuss_cfg",
-	.id = QCS615_SLAVE_GFX3D_CFG,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_imem_cfg = {
 	.name = "qhs_imem_cfg",
-	.id = QCS615_SLAVE_IMEM_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_ipa = {
 	.name = "qhs_ipa",
-	.id = QCS615_SLAVE_IPA_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_mnoc_cfg = {
 	.name = "qhs_mnoc_cfg",
-	.id = QCS615_SLAVE_CNOC_MNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { QCS615_MASTER_CNOC_MNOC_CFG },
+	.link_nodes = { &qhm_mnoc_cfg },
 };
 
 static struct qcom_icc_node qhs_pcie_config = {
 	.name = "qhs_pcie_config",
-	.id = QCS615_SLAVE_PCIE_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_pimem_cfg = {
 	.name = "qhs_pimem_cfg",
-	.id = QCS615_SLAVE_PIMEM_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_prng = {
 	.name = "qhs_prng",
-	.id = QCS615_SLAVE_PRNG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_qdss_cfg = {
 	.name = "qhs_qdss_cfg",
-	.id = QCS615_SLAVE_QDSS_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_qspi = {
 	.name = "qhs_qspi",
-	.id = QCS615_SLAVE_QSPI,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_qup0 = {
 	.name = "qhs_qup0",
-	.id = QCS615_SLAVE_QUP_0,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_qup1 = {
 	.name = "qhs_qup1",
-	.id = QCS615_SLAVE_QUP_1,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_sdc1 = {
 	.name = "qhs_sdc1",
-	.id = QCS615_SLAVE_SDCC_1,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_sdc2 = {
 	.name = "qhs_sdc2",
-	.id = QCS615_SLAVE_SDCC_2,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_snoc_cfg = {
 	.name = "qhs_snoc_cfg",
-	.id = QCS615_SLAVE_SNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { QCS615_MASTER_SNOC_CFG },
+	.link_nodes = { &qhm_snoc_cfg },
 };
 
 static struct qcom_icc_node qhs_spdm = {
 	.name = "qhs_spdm",
-	.id = QCS615_SLAVE_SPDM_WRAPPER,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_tcsr = {
 	.name = "qhs_tcsr",
-	.id = QCS615_SLAVE_TCSR,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_tlmm_east = {
 	.name = "qhs_tlmm_east",
-	.id = QCS615_SLAVE_TLMM_EAST,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_tlmm_south = {
 	.name = "qhs_tlmm_south",
-	.id = QCS615_SLAVE_TLMM_SOUTH,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_tlmm_west = {
 	.name = "qhs_tlmm_west",
-	.id = QCS615_SLAVE_TLMM_WEST,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_ufs_mem_cfg = {
 	.name = "qhs_ufs_mem_cfg",
-	.id = QCS615_SLAVE_UFS_MEM_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_usb2 = {
 	.name = "qhs_usb2",
-	.id = QCS615_SLAVE_USB2,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_usb3 = {
 	.name = "qhs_usb3",
-	.id = QCS615_SLAVE_USB3,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_venus_cfg = {
 	.name = "qhs_venus_cfg",
-	.id = QCS615_SLAVE_VENUS_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_vsense_ctrl_cfg = {
 	.name = "qhs_vsense_ctrl_cfg",
-	.id = QCS615_SLAVE_VSENSE_CTRL_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qns_cnoc_a2noc = {
 	.name = "qns_cnoc_a2noc",
-	.id = QCS615_SLAVE_CNOC_A2NOC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { QCS615_MASTER_CNOC_A2NOC },
+	.link_nodes = { &qnm_cnoc },
 };
 
 static struct qcom_icc_node srvc_cnoc = {
 	.name = "srvc_cnoc",
-	.id = QCS615_SLAVE_SERVICE_CNOC,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_dc_noc_gemnoc = {
 	.name = "qhs_dc_noc_gemnoc",
-	.id = QCS615_SLAVE_DC_NOC_GEMNOC,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { QCS615_MASTER_GEM_NOC_CFG },
+	.link_nodes = { &qhm_gemnoc_cfg },
 };
 
 static struct qcom_icc_node qhs_llcc = {
 	.name = "qhs_llcc",
-	.id = QCS615_SLAVE_LLCC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_mdsp_ms_mpu_cfg = {
 	.name = "qhs_mdsp_ms_mpu_cfg",
-	.id = QCS615_SLAVE_MSS_PROC_MS_MPU_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qns_gem_noc_snoc = {
 	.name = "qns_gem_noc_snoc",
-	.id = QCS615_SLAVE_GEM_NOC_SNOC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { QCS615_MASTER_GEM_NOC_SNOC },
+	.link_nodes = { &qnm_gemnoc },
 };
 
 static struct qcom_icc_node qns_llcc = {
 	.name = "qns_llcc",
-	.id = QCS615_SLAVE_LLCC,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { QCS615_MASTER_LLCC },
+	.link_nodes = { &llcc_mc },
 };
 
 static struct qcom_icc_node qns_sys_pcie = {
 	.name = "qns_sys_pcie",
-	.id = QCS615_SLAVE_MEM_NOC_PCIE_SNOC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { QCS615_MASTER_GEM_NOC_PCIE_SNOC },
+	.link_nodes = { &qnm_gemnoc_pcie },
 };
 
 static struct qcom_icc_node srvc_gemnoc = {
 	.name = "srvc_gemnoc",
-	.id = QCS615_SLAVE_SERVICE_GEM_NOC,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node ebi = {
 	.name = "ebi",
-	.id = QCS615_SLAVE_EBI1,
 	.channels = 2,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qns2_mem_noc = {
 	.name = "qns2_mem_noc",
-	.id = QCS615_SLAVE_MNOC_SF_MEM_NOC,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { QCS615_MASTER_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qnm_mnoc_sf },
 };
 
 static struct qcom_icc_node qns_mem_noc_hf = {
 	.name = "qns_mem_noc_hf",
-	.id = QCS615_SLAVE_MNOC_HF_MEM_NOC,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { QCS615_MASTER_MNOC_HF_MEM_NOC },
+	.link_nodes = { &qnm_mnoc_hf },
 };
 
 static struct qcom_icc_node srvc_mnoc = {
 	.name = "srvc_mnoc",
-	.id = QCS615_SLAVE_SERVICE_MNOC,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_apss = {
 	.name = "qhs_apss",
-	.id = QCS615_SLAVE_APPSS,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qns_cnoc = {
 	.name = "qns_cnoc",
-	.id = QCS615_SLAVE_SNOC_CNOC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { QCS615_MASTER_SNOC_CNOC },
+	.link_nodes = { &qnm_snoc },
 };
 
 static struct qcom_icc_node qns_gemnoc_sf = {
 	.name = "qns_gemnoc_sf",
-	.id = QCS615_SLAVE_SNOC_GEM_NOC_SF,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { QCS615_MASTER_SNOC_SF_MEM_NOC },
+	.link_nodes = { &qnm_snoc_sf },
 };
 
 static struct qcom_icc_node qns_memnoc_gc = {
 	.name = "qns_memnoc_gc",
-	.id = QCS615_SLAVE_SNOC_MEM_NOC_GC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { QCS615_MASTER_SNOC_GC_MEM_NOC },
+	.link_nodes = { &qnm_snoc_gc },
 };
 
 static struct qcom_icc_node qxs_imem = {
 	.name = "qxs_imem",
-	.id = QCS615_SLAVE_IMEM,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qxs_pimem = {
 	.name = "qxs_pimem",
-	.id = QCS615_SLAVE_PIMEM,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node srvc_snoc = {
 	.name = "srvc_snoc",
-	.id = QCS615_SLAVE_SERVICE_SNOC,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node xs_pcie = {
 	.name = "xs_pcie",
-	.id = QCS615_SLAVE_PCIE_0,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node xs_qdss_stm = {
 	.name = "xs_qdss_stm",
-	.id = QCS615_SLAVE_QDSS_STM,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node xs_sys_tcu_cfg = {
 	.name = "xs_sys_tcu_cfg",
-	.id = QCS615_SLAVE_TCU,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 0,
 };
 
 static struct qcom_icc_bcm bcm_acv = {
@@ -1263,6 +1214,7 @@ static struct qcom_icc_node * const aggre1_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc qcs615_aggre1_noc = {
+	.alloc_dyn_id = true,
 	.nodes = aggre1_noc_nodes,
 	.num_nodes = ARRAY_SIZE(aggre1_noc_nodes),
 	.bcms = aggre1_noc_bcms,
@@ -1281,6 +1233,7 @@ static struct qcom_icc_node * const camnoc_virt_nodes[] = {
 };
 
 static const struct qcom_icc_desc qcs615_camnoc_virt = {
+	.alloc_dyn_id = true,
 	.nodes = camnoc_virt_nodes,
 	.num_nodes = ARRAY_SIZE(camnoc_virt_nodes),
 	.bcms = camnoc_virt_bcms,
@@ -1339,6 +1292,7 @@ static struct qcom_icc_node * const config_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc qcs615_config_noc = {
+	.alloc_dyn_id = true,
 	.nodes = config_noc_nodes,
 	.num_nodes = ARRAY_SIZE(config_noc_nodes),
 	.bcms = config_noc_bcms,
@@ -1352,6 +1306,7 @@ static struct qcom_icc_node * const dc_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc qcs615_dc_noc = {
+	.alloc_dyn_id = true,
 	.nodes = dc_noc_nodes,
 	.num_nodes = ARRAY_SIZE(dc_noc_nodes),
 };
@@ -1381,6 +1336,7 @@ static struct qcom_icc_node * const gem_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc qcs615_gem_noc = {
+	.alloc_dyn_id = true,
 	.nodes = gem_noc_nodes,
 	.num_nodes = ARRAY_SIZE(gem_noc_nodes),
 	.bcms = gem_noc_bcms,
@@ -1398,6 +1354,7 @@ static struct qcom_icc_node * const mc_virt_nodes[] = {
 };
 
 static const struct qcom_icc_desc qcs615_mc_virt = {
+	.alloc_dyn_id = true,
 	.nodes = mc_virt_nodes,
 	.num_nodes = ARRAY_SIZE(mc_virt_nodes),
 	.bcms = mc_virt_bcms,
@@ -1426,6 +1383,7 @@ static struct qcom_icc_node * const mmss_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc qcs615_mmss_noc = {
+	.alloc_dyn_id = true,
 	.nodes = mmss_noc_nodes,
 	.num_nodes = ARRAY_SIZE(mmss_noc_nodes),
 	.bcms = mmss_noc_bcms,
@@ -1468,6 +1426,7 @@ static struct qcom_icc_node * const system_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc qcs615_system_noc = {
+	.alloc_dyn_id = true,
 	.nodes = system_noc_nodes,
 	.num_nodes = ARRAY_SIZE(system_noc_nodes),
 	.bcms = system_noc_bcms,
diff --git a/drivers/interconnect/qcom/qcs615.h b/drivers/interconnect/qcom/qcs615.h
deleted file mode 100644
index 66e66c7e23d4ecaf92c2697e695980c3f8663664..0000000000000000000000000000000000000000
--- a/drivers/interconnect/qcom/qcs615.h
+++ /dev/null
@@ -1,128 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights reserved.
- */
-
-#ifndef __DRIVERS_INTERCONNECT_QCOM_QCS615_H
-#define __DRIVERS_INTERCONNECT_QCOM_QCS615_H
-
-#define QCS615_MASTER_A1NOC_CFG				1
-#define QCS615_MASTER_A1NOC_SNOC			2
-#define QCS615_MASTER_ANOC_PCIE_SNOC			3
-#define QCS615_MASTER_APPSS_PROC			4
-#define QCS615_MASTER_BLSP_1				5
-#define QCS615_MASTER_CAMNOC_HF0			6
-#define QCS615_MASTER_CAMNOC_HF0_UNCOMP			7
-#define QCS615_MASTER_CAMNOC_HF1			8
-#define QCS615_MASTER_CAMNOC_HF1_UNCOMP			9
-#define QCS615_MASTER_CAMNOC_SF				10
-#define QCS615_MASTER_CAMNOC_SF_UNCOMP			11
-#define QCS615_MASTER_CNOC_A2NOC			12
-#define QCS615_MASTER_CNOC_DC_NOC			13
-#define QCS615_MASTER_CNOC_MNOC_CFG			14
-#define QCS615_MASTER_CRYPTO				15
-#define QCS615_MASTER_EMAC_EVB				16
-#define QCS615_MASTER_GEM_NOC_CFG			17
-#define QCS615_MASTER_GEM_NOC_PCIE_SNOC			18
-#define QCS615_MASTER_GEM_NOC_SNOC			19
-#define QCS615_MASTER_GFX3D				20
-#define QCS615_MASTER_GIC				21
-#define QCS615_MASTER_GPU_TCU				22
-#define QCS615_MASTER_IPA				23
-#define QCS615_MASTER_IPA_CORE				24
-#define QCS615_MASTER_LLCC				25
-#define QCS615_MASTER_LPASS_ANOC			26
-#define QCS615_MASTER_MDP0				27
-#define QCS615_MASTER_MNOC_HF_MEM_NOC			28
-#define QCS615_MASTER_MNOC_SF_MEM_NOC			29
-#define QCS615_MASTER_PCIE				30
-#define QCS615_MASTER_PIMEM				31
-#define QCS615_MASTER_QDSS_BAM				32
-#define QCS615_MASTER_QDSS_DAP				33
-#define QCS615_MASTER_QDSS_ETR				34
-#define QCS615_MASTER_QSPI				35
-#define QCS615_MASTER_QUP_0				36
-#define QCS615_MASTER_ROTATOR				37
-#define QCS615_MASTER_SDCC_1				38
-#define QCS615_MASTER_SDCC_2				39
-#define QCS615_MASTER_SNOC_CFG				40
-#define QCS615_MASTER_SNOC_CNOC				41
-#define QCS615_MASTER_SNOC_GC_MEM_NOC			42
-#define QCS615_MASTER_SNOC_SF_MEM_NOC			43
-#define QCS615_MASTER_SPDM				44
-#define QCS615_MASTER_SYS_TCU				45
-#define QCS615_MASTER_UFS_MEM				46
-#define QCS615_MASTER_USB2				47
-#define QCS615_MASTER_USB3_0				48
-#define QCS615_MASTER_VIDEO_P0				49
-#define QCS615_MASTER_VIDEO_PROC			50
-#define QCS615_SLAVE_A1NOC_CFG				51
-#define QCS615_SLAVE_A1NOC_SNOC				52
-#define QCS615_SLAVE_AHB2PHY_EAST			53
-#define QCS615_SLAVE_AHB2PHY_WEST			54
-#define QCS615_SLAVE_ANOC_PCIE_SNOC			55
-#define QCS615_SLAVE_AOP				56
-#define QCS615_SLAVE_AOSS				57
-#define QCS615_SLAVE_APPSS				58
-#define QCS615_SLAVE_CAMERA_CFG				59
-#define QCS615_SLAVE_CAMNOC_UNCOMP			60
-#define QCS615_SLAVE_CLK_CTL				61
-#define QCS615_SLAVE_CNOC_A2NOC				62
-#define QCS615_SLAVE_CNOC_DDRSS				63
-#define QCS615_SLAVE_CNOC_MNOC_CFG			64
-#define QCS615_SLAVE_CRYPTO_0_CFG			65
-#define QCS615_SLAVE_DC_NOC_GEMNOC			66
-#define QCS615_SLAVE_DISPLAY_CFG			67
-#define QCS615_SLAVE_EBI1				68
-#define QCS615_SLAVE_EMAC_AVB_CFG			69
-#define QCS615_SLAVE_GEM_NOC_SNOC			70
-#define QCS615_SLAVE_GFX3D_CFG				71
-#define QCS615_SLAVE_GLM				72
-#define QCS615_SLAVE_IMEM				73
-#define QCS615_SLAVE_IMEM_CFG				74
-#define QCS615_SLAVE_IPA_CFG				75
-#define QCS615_SLAVE_IPA_CORE				76
-#define QCS615_SLAVE_LLCC				77
-#define QCS615_SLAVE_LLCC_CFG				78
-#define QCS615_SLAVE_LPASS_SNOC				79
-#define QCS615_SLAVE_MEM_NOC_PCIE_SNOC			80
-#define QCS615_SLAVE_MNOC_HF_MEM_NOC			81
-#define QCS615_SLAVE_MNOC_SF_MEM_NOC			82
-#define QCS615_SLAVE_MSS_PROC_MS_MPU_CFG		83
-#define QCS615_SLAVE_PCIE_0				84
-#define QCS615_SLAVE_PCIE_CFG				85
-#define QCS615_SLAVE_PIMEM				86
-#define QCS615_SLAVE_PIMEM_CFG				87
-#define QCS615_SLAVE_PRNG				88
-#define QCS615_SLAVE_QDSS_CFG				89
-#define QCS615_SLAVE_QDSS_STM				90
-#define QCS615_SLAVE_QSPI				91
-#define QCS615_SLAVE_QUP_0				92
-#define QCS615_SLAVE_QUP_1				93
-#define QCS615_SLAVE_RBCPR_CX_CFG			94
-#define QCS615_SLAVE_RBCPR_MX_CFG			95
-#define QCS615_SLAVE_SDCC_1				96
-#define QCS615_SLAVE_SDCC_2				97
-#define QCS615_SLAVE_SERVICE_A2NOC			98
-#define QCS615_SLAVE_SERVICE_CNOC			99
-#define QCS615_SLAVE_SERVICE_GEM_NOC			100
-#define QCS615_SLAVE_SERVICE_MNOC			101
-#define QCS615_SLAVE_SERVICE_SNOC			102
-#define QCS615_SLAVE_SNOC_CFG				103
-#define QCS615_SLAVE_SNOC_CNOC				104
-#define QCS615_SLAVE_SNOC_GEM_NOC_SF			105
-#define QCS615_SLAVE_SNOC_MEM_NOC_GC			106
-#define QCS615_SLAVE_SPDM_WRAPPER			107
-#define QCS615_SLAVE_TCSR				108
-#define QCS615_SLAVE_TCU				109
-#define QCS615_SLAVE_TLMM_EAST				110
-#define QCS615_SLAVE_TLMM_SOUTH				111
-#define QCS615_SLAVE_TLMM_WEST				112
-#define QCS615_SLAVE_UFS_MEM_CFG			113
-#define QCS615_SLAVE_USB2				114
-#define QCS615_SLAVE_USB3				115
-#define QCS615_SLAVE_VENUS_CFG				116
-#define QCS615_SLAVE_VSENSE_CTRL_CFG			117
-
-#endif
-

-- 
2.47.3



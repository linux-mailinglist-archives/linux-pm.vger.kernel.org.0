Return-Path: <linux-pm+bounces-37204-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E125BC25AA3
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 15:49:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB5E44012CE
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 14:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D76D27E7EB;
	Fri, 31 Oct 2025 14:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="evIkN1Ln";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="d1IKApYG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB1C24C076
	for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2025 14:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761921948; cv=none; b=s9WyyEV5st2eePM9odkhw/5eQoX0Rk5R06qYMRvfXwzu2rpIrMyPLLs39n7qf8DXlG4+dWAbkm/eMTJR5Z0Z5SejcyPGMZ+a4zSoTltbbYdnIOo/K7nh9lQW4GEDloB2qSzlHEh5Tlwa4sJ/MwWrWV6wAmmnBRaCAh+rN4KHlMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761921948; c=relaxed/simple;
	bh=UuEPQFOYYSCQve6RmaW7F+2ZwJ4y3REWh2xPFMCn4sI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EAsBeeOoGCToYcTJ/XtaUJ350WIOKaAWEfj3Idy6bOAPRFfWql8yxkt2ovOyetTelCTm2Oz/Fll4NOUOLfnY2/1t7H/7dRYVqyF5loRRlji2oIVPSQ+iqA9L25XCjx0PTNTcfOCcQicoFMpjLB9zGb+InWqGJ6au0Rw53qoCdls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=evIkN1Ln; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=d1IKApYG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59V7oLXD872685
	for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2025 14:45:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Mye+qHDZxTrZFtqkWF/iykkNw1DYWDnplzqm4G7MwIg=; b=evIkN1LnmVC+i097
	GsIvNrlt78Opctk13bhknOLfjwJKD46MknzxFd3o4cDos93a8UD8GX7JiSQ41kCk
	o7SugoIkKilo5EmpgnvGAqnUmlR7QJ0Du9/Jdkrd4hoBJEplbge8ygm/daMbOL59
	mpeC5ZVvXPvsh1sum0jAhlwpMVOneDuJfgVFcEZGcmzv2Z5zJU6BunAucw6IEiUw
	MW/vZSm1rxK3bffElQII1xyBd3V4eqzszyPhmauenh9if1JB3BpYLEAZuHewTMze
	/PlD8r+/G4CFz6v8DMTQ23VA/4iQH+WFsAccT8b9nkKz7GcDRhT/sMSgUusiXRPo
	5D7pIw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a4fqn2f4m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2025 14:45:42 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ecf77618a5so66393651cf.3
        for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2025 07:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761921941; x=1762526741; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mye+qHDZxTrZFtqkWF/iykkNw1DYWDnplzqm4G7MwIg=;
        b=d1IKApYGo1nZplTx+0qiKkuOk3aAE32aEszkdo3qwymMGK7gExrfIvUGQe9BzwdBHW
         aiOObFAG4jna0o5z2ehOXrwvZCSGeyQqe5RMEu3eqY++7bKr+fyuaay1Xr5g5hBtrJgZ
         d7da1PcD5zAN0WhJ3Jof7Hkk0JbK26u3aSHKD+1NgX6aIO7o90lveRQ1uyfNX+j2F+1q
         O96YJjiG67br7isATFcTIeRBwfAlOmJ3H2oP+mfN8vcp9XBAD8dfy6C+HsyYhLhNhgzk
         OwteMtqud1VAEyRud1rVjkyDLjTOB58YKOtWmRtSdeCMTnsZJj22T6F3zrde/H1X7hWU
         TgGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761921941; x=1762526741;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mye+qHDZxTrZFtqkWF/iykkNw1DYWDnplzqm4G7MwIg=;
        b=JR08TOPnhi5vdpW2JeQDKpEbCUp0Jde1Rf+Dhi6R+Nxh08Ex4YZKOy37crJafSo3k8
         lDTL+651riQ1T3giab8gHEhoHoQoHD/OZj8kXjUA0CXOXMQRfJVLr/Nsnyi7yTQwSAFO
         a1Njp5zTi3j/easJ9+OGU/gyffM2BvJ/qcOZfFjAXagOUEenaIELWl5s4uKyv4yGhRfH
         Vjd3EE6LKlT28uZ1dHjQvdgiDylNepYHRjM3FSGeVR48hrI6EbXUWaSriRAmHoaHjVD4
         3Lu5c3NBvSJvBZvyf8O70MXMnWtIMeJmc/mUlKc+nDWfyUFB0bvWcqcFkNVzE6Ywsp2M
         6faA==
X-Forwarded-Encrypted: i=1; AJvYcCU75m2V7IPiv0Mpg/YuYVgbFtf63A2PUYYUiYaB90NbwXlRebxuZBq/CUvjIobN7oXEik2cCsJzYQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4/JfOo0AmtYGGWDbr4NrMKi5cWW77cEvIKWkMhlV1BkeV3FKj
	9wOBOaepBK9sxTkGyOD3kTkxM2L1Knk1+qFWSZjf6vl+szxP2vJ1InIbpzBqRf1SU5fFOgZQ948
	/Pf+zFSf62cl7k2KAcV9GwOH59p9ytyI+YdCz+UmIPdbmO157eNzdaug7RnMwUA==
X-Gm-Gg: ASbGncshOCMfKxtzxA0czU3gJQvxmDeD24NVbpJb5dMYmXWKfWFexixCxlAhB31Sr9m
	nttpljbCRq0PtmS9ckEnMqUCsJpOxB3la082iDDyUqMB2Z15YoW7/z2tOIlg2wiLsPXNuSyrf42
	SEpuwVPlFwPt89Ds2iLYNbM5o2FvSDjlY7iOKyE5EeXudOkj5+NglMsdn5Ftz8vpAoPFQC4FUHf
	QRWWued72RedQRk8Ypw84dk4WBsZirjDIdMTf2foxoUZk9tXscPT1uNJm2dhFqgqLaHUGmuNjo0
	CmtOQiNKKtonGmb6lIXNZLwvXritLBTqlx4r8xXKSqFMBSlNPMY874O7Rzg4pI8b4VzvRvykeaE
	Bio13mt4MvXsEiqkMWtWCPoG6BvRybc1Z6JHGhCYYMV8VH3upj4VIm5WVHw6IwrcqYMLcX6SdCO
	txxvFZ5M6tns0u
X-Received: by 2002:ac8:5954:0:b0:4e7:2003:3c31 with SMTP id d75a77b69052e-4ed30dcaaa8mr48282501cf.27.1761921940502;
        Fri, 31 Oct 2025 07:45:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcvsTHXMEkkiYA3vxNTDbBqOj61QseTtrkZvzOz5ltfWdlUaEAB22r35oiWQcFggHwE2BbYw==
X-Received: by 2002:ac8:5954:0:b0:4e7:2003:3c31 with SMTP id d75a77b69052e-4ed30dcaaa8mr48281831cf.27.1761921939782;
        Fri, 31 Oct 2025 07:45:39 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5941f5bc218sm541405e87.93.2025.10.31.07.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 07:45:37 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 31 Oct 2025 16:45:22 +0200
Subject: [PATCH v3 06/25] interconnect: qcom: sm8250: convert to dynamic
 IDs
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-rework-icc-v3-6-0575304c9624@oss.qualcomm.com>
References: <20251031-rework-icc-v3-0-0575304c9624@oss.qualcomm.com>
In-Reply-To: <20251031-rework-icc-v3-0-0575304c9624@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=51529;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=UuEPQFOYYSCQve6RmaW7F+2ZwJ4y3REWh2xPFMCn4sI=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpBMuCOJCJCUCRPHISsyXeb2EmbAHgwxjrX7MmV
 Aohcgb55c6JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaQTLggAKCRCLPIo+Aiko
 1TXtCACyitVjWtja96O3vG21CtDL72u2z6VAYcauT6b2nFTHEBDqu1oRv5bOT1pNhiMwuHrD5fz
 2J5jJriNsLUucHHqG5FCnL+MUsH1Fe/QmDbTw1/yIFd0Rgp/v2jDMpDbjQZsnovPyUfLCesoqXS
 xAHIvhJJc0QzaWz16oRkFTdjFf/g+YQeaJ6W/7KiMJgpIMhhOikEKI0xLuQgO0nZw+605QGq6wp
 rIaSwKT+EXqZtAxJUgASMs8rb5B9yXemw1vELLHgs5ZfXBsIeYVCpH1hcRj/wxwx1XqRrNDThO9
 RIaCdRJps5J3b6Q1MeuEAN6ucGlPvrlkLKp5Wknlmnm27svu
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=RL2+3oi+ c=1 sm=1 tr=0 ts=6904cb96 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=7679If9iF30M53oG0m0A:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: 4KtQkxbZRbtYnpgxyhNHVI5AO-STqHkA
X-Proofpoint-GUID: 4KtQkxbZRbtYnpgxyhNHVI5AO-STqHkA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDEzMyBTYWx0ZWRfX7VY32/uzN/us
 qybHPab6HQ2GLKjYOg/lw1qqdwIhqLkrrpWGUJpr7w+d+VQdKqY+vfw/0BfOmM0YePo3uFE1i8C
 OlkCd6jZ7J8pJkXfNXWjJU6ySIdvvm1w3VBFk6iTse7OqcZ4H2/Pwyn1JFWf96k/Vd1ncOghrrV
 ZBf4H5fCncbOTVdg8nTCeEZ3keKk2bBaH3sjzJg9QZcDVDbEh8l4B5y/6YjEHzLot/Bz8K/Z2vM
 a129Z8RSmzp8Bwy0utSg1SaaSXIivZ7VzNGAgE60qV6d7BsUYFQDA7VuG/XrjLP74HNXSAYspPR
 VPI7+4LlpJWRejaGtxVfgwSsX17BIDAf7gwxtY4H0gUdXYujHO91ybTtr93cFijMUzliZ27WPZR
 rHpWclPI+oBJbEqHxvd+MomJooZKdA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_04,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 impostorscore=0
 phishscore=0 bulkscore=0 adultscore=0 spamscore=0 clxscore=1015
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2510310133

Stop using fixed and IDs and covert the platform to use dynamic IDs for
the interconnect. This gives more flexibility and also allows us to drop
the .num_links member, saving from possible errors related to it being
not set or set incorrectly.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/interconnect/qcom/sm8250.c | 736 ++++++++++++++++++-------------------
 drivers/interconnect/qcom/sm8250.h | 168 ---------
 2 files changed, 361 insertions(+), 543 deletions(-)

diff --git a/drivers/interconnect/qcom/sm8250.c b/drivers/interconnect/qcom/sm8250.c
index cc1b14c1352910fd450c334fa90f2a0b390bb9bc..2ed112eab155e1f9be1a4b5336b998639d0e298b 100644
--- a/drivers/interconnect/qcom/sm8250.c
+++ b/drivers/interconnect/qcom/sm8250.c
@@ -14,1383 +14,1369 @@
 
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
 	.num_links = 1,
-	.links = { SM8250_SLAVE_SERVICE_A1NOC },
+	.link_nodes = { &srvc_aggre1_noc },
 };
 
 static struct qcom_icc_node qhm_qspi = {
 	.name = "qhm_qspi",
-	.id = SM8250_MASTER_QSPI_0,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SM8250_A1NOC_SNOC_SLV },
+	.link_nodes = { &qns_a1noc_snoc },
 };
 
 static struct qcom_icc_node qhm_qup1 = {
 	.name = "qhm_qup1",
-	.id = SM8250_MASTER_QUP_1,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SM8250_A1NOC_SNOC_SLV },
+	.link_nodes = { &qns_a1noc_snoc },
 };
 
 static struct qcom_icc_node qhm_qup2 = {
 	.name = "qhm_qup2",
-	.id = SM8250_MASTER_QUP_2,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SM8250_A1NOC_SNOC_SLV },
+	.link_nodes = { &qns_a1noc_snoc },
 };
 
 static struct qcom_icc_node qhm_tsif = {
 	.name = "qhm_tsif",
-	.id = SM8250_MASTER_TSIF,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SM8250_A1NOC_SNOC_SLV },
+	.link_nodes = { &qns_a1noc_snoc },
 };
 
 static struct qcom_icc_node xm_pcie3_modem = {
 	.name = "xm_pcie3_modem",
-	.id = SM8250_MASTER_PCIE_2,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SM8250_SLAVE_ANOC_PCIE_GEM_NOC_1 },
+	.link_nodes = { &qns_pcie_modem_mem_noc },
 };
 
 static struct qcom_icc_node xm_sdc4 = {
 	.name = "xm_sdc4",
-	.id = SM8250_MASTER_SDCC_4,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SM8250_A1NOC_SNOC_SLV },
+	.link_nodes = { &qns_a1noc_snoc },
 };
 
 static struct qcom_icc_node xm_ufs_mem = {
 	.name = "xm_ufs_mem",
-	.id = SM8250_MASTER_UFS_MEM,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SM8250_A1NOC_SNOC_SLV },
+	.link_nodes = { &qns_a1noc_snoc },
 };
 
 static struct qcom_icc_node xm_usb3_0 = {
 	.name = "xm_usb3_0",
-	.id = SM8250_MASTER_USB3,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SM8250_A1NOC_SNOC_SLV },
+	.link_nodes = { &qns_a1noc_snoc },
 };
 
 static struct qcom_icc_node xm_usb3_1 = {
 	.name = "xm_usb3_1",
-	.id = SM8250_MASTER_USB3_1,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SM8250_A1NOC_SNOC_SLV },
+	.link_nodes = { &qns_a1noc_snoc },
 };
 
 static struct qcom_icc_node qhm_a2noc_cfg = {
 	.name = "qhm_a2noc_cfg",
-	.id = SM8250_MASTER_A2NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SM8250_SLAVE_SERVICE_A2NOC },
+	.link_nodes = { &srvc_aggre2_noc },
 };
 
 static struct qcom_icc_node qhm_qdss_bam = {
 	.name = "qhm_qdss_bam",
-	.id = SM8250_MASTER_QDSS_BAM,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SM8250_A2NOC_SNOC_SLV },
+	.link_nodes = { &qns_a2noc_snoc },
 };
 
 static struct qcom_icc_node qhm_qup0 = {
 	.name = "qhm_qup0",
-	.id = SM8250_MASTER_QUP_0,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SM8250_A2NOC_SNOC_SLV },
+	.link_nodes = { &qns_a2noc_snoc },
 };
 
 static struct qcom_icc_node qnm_cnoc = {
 	.name = "qnm_cnoc",
-	.id = SM8250_MASTER_CNOC_A2NOC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SM8250_A2NOC_SNOC_SLV },
+	.link_nodes = { &qns_a2noc_snoc },
 };
 
 static struct qcom_icc_node qxm_crypto = {
 	.name = "qxm_crypto",
-	.id = SM8250_MASTER_CRYPTO_CORE_0,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SM8250_A2NOC_SNOC_SLV },
+	.link_nodes = { &qns_a2noc_snoc },
 };
 
 static struct qcom_icc_node qxm_ipa = {
 	.name = "qxm_ipa",
-	.id = SM8250_MASTER_IPA,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SM8250_A2NOC_SNOC_SLV },
+	.link_nodes = { &qns_a2noc_snoc },
 };
 
 static struct qcom_icc_node xm_pcie3_0 = {
 	.name = "xm_pcie3_0",
-	.id = SM8250_MASTER_PCIE,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SM8250_SLAVE_ANOC_PCIE_GEM_NOC },
+	.link_nodes = { &qns_pcie_mem_noc },
 };
 
 static struct qcom_icc_node xm_pcie3_1 = {
 	.name = "xm_pcie3_1",
-	.id = SM8250_MASTER_PCIE_1,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SM8250_SLAVE_ANOC_PCIE_GEM_NOC },
+	.link_nodes = { &qns_pcie_mem_noc },
 };
 
 static struct qcom_icc_node xm_qdss_etr = {
 	.name = "xm_qdss_etr",
-	.id = SM8250_MASTER_QDSS_ETR,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SM8250_A2NOC_SNOC_SLV },
+	.link_nodes = { &qns_a2noc_snoc },
 };
 
 static struct qcom_icc_node xm_sdc2 = {
 	.name = "xm_sdc2",
-	.id = SM8250_MASTER_SDCC_2,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SM8250_A2NOC_SNOC_SLV },
+	.link_nodes = { &qns_a2noc_snoc },
 };
 
 static struct qcom_icc_node xm_ufs_card = {
 	.name = "xm_ufs_card",
-	.id = SM8250_MASTER_UFS_CARD,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SM8250_A2NOC_SNOC_SLV },
+	.link_nodes = { &qns_a2noc_snoc },
 };
 
 static struct qcom_icc_node qnm_npu = {
 	.name = "qnm_npu",
-	.id = SM8250_MASTER_NPU,
 	.channels = 2,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SM8250_SLAVE_CDSP_MEM_NOC },
+	.link_nodes = { &qns_cdsp_mem_noc },
 };
 
 static struct qcom_icc_node qnm_snoc = {
 	.name = "qnm_snoc",
-	.id = SM8250_SNOC_CNOC_MAS,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 49,
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
+			&qhs_clk_ctl },
 };
 
 static struct qcom_icc_node xm_qdss_dap = {
 	.name = "xm_qdss_dap",
-	.id = SM8250_MASTER_QDSS_DAP,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 50,
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
+			&qhs_clk_ctl },
 };
 
 static struct qcom_icc_node qhm_cnoc_dc_noc = {
 	.name = "qhm_cnoc_dc_noc",
-	.id = SM8250_MASTER_CNOC_DC_NOC,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 2,
-	.links = { SM8250_SLAVE_GEM_NOC_CFG,
-		   SM8250_SLAVE_LLCC_CFG
-	},
+	.link_nodes = { &qhs_memnoc,
+			&qhs_llcc },
 };
 
 static struct qcom_icc_node alm_gpu_tcu = {
 	.name = "alm_gpu_tcu",
-	.id = SM8250_MASTER_GPU_TCU,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 2,
-	.links = { SM8250_SLAVE_LLCC,
-		   SM8250_SLAVE_GEM_NOC_SNOC
-	},
+	.link_nodes = { &qns_llcc,
+			&qns_gem_noc_snoc },
 };
 
 static struct qcom_icc_node alm_sys_tcu = {
 	.name = "alm_sys_tcu",
-	.id = SM8250_MASTER_SYS_TCU,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 2,
-	.links = { SM8250_SLAVE_LLCC,
-		   SM8250_SLAVE_GEM_NOC_SNOC
-	},
+	.link_nodes = { &qns_llcc,
+			&qns_gem_noc_snoc },
 };
 
 static struct qcom_icc_node chm_apps = {
 	.name = "chm_apps",
-	.id = SM8250_MASTER_AMPSS_M0,
 	.channels = 2,
 	.buswidth = 32,
 	.num_links = 3,
-	.links = { SM8250_SLAVE_LLCC,
-		   SM8250_SLAVE_GEM_NOC_SNOC,
-		   SM8250_SLAVE_MEM_NOC_PCIE_SNOC
-	},
+	.link_nodes = { &qns_llcc,
+			&qns_gem_noc_snoc,
+			&qns_sys_pcie },
 };
 
 static struct qcom_icc_node qhm_gemnoc_cfg = {
 	.name = "qhm_gemnoc_cfg",
-	.id = SM8250_MASTER_GEM_NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 3,
-	.links = { SM8250_SLAVE_SERVICE_GEM_NOC_2,
-		   SM8250_SLAVE_SERVICE_GEM_NOC_1,
-		   SM8250_SLAVE_SERVICE_GEM_NOC
-	},
+	.link_nodes = { &srvc_odd_gemnoc,
+			&srvc_even_gemnoc,
+			&srvc_sys_gemnoc },
 };
 
 static struct qcom_icc_node qnm_cmpnoc = {
 	.name = "qnm_cmpnoc",
-	.id = SM8250_MASTER_COMPUTE_NOC,
 	.channels = 2,
 	.buswidth = 32,
 	.num_links = 2,
-	.links = { SM8250_SLAVE_LLCC,
-		   SM8250_SLAVE_GEM_NOC_SNOC
-	},
+	.link_nodes = { &qns_llcc,
+			&qns_gem_noc_snoc },
 };
 
 static struct qcom_icc_node qnm_gpu = {
 	.name = "qnm_gpu",
-	.id = SM8250_MASTER_GRAPHICS_3D,
 	.channels = 2,
 	.buswidth = 32,
 	.num_links = 2,
-	.links = { SM8250_SLAVE_LLCC,
-		   SM8250_SLAVE_GEM_NOC_SNOC },
+	.link_nodes = { &qns_llcc,
+			&qns_gem_noc_snoc },
 };
 
 static struct qcom_icc_node qnm_mnoc_hf = {
 	.name = "qnm_mnoc_hf",
-	.id = SM8250_MASTER_MNOC_HF_MEM_NOC,
 	.channels = 2,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SM8250_SLAVE_LLCC },
+	.link_nodes = { &qns_llcc },
 };
 
 static struct qcom_icc_node qnm_mnoc_sf = {
 	.name = "qnm_mnoc_sf",
-	.id = SM8250_MASTER_MNOC_SF_MEM_NOC,
 	.channels = 2,
 	.buswidth = 32,
 	.num_links = 2,
-	.links = { SM8250_SLAVE_LLCC,
-		   SM8250_SLAVE_GEM_NOC_SNOC
-	},
+	.link_nodes = { &qns_llcc,
+			&qns_gem_noc_snoc },
 };
 
 static struct qcom_icc_node qnm_pcie = {
 	.name = "qnm_pcie",
-	.id = SM8250_MASTER_ANOC_PCIE_GEM_NOC,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 2,
-	.links = { SM8250_SLAVE_LLCC,
-		   SM8250_SLAVE_GEM_NOC_SNOC
-	},
+	.link_nodes = { &qns_llcc,
+			&qns_gem_noc_snoc },
 };
 
 static struct qcom_icc_node qnm_snoc_gc = {
 	.name = "qnm_snoc_gc",
-	.id = SM8250_MASTER_SNOC_GC_MEM_NOC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SM8250_SLAVE_LLCC },
+	.link_nodes = { &qns_llcc },
 };
 
 static struct qcom_icc_node qnm_snoc_sf = {
 	.name = "qnm_snoc_sf",
-	.id = SM8250_MASTER_SNOC_SF_MEM_NOC,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 3,
-	.links = { SM8250_SLAVE_LLCC,
-		   SM8250_SLAVE_GEM_NOC_SNOC,
-		   SM8250_SLAVE_MEM_NOC_PCIE_SNOC
-	},
+	.link_nodes = { &qns_llcc,
+			&qns_gem_noc_snoc,
+			&qns_sys_pcie },
 };
 
 static struct qcom_icc_node llcc_mc = {
 	.name = "llcc_mc",
-	.id = SM8250_MASTER_LLCC,
 	.channels = 4,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SM8250_SLAVE_EBI_CH0 },
+	.link_nodes = { &ebi },
 };
 
 static struct qcom_icc_node qhm_mnoc_cfg = {
 	.name = "qhm_mnoc_cfg",
-	.id = SM8250_MASTER_CNOC_MNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SM8250_SLAVE_SERVICE_MNOC },
+	.link_nodes = { &srvc_mnoc },
 };
 
 static struct qcom_icc_node qnm_camnoc_hf = {
 	.name = "qnm_camnoc_hf",
-	.id = SM8250_MASTER_CAMNOC_HF,
 	.channels = 2,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SM8250_SLAVE_MNOC_HF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_hf },
 };
 
 static struct qcom_icc_node qnm_camnoc_icp = {
 	.name = "qnm_camnoc_icp",
-	.id = SM8250_MASTER_CAMNOC_ICP,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SM8250_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_sf },
 };
 
 static struct qcom_icc_node qnm_camnoc_sf = {
 	.name = "qnm_camnoc_sf",
-	.id = SM8250_MASTER_CAMNOC_SF,
 	.channels = 2,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SM8250_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_sf },
 };
 
 static struct qcom_icc_node qnm_video0 = {
 	.name = "qnm_video0",
-	.id = SM8250_MASTER_VIDEO_P0,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SM8250_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_sf },
 };
 
 static struct qcom_icc_node qnm_video1 = {
 	.name = "qnm_video1",
-	.id = SM8250_MASTER_VIDEO_P1,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SM8250_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_sf },
 };
 
 static struct qcom_icc_node qnm_video_cvp = {
 	.name = "qnm_video_cvp",
-	.id = SM8250_MASTER_VIDEO_PROC,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SM8250_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_sf },
 };
 
 static struct qcom_icc_node qxm_mdp0 = {
 	.name = "qxm_mdp0",
-	.id = SM8250_MASTER_MDP_PORT0,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SM8250_SLAVE_MNOC_HF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_hf },
 };
 
 static struct qcom_icc_node qxm_mdp1 = {
 	.name = "qxm_mdp1",
-	.id = SM8250_MASTER_MDP_PORT1,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SM8250_SLAVE_MNOC_HF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_hf },
 };
 
 static struct qcom_icc_node qxm_rot = {
 	.name = "qxm_rot",
-	.id = SM8250_MASTER_ROTATOR,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SM8250_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_sf },
 };
 
 static struct qcom_icc_node amm_npu_sys = {
 	.name = "amm_npu_sys",
-	.id = SM8250_MASTER_NPU_SYS,
 	.channels = 4,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SM8250_SLAVE_NPU_COMPUTE_NOC },
+	.link_nodes = { &qns_npu_sys },
 };
 
 static struct qcom_icc_node amm_npu_sys_cdp_w = {
 	.name = "amm_npu_sys_cdp_w",
-	.id = SM8250_MASTER_NPU_CDP,
 	.channels = 2,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { SM8250_SLAVE_NPU_COMPUTE_NOC },
+	.link_nodes = { &qns_npu_sys },
 };
 
 static struct qcom_icc_node qhm_cfg = {
 	.name = "qhm_cfg",
-	.id = SM8250_MASTER_NPU_NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 9,
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
+	.link_nodes = { &srvc_noc,
+			&qhs_isense,
+			&qhs_llm,
+			&qhs_dma_bwmon,
+			&qhs_cp,
+			&qhs_tcm,
+			&qhs_cal_dp0,
+			&qhs_cal_dp1,
+			&qhs_dpm },
 };
 
 static struct qcom_icc_node qhm_snoc_cfg = {
 	.name = "qhm_snoc_cfg",
-	.id = SM8250_MASTER_SNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SM8250_SLAVE_SERVICE_SNOC },
+	.link_nodes = { &srvc_snoc },
 };
 
 static struct qcom_icc_node qnm_aggre1_noc = {
 	.name = "qnm_aggre1_noc",
-	.id = SM8250_A1NOC_SNOC_MAS,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { SM8250_SLAVE_SNOC_GEM_NOC_SF },
+	.link_nodes = { &qns_gemnoc_sf },
 };
 
 static struct qcom_icc_node qnm_aggre2_noc = {
 	.name = "qnm_aggre2_noc",
-	.id = SM8250_A2NOC_SNOC_MAS,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { SM8250_SLAVE_SNOC_GEM_NOC_SF },
+	.link_nodes = { &qns_gemnoc_sf },
 };
 
 static struct qcom_icc_node qnm_gemnoc = {
 	.name = "qnm_gemnoc",
-	.id = SM8250_MASTER_GEM_NOC_SNOC,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 6,
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
+			&xs_qdss_stm },
 };
 
 static struct qcom_icc_node qnm_gemnoc_pcie = {
 	.name = "qnm_gemnoc_pcie",
-	.id = SM8250_MASTER_GEM_NOC_PCIE_SNOC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 3,
-	.links = { SM8250_SLAVE_PCIE_2,
-		   SM8250_SLAVE_PCIE_0,
-		   SM8250_SLAVE_PCIE_1
-	},
+	.link_nodes = { &xs_pcie_modem,
+			&xs_pcie_0,
+			&xs_pcie_1 },
 };
 
 static struct qcom_icc_node qxm_pimem = {
 	.name = "qxm_pimem",
-	.id = SM8250_MASTER_PIMEM,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SM8250_SLAVE_SNOC_GEM_NOC_GC },
+	.link_nodes = { &qns_gemnoc_gc },
 };
 
 static struct qcom_icc_node xm_gic = {
 	.name = "xm_gic",
-	.id = SM8250_MASTER_GIC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SM8250_SLAVE_SNOC_GEM_NOC_GC },
+	.link_nodes = { &qns_gemnoc_gc },
 };
 
 static struct qcom_icc_node qns_a1noc_snoc = {
 	.name = "qns_a1noc_snoc",
-	.id = SM8250_A1NOC_SNOC_SLV,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { SM8250_A1NOC_SNOC_MAS },
+	.link_nodes = { &qnm_aggre1_noc },
 };
 
 static struct qcom_icc_node qns_pcie_modem_mem_noc = {
 	.name = "qns_pcie_modem_mem_noc",
-	.id = SM8250_SLAVE_ANOC_PCIE_GEM_NOC_1,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { SM8250_MASTER_ANOC_PCIE_GEM_NOC },
+	.link_nodes = { &qnm_pcie },
 };
 
 static struct qcom_icc_node srvc_aggre1_noc = {
 	.name = "srvc_aggre1_noc",
-	.id = SM8250_SLAVE_SERVICE_A1NOC,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qns_a2noc_snoc = {
 	.name = "qns_a2noc_snoc",
-	.id = SM8250_A2NOC_SNOC_SLV,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { SM8250_A2NOC_SNOC_MAS },
+	.link_nodes = { &qnm_aggre2_noc },
 };
 
 static struct qcom_icc_node qns_pcie_mem_noc = {
 	.name = "qns_pcie_mem_noc",
-	.id = SM8250_SLAVE_ANOC_PCIE_GEM_NOC,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { SM8250_MASTER_ANOC_PCIE_GEM_NOC },
+	.link_nodes = { &qnm_pcie },
 };
 
 static struct qcom_icc_node srvc_aggre2_noc = {
 	.name = "srvc_aggre2_noc",
-	.id = SM8250_SLAVE_SERVICE_A2NOC,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qns_cdsp_mem_noc = {
 	.name = "qns_cdsp_mem_noc",
-	.id = SM8250_SLAVE_CDSP_MEM_NOC,
 	.channels = 2,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SM8250_MASTER_COMPUTE_NOC },
+	.link_nodes = { &qnm_cmpnoc },
 };
 
 static struct qcom_icc_node qhs_a1_noc_cfg = {
 	.name = "qhs_a1_noc_cfg",
-	.id = SM8250_SLAVE_A1NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SM8250_MASTER_A1NOC_CFG },
+	.link_nodes = { &qhm_a1noc_cfg },
 };
 
 static struct qcom_icc_node qhs_a2_noc_cfg = {
 	.name = "qhs_a2_noc_cfg",
-	.id = SM8250_SLAVE_A2NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SM8250_MASTER_A2NOC_CFG },
+	.link_nodes = { &qhm_a2noc_cfg },
 };
 
 static struct qcom_icc_node qhs_ahb2phy0 = {
 	.name = "qhs_ahb2phy0",
-	.id = SM8250_SLAVE_AHB2PHY_SOUTH,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_ahb2phy1 = {
 	.name = "qhs_ahb2phy1",
-	.id = SM8250_SLAVE_AHB2PHY_NORTH,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_aoss = {
 	.name = "qhs_aoss",
-	.id = SM8250_SLAVE_AOSS,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_camera_cfg = {
 	.name = "qhs_camera_cfg",
-	.id = SM8250_SLAVE_CAMERA_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_clk_ctl = {
 	.name = "qhs_clk_ctl",
-	.id = SM8250_SLAVE_CLK_CTL,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_compute_dsp = {
 	.name = "qhs_compute_dsp",
-	.id = SM8250_SLAVE_CDSP_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_cpr_cx = {
 	.name = "qhs_cpr_cx",
-	.id = SM8250_SLAVE_RBCPR_CX_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_cpr_mmcx = {
 	.name = "qhs_cpr_mmcx",
-	.id = SM8250_SLAVE_RBCPR_MMCX_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_cpr_mx = {
 	.name = "qhs_cpr_mx",
-	.id = SM8250_SLAVE_RBCPR_MX_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_crypto0_cfg = {
 	.name = "qhs_crypto0_cfg",
-	.id = SM8250_SLAVE_CRYPTO_0_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_cx_rdpm = {
 	.name = "qhs_cx_rdpm",
-	.id = SM8250_SLAVE_CX_RDPM,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_dcc_cfg = {
 	.name = "qhs_dcc_cfg",
-	.id = SM8250_SLAVE_DCC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_ddrss_cfg = {
 	.name = "qhs_ddrss_cfg",
-	.id = SM8250_SLAVE_CNOC_DDRSS,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SM8250_MASTER_CNOC_DC_NOC },
+	.link_nodes = { &qhm_cnoc_dc_noc },
 };
 
 static struct qcom_icc_node qhs_display_cfg = {
 	.name = "qhs_display_cfg",
-	.id = SM8250_SLAVE_DISPLAY_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_gpuss_cfg = {
 	.name = "qhs_gpuss_cfg",
-	.id = SM8250_SLAVE_GRAPHICS_3D_CFG,
 	.channels = 1,
 	.buswidth = 8,
 };
 
 static struct qcom_icc_node qhs_imem_cfg = {
 	.name = "qhs_imem_cfg",
-	.id = SM8250_SLAVE_IMEM_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_ipa = {
 	.name = "qhs_ipa",
-	.id = SM8250_SLAVE_IPA_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_ipc_router = {
 	.name = "qhs_ipc_router",
-	.id = SM8250_SLAVE_IPC_ROUTER_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_lpass_cfg = {
 	.name = "qhs_lpass_cfg",
-	.id = SM8250_SLAVE_LPASS,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_mnoc_cfg = {
 	.name = "qhs_mnoc_cfg",
-	.id = SM8250_SLAVE_CNOC_MNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SM8250_MASTER_CNOC_MNOC_CFG },
+	.link_nodes = { &qhm_mnoc_cfg },
 };
 
 static struct qcom_icc_node qhs_npu_cfg = {
 	.name = "qhs_npu_cfg",
-	.id = SM8250_SLAVE_NPU_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SM8250_MASTER_NPU_NOC_CFG },
+	.link_nodes = { &qhm_cfg },
 };
 
 static struct qcom_icc_node qhs_pcie0_cfg = {
 	.name = "qhs_pcie0_cfg",
-	.id = SM8250_SLAVE_PCIE_0_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_pcie1_cfg = {
 	.name = "qhs_pcie1_cfg",
-	.id = SM8250_SLAVE_PCIE_1_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_pcie_modem_cfg = {
 	.name = "qhs_pcie_modem_cfg",
-	.id = SM8250_SLAVE_PCIE_2_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_pdm = {
 	.name = "qhs_pdm",
-	.id = SM8250_SLAVE_PDM,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_pimem_cfg = {
 	.name = "qhs_pimem_cfg",
-	.id = SM8250_SLAVE_PIMEM_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_prng = {
 	.name = "qhs_prng",
-	.id = SM8250_SLAVE_PRNG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_qdss_cfg = {
 	.name = "qhs_qdss_cfg",
-	.id = SM8250_SLAVE_QDSS_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_qspi = {
 	.name = "qhs_qspi",
-	.id = SM8250_SLAVE_QSPI_0,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_qup0 = {
 	.name = "qhs_qup0",
-	.id = SM8250_SLAVE_QUP_0,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_qup1 = {
 	.name = "qhs_qup1",
-	.id = SM8250_SLAVE_QUP_1,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_qup2 = {
 	.name = "qhs_qup2",
-	.id = SM8250_SLAVE_QUP_2,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_sdc2 = {
 	.name = "qhs_sdc2",
-	.id = SM8250_SLAVE_SDCC_2,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_sdc4 = {
 	.name = "qhs_sdc4",
-	.id = SM8250_SLAVE_SDCC_4,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_snoc_cfg = {
 	.name = "qhs_snoc_cfg",
-	.id = SM8250_SLAVE_SNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SM8250_MASTER_SNOC_CFG },
+	.link_nodes = { &qhm_snoc_cfg },
 };
 
 static struct qcom_icc_node qhs_tcsr = {
 	.name = "qhs_tcsr",
-	.id = SM8250_SLAVE_TCSR,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_tlmm0 = {
 	.name = "qhs_tlmm0",
-	.id = SM8250_SLAVE_TLMM_NORTH,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_tlmm1 = {
 	.name = "qhs_tlmm1",
-	.id = SM8250_SLAVE_TLMM_SOUTH,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_tlmm2 = {
 	.name = "qhs_tlmm2",
-	.id = SM8250_SLAVE_TLMM_WEST,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_tsif = {
 	.name = "qhs_tsif",
-	.id = SM8250_SLAVE_TSIF,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_ufs_card_cfg = {
 	.name = "qhs_ufs_card_cfg",
-	.id = SM8250_SLAVE_UFS_CARD_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_ufs_mem_cfg = {
 	.name = "qhs_ufs_mem_cfg",
-	.id = SM8250_SLAVE_UFS_MEM_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_usb3_0 = {
 	.name = "qhs_usb3_0",
-	.id = SM8250_SLAVE_USB3,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_usb3_1 = {
 	.name = "qhs_usb3_1",
-	.id = SM8250_SLAVE_USB3_1,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_venus_cfg = {
 	.name = "qhs_venus_cfg",
-	.id = SM8250_SLAVE_VENUS_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_vsense_ctrl_cfg = {
 	.name = "qhs_vsense_ctrl_cfg",
-	.id = SM8250_SLAVE_VSENSE_CTRL_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qns_cnoc_a2noc = {
 	.name = "qns_cnoc_a2noc",
-	.id = SM8250_SLAVE_CNOC_A2NOC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SM8250_MASTER_CNOC_A2NOC },
+	.link_nodes = { &qnm_cnoc },
 };
 
 static struct qcom_icc_node srvc_cnoc = {
 	.name = "srvc_cnoc",
-	.id = SM8250_SLAVE_SERVICE_CNOC,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_llcc = {
 	.name = "qhs_llcc",
-	.id = SM8250_SLAVE_LLCC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_memnoc = {
 	.name = "qhs_memnoc",
-	.id = SM8250_SLAVE_GEM_NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SM8250_MASTER_GEM_NOC_CFG },
+	.link_nodes = { &qhm_gemnoc_cfg },
 };
 
 static struct qcom_icc_node qns_gem_noc_snoc = {
 	.name = "qns_gem_noc_snoc",
-	.id = SM8250_SLAVE_GEM_NOC_SNOC,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { SM8250_MASTER_GEM_NOC_SNOC },
+	.link_nodes = { &qnm_gemnoc },
 };
 
 static struct qcom_icc_node qns_llcc = {
 	.name = "qns_llcc",
-	.id = SM8250_SLAVE_LLCC,
 	.channels = 4,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { SM8250_MASTER_LLCC },
+	.link_nodes = { &llcc_mc },
 };
 
 static struct qcom_icc_node qns_sys_pcie = {
 	.name = "qns_sys_pcie",
-	.id = SM8250_SLAVE_MEM_NOC_PCIE_SNOC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SM8250_MASTER_GEM_NOC_PCIE_SNOC },
+	.link_nodes = { &qnm_gemnoc_pcie },
 };
 
 static struct qcom_icc_node srvc_even_gemnoc = {
 	.name = "srvc_even_gemnoc",
-	.id = SM8250_SLAVE_SERVICE_GEM_NOC_1,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node srvc_odd_gemnoc = {
 	.name = "srvc_odd_gemnoc",
-	.id = SM8250_SLAVE_SERVICE_GEM_NOC_2,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node srvc_sys_gemnoc = {
 	.name = "srvc_sys_gemnoc",
-	.id = SM8250_SLAVE_SERVICE_GEM_NOC,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node ebi = {
 	.name = "ebi",
-	.id = SM8250_SLAVE_EBI_CH0,
 	.channels = 4,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qns_mem_noc_hf = {
 	.name = "qns_mem_noc_hf",
-	.id = SM8250_SLAVE_MNOC_HF_MEM_NOC,
 	.channels = 2,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SM8250_MASTER_MNOC_HF_MEM_NOC },
+	.link_nodes = { &qnm_mnoc_hf },
 };
 
 static struct qcom_icc_node qns_mem_noc_sf = {
 	.name = "qns_mem_noc_sf",
-	.id = SM8250_SLAVE_MNOC_SF_MEM_NOC,
 	.channels = 2,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SM8250_MASTER_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qnm_mnoc_sf },
 };
 
 static struct qcom_icc_node srvc_mnoc = {
 	.name = "srvc_mnoc",
-	.id = SM8250_SLAVE_SERVICE_MNOC,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_cal_dp0 = {
 	.name = "qhs_cal_dp0",
-	.id = SM8250_SLAVE_NPU_CAL_DP0,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_cal_dp1 = {
 	.name = "qhs_cal_dp1",
-	.id = SM8250_SLAVE_NPU_CAL_DP1,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_cp = {
 	.name = "qhs_cp",
-	.id = SM8250_SLAVE_NPU_CP,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_dma_bwmon = {
 	.name = "qhs_dma_bwmon",
-	.id = SM8250_SLAVE_NPU_INT_DMA_BWMON_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_dpm = {
 	.name = "qhs_dpm",
-	.id = SM8250_SLAVE_NPU_DPM,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_isense = {
 	.name = "qhs_isense",
-	.id = SM8250_SLAVE_ISENSE_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_llm = {
 	.name = "qhs_llm",
-	.id = SM8250_SLAVE_NPU_LLM_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_tcm = {
 	.name = "qhs_tcm",
-	.id = SM8250_SLAVE_NPU_TCM,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qns_npu_sys = {
 	.name = "qns_npu_sys",
-	.id = SM8250_SLAVE_NPU_COMPUTE_NOC,
 	.channels = 2,
 	.buswidth = 32,
 };
 
 static struct qcom_icc_node srvc_noc = {
 	.name = "srvc_noc",
-	.id = SM8250_SLAVE_SERVICE_NPU_NOC,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_apss = {
 	.name = "qhs_apss",
-	.id = SM8250_SLAVE_APPSS,
 	.channels = 1,
 	.buswidth = 8,
 };
 
 static struct qcom_icc_node qns_cnoc = {
 	.name = "qns_cnoc",
-	.id = SM8250_SNOC_CNOC_SLV,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SM8250_SNOC_CNOC_MAS },
+	.link_nodes = { &qnm_snoc },
 };
 
 static struct qcom_icc_node qns_gemnoc_gc = {
 	.name = "qns_gemnoc_gc",
-	.id = SM8250_SLAVE_SNOC_GEM_NOC_GC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SM8250_MASTER_SNOC_GC_MEM_NOC },
+	.link_nodes = { &qnm_snoc_gc },
 };
 
 static struct qcom_icc_node qns_gemnoc_sf = {
 	.name = "qns_gemnoc_sf",
-	.id = SM8250_SLAVE_SNOC_GEM_NOC_SF,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { SM8250_MASTER_SNOC_SF_MEM_NOC },
+	.link_nodes = { &qnm_snoc_sf },
 };
 
 static struct qcom_icc_node qxs_imem = {
 	.name = "qxs_imem",
-	.id = SM8250_SLAVE_OCIMEM,
 	.channels = 1,
 	.buswidth = 8,
 };
 
 static struct qcom_icc_node qxs_pimem = {
 	.name = "qxs_pimem",
-	.id = SM8250_SLAVE_PIMEM,
 	.channels = 1,
 	.buswidth = 8,
 };
 
 static struct qcom_icc_node srvc_snoc = {
 	.name = "srvc_snoc",
-	.id = SM8250_SLAVE_SERVICE_SNOC,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node xs_pcie_0 = {
 	.name = "xs_pcie_0",
-	.id = SM8250_SLAVE_PCIE_0,
 	.channels = 1,
 	.buswidth = 8,
 };
 
 static struct qcom_icc_node xs_pcie_1 = {
 	.name = "xs_pcie_1",
-	.id = SM8250_SLAVE_PCIE_1,
 	.channels = 1,
 	.buswidth = 8,
 };
 
 static struct qcom_icc_node xs_pcie_modem = {
 	.name = "xs_pcie_modem",
-	.id = SM8250_SLAVE_PCIE_2,
 	.channels = 1,
 	.buswidth = 8,
 };
 
 static struct qcom_icc_node xs_qdss_stm = {
 	.name = "xs_qdss_stm",
-	.id = SM8250_SLAVE_QDSS_STM,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node xs_sys_tcu_cfg = {
 	.name = "xs_sys_tcu_cfg",
-	.id = SM8250_SLAVE_TCU,
 	.channels = 1,
 	.buswidth = 8,
 };
 
 static struct qcom_icc_node qup0_core_master = {
 	.name = "qup0_core_master",
-	.id = SM8250_MASTER_QUP_CORE_0,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SM8250_SLAVE_QUP_CORE_0 },
+	.link_nodes = { &qup0_core_slave },
 };
 
 static struct qcom_icc_node qup1_core_master = {
 	.name = "qup1_core_master",
-	.id = SM8250_MASTER_QUP_CORE_1,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SM8250_SLAVE_QUP_CORE_1 },
+	.link_nodes = { &qup1_core_slave },
 };
 
 static struct qcom_icc_node qup2_core_master = {
 	.name = "qup2_core_master",
-	.id = SM8250_MASTER_QUP_CORE_2,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SM8250_SLAVE_QUP_CORE_2 },
+	.link_nodes = { &qup2_core_slave },
 };
 
 static struct qcom_icc_node qup0_core_slave = {
 	.name = "qup0_core_slave",
-	.id = SM8250_SLAVE_QUP_CORE_0,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qup1_core_slave = {
 	.name = "qup1_core_slave",
-	.id = SM8250_SLAVE_QUP_CORE_1,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qup2_core_slave = {
 	.name = "qup2_core_slave",
-	.id = SM8250_SLAVE_QUP_CORE_2,
 	.channels = 1,
 	.buswidth = 4,
 };
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
2.47.3



Return-Path: <linux-pm+bounces-37214-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF82C25B60
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 15:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CA8C1A63B07
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 14:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18FD52D1907;
	Fri, 31 Oct 2025 14:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="o0W7MD4+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QnbCuPc2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D09729A312
	for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2025 14:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761921964; cv=none; b=ovRFg95y2NCZmBsmpxrI3fq4Z9JNyXZogClhU/rZbA+/rbW4CXc+hrjVfsV3w41WfFz+kWRH0ii29au62B5rqKYA0A8HcHGjixdbHjwWr9m8iw6nh+skJr81HJ+5JkZGjiQ81SQ7rfL3md7MhkZslsSWgpUhQ5xEClrGxwmA4Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761921964; c=relaxed/simple;
	bh=xxTPtyfIph+nIfOV/q8csCLC27GNgRMY9fa1H8Ht6QE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p3FceUC+hYZDUTo3zceDRW9RiTWRDY+KGOOpTJHjAB8eC6jsYUpd+9LicqwEOQA6X/167h+hA9xyjyyDltRgl8eK1yYyKT590h9NZ0lYdZcdS/i5hAiVtuo9+lmm+MCIvfL6LwodoXRgN2kLdue08SMkNjYUKYdHKc5B1dCASTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=o0W7MD4+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QnbCuPc2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59V9sO2k102638
	for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2025 14:45:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lDDv2fE8ZtVIo2t1m5Ud6LdbneuycBTrfCAte1xtEvA=; b=o0W7MD4+q5ALJE0J
	qR8Smy6an/pCqg4icXXSs2v/Hkk3NZgBuFJvNMKn23k8Rfn0r0tlbFq5el26XzKz
	Zgq8/36uRL9OAal0N9Yt1yT/j4/RewSXQVkKEfiN6C/BzYbjoZSMOC+ewRPqjBX9
	YkwV5BMOa+fFRfcTUonG/x3piK7LiA4OmlspwFkbWuFRS6XeZKjuiBBpWwJW//c4
	sueiYCnIilQDOrGaFhXoaQ1J1ZBMfARaoWkoeW5ywtLR4jlvicc/9OJvUUqD17g2
	Dp8hztWSjAbncbycCOx6Q7KwtKMPK2R4jdUjD5o1s48DJwYd3c5OAP2/QIwbg2Su
	WDPQow==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a4ahdkg0e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2025 14:45:56 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-5db21e64ac8so4016219137.2
        for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2025 07:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761921955; x=1762526755; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lDDv2fE8ZtVIo2t1m5Ud6LdbneuycBTrfCAte1xtEvA=;
        b=QnbCuPc2Sjb8Mk5CqKOUWweRa9K8SB3oyVHeBLw9axbMkHuAajD2KoLASeJWo5uohb
         nG7oeCShzyYwjF1RQcKQfPWjnQ5or879Ng4c7fl6IDJKuB9bfVi8TGfml/yquq+oR+cV
         5zCKUBYHPu4rz78qsccXjjyBr4+0mLyxr65mIDIKK9WFzyMFW9WWMY0RW18JErZ3UtgP
         SDagc4x6LymoAJnKs2Kui9KckvNWp93LoG5rjb48Zo24+Qk1uCICQWJ5vVG6fclwhEHj
         gm1QvxGQ01NZHtIaGXWUIapIKiaf2ufjEDl4Mfw3F7HxCDPyHbUHwxR9jYVNuRhPwyY5
         De5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761921955; x=1762526755;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lDDv2fE8ZtVIo2t1m5Ud6LdbneuycBTrfCAte1xtEvA=;
        b=DRlJFjBozNMBxHu4nyBZa7V2Hc9ZU6EjfBHewAcx+xSixmQUTAZJtswfDpUemt56Qd
         90c5cpz6aWTR9LphYS+9VHyFRISZfLmNct58Gx0vIIBNjEYCmVJqziccvJXJKW9yR6g8
         T1UfgJPgDEDfxLNH6fgpvnXrdJkVL4afrFtwDXjMSrYzkm9eIgsvkPD2S3sGQMwqLQUg
         1Rr0LL6OCWtgp5ZGFMl3DK4OWXbZJnpgdiHcgay2u9hHJKXZJiNSHBqU1TQiqfumQjrQ
         8UVogvacBYI8uaOoT02uw4VbYvRMQRgaKlBXLOpWZe7q5E1N9DoMO75Ia7cslp5d3Bl/
         bNRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsj7s1cXZzpswbgteULGpxRSglbXhHSGevyUsA6VrkJEZQfc+CnShyhDGk6FR/YY17GB4nRBDBzA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzK24t1ak6lbHXJFTFuhRmtUFUq+YLNSg3XUzD03BYOKO8gxMIC
	3x4lq+KYt5JpYENkjfcTxxVvNKeedgIkGa06bt1YHAwfQWsWO8C/oW6XEctMXTY+fjc24yZaXPS
	rMokgQV8XElb6ijD23haR/no6bof15yLpI0tig2U7dDJZ/4NNoKl9f4xz5Depah170VpW/A==
X-Gm-Gg: ASbGnct9pg1kGqVkFiQDDDXiAbCFb6QPuSFFOUwj35ZCleSC2B3oycGTpZb+7dbUDzZ
	wlNyjqWutLX5m0XWewT0UTN8qbgZiOnrqnFdj7VeCtBwFF/N2rMtKZrpcjxqEUcAwZdcSky2vuv
	MdudOrrhp7BzuEoEm8P0d5p2UjPwIrs4vPu/LrOL25AdGC4qr+RDEpCI4xCTBbZHROx1dnuM06B
	5w1gu2E7oEd4y5eB21Rsiy3web6/WtkhfMLEB/tMwocgoJC9v6aoA9x9K+fQRgI7jkrJbG5znda
	4mG7ngVyV+SrsAFO/Im3SGqil9BElV1DGbI9luejuu7oqrS4hqYBtYpcHt4O1cP53ffKA6au0Dh
	3gOvjQS7Nc5sHxBqbPDOWpB021E9UjIli6KuhemMXL36RAPOSaI22Oy3WISGVoCzkNBtHXJ11vK
	QIdmEV103WlHpS
X-Received: by 2002:a05:6102:dc9:b0:5d5:f6ae:3900 with SMTP id ada2fe7eead31-5dbb13ab6e0mr1128460137.45.1761921954549;
        Fri, 31 Oct 2025 07:45:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPX/hCce0cNuTgz2dOBvX9YuloTuqlX+2Bx7RcDIoRj0HQQU7Q9vw9Y9H4lqmCIlwEEizb3A==
X-Received: by 2002:a05:6102:dc9:b0:5d5:f6ae:3900 with SMTP id ada2fe7eead31-5dbb13ab6e0mr1128433137.45.1761921953778;
        Fri, 31 Oct 2025 07:45:53 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5941f5bc218sm541405e87.93.2025.10.31.07.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 07:45:53 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 31 Oct 2025 16:45:32 +0200
Subject: [PATCH v3 16/25] interconnect: qcom: sdx75: convert to dynamic IDs
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-rework-icc-v3-16-0575304c9624@oss.qualcomm.com>
References: <20251031-rework-icc-v3-0-0575304c9624@oss.qualcomm.com>
In-Reply-To: <20251031-rework-icc-v3-0-0575304c9624@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=31100;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=xxTPtyfIph+nIfOV/q8csCLC27GNgRMY9fa1H8Ht6QE=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpBMuFhu6SA/T6BClkx5Gx2ktAwxAlYwGVC/VpZ
 pd29sR43IuJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaQTLhQAKCRCLPIo+Aiko
 1ZP6B/9JYBIXrO8vFsGTJd97SD1Fn3Xn2fOkSS2uSrraHqbImIMdZ1EO/cCWsd3sXaSAduqGDhj
 H9LDx9Xa4CqR9eOMO4zaDgE2c4GMakP0bjXxjipffHnLMpGxUbXEdkbQaPiBhmOwXK68HJ57oZt
 3jg9HX5Vb/5yXliwcftr2qhb6v0DPRhAOrGEjR8CADnKNVGnNqavyRd/BFc3NAOL96OIxWiFRTi
 EHWKSRpjHNk5FxhyghA6wHHmxWOnjFUoAZswY0zpDHUtpPkP0KfMAVpCyRu2+4KOZJE59I7BAgw
 U7ZRz0XNcjtUXs8S4urnfg5PxmWT1vvsu7ImJFh4Ta6S/y86
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDEzMyBTYWx0ZWRfX3msdbcOk6ZDU
 sarOOaaD8Gc5/VHV1dd9n5seY4GeJOPAMLphtx1VzYEXxmNHiUE74CcTGHLFy4teV+DfsPlPXXr
 nyz8VZp4e6ns+i+sLujsa3hcAUgAcZr2t3aRaOL2pynZz6qENrUBostUxTOz0icYchVvbRMYDhB
 Yik+nmdVgOBYPiaeObHUUFtuJaVIj/NML7jwgGUq2Eg4qtdFBKyDwtbUCFW9Cx7HKm1Ql06UsgY
 dFDMYBWpIPOJIDOwIQrK2tDNQnTTuedFw4iySOjFGLG2CIpuO9lRdksNVaKflru63gVGGgyuMiR
 r2D1j1UE42W73GM6i/uOdI0GLSvsehm2TjV2ceYgh+WVFVs47vkuGgYlTvjuP5vhuNxozOza7f+
 GnPFsH5j22+WhKZS6uKmnNyTTZhkOQ==
X-Proofpoint-GUID: sJNOR8OHqnIhrxz5EeYP9huR1Vknm19i
X-Authority-Analysis: v=2.4 cv=TsnrRTXh c=1 sm=1 tr=0 ts=6904cba4 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=-8yzlD1CfS_JFpsswxgA:9 a=QEXdDO2ut3YA:10
 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-ORIG-GUID: sJNOR8OHqnIhrxz5EeYP9huR1Vknm19i
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
 drivers/interconnect/qcom/sdx75.c | 384 +++++++++++++++++---------------------
 drivers/interconnect/qcom/sdx75.h |  97 ----------
 2 files changed, 174 insertions(+), 307 deletions(-)

diff --git a/drivers/interconnect/qcom/sdx75.c b/drivers/interconnect/qcom/sdx75.c
index 7ef1f17f3292e15959cb06e3d8d8c5f3c6ecd060..3721d8f503a022e4c5fde62b0aa9eed9989c1554 100644
--- a/drivers/interconnect/qcom/sdx75.c
+++ b/drivers/interconnect/qcom/sdx75.c
@@ -14,782 +14,740 @@
 #include "bcm-voter.h"
 #include "icc-common.h"
 #include "icc-rpmh.h"
-#include "sdx75.h"
+
+static struct qcom_icc_node qpic_core_master;
+static struct qcom_icc_node qup0_core_master;
+static struct qcom_icc_node qnm_cnoc;
+static struct qcom_icc_node alm_sys_tcu;
+static struct qcom_icc_node chm_apps;
+static struct qcom_icc_node qnm_gemnoc_cfg;
+static struct qcom_icc_node qnm_mdsp;
+static struct qcom_icc_node qnm_pcie;
+static struct qcom_icc_node qnm_snoc_sf;
+static struct qcom_icc_node xm_gic;
+static struct qcom_icc_node xm_ipa2pcie;
+static struct qcom_icc_node llcc_mc;
+static struct qcom_icc_node xm_pcie3_0;
+static struct qcom_icc_node xm_pcie3_1;
+static struct qcom_icc_node xm_pcie3_2;
+static struct qcom_icc_node qhm_audio;
+static struct qcom_icc_node qhm_gic;
+static struct qcom_icc_node qhm_pcie_rscc;
+static struct qcom_icc_node qhm_qdss_bam;
+static struct qcom_icc_node qhm_qpic;
+static struct qcom_icc_node qhm_qup0;
+static struct qcom_icc_node qnm_aggre_noc;
+static struct qcom_icc_node qnm_gemnoc_cnoc;
+static struct qcom_icc_node qnm_gemnoc_pcie;
+static struct qcom_icc_node qnm_system_noc_cfg;
+static struct qcom_icc_node qnm_system_noc_pcie_cfg;
+static struct qcom_icc_node qxm_crypto;
+static struct qcom_icc_node qxm_ipa;
+static struct qcom_icc_node qxm_mvmss;
+static struct qcom_icc_node xm_emac_0;
+static struct qcom_icc_node xm_emac_1;
+static struct qcom_icc_node xm_qdss_etr0;
+static struct qcom_icc_node xm_qdss_etr1;
+static struct qcom_icc_node xm_sdc1;
+static struct qcom_icc_node xm_sdc4;
+static struct qcom_icc_node xm_usb3;
+static struct qcom_icc_node qpic_core_slave;
+static struct qcom_icc_node qup0_core_slave;
+static struct qcom_icc_node qhs_lagg;
+static struct qcom_icc_node qhs_mccc_master;
+static struct qcom_icc_node qns_gemnoc;
+static struct qcom_icc_node qss_snoop_bwmon;
+static struct qcom_icc_node qns_gemnoc_cnoc;
+static struct qcom_icc_node qns_llcc;
+static struct qcom_icc_node qns_pcie;
+static struct qcom_icc_node srvc_gemnoc;
+static struct qcom_icc_node ebi;
+static struct qcom_icc_node qns_pcie_gemnoc;
+static struct qcom_icc_node ps_eth0_cfg;
+static struct qcom_icc_node ps_eth1_cfg;
+static struct qcom_icc_node qhs_audio;
+static struct qcom_icc_node qhs_clk_ctl;
+static struct qcom_icc_node qhs_crypto_cfg;
+static struct qcom_icc_node qhs_imem_cfg;
+static struct qcom_icc_node qhs_ipa;
+static struct qcom_icc_node qhs_ipc_router;
+static struct qcom_icc_node qhs_mss_cfg;
+static struct qcom_icc_node qhs_mvmss_cfg;
+static struct qcom_icc_node qhs_pcie0_cfg;
+static struct qcom_icc_node qhs_pcie1_cfg;
+static struct qcom_icc_node qhs_pcie2_cfg;
+static struct qcom_icc_node qhs_pcie_rscc;
+static struct qcom_icc_node qhs_pdm;
+static struct qcom_icc_node qhs_prng;
+static struct qcom_icc_node qhs_qdss_cfg;
+static struct qcom_icc_node qhs_qpic;
+static struct qcom_icc_node qhs_qup0;
+static struct qcom_icc_node qhs_sdc1;
+static struct qcom_icc_node qhs_sdc4;
+static struct qcom_icc_node qhs_spmi_vgi_coex;
+static struct qcom_icc_node qhs_tcsr;
+static struct qcom_icc_node qhs_tlmm;
+static struct qcom_icc_node qhs_usb3;
+static struct qcom_icc_node qhs_usb3_phy;
+static struct qcom_icc_node qns_a1noc;
+static struct qcom_icc_node qns_ddrss_cfg;
+static struct qcom_icc_node qns_gemnoc_sf;
+static struct qcom_icc_node qns_system_noc_cfg;
+static struct qcom_icc_node qns_system_noc_pcie_cfg;
+static struct qcom_icc_node qxs_imem;
+static struct qcom_icc_node srvc_pcie_system_noc;
+static struct qcom_icc_node srvc_system_noc;
+static struct qcom_icc_node xs_pcie_0;
+static struct qcom_icc_node xs_pcie_1;
+static struct qcom_icc_node xs_pcie_2;
+static struct qcom_icc_node xs_qdss_stm;
+static struct qcom_icc_node xs_sys_tcu_cfg;
 
 static struct qcom_icc_node qpic_core_master = {
 	.name = "qpic_core_master",
-	.id = SDX75_MASTER_QPIC_CORE,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SDX75_SLAVE_QPIC_CORE },
+	.link_nodes = { &qpic_core_slave },
 };
 
 static struct qcom_icc_node qup0_core_master = {
 	.name = "qup0_core_master",
-	.id = SDX75_MASTER_QUP_CORE_0,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SDX75_SLAVE_QUP_CORE_0 },
+	.link_nodes = { &qup0_core_slave },
 };
 
 static struct qcom_icc_node qnm_cnoc = {
 	.name = "qnm_cnoc",
-	.id = SDX75_MASTER_CNOC_DC_NOC,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 4,
-	.links = { SDX75_SLAVE_LAGG_CFG, SDX75_SLAVE_MCCC_MASTER,
-		   SDX75_SLAVE_GEM_NOC_CFG, SDX75_SLAVE_SNOOP_BWMON },
+	.link_nodes = { &qhs_lagg, &qhs_mccc_master,
+			&qns_gemnoc, &qss_snoop_bwmon },
 };
 
 static struct qcom_icc_node alm_sys_tcu = {
 	.name = "alm_sys_tcu",
-	.id = SDX75_MASTER_SYS_TCU,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 2,
-	.links = { SDX75_SLAVE_GEM_NOC_CNOC, SDX75_SLAVE_LLCC },
+	.link_nodes = { &qns_gemnoc_cnoc, &qns_llcc },
 };
 
 static struct qcom_icc_node chm_apps = {
 	.name = "chm_apps",
-	.id = SDX75_MASTER_APPSS_PROC,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 3,
-	.links = { SDX75_SLAVE_GEM_NOC_CNOC, SDX75_SLAVE_LLCC,
-		   SDX75_SLAVE_MEM_NOC_PCIE_SNOC },
+	.link_nodes = { &qns_gemnoc_cnoc, &qns_llcc,
+			&qns_pcie },
 };
 
 static struct qcom_icc_node qnm_gemnoc_cfg = {
 	.name = "qnm_gemnoc_cfg",
-	.id = SDX75_MASTER_GEM_NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SDX75_SLAVE_SERVICE_GEM_NOC },
+	.link_nodes = { &srvc_gemnoc },
 };
 
 static struct qcom_icc_node qnm_mdsp = {
 	.name = "qnm_mdsp",
-	.id = SDX75_MASTER_MSS_PROC,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 3,
-	.links = { SDX75_SLAVE_GEM_NOC_CNOC, SDX75_SLAVE_LLCC,
-		   SDX75_SLAVE_MEM_NOC_PCIE_SNOC },
+	.link_nodes = { &qns_gemnoc_cnoc, &qns_llcc,
+			&qns_pcie },
 };
 
 static struct qcom_icc_node qnm_pcie = {
 	.name = "qnm_pcie",
-	.id = SDX75_MASTER_ANOC_PCIE_GEM_NOC,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 2,
-	.links = { SDX75_SLAVE_GEM_NOC_CNOC, SDX75_SLAVE_LLCC },
+	.link_nodes = { &qns_gemnoc_cnoc, &qns_llcc },
 };
 
 static struct qcom_icc_node qnm_snoc_sf = {
 	.name = "qnm_snoc_sf",
-	.id = SDX75_MASTER_SNOC_SF_MEM_NOC,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 3,
-	.links = { SDX75_SLAVE_GEM_NOC_CNOC, SDX75_SLAVE_LLCC,
-		   SDX75_SLAVE_MEM_NOC_PCIE_SNOC },
+	.link_nodes = { &qns_gemnoc_cnoc, &qns_llcc,
+			&qns_pcie },
 };
 
 static struct qcom_icc_node xm_gic = {
 	.name = "xm_gic",
-	.id = SDX75_MASTER_GIC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SDX75_SLAVE_LLCC },
+	.link_nodes = { &qns_llcc },
 };
 
 static struct qcom_icc_node xm_ipa2pcie = {
 	.name = "xm_ipa2pcie",
-	.id = SDX75_MASTER_IPA_PCIE,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SDX75_SLAVE_MEM_NOC_PCIE_SNOC },
+	.link_nodes = { &qns_pcie },
 };
 
 static struct qcom_icc_node llcc_mc = {
 	.name = "llcc_mc",
-	.id = SDX75_MASTER_LLCC,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SDX75_SLAVE_EBI1 },
+	.link_nodes = { &ebi },
 };
 
 static struct qcom_icc_node xm_pcie3_0 = {
 	.name = "xm_pcie3_0",
-	.id = SDX75_MASTER_PCIE_0,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SDX75_SLAVE_ANOC_PCIE_GEM_NOC },
+	.link_nodes = { &qns_pcie_gemnoc },
 };
 
 static struct qcom_icc_node xm_pcie3_1 = {
 	.name = "xm_pcie3_1",
-	.id = SDX75_MASTER_PCIE_1,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SDX75_SLAVE_ANOC_PCIE_GEM_NOC },
+	.link_nodes = { &qns_pcie_gemnoc },
 };
 
 static struct qcom_icc_node xm_pcie3_2 = {
 	.name = "xm_pcie3_2",
-	.id = SDX75_MASTER_PCIE_2,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SDX75_SLAVE_ANOC_PCIE_GEM_NOC },
+	.link_nodes = { &qns_pcie_gemnoc },
 };
 
 static struct qcom_icc_node qhm_audio = {
 	.name = "qhm_audio",
-	.id = SDX75_MASTER_AUDIO,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SDX75_SLAVE_SNOC_GEM_NOC_SF },
+	.link_nodes = { &qns_gemnoc_sf },
 };
 
 static struct qcom_icc_node qhm_gic = {
 	.name = "qhm_gic",
-	.id = SDX75_MASTER_GIC_AHB,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SDX75_SLAVE_SNOC_GEM_NOC_SF },
+	.link_nodes = { &qns_gemnoc_sf },
 };
 
 static struct qcom_icc_node qhm_pcie_rscc = {
 	.name = "qhm_pcie_rscc",
-	.id = SDX75_MASTER_PCIE_RSCC,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 31,
-	.links = { SDX75_SLAVE_ETH0_CFG, SDX75_SLAVE_ETH1_CFG,
-		   SDX75_SLAVE_AUDIO, SDX75_SLAVE_CLK_CTL,
-		   SDX75_SLAVE_CRYPTO_0_CFG, SDX75_SLAVE_IMEM_CFG,
-		   SDX75_SLAVE_IPA_CFG, SDX75_SLAVE_IPC_ROUTER_CFG,
-		   SDX75_SLAVE_CNOC_MSS, SDX75_SLAVE_ICBDI_MVMSS_CFG,
-		   SDX75_SLAVE_PCIE_0_CFG, SDX75_SLAVE_PCIE_1_CFG,
-		   SDX75_SLAVE_PCIE_2_CFG, SDX75_SLAVE_PDM,
-		   SDX75_SLAVE_PRNG, SDX75_SLAVE_QDSS_CFG,
-		   SDX75_SLAVE_QPIC, SDX75_SLAVE_QUP_0,
-		   SDX75_SLAVE_SDCC_1, SDX75_SLAVE_SDCC_4,
-		   SDX75_SLAVE_SPMI_VGI_COEX, SDX75_SLAVE_TCSR,
-		   SDX75_SLAVE_TLMM, SDX75_SLAVE_USB3,
-		   SDX75_SLAVE_USB3_PHY_CFG, SDX75_SLAVE_DDRSS_CFG,
-		   SDX75_SLAVE_SNOC_CFG, SDX75_SLAVE_PCIE_ANOC_CFG,
-		   SDX75_SLAVE_IMEM, SDX75_SLAVE_QDSS_STM,
-		   SDX75_SLAVE_TCU },
+	.link_nodes = { &ps_eth0_cfg, &ps_eth1_cfg,
+			&qhs_audio, &qhs_clk_ctl,
+			&qhs_crypto_cfg, &qhs_imem_cfg,
+			&qhs_ipa, &qhs_ipc_router,
+			&qhs_mss_cfg, &qhs_mvmss_cfg,
+			&qhs_pcie0_cfg, &qhs_pcie1_cfg,
+			&qhs_pcie2_cfg, &qhs_pdm,
+			&qhs_prng, &qhs_qdss_cfg,
+			&qhs_qpic, &qhs_qup0,
+			&qhs_sdc1, &qhs_sdc4,
+			&qhs_spmi_vgi_coex, &qhs_tcsr,
+			&qhs_tlmm, &qhs_usb3,
+			&qhs_usb3_phy, &qns_ddrss_cfg,
+			&qns_system_noc_cfg, &qns_system_noc_pcie_cfg,
+			&qxs_imem, &xs_qdss_stm,
+			&xs_sys_tcu_cfg },
 };
 
 static struct qcom_icc_node qhm_qdss_bam = {
 	.name = "qhm_qdss_bam",
-	.id = SDX75_MASTER_QDSS_BAM,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SDX75_SLAVE_A1NOC_CFG },
+	.link_nodes = { &qns_a1noc },
 };
 
 static struct qcom_icc_node qhm_qpic = {
 	.name = "qhm_qpic",
-	.id = SDX75_MASTER_QPIC,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SDX75_SLAVE_A1NOC_CFG },
+	.link_nodes = { &qns_a1noc },
 };
 
 static struct qcom_icc_node qhm_qup0 = {
 	.name = "qhm_qup0",
-	.id = SDX75_MASTER_QUP_0,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SDX75_SLAVE_A1NOC_CFG },
+	.link_nodes = { &qns_a1noc },
 };
 
 static struct qcom_icc_node qnm_aggre_noc = {
 	.name = "qnm_aggre_noc",
-	.id = SDX75_MASTER_ANOC_SNOC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SDX75_SLAVE_SNOC_GEM_NOC_SF },
+	.link_nodes = { &qns_gemnoc_sf },
 };
 
 static struct qcom_icc_node qnm_gemnoc_cnoc = {
 	.name = "qnm_gemnoc_cnoc",
-	.id = SDX75_MASTER_GEM_NOC_CNOC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 32,
-	.links = { SDX75_SLAVE_ETH0_CFG, SDX75_SLAVE_ETH1_CFG,
-		   SDX75_SLAVE_AUDIO, SDX75_SLAVE_CLK_CTL,
-		   SDX75_SLAVE_CRYPTO_0_CFG, SDX75_SLAVE_IMEM_CFG,
-		   SDX75_SLAVE_IPA_CFG, SDX75_SLAVE_IPC_ROUTER_CFG,
-		   SDX75_SLAVE_CNOC_MSS, SDX75_SLAVE_ICBDI_MVMSS_CFG,
-		   SDX75_SLAVE_PCIE_0_CFG, SDX75_SLAVE_PCIE_1_CFG,
-		   SDX75_SLAVE_PCIE_2_CFG, SDX75_SLAVE_PCIE_RSC_CFG,
-		   SDX75_SLAVE_PDM, SDX75_SLAVE_PRNG,
-		   SDX75_SLAVE_QDSS_CFG, SDX75_SLAVE_QPIC,
-		   SDX75_SLAVE_QUP_0, SDX75_SLAVE_SDCC_1,
-		   SDX75_SLAVE_SDCC_4, SDX75_SLAVE_SPMI_VGI_COEX,
-		   SDX75_SLAVE_TCSR, SDX75_SLAVE_TLMM,
-		   SDX75_SLAVE_USB3, SDX75_SLAVE_USB3_PHY_CFG,
-		   SDX75_SLAVE_DDRSS_CFG, SDX75_SLAVE_SNOC_CFG,
-		   SDX75_SLAVE_PCIE_ANOC_CFG, SDX75_SLAVE_IMEM,
-		   SDX75_SLAVE_QDSS_STM, SDX75_SLAVE_TCU },
+	.link_nodes = { &ps_eth0_cfg, &ps_eth1_cfg,
+			&qhs_audio, &qhs_clk_ctl,
+			&qhs_crypto_cfg, &qhs_imem_cfg,
+			&qhs_ipa, &qhs_ipc_router,
+			&qhs_mss_cfg, &qhs_mvmss_cfg,
+			&qhs_pcie0_cfg, &qhs_pcie1_cfg,
+			&qhs_pcie2_cfg, &qhs_pcie_rscc,
+			&qhs_pdm, &qhs_prng,
+			&qhs_qdss_cfg, &qhs_qpic,
+			&qhs_qup0, &qhs_sdc1,
+			&qhs_sdc4, &qhs_spmi_vgi_coex,
+			&qhs_tcsr, &qhs_tlmm,
+			&qhs_usb3, &qhs_usb3_phy,
+			&qns_ddrss_cfg, &qns_system_noc_cfg,
+			&qns_system_noc_pcie_cfg, &qxs_imem,
+			&xs_qdss_stm, &xs_sys_tcu_cfg },
 };
 
 static struct qcom_icc_node qnm_gemnoc_pcie = {
 	.name = "qnm_gemnoc_pcie",
-	.id = SDX75_MASTER_GEM_NOC_PCIE_SNOC,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 3,
-	.links = { SDX75_SLAVE_PCIE_0, SDX75_SLAVE_PCIE_1,
-		   SDX75_SLAVE_PCIE_2 },
+	.link_nodes = { &xs_pcie_0, &xs_pcie_1,
+			&xs_pcie_2 },
 };
 
 static struct qcom_icc_node qnm_system_noc_cfg = {
 	.name = "qnm_system_noc_cfg",
-	.id = SDX75_MASTER_SNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SDX75_SLAVE_SERVICE_SNOC },
+	.link_nodes = { &srvc_system_noc },
 };
 
 static struct qcom_icc_node qnm_system_noc_pcie_cfg = {
 	.name = "qnm_system_noc_pcie_cfg",
-	.id = SDX75_MASTER_PCIE_ANOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SDX75_SLAVE_SERVICE_PCIE_ANOC },
+	.link_nodes = { &srvc_pcie_system_noc },
 };
 
 static struct qcom_icc_node qxm_crypto = {
 	.name = "qxm_crypto",
-	.id = SDX75_MASTER_CRYPTO,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SDX75_SLAVE_A1NOC_CFG },
+	.link_nodes = { &qns_a1noc },
 };
 
 static struct qcom_icc_node qxm_ipa = {
 	.name = "qxm_ipa",
-	.id = SDX75_MASTER_IPA,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SDX75_SLAVE_SNOC_GEM_NOC_SF },
+	.link_nodes = { &qns_gemnoc_sf },
 };
 
 static struct qcom_icc_node qxm_mvmss = {
 	.name = "qxm_mvmss",
-	.id = SDX75_MASTER_MVMSS,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SDX75_SLAVE_A1NOC_CFG },
+	.link_nodes = { &qns_a1noc },
 };
 
 static struct qcom_icc_node xm_emac_0 = {
 	.name = "xm_emac_0",
-	.id = SDX75_MASTER_EMAC_0,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SDX75_SLAVE_A1NOC_CFG },
+	.link_nodes = { &qns_a1noc },
 };
 
 static struct qcom_icc_node xm_emac_1 = {
 	.name = "xm_emac_1",
-	.id = SDX75_MASTER_EMAC_1,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SDX75_SLAVE_A1NOC_CFG },
+	.link_nodes = { &qns_a1noc },
 };
 
 static struct qcom_icc_node xm_qdss_etr0 = {
 	.name = "xm_qdss_etr0",
-	.id = SDX75_MASTER_QDSS_ETR,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SDX75_SLAVE_A1NOC_CFG },
+	.link_nodes = { &qns_a1noc },
 };
 
 static struct qcom_icc_node xm_qdss_etr1 = {
 	.name = "xm_qdss_etr1",
-	.id = SDX75_MASTER_QDSS_ETR_1,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SDX75_SLAVE_A1NOC_CFG },
+	.link_nodes = { &qns_a1noc },
 };
 
 static struct qcom_icc_node xm_sdc1 = {
 	.name = "xm_sdc1",
-	.id = SDX75_MASTER_SDCC_1,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SDX75_SLAVE_A1NOC_CFG },
+	.link_nodes = { &qns_a1noc },
 };
 
 static struct qcom_icc_node xm_sdc4 = {
 	.name = "xm_sdc4",
-	.id = SDX75_MASTER_SDCC_4,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SDX75_SLAVE_A1NOC_CFG },
+	.link_nodes = { &qns_a1noc },
 };
 
 static struct qcom_icc_node xm_usb3 = {
 	.name = "xm_usb3",
-	.id = SDX75_MASTER_USB3_0,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SDX75_SLAVE_A1NOC_CFG },
+	.link_nodes = { &qns_a1noc },
 };
 
 static struct qcom_icc_node qpic_core_slave = {
 	.name = "qpic_core_slave",
-	.id = SDX75_SLAVE_QPIC_CORE,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qup0_core_slave = {
 	.name = "qup0_core_slave",
-	.id = SDX75_SLAVE_QUP_CORE_0,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_lagg = {
 	.name = "qhs_lagg",
-	.id = SDX75_SLAVE_LAGG_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_mccc_master = {
 	.name = "qhs_mccc_master",
-	.id = SDX75_SLAVE_MCCC_MASTER,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qns_gemnoc = {
 	.name = "qns_gemnoc",
-	.id = SDX75_SLAVE_GEM_NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qss_snoop_bwmon = {
 	.name = "qss_snoop_bwmon",
-	.id = SDX75_SLAVE_SNOOP_BWMON,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qns_gemnoc_cnoc = {
 	.name = "qns_gemnoc_cnoc",
-	.id = SDX75_SLAVE_GEM_NOC_CNOC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SDX75_MASTER_GEM_NOC_CNOC },
+	.link_nodes = { &qnm_gemnoc_cnoc },
 };
 
 static struct qcom_icc_node qns_llcc = {
 	.name = "qns_llcc",
-	.id = SDX75_SLAVE_LLCC,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { SDX75_MASTER_LLCC },
+	.link_nodes = { &llcc_mc },
 };
 
 static struct qcom_icc_node qns_pcie = {
 	.name = "qns_pcie",
-	.id = SDX75_SLAVE_MEM_NOC_PCIE_SNOC,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { SDX75_MASTER_GEM_NOC_PCIE_SNOC },
+	.link_nodes = { &qnm_gemnoc_pcie },
 };
 
 static struct qcom_icc_node srvc_gemnoc = {
 	.name = "srvc_gemnoc",
-	.id = SDX75_SLAVE_SERVICE_GEM_NOC,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node ebi = {
 	.name = "ebi",
-	.id = SDX75_SLAVE_EBI1,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qns_pcie_gemnoc = {
 	.name = "qns_pcie_gemnoc",
-	.id = SDX75_SLAVE_ANOC_PCIE_GEM_NOC,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { SDX75_MASTER_ANOC_PCIE_GEM_NOC },
+	.link_nodes = { &qnm_pcie },
 };
 
 static struct qcom_icc_node ps_eth0_cfg = {
 	.name = "ps_eth0_cfg",
-	.id = SDX75_SLAVE_ETH0_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node ps_eth1_cfg = {
 	.name = "ps_eth1_cfg",
-	.id = SDX75_SLAVE_ETH1_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_audio = {
 	.name = "qhs_audio",
-	.id = SDX75_SLAVE_AUDIO,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_clk_ctl = {
 	.name = "qhs_clk_ctl",
-	.id = SDX75_SLAVE_CLK_CTL,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_crypto_cfg = {
 	.name = "qhs_crypto_cfg",
-	.id = SDX75_SLAVE_CRYPTO_0_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_imem_cfg = {
 	.name = "qhs_imem_cfg",
-	.id = SDX75_SLAVE_IMEM_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_ipa = {
 	.name = "qhs_ipa",
-	.id = SDX75_SLAVE_IPA_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_ipc_router = {
 	.name = "qhs_ipc_router",
-	.id = SDX75_SLAVE_IPC_ROUTER_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_mss_cfg = {
 	.name = "qhs_mss_cfg",
-	.id = SDX75_SLAVE_CNOC_MSS,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_mvmss_cfg = {
 	.name = "qhs_mvmss_cfg",
-	.id = SDX75_SLAVE_ICBDI_MVMSS_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_pcie0_cfg = {
 	.name = "qhs_pcie0_cfg",
-	.id = SDX75_SLAVE_PCIE_0_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_pcie1_cfg = {
 	.name = "qhs_pcie1_cfg",
-	.id = SDX75_SLAVE_PCIE_1_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_pcie2_cfg = {
 	.name = "qhs_pcie2_cfg",
-	.id = SDX75_SLAVE_PCIE_2_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_pcie_rscc = {
 	.name = "qhs_pcie_rscc",
-	.id = SDX75_SLAVE_PCIE_RSC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_pdm = {
 	.name = "qhs_pdm",
-	.id = SDX75_SLAVE_PDM,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_prng = {
 	.name = "qhs_prng",
-	.id = SDX75_SLAVE_PRNG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_qdss_cfg = {
 	.name = "qhs_qdss_cfg",
-	.id = SDX75_SLAVE_QDSS_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_qpic = {
 	.name = "qhs_qpic",
-	.id = SDX75_SLAVE_QPIC,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_qup0 = {
 	.name = "qhs_qup0",
-	.id = SDX75_SLAVE_QUP_0,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_sdc1 = {
 	.name = "qhs_sdc1",
-	.id = SDX75_SLAVE_SDCC_1,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_sdc4 = {
 	.name = "qhs_sdc4",
-	.id = SDX75_SLAVE_SDCC_4,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_spmi_vgi_coex = {
 	.name = "qhs_spmi_vgi_coex",
-	.id = SDX75_SLAVE_SPMI_VGI_COEX,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_tcsr = {
 	.name = "qhs_tcsr",
-	.id = SDX75_SLAVE_TCSR,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_tlmm = {
 	.name = "qhs_tlmm",
-	.id = SDX75_SLAVE_TLMM,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_usb3 = {
 	.name = "qhs_usb3",
-	.id = SDX75_SLAVE_USB3,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qhs_usb3_phy = {
 	.name = "qhs_usb3_phy",
-	.id = SDX75_SLAVE_USB3_PHY_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node qns_a1noc = {
 	.name = "qns_a1noc",
-	.id = SDX75_SLAVE_A1NOC_CFG,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SDX75_MASTER_ANOC_SNOC },
+	.link_nodes = { &qnm_aggre_noc },
 };
 
 static struct qcom_icc_node qns_ddrss_cfg = {
 	.name = "qns_ddrss_cfg",
-	.id = SDX75_SLAVE_DDRSS_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SDX75_MASTER_CNOC_DC_NOC },
+	.link_nodes = { &qnm_cnoc },
 };
 
 static struct qcom_icc_node qns_gemnoc_sf = {
 	.name = "qns_gemnoc_sf",
-	.id = SDX75_SLAVE_SNOC_GEM_NOC_SF,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { SDX75_MASTER_SNOC_SF_MEM_NOC },
+	.link_nodes = { &qnm_snoc_sf },
 };
 
 static struct qcom_icc_node qns_system_noc_cfg = {
 	.name = "qns_system_noc_cfg",
-	.id = SDX75_SLAVE_SNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SDX75_MASTER_SNOC_CFG },
+	.link_nodes = { &qnm_system_noc_cfg },
 };
 
 static struct qcom_icc_node qns_system_noc_pcie_cfg = {
 	.name = "qns_system_noc_pcie_cfg",
-	.id = SDX75_SLAVE_PCIE_ANOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SDX75_MASTER_PCIE_ANOC_CFG },
+	.link_nodes = { &qnm_system_noc_pcie_cfg },
 };
 
 static struct qcom_icc_node qxs_imem = {
 	.name = "qxs_imem",
-	.id = SDX75_SLAVE_IMEM,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node srvc_pcie_system_noc = {
 	.name = "srvc_pcie_system_noc",
-	.id = SDX75_SLAVE_SERVICE_PCIE_ANOC,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node srvc_system_noc = {
 	.name = "srvc_system_noc",
-	.id = SDX75_SLAVE_SERVICE_SNOC,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node xs_pcie_0 = {
 	.name = "xs_pcie_0",
-	.id = SDX75_SLAVE_PCIE_0,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node xs_pcie_1 = {
 	.name = "xs_pcie_1",
-	.id = SDX75_SLAVE_PCIE_1,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node xs_pcie_2 = {
 	.name = "xs_pcie_2",
-	.id = SDX75_SLAVE_PCIE_2,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node xs_qdss_stm = {
 	.name = "xs_qdss_stm",
-	.id = SDX75_SLAVE_QDSS_STM,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
 };
 
 static struct qcom_icc_node xs_sys_tcu_cfg = {
 	.name = "xs_sys_tcu_cfg",
-	.id = SDX75_SLAVE_TCU,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 0,
 };
 
 static struct qcom_icc_bcm bcm_ce0 = {
@@ -910,6 +868,7 @@ static struct qcom_icc_node * const clk_virt_nodes[] = {
 };
 
 static const struct qcom_icc_desc sdx75_clk_virt = {
+	.alloc_dyn_id = true,
 	.nodes = clk_virt_nodes,
 	.num_nodes = ARRAY_SIZE(clk_virt_nodes),
 	.bcms = clk_virt_bcms,
@@ -925,6 +884,7 @@ static struct qcom_icc_node * const dc_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sdx75_dc_noc = {
+	.alloc_dyn_id = true,
 	.nodes = dc_noc_nodes,
 	.num_nodes = ARRAY_SIZE(dc_noc_nodes),
 };
@@ -951,6 +911,7 @@ static struct qcom_icc_node * const gem_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sdx75_gem_noc = {
+	.alloc_dyn_id = true,
 	.nodes = gem_noc_nodes,
 	.num_nodes = ARRAY_SIZE(gem_noc_nodes),
 	.bcms = gem_noc_bcms,
@@ -967,6 +928,7 @@ static struct qcom_icc_node * const mc_virt_nodes[] = {
 };
 
 static const struct qcom_icc_desc sdx75_mc_virt = {
+	.alloc_dyn_id = true,
 	.nodes = mc_virt_nodes,
 	.num_nodes = ARRAY_SIZE(mc_virt_nodes),
 	.bcms = mc_virt_bcms,
@@ -986,6 +948,7 @@ static struct qcom_icc_node * const pcie_anoc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sdx75_pcie_anoc = {
+	.alloc_dyn_id = true,
 	.nodes = pcie_anoc_nodes,
 	.num_nodes = ARRAY_SIZE(pcie_anoc_nodes),
 	.bcms = pcie_anoc_bcms,
@@ -1064,6 +1027,7 @@ static struct qcom_icc_node * const system_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sdx75_system_noc = {
+	.alloc_dyn_id = true,
 	.nodes = system_noc_nodes,
 	.num_nodes = ARRAY_SIZE(system_noc_nodes),
 	.bcms = system_noc_bcms,
diff --git a/drivers/interconnect/qcom/sdx75.h b/drivers/interconnect/qcom/sdx75.h
deleted file mode 100644
index 24e88715992010d934a1a630979f864af3a8426c..0000000000000000000000000000000000000000
--- a/drivers/interconnect/qcom/sdx75.h
+++ /dev/null
@@ -1,97 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
- */
-
-#ifndef __DRIVERS_INTERCONNECT_QCOM_SDX75_H
-#define __DRIVERS_INTERCONNECT_QCOM_SDX75_H
-
-#define SDX75_MASTER_ANOC_PCIE_GEM_NOC		0
-#define SDX75_MASTER_ANOC_SNOC			1
-#define SDX75_MASTER_APPSS_PROC			2
-#define SDX75_MASTER_AUDIO			3
-#define SDX75_MASTER_CNOC_DC_NOC		4
-#define SDX75_MASTER_CRYPTO			5
-#define SDX75_MASTER_EMAC_0			6
-#define SDX75_MASTER_EMAC_1			7
-#define SDX75_MASTER_GEM_NOC_CFG		8
-#define SDX75_MASTER_GEM_NOC_CNOC		9
-#define SDX75_MASTER_GEM_NOC_PCIE_SNOC		10
-#define SDX75_MASTER_GIC			11
-#define SDX75_MASTER_GIC_AHB			12
-#define SDX75_MASTER_IPA			13
-#define SDX75_MASTER_IPA_PCIE			14
-#define SDX75_MASTER_LLCC			15
-#define SDX75_MASTER_MSS_PROC			16
-#define SDX75_MASTER_MVMSS			17
-#define SDX75_MASTER_PCIE_0			18
-#define SDX75_MASTER_PCIE_1			19
-#define SDX75_MASTER_PCIE_2			20
-#define SDX75_MASTER_PCIE_ANOC_CFG		21
-#define SDX75_MASTER_PCIE_RSCC			22
-#define SDX75_MASTER_QDSS_BAM			23
-#define SDX75_MASTER_QDSS_ETR			24
-#define SDX75_MASTER_QDSS_ETR_1			25
-#define SDX75_MASTER_QPIC			26
-#define SDX75_MASTER_QPIC_CORE			27
-#define SDX75_MASTER_QUP_0			28
-#define SDX75_MASTER_QUP_CORE_0			29
-#define SDX75_MASTER_SDCC_1			30
-#define SDX75_MASTER_SDCC_4			31
-#define SDX75_MASTER_SNOC_CFG			32
-#define SDX75_MASTER_SNOC_SF_MEM_NOC		33
-#define SDX75_MASTER_SYS_TCU			34
-#define SDX75_MASTER_USB3_0			35
-#define SDX75_SLAVE_A1NOC_CFG			36
-#define SDX75_SLAVE_ANOC_PCIE_GEM_NOC		37
-#define SDX75_SLAVE_AUDIO			38
-#define SDX75_SLAVE_CLK_CTL			39
-#define SDX75_SLAVE_CRYPTO_0_CFG		40
-#define SDX75_SLAVE_CNOC_MSS			41
-#define SDX75_SLAVE_DDRSS_CFG			42
-#define SDX75_SLAVE_EBI1			43
-#define SDX75_SLAVE_ETH0_CFG			44
-#define SDX75_SLAVE_ETH1_CFG			45
-#define SDX75_SLAVE_GEM_NOC_CFG			46
-#define SDX75_SLAVE_GEM_NOC_CNOC		47
-#define SDX75_SLAVE_ICBDI_MVMSS_CFG		48
-#define SDX75_SLAVE_IMEM			49
-#define SDX75_SLAVE_IMEM_CFG			50
-#define SDX75_SLAVE_IPA_CFG			51
-#define SDX75_SLAVE_IPC_ROUTER_CFG		52
-#define SDX75_SLAVE_LAGG_CFG			53
-#define SDX75_SLAVE_LLCC			54
-#define SDX75_SLAVE_MCCC_MASTER			55
-#define SDX75_SLAVE_MEM_NOC_PCIE_SNOC		56
-#define SDX75_SLAVE_PCIE_0			57
-#define SDX75_SLAVE_PCIE_1			58
-#define SDX75_SLAVE_PCIE_2			59
-#define SDX75_SLAVE_PCIE_0_CFG			60
-#define SDX75_SLAVE_PCIE_1_CFG			61
-#define SDX75_SLAVE_PCIE_2_CFG			62
-#define SDX75_SLAVE_PCIE_ANOC_CFG		63
-#define SDX75_SLAVE_PCIE_RSC_CFG		64
-#define SDX75_SLAVE_PDM				65
-#define SDX75_SLAVE_PRNG			66
-#define SDX75_SLAVE_QDSS_CFG			67
-#define SDX75_SLAVE_QDSS_STM			68
-#define SDX75_SLAVE_QPIC			69
-#define SDX75_SLAVE_QPIC_CORE			70
-#define SDX75_SLAVE_QUP_0			71
-#define SDX75_SLAVE_QUP_CORE_0			72
-#define SDX75_SLAVE_SDCC_1			73
-#define SDX75_SLAVE_SDCC_4			74
-#define SDX75_SLAVE_SERVICE_GEM_NOC		75
-#define SDX75_SLAVE_SERVICE_PCIE_ANOC		76
-#define SDX75_SLAVE_SERVICE_SNOC		77
-#define SDX75_SLAVE_SNOC_CFG			78
-#define SDX75_SLAVE_SNOC_GEM_NOC_SF		79
-#define SDX75_SLAVE_SNOOP_BWMON			80
-#define SDX75_SLAVE_SPMI_VGI_COEX		81
-#define SDX75_SLAVE_TCSR			82
-#define SDX75_SLAVE_TCU				83
-#define SDX75_SLAVE_TLMM			84
-#define SDX75_SLAVE_USB3			85
-#define SDX75_SLAVE_USB3_PHY_CFG		86
-
-#endif

-- 
2.47.3



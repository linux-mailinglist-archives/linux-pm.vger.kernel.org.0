Return-Path: <linux-pm+bounces-37203-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CADFC25A9A
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 15:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 387B83A3689
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 14:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6794277CA8;
	Fri, 31 Oct 2025 14:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hY0Qdr4s";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="B4hoPvlu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF5F232785
	for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2025 14:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761921946; cv=none; b=cUOeRl405Zaj1uyiXxgPGdmIWBvcWH9HArUMrLg0LQDTrrmu4qliy0A5XEMvPt3DzKiDqA01yKwdV1X0MBxUyUVkuuUFcbXY+bvVTCRNDtjpzGbebOBSDTs3GHb5EqLvigVvvAZPKc6pK+2uatGbhgSt1bX/YQFUPzFaNAfbWTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761921946; c=relaxed/simple;
	bh=7ulmETyiGU2WsCwZzdCVtDREtRVaD9uxvCocrUO+WBg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j90k8Hz5s9cQh37X7cRUh7yShMLDR63yLOWoJJxI7td90zcAm4mU9c2x/no29upGo7Papil5ouIJUrB2/LYYdjHUfmwzHHco6z0EySrWflnqeSH7g2oiTlWQCqFAKLiAM4FLejso7u1a3mef6GkTgJO2u5ihRujOlFpF5ITax/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hY0Qdr4s; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=B4hoPvlu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59VAL3EH1573206
	for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2025 14:45:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nxL2Fe7+zHX4Z/4ICY4EH/xhSYZNHlYnO0qy1OQsTm8=; b=hY0Qdr4sg/ZnPB/0
	z+4PUIysuQbv481E9sULCiBLw4dGdWlder79DB/7qynF2QgbXYSpvZLU5f3udZet
	PIXfuln9juH0381ncthj2WAIpU7RtFzdh+bsDD+4PmHWdT05YV/r02X2lAgWr82t
	YcqwDPwqHFtWiYioXl3zv2cFDHq5RpX6hAWLw7D7rUSP2+aDbZs6ElBIbMYqGHlA
	SePDbFWaPBumT1JhNuUoOH3OQ3N+Yrf9pstlFlMesixqYqV6iC3jM+/4hajV5rzQ
	Dgan0Lv7eWt/TylZmPJXis3lFnw0IFKjA6S7okKt3LPr+odpsth1A4oZ4q9p2SLd
	90pjXw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a4ksc1wtu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2025 14:45:39 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-87c6f88fda2so74321596d6.1
        for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2025 07:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761921938; x=1762526738; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nxL2Fe7+zHX4Z/4ICY4EH/xhSYZNHlYnO0qy1OQsTm8=;
        b=B4hoPvluxEYloaUKjrDP/RxUgJ4bZXtOo1l02ufxPxOH8w2X/MEhWkOG6Yv4V+KIH0
         UyyXL5OTvDk3czv28KMx1PvbRfHcd+MF+yPaxrVLY1oStm7mhcrlTVMjdmn0v/GbiLDe
         kp4QC8kp5UxsdqaEdkRaNyDEZU61lmszXseRZdwB3xqF1goI7w25qkQAx4OebRsoIkDj
         klq9+crD9u/P4NyMBHkga5Sl9ZiEXj9qVPecNHt4IUH4VyTkpZPNY6s3bxN+FQuhcbS2
         pLq9SUq0fv9x8UDpzQzBKON1bX/k4xeJGRrpADi+2XAkQMXRTsIO572yAjsMVIA8YJyn
         f5JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761921939; x=1762526739;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nxL2Fe7+zHX4Z/4ICY4EH/xhSYZNHlYnO0qy1OQsTm8=;
        b=j/7S1OFpRvOfSjGlDlYih+MBa8T4QzEthx9oBKC+a/9FmZtl0giz3XTmDbx/YNjNvE
         DbRVJSbQ7Xt1fUTVqE5DMROzQLX1KbV339MazPkwOuQCFyAC2MV7pmy//zlvUVbUj3J1
         SmurMr7UqKuDbt2gDZqv8bi+zHjSzEXatgTNIukHLvN/24FHaQwCfsNOZ/LV3XM9AZJS
         fpd0G/8CoBIhe4io2dyWfRqpeJ8crpr1PxpkvCib9eR8Mk6DTysLBtnuBp4ZVDWh1769
         kRIDI3+J1uv5fn7IwE7FD+bKPeHhiYeiOCcUz40M5Wch+ycJvMs9OjDlxnPGavEXhlVd
         H/Hw==
X-Forwarded-Encrypted: i=1; AJvYcCUX+P7IaqRtlrp8Iu2NGFq3Pjufoab/3Eq2R/N1NTQSD5btEMriLObwvRNE0eVTbLT8Vrp69pwVuA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzGBJ45Dd5/R3W6EdLs6v3JLF96weDSM1E9n+tc0YjTHDkGADA9
	ZMhjU5+181L5SA7vzk+AWtrh9nWdwfOAa2bHXl8PTFUO22/nhDUF9btyw5TktdgdQZL1ZiNsIKU
	moo+LHs1rX2ssOyC+xMbak42iQxHKaXZgZrhMo/OaragEDjQJWollJbf26IUDZg==
X-Gm-Gg: ASbGncsYEItFgTDUhVHi1zQPJdzVjnle8J4B6vezscWlv9VNkaquS1Bhz4xbwhqPnES
	lSRw51haEvqrd4Cql6onShXeculHO1nmfRaaQ/Xo1z0j4yXqaHo0F6648yWAjy/BTuRDC/ZqnHr
	L3ZB8RFT7ielbacPZP5KJmKPcsTQqesB8e4gHzmu7bd2oposg73OSIvPnY23B3/jRkp1KSXeF8S
	6kVHFA10OTm7wOf8e71jtA23rCRHarXlhpHcCLGM3hGQjPbPSebysflXk6GKq6WribLW0pXOZ31
	pFvPDSvQ6FZSxBy/cqq5AqWIlRraVlVcMghPdt5rw3uFBd0lQWvp79arlHASbC6FHi6/kZdZ35l
	pJTlyC6AOC6hVaRTH8BdBhpU+7Js2J+o45lV589AMnMKM06W787k/1xoKHqdqwjMx0dsViEnJxH
	awEyW2QJMtkl/X
X-Received: by 2002:a05:622a:cf:b0:4eb:b291:36e5 with SMTP id d75a77b69052e-4ed218d97c2mr79611471cf.41.1761921937863;
        Fri, 31 Oct 2025 07:45:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEuOLh4dXXbqUR7R6yZf5/7d0x9npGiKBRhzo5cIwqjKYJXvgvKTGi2FoJ3G/F4b50FNU9IeA==
X-Received: by 2002:a05:622a:cf:b0:4eb:b291:36e5 with SMTP id d75a77b69052e-4ed218d97c2mr79610621cf.41.1761921936980;
        Fri, 31 Oct 2025 07:45:36 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5941f5bc218sm541405e87.93.2025.10.31.07.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 07:45:36 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 31 Oct 2025 16:45:21 +0200
Subject: [PATCH v3 05/25] interconnect: qcom: sdm845: convert to dynamic
 IDs
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-rework-icc-v3-5-0575304c9624@oss.qualcomm.com>
References: <20251031-rework-icc-v3-0-0575304c9624@oss.qualcomm.com>
In-Reply-To: <20251031-rework-icc-v3-0-0575304c9624@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=49685;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=7ulmETyiGU2WsCwZzdCVtDREtRVaD9uxvCocrUO+WBg=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQybL6SYhZcPp2Tf5jlod5UrbYlF7/KGg92K5roX34878V
 jC72nG3k9GYhYGRi0FWTJHFp6Blasym5LAPO6bWwwxiZQKZwsDFKQATSe5i/5/lHFRhfYjDvv/j
 mpl5PhWMpbP4vpnZ5mWaN+9ilbXKPhmf0jjL2GeTrcu2tl+rdnEnhHyPPfyw7NbP/DcLpnRMcvp
 t6vqI0fhYjEME+72t0SfDZ//yZdgpnPYtY0/6sj6r4h/si70sL2d3Xy6TW7vt0RkJz93O9dMceu
 wf93l68IlZ18WmfOvfxjD59qMzEycs3nVp4dStjirq1SUJzsJRheJaR+YatniuSFUQl05Onv453
 stxtyGzzawGIZbsLfVCt5Ne7glLunU5cdleUe5LHvxTLv7o9gswzvTpTtkdxTbdWmxLgdXPe7uk
 FinfuX/sbnCF4OezfVv5IovfRoc+XSXk++TgZoEG+y57AA==
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDEzMyBTYWx0ZWRfX1a6y1E2GJTll
 1RNbKki9HKL3JxtH3RVjTxuu3P5U9akoEx7P0bbScx7Kb2t9fLQTNWsIhO+/REbl9HWkenlDAVU
 I4pryERc0SPB2J2GBb3mRdCjz5fd+L1gJcZ6F3d42dci3rFcKa+cJwjOGE5ksisjHzsP5pR6qar
 xm+x38rZjS4sfOXKjIr9OtpH7TXAxLjULj24xI3EFZ8W8GCga7ywdm6BAL0/tEVauGTd7uYWiV+
 PurO03eCFXG4TlPk/xjIGoI2pzc0dpapxBSfPQHIKrXg97/eXp4726iZOzglF2hpTLqcEoTXFoH
 9Krej+ltk8S1nTjXVsRO3nhK0/I/+ySFoSIzxLigrLk9L+bddvYETuB0yTYJ2WeLDjxx1Op6sS3
 5rhoTA5bni3YZTHtlm4xJ5ty7YkUug==
X-Authority-Analysis: v=2.4 cv=Q8PfIo2a c=1 sm=1 tr=0 ts=6904cb93 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=S9h32VVGmDw0GlSDRGAA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-ORIG-GUID: p5CYF4CqgwpQuW1VrmkFrdJdtPU7HYrr
X-Proofpoint-GUID: p5CYF4CqgwpQuW1VrmkFrdJdtPU7HYrr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_04,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 adultscore=0 malwarescore=0 suspectscore=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510310133

Stop using fixed and IDs and covert the platform to use dynamic IDs for
the interconnect. This gives more flexibility and also allows us to drop
the .num_links member, saving from possible errors related to it being
not set or set incorrectly.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/interconnect/qcom/sdm845.c | 774 ++++++++++++++++++-------------------
 drivers/interconnect/qcom/sdm845.h | 140 -------
 2 files changed, 381 insertions(+), 533 deletions(-)

diff --git a/drivers/interconnect/qcom/sdm845.c b/drivers/interconnect/qcom/sdm845.c
index 855802be93fea1d999bc8a885f36c3c318e1d86d..83d7a611cdf72d4b1cc17f86455106574a13cc9b 100644
--- a/drivers/interconnect/qcom/sdm845.c
+++ b/drivers/interconnect/qcom/sdm845.c
@@ -14,1251 +14,1231 @@
 
 #include "bcm-voter.h"
 #include "icc-rpmh.h"
-#include "sdm845.h"
+
+static struct qcom_icc_node qhm_a1noc_cfg;
+static struct qcom_icc_node qhm_qup1;
+static struct qcom_icc_node qhm_tsif;
+static struct qcom_icc_node xm_sdc2;
+static struct qcom_icc_node xm_sdc4;
+static struct qcom_icc_node xm_ufs_card;
+static struct qcom_icc_node xm_ufs_mem;
+static struct qcom_icc_node xm_pcie_0;
+static struct qcom_icc_node qhm_a2noc_cfg;
+static struct qcom_icc_node qhm_qdss_bam;
+static struct qcom_icc_node qhm_qup2;
+static struct qcom_icc_node qnm_cnoc;
+static struct qcom_icc_node qxm_crypto;
+static struct qcom_icc_node qxm_ipa;
+static struct qcom_icc_node xm_pcie3_1;
+static struct qcom_icc_node xm_qdss_etr;
+static struct qcom_icc_node xm_usb3_0;
+static struct qcom_icc_node xm_usb3_1;
+static struct qcom_icc_node qxm_camnoc_hf0_uncomp;
+static struct qcom_icc_node qxm_camnoc_hf1_uncomp;
+static struct qcom_icc_node qxm_camnoc_sf_uncomp;
+static struct qcom_icc_node qhm_spdm;
+static struct qcom_icc_node qhm_tic;
+static struct qcom_icc_node qnm_snoc;
+static struct qcom_icc_node xm_qdss_dap;
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
+static struct qcom_icc_node qnm_pcie_anoc;
+static struct qcom_icc_node qxm_pimem;
+static struct qcom_icc_node xm_gic;
+static struct qcom_icc_node qns_a1noc_snoc;
+static struct qcom_icc_node srvc_aggre1_noc;
+static struct qcom_icc_node qns_pcie_a1noc_snoc;
+static struct qcom_icc_node qns_a2noc_snoc;
+static struct qcom_icc_node qns_pcie_snoc;
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
+static struct qcom_icc_node qhs_glm;
+static struct qcom_icc_node qhs_gpuss_cfg;
+static struct qcom_icc_node qhs_imem_cfg;
+static struct qcom_icc_node qhs_ipa;
+static struct qcom_icc_node qhs_mnoc_cfg;
+static struct qcom_icc_node qhs_pcie0_cfg;
+static struct qcom_icc_node qhs_pcie_gen3_cfg;
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
+static struct qcom_icc_node qhs_spss_cfg;
+static struct qcom_icc_node qhs_tcsr;
+static struct qcom_icc_node qhs_tlmm_north;
+static struct qcom_icc_node qhs_tlmm_south;
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
+static struct qcom_icc_node qxs_pcie;
+static struct qcom_icc_node qxs_pcie_gen3;
+static struct qcom_icc_node qxs_pimem;
+static struct qcom_icc_node srvc_snoc;
+static struct qcom_icc_node xs_qdss_stm;
+static struct qcom_icc_node xs_sys_tcu_cfg;
 
 static struct qcom_icc_node qhm_a1noc_cfg = {
 	.name = "qhm_a1noc_cfg",
-	.id = SDM845_MASTER_A1NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SDM845_SLAVE_SERVICE_A1NOC },
+	.link_nodes = { &srvc_aggre1_noc },
 };
 
 static struct qcom_icc_node qhm_qup1 = {
 	.name = "qhm_qup1",
-	.id = SDM845_MASTER_BLSP_1,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SDM845_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc },
 };
 
 static struct qcom_icc_node qhm_tsif = {
 	.name = "qhm_tsif",
-	.id = SDM845_MASTER_TSIF,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SDM845_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc },
 };
 
 static struct qcom_icc_node xm_sdc2 = {
 	.name = "xm_sdc2",
-	.id = SDM845_MASTER_SDCC_2,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SDM845_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc },
 };
 
 static struct qcom_icc_node xm_sdc4 = {
 	.name = "xm_sdc4",
-	.id = SDM845_MASTER_SDCC_4,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SDM845_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc },
 };
 
 static struct qcom_icc_node xm_ufs_card = {
 	.name = "xm_ufs_card",
-	.id = SDM845_MASTER_UFS_CARD,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SDM845_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc },
 };
 
 static struct qcom_icc_node xm_ufs_mem = {
 	.name = "xm_ufs_mem",
-	.id = SDM845_MASTER_UFS_MEM,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SDM845_SLAVE_A1NOC_SNOC },
+	.link_nodes = { &qns_a1noc_snoc },
 };
 
 static struct qcom_icc_node xm_pcie_0 = {
 	.name = "xm_pcie_0",
-	.id = SDM845_MASTER_PCIE_0,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SDM845_SLAVE_ANOC_PCIE_A1NOC_SNOC },
+	.link_nodes = { &qns_pcie_a1noc_snoc },
 };
 
 static struct qcom_icc_node qhm_a2noc_cfg = {
 	.name = "qhm_a2noc_cfg",
-	.id = SDM845_MASTER_A2NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SDM845_SLAVE_SERVICE_A2NOC },
+	.link_nodes = { &srvc_aggre2_noc },
 };
 
 static struct qcom_icc_node qhm_qdss_bam = {
 	.name = "qhm_qdss_bam",
-	.id = SDM845_MASTER_QDSS_BAM,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SDM845_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc },
 };
 
 static struct qcom_icc_node qhm_qup2 = {
 	.name = "qhm_qup2",
-	.id = SDM845_MASTER_BLSP_2,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SDM845_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc },
 };
 
 static struct qcom_icc_node qnm_cnoc = {
 	.name = "qnm_cnoc",
-	.id = SDM845_MASTER_CNOC_A2NOC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SDM845_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc },
 };
 
 static struct qcom_icc_node qxm_crypto = {
 	.name = "qxm_crypto",
-	.id = SDM845_MASTER_CRYPTO,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SDM845_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc },
 };
 
 static struct qcom_icc_node qxm_ipa = {
 	.name = "qxm_ipa",
-	.id = SDM845_MASTER_IPA,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SDM845_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc },
 };
 
 static struct qcom_icc_node xm_pcie3_1 = {
 	.name = "xm_pcie3_1",
-	.id = SDM845_MASTER_PCIE_1,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SDM845_SLAVE_ANOC_PCIE_SNOC },
+	.link_nodes = { &qns_pcie_snoc },
 };
 
 static struct qcom_icc_node xm_qdss_etr = {
 	.name = "xm_qdss_etr",
-	.id = SDM845_MASTER_QDSS_ETR,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SDM845_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc },
 };
 
 static struct qcom_icc_node xm_usb3_0 = {
 	.name = "xm_usb3_0",
-	.id = SDM845_MASTER_USB3_0,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SDM845_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc },
 };
 
 static struct qcom_icc_node xm_usb3_1 = {
 	.name = "xm_usb3_1",
-	.id = SDM845_MASTER_USB3_1,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SDM845_SLAVE_A2NOC_SNOC },
+	.link_nodes = { &qns_a2noc_snoc },
 };
 
 static struct qcom_icc_node qxm_camnoc_hf0_uncomp = {
 	.name = "qxm_camnoc_hf0_uncomp",
-	.id = SDM845_MASTER_CAMNOC_HF0_UNCOMP,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SDM845_SLAVE_CAMNOC_UNCOMP },
+	.link_nodes = { &qns_camnoc_uncomp },
 };
 
 static struct qcom_icc_node qxm_camnoc_hf1_uncomp = {
 	.name = "qxm_camnoc_hf1_uncomp",
-	.id = SDM845_MASTER_CAMNOC_HF1_UNCOMP,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SDM845_SLAVE_CAMNOC_UNCOMP },
+	.link_nodes = { &qns_camnoc_uncomp },
 };
 
 static struct qcom_icc_node qxm_camnoc_sf_uncomp = {
 	.name = "qxm_camnoc_sf_uncomp",
-	.id = SDM845_MASTER_CAMNOC_SF_UNCOMP,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SDM845_SLAVE_CAMNOC_UNCOMP },
+	.link_nodes = { &qns_camnoc_uncomp },
 };
 
 static struct qcom_icc_node qhm_spdm = {
 	.name = "qhm_spdm",
-	.id = SDM845_MASTER_SPDM,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SDM845_SLAVE_CNOC_A2NOC },
+	.link_nodes = { &qns_cnoc_a2noc },
 };
 
 static struct qcom_icc_node qhm_tic = {
 	.name = "qhm_tic",
-	.id = SDM845_MASTER_TIC,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 43,
-	.links = { SDM845_SLAVE_A1NOC_CFG,
-		   SDM845_SLAVE_A2NOC_CFG,
-		   SDM845_SLAVE_AOP,
-		   SDM845_SLAVE_AOSS,
-		   SDM845_SLAVE_CAMERA_CFG,
-		   SDM845_SLAVE_CLK_CTL,
-		   SDM845_SLAVE_CDSP_CFG,
-		   SDM845_SLAVE_RBCPR_CX_CFG,
-		   SDM845_SLAVE_CRYPTO_0_CFG,
-		   SDM845_SLAVE_DCC_CFG,
-		   SDM845_SLAVE_CNOC_DDRSS,
-		   SDM845_SLAVE_DISPLAY_CFG,
-		   SDM845_SLAVE_GLM,
-		   SDM845_SLAVE_GFX3D_CFG,
-		   SDM845_SLAVE_IMEM_CFG,
-		   SDM845_SLAVE_IPA_CFG,
-		   SDM845_SLAVE_CNOC_MNOC_CFG,
-		   SDM845_SLAVE_PCIE_0_CFG,
-		   SDM845_SLAVE_PCIE_1_CFG,
-		   SDM845_SLAVE_PDM,
-		   SDM845_SLAVE_SOUTH_PHY_CFG,
-		   SDM845_SLAVE_PIMEM_CFG,
-		   SDM845_SLAVE_PRNG,
-		   SDM845_SLAVE_QDSS_CFG,
-		   SDM845_SLAVE_BLSP_2,
-		   SDM845_SLAVE_BLSP_1,
-		   SDM845_SLAVE_SDCC_2,
-		   SDM845_SLAVE_SDCC_4,
-		   SDM845_SLAVE_SNOC_CFG,
-		   SDM845_SLAVE_SPDM_WRAPPER,
-		   SDM845_SLAVE_SPSS_CFG,
-		   SDM845_SLAVE_TCSR,
-		   SDM845_SLAVE_TLMM_NORTH,
-		   SDM845_SLAVE_TLMM_SOUTH,
-		   SDM845_SLAVE_TSIF,
-		   SDM845_SLAVE_UFS_CARD_CFG,
-		   SDM845_SLAVE_UFS_MEM_CFG,
-		   SDM845_SLAVE_USB3_0,
-		   SDM845_SLAVE_USB3_1,
-		   SDM845_SLAVE_VENUS_CFG,
-		   SDM845_SLAVE_VSENSE_CTRL_CFG,
-		   SDM845_SLAVE_CNOC_A2NOC,
-		   SDM845_SLAVE_SERVICE_CNOC
-	},
+	.link_nodes = { &qhs_a1_noc_cfg,
+			&qhs_a2_noc_cfg,
+			&qhs_aop,
+			&qhs_aoss,
+			&qhs_camera_cfg,
+			&qhs_clk_ctl,
+			&qhs_compute_dsp_cfg,
+			&qhs_cpr_cx,
+			&qhs_crypto0_cfg,
+			&qhs_dcc_cfg,
+			&qhs_ddrss_cfg,
+			&qhs_display_cfg,
+			&qhs_glm,
+			&qhs_gpuss_cfg,
+			&qhs_imem_cfg,
+			&qhs_ipa,
+			&qhs_mnoc_cfg,
+			&qhs_pcie0_cfg,
+			&qhs_pcie_gen3_cfg,
+			&qhs_pdm,
+			&qhs_phy_refgen_south,
+			&qhs_pimem_cfg,
+			&qhs_prng,
+			&qhs_qdss_cfg,
+			&qhs_qupv3_north,
+			&qhs_qupv3_south,
+			&qhs_sdc2,
+			&qhs_sdc4,
+			&qhs_snoc_cfg,
+			&qhs_spdm,
+			&qhs_spss_cfg,
+			&qhs_tcsr,
+			&qhs_tlmm_north,
+			&qhs_tlmm_south,
+			&qhs_tsif,
+			&qhs_ufs_card_cfg,
+			&qhs_ufs_mem_cfg,
+			&qhs_usb3_0,
+			&qhs_usb3_1,
+			&qhs_venus_cfg,
+			&qhs_vsense_ctrl_cfg,
+			&qns_cnoc_a2noc,
+			&srvc_cnoc },
 };
 
 static struct qcom_icc_node qnm_snoc = {
 	.name = "qnm_snoc",
-	.id = SDM845_MASTER_SNOC_CNOC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 42,
-	.links = { SDM845_SLAVE_A1NOC_CFG,
-		   SDM845_SLAVE_A2NOC_CFG,
-		   SDM845_SLAVE_AOP,
-		   SDM845_SLAVE_AOSS,
-		   SDM845_SLAVE_CAMERA_CFG,
-		   SDM845_SLAVE_CLK_CTL,
-		   SDM845_SLAVE_CDSP_CFG,
-		   SDM845_SLAVE_RBCPR_CX_CFG,
-		   SDM845_SLAVE_CRYPTO_0_CFG,
-		   SDM845_SLAVE_DCC_CFG,
-		   SDM845_SLAVE_CNOC_DDRSS,
-		   SDM845_SLAVE_DISPLAY_CFG,
-		   SDM845_SLAVE_GLM,
-		   SDM845_SLAVE_GFX3D_CFG,
-		   SDM845_SLAVE_IMEM_CFG,
-		   SDM845_SLAVE_IPA_CFG,
-		   SDM845_SLAVE_CNOC_MNOC_CFG,
-		   SDM845_SLAVE_PCIE_0_CFG,
-		   SDM845_SLAVE_PCIE_1_CFG,
-		   SDM845_SLAVE_PDM,
-		   SDM845_SLAVE_SOUTH_PHY_CFG,
-		   SDM845_SLAVE_PIMEM_CFG,
-		   SDM845_SLAVE_PRNG,
-		   SDM845_SLAVE_QDSS_CFG,
-		   SDM845_SLAVE_BLSP_2,
-		   SDM845_SLAVE_BLSP_1,
-		   SDM845_SLAVE_SDCC_2,
-		   SDM845_SLAVE_SDCC_4,
-		   SDM845_SLAVE_SNOC_CFG,
-		   SDM845_SLAVE_SPDM_WRAPPER,
-		   SDM845_SLAVE_SPSS_CFG,
-		   SDM845_SLAVE_TCSR,
-		   SDM845_SLAVE_TLMM_NORTH,
-		   SDM845_SLAVE_TLMM_SOUTH,
-		   SDM845_SLAVE_TSIF,
-		   SDM845_SLAVE_UFS_CARD_CFG,
-		   SDM845_SLAVE_UFS_MEM_CFG,
-		   SDM845_SLAVE_USB3_0,
-		   SDM845_SLAVE_USB3_1,
-		   SDM845_SLAVE_VENUS_CFG,
-		   SDM845_SLAVE_VSENSE_CTRL_CFG,
-		   SDM845_SLAVE_SERVICE_CNOC
-	},
+	.link_nodes = { &qhs_a1_noc_cfg,
+			&qhs_a2_noc_cfg,
+			&qhs_aop,
+			&qhs_aoss,
+			&qhs_camera_cfg,
+			&qhs_clk_ctl,
+			&qhs_compute_dsp_cfg,
+			&qhs_cpr_cx,
+			&qhs_crypto0_cfg,
+			&qhs_dcc_cfg,
+			&qhs_ddrss_cfg,
+			&qhs_display_cfg,
+			&qhs_glm,
+			&qhs_gpuss_cfg,
+			&qhs_imem_cfg,
+			&qhs_ipa,
+			&qhs_mnoc_cfg,
+			&qhs_pcie0_cfg,
+			&qhs_pcie_gen3_cfg,
+			&qhs_pdm,
+			&qhs_phy_refgen_south,
+			&qhs_pimem_cfg,
+			&qhs_prng,
+			&qhs_qdss_cfg,
+			&qhs_qupv3_north,
+			&qhs_qupv3_south,
+			&qhs_sdc2,
+			&qhs_sdc4,
+			&qhs_snoc_cfg,
+			&qhs_spdm,
+			&qhs_spss_cfg,
+			&qhs_tcsr,
+			&qhs_tlmm_north,
+			&qhs_tlmm_south,
+			&qhs_tsif,
+			&qhs_ufs_card_cfg,
+			&qhs_ufs_mem_cfg,
+			&qhs_usb3_0,
+			&qhs_usb3_1,
+			&qhs_venus_cfg,
+			&qhs_vsense_ctrl_cfg,
+			&srvc_cnoc },
 };
 
 static struct qcom_icc_node xm_qdss_dap = {
 	.name = "xm_qdss_dap",
-	.id = SDM845_MASTER_QDSS_DAP,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 43,
-	.links = { SDM845_SLAVE_A1NOC_CFG,
-		   SDM845_SLAVE_A2NOC_CFG,
-		   SDM845_SLAVE_AOP,
-		   SDM845_SLAVE_AOSS,
-		   SDM845_SLAVE_CAMERA_CFG,
-		   SDM845_SLAVE_CLK_CTL,
-		   SDM845_SLAVE_CDSP_CFG,
-		   SDM845_SLAVE_RBCPR_CX_CFG,
-		   SDM845_SLAVE_CRYPTO_0_CFG,
-		   SDM845_SLAVE_DCC_CFG,
-		   SDM845_SLAVE_CNOC_DDRSS,
-		   SDM845_SLAVE_DISPLAY_CFG,
-		   SDM845_SLAVE_GLM,
-		   SDM845_SLAVE_GFX3D_CFG,
-		   SDM845_SLAVE_IMEM_CFG,
-		   SDM845_SLAVE_IPA_CFG,
-		   SDM845_SLAVE_CNOC_MNOC_CFG,
-		   SDM845_SLAVE_PCIE_0_CFG,
-		   SDM845_SLAVE_PCIE_1_CFG,
-		   SDM845_SLAVE_PDM,
-		   SDM845_SLAVE_SOUTH_PHY_CFG,
-		   SDM845_SLAVE_PIMEM_CFG,
-		   SDM845_SLAVE_PRNG,
-		   SDM845_SLAVE_QDSS_CFG,
-		   SDM845_SLAVE_BLSP_2,
-		   SDM845_SLAVE_BLSP_1,
-		   SDM845_SLAVE_SDCC_2,
-		   SDM845_SLAVE_SDCC_4,
-		   SDM845_SLAVE_SNOC_CFG,
-		   SDM845_SLAVE_SPDM_WRAPPER,
-		   SDM845_SLAVE_SPSS_CFG,
-		   SDM845_SLAVE_TCSR,
-		   SDM845_SLAVE_TLMM_NORTH,
-		   SDM845_SLAVE_TLMM_SOUTH,
-		   SDM845_SLAVE_TSIF,
-		   SDM845_SLAVE_UFS_CARD_CFG,
-		   SDM845_SLAVE_UFS_MEM_CFG,
-		   SDM845_SLAVE_USB3_0,
-		   SDM845_SLAVE_USB3_1,
-		   SDM845_SLAVE_VENUS_CFG,
-		   SDM845_SLAVE_VSENSE_CTRL_CFG,
-		   SDM845_SLAVE_CNOC_A2NOC,
-		   SDM845_SLAVE_SERVICE_CNOC
-	},
+	.link_nodes = { &qhs_a1_noc_cfg,
+			&qhs_a2_noc_cfg,
+			&qhs_aop,
+			&qhs_aoss,
+			&qhs_camera_cfg,
+			&qhs_clk_ctl,
+			&qhs_compute_dsp_cfg,
+			&qhs_cpr_cx,
+			&qhs_crypto0_cfg,
+			&qhs_dcc_cfg,
+			&qhs_ddrss_cfg,
+			&qhs_display_cfg,
+			&qhs_glm,
+			&qhs_gpuss_cfg,
+			&qhs_imem_cfg,
+			&qhs_ipa,
+			&qhs_mnoc_cfg,
+			&qhs_pcie0_cfg,
+			&qhs_pcie_gen3_cfg,
+			&qhs_pdm,
+			&qhs_phy_refgen_south,
+			&qhs_pimem_cfg,
+			&qhs_prng,
+			&qhs_qdss_cfg,
+			&qhs_qupv3_north,
+			&qhs_qupv3_south,
+			&qhs_sdc2,
+			&qhs_sdc4,
+			&qhs_snoc_cfg,
+			&qhs_spdm,
+			&qhs_spss_cfg,
+			&qhs_tcsr,
+			&qhs_tlmm_north,
+			&qhs_tlmm_south,
+			&qhs_tsif,
+			&qhs_ufs_card_cfg,
+			&qhs_ufs_mem_cfg,
+			&qhs_usb3_0,
+			&qhs_usb3_1,
+			&qhs_venus_cfg,
+			&qhs_vsense_ctrl_cfg,
+			&qns_cnoc_a2noc,
+			&srvc_cnoc },
 };
 
 static struct qcom_icc_node qhm_cnoc = {
 	.name = "qhm_cnoc",
-	.id = SDM845_MASTER_CNOC_DC_NOC,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 2,
-	.links = { SDM845_SLAVE_LLCC_CFG,
-		   SDM845_SLAVE_MEM_NOC_CFG
-	},
+	.link_nodes = { &qhs_llcc,
+			&qhs_memnoc },
 };
 
 static struct qcom_icc_node acm_l3 = {
 	.name = "acm_l3",
-	.id = SDM845_MASTER_APPSS_PROC,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 3,
-	.links = { SDM845_SLAVE_GNOC_SNOC,
-		   SDM845_SLAVE_GNOC_MEM_NOC,
-		   SDM845_SLAVE_SERVICE_GNOC
-	},
+	.link_nodes = { &qns_gladiator_sodv,
+			&qns_gnoc_memnoc,
+			&srvc_gnoc },
 };
 
 static struct qcom_icc_node pm_gnoc_cfg = {
 	.name = "pm_gnoc_cfg",
-	.id = SDM845_MASTER_GNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SDM845_SLAVE_SERVICE_GNOC },
+	.link_nodes = { &srvc_gnoc },
 };
 
 static struct qcom_icc_node llcc_mc = {
 	.name = "llcc_mc",
-	.id = SDM845_MASTER_LLCC,
 	.channels = 4,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SDM845_SLAVE_EBI1 },
+	.link_nodes = { &ebi },
 };
 
 static struct qcom_icc_node acm_tcu = {
 	.name = "acm_tcu",
-	.id = SDM845_MASTER_TCU_0,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 3,
-	.links = { SDM845_SLAVE_MEM_NOC_GNOC,
-		   SDM845_SLAVE_LLCC,
-		   SDM845_SLAVE_MEM_NOC_SNOC
-	},
+	.link_nodes = { &qns_apps_io,
+			&qns_llcc,
+			&qns_memnoc_snoc },
 };
 
 static struct qcom_icc_node qhm_memnoc_cfg = {
 	.name = "qhm_memnoc_cfg",
-	.id = SDM845_MASTER_MEM_NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 2,
-	.links = { SDM845_SLAVE_MSS_PROC_MS_MPU_CFG,
-		   SDM845_SLAVE_SERVICE_MEM_NOC
-	},
+	.link_nodes = { &qhs_mdsp_ms_mpu_cfg,
+			&srvc_memnoc },
 };
 
 static struct qcom_icc_node qnm_apps = {
 	.name = "qnm_apps",
-	.id = SDM845_MASTER_GNOC_MEM_NOC,
 	.channels = 2,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SDM845_SLAVE_LLCC },
+	.link_nodes = { &qns_llcc },
 };
 
 static struct qcom_icc_node qnm_mnoc_hf = {
 	.name = "qnm_mnoc_hf",
-	.id = SDM845_MASTER_MNOC_HF_MEM_NOC,
 	.channels = 2,
 	.buswidth = 32,
 	.num_links = 2,
-	.links = { SDM845_SLAVE_MEM_NOC_GNOC,
-		   SDM845_SLAVE_LLCC
-	},
+	.link_nodes = { &qns_apps_io,
+			&qns_llcc },
 };
 
 static struct qcom_icc_node qnm_mnoc_sf = {
 	.name = "qnm_mnoc_sf",
-	.id = SDM845_MASTER_MNOC_SF_MEM_NOC,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 3,
-	.links = { SDM845_SLAVE_MEM_NOC_GNOC,
-		   SDM845_SLAVE_LLCC,
-		   SDM845_SLAVE_MEM_NOC_SNOC
-	},
+	.link_nodes = { &qns_apps_io,
+			&qns_llcc,
+			&qns_memnoc_snoc },
 };
 
 static struct qcom_icc_node qnm_snoc_gc = {
 	.name = "qnm_snoc_gc",
-	.id = SDM845_MASTER_SNOC_GC_MEM_NOC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SDM845_SLAVE_LLCC },
+	.link_nodes = { &qns_llcc },
 };
 
 static struct qcom_icc_node qnm_snoc_sf = {
 	.name = "qnm_snoc_sf",
-	.id = SDM845_MASTER_SNOC_SF_MEM_NOC,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 2,
-	.links = { SDM845_SLAVE_MEM_NOC_GNOC,
-		   SDM845_SLAVE_LLCC
-	},
+	.link_nodes = { &qns_apps_io,
+			&qns_llcc },
 };
 
 static struct qcom_icc_node qxm_gpu = {
 	.name = "qxm_gpu",
-	.id = SDM845_MASTER_GFX3D,
 	.channels = 2,
 	.buswidth = 32,
 	.num_links = 3,
-	.links = { SDM845_SLAVE_MEM_NOC_GNOC,
-		   SDM845_SLAVE_LLCC,
-		   SDM845_SLAVE_MEM_NOC_SNOC
-	},
+	.link_nodes = { &qns_apps_io,
+			&qns_llcc,
+			&qns_memnoc_snoc },
 };
 
 static struct qcom_icc_node qhm_mnoc_cfg = {
 	.name = "qhm_mnoc_cfg",
-	.id = SDM845_MASTER_CNOC_MNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SDM845_SLAVE_SERVICE_MNOC },
+	.link_nodes = { &srvc_mnoc },
 };
 
 static struct qcom_icc_node qxm_camnoc_hf0 = {
 	.name = "qxm_camnoc_hf0",
-	.id = SDM845_MASTER_CAMNOC_HF0,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SDM845_SLAVE_MNOC_HF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_hf },
 };
 
 static struct qcom_icc_node qxm_camnoc_hf1 = {
 	.name = "qxm_camnoc_hf1",
-	.id = SDM845_MASTER_CAMNOC_HF1,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SDM845_SLAVE_MNOC_HF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_hf },
 };
 
 static struct qcom_icc_node qxm_camnoc_sf = {
 	.name = "qxm_camnoc_sf",
-	.id = SDM845_MASTER_CAMNOC_SF,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SDM845_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns2_mem_noc },
 };
 
 static struct qcom_icc_node qxm_mdp0 = {
 	.name = "qxm_mdp0",
-	.id = SDM845_MASTER_MDP0,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SDM845_SLAVE_MNOC_HF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_hf },
 };
 
 static struct qcom_icc_node qxm_mdp1 = {
 	.name = "qxm_mdp1",
-	.id = SDM845_MASTER_MDP1,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SDM845_SLAVE_MNOC_HF_MEM_NOC },
+	.link_nodes = { &qns_mem_noc_hf },
 };
 
 static struct qcom_icc_node qxm_rot = {
 	.name = "qxm_rot",
-	.id = SDM845_MASTER_ROTATOR,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SDM845_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns2_mem_noc },
 };
 
 static struct qcom_icc_node qxm_venus0 = {
 	.name = "qxm_venus0",
-	.id = SDM845_MASTER_VIDEO_P0,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SDM845_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns2_mem_noc },
 };
 
 static struct qcom_icc_node qxm_venus1 = {
 	.name = "qxm_venus1",
-	.id = SDM845_MASTER_VIDEO_P1,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SDM845_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns2_mem_noc },
 };
 
 static struct qcom_icc_node qxm_venus_arm9 = {
 	.name = "qxm_venus_arm9",
-	.id = SDM845_MASTER_VIDEO_PROC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SDM845_SLAVE_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qns2_mem_noc },
 };
 
 static struct qcom_icc_node qhm_snoc_cfg = {
 	.name = "qhm_snoc_cfg",
-	.id = SDM845_MASTER_SNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SDM845_SLAVE_SERVICE_SNOC },
+	.link_nodes = { &srvc_snoc },
 };
 
 static struct qcom_icc_node qnm_aggre1_noc = {
 	.name = "qnm_aggre1_noc",
-	.id = SDM845_MASTER_A1NOC_SNOC,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 6,
-	.links = { SDM845_SLAVE_APPSS,
-		   SDM845_SLAVE_SNOC_CNOC,
-		   SDM845_SLAVE_SNOC_MEM_NOC_SF,
-		   SDM845_SLAVE_IMEM,
-		   SDM845_SLAVE_PIMEM,
-		   SDM845_SLAVE_QDSS_STM
-	},
+	.link_nodes = { &qhs_apss,
+			&qns_cnoc,
+			&qns_memnoc_sf,
+			&qxs_imem,
+			&qxs_pimem,
+			&xs_qdss_stm },
 };
 
 static struct qcom_icc_node qnm_aggre2_noc = {
 	.name = "qnm_aggre2_noc",
-	.id = SDM845_MASTER_A2NOC_SNOC,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 9,
-	.links = { SDM845_SLAVE_APPSS,
-		   SDM845_SLAVE_SNOC_CNOC,
-		   SDM845_SLAVE_SNOC_MEM_NOC_SF,
-		   SDM845_SLAVE_IMEM,
-		   SDM845_SLAVE_PCIE_0,
-		   SDM845_SLAVE_PCIE_1,
-		   SDM845_SLAVE_PIMEM,
-		   SDM845_SLAVE_QDSS_STM,
-		   SDM845_SLAVE_TCU
-	},
+	.link_nodes = { &qhs_apss,
+			&qns_cnoc,
+			&qns_memnoc_sf,
+			&qxs_imem,
+			&qxs_pcie,
+			&qxs_pcie_gen3,
+			&qxs_pimem,
+			&xs_qdss_stm,
+			&xs_sys_tcu_cfg },
 };
 
 static struct qcom_icc_node qnm_gladiator_sodv = {
 	.name = "qnm_gladiator_sodv",
-	.id = SDM845_MASTER_GNOC_SNOC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 8,
-	.links = { SDM845_SLAVE_APPSS,
-		   SDM845_SLAVE_SNOC_CNOC,
-		   SDM845_SLAVE_IMEM,
-		   SDM845_SLAVE_PCIE_0,
-		   SDM845_SLAVE_PCIE_1,
-		   SDM845_SLAVE_PIMEM,
-		   SDM845_SLAVE_QDSS_STM,
-		   SDM845_SLAVE_TCU
-	},
+	.link_nodes = { &qhs_apss,
+			&qns_cnoc,
+			&qxs_imem,
+			&qxs_pcie,
+			&qxs_pcie_gen3,
+			&qxs_pimem,
+			&xs_qdss_stm,
+			&xs_sys_tcu_cfg },
 };
 
 static struct qcom_icc_node qnm_memnoc = {
 	.name = "qnm_memnoc",
-	.id = SDM845_MASTER_MEM_NOC_SNOC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 5,
-	.links = { SDM845_SLAVE_APPSS,
-		   SDM845_SLAVE_SNOC_CNOC,
-		   SDM845_SLAVE_IMEM,
-		   SDM845_SLAVE_PIMEM,
-		   SDM845_SLAVE_QDSS_STM
-	},
+	.link_nodes = { &qhs_apss,
+			&qns_cnoc,
+			&qxs_imem,
+			&qxs_pimem,
+			&xs_qdss_stm },
 };
 
 static struct qcom_icc_node qnm_pcie_anoc = {
 	.name = "qnm_pcie_anoc",
-	.id = SDM845_MASTER_ANOC_PCIE_SNOC,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 5,
-	.links = { SDM845_SLAVE_APPSS,
-		   SDM845_SLAVE_SNOC_CNOC,
-		   SDM845_SLAVE_SNOC_MEM_NOC_SF,
-		   SDM845_SLAVE_IMEM,
-		   SDM845_SLAVE_QDSS_STM
-	},
+	.link_nodes = { &qhs_apss,
+			&qns_cnoc,
+			&qns_memnoc_sf,
+			&qxs_imem,
+			&xs_qdss_stm },
 };
 
 static struct qcom_icc_node qxm_pimem = {
 	.name = "qxm_pimem",
-	.id = SDM845_MASTER_PIMEM,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 2,
-	.links = { SDM845_SLAVE_SNOC_MEM_NOC_GC,
-		   SDM845_SLAVE_IMEM
-	},
+	.link_nodes = { &qns_memnoc_gc,
+			&qxs_imem },
 };
 
 static struct qcom_icc_node xm_gic = {
 	.name = "xm_gic",
-	.id = SDM845_MASTER_GIC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 2,
-	.links = { SDM845_SLAVE_SNOC_MEM_NOC_GC,
-		   SDM845_SLAVE_IMEM
-	},
+	.link_nodes = { &qns_memnoc_gc,
+			&qxs_imem },
 };
 
 static struct qcom_icc_node qns_a1noc_snoc = {
 	.name = "qns_a1noc_snoc",
-	.id = SDM845_SLAVE_A1NOC_SNOC,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { SDM845_MASTER_A1NOC_SNOC },
+	.link_nodes = { &qnm_aggre1_noc },
 };
 
 static struct qcom_icc_node srvc_aggre1_noc = {
 	.name = "srvc_aggre1_noc",
-	.id = SDM845_SLAVE_SERVICE_A1NOC,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { 0 },
 };
 
 static struct qcom_icc_node qns_pcie_a1noc_snoc = {
 	.name = "qns_pcie_a1noc_snoc",
-	.id = SDM845_SLAVE_ANOC_PCIE_A1NOC_SNOC,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { SDM845_MASTER_ANOC_PCIE_SNOC },
+	.link_nodes = { &qnm_pcie_anoc },
 };
 
 static struct qcom_icc_node qns_a2noc_snoc = {
 	.name = "qns_a2noc_snoc",
-	.id = SDM845_SLAVE_A2NOC_SNOC,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { SDM845_MASTER_A2NOC_SNOC },
+	.link_nodes = { &qnm_aggre2_noc },
 };
 
 static struct qcom_icc_node qns_pcie_snoc = {
 	.name = "qns_pcie_snoc",
-	.id = SDM845_SLAVE_ANOC_PCIE_SNOC,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { SDM845_MASTER_ANOC_PCIE_SNOC },
+	.link_nodes = { &qnm_pcie_anoc },
 };
 
 static struct qcom_icc_node srvc_aggre2_noc = {
 	.name = "srvc_aggre2_noc",
-	.id = SDM845_SLAVE_SERVICE_A2NOC,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qns_camnoc_uncomp = {
 	.name = "qns_camnoc_uncomp",
-	.id = SDM845_SLAVE_CAMNOC_UNCOMP,
 	.channels = 1,
 	.buswidth = 32,
 };
 
 static struct qcom_icc_node qhs_a1_noc_cfg = {
 	.name = "qhs_a1_noc_cfg",
-	.id = SDM845_SLAVE_A1NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SDM845_MASTER_A1NOC_CFG },
+	.link_nodes = { &qhm_a1noc_cfg },
 };
 
 static struct qcom_icc_node qhs_a2_noc_cfg = {
 	.name = "qhs_a2_noc_cfg",
-	.id = SDM845_SLAVE_A2NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SDM845_MASTER_A2NOC_CFG },
+	.link_nodes = { &qhm_a2noc_cfg },
 };
 
 static struct qcom_icc_node qhs_aop = {
 	.name = "qhs_aop",
-	.id = SDM845_SLAVE_AOP,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_aoss = {
 	.name = "qhs_aoss",
-	.id = SDM845_SLAVE_AOSS,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_camera_cfg = {
 	.name = "qhs_camera_cfg",
-	.id = SDM845_SLAVE_CAMERA_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_clk_ctl = {
 	.name = "qhs_clk_ctl",
-	.id = SDM845_SLAVE_CLK_CTL,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_compute_dsp_cfg = {
 	.name = "qhs_compute_dsp_cfg",
-	.id = SDM845_SLAVE_CDSP_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_cpr_cx = {
 	.name = "qhs_cpr_cx",
-	.id = SDM845_SLAVE_RBCPR_CX_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_crypto0_cfg = {
 	.name = "qhs_crypto0_cfg",
-	.id = SDM845_SLAVE_CRYPTO_0_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_dcc_cfg = {
 	.name = "qhs_dcc_cfg",
-	.id = SDM845_SLAVE_DCC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SDM845_MASTER_CNOC_DC_NOC },
+	.link_nodes = { &qhm_cnoc },
 };
 
 static struct qcom_icc_node qhs_ddrss_cfg = {
 	.name = "qhs_ddrss_cfg",
-	.id = SDM845_SLAVE_CNOC_DDRSS,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_display_cfg = {
 	.name = "qhs_display_cfg",
-	.id = SDM845_SLAVE_DISPLAY_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_glm = {
 	.name = "qhs_glm",
-	.id = SDM845_SLAVE_GLM,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_gpuss_cfg = {
 	.name = "qhs_gpuss_cfg",
-	.id = SDM845_SLAVE_GFX3D_CFG,
 	.channels = 1,
 	.buswidth = 8,
 };
 
 static struct qcom_icc_node qhs_imem_cfg = {
 	.name = "qhs_imem_cfg",
-	.id = SDM845_SLAVE_IMEM_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_ipa = {
 	.name = "qhs_ipa",
-	.id = SDM845_SLAVE_IPA_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_mnoc_cfg = {
 	.name = "qhs_mnoc_cfg",
-	.id = SDM845_SLAVE_CNOC_MNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SDM845_MASTER_CNOC_MNOC_CFG },
+	.link_nodes = { &qhm_mnoc_cfg },
 };
 
 static struct qcom_icc_node qhs_pcie0_cfg = {
 	.name = "qhs_pcie0_cfg",
-	.id = SDM845_SLAVE_PCIE_0_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_pcie_gen3_cfg = {
 	.name = "qhs_pcie_gen3_cfg",
-	.id = SDM845_SLAVE_PCIE_1_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_pdm = {
 	.name = "qhs_pdm",
-	.id = SDM845_SLAVE_PDM,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_phy_refgen_south = {
 	.name = "qhs_phy_refgen_south",
-	.id = SDM845_SLAVE_SOUTH_PHY_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_pimem_cfg = {
 	.name = "qhs_pimem_cfg",
-	.id = SDM845_SLAVE_PIMEM_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_prng = {
 	.name = "qhs_prng",
-	.id = SDM845_SLAVE_PRNG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_qdss_cfg = {
 	.name = "qhs_qdss_cfg",
-	.id = SDM845_SLAVE_QDSS_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_qupv3_north = {
 	.name = "qhs_qupv3_north",
-	.id = SDM845_SLAVE_BLSP_2,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_qupv3_south = {
 	.name = "qhs_qupv3_south",
-	.id = SDM845_SLAVE_BLSP_1,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_sdc2 = {
 	.name = "qhs_sdc2",
-	.id = SDM845_SLAVE_SDCC_2,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_sdc4 = {
 	.name = "qhs_sdc4",
-	.id = SDM845_SLAVE_SDCC_4,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_snoc_cfg = {
 	.name = "qhs_snoc_cfg",
-	.id = SDM845_SLAVE_SNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SDM845_MASTER_SNOC_CFG },
+	.link_nodes = { &qhm_snoc_cfg },
 };
 
 static struct qcom_icc_node qhs_spdm = {
 	.name = "qhs_spdm",
-	.id = SDM845_SLAVE_SPDM_WRAPPER,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_spss_cfg = {
 	.name = "qhs_spss_cfg",
-	.id = SDM845_SLAVE_SPSS_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_tcsr = {
 	.name = "qhs_tcsr",
-	.id = SDM845_SLAVE_TCSR,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_tlmm_north = {
 	.name = "qhs_tlmm_north",
-	.id = SDM845_SLAVE_TLMM_NORTH,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_tlmm_south = {
 	.name = "qhs_tlmm_south",
-	.id = SDM845_SLAVE_TLMM_SOUTH,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_tsif = {
 	.name = "qhs_tsif",
-	.id = SDM845_SLAVE_TSIF,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_ufs_card_cfg = {
 	.name = "qhs_ufs_card_cfg",
-	.id = SDM845_SLAVE_UFS_CARD_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_ufs_mem_cfg = {
 	.name = "qhs_ufs_mem_cfg",
-	.id = SDM845_SLAVE_UFS_MEM_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_usb3_0 = {
 	.name = "qhs_usb3_0",
-	.id = SDM845_SLAVE_USB3_0,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_usb3_1 = {
 	.name = "qhs_usb3_1",
-	.id = SDM845_SLAVE_USB3_1,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_venus_cfg = {
 	.name = "qhs_venus_cfg",
-	.id = SDM845_SLAVE_VENUS_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_vsense_ctrl_cfg = {
 	.name = "qhs_vsense_ctrl_cfg",
-	.id = SDM845_SLAVE_VSENSE_CTRL_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qns_cnoc_a2noc = {
 	.name = "qns_cnoc_a2noc",
-	.id = SDM845_SLAVE_CNOC_A2NOC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SDM845_MASTER_CNOC_A2NOC },
+	.link_nodes = { &qnm_cnoc },
 };
 
 static struct qcom_icc_node srvc_cnoc = {
 	.name = "srvc_cnoc",
-	.id = SDM845_SLAVE_SERVICE_CNOC,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_llcc = {
 	.name = "qhs_llcc",
-	.id = SDM845_SLAVE_LLCC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_memnoc = {
 	.name = "qhs_memnoc",
-	.id = SDM845_SLAVE_MEM_NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SDM845_MASTER_MEM_NOC_CFG },
+	.link_nodes = { &qhm_memnoc_cfg },
 };
 
 static struct qcom_icc_node qns_gladiator_sodv = {
 	.name = "qns_gladiator_sodv",
-	.id = SDM845_SLAVE_GNOC_SNOC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SDM845_MASTER_GNOC_SNOC },
+	.link_nodes = { &qnm_gladiator_sodv },
 };
 
 static struct qcom_icc_node qns_gnoc_memnoc = {
 	.name = "qns_gnoc_memnoc",
-	.id = SDM845_SLAVE_GNOC_MEM_NOC,
 	.channels = 2,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SDM845_MASTER_GNOC_MEM_NOC },
+	.link_nodes = { &qnm_apps },
 };
 
 static struct qcom_icc_node srvc_gnoc = {
 	.name = "srvc_gnoc",
-	.id = SDM845_SLAVE_SERVICE_GNOC,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node ebi = {
 	.name = "ebi",
-	.id = SDM845_SLAVE_EBI1,
 	.channels = 4,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_mdsp_ms_mpu_cfg = {
 	.name = "qhs_mdsp_ms_mpu_cfg",
-	.id = SDM845_SLAVE_MSS_PROC_MS_MPU_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qns_apps_io = {
 	.name = "qns_apps_io",
-	.id = SDM845_SLAVE_MEM_NOC_GNOC,
 	.channels = 1,
 	.buswidth = 32,
 };
 
 static struct qcom_icc_node qns_llcc = {
 	.name = "qns_llcc",
-	.id = SDM845_SLAVE_LLCC,
 	.channels = 4,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { SDM845_MASTER_LLCC },
+	.link_nodes = { &llcc_mc },
 };
 
 static struct qcom_icc_node qns_memnoc_snoc = {
 	.name = "qns_memnoc_snoc",
-	.id = SDM845_SLAVE_MEM_NOC_SNOC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SDM845_MASTER_MEM_NOC_SNOC },
+	.link_nodes = { &qnm_memnoc },
 };
 
 static struct qcom_icc_node srvc_memnoc = {
 	.name = "srvc_memnoc",
-	.id = SDM845_SLAVE_SERVICE_MEM_NOC,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qns2_mem_noc = {
 	.name = "qns2_mem_noc",
-	.id = SDM845_SLAVE_MNOC_SF_MEM_NOC,
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SDM845_MASTER_MNOC_SF_MEM_NOC },
+	.link_nodes = { &qnm_mnoc_sf },
 };
 
 static struct qcom_icc_node qns_mem_noc_hf = {
 	.name = "qns_mem_noc_hf",
-	.id = SDM845_SLAVE_MNOC_HF_MEM_NOC,
 	.channels = 2,
 	.buswidth = 32,
 	.num_links = 1,
-	.links = { SDM845_MASTER_MNOC_HF_MEM_NOC },
+	.link_nodes = { &qnm_mnoc_hf },
 };
 
 static struct qcom_icc_node srvc_mnoc = {
 	.name = "srvc_mnoc",
-	.id = SDM845_SLAVE_SERVICE_MNOC,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_apss = {
 	.name = "qhs_apss",
-	.id = SDM845_SLAVE_APPSS,
 	.channels = 1,
 	.buswidth = 8,
 };
 
 static struct qcom_icc_node qns_cnoc = {
 	.name = "qns_cnoc",
-	.id = SDM845_SLAVE_SNOC_CNOC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SDM845_MASTER_SNOC_CNOC },
+	.link_nodes = { &qnm_snoc },
 };
 
 static struct qcom_icc_node qns_memnoc_gc = {
 	.name = "qns_memnoc_gc",
-	.id = SDM845_SLAVE_SNOC_MEM_NOC_GC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SDM845_MASTER_SNOC_GC_MEM_NOC },
+	.link_nodes = { &qnm_snoc_gc },
 };
 
 static struct qcom_icc_node qns_memnoc_sf = {
 	.name = "qns_memnoc_sf",
-	.id = SDM845_SLAVE_SNOC_MEM_NOC_SF,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { SDM845_MASTER_SNOC_SF_MEM_NOC },
+	.link_nodes = { &qnm_snoc_sf },
 };
 
 static struct qcom_icc_node qxs_imem = {
 	.name = "qxs_imem",
-	.id = SDM845_SLAVE_IMEM,
 	.channels = 1,
 	.buswidth = 8,
 };
 
 static struct qcom_icc_node qxs_pcie = {
 	.name = "qxs_pcie",
-	.id = SDM845_SLAVE_PCIE_0,
 	.channels = 1,
 	.buswidth = 8,
 };
 
 static struct qcom_icc_node qxs_pcie_gen3 = {
 	.name = "qxs_pcie_gen3",
-	.id = SDM845_SLAVE_PCIE_1,
 	.channels = 1,
 	.buswidth = 8,
 };
 
 static struct qcom_icc_node qxs_pimem = {
 	.name = "qxs_pimem",
-	.id = SDM845_SLAVE_PIMEM,
 	.channels = 1,
 	.buswidth = 8,
 };
 
 static struct qcom_icc_node srvc_snoc = {
 	.name = "srvc_snoc",
-	.id = SDM845_SLAVE_SERVICE_SNOC,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node xs_qdss_stm = {
 	.name = "xs_qdss_stm",
-	.id = SDM845_SLAVE_QDSS_STM,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node xs_sys_tcu_cfg = {
 	.name = "xs_sys_tcu_cfg",
-	.id = SDM845_SLAVE_TCU,
 	.channels = 1,
 	.buswidth = 8,
 };
@@ -1534,6 +1514,7 @@ static struct qcom_icc_node * const aggre1_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sdm845_aggre1_noc = {
+	.alloc_dyn_id = true,
 	.nodes = aggre1_noc_nodes,
 	.num_nodes = ARRAY_SIZE(aggre1_noc_nodes),
 	.bcms = aggre1_noc_bcms,
@@ -1563,6 +1544,7 @@ static struct qcom_icc_node * const aggre2_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sdm845_aggre2_noc = {
+	.alloc_dyn_id = true,
 	.nodes = aggre2_noc_nodes,
 	.num_nodes = ARRAY_SIZE(aggre2_noc_nodes),
 	.bcms = aggre2_noc_bcms,
@@ -1624,6 +1606,7 @@ static struct qcom_icc_node * const config_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sdm845_config_noc = {
+	.alloc_dyn_id = true,
 	.nodes = config_noc_nodes,
 	.num_nodes = ARRAY_SIZE(config_noc_nodes),
 	.bcms = config_noc_bcms,
@@ -1640,6 +1623,7 @@ static struct qcom_icc_node * const dc_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sdm845_dc_noc = {
+	.alloc_dyn_id = true,
 	.nodes = dc_noc_nodes,
 	.num_nodes = ARRAY_SIZE(dc_noc_nodes),
 	.bcms = dc_noc_bcms,
@@ -1658,6 +1642,7 @@ static struct qcom_icc_node * const gladiator_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sdm845_gladiator_noc = {
+	.alloc_dyn_id = true,
 	.nodes = gladiator_noc_nodes,
 	.num_nodes = ARRAY_SIZE(gladiator_noc_nodes),
 	.bcms = gladiator_noc_bcms,
@@ -1693,6 +1678,7 @@ static struct qcom_icc_node * const mem_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sdm845_mem_noc = {
+	.alloc_dyn_id = true,
 	.nodes = mem_noc_nodes,
 	.num_nodes = ARRAY_SIZE(mem_noc_nodes),
 	.bcms = mem_noc_bcms,
@@ -1727,6 +1713,7 @@ static struct qcom_icc_node * const mmss_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sdm845_mmss_noc = {
+	.alloc_dyn_id = true,
 	.nodes = mmss_noc_nodes,
 	.num_nodes = ARRAY_SIZE(mmss_noc_nodes),
 	.bcms = mmss_noc_bcms,
@@ -1773,6 +1760,7 @@ static struct qcom_icc_node * const system_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sdm845_system_noc = {
+	.alloc_dyn_id = true,
 	.nodes = system_noc_nodes,
 	.num_nodes = ARRAY_SIZE(system_noc_nodes),
 	.bcms = system_noc_bcms,
diff --git a/drivers/interconnect/qcom/sdm845.h b/drivers/interconnect/qcom/sdm845.h
deleted file mode 100644
index bc7e425ce9852288da16c49345e77f6374267365..0000000000000000000000000000000000000000
--- a/drivers/interconnect/qcom/sdm845.h
+++ /dev/null
@@ -1,140 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Copyright (c) 2020, The Linux Foundation. All rights reserved.
- */
-
-#ifndef __DRIVERS_INTERCONNECT_QCOM_SDM845_H__
-#define __DRIVERS_INTERCONNECT_QCOM_SDM845_H__
-
-#define SDM845_MASTER_A1NOC_CFG				1
-#define SDM845_MASTER_BLSP_1				2
-#define SDM845_MASTER_TSIF				3
-#define SDM845_MASTER_SDCC_2				4
-#define SDM845_MASTER_SDCC_4				5
-#define SDM845_MASTER_UFS_CARD				6
-#define SDM845_MASTER_UFS_MEM				7
-#define SDM845_MASTER_PCIE_0				8
-#define SDM845_MASTER_A2NOC_CFG				9
-#define SDM845_MASTER_QDSS_BAM				10
-#define SDM845_MASTER_BLSP_2				11
-#define SDM845_MASTER_CNOC_A2NOC			12
-#define SDM845_MASTER_CRYPTO				13
-#define SDM845_MASTER_IPA				14
-#define SDM845_MASTER_PCIE_1				15
-#define SDM845_MASTER_QDSS_ETR				16
-#define SDM845_MASTER_USB3_0				17
-#define SDM845_MASTER_USB3_1				18
-#define SDM845_MASTER_CAMNOC_HF0_UNCOMP			19
-#define SDM845_MASTER_CAMNOC_HF1_UNCOMP			20
-#define SDM845_MASTER_CAMNOC_SF_UNCOMP			21
-#define SDM845_MASTER_SPDM				22
-#define SDM845_MASTER_TIC				23
-#define SDM845_MASTER_SNOC_CNOC				24
-#define SDM845_MASTER_QDSS_DAP				25
-#define SDM845_MASTER_CNOC_DC_NOC			26
-#define SDM845_MASTER_APPSS_PROC			27
-#define SDM845_MASTER_GNOC_CFG				28
-#define SDM845_MASTER_LLCC				29
-#define SDM845_MASTER_TCU_0				30
-#define SDM845_MASTER_MEM_NOC_CFG			31
-#define SDM845_MASTER_GNOC_MEM_NOC			32
-#define SDM845_MASTER_MNOC_HF_MEM_NOC			33
-#define SDM845_MASTER_MNOC_SF_MEM_NOC			34
-#define SDM845_MASTER_SNOC_GC_MEM_NOC			35
-#define SDM845_MASTER_SNOC_SF_MEM_NOC			36
-#define SDM845_MASTER_GFX3D				37
-#define SDM845_MASTER_CNOC_MNOC_CFG			38
-#define SDM845_MASTER_CAMNOC_HF0			39
-#define SDM845_MASTER_CAMNOC_HF1			40
-#define SDM845_MASTER_CAMNOC_SF				41
-#define SDM845_MASTER_MDP0				42
-#define SDM845_MASTER_MDP1				43
-#define SDM845_MASTER_ROTATOR				44
-#define SDM845_MASTER_VIDEO_P0				45
-#define SDM845_MASTER_VIDEO_P1				46
-#define SDM845_MASTER_VIDEO_PROC			47
-#define SDM845_MASTER_SNOC_CFG				48
-#define SDM845_MASTER_A1NOC_SNOC			49
-#define SDM845_MASTER_A2NOC_SNOC			50
-#define SDM845_MASTER_GNOC_SNOC				51
-#define SDM845_MASTER_MEM_NOC_SNOC			52
-#define SDM845_MASTER_ANOC_PCIE_SNOC			53
-#define SDM845_MASTER_PIMEM				54
-#define SDM845_MASTER_GIC				55
-#define SDM845_SLAVE_A1NOC_SNOC				56
-#define SDM845_SLAVE_SERVICE_A1NOC			57
-#define SDM845_SLAVE_ANOC_PCIE_A1NOC_SNOC		58
-#define SDM845_SLAVE_A2NOC_SNOC				59
-#define SDM845_SLAVE_ANOC_PCIE_SNOC			60
-#define SDM845_SLAVE_SERVICE_A2NOC			61
-#define SDM845_SLAVE_CAMNOC_UNCOMP			62
-#define SDM845_SLAVE_A1NOC_CFG				63
-#define SDM845_SLAVE_A2NOC_CFG				64
-#define SDM845_SLAVE_AOP				65
-#define SDM845_SLAVE_AOSS				66
-#define SDM845_SLAVE_CAMERA_CFG				67
-#define SDM845_SLAVE_CLK_CTL				68
-#define SDM845_SLAVE_CDSP_CFG				69
-#define SDM845_SLAVE_RBCPR_CX_CFG			70
-#define SDM845_SLAVE_CRYPTO_0_CFG			71
-#define SDM845_SLAVE_DCC_CFG				72
-#define SDM845_SLAVE_CNOC_DDRSS				73
-#define SDM845_SLAVE_DISPLAY_CFG			74
-#define SDM845_SLAVE_GLM				75
-#define SDM845_SLAVE_GFX3D_CFG				76
-#define SDM845_SLAVE_IMEM_CFG				77
-#define SDM845_SLAVE_IPA_CFG				78
-#define SDM845_SLAVE_CNOC_MNOC_CFG			79
-#define SDM845_SLAVE_PCIE_0_CFG				80
-#define SDM845_SLAVE_PCIE_1_CFG				81
-#define SDM845_SLAVE_PDM				82
-#define SDM845_SLAVE_SOUTH_PHY_CFG			83
-#define SDM845_SLAVE_PIMEM_CFG				84
-#define SDM845_SLAVE_PRNG				85
-#define SDM845_SLAVE_QDSS_CFG				86
-#define SDM845_SLAVE_BLSP_2				87
-#define SDM845_SLAVE_BLSP_1				88
-#define SDM845_SLAVE_SDCC_2				89
-#define SDM845_SLAVE_SDCC_4				90
-#define SDM845_SLAVE_SNOC_CFG				91
-#define SDM845_SLAVE_SPDM_WRAPPER			92
-#define SDM845_SLAVE_SPSS_CFG				93
-#define SDM845_SLAVE_TCSR				94
-#define SDM845_SLAVE_TLMM_NORTH				95
-#define SDM845_SLAVE_TLMM_SOUTH				96
-#define SDM845_SLAVE_TSIF				97
-#define SDM845_SLAVE_UFS_CARD_CFG			98
-#define SDM845_SLAVE_UFS_MEM_CFG			99
-#define SDM845_SLAVE_USB3_0				100
-#define SDM845_SLAVE_USB3_1				101
-#define SDM845_SLAVE_VENUS_CFG				102
-#define SDM845_SLAVE_VSENSE_CTRL_CFG			103
-#define SDM845_SLAVE_CNOC_A2NOC				104
-#define SDM845_SLAVE_SERVICE_CNOC			105
-#define SDM845_SLAVE_LLCC_CFG				106
-#define SDM845_SLAVE_MEM_NOC_CFG			107
-#define SDM845_SLAVE_GNOC_SNOC				108
-#define SDM845_SLAVE_GNOC_MEM_NOC			109
-#define SDM845_SLAVE_SERVICE_GNOC			110
-#define SDM845_SLAVE_EBI1				111
-#define SDM845_SLAVE_MSS_PROC_MS_MPU_CFG		112
-#define SDM845_SLAVE_MEM_NOC_GNOC			113
-#define SDM845_SLAVE_LLCC				114
-#define SDM845_SLAVE_MEM_NOC_SNOC			115
-#define SDM845_SLAVE_SERVICE_MEM_NOC			116
-#define SDM845_SLAVE_MNOC_SF_MEM_NOC			117
-#define SDM845_SLAVE_MNOC_HF_MEM_NOC			118
-#define SDM845_SLAVE_SERVICE_MNOC			119
-#define SDM845_SLAVE_APPSS				120
-#define SDM845_SLAVE_SNOC_CNOC				121
-#define SDM845_SLAVE_SNOC_MEM_NOC_GC			122
-#define SDM845_SLAVE_SNOC_MEM_NOC_SF			123
-#define SDM845_SLAVE_IMEM				124
-#define SDM845_SLAVE_PCIE_0				125
-#define SDM845_SLAVE_PCIE_1				126
-#define SDM845_SLAVE_PIMEM				127
-#define SDM845_SLAVE_SERVICE_SNOC			128
-#define SDM845_SLAVE_QDSS_STM				129
-#define SDM845_SLAVE_TCU				130
-
-#endif /* __DRIVERS_INTERCONNECT_QCOM_SDM845_H__ */

-- 
2.47.3



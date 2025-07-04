Return-Path: <linux-pm+bounces-30145-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ECCAAF9881
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jul 2025 18:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 533AB3B1F29
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jul 2025 16:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476E2309DA8;
	Fri,  4 Jul 2025 16:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D/BwV/uF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEDE3093D1
	for <linux-pm@vger.kernel.org>; Fri,  4 Jul 2025 16:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751646932; cv=none; b=LuD1atMv2Z1h2fC0obuMuOEoqyADUthpKH92nUHEt1XFt4s20hz6s6EQ4s3CTe116NLTQunxIF4C9onfhgPMwXccoN17VSpioAqb9mCe5Q5mygtbTvqW29M1X+MgmbxbflJOF5njafDzgBPdwN/icPLhjKH17zviMDo4H+lN6N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751646932; c=relaxed/simple;
	bh=Po3uAnbbJQfcOJ9AwjjvOgDGl5MOefKiXSjPVGg+duA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FUt9m4R0Xr7HgvWFjEqjGSCsQ1sTMGvMYnAD7XPUN4hoYt2Fqb7c250fQkdckOkwgiwPGzUiIDgftuaMfnZiHOM5Q1orWxqMpOerZ2hlLq1Qc5VTjQMbZbLgTJYzL88La60YJG2qGo7HAYuJez67k3GpoX6B5jOxdnOXeMVPK00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D/BwV/uF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56498owv011258
	for <linux-pm@vger.kernel.org>; Fri, 4 Jul 2025 16:35:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=x+uc35o7ZAs4x+Vhq1bn38
	TM/2Sgai0URazaa2yZZXc=; b=D/BwV/uF50S5g+Rk1bn+6iA0qx/6gplbGT3crC
	QEYgxGelFN8srvoM+gkJFkE62cyv1pG1dttuxp1xuX24Of9wRTHBMOzW5gDTbFon
	gFYQs21sxKJrJaF8O8cAIhbbtYpuBsnyZuowuAPxC+JI7GgN5hFNQpIkOPZQvzBk
	V0fXyp40jDnr+VC8n0cNOUd5FwGycpU6NW6w0aawteZdBXQhm1mHCrcH2fg+TAH4
	DHfQDxeneZ+h3WINUw4My1L+5lptJR8n+hJZZjS41hcFDhc2c8HRKrOPDheV5ofL
	Iz9bB4Uj+N32Ow7etd8TyiX6CjXW0pM8QJAsoawsY8blSUwA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47j802c7jw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 04 Jul 2025 16:35:29 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7d22790afd2so145393185a.2
        for <linux-pm@vger.kernel.org>; Fri, 04 Jul 2025 09:35:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751646923; x=1752251723;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x+uc35o7ZAs4x+Vhq1bn38TM/2Sgai0URazaa2yZZXc=;
        b=XpVGWK5LiWU92zqgjVG4MiY9k/awGquGi34LAv6cazFx6vh1xc50S0pBuSMzJTIzkR
         PIZJnMARB9szauoX54TobpJWpN46ryoNxQ7jM5EUHn3qpf2L2J5oNfygRVNdSdE8DDR4
         frTBqcUdoZm09dTBdIE/24nCOZe+9PJRV99sTnKQ7l/6WERppUF1646Z7TOOrnfg7twa
         X7qUMZNgHktWg09sEO83tGzFa2oSceOkoXWYT0IYq21xXDwyFNGZJ8QNulsNEc2M6m0W
         BZhYSxRc1z6wtfwswPEpfF45bro+BmOwPSks24yCbux8NzfIe4hFGRAKdR9wjdF8EBvi
         qaig==
X-Forwarded-Encrypted: i=1; AJvYcCVarX6NqcaiLtYMd4JiVjSw3Ok7EJViO+SZLaLgyTFCsU7btVcoqg5wgh8TMkRL96ND5mGHUGNcQw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxJnzx71XPl3Qmhjc4cGfBx0sl9eA5nHUmOKlAY7tq38NzOJmff
	CyqBJzaYMsDYWTtD354Se804B3yhj8S7cnKgZdS39ry0DLTG5CtOmiI3w/8id+kPhqgtP1WlmYY
	/ggJtrKatKqg7jnWLvsCHW0l0BcDVQ42tOEreCxLvdFV/9dznirPK297JRTtjjbP0GHlOF06s
X-Gm-Gg: ASbGncvo9X0t+A18haPuP7tbeJJJ42HqIQxnPuL5sDkN6yw9FTsGXp25HxmcZPIgQAw
	6G9FI0OCaXz+/Po7N6eDhcCee7pFpWDVF6Z0I7YWlg9A08bZK7T5NO80eLT3dhDnMwtt4mTMDod
	ifpePRIpfXiOd34LicyEDmMkm7R+NCpCG/RQNQBjRSJrK7UF5RVilBZyeGsNgprWhjtLyqfsAIC
	fyKr/N2pme1AGRGfCYJDCuijstBqG0f2ObrxG9rVfr79vqF7wcxggIh9mYDBVhOWZDqGO4B9EXM
	g1Ifq/TSipQK/0Zum9sOBUYdYs5xYmhsTur1PpstGJmtBSJFDTaeccLEfeIwrTPCNCJjvmZ+HSF
	yZjDC9dbztncBFfo2hhCEa5MBEnMfYqyuSRA=
X-Received: by 2002:a05:620a:2915:b0:7ca:f02a:4d2b with SMTP id af79cd13be357-7d5dcc7295dmr437631085a.12.1751646923038;
        Fri, 04 Jul 2025 09:35:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQf8t57Yy79UtDPPVGPKb+uYjUJ6VtqYRO6eocRU7Sq95hkq8WDUXdXfwQHNnP+4vGWZMFKQ==
X-Received: by 2002:a05:620a:2915:b0:7ca:f02a:4d2b with SMTP id af79cd13be357-7d5dcc7295dmr437627185a.12.1751646922586;
        Fri, 04 Jul 2025 09:35:22 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-556383d33f3sm298321e87.68.2025.07.04.09.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 09:35:21 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v2 00/28] interconnect: qcom: icc-rpmh: use NULL-terminated
 arrays and drop static IDs
Date: Fri, 04 Jul 2025 19:35:12 +0300
Message-Id: <20250704-rework-icc-v2-0-875fac996ef5@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMACaGgC/02OQQ6CMBBFr0K6ttgWbYWV9zAsShm1Uah0CmIId
 7dATNxM8iZ/3vyJIHgLSIpkIh4Gi9a1EcQuIeau2xtQW0cmgokjkzyjHt7OP6g1hrI6q5RQUqv
 8ROLBy8PVjqvsUka+WwzOf1b3wJftTyP/NQOnjFaGZ0KK/FArfnaIadfrp3FNk8ZBynnTe+j6W
 DFsP0ilEegSsqFIWhjDvtEYwMf8/AXxTldm2gAAAA==
X-Change-ID: 20250613-rework-icc-0d3b7276a798
To: Georgi Djakov <djakov@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5598;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=Po3uAnbbJQfcOJ9AwjjvOgDGl5MOefKiXSjPVGg+duA=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBoaALE8yCzNhw3/zTB2MAdpwiQlGQG4bu0xxob0
 cq9Z93tUlOJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaGgCxAAKCRCLPIo+Aiko
 1czFB/96HwsiGptRvOgP15Z2sYwphRfPTxhO3NcZg1F4G9OXZA2oFymEffyjC7eKVYgKqDHfqKK
 +3HWbvmZw5PoNwgtY8htkRUQOzvc2+Lj6SgmYOxRCuEV8TxRSyZCEgEbHKcqtp8ylaVANKY72Pj
 /5fNheiejelgr6hnSgAGW+vQwx/F9AUBS485inlZoR2MeMfTgqMLBVtUDGKL8Hfo7SnRlzc+kg5
 5+I5T3+WazLUJ5YfnhiHb/YFjq89raluIU8Nvq37XRhzn8YbkIKJXrP2WeGxNjY7AsHKQoxQfvr
 AJEuzrnOHulF2HD5xwQdrSiUrHxgZU1yD7ZOyMR2fj8WkFfh
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: OiX-U-843ITdkk8eEZxpmDW46lZKg9CM
X-Authority-Analysis: v=2.4 cv=YPWfyQGx c=1 sm=1 tr=0 ts=686802d1 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=XAMh8DXI7HpmVRFZxe8A:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: OiX-U-843ITdkk8eEZxpmDW46lZKg9CM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA0MDEyNiBTYWx0ZWRfX3gSWv1UAV1ha
 oWUJC9T8OEin+eg2BpE5N9XYXj1q087raFCCSASdGpakbyTMAep7IIEQYKvyBbdihdavQdFezT0
 vRNMsOuiNem/O31ZghGlXnQg5TFxtUI7wcKrXtMabQplnnl6cKZy/BiWlEzQ1QuotfHJ10gaEvR
 sj2KY2y8Uac7tQwPKSW3cumIXhvx9zVV+m8aiiKgWON9vIasHo/VCb9r6CYDNQgdTriYpcSCDnS
 v6weLpVnkkdp7Iyxti6Fi6XF2D3SWuSJlRD6SKP1iPMGO1VV300bD/5L4UZzyN9LbucISBvNc70
 15R7oHsZ8O1zsIx+RibsZ5zx7peeR/OIEDh8SjsbJ4EySIOxMeDmWT5mixs/EHZ22lKcSANwhiz
 x3G7jYC/uTo2fbYl5mZ1jGxX3MY+BduBg7kjF0FiOfb6mAZw/Zbr+yiys+eYJRu/fC5U8xpq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_06,2025-07-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 mlxlogscore=684 mlxscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507040126

Qualcomm interconnect code has been using .num_foo fields together with
the arrays embedded in the structure, which results in hard-to-notice
mistakes if .num_foo gets omitted or incorrect.

Rework RPMh interconnect code to use NULL-terminated arrays for the
dynamic IDs case (as now all the arrays contain only pointers) and,
while we are at it, rework all the drivers to use dynamic IDs and drop
static IDs code.

This series touches only RPMh interconnect drivers. Corresponding series
for RPM drivers will follow up shortly.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Changes in v2:
- Rebased on linux-next, dropping applied dependency
- Link to v1: https://lore.kernel.org/r/20250616-rework-icc-v1-0-bc1326294d71@oss.qualcomm.com

---
Dmitry Baryshkov (28):
      interconnect: qcom: sc8280xp: specify num_links for qnm_a1noc_cfg
      interconnect: qcom: sc8180x: specify num_nodes
      interconnect: qcom: rpmh: make nodes a NULL_terminated array
      interconnect: qcom: rpmh: make link_nodes a NULL_terminated array
      interconnect: qcom: sc7280: convert to dynamic IDs
      interconnect: qcom: sc8180x: convert to dynamic IDs
      interconnect: qcom: sc8280xp: convert to dynamic IDs
      interconnect: qcom: sdm845: convert to dynamic IDs
      interconnect: qcom: sm8250: convert to dynamic IDs
      interconnect: qcom: x1e80100: convert to dynamic IDs
      interconnect: qcom: qcs615: convert to dynamic IDs
      interconnect: qcom: qcs8300: convert to dynamic IDs
      interconnect: qcom: qdu1000: convert to dynamic IDs
      interconnect: qcom: sar2130p: convert to dynamic IDs
      interconnect: qcom: sc7180: convert to dynamic IDs
      interconnect: qcom: sdm670: convert to dynamic IDs
      interconnect: qcom: sdx55: convert to dynamic IDs
      interconnect: qcom: sdx65: convert to dynamic IDs
      interconnect: qcom: sdx75: convert to dynamic IDs
      interconnect: qcom: sm6350: convert to dynamic IDs
      interconnect: qcom: sm7150: convert to dynamic IDs
      interconnect: qcom: sm8150: convert to dynamic IDs
      interconnect: qcom: sm8350: convert to dynamic IDs
      interconnect: qcom: sm8450: convert to dynamic IDs
      interconnect: qcom: sm8550: convert to dynamic IDs
      interconnect: qcom: sm8650: convert to dynamic IDs
      interconnect: qcom: sm8750: convert to dynamic IDs
      interconnect: qcom: icc-rpmh: drop support for non-dynamic IDS

 drivers/interconnect/qcom/bcm-voter.c |    4 +-
 drivers/interconnect/qcom/icc-rpmh.c  |   20 +-
 drivers/interconnect/qcom/icc-rpmh.h  |   13 +-
 drivers/interconnect/qcom/qcs615.c    |  713 ++++++++-----------
 drivers/interconnect/qcom/qcs615.h    |  128 ----
 drivers/interconnect/qcom/qcs8300.c   |  911 +++++++++++-------------
 drivers/interconnect/qcom/qcs8300.h   |  177 -----
 drivers/interconnect/qcom/qdu1000.c   |  470 ++++++------
 drivers/interconnect/qcom/qdu1000.h   |   95 ---
 drivers/interconnect/qcom/sa8775p.c   |  493 ++++++-------
 drivers/interconnect/qcom/sar2130p.c  |  795 ++++++++-------------
 drivers/interconnect/qcom/sc7180.c    |  892 +++++++++++------------
 drivers/interconnect/qcom/sc7180.h    |  149 ----
 drivers/interconnect/qcom/sc7280.c    |  840 ++++++++++------------
 drivers/interconnect/qcom/sc7280.h    |  154 ----
 drivers/interconnect/qcom/sc8180x.c   | 1013 +++++++++++++-------------
 drivers/interconnect/qcom/sc8180x.h   |  179 -----
 drivers/interconnect/qcom/sc8280xp.c  | 1257 ++++++++++++++++-----------------
 drivers/interconnect/qcom/sc8280xp.h  |  209 ------
 drivers/interconnect/qcom/sdm670.c    |  712 +++++++++----------
 drivers/interconnect/qcom/sdm670.h    |  128 ----
 drivers/interconnect/qcom/sdm845.c    |  986 ++++++++++++--------------
 drivers/interconnect/qcom/sdm845.h    |  140 ----
 drivers/interconnect/qcom/sdx55.c     |  611 ++++++++--------
 drivers/interconnect/qcom/sdx55.h     |   70 --
 drivers/interconnect/qcom/sdx65.c     |  577 +++++++--------
 drivers/interconnect/qcom/sdx65.h     |   65 --
 drivers/interconnect/qcom/sdx75.c     |  498 ++++++-------
 drivers/interconnect/qcom/sdx75.h     |   97 ---
 drivers/interconnect/qcom/sm6350.c    |  838 +++++++++++-----------
 drivers/interconnect/qcom/sm6350.h    |  139 ----
 drivers/interconnect/qcom/sm7150.c    |  860 +++++++++++-----------
 drivers/interconnect/qcom/sm7150.h    |  140 ----
 drivers/interconnect/qcom/sm8150.c    |  930 ++++++++++++------------
 drivers/interconnect/qcom/sm8150.h    |  152 ----
 drivers/interconnect/qcom/sm8250.c    |  977 ++++++++++++-------------
 drivers/interconnect/qcom/sm8250.h    |  168 -----
 drivers/interconnect/qcom/sm8350.c    |  901 ++++++++++++-----------
 drivers/interconnect/qcom/sm8350.h    |  158 -----
 drivers/interconnect/qcom/sm8450.c    |  823 ++++++++++-----------
 drivers/interconnect/qcom/sm8450.h    |  169 -----
 drivers/interconnect/qcom/sm8550.c    |  683 ++++++++----------
 drivers/interconnect/qcom/sm8550.h    |  138 ----
 drivers/interconnect/qcom/sm8650.c    |  713 ++++++++-----------
 drivers/interconnect/qcom/sm8650.h    |  144 ----
 drivers/interconnect/qcom/sm8750.c    |  779 ++++++++------------
 drivers/interconnect/qcom/x1e80100.c  |  819 ++++++++++-----------
 drivers/interconnect/qcom/x1e80100.h  |  192 -----
 48 files changed, 8655 insertions(+), 13464 deletions(-)
---
base-commit: 26ffb3d6f02cd0935fb9fa3db897767beee1cb2a
change-id: 20250613-rework-icc-0d3b7276a798

Best regards,
-- 
With best wishes
Dmitry



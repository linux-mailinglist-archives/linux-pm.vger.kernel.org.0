Return-Path: <linux-pm+bounces-37199-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12102C25B09
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 15:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 437C41890D02
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 14:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059991EB1AA;
	Fri, 31 Oct 2025 14:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Rs64Oc4J";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eItHuI5+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8DC1DD543
	for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2025 14:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761921942; cv=none; b=otPCdrT5Utv9kZA13GCsykVoQSP0pUqj8A4oODdzjY4mRXV3u3XErJzu6GEMGvGpFYoou56RCNfTRk7UYPKtQCkhuVWyHZUQfpnlYpimJ1L90Lu4rKTf02sXmWwBqy6NkDbobHw8I5z958pPFRUxoxOWD+qkayA+9uaUpedknV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761921942; c=relaxed/simple;
	bh=qjRjUFcnZwLFG2LtBHEZ5yutnofEqlCGZTRfln3GIn4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S07UAFzN3x/NqcHePpAbE85Wf9N60efnXflDoptE63olkfcahxw2uL7xX1pBPf2uDCCZYPRnBCObHJjsDrDMpsimOkRZ2UosOi9ergAL7yQ5J7zZlpxSULBuhblLbupXerUWeL2/E9eQGM0eEkXifVXPgcSQjInfraEWRwz+hzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Rs64Oc4J; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eItHuI5+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59V73IKl2058369
	for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2025 14:45:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mrEBbofqL82NxnXEolJ2r+yqGT0aObTM7wn72YYU4wA=; b=Rs64Oc4JtjXs4vCS
	cwHVgfVYoBo5wg9CZsSr0Al7dQghDp9DCqH3AuWJ2TkLco7oTxmGjP9g82ngkQMI
	BYg6ZG6fmAUHXY3Gc9lH9E6xewr9w/88L6a/CWWEnqmpFnimrT0enrKWQDOevdlc
	BpVhW27j2Jq7+6vbre7qX0f0pE9Mq2eX177S9011vVywhVmxRfCXMI35EVCC91JA
	MPaiDc1uckdBxXS6RRIumWqKdGKwCWkP62zjudaw59DdA9NKrkdAt5SfUQQzwjG3
	L/rkTHHZWGuD3knbLIhJ2lAdIvHLjWPaWFGWME1/3+FEI5WAfDXLXs9dVORUYWI/
	X6YgXg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a4rcvh7dx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2025 14:45:35 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4e88a5e70a7so69043401cf.1
        for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2025 07:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761921934; x=1762526734; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mrEBbofqL82NxnXEolJ2r+yqGT0aObTM7wn72YYU4wA=;
        b=eItHuI5+sVYdw5INM1QywJR+9o7LbfDYVmyB3cUoGAjRli7aqYbSyu4Uf74BnwWQu2
         xJmxhYFkyeydcKnyWrA7YIAtLt9ej2hIPcvU6xxSUu2NJ6nEHYIum+5DccF92sX7mxQI
         +Ci7L3gowmOcwEr31xgSDUnfqf5mr7UUiDd2PNKMTOzDUMY+dWquMj0GZUfvP4nZeg2V
         +ico1QqfuPF0NpXP69c4ecmR0xcRWGqIO1xzQjBkCB/ddTzJ2raxgKUwsq5lb/xpLSf9
         dwzzRhZ+LC6l0/JhFXZVXbNK0v+1iB6VybSnU+QQsFQejoUXgCOlL1kPiGD/Gs/5mOKq
         cRpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761921934; x=1762526734;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mrEBbofqL82NxnXEolJ2r+yqGT0aObTM7wn72YYU4wA=;
        b=cR1LUVEyOeOwREo8VRoDhuixnDdmW+vrwXXJP4r7r+duyXHFzjpwzin+iTMWaskwEF
         PDkjlE/eCOa+A5puduQoYJEZkA121p/eq8oWzd28aTPNijmg/6nTqvcwrzb3Ia5eNNpu
         ujxhQrt0Ancox7gX4HVs2NRgnia2LfkxfOg+uIExAoNiWEuBNuCDo33denXnHmIHZT4o
         KIU4QJCdKZvLe7hqd8b2A2aVLfzGM5KzecdSL3DSrg8Gfl3MlpaCqE2KlC5Cj6bD0rnp
         n+chvX5QothBSxV83KOa3jUvqoxXvQUR5EwrhG8u6rqeUinwF5ux5RsmRZOWSGtpwmDz
         BXeA==
X-Forwarded-Encrypted: i=1; AJvYcCUB6D7r0jKf34jtW3czqNPIf5m7Ri3rKM64CF323PjDgUiOCtDNWkVf3zl4JSCMurqTavevou6Gww==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx44Tujv2ewDKhDq4UkeyBxdOEVD0GhHoLP4l07Fo5o7NmgyPiF
	Mx4tEuA1eWKrmvVVOUX+SSoYiBRUN8KxkgYGewDyPHD7fRhju9MwufHR2M6JNo3krPYdoNO09yF
	1/QpoYtk7cHfkbUH+Emxs6hDhbxYv7NmBLH5HEb3Jom0vLHbWBWmDl2r376j1eg==
X-Gm-Gg: ASbGncuupiW5vsS7NSzddA0CaEaIfcNJJ6wnxbCOcMft3LZ4XG5Ry4bJU2UhYDKuvky
	HVz26Q4Pe6AlY54BZ9OpQu0whOMvRoNi5ykRNS2M2YgY99obgDinS5ATHfH8FalIcckb7+/2rIU
	Wgw+qVbS/ObgxVv78vwgcnocj8rjm3f2sHwwaPBez0T+h4QvBxRrmbf7F8XGNuJGCeWiD4Qkqof
	8UhQmv0yLI0zK9dg6tvCA1UgTdchlmDkrFWxpqgHSh2zt2GpbqgEDudc8urDqOIAhstAbECW+Xq
	cwkpjljqhUEh7FrKszq7uDoX+yzzBgPLZL1ocyc7xP6iUDvSvhfCD8jBeOyo5wS62h+EaCkSVeD
	rg/FIxqHNtutsi0TEoa9RFe50e6p1JlMRuQF1K7K3IbfKVvvmHaquO3K0fkOZk8tLKKZX2mN7ka
	7VxcOB0OJQphez
X-Received: by 2002:ac8:5984:0:b0:4eb:a2ec:6e3e with SMTP id d75a77b69052e-4ed218c6279mr100875421cf.28.1761921932948;
        Fri, 31 Oct 2025 07:45:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGose1TAhx2YbAZJXqYkqSLPH83hxlQa7bmQuo0gQV1cndR7BbrUoInlvPA19tSuI34ZqhWlg==
X-Received: by 2002:ac8:5984:0:b0:4eb:a2ec:6e3e with SMTP id d75a77b69052e-4ed218c6279mr100874021cf.28.1761921931840;
        Fri, 31 Oct 2025 07:45:31 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5941f5bc218sm541405e87.93.2025.10.31.07.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 07:45:30 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 31 Oct 2025 16:45:17 +0200
Subject: [PATCH v3 01/25] interconnect: qcom: icc-rpmh: convert link_nodes
 to dynamic array
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-rework-icc-v3-1-0575304c9624@oss.qualcomm.com>
References: <20251031-rework-icc-v3-0-0575304c9624@oss.qualcomm.com>
In-Reply-To: <20251031-rework-icc-v3-0-0575304c9624@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=76790;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=qjRjUFcnZwLFG2LtBHEZ5yutnofEqlCGZTRfln3GIn4=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpBMuAGnXMli/zaZzfGJlwIB+GKKD1YOMx+jxB+
 iP7NtK+5z+JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaQTLgAAKCRCLPIo+Aiko
 1a4yCACBX9S47oEA1H7Uhk4igdqxwtJ65ROYWBc3hGOSmLs4dQqgzMVsLeRU1QhymoEW3MlCg+w
 QpA10wURlg7JifB8j/JDOfvGkdfF3L6gj4IaHIePC6maPQPhq4SWFrlOLP8GYB7agI6ueSxxTsC
 YJBR+Jrwmsz+JRaVIHZPQcCBL/WQiL3QMqGcCb6LqJJ8KabBYPT2QKG9oxPiMcI5Cd37cbUQjmu
 tL7awxjRQR09DX27cjSIYn61AqHvCow8rTIgDCwVUA5kncmRYONjCPwysm+hCxyHfotXJl9MOAJ
 sji/43nbkf4dxrWJgOllwAebiMKV2T2n/J7tcnWkS+BtIYbd
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=bJYb4f+Z c=1 sm=1 tr=0 ts=6904cb8f cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=zCA6ciPUE3KIEvnuGmwA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDEzMyBTYWx0ZWRfXwhaVuiYGsl/P
 /5oVkqnpJkgeoXh67/AD4AyU7rynrtDf+1CPPjgK2/EL2/nQ4AbJ1Kf+v6ioUj3Jl00ahwWdWzR
 QFiHyAV5POR7dwvAlPPUheKOy/r1FIW5ULbMlESFpM8K4wyDmcfBLJf1NbjF4AgFAvXkyJSDwbe
 3acgvSif7AD1rp9VARK3yGUOaIm6U9CkgUfsICZMQKUUz9ae5MFVjgwi5raIrLkel3no7rdzwAw
 ZlNFh2SE1n91e6ztRx9/1lgSU7jmxO95qO/1vjaSEAIEzmAE+iChW7qJ3jQNoxalK4wV6Y7lQVO
 YL4hGhQdNXTrRTGmFwZJVS4eKy6yv907i+yKegcVL0CtMJOuMkCU+GAsgG7iDRbP7drkuZiAqt2
 6z/m7J8KJxa7FBwW9zknW0Nh74W6Ig==
X-Proofpoint-ORIG-GUID: 9JCDF4yl1dGvJae0TpPbD-fUZGZywsmm
X-Proofpoint-GUID: 9JCDF4yl1dGvJae0TpPbD-fUZGZywsmm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_04,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 malwarescore=0
 spamscore=0 suspectscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510310133

Declaring link_nodes as a double-pointer results in a syntax sugar in
the interconnect driver to typecast the array. Change the type of
link_nodes field to the array to remove the need for the extra typecast.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/interconnect/qcom/glymur.c   | 204 +++++++++++++++++------------------
 drivers/interconnect/qcom/icc-rpmh.h |   2 +-
 drivers/interconnect/qcom/milos.c    | 130 +++++++++++-----------
 drivers/interconnect/qcom/sa8775p.c  | 186 ++++++++++++++++----------------
 4 files changed, 261 insertions(+), 261 deletions(-)

diff --git a/drivers/interconnect/qcom/glymur.c b/drivers/interconnect/qcom/glymur.c
index cf20b5752dbbf4a5e7a79926910993445d7cbb4f..104ac6c1bd3665de92e15d577cb51111289c794a 100644
--- a/drivers/interconnect/qcom/glymur.c
+++ b/drivers/interconnect/qcom/glymur.c
@@ -457,7 +457,7 @@ static struct qcom_icc_node qup0_core_master = {
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qup0_core_slave },
+	.link_nodes = { &qup0_core_slave },
 };
 
 static struct qcom_icc_node qup1_core_master = {
@@ -465,7 +465,7 @@ static struct qcom_icc_node qup1_core_master = {
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qup1_core_slave },
+	.link_nodes = { &qup1_core_slave },
 };
 
 static struct qcom_icc_node qup2_core_master = {
@@ -473,7 +473,7 @@ static struct qcom_icc_node qup2_core_master = {
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qup2_core_slave },
+	.link_nodes = { &qup2_core_slave },
 };
 
 static struct qcom_icc_node llcc_mc = {
@@ -481,7 +481,7 @@ static struct qcom_icc_node llcc_mc = {
 	.channels = 12,
 	.buswidth = 4,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &ebi },
+	.link_nodes = { &ebi },
 };
 
 static struct qcom_icc_node qsm_mnoc_cfg = {
@@ -489,7 +489,7 @@ static struct qcom_icc_node qsm_mnoc_cfg = {
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &srvc_mnoc },
+	.link_nodes = { &srvc_mnoc },
 };
 
 static struct qcom_icc_node qsm_pcie_east_anoc_cfg = {
@@ -497,7 +497,7 @@ static struct qcom_icc_node qsm_pcie_east_anoc_cfg = {
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &srvc_pcie_east_aggre_noc },
+	.link_nodes = { &srvc_pcie_east_aggre_noc },
 };
 
 static struct qcom_icc_node qnm_hscnoc_pcie_east = {
@@ -505,7 +505,7 @@ static struct qcom_icc_node qnm_hscnoc_pcie_east = {
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 3,
-	.link_nodes = (struct qcom_icc_node *[]) { &xs_pcie_0, &xs_pcie_1,
+	.link_nodes = { &xs_pcie_0, &xs_pcie_1,
 		      &xs_pcie_5 },
 };
 
@@ -514,7 +514,7 @@ static struct qcom_icc_node qsm_cnoc_pcie_east_slave_cfg = {
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 2,
-	.link_nodes = (struct qcom_icc_node *[]) { &qhs_hscnoc_pcie_east_ms_mpu_cfg,
+	.link_nodes = { &qhs_hscnoc_pcie_east_ms_mpu_cfg,
 		      &srvc_pcie_east },
 };
 
@@ -523,7 +523,7 @@ static struct qcom_icc_node qsm_pcie_west_anoc_cfg = {
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &srvc_pcie_west_aggre_noc },
+	.link_nodes = { &srvc_pcie_west_aggre_noc },
 };
 
 static struct qcom_icc_node qnm_hscnoc_pcie_west = {
@@ -531,7 +531,7 @@ static struct qcom_icc_node qnm_hscnoc_pcie_west = {
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 5,
-	.link_nodes = (struct qcom_icc_node *[]) { &xs_pcie_2, &xs_pcie_3a,
+	.link_nodes = { &xs_pcie_2, &xs_pcie_3a,
 		      &xs_pcie_3b, &xs_pcie_4,
 		      &xs_pcie_6 },
 };
@@ -541,7 +541,7 @@ static struct qcom_icc_node qsm_cnoc_pcie_west_slave_cfg = {
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 2,
-	.link_nodes = (struct qcom_icc_node *[]) { &qhs_hscnoc_pcie_west_ms_mpu_cfg,
+	.link_nodes = { &qhs_hscnoc_pcie_west_ms_mpu_cfg,
 		      &srvc_pcie_west },
 };
 
@@ -550,7 +550,7 @@ static struct qcom_icc_node qss_cnoc_pcie_slave_east_cfg = {
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qsm_cnoc_pcie_east_slave_cfg },
+	.link_nodes = { &qsm_cnoc_pcie_east_slave_cfg },
 };
 
 static struct qcom_icc_node qss_cnoc_pcie_slave_west_cfg = {
@@ -558,7 +558,7 @@ static struct qcom_icc_node qss_cnoc_pcie_slave_west_cfg = {
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qsm_cnoc_pcie_west_slave_cfg },
+	.link_nodes = { &qsm_cnoc_pcie_west_slave_cfg },
 };
 
 static struct qcom_icc_node qss_mnoc_cfg = {
@@ -566,7 +566,7 @@ static struct qcom_icc_node qss_mnoc_cfg = {
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qsm_mnoc_cfg },
+	.link_nodes = { &qsm_mnoc_cfg },
 };
 
 static struct qcom_icc_node qss_pcie_east_anoc_cfg = {
@@ -574,7 +574,7 @@ static struct qcom_icc_node qss_pcie_east_anoc_cfg = {
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qsm_pcie_east_anoc_cfg },
+	.link_nodes = { &qsm_pcie_east_anoc_cfg },
 };
 
 static struct qcom_icc_node qss_pcie_west_anoc_cfg = {
@@ -582,7 +582,7 @@ static struct qcom_icc_node qss_pcie_west_anoc_cfg = {
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qsm_pcie_west_anoc_cfg },
+	.link_nodes = { &qsm_pcie_west_anoc_cfg },
 };
 
 static struct qcom_icc_node qns_llcc = {
@@ -590,7 +590,7 @@ static struct qcom_icc_node qns_llcc = {
 	.channels = 12,
 	.buswidth = 16,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &llcc_mc },
+	.link_nodes = { &llcc_mc },
 };
 
 static struct qcom_icc_node qns_pcie_east = {
@@ -598,7 +598,7 @@ static struct qcom_icc_node qns_pcie_east = {
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qnm_hscnoc_pcie_east },
+	.link_nodes = { &qnm_hscnoc_pcie_east },
 };
 
 static struct qcom_icc_node qns_pcie_west = {
@@ -606,7 +606,7 @@ static struct qcom_icc_node qns_pcie_west = {
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qnm_hscnoc_pcie_west },
+	.link_nodes = { &qnm_hscnoc_pcie_west },
 };
 
 static struct qcom_icc_node qsm_cfg = {
@@ -614,7 +614,7 @@ static struct qcom_icc_node qsm_cfg = {
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 51,
-	.link_nodes = (struct qcom_icc_node *[]) { &qhs_ahb2phy0, &qhs_ahb2phy1,
+	.link_nodes = { &qhs_ahb2phy0, &qhs_ahb2phy1,
 		      &qhs_ahb2phy2, &qhs_ahb2phy3,
 		      &qhs_av1_enc_cfg, &qhs_camera_cfg,
 		      &qhs_clk_ctl, &qhs_crypto0_cfg,
@@ -654,7 +654,7 @@ static struct qcom_icc_node xm_gic = {
 		.prio_fwd_disable = 0,
 	},
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_llcc },
+	.link_nodes = { &qns_llcc },
 };
 
 static struct qcom_icc_node qss_cfg = {
@@ -662,7 +662,7 @@ static struct qcom_icc_node qss_cfg = {
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qsm_cfg },
+	.link_nodes = { &qsm_cfg },
 };
 
 static struct qcom_icc_node qnm_hscnoc_cnoc = {
@@ -670,7 +670,7 @@ static struct qcom_icc_node qnm_hscnoc_cnoc = {
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 8,
-	.link_nodes = (struct qcom_icc_node *[]) { &qhs_aoss, &qhs_ipc_router,
+	.link_nodes = { &qhs_aoss, &qhs_ipc_router,
 		      &qhs_soccp, &qhs_tme_cfg,
 		      &qns_apss, &qss_cfg,
 		      &qxs_boot_imem, &qxs_imem },
@@ -681,7 +681,7 @@ static struct qcom_icc_node qns_hscnoc_cnoc = {
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qnm_hscnoc_cnoc },
+	.link_nodes = { &qnm_hscnoc_cnoc },
 };
 
 static struct qcom_icc_node alm_gpu_tcu = {
@@ -696,7 +696,7 @@ static struct qcom_icc_node alm_gpu_tcu = {
 		.prio_fwd_disable = 1,
 	},
 	.num_links = 2,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_hscnoc_cnoc, &qns_llcc },
+	.link_nodes = { &qns_hscnoc_cnoc, &qns_llcc },
 };
 
 static struct qcom_icc_node alm_pcie_qtc = {
@@ -711,7 +711,7 @@ static struct qcom_icc_node alm_pcie_qtc = {
 		.prio_fwd_disable = 1,
 	},
 	.num_links = 2,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_hscnoc_cnoc, &qns_llcc },
+	.link_nodes = { &qns_hscnoc_cnoc, &qns_llcc },
 };
 
 static struct qcom_icc_node alm_sys_tcu = {
@@ -726,7 +726,7 @@ static struct qcom_icc_node alm_sys_tcu = {
 		.prio_fwd_disable = 1,
 	},
 	.num_links = 2,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_hscnoc_cnoc, &qns_llcc },
+	.link_nodes = { &qns_hscnoc_cnoc, &qns_llcc },
 };
 
 static struct qcom_icc_node chm_apps = {
@@ -734,7 +734,7 @@ static struct qcom_icc_node chm_apps = {
 	.channels = 6,
 	.buswidth = 32,
 	.num_links = 4,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_hscnoc_cnoc, &qns_llcc,
+	.link_nodes = { &qns_hscnoc_cnoc, &qns_llcc,
 		      &qns_pcie_east, &qns_pcie_west },
 };
 
@@ -750,7 +750,7 @@ static struct qcom_icc_node qnm_aggre_noc_east = {
 		.prio_fwd_disable = 1,
 	},
 	.num_links = 4,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_hscnoc_cnoc, &qns_llcc,
+	.link_nodes = { &qns_hscnoc_cnoc, &qns_llcc,
 		      &qns_pcie_east, &qns_pcie_west },
 };
 
@@ -766,7 +766,7 @@ static struct qcom_icc_node qnm_gpu = {
 		.prio_fwd_disable = 1,
 	},
 	.num_links = 4,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_hscnoc_cnoc, &qns_llcc,
+	.link_nodes = { &qns_hscnoc_cnoc, &qns_llcc,
 		      &qns_pcie_east, &qns_pcie_west },
 };
 
@@ -782,7 +782,7 @@ static struct qcom_icc_node qnm_lpass = {
 		.prio_fwd_disable = 0,
 	},
 	.num_links = 4,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_hscnoc_cnoc, &qns_llcc,
+	.link_nodes = { &qns_hscnoc_cnoc, &qns_llcc,
 		      &qns_pcie_east, &qns_pcie_west },
 };
 
@@ -798,7 +798,7 @@ static struct qcom_icc_node qnm_mnoc_hf = {
 		.prio_fwd_disable = 0,
 	},
 	.num_links = 4,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_hscnoc_cnoc, &qns_llcc,
+	.link_nodes = { &qns_hscnoc_cnoc, &qns_llcc,
 		      &qns_pcie_east, &qns_pcie_west },
 };
 
@@ -814,7 +814,7 @@ static struct qcom_icc_node qnm_mnoc_sf = {
 		.prio_fwd_disable = 0,
 	},
 	.num_links = 4,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_hscnoc_cnoc, &qns_llcc,
+	.link_nodes = { &qns_hscnoc_cnoc, &qns_llcc,
 		      &qns_pcie_east, &qns_pcie_west },
 };
 
@@ -830,7 +830,7 @@ static struct qcom_icc_node qnm_nsp_noc = {
 		.prio_fwd_disable = 1,
 	},
 	.num_links = 4,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_hscnoc_cnoc, &qns_llcc,
+	.link_nodes = { &qns_hscnoc_cnoc, &qns_llcc,
 		      &qns_pcie_east, &qns_pcie_west },
 };
 
@@ -846,7 +846,7 @@ static struct qcom_icc_node qnm_pcie_east = {
 		.prio_fwd_disable = 1,
 	},
 	.num_links = 2,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_hscnoc_cnoc, &qns_llcc },
+	.link_nodes = { &qns_hscnoc_cnoc, &qns_llcc },
 };
 
 static struct qcom_icc_node qnm_pcie_west = {
@@ -861,7 +861,7 @@ static struct qcom_icc_node qnm_pcie_west = {
 		.prio_fwd_disable = 1,
 	},
 	.num_links = 2,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_hscnoc_cnoc, &qns_llcc },
+	.link_nodes = { &qns_hscnoc_cnoc, &qns_llcc },
 };
 
 static struct qcom_icc_node qnm_snoc_sf = {
@@ -876,7 +876,7 @@ static struct qcom_icc_node qnm_snoc_sf = {
 		.prio_fwd_disable = 1,
 	},
 	.num_links = 4,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_hscnoc_cnoc, &qns_llcc,
+	.link_nodes = { &qns_hscnoc_cnoc, &qns_llcc,
 		      &qns_pcie_east, &qns_pcie_west },
 };
 
@@ -885,7 +885,7 @@ static struct qcom_icc_node qxm_wlan_q6 = {
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 4,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_hscnoc_cnoc, &qns_llcc,
+	.link_nodes = { &qns_hscnoc_cnoc, &qns_llcc,
 		      &qns_pcie_east, &qns_pcie_west },
 };
 
@@ -894,7 +894,7 @@ static struct qcom_icc_node qns_a4noc_hscnoc = {
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qnm_aggre_noc_east },
+	.link_nodes = { &qnm_aggre_noc_east },
 };
 
 static struct qcom_icc_node qns_lpass_ag_noc_gemnoc = {
@@ -902,7 +902,7 @@ static struct qcom_icc_node qns_lpass_ag_noc_gemnoc = {
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qnm_lpass },
+	.link_nodes = { &qnm_lpass },
 };
 
 static struct qcom_icc_node qns_mem_noc_hf = {
@@ -910,7 +910,7 @@ static struct qcom_icc_node qns_mem_noc_hf = {
 	.channels = 2,
 	.buswidth = 32,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qnm_mnoc_hf },
+	.link_nodes = { &qnm_mnoc_hf },
 };
 
 static struct qcom_icc_node qns_mem_noc_sf = {
@@ -918,7 +918,7 @@ static struct qcom_icc_node qns_mem_noc_sf = {
 	.channels = 2,
 	.buswidth = 32,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qnm_mnoc_sf },
+	.link_nodes = { &qnm_mnoc_sf },
 };
 
 static struct qcom_icc_node qns_nsp_hscnoc = {
@@ -926,7 +926,7 @@ static struct qcom_icc_node qns_nsp_hscnoc = {
 	.channels = 4,
 	.buswidth = 32,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qnm_nsp_noc },
+	.link_nodes = { &qnm_nsp_noc },
 };
 
 static struct qcom_icc_node qns_pcie_east_mem_noc = {
@@ -934,7 +934,7 @@ static struct qcom_icc_node qns_pcie_east_mem_noc = {
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qnm_pcie_east },
+	.link_nodes = { &qnm_pcie_east },
 };
 
 static struct qcom_icc_node qns_pcie_west_mem_noc = {
@@ -942,7 +942,7 @@ static struct qcom_icc_node qns_pcie_west_mem_noc = {
 	.channels = 1,
 	.buswidth = 64,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qnm_pcie_west },
+	.link_nodes = { &qnm_pcie_west },
 };
 
 static struct qcom_icc_node qns_gemnoc_sf = {
@@ -950,7 +950,7 @@ static struct qcom_icc_node qns_gemnoc_sf = {
 	.channels = 1,
 	.buswidth = 64,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qnm_snoc_sf },
+	.link_nodes = { &qnm_snoc_sf },
 };
 
 static struct qcom_icc_node xm_usb3_0 = {
@@ -965,7 +965,7 @@ static struct qcom_icc_node xm_usb3_0 = {
 		.prio_fwd_disable = 1,
 	},
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_a4noc_hscnoc },
+	.link_nodes = { &qns_a4noc_hscnoc },
 };
 
 static struct qcom_icc_node xm_usb3_1 = {
@@ -980,7 +980,7 @@ static struct qcom_icc_node xm_usb3_1 = {
 		.prio_fwd_disable = 1,
 	},
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_a4noc_hscnoc },
+	.link_nodes = { &qns_a4noc_hscnoc },
 };
 
 static struct qcom_icc_node xm_usb4_0 = {
@@ -995,7 +995,7 @@ static struct qcom_icc_node xm_usb4_0 = {
 		.prio_fwd_disable = 1,
 	},
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_a4noc_hscnoc },
+	.link_nodes = { &qns_a4noc_hscnoc },
 };
 
 static struct qcom_icc_node xm_usb4_1 = {
@@ -1010,7 +1010,7 @@ static struct qcom_icc_node xm_usb4_1 = {
 		.prio_fwd_disable = 1,
 	},
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_a4noc_hscnoc },
+	.link_nodes = { &qns_a4noc_hscnoc },
 };
 
 static struct qcom_icc_node qnm_lpiaon_noc = {
@@ -1018,7 +1018,7 @@ static struct qcom_icc_node qnm_lpiaon_noc = {
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_lpass_ag_noc_gemnoc },
+	.link_nodes = { &qns_lpass_ag_noc_gemnoc },
 };
 
 static struct qcom_icc_node qnm_av1_enc = {
@@ -1033,7 +1033,7 @@ static struct qcom_icc_node qnm_av1_enc = {
 		.prio_fwd_disable = 1,
 	},
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_mem_noc_sf },
+	.link_nodes = { &qns_mem_noc_sf },
 };
 
 static struct qcom_icc_node qnm_camnoc_hf = {
@@ -1048,7 +1048,7 @@ static struct qcom_icc_node qnm_camnoc_hf = {
 		.prio_fwd_disable = 0,
 	},
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_mem_noc_hf },
+	.link_nodes = { &qns_mem_noc_hf },
 };
 
 static struct qcom_icc_node qnm_camnoc_icp = {
@@ -1063,7 +1063,7 @@ static struct qcom_icc_node qnm_camnoc_icp = {
 		.prio_fwd_disable = 1,
 	},
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_mem_noc_sf },
+	.link_nodes = { &qns_mem_noc_sf },
 };
 
 static struct qcom_icc_node qnm_camnoc_sf = {
@@ -1078,7 +1078,7 @@ static struct qcom_icc_node qnm_camnoc_sf = {
 		.prio_fwd_disable = 0,
 	},
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_mem_noc_sf },
+	.link_nodes = { &qns_mem_noc_sf },
 };
 
 static struct qcom_icc_node qnm_eva = {
@@ -1093,7 +1093,7 @@ static struct qcom_icc_node qnm_eva = {
 		.prio_fwd_disable = 0,
 	},
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_mem_noc_sf },
+	.link_nodes = { &qns_mem_noc_sf },
 };
 
 static struct qcom_icc_node qnm_mdp = {
@@ -1108,7 +1108,7 @@ static struct qcom_icc_node qnm_mdp = {
 		.prio_fwd_disable = 0,
 	},
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_mem_noc_hf },
+	.link_nodes = { &qns_mem_noc_hf },
 };
 
 static struct qcom_icc_node qnm_vapss_hcp = {
@@ -1116,7 +1116,7 @@ static struct qcom_icc_node qnm_vapss_hcp = {
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_mem_noc_sf },
+	.link_nodes = { &qns_mem_noc_sf },
 };
 
 static struct qcom_icc_node qnm_video = {
@@ -1131,7 +1131,7 @@ static struct qcom_icc_node qnm_video = {
 		.prio_fwd_disable = 0,
 	},
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_mem_noc_sf },
+	.link_nodes = { &qns_mem_noc_sf },
 };
 
 static struct qcom_icc_node qnm_video_cv_cpu = {
@@ -1146,7 +1146,7 @@ static struct qcom_icc_node qnm_video_cv_cpu = {
 		.prio_fwd_disable = 1,
 	},
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_mem_noc_sf },
+	.link_nodes = { &qns_mem_noc_sf },
 };
 
 static struct qcom_icc_node qnm_video_v_cpu = {
@@ -1161,7 +1161,7 @@ static struct qcom_icc_node qnm_video_v_cpu = {
 		.prio_fwd_disable = 1,
 	},
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_mem_noc_sf },
+	.link_nodes = { &qns_mem_noc_sf },
 };
 
 static struct qcom_icc_node qnm_nsp = {
@@ -1169,7 +1169,7 @@ static struct qcom_icc_node qnm_nsp = {
 	.channels = 4,
 	.buswidth = 32,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_nsp_hscnoc },
+	.link_nodes = { &qns_nsp_hscnoc },
 };
 
 static struct qcom_icc_node xm_pcie_0 = {
@@ -1184,7 +1184,7 @@ static struct qcom_icc_node xm_pcie_0 = {
 		.prio_fwd_disable = 0,
 	},
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_pcie_east_mem_noc },
+	.link_nodes = { &qns_pcie_east_mem_noc },
 };
 
 static struct qcom_icc_node xm_pcie_1 = {
@@ -1199,7 +1199,7 @@ static struct qcom_icc_node xm_pcie_1 = {
 		.prio_fwd_disable = 0,
 	},
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_pcie_east_mem_noc },
+	.link_nodes = { &qns_pcie_east_mem_noc },
 };
 
 static struct qcom_icc_node xm_pcie_5 = {
@@ -1214,7 +1214,7 @@ static struct qcom_icc_node xm_pcie_5 = {
 		.prio_fwd_disable = 0,
 	},
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_pcie_east_mem_noc },
+	.link_nodes = { &qns_pcie_east_mem_noc },
 };
 
 static struct qcom_icc_node xm_pcie_2 = {
@@ -1229,7 +1229,7 @@ static struct qcom_icc_node xm_pcie_2 = {
 		.prio_fwd_disable = 0,
 	},
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_pcie_west_mem_noc },
+	.link_nodes = { &qns_pcie_west_mem_noc },
 };
 
 static struct qcom_icc_node xm_pcie_3a = {
@@ -1244,7 +1244,7 @@ static struct qcom_icc_node xm_pcie_3a = {
 		.prio_fwd_disable = 0,
 	},
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_pcie_west_mem_noc },
+	.link_nodes = { &qns_pcie_west_mem_noc },
 };
 
 static struct qcom_icc_node xm_pcie_3b = {
@@ -1259,7 +1259,7 @@ static struct qcom_icc_node xm_pcie_3b = {
 		.prio_fwd_disable = 0,
 	},
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_pcie_west_mem_noc },
+	.link_nodes = { &qns_pcie_west_mem_noc },
 };
 
 static struct qcom_icc_node xm_pcie_4 = {
@@ -1274,7 +1274,7 @@ static struct qcom_icc_node xm_pcie_4 = {
 		.prio_fwd_disable = 0,
 	},
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_pcie_west_mem_noc },
+	.link_nodes = { &qns_pcie_west_mem_noc },
 };
 
 static struct qcom_icc_node xm_pcie_6 = {
@@ -1289,7 +1289,7 @@ static struct qcom_icc_node xm_pcie_6 = {
 		.prio_fwd_disable = 0,
 	},
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_pcie_west_mem_noc },
+	.link_nodes = { &qns_pcie_west_mem_noc },
 };
 
 static struct qcom_icc_node qnm_aggre1_noc = {
@@ -1297,7 +1297,7 @@ static struct qcom_icc_node qnm_aggre1_noc = {
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_gemnoc_sf },
+	.link_nodes = { &qns_gemnoc_sf },
 };
 
 static struct qcom_icc_node qnm_aggre2_noc = {
@@ -1305,7 +1305,7 @@ static struct qcom_icc_node qnm_aggre2_noc = {
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_gemnoc_sf },
+	.link_nodes = { &qns_gemnoc_sf },
 };
 
 static struct qcom_icc_node qnm_aggre3_noc = {
@@ -1313,7 +1313,7 @@ static struct qcom_icc_node qnm_aggre3_noc = {
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_gemnoc_sf },
+	.link_nodes = { &qns_gemnoc_sf },
 };
 
 static struct qcom_icc_node qnm_nsi_noc = {
@@ -1328,7 +1328,7 @@ static struct qcom_icc_node qnm_nsi_noc = {
 		.prio_fwd_disable = 1,
 	},
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_gemnoc_sf },
+	.link_nodes = { &qns_gemnoc_sf },
 };
 
 static struct qcom_icc_node qnm_oobmss = {
@@ -1343,7 +1343,7 @@ static struct qcom_icc_node qnm_oobmss = {
 		.prio_fwd_disable = 1,
 	},
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_gemnoc_sf },
+	.link_nodes = { &qns_gemnoc_sf },
 };
 
 static struct qcom_icc_node qns_a1noc_snoc = {
@@ -1351,7 +1351,7 @@ static struct qcom_icc_node qns_a1noc_snoc = {
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qnm_aggre1_noc },
+	.link_nodes = { &qnm_aggre1_noc },
 };
 
 static struct qcom_icc_node qns_a2noc_snoc = {
@@ -1359,7 +1359,7 @@ static struct qcom_icc_node qns_a2noc_snoc = {
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qnm_aggre2_noc },
+	.link_nodes = { &qnm_aggre2_noc },
 };
 
 static struct qcom_icc_node qns_a3noc_snoc = {
@@ -1367,7 +1367,7 @@ static struct qcom_icc_node qns_a3noc_snoc = {
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qnm_aggre3_noc },
+	.link_nodes = { &qnm_aggre3_noc },
 };
 
 static struct qcom_icc_node qns_lpass_aggnoc = {
@@ -1375,7 +1375,7 @@ static struct qcom_icc_node qns_lpass_aggnoc = {
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qnm_lpiaon_noc },
+	.link_nodes = { &qnm_lpiaon_noc },
 };
 
 static struct qcom_icc_node qns_system_noc = {
@@ -1383,7 +1383,7 @@ static struct qcom_icc_node qns_system_noc = {
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qnm_nsi_noc },
+	.link_nodes = { &qnm_nsi_noc },
 };
 
 static struct qcom_icc_node qns_oobmss_snoc = {
@@ -1391,7 +1391,7 @@ static struct qcom_icc_node qns_oobmss_snoc = {
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qnm_oobmss },
+	.link_nodes = { &qnm_oobmss },
 };
 
 static struct qcom_icc_node qxm_crypto = {
@@ -1406,7 +1406,7 @@ static struct qcom_icc_node qxm_crypto = {
 		.prio_fwd_disable = 1,
 	},
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_a1noc_snoc },
+	.link_nodes = { &qns_a1noc_snoc },
 };
 
 static struct qcom_icc_node qxm_soccp = {
@@ -1421,7 +1421,7 @@ static struct qcom_icc_node qxm_soccp = {
 		.prio_fwd_disable = 1,
 	},
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_a1noc_snoc },
+	.link_nodes = { &qns_a1noc_snoc },
 };
 
 static struct qcom_icc_node xm_qdss_etr_0 = {
@@ -1436,7 +1436,7 @@ static struct qcom_icc_node xm_qdss_etr_0 = {
 		.prio_fwd_disable = 1,
 	},
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_a1noc_snoc },
+	.link_nodes = { &qns_a1noc_snoc },
 };
 
 static struct qcom_icc_node xm_qdss_etr_1 = {
@@ -1451,7 +1451,7 @@ static struct qcom_icc_node xm_qdss_etr_1 = {
 		.prio_fwd_disable = 1,
 	},
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_a1noc_snoc },
+	.link_nodes = { &qns_a1noc_snoc },
 };
 
 static struct qcom_icc_node xm_ufs_mem = {
@@ -1466,7 +1466,7 @@ static struct qcom_icc_node xm_ufs_mem = {
 		.prio_fwd_disable = 1,
 	},
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_a2noc_snoc },
+	.link_nodes = { &qns_a2noc_snoc },
 };
 
 static struct qcom_icc_node xm_usb3_2 = {
@@ -1481,7 +1481,7 @@ static struct qcom_icc_node xm_usb3_2 = {
 		.prio_fwd_disable = 1,
 	},
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_a2noc_snoc },
+	.link_nodes = { &qns_a2noc_snoc },
 };
 
 static struct qcom_icc_node xm_usb4_2 = {
@@ -1496,7 +1496,7 @@ static struct qcom_icc_node xm_usb4_2 = {
 		.prio_fwd_disable = 1,
 	},
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_a2noc_snoc },
+	.link_nodes = { &qns_a2noc_snoc },
 };
 
 static struct qcom_icc_node qhm_qspi = {
@@ -1511,7 +1511,7 @@ static struct qcom_icc_node qhm_qspi = {
 		.prio_fwd_disable = 1,
 	},
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_a3noc_snoc },
+	.link_nodes = { &qns_a3noc_snoc },
 };
 
 static struct qcom_icc_node qhm_qup0 = {
@@ -1526,7 +1526,7 @@ static struct qcom_icc_node qhm_qup0 = {
 		.prio_fwd_disable = 1,
 	},
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_a3noc_snoc },
+	.link_nodes = { &qns_a3noc_snoc },
 };
 
 static struct qcom_icc_node qhm_qup1 = {
@@ -1541,7 +1541,7 @@ static struct qcom_icc_node qhm_qup1 = {
 		.prio_fwd_disable = 1,
 	},
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_a3noc_snoc },
+	.link_nodes = { &qns_a3noc_snoc },
 };
 
 static struct qcom_icc_node qhm_qup2 = {
@@ -1556,7 +1556,7 @@ static struct qcom_icc_node qhm_qup2 = {
 		.prio_fwd_disable = 1,
 	},
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_a3noc_snoc },
+	.link_nodes = { &qns_a3noc_snoc },
 };
 
 static struct qcom_icc_node qxm_sp = {
@@ -1564,7 +1564,7 @@ static struct qcom_icc_node qxm_sp = {
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_a3noc_snoc },
+	.link_nodes = { &qns_a3noc_snoc },
 };
 
 static struct qcom_icc_node xm_sdc2 = {
@@ -1579,7 +1579,7 @@ static struct qcom_icc_node xm_sdc2 = {
 		.prio_fwd_disable = 1,
 	},
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_a3noc_snoc },
+	.link_nodes = { &qns_a3noc_snoc },
 };
 
 static struct qcom_icc_node xm_sdc4 = {
@@ -1594,7 +1594,7 @@ static struct qcom_icc_node xm_sdc4 = {
 		.prio_fwd_disable = 1,
 	},
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_a3noc_snoc },
+	.link_nodes = { &qns_a3noc_snoc },
 };
 
 static struct qcom_icc_node xm_usb2_0 = {
@@ -1609,7 +1609,7 @@ static struct qcom_icc_node xm_usb2_0 = {
 		.prio_fwd_disable = 1,
 	},
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_a3noc_snoc },
+	.link_nodes = { &qns_a3noc_snoc },
 };
 
 static struct qcom_icc_node xm_usb3_mp = {
@@ -1624,7 +1624,7 @@ static struct qcom_icc_node xm_usb3_mp = {
 		.prio_fwd_disable = 1,
 	},
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_a3noc_snoc },
+	.link_nodes = { &qns_a3noc_snoc },
 };
 
 static struct qcom_icc_node qnm_lpass_lpinoc = {
@@ -1632,7 +1632,7 @@ static struct qcom_icc_node qnm_lpass_lpinoc = {
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_lpass_aggnoc },
+	.link_nodes = { &qns_lpass_aggnoc },
 };
 
 static struct qcom_icc_node xm_cpucp = {
@@ -1640,7 +1640,7 @@ static struct qcom_icc_node xm_cpucp = {
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 2,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_system_noc, &srvc_nsinoc },
+	.link_nodes = { &qns_system_noc, &srvc_nsinoc },
 };
 
 static struct qcom_icc_node xm_mem_sp = {
@@ -1648,7 +1648,7 @@ static struct qcom_icc_node xm_mem_sp = {
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_oobmss_snoc },
+	.link_nodes = { &qns_oobmss_snoc },
 };
 
 static struct qcom_icc_node qns_lpi_aon_noc = {
@@ -1656,7 +1656,7 @@ static struct qcom_icc_node qns_lpi_aon_noc = {
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qnm_lpass_lpinoc },
+	.link_nodes = { &qnm_lpass_lpinoc },
 };
 
 static struct qcom_icc_node qnm_lpinoc_dsp_qns4m = {
@@ -1664,7 +1664,7 @@ static struct qcom_icc_node qnm_lpinoc_dsp_qns4m = {
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_lpi_aon_noc },
+	.link_nodes = { &qns_lpi_aon_noc },
 };
 
 static struct qcom_icc_bcm bcm_acv = {
diff --git a/drivers/interconnect/qcom/icc-rpmh.h b/drivers/interconnect/qcom/icc-rpmh.h
index 307f48412563690049e944907bd80500f263f738..b72939cceba38e92154f6af5a93149337fa13479 100644
--- a/drivers/interconnect/qcom/icc-rpmh.h
+++ b/drivers/interconnect/qcom/icc-rpmh.h
@@ -98,7 +98,6 @@ struct qcom_icc_node {
 	const char *name;
 	u16 links[MAX_LINKS];
 	u16 id;
-	struct qcom_icc_node **link_nodes;
 	struct icc_node *node;
 	u16 num_links;
 	u16 channels;
@@ -108,6 +107,7 @@ struct qcom_icc_node {
 	struct qcom_icc_bcm *bcms[MAX_BCM_PER_NODE];
 	size_t num_bcms;
 	const struct qcom_icc_qosbox *qosbox;
+	struct qcom_icc_node *link_nodes[];
 };
 
 /**
diff --git a/drivers/interconnect/qcom/milos.c b/drivers/interconnect/qcom/milos.c
index 167d479f77641a3c1a69f8a0beb20473a251a9d9..814ec0517f6b8f42ae9d7ce3cd5cebcbaae35ae8 100644
--- a/drivers/interconnect/qcom/milos.c
+++ b/drivers/interconnect/qcom/milos.c
@@ -151,7 +151,7 @@ static struct qcom_icc_node qhm_qup1 = {
 	.buswidth = 4,
 	.qosbox = &qhm_qup1_qos,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_a1noc_snoc },
+	.link_nodes = { &qns_a1noc_snoc },
 };
 
 static struct qcom_icc_qosbox xm_ufs_mem_qos = {
@@ -168,7 +168,7 @@ static struct qcom_icc_node xm_ufs_mem = {
 	.buswidth = 8,
 	.qosbox = &xm_ufs_mem_qos,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_a1noc_snoc },
+	.link_nodes = { &qns_a1noc_snoc },
 };
 
 static struct qcom_icc_qosbox xm_usb3_0_qos = {
@@ -185,7 +185,7 @@ static struct qcom_icc_node xm_usb3_0 = {
 	.buswidth = 8,
 	.qosbox = &xm_usb3_0_qos,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_a1noc_snoc },
+	.link_nodes = { &qns_a1noc_snoc },
 };
 
 static struct qcom_icc_qosbox qhm_qdss_bam_qos = {
@@ -202,7 +202,7 @@ static struct qcom_icc_node qhm_qdss_bam = {
 	.buswidth = 4,
 	.qosbox = &qhm_qdss_bam_qos,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_a2noc_snoc },
+	.link_nodes = { &qns_a2noc_snoc },
 };
 
 static struct qcom_icc_qosbox qhm_qspi_qos = {
@@ -219,7 +219,7 @@ static struct qcom_icc_node qhm_qspi = {
 	.buswidth = 4,
 	.qosbox = &qhm_qspi_qos,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_a2noc_snoc },
+	.link_nodes = { &qns_a2noc_snoc },
 };
 
 static struct qcom_icc_qosbox qhm_qup0_qos = {
@@ -236,7 +236,7 @@ static struct qcom_icc_node qhm_qup0 = {
 	.buswidth = 4,
 	.qosbox = &qhm_qup0_qos,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_a2noc_snoc },
+	.link_nodes = { &qns_a2noc_snoc },
 };
 
 static struct qcom_icc_qosbox qxm_crypto_qos = {
@@ -253,7 +253,7 @@ static struct qcom_icc_node qxm_crypto = {
 	.buswidth = 8,
 	.qosbox = &qxm_crypto_qos,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_a2noc_snoc },
+	.link_nodes = { &qns_a2noc_snoc },
 };
 
 static struct qcom_icc_qosbox qxm_ipa_qos = {
@@ -270,7 +270,7 @@ static struct qcom_icc_node qxm_ipa = {
 	.buswidth = 8,
 	.qosbox = &qxm_ipa_qos,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_a2noc_snoc },
+	.link_nodes = { &qns_a2noc_snoc },
 };
 
 static struct qcom_icc_qosbox xm_qdss_etr_0_qos = {
@@ -287,7 +287,7 @@ static struct qcom_icc_node xm_qdss_etr_0 = {
 	.buswidth = 8,
 	.qosbox = &xm_qdss_etr_0_qos,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_a2noc_snoc },
+	.link_nodes = { &qns_a2noc_snoc },
 };
 
 static struct qcom_icc_qosbox xm_qdss_etr_1_qos = {
@@ -304,7 +304,7 @@ static struct qcom_icc_node xm_qdss_etr_1 = {
 	.buswidth = 8,
 	.qosbox = &xm_qdss_etr_1_qos,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_a2noc_snoc },
+	.link_nodes = { &qns_a2noc_snoc },
 };
 
 static struct qcom_icc_qosbox xm_sdc1_qos = {
@@ -321,7 +321,7 @@ static struct qcom_icc_node xm_sdc1 = {
 	.buswidth = 8,
 	.qosbox = &xm_sdc1_qos,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_a2noc_snoc },
+	.link_nodes = { &qns_a2noc_snoc },
 };
 
 static struct qcom_icc_qosbox xm_sdc2_qos = {
@@ -338,7 +338,7 @@ static struct qcom_icc_node xm_sdc2 = {
 	.buswidth = 8,
 	.qosbox = &xm_sdc2_qos,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_a2noc_snoc },
+	.link_nodes = { &qns_a2noc_snoc },
 };
 
 static struct qcom_icc_node qup0_core_master = {
@@ -346,7 +346,7 @@ static struct qcom_icc_node qup0_core_master = {
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qup0_core_slave },
+	.link_nodes = { &qup0_core_slave },
 };
 
 static struct qcom_icc_node qup1_core_master = {
@@ -354,7 +354,7 @@ static struct qcom_icc_node qup1_core_master = {
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qup1_core_slave },
+	.link_nodes = { &qup1_core_slave },
 };
 
 static struct qcom_icc_node qsm_cfg = {
@@ -362,7 +362,7 @@ static struct qcom_icc_node qsm_cfg = {
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 35,
-	.link_nodes = (struct qcom_icc_node *[]) { &qhs_ahb2phy0, &qhs_ahb2phy1,
+	.link_nodes = { &qhs_ahb2phy0, &qhs_ahb2phy1,
 		   &qhs_camera_cfg, &qhs_clk_ctl,
 		   &qhs_cpr_cx, &qhs_cpr_mxa,
 		   &qhs_crypto0_cfg, &qhs_cx_rdpm,
@@ -387,7 +387,7 @@ static struct qcom_icc_node qnm_gemnoc_cnoc = {
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 14,
-	.link_nodes = (struct qcom_icc_node *[]) { &qhs_aoss, &qhs_display_cfg,
+	.link_nodes = { &qhs_aoss, &qhs_display_cfg,
 		   &qhs_ipa, &qhs_ipc_router,
 		   &qhs_pcie0_cfg, &qhs_pcie1_cfg,
 		   &qhs_prng, &qhs_tme_cfg,
@@ -401,7 +401,7 @@ static struct qcom_icc_node qnm_gemnoc_pcie = {
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 2,
-	.link_nodes = (struct qcom_icc_node *[]) { &xs_pcie_0, &xs_pcie_1 },
+	.link_nodes = { &xs_pcie_0, &xs_pcie_1 },
 };
 
 static struct qcom_icc_qosbox alm_gpu_tcu_qos = {
@@ -418,7 +418,7 @@ static struct qcom_icc_node alm_gpu_tcu = {
 	.buswidth = 8,
 	.qosbox = &alm_gpu_tcu_qos,
 	.num_links = 2,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_gem_noc_cnoc, &qns_llcc },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc },
 };
 
 static struct qcom_icc_qosbox alm_sys_tcu_qos = {
@@ -435,7 +435,7 @@ static struct qcom_icc_node alm_sys_tcu = {
 	.buswidth = 8,
 	.qosbox = &alm_sys_tcu_qos,
 	.num_links = 2,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_gem_noc_cnoc, &qns_llcc },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc },
 };
 
 static struct qcom_icc_node chm_apps = {
@@ -443,7 +443,7 @@ static struct qcom_icc_node chm_apps = {
 	.channels = 3,
 	.buswidth = 32,
 	.num_links = 3,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_gem_noc_cnoc, &qns_llcc,
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc,
 		   &qns_pcie },
 };
 
@@ -461,7 +461,7 @@ static struct qcom_icc_node qnm_gpu = {
 	.buswidth = 32,
 	.qosbox = &qnm_gpu_qos,
 	.num_links = 2,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_gem_noc_cnoc, &qns_llcc },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc },
 };
 
 static struct qcom_icc_qosbox qnm_lpass_gemnoc_qos = {
@@ -478,7 +478,7 @@ static struct qcom_icc_node qnm_lpass_gemnoc = {
 	.buswidth = 16,
 	.qosbox = &qnm_lpass_gemnoc_qos,
 	.num_links = 3,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_gem_noc_cnoc, &qns_llcc,
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc,
 		   &qns_pcie },
 };
 
@@ -487,7 +487,7 @@ static struct qcom_icc_node qnm_mdsp = {
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 3,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_gem_noc_cnoc, &qns_llcc,
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc,
 		   &qns_pcie },
 };
 
@@ -505,7 +505,7 @@ static struct qcom_icc_node qnm_mnoc_hf = {
 	.buswidth = 32,
 	.qosbox = &qnm_mnoc_hf_qos,
 	.num_links = 2,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_gem_noc_cnoc, &qns_llcc },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc },
 };
 
 static struct qcom_icc_qosbox qnm_mnoc_sf_qos = {
@@ -522,7 +522,7 @@ static struct qcom_icc_node qnm_mnoc_sf = {
 	.buswidth = 32,
 	.qosbox = &qnm_mnoc_sf_qos,
 	.num_links = 2,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_gem_noc_cnoc, &qns_llcc },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc },
 };
 
 static struct qcom_icc_qosbox qnm_nsp_gemnoc_qos = {
@@ -539,7 +539,7 @@ static struct qcom_icc_node qnm_nsp_gemnoc = {
 	.buswidth = 32,
 	.qosbox = &qnm_nsp_gemnoc_qos,
 	.num_links = 3,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_gem_noc_cnoc, &qns_llcc,
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc,
 		   &qns_pcie },
 };
 
@@ -557,7 +557,7 @@ static struct qcom_icc_node qnm_pcie = {
 	.buswidth = 8,
 	.qosbox = &qnm_pcie_qos,
 	.num_links = 2,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_gem_noc_cnoc, &qns_llcc },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc },
 };
 
 static struct qcom_icc_qosbox qnm_snoc_gc_qos = {
@@ -574,7 +574,7 @@ static struct qcom_icc_node qnm_snoc_gc = {
 	.buswidth = 8,
 	.qosbox = &qnm_snoc_gc_qos,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_llcc },
+	.link_nodes = { &qns_llcc },
 };
 
 static struct qcom_icc_qosbox qnm_snoc_sf_qos = {
@@ -591,7 +591,7 @@ static struct qcom_icc_node qnm_snoc_sf = {
 	.buswidth = 16,
 	.qosbox = &qnm_snoc_sf_qos,
 	.num_links = 3,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_gem_noc_cnoc, &qns_llcc,
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc,
 		   &qns_pcie },
 };
 
@@ -600,7 +600,7 @@ static struct qcom_icc_node qxm_wlan_q6 = {
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 3,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_gem_noc_cnoc, &qns_llcc,
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc,
 		   &qns_pcie },
 };
 
@@ -609,7 +609,7 @@ static struct qcom_icc_node qxm_lpass_dsp = {
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_lpass_ag_noc_gemnoc },
+	.link_nodes = { &qns_lpass_ag_noc_gemnoc },
 };
 
 static struct qcom_icc_node llcc_mc = {
@@ -617,7 +617,7 @@ static struct qcom_icc_node llcc_mc = {
 	.channels = 2,
 	.buswidth = 4,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &ebi },
+	.link_nodes = { &ebi },
 };
 
 static struct qcom_icc_qosbox qnm_camnoc_hf_qos = {
@@ -634,7 +634,7 @@ static struct qcom_icc_node qnm_camnoc_hf = {
 	.buswidth = 32,
 	.qosbox = &qnm_camnoc_hf_qos,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_mem_noc_hf },
+	.link_nodes = { &qns_mem_noc_hf },
 };
 
 static struct qcom_icc_qosbox qnm_camnoc_icp_qos = {
@@ -651,7 +651,7 @@ static struct qcom_icc_node qnm_camnoc_icp = {
 	.buswidth = 8,
 	.qosbox = &qnm_camnoc_icp_qos,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_mem_noc_sf },
+	.link_nodes = { &qns_mem_noc_sf },
 };
 
 static struct qcom_icc_qosbox qnm_camnoc_sf_qos = {
@@ -668,7 +668,7 @@ static struct qcom_icc_node qnm_camnoc_sf = {
 	.buswidth = 32,
 	.qosbox = &qnm_camnoc_sf_qos,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_mem_noc_sf },
+	.link_nodes = { &qns_mem_noc_sf },
 };
 
 static struct qcom_icc_qosbox qnm_mdp_qos = {
@@ -685,7 +685,7 @@ static struct qcom_icc_node qnm_mdp = {
 	.buswidth = 32,
 	.qosbox = &qnm_mdp_qos,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_mem_noc_hf },
+	.link_nodes = { &qns_mem_noc_hf },
 };
 
 static struct qcom_icc_qosbox qnm_video_qos = {
@@ -702,7 +702,7 @@ static struct qcom_icc_node qnm_video = {
 	.buswidth = 32,
 	.qosbox = &qnm_video_qos,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_mem_noc_sf },
+	.link_nodes = { &qns_mem_noc_sf },
 };
 
 static struct qcom_icc_node qsm_hf_mnoc_cfg = {
@@ -710,7 +710,7 @@ static struct qcom_icc_node qsm_hf_mnoc_cfg = {
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &srvc_mnoc_hf },
+	.link_nodes = { &srvc_mnoc_hf },
 };
 
 static struct qcom_icc_node qsm_sf_mnoc_cfg = {
@@ -718,7 +718,7 @@ static struct qcom_icc_node qsm_sf_mnoc_cfg = {
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &srvc_mnoc_sf },
+	.link_nodes = { &srvc_mnoc_sf },
 };
 
 static struct qcom_icc_node qxm_nsp = {
@@ -726,7 +726,7 @@ static struct qcom_icc_node qxm_nsp = {
 	.channels = 2,
 	.buswidth = 32,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_nsp_gemnoc },
+	.link_nodes = { &qns_nsp_gemnoc },
 };
 
 static struct qcom_icc_node qsm_pcie_anoc_cfg = {
@@ -734,7 +734,7 @@ static struct qcom_icc_node qsm_pcie_anoc_cfg = {
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &srvc_pcie_aggre_noc },
+	.link_nodes = { &srvc_pcie_aggre_noc },
 };
 
 static struct qcom_icc_qosbox xm_pcie3_0_qos = {
@@ -751,7 +751,7 @@ static struct qcom_icc_node xm_pcie3_0 = {
 	.buswidth = 8,
 	.qosbox = &xm_pcie3_0_qos,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_pcie_mem_noc },
+	.link_nodes = { &qns_pcie_mem_noc },
 };
 
 static struct qcom_icc_qosbox xm_pcie3_1_qos = {
@@ -768,7 +768,7 @@ static struct qcom_icc_node xm_pcie3_1 = {
 	.buswidth = 8,
 	.qosbox = &xm_pcie3_1_qos,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_pcie_mem_noc },
+	.link_nodes = { &qns_pcie_mem_noc },
 };
 
 static struct qcom_icc_node qnm_aggre1_noc = {
@@ -776,7 +776,7 @@ static struct qcom_icc_node qnm_aggre1_noc = {
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_gemnoc_sf },
+	.link_nodes = { &qns_gemnoc_sf },
 };
 
 static struct qcom_icc_node qnm_aggre2_noc = {
@@ -784,7 +784,7 @@ static struct qcom_icc_node qnm_aggre2_noc = {
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_gemnoc_sf },
+	.link_nodes = { &qns_gemnoc_sf },
 };
 
 static struct qcom_icc_qosbox qnm_apss_noc_qos = {
@@ -801,7 +801,7 @@ static struct qcom_icc_node qnm_apss_noc = {
 	.buswidth = 4,
 	.qosbox = &qnm_apss_noc_qos,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_gemnoc_sf },
+	.link_nodes = { &qns_gemnoc_sf },
 };
 
 static struct qcom_icc_qosbox qnm_cnoc_data_qos = {
@@ -818,7 +818,7 @@ static struct qcom_icc_node qnm_cnoc_data = {
 	.buswidth = 8,
 	.qosbox = &qnm_cnoc_data_qos,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_gemnoc_sf },
+	.link_nodes = { &qns_gemnoc_sf },
 };
 
 static struct qcom_icc_qosbox qxm_pimem_qos = {
@@ -835,7 +835,7 @@ static struct qcom_icc_node qxm_pimem = {
 	.buswidth = 8,
 	.qosbox = &qxm_pimem_qos,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_gemnoc_gc },
+	.link_nodes = { &qns_gemnoc_gc },
 };
 
 static struct qcom_icc_qosbox xm_gic_qos = {
@@ -852,7 +852,7 @@ static struct qcom_icc_node xm_gic = {
 	.buswidth = 8,
 	.qosbox = &xm_gic_qos,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_gemnoc_gc },
+	.link_nodes = { &qns_gemnoc_gc },
 };
 
 static struct qcom_icc_node qns_a1noc_snoc = {
@@ -860,7 +860,7 @@ static struct qcom_icc_node qns_a1noc_snoc = {
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qnm_aggre1_noc },
+	.link_nodes = { &qnm_aggre1_noc },
 };
 
 static struct qcom_icc_node qns_a2noc_snoc = {
@@ -868,7 +868,7 @@ static struct qcom_icc_node qns_a2noc_snoc = {
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qnm_aggre2_noc },
+	.link_nodes = { &qnm_aggre2_noc },
 };
 
 static struct qcom_icc_node qup0_core_slave = {
@@ -1079,7 +1079,7 @@ static struct qcom_icc_node qss_mnoc_hf_cfg = {
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qsm_hf_mnoc_cfg },
+	.link_nodes = { &qsm_hf_mnoc_cfg },
 };
 
 static struct qcom_icc_node qss_mnoc_sf_cfg = {
@@ -1087,7 +1087,7 @@ static struct qcom_icc_node qss_mnoc_sf_cfg = {
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qsm_sf_mnoc_cfg },
+	.link_nodes = { &qsm_sf_mnoc_cfg },
 };
 
 static struct qcom_icc_node qss_nsp_qtb_cfg = {
@@ -1102,7 +1102,7 @@ static struct qcom_icc_node qss_pcie_anoc_cfg = {
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qsm_pcie_anoc_cfg },
+	.link_nodes = { &qsm_pcie_anoc_cfg },
 };
 
 static struct qcom_icc_node qss_wlan_q6_throttle_cfg = {
@@ -1201,7 +1201,7 @@ static struct qcom_icc_node qss_cfg = {
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qsm_cfg },
+	.link_nodes = { &qsm_cfg },
 };
 
 static struct qcom_icc_node qss_ddrss_cfg = {
@@ -1251,7 +1251,7 @@ static struct qcom_icc_node qns_gem_noc_cnoc = {
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qnm_gemnoc_cnoc },
+	.link_nodes = { &qnm_gemnoc_cnoc },
 };
 
 static struct qcom_icc_node qns_llcc = {
@@ -1259,7 +1259,7 @@ static struct qcom_icc_node qns_llcc = {
 	.channels = 2,
 	.buswidth = 16,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &llcc_mc },
+	.link_nodes = { &llcc_mc },
 };
 
 static struct qcom_icc_node qns_pcie = {
@@ -1267,7 +1267,7 @@ static struct qcom_icc_node qns_pcie = {
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qnm_gemnoc_pcie },
+	.link_nodes = { &qnm_gemnoc_pcie },
 };
 
 static struct qcom_icc_node qns_lpass_ag_noc_gemnoc = {
@@ -1275,7 +1275,7 @@ static struct qcom_icc_node qns_lpass_ag_noc_gemnoc = {
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qnm_lpass_gemnoc },
+	.link_nodes = { &qnm_lpass_gemnoc },
 };
 
 static struct qcom_icc_node ebi = {
@@ -1290,7 +1290,7 @@ static struct qcom_icc_node qns_mem_noc_hf = {
 	.channels = 2,
 	.buswidth = 32,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qnm_mnoc_hf },
+	.link_nodes = { &qnm_mnoc_hf },
 };
 
 static struct qcom_icc_node qns_mem_noc_sf = {
@@ -1298,7 +1298,7 @@ static struct qcom_icc_node qns_mem_noc_sf = {
 	.channels = 2,
 	.buswidth = 32,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qnm_mnoc_sf },
+	.link_nodes = { &qnm_mnoc_sf },
 };
 
 static struct qcom_icc_node srvc_mnoc_hf = {
@@ -1320,7 +1320,7 @@ static struct qcom_icc_node qns_nsp_gemnoc = {
 	.channels = 2,
 	.buswidth = 32,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qnm_nsp_gemnoc },
+	.link_nodes = { &qnm_nsp_gemnoc },
 };
 
 static struct qcom_icc_node qns_pcie_mem_noc = {
@@ -1328,7 +1328,7 @@ static struct qcom_icc_node qns_pcie_mem_noc = {
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qnm_pcie },
+	.link_nodes = { &qnm_pcie },
 };
 
 static struct qcom_icc_node srvc_pcie_aggre_noc = {
@@ -1343,7 +1343,7 @@ static struct qcom_icc_node qns_gemnoc_gc = {
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qnm_snoc_gc },
+	.link_nodes = { &qnm_snoc_gc },
 };
 
 static struct qcom_icc_node qns_gemnoc_sf = {
@@ -1351,7 +1351,7 @@ static struct qcom_icc_node qns_gemnoc_sf = {
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qnm_snoc_sf },
+	.link_nodes = { &qnm_snoc_sf },
 };
 
 static struct qcom_icc_bcm bcm_acv = {
diff --git a/drivers/interconnect/qcom/sa8775p.c b/drivers/interconnect/qcom/sa8775p.c
index 04b4abbf44875c767ac67c552b36a8c64a06b2c3..d144e8cb5d1e3a69410975bd6b7abd9578c01407 100644
--- a/drivers/interconnect/qcom/sa8775p.c
+++ b/drivers/interconnect/qcom/sa8775p.c
@@ -214,7 +214,7 @@ static struct qcom_icc_node qxm_qup3 = {
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_a1noc_snoc },
+	.link_nodes = { &qns_a1noc_snoc },
 };
 
 static struct qcom_icc_node xm_emac_0 = {
@@ -222,7 +222,7 @@ static struct qcom_icc_node xm_emac_0 = {
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_a1noc_snoc },
+	.link_nodes = { &qns_a1noc_snoc },
 };
 
 static struct qcom_icc_node xm_emac_1 = {
@@ -230,7 +230,7 @@ static struct qcom_icc_node xm_emac_1 = {
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_a1noc_snoc },
+	.link_nodes = { &qns_a1noc_snoc },
 };
 
 static struct qcom_icc_node xm_sdc1 = {
@@ -238,7 +238,7 @@ static struct qcom_icc_node xm_sdc1 = {
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_a1noc_snoc },
+	.link_nodes = { &qns_a1noc_snoc },
 };
 
 static struct qcom_icc_node xm_ufs_mem = {
@@ -246,7 +246,7 @@ static struct qcom_icc_node xm_ufs_mem = {
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_a1noc_snoc },
+	.link_nodes = { &qns_a1noc_snoc },
 };
 
 static struct qcom_icc_node xm_usb2_2 = {
@@ -254,7 +254,7 @@ static struct qcom_icc_node xm_usb2_2 = {
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_a1noc_snoc },
+	.link_nodes = { &qns_a1noc_snoc },
 };
 
 static struct qcom_icc_node xm_usb3_0 = {
@@ -262,7 +262,7 @@ static struct qcom_icc_node xm_usb3_0 = {
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_a1noc_snoc },
+	.link_nodes = { &qns_a1noc_snoc },
 };
 
 static struct qcom_icc_node xm_usb3_1 = {
@@ -270,7 +270,7 @@ static struct qcom_icc_node xm_usb3_1 = {
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_a1noc_snoc },
+	.link_nodes = { &qns_a1noc_snoc },
 };
 
 static struct qcom_icc_node qhm_qdss_bam = {
@@ -278,7 +278,7 @@ static struct qcom_icc_node qhm_qdss_bam = {
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_a2noc_snoc },
+	.link_nodes = { &qns_a2noc_snoc },
 };
 
 static struct qcom_icc_node qhm_qup0 = {
@@ -286,7 +286,7 @@ static struct qcom_icc_node qhm_qup0 = {
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_a2noc_snoc },
+	.link_nodes = { &qns_a2noc_snoc },
 };
 
 static struct qcom_icc_node qhm_qup1 = {
@@ -294,7 +294,7 @@ static struct qcom_icc_node qhm_qup1 = {
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_a2noc_snoc },
+	.link_nodes = { &qns_a2noc_snoc },
 };
 
 static struct qcom_icc_node qhm_qup2 = {
@@ -302,7 +302,7 @@ static struct qcom_icc_node qhm_qup2 = {
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_a2noc_snoc },
+	.link_nodes = { &qns_a2noc_snoc },
 };
 
 static struct qcom_icc_node qnm_cnoc_datapath = {
@@ -310,7 +310,7 @@ static struct qcom_icc_node qnm_cnoc_datapath = {
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_a2noc_snoc },
+	.link_nodes = { &qns_a2noc_snoc },
 };
 
 static struct qcom_icc_node qxm_crypto_0 = {
@@ -318,7 +318,7 @@ static struct qcom_icc_node qxm_crypto_0 = {
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_a2noc_snoc },
+	.link_nodes = { &qns_a2noc_snoc },
 };
 
 static struct qcom_icc_node qxm_crypto_1 = {
@@ -326,7 +326,7 @@ static struct qcom_icc_node qxm_crypto_1 = {
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_a2noc_snoc },
+	.link_nodes = { &qns_a2noc_snoc },
 };
 
 static struct qcom_icc_node qxm_ipa = {
@@ -334,7 +334,7 @@ static struct qcom_icc_node qxm_ipa = {
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_a2noc_snoc },
+	.link_nodes = { &qns_a2noc_snoc },
 };
 
 static struct qcom_icc_node xm_qdss_etr_0 = {
@@ -342,7 +342,7 @@ static struct qcom_icc_node xm_qdss_etr_0 = {
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_a2noc_snoc },
+	.link_nodes = { &qns_a2noc_snoc },
 };
 
 static struct qcom_icc_node xm_qdss_etr_1 = {
@@ -350,7 +350,7 @@ static struct qcom_icc_node xm_qdss_etr_1 = {
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_a2noc_snoc },
+	.link_nodes = { &qns_a2noc_snoc },
 };
 
 static struct qcom_icc_node xm_ufs_card = {
@@ -358,7 +358,7 @@ static struct qcom_icc_node xm_ufs_card = {
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_a2noc_snoc },
+	.link_nodes = { &qns_a2noc_snoc },
 };
 
 static struct qcom_icc_node qup0_core_master = {
@@ -366,7 +366,7 @@ static struct qcom_icc_node qup0_core_master = {
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qup0_core_slave },
+	.link_nodes = { &qup0_core_slave },
 };
 
 static struct qcom_icc_node qup1_core_master = {
@@ -374,7 +374,7 @@ static struct qcom_icc_node qup1_core_master = {
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qup1_core_slave },
+	.link_nodes = { &qup1_core_slave },
 };
 
 static struct qcom_icc_node qup2_core_master = {
@@ -382,7 +382,7 @@ static struct qcom_icc_node qup2_core_master = {
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qup2_core_slave },
+	.link_nodes = { &qup2_core_slave },
 };
 
 static struct qcom_icc_node qup3_core_master = {
@@ -390,7 +390,7 @@ static struct qcom_icc_node qup3_core_master = {
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qup3_core_slave },
+	.link_nodes = { &qup3_core_slave },
 };
 
 static struct qcom_icc_node qnm_gemnoc_cnoc = {
@@ -398,7 +398,7 @@ static struct qcom_icc_node qnm_gemnoc_cnoc = {
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 82,
-	.link_nodes = (struct qcom_icc_node *[]) { &qhs_ahb2phy0, &qhs_ahb2phy1,
+	.link_nodes = { &qhs_ahb2phy0, &qhs_ahb2phy1,
 		      &qhs_ahb2phy2, &qhs_ahb2phy3,
 		      &qhs_anoc_throttle_cfg, &qhs_aoss,
 		      &qhs_apss, &qhs_boot_rom,
@@ -446,7 +446,7 @@ static struct qcom_icc_node qnm_gemnoc_pcie = {
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 2,
-	.link_nodes = (struct qcom_icc_node *[]) { &xs_pcie_0, &xs_pcie_1 },
+	.link_nodes = { &xs_pcie_0, &xs_pcie_1 },
 };
 
 static struct qcom_icc_node qnm_cnoc_dc_noc = {
@@ -454,7 +454,7 @@ static struct qcom_icc_node qnm_cnoc_dc_noc = {
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 2,
-	.link_nodes = (struct qcom_icc_node *[]) { &qhs_llcc, &qns_gemnoc },
+	.link_nodes = { &qhs_llcc, &qns_gemnoc },
 };
 
 static struct qcom_icc_node alm_gpu_tcu = {
@@ -462,7 +462,7 @@ static struct qcom_icc_node alm_gpu_tcu = {
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 2,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_gem_noc_cnoc, &qns_llcc },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc },
 };
 
 static struct qcom_icc_node alm_pcie_tcu = {
@@ -470,7 +470,7 @@ static struct qcom_icc_node alm_pcie_tcu = {
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 2,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_gem_noc_cnoc, &qns_llcc },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc },
 };
 
 static struct qcom_icc_node alm_sys_tcu = {
@@ -478,7 +478,7 @@ static struct qcom_icc_node alm_sys_tcu = {
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 2,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_gem_noc_cnoc, &qns_llcc },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc },
 };
 
 static struct qcom_icc_node chm_apps = {
@@ -486,7 +486,7 @@ static struct qcom_icc_node chm_apps = {
 	.channels = 4,
 	.buswidth = 32,
 	.num_links = 3,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_gem_noc_cnoc, &qns_llcc,
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc,
 		      &qns_pcie },
 };
 
@@ -495,7 +495,7 @@ static struct qcom_icc_node qnm_cmpnoc0 = {
 	.channels = 2,
 	.buswidth = 32,
 	.num_links = 2,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_gem_noc_cnoc, &qns_llcc },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc },
 };
 
 static struct qcom_icc_node qnm_cmpnoc1 = {
@@ -503,7 +503,7 @@ static struct qcom_icc_node qnm_cmpnoc1 = {
 	.channels = 2,
 	.buswidth = 32,
 	.num_links = 2,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_gem_noc_cnoc, &qns_llcc },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc },
 };
 
 static struct qcom_icc_node qnm_gemnoc_cfg = {
@@ -511,7 +511,7 @@ static struct qcom_icc_node qnm_gemnoc_cfg = {
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 4,
-	.link_nodes = (struct qcom_icc_node *[]) { &srvc_even_gemnoc, &srvc_odd_gemnoc,
+	.link_nodes = { &srvc_even_gemnoc, &srvc_odd_gemnoc,
 		      &srvc_sys_gemnoc, &srvc_sys_gemnoc_2 },
 };
 
@@ -520,7 +520,7 @@ static struct qcom_icc_node qnm_gpdsp_sail = {
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 2,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_gem_noc_cnoc, &qns_llcc },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc },
 };
 
 static struct qcom_icc_node qnm_gpu = {
@@ -528,7 +528,7 @@ static struct qcom_icc_node qnm_gpu = {
 	.channels = 2,
 	.buswidth = 32,
 	.num_links = 2,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_gem_noc_cnoc, &qns_llcc },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc },
 };
 
 static struct qcom_icc_node qnm_mnoc_hf = {
@@ -536,7 +536,7 @@ static struct qcom_icc_node qnm_mnoc_hf = {
 	.channels = 2,
 	.buswidth = 32,
 	.num_links = 2,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_llcc, &qns_pcie },
+	.link_nodes = { &qns_llcc, &qns_pcie },
 };
 
 static struct qcom_icc_node qnm_mnoc_sf = {
@@ -544,7 +544,7 @@ static struct qcom_icc_node qnm_mnoc_sf = {
 	.channels = 2,
 	.buswidth = 32,
 	.num_links = 3,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_gem_noc_cnoc, &qns_llcc,
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc,
 		      &qns_pcie },
 };
 
@@ -553,7 +553,7 @@ static struct qcom_icc_node qnm_pcie = {
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 2,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_gem_noc_cnoc, &qns_llcc },
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc },
 };
 
 static struct qcom_icc_node qnm_snoc_gc = {
@@ -561,7 +561,7 @@ static struct qcom_icc_node qnm_snoc_gc = {
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_llcc },
+	.link_nodes = { &qns_llcc },
 };
 
 static struct qcom_icc_node qnm_snoc_sf = {
@@ -569,7 +569,7 @@ static struct qcom_icc_node qnm_snoc_sf = {
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 3,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_gem_noc_cnoc, &qns_llcc,
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc,
 		      &qns_pcie },
 };
 
@@ -578,7 +578,7 @@ static struct qcom_icc_node qxm_dsp0 = {
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_gp_dsp_sail_noc },
+	.link_nodes = { &qns_gp_dsp_sail_noc },
 };
 
 static struct qcom_icc_node qxm_dsp1 = {
@@ -586,7 +586,7 @@ static struct qcom_icc_node qxm_dsp1 = {
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_gp_dsp_sail_noc },
+	.link_nodes = { &qns_gp_dsp_sail_noc },
 };
 
 static struct qcom_icc_node qhm_config_noc = {
@@ -594,7 +594,7 @@ static struct qcom_icc_node qhm_config_noc = {
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 6,
-	.link_nodes = (struct qcom_icc_node *[]) { &qhs_lpass_core, &qhs_lpass_lpi,
+	.link_nodes = { &qhs_lpass_core, &qhs_lpass_lpi,
 		      &qhs_lpass_mpu, &qhs_lpass_top,
 		      &srvc_niu_aml_noc, &srvc_niu_lpass_agnoc },
 };
@@ -604,7 +604,7 @@ static struct qcom_icc_node qxm_lpass_dsp = {
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 4,
-	.link_nodes = (struct qcom_icc_node *[]) { &qhs_lpass_top, &qns_sysnoc,
+	.link_nodes = { &qhs_lpass_top, &qns_sysnoc,
 		      &srvc_niu_aml_noc, &srvc_niu_lpass_agnoc },
 };
 
@@ -613,7 +613,7 @@ static struct qcom_icc_node llcc_mc = {
 	.channels = 8,
 	.buswidth = 4,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &ebi },
+	.link_nodes = { &ebi },
 };
 
 static struct qcom_icc_node qnm_camnoc_hf = {
@@ -621,7 +621,7 @@ static struct qcom_icc_node qnm_camnoc_hf = {
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_mem_noc_hf },
+	.link_nodes = { &qns_mem_noc_hf },
 };
 
 static struct qcom_icc_node qnm_camnoc_icp = {
@@ -629,7 +629,7 @@ static struct qcom_icc_node qnm_camnoc_icp = {
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_mem_noc_sf },
+	.link_nodes = { &qns_mem_noc_sf },
 };
 
 static struct qcom_icc_node qnm_camnoc_sf = {
@@ -637,7 +637,7 @@ static struct qcom_icc_node qnm_camnoc_sf = {
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_mem_noc_sf },
+	.link_nodes = { &qns_mem_noc_sf },
 };
 
 static struct qcom_icc_node qnm_mdp0_0 = {
@@ -645,7 +645,7 @@ static struct qcom_icc_node qnm_mdp0_0 = {
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_mem_noc_hf },
+	.link_nodes = { &qns_mem_noc_hf },
 };
 
 static struct qcom_icc_node qnm_mdp0_1 = {
@@ -653,7 +653,7 @@ static struct qcom_icc_node qnm_mdp0_1 = {
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_mem_noc_hf },
+	.link_nodes = { &qns_mem_noc_hf },
 };
 
 static struct qcom_icc_node qnm_mdp1_0 = {
@@ -661,7 +661,7 @@ static struct qcom_icc_node qnm_mdp1_0 = {
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_mem_noc_hf },
+	.link_nodes = { &qns_mem_noc_hf },
 };
 
 static struct qcom_icc_node qnm_mdp1_1 = {
@@ -669,7 +669,7 @@ static struct qcom_icc_node qnm_mdp1_1 = {
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_mem_noc_hf },
+	.link_nodes = { &qns_mem_noc_hf },
 };
 
 static struct qcom_icc_node qnm_mnoc_hf_cfg = {
@@ -677,7 +677,7 @@ static struct qcom_icc_node qnm_mnoc_hf_cfg = {
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &srvc_mnoc_hf },
+	.link_nodes = { &srvc_mnoc_hf },
 };
 
 static struct qcom_icc_node qnm_mnoc_sf_cfg = {
@@ -685,7 +685,7 @@ static struct qcom_icc_node qnm_mnoc_sf_cfg = {
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &srvc_mnoc_sf },
+	.link_nodes = { &srvc_mnoc_sf },
 };
 
 static struct qcom_icc_node qnm_video0 = {
@@ -693,7 +693,7 @@ static struct qcom_icc_node qnm_video0 = {
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_mem_noc_sf },
+	.link_nodes = { &qns_mem_noc_sf },
 };
 
 static struct qcom_icc_node qnm_video1 = {
@@ -701,7 +701,7 @@ static struct qcom_icc_node qnm_video1 = {
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_mem_noc_sf },
+	.link_nodes = { &qns_mem_noc_sf },
 };
 
 static struct qcom_icc_node qnm_video_cvp = {
@@ -709,7 +709,7 @@ static struct qcom_icc_node qnm_video_cvp = {
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_mem_noc_sf },
+	.link_nodes = { &qns_mem_noc_sf },
 };
 
 static struct qcom_icc_node qnm_video_v_cpu = {
@@ -717,7 +717,7 @@ static struct qcom_icc_node qnm_video_v_cpu = {
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_mem_noc_sf },
+	.link_nodes = { &qns_mem_noc_sf },
 };
 
 static struct qcom_icc_node qhm_nsp_noc_config = {
@@ -725,7 +725,7 @@ static struct qcom_icc_node qhm_nsp_noc_config = {
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &service_nsp_noc },
+	.link_nodes = { &service_nsp_noc },
 };
 
 static struct qcom_icc_node qxm_nsp = {
@@ -733,7 +733,7 @@ static struct qcom_icc_node qxm_nsp = {
 	.channels = 2,
 	.buswidth = 32,
 	.num_links = 2,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_hcp, &qns_nsp_gemnoc },
+	.link_nodes = { &qns_hcp, &qns_nsp_gemnoc },
 };
 
 static struct qcom_icc_node qhm_nspb_noc_config = {
@@ -741,7 +741,7 @@ static struct qcom_icc_node qhm_nspb_noc_config = {
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &service_nspb_noc },
+	.link_nodes = { &service_nspb_noc },
 };
 
 static struct qcom_icc_node qxm_nspb = {
@@ -749,7 +749,7 @@ static struct qcom_icc_node qxm_nspb = {
 	.channels = 2,
 	.buswidth = 32,
 	.num_links = 2,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_nspb_hcp, &qns_nspb_gemnoc },
+	.link_nodes = { &qns_nspb_hcp, &qns_nspb_gemnoc },
 };
 
 static struct qcom_icc_node xm_pcie3_0 = {
@@ -757,7 +757,7 @@ static struct qcom_icc_node xm_pcie3_0 = {
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_pcie_mem_noc },
+	.link_nodes = { &qns_pcie_mem_noc },
 };
 
 static struct qcom_icc_node xm_pcie3_1 = {
@@ -765,7 +765,7 @@ static struct qcom_icc_node xm_pcie3_1 = {
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_pcie_mem_noc },
+	.link_nodes = { &qns_pcie_mem_noc },
 };
 
 static struct qcom_icc_node qhm_gic = {
@@ -773,7 +773,7 @@ static struct qcom_icc_node qhm_gic = {
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_gemnoc_sf },
+	.link_nodes = { &qns_gemnoc_sf },
 };
 
 static struct qcom_icc_node qnm_aggre1_noc = {
@@ -781,7 +781,7 @@ static struct qcom_icc_node qnm_aggre1_noc = {
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_gemnoc_sf },
+	.link_nodes = { &qns_gemnoc_sf },
 };
 
 static struct qcom_icc_node qnm_aggre2_noc = {
@@ -789,7 +789,7 @@ static struct qcom_icc_node qnm_aggre2_noc = {
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_gemnoc_sf },
+	.link_nodes = { &qns_gemnoc_sf },
 };
 
 static struct qcom_icc_node qnm_lpass_noc = {
@@ -797,7 +797,7 @@ static struct qcom_icc_node qnm_lpass_noc = {
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_gemnoc_sf },
+	.link_nodes = { &qns_gemnoc_sf },
 };
 
 static struct qcom_icc_node qnm_snoc_cfg = {
@@ -805,7 +805,7 @@ static struct qcom_icc_node qnm_snoc_cfg = {
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &srvc_snoc },
+	.link_nodes = { &srvc_snoc },
 };
 
 static struct qcom_icc_node qxm_pimem = {
@@ -813,7 +813,7 @@ static struct qcom_icc_node qxm_pimem = {
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_gemnoc_gc },
+	.link_nodes = { &qns_gemnoc_gc },
 };
 
 static struct qcom_icc_node xm_gic = {
@@ -821,7 +821,7 @@ static struct qcom_icc_node xm_gic = {
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qns_gemnoc_gc },
+	.link_nodes = { &qns_gemnoc_gc },
 };
 
 static struct qcom_icc_node qns_a1noc_snoc = {
@@ -829,7 +829,7 @@ static struct qcom_icc_node qns_a1noc_snoc = {
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qnm_aggre1_noc },
+	.link_nodes = { &qnm_aggre1_noc },
 };
 
 static struct qcom_icc_node qns_a2noc_snoc = {
@@ -837,7 +837,7 @@ static struct qcom_icc_node qns_a2noc_snoc = {
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qnm_aggre2_noc },
+	.link_nodes = { &qnm_aggre2_noc },
 };
 
 static struct qcom_icc_node qup0_core_slave = {
@@ -941,7 +941,7 @@ static struct qcom_icc_node qhs_compute0_cfg = {
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qhm_nsp_noc_config },
+	.link_nodes = { &qhm_nsp_noc_config },
 };
 
 static struct qcom_icc_node qhs_compute1_cfg = {
@@ -949,7 +949,7 @@ static struct qcom_icc_node qhs_compute1_cfg = {
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qhm_nspb_noc_config },
+	.link_nodes = { &qhm_nspb_noc_config },
 };
 
 static struct qcom_icc_node qhs_cpr_cx = {
@@ -1089,7 +1089,7 @@ static struct qcom_icc_node qhs_lpass_cfg = {
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qhm_config_noc },
+	.link_nodes = { &qhm_config_noc },
 };
 
 static struct qcom_icc_node qhs_lpass_throttle_cfg = {
@@ -1301,7 +1301,7 @@ static struct qcom_icc_node qns_ddrss_cfg = {
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qnm_cnoc_dc_noc },
+	.link_nodes = { &qnm_cnoc_dc_noc },
 };
 
 static struct qcom_icc_node qns_gpdsp_noc_cfg = {
@@ -1315,7 +1315,7 @@ static struct qcom_icc_node qns_mnoc_hf_cfg = {
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qnm_mnoc_hf_cfg },
+	.link_nodes = { &qnm_mnoc_hf_cfg },
 };
 
 static struct qcom_icc_node qns_mnoc_sf_cfg = {
@@ -1323,7 +1323,7 @@ static struct qcom_icc_node qns_mnoc_sf_cfg = {
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qnm_mnoc_sf_cfg },
+	.link_nodes = { &qnm_mnoc_sf_cfg },
 };
 
 static struct qcom_icc_node qns_pcie_anoc_cfg = {
@@ -1337,7 +1337,7 @@ static struct qcom_icc_node qns_snoc_cfg = {
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qnm_snoc_cfg },
+	.link_nodes = { &qnm_snoc_cfg },
 };
 
 static struct qcom_icc_node qxs_boot_imem = {
@@ -1393,7 +1393,7 @@ static struct qcom_icc_node qns_gemnoc = {
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qnm_gemnoc_cfg },
+	.link_nodes = { &qnm_gemnoc_cfg },
 };
 
 static struct qcom_icc_node qns_gem_noc_cnoc = {
@@ -1401,7 +1401,7 @@ static struct qcom_icc_node qns_gem_noc_cnoc = {
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qnm_gemnoc_cnoc },
+	.link_nodes = { &qnm_gemnoc_cnoc },
 };
 
 static struct qcom_icc_node qns_llcc = {
@@ -1409,7 +1409,7 @@ static struct qcom_icc_node qns_llcc = {
 	.channels = 6,
 	.buswidth = 16,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &llcc_mc },
+	.link_nodes = { &llcc_mc },
 };
 
 static struct qcom_icc_node qns_pcie = {
@@ -1417,7 +1417,7 @@ static struct qcom_icc_node qns_pcie = {
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qnm_gemnoc_pcie },
+	.link_nodes = { &qnm_gemnoc_pcie },
 };
 
 static struct qcom_icc_node srvc_even_gemnoc = {
@@ -1449,7 +1449,7 @@ static struct qcom_icc_node qns_gp_dsp_sail_noc = {
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qnm_gpdsp_sail },
+	.link_nodes = { &qnm_gpdsp_sail },
 };
 
 static struct qcom_icc_node qhs_lpass_core = {
@@ -1481,7 +1481,7 @@ static struct qcom_icc_node qns_sysnoc = {
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qnm_lpass_noc },
+	.link_nodes = { &qnm_lpass_noc },
 };
 
 static struct qcom_icc_node srvc_niu_aml_noc = {
@@ -1507,7 +1507,7 @@ static struct qcom_icc_node qns_mem_noc_hf = {
 	.channels = 2,
 	.buswidth = 32,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qnm_mnoc_hf },
+	.link_nodes = { &qnm_mnoc_hf },
 };
 
 static struct qcom_icc_node qns_mem_noc_sf = {
@@ -1515,7 +1515,7 @@ static struct qcom_icc_node qns_mem_noc_sf = {
 	.channels = 2,
 	.buswidth = 32,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qnm_mnoc_sf },
+	.link_nodes = { &qnm_mnoc_sf },
 };
 
 static struct qcom_icc_node srvc_mnoc_hf = {
@@ -1541,7 +1541,7 @@ static struct qcom_icc_node qns_nsp_gemnoc = {
 	.channels = 2,
 	.buswidth = 32,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qnm_cmpnoc0 },
+	.link_nodes = { &qnm_cmpnoc0 },
 };
 
 static struct qcom_icc_node service_nsp_noc = {
@@ -1555,7 +1555,7 @@ static struct qcom_icc_node qns_nspb_gemnoc = {
 	.channels = 2,
 	.buswidth = 32,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qnm_cmpnoc1 },
+	.link_nodes = { &qnm_cmpnoc1 },
 };
 
 static struct qcom_icc_node qns_nspb_hcp = {
@@ -1575,7 +1575,7 @@ static struct qcom_icc_node qns_pcie_mem_noc = {
 	.channels = 1,
 	.buswidth = 32,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qnm_pcie },
+	.link_nodes = { &qnm_pcie },
 };
 
 static struct qcom_icc_node qns_gemnoc_gc = {
@@ -1583,7 +1583,7 @@ static struct qcom_icc_node qns_gemnoc_gc = {
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qnm_snoc_gc },
+	.link_nodes = { &qnm_snoc_gc },
 };
 
 static struct qcom_icc_node qns_gemnoc_sf = {
@@ -1591,7 +1591,7 @@ static struct qcom_icc_node qns_gemnoc_sf = {
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.link_nodes = (struct qcom_icc_node *[]) { &qnm_snoc_sf },
+	.link_nodes = { &qnm_snoc_sf },
 };
 
 static struct qcom_icc_node srvc_snoc = {

-- 
2.47.3



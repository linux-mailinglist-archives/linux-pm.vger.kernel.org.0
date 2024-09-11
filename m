Return-Path: <linux-pm+bounces-14009-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3F6974EF4
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 11:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EFA41C2239F
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 09:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E583175D26;
	Wed, 11 Sep 2024 09:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="H3cT24HG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D105D224F6;
	Wed, 11 Sep 2024 09:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726047942; cv=none; b=Yv3psSqTYXwUZ6uc8IhOQPlBZpvMwEkzgPmSEspTB+s4pTFPR5C0iBfDWGrkXBydYmmYUROzP0grtOpdZ1gODpdJOqcoPrKVJ1KvOjyhyPpYjH+v1SlBOUqYI5QBJi6ZhHeZu11A5lUPJyrxJvnK9oU7Zzh07Tvvi+fx6ZnOUbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726047942; c=relaxed/simple;
	bh=S849BrBO8OJeXkTN4DppK0IburqI4MHpBS3x5Gnp2DE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qRSsrchiSUhgRapKsviFhph3bOsRRltwi5hJJ38Hru+6edCVITcpK+tHKNE0xsiWL+01Hvi3SUHnA9tAfGAqX/4c2BJC461dlQm4YyD8HXyDa+HDwwfxstt6qN36IBC3kM2kKynH1KosMVQSDOplhRKu4vszZzkw87u2TCBaPuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=H3cT24HG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48B2Nt4e025671;
	Wed, 11 Sep 2024 09:45:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Lq8qsgByX1iptxjgVqYDVa
	tocn3F6fjE/0CuKXWJgF0=; b=H3cT24HGwdfHCSnpiCIqTpC8ErWzV9KtlvGO4T
	x4/xto3X+rve22ouEi05qMlAnnW1RHxzX06/ABwHB7lgcSvS3dJPRDKL3UAsABsR
	DKuVJuVtbIbfa5CgLGZG5dTaT4QH+yLANNRYZtnCUjqSGhhrtYM3I+JcgqEAuM/W
	ar8OBi6lZKrzxcFNAUzmtQue9CsaX5EnFoIZj1R5F+/UU/xmO5FDVHrodGMS5sfh
	PhulPEWwhsO9RTT9edPANKAQ0is4NxY5C7+4sEb3pBjAJXxSIovwd2fG38OIF/GS
	scOjMJJXxhSFOjoT4HaXgIp+CZuhjYVH4HX2QRuaeZBGkCOg==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41gy7315nm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Sep 2024 09:45:37 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48B9jZS0024530
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Sep 2024 09:45:36 GMT
Received: from 13375c2f25f8.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 11 Sep 2024 02:45:32 -0700
From: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
To: Georgi Djakov <djakov@kernel.org>
CC: Konrad Dybcio <konradybcio@kernel.org>,
        Odelu Kukatla
	<quic_okukatla@quicinc.com>,
        Jeff Johnson <quic_jjohnson@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Mike Tipton <quic_mdtipton@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>
Subject: [PATCH V2] interconnect: qcom: icc-rpmh: probe defer incase of missing QoS clock dependency
Date: Wed, 11 Sep 2024 09:45:16 +0000
Message-ID: <20240911094516.16901-1-quic_rlaggysh@quicinc.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: wytHDVEJ2DbfqYqnCBI0_D1GpWI_mmu1
X-Proofpoint-GUID: wytHDVEJ2DbfqYqnCBI0_D1GpWI_mmu1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 priorityscore=1501 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2408220000 definitions=main-2409110074

Return -EPROBE_DEFER from interconnect provider incase probe defer is
received from devm_clk_bulk_get_all(). This would help in reattempting
the inteconnect driver probe, once the required QoS clocks are
available.

Suggested-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
---
Changes in v2:
 - Removed the qos_clk_required rename change and posted it as separate
   patch.
 - As suggested, dev_err_probe is used for reporting the probe defer
   error message.
---
 drivers/interconnect/qcom/icc-rpmh.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/interconnect/qcom/icc-rpmh.c b/drivers/interconnect/qcom/icc-rpmh.c
index f49a8e0cb03c..adacd6f7d6a8 100644
--- a/drivers/interconnect/qcom/icc-rpmh.c
+++ b/drivers/interconnect/qcom/icc-rpmh.c
@@ -311,6 +311,9 @@ int qcom_icc_rpmh_probe(struct platform_device *pdev)
 		}
 
 		qp->num_clks = devm_clk_bulk_get_all(qp->dev, &qp->clks);
+		if (qp->num_clks == -EPROBE_DEFER)
+			return dev_err_probe(dev, qp->num_clks, "Failed to get QoS clocks\n");
+
 		if (qp->num_clks < 0 || (!qp->num_clks && desc->qos_clks_required)) {
 			dev_info(dev, "Skipping QoS, failed to get clk: %d\n", qp->num_clks);
 			goto skip_qos_config;
-- 
2.39.2



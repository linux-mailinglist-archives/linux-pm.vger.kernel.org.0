Return-Path: <linux-pm+bounces-18806-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F1A9E907A
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 11:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC682163F74
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 10:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0F021A95F;
	Mon,  9 Dec 2024 10:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="peS8DkjS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227A1218820;
	Mon,  9 Dec 2024 10:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733740544; cv=none; b=bZhjS7qvmaP6TayzlNxq4hqtmiUHnU0Snw5J+u5B0+Z/kt8MBmPhwiVgdHSQNNGK6DB9WTFKzTtGmr9fE56eqfXdnumu7aQKP50zZD7GsXF03OPv3lv3Fg9DT2ctmKzvJMzIFsRQUiG6O2mOZUXA3QogDEd5IOYIxpWwSNcUxjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733740544; c=relaxed/simple;
	bh=Lk2uD8no3UHqssuAhfJetDYSCALIKGgQQlPBMQzcuMA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qY8E+kqZF+RtdbBya2Fa3Vzv/FhhDSnxgdjJ3qEBTu5ctR5uXPawWKroTQUKhemGu/DNvdgiIEHrEZEtV48P8aIk5yPJLmnxeoqaWpk3JiEGR8aAvQ4DGFZcDRZRE4hoGa+nD7pbHmTs/c4CfN3XhgDfyes4LwtyRPHYArHtMxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=peS8DkjS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B90QGQO020262;
	Mon, 9 Dec 2024 10:35:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=NgQwRfb+GL0pGvjhcqxoIpdM
	HZFa68KLchTCxTmtGqI=; b=peS8DkjS327A6wkq4ptwW7Uypojq/d9un3x8+6AQ
	mXjE0GDy/NfrdCSib4xHbKH/4upNdB8B6Yd8BFsJ6uDOe6HmB87cSBxZ9VWKnq6s
	vy+SxuHQEGur1maxXu5zKUrlpSVXvWkFKIKNmu+3lB96qR6HqPoAv7ybav2cxDx3
	FrKSr7KHC+m6QHHLKsAodD/LwRxrUgY3MRFuwaxdj5kIgn5n5LpxTn7VnSepgK3q
	Pm1Gu3jFmlqRn+7M8F8cPJbYv0BPrq1VY3vu9QPvHazaJbp2NSaW4JZQhwn6el/K
	Czt5ZFJnY0yuMyH4dKNU4wkpKtZiVCLMRwIwWjGeeXbSFg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43cc2ecg7p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 10:35:36 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B9AZZYP009222
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 9 Dec 2024 10:35:35 GMT
Received: from hu-janathot-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 9 Dec 2024 02:35:29 -0800
From: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Konrad Dybcio" <konradybcio@kernel.org>,
        Marcel Holtmann
	<marcel@holtmann.org>,
        "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
CC: <quic_mohamull@quicinc.com>, <quic_hbandi@quicinc.com>,
        <quic_anubhavg@quicinc.com>,
        Bartosz Golaszewski
	<bartosz.golaszewski@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-bluetooth@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
Subject: [PATCH v5 3/4] Bluetooth: hci_qca: use the power sequencer for wcn6750
Date: Mon, 9 Dec 2024 16:04:54 +0530
Message-ID: <20241209103455.9675-4-quic_janathot@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241209103455.9675-1-quic_janathot@quicinc.com>
References: <20241209103455.9675-1-quic_janathot@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 8rGDPpxN3qVMjWznwMg-J5nfpMk5JIna
X-Proofpoint-GUID: 8rGDPpxN3qVMjWznwMg-J5nfpMk5JIna
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 mlxlogscore=999 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 clxscore=1015 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412090082

Older boards are having entry "enable-gpios" in dts, we can safely assume
latest boards which are supporting PMU node enrty will support power
sequencer.

Signed-off-by: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
---
 drivers/bluetooth/hci_qca.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 37129e6cb0eb..fbf8840fa534 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2346,6 +2346,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 	switch (qcadev->btsoc_type) {
 	case QCA_WCN6855:
 	case QCA_WCN7850:
+	case QCA_WCN6750:
 		if (!device_property_present(&serdev->dev, "enable-gpios")) {
 			/*
 			 * Backward compatibility with old DT sources. If the
@@ -2365,7 +2366,6 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 	case QCA_WCN3990:
 	case QCA_WCN3991:
 	case QCA_WCN3998:
-	case QCA_WCN6750:
 		qcadev->bt_power->dev = &serdev->dev;
 		err = qca_init_regulators(qcadev->bt_power, data->vregs,
 					  data->num_vregs);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project



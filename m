Return-Path: <linux-pm+bounces-15239-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 197CF99241F
	for <lists+linux-pm@lfdr.de>; Mon,  7 Oct 2024 08:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5DE7B2223D
	for <lists+linux-pm@lfdr.de>; Mon,  7 Oct 2024 06:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF4814387B;
	Mon,  7 Oct 2024 06:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="T5xH0Ys5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A862744D;
	Mon,  7 Oct 2024 06:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728281265; cv=none; b=d8a2o28xNgGzqwm2s6GS/8YwI1JG4uSAkh6IkpjzJP30npOnKx1z9pwSdFZm9AIA85h5WDuJHCACQYy8brNVOUIUufC5cI7aTya6LHRxGgsyhZOMHbVeerfAHngC6TmXcqG4Yzjc0e/pBn+FndOCeByetLDNwziPTwukn4Dotek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728281265; c=relaxed/simple;
	bh=aj3zl6u1lYeqGFapGSXt75jXRIhJSuMiKfjwnzRr2rE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cn4V2+X7aqJutXaS3UROHr6ZMafuBm7aVh7Xu1kP8pjsb4gT0jrst4RR5oKPJDV2YnXf2vCIoo3VlCXRzjyzRN/iYtWdRrIrNdRprls1TomGsRzutC8+fxn/n8B+77smkKkXEz290SoT60Z4hLcCLzhrcvcvrOGb5P+gh31KQ6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=T5xH0Ys5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4974SpjU019630;
	Mon, 7 Oct 2024 06:07:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zLRoZk49uyxVabf73yH4iupFA8mWSHmk562C4qtbTUY=; b=T5xH0Ys5LVkJYatq
	BQfD13fd7l75zTn7VLFKeqE+0li4suYiRxQ1c8z/L3OAi1JbXCqE7r5WjvayIa3x
	qmXDx8uGLbFD8YavLSkuhDf4QhP0tXD+eEyPOzG0KKeCMRk9ZJ9di+7PDdytGQdk
	DZwMcbLa7swtj+DQQXmKxpgyoHI+/k5Q94QPIoriaB/lHziw9ZjqrIjbTGr2MqsS
	qXZVxdVsSuBdOwLlbGoNGBQiipm+xKg13y/sTn8DFDnqX4iVAVK86XAQLsWDRQUN
	Zr6B+eldhiktlIRB/2hNJiBgKpZiAU+ZUeb8d6F2GTOmKD57gRmMGdSsdhF4/GS/
	PjY+rg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 422xsnk5d1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Oct 2024 06:07:26 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49767PjI011814
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 7 Oct 2024 06:07:25 GMT
Received: from hu-sibis-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 6 Oct 2024 23:07:20 -0700
From: Sibi Sankar <quic_sibis@quicinc.com>
To: <sudeep.holla@arm.com>, <cristian.marussi@arm.com>,
        <ulf.hansson@linaro.org>, <jassisinghbrar@gmail.com>
CC: <linux-kernel@vger.kernel.org>, <arm-scmi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <quic_sibis@quicinc.com>,
        <johan@kernel.org>, <konradybcio@kernel.org>,
        <linux-pm@vger.kernel.org>, <tstrudel@google.com>, <rafael@kernel.org>,
        "Johan Hovold" <johan+linaro@kernel.org>
Subject: [PATCH V3 1/4] firmware: arm_scmi: Ensure that the message-id supports fastchannel
Date: Mon, 7 Oct 2024 11:36:39 +0530
Message-ID: <20241007060642.1978049-2-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241007060642.1978049-1-quic_sibis@quicinc.com>
References: <20241007060642.1978049-1-quic_sibis@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: q3SpSnhWDpKl4HwBdXV4GEis20IQxwua
X-Proofpoint-ORIG-GUID: q3SpSnhWDpKl4HwBdXV4GEis20IQxwua
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 impostorscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 mlxlogscore=999 clxscore=1011 malwarescore=0 priorityscore=1501 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410070041

Currently the perf and powercap protocol relies on the protocol domain
attributes, which just ensures that one fastchannel per domain, before
instantiating fastchannels for all possible message-ids. Fix this by
ensuring that each message-id supports fastchannel before initialization.

Reported-by: Johan Hovold <johan+linaro@kernel.org>
Closes: https://lore.kernel.org/lkml/ZoQjAWse2YxwyRJv@hovoldconsulting.com/
Fixes: 6f9ea4dabd2d ("firmware: arm_scmi: Generalize the fast channel support")
Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---
 drivers/firmware/arm_scmi/driver.c    | 9 +++++++++
 drivers/firmware/arm_scmi/protocols.h | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 88c5c4ff4bb6..80a9a615672a 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -56,6 +56,9 @@ static atomic_t transfer_last_id;
 
 static struct dentry *scmi_top_dentry;
 
+static int scmi_protocol_msg_check(const struct scmi_protocol_handle *ph,
+				   u32 message_id, u32 *attributes);
+
 /**
  * struct scmi_xfers_info - Structure to manage transfer information
  *
@@ -1841,6 +1844,7 @@ scmi_common_fastchannel_init(const struct scmi_protocol_handle *ph,
 	int ret;
 	u32 flags;
 	u64 phys_addr;
+	u32 attributes;
 	u8 size;
 	void __iomem *addr;
 	struct scmi_xfer *t;
@@ -1849,6 +1853,11 @@ scmi_common_fastchannel_init(const struct scmi_protocol_handle *ph,
 	struct scmi_msg_resp_desc_fc *resp;
 	const struct scmi_protocol_instance *pi = ph_to_pi(ph);
 
+	/* Check if the MSG_ID supports fastchannel */
+	ret = scmi_protocol_msg_check(ph, message_id, &attributes);
+	if (!ret && !MSG_SUPPORTS_FASTCHANNEL(attributes))
+		return;
+
 	if (!p_addr) {
 		ret = -EINVAL;
 		goto err_out;
diff --git a/drivers/firmware/arm_scmi/protocols.h b/drivers/firmware/arm_scmi/protocols.h
index aaee57cdcd55..d62c4469d1fd 100644
--- a/drivers/firmware/arm_scmi/protocols.h
+++ b/drivers/firmware/arm_scmi/protocols.h
@@ -31,6 +31,8 @@
 
 #define SCMI_PROTOCOL_VENDOR_BASE	0x80
 
+#define MSG_SUPPORTS_FASTCHANNEL(x)	((x) & BIT(0))
+
 enum scmi_common_cmd {
 	PROTOCOL_VERSION = 0x0,
 	PROTOCOL_ATTRIBUTES = 0x1,
-- 
2.34.1



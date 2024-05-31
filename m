Return-Path: <linux-pm+bounces-8462-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 896558D60F1
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2024 13:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAB671C23DE1
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2024 11:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143CB15749F;
	Fri, 31 May 2024 11:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FGIKqhsU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E365156967;
	Fri, 31 May 2024 11:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717155745; cv=none; b=QbeoYA8EQjGewXQ/53KNvzrLAYysfjH9/2eliHPjrUJd5CSIsuK+kvMFCgAee2zM4rk9x6xMcXyiAl+4IunQnYFe9QrHhpvrNmybnNTeiKiAABAvTPKGl+aROAohk0/wCriMN8qVgABA09OXunUeLJv0xZCPai0jmzCjhLnMfp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717155745; c=relaxed/simple;
	bh=9UU6LBz5TtskQfhXxTT43Xo2kFoRuPEY198DyhkM65g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=S+p5Hq9NAuRobSm2pp8F36vYxScgcD3b3dLIcLQEAszhJZhbGVa7aiBywgSzx/iN6vhXsKDsquP5ZepHpO8BSKXxWdm7VQR/SuvmDHz0oagB9ar/tg1hv3mC+rHnEk/acdbTSffxyamYA45TTixDHGqZYNufQj2aqReEHy1kYLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FGIKqhsU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44V62aCg031687;
	Fri, 31 May 2024 11:42:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=Gpd5wWL3hFvOTHXGuKxGYaxOTBl4t1JBR6z4skl+jms=; b=FG
	IKqhsUrv9OsLfI0p5sj0muKoObqVvlmt02FTQAmFlNY02RHXh6uyySrdWmzX0RJL
	gA7KRW8Td2zw+id0IT3G7k33sTYdrVQFE6Hh27LCJkPmpAkjHP0l6YzvPQvFYZcb
	Y63ewW3UlyZzirfl5lGe/ISPrnjcFVIaa8cLC6wU8fhmgTvngqkpMMjmKE2sxjAM
	mXAYiPjyqAMZgkP0bzgIx4auqClcnZGsF0MtOq1NIpqQSpbZof7W6oJbukqrYDHI
	aBhfHDRf+PKWPzFfNl/s77SK/77GGfvXFXrEmWYzta5izrlqsbVEQzJf25YpCoL4
	K4t8BcbpU+Gpp+U7VZBw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yf8xa0rck-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 11:42:07 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44VBg4SS025833
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 11:42:04 GMT
Received: from hu-tdas-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 31 May 2024 04:42:00 -0700
From: Taniya Das <quic_tdas@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>, Ulf Hansson
	<ulf.hansson@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <quic_jkona@quicinc.com>, <quic_imrashai@quicinc.com>,
        Taniya Das
	<quic_tdas@quicinc.com>
Subject: [PATCH] pmdomain: qcom: rpmhpd: Skip retention level for Power Domains
Date: Fri, 31 May 2024 17:11:48 +0530
Message-ID: <20240531114148.8550-1-quic_tdas@quicinc.com>
X-Mailer: git-send-email 2.17.1
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
X-Proofpoint-GUID: ZhQXm1LzWs26m_XjhkqE2_3agSGgRpoX
X-Proofpoint-ORIG-GUID: ZhQXm1LzWs26m_XjhkqE2_3agSGgRpoX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-31_08,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 impostorscore=0 clxscore=1011 lowpriorityscore=0 adultscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405310087

In the cases where the power domain connected to logics is allowed to
transition from a level(L)-->power collapse(0)-->retention(1) or
vice versa retention(1)-->power collapse(0)-->level(L)  will cause the
logic to lose the configurations. The ARC does not support retention
to collapse transition on MxC rails.

The targets from SM8450 onwards the PLL logics of clock controllers are
connected to MxC rails and the recommended configurations are carried
out during the clock controller probes. The MxC transition as mentioned
above should be skipped to ensure the PLL settings are intact across
clock controller power on & off.

On older generation of targets which supports only Mx the logic is never
collapsed and it is parked always at RETENTION, thus this issue is never
observed on those targets.

Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
---
 drivers/pmdomain/qcom/rpmhpd.c | 7 +++++++
 1 file changed, 7 insertions(+)
---
 drivers/pmdomain/qcom/rpmhpd.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pmdomain/qcom/rpmhpd.c b/drivers/pmdomain/qcom/rpmhpd.c
index de9121ef4216..d2cb4271a1ca 100644
--- a/drivers/pmdomain/qcom/rpmhpd.c
+++ b/drivers/pmdomain/qcom/rpmhpd.c
@@ -40,6 +40,7 @@
  * @addr:		Resource address as looped up using resource name from
  *			cmd-db
  * @state_synced:	Indicator that sync_state has been invoked for the rpmhpd resource
+ * @skip_retention_level: Indicate that retention level should not be used for the power domain
  */
 struct rpmhpd {
 	struct device	*dev;
@@ -56,6 +57,7 @@ struct rpmhpd {
 	const char	*res_name;
 	u32		addr;
 	bool		state_synced;
+	bool            skip_retention_level;
 };
 
 struct rpmhpd_desc {
@@ -173,6 +175,7 @@ static struct rpmhpd mxc = {
 	.pd = { .name = "mxc", },
 	.peer = &mxc_ao,
 	.res_name = "mxc.lvl",
+	.skip_retention_level = true,
 };
 
 static struct rpmhpd mxc_ao = {
@@ -180,6 +183,7 @@ static struct rpmhpd mxc_ao = {
 	.active_only = true,
 	.peer = &mxc,
 	.res_name = "mxc.lvl",
+	.skip_retention_level = true,
 };
 
 static struct rpmhpd nsp = {
@@ -819,6 +823,9 @@ static int rpmhpd_update_level_mapping(struct rpmhpd *rpmhpd)
 		return -EINVAL;
 
 	for (i = 0; i < rpmhpd->level_count; i++) {
+		if (rpmhpd->skip_retention_level && buf[i] == RPMH_REGULATOR_LEVEL_RETENTION)
+			continue;
+
 		rpmhpd->level[i] = buf[i];
 
 		/* Remember the first corner with non-zero level */
-- 
2.17.1



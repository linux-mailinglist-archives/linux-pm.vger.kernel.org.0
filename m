Return-Path: <linux-pm+bounces-9925-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF9C2915DA2
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2024 06:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD958B21015
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2024 04:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9539F13BAE4;
	Tue, 25 Jun 2024 04:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gr2RsUlT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E755421A0C;
	Tue, 25 Jun 2024 04:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719290010; cv=none; b=bV0qMP/8yGPXGKFJB0VaQAidoTO8+ve33Fcd+JzrT3jp7AW+X86w3ZnIHsD/TJHOpHy0Fo/imcfUCEiQqim25A0Ri+AMb3h27cOK7zdrWtO7paxP1fETqLGeRPuQby+I5tNnVseXCy7z3ejig/Kz/YrptbETjkq+Iooq7uGa0Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719290010; c=relaxed/simple;
	bh=ebjOht0y72+MXd4MAl1Qqj8PL3xwjNmflZ1aCQOD49w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=apNXPBmH5ucDhuPdfPHdYU/0eaq3hxsofymd8wQggNytBjJu5wZzHaXxvThB9mvZEwPZy5H4Y/1y/pwowzhAmIwDqCSHEp26Qla65JEXi5/6gVDcWARKwIQCFyxSy+RtW8shVkQwpcjTJOxZCVdjCFKlviScDP7+UjvU95Bc+bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gr2RsUlT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45OK1GPK014014;
	Tue, 25 Jun 2024 04:33:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=de8NdmI+UAnhaZkRTI4vgS
	GgY3+j55GxwWNIUjBdzWI=; b=gr2RsUlTmuVOiWuG84ikM/lS+GnTwrPfKTDDyQ
	WNk4DsaVVTSfVmTV4jKgBYQnNydx9xmru9aTb1b05zWWTg5EdNDofq8fjE7hhhq0
	H29/ySSfyQhXAgsK0Zpw3/W8QVAuXpT7ogOrMI4TVqSMbejOZ4Q//Gl+1krjoCMs
	PNvuWlpIOf7qDd03P3K5iQ6OCPCn5+pLRUM0TuhbWuGQgyi1D32/Nz1WNXlb3bN/
	53kbZ/9+WQGFSlABHzZC9GEGFvUNol/WsClrtA6tDss9tfHYgRYwDho+ZRbkDy4t
	0keBXQQAEj4UGFdn0pzDBgz7sQt3E0E7TUngymGM/ZgrNxUA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywnxgwavy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 04:33:24 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45P4XN0o010354
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 04:33:23 GMT
Received: from hu-tdas-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 24 Jun 2024 21:33:19 -0700
From: Taniya Das <quic_tdas@quicinc.com>
Date: Tue, 25 Jun 2024 10:03:11 +0530
Subject: [PATCH v2] pmdomain: qcom: rpmhpd: Skip retention level for Power
 Domains
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240625-avoid_mxc_retention-v2-1-af9c2f549a5f@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAIZIemYC/0WMQQ6CMBBFr0JmbUmnUgRX3sMYUttBZkGrbSUkh
 Ltb3bj7L/nvbZAoMiU4VxtEWjhx8AXUoQI7Gf8gwa4wKKka2SotzBLYDfNqh0iZfC5/cZe9Nqc
 WXd8hFPMZaeT1V73eCo8xzCJPkcy/pY+I2GDT1Z3WUqB4vdkO2Zl0+S72trZhhn3/AFM8YhqjA
 AAA
To: Bjorn Andersson <andersson@kernel.org>,
        Ulf Hansson
	<ulf.hansson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Andy
 Gross" <agross@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_jkona@quicinc.com>,
        <quic_imrashai@quicinc.com>, Taniya Das <quic_tdas@quicinc.com>,
        <stable@vger.kernel.org>
X-Mailer: b4 0.14-dev-f7c49
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: sWfFej0VuIXYZnYtPg_0cdcimAAS3uRY
X-Proofpoint-ORIG-GUID: sWfFej0VuIXYZnYtPg_0cdcimAAS3uRY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_01,2024-06-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1011
 suspectscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 mlxscore=0
 malwarescore=0 priorityscore=1501 mlxlogscore=999 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406250030

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

On older targets that do not split MX into MxA and MxC does not collapse
the logic and it is parked always at RETENTION, thus this issue is never
observed on those targets.

Cc: stable@vger.kernel.org # v5.17
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
---
[Changes in v2]: Incorporate the comments in the commit text.
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

---
base-commit: 62c97045b8f720c2eac807a5f38e26c9ed512371
change-id: 20240625-avoid_mxc_retention-b095a761d981

Best regards,
-- 
Taniya Das <quic_tdas@quicinc.com>



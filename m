Return-Path: <linux-pm+bounces-9851-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6CE914163
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 06:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FA781C21D8A
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 04:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E213381A4;
	Mon, 24 Jun 2024 04:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IiDiCk7d"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0387821A0C;
	Mon, 24 Jun 2024 04:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719204605; cv=none; b=eN1dFWjyVP4J8MgftebBfo1yODkcMp69GTbIQ6lqggCt/YOR0+OzG669Bvxz+Xbt9TeurAGRiN5lBFgD7tuSV+8zwVxdhG9HK/bDVSGQ0mTV+IJ3U2MqKu1GbLZdx9SoAe8ut994qoyGeO/MOitUE3ri89M5/ufXdAlPZ7yDdBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719204605; c=relaxed/simple;
	bh=OPhQa3WgRkEpU3fRsn+zCTILUYnHvf55NcBDwGPkr8s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j7TsXCCGbSBlczOD5o8o49HvEiy/vERCQDVeIx5KyJY+vRQ8TDw67ztwJSpnvRstd70B+YfmM6typ4d7SyAUCVQuiTKCuPgYm7kTYor71RDp5LCkGKBOb0HJfNxTd2n53IByMCJCUHpQNm5PpKvH6e0MbiGMdwVsUr9A7ShGDEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IiDiCk7d; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45NMG5ug003475;
	Mon, 24 Jun 2024 04:49:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HA4jyZ+vOAnRvXanedqbEuSrc9gnQ3keQaej/Y3K9Hs=; b=IiDiCk7dyOHrr241
	0KH7DzXWBkkGAHxZTn2AwHj99nY6DPgpWmpcgehkAA504jk6e10ot6gidHWUg+Vc
	/6L7Hk+18XRXzb5Y2qadjYo1eGrErzan7J9HcfwsM8N1zAD2M8mW5YodgfDLBXoD
	QnfW+BjDfTq1QcHgN4IKYvtnJVaSXBCRcV+2sjqEHLbXa0laWxdjNJawjz6JOj2Q
	lJ0x9GGS37c0ZQGVAIKfwufbwdUI6Y9AeMUJOaaP5ltnO782CzkqCoTOC19lt5zq
	RcRXLdN1eHJ92RSmYPmNrZpF8sY0cQ81altD/befEKzNOpZuu2tE8xtExLs7S9oZ
	y2wYIg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywp6yjmnk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 04:49:55 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45O4nrmk025171
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 04:49:53 GMT
Received: from hu-jkona-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 23 Jun 2024 21:49:46 -0700
From: Jagadeesh Kona <quic_jkona@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette
	<mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Stanimir Varbanov
	<stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mauro Carvalho Chehab
	<mchehab@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J .
 Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>, Pavel Machek
	<pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Andy
 Gross" <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
        "Jagadeesh Kona" <quic_jkona@quicinc.com>,
        Satya Priya Kakitapalli
	<quic_skakitap@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        "Ajit
 Pandey" <quic_ajipan@quicinc.com>
Subject: [PATCH V7 5/5] venus: pm_helpers: Use dev_pm_genpd_set_hwmode to switch GDSC mode on V6
Date: Mon, 24 Jun 2024 10:18:09 +0530
Message-ID: <20240624044809.17751-6-quic_jkona@quicinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240624044809.17751-1-quic_jkona@quicinc.com>
References: <20240624044809.17751-1-quic_jkona@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 46U0q67XFjPitDCCHoe72fNSZrZIP85o
X-Proofpoint-ORIG-GUID: 46U0q67XFjPitDCCHoe72fNSZrZIP85o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_04,2024-06-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 bulkscore=0
 phishscore=0 adultscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406240036

The Venus driver requires vcodec GDSC to be ON in SW mode for clock
operations and move it back to HW mode to gain power benefits. Earlier,
as there is no interface to switch the GDSC mode from GenPD framework,
the GDSC is moved to HW control mode as part of GDSC enable callback and
venus driver is writing to its POWER_CONTROL register to keep the GDSC ON
from SW whereever required. But the POWER_CONTROL register addresses
are not constant and can vary across the variants.

Also as per the HW recommendation, the GDSC mode switching needs to be
controlled from respective GDSC register and this is a uniform approach
across all the targets. Hence use dev_pm_genpd_set_hwmode() API which
controls GDSC mode switching using its respective GDSC register.

In venus V6 variants, the vcodec gdsc gets enabled in SW mode by default
with new HW_CTRL_TRIGGER flag and there is no need to switch it to SW
mode again after enable, hence add check to avoid switching gdsc to SW mode
again after gdsc enable. Similarly add check to avoid switching GDSC to HW
mode before disabling the GDSC, so GDSC gets enabled in SW mode in the next
enable.

Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Tested-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Reviewed-by: Taniya Das <quic_tdas@quicinc.com>
---
 .../media/platform/qcom/venus/pm_helpers.c    | 39 +++++++++++--------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/drivers/media/platform/qcom/venus/pm_helpers.c
index 502822059498..4ce76ce6dd4d 100644
--- a/drivers/media/platform/qcom/venus/pm_helpers.c
+++ b/drivers/media/platform/qcom/venus/pm_helpers.c
@@ -412,10 +412,9 @@ static int vcodec_control_v4(struct venus_core *core, u32 coreid, bool enable)
 	u32 val;
 	int ret;
 
-	if (IS_V6(core)) {
-		ctrl = core->wrapper_base + WRAPPER_CORE_POWER_CONTROL_V6;
-		stat = core->wrapper_base + WRAPPER_CORE_POWER_STATUS_V6;
-	} else if (coreid == VIDC_CORE_ID_1) {
+	if (IS_V6(core))
+		return dev_pm_genpd_set_hwmode(core->pmdomains->pd_devs[coreid], !enable);
+	else if (coreid == VIDC_CORE_ID_1) {
 		ctrl = core->wrapper_base + WRAPPER_VCODEC0_MMCC_POWER_CONTROL;
 		stat = core->wrapper_base + WRAPPER_VCODEC0_MMCC_POWER_STATUS;
 	} else {
@@ -451,9 +450,11 @@ static int poweroff_coreid(struct venus_core *core, unsigned int coreid_mask)
 
 		vcodec_clks_disable(core, core->vcodec0_clks);
 
-		ret = vcodec_control_v4(core, VIDC_CORE_ID_1, false);
-		if (ret)
-			return ret;
+		if (!IS_V6(core)) {
+			ret = vcodec_control_v4(core, VIDC_CORE_ID_1, false);
+			if (ret)
+				return ret;
+		}
 
 		ret = pm_runtime_put_sync(core->pmdomains->pd_devs[1]);
 		if (ret < 0)
@@ -467,9 +468,11 @@ static int poweroff_coreid(struct venus_core *core, unsigned int coreid_mask)
 
 		vcodec_clks_disable(core, core->vcodec1_clks);
 
-		ret = vcodec_control_v4(core, VIDC_CORE_ID_2, false);
-		if (ret)
-			return ret;
+		if (!IS_V6(core)) {
+			ret = vcodec_control_v4(core, VIDC_CORE_ID_2, false);
+			if (ret)
+				return ret;
+		}
 
 		ret = pm_runtime_put_sync(core->pmdomains->pd_devs[2]);
 		if (ret < 0)
@@ -488,9 +491,11 @@ static int poweron_coreid(struct venus_core *core, unsigned int coreid_mask)
 		if (ret < 0)
 			return ret;
 
-		ret = vcodec_control_v4(core, VIDC_CORE_ID_1, true);
-		if (ret)
-			return ret;
+		if (!IS_V6(core)) {
+			ret = vcodec_control_v4(core, VIDC_CORE_ID_1, true);
+			if (ret)
+				return ret;
+		}
 
 		ret = vcodec_clks_enable(core, core->vcodec0_clks);
 		if (ret)
@@ -506,9 +511,11 @@ static int poweron_coreid(struct venus_core *core, unsigned int coreid_mask)
 		if (ret < 0)
 			return ret;
 
-		ret = vcodec_control_v4(core, VIDC_CORE_ID_2, true);
-		if (ret)
-			return ret;
+		if (!IS_V6(core)) {
+			ret = vcodec_control_v4(core, VIDC_CORE_ID_2, true);
+			if (ret)
+				return ret;
+		}
 
 		ret = vcodec_clks_enable(core, core->vcodec1_clks);
 		if (ret)
-- 
2.43.0



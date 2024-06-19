Return-Path: <linux-pm+bounces-9589-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5E590EFE5
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 16:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A788BB20C9C
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 14:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C75F45033;
	Wed, 19 Jun 2024 14:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="k0vcEqpV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACA014F9F1;
	Wed, 19 Jun 2024 14:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718806503; cv=none; b=R/3hYP0o0mvbeKR2c20MmVr2BarIGGU6cygafFA169/Jqm/v+rcnscwT2di/5SXyDbZnw3zlh4+aYC8wEGhdNK5zxXlJkEgSuCHWPEIO6k6r4NoLkC7a13k1fnuFvXBgEUzVIa/DT26z3wphwfTOD+Zt+yaDIGfkRHVmLNvGxlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718806503; c=relaxed/simple;
	bh=o9WGLkoWQpIUSTg5wDZ0p/U4FrhMY6Lo9WunXU4/juU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gbYD9vd2e75RyL5U+7/c5mE3QaQRWC27oNlc/dMsL6EcF56SFI0ATL7u/q6a373R7/8ez3i8V88VxjP2DqvZIRjPFVqFxcNNjEjT5y12QbbG1mKMVP0lyH+R/POmC8zltZ0lndgqQwcD8CGAUobIoKcisZJorqWrJTZEE5W5vyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=k0vcEqpV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45J9ldvB007546;
	Wed, 19 Jun 2024 14:14:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=7xaCSLx4kLuRx6dHM1H2af
	rH2o9PCQLGNrfD8OemfZ4=; b=k0vcEqpVNALkn0q7ApQUnIq+v4AJE1Mr21qxvR
	Tzjs+2FwB89R4XY1W4e0yqlf9FghmSOAUJah9zgG3lpzoIqSYjwfs1WV6bAXwBHN
	LnlQJktJpd8+quyT8ObTy3k87e0A0059T3mIEYr7A3Fz6cuzfSXfPI5nVo/LebUE
	g5Nw96lkq6dDTpRZR0LVPffPKYAgxUpclJ5tcoxPiNzZkfDMGZSlKJtHYUipg87/
	ws99NGr8DJmlUraSpzdOW/z84o/2G9TY6+fH/zGT2rCNmhjZqwQ0aBVQr9bII35w
	Y5AcvqPGA7gh/Qeo8UoScBVefAwt7xmxmp6yJ7vCe7zJqgUw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yuja79wfp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 14:14:51 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45JEEngT014078
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 14:14:49 GMT
Received: from hu-jkona-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 19 Jun 2024 07:14:42 -0700
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
Subject: [PATCH V6 0/5] Add control for switching back and forth to HW control
Date: Wed, 19 Jun 2024 19:44:08 +0530
Message-ID: <20240619141413.7983-1-quic_jkona@quicinc.com>
X-Mailer: git-send-email 2.43.0
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
X-Proofpoint-ORIG-GUID: DxNLJOab-R-IT30z5wp6fqSuiGGjsweS
X-Proofpoint-GUID: DxNLJOab-R-IT30z5wp6fqSuiGGjsweS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-19_02,2024-06-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 phishscore=0 bulkscore=0 suspectscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406190106

This series adds support for dev_pm_genpd_set_hwmode() and dev_pm_genpd_get_hwmode() APIs
and support in gdsc provider drivers to register respective callbacks and venus consumer
driver example using above API to switch the power domain(GDSC) to HW/SW modes dynamically
at runtime.

Changes in V6:
- [PATCH 3/5]: Added details for 1usec delay in gdsc_set_hwmode()
- [PATCH 4/5]: Updated commit text
- Added R-By and T-By tags received on V5 RESEND
- Link to V5 RESEND: https://lore.kernel.org/all/20240413152013.22307-1-quic_jkona@quicinc.com/
- Link to V5: https://lore.kernel.org/all/20240315111046.22136-1-quic_jkona@quicinc.com/

Changes in V5:
- Updated 1st patch as per V4 review comments to synchronize the initial HW mode state by
  invoking ->get_hwmode_dev()callback in genpd_add_device()
- With above change, SW cached hwmode will contain correct value initially, and it will be
  updated everytime mode is changed in set_hwmode, hence updated dev_pm_genpd_get_hwmode()
  to just return SW cached hwmode in 1st patch
- Updated commit text for 1st, 3rd, 4th and 5th patches
- Updated 3rd and 5th patches as per review comments received on V4 series
- Added R-By tags received in older series to 1st and 2nd patches
- Link to V4: https://lore.kernel.org/all/20240122-gdsc-hwctrl-v4-0-9061e8a7aa07@linaro.org/

Changes in V4:
 - Re-worded 1st patch commit message, as per Bjorn's suggestion, and added
   Dmitry's R-b tag
 - Added Bjorn's and Dmitry's R-b tags to the 2nd patch
 - Re-worded 3rd patch commit message, to better explain the HW_CTRL_TRIGGER flag.
 - Added mode transition delay when setting mode for GDSC
 - Added status polling if GDSSC is enabled when transitioning from HW to SW
 - Re-worded 4th patch commit message to better explain why the
   HW_CTRL_TRIGGER needs to be used instead
 - Drop changes to SC7180, SDM845 and SM8550 video CC drivers, as only
   SC7280 and SM8250 have been tested so far. More platforms (with v6 venus)
   will be added eventually.
 - Call genpd set_hwmode API only for v6 and dropped the vcodec_pmdomains_hwctrl.
 - Re-worded 5th patch commit message accordingly. 
 - Link to V3: https://lore.kernel.org/lkml/20230823114528.3677667-1-abel.vesa@linaro.org/ 

Changes in V3:
 - 5th patch has been squashed in the 4th one
 - Link to V2: https://lore.kernel.org/lkml/20230816145741.1472721-1-abel.vesa@linaro.org/

Changes in V2:
 - patch for printing domain HW-managed mode in the summary
 - patch that adds one consumer (venus)
 - patch for gdsc with new (different) flag
 - patch for videocc GDSC provider to update flags
 - Link to V1: https://lore.kernel.org/all/20230628105652.1670316-1-abel.vesa@linaro.org/

Abel Vesa (1):
  PM: domains: Add the domain HW-managed mode to the summary

Jagadeesh Kona (3):
  clk: qcom: gdsc: Add set and get hwmode callbacks to switch GDSC mode
  clk: qcom: videocc: Use HW_CTRL_TRIGGER for SM8250, SC7280 vcodec
    GDSC's
  venus: pm_helpers: Use dev_pm_genpd_set_hwmode to switch GDSC mode on
    V6

Ulf Hansson (1):
  PM: domains: Allow devices attached to genpd to be managed by HW

 drivers/clk/qcom/gdsc.c                       | 42 ++++++++++
 drivers/clk/qcom/gdsc.h                       |  1 +
 drivers/clk/qcom/videocc-sc7280.c             |  2 +-
 drivers/clk/qcom/videocc-sm8250.c             |  4 +-
 .../media/platform/qcom/venus/pm_helpers.c    | 39 ++++++----
 drivers/pmdomain/core.c                       | 78 ++++++++++++++++++-
 include/linux/pm_domain.h                     | 17 ++++
 7 files changed, 162 insertions(+), 21 deletions(-)

-- 
2.43.0



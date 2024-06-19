Return-Path: <linux-pm+bounces-9592-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3EC90EFF4
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 16:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE0EF1C23EC8
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 14:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9FBD1EA6F;
	Wed, 19 Jun 2024 14:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XM7KUXpJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DD0D27E;
	Wed, 19 Jun 2024 14:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718806525; cv=none; b=f7ZRRIKG+OvZI7xADnmuqq1opAdIGSsuGXnx7394y9SfSmQMsBvV9YpfDb8tOG8LA3ZFT/3I2DBsVQD9g4uumWmWz8d8Ij0ypWJP8fxFx0mUBaJ9x4VndyI3Q+wdtCEVfKrTzXjR1b9tqNBruuXgQTgvmY1Ee4zThX/ziGZeXcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718806525; c=relaxed/simple;
	bh=Et+6bg9ygYKyI2+mmGucP00F6/df/i/Onxfy/do1cD4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bLgBErHsvIrh+nCj2xUOQ5RjpuUbY30rdjvVGx3RSxoT1XLWwd2c5c/uPg/vmhiVkA8RXGf2PCK1HjHhgfvoFmPcHmCXloPgP1VumO7ZXyDKG5JoVSjIpTdBfUW+BWCZT7wMoBPKk1UYLN6hH0LA0x4P7Xq4rfSr4Wk3jfsO++M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XM7KUXpJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45J9llYP005109;
	Wed, 19 Jun 2024 14:15:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sZR1edagXuuQElm3hgWV7NovGoUGtEWKak1GxlIYbaA=; b=XM7KUXpJoVFrUFhN
	E2vUISBLZKY3wovUDTuMMevrNsrlqvtMp7AYjhx3shKuvPHdcLBe3Xdz4odwl44h
	dj1o35AgK7sjqrkkJ1NbadCjbtmMmNIVDCQbJGPnpkoPAOzebDwlqw0uI37nL5nh
	ixRPCOCMQeE8mvJLcG4Btcm6P4jA17XNylw4q5GvCar4g7fjDxlqnyD5sxs0uPu+
	0lwDPFt6kQsHiu2WZqYiu1fVKC7+tAcGGJrjDztw+rX8pDrsbc8XNbI69WGr3kYR
	L4uVriEdTen79YggKkSBoaMm51X2qESYVW2nSBevgLea9uVgH4EMu4IF9Tu3ihFP
	KjibVw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yuja79wgu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 14:15:15 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45JEFDeZ022297
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 14:15:13 GMT
Received: from hu-jkona-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 19 Jun 2024 07:15:05 -0700
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
Subject: [PATCH V6 3/5] clk: qcom: gdsc: Add set and get hwmode callbacks to switch GDSC mode
Date: Wed, 19 Jun 2024 19:44:11 +0530
Message-ID: <20240619141413.7983-4-quic_jkona@quicinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240619141413.7983-1-quic_jkona@quicinc.com>
References: <20240619141413.7983-1-quic_jkona@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 4Y_Eb3EueTpbkdZdid8ig4QjuL3G5uIn
X-Proofpoint-GUID: 4Y_Eb3EueTpbkdZdid8ig4QjuL3G5uIn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-19_02,2024-06-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 phishscore=0 bulkscore=0 suspectscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406190106

Some GDSC client drivers require the GDSC mode to be switched dynamically
to HW mode at runtime to gain the power benefits. Typically such client
drivers require the GDSC to be brought up in SW mode initially to enable
the required dependent clocks and configure the hardware to proper state.
Once initial hardware set up is done, they switch the GDSC to HW mode to
save power. At the end of usecase, they switch the GDSC back to SW mode
and disable the GDSC.

Introduce HW_CTRL_TRIGGER flag to register the set_hwmode_dev and
get_hwmode_dev callbacks for GDSC's whose respective client drivers
require the GDSC mode to be switched dynamically at runtime using
dev_pm_genpd_set_hwmode() API.

Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/clk/qcom/gdsc.c | 42 +++++++++++++++++++++++++++++++++++++++++
 drivers/clk/qcom/gdsc.h |  1 +
 2 files changed, 43 insertions(+)

diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
index df9618ab7eea..6acc7af82255 100644
--- a/drivers/clk/qcom/gdsc.c
+++ b/drivers/clk/qcom/gdsc.c
@@ -363,6 +363,44 @@ static int gdsc_disable(struct generic_pm_domain *domain)
 	return 0;
 }
 
+static int gdsc_set_hwmode(struct generic_pm_domain *domain, struct device *dev, bool mode)
+{
+	struct gdsc *sc = domain_to_gdsc(domain);
+	int ret;
+
+	ret = gdsc_hwctrl(sc, mode);
+	if (ret)
+		return ret;
+
+	/*
+	 * Wait for the GDSC to go through a power down and
+	 * up cycle. In case SW/FW end up polling status
+	 * bits for the gdsc before the power cycle is completed
+	 * it might read the status wrongly.
+	 */
+	udelay(1);
+
+	/*
+	 * When GDSC is switched to HW mode, HW can disable the GDSC.
+	 * When GDSC is switched back to SW mode, the GDSC will be enabled
+	 * again, hence need to poll for GDSC to complete the power up.
+	 */
+	if (!mode)
+		return gdsc_poll_status(sc, GDSC_ON);
+
+	return 0;
+}
+
+static bool gdsc_get_hwmode(struct generic_pm_domain *domain, struct device *dev)
+{
+	struct gdsc *sc = domain_to_gdsc(domain);
+	u32 val;
+
+	regmap_read(sc->regmap, sc->gdscr, &val);
+
+	return !!(val & HW_CONTROL_MASK);
+}
+
 static int gdsc_init(struct gdsc *sc)
 {
 	u32 mask, val;
@@ -451,6 +489,10 @@ static int gdsc_init(struct gdsc *sc)
 		sc->pd.power_off = gdsc_disable;
 	if (!sc->pd.power_on)
 		sc->pd.power_on = gdsc_enable;
+	if (sc->flags & HW_CTRL_TRIGGER) {
+		sc->pd.set_hwmode_dev = gdsc_set_hwmode;
+		sc->pd.get_hwmode_dev = gdsc_get_hwmode;
+	}
 
 	ret = pm_genpd_init(&sc->pd, NULL, !on);
 	if (ret)
diff --git a/drivers/clk/qcom/gdsc.h b/drivers/clk/qcom/gdsc.h
index 803512688336..1e2779b823d1 100644
--- a/drivers/clk/qcom/gdsc.h
+++ b/drivers/clk/qcom/gdsc.h
@@ -67,6 +67,7 @@ struct gdsc {
 #define ALWAYS_ON	BIT(6)
 #define RETAIN_FF_ENABLE	BIT(7)
 #define NO_RET_PERIPH	BIT(8)
+#define HW_CTRL_TRIGGER	BIT(9)
 	struct reset_controller_dev	*rcdev;
 	unsigned int			*resets;
 	unsigned int			reset_count;
-- 
2.43.0



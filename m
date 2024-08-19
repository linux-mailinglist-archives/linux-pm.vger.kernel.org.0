Return-Path: <linux-pm+bounces-12493-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A276C95755E
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 22:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0D2FB24DAD
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 20:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135FE1DD39F;
	Mon, 19 Aug 2024 20:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gzhPeAn/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E06F18E0E;
	Mon, 19 Aug 2024 20:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724098121; cv=none; b=toD1B+ZOIfQesnJAuGbRyXAZVf61VL+wI0/aChS61vMsfjDZtVEiZRyR3UxU2YKSC2SBrvcFw0oQmTnLhh8AxZA30lnVlxhtHwzEAoHaKe/bIVF1ok9KvINAICGWvDP4mHOTLutFXJtY9UoRzlAirOVi5h4MhAY0OrYh2P2p2iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724098121; c=relaxed/simple;
	bh=2HCYxWf0jM8B0Mt6KGgwSSzmUDx2DPGXcQPeYf6+6TA=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=HCm/qoRH3zD72tsd+lQQTbdwplf8QK77wgaF19amFhqqMnpjF2KbykQ8sRJoLZUgUYR+B00FmHBuU0doAL3Ytl2HVckLGCwUnFs8gDk2nalQ24lcsdXs4YOQY0JvmZPsRtoUxCDUfao4zVgD7fZ1LxIyRdRef2z6gAF7LBEW0kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gzhPeAn/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47JATc9L002694;
	Mon, 19 Aug 2024 20:08:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=oOSnHOne6wGKWYRAglUsHf
	VosEcu5Tx8J8KBurt7o8Q=; b=gzhPeAn/KfnIXbAgtYuAd3f8BQJ9/f3dTuTxxe
	mgMPKfUnCDiOU8CnHrLXHjLxnmHOQyquY2e9uoN3oYmBqSdPyTYIS/zTAPpf6wUw
	D2h0zkcfTpDD2qWgRkfbk2m9EWBXTtieQoY+kvSsFAZr7wRfEhDrBFFNFSsRxtQO
	y6dQuoICw7wkwBEpAs+sip3wMDyH43nrB6Mt3TPKKcMl9hO6Q6tkP21GXA4DDTLo
	LsJxgpeoCirlOuOkXgtE5Pl57Sea3Kg5J4lsE5UNf8RmbJYdxskPfQ1gXLWacACA
	kMrgzmKeSA0ktajrbOcRZ9OnyBA2Jy4H/CKVMVhk3Wty7eAw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 413qxg34cw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Aug 2024 20:08:23 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47JK8MaF030447
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Aug 2024 20:08:22 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 19 Aug 2024 13:08:21 -0700
From: Bjorn Andersson <quic_bjorande@quicinc.com>
Subject: [PATCH v2 0/3] soc: qcom: pmic_glink: v6.11-rc bug fixes
Date: Mon, 19 Aug 2024 13:07:44 -0700
Message-ID: <20240819-pmic-glink-v6-11-races-v2-0-88fe3ab1f0e2@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABCmw2YC/4WNTQ6CMBBGr0Jm7ZiW8r/yHoYFjgNMlIKtNhrC3
 a1cwOV7yfe+FTw7YQ9NsoLjIF5mGyE9JEBjZwdGuUaGVKWZqnSFyySEw13sDUOBWqPriD2awvR
 5XWRkTA1xvDju5b2Hz23kUfxzdp/9J+if/ZsMGhX2VUl5WbK6UH16vITE0pHmCdpt275RkSHav
 gAAAA==
To: Sebastian Reichel <sre@kernel.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Heikki
 Krogerus" <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
CC: Johan Hovold <johan+linaro@kernel.org>, Chris Lew <quic_clew@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Stephen Boyd
	<swboyd@chromium.org>,
        Amit Pundir <amit.pundir@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>,
        Bjorn Andersson
	<quic_bjorande@quicinc.com>,
        Johan Hovold <johan@kernel.org>, <stable@vger.kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724098101; l=2324;
 i=quic_bjorande@quicinc.com; s=20230915; h=from:subject:message-id;
 bh=2HCYxWf0jM8B0Mt6KGgwSSzmUDx2DPGXcQPeYf6+6TA=;
 b=nSlPKXudz2PHd80dzcRxXlZkHQ+HGAxizHD8iJltKxs4u/suCYiw+9Sw0GnIuYS2erzPHeF9N
 iRXSFLJykobCtK6TkUGSGWfeDXIYFUCY55c8JRBGlOHM8B/nWni7FiY
X-Developer-Key: i=quic_bjorande@quicinc.com; a=ed25519;
 pk=VkhObtljigy9k0ZUIE1Mvr0Y+E1dgBEH9WoLQnUtbIM=
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 97sTMK23GBOeR069Yn9WxrlkH85WNnQo
X-Proofpoint-GUID: 97sTMK23GBOeR069Yn9WxrlkH85WNnQo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-19_16,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=1 clxscore=1015 bulkscore=1
 adultscore=0 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2408190137

Amit and Johan both reported a NULL pointer dereference in the
pmic_glink client code during initialization, and Stephen Boyd pointed
out the problem (race condition).

While investigating, and writing the fix, I noticed that
ucsi_unregister() is called in atomic context but tries to sleep, and I
also noticed that the condition for when to inform the pmic_glink client
drivers when the remote has gone down is just wrong.

So, let's fix all three.

As mentioned in the commit message for the UCSI fix, I have a series in
the works that makes the GLINK callback happen in a sleepable context,
which would remove the need for the clients list to be protected by a
spinlock, and removing the work scheduling. This is however not -rc
material...

In addition to the NULL pointer dereference, there is the -ECANCELED
issue reported here:
https://lore.kernel.org/all/Zqet8iInnDhnxkT9@hovoldconsulting.com/
Johan reports that these fixes do not address that issue.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
Changes in v2:
- Refer to the correct commit in the ucsi_unregister() patch.
- Updated wording in the same commit message about the new error message
  in the log.
- Changed the data type of the introduced state variables, opted to go
  for a bool as we only represent two states (and I would like to
  further clean this up going forward)
- Initialized the spinlock
- Link to v1: https://lore.kernel.org/r/20240818-pmic-glink-v6-11-races-v1-0-f87c577e0bc9@quicinc.com

---
Bjorn Andersson (3):
      soc: qcom: pmic_glink: Fix race during initialization
      usb: typec: ucsi: Move unregister out of atomic section
      soc: qcom: pmic_glink: Actually communicate with remote goes down

 drivers/power/supply/qcom_battmgr.c   | 16 ++++++++-----
 drivers/soc/qcom/pmic_glink.c         | 40 ++++++++++++++++++++++----------
 drivers/soc/qcom/pmic_glink_altmode.c | 17 +++++++++-----
 drivers/usb/typec/ucsi/ucsi_glink.c   | 43 ++++++++++++++++++++++++++---------
 include/linux/soc/qcom/pmic_glink.h   | 11 +++++----
 5 files changed, 87 insertions(+), 40 deletions(-)
---
base-commit: 2fd613d27928293eaa87788b10e8befb6805cd42
change-id: 20240818-pmic-glink-v6-11-races-363f5964c339

Best regards,
-- 
Bjorn Andersson <quic_bjorande@quicinc.com>



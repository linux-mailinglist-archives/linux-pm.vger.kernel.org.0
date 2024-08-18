Return-Path: <linux-pm+bounces-12392-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F25956010
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 01:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC3E3B21A62
	for <lists+linux-pm@lfdr.de>; Sun, 18 Aug 2024 23:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90BF915539A;
	Sun, 18 Aug 2024 23:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="D1kRhZhW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF3114F12F;
	Sun, 18 Aug 2024 23:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724023079; cv=none; b=nfP/z0nLnBYb+HD67QCfwBC7vev/7FhjTprNF8OzB3m1PKUZPI5b9dFY8G40L08QGrtfMQwrZ0qW04HhJLLI7oaVVZGhEG1LYHBF32v0rVECGfNKb/rOmtrIcsW+QxUZ/Lqdjgvo+F+axI9mdCDUvJgGPot4cUG8Z0vbRmWm8oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724023079; c=relaxed/simple;
	bh=2/uDyHgeJRduSHXpQqcHNYnor9Qt4dV86uSyEebFDXo=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=LwDl1JeDhr8rJMrGQWd5cyfhKUDU3kd+f30dQato8GFYdGQ7Or2Qgh9+f5MyU1+YvExxdATkF9GtMf7mKIgyBSHu6a19FZ9GjiDOWlrOEhIwpXfrC4lVenVocBfA18p9Ev+xRrU/C63lCgbI/KTkLcwozHw9vne59KdHbzSFPac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=D1kRhZhW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47IN9HKk007309;
	Sun, 18 Aug 2024 23:17:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=urBpBTGMS3ylyUFZaMqc3f
	PHtW/pdqcYyWo6uyf86Eo=; b=D1kRhZhWfLLi82Lj89BHL8m9a9uU6Kz0KhQh7l
	DgmOzgFu/NCfcMS+ZwC7GAuxRw7Sq9EsmM8ozE3HmSLU0Xk0oI5GCLC/VRnKrE9Z
	HobQppP82HZ979z374pSOM+YkIHhwkgCn2TaNVNLBn58CBpsHMOrdxtyVjIy3bfc
	DY7pGXh82xgA4nmj1ANxDxLmTtJkuETmhw35wXHxbSQgG+S0FfzdGR0CI66zNTee
	OymNAdW2c25WoS8Fh+bHBo23t8zui5VfQkG/PMsguPZWr+6o9ol/gcREKpOZYglz
	JUj0jW6h2zvwXxznOo8YDYQEpBO5PuvCe3d5Cd0qbxY5YZNQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 412kxujg1u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 18 Aug 2024 23:17:39 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47INHcAJ029843
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 18 Aug 2024 23:17:38 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 18 Aug 2024 16:17:37 -0700
From: Bjorn Andersson <quic_bjorande@quicinc.com>
Subject: [PATCH 0/3] soc: qcom: pmic_glink: v6.11-rc bug fixes
Date: Sun, 18 Aug 2024 16:17:36 -0700
Message-ID: <20240818-pmic-glink-v6-11-races-v1-0-f87c577e0bc9@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABCBwmYC/x3MQQqAIBBA0avIrBvILNGuEi3CphoqCwUJwrsnL
 d/i/xciBaYIvXghUOLIly+QlQC3TX4l5LkYmrppayMN3ic7XA/2OyaNUmKYHEVUWi2d1a1TykK
 J70ALP/94GHP+ALqRDc5oAAAA
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
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724023057; l=1879;
 i=quic_bjorande@quicinc.com; s=20230915; h=from:subject:message-id;
 bh=2/uDyHgeJRduSHXpQqcHNYnor9Qt4dV86uSyEebFDXo=;
 b=SEhwtzoFctybJMOdjcRaQJP976EW+1jQ6vnlcIg3PESLwrMV5m+AJCncCb3Grm6p6h91vLURp
 KUY1pEvXHYAASSjNRv/GHdg48vG4+k6MUbTzCaMJgFWbw3B5KDjB2rm
X-Developer-Key: i=quic_bjorande@quicinc.com; a=ed25519;
 pk=VkhObtljigy9k0ZUIE1Mvr0Y+E1dgBEH9WoLQnUtbIM=
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: kh4JqDPPVJD3PVApuWstXkFUSd0KPsMg
X-Proofpoint-ORIG-GUID: kh4JqDPPVJD3PVApuWstXkFUSd0KPsMg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-18_22,2024-08-16_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=848 spamscore=0
 priorityscore=1501 phishscore=0 adultscore=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 impostorscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408180174

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
I have not yet been able to either reproduce this or convince myself
that this is the same issue.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
Bjorn Andersson (3):
      soc: qcom: pmic_glink: Fix race during initialization
      usb: typec: ucsi: Move unregister out of atomic section
      soc: qcom: pmic_glink: Actually communicate with remote goes down

 drivers/power/supply/qcom_battmgr.c   | 16 ++++++++-----
 drivers/soc/qcom/pmic_glink.c         | 40 +++++++++++++++++++++----------
 drivers/soc/qcom/pmic_glink_altmode.c | 17 +++++++++-----
 drivers/usb/typec/ucsi/ucsi_glink.c   | 44 ++++++++++++++++++++++++++---------
 include/linux/soc/qcom/pmic_glink.h   | 11 +++++----
 5 files changed, 88 insertions(+), 40 deletions(-)
---
base-commit: 296c871d2904cff2b4742702ef94512ab467a8e3
change-id: 20240818-pmic-glink-v6-11-races-363f5964c339

Best regards,
-- 
Bjorn Andersson <quic_bjorande@quicinc.com>



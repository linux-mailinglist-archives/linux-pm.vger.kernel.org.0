Return-Path: <linux-pm+bounces-12393-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 765EB956011
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 01:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91EB71C20D64
	for <lists+linux-pm@lfdr.de>; Sun, 18 Aug 2024 23:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C15C155C98;
	Sun, 18 Aug 2024 23:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QeV7iVWw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEE543AA9;
	Sun, 18 Aug 2024 23:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724023079; cv=none; b=UHhia+ZehtoIoup2xyvcHgeU7f/ycbAcDw2nsoAv+JGs5BGnT4NwWRdx4/Fx1yekX3qCfxQRu//bhA+LzrEp9+QkTknn7HLgIeSZEC2576ucCR//hsU+G0+lSiSQxk2sRa1hp/awfM1hQbni4JAY9JhXIbGmmi2lenXoXUFyNJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724023079; c=relaxed/simple;
	bh=hGecqx0y4ZNmpw/sD873/9VdPmSix/UvJFpjLjua/qQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=PgnJXUxfPfoWQYolnUT9aMJGBd0J6OjHvR6xYvGJRhBzwNCyziSHvCwCB45iI+QhN2XJ1xljK+ZmCnowM/FZ4mmTar1/m2sTffod1jWtzBoHbeICPQecnz4jRGFZ/yCS3XMhR6p7WiZ5VmQCh2r0XGXemvY58HqKcOnnweGjuMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QeV7iVWw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47IN8ltd007329;
	Sun, 18 Aug 2024 23:17:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	l8/dsTVFOtZOsfs+nNPd6KGty5VpdIAXBuSgXDPMSv4=; b=QeV7iVWwlxjx0Lxn
	jdnIqsuVPBLglsP4wEAGgWWH3qe3OiN0nwL2KurI6rehvpnM2QEGgrjpADIS3v6P
	DsaBiAfOAQPntj+inGdtsGxxU4uc705R0uWdZaqOPtRXYTyQ9M6hIoUDyYNNHn0d
	klF0woHtPyEbS47WHbXA3qcyy7w0jcULE3utXpnCMqL+mJR4eicDsu/gDiUlRrBd
	c4RagYwfakqa2vU6eci0P4U81kFO5Tn3r6XgRmrWrqb32NIR4B1yuUwPZtwI5xhC
	uhxdGpr4DqPZFC+JkK4q5QL88V3YjG/nLTiIoE6H1wXWoNbNVenVsVBxSxi/2MN1
	hg2inQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 412key2gqd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 18 Aug 2024 23:17:40 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47INHcWF029847
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 18 Aug 2024 23:17:38 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 18 Aug 2024 16:17:38 -0700
From: Bjorn Andersson <quic_bjorande@quicinc.com>
Date: Sun, 18 Aug 2024 16:17:38 -0700
Subject: [PATCH 2/3] usb: typec: ucsi: Move unregister out of atomic
 section
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240818-pmic-glink-v6-11-races-v1-2-f87c577e0bc9@quicinc.com>
References: <20240818-pmic-glink-v6-11-races-v1-0-f87c577e0bc9@quicinc.com>
In-Reply-To: <20240818-pmic-glink-v6-11-races-v1-0-f87c577e0bc9@quicinc.com>
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
	<quic_bjorande@quicinc.com>, <stable@vger.kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724023057; l=3903;
 i=quic_bjorande@quicinc.com; s=20230915; h=from:subject:message-id;
 bh=hGecqx0y4ZNmpw/sD873/9VdPmSix/UvJFpjLjua/qQ=;
 b=w/VbHhjn1zTaAHcySC2t8IxYg180gtT5DbbnkbFwq3CKJRhJNBSHOOxkEKp5ktBBcdvVD1Skf
 Y9st/ms1hsSDEVhI/mK6UnUwSewC1bndaTtru0W20Eftj766icQ8noO
X-Developer-Key: i=quic_bjorande@quicinc.com; a=ed25519;
 pk=VkhObtljigy9k0ZUIE1Mvr0Y+E1dgBEH9WoLQnUtbIM=
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: QAMzOxOXhjSEHpWy5fGUssm1PDyBvtai
X-Proofpoint-GUID: QAMzOxOXhjSEHpWy5fGUssm1PDyBvtai
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-18_22,2024-08-16_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 mlxscore=0 adultscore=0 clxscore=1015 impostorscore=0
 suspectscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2408180173

Commit 'caa855189104 ("soc: qcom: pmic_glink: Fix race during
initialization")' moved the pmic_glink client list under a spinlock, as
it is accessed by the rpmsg/glink callback, which in turn is invoked
from IRQ context.

This means that ucsi_unregister() is now called from IRQ context, which
isn't feasible as it's expecting a sleepable context. An effort is under
way to get GLINK to invoke its callbacks in a sleepable context, but
until then lets schedule the unregistration.

A side effect of this is that ucsi_unregister() can now happen
after the remote processor, and thereby the communication link with it, is
gone. pmic_glink_send() is amended with a check to avoid the resulting
NULL pointer dereference, but it becomes expecting to see a failing send
upon shutting down the remote processor (e.g. during a restart following
a firmware crash):

  ucsi_glink.pmic_glink_ucsi pmic_glink.ucsi.0: failed to send UCSI write request: -5

Fixes: caa855189104 ("soc: qcom: pmic_glink: Fix race during initialization")
Cc: stable@vger.kernel.org
Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 drivers/soc/qcom/pmic_glink.c       | 10 +++++++++-
 drivers/usb/typec/ucsi/ucsi_glink.c | 28 +++++++++++++++++++++++-----
 2 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/drivers/soc/qcom/pmic_glink.c b/drivers/soc/qcom/pmic_glink.c
index 58ec91767d79..e4747f1d3da5 100644
--- a/drivers/soc/qcom/pmic_glink.c
+++ b/drivers/soc/qcom/pmic_glink.c
@@ -112,8 +112,16 @@ EXPORT_SYMBOL_GPL(pmic_glink_register_client);
 int pmic_glink_send(struct pmic_glink_client *client, void *data, size_t len)
 {
 	struct pmic_glink *pg = client->pg;
+	int ret;
 
-	return rpmsg_send(pg->ept, data, len);
+	mutex_lock(&pg->state_lock);
+	if (!pg->ept)
+		ret = -ECONNRESET;
+	else
+		ret = rpmsg_send(pg->ept, data, len);
+	mutex_unlock(&pg->state_lock);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(pmic_glink_send);
 
diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c b/drivers/usb/typec/ucsi/ucsi_glink.c
index ac53a81c2a81..a33056eec83d 100644
--- a/drivers/usb/typec/ucsi/ucsi_glink.c
+++ b/drivers/usb/typec/ucsi/ucsi_glink.c
@@ -68,6 +68,9 @@ struct pmic_glink_ucsi {
 
 	struct work_struct notify_work;
 	struct work_struct register_work;
+	spinlock_t state_lock;
+	unsigned int pdr_state;
+	unsigned int new_pdr_state;
 
 	u8 read_buf[UCSI_BUF_SIZE];
 };
@@ -244,8 +247,22 @@ static void pmic_glink_ucsi_notify(struct work_struct *work)
 static void pmic_glink_ucsi_register(struct work_struct *work)
 {
 	struct pmic_glink_ucsi *ucsi = container_of(work, struct pmic_glink_ucsi, register_work);
+	unsigned long flags;
+	unsigned int new_state;
+
+	spin_lock_irqsave(&ucsi->state_lock, flags);
+	new_state = ucsi->new_pdr_state;
+	spin_unlock_irqrestore(&ucsi->state_lock, flags);
+
+	if (ucsi->pdr_state != SERVREG_SERVICE_STATE_UP) {
+		if (new_state == SERVREG_SERVICE_STATE_UP)
+			ucsi_register(ucsi->ucsi);
+	} else {
+		if (new_state == SERVREG_SERVICE_STATE_DOWN)
+			ucsi_unregister(ucsi->ucsi);
+	}
 
-	ucsi_register(ucsi->ucsi);
+	ucsi->pdr_state = new_state;
 }
 
 static void pmic_glink_ucsi_callback(const void *data, size_t len, void *priv)
@@ -269,11 +286,12 @@ static void pmic_glink_ucsi_callback(const void *data, size_t len, void *priv)
 static void pmic_glink_ucsi_pdr_notify(void *priv, int state)
 {
 	struct pmic_glink_ucsi *ucsi = priv;
+	unsigned long flags;
 
-	if (state == SERVREG_SERVICE_STATE_UP)
-		schedule_work(&ucsi->register_work);
-	else if (state == SERVREG_SERVICE_STATE_DOWN)
-		ucsi_unregister(ucsi->ucsi);
+	spin_lock_irqsave(&ucsi->state_lock, flags);
+	ucsi->new_pdr_state = state;
+	spin_unlock_irqrestore(&ucsi->state_lock, flags);
+	schedule_work(&ucsi->register_work);
 }
 
 static void pmic_glink_ucsi_destroy(void *data)

-- 
2.34.1



Return-Path: <linux-pm+bounces-12491-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17925957550
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 22:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D5A71C210CB
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 20:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602A71DF660;
	Mon, 19 Aug 2024 20:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="krpEkZ1b"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15C81DD39C;
	Mon, 19 Aug 2024 20:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724098111; cv=none; b=Ni/80XCkR0gJVKVPDehKqz1OxbJDgE5XkQiDjKQh53bdbwpv0yLZo8o9dmfIBc3Lmun/SJ6sa5yvAIvoAXdg9jVKu3uv7bVXc1zWkUIovb9dgAW3WAPaic0IwGrEhSXu7xnZMNuRFEpwhaVRl5jE9SowGmOaYVqUMnS/6mCoNig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724098111; c=relaxed/simple;
	bh=VMywmaV2PC3+xgr4QRnO1wOmoE97PYvg4j7eQMJZDJg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=PARhBP8kj94qF3+84brnDSNaY8iJ7AJ3oSbt68HTYM2JFmQqq1D+yF+idLY0lFXI0RZkk8ZmsnALfylLB823mupqSaMCj8Sxg/PDv9i1rtwJbjGGDohazanmhW8ow9+bI8mkRBS/l7ZzZvDIz3sxb4GEWql7PTWr9FQB4MVQMKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=krpEkZ1b; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47JBA2Ze022742;
	Mon, 19 Aug 2024 20:08:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gZAnlzRN7R8Xgp/8ZFX6752e8W3mZV1F/mkGlAWZ5gc=; b=krpEkZ1bts/NCHMp
	aHeJWcvpoCN2Ftcg+n01dZdC49kL4thjX+x0AzX5IHtpHR7NcLS0SXtQOx6Shjkr
	NQ618YlAAXfXYFSMrDQqnr+9F+g+ueZGeSYZ5sqMQR1BHpXDmI+ymq+GomwJ4RW0
	cuE34idqBBmPJxNjSSI0xXdHqr2uKa4rbhjRSBFoct0euSDPrz11SrjK4eXoB5rW
	/g3fcmo4EcNdSF7SxB9A1gP8XPT1KUfiwLxisv5GgMWDFL1R1de6k5MtKFJI/aFt
	6FdUn/bnYTrUIXcC127q8GKdpa5EDovGfirdNuV1lUD4Y8iGWz5d6wpvDpmChj/d
	+hhcBQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 412m32ncy6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Aug 2024 20:08:23 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47JK8MJA019555
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Aug 2024 20:08:22 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 19 Aug 2024 13:08:22 -0700
From: Bjorn Andersson <quic_bjorande@quicinc.com>
Date: Mon, 19 Aug 2024 13:07:46 -0700
Subject: [PATCH v2 2/3] usb: typec: ucsi: Move unregister out of atomic
 section
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240819-pmic-glink-v6-11-races-v2-2-88fe3ab1f0e2@quicinc.com>
References: <20240819-pmic-glink-v6-11-races-v2-0-88fe3ab1f0e2@quicinc.com>
In-Reply-To: <20240819-pmic-glink-v6-11-races-v2-0-88fe3ab1f0e2@quicinc.com>
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
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724098101; l=4450;
 i=quic_bjorande@quicinc.com; s=20230915; h=from:subject:message-id;
 bh=VMywmaV2PC3+xgr4QRnO1wOmoE97PYvg4j7eQMJZDJg=;
 b=YPEj0ic2lN+vc/rh4jE5Sn8CEocbodrM1U1FhY+i/Ye1mVIyi57uW2Uglyc5QfdDDiclMt+9I
 o7n5qxTXaY2CruFadRpr4r0rv/nFnlExm7OI6tGLZPdmtkfln2iIEFb
X-Developer-Key: i=quic_bjorande@quicinc.com; a=ed25519;
 pk=VkhObtljigy9k0ZUIE1Mvr0Y+E1dgBEH9WoLQnUtbIM=
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: NtI19OLslqDwQ7WWPHLcSLRzxfbQ6WSy
X-Proofpoint-ORIG-GUID: NtI19OLslqDwQ7WWPHLcSLRzxfbQ6WSy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-19_16,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 suspectscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 mlxlogscore=999
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408190137

Commit '635ce0db8956 ("soc: qcom: pmic_glink: don't traverse clients
list without a lock")' moved the pmic_glink client list under a
spinlock, as it is accessed by the rpmsg/glink callback, which in turn
is invoked from IRQ context.

This means that ucsi_unregister() is now called from IRQ context, which
isn't feasible as it's expecting a sleepable context. An effort is under
way to get GLINK to invoke its callbacks in a sleepable context, but
until then lets schedule the unregistration.

A side effect of this is that ucsi_unregister() can now happen
after the remote processor, and thereby the communication link with it, is
gone. pmic_glink_send() is amended with a check to avoid the resulting NULL
pointer dereference.
This does however result in the user being informed about this error by
the following entry in the kernel log:

  ucsi_glink.pmic_glink_ucsi pmic_glink.ucsi.0: failed to send UCSI write request: -5

Fixes: 635ce0db8956 ("soc: qcom: pmic_glink: don't traverse clients list without a lock")
Cc: stable@vger.kernel.org
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Tested-by: Amit Pundir <amit.pundir@linaro.org>
Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 drivers/soc/qcom/pmic_glink.c       | 10 +++++++++-
 drivers/usb/typec/ucsi/ucsi_glink.c | 27 ++++++++++++++++++++++-----
 2 files changed, 31 insertions(+), 6 deletions(-)

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
index ac53a81c2a81..bb6244f21e0a 100644
--- a/drivers/usb/typec/ucsi/ucsi_glink.c
+++ b/drivers/usb/typec/ucsi/ucsi_glink.c
@@ -68,6 +68,9 @@ struct pmic_glink_ucsi {
 
 	struct work_struct notify_work;
 	struct work_struct register_work;
+	spinlock_t state_lock;
+	bool ucsi_registered;
+	bool pd_running;
 
 	u8 read_buf[UCSI_BUF_SIZE];
 };
@@ -244,8 +247,20 @@ static void pmic_glink_ucsi_notify(struct work_struct *work)
 static void pmic_glink_ucsi_register(struct work_struct *work)
 {
 	struct pmic_glink_ucsi *ucsi = container_of(work, struct pmic_glink_ucsi, register_work);
+	unsigned long flags;
+	bool pd_running;
 
-	ucsi_register(ucsi->ucsi);
+	spin_lock_irqsave(&ucsi->state_lock, flags);
+	pd_running = ucsi->pd_running;
+	spin_unlock_irqrestore(&ucsi->state_lock, flags);
+
+	if (!ucsi->ucsi_registered && pd_running) {
+		ucsi_register(ucsi->ucsi);
+		ucsi->ucsi_registered = true;
+	} else if (ucsi->ucsi_registered && !pd_running) {
+		ucsi_unregister(ucsi->ucsi);
+		ucsi->ucsi_registered = false;
+	}
 }
 
 static void pmic_glink_ucsi_callback(const void *data, size_t len, void *priv)
@@ -269,11 +284,12 @@ static void pmic_glink_ucsi_callback(const void *data, size_t len, void *priv)
 static void pmic_glink_ucsi_pdr_notify(void *priv, int state)
 {
 	struct pmic_glink_ucsi *ucsi = priv;
+	unsigned long flags;
 
-	if (state == SERVREG_SERVICE_STATE_UP)
-		schedule_work(&ucsi->register_work);
-	else if (state == SERVREG_SERVICE_STATE_DOWN)
-		ucsi_unregister(ucsi->ucsi);
+	spin_lock_irqsave(&ucsi->state_lock, flags);
+	ucsi->pd_running = state == SERVREG_SERVICE_STATE_UP;
+	spin_unlock_irqrestore(&ucsi->state_lock, flags);
+	schedule_work(&ucsi->register_work);
 }
 
 static void pmic_glink_ucsi_destroy(void *data)
@@ -320,6 +336,7 @@ static int pmic_glink_ucsi_probe(struct auxiliary_device *adev,
 	INIT_WORK(&ucsi->register_work, pmic_glink_ucsi_register);
 	init_completion(&ucsi->read_ack);
 	init_completion(&ucsi->write_ack);
+	spin_lock_init(&ucsi->state_lock);
 	mutex_init(&ucsi->lock);
 
 	ucsi->ucsi = ucsi_create(dev, &pmic_glink_ucsi_ops);

-- 
2.34.1



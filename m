Return-Path: <linux-pm+bounces-12394-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17410956013
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 01:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C38CB281E78
	for <lists+linux-pm@lfdr.de>; Sun, 18 Aug 2024 23:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83E715666B;
	Sun, 18 Aug 2024 23:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="M94Zpddb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF771509B3;
	Sun, 18 Aug 2024 23:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724023079; cv=none; b=S64JJsQ5JhjmFxhwOKroSdOYLxbnQ0GOR3c4YEKariWJIchzlUjC20a8mPhcg1HBxj9LlfsYU3peKnw4+b3xPHQh53KmF9Ztd/De4IqoMNr3DDlw4OnMw2+Js29V3a+xOhs/qVEnK8R/bwGSssnKOt8uXHbMZrbPnvzwEcYI8G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724023079; c=relaxed/simple;
	bh=62ubaoaUfm6r0cjMk7EfgJSm9PpSj8pinqrJJT5P1d8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=d4X9OcL4x0w/c4VawDNhkosblIZnzWbTHqS6Cnh6tdRW9FbuzeMKvMwRVwAPc2Kp1raHgSeQ8AhAFJnOuT1dHUyQEOCFOoecYT7GGXnkUNgezeP055Rw3rWD7FRxX0gaYeiYcdUUmdizgj4mare4AD02ffG+FGQgXfoy1zuEzug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=M94Zpddb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47IN9Ag7007187;
	Sun, 18 Aug 2024 23:17:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CY7YkM2IF1oEPhhqZSmK51CQkF7vQtVJ9D3Sc3FzPCE=; b=M94ZpddbceQdITHQ
	3Bkpsy0hfFjmUPMoT0/V2qxZ5UG7sBG1qgfLnRg1WB8ImO+dZ3KQF2IK4Rs+h1Gd
	yM/M9Jyl1bieQMUyXLXZ+1ZBnYfzh+mNm/PWROLVIDWTaya74gArSpbk6R7s7u3X
	RFu3NQBIDMrwHsHLwfEhDTET+cj182IFkNyy2J1i2lZ7eQ0T76nob629Jek5YtNi
	kxfNKHlxYiSDeDDQlF1Yclj2zns6KORwAbLtDtYZylYxAU3vawZsBnJrUCmM7iVz
	kOGerfJa2gLipZnOJknHXyTHw5kHmfZh1jf4Q8RVc7P8aP3l4Q3s0vaZK9rzfqKq
	GIe88A==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 412kxujg1v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 18 Aug 2024 23:17:39 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47INHcYv022571
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 18 Aug 2024 23:17:38 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 18 Aug 2024 16:17:37 -0700
From: Bjorn Andersson <quic_bjorande@quicinc.com>
Date: Sun, 18 Aug 2024 16:17:37 -0700
Subject: [PATCH 1/3] soc: qcom: pmic_glink: Fix race during initialization
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240818-pmic-glink-v6-11-races-v1-1-f87c577e0bc9@quicinc.com>
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
	<quic_bjorande@quicinc.com>,
        Johan Hovold <johan@kernel.org>, <stable@vger.kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724023057; l=8420;
 i=quic_bjorande@quicinc.com; s=20230915; h=from:subject:message-id;
 bh=62ubaoaUfm6r0cjMk7EfgJSm9PpSj8pinqrJJT5P1d8=;
 b=wLFJ319GI+xGjjjEeDS7Ri70jP99cCy9mdG2ZGQroyoMj7xRnkFf1UekUtUEaXR8apRGQekDM
 jPAPkvhAuMwDVjKEo+dvprbJgMIY46hLcrBcTdDlnQbXOAM+2CmEvxP
X-Developer-Key: i=quic_bjorande@quicinc.com; a=ed25519;
 pk=VkhObtljigy9k0ZUIE1Mvr0Y+E1dgBEH9WoLQnUtbIM=
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: cAXcy6b6CL92cdT5qYvCYlBXKI97mMYi
X-Proofpoint-ORIG-GUID: cAXcy6b6CL92cdT5qYvCYlBXKI97mMYi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-18_22,2024-08-16_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 phishscore=0 adultscore=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408180174

As pointed out by Stephen Boyd it is possible that during initialization
of the pmic_glink child drivers, the protection-domain notifiers fires,
and the associated work is scheduled, before the client registration
returns and as a result the local "client" pointer has been initialized.

The outcome of this is a NULL pointer dereference as the "client"
pointer is blindly dereferenced.

Timeline provided by Stephen:
 CPU0                               CPU1
 ----                               ----
 ucsi->client = NULL;
 devm_pmic_glink_register_client()
  client->pdr_notify(client->priv, pg->client_state)
   pmic_glink_ucsi_pdr_notify()
    schedule_work(&ucsi->register_work)
    <schedule away>
                                    pmic_glink_ucsi_register()
                                     ucsi_register()
                                      pmic_glink_ucsi_read_version()
                                       pmic_glink_ucsi_read()
                                        pmic_glink_ucsi_read()
                                         pmic_glink_send(ucsi->client)
                                         <client is NULL BAD>
 ucsi->client = client // Too late!

This code is identical across the altmode, battery manager and usci
child drivers.

Resolve this by splitting the allocation of the "client" object and the
registration thereof into two operations.

This only happens if the protection domain registry is populated at the
time of registration, which by the introduction of commit '1ebcde047c54
("soc: qcom: add pd-mapper implementation")' became much more likely.

Reported-by: Amit Pundir <amit.pundir@linaro.org>
Closes: https://lore.kernel.org/all/CAMi1Hd2_a7TjA7J9ShrAbNOd_CoZ3D87twmO5t+nZxC9sX18tA@mail.gmail.com/
Reported-by: Johan Hovold <johan@kernel.org>
Closes: https://lore.kernel.org/all/ZqiyLvP0gkBnuekL@hovoldconsulting.com/
Reported-by: Stephen Boyd <swboyd@chromium.org>
Closes: https://lore.kernel.org/all/CAE-0n52JgfCBWiFQyQWPji8cq_rCsviBpW-m72YitgNfdaEhQg@mail.gmail.com/
Fixes: 58ef4ece1e41 ("soc: qcom: pmic_glink: Introduce base PMIC GLINK driver")
Cc: stable@vger.kernel.org
Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 drivers/power/supply/qcom_battmgr.c   | 16 ++++++++++------
 drivers/soc/qcom/pmic_glink.c         | 28 ++++++++++++++++++----------
 drivers/soc/qcom/pmic_glink_altmode.c | 17 +++++++++++------
 drivers/usb/typec/ucsi/ucsi_glink.c   | 16 ++++++++++------
 include/linux/soc/qcom/pmic_glink.h   | 11 ++++++-----
 5 files changed, 55 insertions(+), 33 deletions(-)

diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
index 49bef4a5ac3f..df90a470c51a 100644
--- a/drivers/power/supply/qcom_battmgr.c
+++ b/drivers/power/supply/qcom_battmgr.c
@@ -1387,12 +1387,16 @@ static int qcom_battmgr_probe(struct auxiliary_device *adev,
 					     "failed to register wireless charing power supply\n");
 	}
 
-	battmgr->client = devm_pmic_glink_register_client(dev,
-							  PMIC_GLINK_OWNER_BATTMGR,
-							  qcom_battmgr_callback,
-							  qcom_battmgr_pdr_notify,
-							  battmgr);
-	return PTR_ERR_OR_ZERO(battmgr->client);
+	battmgr->client = devm_pmic_glink_new_client(dev, PMIC_GLINK_OWNER_BATTMGR,
+						     qcom_battmgr_callback,
+						     qcom_battmgr_pdr_notify,
+						     battmgr);
+	if (IS_ERR(battmgr->client))
+		return PTR_ERR(battmgr->client);
+
+	pmic_glink_register_client(battmgr->client);
+
+	return 0;
 }
 
 static const struct auxiliary_device_id qcom_battmgr_id_table[] = {
diff --git a/drivers/soc/qcom/pmic_glink.c b/drivers/soc/qcom/pmic_glink.c
index 9ebc0ba35947..58ec91767d79 100644
--- a/drivers/soc/qcom/pmic_glink.c
+++ b/drivers/soc/qcom/pmic_glink.c
@@ -66,15 +66,14 @@ static void _devm_pmic_glink_release_client(struct device *dev, void *res)
 	spin_unlock_irqrestore(&pg->client_lock, flags);
 }
 
-struct pmic_glink_client *devm_pmic_glink_register_client(struct device *dev,
-							  unsigned int id,
-							  void (*cb)(const void *, size_t, void *),
-							  void (*pdr)(void *, int),
-							  void *priv)
+struct pmic_glink_client *devm_pmic_glink_new_client(struct device *dev,
+						     unsigned int id,
+						     void (*cb)(const void *, size_t, void *),
+						     void (*pdr)(void *, int),
+						     void *priv)
 {
 	struct pmic_glink_client *client;
 	struct pmic_glink *pg = dev_get_drvdata(dev->parent);
-	unsigned long flags;
 
 	client = devres_alloc(_devm_pmic_glink_release_client, sizeof(*client), GFP_KERNEL);
 	if (!client)
@@ -85,6 +84,18 @@ struct pmic_glink_client *devm_pmic_glink_register_client(struct device *dev,
 	client->cb = cb;
 	client->pdr_notify = pdr;
 	client->priv = priv;
+	INIT_LIST_HEAD(&client->node);
+
+	devres_add(dev, client);
+
+	return client;
+}
+EXPORT_SYMBOL_GPL(devm_pmic_glink_new_client);
+
+void pmic_glink_register_client(struct pmic_glink_client *client)
+{
+	struct pmic_glink *pg = client->pg;
+	unsigned long flags;
 
 	mutex_lock(&pg->state_lock);
 	spin_lock_irqsave(&pg->client_lock, flags);
@@ -95,11 +106,8 @@ struct pmic_glink_client *devm_pmic_glink_register_client(struct device *dev,
 	spin_unlock_irqrestore(&pg->client_lock, flags);
 	mutex_unlock(&pg->state_lock);
 
-	devres_add(dev, client);
-
-	return client;
 }
-EXPORT_SYMBOL_GPL(devm_pmic_glink_register_client);
+EXPORT_SYMBOL_GPL(pmic_glink_register_client);
 
 int pmic_glink_send(struct pmic_glink_client *client, void *data, size_t len)
 {
diff --git a/drivers/soc/qcom/pmic_glink_altmode.c b/drivers/soc/qcom/pmic_glink_altmode.c
index 1e0808b3cb93..e4f5059256e5 100644
--- a/drivers/soc/qcom/pmic_glink_altmode.c
+++ b/drivers/soc/qcom/pmic_glink_altmode.c
@@ -520,12 +520,17 @@ static int pmic_glink_altmode_probe(struct auxiliary_device *adev,
 			return ret;
 	}
 
-	altmode->client = devm_pmic_glink_register_client(dev,
-							  altmode->owner_id,
-							  pmic_glink_altmode_callback,
-							  pmic_glink_altmode_pdr_notify,
-							  altmode);
-	return PTR_ERR_OR_ZERO(altmode->client);
+	altmode->client = devm_pmic_glink_new_client(dev,
+						     altmode->owner_id,
+						     pmic_glink_altmode_callback,
+						     pmic_glink_altmode_pdr_notify,
+						     altmode);
+	if (IS_ERR(altmode->client))
+		return PTR_ERR(altmode->client);
+
+	pmic_glink_register_client(altmode->client);
+
+	return 0;
 }
 
 static const struct auxiliary_device_id pmic_glink_altmode_id_table[] = {
diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c b/drivers/usb/typec/ucsi/ucsi_glink.c
index 16c328497e0b..ac53a81c2a81 100644
--- a/drivers/usb/typec/ucsi/ucsi_glink.c
+++ b/drivers/usb/typec/ucsi/ucsi_glink.c
@@ -367,12 +367,16 @@ static int pmic_glink_ucsi_probe(struct auxiliary_device *adev,
 		ucsi->port_orientation[port] = desc;
 	}
 
-	ucsi->client = devm_pmic_glink_register_client(dev,
-						       PMIC_GLINK_OWNER_USBC,
-						       pmic_glink_ucsi_callback,
-						       pmic_glink_ucsi_pdr_notify,
-						       ucsi);
-	return PTR_ERR_OR_ZERO(ucsi->client);
+	ucsi->client = devm_pmic_glink_new_client(dev, PMIC_GLINK_OWNER_USBC,
+						  pmic_glink_ucsi_callback,
+						  pmic_glink_ucsi_pdr_notify,
+						  ucsi);
+	if (IS_ERR(ucsi->client))
+		return PTR_ERR(ucsi->client);
+
+	pmic_glink_register_client(ucsi->client);
+
+	return 0;
 }
 
 static void pmic_glink_ucsi_remove(struct auxiliary_device *adev)
diff --git a/include/linux/soc/qcom/pmic_glink.h b/include/linux/soc/qcom/pmic_glink.h
index fd124aa18c81..aedde76d7e13 100644
--- a/include/linux/soc/qcom/pmic_glink.h
+++ b/include/linux/soc/qcom/pmic_glink.h
@@ -23,10 +23,11 @@ struct pmic_glink_hdr {
 
 int pmic_glink_send(struct pmic_glink_client *client, void *data, size_t len);
 
-struct pmic_glink_client *devm_pmic_glink_register_client(struct device *dev,
-							  unsigned int id,
-							  void (*cb)(const void *, size_t, void *),
-							  void (*pdr)(void *, int),
-							  void *priv);
+struct pmic_glink_client *devm_pmic_glink_new_client(struct device *dev,
+						     unsigned int id,
+						     void (*cb)(const void *, size_t, void *),
+						     void (*pdr)(void *, int),
+						     void *priv);
+void pmic_glink_register_client(struct pmic_glink_client *client);
 
 #endif

-- 
2.34.1



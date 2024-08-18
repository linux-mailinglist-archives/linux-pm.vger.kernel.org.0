Return-Path: <linux-pm+bounces-12395-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E29095601D
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 01:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD32E281EBC
	for <lists+linux-pm@lfdr.de>; Sun, 18 Aug 2024 23:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B5A158A04;
	Sun, 18 Aug 2024 23:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZkY98LCO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFBE154454;
	Sun, 18 Aug 2024 23:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724023080; cv=none; b=sHUXP+Ay1tPVygAt5N7pvRNDwiC2Adt0oo7xvqyd5XPL89QZ3t3Gg1JEd/6fR7/2kaTUog2Y3hJsaoIyz1NEEk45Beg/mB0jC3/ex0Ja9bZics8oLyCeJ2OOiBD/z+bvKlc3ZG49KgfguxZtajiFyr1a9TTJ4c7+HgIVOyTcVoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724023080; c=relaxed/simple;
	bh=A/HYDsrJuXFW0qGUWD2KE96ILaBtDbLU+NxkkFF5u+I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=nF+SYsVj5ZCO9zz9n3RfundL/EMCX+BFH/5MBgZ3vqzPC5Y/sOUQE0pDEhD/BpaReos8WrYhHdabqdjIYSOHsNUvL1BRlrvvZKLTXtbFkdsVzknph3RuIN2auXNEKxHbmR9CMlw34krRjvcyl5oJu0ErhS1SyE9ZOooIl0u6938=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZkY98LCO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47IL3Ikb030735;
	Sun, 18 Aug 2024 23:17:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WJASdRSwBE2XVvB6rmnNHIQXn5hm5EE5wC8ypIKFpuo=; b=ZkY98LCOenmw2q4/
	usrwk/AriItEPK9js3tQSVajxbnpS3CWKOjUw5yMeB57CutSW5k+AsflslYgg/g8
	8I6vz964F3HotQ6QrZ2Pf1qsyLwQSOEDtZ6icVUSbKUs2lDcSxuBSY/K77iFjzp5
	QZXO1CzNI1Ad51UN+VlsNKmnwUPIBVePL8Gv3t1+2Ft3vkVWrKKA7wd3g95C00gc
	b2Y041+DKtwUiticFhfFTNtC3NOz6mPBzT7/PacL5eqZmfgyH2rl7yex4+/kAzak
	t9DW/8c0KlmBHtSKB/XqNB/il/pP9iVFmuGH8ottBkEbPwyyxmXiX9XEo9Ql4s/h
	LRUn0w==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 412m872ftf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 18 Aug 2024 23:17:40 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47INHcWG029847
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 18 Aug 2024 23:17:38 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 18 Aug 2024 16:17:38 -0700
From: Bjorn Andersson <quic_bjorande@quicinc.com>
Date: Sun, 18 Aug 2024 16:17:39 -0700
Subject: [PATCH 3/3] soc: qcom: pmic_glink: Actually communicate with
 remote goes down
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240818-pmic-glink-v6-11-races-v1-3-f87c577e0bc9@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724023057; l=1283;
 i=quic_bjorande@quicinc.com; s=20230915; h=from:subject:message-id;
 bh=A/HYDsrJuXFW0qGUWD2KE96ILaBtDbLU+NxkkFF5u+I=;
 b=N4uM4ZyFXEnLrngR9QzkC2v7udqPNoUqxiXM2V1jmLj+w7Ex2LraJQzLX9o6j/82ZvR4rIgXv
 n8LBCLwl8BOBOGmRJB77EHJkGNMkW1iJdJnPh9Psa9COmedQbk5WWFQ
X-Developer-Key: i=quic_bjorande@quicinc.com; a=ed25519;
 pk=VkhObtljigy9k0ZUIE1Mvr0Y+E1dgBEH9WoLQnUtbIM=
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: SZWl1v5oJrFfAjhOrZKPnL3eUeoZFCEN
X-Proofpoint-ORIG-GUID: SZWl1v5oJrFfAjhOrZKPnL3eUeoZFCEN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-18_22,2024-08-16_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 priorityscore=1501 adultscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 spamscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408180174

When the pmic_glink state is UP and we either receive a protection-
domain (PD) notifcation indicating that the PD is going down, or that
the whole remoteproc is going down, it's expected that the pmic_glink
client instances are notified that their function has gone DOWN.

This is not what the code does, which results in the client state either
not updating, or being wrong in many cases. So let's fix the conditions.

Fixes: 58ef4ece1e41 ("soc: qcom: pmic_glink: Introduce base PMIC GLINK driver")
Cc: stable@vger.kernel.org
Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 drivers/soc/qcom/pmic_glink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/pmic_glink.c b/drivers/soc/qcom/pmic_glink.c
index e4747f1d3da5..cb202a37e8ab 100644
--- a/drivers/soc/qcom/pmic_glink.c
+++ b/drivers/soc/qcom/pmic_glink.c
@@ -191,7 +191,7 @@ static void pmic_glink_state_notify_clients(struct pmic_glink *pg)
 		if (pg->pdr_state == SERVREG_SERVICE_STATE_UP && pg->ept)
 			new_state = SERVREG_SERVICE_STATE_UP;
 	} else {
-		if (pg->pdr_state == SERVREG_SERVICE_STATE_UP && pg->ept)
+		if (pg->pdr_state == SERVREG_SERVICE_STATE_DOWN || !pg->ept)
 			new_state = SERVREG_SERVICE_STATE_DOWN;
 	}
 

-- 
2.34.1



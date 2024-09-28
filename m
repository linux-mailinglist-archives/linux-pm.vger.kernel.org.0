Return-Path: <linux-pm+bounces-14887-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F20C988ECE
	for <lists+linux-pm@lfdr.de>; Sat, 28 Sep 2024 11:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E5B6B2154C
	for <lists+linux-pm@lfdr.de>; Sat, 28 Sep 2024 09:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC0C19E7F5;
	Sat, 28 Sep 2024 09:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iJr4oFGd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCCF2AF15;
	Sat, 28 Sep 2024 09:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727515625; cv=none; b=RfjF7bN2XN8RDArG52ZRDB9lyxq509/TYB9SsrJazddv3y8O1J51xTGtiuPPyXJxsgWylAKq//hu6IC+/8GVET0WKyL/989mHTxz6PnzUAQgNk1Sf0pQ7KJS7LTDFxUddCaMe35MGl3P0laK7aQ83K4WhVcN+W3V9jJQBKmqh/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727515625; c=relaxed/simple;
	bh=I4GEl8noeNqn5baoETtbeN8eHN+C2zt25GPno6/BBmA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=fVzZccu8De78bBFJWPqXVyLvEY5ZL5LYOkRrKQIr2c18bLhyWW0RGQxTUiyT/WOqbX70jP+kCMqKwwSwlKx87qRFzZtNOQG6UAKkOhRKFoHvUCFgd5lzcVVUavNGBRZAvoZq/SSC6dwP42v3KUTURjtamS5FkfWea5y+dpN6Vl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=iJr4oFGd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48S7uknB019780;
	Sat, 28 Sep 2024 09:26:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=4ZsmIjDEG1e9FkWhJTFR2i
	PcEwy/Bf2eceXye0AS4jc=; b=iJr4oFGdAKc4BVSxfBK9zriVquhSUFsD4haijl
	09yH0vip7QgcOr1l06hrY1AUVnDTxFnR3zxB3BuTM0cC5N3XxTqwFGYLREofYzT0
	RPxnqGrUd36sIiU7cEJhV7RPHxVf0seT1Ox6xzjX6iYE41Pbj+AIJRhrO4tQ5z/Y
	uASRtBXwupIeCO7pk21bOv8EW0EBuRcPY40QSbEPwXc0OG+6OLvjSgv0jm/RgUlW
	RCrGJZTyMNNlaZsiX++BTtyNAOKtKftyJnplWs9HSPGusZ3aeL2WImmRnD51ZumP
	aiMd2eubLIBqyrigyLzuZrDGYaWNg6XVkXN+Io8pRaWpIjCg==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41xa12gcce-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 28 Sep 2024 09:26:47 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48S9QkbA019012
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 28 Sep 2024 09:26:46 GMT
Received: from hu-zijuhu-lv.qualcomm.com (10.49.16.6) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sat, 28 Sep 2024 02:26:46 -0700
From: Zijun Hu <quic_zijuhu@quicinc.com>
Date: Sat, 28 Sep 2024 02:26:27 -0700
Subject: [PATCH RFC] PM: sleep: wakeirq: Fix a serious logical error in
 dev_pm_disarm_wake_irq()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240928-fix_wakeirq-v1-1-25d13a7e13ba@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAMLL92YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDSyML3bTMivjyxOzUzKJCXSNzs7Q0CyMzS3ODVCWgjoKiVKA02LRopSA
 3Z6XY2loA3NFyyGIAAAA=
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>,
        Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Johan Hovold <johan+linaro@kernel.org>, Tony Lindgren <tony@atomide.com>,
        Zijun Hu <zijun_hu@icloud.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.1
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: b3vTMolw8jIAC_GZ608Tuqn9rVhKwJm7
X-Proofpoint-GUID: b3vTMolw8jIAC_GZ608Tuqn9rVhKwJm7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 spamscore=0 clxscore=1011 mlxscore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409280069

IT is a serious logical error for dev_pm_disarm_wake_irq() not to disable
the wake irq enabled by dev_pm_arm_wake_irq(), fixed by simply correcting
the wrong if condition.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
List relevant commits as following:

johan+linaro@kernel.org  2023-07-13
Commit: 8527beb12087 ("PM: sleep: wakeirq: fix wake irq arming")

tony@atomide.com  2018-02-09
Commit: 69728051f5bf ("PM / wakeirq: Fix unbalanced IRQ enable for wakeirq")

The former commit fixes the later.
---
 drivers/base/power/wakeirq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/wakeirq.c b/drivers/base/power/wakeirq.c
index 5a5a9e978e85..8b15f9a0e8f9 100644
--- a/drivers/base/power/wakeirq.c
+++ b/drivers/base/power/wakeirq.c
@@ -356,7 +356,7 @@ void dev_pm_disarm_wake_irq(struct wake_irq *wirq)
 		disable_irq_wake(wirq->irq);
 
 		if (wirq->status & WAKE_IRQ_DEDICATED_ALLOCATED &&
-		    !(wirq->status & WAKE_IRQ_DEDICATED_ENABLED))
+		    (wirq->status & WAKE_IRQ_DEDICATED_ENABLED))
 			disable_irq_nosync(wirq->irq);
 	}
 }

---
base-commit: eb46cb321f1f3f3102f4ad3d61dd5c8c06cdbf17
change-id: 20240928-fix_wakeirq-276ff826970e

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>



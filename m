Return-Path: <linux-pm+bounces-8505-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92EF48D78D8
	for <lists+linux-pm@lfdr.de>; Mon,  3 Jun 2024 00:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC36BB20EB8
	for <lists+linux-pm@lfdr.de>; Sun,  2 Jun 2024 22:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B902A7E586;
	Sun,  2 Jun 2024 22:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eDIwa0KM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14EC27E110;
	Sun,  2 Jun 2024 22:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717367086; cv=none; b=bmYJVLjxGxH3E/TzfE4s74mKC7JHnt5ue2ooVGJl02s9Z1DFZ6HsCk6z4LwrK1OZnvATEqM2AiCLEjE70JnR+LXZpWBYjvkg37I6H5mznE92POq8u1bMNwyaQJGtQsJVeWwlmHp9+0pyjXnCzkaUw0V9rhhQVJZ4jNMoTTSMZxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717367086; c=relaxed/simple;
	bh=vfwNZlKpz4TNgLna05fDr4G878bn+dbKpAonUnZsQW4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=EdaZqoa2StHDi6cxJXOpc8tL3clcPFM6ePwPvOderuWbGBh6BO+cRY8eystMuXBlHEGA1bdD2PUGHjoptsRznQ0VGwkLeRF9cbU51WqWP5Gh2qFi+MwfsISlHTVZNlouqNmN1qxjK6MzGouJRtLjf/N99TYDU3bfMCF5nsxywrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=eDIwa0KM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 452MOevo013947;
	Sun, 2 Jun 2024 22:24:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=DH86hZwMsk4NCjqy+2kZff
	JO87KRTSnMXvi1enRmErM=; b=eDIwa0KMubaaEzMiDEKyz4aIQmg6gkq57tbsGm
	oWFbutN9QYXDElgVzm16kR7WHqHMad9v4BXpWXOm8kxJWznMnwDbeATJ0oOGt8H0
	A/I1HcskVXM35tHgEngggyTYWwM1xfSmQIenZ82zuDC9fBSSHGmJHFHVqw2y9mwV
	F/0I02XjPNFoWSM1lDHQVh7wNpGnP+ZrJZ4J3pOQcxmPmqLG9t9n46otIGZ8Z7/w
	1LuGBCgcIZqloOkgRTzewNlIkoAlwEHbEkOFhvB7LvUk29GdMvDqKKQ9Tp/lwk97
	KWGNhp1n1PKe6vg0nPyRmEcgWyaeA22MAxy/KrhAzpcaZiYg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yfw4d2mvs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 02 Jun 2024 22:24:40 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 452MOdxf022888
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 2 Jun 2024 22:24:39 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 2 Jun 2024
 15:24:39 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Sun, 2 Jun 2024 15:24:38 -0700
Subject: [PATCH] cpuidle: haltpoll: add missing MODULE_DESCRIPTION() macro
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240602-md-cpuidle-haltpoll-v1-1-8d649277ca23@quicinc.com>
X-B4-Tracking: v=1; b=H4sIACbxXGYC/x3MQQrDIBBA0auEWXfA2uCiVyldjDqpA8bImJRAy
 N1rs3yL/w9orMINnsMByl9pspSO+22AkKh8GCV2gzV2NM5YnCOGuknMjInyWpec0bmHC+TYBzt
 CL6vyJPt1fb27PTVGr1RC+r+ylG3HmdrKCuf5A2EDCcqEAAAA
To: "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano
	<daniel.lezcano@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Vktk-zav8c6qbEk5eSZK4bDnJ-x3smNO
X-Proofpoint-GUID: Vktk-zav8c6qbEk5eSZK4bDnJ-x3smNO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-02_15,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 mlxscore=0 adultscore=0 impostorscore=0 bulkscore=0
 spamscore=0 phishscore=0 clxscore=1011 mlxlogscore=999 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406020195

make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/cpuidle/cpuidle-haltpoll.o

Add the missing invocation of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/cpuidle/cpuidle-haltpoll.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpuidle/cpuidle-haltpoll.c b/drivers/cpuidle/cpuidle-haltpoll.c
index d8515d5c0853..bcd03e893a0a 100644
--- a/drivers/cpuidle/cpuidle-haltpoll.c
+++ b/drivers/cpuidle/cpuidle-haltpoll.c
@@ -141,5 +141,6 @@ static void __exit haltpoll_exit(void)
 
 module_init(haltpoll_init);
 module_exit(haltpoll_exit);
+MODULE_DESCRIPTION("cpuidle driver for haltpoll governor");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Marcelo Tosatti <mtosatti@redhat.com>");

---
base-commit: a693b9c95abd4947c2d06e05733de5d470ab6586
change-id: 20240602-md-cpuidle-haltpoll-6636ca6ebc24



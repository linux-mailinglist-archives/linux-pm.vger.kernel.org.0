Return-Path: <linux-pm+bounces-21426-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BAD9A29885
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 19:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C55141889052
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 18:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B78F1FDA6D;
	Wed,  5 Feb 2025 18:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="abEViVS3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FB11A83ED;
	Wed,  5 Feb 2025 18:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738779255; cv=none; b=HeFM9ThQ7sY6u5dvx3MWsuqgwb41LjDAtui4UrAsh7XSg0tJu3ZBoDlfrpTdPZAp3nKQt+3LibnMr+1dQMzDUaDix/BxsvL8+RyEB/OesEe0lqk9fELf/hVPXGeYqBEkBeDubeBNAc/67C8ZSoBWjC+ogQeJ5G3VFbdtm3mMsvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738779255; c=relaxed/simple;
	bh=BNuuoIKCTW2XZ1ATUd3BE3PJ9sf5RKJy22TzPwiBTmg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mvF2hDLCV+z2Zi4+AphXgStgokToDmmfXZWeoEloJVXrqRLBJ46025OwAsuaZ9tynPdR/mPczC3CRPzsyCPNY3yEfJGsq7AUDL+q+QdablWxJCxgUB7vdbd/NBom9oMcyvm8MUVEUSGRG5SVPPwzfj0hpml2ZxyLC7MimoSc4Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=abEViVS3; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 515HVweX000796;
	Wed, 5 Feb 2025 18:14:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=N3/TgxWVs+9amURuIjA6GRq5FPbB7J4yXlYz2oN7e
	SE=; b=abEViVS3/TzX4e6XTw01ULsj9In5RcdOzn6m3XO6xncUQPyIcV/k6Vxqx
	Ea+esY3M76L9oPcK8jL9J0gtdCiFYoFZvSBz5R3KG5LnnVn1FlTDi9yfGidyUQbb
	5S6olZEWG8cz9EXT9V2oRR4sU16CjWOnQs6HH6yWvdRggReE0EWo24E5FO6Ghurn
	FFA1+NWYf5yyOJep6sBcEsSHuI49wSrw9SEV6T1/+ogg9nc93jZ8zp1+ln4wN8kG
	TvQxPZi9FrSIsOBF2CXVbmpGMLNyVK4gpmfrH6Wj2j7FR04xCyV2KolPMzcVpGTG
	h7WWtp9fGDHgu26KbcnEAMUm+Klww==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44m3pnu45g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Feb 2025 18:14:03 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 515HVlas021493;
	Wed, 5 Feb 2025 18:14:02 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 44j0n1htty-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Feb 2025 18:14:02 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 515IDxaX33030528
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Feb 2025 18:13:59 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0BDB720143;
	Wed,  5 Feb 2025 18:13:59 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C53F620141;
	Wed,  5 Feb 2025 18:13:55 +0000 (GMT)
Received: from li-34d1fccc-27cd-11b2-a85c-c167793e56f7.ibm.com.com (unknown [9.171.42.237])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Feb 2025 18:13:55 +0000 (GMT)
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: rafael@kernel.org, viresh.kumar@linaro.org, zhenglifeng1@huawei.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        gautam@linux.ibm.com, aboorvad@linux.ibm.com
Subject: [PATCH 1/1] cpufreq: prevent NULL dereference in cpufreq_online
Date: Wed,  5 Feb 2025 23:43:47 +0530
Message-ID: <20250205181347.2079272-1-aboorvad@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: RmWeyWoMQL1qjyLhtIbtAIZbdrfxXXKk
X-Proofpoint-GUID: RmWeyWoMQL1qjyLhtIbtAIZbdrfxXXKk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-05_06,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 malwarescore=0 mlxlogscore=921 spamscore=0
 mlxscore=0 suspectscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502050138

Ensure `cpufreq_driver->set_boost` is non-NULL before using it in
`cpufreq_online` to prevent a potential NULL pointer dereference.

Reported-by: Gautam Menghani <gautam@linux.ibm.com>
Closes: https://lore.kernel.org/all/c9e56c5f54cc33338762c94e9bed7b5a0d5de812.camel@linux.ibm.com/
Fixes: dd016f379ebc ("cpufreq: Introduce a more generic way to set default per-policy boost flag")
Suggested-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
---
 drivers/cpufreq/cpufreq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index e0048856ecee..30ffbddc7ece 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1571,7 +1571,8 @@ static int cpufreq_online(unsigned int cpu)
 		policy->cdev = of_cpufreq_cooling_register(policy);
 
 	/* Let the per-policy boost flag mirror the cpufreq_driver boost during init */
-	if (policy->boost_enabled != cpufreq_boost_enabled()) {
+	if (cpufreq_driver->set_boost &&
+	    policy->boost_enabled != cpufreq_boost_enabled()) {
 		policy->boost_enabled = cpufreq_boost_enabled();
 		ret = cpufreq_driver->set_boost(policy, policy->boost_enabled);
 		if (ret) {
-- 
2.34.1



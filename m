Return-Path: <linux-pm+bounces-41155-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D8EABD3C3C5
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jan 2026 10:39:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 05E705296AD
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jan 2026 09:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C2A3D1CD1;
	Tue, 20 Jan 2026 09:26:34 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027943D1CBF
	for <linux-pm@vger.kernel.org>; Tue, 20 Jan 2026 09:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.0.225.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768901194; cv=none; b=SCsKQlSPxZOhL24zZllrVb4AQdXwH/JZ8oaHs3GL9RboyaN/KP0eiQhUddgdcMVqgiuPLSRxCo9VBtskVpNilW12NXMeRb/lBbwkPRDQHINwq6dTegOIUeAuDEiPs8JyT2V+7MfPrBahBZJyhR1G0MVJyrX0hyZ9lerIOp/kPeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768901194; c=relaxed/simple;
	bh=xlJu5A9xOOwkqCC9DLM5aKhbJ+vlNP90YEUfZ2qufBE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KnNFDPjW6KFXyYsHP4snTSQwvVFY0A4QnPrQKDj0fINCiYm/IYBxAg6F1x4eM0zhRyLMzJ+5ZJg2Y49be7oSrhr5L0sabDBghGcklkC0n1Y/26LtCyIAlHfbgdPhbDbL8Fr7JwKShLY4wluvS1EJRUSP6N8CCsf9cDRMF/I4brI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=210.0.225.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1768901178-086e2306f82bd20001-MQbzy6
Received: from ZXBJMBX03.zhaoxin.com (ZXBJMBX03.zhaoxin.com [10.29.252.7]) by mx1.zhaoxin.com with ESMTP id 4meMG5HfJDABn0zO (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Tue, 20 Jan 2026 17:26:18 +0800 (CST)
X-Barracuda-Envelope-From: TonyWWang-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.29.252.7
Received: from ZXSHMBX1.zhaoxin.com (10.28.252.163) by ZXBJMBX03.zhaoxin.com
 (10.29.252.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.59; Tue, 20 Jan
 2026 17:26:11 +0800
Received: from ZXSHMBX1.zhaoxin.com ([fe80::936:f2f9:9efa:3c85]) by
 ZXSHMBX1.zhaoxin.com ([fe80::936:f2f9:9efa:3c85%7]) with mapi id
 15.01.2507.059; Tue, 20 Jan 2026 17:26:11 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.29.252.7
Received: from tony.zhaoxin.com (10.32.64.8) by ZXBJMBX03.zhaoxin.com
 (10.29.252.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.59; Tue, 20 Jan
 2026 17:24:46 +0800
From: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <CobeChen@zhaoxin.com>, <TimGuo@zhaoxin.com>, <LeoLiu-oc@zhaoxin.com>,
	<LindaChai@zhaoxin.com>
Subject: [PATCH] cpufreq: Add CPU frequency policy change notification support
Date: Tue, 20 Jan 2026 17:24:45 +0800
X-ASG-Orig-Subj: [PATCH] cpufreq: Add CPU frequency policy change notification support
Message-ID: <20260120092445.5711-1-TonyWWang-oc@zhaoxin.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 ZXBJMBX03.zhaoxin.com (10.29.252.7)
X-Moderation-Data: 1/20/2026 5:26:10 PM
X-Barracuda-Connect: ZXBJMBX03.zhaoxin.com[10.29.252.7]
X-Barracuda-Start-Time: 1768901178
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://mx2.zhaoxin.com:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 1486
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.153305
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------

Implemented CPUFREQ_CHANGE_POLICY notification in cpufreq subsystem.
This enhancement allows kernel modules to be notified when a CPU frequency
policy is modified, facilitating more integrated system management.
The notification is dispatched after a successful governor switch during
policy updates.

Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
---
 drivers/cpufreq/cpufreq.c | 2 ++
 include/linux/cpufreq.h   | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index a7a69f4d7675..b35fed93bca4 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2707,6 +2707,8 @@ static int cpufreq_set_policy(struct cpufreq_policy *=
policy,
 		ret =3D cpufreq_start_governor(policy);
 		if (!ret) {
 			pr_debug("governor change\n");
+			blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
+						     CPUFREQ_CHANGE_POLICY, policy);
 			return 0;
 		}
 		cpufreq_exit_governor(policy);
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index cc894fc38971..b1cc9138e801 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -528,6 +528,7 @@ static inline void cpufreq_resume(void) {}
 /* Policy Notifiers  */
 #define CPUFREQ_CREATE_POLICY		(0)
 #define CPUFREQ_REMOVE_POLICY		(1)
+#define CPUFREQ_CHANGE_POLICY		(2)
=20
 #ifdef CONFIG_CPU_FREQ
 int cpufreq_register_notifier(struct notifier_block *nb, unsigned int list=
);
--=20
2.25.1



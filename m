Return-Path: <linux-pm+bounces-18789-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A99FE9E897C
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 04:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98405164296
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 03:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6ACCBA3D;
	Mon,  9 Dec 2024 03:22:40 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914C83D76;
	Mon,  9 Dec 2024 03:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733714560; cv=none; b=lXWeNh1P3bTGWpdMuapl3g4Irv7mPqbdzmjKAOMU6LTNkZePDqKhpg2jedr9jXst6HmTBuQVq/BzSnOFmUIBROIo5Zs4Hsb4IkVKm/b9oKbMj3U8KIrQy3w/B8EqH1hHBTBr6YIuIIG872MjK4hkhsfOefW8sPiw9eHKEUvSuh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733714560; c=relaxed/simple;
	bh=pxVjJM3xlHmqsLWloFW4wOs0kH3D8fuPRBOZEI5nH0Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CBG1eaM/2aerDKEsEzYvHBqWA0Tb3bV5bKDW+xWeSt3xv4jxmysTSZCz29YO8KFoLwS33390tbtaI3Npo+TIpeq6meX1aT8O4z9+EfrbupewL0BCB/EL44U0T21Arx9MN55Zc0xPtggUyOBV6GmfYu+Bk1UHpZxecXIpHhrqtHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B92mSeA022681;
	Sun, 8 Dec 2024 19:22:01 -0800
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 43cwy1rxan-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Sun, 08 Dec 2024 19:22:01 -0800 (PST)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Sun, 8 Dec 2024 19:22:00 -0800
Received: from pek-lpg-core1.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Sun, 8 Dec 2024 19:21:58 -0800
From: <jianqi.ren.cn@windriver.com>
To: <abelova@astralinux.ru>, <gregkh@linuxfoundation.org>
CC: <stable@vger.kernel.org>, <ray.huang@amd.com>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 6.1.y] cpufreq: amd-pstate: add check for cpufreq_cpu_get's return value
Date: Mon, 9 Dec 2024 12:19:51 +0800
Message-ID: <20241209041951.3426114-1-jianqi.ren.cn@windriver.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Sb_mQFmYe82WDyHr2viYZ8j8kk4LHgQw
X-Authority-Analysis: v=2.4 cv=eePHf6EH c=1 sm=1 tr=0 ts=67566259 cx=c_pps a=K4BcnWQioVPsTJd46EJO2w==:117 a=K4BcnWQioVPsTJd46EJO2w==:17 a=RZcAm9yDv7YA:10 a=KP9VF9y3AAAA:8 a=HH5vDtPzAAAA:8 a=zd2uoN0lAAAA:8 a=KKAkSRfTAAAA:8 a=t7CeM3EgAAAA:8
 a=T-_msMMreK8bA51VSmQA:9 a=4w0yzETBtB_scsjRCo-X:22 a=QM_-zKB-Ew0MsOlNKMB5:22 a=cvBusfyB2V15izCimMoJ:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: Sb_mQFmYe82WDyHr2viYZ8j8kk4LHgQw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-08_11,2024-12-06_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501
 spamscore=0 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2411120000 definitions=main-2412090025

From: Anastasia Belova <abelova@astralinux.ru>

[ Upstream commit 5493f9714e4cdaf0ee7cec15899a231400cb1a9f ]

cpufreq_cpu_get may return NULL. To avoid NULL-dereference check it
and return in case of error.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
Reviewed-by: Perry Yuan <perry.yuan@amd.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Jianqi Ren <jianqi.ren.cn@windriver.com>
---
 drivers/cpufreq/amd-pstate.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 90dcf26f0973..106aef210003 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -309,9 +309,14 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
 	unsigned long max_perf, min_perf, des_perf,
 		      cap_perf, lowest_nonlinear_perf, max_freq;
 	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
-	struct amd_cpudata *cpudata = policy->driver_data;
+	struct amd_cpudata *cpudata;
 	unsigned int target_freq;
 
+	if (!policy)
+		return;
+
+	cpudata = policy->driver_data;
+
 	cap_perf = READ_ONCE(cpudata->highest_perf);
 	lowest_nonlinear_perf = READ_ONCE(cpudata->lowest_nonlinear_perf);
 	max_freq = READ_ONCE(cpudata->max_freq);
-- 
2.25.1



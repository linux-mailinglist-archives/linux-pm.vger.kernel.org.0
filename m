Return-Path: <linux-pm+bounces-31208-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0CE8B0C449
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 14:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C11E1AA227F
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 12:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E642D5A04;
	Mon, 21 Jul 2025 12:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ht5jarW3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06762D5A19;
	Mon, 21 Jul 2025 12:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753101722; cv=none; b=Dl20CS2SnVdCHIjE1KXsYjjZ0d8qco2PmfjBP4L5unbzlIZCWpgUXBEDm065JN8PjPSJMypohR6K3nRon7N7NQ+Hhtx6v2THXhWk6nYkROxbum9gT35rycISIWH8QGedS64SjqP5AXGWIt6nsQvNiiG2BCtIRvJCDmTT2IvZoFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753101722; c=relaxed/simple;
	bh=oXq2pB+fx59/NhTUlH8KT9gRtGuAabW6XMQl5gp5MFI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uG+tttEO/jSXH0mv1PtJtzIrJTAnUjsnmCOFIh9/W6CY9uv8p3RtDRlc7Q8Frk3a/5CBKGIW8MeRmDpajkhfmvqkZyUkqs2271mpsR501vX4t06xKyjmc/FNo8fwdBf/Z0+uDOt9PWQCeGVcQHRNXUmsbaIL2nOLIRhvrccFlzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ht5jarW3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56LAI8po000902;
	Mon, 21 Jul 2025 12:41:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1Ql3MhLlWSmZVDLj1v+Nf2U93SFaRmXviMo7cDR5L+s=; b=ht5jarW3cIxGWDMa
	89wRJ9zjbM0FsNaDB20A662rJp/FZ+4VGM83o1Lb0KX47C9TkE1W6suMV9y4n7aC
	KnADOJTzP9lCdyTThZsetL0muFew9mCnrvwRhgAvwUzl+yiccGndHT2zRmcfmwab
	ZImmy9eZfGqkrjENRT2HqllufZdr9x+YeLSpSbgyL9uDPfbRyKsWhyIGJhD4L4UK
	Q3LuoqJzqIpE3mWPbbK8MF9ICZPX4EBLbg6+I4o8lRt7dgSSo0fVY6FTVPay+7G4
	JN4lSpxF+Y2Utj2P7MuaJvi9ECo+IG8tvGpfLEQGZptqrjLTLl2KJwizmm4Q98CH
	IbG3cg==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48044dd1um-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Jul 2025 12:41:52 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56LCfp6V002289
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Jul 2025 12:41:51 GMT
Received: from zhonhan-gv.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 21 Jul 2025 05:41:48 -0700
From: Zhongqiu Han <quic_zhonhan@quicinc.com>
To: <rafael@kernel.org>, <lenb@kernel.org>, <pavel@kernel.org>,
        <tony.luck@intel.com>, <reinette.chatre@intel.com>,
        <Dave.Martin@arm.com>, <james.morse@arm.com>, <ulf.hansson@linaro.org>,
        <amit.kucheria@linaro.org>, <christian.loehle@arm.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_zhonhan@quicinc.com>
Subject: [PATCH v2 5/5] resctrl: Replace PM QoS logic with cpu_affinity_latency_qos_* helpers
Date: Mon, 21 Jul 2025 20:41:04 +0800
Message-ID: <20250721124104.806120-6-quic_zhonhan@quicinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250721124104.806120-1-quic_zhonhan@quicinc.com>
References: <20250721124104.806120-1-quic_zhonhan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=BJ6zrEQG c=1 sm=1 tr=0 ts=687e3590 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=tAw3UdR0-tMnE-oq3cEA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: L-E2Bej92DRaPOnHhqroaeaIYjBZ675a
X-Proofpoint-ORIG-GUID: L-E2Bej92DRaPOnHhqroaeaIYjBZ675a
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDExMiBTYWx0ZWRfX2hX+tsfOR8+L
 CrsHM67GJZ+LpPI1djbqRT2aC6RiN3yJbF/z5/CSB9PsMOD7cwFtkgadwRmhUxYYKgeIMj3vUbY
 OhcgGo+r24B738cmVPKCa6I9v8WCqYOVdwZFdsPXV/iwxgz8wBGX/P7njCzq2z8Pem5A2TH843M
 7WaIbUEtjIElXdurWGznhvgzqBBCMqdx0j5HKUCiqYt+SKFSj3IckWugB/zyB0YuxrrEZ+7JCtE
 UmQEhL7K/94d0CWM+srWsbwtxKAT14zoy2+dYV/NuqfOlvNztzcF3gqGyS8gHBmjC66PIxeS2M7
 msTzm4vIzxoTZmWdjxW+7hxDWNHMjgM9UM7T26hvYo90o9h0mqenrepcEWO/U82pyGwoGK/gG4E
 Fid9JDgRN5gLMO+OlqeSOG8aGXkMexXCVOicSxMi+AhUlP+vnqWXNte7GtpN8m0ByK9X/cyJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_03,2025-07-21_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 spamscore=0
 mlxlogscore=999 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0
 mlxscore=0 malwarescore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507210112

Use cpu_affinity_latency_qos_* helpers to replace the dev_pm_qos_request
handling for CPU masks in pseudo-locking.

These helpers encapsulate latency QoS operations for a group of CPUs,
providing a consistent mechanism for request addition, removal, and error
handling. This improves code clarity and maintainability. As resctrlfs is
used on different platforms, a unified interface also makes it easier to
adapt to platform-specific CPU masks and latency QoS values.

The only functional change, and a beneficial one, is that when the latency
QoS value is updated for a CPU in the mask, the interface will actively
wake up that CPU to ensure the QoS setting takes effect immediately. This
helps enforce latency constraints in a timely manner on
performance-critical paths.

Signed-off-by: Zhongqiu Han <quic_zhonhan@quicinc.com>
---
 fs/resctrl/pseudo_lock.c | 51 +++-------------------------------------
 include/linux/resctrl.h  |  3 ++-
 2 files changed, 5 insertions(+), 49 deletions(-)

diff --git a/fs/resctrl/pseudo_lock.c b/fs/resctrl/pseudo_lock.c
index 87bbc2605de1..8be3ae804af9 100644
--- a/fs/resctrl/pseudo_lock.c
+++ b/fs/resctrl/pseudo_lock.c
@@ -108,25 +108,9 @@ static struct rdtgroup *region_find_by_minor(unsigned int minor)
 	return rdtgrp_match;
 }
 
-/**
- * struct pseudo_lock_pm_req - A power management QoS request list entry
- * @list:	Entry within the @pm_reqs list for a pseudo-locked region
- * @req:	PM QoS request
- */
-struct pseudo_lock_pm_req {
-	struct list_head list;
-	struct dev_pm_qos_request req;
-};
-
 static void pseudo_lock_cstates_relax(struct pseudo_lock_region *plr)
 {
-	struct pseudo_lock_pm_req *pm_req, *next;
-
-	list_for_each_entry_safe(pm_req, next, &plr->pm_reqs, list) {
-		dev_pm_qos_remove_request(&pm_req->req);
-		list_del(&pm_req->list);
-		kfree(pm_req);
-	}
+	cpu_affinity_latency_qos_remove(&plr->pm_reqs);
 }
 
 /**
@@ -149,36 +133,8 @@ static void pseudo_lock_cstates_relax(struct pseudo_lock_region *plr)
  */
 static int pseudo_lock_cstates_constrain(struct pseudo_lock_region *plr)
 {
-	struct pseudo_lock_pm_req *pm_req;
-	int cpu;
-	int ret;
-
-	for_each_cpu(cpu, &plr->d->hdr.cpu_mask) {
-		pm_req = kzalloc(sizeof(*pm_req), GFP_KERNEL);
-		if (!pm_req) {
-			rdt_last_cmd_puts("Failure to allocate memory for PM QoS\n");
-			ret = -ENOMEM;
-			goto out_err;
-		}
-		ret = dev_pm_qos_add_request(get_cpu_device(cpu),
-					     &pm_req->req,
-					     DEV_PM_QOS_RESUME_LATENCY,
-					     30);
-		if (ret < 0) {
-			rdt_last_cmd_printf("Failed to add latency req CPU%d\n",
-					    cpu);
-			kfree(pm_req);
-			ret = -1;
-			goto out_err;
-		}
-		list_add(&pm_req->list, &plr->pm_reqs);
-	}
-
-	return 0;
-
-out_err:
-	pseudo_lock_cstates_relax(plr);
-	return ret;
+	return cpu_affinity_latency_qos_add(&plr->pm_reqs, &plr->d->hdr.cpu_mask,
+					    30);
 }
 
 /**
@@ -275,7 +231,6 @@ static int pseudo_lock_init(struct rdtgroup *rdtgrp)
 		return -ENOMEM;
 
 	init_waitqueue_head(&plr->lock_thread_wq);
-	INIT_LIST_HEAD(&plr->pm_reqs);
 	rdtgrp->plr = plr;
 	return 0;
 }
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 6fb4894b8cfd..521fe70b0425 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -6,6 +6,7 @@
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/pid.h>
+#include <linux/pm_qos.h>
 #include <linux/resctrl_types.h>
 
 #ifdef CONFIG_ARCH_HAS_CPU_RESCTRL
@@ -108,7 +109,7 @@ struct pseudo_lock_region {
 	void			*kmem;
 	unsigned int		minor;
 	struct dentry		*debugfs_dir;
-	struct list_head	pm_reqs;
+	struct cpu_affinity_qos_req	pm_reqs;
 };
 
 /**
-- 
2.43.0



Return-Path: <linux-pm+bounces-26739-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3B3AAC8C3
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 16:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B9D8980A03
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 14:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7731328151F;
	Tue,  6 May 2025 14:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="a+5JjxOv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8422F280006;
	Tue,  6 May 2025 14:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746543139; cv=none; b=Masmr7QFlsuaFO2pVxbf+DhOmYY4ViEeN+862/RgZuYxB5oSLNC/3ZmajsFqbm1MKakdwJvHUF4UR9m4T5+L+FDcDY2NE4rZif6C6VdUU2jHixWRIdeHzZPGuvQwIr4Yw4+GQv5t3PMldYyR6b9QrHA5dr/kn8juB/Z/UltjYt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746543139; c=relaxed/simple;
	bh=Xc8uV93DtLs7S8IMFtDcMlDXGM60gIa3A536pCU0bWA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OEOmDgpuJAINsimJEcMyN/v3qr4eVexOchjpxo6ttz8AsnQp72hIOM+MnKMBnDDJlHQjZMhBLySudrtguKyyjQGu6IS1QTG1sxsVL09+H9i3IW6S0OhMMNdgjn4mwWNVWMOIB8LuihhKsxAwihr2qEBTXubnR9PeV69Q5oude88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=a+5JjxOv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5468e2fb014186;
	Tue, 6 May 2025 14:52:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=XEcBsARco6QpGU97OKN38n
	oBlqXGcNH/7Y9jiSHXa3w=; b=a+5JjxOvgmw0IAJ+T9ro7IfwK6ukRB0Q9MFhxK
	eXfReiOk7JUOTOwUSuSnlxMk+BE4ux7rmNmePzBDvWnfAhNFOOBIxlJqAPTtStdC
	oM1j5lCE/jwODeBWpLCRGIDdXlErJvcsseQa9G0Le7IYgu0boupVn6xEgbPSVz7V
	J7Na+Va492LnHIYjT0OVyPjIZxNVV06VR12e94olaiq9a0LL1TpA3v6XaMgbEfH7
	r/PAUi10X2iZEYNqSep/7ciUVJt/UdnF3OosAtXForrdhDElUgQ/aE6fHu/+6wkp
	3PEL/injLqt6yaGcm6HMPLuR29IoxkavM9sOop7YliXmbcmw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46f5u42pc6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 May 2025 14:52:13 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 546EqCgU016570
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 6 May 2025 14:52:12 GMT
Received: from hu-mdtipton-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 6 May 2025 07:52:12 -0700
From: Mike Tipton <quic_mdtipton@quicinc.com>
To: Georgi Djakov <djakov@kernel.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_aiquny@quicinc.com>, <quic_okukatla@quicinc.com>,
        Mike Tipton
	<quic_mdtipton@quicinc.com>
Subject: [PATCH v2] interconnect: Use rt_mutex for icc_bw_lock
Date: Tue, 6 May 2025 07:51:59 -0700
Message-ID: <20250506145159.1951159-1-quic_mdtipton@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=KcfSsRYD c=1 sm=1 tr=0 ts=681a221d cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=3H110R4YSZwA:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8
 a=COk6AnOGAAAA:8 a=KKAgPzKmHZGUr0HHQOcA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: E99k0zjUfBrwcWG18iapbR3Gj7wivgLU
X-Proofpoint-ORIG-GUID: E99k0zjUfBrwcWG18iapbR3Gj7wivgLU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA2MDE0MyBTYWx0ZWRfX4uA8awaLCExb
 b12WrXAvTy9fpA13NSJL1IRBEGEFA9NjicJ+pggjcxobmA2byqFS2hZ7CvIcUyDin78zfqKszRP
 i7cUJL7ND45wSlzbAZZh7Thuw6LBRPmdlWCIDSY3L6Qd4PYTokehb2s24wl7Yza4uGSGfI7MKsi
 F0zUmFcZaHkgjpPj8CILO0antMfE7a8kbpnZg4JdE6mCXH0rJwSxHMX0JdXLfclZGvzZxAwZv7P
 esafO3lC6DeIxm8hag9Tftzm0PcKMZIInDQWaeq1Mg6HeLdV9eZcGir+xikuh2pxQMiDBzl2yMQ
 Li7cuanvEiXlaErWb5QDZlZYFKaN9hOFiiaH0TDXplaZQva6OE0CiPIwu5xDyOeNKlm4t/H+Um4
 kmZvYYEhx3h9CWRigPwkJ4tDmjC3k33I3rpMY+WQtNFioxsIcl+Cy/MsQOyS/FR6bRcSEVHj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-06_06,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 impostorscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 clxscore=1015 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505060143

The icc_set_bw() function is often used in latency sensitive paths to
scale BW on a per-frame basis by high priority clients such as GPU and
display. However, there are many low priority clients of icc_set_bw() as
well. This can lead to priority inversion and unacceptable delays for
the high priority clients. Which in the case of GPU and display can
result in frame drops and visual glitches.

To prevent this priority inversion, switch to using rt_mutex for
icc_bw_lock. This isn't needed for icc_lock since that's not used in the
critical, latency-sensitive voting paths.

Signed-off-by: Mike Tipton <quic_mdtipton@quicinc.com>
---

Since the original patch was posted a couple years ago, we've continued
to hit this for display and now for GPU as well. How frequently depends
heavily on the specific chip, product, and use case. Different
configurations hit it easier than others. But for both cases it results
in obvious visual glitches.

The paths being voted for (primarily DDR) are fundamentally shared
between clients of all types and priority levels. We can't control their
priorities, so aside from having those priorities inherited we're always
subject to these sorts of inversions.

The motivation isn't really for general performance improvement, but
instead to fix the rare cases of visual glitches and artifacts.

A similar patch was posted last year [1] to address similar problems.

[1] https://lore.kernel.org/all/20240220074300.10805-1-wangrumeng@xiaomi.corp-partner.google.com/

Changes in v2:
- Rebase onto linux-next.
- Select RT_MUTEXES in Kconfig.
- Only use rt_mutex for icc_bw_lock since now there are separate locks
  and icc_lock isn't in the critical path.
- Reword commit text.
- Link to v1: https://lore.kernel.org/all/20220906191423.30109-1-quic_mdtipton@quicinc.com/

 drivers/interconnect/Kconfig |  1 +
 drivers/interconnect/core.c  | 23 ++++++++++++-----------
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/interconnect/Kconfig b/drivers/interconnect/Kconfig
index f2e49bd97d31..f6fd5f2d7d40 100644
--- a/drivers/interconnect/Kconfig
+++ b/drivers/interconnect/Kconfig
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 menuconfig INTERCONNECT
 	bool "On-Chip Interconnect management support"
+	select RT_MUTEXES
 	help
 	  Support for management of the on-chip interconnects.
 
diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 1a41e59c77f8..2e86a3c95d1a 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -14,6 +14,7 @@
 #include <linux/interconnect-provider.h>
 #include <linux/list.h>
 #include <linux/mutex.h>
+#include <linux/rtmutex.h>
 #include <linux/slab.h>
 #include <linux/of.h>
 #include <linux/overflow.h>
@@ -30,7 +31,7 @@ static LIST_HEAD(icc_providers);
 static int providers_count;
 static bool synced_state;
 static DEFINE_MUTEX(icc_lock);
-static DEFINE_MUTEX(icc_bw_lock);
+static DEFINE_RT_MUTEX(icc_bw_lock);
 static struct dentry *icc_debugfs_dir;
 
 static void icc_summary_show_one(struct seq_file *s, struct icc_node *n)
@@ -178,7 +179,7 @@ static struct icc_path *path_init(struct device *dev, struct icc_node *dst,
 
 	path->num_nodes = num_nodes;
 
-	mutex_lock(&icc_bw_lock);
+	rt_mutex_lock(&icc_bw_lock);
 
 	for (i = num_nodes - 1; i >= 0; i--) {
 		node->provider->users++;
@@ -190,7 +191,7 @@ static struct icc_path *path_init(struct device *dev, struct icc_node *dst,
 		node = node->reverse;
 	}
 
-	mutex_unlock(&icc_bw_lock);
+	rt_mutex_unlock(&icc_bw_lock);
 
 	return path;
 }
@@ -704,7 +705,7 @@ int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw)
 	if (WARN_ON(IS_ERR(path) || !path->num_nodes))
 		return -EINVAL;
 
-	mutex_lock(&icc_bw_lock);
+	rt_mutex_lock(&icc_bw_lock);
 
 	old_avg = path->reqs[0].avg_bw;
 	old_peak = path->reqs[0].peak_bw;
@@ -736,7 +737,7 @@ int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw)
 		apply_constraints(path);
 	}
 
-	mutex_unlock(&icc_bw_lock);
+	rt_mutex_unlock(&icc_bw_lock);
 
 	trace_icc_set_bw_end(path, ret);
 
@@ -798,7 +799,7 @@ void icc_put(struct icc_path *path)
 		pr_err("%s: error (%d)\n", __func__, ret);
 
 	mutex_lock(&icc_lock);
-	mutex_lock(&icc_bw_lock);
+	rt_mutex_lock(&icc_bw_lock);
 
 	for (i = 0; i < path->num_nodes; i++) {
 		node = path->reqs[i].node;
@@ -807,7 +808,7 @@ void icc_put(struct icc_path *path)
 			node->provider->users--;
 	}
 
-	mutex_unlock(&icc_bw_lock);
+	rt_mutex_unlock(&icc_bw_lock);
 	mutex_unlock(&icc_lock);
 
 	kfree(path->name);
@@ -1023,7 +1024,7 @@ void icc_node_add(struct icc_node *node, struct icc_provider *provider)
 		return;
 
 	mutex_lock(&icc_lock);
-	mutex_lock(&icc_bw_lock);
+	rt_mutex_lock(&icc_bw_lock);
 
 	node->provider = provider;
 	list_add_tail(&node->node_list, &provider->nodes);
@@ -1056,7 +1057,7 @@ void icc_node_add(struct icc_node *node, struct icc_provider *provider)
 	node->avg_bw = 0;
 	node->peak_bw = 0;
 
-	mutex_unlock(&icc_bw_lock);
+	rt_mutex_unlock(&icc_bw_lock);
 	mutex_unlock(&icc_lock);
 }
 EXPORT_SYMBOL_GPL(icc_node_add);
@@ -1182,7 +1183,7 @@ void icc_sync_state(struct device *dev)
 		return;
 
 	mutex_lock(&icc_lock);
-	mutex_lock(&icc_bw_lock);
+	rt_mutex_lock(&icc_bw_lock);
 	synced_state = true;
 	list_for_each_entry(p, &icc_providers, provider_list) {
 		dev_dbg(p->dev, "interconnect provider is in synced state\n");
@@ -1195,7 +1196,7 @@ void icc_sync_state(struct device *dev)
 			}
 		}
 	}
-	mutex_unlock(&icc_bw_lock);
+	rt_mutex_unlock(&icc_bw_lock);
 	mutex_unlock(&icc_lock);
 }
 EXPORT_SYMBOL_GPL(icc_sync_state);
-- 
2.34.1



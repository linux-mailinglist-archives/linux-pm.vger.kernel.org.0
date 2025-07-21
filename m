Return-Path: <linux-pm+bounces-31206-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BFE1B0C445
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 14:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 604101AA22CD
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 12:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A375C2D59F7;
	Mon, 21 Jul 2025 12:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VfByTHY/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042502D59EF;
	Mon, 21 Jul 2025 12:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753101715; cv=none; b=I9E0JRHdnjt+D0lDlvAy5vObHmcdw+5IcDm5xrk5QQrdPOuplrM4O/qbnyxA1xqHYhKbVdaieyCsFyHWhM3bQdnYY5SItywoiJhIObneHCjmiJrKU+aAatRX81BZQj74Ho4lF3mmcN31i6JXh/YWBpKOAjhDg9e2MbAH07LAgCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753101715; c=relaxed/simple;
	bh=lAZPNUeeuhhsP5b0+OmxKzK/GjGMxwF1LiTfBK38Ofw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SuqA+YedFMsCrI49Y8ho6X53w5w9mh2ofFnrNm8taUkwpDYq5xXMnP6Fif+NOEKy6TtRurWsSW/G0oaoQceptm82se4+Sg4LkSLNKyiatZfPl3AX6qw0jq8bshjb+mJewfI0t75+Iq9lt3NMnq/GlIAgD6zWgzSek5IM62X/6tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VfByTHY/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56LAWE8j015737;
	Mon, 21 Jul 2025 12:41:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lZfSS9a2l7X18pJgkXw1vbBprrrii+uTqrpX09plhr0=; b=VfByTHY/HMShgMIr
	x4fp5cVi8QyTJpmGUXLHLQR6TlPVmJd7BULDqyADxqodL7d2zoyYQ5YGpGv4PSGk
	FACszzqc/jjdigT/jlGXD6qQ1P2Igb1tHpmUIlI6vM7CnhuUqP295hDlgPwmbtbV
	sBNKJBVrD92Kzys+nW9eVWZzLwTyW9htsHqCB9U+PHScn6ZQWk16TFszX33o5Nu6
	iqThCK2LI7B9W9XQvhYcYZ6viyNuGAMfUzkI52DUK4mo0+EJmE4Tn6BEbBZJo/zt
	GlX815w3cfNtsKyVaPV+Csm9ubviEuxM0Ndtl8K7hWOjc1D+BRdZ11PI+6+EZISk
	H6NCWg==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 480451d123-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Jul 2025 12:41:46 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56LCfjwX002213
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Jul 2025 12:41:45 GMT
Received: from zhonhan-gv.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 21 Jul 2025 05:41:42 -0700
From: Zhongqiu Han <quic_zhonhan@quicinc.com>
To: <rafael@kernel.org>, <lenb@kernel.org>, <pavel@kernel.org>,
        <tony.luck@intel.com>, <reinette.chatre@intel.com>,
        <Dave.Martin@arm.com>, <james.morse@arm.com>, <ulf.hansson@linaro.org>,
        <amit.kucheria@linaro.org>, <christian.loehle@arm.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_zhonhan@quicinc.com>
Subject: [PATCH v2 3/5] Documentation: PM: QoS: Add CPU affinity latency PM QoS Interface documentation
Date: Mon, 21 Jul 2025 20:41:02 +0800
Message-ID: <20250721124104.806120-4-quic_zhonhan@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=EIMG00ZC c=1 sm=1 tr=0 ts=687e358a cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=jR7MCmn6jQT2zHobaZIA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: ub5fD4xF7k6-1WrxgLLlbm3LQFoYOlfI
X-Proofpoint-GUID: ub5fD4xF7k6-1WrxgLLlbm3LQFoYOlfI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDExMiBTYWx0ZWRfX/KEBGx9hzkxS
 cJj0+092j01tiXYytWSzVn5AW3AS8WnsNXVLa7bCGju9rrzob7689pdYkAYRu8WrZjliBEqjRBD
 vJK5qtBLdeSxRwii9UH/va+glsEFGejFBXFMxYU0PEVDcQpZYclqA7U0Qs8uLQYCLlKoV72JOcy
 1WyoYwl3L+hQmHY72HZ+XiMlWQM6RJ6Fth0L9bCUcDkNw0GjGkzNNb5o24VSyUUd5uupJWNiTOJ
 Edxbs//b7yB4fCqpTUOKZve2KA73iCHhV7zhPT5lew8ZN92PPPxy38UBXt/pVPnX2dxP8kFcv4k
 fDFEDlHTwXZKe6gO9KeW8qtKuYu3byq0mneyEOc6JA2y8Q5oR3cWnvuUxSuZ6PCUZ6jyraWSPPm
 2cYhRisLoDGgjYM8c6mue9otf8Kp0m56Q9bRfbs15Np67T2z5YwxMtXh9xFZxFSakvoRa667
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_03,2025-07-21_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 mlxlogscore=999 phishscore=0 mlxscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507210112

Adds documentation for the CPU affinity latency PM QoS interface, enabling
latency constraints to be applied to specific CPUs according to a defined
CPU mask.

Signed-off-by: Zhongqiu Han <quic_zhonhan@quicinc.com>
---
 Documentation/power/pm_qos_interface.rst | 57 ++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/Documentation/power/pm_qos_interface.rst b/Documentation/power/pm_qos_interface.rst
index 5019c79c7710..1ede4cafc2e3 100644
--- a/Documentation/power/pm_qos_interface.rst
+++ b/Documentation/power/pm_qos_interface.rst
@@ -17,6 +17,13 @@ The latency unit used in the PM QoS framework is the microsecond (usec).
 1. PM QoS framework
 ===================
 
+For CPU latency QoS, there are two types of interfaces: one is the global CPU
+latency QoS interface, and the other is the CPU affinity latency QoS, where the
+CPU is determined by the CPU affinity mask, which can apply to part or all of
+the CPUs.
+
+1) Global CPU latency QoS interface:
+
 A global list of CPU latency QoS requests is maintained along with an aggregated
 (effective) target value.  The aggregated target value is updated with changes
 to the request list or elements of the list.  For CPU latency QoS, the
@@ -76,6 +83,56 @@ cpu_latency_qos_update_request() call.
 To remove the user mode request for a target value simply close the device
 node.
 
+2) CPU affinity latency QoS interface:
+
+The Global CPU latency QoS interface can easily limit the latency for all CPUs.
+If we want to limit the CPU latency for partial CPUs specified by a CPU
+affinity mask, we can use the CPU affinity latency QoS interface. Currently,
+this is only supported for kernel users. This will only prevent the CPUs
+specified by the mask from entering C states. Typically, some threads or
+drivers know which specific CPUs they are interested in. For example, drivers
+with IRQ affinity only want interrupts to wake up and be handled on specific
+CPUs. Similarly, kernel thread bound to specific CPUs through affinity only
+care about the latency of those particular CPUs.
+
+It allows flexible and precise latency QoS settings for specific CPUs. This can
+help save power, especially on heterogeneous platforms with big and little cores,
+as well as power-conscious embedded systems. For example:
+
+                         driver A       rt kthread B      module C
+    CPU IDs (mask):        0-3              2-5              6-7
+    target latency(us):    20               30               100
+                            |                |                |
+                            v                v                v
+                            +---------------------------------+
+                            |        PM  QoS  Framework       |
+                            +---------------------------------+
+                            |                |                |
+                            v                v                v
+    CPU IDs (mask):        0-3            2-3,4-5            6-7
+    runtime latency(us):   20              20,30             100
+
+The usage of kernel space is:
+
+int cpu_affinity_latency_qos_add(handle, affinity_mask, latency_value);
+  Will insert an element into the CPUs specified by the affinity_mask latency
+  QoS list with the target value. Upon change to this list the new target is
+  recomputed. Clients of PM QoS need to save the returned handle for future use
+  in other PM QoS API functions.
+
+int cpu_affinity_latency_qos_remove(handle);
+  Will remove the element. After removal it will update the aggregate target
+  and call the notification tree if the target was changed as a result of
+  removing the request.
+
+bool cpu_affinity_latency_qos_active(handle);
+  Returns true if the request is still active, i.e. it has not been removed from
+  the CPU latency QoS list.
+
+Note:
+a) The CPU affinity latency QoS interface uses a mutex, which might sleep.
+b) Use dev_pm_qos_raw_resume_latency(device) to read the CPU latency set by the
+   above interface, by passing the CPU device.
 
 2. PM QoS per-device latency and flags framework
 ================================================
-- 
2.43.0



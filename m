Return-Path: <linux-pm+bounces-31203-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE602B0C43E
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 14:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D2C73A5D57
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 12:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9593F2D3EE5;
	Mon, 21 Jul 2025 12:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WbVDa2fG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD952D3EC4;
	Mon, 21 Jul 2025 12:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753101707; cv=none; b=F4N1WGRl4lPnRVZmRU6tMchm6weSToTexVbFBybQtijHhEwZSCMg52SAsK423Q+aZCRf7p9io/nZjfWsoiwZ5hP/1JqpZJOKGTbkB/eahcU8drdnwa6h4nghMzC9XrAYaDMJYd1dHI+U7r6SeC9OywIIfb5GAmJGnzelspv2eT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753101707; c=relaxed/simple;
	bh=yI/mzFx2WGKaNJf2JxXpZ1YojEPx8LvSZB2nNfi8ZcI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=S7BxxHYLJ6oa7KIZSQO6pptbpXi1CbJxzixBsdiFKDhBOZnNamElHHb2gvBnpuG5qCcua/FbyjrRV510OaWN0S9s9dBk2lLzqyD9RoRzlIAIeFCigEqLUjAjJpzkh93zZ3Qpzjgr2BnHh+NmaXyH4CINGFDaJGV8uCne+n7Nha0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WbVDa2fG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56LABHCb005502;
	Mon, 21 Jul 2025 12:41:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=kfWWTca2fzeLKVm+Cn6N8r
	ec5popA7lBheSLmQOvEDY=; b=WbVDa2fGPhdEaigxO7vfQS3+8CBwHS2ZxPFc9e
	BU8PoUTc+bAkZppUOf385fJ2sgbx7YdXcLfuIjQZTE+QJCOfxZoux+F6qOEBfrs0
	IfXj5nbnzK4osh0g25+OAqQ7V6GUAwMsq0demlrfXXcOPHEVy2+7145JZtr1FyOU
	LL7NLGCuafsOHBo8m22jXZQ+XJpBlIIQjmFI2ziFS7J9sR9Hsa7NfmKxqJfW4udI
	h0/jTNacqQP4tKKZ71xoVfludTvQ5fm1Mr9/vrqrHjNFQ/PuLTlCo6Mo1dM5YSEd
	FRehu8ZW2ZBXjAMDkJjMrIjQWmBRSUSOVGBqTtCxIYKKfnPg==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48047q53rp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Jul 2025 12:41:36 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56LCfZ0p013897
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Jul 2025 12:41:35 GMT
Received: from zhonhan-gv.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 21 Jul 2025 05:41:32 -0700
From: Zhongqiu Han <quic_zhonhan@quicinc.com>
To: <rafael@kernel.org>, <lenb@kernel.org>, <pavel@kernel.org>,
        <tony.luck@intel.com>, <reinette.chatre@intel.com>,
        <Dave.Martin@arm.com>, <james.morse@arm.com>, <ulf.hansson@linaro.org>,
        <amit.kucheria@linaro.org>, <christian.loehle@arm.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_zhonhan@quicinc.com>
Subject: [PATCH v2 0/5] PM QoS: Add CPU affinity latency QoS support and resctrl integration
Date: Mon, 21 Jul 2025 20:40:59 +0800
Message-ID: <20250721124104.806120-1-quic_zhonhan@quicinc.com>
X-Mailer: git-send-email 2.43.0
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDExMiBTYWx0ZWRfX/scfzge+e47J
 IlkLJrd/4AEuEq1KttmmXjSGUAOCHWt4g/HUFo0tDoLrbuFQwdqOO88EpF/rEYecnifgQNEksAO
 ErcWivDJ28ewAJ6moN49R4nBXp5skMAhK6CRuwtp4ZPj6TLk9rNpk6dbY515iXBlMxmi22/HdMY
 GZDO2hD2IDL1malTXUdAJrdRXZiIALT69CVdKPsebLpK9K6NdaiGd1NhC8VUsNjkg6HuqK2i3im
 nlv43tDQ3NVuY4xtKdxoYDIl9VNBvmHJSDDYy3Z9mEVvgcflexeItJNJErk2FWUb7gaQ0GuxEIi
 +20HhQJY1uqpQ6QkJaywOG59hwgXAPogPEItElMX3pJ+HCU3boNNp4TIfGyBVP+blYQaCHfp/87
 sfwihHP1/x5H/dI2pL0ioxILcLT7ywi8XAAnqveBF63iGJlCddcL5qKa//YiTBvoNc89mDEJ
X-Proofpoint-ORIG-GUID: npN9tD5ObsEl9tBMjeecRPXBVNA5RG5w
X-Proofpoint-GUID: npN9tD5ObsEl9tBMjeecRPXBVNA5RG5w
X-Authority-Analysis: v=2.4 cv=IrMecK/g c=1 sm=1 tr=0 ts=687e3580 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=eauDvVCzbnmlXtCe9pQA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_03,2025-07-21_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1011
 priorityscore=1501 spamscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507210112

Hi all,

This patch series introduces support for CPU affinity-based latency
constraints in the PM QoS framework. The motivation is to allow
finer-grained power management by enabling latency QoS requests to target
specific CPUs, rather than applying system-wide constraints.

The current PM QoS framework supports global and per-device CPU latency
constraints. However, in many real-world scenarios, such as IRQ affinity
or CPU-bound kernel threads, only a subset of CPUs are
performance-critical. Applying global constraints in such cases
unnecessarily prevents other CPUs from entering deeper C-states, leading
to increased power consumption.

This series addresses that limitation by introducing a new interface that
allows latency constraints to be applied to a CPU mask. This is
particularly useful on heterogeneous platforms (e.g., big.LITTLE) and
embedded systems where power efficiency is critical for example:

                        driver A       rt kthread B      module C
  CPU IDs (mask):         0-3              2-5              6-7
  target latency(us):     20               30               100
                          |                |                |
                          v                v                v
                          +---------------------------------+
                          |        PM  QoS  Framework       |
                          +---------------------------------+
                          |                |                |
                          v                v                v
  CPU IDs (mask):        0-3            2-3,4-5            6-7
  runtime latency(us):   20             20, 30             100

The current implementation includes only cpu_affinity_latency_qos_add()
and cpu_affinity_latency_qos_remove() interfaces. An update interface is
planned for future submission, along with PM QoS optimizations in the UFS
subsystem.

Patch1 introduces the core support for CPU affinity latency QoS in the PM
QoS framework.

Patch2 removes redundant KERN_ERR prefixes in WARN() calls in the global
CPU PM QoS interface. This change addresses issues in existing code and is
not related to the new interface introduced in this patch series.

Patch3 adds documentation for the new interface.

Patch4 fixes a minor documentation issue related to the return type of
cpu_latency_qos_request_active(). This change addresses issues in existing
doc and is not related to the new interface introduced in this patch
series.

Patch5 updates the resctrl pseudo-locking logic to use the new CPU
affinity latency QoS helpers, improving clarity and consistency. The only
functional and beneficial change is that the new interface actively wakes
up CPUs whose latency QoS values have changed, ensuring the latency limit
takes effect immediately.

Changes since v1:
- Rebased on top of current next.
- Resolve the compilation warning due to a missing static function
  declaration.
- Remove the conditional compilation based on CONFIG_CPU_IDLE and make it
  depend solely on CONFIG_PM.
- Add support for cpu_affinity_latency_qos_active.
- Remove cpu_affinity_latency_qos_update; will reintroduce it when needed
  in the future.
- Optimize the code, for example by using cpu_affinity_latency_qos_active
  inside the add/remove functions to enhance robustness.
- Refine the commit message and fix a few minor issues unrelated to this
  series.
- Refactor the CPU latency PM QoS logic of resctrl pseudo_lock using the
  interfaces provided by this series.
- Link to v1: https://lore.kernel.org/all/20250424095228.1112558-1-quic_zhonhan@quicinc.com/

Zhongqiu Han (5):
  PM: QoS: Add support for CPU affinity latency PM QoS
  PM: QOS: Remove unnecessary KERN_ERR on WARN() calls
  Documentation: PM: QoS: Add CPU affinity latency PM QoS Interface
    documentation
  Documentation: PM: QoS: Fix return type and return value description
  resctrl: Replace PM QoS logic with cpu_affinity_latency_qos_* helpers

 Documentation/power/pm_qos_interface.rst |  63 ++++++++-
 fs/resctrl/pseudo_lock.c                 |  51 +------
 include/linux/pm_qos.h                   |  40 ++++++
 include/linux/resctrl.h                  |   3 +-
 kernel/power/qos.c                       | 166 ++++++++++++++++++++++-
 5 files changed, 268 insertions(+), 55 deletions(-)


base-commit: 024e09e444bd2b06aee9d1f3fe7b313c7a2df1bb
-- 
2.43.0



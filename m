Return-Path: <linux-pm+bounces-26104-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9681CA9A913
	for <lists+linux-pm@lfdr.de>; Thu, 24 Apr 2025 11:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE8E53AFF4A
	for <lists+linux-pm@lfdr.de>; Thu, 24 Apr 2025 09:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F40C1D516F;
	Thu, 24 Apr 2025 09:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EdWsowNo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9FBE56A;
	Thu, 24 Apr 2025 09:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745488371; cv=none; b=HAwGld/48IBBjmTLgD6sjcxS8Rpwd9c3rZLnO6LoUpbz68hgF/BUyq4DqI0pA1SAkuvf0yXxGwzjclGehUE/quVuk025oVmwjUSJ9lZjsqht4o7aREQG6RPWzsT40W+Lc1omHFs8VVt5ufLEJYjK9bxwAl4+DZ6bxoqk/8xi9t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745488371; c=relaxed/simple;
	bh=mppaSWq3J3VdfDI8xG8v0YglZKH1xKtJeoCNdPIaf9E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rG9V7XFuDZoaGpww0cYoB1I2cX/Nl6Rp7PZqAqGhAhXFvNVq6v5bRsCkde0SMgYP5m1Vf9GpQCBYd5ZIp9sNlB/74dZYs5b/1+vXostgWtfh302+zAuBSVksTs2dvKYAMZPUYC/f7lFqOEH8oy3h1hyjC06mNdAf5IRnlU6J0Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=EdWsowNo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53O0FC2b000748;
	Thu, 24 Apr 2025 09:52:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=pV/Z9wGZFxUl69J88AuYO+
	GtJEVdC8YMT5c0F2+WDx0=; b=EdWsowNo1xGU78gUkus2zsBQB9lOlkk5h/ccRh
	p/DjVAaShzOjxytoAhuYUgjvypbbjWDolfDs11xB0lyaZi3M9eW2VTGz5SaT4Req
	rU33FSVAi0Hrv8ySR3qsfj0RtINALZ6TUCQgVJymp2dzSMaaZdusfyvjhewpn2F7
	KGCc4oszHawRZ7z+YhwGN4L3pED8DOWcy8H+o6kHkEkDSFmCZPsaKqVbk1IAJKIk
	qyqmcv5Fv4gvJhyRNsYhGCFae25bF4I75Kosx5yRQ+VNZTHpkIB/llDXNIsMzgAQ
	4lYiMDx271wvGhu7IEF6XSlGZl6WTNs+iLKtZvdncgE7XLCA==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 466jh3d22r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 09:52:45 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53O9qjxt029946
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 09:52:45 GMT
Received: from zhonhan-gv.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 24 Apr 2025 02:52:43 -0700
From: Zhongqiu Han <quic_zhonhan@quicinc.com>
To: <rafael@kernel.org>, <pavel@kernel.org>, <len.brown@intel.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_zhonhan@quicinc.com>
Subject: [PATCH] PM: QoS: Add support for CPU affinity mask-based CPUs latency QoS
Date: Thu, 24 Apr 2025 17:52:28 +0800
Message-ID: <20250424095228.1112558-1-quic_zhonhan@quicinc.com>
X-Mailer: git-send-email 2.25.1
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDA2NSBTYWx0ZWRfXyksk9yROW65I 3kEnKUtYKGmdD+bqD3gN04f5dR4l700UClJc+Gt/0en06Od8gzhLB+0SMHV7STPUFN7PdKZFOV8 NAxbSITgLUXbFD57UIXwD9IEeLRE0J0Zx8PenmUsgIgeQp9+Y7rUYS00Y2B+ENo4s5+CpwwbYm/
 N/bbSXo5iyJ4Uerro6ROcn8a8PmZUqvQtC1VejlBADMpsceCtSGGQw2vgCCz0pEnDIYYyISnIS8 j5vbwbUcGaVhNugURGaosRcU9qc4rbjNcjNCkgQ0OgTGcnJLJhYTXSsBzbdc3cscHZiGBuyQcLi LiOyxm/ZraJ4mS9H7A2BsPRZpyMHHu09BB49up/esSc93MjBG8HeTW6sjrXW22yN2Cx60UOg7qG
 z1qtvf7OUOYvTdH3AZ88+My9oifcdjJZ/3laUNihgh++6uUAEEz/Lz/uTXxE+tYGyxlCB5M1
X-Authority-Analysis: v=2.4 cv=bs1MBFai c=1 sm=1 tr=0 ts=680a09ee cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=k6c9-4DSoN7O16MBcjIA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: SQU2GTdi5DmKfeu1xsFQd8NyPlARo1yj
X-Proofpoint-GUID: SQU2GTdi5DmKfeu1xsFQd8NyPlARo1yj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-24_04,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=999 mlxscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0 malwarescore=0
 clxscore=1011 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504240065

Currently, the PM QoS framework supports global CPU latency QoS and
per-device CPU latency QoS requests. An example of using global CPU
latency QoS is a commit 2777e73fc154 ("scsi: ufs: core: Add CPU latency
QoS support for UFS driver") that improved random io performance by 15%
for ufs on specific device platform.

However, this prevents all CPUs in the system from entering C states.
Typically, some threads or drivers know which specific CPUs they are
interested in. For example, drivers with IRQ affinity only want interrupts
to wake up and be handled on specific CPUs. Similarly, kernel thread bound
to specific CPUs through affinity only care about the latency of those
particular CPUs.

This patch introduces support for partial CPUs PM QoS using a CPU affinity
mask, allowing flexible and more precise latency QoS settings for specific
CPUs. This can help save power, especially on heterogeneous platforms with
big and little cores, as well as some power-conscious embedded systems for
example:

                  driver A       rt kthread B      module C
QoS cpu mask:       0-3              2-5              6-7
target latency:     20               30               50
                    |                |                |
                    v                v                v
                    +---------------------------------+
                    |        PM  QoS  Framework       |
                    +---------------------------------+
                    |                |                |
                    v                v                v
cpu mask:          0-3            2-3,4-5            6-7
actual latency:    20             20, 30             50

Implement this support based on per-device CPU latency PM QoS.

Signed-off-by: Zhongqiu Han <quic_zhonhan@quicinc.com>
---
 include/linux/pm_qos.h |  35 +++++++++
 kernel/power/qos.c     | 158 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 193 insertions(+)

diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
index 4a69d4af3ff8..59139e5a0a30 100644
--- a/include/linux/pm_qos.h
+++ b/include/linux/pm_qos.h
@@ -131,6 +131,11 @@ enum pm_qos_req_action {
 	PM_QOS_REMOVE_REQ	/* Remove an existing request */
 };
 
+struct cpu_affinity_qos_req {
+	struct list_head list;
+	struct dev_pm_qos_request req;
+};
+
 static inline int dev_pm_qos_request_active(struct dev_pm_qos_request *req)
 {
 	return req->dev != NULL;
@@ -317,3 +322,33 @@ int freq_qos_remove_notifier(struct freq_constraints *qos,
 			     struct notifier_block *notifier);
 
 #endif
+
+#if defined(CONFIG_CPU_IDLE) && defined(CONFIG_PM)
+int cpu_latency_qos_affinity_add(struct cpu_affinity_qos_req *pm_req,
+			const cpumask_t *affinity_mask, s32 latency_value);
+int cpu_latency_qos_affinity_update(struct cpu_affinity_qos_req *pm_req,
+			s32 new_value);
+int cpu_latency_qos_affinity_remove(struct cpu_affinity_qos_req *pm_req);
+int cpu_latency_qos_affinity_release(struct list_head *pm_reqs);
+void wakeup_qos_affinity_idle_cpu(int cpu);
+#else
+int cpu_latency_qos_affinity_add(struct cpu_affinity_qos_req *pm_req,
+			const cpumask_t *affinity_mask, s32 latency_value)
+{
+	return 0;
+}
+int cpu_latency_qos_affinity_update(struct cpu_affinity_qos_req *pm_req,
+			s32 new_value)
+{
+	return 0;
+}
+int cpu_latency_qos_affinity_remove(struct cpu_affinity_qos_req *pm_req)
+{
+	return 0;
+}
+int cpu_latency_qos_affinity_release(struct list_head *pm_reqs)
+{
+	return 0;
+}
+void wakeup_qos_affinity_idle_cpu(int cpu) {}
+#endif
diff --git a/kernel/power/qos.c b/kernel/power/qos.c
index 4244b069442e..b9b814ee670f 100644
--- a/kernel/power/qos.c
+++ b/kernel/power/qos.c
@@ -335,6 +335,164 @@ void cpu_latency_qos_remove_request(struct pm_qos_request *req)
 }
 EXPORT_SYMBOL_GPL(cpu_latency_qos_remove_request);
 
+#ifdef CONFIG_PM
+
+/**
+ * wakeup_qos_affinity_idle_cpu - break one specific cpu out of idle.
+ */
+void wakeup_qos_affinity_idle_cpu(int cpu)
+{
+	preempt_disable();
+	if (cpu != smp_processor_id() && cpu_online(cpu))
+		wake_up_if_idle(cpu);
+	preempt_enable();
+}
+
+/**
+ * cpu_latency_qos_affinity_add - Add new CPU affinity latency QoS request.
+ * @pm_req : Pointer to a preallocated handle.
+ * @affinity_mask: Mask to determine which CPUs need latency QoS.
+ * @new_value: New requested constraint value.
+ *
+ * Use @latency_value to initialize the request handle pointed to by @pm_req,
+ * insert it as a new entry to the CPU latency QoS list and recompute the
+ * effective QoS constraint for that list, @affinity_mask determine which CPUs
+ * need the latency QoS.
+ *
+ * Callers need to save the handle for later use in updates and removal of the
+ * QoS request represented by it.
+ */
+int cpu_latency_qos_affinity_add(struct cpu_affinity_qos_req *pm_req,
+				 const cpumask_t *affinity_mask,
+				 s32 latency_value)
+{
+	int cpu;
+	cpumask_t actual_mask;
+	struct cpu_affinity_qos_req *cpu_pm_req;
+	int ret = 0;
+
+	if (!pm_req)
+		pr_err("%s: invalid PM Qos request\n", __func__);
+
+	INIT_LIST_HEAD(&pm_req->list);
+
+	if (!affinity_mask || cpumask_empty(affinity_mask) ||
+	    latency_value < 0) {
+		pr_err("%s: invalid PM Qos request value\n", __func__);
+		return -EINVAL;
+	}
+
+	for_each_cpu(cpu, affinity_mask) {
+		cpu_pm_req = kzalloc(sizeof(struct cpu_affinity_qos_req),
+				     GFP_KERNEL);
+		if (!cpu_pm_req) {
+			ret = -ENOMEM;
+			goto out_err;
+		}
+		ret = dev_pm_qos_add_request(get_cpu_device(cpu),
+					     &cpu_pm_req->req,
+					     DEV_PM_QOS_RESUME_LATENCY,
+					     latency_value);
+		if (ret < 0) {
+			pr_err("failed to add latency req for cpu%d", cpu);
+			kfree(cpu_pm_req);
+			goto out_err;
+		} else if (ret > 0) {
+			wakeup_qos_affinity_idle_cpu(cpu);
+		}
+
+		cpumask_set_cpu(cpu, &actual_mask);
+		list_add(&cpu_pm_req->list, &pm_req->list);
+	}
+
+	pr_info("PM Qos latency: %d added on cpus %*pb\n", latency_value,
+		cpumask_pr_args(&actual_mask));
+
+	return ret;
+
+out_err:
+	cpu_latency_qos_affinity_release(&pm_req->list);
+	pr_err("failed to add PM QoS latency req, removed all added requests\n");
+	return ret;
+}
+EXPORT_SYMBOL_GPL(cpu_latency_qos_affinity_add);
+
+/**
+ * cpu_latency_qos_affinity_update - Modify existing CPU affinity latency QoS.
+ * @pm_req : QoS request to update for CPUs with affinity masks.
+ * @new_value: New requested constraint value.
+ *
+ * Use @new_value to update the QoS request represented by @pm_req in the CPU
+ * latency QoS list along with updating the effective constraint value for that
+ * list.
+ */
+int cpu_latency_qos_affinity_update(struct cpu_affinity_qos_req *pm_req,
+				    s32 new_value)
+{
+	struct cpu_affinity_qos_req *cpu_pm_req, *next;
+	int ret = 0;
+
+	if (!pm_req || new_value < 0 || list_empty(&pm_req->list)) {
+		pr_err("%s: invalid PM Qos request value\n", __func__);
+		return -EINVAL;
+	}
+
+	list_for_each_entry_safe(cpu_pm_req, next, &pm_req->list, list) {
+		ret = dev_pm_qos_update_request(&cpu_pm_req->req, new_value);
+		if (ret < 0) {
+			pr_err("PM QoS qos update failed for %s\n",
+			       dev_name(cpu_pm_req->req.dev));
+		} else if (ret > 0) {
+			wakeup_qos_affinity_idle_cpu(cpu_pm_req->req.dev->id);
+		}
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(cpu_latency_qos_affinity_update);
+
+/**
+ * cpu_latency_qos_affinity_remove - Remove existing CPU affinity latency QoS.
+ * @pm_req: QoS request to update for CPUs with affinity masks.
+ *
+ * Remove the CPU latency QoS request represented by @pm_req from the CPU latency
+ * QoS list.
+ */
+int cpu_latency_qos_affinity_remove(struct cpu_affinity_qos_req *pm_req)
+{
+	if (!pm_req || list_empty(&pm_req->list)) {
+		pr_err("%s: invalid PM Qos request value\n", __func__);
+		return -EINVAL;
+	}
+
+	return cpu_latency_qos_affinity_release(&pm_req->list);
+}
+EXPORT_SYMBOL_GPL(cpu_latency_qos_affinity_remove);
+
+/**
+ * cpu_latency_qos_affinity_release - Release pm_reqs latency QoS resource.
+ * @pm_req: QoS request to remove.
+ *
+ * Release pm_reqs managed CPU affinity latency QoS resource.
+ */
+int cpu_latency_qos_affinity_release(struct list_head *pm_reqs)
+{
+	int ret = 0;
+	struct cpu_affinity_qos_req *cpu_pm_req, *next;
+
+	list_for_each_entry_safe(cpu_pm_req, next, pm_reqs, list) {
+		ret = dev_pm_qos_remove_request(&cpu_pm_req->req);
+		if (ret < 0)
+			pr_err("failed to remove qos request for %s\n",
+			       dev_name(cpu_pm_req->req.dev));
+		list_del(&cpu_pm_req->list);
+		kfree(cpu_pm_req);
+	}
+
+	return ret;
+}
+#endif /* CONFIG_PM */
+
 /* User space interface to the CPU latency QoS via misc device. */
 
 static int cpu_latency_qos_open(struct inode *inode, struct file *filp)
-- 
2.25.1



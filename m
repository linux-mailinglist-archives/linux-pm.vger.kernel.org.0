Return-Path: <linux-pm+bounces-31204-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62326B0C440
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 14:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 781FE3AB017
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 12:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E872D46AC;
	Mon, 21 Jul 2025 12:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JjUTKPJ7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AB22D3EC5;
	Mon, 21 Jul 2025 12:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753101710; cv=none; b=I9q9fo1HQhDjE7O8n4hw4/ZG/VKHUziTcRSj12rkuFJ6s3EdtIixhRvL2K5uBKmlSHLZAbmp9xfAtqY3ldal92KtfLMRH7tMRPQ+wlUsZle2hrK1l5srmJ4y3LFNE6w6hU8oenCF1sTVH3o4NLFgzsCADu/hIC1UBLzK4kR+4qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753101710; c=relaxed/simple;
	bh=qQsUHeoJ/j4D0gircpwU6t8Vcf76jammambJP2bRpHs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sY+4oGTlWpuM9iwDmzPuveRiKFeT+0QBQYrTGNoCy37ImBQH0ETCWYtufG/KR6mpUVC6jsejkOFCsYoAa231jZPxMqPbZi1ojO+nBqvzmanR1DxKoZZzTOxGrmYa10wFrR5In1tskgiEnd1MeLqfX5qvGV4/6bYqrD0Y0+meFy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JjUTKPJ7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56LA4hWG015762;
	Mon, 21 Jul 2025 12:41:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NbnzzDg7ZFxM4Sy8hBjxkah1SmY2zoBVYeJhIOgf2vU=; b=JjUTKPJ7vZCJZyoK
	biNBawQWUwT2crFmcon/6v3pbP7TqUeraKGO5hS9qgSdEccgk8AJJnTwIAPw/rri
	pWinqt6XploghpTNnVIqufYX3MJjkWlADBEwaaQ7Tr6K0PsT9rcjZr1g4Z1VsOaE
	hix1toPPWTdwyhrGPYw+rTc8uMJh7Rmop4xb5tomcNkB/TBKJkgZisM/OzfbE1nl
	S55Rwl3TyrER+am67IUWWucvjd1D1j0oLyRMVHHhCPoQWUpY2VSJMFF+4ZyAMEZT
	2Vn3lMDTltisKJGn1wl1O/98Eut+mkO9CZCA9pmHN6NKPTJ1v9yz/ePHsUo8Qo9V
	4NyQdw==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 480451d11q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Jul 2025 12:41:39 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56LCfcwU015641
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Jul 2025 12:41:38 GMT
Received: from zhonhan-gv.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 21 Jul 2025 05:41:35 -0700
From: Zhongqiu Han <quic_zhonhan@quicinc.com>
To: <rafael@kernel.org>, <lenb@kernel.org>, <pavel@kernel.org>,
        <tony.luck@intel.com>, <reinette.chatre@intel.com>,
        <Dave.Martin@arm.com>, <james.morse@arm.com>, <ulf.hansson@linaro.org>,
        <amit.kucheria@linaro.org>, <christian.loehle@arm.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_zhonhan@quicinc.com>
Subject: [PATCH v2 1/5] PM: QoS: Add support for CPU affinity latency PM QoS
Date: Mon, 21 Jul 2025 20:41:00 +0800
Message-ID: <20250721124104.806120-2-quic_zhonhan@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=EIMG00ZC c=1 sm=1 tr=0 ts=687e3583 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=tExEg1ksGLqWEgzjn1MA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: S3-RiFUH3mf_BEtztJi2CLMuxTvDnl9w
X-Proofpoint-GUID: S3-RiFUH3mf_BEtztJi2CLMuxTvDnl9w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDExMiBTYWx0ZWRfX1tlSbUmk+mCR
 lRxIMNxtQcGNILwYm4KGxvyUQo133jXw2bcLkQwtLQO9H2y5WwPB+NOCwu54nY1CeLfFbv3wm5R
 35rufHpPo7+2VxLkVwf+Elqev3dRflwBkM8lm7b3lQRaZtDeoPI/6Cci6+MNMQ5lfBXblhTl5eK
 KG6+mK2nebyCFxKHtt0NtcTSkx5mVG/F9F+ylpS1B/mG3VBhu8RiA3tsa+MnE+CHfV+Vh5mGWFQ
 aopnkMGhbYEubebIqGqEiKNSsRYkfmkb5L467C6HM98vptdKatbg9/keYvSWDtBF9S0HBV0pe5l
 zrPwftt+tcNw93kockC8rd2zlY3fALzOmAEqcy0EZ/Z4ntsYXU61LflAhbcFkoRuW1z0FoOi0Rd
 xhrkk8GMddaakr5qH5c4LZhGSCeJ6Iu70NAI8lb72GeI0/Y9pV+OKG6h6VxixkJQZx77TIWs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_03,2025-07-21_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 mlxlogscore=999 phishscore=0 mlxscore=0 clxscore=1011
 suspectscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507210112

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

Implement this support based on per-device CPU latency PM QoS.

Signed-off-by: Zhongqiu Han <quic_zhonhan@quicinc.com>
---
 include/linux/pm_qos.h |  40 +++++++++++
 kernel/power/qos.c     | 160 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 200 insertions(+)

diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
index 4a69d4af3ff8..2dbad825f8bd 100644
--- a/include/linux/pm_qos.h
+++ b/include/linux/pm_qos.h
@@ -131,6 +131,15 @@ enum pm_qos_req_action {
 	PM_QOS_REMOVE_REQ	/* Remove an existing request */
 };
 
+/* cpu affinity pm latency qos request handle */
+struct cpu_affinity_qos_req {
+	struct list_head list;
+	union {
+		struct dev_pm_qos_request req;
+		void *req_ptr;
+	};
+};
+
 static inline int dev_pm_qos_request_active(struct dev_pm_qos_request *req)
 {
 	return req->dev != NULL;
@@ -208,6 +217,13 @@ static inline s32 dev_pm_qos_raw_resume_latency(struct device *dev)
 		PM_QOS_RESUME_LATENCY_NO_CONSTRAINT :
 		pm_qos_read_value(&dev->power.qos->resume_latency);
 }
+
+int cpu_affinity_latency_qos_add(struct cpu_affinity_qos_req *pm_req,
+				  const cpumask_t *affinity_mask, s32 latency_value);
+int cpu_affinity_latency_qos_remove(struct cpu_affinity_qos_req *pm_req);
+int cpu_affinity_latency_qos_release(struct cpu_affinity_qos_req *pm_req);
+bool cpu_affinity_latency_qos_active(struct cpu_affinity_qos_req *pm_req);
+void wakeup_qos_affinity_idle_cpu(int cpu);
 #else
 static inline enum pm_qos_flags_status __dev_pm_qos_flags(struct device *dev,
 							  s32 mask)
@@ -289,6 +305,30 @@ static inline s32 dev_pm_qos_raw_resume_latency(struct device *dev)
 {
 	return PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
 }
+
+static inline int cpu_affinity_latency_qos_add(struct cpu_affinity_qos_req *pm_req,
+						const cpumask_t *affinity_mask,
+						s32 latency_value)
+{
+	return 0;
+}
+
+static inline int cpu_affinity_latency_qos_remove(
+		   struct cpu_affinity_qos_req *pm_req)
+{
+	return 0;
+}
+static inline int cpu_affinity_latency_qos_release(
+		   struct cpu_affinity_qos_req *pm_req)
+{
+	return 0;
+}
+static inline bool cpu_affinity_latency_qos_active(
+		    struct cpu_affinity_qos_req *pm_req)
+{
+	return false;
+}
+static inline void wakeup_qos_affinity_idle_cpu(int cpu) {}
 #endif
 
 static inline int freq_qos_request_active(struct freq_qos_request *req)
diff --git a/kernel/power/qos.c b/kernel/power/qos.c
index 4244b069442e..5e507ed8d077 100644
--- a/kernel/power/qos.c
+++ b/kernel/power/qos.c
@@ -335,6 +335,166 @@ void cpu_latency_qos_remove_request(struct pm_qos_request *req)
 }
 EXPORT_SYMBOL_GPL(cpu_latency_qos_remove_request);
 
+#ifdef CONFIG_PM
+
+/**
+ * wakeup_qos_affinity_idle_cpu - break one specific cpu out of idle.
+ * @cpu: the CPU to be woken up from idle.
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
+ * cpu_affinity_latency_qos_add - Add new CPU affinity latency QoS request.
+ * @pm_req: Pointer to a preallocated handle.
+ * @affinity_mask: Mask to determine which CPUs need latency QoS.
+ * @latency_value: New requested constraint value.
+ *
+ * Use @latency_value to initialize the request handle pointed to by @pm_req,
+ * insert it as a new entry to the CPU latency QoS list and recompute the
+ * effective QoS constraint for that list, @affinity_mask determine which CPUs
+ * need the latency QoS.
+ *
+ * Callers need to save the handle for later use in updates and removal of the
+ * QoS request represented by it.
+ *
+ * Returns 0 or a positive value on success, or a negative error code on failure.
+ */
+int cpu_affinity_latency_qos_add(struct cpu_affinity_qos_req *pm_req,
+				  const cpumask_t *affinity_mask,
+				  s32 latency_value)
+{
+	int cpu;
+	cpumask_t actual_mask;
+	struct cpu_affinity_qos_req *cpu_pm_req;
+	int ret = 0;
+
+	if (!pm_req) {
+		pr_err("%s: invalid PM Qos request\n", __func__);
+		return -EINVAL;
+	}
+
+	if (cpu_affinity_latency_qos_active(pm_req)) {
+		WARN(1, "%s called for already added request\n", __func__);
+		return -EBUSY;
+	}
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
+	pm_req->req_ptr = pm_req;
+	return ret;
+
+out_err:
+	cpu_affinity_latency_qos_release(pm_req);
+	pr_err("failed to add PM QoS latency req, removed all added requests\n");
+	return ret;
+}
+EXPORT_SYMBOL_GPL(cpu_affinity_latency_qos_add);
+
+
+/**
+ * cpu_affinity_latency_qos_remove - Remove an existing CPU affinity latency QoS.
+ * @pm_req: Handle to the QoS request to be removed.
+ *
+ * Remove the CPU latency QoS request represented by @pm_req from the CPU latency
+ * QoS list. This handle must have been previously initialized and added via
+ * cpu_affinity_latency_qos_add().
+ */
+int cpu_affinity_latency_qos_remove(struct cpu_affinity_qos_req *pm_req)
+{
+	if (!pm_req) {
+		pr_err("%s: invalid PM Qos request value\n", __func__);
+		return -EINVAL;
+	}
+
+	if (!cpu_affinity_latency_qos_active(pm_req)) {
+		WARN(1, "%s called for unknown object\n", __func__);
+		return -EINVAL;
+	}
+
+	return cpu_affinity_latency_qos_release(pm_req);
+}
+EXPORT_SYMBOL_GPL(cpu_affinity_latency_qos_remove);
+
+/**
+ * cpu_affinity_latency_qos_release - Release pm_reqs latency QoS resource.
+ * @pm_req: QoS request to be released.
+ *
+ * Release pm_reqs managed CPU affinity latency QoS resource.
+ *
+ * Returns a negative value indicates failure.
+ */
+int cpu_affinity_latency_qos_release(struct cpu_affinity_qos_req *pm_req)
+{
+	int ret = 0;
+	struct cpu_affinity_qos_req *cpu_pm_req, *next;
+
+	list_for_each_entry_safe(cpu_pm_req, next, &pm_req->list, list) {
+		ret = dev_pm_qos_remove_request(&cpu_pm_req->req);
+		if (ret < 0)
+			pr_err("failed to remove qos request for %s\n",
+			       dev_name(cpu_pm_req->req.dev));
+		list_del(&cpu_pm_req->list);
+		kfree(cpu_pm_req);
+		cpu_pm_req = NULL;
+	}
+
+	memset(pm_req, 0, sizeof(*pm_req));
+	return ret;
+}
+
+/**
+ * cpu_affinity_latency_qos_active - Check if a CPU affinity latency QoS
+ * request is active.
+ * @pm_req: Handle to the QoS request.
+ *
+ * Return: 'true' if @pm_req has been added to the CPU latency QoS list,
+ * 'false' otherwise.
+ */
+bool cpu_affinity_latency_qos_active(struct cpu_affinity_qos_req *pm_req)
+{
+	return pm_req->req_ptr == pm_req;
+}
+EXPORT_SYMBOL_GPL(cpu_affinity_latency_qos_active);
+
+#endif /* CONFIG_PM */
+
 /* User space interface to the CPU latency QoS via misc device. */
 
 static int cpu_latency_qos_open(struct inode *inode, struct file *filp)
-- 
2.43.0



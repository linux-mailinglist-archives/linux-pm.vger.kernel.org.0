Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5F13AAB44
	for <lists+linux-pm@lfdr.de>; Thu, 17 Jun 2021 07:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbhFQFtC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Jun 2021 01:49:02 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:20869 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbhFQFtA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Jun 2021 01:49:00 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210617054651epoutp02d82502037439c6cdc88065c10bf0c32c~JSHW67n_x0763307633epoutp02S
        for <linux-pm@vger.kernel.org>; Thu, 17 Jun 2021 05:46:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210617054651epoutp02d82502037439c6cdc88065c10bf0c32c~JSHW67n_x0763307633epoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1623908811;
        bh=hwWTZ1zcrCBHmAHfjGm8GlblR5880x/jeAsPMHDxZh0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jwSfpZ0jFgrN3RVOL6OMIktHrdz5QXvKZkN3ZIXv5s8B4d4BV6+6xnzL3FgZ7pi7S
         h0FEzBaOy8lUlhsVvxKa4/ByeOrqqo/ROYo11I4P/LRHSD/ZgclE20CF+0dSY4Q2zw
         /KUpoTAXc9pEy5mfYuQK5g4/t5MSo//sthluk7e0=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210617054650epcas1p141bafea5e22f2f3678d2fcac1ac4b659~JSHWNUgBI1952019520epcas1p1H;
        Thu, 17 Jun 2021 05:46:50 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.155]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4G59zX1QWJz4x9QK; Thu, 17 Jun
        2021 05:46:48 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        B3.E4.09824.8C1EAC06; Thu, 17 Jun 2021 14:46:48 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20210617054647epcas1p431edaffea5bf7f3792b55dc3d91289ae~JSHTs2uRt0153601536epcas1p4t;
        Thu, 17 Jun 2021 05:46:47 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210617054647epsmtrp13b78b339e85e09b32db3524f8064b4e9~JSHTr58G-1935819358epsmtrp1S;
        Thu, 17 Jun 2021 05:46:47 +0000 (GMT)
X-AuditID: b6c32a37-04bff70000002660-4c-60cae1c8c1a7
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        B8.96.08163.7C1EAC06; Thu, 17 Jun 2021 14:46:47 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210617054647epsmtip161f5cdda44ba310d5ace73227f1d7b66~JSHTeDLoJ1583415834epsmtip1i;
        Thu, 17 Jun 2021 05:46:47 +0000 (GMT)
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     andrew-sh.cheng@mediatek.com, hsinyi@chromium.org
Cc:     sibis@codeaurora.org, saravanak@google.com,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, chanwoo@kernel.org, cwchoi00@gmail.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Saravana Kannan <skannan@codeaurora.org>
Subject: [PATCH 3/4] PM / devfreq: Add cpu based scaling support to passive
 governor
Date:   Thu, 17 Jun 2021 15:05:45 +0900
Message-Id: <20210617060546.26933-4-cw00.choi@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210617060546.26933-1-cw00.choi@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmk+LIzCtJLcpLzFFi42LZdlhTX/fEw1MJBnO6WSy2r3/BajHxxhUW
        i+tfnrNaPDuqbTGhdTuzxdmmN+wWl3fNYbP43HuE0eJ24wo2i65Df9ksri18z2px4OJENgce
        j9kNF1k8Lvf1MnnsnHWX3WPBplKPTas62TxaTu5n8ejbsorR4/MmuQCOqGybjNTElNQihdS8
        5PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFslF58AXbfMHKBjlRTKEnNKgUIBicXFSvp2
        NkX5pSWpChn5xSW2SqkFKTkFlgV6xYm5xaV56XrJ+blWhgYGRqZAhQnZGZO7lzAVrEurWHb+
        PnsD48zgLkZODgkBE4nll2+xdTFycQgJ7GCUmLP8GCuE84lRYu+Xk8wQzmdGifmXH7PAtBzt
        fMIOYgsJ7GKUWLa+BKLoC6PEzXOdjCAJNgEtif0vbrCB2CICphJ7Dk9kASliFuhikth87hcT
        SEJYIEyicdosZhCbRUBVYkrDb7CpvAJWEr/azzNDbJOXWL3hAJjNKWAtcW7JHXaQQRICrRwS
        bTuWAG3jAHJcJPZdZYOoF5Z4dXwLO4QtJfGyvw3KrpZYefIIG0RvB6PElv0XWCESxhL7l05m
        ApnDLKApsX6XPkRYUWLn77lgzzAL8Em8+9rDCrGKV6KjTQiiRFni8oO7TBC2pMTi9k6oEzwk
        Tm04BQ25PkaJP3v+s09glJuFsGEBI+MqRrHUguLc9NRiwwJj5CjbxAhOjVrmOxinvf2gd4iR
        iYPxEKMEB7OSCK9u8YkEId6UxMqq1KL8+KLSnNTiQ4ymwMCbyCwlmpwPTM55JfGGpkbGxsYW
        JoZmpoaGSuK8O9kOJQgJpCeWpGanphakFsH0MXFwSjUwTX92Lch8g+OWg0q/f/0/FpPzI/Pr
        RqbG3f0ZkrZeH/we6L0QOXT3pqjrR2GLU3H1BxbfLwW6f8HlOIXuV1lBDquCy1QZnP88zHzj
        erE2M4pz5vnX0v/38tz2/WN+4nX/reczJ2z87fE+N9b8nsO/03cmTzu7ptX7d8XzBSEN0Vum
        v1ScfmA1x2KJt7vzVOpe/1TeO5lH4tOHAwEd3v4+RtN9P2W4lE+alWPWfKzJRaTQqMwtMezs
        P44Ie42ci59cKm5rcH8/bR/RoHrw+uGVqxfdvShQ6xZs5dehfHvK6UmF3eUy6/2mXkl4kPDs
        9XI+O0eJb60b1z7pZjbyXSM6I+7XZA+pP/ISD0RNZP6/U2Ipzkg01GIuKk4EALwyxxsWBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNLMWRmVeSWpSXmKPExsWy7bCSnO7xh6cSDD7+VbLYvv4Fq8XEG1dY
        LK5/ec5q8eyotsWE1u3MFmeb3rBbXN41h83ic+8RRovbjSvYLLoO/WWzuLbwPavFgYsT2Rx4
        PGY3XGTxuNzXy+Sxc9Zddo8Fm0o9Nq3qZPNoObmfxaNvyypGj8+b5AI4orhsUlJzMstSi/Tt
        ErgyJncvYSpYl1ax7Px99gbGmcFdjJwcEgImEkc7n7B3MXJxCAnsYJRombGEDSIhKTHt4lHm
        LkYOIFtY4vDhYoiaT4wSvYdOs4PUsAloSex/cYMNpEZEwFzi+JVokBpmgWlMEit/7WQFqREW
        CJF4dfwtM4jNIqAqMaXhN1gvr4CVxK/288wQu+QlVm84AGZzClhLnFtyhx1kphBQzflX6RMY
        +RYwMqxilEwtKM5Nzy02LDDKSy3XK07MLS7NS9dLzs/dxAgOXy2tHYx7Vn3QO8TIxMF4iFGC
        g1lJhFe3+ESCEG9KYmVValF+fFFpTmrxIUZpDhYlcd4LXSfjhQTSE0tSs1NTC1KLYLJMHJxS
        DUzLDq4O+bZgaiObrf7W2ARdp1cX1gnLHbjYU+N4oNPXelHfaQtZj4nZezYGpJw74asX/edZ
        Qta0RckXli5U2ClRuiSjXPvsxN9dnCHnw+9vmXUx5R9/0savh28yuF2vXj/VTuxv7aNK219/
        dr3sPB9l0b/IxcqqcGNqZczNetUb++8wcL59Y1r6zv2FqUbiLLEj/DEFIhVPEg0UXz4VSf3W
        d1nqxiuexTX7ilKn+y1em7K980eP88eD7ttf3Oti8tiw64vIc7tdef8Z1qg3B5Q5nEk6zftx
        Z6wlg7TezIVqQVqTTBZH9W5jO2i81vE5w4/vWTbGZmXSE2dvnKa2Y8UZn+cnpUSnrTEv7ebY
        HpegxFKckWioxVxUnAgApo1Jt84CAAA=
X-CMS-MailID: 20210617054647epcas1p431edaffea5bf7f3792b55dc3d91289ae
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210617054647epcas1p431edaffea5bf7f3792b55dc3d91289ae
References: <20210617060546.26933-1-cw00.choi@samsung.com>
        <CGME20210617054647epcas1p431edaffea5bf7f3792b55dc3d91289ae@epcas1p4.samsung.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Saravana Kannan <skannan@codeaurora.org>

Many CPU architectures have caches that can scale independent of the
CPUs. Frequency scaling of the caches is necessary to make sure that the
cache is not a performance bottleneck that leads to poor performance and
power. The same idea applies for RAM/DDR.

To achieve this, this patch adds support for cpu based scaling to the
passive governor. This is accomplished by taking the current frequency
of each CPU frequency domain and then adjust the frequency of the cache
(or any devfreq device) based on the frequency of the CPUs. It listens
to CPU frequency transition notifiers to keep itself up to date on the
current CPU frequency.

To decide the frequency of the device, the governor does one of the
following:
* Derives the optimal devfreq device opp from required-opps property of
  the parent cpu opp_table.

* Scales the device frequency in proportion to the CPU frequency. So, if
  the CPUs are running at their max frequency, the device runs at its
  max frequency. If the CPUs are running at their min frequency, the
  device runs at its min frequency. It is interpolated for frequencies
  in between.

Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
[Sibi: Integrated cpu-freqmap governor into passive_governor]
Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
[Chanwoo: Fix conflict with latest code and clean code up]
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/governor.h         |  22 +++
 drivers/devfreq/governor_passive.c | 264 ++++++++++++++++++++++++++++-
 include/linux/devfreq.h            |  16 +-
 3 files changed, 293 insertions(+), 9 deletions(-)

diff --git a/drivers/devfreq/governor.h b/drivers/devfreq/governor.h
index 9a9495f94ac6..3c36c92c89a9 100644
--- a/drivers/devfreq/governor.h
+++ b/drivers/devfreq/governor.h
@@ -47,6 +47,28 @@
 #define DEVFREQ_GOV_ATTR_POLLING_INTERVAL		BIT(0)
 #define DEVFREQ_GOV_ATTR_TIMER				BIT(1)
 
+/**
+ * struct devfreq_cpu_data - Hold the per-cpu data
+ * @dev:	reference to cpu device.
+ * @first_cpu:	the cpumask of the first cpu of a policy.
+ * @opp_table:	reference to cpu opp table.
+ * @cur_freq:	the current frequency of the cpu.
+ * @min_freq:	the min frequency of the cpu.
+ * @max_freq:	the max frequency of the cpu.
+ *
+ * This structure stores the required cpu_data of a cpu.
+ * This is auto-populated by the governor.
+ */
+struct devfreq_cpu_data {
+	struct device *dev;
+	unsigned int first_cpu;
+
+	struct opp_table *opp_table;
+	unsigned int cur_freq;
+	unsigned int min_freq;
+	unsigned int max_freq;
+};
+
 /**
  * struct devfreq_governor - Devfreq policy governor
  * @node:		list node - contains registered devfreq governors
diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
index fc09324a03e0..07e864509b7e 100644
--- a/drivers/devfreq/governor_passive.c
+++ b/drivers/devfreq/governor_passive.c
@@ -8,11 +8,84 @@
  */
 
 #include <linux/module.h>
+#include <linux/cpu.h>
+#include <linux/cpufreq.h>
+#include <linux/cpumask.h>
+#include <linux/slab.h>
 #include <linux/device.h>
 #include <linux/devfreq.h>
 #include "governor.h"
 
-static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
+#define HZ_PER_KHZ	1000
+
+static unsigned long get_taget_freq_by_required_opp(struct device *p_dev,
+						struct opp_table *p_opp_table,
+						struct opp_table *opp_table,
+						unsigned long freq)
+{
+	struct dev_pm_opp *opp = NULL, *p_opp = NULL;
+
+	if (!p_dev || !p_opp_table || !opp_table || !freq)
+		return 0;
+
+	p_opp = devfreq_recommended_opp(p_dev, &freq, 0);
+	if (IS_ERR(p_opp))
+		return 0;
+
+	opp = dev_pm_opp_xlate_required_opp(p_opp_table, opp_table, p_opp);
+	dev_pm_opp_put(p_opp);
+
+	if (IS_ERR(opp))
+		return 0;
+
+	freq = dev_pm_opp_get_freq(opp);
+	dev_pm_opp_put(opp);
+
+	return freq;
+}
+
+static int get_target_freq_with_cpufreq(struct devfreq *devfreq,
+					unsigned long *target_freq)
+{
+	struct devfreq_passive_data *p_data =
+				(struct devfreq_passive_data *)devfreq->data;
+	struct devfreq_cpu_data *cpu_data;
+	unsigned long cpu, cpu_cur, cpu_min, cpu_max, cpu_percent;
+	unsigned long dev_min, dev_max;
+	unsigned long freq = 0;
+
+	for_each_online_cpu(cpu) {
+		cpu_data = p_data->cpu_data[cpu];
+		if (!cpu_data || cpu_data->first_cpu != cpu)
+			continue;
+
+		/* Get target freq via required opps */
+		cpu_cur = cpu_data->cur_freq * HZ_PER_KHZ;
+		freq = get_taget_freq_by_required_opp(cpu_data->dev,
+					cpu_data->opp_table,
+					devfreq->opp_table, cpu_cur);
+		if (freq) {
+			*target_freq = max(freq, *target_freq);
+			continue;
+		}
+
+		/* Use Interpolation if required opps is not available */
+		devfreq_get_freq_range(devfreq, &dev_min, &dev_max);
+
+		cpu_min = cpu_data->min_freq;
+		cpu_max = cpu_data->max_freq;
+		cpu_cur = cpu_data->cur_freq;
+
+		cpu_percent = ((cpu_cur - cpu_min) * 100) / (cpu_max - cpu_min);
+		freq = dev_min + mult_frac(dev_max - dev_min, cpu_percent, 100);
+
+		*target_freq = max(freq, *target_freq);
+	}
+
+	return 0;
+}
+
+static int get_target_freq_with_devfreq(struct devfreq *devfreq,
 					unsigned long *freq)
 {
 	struct devfreq_passive_data *p_data
@@ -99,6 +172,172 @@ static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
 	return 0;
 }
 
+static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
+					   unsigned long *freq)
+{
+	struct devfreq_passive_data *p_data =
+				(struct devfreq_passive_data *)devfreq->data;
+	int ret;
+
+	if (!p_data)
+		return -EINVAL;
+
+	/*
+	 * If the devfreq device with passive governor has the specific method
+	 * to determine the next frequency, should use the get_target_freq()
+	 * of struct devfreq_passive_data.
+	 */
+	if (p_data->get_target_freq)
+		return p_data->get_target_freq(devfreq, freq);
+
+	switch (p_data->parent_type) {
+	case DEVFREQ_PARENT_DEV:
+		ret = get_target_freq_with_devfreq(devfreq, freq);
+		break;
+	case CPUFREQ_PARENT_DEV:
+		ret = get_target_freq_with_cpufreq(devfreq, freq);
+		break;
+	default:
+		ret = -EINVAL;
+		dev_err(&devfreq->dev, "Invalid parent type\n");
+		break;
+	}
+
+	return ret;
+}
+
+static int cpufreq_passive_notifier_call(struct notifier_block *nb,
+					 unsigned long event, void *ptr)
+{
+	struct devfreq_passive_data *data =
+			container_of(nb, struct devfreq_passive_data, nb);
+	struct devfreq *devfreq = (struct devfreq *)data->this;
+	struct devfreq_cpu_data *cpu_data;
+	struct cpufreq_freqs *freqs = ptr;
+	unsigned int cur_freq;
+	int ret;
+
+	if (event != CPUFREQ_POSTCHANGE || !freqs ||
+		!data->cpu_data[freqs->policy->cpu])
+		return 0;
+
+	cpu_data = data->cpu_data[freqs->policy->cpu];
+	if (cpu_data->cur_freq == freqs->new)
+		return 0;
+
+	cur_freq = cpu_data->cur_freq;
+	cpu_data->cur_freq = freqs->new;
+
+	mutex_lock(&devfreq->lock);
+	ret = devfreq_update_target(devfreq, freqs->new);
+	mutex_unlock(&devfreq->lock);
+	if (ret) {
+		cpu_data->cur_freq = cur_freq;
+		dev_err(&devfreq->dev, "failed to update the frequency.\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int cpufreq_passive_register_notifier(struct devfreq *devfreq)
+{
+	struct devfreq_passive_data *p_data
+			= (struct devfreq_passive_data *)devfreq->data;
+	struct device *dev = devfreq->dev.parent;
+	struct opp_table *opp_table = NULL;
+	struct devfreq_cpu_data *cpu_data;
+	struct cpufreq_policy *policy;
+	struct device *cpu_dev;
+	unsigned int cpu;
+	int ret;
+
+	get_online_cpus();
+
+	p_data->nb.notifier_call = cpufreq_passive_notifier_call;
+	ret = cpufreq_register_notifier(&p_data->nb, CPUFREQ_TRANSITION_NOTIFIER);
+	if (ret) {
+		dev_err(dev, "failed to register cpufreq notifier\n");
+		p_data->nb.notifier_call = NULL;
+		goto out;
+	}
+
+	for_each_online_cpu(cpu) {
+		if (p_data->cpu_data[cpu])
+			continue;
+
+		policy = cpufreq_cpu_get(cpu);
+		if (policy) {
+			cpu_data = kzalloc(sizeof(*cpu_data), GFP_KERNEL);
+			if (!cpu_data) {
+				ret = -ENOMEM;
+				goto out;
+			}
+
+			cpu_dev = get_cpu_device(cpu);
+			if (!cpu_dev) {
+				dev_err(dev, "failed to get cpu device\n");
+				ret = -ENODEV;
+				goto out;
+			}
+
+			opp_table = dev_pm_opp_get_opp_table(cpu_dev);
+			if (IS_ERR(opp_table)) {
+				ret = PTR_ERR(opp_table);
+				goto out;
+			}
+
+			cpu_data->dev = cpu_dev;
+			cpu_data->opp_table = opp_table;
+			cpu_data->first_cpu = cpumask_first(policy->related_cpus);
+			cpu_data->cur_freq = policy->cur;
+			cpu_data->min_freq = policy->cpuinfo.min_freq;
+			cpu_data->max_freq = policy->cpuinfo.max_freq;
+
+			p_data->cpu_data[cpu] = cpu_data;
+			cpufreq_cpu_put(policy);
+		} else {
+			ret = -EPROBE_DEFER;
+			goto out;
+		}
+	}
+out:
+	put_online_cpus();
+	if (ret)
+		return ret;
+
+	mutex_lock(&devfreq->lock);
+	ret = devfreq_update_target(devfreq, 0L);
+	mutex_unlock(&devfreq->lock);
+	if (ret)
+		dev_err(dev, "failed to update the frequency\n");
+
+	return ret;
+}
+
+static int cpufreq_passive_unregister_notifier(struct devfreq *devfreq)
+{
+	struct devfreq_passive_data *p_data
+			= (struct devfreq_passive_data *)devfreq->data;
+	struct devfreq_cpu_data *cpu_data;
+	int cpu;
+
+	if (p_data->nb.notifier_call)
+		cpufreq_unregister_notifier(&p_data->nb, CPUFREQ_TRANSITION_NOTIFIER);
+
+	for_each_possible_cpu(cpu) {
+		cpu_data = p_data->cpu_data[cpu];
+		if (cpu_data) {
+			if (cpu_data->opp_table)
+				dev_pm_opp_put_opp_table(cpu_data->opp_table);
+			kfree(cpu_data);
+			cpu_data = NULL;
+		}
+	}
+
+	return 0;
+}
+
 static int devfreq_passive_notifier_call(struct notifier_block *nb,
 				unsigned long event, void *ptr)
 {
@@ -140,7 +379,7 @@ static int devfreq_passive_event_handler(struct devfreq *devfreq,
 	struct notifier_block *nb = &p_data->nb;
 	int ret = 0;
 
-	if (!parent)
+	if (p_data->parent_type == DEVFREQ_PARENT_DEV && !parent)
 		return -EPROBE_DEFER;
 
 	switch (event) {
@@ -148,13 +387,24 @@ static int devfreq_passive_event_handler(struct devfreq *devfreq,
 		if (!p_data->this)
 			p_data->this = devfreq;
 
-		nb->notifier_call = devfreq_passive_notifier_call;
-		ret = devfreq_register_notifier(parent, nb,
-					DEVFREQ_TRANSITION_NOTIFIER);
+		if (p_data->parent_type == DEVFREQ_PARENT_DEV) {
+			nb->notifier_call = devfreq_passive_notifier_call;
+			ret = devfreq_register_notifier(parent, nb,
+						DEVFREQ_TRANSITION_NOTIFIER);
+		} else if (p_data->parent_type == CPUFREQ_PARENT_DEV) {
+			ret = cpufreq_passive_register_notifier(devfreq);
+		} else {
+			ret = -EINVAL;
+		}
 		break;
 	case DEVFREQ_GOV_STOP:
-		WARN_ON(devfreq_unregister_notifier(parent, nb,
-					DEVFREQ_TRANSITION_NOTIFIER));
+		if (p_data->parent_type == DEVFREQ_PARENT_DEV)
+			WARN_ON(devfreq_unregister_notifier(parent, nb,
+						DEVFREQ_TRANSITION_NOTIFIER));
+		else if (p_data->parent_type == CPUFREQ_PARENT_DEV)
+			WARN_ON(cpufreq_passive_unregister_notifier(devfreq));
+		else
+			ret = -EINVAL;
 		break;
 	default:
 		break;
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index 142474b4af96..cfa0ef54841e 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -38,6 +38,7 @@ enum devfreq_timer {
 
 struct devfreq;
 struct devfreq_governor;
+struct devfreq_cpu_data;
 struct thermal_cooling_device;
 
 /**
@@ -288,6 +289,11 @@ struct devfreq_simple_ondemand_data {
 #endif
 
 #if IS_ENABLED(CONFIG_DEVFREQ_GOV_PASSIVE)
+enum devfreq_parent_dev_type {
+	DEVFREQ_PARENT_DEV,
+	CPUFREQ_PARENT_DEV,
+};
+
 /**
  * struct devfreq_passive_data - ``void *data`` fed to struct devfreq
  *	and devfreq_add_device
@@ -299,8 +305,10 @@ struct devfreq_simple_ondemand_data {
  *			using governors except for passive governor.
  *			If the devfreq device has the specific method to decide
  *			the next frequency, should use this callback.
- * @this:	the devfreq instance of own device.
- * @nb:		the notifier block for DEVFREQ_TRANSITION_NOTIFIER list
+ + * @parent_type	parent type of the device
+ + * @this:		the devfreq instance of own device.
+ + * @nb:		the notifier block for DEVFREQ_TRANSITION_NOTIFIER list
+ + * @cpu_data:		the state min/max/current frequency of all online cpu's
  *
  * The devfreq_passive_data have to set the devfreq instance of parent
  * device with governors except for the passive governor. But, don't need to
@@ -314,9 +322,13 @@ struct devfreq_passive_data {
 	/* Optional callback to decide the next frequency of passvice device */
 	int (*get_target_freq)(struct devfreq *this, unsigned long *freq);
 
+	/* Should set the type of parent device */
+	enum devfreq_parent_dev_type parent_type;
+
 	/* For passive governor's internal use. Don't need to set them */
 	struct devfreq *this;
 	struct notifier_block nb;
+	struct devfreq_cpu_data *cpu_data[NR_CPUS];
 };
 #endif
 
-- 
2.17.1


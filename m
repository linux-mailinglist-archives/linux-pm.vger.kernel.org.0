Return-Path: <linux-pm+bounces-39031-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6CBC99F15
	for <lists+linux-pm@lfdr.de>; Tue, 02 Dec 2025 04:08:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7DAE04E1604
	for <lists+linux-pm@lfdr.de>; Tue,  2 Dec 2025 03:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6545F22A4FE;
	Tue,  2 Dec 2025 03:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="kyrTHpqm"
X-Original-To: linux-pm@vger.kernel.org
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2071B424F
	for <linux-pm@vger.kernel.org>; Tue,  2 Dec 2025 03:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764644900; cv=none; b=eWpYT0j3MG0xOU2yW6c9R7tnrpWYNBklE2HTq8WADqSpeh9CcU9jQVvoZJYMJxlwr6aBPm7pNPUjQBoEeG089quuFV1scQ8c8PXW5ueSzyeCztlCBck7O245FoexLpnKECVtrdB9Noq46s1ygf2nRR2ZA6fKGFt1XSNSeuuDkXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764644900; c=relaxed/simple;
	bh=dwCwLzrwdVbe84dfg+Nz0rl3lK77oqeENJYOyXgCLj8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cB44txk/PyJyvF0U0r/1UQp213uIeCbV9OQuxgsoVrBzTyVp5BEJJkOpeONkB7gIqkw6RpV3koeLWm2wxIwrjC6gRzMmW21D7p6Z6okRpAqmziHz6y9SrmAjj6basW3hFweBaRE7yrGJL2EDOCqYDGCs733jXBuol2sfGlBhsVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=kyrTHpqm; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=WsqQ6IwM/SUcKOB6IOo5ZP0W1mzKw9Uqzqixynmdc9s=;
	b=kyrTHpqmSUGXYG66aPwDt1d1QxdWz+4xLKOuSqrSI+us04cNxWk/b6+xqL6PXVrWZxyNZ2f0a
	FwjgDYxVYrjNZWsRiRTPThg9+4XBmRpMCbgtM7cpa4NdBkrBd4Og8xriX9hVWj4URg1hKG3Upyx
	O29T8MgLlTNLFIa+Dz5VhI8=
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4dL5JT0nbZz1K9Br;
	Tue,  2 Dec 2025 11:06:17 +0800 (CST)
Received: from kwepemf200001.china.huawei.com (unknown [7.202.181.227])
	by mail.maildlp.com (Postfix) with ESMTPS id D4433180043;
	Tue,  2 Dec 2025 11:08:06 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemf200001.china.huawei.com
 (7.202.181.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 2 Dec
 2025 11:08:05 +0800
Message-ID: <246a9483-850c-4c06-ac48-d03e0ae0bcec@huawei.com>
Date: Tue, 2 Dec 2025 11:08:05 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/3] arm64: topology: Handle AMU FIE setup on CPU
 hotplug
To: Beata Michalska <beata.michalska@arm.com>
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <rafael@kernel.org>,
	<viresh.kumar@linaro.org>, <sudeep.holla@arm.com>,
	<gregkh@linuxfoundation.org>, <dakr@kernel.org>, <ionela.voinescu@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<vincent.guittot@linaro.org>, <zhanjie9@hisilicon.com>,
	<lihuisong@huawei.com>, <yubowen8@huawei.com>, <zhangpengjie2@huawei.com>,
	<wangzhi12@huawei.com>, <linhongye@h-partners.com>
References: <20251119081356.2495290-1-zhenglifeng1@huawei.com>
 <aS2z0EURwHbbGZab@arm.com> <9b6882dc-a91a-42d6-bf76-347338930d71@huawei.com>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <9b6882dc-a91a-42d6-bf76-347338930d71@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemf200001.china.huawei.com (7.202.181.227)

On 2025/12/2 11:05, zhenglifeng (A) wrote:
> On 2025/12/1 23:27, Beata Michalska wrote:
>> Hi,
>>
>> Apologies for the delay in reviewing this - currently in progress....
>> Out of curiosity: what's the cpufreq driver used for testing this series ?
> 
> I used cppc_cpufreq for testing this. But with some modifications in
> processor_driver.c, or you'll find that the driver will fail to load with
> maxcpus set. The modification below is only a temporary solution. I'm still
> working on that.

In addition, I exposed some sysfs interfaces for easily checking freq scale
and source as below when testing. Hope this helps.

---
diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 331a0654f3dc..ba15c90cf908 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -98,6 +98,23 @@ void topology_set_scale_freq_source(struct scale_freq_data *data,
 }
 EXPORT_SYMBOL_GPL(topology_set_scale_freq_source);
 
+int topology_get_scale_freq_source(int cpu)
+{
+	struct scale_freq_data *sfd;
+	int scale_freq_source;
+
+	rcu_read_lock();
+
+	sfd = rcu_dereference(*per_cpu_ptr(&sft_data, cpu));
+	if (sfd)
+		scale_freq_source = sfd->source;
+
+	rcu_read_unlock();
+
+	return scale_freq_source;
+}
+EXPORT_SYMBOL_GPL(topology_get_scale_freq_source);
+
 void topology_clear_scale_freq_source(enum scale_freq_source source,
 				      const struct cpumask *cpus)
 {
diff --git a/drivers/base/topology.c b/drivers/base/topology.c
index c890e2a5b428..79c0dc8d5361 100644
--- a/drivers/base/topology.c
+++ b/drivers/base/topology.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/hardirq.h>
 #include <linux/topology.h>
+#include <linux/arch_topology.h>
 
 #define define_id_show_func(name, fmt)					\
 static ssize_t name##_show(struct device *dev,				\
@@ -226,7 +227,27 @@ static ssize_t cpu_capacity_show(struct device *dev,
 	return sysfs_emit(buf, "%lu\n", topology_get_cpu_scale(cpu->dev.id));
 }
 
+static ssize_t arch_freq_scale_show(struct device *dev,
+				    struct device_attribute *attr,
+				    char *buf)
+{
+	struct cpu *cpu = container_of(dev, struct cpu, dev);
+
+	return sysfs_emit(buf, "%lu\n", topology_get_freq_scale(cpu->dev.id));
+}
+
+static ssize_t scale_freq_source_show(struct device *dev,
+				    struct device_attribute *attr,
+				    char *buf)
+{
+	struct cpu *cpu = container_of(dev, struct cpu, dev);
+
+	return sysfs_emit(buf, "%d\n", topology_get_scale_freq_source(cpu->dev.id));
+}
+
 static DEVICE_ATTR_RO(cpu_capacity);
+static DEVICE_ATTR_RO(arch_freq_scale);
+static DEVICE_ATTR_RO(scale_freq_source);
 
 static int cpu_capacity_sysctl_add(unsigned int cpu)
 {
@@ -236,6 +257,8 @@ static int cpu_capacity_sysctl_add(unsigned int cpu)
 		return -ENOENT;
 
 	device_create_file(cpu_dev, &dev_attr_cpu_capacity);
+	device_create_file(cpu_dev, &dev_attr_arch_freq_scale);
+	device_create_file(cpu_dev, &dev_attr_scale_freq_source);
 
 	return 0;
 }
@@ -248,6 +271,8 @@ static int cpu_capacity_sysctl_remove(unsigned int cpu)
 		return -ENOENT;
 
 	device_remove_file(cpu_dev, &dev_attr_cpu_capacity);
+	device_remove_file(cpu_dev, &dev_attr_arch_freq_scale);
+	device_remove_file(cpu_dev, &dev_attr_scale_freq_source);
 
 	return 0;
 }
diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
index d72d6e5aa200..0149aef7b684 100644
--- a/include/linux/arch_topology.h
+++ b/include/linux/arch_topology.h
@@ -47,6 +47,7 @@ struct scale_freq_data {
 
 void topology_scale_freq_tick(void);
 void topology_set_scale_freq_source(struct scale_freq_data *data, const struct cpumask *cpus);
+int topology_get_scale_freq_source(int cpu);
 void topology_clear_scale_freq_source(enum scale_freq_source source, const struct cpumask *cpus);
 
 DECLARE_PER_CPU(unsigned long, hw_pressure);



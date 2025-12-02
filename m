Return-Path: <linux-pm+bounces-39030-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B368AC99F0C
	for <lists+linux-pm@lfdr.de>; Tue, 02 Dec 2025 04:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 33AE134579F
	for <lists+linux-pm@lfdr.de>; Tue,  2 Dec 2025 03:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F3722A1D5;
	Tue,  2 Dec 2025 03:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="xjeHDNN9"
X-Original-To: linux-pm@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C82226CEB
	for <linux-pm@vger.kernel.org>; Tue,  2 Dec 2025 03:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764644732; cv=none; b=tD729a24Q8XxN1YXRdYLBC/dnZO1cp1yopvbm1CYP6H84/3+njjXBMLJGnr7tVpDlNG41Ed7gDOvVGkPKj+ZwFaN+OMLBD82Itkni+yRzmI5uJj5bZTLrgvuWKOpsIzLrwTrurrZ+G48YE9W6M1XNaifkXdOukpcMZTGrducFiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764644732; c=relaxed/simple;
	bh=lqNIgIY+afxV0mHMgDFAIzYr+EQRx9gQqS+OcL3djYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DJXp/FfTLyD+lkyVOrr+FUtVQSLyowzLDEqXg3CBE0IiON77P/Gl8FIa1Sxf5YNnGolGfjIzlm/+nXluKkeMQ3HMxam0G+uZJmGJQ5bpnaveilqEEPUxlDWKV+by2+EIpQ/eoEpZrUjv8D2tlVdLjO1bA9IarHaLStw94APUGmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=xjeHDNN9; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=2rHXvW4bH2/TkN92iJH0Vzt3Jt0dYt/xjH5QzdLvm88=;
	b=xjeHDNN9+fo8cNPhS2c+DJMc95d+4P81B/vT/nPXVcOtiZnW2yOdfcIskGbWGg+lI/cO1ZB+B
	BEKZ+K/uWz5AcFmOXYuStF9AjrZjtYCM9ZOA7TcbZ/632Pl1Cg5/WOMNyKvYPukVfiWFKSAj1RV
	oJKQRAKiafxaXq3SglknfpU=
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4dL5FN26LKz1T4Hj;
	Tue,  2 Dec 2025 11:03:36 +0800 (CST)
Received: from kwepemf200001.china.huawei.com (unknown [7.202.181.227])
	by mail.maildlp.com (Postfix) with ESMTPS id 0A2C5180485;
	Tue,  2 Dec 2025 11:05:27 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemf200001.china.huawei.com
 (7.202.181.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 2 Dec
 2025 11:05:26 +0800
Message-ID: <9b6882dc-a91a-42d6-bf76-347338930d71@huawei.com>
Date: Tue, 2 Dec 2025 11:05:25 +0800
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
 <aS2z0EURwHbbGZab@arm.com>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <aS2z0EURwHbbGZab@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemf200001.china.huawei.com (7.202.181.227)

On 2025/12/1 23:27, Beata Michalska wrote:
> Hi,
> 
> Apologies for the delay in reviewing this - currently in progress....
> Out of curiosity: what's the cpufreq driver used for testing this series ?

I used cppc_cpufreq for testing this. But with some modifications in
processor_driver.c, or you'll find that the driver will fail to load with
maxcpus set. The modification below is only a temporary solution. I'm still
working on that.

---
diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
index 5d824435b26b..2f286a1b0b02 100644
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -33,6 +33,7 @@ MODULE_AUTHOR("Paul Diefenbaugh");
 MODULE_DESCRIPTION("ACPI Processor Driver");
 MODULE_LICENSE("GPL");
 
+static int acpi_processor_start(struct device *dev);
 static int acpi_processor_stop(struct device *dev);
 
 static const struct acpi_device_id processor_device_ids[] = {
@@ -46,6 +47,7 @@ static struct device_driver acpi_processor_driver = {
 	.name = "processor",
 	.bus = &cpu_subsys,
 	.acpi_match_table = processor_device_ids,
+	.probe = acpi_processor_start,
 	.remove = acpi_processor_stop,
 };
 
@@ -191,6 +193,21 @@ static int __acpi_processor_start(struct acpi_device *device)
 	return result;
 }
 
+static int acpi_processor_start(struct device *dev)
+{
+	struct acpi_device *device = ACPI_COMPANION(dev);
+	int ret;
+
+	if (!device)
+		return -ENODEV;
+
+	/* Protect against concurrent CPU hotplug operations */
+	cpu_hotplug_disable();
+	ret = __acpi_processor_start(device);
+	cpu_hotplug_enable();
+	return ret;
+}
+
 static int acpi_processor_stop(struct device *dev)
 {
 	struct acpi_device *device = ACPI_COMPANION(dev);
@@ -264,9 +281,9 @@ static int __init acpi_processor_driver_init(void)
 
 	acpi_processor_register_idle_driver();
 
-	result = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
-				   "acpi/cpu-drv:online",
-				   acpi_soft_cpu_online, NULL);
+	result = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
+					   "acpi/cpu-drv:online",
+					   acpi_soft_cpu_online, NULL);
 	if (result < 0)
 		goto err;
 	hp_online = result;

> 
> ---
> BR
> Beata
> On Wed, Nov 19, 2025 at 04:13:53PM +0800, Lifeng Zheng wrote:
>> Solve a problem that causes CPUs Setup AMU FIE failed in a corner case,
>> even though they're eligible.
>>
>>
> 



Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86A4E1EB3CE
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jun 2020 05:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725872AbgFBDe1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Jun 2020 23:34:27 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:52160 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725850AbgFBDe1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 1 Jun 2020 23:34:27 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 9F2B0CF6E2AC83EB5307;
        Tue,  2 Jun 2020 11:34:24 +0800 (CST)
Received: from [127.0.0.1] (10.166.215.101) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Tue, 2 Jun 2020
 11:34:17 +0800
To:     <viresh.kumar@linaro.org>, <rjw@rjwysocki.net>
CC:     <guohanjun@huawei.com>, <Sudeep.Holla@arm.com>,
        <ionela.voinescu@arm.com>, <wangxiongfeng2@huawei.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
Subject: [Question]: about 'cpuinfo_cur_freq' shown in sysfs when the CPU is
 in idle state
Message-ID: <f1773fdc-f6ef-ec28-0c0a-4a09e66ab63b@huawei.com>
Date:   Tue, 2 Jun 2020 11:34:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.166.215.101]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Viresh,

Sorry to disturb you about another problem as follows.

CPPC use the increment of Desired Performance counter and Reference Performance
counter to get the CPU frequency and show it in sysfs through
'cpuinfo_cur_freq'. But ACPI CPPC doesn't specifically define the behavior of
these two counters when the CPU is in idle state, such as stop incrementing when
the CPU is in idle state.

ARMv8.4 Extension inctroduced support for the Activity Monitors Unit (AMU). The
processor frequency cycles and constant frequency cycles in AMU can be used as
Delivered Performance counter and Reference Performance counter. These two
counter in AMU does not increase when the PE is in WFI or WFE. So the increment
is zero when the PE is in WFI/WFE. This cause no issue because
'cppc_get_rate_from_fbctrs()' in cppc_cpufreq driver will check the increment
and return the desired performance if the increment is zero.

But when the CPU goes into power down idle state, accessing these two counters
in AMU by memory-mapped address will return zero. Such as CPU1 went into power
down idle state and CPU0 try to get the frequency of CPU1. In this situation,
will display a very big value for 'cpuinfo_cur_freq' in sysfs. Do you have some
advice about this problem ?

I was thinking about an idea as follows. We can run 'cppc_cpufreq_get_rate()' on
the CPU to be measured, so that we can make sure the CPU is in C0 state when we
access the two counters. Also we can return the actual frequency rather than
desired performance when the CPU is in WFI/WFE. But this modification will
change the existing logical and I am not sure if this will cause some bad effect.


diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 257d726..ded3bcc 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -396,9 +396,10 @@ static int cppc_get_rate_from_fbctrs(struct cppc_cpudata *cpu,
        return cppc_cpufreq_perf_to_khz(cpu, delivered_perf);
 }

-static unsigned int cppc_cpufreq_get_rate(unsigned int cpunum)
+static int cppc_cpufreq_get_rate_cpu(void *info)
 {
        struct cppc_perf_fb_ctrs fb_ctrs_t0 = {0}, fb_ctrs_t1 = {0};
+ unsigned int cpunum = *(unsigned int *)info;
        struct cppc_cpudata *cpu = all_cpu_data[cpunum];
        int ret;

@@ -418,6 +419,22 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpunum)
        return cppc_get_rate_from_fbctrs(cpu, fb_ctrs_t0, fb_ctrs_t1);
 }

+static unsigned int cppc_cpufreq_get_rate(unsigned int cpunum)
+{
+ unsigned int ret;
+
+ ret = smp_call_on_cpu(cpunum, cppc_cpufreq_get_rate_cpu, &cpunum, true);
+
+ /*
+  * convert negative error code to zero, otherwise we will display
+  * an odd value for 'cpuinfo_cur_freq' in sysfs
+  */
+ if (ret < 0)
+         ret = 0;
+
+ return ret;
+}
+
 static int cppc_cpufreq_set_boost(struct cpufreq_policy *policy, int state)
 {
        struct cppc_cpudata *cpudata;


Thanks,
Xiongfeng


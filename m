Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE2E1D7192
	for <lists+linux-pm@lfdr.de>; Mon, 18 May 2020 09:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgERHQq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 May 2020 03:16:46 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4810 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726729AbgERHQq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 18 May 2020 03:16:46 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id DF2C3410768E010C9926;
        Mon, 18 May 2020 15:16:43 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Mon, 18 May 2020 15:16:33 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <rjw@rjwysocki.net>, <viresh.kumar@linaro.org>,
        <Souvik.Chakravarty@arm.com>, <Thanu.Rangarajan@arm.com>
CC:     <Sudeep.Holla@arm.com>, <guohanjun@huawei.com>,
        <john.garry@huawei.com>, <jonathan.cameron@huawei.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangxiongfeng2@huawei.com>
Subject: [RFC PATCH v2 0/3] add SW BOOST support for CPPC
Date:   Mon, 18 May 2020 15:10:05 +0800
Message-ID: <1589785808-12138-1-git-send-email-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

ACPI spec 6.2 section 8.4.7.1 provide the following two CPC registers.

"Highest performance is the absolute maximum performance an individual
processor may reach, assuming ideal conditions. This performance level
may not be sustainable for long durations, and may only be achievable if
other platform components are in a specific state; for example, it may
require other processors be in an idle state.

Nominal Performance is the maximum sustained performance level of the
processor, assuming ideal operating conditions. In absence of an
external constraint (power, thermal, etc.) this is the performance level
the platform is expected to be able to maintain continuously. All
processors are expected to be able to sustain their nominal performance
state simultaneously."

We can use Highest Performance as the max performance in boost mode and
Nomial Performance as the max performance in non-boost mode. If the
Highest Performance is greater than the Nominal Performance, we assume
SW BOOST is supported.

Xiongfeng Wang (3):
  cpufreq: handle the return value of '.set_boost()' properly
  cpufreq: export 'cpufreq_policy_list' and make macro
    'for_each_*_policy' public
  CPPC: add support for SW BOOST

 drivers/cpufreq/cppc_cpufreq.c | 42 ++++++++++++++++++++++++++++++++++++++++--
 drivers/cpufreq/cpufreq.c      | 21 ++++++---------------
 include/linux/cpufreq.h        | 14 ++++++++++++++
 3 files changed, 60 insertions(+), 17 deletions(-)

-- 
1.7.12.4


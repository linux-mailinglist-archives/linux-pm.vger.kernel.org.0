Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01A331D958C
	for <lists+linux-pm@lfdr.de>; Tue, 19 May 2020 13:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728837AbgESLr5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 May 2020 07:47:57 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4866 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726880AbgESLr5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 19 May 2020 07:47:57 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B16082A384A26CA1F027;
        Tue, 19 May 2020 19:47:54 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Tue, 19 May 2020 19:47:46 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <rjw@rjwysocki.net>, <viresh.kumar@linaro.org>,
        <Souvik.Chakravarty@arm.com>, <Thanu.Rangarajan@arm.com>
CC:     <Sudeep.Holla@arm.com>, <guohanjun@huawei.com>,
        <john.garry@huawei.com>, <jonathan.cameron@huawei.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangxiongfeng2@huawei.com>
Subject: [RFC PATCH v3 0/2] add SW BOOST support for CPPC
Date:   Tue, 19 May 2020 19:41:27 +0800
Message-ID: <1589888489-13828-1-git-send-email-wangxiongfeng2@huawei.com>
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

Xiongfeng Wang (2):
  cpufreq: change '.set_boost' to act on only one policy
  CPPC: add support for SW BOOST

 drivers/cpufreq/acpi-cpufreq.c |  4 ++--
 drivers/cpufreq/cppc_cpufreq.c | 39 +++++++++++++++++++++++++++++--
 drivers/cpufreq/cpufreq.c      | 53 +++++++++++++++++++++---------------------
 include/linux/cpufreq.h        |  2 +-
 4 files changed, 67 insertions(+), 31 deletions(-)

-- 
1.7.12.4


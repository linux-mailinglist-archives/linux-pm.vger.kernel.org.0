Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0E6E4647A9
	for <lists+linux-pm@lfdr.de>; Wed,  1 Dec 2021 08:12:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347121AbhLAHQD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Dec 2021 02:16:03 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:28203 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347106AbhLAHQD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Dec 2021 02:16:03 -0500
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4J3qxH3Qnyz8vnB;
        Wed,  1 Dec 2021 15:10:43 +0800 (CST)
Received: from dggpeml500006.china.huawei.com (7.185.36.76) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 1 Dec 2021 15:12:41 +0800
Received: from huawei.com (10.175.100.227) by dggpeml500006.china.huawei.com
 (7.185.36.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Wed, 1 Dec
 2021 15:12:41 +0800
From:   Tang Yizhou <tangyizhou@huawei.com>
To:     <viresh.kumar@linaro.org>, <rafael.j.wysocki@intel.com>,
        <rafael@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <zhengbin13@huawei.com>, Tang Yizhou <tangyizhou@huawei.com>
Subject: [PATCH v3 0/2] cpufreq: Update function comment and document
Date:   Wed, 1 Dec 2021 15:40:19 +0800
Message-ID: <20211201074021.18097-1-tangyizhou@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.100.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500006.china.huawei.com (7.185.36.76)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

v3:
Take viresh's advice and update the comments in cpufreq.c

v2:
1. Take viresh's advice and update the comments in cpufreq.c
2. Add an Acked-by tag in Patch 2.

Tang Yizhou (2):
  cpufreq: Fix a comment in cpufreq_policy_free
  doc/cpufreq: Update core.rst

 Documentation/cpu-freq/core.rst | 6 +++---
 drivers/cpufreq/cpufreq.c       | 5 +++--
 2 files changed, 6 insertions(+), 5 deletions(-)

-- 
2.17.1


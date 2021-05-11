Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B865637A5F0
	for <lists+linux-pm@lfdr.de>; Tue, 11 May 2021 13:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbhEKLqR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 May 2021 07:46:17 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2421 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbhEKLqQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 May 2021 07:46:16 -0400
Received: from dggeml764-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Ffbcz6XNqz61Sn;
        Tue, 11 May 2021 19:42:27 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggeml764-chm.china.huawei.com (10.1.199.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 11 May 2021 19:45:07 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 11 May
 2021 19:45:06 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
CC:     <viresh.kumar@linaro.org>, <rjw@rjwysocki.net>
Subject: [PATCH -next] cpufreq: cppc: Remove unnecessary INIT_LIST_HEAD()
Date:   Tue, 11 May 2021 19:47:03 +0800
Message-ID: <20210511114703.3790524-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The list_head cpu_data_list is initialized statically.
It is unnecessary to initialize by INIT_LIST_HEAD().

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 3848b4c222e1..b312fa210a39 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -723,8 +723,6 @@ static int __init cppc_cpufreq_init(void)
 	if ((acpi_disabled) || !acpi_cpc_valid())
 		return -ENODEV;
 
-	INIT_LIST_HEAD(&cpu_data_list);
-
 	cppc_check_hisi_workaround();
 
 	ret = cpufreq_register_driver(&cppc_cpufreq_driver);
-- 
2.25.1


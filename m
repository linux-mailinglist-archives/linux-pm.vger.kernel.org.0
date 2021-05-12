Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D76137B6C7
	for <lists+linux-pm@lfdr.de>; Wed, 12 May 2021 09:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbhELHX4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 May 2021 03:23:56 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2364 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbhELHX4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 May 2021 03:23:56 -0400
Received: from dggeml704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Fg5l02R2Bz60Wb;
        Wed, 12 May 2021 15:19:24 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggeml704-chm.china.huawei.com (10.3.17.142) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Wed, 12 May 2021 15:22:46 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 12 May
 2021 15:22:46 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <rjw@rjwysocki.net>
Subject: [PATCH -next] PM: domains: fix some kernel-doc issues
Date:   Wed, 12 May 2021 15:25:15 +0800
Message-ID: <20210512072515.3820032-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fix the following make W=1 kernel build warnings:

  drivers/base/power/domain_governor.c:259: warning: Function parameter or member 'now' not described in '_default_power_down_ok'
  drivers/base/power/domain.c:581: warning: Function parameter or member 'depth' not described in 'genpd_power_off'
  drivers/base/power/domain.c:2520: warning: Function parameter or member 'np' not described in 'of_genpd_remove_last'
  drivers/base/power/domain.c:2520: warning: Excess function parameter 'provider' description in 'of_genpd_remove_last'

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/base/power/domain.c          | 3 ++-
 drivers/base/power/domain_governor.c | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index b6a782c31613..5695a641efd3 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -572,6 +572,7 @@ static void genpd_queue_power_off_work(struct generic_pm_domain *genpd)
  * RPM status of the releated device is in an intermediate state, not yet turned
  * into RPM_SUSPENDED. This means genpd_power_off() must allow one device to not
  * be RPM_SUSPENDED, while it tries to power off the PM domain.
+ * @depth: nesting count for lockdep.
  *
  * If all of the @genpd's devices have been suspended and all of its subdomains
  * have been powered down, remove power from @genpd.
@@ -2505,7 +2506,7 @@ EXPORT_SYMBOL_GPL(of_genpd_remove_subdomain);
 
 /**
  * of_genpd_remove_last - Remove the last PM domain registered for a provider
- * @provider: Pointer to device structure associated with provider
+ * @np: Pointer to device node associated with provider
  *
  * Find the last PM domain that was added by a particular provider and
  * remove this PM domain from the list of PM domains. The provider is
diff --git a/drivers/base/power/domain_governor.c b/drivers/base/power/domain_governor.c
index c6c218758f0b..cd08c5885190 100644
--- a/drivers/base/power/domain_governor.c
+++ b/drivers/base/power/domain_governor.c
@@ -252,6 +252,7 @@ static bool __default_power_down_ok(struct dev_pm_domain *pd,
 /**
  * _default_power_down_ok - Default generic PM domain power off governor routine.
  * @pd: PM domain to check.
+ * @now: current ktime.
  *
  * This routine must be executed under the PM domain's lock.
  */
-- 
2.25.1


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49CDE5EC794
	for <lists+linux-pm@lfdr.de>; Tue, 27 Sep 2022 17:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbiI0PYN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Sep 2022 11:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbiI0PYM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Sep 2022 11:24:12 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F711616DA
        for <linux-pm@vger.kernel.org>; Tue, 27 Sep 2022 08:24:10 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4McNbF4Xs2z1N7Gw;
        Tue, 27 Sep 2022 23:19:53 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 27 Sep 2022 23:24:08 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 27 Sep
 2022 23:24:08 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-pm@vger.kernel.org>
CC:     <rafael@kernel.org>, <viresh.kumar@linaro.org>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next 0/4] cpufreq: Switch to use dev_err_probe() helper
Date:   Tue, 27 Sep 2022 23:40:17 +0800
Message-ID: <20220927154021.816570-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patchset is trying to replace dev_err() with dev_err_probe() in
the probe path. With this helper, it prints the error name instead of
printing error code which is more readable and sets the defer probe
reason which can be checked later through debugfs, and it makes error
path more clean.

Yang Yingliang (4):
  cpufreq: dt: Switch to use dev_err_probe() helper
  cpufreq: imx6q: Switch to use dev_err_probe() helper
  cpufreq: qcom-nvmem: Switch to use dev_err_probe() helper
  cpufreq: sun50i: Switch to use dev_err_probe() helper

 drivers/cpufreq/cpufreq-dt.c           | 6 ++----
 drivers/cpufreq/imx6q-cpufreq.c        | 4 +---
 drivers/cpufreq/qcom-cpufreq-nvmem.c   | 7 ++-----
 drivers/cpufreq/sun50i-cpufreq-nvmem.c | 9 +++------
 4 files changed, 8 insertions(+), 18 deletions(-)

-- 
2.25.1


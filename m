Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8A2772588
	for <lists+linux-pm@lfdr.de>; Mon,  7 Aug 2023 15:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbjHGNYj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Aug 2023 09:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234023AbjHGNX6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Aug 2023 09:23:58 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6842E2682
        for <linux-pm@vger.kernel.org>; Mon,  7 Aug 2023 06:23:10 -0700 (PDT)
Received: from dggpemm500008.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RKH5m5MPDzfbnd;
        Mon,  7 Aug 2023 21:21:32 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500008.china.huawei.com (7.185.36.136) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 7 Aug 2023 21:22:42 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 21:22:41 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-pm@vger.kernel.org>
CC:     <sre@kernel.org>, <yangyingliang@huawei.com>
Subject: [PATCH -next 0/5] power: reset: use builtin_platform_driver() to simplify code
Date:   Mon, 7 Aug 2023 21:19:46 +0800
Message-ID: <20230807131951.3443880-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The driver init function doesn't do anything special, so it can use the
builtin_platform_driver() macro to eliminate boilerplate code.

Yang Yingliang (5):
  power: reset: st-poweroff: use builtin_platform_driver() to simplify
    code
  power: reset: msm: use builtin_platform_driver() to simplify code
  power: reset: xgene-reboot: use builtin_platform_driver() to simplify
    code
  power: reset: axxia-reset: use builtin_platform_driver() to simplify
    code
  power: reset: syscon-poweroff: use builtin_platform_driver() to
    simplify code

 drivers/power/reset/axxia-reset.c     | 7 +------
 drivers/power/reset/msm-poweroff.c    | 7 +------
 drivers/power/reset/st-poweroff.c     | 7 +------
 drivers/power/reset/syscon-poweroff.c | 7 +------
 drivers/power/reset/xgene-reboot.c    | 7 +------
 5 files changed, 5 insertions(+), 30 deletions(-)

-- 
2.25.1


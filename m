Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCC0572FA1F
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jun 2023 12:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234209AbjFNKI6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 14 Jun 2023 06:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234921AbjFNKIz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 14 Jun 2023 06:08:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDBE81BC6
        for <linux-pm@vger.kernel.org>; Wed, 14 Jun 2023 03:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686737289;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ECLt4MQqsZaUqdVLVd32V9JuvnwGyQKanHPSvRz66bs=;
        b=UJVNqbJTTq6RWNXneJNzTjDxbZF5VRBvBAxIw9z3u5BdqH9YzT5tCOpKu5haEBa8GGqwUc
        Wlwo3o8PlkNLBHxgrGcaytS1a/nGJGKDTrBtnu64mzzSXGfxZmtAewTq1BITB7FqxUXQ83
        jSakz7OFco7aAcHgzfayeg/1Xz8DQi8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-292-0Si8CIIrMQ-khoOpU0YGkA-1; Wed, 14 Jun 2023 06:08:05 -0400
X-MC-Unique: 0Si8CIIrMQ-khoOpU0YGkA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5727585A58A;
        Wed, 14 Jun 2023 10:08:05 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.193.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4A3461121314;
        Wed, 14 Jun 2023 10:08:04 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        Bernhard Krug <b.krug@elektronenpumpe.de>,
        stable@vger.kernel.org
Subject: [PATCH] thermal/intel/intel_soc_dts_iosf: Fix reporting wrong temperatures
Date:   Wed, 14 Jun 2023 12:07:56 +0200
Message-Id: <20230614100756.437606-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Since commit 955fb8719efb ("thermal/intel/intel_soc_dts_iosf: Use Intel
TCC library") intel_soc_dts_iosf is reporting the wrong temperature.

The driver expects tj_max to be in milli-degrees-celcius but after
the switch to the TCC library this is now in degrees celcius so
instead of e.g. 90000 it is set to 90 causing a temperature 45
degrees below tj_max to be reported as -44910 milli-degrees
instead of as 45000 milli-degrees.

Fix this by adding back the lost factor of 1000.

Fixes: 955fb8719efb ("thermal/intel/intel_soc_dts_iosf: Use Intel TCC library")
Reported-by: Bernhard Krug <b.krug@elektronenpumpe.de>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Note reported by private email, so no Closes: tag
---
 drivers/thermal/intel/intel_soc_dts_iosf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/intel_soc_dts_iosf.c b/drivers/thermal/intel/intel_soc_dts_iosf.c
index f99dc7e4ae89..db97499f4f0a 100644
--- a/drivers/thermal/intel/intel_soc_dts_iosf.c
+++ b/drivers/thermal/intel/intel_soc_dts_iosf.c
@@ -398,7 +398,7 @@ struct intel_soc_dts_sensors *intel_soc_dts_iosf_init(
 	spin_lock_init(&sensors->intr_notify_lock);
 	mutex_init(&sensors->dts_update_lock);
 	sensors->intr_type = intr_type;
-	sensors->tj_max = tj_max;
+	sensors->tj_max = tj_max * 1000;
 	if (intr_type == INTEL_SOC_DTS_INTERRUPT_NONE)
 		notification = false;
 	else
-- 
2.40.1


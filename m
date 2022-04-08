Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1E24F9382
	for <lists+linux-pm@lfdr.de>; Fri,  8 Apr 2022 13:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbiDHLLh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 Apr 2022 07:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiDHLLf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 Apr 2022 07:11:35 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 810FF1705D
        for <linux-pm@vger.kernel.org>; Fri,  8 Apr 2022 04:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1649416171; x=1680952171;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DgXZH7WbSxWernALJcj9Fpx8ZlVIXSraIrzfrlCm1qs=;
  b=idm5KyaR2Juw1Ru3r7W/v64mMVr2CLryT2LlTGtCxUdFCNDvFXzgjH7i
   oTG9JtE2SsujiS65GXcgWg9caAvDjwtoHlTL84k9718k6sS/w6L/iLlGA
   n1q3wCCrh2luP7lpBz8A7zdvv+UbnyftKLaD8RPXd1s21LlJ+tDXVF2UI
   FO6LAJtHxCORkcWjIG1n08556i1z8acKooLs7LpBDJaQXyW67qoQLu1gw
   JQTr0A8o46wV/mgiKKv7ErhTBY4gzzAaF5hskdhvmLGpogs6aI29dLRVz
   +vdhuA/ut4PW/TKk6AXnPmMPySPmp6Qg2JIsZmw8OlYXETMX6+G04bH5d
   g==;
X-IronPort-AV: E=Sophos;i="5.90,244,1643670000"; 
   d="scan'208";a="23186346"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 08 Apr 2022 13:09:26 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Fri, 08 Apr 2022 13:09:26 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Fri, 08 Apr 2022 13:09:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1649416166; x=1680952166;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DgXZH7WbSxWernALJcj9Fpx8ZlVIXSraIrzfrlCm1qs=;
  b=W3qM+hKcvN+v7GKu+0DlpUleHmypsfZJIvozJgONU/PwYmlblgWR0yjQ
   8bIhl33KPcNJ5mtSYb9U+nNM+bdHeGfVvoHZJGQAko02m8sL68P/PhoR5
   WyEsL0bDk89vNyE9XgDlWCHUFzOoYCcGpOY7N9J8KCcS+PBxEk4B1gBY1
   pJSfyMCzbucKBiYcBxDEcfDByZzKNCST7GIULRxvIaj54ZVVB1uVfWscE
   YMfjO28naYmxDU7Dw52E7PTD76ETLiinPz9w0I82hbwp8hrU81d+yDszY
   t1ew3wdTqI7z/vDDnG9c7aQBzbDzTaw3u6CnaGCAU1xT+bD2bJU45RjlV
   g==;
X-IronPort-AV: E=Sophos;i="5.90,244,1643670000"; 
   d="scan'208";a="23186344"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 08 Apr 2022 13:09:26 +0200
Received: from steina-w.tq-net.de (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 694F9280075;
        Fri,  8 Apr 2022 13:09:25 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/2] thermal/drivers/thermal_helpers: Adjust output format
Date:   Fri,  8 Apr 2022 13:09:20 +0200
Message-Id: <20220408110920.3809225-2-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220408110920.3809225-1-alexander.stein@ew.tq-group.com>
References: <20220408110920.3809225-1-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Outputs like this where -1 is printed as unsigned is somewhat misleading
 thermal thermal_zone1: Trip3[type=0,temp=48000]:trend=4,throttle=1
 thermal cooling_device3: cur_state=1
 thermal cooling_device3: old_target=-1, target=2
 thermal cooling_device3: zone1->target=1
 thermal cooling_device3: zone1->target=2
 thermal cooling_device3: zone1->target=18446744073709551615
 thermal cooling_device3: set to state 2

With THERMAL_NO_TARGET assigning -1 as unsigned it make sense to print
the target as signed integer, even if the type is actually unsigned.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
An alternative would be to change thermal_instance::target from unsigned
long to long, but this would entail a lot of API & driver changes as well
which looks less intriguing.

 drivers/thermal/thermal_helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
index 3edd047e144f..0d0da6670267 100644
--- a/drivers/thermal/thermal_helpers.c
+++ b/drivers/thermal/thermal_helpers.c
@@ -199,7 +199,7 @@ void __thermal_cdev_update(struct thermal_cooling_device *cdev)
 
 	/* Make sure cdev enters the deepest cooling state */
 	list_for_each_entry(instance, &cdev->thermal_instances, cdev_node) {
-		dev_dbg(&cdev->device, "zone%d->target=%lu\n",
+		dev_dbg(&cdev->device, "zone%d->target=%ld\n",
 			instance->tz->id, instance->target);
 		if (instance->target == THERMAL_NO_TARGET)
 			continue;
-- 
2.25.1


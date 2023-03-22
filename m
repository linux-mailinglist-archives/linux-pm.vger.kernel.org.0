Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9AB86C56D3
	for <lists+linux-pm@lfdr.de>; Wed, 22 Mar 2023 21:10:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbjCVUKV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 Mar 2023 16:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbjCVUJb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 Mar 2023 16:09:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE4B7B3A0;
        Wed, 22 Mar 2023 13:02:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C8171622C1;
        Wed, 22 Mar 2023 20:02:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8019EC433EF;
        Wed, 22 Mar 2023 20:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679515323;
        bh=hK+x42Q/uF3uttO6IsFrAqE3HDLQUzKmJcaBgft0unU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jAnWrP9ErldxYgsuw5GexXiNfR0kF8+WiHOqt1cdKUaZwutQTM7NHDXo3SFLZ9prA
         QswBjS3AJAOUrUaGanVVRCt1MjqTuRPAsKfuW9zzzDahswXteubMJKZa2bq6kvecfr
         nKPQhlDdMK2DHukLafBnIUiMQe29Jklhbb+mn3lfN8OwLg2yp9N1IuSaVE8hkm1nHc
         SWanxJvzuOogJJeXIfINPtUkN2irzU/MfyR5oS1RYdlO2jLOuh2qM3psmmGrt9USNC
         SqE2TBxnpCArXuxIB4lWbMMkPHJvl4KfwQ0LVj6BoNHbbdbAaUVcYJrG40Yk2QevzF
         nXa/GjnsBBD1g==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Prarit Bhargava <prarit@redhat.com>, linux-pm@vger.kernel.org,
        Len Brown <len.brown@intel.com>,
        Sasha Levin <sashal@kernel.org>, lenb@kernel.org
Subject: [PATCH AUTOSEL 5.15 14/16] tools/power turbostat: Fix /dev/cpu_dma_latency warnings
Date:   Wed, 22 Mar 2023 16:01:18 -0400
Message-Id: <20230322200121.1997157-14-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230322200121.1997157-1-sashal@kernel.org>
References: <20230322200121.1997157-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Prarit Bhargava <prarit@redhat.com>

[ Upstream commit 40aafc7d58d3544f152a863a0e9863014b6d5d8c ]

When running as non-root the following error is seen in turbostat:

turbostat: fopen /dev/cpu_dma_latency
: Permission denied

turbostat and the man page have information on how to avoid other
permission errors, so these can be fixed the same way.

Provide better /dev/cpu_dma_latency warnings that provide instructions on
how to avoid the error, and update the man page.

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Len Brown <len.brown@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/power/x86/turbostat/turbostat.8 | 2 ++
 tools/power/x86/turbostat/turbostat.c | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.8 b/tools/power/x86/turbostat/turbostat.8
index 9b17097bc3d7b..b3d4bf08e70b1 100644
--- a/tools/power/x86/turbostat/turbostat.8
+++ b/tools/power/x86/turbostat/turbostat.8
@@ -296,6 +296,8 @@ Alternatively, non-root users can be enabled to run turbostat this way:
 
 # chmod +r /dev/cpu/*/msr
 
+# chmod +r /dev/cpu_dma_latency
+
 .B "turbostat "
 reads hardware counters, but doesn't write them.
 So it will not interfere with the OS or other programs, including
diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 4f176bbf29f42..84b8a35c91972 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -5237,7 +5237,7 @@ void print_dev_latency(void)
 
 	retval = read(fd, (void *)&value, sizeof(int));
 	if (retval != sizeof(int)) {
-		warn("read %s\n", path);
+		warn("read failed %s\n", path);
 		close(fd);
 		return;
 	}
-- 
2.39.2


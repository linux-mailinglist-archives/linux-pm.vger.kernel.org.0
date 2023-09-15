Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37D5A7A20A8
	for <lists+linux-pm@lfdr.de>; Fri, 15 Sep 2023 16:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235554AbjIOOR3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Sep 2023 10:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235619AbjIOOR2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Sep 2023 10:17:28 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6FC42737
        for <linux-pm@vger.kernel.org>; Fri, 15 Sep 2023 07:17:05 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-403012f27e3so25217525e9.3
        for <linux-pm@vger.kernel.org>; Fri, 15 Sep 2023 07:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694787424; x=1695392224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QemNO+c45J3TSx6FcSHQfwkZOTsDS0K4Gg9M0rrbiy8=;
        b=XPCWL4ZOINzEDGzwkxAd+4pp4o23wSRqDe9Bpdm1tPc3ae6fh8SgGIHQKZXkyzZ++y
         kCxzgIpjNoQ9PAH9i8T1nbW3CeRPPzOURCUmP1SpkZHmStJwjDwXLvISreOQxpNwrI0F
         u3L55A6eUZ909+UDlyereh1eX3Qw2sHB1A6ESDy3BTbts+l5cxlrVRiFOmLsjHyHrd33
         QoKhSkc2VwvTqY+yGMmd0GWoeaF96Spa89WoYGUACxTV6MHC12kks8NWwr1NnDFtVCWY
         Ccl4+K/WlTg9GFL7XN+hhvZfgDN3NE0kVn8CLPcPDJN1lvT0Ne64/k5mNhA6/3buYrqx
         o2sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694787424; x=1695392224;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QemNO+c45J3TSx6FcSHQfwkZOTsDS0K4Gg9M0rrbiy8=;
        b=lJeuETCcupllOLL0XLS55RvAOUEMDu0KQrTFcCo8A+FxatdRIjieX1BAbbFvApgSdX
         /IYieal1m5mLTkhwhC3itfojiKlEURHsOedbH2riVNXBL+NrbkhMwInqbISbEslN6BuT
         zAEv0EkmB4mdoOGFrvsIlpXbNR2RxWHFURlOakKMghxiOaHijo17vt6GJyPLmEX9iZuD
         nUu9aXwRijN7uaKrnAX8mVNZY3pxQ1vMUAh7VvukkzXnEVObUY4ODI+vTg8cDV6PPZ2A
         NUoeRcPFnhK74QqH3QBkIJ/hsQu5Wuo0VzhRHBC1L8V+gArzUlZC2OWJOrMX2PB95QEG
         DVLg==
X-Gm-Message-State: AOJu0YzuwofTt0u4FglPGboUh6zG5ZExCsIhbYtiMzuXTxoIr8mZOHoz
        UHF+v3nFncXT+MeETBpHicVc42p0hAd2eEFGIICyhQ==
X-Google-Smtp-Source: AGHT+IENFtSziBTAc8FDsdeoYRi10JRVxnI3GMM5OV0MPrV4NqfqiRPmMmFNJRmFokFuRiONdNlPQQ==
X-Received: by 2002:a5d:4e4e:0:b0:31f:ecb2:1bf6 with SMTP id r14-20020a5d4e4e000000b0031fecb21bf6mr1562489wrt.8.1694787424007;
        Fri, 15 Sep 2023 07:17:04 -0700 (PDT)
Received: from loic-ThinkPad-T470p.. ([2a01:e0a:82c:5f0:92b0:d1e8:d03e:ab51])
        by smtp.gmail.com with ESMTPSA id z11-20020a5d440b000000b0031423a8f4f7sm4519852wrq.56.2023.09.15.07.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 07:17:02 -0700 (PDT)
From:   Loic Poulain <loic.poulain@linaro.org>
To:     rafael@kernel.org, pavel@ucw.cz
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Loic Poulain <loic.poulain@linaro.org>
Subject: [PATCH] PM: hibernate: Request 0 CPU latency during image decompression
Date:   Fri, 15 Sep 2023 16:17:00 +0200
Message-Id: <20230915141700.91540-1-loic.poulain@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The (SMP) load_image_lzo procedure relies on multiple threads and
their synchronization for decompressing the hibernate image. for
performance reasons, it is important to keep the CPUs responsive
so that the synchronization overhead stays minimal. This overhead
roughly corresponds to thread wakeup latency, which is linked to
the CPU idle exit time.

By requesting 0 CPU latency, we prevent CPUs to enter their deepest
idle states, ensuring that they will be as responsive as possible
during the whole decompression procedure, and by extension improve
the hibernate resume time (CPU dependent).

On iMX8M mini SoC, that gives a ~40% boost for the decompression time:
PM: hibernation: Read 365640 kbytes in 1.88 seconds (194.48 MB/s)
vs
PM: hibernation: Read 363476 kbytes in 1.26 seconds (288.47 MB/s)

Note: 40% diff sounds huge, and may point to iMX specific cpuidle
issue. Anyhow, we know that during this bottleneck procedure, the CPUs
will be fully dedicated to the decompress task, and must be kept ready
for it.

Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
---
 kernel/power/swap.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index f6ebcd00c410..d2cd53497c4e 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -22,6 +22,7 @@
 #include <linux/swap.h>
 #include <linux/swapops.h>
 #include <linux/pm.h>
+#include <linux/pm_qos.h>
 #include <linux/slab.h>
 #include <linux/lzo.h>
 #include <linux/vmalloc.h>
@@ -1180,6 +1181,7 @@ static int load_image_lzo(struct swap_map_handle *handle,
 	unsigned char **page = NULL;
 	struct dec_data *data = NULL;
 	struct crc_data *crc = NULL;
+	struct pm_qos_request qos;
 
 	hib_init_batch(&hb);
 
@@ -1190,6 +1192,8 @@ static int load_image_lzo(struct swap_map_handle *handle,
 	nr_threads = num_online_cpus() - 1;
 	nr_threads = clamp_val(nr_threads, 1, LZO_THREADS);
 
+	cpu_latency_qos_add_request(&qos, 0);
+
 	page = vmalloc(array_size(LZO_MAX_RD_PAGES, sizeof(*page)));
 	if (!page) {
 		pr_err("Failed to allocate LZO page\n");
@@ -1470,6 +1474,8 @@ static int load_image_lzo(struct swap_map_handle *handle,
 	}
 	vfree(page);
 
+	cpu_latency_qos_remove_request(&qos);
+
 	return ret;
 }
 
-- 
2.34.1


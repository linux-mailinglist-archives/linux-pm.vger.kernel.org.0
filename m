Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB2E551E714
	for <lists+linux-pm@lfdr.de>; Sat,  7 May 2022 14:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385012AbiEGM7G (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 7 May 2022 08:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384961AbiEGM64 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 7 May 2022 08:58:56 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E663EBAD
        for <linux-pm@vger.kernel.org>; Sat,  7 May 2022 05:55:09 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id d5so13434020wrb.6
        for <linux-pm@vger.kernel.org>; Sat, 07 May 2022 05:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i7ClBWhU0BsFP+r9fOAi97/XZv2iZQBCPscZpo8wov8=;
        b=ZMaeL/azudnELzx4AN94lhWK+xBt5yOgl9UURvYUas9fkJpxaMKIm5kXMh75EnxCm0
         1IV8O5VsfIxyujffYTJW8dDRBF7b31NizsV34O2gtZk+tT2hl3fm0Ih/yXM3yyWGR4/7
         lwQuU1J0aCbSBUCT27nQWWZg26Xd9jTRgi3jiC2vrGgAdLlrCQ6oRoRVlfTOCuLy7I+G
         P0uFZ2OSwXULOw5pkMLlxyBKrYX+5OEyHnaWAGOiyZ36swtl9M9wbzT/edJP7Tqg8Apk
         pq/viGRHwVf9MoL7lC8/nQEgzi7vdijTze6qCe6dEU0GQqtJOjPnGYidFxjOU7RkrWqN
         dUQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i7ClBWhU0BsFP+r9fOAi97/XZv2iZQBCPscZpo8wov8=;
        b=VjdTkBhKstD8gzbby+4TameCbYUOjyopFj2HO2rHR6RAIcb2P2FKIGE/JaH3wBzW3p
         rujy5ABZhURPAJXK/cflO7IkPJDozzkxNoJY7nQ2f8NJY+YskhtOyXOvOsrSXqBqIA39
         jMox98vlD9jxILDV2dmPoLvZpjqAFgt3XzmKszVmWDEfJsM0OntLzcWsTTsN7/khPIe0
         OOLHQI0kxNY/HcERAAO5M9090J7Td+eLOMHSNkWCGX1g0Bv6vBYLB40RD5OQcBUJFgP2
         I/xzxpQy1MIrh+T7Av/f1BIGwjlB2OcJqk79vtZn/JqjjNqnH1HgXG044MfsTFnVXbyj
         q4vg==
X-Gm-Message-State: AOAM531zKqk8V+ex1AYzhKLC7QLkjKHxRZbSdgKdsEC2pL/PsKOGnAFB
        QjIow6rk75lS4tYO7XKZk5N8dA==
X-Google-Smtp-Source: ABdhPJyQBnAgMemg9n9uktVI9bwElN474gBrco3BobKJ/odxA/zwYUvCC+X7LwC6anuyYnY3z480Qw==
X-Received: by 2002:a5d:6b0d:0:b0:1f0:6497:b071 with SMTP id v13-20020a5d6b0d000000b001f06497b071mr6462214wrw.638.1651928109546;
        Sat, 07 May 2022 05:55:09 -0700 (PDT)
Received: from localhost.localdomain (static-176-182-171-101.ncc.abo.bbox.fr. [176.182.171.101])
        by smtp.gmail.com with ESMTPSA id e9-20020a05600c218900b0039453fe55a7sm10470345wme.35.2022.05.07.05.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 May 2022 05:55:09 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     khilman@baylibre.com, abailon@baylibre.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v2 03/14] thermal/core: Remove duplicate information when an error occurs
Date:   Sat,  7 May 2022 14:54:31 +0200
Message-Id: <20220507125443.2766939-4-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220507125443.2766939-1-daniel.lezcano@linexp.org>
References: <20220507125443.2766939-1-daniel.lezcano@linexp.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pr_err already tells it is an error, it is pointless to add the
'Error:' string in the messages. Remove them.

Cc: Alexandre Bailon <abailon@baylibre.com>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc; Eduardo Valentin <eduval@amazon.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
---
 drivers/thermal/thermal_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 1a405854748a..dc5a03d51f5c 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1197,23 +1197,23 @@ thermal_zone_device_register(const char *type, int trips, int mask,
 	struct thermal_governor *governor;
 
 	if (!type || strlen(type) == 0) {
-		pr_err("Error: No thermal zone type defined\n");
+		pr_err("No thermal zone type defined\n");
 		return ERR_PTR(-EINVAL);
 	}
 
 	if (type && strlen(type) >= THERMAL_NAME_LENGTH) {
-		pr_err("Error: Thermal zone name (%s) too long, should be under %d chars\n",
+		pr_err("Thermal zone name (%s) too long, should be under %d chars\n",
 		       type, THERMAL_NAME_LENGTH);
 		return ERR_PTR(-EINVAL);
 	}
 
 	if (trips > THERMAL_MAX_TRIPS || trips < 0 || mask >> trips) {
-		pr_err("Error: Incorrect number of thermal trips\n");
+		pr_err("Incorrect number of thermal trips\n");
 		return ERR_PTR(-EINVAL);
 	}
 
 	if (!ops) {
-		pr_err("Error: Thermal zone device ops not defined\n");
+		pr_err("Thermal zone device ops not defined\n");
 		return ERR_PTR(-EINVAL);
 	}
 
-- 
2.25.1


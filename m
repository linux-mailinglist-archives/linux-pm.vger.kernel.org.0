Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FECA510BC1
	for <lists+linux-pm@lfdr.de>; Wed, 27 Apr 2022 00:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355687AbiDZWSu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Apr 2022 18:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355681AbiDZWSt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Apr 2022 18:18:49 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D923E3D48D
        for <linux-pm@vger.kernel.org>; Tue, 26 Apr 2022 15:15:39 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id n126-20020a1c2784000000b0038e8af3e788so132837wmn.1
        for <linux-pm@vger.kernel.org>; Tue, 26 Apr 2022 15:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZL8cQRMvYoW7iggfJuWncj/joC9twZND0+x25qwoH6c=;
        b=vIv/sfg28J4s9ZRXG8ce+pZ6/Gte/6OUlaDOmsENoRGWyIwaQyQhn82Yb0xfZGVQTT
         qVWf8++HOggrmlnZb8197yhP1no66n++QDTtV7t+gHxLHvYbSEdFpKea338AhWuPBS2v
         DY7OJHfMNAUi7hyRFf09+x86nbPZWRYx9zywnc/SLl8wZjsetqdXFjL5myT8CFdzbdFa
         ade5E93IqRNUeZbuVarNZqDml/I3nqSNgvuiGaKdKEykIoRSkLdL7qOBYbJEKEeW25NK
         MbM8Gvl2rSUCLi9OfWpaZd62v7DWLFbuJ6hxIJqAldbYRtPQSSH4OeodDXWa4L/xpWzX
         JgmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZL8cQRMvYoW7iggfJuWncj/joC9twZND0+x25qwoH6c=;
        b=gJXwoa+4UbzUL5RDcynduFRzeXH7bwi1cxoRORKSHdYLeW7ucCXcLYxAV00/SA9GRi
         XWFpZ2ITEa62E/TTWDOPjs9KxJUEXsRgbwCm0fioQ6RNIuo8pV/+2QzwH5CXFjIzZUR8
         Gqfl3SD4Jv7v2Ef4JE3AoWYTe3tbXiLGXVcan2EFCtZATHk1Yyit7HwxOc+Gvy+mXzSU
         C9SeWkXMa64woEzhMTwbKYlK+TbPZSMKJYwHObEJGVHY41dw/4ByEIhfgLqCJwTXe5Ei
         i6Hz8NtmG8v5zqA32kGN6kcc4XbCz5GpQU1lfTnQUkKpLyJaaFfXGnwZiju1+FNCDE8Q
         RnZw==
X-Gm-Message-State: AOAM532dwNko1BaZfsuNE1BvpzeZonO5VBeSxDs/rJoXhKPkLRHm+TLh
        VQL70EqIdgdLZuIUEeACblDciw==
X-Google-Smtp-Source: ABdhPJxAiwUaSF3XnKZJ/Xp3/zDR6siV6vR4q0ZAtoXBUcAkn9EGWOba4zAMVz9Y/r2PkzicWqU3hA==
X-Received: by 2002:a05:600c:4e8d:b0:393:ee69:ec42 with SMTP id f13-20020a05600c4e8d00b00393ee69ec42mr8859502wmq.21.1651011338432;
        Tue, 26 Apr 2022 15:15:38 -0700 (PDT)
Received: from localhost.localdomain (static-176-182-171-101.ncc.abo.bbox.fr. [176.182.171.101])
        by smtp.gmail.com with ESMTPSA id j19-20020adfb313000000b0020aed8ece65sm393314wrd.32.2022.04.26.15.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 15:15:38 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     rafael@kernel.org, daniel.lezcano@linaro.org
Cc:     khilman@baylibre.com, abailon@baylibre.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/15] thermal/core: Remove duplicate information when an error occurs
Date:   Wed, 27 Apr 2022 00:15:12 +0200
Message-Id: <20220426221523.3056696-5-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220426221523.3056696-1-daniel.lezcano@linexp.org>
References: <20220426221523.3056696-1-daniel.lezcano@linexp.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
index b1d20c8ba3d1..a34c8cb31e91 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1197,23 +1197,23 @@ thermal_zone_register(const char *type, int trips, int mask,
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


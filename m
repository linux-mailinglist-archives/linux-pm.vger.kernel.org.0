Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9645A58CD58
	for <lists+linux-pm@lfdr.de>; Mon,  8 Aug 2022 20:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243612AbiHHSJg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Aug 2022 14:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237965AbiHHSJf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Aug 2022 14:09:35 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFEFC62EA
        for <linux-pm@vger.kernel.org>; Mon,  8 Aug 2022 11:09:33 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id h13so11775069wrf.6
        for <linux-pm@vger.kernel.org>; Mon, 08 Aug 2022 11:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=E7W+A8RBq7Usp9JU9F1Ru53gxwOjNDrCjAkC1uG7hB8=;
        b=K1ljnjeze7jNd1Zry0QkH2fhPDlX4fViK9SEP0ye2TfZ0hIaFCk11ir0aKzI96yU6/
         kehdi1SBDLMrlVbw97VVun0eqb8sSxT4mErssG/JBp9XCPJ3I80VxDHazp3MP9AFUGSa
         eVUeMb9pY7FzZFyJFuZPtkQUH8Q7PzhSXyjqOOl6DKZxk7u8mtP+TcmxRMGYxWVJ0Zi3
         H4WWA1qwaDtUxeN/WpD6qWRREb+f7aYYio3NZ42avgXpkN2tDLujhbCNpLNsPxglScLf
         qoz5ntjRGBftLN+DUJr1Yw7bMl0gugyr4eydRAcRnTLU9PbiOUdePA1VwEOc0Kt5VWY3
         DjCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=E7W+A8RBq7Usp9JU9F1Ru53gxwOjNDrCjAkC1uG7hB8=;
        b=Obsi9bj/LWq+dAp5n8eBDDQZSV8/6g4puriJCc82ii6g7gHaq1vOo+Daw5+p2H25Sh
         0o8RhWORU4dWZeFN8Q0Mv5Zb15m0uNMY5+RRzfPsVEpOUWqcJAwAKSUckeH9+kbNqjlc
         UQTRhO/3E9TfecvEQqjofVvpzP+/wBQ7tGEyEm5lD34/2FCrtB1PnaJ/Kn2WeVX4E3uN
         PPegT3289FTfcQEhE/6cu1zw77eGllagm06pEe23Mhgr3QsjI1rgNlbSM2/P/PJhrbYr
         BwHXMvIp2wIWiGqjw78sZyHiZ2GKicQzFFMO/QiEbybOx9b6CTTrmCLgexJE+C3ttw8C
         UEyg==
X-Gm-Message-State: ACgBeo0DQw60RGobEbcNmnuQeoAYupomrHptjyFwzJuUnShVt71nWYzc
        2/bxyXfKXYo32D/EoWaJhHDh8w==
X-Google-Smtp-Source: AA6agR6j3bOlOUhmzuo2GiW8M3SkMk/yg8KqV2xEhqyOjkIwV0K6lDVjcG8CneciLlAnhVnX/RLjZw==
X-Received: by 2002:a05:6000:178a:b0:221:1b91:c8fa with SMTP id e10-20020a056000178a00b002211b91c8famr10941704wrg.245.1659982172473;
        Mon, 08 Aug 2022 11:09:32 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id c5-20020a5d4f05000000b002205a5de337sm11937309wru.102.2022.08.08.11.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 11:09:31 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     michael@walle.cc, dan.carpenter@oracle.com, linux@roeck-us.net,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 1/4] thermal/of: Fix error code in of_thermal_zone_find()
Date:   Mon,  8 Aug 2022 20:09:12 +0200
Message-Id: <20220808180915.446053-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

Currently, if we cannot find the correct thermal zone then this error
path returns NULL and it would lead to an Oops in the caller.  Return
ERR_PTR(-EINVAL) instead.

Fixes: 3bd52ac87347 ("thermal/of: Rework the thermal device tree initialization")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Link: https://lore.kernel.org/r/YvDzovkMCQecPDjz@kili
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_of.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index c2bb5954b21e..368eb58e97cf 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -368,6 +368,7 @@ static struct device_node *of_thermal_zone_find(struct device_node *sensor, int
 			}
 		}
 	}
+	tz = ERR_PTR(-EINVAL);
 out:
 	of_node_put(np);
 	return tz;
-- 
2.34.1


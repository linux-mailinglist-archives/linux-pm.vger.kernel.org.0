Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62C183799B8
	for <lists+linux-pm@lfdr.de>; Tue, 11 May 2021 00:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbhEJWKg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 May 2021 18:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbhEJWKf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 May 2021 18:10:35 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF73C061574;
        Mon, 10 May 2021 15:09:29 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id q186so3055641ljq.8;
        Mon, 10 May 2021 15:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zC2m9tdB05UvOitG8AiDnA/r8NvGC3XS+DBBN1eDOIk=;
        b=fo9EMGf98O5I0aDtdX1qLO7IPIXmdaemjo6kn2Jw2TG7ylAShVJfYtqNGknQgxGDy9
         kZaYRhiFnZdwDOO/SJe1Gupav/PDsjm0eNi6ZL2eNA1WnsbHPUp07p3Dw5452nGVBFdK
         lqJ1N97ULZac70/R3KyG+WUT+AiHwRKv8/Pfv8M25DbxSj24ZOLAOx2qp0VthfexiEIh
         m8l0HSbIeoOsxT55BNW0dmCFqo9b3FSO5D7W/a3ccu+WAAR3Fge7UTbnyGjcgUzORTbr
         G14E5KxzUGXy4iGzvlfrO7CgvCMyaMQEHmD1cB0Jp+Q6fQtQpDnbT+e00QBhFE1C+j6F
         L4Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zC2m9tdB05UvOitG8AiDnA/r8NvGC3XS+DBBN1eDOIk=;
        b=p7oIJZtFft6bSrKHvE5r/MxzkeXEnJZPoaX4QIYZUNaVNq1q1KSLy4EUzijo+BqtpC
         M/1xZMrfgH0zMJdCC9iJMew4efRQ9DvFJ4yoAa7mcfACyJxLC2W91UvsSe5QyUizDrJt
         S+yrbSekhlnegqEdtz3XZ7qzqjVsoT+B+6W5/WgK5USwEOau3grZagur568C0/j0v/Xe
         XwYZLMGJ3YQod6DfFO3p5lEx0rk7IMJt2R6mm1/Uvw5tG1+yChlSUMOZu9rB9bYguK0l
         Ic+5pFxqZfwIGwq1xade6soNObzw3jGEupPUIBYbSfccJBQiDRYSv9IzUgsqbQRrBPAA
         gWUw==
X-Gm-Message-State: AOAM531JxzhDFf8mNEgyvXu62B0cvUutXK7LWDr01h3xUEJTfvc9M6LI
        sAspKFedlsZTuPG5a+CaN4k=
X-Google-Smtp-Source: ABdhPJzZMsIyJG0LaMscJd6YlMClncgHaLKOf3CoSkAy6rGpxrqKzZXnAR4JP/hwGkoMBPtwA9o1MA==
X-Received: by 2002:a2e:b60d:: with SMTP id r13mr21171573ljn.503.1620684568026;
        Mon, 10 May 2021 15:09:28 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-91.dynamic.spd-mgts.ru. [109.252.193.91])
        by smtp.gmail.com with ESMTPSA id y5sm2381479lfa.148.2021.05.10.15.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 15:09:27 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Antoni Aloy Torrens <aaloytorrens@gmail.com>,
        =?UTF-8?q?Nikola=20Milosavljevi=C4=87?= <mnidza@outlook.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] power: supply: sbs-battery: Silence warning about unknown chemistry
Date:   Tue, 11 May 2021 01:08:26 +0300
Message-Id: <20210510220827.11595-1-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Older variants of controller don't support reporting type of the battery.
Make warning message about unknown chemistry to be printed only once in
order to stop flooding kernel log with the message on each request of the
property. This patch fixes the noisy messages on Asus Transformer TF101.

Tested-by: Antoni Aloy Torrens <aaloytorrens@gmail.com> # TF101
Tested-by: Nikola Milosavljević <mnidza@outlook.com> # TF101
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/power/supply/sbs-battery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
index 8d7a10730e43..b71fbf543428 100644
--- a/drivers/power/supply/sbs-battery.c
+++ b/drivers/power/supply/sbs-battery.c
@@ -814,7 +814,7 @@ static int sbs_get_chemistry(struct i2c_client *client,
 		val->intval = POWER_SUPPLY_TECHNOLOGY_UNKNOWN;
 
 	if (val->intval == POWER_SUPPLY_TECHNOLOGY_UNKNOWN)
-		dev_warn(&client->dev, "Unknown chemistry: %s\n", chemistry);
+		dev_warn_once(&client->dev, "Unknown chemistry: %s\n", chemistry);
 
 	return 0;
 }
-- 
2.30.2


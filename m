Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD2E4107F17
	for <lists+linux-pm@lfdr.de>; Sat, 23 Nov 2019 16:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfKWPnO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 23 Nov 2019 10:43:14 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39618 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfKWPnO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 23 Nov 2019 10:43:14 -0500
Received: by mail-pl1-f194.google.com with SMTP id o9so4524127plk.6;
        Sat, 23 Nov 2019 07:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=nrUKykjn+gDcCBGken+j/LsXvodvX6rhHDMnwJDRHIQ=;
        b=ZETwb2QcVYN3CxePcfibr/5HrtdVN60tAxY0idHtOyzT9wVGejjUbNXw37SYsUTF8k
         qL+1kt5GesGI1kkp6FKAf1g87ViQqugXGG4BvTM3a/wlDR/N5MrmJP4yn8c1yHoNtRZ5
         sUv331rW1N3BwZR/1TZzFgVjziL0FoOwqRjrbUIxrCYhEsLUgjgXf5ntbRwMxvkW+iOU
         KSq811Um/Zoho88bUepewpA7lJxbhG9wD0YgARhbhrphOaHKhMJfwAx9WRuI+0fAd3MS
         /2OEMl99gQwBo4gGEzQjiDgYzDZusVQU9ui3e0Chqv2eYR63EXsx1bOLmWEB4MeTcAsI
         c38A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nrUKykjn+gDcCBGken+j/LsXvodvX6rhHDMnwJDRHIQ=;
        b=l1W1PmtML1TN+XXY7o0pc6uxm6cR//pSsOzWmLukIL/j6cY2a7yri9RiWSIc/J4FJs
         PSKg3O0giYsQ8bYatcYBmHUCN5vxoNg2RTcJZ1sPxqLAZK0Msw9e2i/u7++EvxsyvOiZ
         F4RJK+Hp4mmfSEEiV7+8BoWr9o8Gmclp1X1kNtfrJjWNvMCbzrDH+AWCa3bSo5SjRMZw
         +XsdKweZ5Bbnshl4Gft+bs4Xaa8L5DH7XrUVGWAYPQPdgTqaPUV80MEYcNecFHiGg6XI
         lmhZPuFGgFsHu7UPcnQ8g/ZC6OpNUc2uS5LsZMDhWpXh4wU/1/Cw7CwKH2Pot1Ev3tw7
         Xqfg==
X-Gm-Message-State: APjAAAUf6NrdcjL3NLzL0MdBFEOez9N1bx10HODze0DakTwpTfzuJyGo
        AOoHICCGz7Ox+lSlI880fibsWUB1
X-Google-Smtp-Source: APXvYqyU+S8/etugzXZM1cJK0t7Gy4YKk3XTFxB9dduV7udbbFgcDpZ3dgPLo/Wgpv3QZt/fyWM07A==
X-Received: by 2002:a17:90a:24ac:: with SMTP id i41mr27110016pje.11.1574523793698;
        Sat, 23 Nov 2019 07:43:13 -0800 (PST)
Received: from localhost.localdomain (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id u24sm2146462pfh.48.2019.11.23.07.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2019 07:43:13 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org, eduval@amazon.com
Cc:     linux-pm@vger.kernel.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, amit.kucheria@verdurent.com,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH] MAINTAINERS: thermal: Eduardo's email is bouncing
Date:   Sat, 23 Nov 2019 07:43:03 -0800
Message-Id: <20191123154303.2202-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The last two emails to Eduardo were returned with:

452 4.2.2 The email account that you tried to reach is over quota.
Please direct the recipient to
https://support.google.com/mail/?p=OverQuotaTemp j17sor626162wrq.49 -
gsmtp

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e4f170d8bc29..84e8bdae4beb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16085,7 +16085,6 @@ F:	drivers/media/radio/radio-raremono.c
 
 THERMAL
 M:	Zhang Rui <rui.zhang@intel.com>
-M:	Eduardo Valentin <edubezval@gmail.com>
 R:	Daniel Lezcano <daniel.lezcano@linaro.org>
 R:	Amit Kucheria <amit.kucheria@verdurent.com>
 L:	linux-pm@vger.kernel.org
-- 
2.17.1


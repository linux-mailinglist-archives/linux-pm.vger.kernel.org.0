Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3143B5096
	for <lists+linux-pm@lfdr.de>; Sun, 27 Jun 2021 01:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbhFZXwS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 26 Jun 2021 19:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbhFZXwS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 26 Jun 2021 19:52:18 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD74C061574
        for <linux-pm@vger.kernel.org>; Sat, 26 Jun 2021 16:49:54 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id a15so15984167lfr.6
        for <linux-pm@vger.kernel.org>; Sat, 26 Jun 2021 16:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eISukSxr9S6lVbjbCM2Ot77tr1WgILTAvVDWCUeQenA=;
        b=MYRxi85STBrA6ytlEgiBAF1tE55JOmd5vSToUuFjM1ecNxnCG1UeYEMOrCQTkq3P9X
         OyesvsV1iezO8e/R1kK3dWuPHNwpgUb5ozCEm7WeNKN+sU4QAE8Zc2gS8OTGn87JNOEv
         1IXZ60oXBsTZo03SRlWIU4LQlqeY8bwkF5QYkA2QKQ/VRVhfekQzQ9nhg2fdm4E6mOog
         O4BNIgp9Tdjg9lF03NjUsW0NvnXYveR4cre3PMGibplazkrOI2nePRsisS1rwhjBLDpk
         cm1lQopOxUvlIMkUK18EcgjYnLi21hgNNmFy2d6V/hG89cZTbe2iERrSysO7GnCvFwFV
         TSEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eISukSxr9S6lVbjbCM2Ot77tr1WgILTAvVDWCUeQenA=;
        b=Xzxqe7ZEfdDnLn8YIxa9H8WDPzJnWbXrkfLywAEMKm/ds/Z8vdBNXsz6gpnq+ThzDo
         rwJtT4OuiLKRfSwJpgVFSFSAvBdzu7TaOD0UPCOByWwwHjNLbgSxDCpU7bnNmSkwcMAi
         e8b//gb4DGofyyAAFMfnbahcyxuJYArUrUpqtNWo5IAp182clAZZrjK3/E1GDXi2gJce
         MacroBkAiIHlvDa85oWH07bqutYrNxkEcexFXlymCDTM9ZWKmGvJpXXQvh16cImoyoO0
         TiXGsPbW4a9MIcFSEEIARY+9NGHjLspyq9wPn+2AGWB85BXIGWEVhkDKbw5cqe2fi7vR
         Dyqg==
X-Gm-Message-State: AOAM533i6rp2YAe6LfytpclZMU/+0z22YiiovzgBBaQCw53Ygkd8a6WV
        uJg4p6SSEJR5rp1Fh4y8K7ReoQ==
X-Google-Smtp-Source: ABdhPJwUB44QORbuNBQmNN9Dx4OyT7aCxGiEZFMKFOvUwObcavzCQU8kG1H8revzLTi6Lcqx+RAclQ==
X-Received: by 2002:a05:6512:610:: with SMTP id b16mr13612599lfe.631.1624751392746;
        Sat, 26 Jun 2021 16:49:52 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id w17sm893700lft.285.2021.06.26.16.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jun 2021 16:49:52 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        stable@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] power: supply: ab8500: Fix an old bug
Date:   Sun, 27 Jun 2021 01:47:49 +0200
Message-Id: <20210626234749.2958991-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Trying to get the AB8500 charging driver working I ran into a bit
of bitrot: we haven't used the driver for a while so errors in
refactorings won't be noticed.

This one is pretty self evident: use argument to the macro or we
end up with a random pointer to something else.

Cc: stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Marcus Cooper <codekipper@gmail.com>
Fixes: 297d716f6260 ("power_supply: Change ownership from driver to core")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/power/supply/ab8500-chargalg.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/ab8500-chargalg.h b/drivers/power/supply/ab8500-chargalg.h
index 94a6f9068bc5..07e6ff50084f 100644
--- a/drivers/power/supply/ab8500-chargalg.h
+++ b/drivers/power/supply/ab8500-chargalg.h
@@ -15,7 +15,7 @@
  * - POWER_SUPPLY_TYPE_USB,
  * because only them store as drv_data pointer to struct ux500_charger.
  */
-#define psy_to_ux500_charger(x) power_supply_get_drvdata(psy)
+#define psy_to_ux500_charger(x) power_supply_get_drvdata(x)
 
 /* Forward declaration */
 struct ux500_charger;
-- 
2.31.1


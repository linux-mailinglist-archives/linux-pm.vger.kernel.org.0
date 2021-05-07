Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD83C37656F
	for <lists+linux-pm@lfdr.de>; Fri,  7 May 2021 14:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234610AbhEGMse (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 May 2021 08:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236659AbhEGMse (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 May 2021 08:48:34 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2822C061761;
        Fri,  7 May 2021 05:47:34 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id t4so5078332plc.6;
        Fri, 07 May 2021 05:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+caYlZt6JBO2713Zp0OiFB6j6uYzzD9T0bDTiOyqv2s=;
        b=TgYaFanx2GcUu/76MpP2Dc1JYQDATXntvUlkN9K9ISAVoYImZGhMJgLnzBuJ0MpW0V
         W+e3Oj0FTcsn+lFUz/NHIZJa7bKdMjOfWeRkOeM1iMJzi1Wn7h9pvd+spNK7ZRTUPaLj
         I5E7RtPG9sA7zv3liyYewiGSusLFHdJiJM2g+bsKwX6Ie2vwEWiOLLSX1oDox9j/iAj5
         dImPdbjTKxGRroYnvq/Hkis1ukvd7jbZF13p0CdbUlN0UIu9MDPMsMjAdqMxtXG8ymTW
         vdnuc6iaLw0MGdIPhsL9VU/+rvtxZV26YyVHsT/pKUcEDmOF/dM99ev1ihSPbdNosnTN
         sTDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+caYlZt6JBO2713Zp0OiFB6j6uYzzD9T0bDTiOyqv2s=;
        b=OtCoUp7GtaWhmyYScbH4Z51dXtijVJP9utO33dcAT3ddeGkoUsyCr8hKp1DI7954jE
         xMJW3k/XUwe6r5Ewzp7GD9qpwS2nkS3QjV5NBUMAoCxCSNSMevuyZgWbuLynJ7DKfvie
         NuDSw6S6ShPi3yxDYGNSt+y3ZSI/re1XE4zScrvG9crcFcfNa5ItTafGaa/mlhAa1EwG
         ph1kbZOvvezauxMyP+pjNowkkq1IaMcLES74jnFjgjcHYi+oALz9J4b/p6LhpnPZ/w+i
         LBVZDxSBHMZicNksYXZxmrncdDuubDEXFXHLvekWBImEfhgRBUt7jSgVjiLTvgZkxXib
         3wAQ==
X-Gm-Message-State: AOAM5303z7Gap4RIShelDi9xb+tW2ZoDN43p14WvViuXwToqakblBUwa
        ufmw1a5iXnV/VAxMeHJsksSum8As/f2LpD19RXs=
X-Google-Smtp-Source: ABdhPJxGBSHMJsHOioVsl4rJbKXzJRWEYt5zQGcWtIJyS2T+Nd5qJoUyuM++14MC1vXw0TEghRlQ6g==
X-Received: by 2002:a17:90a:d493:: with SMTP id s19mr23532188pju.200.1620391654308;
        Fri, 07 May 2021 05:47:34 -0700 (PDT)
Received: from localhost.localdomain (host-219-71-67-82.dynamic.kbtelecom.net. [219.71.67.82])
        by smtp.gmail.com with ESMTPSA id j10sm4964859pff.69.2021.05.07.05.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 05:47:33 -0700 (PDT)
From:   Wei Ming Chen <jj251510319013@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     sre@kernel.org, linux-pm@vger.kernel.org,
        Wei Ming Chen <jj251510319013@gmail.com>
Subject: [PATCH] power: supply: oplc_battery: Use fallthrough pseudo-keyword
Date:   Fri,  7 May 2021 20:47:24 +0800
Message-Id: <20210507124724.10825-1-jj251510319013@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add pseudo-keyword macro fallthrough[1]

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through

Signed-off-by: Wei Ming Chen <jj251510319013@gmail.com>
---
 drivers/power/supply/olpc_battery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/supply/olpc_battery.c b/drivers/power/supply/olpc_battery.c
index e0476ec06601..743b7f1cf9ea 100644
--- a/drivers/power/supply/olpc_battery.c
+++ b/drivers/power/supply/olpc_battery.c
@@ -238,6 +238,7 @@ static int olpc_bat_get_charge_full_design(union power_supply_propval *val)
 	case POWER_SUPPLY_TECHNOLOGY_LiFe:
 		switch (mfr) {
 		case 1: /* Gold Peak, fall through */
+			fallthrough;
 		case 2: /* BYD */
 			val->intval = 2800000;
 			break;
-- 
2.25.1


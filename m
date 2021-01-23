Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60B203018AF
	for <lists+linux-pm@lfdr.de>; Sat, 23 Jan 2021 23:20:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbhAWWUo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 23 Jan 2021 17:20:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbhAWWUm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 23 Jan 2021 17:20:42 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D82BDC0617AB
        for <linux-pm@vger.kernel.org>; Sat, 23 Jan 2021 14:19:32 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id f11so10747415ljm.8
        for <linux-pm@vger.kernel.org>; Sat, 23 Jan 2021 14:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8/JkWsoo9Q6Dhvm5nfPdfL/Tx4n2636EiCOBIgxbDkI=;
        b=evDEXxX6//vF92EbY5WWm94jmJ6T7AUu8NaeU5AgS9cVA7aLjSs9L/zxTY207Wmiub
         s0Uvk1t6pzdtDqKIEqAFSraon8/cCRwtsOZ8hZ3YHFXyUv+Z+TWVirN0Nu8OZiF/EfBp
         c1/Of9QnOcPh17TyEmOoM7AWMx9GzcavOYDa+JS0LxHxuHzngZgINKxJZSorzhKXRk6j
         jy2rYl+pgO6AjBGbufpTyDuA5ZoC/tb3INLg1KRQRHHBE8DWJgqv4o3Yw5neRpSDs9R1
         YKlsGK+mEfxZ2OccmgZyOgyIo67NpgvR74OzmTaJ8Blo7qV7znxv2WSPyga6dT3meWyi
         FfjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8/JkWsoo9Q6Dhvm5nfPdfL/Tx4n2636EiCOBIgxbDkI=;
        b=Z8LHDqfuDEkF0+x78raJJPC+v8tsTrCgfniaRLP4kyCFnJwIPz59Srq4P0hnQx6UNg
         TtmYlDrWYlI6v0Btj/xzVNJvIp6vHKqC71rVxlum9lcWm/Xu9C41XG5lEutzYZbXd2/B
         WLrphA2c1HRtfBIyDLWbL2PzHwIPRDo2CmZJBrTsBXpjjoh5upG2Dbnj6fNgv+bfdolo
         IE2nxlqfbmFT3dWmwl97BEEXYXhQp6Uo2XjGL11BKHyy5gHCoU1PJEygNfU6KsCUQdgg
         Ia8EBpGR8byRBCgsYeLlaB9EjoPz1drNbSGyAF4CNvrQOWLDUEPid1OYqsCdyuX+0X3Q
         sXXw==
X-Gm-Message-State: AOAM530gFW7BYy6rDfVliwjICRJWHB0w9GlXSKi9BbMcaf8ssmBcTXD+
        xDnbeE3EO6p3BFV1bJgSW91Y1g==
X-Google-Smtp-Source: ABdhPJzE3v28O5p9Nb2PrRAI/3XE/f45VU8J2q1yOkcUbiCaVxvxp3W8YEbfvOh3oF1m01mzGPtr+Q==
X-Received: by 2002:a2e:6c0a:: with SMTP id h10mr65100ljc.149.1611440371374;
        Sat, 23 Jan 2021 14:19:31 -0800 (PST)
Received: from localhost.localdomain (c-92d7225c.014-348-6c756e10.bbcust.telenor.se. [92.34.215.146])
        by smtp.gmail.com with ESMTPSA id x17sm1313956lfg.0.2021.01.23.14.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jan 2021 14:19:30 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Marcus Cooper <codekipper@gmail.com>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 09/10] power: supply: ab8500: Drop unused member
Date:   Sat, 23 Jan 2021 23:19:07 +0100
Message-Id: <20210123221908.2993388-10-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210123221908.2993388-1-linus.walleij@linaro.org>
References: <20210123221908.2993388-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This setting is read directly from the device tree in
the ab8500_charger.c code.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/power/supply/ab8500-bm.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/power/supply/ab8500-bm.h b/drivers/power/supply/ab8500-bm.h
index 871bdc1f5cbd..0c940571e5b0 100644
--- a/drivers/power/supply/ab8500-bm.h
+++ b/drivers/power/supply/ab8500-bm.h
@@ -506,7 +506,6 @@ struct abx500_bm_data {
 	int usb_safety_tmr_h;
 	int bkup_bat_v;
 	int bkup_bat_i;
-	bool autopower_cfg;
 	bool no_maintenance;
 	bool capacity_scaling;
 	bool chg_unknown_bat;
-- 
2.29.2


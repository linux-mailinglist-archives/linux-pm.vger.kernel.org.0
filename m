Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92E6A3C733C
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jul 2021 17:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237098AbhGMPcP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Jul 2021 11:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236932AbhGMPcO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Jul 2021 11:32:14 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49DE5C0613E9
        for <linux-pm@vger.kernel.org>; Tue, 13 Jul 2021 08:29:24 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id a6so30596281ljq.3
        for <linux-pm@vger.kernel.org>; Tue, 13 Jul 2021 08:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BH1R2YDByvxjcRj7+sjhYJFEOJey1VxQapoVe6e4nvk=;
        b=Fk8Ubdjr48N+SiJ92d5G02R+GXD5TIvyBPz5yH7VNVUGrBdAsTjgR8hPWqUmhvSaDr
         pHE8wKmnn9lFFukjPeZwrkdzNBoirsYK1Le4zm4ykuqmXDoyMzIld2ymdExx0zs3Lv6f
         GocJbqueVB0qRmaYamMRJfNscPc11wJlQ3uMM9aX8ofSo0seiSZqo9+cmSWAY4MRbq8/
         4m8Bl9rYKcFMKXLSlMRTY/2Ht0dJO8h/jG/4poBFYT2lPaFDeMivs0O10NfVW3IfHH9B
         Rn2ss0oqWl8GclRC23qS0Aqwe5Z5JKypJL7dcJyC2tMr1+7BPrAnW56WCxGqCB+DOMsk
         KfUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BH1R2YDByvxjcRj7+sjhYJFEOJey1VxQapoVe6e4nvk=;
        b=rTUFaEgdP6USVbYTWLpkvflaIpRQcieZZlXQFqJnsuvq3X7aQM94mg9NNFa51/49gE
         vzRv0nlrq4wzbqJC+oSzj8JFrSlLz2DqVqZ4sgIdqOnxdQYXgw62g+5kzOOr0cbE3YxA
         cbd7FpNucoDX08mxvXviIQ4v4KKr9I+hDlgJ3jSaULY1FgV5cfcUKjhZc+rzK1QUuy57
         00ZSH1O4wmltDsEtfsA3p06xhkGdr25pR5j61ytWpY6NF3hrnjIM+Yh0m6XXCbs7zVtj
         H8bXZkjFMw1niu87GFa0aADMnllm538Wp0WfcSC2NIWlWXBcet4GhwCDhoX96AVdz4Pc
         BBnA==
X-Gm-Message-State: AOAM531KrKHrG+84frQMuIuaSzk1ys7rG1HDIUDgtXLQRx2v+bLgP4CW
        Pi2GIy919v6n9KHIkFZWtpOKdw==
X-Google-Smtp-Source: ABdhPJyZGiKIAqLj4i2YdeNVuM2WFM/a1ud5+B5tHvEdgkjitRtfVYdwRZzqgpXkBq6Lqlci4epfmw==
X-Received: by 2002:a2e:b5b5:: with SMTP id f21mr4743065ljn.479.1626190162678;
        Tue, 13 Jul 2021 08:29:22 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id d8sm827395ljg.86.2021.07.13.08.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 08:29:22 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 5/5] power: supply: ab8500: Drop some includes from bmdata
Date:   Tue, 13 Jul 2021 17:27:09 +0200
Message-Id: <20210713152709.871833-5-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210713152709.871833-1-linus.walleij@linaro.org>
References: <20210713152709.871833-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This file isn't using any AB8500 symbols so drop these includes.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/power/supply/ab8500_bmdata.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/power/supply/ab8500_bmdata.c b/drivers/power/supply/ab8500_bmdata.c
index f705c19ef359..6f5fb794042c 100644
--- a/drivers/power/supply/ab8500_bmdata.c
+++ b/drivers/power/supply/ab8500_bmdata.c
@@ -2,8 +2,6 @@
 #include <linux/export.h>
 #include <linux/power_supply.h>
 #include <linux/of.h>
-#include <linux/mfd/abx500.h>
-#include <linux/mfd/abx500/ab8500.h>
 
 #include "ab8500-bm.h"
 
-- 
2.31.1


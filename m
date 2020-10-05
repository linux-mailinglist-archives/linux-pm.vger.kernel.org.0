Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2E4284007
	for <lists+linux-pm@lfdr.de>; Mon,  5 Oct 2020 22:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729489AbgJEUCD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Oct 2020 16:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729424AbgJEUCD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Oct 2020 16:02:03 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B23C0613CE;
        Mon,  5 Oct 2020 13:02:02 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id w5so10963811wrp.8;
        Mon, 05 Oct 2020 13:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kDG90piP9bjjZ54VM7VZ8xIJjJTXJAd5c7/jB4KZCuw=;
        b=U6Qb2I2EVdvXUonV7xvElgjAtpp5Q39Ju/U+JyYCWKusZ9PHt3ZW7VAe2oyxxPMAqC
         Gt0YhdLms9ASnHGet4kNAFfvxQ7uyIZhr2rVfjRFxZfkbGrUGJ8hXSWnuW6ZvWEP6FOp
         5bCGoAOZhUiA+uwkhJ+PTpW/WSLWAlgR6RTIFNcKra4FxY8PxQq7AchY32dmCdDkKe2/
         LQymcfir9y2x+3OSvq6AwxNSSjZ4LVAAePapsoPLdEx534RH+Kzp9/AL0vDeQ7QyTnjP
         9Nh4J3uDEXkphCLTh5irFrlrhVOoaIQegw1t7y+cSvsrUYENr+dG435WJUvfzDm8LpNR
         XG9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kDG90piP9bjjZ54VM7VZ8xIJjJTXJAd5c7/jB4KZCuw=;
        b=rcA4Yl6DkgNZpj1gdFUUaOGCstO5yHeTqfQkYS2qM/1n1FyA2WyMwLJpKyKTFBuAit
         2X+zhLE8imp4EYHPzzAsCdXJAfGg7+RS34MuV0LnS59ZGXEagvnVViSxgS782II9YEua
         SXxT/kVgOp3llr5SYRHKiBYFJfWqlVenKRN7qIyRdxjhAriB59Zy+BmwIUWHFG/bw8Gc
         LnTVEc+8bs6pFA5juVFpQ1G7C00VQrSGkE++hyE/iVUhdm8PfWD7D+LYDmMdLjxkDa29
         knJG560qoBcktLcgNiAyM91sbtA6QSTK8CvcS8n+cP9THce9huNGTb6eA78xF1WKWYpC
         K4zQ==
X-Gm-Message-State: AOAM530k+FxUoD5UGeCASVHgsI1GYbF+FcVGN/i7b/uvsOvLeqvv42y5
        Df2z5q6Fd0tbg8Gj96zwWYE=
X-Google-Smtp-Source: ABdhPJx7wfmIUYe3PgJvRZq15QibKic8hinUwE91butGT+DJ065259eG14cshO9OX8cQ3GLHSYvqUg==
X-Received: by 2002:adf:f903:: with SMTP id b3mr1108480wrr.142.1601928121488;
        Mon, 05 Oct 2020 13:02:01 -0700 (PDT)
Received: from localhost ([91.92.14.102])
        by smtp.gmail.com with ESMTPSA id s19sm736954wmc.41.2020.10.05.13.00.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2020 13:01:09 -0700 (PDT)
From:   Iskren Chernev <iskren.chernev@gmail.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Iskren Chernev <iskren.chernev@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] power: supply: max17040: Fix ptr to enum cast
Date:   Mon,  5 Oct 2020 23:00:38 +0300
Message-Id: <20201005200038.1032697-1-iskren.chernev@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

clang complains about casting pointers to smaller enum types.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
---

P.S. I fixed a similar issue in v5, but it was in another patch, and the
test robot only complains about the first issue, so I missed this one.

There is a similar warning in ltc2941-battery-gauge, let me know if I
should submit a fix for it as well.

 drivers/power/supply/max17040_battery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
index 1d7510a59295d..d956c67d51558 100644
--- a/drivers/power/supply/max17040_battery.c
+++ b/drivers/power/supply/max17040_battery.c
@@ -247,7 +247,7 @@ static int max17040_get_of_data(struct max17040_chip *chip)
 {
 	struct device *dev = &chip->client->dev;
 	struct chip_data *data = &max17040_family[
-		(enum chip_id) of_device_get_match_data(dev)];
+		(uintptr_t) of_device_get_match_data(dev)];
 	int rcomp_len;
 	u8 rcomp[2];


base-commit: f9d293364b452b651292ed3034dd06c57b1754d5
--
2.28.0


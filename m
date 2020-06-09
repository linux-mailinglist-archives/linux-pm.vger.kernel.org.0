Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 728A41F4994
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jun 2020 00:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728629AbgFIWuv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Jun 2020 18:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728108AbgFIWuu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Jun 2020 18:50:50 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B0DC05BD1E;
        Tue,  9 Jun 2020 15:50:49 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id u17so330070qtq.1;
        Tue, 09 Jun 2020 15:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oGAa4Mn6OsK1MTg/eaa33f/HGF3MMyA73RH3oZcHO8Q=;
        b=Wfhc0mYzeiHLe6+K0/T43lF6dtzPYAjscyG41VUhNGlUUU/qUHKCCpSW3o3ehezQB6
         glJWqCl6j0LwVh3n8K6rZk2w7btrZ9lwFG0TL+w3bS/NPXMOW1DxfR4a5ZMRQXWcf037
         8OciGTHxhZNWEkXLsXKDwbzFKw1Gr32TOLhr6t0NxHd4DwghKwfvegpamD969N9LEZrD
         ATZuAa9zPcIB8xmugNZspQyeKse3IiDU2TmH7h3PZSL0QSJLHMhaGB6Z5Do9OV5BBzfk
         OZp9FK7KsLTf4XXmbt+CzCvk9t5wg5IuEe+qyPNQjveCh6mo06sL2leVLnuohzB5dMtw
         sctA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oGAa4Mn6OsK1MTg/eaa33f/HGF3MMyA73RH3oZcHO8Q=;
        b=uS1188L9qzpFwyf5OXDVuAu+P4m6sTuEAiL3B79IEdImjdzdefJEsi6xtRV//LRJFb
         UllAfw3+FdosV9gfFaGi94nsjV6TsvtH3A+ikipIuQzgeCIqa/IuQQkGuLwuam3FgHxX
         a/Zr0FI5cfKMXwtjYr+IY3GwznjD45XVAPQWq+fp+KVonO2GXQ/XiqSnZ97C2QKfH4KY
         hIYYyBv/dA0C/zfm0TiQyXXtB2CBLPuDTln0E45B21taRUS0WXCmxyYxb/q4+Y3QYKSM
         7sFqkfOf/npA/Xy1oZgMfPnk6u29V3pVojk/pli45BUPaT6rrscg/E3YgtUnVQtOY0nz
         8Sbg==
X-Gm-Message-State: AOAM533I+GghGYi8nKDBhsT0/NKann1QW7aJ8eSfp2wpY9fZ6wfmDLD7
        BgIXxQ/lUnrd6u4TEVdDKAREzOHjFd+/
X-Google-Smtp-Source: ABdhPJys9woneWLnvJxMrdXdSf7xqgSI17WLZRCKPMv1V7/gyIV/jiHrBwLMFoBewqKnx4ny6CHiaQ==
X-Received: by 2002:ac8:6947:: with SMTP id n7mr242325qtr.178.1591743048686;
        Tue, 09 Jun 2020 15:50:48 -0700 (PDT)
Received: from localhost.localdomain ([142.119.96.191])
        by smtp.googlemail.com with ESMTPSA id v189sm10726314qkb.64.2020.06.09.15.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 15:50:48 -0700 (PDT)
From:   Keyur Patel <iamkeyur96@gmail.com>
Cc:     Keyur Patel <iamkeyur96@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] power: supply: axp20x_usb_power: fix spelling mistake
Date:   Tue,  9 Jun 2020 18:50:35 -0400
Message-Id: <20200609225035.108435-1-iamkeyur96@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200609224524.108092-1-iamkeyur96@gmail.com>
References: <20200609224524.108092-1-iamkeyur96@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fix typo: "triger" --> "trigger"

Signed-off-by: Keyur Patel <iamkeyur96@gmail.com>
---
 drivers/power/supply/axp20x_usb_power.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
index 4fde24b5f35a..d01dc0332edc 100644
--- a/drivers/power/supply/axp20x_usb_power.c
+++ b/drivers/power/supply/axp20x_usb_power.c
@@ -78,7 +78,7 @@ static bool axp20x_usb_vbus_needs_polling(struct axp20x_usb_power *power)
 	/*
 	 * Polling is only necessary while VBUS is offline. While online, a
 	 * present->absent transition implies an online->offline transition
-	 * and will triger the VBUS_REMOVAL IRQ.
+	 * and will trigger the VBUS_REMOVAL IRQ.
 	 */
 	if (power->axp20x_id >= AXP221_ID && !power->online)
 		return true;
-- 
2.26.2


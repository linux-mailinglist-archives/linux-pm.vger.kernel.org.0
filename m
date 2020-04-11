Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47B591A4CDA
	for <lists+linux-pm@lfdr.de>; Sat, 11 Apr 2020 02:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgDKAUg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Apr 2020 20:20:36 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53893 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbgDKAUZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Apr 2020 20:20:25 -0400
Received: by mail-wm1-f68.google.com with SMTP id d77so4066711wmd.3;
        Fri, 10 Apr 2020 17:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TE3sMAOxYDEKsrqGbaQEWcZdkId7UvPKpC1cYAS9Bb4=;
        b=GUZ+gowPiKiUow4O9M2HabHPSHLL480L/OTu8zEtqyHcAhIJ5hl5HaWjK+P1z0MW/y
         kNhTwww5jaisDQoxtRveKw1lsq/8NmPm4aPVc7vCdQdQo8YaYvG1V7cT6RoeGQu4unKy
         gOoayXt3b1qctBo110K+40gtZzVE9ZHprMSHbm9+HnywZvpsDK/vy1cWVccGxMP7r6oO
         FzjyTol44+KxQGYv2cIMxl3BlfugfRF6ydXlSQLfmWfVgBhTU2wHiDic1+1Ly91BgonE
         KPK6WcY5wiMuPYnXWsyJ6CtSG0UjB8WXGIZsjs/V/73bN+lbsvmGJ477sN/619XPWLXN
         2s8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TE3sMAOxYDEKsrqGbaQEWcZdkId7UvPKpC1cYAS9Bb4=;
        b=F9Ctm4YxOMjMlsGmu3/E0qviiuIbDHXCSCZTcXbLSXqJM2MO8o2MIMv3Jw2Y9llDqN
         dg8KtRDRUBCjCIWLKIDSSyzHz79VigvS0Jqr5onAyHeeh+CdneQV8GaX2xoqXpKvmc+W
         z7w/fa8kWvZRvWM2DW56nTnweBoliO0x4aB8WNMtNGQi4dMZQu5ti06M+PxxebX3YP2t
         mJEwcB7aGirzUEcybsS0UwPbzX6K07tgAwbATmuuIImuVuCFmO0W/I6lsuBRiawl7q91
         2hI84/aN0mD0BLwfBVk5PiNo92UNtYgwCxld9SOljdAUNz5ugSr538qDbTq5jXMALNWa
         8fvw==
X-Gm-Message-State: AGi0PuYg/E+IZkrj4Fcx8YsgSHd4BNNUXtaBrER3Vs2i6u4OQWlU97EL
        DjOAbhpNLpwctxq3Ov7+SQ/mw0X+xkjA
X-Google-Smtp-Source: APiQypLmI3kOoMegOugkPKgJfR0jWXdEoWwlIgoTtC1TiO5weHkh3/vOlXbmIHhWPaov2aHfK1w5Jw==
X-Received: by 2002:a7b:cd8c:: with SMTP id y12mr7877443wmj.106.1586564423558;
        Fri, 10 Apr 2020 17:20:23 -0700 (PDT)
Received: from ninjahost.lan (host-2-102-14-153.as13285.net. [2.102.14.153])
        by smtp.gmail.com with ESMTPSA id b191sm5091594wmd.39.2020.04.10.17.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 17:20:23 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     boqun.feng@gmail.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org (open list:POWER MANAGEMENT CORE)
Subject: [PATCH 9/9] power: wakeup: Add missing annotation for wakeup_sources_read_lock() and wakeup_sources_read_unlock()
Date:   Sat, 11 Apr 2020 01:19:33 +0100
Message-Id: <20200411001933.10072-10-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200411001933.10072-1-jbi.octave@gmail.com>
References: <0/9>
 <20200411001933.10072-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Sparse reports warnings at wakeup_sources_read_lock()
	and wakeup_sources_read_unlock()

warning: context imbalance in wakeup_sources_read_lock()
	- wrong count at exit
context imbalance in wakeup_sources_read_unlock()
	- unexpected unlock

The root cause is the missing annotation at
wakeup_sources_read_lock() and wakeup_sources_read_unlock()

Add the missing  __acquires(&wakeup_srcu) annotation
Add the missing __releases(&wakeup_srcu) annotation

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 drivers/base/power/wakeup.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index 41ce086d8f57..753e9a46e04e 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -254,6 +254,7 @@ EXPORT_SYMBOL_GPL(wakeup_source_unregister);
  * This index must be passed to the matching wakeup_sources_read_unlock().
  */
 int wakeup_sources_read_lock(void)
+	__acquires(&wakeup_srcu)
 {
 	return srcu_read_lock(&wakeup_srcu);
 }
@@ -264,6 +265,7 @@ EXPORT_SYMBOL_GPL(wakeup_sources_read_lock);
  * @idx: return value from corresponding wakeup_sources_read_lock()
  */
 void wakeup_sources_read_unlock(int idx)
+	__releases(&wakeup_srcu)
 {
 	srcu_read_unlock(&wakeup_srcu, idx);
 }
-- 
2.24.1


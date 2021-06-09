Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD7A33A10D6
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jun 2021 12:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238568AbhFIKIN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Jun 2021 06:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234217AbhFIKIM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Jun 2021 06:08:12 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E1FC06175F
        for <linux-pm@vger.kernel.org>; Wed,  9 Jun 2021 03:06:18 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id a1so27378447lfr.12
        for <linux-pm@vger.kernel.org>; Wed, 09 Jun 2021 03:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kziI9SCt0c63nrukquSSDGhvQsklkwm80pK2jCkKV/8=;
        b=ocAQ/4+bpUOUubmy0uU8rzGkEcreB5FA8DJQDdC+qjuGWhw5aunQ5NGgkRjkWMQmrS
         ZPkmgqCIy7BQt934bRcyJXeojgGvACSQecdfuhspGw+IHhl4dH0Tndk70mE+WUPhwk/h
         fzd99G0iK1QAAGArcBXPMp0CzMbmaK5h7saGzD/089u7NTMvI9ou7jvtlPn8v37tBxHy
         ONC7IItbCe0GKsL68GQ5ylKowtkGn5LC9KfwaSKYBYA5bVSzLlssptqwJxn13WRqsj6y
         EeGLF3fmtLVHXMmFNybGofjBwZiPN1StkB20aD+hzMSRJtbfxUE2LF6zKNZKqCduqiFV
         wf0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kziI9SCt0c63nrukquSSDGhvQsklkwm80pK2jCkKV/8=;
        b=YsFiZV9PiDe4Ds/FJaNj6UTi7+ampseglaeK3LCgSlryoKBCKGRE89uqfbyBgDbkx1
         9rh3QVLFAtAQiiNN1WS1ESO5c3rx3xtUG5qk5r3dw5Pz9qy0XmzmvpZnw0IOLnd9nCGz
         tU6gw4rno5SeV2Y3z5wzJF7lsXn0qtZKSWilJ3K58wYtdh2sKjtnRcMqA6W8bkIdTao0
         el7vJMOXTt1hR72bjEvUvToPCPWhOujHvLdGiUm4Fb1+9RPiiAKTinXbE26lD3F9QkcA
         lumYUl+UlZskkUlYKo46dRixY2rtcSem2X3VV+nXsNfVNMDopyeLxFjI5Wta0mNyUpve
         OPEg==
X-Gm-Message-State: AOAM5334gLJsJmSufuvJu2ItV1j2EmkznZXN63k2newHUh055S2YbNu1
        9cfsDLMA0/yWnm3eWyxWGRmT1Q==
X-Google-Smtp-Source: ABdhPJy3vLoeOu5r0E1JMWc+45Y9k4iikqrd7OlIr7swkKp5Gezd4tXOsSa6ac2rXxjOp9Hlx3QnrQ==
X-Received: by 2002:a05:6512:31cd:: with SMTP id j13mr18401644lfe.445.1623233176628;
        Wed, 09 Jun 2021 03:06:16 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-129-146.NA.cust.bahnhof.se. [155.4.129.146])
        by smtp.gmail.com with ESMTPSA id f11sm304406lfk.9.2021.06.09.03.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 03:06:14 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Saravana Kannan <saravanak@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/3] PM: runtime: Clarify documentation when callbacks are unassigned
Date:   Wed,  9 Jun 2021 12:06:10 +0200
Message-Id: <20210609100610.97830-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Recent changes to the PM core allows ->runtime_suspend|resume callbacks to
be unassigned.

In the earlier behaviour the PM core would return -ENOSYS, when trying to
runtime resume a device, for example. Let's update the documentation to
clarify this.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v4:
        - This time, really, fix spelling and further clarified the behaviour,
	according to comments from Alan.

---
 Documentation/power/runtime_pm.rst | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/power/runtime_pm.rst b/Documentation/power/runtime_pm.rst
index 18ae21bf7f92..8a0a43811e3a 100644
--- a/Documentation/power/runtime_pm.rst
+++ b/Documentation/power/runtime_pm.rst
@@ -827,6 +827,15 @@ or driver about runtime power changes.  Instead, the driver for the device's
 parent must take responsibility for telling the device's driver when the
 parent's power state changes.
 
+Note that, in some cases it may not be desirable for subsystems/drivers to call
+pm_runtime_no_callbacks() for their devices. This could be because a subset of
+the runtime PM callbacks needs to be implemented, a platform dependent PM
+domain could get attached to the device or that the device is power managed
+through a supplier device link. For these reasons and to avoid boilerplate code
+in subsystems/drivers, the PM core allows runtime PM callbacks to be
+unassigned. More precisely, if a callback pointer is NULL, the PM core will act
+as though there was a callback and it returned 0.
+
 9. Autosuspend, or automatically-delayed suspends
 =================================================
 
-- 
2.25.1


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2ED819C40B
	for <lists+linux-pm@lfdr.de>; Thu,  2 Apr 2020 16:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388234AbgDBO2R (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Apr 2020 10:28:17 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36835 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388040AbgDBO2M (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Apr 2020 10:28:12 -0400
Received: by mail-wr1-f67.google.com with SMTP id 31so4471637wrs.3
        for <linux-pm@vger.kernel.org>; Thu, 02 Apr 2020 07:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VU+xqIYUTfSvHhAUSB6IALHNuMd3fiGTEeSEcx6bLyc=;
        b=ZQ7d6GqzAsfbjd/MDsta02mPMBsWG2DWMtHQBcag5uJzvizQXTWes+lpcRIKs897Cz
         0ekiMSVf/i4tYpoD4j5pQ9zU0j6qdaJcVbvSlKeU+BnlI5IMB7FfenFk4tAuDNY7D9qb
         YYEOBCdVMf9p2nI6AdHUXtJH4tGV7csYlbxkda4ht10qKDHngS+rpfjhLaisr+Q83GZN
         du6thyKJ9Ox1zEcizCAJXf66hsMBmhu2vHfspOo/RgwHxobTtKZ5vyWv8vWAagWcCSlo
         s+L47YHN88sSsewX0BA16l+uqYK8RbGfA6ePDsLJSkxCzNtSyaFixmF9iT52VUgP0l4v
         lTAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VU+xqIYUTfSvHhAUSB6IALHNuMd3fiGTEeSEcx6bLyc=;
        b=FNnFkLn8tphHFhqRaWGhwOnmx2RJq25izcNLFxzp+HaG4vi3edYWk0weLWI5f+vSYo
         CE4LyAVmqv6VC0SqIEyAikneMJW4okn3bhyCJd/nYuSS/Tz4ou/k/2KTB0w7VmBoOhAS
         B3/F8JxCu4ZXst5qVAVH4hEq8usRXnYS2TI/4X40NWmRUduyotWm6cPbk2qIJm8B9LFO
         27iJ8aldfI7OcgN4L3LZZaEPIRdpE4niVXx2vBAhWKaPCo5ip0gCtIToYJrX8lPYpKEe
         1h8PT5XMTMUFpAx0tdsRdOUSR6rJUI8rv6COanhIn+A38yyTE9JCkrAAS3xO5ThZiQNg
         lr+w==
X-Gm-Message-State: AGi0PuYBymZS9XMn50aRrKnhvdfZTWvyPJxGpOCJ7OHcs3t01pdMRR2I
        hlVbOS0RuMPjCXhkFmhWFOelKw==
X-Google-Smtp-Source: APiQypLT5yw5tziJRrxbLM60c69A4QnjkhFlp8iihyXSDhdHB/OsoJrERJNAbcAMyfJhp9htuqZXQw==
X-Received: by 2002:a05:6000:11c2:: with SMTP id i2mr4090462wrx.210.1585837690305;
        Thu, 02 Apr 2020 07:28:10 -0700 (PDT)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:4b2:e366:e86f:261a])
        by smtp.gmail.com with ESMTPSA id a7sm7045186wmm.34.2020.04.02.07.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 07:28:09 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rui.zhang@intel.com
Cc:     amit.kucheria@verdurent.com,
        linux-pm@vger.kernel.org (open list:THERMAL),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH V2 8/9] thermal: Remove stubs for thermal_zone_[un]bind_cooling_device
Date:   Thu,  2 Apr 2020 16:27:46 +0200
Message-Id: <20200402142747.8307-8-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200402142747.8307-1-daniel.lezcano@linaro.org>
References: <20200402142747.8307-1-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

All callers of the functions depends on THERMAL, it is pointless to
define stubs. Remove them.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 include/linux/thermal.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 12df9ff0182d..7b3dbfe15b59 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -426,16 +426,6 @@ static inline struct thermal_zone_device *thermal_zone_device_register(
 static inline void thermal_zone_device_unregister(
 	struct thermal_zone_device *tz)
 { }
-static inline int thermal_zone_bind_cooling_device(
-	struct thermal_zone_device *tz, int trip,
-	struct thermal_cooling_device *cdev,
-	unsigned long upper, unsigned long lower,
-	unsigned int weight)
-{ return -ENODEV; }
-static inline int thermal_zone_unbind_cooling_device(
-	struct thermal_zone_device *tz, int trip,
-	struct thermal_cooling_device *cdev)
-{ return -ENODEV; }
 static inline void thermal_zone_device_update(struct thermal_zone_device *tz,
 					      enum thermal_notify_event event)
 { }
-- 
2.17.1


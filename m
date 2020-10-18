Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D878D291806
	for <lists+linux-pm@lfdr.de>; Sun, 18 Oct 2020 17:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgJRPVg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 18 Oct 2020 11:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbgJRPVf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 18 Oct 2020 11:21:35 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB78C061755;
        Sun, 18 Oct 2020 08:21:35 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id 23so4025046ljv.7;
        Sun, 18 Oct 2020 08:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VtpdlBX2SFrPia1lw3w/twJyFVdNiSIe4U4QQ2v4e1c=;
        b=FQqTEExB4p06tKd9q0RIuPTm064MqB0pFGJ7i8nqIEmtZkt+d2dHMytpo+4+bazN2+
         yPFn/sT1iS95v56+3FF5Yz5bEMtLeyz4DccMpJxdDEH3wrP7/IfTakmBuss4QvCOa94C
         o/zCKWd8QOZr1uoLu8jJYodghD9UNueMlDguEWzx5s0zYdfBIyjwZIn9O/8oS/Ju9/Iq
         cnckAT2pOungAPLwxZnT7+t0QjWQN5dlyDCB8g7kJj4OpU98E3anwie96RARCCH/vamx
         9JdAGacYAS0QbKqcZ9AyI6ZSc4QGDRDuKNVIp7uERSq/uACRXastuV7d/jtSdR4HTHT+
         MiLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VtpdlBX2SFrPia1lw3w/twJyFVdNiSIe4U4QQ2v4e1c=;
        b=NZJxyUPu6Lnc7AyR7GpBcPN/++aO2ePLcT31IzHhvK7oWryS3iLW97SnzD1EG8ZCgi
         I+Cg0ZqVi5aT3NacdA9LFzUroXfuSIy+opAB/Qts3H2FT7oC0FuvYqKXnM7I9wWqZIML
         7Km4R+AKVbLTDyp1TaG81RYexa57xA/1J4DaVxXCJFUbGO9zjIZwqfDPusu5bGhPTlFB
         eZ5iQGiuftlgRHkvuWO/5EXgc1F5hnQ3Kkf66s9+m29MHqDED5AfvsSmBoJZCa5gxhTH
         XFybqT+LorJF/BDHszTFN+K58qtofSFyg58QfzNXK4toVnCSlpP60vI2gJGj6Y3/NUq4
         De6Q==
X-Gm-Message-State: AOAM530MRmon2PxFsd8Z23zOo4RGd0RC8bB+4jPdn5sF8zPkZ7ZTQue1
        8QOW7cGspkaOhFEEL+6v9m6bL58p9bHPj2mE
X-Google-Smtp-Source: ABdhPJyTaYX+sDOnTnWEIAc3rQHytBudND0xZSCVfZi5lCJYUuHxF9IClsZFGHYc9lZ/QVvQc0eGzA==
X-Received: by 2002:a2e:2a86:: with SMTP id q128mr3972086ljq.158.1603034493667;
        Sun, 18 Oct 2020 08:21:33 -0700 (PDT)
Received: from localhost ([2a02:a310:53e:fc00:a13a:fe7:fa56:f3f9])
        by smtp.gmail.com with ESMTPSA id m13sm2787966lfl.269.2020.10.18.08.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2020 08:21:33 -0700 (PDT)
From:   Hubert Jasudowicz <hubert.jasudowicz@gmail.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-pm@vger.kernel.org (open list:POWER MANAGEMENT CORE),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] powercap: Fix typo in Kconfig "Plance" -> "Plane"
Date:   Sun, 18 Oct 2020 17:21:06 +0200
Message-Id: <adc856179a9496f73be4036d80e6e6fa5c7ee591.1603033133.git.hubert.jasudowicz@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Signed-off-by: Hubert Jasudowicz <hubert.jasudowicz@gmail.com>
---
 drivers/powercap/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/powercap/Kconfig b/drivers/powercap/Kconfig
index ebc4d4578339..bc228725346b 100644
--- a/drivers/powercap/Kconfig
+++ b/drivers/powercap/Kconfig
@@ -30,7 +30,7 @@ config INTEL_RAPL
 
 	  In RAPL, the platform level settings are divided into domains for
 	  fine grained control. These domains include processor package, DRAM
-	  controller, CPU core (Power Plance 0), graphics uncore (Power Plane
+	  controller, CPU core (Power Plane 0), graphics uncore (Power Plane
 	  1), etc.
 
 config IDLE_INJECT

base-commit: 9d9af1007bc08971953ae915d88dc9bb21344b53
-- 
2.28.0


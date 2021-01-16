Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56B092F8DC3
	for <lists+linux-pm@lfdr.de>; Sat, 16 Jan 2021 18:10:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbhAPRI2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 16 Jan 2021 12:08:28 -0500
Received: from mail-pj1-f43.google.com ([209.85.216.43]:37377 "EHLO
        mail-pj1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725964AbhAPRIZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 16 Jan 2021 12:08:25 -0500
Received: by mail-pj1-f43.google.com with SMTP id g15so2735764pjd.2;
        Sat, 16 Jan 2021 09:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4I6/1V/j2pZFuVVOV4REVkDfm4tmUoy6tKgu0Y3qV6s=;
        b=Basl4BJW/0jwOQd6SHCq+AJpjtzYWfYmlrTdm8INaFQtVsYPtMUM70jFguBF8giKNQ
         eTBbm0MPV3HAf2nviXqnHVW0lIllExXdnOfMHylFphFSkiBu9+CFao39+QAq6a2jahPn
         ujhoBLeycc7GcBpXC6O6mS9vENkfWB+gItwfBk+Bv/3dAy7pBahxGC48+GWgsU2NPOSD
         UqFhdvHWtd8WNlJcjGdp1NXTa1ArYuwNU0fMT6DxEZbBferUv1ErsN9j31F9sh0wKfhQ
         LjBuFmTIj18IhnL45BjolcKkUdjwG2IenUqphBhgpNkLd0QzgO1AanRUK39O+aj5iKVp
         m2nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4I6/1V/j2pZFuVVOV4REVkDfm4tmUoy6tKgu0Y3qV6s=;
        b=Vsxk3TdWQBsJTqvlkrTMyTFdO/KBxjHYsxay22ORBxhmw7ve3Yl+GgyJhohZIWlLCD
         pF6z8OnOt6GhgpSu0tGMEc0+tBDn1qOj2Aqk0Ky/Dj8uCwnDu70HkbU+laZuAzzAhFQZ
         /tDnADr8NYjG6zLD1yoBV0Px0mLCwIivS2lV02QsexjSCoFqohXbUXAKqJDMbsU6v/YY
         t5M2/q3prDK92rKWBL5irIpVmHGrjBCS2z4AbAra18BjX48RTMfTKQg4sWiDj5KMzFNT
         0Hdn/J1oiGkSfcr+hYOOF63k8lrX2/HuwGl3C82NDoKnW3s74RjOSWTBOf8aqG0sQQA+
         zFRA==
X-Gm-Message-State: AOAM530kORAxWsUkYLr3DNm4ojmuv+D9O/97kNP5wrOVvS1/uxgSPeFI
        YlUma3YpN3s4SGM8rf31LEk=
X-Google-Smtp-Source: ABdhPJxOjIduViQHxvOqYtA2ywxH3Gq6Yfse9K31DSEVwd4cDB8kQI9eoejGMYHfMtxpuAGkdE3uKw==
X-Received: by 2002:a17:90a:474c:: with SMTP id y12mr17448532pjg.175.1610816864856;
        Sat, 16 Jan 2021 09:07:44 -0800 (PST)
Received: from s18.smythies.com (test.smythies.com. [173.180.45.3])
        by smtp.gmail.com with ESMTPSA id f13sm7247566pjj.1.2021.01.16.09.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jan 2021 09:07:44 -0800 (PST)
From:   Doug Smythies <doug.smythies@gmail.com>
X-Google-Original-From: Doug Smythies <dsmythies@telus.net>
To:     lenb@kernel.org
Cc:     dsmythies@telus.net, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH] tools/power/x86/turbostat: Fix TCC offset bit mask
Date:   Sat, 16 Jan 2021 09:07:25 -0800
Message-Id: <20210116170725.5245-1-dsmythies@telus.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The TCC offset mask is incorrect, resulting in
incorrect target temperature calculations, if
the offset is big enough to exceed the mask size.

Signed-off-by: Doug Smythies <dsmythies@telus.net>
---
 tools/power/x86/turbostat/turbostat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 389ea5209a83..d7acdd4d16c4 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -4823,7 +4823,7 @@ int read_tcc_activation_temp()
 
 	target_c = (msr >> 16) & 0xFF;
 
-	offset_c = (msr >> 24) & 0xF;
+	offset_c = (msr >> 24) & 0x3F;
 
 	tcc = target_c - offset_c;
 
-- 
2.25.1


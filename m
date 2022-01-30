Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D119D4A39A2
	for <lists+linux-pm@lfdr.de>; Sun, 30 Jan 2022 22:02:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356361AbiA3VCX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 30 Jan 2022 16:02:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232616AbiA3VCW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 30 Jan 2022 16:02:22 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5328BC06173B
        for <linux-pm@vger.kernel.org>; Sun, 30 Jan 2022 13:02:22 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id c2so8846362wml.1
        for <linux-pm@vger.kernel.org>; Sun, 30 Jan 2022 13:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PRlA2mW2VZ0B7IKeYTrrJglGZpUD87Qspht3pCuXF60=;
        b=s4poMru3W116uAHW4cFJKcEjX0Hw2P5QiUgwieczodybEcf5nPtZA4OeDuqaZB/w70
         UBwKIaSVwXslwXVnrDGe7vX2uRfHVpSgpDhO4wjSNaemdgLOfUyNFYaOHSR5MobInWyj
         Cz1jEIoO1mqVobQWHbWauKgvvs4uud+9fQkuNmT7E6FEdswU8XUqph0qDK1N6HI30at4
         ZCFaVWYmJpYV8Qe4sQIWbGhCrA/QbOQzAP+mcqdeBlt5gClWAb38xsAz+vr3mqgVUWe7
         hXFMOdq/MUMj5kbSfwF4lB9bxp5Anzpglq/eeKibWaiB1RVPJr4PSfnp6q5X/rK06z05
         A7Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PRlA2mW2VZ0B7IKeYTrrJglGZpUD87Qspht3pCuXF60=;
        b=SWfqBMdyExO7sDJqHzYFKQz1tbojo5W20Kk7swYEUNi8o3wFz+7dzVgD2kqA0y1NmL
         T0PhT/ntI7lhiq7rv86Yj6/Qu4o6qG5JyvsE9SDafwr6CY2NSOwlNsJ6fI1aujy5WUma
         yTCgGoGbqw4Wdafed9l77I6zKeIlic66o2njEPNnS7txFx863VqCENhbFzKBvAYIf8tR
         0Dzd0vSJ3sZyPF7syyatfKlkUIBFlZkZWRPQNy1lNgPpgbEyVoc/ne8En82woTwaY65I
         0ASRBXY+nNtmFZXFD+WT6/EbYYB1TY91WwGGzfJDLYSV52f7pY1UYDfhQo0jGNKjKQxF
         wzcw==
X-Gm-Message-State: AOAM531RAMj5dllxme0rusqAb3GL24RbRgSvbdK1Nbqc0ds/uvVF50ek
        G5YUI2XzbQfSUpNhA7zZPOyV/A==
X-Google-Smtp-Source: ABdhPJyms0o/aq6IjOZs+4GOCYsm+xmkn2HDMprqxPuL3cCmBVwz3Tog10rmEdQ5oe57II3F/ow6mQ==
X-Received: by 2002:a05:600c:4808:: with SMTP id i8mr7723214wmo.23.1643576540890;
        Sun, 30 Jan 2022 13:02:20 -0800 (PST)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:d3c5:fe0:78a4:5227])
        by smtp.gmail.com with ESMTPSA id i6sm9845185wrw.8.2022.01.30.13.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jan 2022 13:02:20 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rjw@rjwysocki.net
Cc:     heiko@sntech.de, lukasz.luba@arm.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, ulf.hansson@linaro.org,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v1 5/7] powercap/dtpm: Move the 'root' reset place
Date:   Sun, 30 Jan 2022 22:02:07 +0100
Message-Id: <20220130210210.549877-5-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220130210210.549877-1-daniel.lezcano@linaro.org>
References: <20220130210210.549877-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The 'root' node is checked everytime a dtpm node is destroyed.

When we reach the end of the hierarchy destruction function, we can
unconditionnaly set the 'root' node to NULL again.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/powercap/dtpm.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/powercap/dtpm.c b/drivers/powercap/dtpm.c
index d9d74f981118..ec931a06d90a 100644
--- a/drivers/powercap/dtpm.c
+++ b/drivers/powercap/dtpm.c
@@ -184,9 +184,6 @@ int dtpm_release_zone(struct powercap_zone *pcz)
 	else
 		kfree(dtpm);
 
-	if (root == dtpm)
-		root = NULL;
-
 	return 0;
 }
 
@@ -656,6 +653,8 @@ void dtpm_destroy_hierarchy(void)
 
 	pct = NULL;
 
+	root = NULL;
+
 out_unlock:
 	mutex_unlock(&dtpm_lock);
 }
-- 
2.25.1


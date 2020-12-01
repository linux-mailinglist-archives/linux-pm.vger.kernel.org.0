Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C59852CAC57
	for <lists+linux-pm@lfdr.de>; Tue,  1 Dec 2020 20:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404368AbgLAT30 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Dec 2020 14:29:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404353AbgLAT30 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Dec 2020 14:29:26 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04772C0617A7
        for <linux-pm@vger.kernel.org>; Tue,  1 Dec 2020 11:28:46 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id p8so4506123wrx.5
        for <linux-pm@vger.kernel.org>; Tue, 01 Dec 2020 11:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=biB1E7VQfFhALxeshFh3G0/O96X9L1epLBYd8Sfk+Nw=;
        b=xLTJ2dkmFyetvAQs8XCbA2YVz+kk+PyA+BSVGtk7vkhZpJmN7WYZ2fbRETpXYZcULa
         mPJvpt+mMKnLdanZ7jRUu2dZTos/9GX0AStqszpT9FSBJkn96JZNBTmMVRA9SffEiA6R
         SPvFFszUJ4ewvKZW7029b0hxeFLwHIuzX4Lcxxhc+ntQ8FDEgIuvdeAYM6iYS/bUHEUb
         ucgaFtDeQxpmu8m18BUNUtpWu5X5bXmoVpWGbghatw7F+DIrtldAcySmsO2CWA5EB0Lc
         wy2Bk2ht9HGAB2tyDQOwisu9hj/e5BJn+AWsEKw4hDvHhOgk9KPMh74F+Gn+SAQ3+T84
         jgMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=biB1E7VQfFhALxeshFh3G0/O96X9L1epLBYd8Sfk+Nw=;
        b=jZebo3HZn+Bak/z17u1IA/xQOgm3c6PEQNNolH6+Y+4W/mdXgVwgKSTxNGyoFqiKXw
         1Q2btFbDOUMPwo7YuQLalx0S4d9TC+zysF+Ni7cu1soR7k2he88cHYofmL6Zf2Tupgj/
         Ebi4a+3ETmg5TgGX4Tc8KacbUWZ2+yMj5owdHw6Agg3HEUhSMQUMfexmK9bDnNoUy4UN
         ebjRGIG2mksnOmDHVk03GJRjUJUQuxorj4ckI/rS/Z7/F5o9oqQCvKbpvKDHlqYo47rE
         EXGvu0cfMlLpEbK0TcgFzWI+gj8Yio3BV7KWpYlzVZteZ/Q6ZGofj3L6vS5sb2hJg1qg
         Gf0w==
X-Gm-Message-State: AOAM533LRnzIVTtWtVmFnP8/Kol/3lrtZ4gz3XB4V6Dc3a1gembzdgp4
        zAABJBzRZe49GGQfpj59BY+Kp/IfobgHIg==
X-Google-Smtp-Source: ABdhPJx95WGJ6TQR/QZKhtS/lpYNafznf+2LBdWmdQISBKxr3euml49jW2IQLZ682viiVEd3D3KW/g==
X-Received: by 2002:a5d:4b81:: with SMTP id b1mr5842762wrt.372.1606850924675;
        Tue, 01 Dec 2020 11:28:44 -0800 (PST)
Received: from localhost.localdomain (lns-bzn-59-82-252-140-184.adsl.proxad.net. [82.252.140.184])
        by smtp.gmail.com with ESMTPSA id n123sm1317922wmn.7.2020.12.01.11.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 11:28:44 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rjw@rjwysocki.net
Cc:     ulf.hansson@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org,
        lukasz.luba@arm.com, Thara Gopinath <thara.gopinath@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Ram Chandrasekar <rkumbako@codeaurora.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Akinobu Mita <akinobu.mita@gmail.com>
Subject: [PATCH v4 1/4] units: Add Watt units
Date:   Tue,  1 Dec 2020 20:27:58 +0100
Message-Id: <20201201192801.27607-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201201192801.27607-1-daniel.lezcano@linaro.org>
References: <20201201192801.27607-1-daniel.lezcano@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

As there are the temperature units, let's add the Watt macros definition.

Cc: Thara Gopinath <thara.gopinath@linaro.org>
Cc: Lina Iyer <ilina@codeaurora.org>
Cc: Ram Chandrasekar <rkumbako@codeaurora.org>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Lukasz Luba <lukasz.luba@arm.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
---
 include/linux/units.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/units.h b/include/linux/units.h
index aaf716364ec3..92c234e71cab 100644
--- a/include/linux/units.h
+++ b/include/linux/units.h
@@ -4,6 +4,10 @@

 #include <linux/kernel.h>

+#define MILLIWATT_PER_WATT	1000L
+#define MICROWATT_PER_MILLIWATT	1000L
+#define MICROWATT_PER_WATT	1000000L
+
 #define ABSOLUTE_ZERO_MILLICELSIUS -273150

 static inline long milli_kelvin_to_millicelsius(long t)
--
2.17.1

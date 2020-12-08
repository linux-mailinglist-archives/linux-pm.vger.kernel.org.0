Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 535EE2D3005
	for <lists+linux-pm@lfdr.de>; Tue,  8 Dec 2020 17:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730481AbgLHQnI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Dec 2020 11:43:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730474AbgLHQnI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Dec 2020 11:43:08 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF760C06179C
        for <linux-pm@vger.kernel.org>; Tue,  8 Dec 2020 08:42:21 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id q16so18201469edv.10
        for <linux-pm@vger.kernel.org>; Tue, 08 Dec 2020 08:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=B8ZqKyFHGH5C+QdIaLYiAJfgSlK2HoPCxGbkd1rkjtU=;
        b=YJGXosdLUTFfXiLJhGUn7kcaKGyWwlL+NNVTDbQa1EmRHBT7VYNdOSoTOo+4/pO7Rv
         f67HYgSUuN/zNwg8creeABtACtEh35QesqX+DtjL7f9RLkZMLQMmOqK/f1LSzENWvRdy
         2RhNgiZznYQaDa34tLeh3z1qy8oUPpp2RMFmqNZs9uSqhsGJfm33k5EwJLjg5NRwCwQX
         e5q9PodIkfLUCoXywx+sArD+xGAC3GhatjyWilLx7BUAFtnIFYeqnodo8s7XG7bvhXeo
         LEeA3SL41D2ENjNej6A8tEzJULIHEhLjNJ598yPvyB0HQMU46EF2LbQFZAoFxYRBz5NL
         08mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=B8ZqKyFHGH5C+QdIaLYiAJfgSlK2HoPCxGbkd1rkjtU=;
        b=XJiKecPkRzyMmcL0AuBFrFAF+OBF+Of1Xc8pUOMRaTCfI8ges3d8gJju9RSMhe4a8U
         pwTTHPw+gTqvLc8okrTewc7P6r5LxbgYMI0OI/Xv4cnaafiFMojUohXlf7rWFUqyFcMn
         vpE+6fbbamR6fuFbyKhIB7TW7hSca0mpXWWBEEae+XW3bTQd863LIMzBpAK2u29pBV/U
         Dvj1BOVZ3BqAr8oZo5uVqu6iXThJKeefPZWbcuFRCQAlMWk/CpFHF5nxpK6V0gbLQvAz
         CdwOT9aEoSPEpkmngd7YWreLJH+CP/33pcliNiRq4wkx0DGsla1blGN5lMVv0N01JUrS
         5ulw==
X-Gm-Message-State: AOAM533OkCANsXLjAGOsOaIl9LVmjF2Z7AQSfSyqt4owordgTTe9t8Uw
        v7XrR5FuPlaMVnMVsIjUgOQIJg==
X-Google-Smtp-Source: ABdhPJzsje/g6gUZ+/m6qEO4sipKpj2XfNKA+0bsFwkdBQMj+67enVK+bcuHNopCvhldU3J6mYF1WA==
X-Received: by 2002:a05:6402:139a:: with SMTP id b26mr7346573edv.47.1607445740668;
        Tue, 08 Dec 2020 08:42:20 -0800 (PST)
Received: from localhost.localdomain (lns-bzn-59-82-252-158-132.adsl.proxad.net. [82.252.158.132])
        by smtp.gmail.com with ESMTPSA id t19sm16150546eje.86.2020.12.08.08.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 08:42:20 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rjw@rjwysocki.net
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Ram Chandrasekar <rkumbako@codeaurora.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v5 1/4] units: Add Watt units
Date:   Tue,  8 Dec 2020 17:41:42 +0100
Message-Id: <20201208164145.19493-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201208164145.19493-1-daniel.lezcano@linaro.org>
References: <20201208164145.19493-1-daniel.lezcano@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

As there are the temperature units, let's add the Watt macros definition.

Cc: Thara Gopinath <thara.gopinath@linaro.org>
Cc: Lina Iyer <ilina@codeaurora.org>
Cc: Ram Chandrasekar <rkumbako@codeaurora.org>
Cc: Zhang Rui <rui.zhang@intel.com>
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


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA60212708E
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2019 23:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfLSWTx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Dec 2019 17:19:53 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35728 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbfLSWTv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Dec 2019 17:19:51 -0500
Received: by mail-wr1-f68.google.com with SMTP id g17so7553167wro.2
        for <linux-pm@vger.kernel.org>; Thu, 19 Dec 2019 14:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xIw0nWMVvmMwb4Q12xq9FnKNnehOct3euxpTG4ta6kw=;
        b=UELwUgkIqMLM8KbzghW/nxo2zlVq5P1wRHZQUzemcp1Mo4En6J69er+/z19UrnXzq7
         4HWSjAk+mRtSYwkLpV0E70UgihbarSN4mbe41sDDk/fTL33TfqmA44/eiUmYo4Werjy2
         Z1NmTMYj1xIYm1jjYDhBQ2bjLvrH42FibRjvlf7t5WV5ZxJYLRs3uDjkNtVKqyVsPozN
         r91Aht9GVlVNOPAPNvxZTCeLr0vtxmeHo9ROBM2yXck7D7JMjjyH6T9hfg2E2NDELFT+
         HpB9sxM+GD5/Arv6Y63UTZ4J6zEZ1BXoI6+M79zEvpj7O0THPCzg4N97UOuxdqx4bSks
         jnOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xIw0nWMVvmMwb4Q12xq9FnKNnehOct3euxpTG4ta6kw=;
        b=et/k5C4iUVZY/xODOI5kPpncc5M5CGTKEJVPYpoQSGV3bRp2QDtBt1b8R5FvQTACas
         duSR5CwoudJTMnXSdGRKDXdIwnHO2W4rDhTfcuxXDj/z42i8hVZ/Bd2/pKBN512Ww+lV
         OSgp9zFz/We3wGj2b/N8eKJEJzImSG+918XKo6apDBYZa7Ux5GUj7n4yxZdsA7KT17Sm
         SVewNNdy7i5b4f9O9hfowpWI5rgBLS986W72+uLb+ZswGwnlRtGQrhS9wxCzVXbzh737
         Wc1WtoKA/L/CjlzCukNDFnz9o2tITMlemiQqybRZ4LlHaMtSsQ1+zpMJnQ9V6WNI+pef
         YpiA==
X-Gm-Message-State: APjAAAWzOx6ZO2l9G90Vt1y0qIt+L1yvz9inAodSFU7lHCq5bcqIFqNq
        E6hyqXET8jrk+awUb39HSjl+ew==
X-Google-Smtp-Source: APXvYqzilQIba81xsMAm/XzNo8yOiToCMG0j4CoenolEuzgNB9N7sIv8+//Szr3GBzVBI0YM7rAOzQ==
X-Received: by 2002:adf:ef49:: with SMTP id c9mr11527564wrp.292.1576793989331;
        Thu, 19 Dec 2019 14:19:49 -0800 (PST)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:58d:4e9b:2833:86c3])
        by smtp.gmail.com with ESMTPSA id n189sm8161765wme.33.2019.12.19.14.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 14:19:48 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-pm@vger.kernel.org (open list:CPU IDLE TIME MANAGEMENT FRAMEWORK),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] thermal: cpuidle: Register cpuidle cooling device
Date:   Thu, 19 Dec 2019 23:19:28 +0100
Message-Id: <20191219221932.15930-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191219221932.15930-1-daniel.lezcano@linaro.org>
References: <20191219221932.15930-1-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The cpuidle driver can be used as a cooling device by injecting idle
cycles. The DT binding for the idle state added an optional

When the property is set, register the cpuidle driver with the idle
state node pointer as a cooling device. The thermal framework will do
the association automatically with the thermal zone via the
cooling-device defined in the device tree cooling-maps section.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpuidle/dt_idle_states.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/cpuidle/dt_idle_states.c b/drivers/cpuidle/dt_idle_states.c
index d06d21a9525d..34bd65197342 100644
--- a/drivers/cpuidle/dt_idle_states.c
+++ b/drivers/cpuidle/dt_idle_states.c
@@ -8,6 +8,7 @@
 
 #define pr_fmt(fmt) "DT idle-states: " fmt
 
+#include <linux/cpu_cooling.h>
 #include <linux/cpuidle.h>
 #include <linux/cpumask.h>
 #include <linux/errno.h>
@@ -205,6 +206,13 @@ int dt_init_idle_driver(struct cpuidle_driver *drv,
 			err = -EINVAL;
 			break;
 		}
+
+		if (of_find_property(state_node, "#cooling-cells", NULL)) {
+			err = cpuidle_of_cooling_register(state_node, drv);
+			if (err)
+				break;
+		}
+
 		of_node_put(state_node);
 	}
 
-- 
2.17.1


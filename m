Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4DDB29C804
	for <lists+linux-pm@lfdr.de>; Tue, 27 Oct 2020 20:02:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S371332AbgJ0S7q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Oct 2020 14:59:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34868 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S371327AbgJ0S7m (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Oct 2020 14:59:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603825181;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=sfTbKiw+jeF8w3EzHE/NJ0fzZGcPzRXq1w6rKzCOzNQ=;
        b=YaB528y3IsHVW8sWeJZPrmC/eFAacQDZf4bNW7NJxCol2/0CIla1bJTHV2bU2FxxeCbhXL
        MnoUKURSh3RfQIRwflj6vEIoesCpjcXUWvJopLu1AEeFZBbbxuLRRj6ksE14IAUYErh1/f
        7VRbVtGm5/8jr9I6k0M3eVRCG5/m+X8=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-572-fspxTHPpOLm66Mnvwj3lNQ-1; Tue, 27 Oct 2020 14:59:39 -0400
X-MC-Unique: fspxTHPpOLm66Mnvwj3lNQ-1
Received: by mail-oi1-f199.google.com with SMTP id 204so1099457oid.21
        for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2020 11:59:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sfTbKiw+jeF8w3EzHE/NJ0fzZGcPzRXq1w6rKzCOzNQ=;
        b=o1UT9ggerbkXkWr0zttGPBQzA3a1hNX9PDKrKCaOteMhBetXUMo4jXXWbf43eISyoF
         83YBCAqQi9oENuqanKPI6lfDYht1K24Zplp6eDxvlOLHCPBqaJc4vYVT9tCW8byepl4O
         lMlDS8abXJdg1I0+Ma9KM/wwHJaxSbc0YAAvVk92YvXG6MUXb7z2wQtF8U80LUaibYZ/
         is0qk1W2ZizJRSvFtUOm8zT9gSuVH5dGeu/hDsLw6Md4oiaiVsLeGH4o3TgGRyf8Hb8J
         Mtsmpu0kf4BdBfUsHOj4BmP3XRb6V2NLgk5SNa+TQJIaf1FruDzuUc8Q7Uln1BJilFc1
         Rxqg==
X-Gm-Message-State: AOAM532vc9asXawKiibMMiy0HVDiveWSxTMcL/T9cxvKR/n2jJ236tzN
        pO6JrIpQr6Z9qtXrB5Wyi9Vx4Rmuc/M6TSGuYfkcaSyfSth+lwqzs7+RqjbfO3M34rw3oiMtFpz
        VmN5Qh/fmkor4VQFrqb0=
X-Received: by 2002:a9d:604e:: with SMTP id v14mr2407290otj.234.1603825179149;
        Tue, 27 Oct 2020 11:59:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxWlj7rFomA6Zy2XUfPuGp7CTLGBrS2ZZd4sxN3Xe36Gr6sYTM4EsopH4vRTx8gFR+VXXcwpw==
X-Received: by 2002:a9d:604e:: with SMTP id v14mr2407284otj.234.1603825178972;
        Tue, 27 Oct 2020 11:59:38 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id c128sm1891974oob.23.2020.10.27.11.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 11:59:38 -0700 (PDT)
From:   trix@redhat.com
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] cpufreq: speedstep: remove unneeded semicolon
Date:   Tue, 27 Oct 2020 11:59:34 -0700
Message-Id: <20201027185934.1586984-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A semicolon is not needed after a switch statement.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/cpufreq/speedstep-lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/speedstep-lib.c b/drivers/cpufreq/speedstep-lib.c
index a13a2d1e444e..0b66df4ed513 100644
--- a/drivers/cpufreq/speedstep-lib.c
+++ b/drivers/cpufreq/speedstep-lib.c
@@ -240,7 +240,7 @@ unsigned int speedstep_get_frequency(enum speedstep_processor processor)
 		return pentium3_get_frequency(processor);
 	default:
 		return 0;
-	};
+	}
 	return 0;
 }
 EXPORT_SYMBOL_GPL(speedstep_get_frequency);
-- 
2.18.1


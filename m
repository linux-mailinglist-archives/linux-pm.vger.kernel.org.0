Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97BEE3729E5
	for <lists+linux-pm@lfdr.de>; Tue,  4 May 2021 14:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbhEDMPj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 May 2021 08:15:39 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41495 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbhEDMPi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 May 2021 08:15:38 -0400
Received: from mail-qv1-f69.google.com ([209.85.219.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1ldtwo-00014A-RQ
        for linux-pm@vger.kernel.org; Tue, 04 May 2021 12:14:42 +0000
Received: by mail-qv1-f69.google.com with SMTP id r11-20020a0cb28b0000b02901c87a178503so1753490qve.22
        for <linux-pm@vger.kernel.org>; Tue, 04 May 2021 05:14:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2jrHuSrwRsSBaANh1fW2x8t+NrzkJf+pmPZRwAI6hhI=;
        b=KkqPwoc5kTXVkBiinRaZGjQNoIBjvaBRWZNHR5QMMYA+aQ2x4TEoOALm+6KkWFB0Dg
         rSY5RXhVf3ngwvk982VTM1VOc/guy7F/C8KZ1SJctsV4TRkDeBNTW7zhCmMXGU7GfTYl
         Zyxdas1mJ6atZ8f9e+4/aSv7wvNwJFrPzgFADIdeX8nh1jaIYumRLSUT1oNO3nEhobxa
         ltI9N+6qx/6DpwGPjuEZctF/TIkeFMrcidaFBxlAeJ353Uwp3bgOPlndG3oCvbvENcal
         zfnBFVJWHU0r4N2cT84f9eoQ4ED6dEFvIyv/4dXpgdl7v+u9YifOZOkgwwvOC1XrvtFX
         yCuQ==
X-Gm-Message-State: AOAM5320QPAbKjxZb1a/NkYhghIRSv7DOcka8vF2INlbW1c6Y/z5aJvA
        werPQL/30k2TjeaRVBBjWVu94b0iV61lsJ2WZMvmLYyeTdbdKMapIp1sbRmKP7IioDwQPrah9FI
        zCu+nAVUUZBxaHqioPwXfq1oLkftf2ehbQHE8
X-Received: by 2002:a05:6214:a62:: with SMTP id ef2mr19916175qvb.31.1620130482023;
        Tue, 04 May 2021 05:14:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyfTe7sTJl6AKixtSfV1yALubwrsCN0jqdi8R0pr10kYahin2lK2I1QmOQq1q4omwSb3OIA7g==
X-Received: by 2002:a05:6214:a62:: with SMTP id ef2mr19916162qvb.31.1620130481914;
        Tue, 04 May 2021 05:14:41 -0700 (PDT)
Received: from localhost.localdomain ([45.237.49.5])
        by smtp.gmail.com with ESMTPSA id v66sm10743990qkd.113.2021.05.04.05.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 05:14:41 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sebastian Reichel <sre@kernel.org>,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] MAINTAINERS: power: supply: use Krzysztof Kozlowski's Canonical address
Date:   Tue,  4 May 2021 08:14:37 -0400
Message-Id: <20210504121437.13424-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Switch to Canonical address in S3C power supply driver, just like in
other entries.

Cc: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1783372a608a..ccb9823fb77f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16021,7 +16021,7 @@ W:	http://www.ibm.com/developerworks/linux/linux390/
 F:	drivers/s390/scsi/zfcp_*
 
 S3C ADC BATTERY DRIVER
-M:	Krzysztof Kozlowski <krzk@kernel.org>
+M:	Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
 L:	linux-samsung-soc@vger.kernel.org
 S:	Odd Fixes
 F:	drivers/power/supply/s3c_adc_battery.c
-- 
2.25.1


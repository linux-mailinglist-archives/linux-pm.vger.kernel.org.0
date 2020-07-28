Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF1C2300E5
	for <lists+linux-pm@lfdr.de>; Tue, 28 Jul 2020 06:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgG1E7I (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Jul 2020 00:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgG1E7H (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Jul 2020 00:59:07 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F12C061794;
        Mon, 27 Jul 2020 21:59:05 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id di22so6611524edb.12;
        Mon, 27 Jul 2020 21:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=qwT94/2d5vMLNnP3aSonuZ5wA6OYYOi5iOIf8fUcfiE=;
        b=guXqFEi/Daunmiz5/09ztCjMyaX9nl/DG7fSEBBnCM1H84PwnPC2j3u0XZEDw2I98A
         INfQLT6kVsJDAuhBqM3uUSeBpZdY0A2w0RQwYEyBth/a90TvLOlklx/OpJ5R+wvWsBWQ
         +WZ4EQLle8hKzLix2n+ShgAAcNWm0sQvxHjtefkH9PDGKhsKRFPJ1+lw4qLGgZrktrC7
         9j8aqIZFIu5Nq7mLTmklXXaGr0+FUDdwFVuCz7LfF/XVCq+SXxMA94g15gj2b77r7kB0
         Q8u7S2V6HKKCxJAWWM4rxGOrJBJNIIskq8rfSGRBqJVYC4EKM6VOg9doyrgaQKo+vYrg
         WexQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qwT94/2d5vMLNnP3aSonuZ5wA6OYYOi5iOIf8fUcfiE=;
        b=P8VW3PmswKj1o1wdU7cW4RJGidY4fFt6FwokNq/VdrqDHvQNB4y8FGjYYFBDwu/rQ6
         kMwCdMYn3Skq3T7i/I2UmW2HcLnSiuxxiQssH4zl1G167UBaYMrkJljIWeJujJ6iECyM
         Ea5DWrHUIRCJtRnMVPcUg9VCUBpC7hZjbKWn8UEKIYUkbs9Vs6avvlqAbOdqXUGoF3M9
         HUKtZ5rA0leMOAmDLaGBmowDVapIWJtpbaCFhPmwJyfnZZUANkoLjO3YUPAJTEPqn0UV
         QCPNCH1k7kBDTz9UWIXmZoifGclMVlYDrrSTrvlKCP/1nPX4BVXQdEu0xjTTHDhfORoY
         Q1QA==
X-Gm-Message-State: AOAM530Ox0MhDOkZprktRKasdKibbce4mgvCpQ/E/abYQOhGKwY+D2Sb
        pyjb2rW6KYZx4NuotrC1rk2sgHcOMKY=
X-Google-Smtp-Source: ABdhPJys0wyfvlOiKfT8X3K5UcykXzPKQlSmRCRZ0K5sBjw/kY8acLU8Kux2FLegMUzaBa6q+qyP+Q==
X-Received: by 2002:aa7:d989:: with SMTP id u9mr24317597eds.85.1595912344289;
        Mon, 27 Jul 2020 21:59:04 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2d6c:b00:cd97:e2be:76a3:65a9])
        by smtp.gmail.com with ESMTPSA id q3sm6840596edc.88.2020.07.27.21.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 21:59:03 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-msm@vger.kernel.org
Cc:     Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        Pia Eichinger <pia.eichinger@st.oth-regensburg.de>,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: update entry to thermal governors file name prefixing
Date:   Tue, 28 Jul 2020 06:58:50 +0200
Message-Id: <20200728045850.22661-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Commit 0015d9a2a727 ("thermal/governors: Prefix all source files with
gov_") renamed power_allocator.c to gov_power_allocator.c in
./drivers/thermal amongst some other file renames, but missed to adjust
the MAINTAINERS entry.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains:

  warning: no file matches    F:    drivers/thermal/power_allocator.c

Update the file entry in MAINTAINERS to the new file name.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Amit, please ack.

Daniel, please pick this non-urgent minor patch for your -next tree.

applies cleanly on next-20200727

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index aad65cc8f35d..aa5a11d71f71 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17164,7 +17164,7 @@ M:	Lukasz Luba <lukasz.luba@arm.com>
 L:	linux-pm@vger.kernel.org
 S:	Maintained
 F:	Documentation/driver-api/thermal/power_allocator.rst
-F:	drivers/thermal/power_allocator.c
+F:	drivers/thermal/gov_power_allocator.c
 F:	include/trace/events/thermal_power_allocator.h
 
 THINKPAD ACPI EXTRAS DRIVER
-- 
2.17.1


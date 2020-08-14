Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 891C82449CE
	for <lists+linux-pm@lfdr.de>; Fri, 14 Aug 2020 14:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbgHNMh2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Aug 2020 08:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbgHNMh2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Aug 2020 08:37:28 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2242C061384
        for <linux-pm@vger.kernel.org>; Fri, 14 Aug 2020 05:37:27 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id t6so9728749ljk.9
        for <linux-pm@vger.kernel.org>; Fri, 14 Aug 2020 05:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i6wVk0NOTKCmok38t1o9CQfEvMictpw3WKbOiZaaxQ4=;
        b=e0qwwK87p4VSAwgjIaMUrsRege7Nd6pniOvtnX7UxpFKvV78kHHf6W7xVspTj6+38v
         uerKCoPZrBJ/Xblh1vDywlsoN8Dmhb/Ba3WxfFRw60BJWA9xE+1lgcJC0KF5i5AA05UQ
         2mjk917rYlwlAEWk7IsYP/bA6bGyksZKvv+cM2GFJiGj+8HNDbx1q97dKtLUxSFrlWNE
         tmOYBp703olmzavtkLQlN0rQgUv45DdaQbCFpK9eroxRfh8MUrk08ZN0A3MoPSNrytxh
         0367xSzXIPshEnS8DXxXbh+jPUM07aXh5H2kpuf8i+H305qP843nd6NeEALYARxhNVO2
         cavA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i6wVk0NOTKCmok38t1o9CQfEvMictpw3WKbOiZaaxQ4=;
        b=Vx6irP2ijpp6FnETtTkbCgeBEsyqthRlCEq/jAjL8boj3MMa/3HD+ub6VHButPWxuW
         qPXkDMxoPMHCLwQwg1sodDn+3UnsK3iCrMwM5nmHZ23GjLPVd/bVU3+zxwDPHLWk72tN
         8USaRmrsoBTCZs6LrbL6YGtc2DOJe3oTPEx8953zv99/oCkbwXp4xlyhoEpWWxgD9gkg
         R9mJouQbPqtxpflAxpfWTogk/nAdr/xCTM7iFrUsPwwLGikiE790Ua7Lm5nXlQu4UHny
         REKHlWq6OvtH8o4Ln+9JAxf/Vb3doolIp04bh2iQ6eAWR0ri+OPlSXWehdMrtc2Do1sC
         k5oA==
X-Gm-Message-State: AOAM531eJeskqlLAkn5C2WZ+NaXvuyMBEVCAtI6+36GAfKvPWiKqgRaI
        FWgeHPrHuYOkkYkvwg+X0iWvfA==
X-Google-Smtp-Source: ABdhPJzSYQa4dZobIdaRYS8PhHdc4JtDlOkD2lFtW4n75TAuOjNlR4F1kUHcPQxzV4qoEA1Vd6fMFQ==
X-Received: by 2002:a2e:b814:: with SMTP id u20mr1192615ljo.202.1597408645333;
        Fri, 14 Aug 2020 05:37:25 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-180-79.NA.cust.bahnhof.se. [98.128.180.79])
        by smtp.gmail.com with ESMTPSA id p25sm1742906ljn.58.2020.08.14.05.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 05:37:24 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        linux-pm@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] MAINTAINERS: Update section for cpuidle-psci
Date:   Fri, 14 Aug 2020 14:37:16 +0200
Message-Id: <20200814123716.61936-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Extend the file pattern to also include cpuidle-psci.h and
cpuidle-psci-domain.c. Moreover, add myself as a co-maintainer,
particularly to help with the support for PM domains.

Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f9ae8ea54e27..66821197175e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4556,10 +4556,11 @@ F:	drivers/cpuidle/cpuidle-exynos.c
 CPUIDLE DRIVER - ARM PSCI
 M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
 M:	Sudeep Holla <sudeep.holla@arm.com>
+M:	Ulf Hansson <ulf.hansson@linaro.org>
 L:	linux-pm@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org
 S:	Supported
-F:	drivers/cpuidle/cpuidle-psci.c
+F:	drivers/cpuidle/cpuidle-psci*
 
 CRAMFS FILESYSTEM
 M:	Nicolas Pitre <nico@fluxnic.net>
-- 
2.25.1


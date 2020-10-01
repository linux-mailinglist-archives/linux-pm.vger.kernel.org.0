Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D885727FC77
	for <lists+linux-pm@lfdr.de>; Thu,  1 Oct 2020 11:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731725AbgJAJ3A (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Oct 2020 05:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbgJAJ3A (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Oct 2020 05:29:00 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC449C0613D0
        for <linux-pm@vger.kernel.org>; Thu,  1 Oct 2020 02:28:59 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id w11so5714941lfn.2
        for <linux-pm@vger.kernel.org>; Thu, 01 Oct 2020 02:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lxkWfDdAWpwvBtJ5SN+i9/MI7hWoAZmdYZSbuiMF5cc=;
        b=s1Q/saU96Gy2H/Dofqs2qd1CCDavdBoj4GMVSXUyaK8ica+XSwGnN79o9ZzXPQwMdH
         06+Be2u51wAkBWGQwmyP1fy50YN5nLdqH8nIY7+Qn9wdXFzijNBYJvBXQr/8jDEtGnEy
         QR6KtccrziT8JMWsMtQceg0yW1YKv4oQc46/Tya7oETpW8/2tjeVRyOUYv47vEzf3FGN
         j+pG1JISk299IpLpkNgY8fg10+++3qWH+QWdyN1To/RvrdbAc1bvG6kOOvBdlhQlDU7G
         NXX/ilT6e5jpbgYHQXMa/S48nAJexRFgc4qioGKc1jdVn8XvhVtpIar1o6D6uZt4uqhv
         C6+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lxkWfDdAWpwvBtJ5SN+i9/MI7hWoAZmdYZSbuiMF5cc=;
        b=OAe9+yTS0ahc0b9Dv6it3ZsboQF2Yz38KYC0goOxhyGzrC3oD3Ulvv5nTpPo31xmdy
         pMV8ur7b5/ngXJ9od4JfDjnXcbisQWu0ChQjbCUqkP89YkMgYbnHxF4yYceSHP2VobsE
         gxzcHfGfMq7g0WUw9vsdZsagRzR/ra1F1TAdEHEqnZlktUWddxr29U7tSa3aiNcapLoF
         8+URRjfyxqECZEnV3g9cI8RRLVVNqX+fJMdPntbrEXW/P3PRgo5pTiAzqH2dJApPUKio
         hhbTSbOjaf0CqFkhaHvOjOR7xdKBDOhcrMnCjA18YEcndhbBizuIMvnHXL4NgniuGNND
         NkxA==
X-Gm-Message-State: AOAM531SpqqPt8iZfzkQcT4JRmViKGpcdQK/9H6WeEoFx98W1MF7d1YW
        zSRXDFtL414HzgPAfV+ofC0H7xR71ZNfDW86
X-Google-Smtp-Source: ABdhPJx81QXnZltoLgULrsnB0tngKaoGSgv8AlLGGbgPF0eamLBnbHywvu4oYVAcxDqQbzpwx/cK4w==
X-Received: by 2002:a19:9152:: with SMTP id y18mr2535251lfj.376.1601544538167;
        Thu, 01 Oct 2020 02:28:58 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-133-169.NA.cust.bahnhof.se. [155.4.133.169])
        by smtp.gmail.com with ESMTPSA id q24sm487922lfo.149.2020.10.01.02.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 02:28:57 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
Cc:     Lina Iyer <ilina@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
Subject: [PATCH] MAINTAINERS: Add section for cpuidle-psci PM domain
Date:   Thu,  1 Oct 2020 11:28:52 +0200
Message-Id: <20201001092852.124740-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The cpuidle-psci-domain.c is not listed in the section for the cpuidle
driver for ARM PSCI. From discussions at LKML, Lorenzo and Sudeep prefer
that we add a separate section for it, so let's do that and add myself as
the maintainer for this part.

Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 45102f1fe361..be8e3e9a8e29 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4574,6 +4574,14 @@ L:	linux-arm-kernel@lists.infradead.org
 S:	Supported
 F:	drivers/cpuidle/cpuidle-psci.c
 
+CPUIDLE DRIVER - ARM PSCI PM DOMAIN
+M:	Ulf Hansson <ulf.hansson@linaro.org>
+L:	linux-pm@vger.kernel.org
+L:	linux-arm-kernel@lists.infradead.org
+S:	Supported
+F:	drivers/cpuidle/cpuidle-psci.h
+F:	drivers/cpuidle/cpuidle-psci-domain.c
+
 CRAMFS FILESYSTEM
 M:	Nicolas Pitre <nico@fluxnic.net>
 S:	Maintained
-- 
2.25.1


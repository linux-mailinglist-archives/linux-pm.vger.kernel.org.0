Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7076A3B990B
	for <lists+linux-pm@lfdr.de>; Fri,  2 Jul 2021 01:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234448AbhGAXbQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Jul 2021 19:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234238AbhGAXbH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Jul 2021 19:31:07 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59E8C061765;
        Thu,  1 Jul 2021 16:28:35 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id q16so14835589lfr.4;
        Thu, 01 Jul 2021 16:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aFWmveTeoaoW3RFvsNJpft7Y7cAPSKpJ6ErHsqheVLE=;
        b=SYYEDFgrtRC0UQMeCSP82+Fb1iGb0lQRxxwRkGS0e/ErODNfFX2FdiCXOQhNgeRNin
         1vWGEV3lqEuu0Dz2CNRT//8WYeVj268SEoWdQXx6WxvUSYLVOTNomWtjHJsWNRyRIZIP
         uEfbdL0DyrLhH1KOmNHrNQNKLCXrO7D1Bx+Xn2IrC983/FMBaDl2blf9fdFYzUPskq+k
         U4zx0YH06QOVY8PmVpBuN0s1MQJ5bOJ7ughEvHENN+uxXrlyaHvKRhwNk8WQ6sNB9AoX
         beqWfVRd7zCv6Zqk+JKnPIt83bjJWMIUjBctXrRHmeVzDW8bkdlvsXrqKYtOhph4izpY
         tWoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aFWmveTeoaoW3RFvsNJpft7Y7cAPSKpJ6ErHsqheVLE=;
        b=oEKO1sEITRysq3hQVkCN6bGx15G98K2byZ+4ujARJuNlrzQKnmXWIrPj0X4dLMrE86
         59Phsf9X9ZLh9DxtovNIup20ckxuiFQMwg2uUMx9fnUM6zXxyw5RRpRD761R+I1AcMsb
         pX0UVlGgihWfhaCVsdLsTEu+tkSC31QA046vtRk55StwWJDFCz8ygy3XSXh3JDmESD6t
         DWrCF4cGPWsFAxqRCj4p9po9wzYuq8D+LVwIwdxqeWOvTNHtNBuOeQXvKYnLyqOmZRGK
         Pg1qBDEaaoKk/eV5IhPK4B1dW+Hk8fq4KhvXtVs9BXOym/GJUqTQiqw5m6WkXNUSDTDp
         lluA==
X-Gm-Message-State: AOAM530u18p26bBccWutzKXoI+2Pvvd20vmjld/wAKK9Xsve74gxLruS
        pTmHBnAfzp451G6NfqWXcw0=
X-Google-Smtp-Source: ABdhPJw00HGHbIEEXvEcCOkrasEaZA8n7UBSoW8wbIDNKliiGEF0O4kPIEw8Dkgfj+oWk878TpHj2Q==
X-Received: by 2002:a19:86c1:: with SMTP id i184mr1605819lfd.320.1625182114223;
        Thu, 01 Jul 2021 16:28:34 -0700 (PDT)
Received: from localhost.localdomain (94-29-37-113.dynamic.spd-mgts.ru. [94.29.37.113])
        by smtp.gmail.com with ESMTPSA id s20sm102655lfr.39.2021.07.01.16.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 16:28:33 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v7 08/37] dt-bindings: host1x: Document Memory Client resets of Host1x, GR2D and GR3D
Date:   Fri,  2 Jul 2021 02:26:59 +0300
Message-Id: <20210701232728.23591-9-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210701232728.23591-1-digetx@gmail.com>
References: <20210701232728.23591-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Memory Client should be blocked before hardware reset is asserted in order
to prevent memory corruption and hanging of memory controller.

Document Memory Client resets of Host1x, GR2D and GR3D hardware units.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../bindings/display/tegra/nvidia,tegra20-host1x.txt          | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt
index 62861a8fb5c6..07a08653798b 100644
--- a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt
+++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt
@@ -18,6 +18,7 @@ Required properties:
 - resets: Must contain an entry for each entry in reset-names.
   See ../reset/reset.txt for details.
 - reset-names: Must include the following entries:
+  - mc
   - host1x
 
 Optional properties:
@@ -197,6 +198,7 @@ of the following host1x client modules:
   - resets: Must contain an entry for each entry in reset-names.
     See ../reset/reset.txt for details.
   - reset-names: Must include the following entries:
+    - mc
     - 2d
 
   Optional properties:
@@ -222,6 +224,8 @@ of the following host1x client modules:
   - resets: Must contain an entry for each entry in reset-names.
     See ../reset/reset.txt for details.
   - reset-names: Must include the following entries:
+    - mc
+    - mc2 (Only required on SoCs with two 3D clocks)
     - 3d
     - 3d2 (Only required on SoCs with two 3D clocks)
 
-- 
2.30.2


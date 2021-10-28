Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C01F43F293
	for <lists+linux-pm@lfdr.de>; Fri, 29 Oct 2021 00:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbhJ1WTN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Oct 2021 18:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbhJ1WTM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Oct 2021 18:19:12 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2957FC061570;
        Thu, 28 Oct 2021 15:16:45 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id i26so11320386ljg.7;
        Thu, 28 Oct 2021 15:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zccR1Tq2hhAOkM8nx/fMHIfFzwGXSXLaETWpnFro8HM=;
        b=eZn3kUXN9Nt3/bN2zLGP9h5JktbC5d8/qFxl6rGy4PINL8CGIYT7YsvvIiHorRWnGx
         +PfmZ8Ymu4Q4RLycU7jQcbW1u03IvhkMhjS427UEQ3lwcDsxqtwtFskI6Ea5oqmIHC5k
         JKBtHNR3EPsTvXTYpHyIMyWTfri+CYRD0NwZILNDfMwe2R8F7HkKfxwCHiyMED3piZ7t
         /PwHXKIH/uGRNPFS6E4U+Lbphpu/sF/7WZJovpM6xvoCdu0TCIY/SDQ+/i8rit4aZULv
         VvUI5Q/C8H2JE0rNVpxtqiz0gXy/c8dMMIdybUv7t5i2rycALvRknx9BkFQwcYaXPNOC
         RKEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zccR1Tq2hhAOkM8nx/fMHIfFzwGXSXLaETWpnFro8HM=;
        b=AxvU6da5ELuPsooFzvePJpGP1AAlp27wdzyCL35UQMaDhL88AO1Da3WfhEUiN3lqUw
         U4wBWlrNQ9wOf5Of3nOIMQ5ZQ5jgYmUsnBX84HKU2SxL58Mf+TH6ElIhS4SsCIa9ZEN1
         RPzlYT1LB5MYvEKn+GIAGRzg6v5cIcRF1icOvPCIlORN6lpdIB4MY+Ht20if6jqTK7Me
         4QhVnKxtMfd4eg1p75vbFJcgj+n20ddzNQTY9v4rPtw2/5Au9cq/JT/G77kZopj1OS3I
         8KjuHllYelM12i23L5jWAo96U16CPca855s6hMxcQytWGuuEkVMt1ej3yLU4xrm+/8Mo
         FWAg==
X-Gm-Message-State: AOAM530LjtWc/oiahVbo8PGDTB0V0IRfwsjlPdX+X/nzT4qwgu0b91JT
        wT3RggVnZJCCBHL+YYV6tYg=
X-Google-Smtp-Source: ABdhPJyalJUYRYJip4v8rzWeYJluHz+c9NGgYD3IPDSAitpycpPooq4FbSIruhkvebXV6HHBFm9Glg==
X-Received: by 2002:a2e:8846:: with SMTP id z6mr7523700ljj.277.1635459403581;
        Thu, 28 Oct 2021 15:16:43 -0700 (PDT)
Received: from localhost.localdomain (46-138-44-18.dynamic.spd-mgts.ru. [46.138.44.18])
        by smtp.gmail.com with ESMTPSA id 9sm404598lfz.157.2021.10.28.15.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 15:16:43 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Viresh Kumar <vireshk@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        David Heidelberg <david@ixit.cz>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v4] dt-bindings: opp: Allow multi-worded OPP entry name
Date:   Fri, 29 Oct 2021 01:15:47 +0300
Message-Id: <20211028221547.22601-1-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Not all OPP entries fit into a single word. In particular NVIDIA Tegra OPP
tables use multi-word names. Allow OPP entry to have multi-worded name
separated by hyphen. This silences DT checker warnings about wrong naming
scheme.

Reviewed-by: David Heidelberg <david@ixit.cz>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---

Changelog:

v4: - Corrected pattern to retain matching of variants like 'opp1'.
      Was spotted by Rob Herring.

v3: - Viresh Kumar suggested that we shouldn't support postfix variant.
      I dropped variant with postfix naming scheme and multi-wording
      support of table names.

v2: - In addition to a multi-wording support, support of the postfix
      *-opp-table naming scheme is added to the updated pattern.

 Documentation/devicetree/bindings/opp/opp-v2-base.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/opp/opp-v2-base.yaml b/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
index ae3ae4d39843..15a76bcd6d42 100644
--- a/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
+++ b/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
@@ -33,7 +33,7 @@ properties:
     type: boolean
 
 patternProperties:
-  '^opp-?[0-9]+$':
+  '^opp(-?[0-9]+)*$':
     type: object
     description:
       One or more OPP nodes describing voltage-current-frequency combinations.
-- 
2.33.1


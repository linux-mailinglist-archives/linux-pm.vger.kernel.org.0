Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 285AB438C38
	for <lists+linux-pm@lfdr.de>; Sun, 24 Oct 2021 23:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbhJXWAF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 24 Oct 2021 18:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbhJXWAF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 24 Oct 2021 18:00:05 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C783EC061745;
        Sun, 24 Oct 2021 14:57:43 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id j21so6906349lfe.0;
        Sun, 24 Oct 2021 14:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+OPNFjQ0wVzkY1u6XnIDimYIJnCs2bgrAf6ProT42W0=;
        b=IrnQq0Ym/QnKoKVI7edsx4cAuDrzOkiqVEgNPjETSF4ydD9jJn6qC8iQNp5gwwrzUg
         dNNnNXC+8Io5c01EKUT5xLEY87PYxvuchZqE2tLsjro2P/0ruUOs3QTK8oEcQaEDVS8a
         4K15OGXLosRivPeDIFB/d2alg4MIMSBFtz4X5NWWhzs+mUO0so5S5Nuzw9pJHuRVLxMH
         xQLdySugfdoXNV+eiO9zi8952p6k246DuFaD5BW1qS+wPWMc1pxPjcXJB16cVvdakNRm
         8oUP3kaydN4Pb3m5EGwErpjIaqkZC3xiNDJtOPqVkosue4F+r2hJBaA1Luz/Z6L2xKKN
         eDfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+OPNFjQ0wVzkY1u6XnIDimYIJnCs2bgrAf6ProT42W0=;
        b=PMNUdAKsvhAszevU8M/jhrDNlz3jnB/c7OMs2S9Q0aEEUTIUkGw4VIYx5omnFmVXAi
         dFkqYP2INo11NFm6M/nHcyGtAAyftVDChzgsMCnUBw9i2UJOW37U35zbiLtpNc4XiP1Y
         DZ6zCjesWuUc/cxNuWbTXZhKibUU6Yt7vGkvSV6doDskqEq1ZEogBPzgowJtK5H7mpF1
         uGCdCVflqVB6HnRRrApQEh8FBj1xnrGx7zAoj1vWiP+7xL6E+Gjx9sP9GAj3ILIvAq7V
         tlOCVaNrO9WLgL6qU06SPB4iEnsm92os9R1ce8Ms0NsUGH52wbFMrUr5PPtK8wbFYZgT
         GbLw==
X-Gm-Message-State: AOAM530C4U4eNF7fRJnGuXyyzxmHfkAzEdQBoZsb+A/AaP3eNXEmxMV9
        4SWxg8Mifp6BGbm1Z/NIWfo=
X-Google-Smtp-Source: ABdhPJwzKtqJ08WOIh+DpB8KaTx7RH+I+2hakfvKl8cIVp2e+hPQrUdsJaAcL3p90wdPlomH4G2dEw==
X-Received: by 2002:a05:6512:33c8:: with SMTP id d8mr12823570lfg.621.1635112662112;
        Sun, 24 Oct 2021 14:57:42 -0700 (PDT)
Received: from localhost.localdomain (46-138-41-28.dynamic.spd-mgts.ru. [46.138.41.28])
        by smtp.gmail.com with ESMTPSA id d27sm1577364ljo.15.2021.10.24.14.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Oct 2021 14:57:41 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Viresh Kumar <vireshk@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        David Heidelberg <david@ixit.cz>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v3] dt-bindings: opp: Allow multi-worded OPP entry names
Date:   Mon, 25 Oct 2021 00:57:18 +0300
Message-Id: <20211024215718.28969-1-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Not all OPP entries fit into a single word. In particular NVIDIA Tegra OPP
tables use multi-word names where first part is freq and second voltage
because different hardware versions use different voltages for the same
freqs. Allow OPP entry to have multi-worded name separated by hyphen.
This silences DT checker warnings about wrong naming scheme.

Reviewed-by: David Heidelberg <david@ixit.cz>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---

Changelog:

v3: - Viresh Kumar suggested that we shouldn't support postfix variant.
      I dropped variant with postfix naming scheme and multi-wording
      support of table names.

v2: - In addition to a multi-wording support, support of the postfix
      *-opp-table naming scheme is added to the updated pattern.

 Documentation/devicetree/bindings/opp/opp-v2-base.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/opp/opp-v2-base.yaml b/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
index ae3ae4d39843..f79343960539 100644
--- a/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
+++ b/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
@@ -33,7 +33,7 @@ properties:
     type: boolean
 
 patternProperties:
-  '^opp-?[0-9]+$':
+  '^opp(-[0-9]+)*$':
     type: object
     description:
       One or more OPP nodes describing voltage-current-frequency combinations.
-- 
2.33.1


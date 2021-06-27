Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 328233B55EF
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jun 2021 01:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbhF0Xt5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 27 Jun 2021 19:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbhF0Xt5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 27 Jun 2021 19:49:57 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81791C061574
        for <linux-pm@vger.kernel.org>; Sun, 27 Jun 2021 16:47:32 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id a16so22568344ljq.3
        for <linux-pm@vger.kernel.org>; Sun, 27 Jun 2021 16:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7a1C3uQS+jx46SRoQWLs/UbnX/sjfDf/csgTDG6Gjik=;
        b=PdOU3SWkOLHxKuMbrYLVlBiFCjRUYP7zx4VxN2udZTMDEaDdu+aoRmfnclC2k07icr
         UIJgL6Ws1B++mkghEinLWBLhxN2Uol+TqJuaDxVUEiFN3AWIiDubNPxwanYNG9QaijSD
         e5M8B7Npjn3dJw5IrBhA5/5QA+TmxyOWCy0LkzW2Uwdh0LWU35qCQiTsBcNE3xXP4n6X
         +QXlrBE7wrbxUwvHvw5sr0BqqA+OcDMTh9jDL6Zg8eZ28yT/sdvkj1iLqAee7OFt7c77
         DceEHJNaRgc9tuKDRp6lVGPuJbCdf7V91o5KCZ2TFxPjYbgIr8iIVNVXaLqczna78XP1
         Ehgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7a1C3uQS+jx46SRoQWLs/UbnX/sjfDf/csgTDG6Gjik=;
        b=VmHMf2WfSQxNOgFEMq6/qWF8M6F/qdkRFhjOANAmG7vcOeGl16omNOo5QvXPr06Fgm
         hYU/9G71NRZploGS7/qS7MTA2zr+TzDO8NVYfH8M/b60RUtzrHlHU7o9J/uW7UiHBD/z
         eSgyvVO4RnAATVo8MpUwhUNMk7C/9NLoAD+YzCGsNpjS3wVuCO2TnivKFG6Bdsw5NsJZ
         salZYtSBD0zuFX7OmIKeX4tp3bbAo/QJR796U+EUmXVXqWndKBEFrLgIpAf4n05FzuLG
         IZsNGspG7F5fM5KTBzPrYLFFL6aWa0bsNPe0MkZ+w8pEukKOWlKj8K3BWKOCbAgIiXTJ
         YyuQ==
X-Gm-Message-State: AOAM531PbdR/XVSAJ5mfJMAZ1ykCiCMJzAGGTBtfCYw/VBHlHXR3SupY
        NC4GMsk8ZFYPMN7/IllGflv9UR3oUxWRbw==
X-Google-Smtp-Source: ABdhPJwSGG33GEykuxULqD+4WKY8hIqb1PNYyQ979r9Nesgwr5qHEdqc/Ukaj1nEGuvPsoxlTPt1OQ==
X-Received: by 2002:a2e:3310:: with SMTP id d16mr17815510ljc.494.1624837650828;
        Sun, 27 Jun 2021 16:47:30 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id l14sm1151890lfg.221.2021.06.27.16.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jun 2021 16:47:30 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 1/2] dt-bindings: power: Extend battery bindings with type
Date:   Mon, 28 Jun 2021 01:45:14 +0200
Message-Id: <20210627234515.3057935-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This adds a battery-type property and bindings for the different
"technologies" that are used in Linux. More types can be added.

This is needed to convert the custom ST-Ericsson AB8500 battery
properties over to the generic battery bindings.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
I need a bunch of new bindings for switch the STE AB8500 custom
bindings out, but I need to start somewhere, this is as good as
any place to start.
---
 .../devicetree/bindings/power/supply/battery.yaml  | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/battery.yaml b/Documentation/devicetree/bindings/power/supply/battery.yaml
index c3b4b7543591..3561ae2c1d58 100644
--- a/Documentation/devicetree/bindings/power/supply/battery.yaml
+++ b/Documentation/devicetree/bindings/power/supply/battery.yaml
@@ -31,6 +31,20 @@ properties:
   compatible:
     const: simple-battery
 
+  battery-type:
+    description: This describes the chemical technology of the battery.
+    oneOf:
+      - const: nickel-cadmium
+      - const: nickel-metal-hydride
+      - const: lithium-ion
+        description: This is a blanket type for all lithium-ion batteries,
+          including those below. If possible, a precise compatible string
+          from below should be used, but sometimes it is unknown which specific
+          lithium ion battery is employed and this wide compatible can be used.
+      - const: lithium-ion-polymer
+      - const: lithium-ion-iron-phosphate
+      - const: lithium-ion-manganese-oxide
+
   over-voltage-threshold-microvolt:
     description: battery over-voltage limit
 
-- 
2.31.1


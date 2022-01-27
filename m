Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 749C749EE7C
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jan 2022 00:08:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245606AbiA0XId (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Jan 2022 18:08:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343699AbiA0XIc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Jan 2022 18:08:32 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0533C061755
        for <linux-pm@vger.kernel.org>; Thu, 27 Jan 2022 15:08:30 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id c3so4214717pls.5
        for <linux-pm@vger.kernel.org>; Thu, 27 Jan 2022 15:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7h2TqwoqXaEMfjPzv9SF6ZGc4nNnV1XaxjSg49pOxCw=;
        b=DPUvXSj4gGoUi2PZpwiU9r2MGTNKqUgmF4dU8QpNs/blxOChn/Dp4X5P6uc34QaFaV
         DOvAxI8yXqbH/50nNHY73T7e0MH2ScJuvKPL2U+RdqfwtNhtdml4RTg/ip02fDK4yYwO
         +/wg5JzxvX29Bfht/wS7TUy2EGdWPpsb4iBTk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7h2TqwoqXaEMfjPzv9SF6ZGc4nNnV1XaxjSg49pOxCw=;
        b=V5wbX1Lld4bpQKmGAoH8kxZNDdQMkfj7UOogNdZTrhAliVAIzfUDqX3G1OUMcTpF4Q
         ObAul5AMUejkJgMrnEFZ+4l4RNMIjhEomZD1dTB3jgOfo/LdohkgzjVzuXdS20fsmtQv
         H1gerY1Bul0DsNruShkb7oY28z0Yb3hRieSChpcGaqu3LqpO5J5RitJm2VzKvnVVoJCP
         7VEb5xRiZTLl1NVN0OqU+p696X2fncs1AOsac337nueRDULC5JNwKRR+O7jlXilRWIt3
         POIUsJnFUI43xYXazUswvRm2lWt5VllDlkg8Qzb/zHKeMWDaDeEAyJetOPFVWfhKkYp1
         Lifw==
X-Gm-Message-State: AOAM530dtnkft/ddR5cCbqvUSyPFhAHkNG/jaJJa3n3cZfV4LR57HoX8
        aAFPPtFiKNFyVbnGE8nMOaRQ9Q==
X-Google-Smtp-Source: ABdhPJwF8ZK0wYylhQqNtZ4M2mQnejXec2VevUUW76yQtWHtCIpE5oy0RcA49p/AmsG5dRO59F5mzg==
X-Received: by 2002:a17:90b:33c6:: with SMTP id lk6mr6586908pjb.213.1643324910342;
        Thu, 27 Jan 2022 15:08:30 -0800 (PST)
Received: from localhost ([2620:15c:202:201:723d:38a9:9e7f:3435])
        by smtp.gmail.com with UTF8SMTPSA id h6sm6933258pfc.35.2022.01.27.15.08.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 15:08:29 -0800 (PST)
From:   Brian Norris <briannorris@chromium.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Lin Huang <hl@rock-chips.com>,
        linux-arm-kernel@lists.infradead.org,
        Derek Basehore <dbasehore@chromium.org>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH v2 03/15] dt-bindings: devfreq: rk3399_dmc: Fix Hz units
Date:   Thu, 27 Jan 2022 15:07:14 -0800
Message-Id: <20220127150615.v2.3.I9341269171c114d0e04e41d48037fd32816e2d8c@changeid>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
In-Reply-To: <20220127230727.3369358-1-briannorris@chromium.org>
References: <20220127230727.3369358-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The driver and all downstream device trees [1] are using Hz units, but
the document claims MHz. DRAM frequency for these systems can't possibly
exceed 2^32-1 Hz, so the choice of unit doesn't really matter than much.

Rather than add unnecessary risk in getting the units wrong, let's just
go with the unofficial convention and make the docs match reality.

A sub-1MHz frequency is extremely unlikely, so include a minimum in the
schema, to help catch anybody who might have believed this was MHz.

[1] And notably, also those trying to upstream them:
https://lore.kernel.org/lkml/20210308233858.24741-3-daniel.lezcano@linaro.org/

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

(no changes since v1)

 .../bindings/devfreq/rk3399_dmc.yaml          | 24 +++++++++----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/devfreq/rk3399_dmc.yaml b/Documentation/devicetree/bindings/devfreq/rk3399_dmc.yaml
index fd62a8cd62d5..8bb778df92ae 100644
--- a/Documentation/devicetree/bindings/devfreq/rk3399_dmc.yaml
+++ b/Documentation/devicetree/bindings/devfreq/rk3399_dmc.yaml
@@ -116,11 +116,11 @@ properties:
 
   rockchip,ddr3_odt_dis_freq:
     $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 1000000  # In case anyone thought this was MHz.
     description:
       When the DRAM type is DDR3, this parameter defines the ODT disable
-      frequency in MHz (Mega Hz). When the DDR frequency is less then
-      ddr3_odt_dis_freq, the ODT on the DRAM side and controller side are both
-      disabled.
+      frequency in Hz. When the DDR frequency is less then ddr3_odt_dis_freq,
+      the ODT on the DRAM side and controller side are both disabled.
 
   rockchip,ddr3_drv:
     deprecated: true
@@ -160,11 +160,11 @@ properties:
 
   rockchip,lpddr3_odt_dis_freq:
     $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 1000000  # In case anyone thought this was MHz.
     description:
       When the DRAM type is LPDDR3, this parameter defines then ODT disable
-      frequency in MHz (Mega Hz). When DDR frequency is less then
-      ddr3_odt_dis_freq, the ODT on the DRAM side and controller side are both
-      disabled.
+      frequency in Hz. When DDR frequency is less then ddr3_odt_dis_freq, the
+      ODT on the DRAM side and controller side are both disabled.
 
   rockchip,lpddr3_drv:
     deprecated: true
@@ -204,11 +204,11 @@ properties:
 
   rockchip,lpddr4_odt_dis_freq:
     $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 1000000  # In case anyone thought this was MHz.
     description:
       When the DRAM type is LPDDR4, this parameter defines the ODT disable
-      frequency in MHz (Mega Hz). When the DDR frequency is less then
-      ddr3_odt_dis_freq, the ODT on the DRAM side and controller side are both
-      disabled.
+      frequency in Hz. When the DDR frequency is less then ddr3_odt_dis_freq,
+      the ODT on the DRAM side and controller side are both disabled.
 
   rockchip,lpddr4_drv:
     deprecated: true
@@ -287,7 +287,7 @@ examples:
       rockchip,sr_mc_gate_idle = <0x3>;
       rockchip,srpd_lite_idle = <0x4>;
       rockchip,standby_idle = <0x2000>;
-      rockchip,ddr3_odt_dis_freq = <333>;
-      rockchip,lpddr3_odt_dis_freq = <333>;
-      rockchip,lpddr4_odt_dis_freq = <333>;
+      rockchip,ddr3_odt_dis_freq = <333000000>;
+      rockchip,lpddr3_odt_dis_freq = <333000000>;
+      rockchip,lpddr4_odt_dis_freq = <333000000>;
     };
-- 
2.35.0.rc0.227.g00780c9af4-goog


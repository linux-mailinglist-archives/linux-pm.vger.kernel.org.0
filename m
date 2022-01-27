Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4948549EE80
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jan 2022 00:08:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343731AbiA0XIf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Jan 2022 18:08:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343769AbiA0XIe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Jan 2022 18:08:34 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88DDCC061747
        for <linux-pm@vger.kernel.org>; Thu, 27 Jan 2022 15:08:34 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id my12-20020a17090b4c8c00b001b528ba1cd7so4758169pjb.1
        for <linux-pm@vger.kernel.org>; Thu, 27 Jan 2022 15:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PIXY+sEGqfziH4n+3nglkYpU71hUD2jbkDapelJUYx4=;
        b=VHdpreI16umQb0mYgJNYwcpXLMOYb9t5rWTJ5lF4m9dkAlOLQJbt8IUssF2/vzGhhu
         P2J4/IhQS1aBIC7OrTZ1rtXRz+BfKAgWlbPsQXOeqn/lbT032Hn/Q9FuFAS2EqI91NEL
         qkeLOxEtvhwyVPeocb+jYET3MYH1WQ8LLra/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PIXY+sEGqfziH4n+3nglkYpU71hUD2jbkDapelJUYx4=;
        b=kzNmvEYvU37CR1X4DlaLn4EiIVHRbhkMlVPCYZq6loYCsiVRORRSbmj3S8jz1UedaA
         tcXkoG7ITc1czNO4EQ8l6etOecejNgOcaVm6j0N9C8z3ME10sAe7RciCNGEg0tHduVx7
         7oAdAVt/NsOeEos7gKnki8r7t9WOqEqav7XmBECUFukpPScKY0mHSgv4XImopBDkxqS4
         1Gelf3uRGLqCubZxGOFuE2TBbnYwGEW5CxA3bAZ+EfuNo9l+ajuluDWs8cqIFj4Psaox
         vEAKzIDsjWIWtaQX532O8CAAT6XfRVCdz6d1l7BryFMODQ+eu+LEFOoQ9v9VBDfHf3b/
         oHbg==
X-Gm-Message-State: AOAM531sopcX3eKAK2kvKhFl8zZz/T0ey7n+aan3VBoCkbk+MDPCbIwi
        UlJNGK6O1545x2yxnMQwiXn3RQ==
X-Google-Smtp-Source: ABdhPJyOEdExuVH8zC2uGNPOjViFehIsUDjflPA1+PxmuS5k/khzsp0p8n9ZntEMyywxRWObRePXqQ==
X-Received: by 2002:a17:90b:1983:: with SMTP id mv3mr6659930pjb.222.1643324914114;
        Thu, 27 Jan 2022 15:08:34 -0800 (PST)
Received: from localhost ([2620:15c:202:201:723d:38a9:9e7f:3435])
        by smtp.gmail.com with UTF8SMTPSA id h10sm4000716pfv.31.2022.01.27.15.08.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 15:08:33 -0800 (PST)
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
Subject: [PATCH v2 05/15] dt-bindings: devfreq: rk3399_dmc: Add more disable-freq properties
Date:   Thu, 27 Jan 2022 15:07:16 -0800
Message-Id: <20220127150615.v2.5.I382d4de737198ea52deb118c9bdc4d93d76e009e@changeid>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
In-Reply-To: <20220127230727.3369358-1-briannorris@chromium.org>
References: <20220127230727.3369358-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

DDR DVFS tuning has found that several power-saving features don't have
good tradeoffs at higher frequencies -- at higher frequencies, we'll see
glitches or other errors. Provide tuning controls so these can be
disabled at higher OPPs, and left active only at the lower ones.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

Changes in v2:
 - hyphens, not underscores
 - *-hz units, and drop the types definition

 .../bindings/devfreq/rk3399_dmc.yaml          | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/Documentation/devicetree/bindings/devfreq/rk3399_dmc.yaml b/Documentation/devicetree/bindings/devfreq/rk3399_dmc.yaml
index 8786b7fa9b28..afa058c52c0b 100644
--- a/Documentation/devicetree/bindings/devfreq/rk3399_dmc.yaml
+++ b/Documentation/devicetree/bindings/devfreq/rk3399_dmc.yaml
@@ -299,6 +299,38 @@ properties:
       self-refresh mode. The controller, pi, PHY and DRAM clock will be gated
       if bus is idle for standby_idle nanoseconds.
 
+  rockchip,pd-idle-dis-freq-hz:
+    description:
+      Defines the power-down idle disable frequency in Hz. When the DDR
+      frequency is greater than pd-idle-dis-freq, power-down idle is disabled.
+      See also rockchip,pd-idle-ns.
+
+  rockchip,sr-idle-dis-freq-hz:
+    description:
+      Defines the self-refresh idle disable frequency in Hz. When the DDR
+      frequency is greater than sr-idle-dis-freq, self-refresh idle is
+      disabled. See also rockchip,sr-idle-ns.
+
+  rockchip,sr-mc-gate-idle-dis-freq-hz:
+    description:
+      Defines the self-refresh and memory-controller clock gating disable
+      frequency in Hz. When the DDR frequency is greater than
+      sr-mc-gate-idle-dis-freq, the clock will not be gated when idle. See also
+      rockchip,sr-mc-gate-idle-ns.
+
+  rockchip,srpd-lite-idle-dis-freq-hz:
+    description:
+      Defines the self-refresh power down idle disable frequency in Hz. When
+      the DDR frequency is greater than srpd-lite-idle-dis-freq, memory will
+      not be placed into self-refresh power down mode when idle. See also
+      rockchip,srpd-lite-idle-ns.
+
+  rockchip,standby-idle-dis-freq-hz:
+    description:
+      Defines the standby idle disable frequency in Hz. When the DDR frequency
+      is greater than standby-idle-dis-freq, standby idle is disabled. See also
+      rockchip,standby-idle-ns.
+
 required:
   - compatible
   - devfreq-events
@@ -330,4 +362,9 @@ examples:
       rockchip,ddr3_odt_dis_freq = <333000000>;
       rockchip,lpddr3_odt_dis_freq = <333000000>;
       rockchip,lpddr4_odt_dis_freq = <333000000>;
+      rockchip,pd-idle-dis-freq-hz = <1000000000>;
+      rockchip,sr-idle-dis-freq-hz = <1000000000>;
+      rockchip,sr-mc-gate-idle-dis-freq-hz = <1000000000>;
+      rockchip,srpd-lite-idle-dis-freq-hz = <0>;
+      rockchip,standby-idle-dis-freq-hz = <928000000>;
     };
-- 
2.35.0.rc0.227.g00780c9af4-goog


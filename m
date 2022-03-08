Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7104D0C88
	for <lists+linux-pm@lfdr.de>; Tue,  8 Mar 2022 01:10:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344056AbiCHAL2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Mar 2022 19:11:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344031AbiCHALM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Mar 2022 19:11:12 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 635E9377F1
        for <linux-pm@vger.kernel.org>; Mon,  7 Mar 2022 16:10:16 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id e2so15507472pls.10
        for <linux-pm@vger.kernel.org>; Mon, 07 Mar 2022 16:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4MidqK8UFH0OO5PuGunb8WphemubCtQBPIxhc/BLNC4=;
        b=Y7MZ3dBBFqBsHVJw4LhSele0cERRtvLPdhqjvm/dbYuKac/ttY1X7dhkkWQ/tfVGl0
         tr7jWz/2apfy1mdwUM7wRiCrcE5/lHX/RNl0+Y4iWCR7Y7j0/7W/RELbflk4b1yVvoVZ
         zjgTnxNRlNWVX3HyNdCEkxpAZRGe4F+pSxuHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4MidqK8UFH0OO5PuGunb8WphemubCtQBPIxhc/BLNC4=;
        b=6UTJiXR0C/Iohu3BoJ/IwAFXgzMBdcUBsibhC6dRC6dm+ATb98MnQG+7k1hhMUdvjh
         1GU6EII/6yr+QjOZW0mu5h+oFET50/oeBDMkrJiSss63GNBcLYUKYLNcyY8dbx9c7dnf
         kk0UFUoR6rXp2vHqSCJlD7tCb4pvLF6Tt/qudW2m7Ot7/MymHNL8J8ylzhaS1rsNNMy0
         vYIgL9gGcNmQLVWyQinn3+edD+TzAPsUA5rW7l3P3iMlL/lfYoHMhQWV7HBeeqXnviw3
         gw2izgWTFXtsCFaKZbvGdlDfzi9QFVrsdm0J6RFv14TOGxTkkaLfKv1/uyMHz+751RE9
         9QUA==
X-Gm-Message-State: AOAM530Cn0R2wDiQOqJXEpUNRaZtNwNuoDJfFoLVzsYNlR9THLrN7pPP
        OM8IzfXCDBbJpvxJGE6ejBACKQ==
X-Google-Smtp-Source: ABdhPJxEvIqD1klp8jx5ozBpuURKAe+1fn2tbuJrsH1G/PMoec47nH+zhYizJ5ADadhdFnqLvm92UA==
X-Received: by 2002:a17:90a:bf86:b0:1bd:6057:b77c with SMTP id d6-20020a17090abf8600b001bd6057b77cmr1688428pjs.72.1646698215650;
        Mon, 07 Mar 2022 16:10:15 -0800 (PST)
Received: from localhost ([2620:15c:202:201:e551:44dc:2842:57f1])
        by smtp.gmail.com with UTF8SMTPSA id h6-20020a636c06000000b00363a2533b17sm12943047pgc.8.2022.03.07.16.10.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 16:10:15 -0800 (PST)
From:   Brian Norris <briannorris@chromium.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Lin Huang <hl@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
        Derek Basehore <dbasehore@chromium.org>,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Brian Norris <briannorris@chromium.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 05/15] dt-bindings: devfreq: rk3399_dmc: Add more disable-freq properties
Date:   Mon,  7 Mar 2022 16:09:35 -0800
Message-Id: <20220307160918.v3.5.I382d4de737198ea52deb118c9bdc4d93d76e009e@changeid>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
In-Reply-To: <20220308000945.706701-1-briannorris@chromium.org>
References: <20220308000945.706701-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

DDR DVFS tuning has found that several power-saving features don't have
good tradeoffs at higher frequencies -- at higher frequencies, we'll see
glitches or other errors. Provide tuning controls so these can be
disabled at higher OPPs, and left active only at the lower ones.

Signed-off-by: Brian Norris <briannorris@chromium.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---

Changes in v3:
 * Add Reviewed-by

Changes in v2:
 * hyphens, not underscores
 * *-hz units, and drop the types definition

 .../bindings/devfreq/rk3399_dmc.yaml          | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/Documentation/devicetree/bindings/devfreq/rk3399_dmc.yaml b/Documentation/devicetree/bindings/devfreq/rk3399_dmc.yaml
index 6a33a7b44741..60ed5023f54f 100644
--- a/Documentation/devicetree/bindings/devfreq/rk3399_dmc.yaml
+++ b/Documentation/devicetree/bindings/devfreq/rk3399_dmc.yaml
@@ -300,6 +300,38 @@ properties:
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
@@ -331,4 +363,9 @@ examples:
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
2.35.1.616.g0bdcbb4464-goog


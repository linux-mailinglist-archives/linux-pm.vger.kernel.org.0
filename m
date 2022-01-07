Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10F1D487FB0
	for <lists+linux-pm@lfdr.de>; Sat,  8 Jan 2022 00:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbiAGXxr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 Jan 2022 18:53:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231937AbiAGXxn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Jan 2022 18:53:43 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A78CC061751
        for <linux-pm@vger.kernel.org>; Fri,  7 Jan 2022 15:53:38 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id w7so6177619plp.13
        for <linux-pm@vger.kernel.org>; Fri, 07 Jan 2022 15:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uqA2vTRTwCd5lb+1bpw59I8A4YOj+PxA4CFZWdTkSiE=;
        b=KjQjjOwC8d4WeVLXIzAl5ZiDLmf1td57rlGuw1GCTyOix4NbWz87jaIU3GPeaHkhs2
         +aKtbG6eMTbXncBI8DqE362s9f/7hyyLlEFnDyCIssQVbVjfuNX3Ig4LPvwuuJx9CHy3
         4H3ahd/fdtvy4tK0RwPpQ0oebhP89pSmGlBC0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uqA2vTRTwCd5lb+1bpw59I8A4YOj+PxA4CFZWdTkSiE=;
        b=hLXSGOpu49c8cAwQILtjWaw769yQPjEMaAb/i6JBAQGCnuWN5vbpj8UAPk75jP0p6U
         nSvrl0+/eu2hMwHxmt3tELWlkWPfOgaZmLZpeAnG1THcvxxXc70bnUwjMIg0pw5R4JT/
         n9m19wTfeoMi/VEInAcHrRYhgUn16KqkeU67BpNPGnNNnxlsYWNOulC2cHY4yHiWLG8z
         6aQq2v41xjnu3838c6j7ovTXVQ6YkJLkHd2+knGkXbK7m4DbJHS8QDDDEKNwLGzHKnd0
         OafM8VPlrdaqb/mcHPXvsBCi3tvCEm0kiTmnpboNEpnw57X3O+s2C4pZoiVArg8EQ10F
         QU3A==
X-Gm-Message-State: AOAM53047Isa8TcTvYxFLao/U2mQhmIF/8hWMOsSfSFNSNl9Z+d6HGiW
        yVs0tYT2K0nsmHPSJy41H87q8Q==
X-Google-Smtp-Source: ABdhPJwIGLUJ4870oxOMvvNEBPUvoGuIBVIO34djfW+MF+nHRtQ6skGcluLNSZvfeaLmcwPvyDn+Tw==
X-Received: by 2002:a17:90a:df04:: with SMTP id gp4mr2131418pjb.148.1641599617740;
        Fri, 07 Jan 2022 15:53:37 -0800 (PST)
Received: from localhost ([2620:15c:202:201:db:1c60:693f:c24e])
        by smtp.gmail.com with UTF8SMTPSA id h19sm57446pfh.30.2022.01.07.15.53.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jan 2022 15:53:37 -0800 (PST)
From:   Brian Norris <briannorris@chromium.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        Lin Huang <hl@rock-chips.com>, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org,
        Derek Basehore <dbasehore@chromium.org>,
        linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH 04/10] dt-bindings: devfreq: rk3399_dmc: Add more disable-freq properties
Date:   Fri,  7 Jan 2022 15:53:14 -0800
Message-Id: <20220107155215.4.I382d4de737198ea52deb118c9bdc4d93d76e009e@changeid>
X-Mailer: git-send-email 2.34.1.575.g55b058a8bb-goog
In-Reply-To: <20220107235320.965497-1-briannorris@chromium.org>
References: <20220107235320.965497-1-briannorris@chromium.org>
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

 .../bindings/devfreq/rk3399_dmc.yaml          | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/Documentation/devicetree/bindings/devfreq/rk3399_dmc.yaml b/Documentation/devicetree/bindings/devfreq/rk3399_dmc.yaml
index 2c871c57fd97..357d07c5a3df 100644
--- a/Documentation/devicetree/bindings/devfreq/rk3399_dmc.yaml
+++ b/Documentation/devicetree/bindings/devfreq/rk3399_dmc.yaml
@@ -271,6 +271,43 @@ properties:
       When the DRAM type is LPDDR4, this parameter defines the PHY side ODT
       strength. Default value is 60.
 
+  rockchip,pd_idle_dis_freq:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Defines the power-down idle disable frequency in Hz. When the DDR
+      frequency is greater than pd_idle_dis_freq, power-down idle is disabled.
+      See also rockchip,pd_idle.
+
+  rockchip,sr_idle_dis_freq:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Defines the self-refresh idle disable frequency in Hz. When the DDR
+      frequency is greater than sr_idle_dis_freq, self-refresh idle is
+      disabled. See also rockchip,sr_idle.
+
+  rockchip,sr_mc_gate_idle_dis_freq:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Defines the self-refresh and memory-controller clock gating disable
+      frequency in Hz. When the DDR frequency is greater than
+      sr_mc_gate_idle_dis_freq, the clock will not be gated when idle. See also
+      rockchip,sr_mc_gate_idle.
+
+  rockchip,srpd_lite_idle_dis_freq:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Defines the self-refresh power down idle disable frequency in Hz. When
+      the DDR frequency is greater than srpd_lite_idle_dis_freq, memory will
+      not be placed into self-refresh power down mode when idle. See also
+      rockchip,srpd_lite_idle.
+
+  rockchip,standby_idle_dis_freq:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Defines the standby idle disable frequency in Hz. When the DDR frequency
+      is greater than standby_idle_dis_freq, standby idle is disabled. See also
+      rockchip,standby_idle.
+
 additionalProperties: false
 
 examples:
@@ -294,4 +331,9 @@ examples:
       rockchip,ddr3_odt_dis_freq = <333000000>;
       rockchip,lpddr3_odt_dis_freq = <333000000>;
       rockchip,lpddr4_odt_dis_freq = <333000000>;
+      rockchip,pd_idle_dis_freq = <1000000000>;
+      rockchip,sr_idle_dis_freq = <1000000000>;
+      rockchip,sr_mc_gate_idle_dis_freq = <1000000000>;
+      rockchip,srpd_lite_idle_dis_freq = <0>;
+      rockchip,standby_idle_dis_freq = <928000000>;
     };
-- 
2.34.1.575.g55b058a8bb-goog


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB88027A196
	for <lists+linux-pm@lfdr.de>; Sun, 27 Sep 2020 17:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgI0PKH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 27 Sep 2020 11:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgI0PKG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 27 Sep 2020 11:10:06 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A7AC0613CE;
        Sun, 27 Sep 2020 08:10:06 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id c18so8952334wrm.9;
        Sun, 27 Sep 2020 08:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HMVabqNDpRm5jRigfMy/HSkt9g7XhYmIwimrxhJfJvQ=;
        b=TkxGGsf7AhHgvKTOqLLuyHlNnTMX2xsgmCsz/B9oj1CwPeXjoiiRr54Eliz/xjBGQe
         thAXINErMhrAsr5bnQ+9vk6x5Fi5LxcVQ7WjKqGO8W50PUPSNKxamHVOy/9C8t2NL0wK
         2sqJuxtIttZiX4H4PYH1w+l4em8+ojMhveJ60X9CYPhmd7l8jJmLbmtdPNc1rFUdjdPe
         jJ+W0ZkttAeoxtfKVq9N4v1gavDjWBHmlPqiUILfGhfZzbVjsCUFSTMo1UAkLfq7aRzJ
         qgGZo9zN+He2YChmM0ZVDlavX/49LQ9G4V7jQFfW+9YRPDnFnOMO9V+I2tJM0UtpVLmG
         tkRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HMVabqNDpRm5jRigfMy/HSkt9g7XhYmIwimrxhJfJvQ=;
        b=OirNBsN7sP9MEPY1z2JwCB0EDzIeZWHdsq9yKjUBu+nUXLscGVcT7UvLSEhO7mVCOG
         QOVuBDkJU+wqPJ318P36lal3S1Ka7Yo5fWaLoRgB1ZttFy9YKDEtixVRwQRm5nuAE1Ji
         /LnzlCHzHdCJUsXoPsgKq3u46E7+gAH0Yvo1499v8F50Gk8M0ED93QkLcYSfTLlsXnYH
         lLHvRJUEihLv9wLtntoHr+oQHsdh3CMr2wo4GtmA0eod4Y7HmWosu2mSDTOgyZaIueg+
         1l1vSj2tNGAKGFS6IaudIGHnaDxeeQMzmDWKbVmvHDTv8W36T0ecB4vgqOU7Lmd/Oahf
         zhOA==
X-Gm-Message-State: AOAM530mofMQ3LaCMtGTZXHt+xBdXMwd+woug3U1XRk8r5Oe3A27LTIJ
        mDTEG29K/x7mMp2XqtjJpmD6STRIB7wtGe3J
X-Google-Smtp-Source: ABdhPJxXQkXpfAdTjoBbm1Eq3yFMek1ks+tD8lDdfcrvNKaiExSLVktaf+NLI5Ru87arAicswKdzMQ==
X-Received: by 2002:a5d:4811:: with SMTP id l17mr14832728wrq.252.1601219405330;
        Sun, 27 Sep 2020 08:10:05 -0700 (PDT)
Received: from arrakis.kwizart.net (lfbn-nic-1-212-171.w2-15.abo.wanadoo.fr. [2.15.59.171])
        by smtp.gmail.com with ESMTPSA id s11sm9565114wrt.43.2020.09.27.08.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2020 08:10:04 -0700 (PDT)
From:   Nicolas Chauvet <kwizart@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        Nicolas Chauvet <kwizart@gmail.com>
Subject: [PATCH v2 4/6] arm64: tegra: Add missing gpu-throt-level to tegra210 soctherm
Date:   Sun, 27 Sep 2020 17:09:54 +0200
Message-Id: <20200927150956.34609-5-kwizart@gmail.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200927150956.34609-1-kwizart@gmail.com>
References: <20200927150956.34609-1-kwizart@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On jetson-tx1 the following message can be seen:
 tegra_soctherm 700e2000.thermal-sensor: throttle-cfg: heavy: no throt prop or invalid prop

This patch will fix the invalid prop issue according to the binding.

Signed-off-by: Nicolas Chauvet <kwizart@gmail.com>
---
 arch/arm64/boot/dts/nvidia/tegra210.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210.dtsi b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
index 8cca2166a446..c518292ee3f5 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
@@ -1582,6 +1582,7 @@ throttle-cfgs {
 			throttle_heavy: heavy {
 				nvidia,priority = <100>;
 				nvidia,cpu-throt-percent = <85>;
+				nvidia,gpu-throt-level = <TEGRA_SOCTHERM_THROT_LEVEL_HIGH>;
 
 				#cooling-cells = <2>;
 			};
-- 
2.25.4


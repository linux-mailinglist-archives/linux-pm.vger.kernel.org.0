Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8784A27A190
	for <lists+linux-pm@lfdr.de>; Sun, 27 Sep 2020 17:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbgI0PKE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 27 Sep 2020 11:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgI0PKE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 27 Sep 2020 11:10:04 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB30C0613CE;
        Sun, 27 Sep 2020 08:10:03 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id k18so4077478wmj.5;
        Sun, 27 Sep 2020 08:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nQZJ7yPVXRTTpaaOFiG+mf5v7oE6uXQPB9nQE0+9z00=;
        b=bG0X42Fc4mVAg6I/1UJJ2q1ckTY+2hVIt3dTvMuA1PizsJxAyfWnoFJUAYQV97kovW
         TXILlzAitdEY1HmgWs0dVhHkYPrfxPNYd9c4E8YN+Akzpa+G3lkCBCl6xE8nq7mCAhrr
         vCHOKGPbWQA2zvZwZhBTd6tPqIVI2kBkuPsr0t+SbQiT4gC7zdVySXbxX5JWW5QbcLI2
         Ztkit3Job2jn+LeiHjcnGENUo20CAgxrHpdR4+D1TdtCVMzHKXGyxn735sgDHNSiNsu7
         CnnljxtFVgksHqnmDCR5r1waB8ScfmOpCd+fNyIWEsoqrxxXP5sDRLGwslMJhPG9BMKF
         RzuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nQZJ7yPVXRTTpaaOFiG+mf5v7oE6uXQPB9nQE0+9z00=;
        b=LvRjUoAn0X5u5iAi1oYhtPhEYFJVb5r7VMLvqMThG7jYu/lCMmbacNUYK3viwui0io
         iZtjbkiSqPrKypoAdCiWR4ZS9NoIyZnaEKChZ9eFiO4cio0EPjDcqHCmfRh+at9Wf3Y/
         dtnjBvYrpfUPNhujb0RTZb0re7qtO0hc8h+cw0lzBsuLQgk2WJSugd49YxyEb48ddx3C
         3bY1ABXmeLmvrI7yBE+Gn7s/LypZ0Lr5dSnffWQFM+KVwTFGtNcZxU3eY6qmpiL3IPYH
         puac2Ui8MNFGslbCN1nhEtsWaI/ye2ZwtNn5p6NlqPBn3grfzxSZ3knvY6DxIzc11aHK
         7B7g==
X-Gm-Message-State: AOAM532N9xXAN+b44TGcggZB19s+xDGMpujb80hvMFyC+nRR7sgPajCW
        eSzYJyetFyyzXRxRWB70N8izhF/Fx/0bqWhg
X-Google-Smtp-Source: ABdhPJzqnYAqqLAVnob8XTUEUo0SaxsaIT+JsjRper/5hhwPxpgpzqhKKaFgtytc9GGFxciICoYaEQ==
X-Received: by 2002:a1c:cc0a:: with SMTP id h10mr6970201wmb.80.1601219402359;
        Sun, 27 Sep 2020 08:10:02 -0700 (PDT)
Received: from arrakis.kwizart.net (lfbn-nic-1-212-171.w2-15.abo.wanadoo.fr. [2.15.59.171])
        by smtp.gmail.com with ESMTPSA id s11sm9565114wrt.43.2020.09.27.08.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2020 08:10:01 -0700 (PDT)
From:   Nicolas Chauvet <kwizart@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        Nicolas Chauvet <kwizart@gmail.com>
Subject: [PATCH v2 1/6] ARM: tegra: Add missing gpu-throt-level to tegra124 soctherm
Date:   Sun, 27 Sep 2020 17:09:51 +0200
Message-Id: <20200927150956.34609-2-kwizart@gmail.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200927150956.34609-1-kwizart@gmail.com>
References: <20200927150956.34609-1-kwizart@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On jetson-tk1 the following message can be seen:
 tegra_soctherm 700e2000.thermal-sensor: throttle-cfg: heavy: no throt prop or invalid prop

This patch will fix the invalid prop issue according to the binding.

Signed-off-by: Nicolas Chauvet <kwizart@gmail.com>
---
 arch/arm/boot/dts/tegra124.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi
index 64f488ba1e72..a0fa5821a232 100644
--- a/arch/arm/boot/dts/tegra124.dtsi
+++ b/arch/arm/boot/dts/tegra124.dtsi
@@ -910,6 +910,7 @@ throttle-cfgs {
 			throttle_heavy: heavy {
 				nvidia,priority = <100>;
 				nvidia,cpu-throt-percent = <85>;
+				nvidia,gpu-throt-level = <TEGRA_SOCTHERM_THROT_LEVEL_HIGH>;
 
 				#cooling-cells = <2>;
 			};
-- 
2.25.4


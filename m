Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0F982A6AF8
	for <lists+linux-pm@lfdr.de>; Wed,  4 Nov 2020 17:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731443AbgKDQtl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Nov 2020 11:49:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731437AbgKDQtl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Nov 2020 11:49:41 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711EDC0613D4;
        Wed,  4 Nov 2020 08:49:40 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id m16so23700301ljo.6;
        Wed, 04 Nov 2020 08:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XaJT1vjZMvf/X8YLSd9ZZ4MLx0gBpwx6yTJ1gBvJkXU=;
        b=o+PN+lFWYPC3q/5e+PBs4YIDTtISHaS7z8ihni+Qi3cmP7lxQEqiML6aqXk/WYwBSF
         /Fd3sH3BMXEPP62hwlW1yjjba6gaEliSe5J0Nw02lFmDlFyI76T/qnM1ekhX8jqEV8Fl
         5W/zRpZ9yupjboVSPuVKuPYD9L1kPMD7uiLB1U48vllyTMVmj2X8HPYaXcPXBbA6LD0i
         mW9aBfOEn6F1F+Ik146ldnJKNxUhHlJ6Zbp60VjoXWKcGnZR+eaY6qQCrv8gK0rpwRWv
         cJUB5c4PMJ7mnxMqrTgO66ku7UAHcxcsIVaqqMk1rBGQmHEzgH8DBx62HCPzRcvDO2Nu
         Bd0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XaJT1vjZMvf/X8YLSd9ZZ4MLx0gBpwx6yTJ1gBvJkXU=;
        b=DnKtGon3NZESwiD6JO0JCLb/AuQIU8vgR4zFdbONLsTBPJgGVH3T538XTyUrGsB5Wa
         hsD1u0XORzHJxQYbYJwzDUizc8oYD3CbV1DrjtydOzxYT3gUkH1ZhRvtahiUP+XWQPIe
         a2LZ1nLc8nyLxHMMCvLBK0GD8eHNa8pQGofuM575scwgG0OV70shvEhinneqPRIbEE8n
         yHOnl8z4MXxmXGYU3/S5j0IC2qCvYgHVAgqlNN5HDAu6bku/00MPY6lPKGoqYmqriEJl
         xs9iOqyNM0IpnE1SggWR9ArQB/Yf1EUwH7DOMf3Z4v6V8IkrYcyi8oifDFTUqtQFU3BS
         +vmw==
X-Gm-Message-State: AOAM530au0/xl4Q0BjrHt2NVnRA/O4awoFlXl26FiGNKj82qj3p/RkDw
        3dtu8qWivPHMu46DcB5vxfw=
X-Google-Smtp-Source: ABdhPJxPzT4dfgMeZPtc8/pOQuOJNmNAEDQa7Z1ToMwzkGX4WNVnUqfiw9g6i3aNgPTyVvE0XlbEXA==
X-Received: by 2002:a2e:b1c6:: with SMTP id e6mr6983022lja.108.1604508578791;
        Wed, 04 Nov 2020 08:49:38 -0800 (PST)
Received: from localhost.localdomain (109-252-192-83.dynamic.spd-mgts.ru. [109.252.192.83])
        by smtp.gmail.com with ESMTPSA id m2sm454587lfo.25.2020.11.04.08.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 08:49:38 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v7 07/47] dt-bindings: memory: tegra20: emc: Document new interconnect property
Date:   Wed,  4 Nov 2020 19:48:43 +0300
Message-Id: <20201104164923.21238-8-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201104164923.21238-1-digetx@gmail.com>
References: <20201104164923.21238-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

External Memory Controller is interconnected with memory controller and
with external memory. Document new interconnect property which turns EMC
into interconnect provider.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../bindings/memory-controllers/nvidia,tegra20-emc.txt          | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.txt b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.txt
index 1b0d4417aad8..82bc5b2ae7e5 100644
--- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.txt
+++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.txt
@@ -13,6 +13,7 @@ Properties:
 - interrupts : Should contain EMC General interrupt.
 - clocks : Should contain EMC clock.
 - nvidia,memory-controller : Phandle of the Memory Controller node.
+- #interconnect-cells : Should be 0.
 
 Child device nodes describe the memory settings for different configurations and clock rates.
 
@@ -21,6 +22,7 @@ Example:
 	memory-controller@7000f400 {
 		#address-cells = < 1 >;
 		#size-cells = < 0 >;
+		#interconnect-cells = <0>;
 		compatible = "nvidia,tegra20-emc";
 		reg = <0x7000f400 0x400>;
 		interrupts = <0 78 0x04>;
-- 
2.27.0


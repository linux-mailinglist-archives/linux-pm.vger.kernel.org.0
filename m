Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4812F2A6AE0
	for <lists+linux-pm@lfdr.de>; Wed,  4 Nov 2020 17:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731821AbgKDQxM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Nov 2020 11:53:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731519AbgKDQty (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Nov 2020 11:49:54 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578F2C0613D3;
        Wed,  4 Nov 2020 08:49:54 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id l2so28079515lfk.0;
        Wed, 04 Nov 2020 08:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0Wup0jgVqkx9Z2UtrB2UQcATbTsL4I5PHiSg5IeKsK8=;
        b=l28eK///7thfjpdLXMWhiHHWDQvoZhEFc21hkIrW2nmkPIUnISNVVRI5Q5kttUvAbX
         HefPgitvaywJSbF6hjkjoFVpJ+2vLQ1/dFZZpb+bUt+Bd4DxzoTw2p8Pvp7REtz56vUg
         ZHVZ9iLdALzbjUUucAR9l9J4mD4IGqTTlPq5tydYJ76/GVhIfZOufiSYBwQZddQyZRYj
         wFlNveXYjeo+wcTWahXrWJxKYwnXBLjx0voygI6w+I9jYZCnW5VCNLXRbvFT2K06PAWJ
         fm3BMEPBOl8NH1mb3ry3IqtrsJjEFsAz9jQEW2dapu+g01OSIcXuz6T6tcfI9l3+G+ju
         OpdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0Wup0jgVqkx9Z2UtrB2UQcATbTsL4I5PHiSg5IeKsK8=;
        b=Edx1ekzz88sMMTdMKhb2GDEEa2qulL5GMCX79EcKLMB7t4QvlupgUtnK9Yzky9/FID
         d0I3uK0bCP1fuRAkk98cEkBhV6nL9gqKBjZXoNrx1cPUESzwepWCH8vLFokvE3oaLg6V
         cbhmRtZSw7hbELL8x4bzikUhc2HmKBEbddp8C/sNIn+KJu7O+O5ksioeHueGXN6WwZcl
         0R2FvVHL7zEQcijBuHfGHcae+/Xzg8c4m9TeB69p0wpKfRCYwpyc3U18gobQmrEu5Lnh
         h1V6alzEI8ZmBed3EnO8tACiB5qcizO9kXzY3+ZD35fTMqm5JgP8jL+oPRfkGGfCwZFP
         BMXQ==
X-Gm-Message-State: AOAM531C6u8ihrYmXmrPlqRZN9R75OyvuEEgZcV7GInCmfRGiYu0v3ft
        uvJDyuUFMRx4XUbaiXJfJTE=
X-Google-Smtp-Source: ABdhPJxEeFZ6vuDc7FfaiND2otyL3xiZBcK7Vgh1+tUpTMHt4Cy8mql9zhsl6OV8nvicmg7VAmJMHw==
X-Received: by 2002:a19:c8c6:: with SMTP id y189mr3343699lff.502.1604508592892;
        Wed, 04 Nov 2020 08:49:52 -0800 (PST)
Received: from localhost.localdomain (109-252-192-83.dynamic.spd-mgts.ru. [109.252.192.83])
        by smtp.gmail.com with ESMTPSA id m2sm454587lfo.25.2020.11.04.08.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 08:49:52 -0800 (PST)
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
Subject: [PATCH v7 19/47] dt-bindings: memory: tegra124: Add memory client IDs
Date:   Wed,  4 Nov 2020 19:48:55 +0300
Message-Id: <20201104164923.21238-20-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201104164923.21238-1-digetx@gmail.com>
References: <20201104164923.21238-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Each memory client has unique hardware ID, add these IDs.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 include/dt-bindings/memory/tegra124-mc.h | 68 ++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/include/dt-bindings/memory/tegra124-mc.h b/include/dt-bindings/memory/tegra124-mc.h
index 186e6b7e9b35..7e73bb400eca 100644
--- a/include/dt-bindings/memory/tegra124-mc.h
+++ b/include/dt-bindings/memory/tegra124-mc.h
@@ -54,4 +54,72 @@
 #define TEGRA124_MC_RESET_ISP2B		22
 #define TEGRA124_MC_RESET_GPU		23
 
+#define TEGRA124_MC_PTCR		0
+#define TEGRA124_MC_DISPLAY0A		1
+#define TEGRA124_MC_DISPLAY0AB		2
+#define TEGRA124_MC_DISPLAY0B		3
+#define TEGRA124_MC_DISPLAY0BB		4
+#define TEGRA124_MC_DISPLAY0C		5
+#define TEGRA124_MC_DISPLAY0CB		6
+#define TEGRA124_MC_AFIR		14
+#define TEGRA124_MC_AVPCARM7R		15
+#define TEGRA124_MC_DISPLAYHC		16
+#define TEGRA124_MC_DISPLAYHCB		17
+#define TEGRA124_MC_HDAR		21
+#define TEGRA124_MC_HOST1XDMAR		22
+#define TEGRA124_MC_HOST1XR		23
+#define TEGRA124_MC_MSENCSRD		28
+#define TEGRA124_MC_PPCSAHBDMAR		29
+#define TEGRA124_MC_PPCSAHBSLVR		30
+#define TEGRA124_MC_SATAR		31
+#define TEGRA124_MC_VDEBSEVR		34
+#define TEGRA124_MC_VDEMBER		35
+#define TEGRA124_MC_VDEMCER		36
+#define TEGRA124_MC_VDETPER		37
+#define TEGRA124_MC_MPCORELPR		38
+#define TEGRA124_MC_MPCORER		39
+#define TEGRA124_MC_MSENCSWR		43
+#define TEGRA124_MC_AFIW		49
+#define TEGRA124_MC_AVPCARM7W		50
+#define TEGRA124_MC_HDAW		53
+#define TEGRA124_MC_HOST1XW		54
+#define TEGRA124_MC_MPCORELPW		56
+#define TEGRA124_MC_MPCOREW		57
+#define TEGRA124_MC_PPCSAHBDMAW		59
+#define TEGRA124_MC_PPCSAHBSLVW		60
+#define TEGRA124_MC_SATAW		61
+#define TEGRA124_MC_VDEBSEVW		62
+#define TEGRA124_MC_VDEDBGW		63
+#define TEGRA124_MC_VDEMBEW		64
+#define TEGRA124_MC_VDETPMW		65
+#define TEGRA124_MC_ISPRA		68
+#define TEGRA124_MC_ISPWA		70
+#define TEGRA124_MC_ISPWB		71
+#define TEGRA124_MC_XUSB_HOSTR		74
+#define TEGRA124_MC_XUSB_HOSTW		75
+#define TEGRA124_MC_XUSB_DEVR		76
+#define TEGRA124_MC_XUSB_DEVW		77
+#define TEGRA124_MC_ISPRAB		78
+#define TEGRA124_MC_ISPWAB		80
+#define TEGRA124_MC_ISPWBB		81
+#define TEGRA124_MC_TSECSRD		84
+#define TEGRA124_MC_TSECSWR		85
+#define TEGRA124_MC_A9AVPSCR		86
+#define TEGRA124_MC_A9AVPSCW		87
+#define TEGRA124_MC_GPUSRD		88
+#define TEGRA124_MC_GPUSWR		89
+#define TEGRA124_MC_DISPLAYT		90
+#define TEGRA124_MC_SDMMCRA		96
+#define TEGRA124_MC_SDMMCRAA		97
+#define TEGRA124_MC_SDMMCR		98
+#define TEGRA124_MC_SDMMCRAB		99
+#define TEGRA124_MC_SDMMCWA		100
+#define TEGRA124_MC_SDMMCWAA		101
+#define TEGRA124_MC_SDMMCW		102
+#define TEGRA124_MC_SDMMCWAB		103
+#define TEGRA124_MC_VICSRD		108
+#define TEGRA124_MC_VICSWR		109
+#define TEGRA124_MC_VIW			114
+#define TEGRA124_MC_DISPLAYD		115
+
 #endif
-- 
2.27.0


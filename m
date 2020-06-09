Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 584721F3BE1
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jun 2020 15:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729332AbgFINRF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Jun 2020 09:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728500AbgFINO4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Jun 2020 09:14:56 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED0BC08C5C3;
        Tue,  9 Jun 2020 06:14:55 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id n24so24953621lji.10;
        Tue, 09 Jun 2020 06:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Aln/v5oHNx0uR1+3PdbEeFlof0TuksBXcZsr09IBv7Y=;
        b=f1i/e/fq+GUsu+SLmELnxg5S2fQRNDxo4c3CHgnS7jzmTEUkQ4VR+0/3WxPkOJ/jiR
         USM8+zSaZtsFhsKwEu7RV3zNuI/LcjxjafbHQnmIVWIQ9PPYaiwoe3UjBP9C7uhBbHFV
         gUuXPduSXCcnfILK3uKo5LjhNhJyEnq/5d2Z6rBbD37d32eNZ6kPNAuU4tGh9Vgf+KuX
         awGeIGssdX50Z5kPHh1ZgvdF3jgJQlhNkjhAAJIh/p6DgY0QQmbahJoBQX+b5jB5+5WB
         P6m5mqQsOeKg41Y4nHrvSXhHfGXvgXzvQfMyDubT9Hv85B7dARvLxdvIZv7REDO25Sct
         cMOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Aln/v5oHNx0uR1+3PdbEeFlof0TuksBXcZsr09IBv7Y=;
        b=hZvUwlEYRhg5QatowRsybvBUR766JY4Ld3lDK2e8DQnJN1yvIIivvcGvrCNF1j2cd6
         H4Fc4Q6nAY3uNk7l+RP2bickn8fHVAPnCGSsjq5hmEbj0ZD7hZ/GHIK7IphZfqnUWE9q
         T2rmyxNTJboGwFua7zRF+xot2UJaCcLugmvNpUtV4DLFgB+bU5R7xG5JovjUgsP/3/47
         hqzrs3RVc5vNwAFlYRhbIkWX9VlldxGzruw0/2ntFF/yiTZmydPiLBH+em0ix8ncUcbe
         nPgknk1u0XEo1cCzlrERPyjS6xVhOYUgtYNUVMzlEr8Gu/4rdq8eqnL29k94uY8/iECn
         JO4Q==
X-Gm-Message-State: AOAM533Kz2RrrV0JSvVvZQYgZAVwk7DIqvb6K/Gj7EoWQJ1HG5jH2v4j
        N4FVrH0KNgrugm4mNQVeDS4=
X-Google-Smtp-Source: ABdhPJwR5s0/K2rLHpYv3O8omNNYS0C0VEkRc98oW6G9hNru7vvY1eTuzIcA9R0pWenyOoUhFWPfAQ==
X-Received: by 2002:a2e:1412:: with SMTP id u18mr14378966ljd.309.1591708494412;
        Tue, 09 Jun 2020 06:14:54 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id l22sm4323522lji.120.2020.06.09.06.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 06:14:53 -0700 (PDT)
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
        Mikko Perttunen <cyndis@kapsi.fi>
Cc:     =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v4 24/37] dt-bindings: memory: tegra30: Add memory client IDs
Date:   Tue,  9 Jun 2020 16:13:51 +0300
Message-Id: <20200609131404.17523-25-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200609131404.17523-1-digetx@gmail.com>
References: <20200609131404.17523-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Each memory client have a unique hardware ID, this patch adds these IDs.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 include/dt-bindings/memory/tegra30-mc.h | 67 +++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/include/dt-bindings/memory/tegra30-mc.h b/include/dt-bindings/memory/tegra30-mc.h
index 169f005fbc78..930f708aca17 100644
--- a/include/dt-bindings/memory/tegra30-mc.h
+++ b/include/dt-bindings/memory/tegra30-mc.h
@@ -41,4 +41,71 @@
 #define TEGRA30_MC_RESET_VDE		16
 #define TEGRA30_MC_RESET_VI		17
 
+#define TEGRA30_MC_PTCR			0
+#define TEGRA30_MC_DISPLAY0A		1
+#define TEGRA30_MC_DISPLAY0AB		2
+#define TEGRA30_MC_DISPLAY0B		3
+#define TEGRA30_MC_DISPLAY0BB		4
+#define TEGRA30_MC_DISPLAY0C		5
+#define TEGRA30_MC_DISPLAY0CB		6
+#define TEGRA30_MC_DISPLAY1B		7
+#define TEGRA30_MC_DISPLAY1BB		8
+#define TEGRA30_MC_EPPUP		9
+#define TEGRA30_MC_G2PR			10
+#define TEGRA30_MC_G2SR			11
+#define TEGRA30_MC_MPEUNIFBR		12
+#define TEGRA30_MC_VIRUV		13
+#define TEGRA30_MC_AFIR			14
+#define TEGRA30_MC_AVPCARM7R		15
+#define TEGRA30_MC_DISPLAYHC		16
+#define TEGRA30_MC_DISPLAYHCB		17
+#define TEGRA30_MC_FDCDRD		18
+#define TEGRA30_MC_FDCDRD2		19
+#define TEGRA30_MC_G2DR			20
+#define TEGRA30_MC_HDAR			21
+#define TEGRA30_MC_HOST1XDMAR		22
+#define TEGRA30_MC_HOST1XR		23
+#define TEGRA30_MC_IDXSRD		24
+#define TEGRA30_MC_IDXSRD2		25
+#define TEGRA30_MC_MPE_IPRED		26
+#define TEGRA30_MC_MPEAMEMRD		27
+#define TEGRA30_MC_MPECSRD		28
+#define TEGRA30_MC_PPCSAHBDMAR		29
+#define TEGRA30_MC_PPCSAHBSLVR		30
+#define TEGRA30_MC_SATAR		31
+#define TEGRA30_MC_TEXSRD		32
+#define TEGRA30_MC_TEXSRD2		33
+#define TEGRA30_MC_VDEBSEVR		34
+#define TEGRA30_MC_VDEMBER		35
+#define TEGRA30_MC_VDEMCER		36
+#define TEGRA30_MC_VDETPER		37
+#define TEGRA30_MC_MPCORELPR		38
+#define TEGRA30_MC_MPCORER		39
+#define TEGRA30_MC_EPPU			40
+#define TEGRA30_MC_EPPV			41
+#define TEGRA30_MC_EPPY			42
+#define TEGRA30_MC_MPEUNIFBW		43
+#define TEGRA30_MC_VIWSB		44
+#define TEGRA30_MC_VIWU			45
+#define TEGRA30_MC_VIWV			46
+#define TEGRA30_MC_VIWY			47
+#define TEGRA30_MC_G2DW			48
+#define TEGRA30_MC_AFIW			49
+#define TEGRA30_MC_AVPCARM7W		50
+#define TEGRA30_MC_FDCDWR		51
+#define TEGRA30_MC_FDCDWR2		52
+#define TEGRA30_MC_HDAW			53
+#define TEGRA30_MC_HOST1XW		54
+#define TEGRA30_MC_ISPW			55
+#define TEGRA30_MC_MPCORELPW		56
+#define TEGRA30_MC_MPCOREW		57
+#define TEGRA30_MC_MPECSWR		58
+#define TEGRA30_MC_PPCSAHBDMAW		59
+#define TEGRA30_MC_PPCSAHBSLVW		60
+#define TEGRA30_MC_SATAW		61
+#define TEGRA30_MC_VDEBSEVW		62
+#define TEGRA30_MC_VDEDBGW		63
+#define TEGRA30_MC_VDEMBEW		64
+#define TEGRA30_MC_VDETPMW		65
+
 #endif
-- 
2.26.0


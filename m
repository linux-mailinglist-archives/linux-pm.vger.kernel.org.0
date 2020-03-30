Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9A2B1971D9
	for <lists+linux-pm@lfdr.de>; Mon, 30 Mar 2020 03:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbgC3BJp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 29 Mar 2020 21:09:45 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39039 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728201AbgC3BJo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 29 Mar 2020 21:09:44 -0400
Received: by mail-lj1-f194.google.com with SMTP id i20so16304593ljn.6;
        Sun, 29 Mar 2020 18:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PZPNrypYAJ0DVxGo/z3wAqcvtTxmsayiljwdnKM3VrQ=;
        b=c+DhtUuuMUJ0rR4YA7n4mv3Ohj94+u2O55W9TrqbxwN2tEnvjmKzSGsG/NECIL4tPT
         Czjqjem+O/r0pKA3h3XFnDh+qXsY7dd0dVR6hcMRYNEu/6UEJ5Ho879y6I3VQq9BnAzq
         h/fxU34j2ZrNnLsNL2Fgfb2Qk5xhklR4eIACoYc2W++TIZ+ldJrqFc2uQY8WnZEqANsb
         0/xULCchZQwJQpcPjntoWfznK6ijQhVLtg7t5hn4PwYDzl3nELgExhTHRIMQ8QhUUyqY
         YnlRhCRfpu8qtdvX3irMlx6PCQK9KQD4BkbndFtqIDLnjmu7EYGnIhNA3NFgpvdM8tjf
         8NkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PZPNrypYAJ0DVxGo/z3wAqcvtTxmsayiljwdnKM3VrQ=;
        b=e+MfA2wip2itAZh/0YVtSO+RzjkiOLUBQUMR0/X5yW8axOtwvUIssSJJSy3/6W3k94
         W/IN1rFbURT/FOnTCPX7uDT25C7yZHrR73nbdHfFLUxCU3ha6Y+dc3I+4KpD3gZwMYPf
         oqzMsbsLNBbQ99LXaciuPtRE9Z+OUditkB9ErIgdc/+OvJZIjSS8y844RDpF6Y8nhPAI
         h7Hv5pYJc/IaVT7Rmhcf+C1Nd9HHUT/YAh/5wB57qi3mAOG2fLkBaZyXr0MkDicFzNaL
         H7BHaxPuhYmk0ZwkL+G+v25cxBpsQkVf1f88PiS1G0lxIRb3O8XyCwN8xTTT/RdsjXQX
         0uAQ==
X-Gm-Message-State: AGi0PuaDWRINOiwSgg1vVkbdIs0e3zoBXOpKxSU6eoeBzIWCcM4p5bF6
        nxtREoiwAbs+kx+t0OLQTIU=
X-Google-Smtp-Source: APiQypL5WrohbBW5CsxmlK1Tm0Cj8PudLUhgCzjYqMhQc6gTXz5YtkrXjBmZxeb+upQypsi3mdjjRQ==
X-Received: by 2002:a2e:8911:: with SMTP id d17mr5816369lji.16.1585530581827;
        Sun, 29 Mar 2020 18:09:41 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.gmail.com with ESMTPSA id f23sm2449005lja.60.2020.03.29.18.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 18:09:40 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 07/22] dt-bindings: memory: tegra30: Add memory client IDs
Date:   Mon, 30 Mar 2020 04:08:49 +0300
Message-Id: <20200330010904.27643-8-digetx@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200330010904.27643-1-digetx@gmail.com>
References: <20200330010904.27643-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Each memory client have a unique hardware ID, this patch adds these IDs.

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
2.25.1


Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7774224423F
	for <lists+linux-pm@lfdr.de>; Fri, 14 Aug 2020 02:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbgHNAI4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Aug 2020 20:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbgHNAH3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Aug 2020 20:07:29 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5957EC061757;
        Thu, 13 Aug 2020 17:07:29 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id i19so3949207lfj.8;
        Thu, 13 Aug 2020 17:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Lr6InQs+cwUdZHYMsF5leEEXS/E4w6EG4rKFnYLtLUg=;
        b=P5vAfsU5bDceymZMHPRLpNYC8PErfXyHQGA58gro3wnk2be2eYECXTz48ireW5nv8r
         y/YX0fQkUVHcfDrksJY1YPGpkGZ+AV0OwEa75gS15UsTvXEkTUQWSoq4Bx5whwopJiME
         a/rPrrTN//9o8MdQelhayURhtjOhGKdFLejcKQndoL9b7ShKi7GopvPQlKv6ehiA6JtR
         FJLJ5gDGqIb/Yv4mvOt+m1xIpLNNLSN1qsVtP5jeFQmtucBWPly/cKQqjXZ1GdvPr6lb
         +x7bKOlAKJNTacfUhBrgyI3Y6bq0sE3/8GJA4aGPMdUO3MBupwgXSaipZhf7vLG+7BS1
         lE+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lr6InQs+cwUdZHYMsF5leEEXS/E4w6EG4rKFnYLtLUg=;
        b=r1beLzr1H3IN25H6E9DSxnqZVRFiGy7TBqN9PB490J9jrhZv8Mge5jysAYPaet53mj
         qrIspfPa6CC7/aBEPyE4BKZn8DQlueoTVrwsp/UygAvKHy47tdlBX3YsgGiJKAkpaFJZ
         +VuAK8wWEfYX4DXYZCA7asdmt+Rvz/8g4QQsrKRTOzPGoWRXjsDpMhPdMVKa3839XICM
         sRB+/LHWSHlZY9rC29uvkwpoq/NIAekJSfGr16/2yCNDSrHTz23Kd1GgMjSRykYtSMxe
         oXdDTTVQYT4Mz3RShb2BuGOPzWVyfVRIbju4SPHk7c0t70DMTY0kMDypkkrZjEuj4oWT
         Bk0A==
X-Gm-Message-State: AOAM5324KniSFcLSirMZNVgtvuwepE9LAW2jvCXZYEdCv4+SMb+nYDQs
        CR56yatgOBc6ARxWVZIQcxQ=
X-Google-Smtp-Source: ABdhPJx94RkIBlhneQSzkJctTu1N95bLFx03tsVwIAUkVQuLUcSXbwQEO8fbyIi3+go7v+AgWAwMaw==
X-Received: by 2002:a05:6512:74b:: with SMTP id c11mr3235370lfs.119.1597363647881;
        Thu, 13 Aug 2020 17:07:27 -0700 (PDT)
Received: from localhost.localdomain (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.gmail.com with ESMTPSA id c17sm1504450lfr.23.2020.08.13.17.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 17:07:27 -0700 (PDT)
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
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v5 24/36] dt-bindings: memory: tegra30: Add memory client IDs
Date:   Fri, 14 Aug 2020 03:06:09 +0300
Message-Id: <20200814000621.8415-25-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200814000621.8415-1-digetx@gmail.com>
References: <20200814000621.8415-1-digetx@gmail.com>
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
2.27.0


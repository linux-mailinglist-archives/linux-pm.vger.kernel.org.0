Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4BA31971E7
	for <lists+linux-pm@lfdr.de>; Mon, 30 Mar 2020 03:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbgC3BKy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 29 Mar 2020 21:10:54 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46474 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728162AbgC3BJm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 29 Mar 2020 21:09:42 -0400
Received: by mail-lj1-f194.google.com with SMTP id r7so8639692ljg.13;
        Sun, 29 Mar 2020 18:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M8DwevTofPw/pIdfp/6Cb1DGwp3gDQ5YLGJ2daY85MQ=;
        b=O6r9IkP9gT5mV1V+BtMChNkuEDA23g0XoMFPgKrfLC+yuksJd+kdDolL2UC22dmopL
         8dRNBCHi6LH8QW6N5NcbEtW4SDXNG/MExceo4TisUduBw64+BAVDGYmAAQdz3Be0LHCX
         mjfTEe6cl0PW4dxXnpcjbBZCxPoJKShkYTanh08JV583adSP2d0dDdfpep8wEeORsAM8
         3t2+4S53B48ZvhAP+LympPmE4r/XEcCcZWovbKkeLJ1edLnk05mFThwKS/geusT9gLtm
         joORZjx+6oCNPKX8VF+NcQNPo3CHNAbP4CcaX37k6Ib9ig2gzPMOUEQK+hmSWJfNDYnu
         A6Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M8DwevTofPw/pIdfp/6Cb1DGwp3gDQ5YLGJ2daY85MQ=;
        b=S8STf9i2RCuBseMepJdXP924tTBRYhgd7XXWFXofdOMVO29opKJlMfPVGRjgWTvmf3
         v4uKF8y7TVUEiBHAfgVx+mQ1TsnXHGmHmVEy1+kwnSTSKqrJklSuhZ9c7xUVeTM2JeIo
         QoJ5ivWe44GxIXyo6DZjcznwA2M+UTbjbPJtFuGwK2GjV4ZyzmkhJzBFJNzfXNe1m53e
         NGrgDWvA05E9g2n9yVSIvg3UoWf0R/2DZQ5/DWR5DcbuFn5GxY6CeO60MLRl7MZ3Bssz
         7aSqi+n80wWeOXYS7zh/JEYB++1CgiS/Ew2hqB2m0q1PSMNj3M/Kz2PU5F2CvdnIj3MO
         Wh5A==
X-Gm-Message-State: AGi0PuYgYsOAoshpAArNGCAkQY/iTqPT4Gfif1mtnt+1D6CuyEPK17rc
        bOXDQdyw8MA+2HqTQOEvsaI=
X-Google-Smtp-Source: APiQypLK4tHPYMPuq2cSaOwrtI4imEKVje/al1R0EOqTdKMfdRe0Dz8UxEc++EAv1R+FeNNvPSHdAg==
X-Received: by 2002:a2e:7401:: with SMTP id p1mr5574125ljc.279.1585530580279;
        Sun, 29 Mar 2020 18:09:40 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.gmail.com with ESMTPSA id f23sm2449005lja.60.2020.03.29.18.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 18:09:39 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 06/22] dt-bindings: memory: tegra20: Add memory client IDs
Date:   Mon, 30 Mar 2020 04:08:48 +0300
Message-Id: <20200330010904.27643-7-digetx@gmail.com>
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
 include/dt-bindings/memory/tegra20-mc.h | 53 +++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/include/dt-bindings/memory/tegra20-mc.h b/include/dt-bindings/memory/tegra20-mc.h
index 35e131eee198..6f8829508ad0 100644
--- a/include/dt-bindings/memory/tegra20-mc.h
+++ b/include/dt-bindings/memory/tegra20-mc.h
@@ -18,4 +18,57 @@
 #define TEGRA20_MC_RESET_VDE		13
 #define TEGRA20_MC_RESET_VI		14
 
+#define TEGRA20_MC_DISPLAY0A		0
+#define TEGRA20_MC_DISPLAY0AB		1
+#define TEGRA20_MC_DISPLAY0B		2
+#define TEGRA20_MC_DISPLAY0BB		3
+#define TEGRA20_MC_DISPLAY0C		4
+#define TEGRA20_MC_DISPLAY0CB		5
+#define TEGRA20_MC_DISPLAY1B		6
+#define TEGRA20_MC_DISPLAY1BB		7
+#define TEGRA20_MC_EPPUP		8
+#define TEGRA20_MC_G2PR			9
+#define TEGRA20_MC_G2SR			10
+#define TEGRA20_MC_MPEUNIFBR		11
+#define TEGRA20_MC_VIRUV		12
+#define TEGRA20_MC_AVPCARM7R		13
+#define TEGRA20_MC_DISPLAYHC		14
+#define TEGRA20_MC_DISPLAYHCB		15
+#define TEGRA20_MC_FDCDRD		16
+#define TEGRA20_MC_G2DR			17
+#define TEGRA20_MC_HOST1XDMAR		18
+#define TEGRA20_MC_HOST1XR		19
+#define TEGRA20_MC_IDXSRD		20
+#define TEGRA20_MC_MPCORER		21
+#define TEGRA20_MC_MPE_IPRED		22
+#define TEGRA20_MC_MPEAMEMRD		23
+#define TEGRA20_MC_MPECSRD		24
+#define TEGRA20_MC_PPCSAHBDMAR		25
+#define TEGRA20_MC_PPCSAHBSLVR		26
+#define TEGRA20_MC_TEXSRD		27
+#define TEGRA20_MC_VDEBSEVR		28
+#define TEGRA20_MC_VDEMBER		29
+#define TEGRA20_MC_VDEMCER		30
+#define TEGRA20_MC_VDETPER		31
+#define TEGRA20_MC_EPPU			32
+#define TEGRA20_MC_EPPV			33
+#define TEGRA20_MC_EPPY			34
+#define TEGRA20_MC_MPEUNIFBW		35
+#define TEGRA20_MC_VIWSB		36
+#define TEGRA20_MC_VIWU			37
+#define TEGRA20_MC_VIWV			38
+#define TEGRA20_MC_VIWY			39
+#define TEGRA20_MC_G2DW			40
+#define TEGRA20_MC_AVPCARM7W		41
+#define TEGRA20_MC_FDCDWR		42
+#define TEGRA20_MC_HOST1XW		43
+#define TEGRA20_MC_ISPW			44
+#define TEGRA20_MC_MPCOREW		45
+#define TEGRA20_MC_MPECSWR		46
+#define TEGRA20_MC_PPCSAHBDMAW		47
+#define TEGRA20_MC_PPCSAHBSLVW		48
+#define TEGRA20_MC_VDEBSEVW		49
+#define TEGRA20_MC_VDEMBEW		50
+#define TEGRA20_MC_VDETPMW		51
+
 #endif
-- 
2.25.1

